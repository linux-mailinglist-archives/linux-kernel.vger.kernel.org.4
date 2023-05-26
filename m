Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EC4712C56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbjEZSSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjEZSSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031AD12A;
        Fri, 26 May 2023 11:18:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A5C160DE3;
        Fri, 26 May 2023 18:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61905C433D2;
        Fri, 26 May 2023 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685125098;
        bh=3X5rRSF8sIavtJV2mOMQEUoORlfFr9LV9dslcms/7xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=es1ECrgoIkqIRJiP4jPMWa0r3koUHKo6w5fdEiu28OU0bd16kOhqjlXy4WUgO+/+G
         F9DhgSBhoXRKdPnY+fXt5e1hausG4COmyHZ2Ia+STqzND18ozkBXLluKRI2Aomi49i
         KR0dGoH/olAOGuLJiU49UoMc0q4u05SvKRK61bSc=
Date:   Fri, 26 May 2023 19:18:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Greg Thelen <gthelen@google.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.10 000/381] 5.10.180-rc1 review
Message-ID: <2023052605-untoasted-sheet-d44d@gregkh>
References: <20230515161736.775969473@linuxfoundation.org>
 <xr93jzx2el8h.fsf@gthelen2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xr93jzx2el8h.fsf@gthelen2.svl.corp.google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 02:39:10PM -0700, Greg Thelen wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > This is the start of the stable review cycle for the 5.10.180 release.
> > There are 381 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.180-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> > -------------
> > Pseudo-Shortlog of commits:
> 
> [...]
> 
> > Baokun Li <libaokun1@huawei.com>
> >     writeback, cgroup: fix null-ptr-deref write in bdi_split_work_to_wbs
> 
> Sorry for not noticing this sooner, but I think there's a benign issue
> in this backport.
> 
> v5.10.180 commit 2b00b2a0e642 ("writeback, cgroup: fix null-ptr-deref
> write in bdi_split_work_to_wbs") contains:
> 
> +static void cgwb_free_rcu(struct rcu_head *rcu_head)
> +{
> +       struct bdi_writeback *wb = container_of(rcu_head,
> +                       struct bdi_writeback, rcu);
> +
> +       percpu_ref_exit(&wb->refcnt);
> +       kfree(wb);
> +}
> 
> [...]
> 
> @@ -397,7 +406,7 @@ static void cgwb_release_workfn(struct work_struct *work)
>         fprop_local_destroy_percpu(&wb->memcg_completions);
>         percpu_ref_exit(&wb->refcnt);
>         wb_exit(wb);
> -       kfree_rcu(wb, rcu);
> +       call_rcu(&wb->rcu, cgwb_free_rcu);
>  }
> 
> Notice there are now 2 percpu_ref_exit() calls. The upstream, and 5.15.y
> patches remove the cgwb_release_workfn() calls to percpu_ref_exit(). The
> 5.10.y fixup is below. It's not essential but might be worth applying to
> track upstream.

Thanks, I've queued this up now.

greg k-h
