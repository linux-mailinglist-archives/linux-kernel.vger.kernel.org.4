Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD2C727F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbjFHL7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbjFHL7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860F52113
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:59:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21C4D64CE9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 11:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A83C433EF;
        Thu,  8 Jun 2023 11:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686225574;
        bh=kqj+AnBwnPPQKa4kzE0ArmNg7GgENWk2/+XafiMcx5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ShsluX5d4ZlHzfqTkZLdoPZBxhpZcjulNtqKiPyvLfOFldMuyZRaBqS8VsiweyA51
         YNHEaBAA/InLeOtEo07ZiCploLCoXMWfEvkj0PSWD0+TWlUuZ/0BLzuZCOU3giTIZR
         sF+xPlNzefUTZ87VeWWpIfUPY4Z7TSJQefk8VEZHAJcaYLvAel5OjTNwAZF9pbJAIQ
         aWL3+5FRnJMXiws5nnodAruR7tn6JE6s0QcEXih9XEJlGOrDQNp8mDOTIeUXuxhuVT
         +plZk0SdCa705FgMjgMb9VPaoxe4jP6kh013tmsG7cFC4ewDKyxPhbx7/nkKF6pt3K
         wBXqnmXruZJfg==
Date:   Thu, 8 Jun 2023 17:29:28 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     mani@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
Subject: Re: [PATCH v2 0/2] Add MHI quirk for QAIC
Message-ID: <20230608115928.GA5672@thinkpad>
References: <20230519163902.4170-1-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519163902.4170-1-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 10:39:00AM -0600, Jeffrey Hugo wrote:
> With the QAIC driver in -next, I'd like to suggest some MHI changes that
> specific to AIC100 devices, but perhaps provide a framework for other
> device oddities.
> 
> AIC100 devices technically violate the MHI spec in two ways. Sadly, these
> issues comes from the device hardware, so host SW needs to work around
> them.
> 
> Thie first issue, presented in this series, has to do with the
> SOC_HW_VERSION register. This register is suposed to be initialized by the
> hardware prior to the MHI being accessable by the host to contain a
> version string for the SoC of the device. This could be used by the host
> MHI controller software to identify and handle version to version changes.
> The AIC100 hardware does not initialize this register, and thus it
> contains garbage.
> 
> This would not be much of a problem normally - the QAIC driver would just
> never use it. However the MHI stack uses this register as part of the init
> sequence and if the controller reports that the register is inaccessable
> then the init sequence fails.  On some AIC100 cards, the garbage value
> ends up being 0xFFFFFFFF which is PCIe spec defined to be a special value
> indicating the access failed.  The MHI controller cannot tell if that
> value is a PCIe link issue, or just garbage.
> 
> QAIC needs a way to tell MHI not to use this register. Other buses have a
> quirk mechanism - a way to describe oddities in a particular
> implementation that have some kind of workaround. Since this seems to be
> the first need for such a thing in MHI, introduce a quirk framework.
> 
> The second issue AIC100 has involves the PK Hash registers. A solution for
> this is expected to be proposed in the near future and is anticipated to
> make use of the quirk framework proposed here. With PK Hash, there are two
> oddities to handle. AIC100 does not initialize these registers until the
> SBL is running, which is later than the spec indicates, and in practice
> is after MHI reads/caches them. Also, AIC100 does not have enough
> registers defined to fully report the 5 PK Hash slots, so a custom
> reporting format is defined by the device.
> 

Looking at the two issues you reported above, it looks to me that they can be
handled inside the aic100 mhi_controller driver itself. Since the MHI stack
exports the read_reg callback to controller drivers, if some registers are not
supported by the device, then the callback can provide some fixed dummy data
emulating the register until the issue is fixed in the device (if at all).

Quirk framework could be useful if the device misbehaves against the protocol
itself but for the register issues like this, I think the controller driver can
handle itself.

What do you think?

- Mani

> v2:
> -Fix build error
> -Fix typo in commit text
> 
> Jeffrey Hugo (2):
>   bus: mhi: host: Add quirk framework and initial quirk
>   accel/qaic: Add MHI_QUIRK_SOC_HW_VERSION_UNRELIABLE
> 
>  drivers/accel/qaic/mhi_controller.c |  1 +
>  drivers/bus/mhi/host/init.c         | 13 +++++++++----
>  include/linux/mhi.h                 | 18 ++++++++++++++++++
>  3 files changed, 28 insertions(+), 4 deletions(-)
> 
> -- 
> 2.40.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
