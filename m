Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A17710024
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjEXVlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjEXVli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:41:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83546FC;
        Wed, 24 May 2023 14:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1928161221;
        Wed, 24 May 2023 21:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58302C433EF;
        Wed, 24 May 2023 21:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684964496;
        bh=cZrnJxeMhUwXMVYsdoRzT3yaEt4/nNkyLF7HSNLFDZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iihtjHlFxfST4cYvt3gkZ/Mkzems7Hy57Pf8LyKaPzb7eEGcK0mkSMAV/4GgXlEhq
         cbJaHiSqNnSVbrnAq8IG5voAwb13B6OJdir8itKCRRFGF3O7CfNEifkQ2+Hj48MdzZ
         fHMVHO2i2zMf27HKaz456y5C4E5XKidXmmqQRq7XWqVOpTcLuKBXZl3uO1Y0XJL00q
         Nn7pS6Ho/uA/fthp8Wx1Tsy7IJAd9nkwaGtQJnRgUwGoTKfFnDN0hIg3xyka91U6vH
         b5SbK+IEJrSotZ1QRaJAwHIbPKstxF+ky3ajwITMPrRYpFUNUpaAMfnND8ZuBOaAOI
         VhyToQ/N27iAg==
Date:   Wed, 24 May 2023 14:41:33 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, namhyung@kernel.org, eranian@google.com,
        acme@kernel.org, mark.rutland@arm.com, jolsa@kernel.org,
        irogers@google.com, bp@alien8.de, kan.liang@linux.intel.com,
        adrian.hunter@intel.com, maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, maz@kernel.org, oliver.upton@linux.dev,
        kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 3/4] perf/core: Remove pmu linear searching code
Message-ID: <20230524214133.GA2359762@dev-arch.thelio-3990X>
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
 <20230504110003.2548-4-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504110003.2548-4-ravi.bangoria@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

+ arm64 KVM folks

