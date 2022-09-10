Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A325B4688
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIJNn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 09:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJNnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 09:43:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CA23ED62
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 06:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1309B808D6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 13:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822F9C433D7;
        Sat, 10 Sep 2022 13:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662817430;
        bh=tBeZ680+HlTQzJfvNJw3jMyeEy9SyGRGumiy8ZxNN/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LiS4kh2PSCn9bIjpLqYgxZ94APB3ehxWTQ63zQS3IZFPr7hFNjksC7CxzjlTc+OKz
         EJhW8dXiUBv8DWw3dw/VdRI1nH80OT4ng8rQs6frXNYd1UEU9MkLXyy39w7FyOra5R
         is4e2U92PG0p2Z09ZMnFZfMRwxidkThmPfZmBZXa/8ajG72ffFj68ZLAOJ7/8ZOqO8
         GxLuXrw4Tqrxx11p2aCxJ4TLH8KV0EvasS9V15p6SYj9dfrGzEXY1wihuiZeVOkH02
         6BTk+jID4KzMrZYQTP1ciOS3tXt3leBEH+YgUSg5PFr9xf4Ga4c5wqiuAWXOyQERXn
         018CB8DfdL6Mg==
Date:   Sat, 10 Sep 2022 14:43:44 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v2] KVM: arm64: Only set KVM_MODE_PROTECTED if
 is_hyp_mode_available()
Message-ID: <20220910134342.GA959@willie-the-truck>
References: <20220909144552.3000716-1-quic_eberman@quicinc.com>
 <Yxt3wmXYYbWraXrd@arm.com>
 <05057e2a-1a85-69ba-ffcd-584d4090467a@quicinc.com>
 <878rmrr3xw.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rmrr3xw.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 10:09:31AM +0100, Marc Zyngier wrote:
> On Fri, 09 Sep 2022 18:55:18 +0100,
> Elliot Berman <quic_eberman@quicinc.com> wrote:
> > 
> > 
> > 
> > On 9/9/2022 10:28 AM, Catalin Marinas wrote:
> > > On Fri, Sep 09, 2022 at 07:45:52AM -0700, Elliot Berman wrote:
> > >> Do not switch kvm_mode to KVM_MODE_PROTECTED if hypervisor mode is not
> > >> available. This prevents "Protected KVM" cpu capability being reported
> > >> when Linux is booting in EL1 and would not have KVM enabled.
> > >> 
> > >> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > >> ---
> > >>   arch/arm64/kvm/arm.c | 4 +++-
> > >>   1 file changed, 3 insertions(+), 1 deletion(-)
> > >> 
> > >> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > >> index 8fe73ee5fa84..861f4b388879 100644
> > >> --- a/arch/arm64/kvm/arm.c
> > >> +++ b/arch/arm64/kvm/arm.c
> > >> @@ -2272,7 +2272,9 @@ static int __init early_kvm_mode_cfg(char *arg)
> > >>   		return -EINVAL;
> > >>     	if (strcmp(arg, "protected") == 0) {
> > >> -		if (!is_kernel_in_hyp_mode())
> > >> +		if (!is_hyp_mode_available())
> > >> +			kvm_mode = KVM_MODE_DEFAULT;
> > > 
> > > I think kvm_mode is already KVM_MODE_DEFAULT at this point. You may want
> > > to print a warning instead.
> > > 
> > 
> > Does it make sense to print warning for kvm-arm.mode=nvhe as well?
> 
> In general, specifying a kvm-arm.mode when no hypervisor mode is
> available should be reported as a warning.

As long as this is pr_warn() rather than WARN() then I agree. Otherwise,
kernels with a kvm-arm.mode hardcoded in CONFIG_CMDLINE (e.g. Android's
GKI) will make for noisy guests.

Will
