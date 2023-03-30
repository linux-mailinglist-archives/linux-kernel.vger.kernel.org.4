Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FAE6D0913
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjC3PHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjC3PG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:06:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF94C7D83
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:06:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 841C2620D5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D2CC4339B;
        Thu, 30 Mar 2023 15:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680188806;
        bh=YylqFNuWsS+Mnc5Y/qsJSCYd3mE18d+yT7l+7jgGZ4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqXIasze8qHWtF24YuVU5DYPObe9MMHsO/4vFiPbkpIEF7drFokIFDS56+klT5U9C
         qQ+WD01bJk4n6zMff5K+5PFvoi45W+rIP6bpYMYx7dnFy5zHsnaTY/eFu+tdAz74L3
         OLrUZ+vW35sYGnI8CJfI4NeXCShjLMbHEJ8ZFJM94nGPar4KUWTh9cbLWfzbtzhfGl
         +K1MwEMH9QfGMdYdraz0yrhvtS+PDxWNtRABeUVjIjYfJJKDmkBORTRFApHxxEPTl5
         KrSdh4itk9M0BiUXEMjaJsIdEqanbvBWTYirgZ8cgVx3AiLDIFqJmRekcfuEiCfzsV
         RnF9DdN4+O4aA==
Date:   Thu, 30 Mar 2023 16:06:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     joro@8bytes.org, catalin.marinas@arm.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, steev@kali.org,
        iommu@lists.linux.dev, johan+linaro@kernel.org,
        andersson@kernel.org, linux-arm-kernel@lists.infradead.org,
        robin.murphy@arm.com
Subject: Re: [PATCH v5] iommu/arm-smmu-qcom: Limit the SMR groups to 128
Message-ID: <20230330150640.GA4185@willie-the-truck>
References: <20230327080029.11584-1-manivannan.sadhasivam@linaro.org>
 <167991987524.1305084.466646756285487652.b4-ty@kernel.org>
 <20230330054127.GA9876@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330054127.GA9876@thinkpad>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 11:11:27AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 27, 2023 at 01:52:01PM +0100, Will Deacon wrote:
> > On Mon, 27 Mar 2023 13:30:29 +0530, Manivannan Sadhasivam wrote:
> > > Some platforms support more than 128 stream matching groups than what is
> > > defined by the ARM SMMU architecture specification. But due to some unknown
> > > reasons, those additional groups don't exhibit the same behavior as the
> > > architecture supported ones.
> > > 
> > > For instance, the additional groups will not detect the quirky behavior of
> > > some firmware versions intercepting writes to S2CR register, thus skipping
> > > the quirk implemented in the driver and causing boot crash.
> > > 
> > > [...]
> > 
> > Applied to will (for-joerg/arm-smmu/updates), thanks!
> > 
> 
> Thanks Will! Could you please tag this patch for 6.3-rcS? Even though this patch
> is not fixing any issue introduced in 6.3, the affected platform (SC8280XP) has
> reasonable upstream support in 6.3 and the distro folks would like to stick to
> it for some time. This patch will allow them to boot mainline without any
> additional out-of-tree patches.

I already queued this up for 6.4 since it's neither a regression
nor marked for stable inclusion.

Having said that, once it lands in mainline feel free to propose a
-stable backport if it's needed by distros.

Will
