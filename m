Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64306371D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 06:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKXFks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 00:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKXFkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 00:40:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF58FC4941;
        Wed, 23 Nov 2022 21:40:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D621B826CC;
        Thu, 24 Nov 2022 05:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E71C433D6;
        Thu, 24 Nov 2022 05:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669268442;
        bh=lVoc1Z4nZLLeyRRN6vomWKFzXE4y5IGTZpcunzw755w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A9GBHKATK6mVEize809pwWWnocYATWta3UrknB5RElYWNN06Sif3dKgKpDWL7nlnD
         3ewJCoBXC3+YW0NedjXyiPVoVA8I5/CnM72DjCYnELeY4XvsftlHnXmeOOBgvMo47z
         jkFihmt18F0qs16MfnfYP2Pims3F1Ez2IXWYcQ+M=
Date:   Thu, 24 Nov 2022 06:40:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v3 1/9] LSM: Identify modules by more than name
Message-ID: <Y38D1s3uQ6zNORei@kroah.com>
References: <20221123201552.7865-1-casey@schaufler-ca.com>
 <20221123201552.7865-2-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123201552.7865-2-casey@schaufler-ca.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 12:15:44PM -0800, Casey Schaufler wrote:
> Create a struct lsm_id to contain identifying information
> about Linux Security Modules (LSMs). At inception this contains
> the name of the module and an identifier associated with the
> security module. Change the security_add_hooks() interface to
> use this structure. Change the individual modules to maintain
> their own struct lsm_id and pass it to security_add_hooks().
> 
> The values are for LSM identifiers are defined in a new UAPI
> header file linux/lsm.h. Each existing LSM has been updated to
> include it's LSMID in the lsm_id.
> 
> The LSM ID values are sequential, with the oldest module
> LSM_ID_CAPABILITY being the lowest value and the existing modules
> numbered in the order they were included in the main line kernel.
> This is an arbitrary convention for assigning the values, but
> none better presents itself. The value 0 is defined as being invalid.
> The values 1-99 are reserved for any special case uses which may
> arise in the future.

What would be a "special case" that deserves a lower number?

> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index e5971fa74fd7..20983ae8d31f 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -5,6 +5,7 @@
>   */
>  #include <linux/lsm_hooks.h>
>  #include <linux/bpf_lsm.h>
> +#include <uapi/linux/lsm.h>
>  
>  static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> @@ -15,9 +16,19 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
>  };
>  
> +/*
> + * slot has to be LSMBLOB_NEEDED because some of the hooks
> + * supplied by this module require a slot.
> + */
> +struct lsm_id bpf_lsmid __lsm_ro_after_init = {
> +	.lsm = "bpf",
> +	.id = LSM_ID_BPF,
> +};

I do not understand this comment, what is LSMBLOB_NEEDED and how does
that relate to the struct lsm_id?

thanks,

greg k-h