On Thu, May 04, 2023 at 04:30:02PM +0530, Ravi Bangoria wrote:
> Searching for the right pmu by iterating over all pmus is no longer
> required since all pmus now *must* be present in the 'pmu_idr' list.
> So, remove linear searching code.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  kernel/events/core.c | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 0695bb9fbbb6..eba2b8595115 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11630,38 +11630,27 @@ static struct pmu *perf_init_event(struct perf_event *event)
>  	}
>  
>  again:
> +	ret = -ENOENT;
>  	rcu_read_lock();
>  	pmu = idr_find(&pmu_idr, type);
>  	rcu_read_unlock();
> -	if (pmu) {
> -		if (event->attr.type != type && type != PERF_TYPE_RAW &&
> -		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
> -			goto fail;
> -
> -		ret = perf_try_init_event(pmu, event);
> -		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
> -			type = event->attr.type;
> -			goto again;
> -		}
> +	if (!pmu)
> +		goto fail;
>  
> -		if (ret)
> -			pmu = ERR_PTR(ret);
> +	if (event->attr.type != type && type != PERF_TYPE_RAW &&
> +	    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
> +		goto fail;
>  
> -		goto unlock;
> +	ret = perf_try_init_event(pmu, event);
> +	if (ret == -ENOENT && event->attr.type != type && !extended_type) {
> +		type = event->attr.type;
> +		goto again;
>  	}
>  
> -	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
> -		ret = perf_try_init_event(pmu, event);
> -		if (!ret)
> -			goto unlock;
> -
> -		if (ret != -ENOENT) {
> -			pmu = ERR_PTR(ret);
> -			goto unlock;
> -		}
> -	}
>  fail:
> -	pmu = ERR_PTR(-ENOENT);
> +	if (ret)
> +		pmu = ERR_PTR(ret);
> +
>  unlock:
>  	srcu_read_unlock(&pmus_srcu, idx);
>  
> -- 
> 2.40.0
> 

My apologies if this has already been reported or fixed already, I did a
search of lore.kernel.org and did not find anything. This patch as
commit 9551fbb64d09 ("perf/core: Remove pmu linear searching code") in
-next breaks starting QEMU with KVM enabled on two of my arm64 machines:

$ qemu-system-aarch64 \
    -display none \
    -nodefaults \
    -machine virt,gic-version=max \
    -append 'console=ttyAMA0 earlycon' \
    -kernel arch/arm64/boot/Image.gz \
    -initrd rootfs.cpio \
    -cpu host \
    -enable-kvm \
    -m 512m \
    -smp 8 \
    -serial mon:stdio
qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: No such device
qemu-system-aarch64: failed to set irq for PMU

In the kernel log, I see

[   42.944952] kvm: pmu event creation failed -2

I am not sure if this issue is unexpected as a result of this change or
if there is something that needs to change on the arm64 KVM side (it
appears the kernel message comes from arch/arm64/kvm/pmu-emul.c).

If there is any further information I can provide or patches I can test,
I am more than happy to do so.

Cheers,
Nathan

# bad: [cf09e328589a2ed7f6c8d90f2edb697fb4f8a96b] Add linux-next specific files for 20230524
# good: [27e462c8fad4bf04ec4f81f8539ce6fa947ead3a] Merge tag 'xtensa-20230523' of https://github.com/jcmvbkbc/linux-xtensa
git bisect start 'cf09e328589a2ed7f6c8d90f2edb697fb4f8a96b' '27e462c8fad4bf04ec4f81f8539ce6fa947ead3a'
# good: [a20d8ab9e26daaeeaf971139b736981cf164ab0a] Merge branch 'for-linux-next' of git://anongit.freedesktop.org/drm/drm-misc
git bisect good a20d8ab9e26daaeeaf971139b736981cf164ab0a
# good: [2714032dfd641b22695e14efd5f9dff08a5e3245] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
git bisect good 2714032dfd641b22695e14efd5f9dff08a5e3245
# bad: [b2bc2854ec87557033538aa9290f70b9141a6653] Merge branch 'for-leds-next' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git
git bisect bad b2bc2854ec87557033538aa9290f70b9141a6653
# good: [20d4044f23c7724020b6c7d34ccee9bb929d1078] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
git bisect good 20d4044f23c7724020b6c7d34ccee9bb929d1078
# bad: [c3cab2fce7b318ee2edf148b1436f3a3864ae773] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
git bisect bad c3cab2fce7b318ee2edf148b1436f3a3864ae773
# bad: [af75e6871092fc1f9fa039132d5667f1e0a47a0a] Merge branch into tip/master: 'sched/core'
git bisect bad af75e6871092fc1f9fa039132d5667f1e0a47a0a
# good: [c50a7b40a2f50403c3f58f1c27a85e4c5d2e0865] Merge branch into tip/master: 'objtool/core'
git bisect good c50a7b40a2f50403c3f58f1c27a85e4c5d2e0865
# good: [519fabc7aaba3f0847cf37d5f9a5740c370eb777] psi: remove 500ms min window size limitation for triggers
git bisect good 519fabc7aaba3f0847cf37d5f9a5740c370eb777
# bad: [b85c6694924e9f09a40a2e0a3798f3945eaa6fda] Merge branch into tip/master: 'perf/core'
git bisect bad b85c6694924e9f09a40a2e0a3798f3945eaa6fda
# bad: [9551fbb64d094cc105964716224adeb7765df8fd] perf/core: Remove pmu linear searching code
git bisect bad 9551fbb64d094cc105964716224adeb7765df8fd
# good: [2fad201fe38ff9a692acedb1990ece2c52a29f95] perf/ibs: Fix interface via core pmu events
git bisect good 2fad201fe38ff9a692acedb1990ece2c52a29f95
# first bad commit: [9551fbb64d094cc105964716224adeb7765df8fd] perf/core: Remove pmu linear searching code
