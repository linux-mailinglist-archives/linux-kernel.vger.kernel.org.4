Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224D071850D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbjEaOfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjEaOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:35:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D68C8F;
        Wed, 31 May 2023 07:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C91663CD2;
        Wed, 31 May 2023 14:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB03C433EF;
        Wed, 31 May 2023 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685543710;
        bh=qZT1WJZg48J+Oxx7bRc/+kOKz7mgCQMjiwzmueUHij4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y0GbVh4aPLnfifMceY828srNPevGH4vGAyBD9gAP8xXIujPIBPtDEx/mkTkbcTFmB
         aD146SaowPJjAhdqWZWSOy/kg8PWqfcstlKk854mMhAHhCwbsQ71sK1yJnBb/DwtEX
         MamY/jFuTB5Yw7Z9J7E0/xGskdkUMiMmB7Uk7OIE=
Date:   Wed, 31 May 2023 15:35:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Jeffrey Hugo <quic_jhugo@quicinc.com>, kuba@kernel.org,
        andersson@kernel.org, daniel@ffwll.ch, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Subject: Re: [PATCH] bus: mhi: host: Add userspace character interface
Message-ID: <2023053134-unpiloted-why-0f37@gregkh>
References: <20230522190459.13790-1-quic_jhugo@quicinc.com>
 <20230531142803.GH7968@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531142803.GH7968@thinkpad>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 07:58:03PM +0530, Manivannan Sadhasivam wrote:
> + Jakub (who NACKed the previous submission of UCI driver)
> Link to previous submission: https://lore.kernel.org/all/1606533966-22821-1-git-send-email-hemantk@codeaurora.org/
> 
> On Mon, May 22, 2023 at 01:04:59PM -0600, Jeffrey Hugo wrote:
> > From: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
> > 
> > I2C, USB, and PCIe are examples of buses which have a mechanism to give
> > userspace direct access to a device on those buses. The MHI userspace
> > character interface (uci) is the MHI bus analogue.
> > 
> > The MHI bus devices are MHI channels which ferry blocks of data from one
> > end to the other. With this simple purpose, we can define a simple
> > interface to userspace - a character device that supports open/close/read/
> > write/poll operations. Since bus devices can only have a single consumer
> > we encode a whitelist of MHI channels to be exported to userspace so as
> > to avoid conflicts.
> > 
> > We also make this mechanism open to any device that implements MHI.
> > Today this includes WLAN (Wi-Fi), WWAN (4G/5G cellular), and ML/AI
> > devices. More devices are expected in the future.
> > 
> > In addition to implementing the framework for uci, we include an initial
> > usecase - the QAIC Sahara device.
> > 
> > Sahara is a file transfer protocol that is commonly used for two purposes
> > when interacting with a device - transferring firmware to the device and
> > transferring crashdumps from the device. The Sahara protocol puts the
> > receiver of the data in control of the transfer. A firmware transfer
> > operation would have the device requesting the specific firmware images
> > that the device wants, and the host satisfying those requests.
> > 
> > In most cases, including for AIC100, Sahara is used as part of a two stage
> > loading process. The device will boot a very limited bootloader that does
> > the base minimum initialization and jump to the next stage. A simple, one-
> > shot protocol like BHI is used to send the next stage bootloader to the
> > device. This second stage bootloader contains more functionality and
> > implements the Sahara protocol. The second stage determines from various
> > inputs what set of runtime firmware is required to boot the device into an
> > operational status, and requests those pieces from the host.  With those
> > images transferred over, the device can funnly initialize.
> > 
> > Each AIC100 instance (currently, up to 16) in a system will create a
> > MHI device for QAIC_SAHARA. MHI_uci will consume each of these and create
> > a unique chardev which will be found as
> > /dev/<mhi instance>_QAIC_SAHARA
> > For example - /dev/mhi0_QAIC_SAHARA
> > 
> > An open userspace application that can consume these devices for firmware
> > transfers is located at https://github.com/andersson/qdl
> > 
> > Signed-off-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
> > [jhugo: Rename to uci, plumb to mhi, rewrite commit text]
> > Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> 
> The previous attempt on adding UCI driver was NACKed by Jakub. For merging this
> patch, I need an ACK from Jakub.

Given that this fails the kernel robot tests, why would anyone ack it
as-is?

confused,

greg k-h
