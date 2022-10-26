Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25E160DAE3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiJZGBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbiJZGBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F2F5A885;
        Tue, 25 Oct 2022 23:01:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0456461C3C;
        Wed, 26 Oct 2022 06:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3391C433D6;
        Wed, 26 Oct 2022 06:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666764068;
        bh=++gVpUQZ8nzv4m4Hebok3BwXhcBs2ETMOZ0VuYDM1LE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NG6Q8jiFIHK0VDkBoI7TAtoPJvnBRot68vT4wzExbhXw7f5apcCwUGyvCFn3i6eRv
         SUi+zSRLs6hEjxdkO+LYtvWRgEW4JDt9EK6ClUNdb9mirVYy754tIV2Cca+b3T4OPh
         0sSDmbLoy43fai5Nv1qsJKqK9qSFCV8kgkQ9iu8w=
Date:   Wed, 26 Oct 2022 08:02:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v1 7/8] LSM: Create lsm_module_list system call
Message-ID: <Y1jNWbEp1QOgs0Ip@kroah.com>
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-8-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025184519.13231-8-casey@schaufler-ca.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:45:18AM -0700, Casey Schaufler wrote:
> Create a system call to report the list of Linux Security Modules
> that are active on the system. The list is provided as an array
> of LSM ID numbers.
> 
> The calling application can use this list determine what LSM
> specific actions it might take. That might include chosing an
> output format, determining required privilege or bypassing
> security module specific behavior.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/syscalls.h |  1 +
>  kernel/sys_ni.c          |  1 +
>  security/lsm_syscalls.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 2d9033e9e5a0..02bb82142e24 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1058,6 +1058,7 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
>  					    unsigned long home_node,
>  					    unsigned long flags);
>  asmlinkage long sys_lsm_self_attr(struct lsm_ctx *ctx, size_t *size, int flags);
> +asmlinkage long sys_lsm_module_list(unsigned int *ids, size_t *size, int flags);

Instead of "unsigned int", how about "u64" to make it portable
properly?

thanks,

greg k-h
