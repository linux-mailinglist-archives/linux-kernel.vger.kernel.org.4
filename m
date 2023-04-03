Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1756D4113
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjDCJrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjDCJrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:47:32 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3628011166
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:47:13 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PqmJb6CRBzMq5Wj;
        Mon,  3 Apr 2023 11:47:11 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PqmJY2s6lz20sV;
        Mon,  3 Apr 2023 11:47:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1680515231;
        bh=p6azdZmCDetm+MRuPRyQn9dJl2cUhUw3RMYCZChzekU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iqrdHqmKYIqoL2fYNNMc/PoJgmDfGOuk8UYr8hsggWQCMAA8AHiOzIZyHCT75CfFA
         pymslOIadB0FD1DorIoMObhUfBl5alJHvzbr4knUzyaGi4gwhkjuTWz1AuUwcSpdi2
         fbEHgAlzUV2gQ1u0+InDivuRlgszNU3HF55+GWaI=
Message-ID: <544a4809-1a79-9dd7-61a5-5fce1f4a5f10@digikod.net>
Date:   Mon, 3 Apr 2023 11:47:08 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v7 07/11] LSM: Helpers for attribute names and filling an
 lsm_ctx
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20230315224704.2672-1-casey@schaufler-ca.com>
 <20230315224704.2672-8-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230315224704.2672-8-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/03/2023 23:47, Casey Schaufler wrote:
> Add lsm_name_to_attr(), which translates a text string to a
> LSM_ATTR value if one is available.
> 
> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
> the trailing attribute value.
> 
> All are used in module specific components of LSM system calls.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   include/linux/security.h | 13 ++++++++++
>   security/lsm_syscalls.c  | 51 ++++++++++++++++++++++++++++++++++++++++
>   security/security.c      | 31 ++++++++++++++++++++++++
>   3 files changed, 95 insertions(+)

[...]

> diff --git a/security/security.c b/security/security.c
> index 2c57fe28c4f7..f7b814a3940c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -753,6 +753,37 @@ static int lsm_superblock_alloc(struct super_block *sb)
>   	return 0;
>   }
>   
> +/**
> + * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
> + * @ctx: an LSM context to be filled
> + * @context: the new context value
> + * @context_size: the size of the new context value
> + * @id: LSM id
> + * @flags: LSM defined flags
> + *
> + * Fill all of the fields in a user space lsm_ctx structure.
> + * Caller is assumed to have verified that @ctx has enough space
> + * for @context.
> + * Returns 0 on success, -EFAULT on a copyout error.
> + */
> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> +		      size_t context_size, u64 id, u64 flags)
> +{
> +	struct lsm_ctx local;
> +	void __user *vc = ctx;
> +
> +	local.id = id;
> +	local.flags = flags;
> +	local.ctx_len = context_size;
> +	local.len = context_size + sizeof(local);
> +	vc += sizeof(local);
> +	if (copy_to_user(ctx, &local, sizeof(local)))
> +		return -EFAULT;
> +	if (context_size > 0 && copy_to_user(vc, context, context_size))
> +		return -EFAULT;

Can we do a single copy_to_user() call? That would avoid inconsistent 
user space data, could speed up a bit the operation, and make the code 
easier to understand. To use the stack, we need to know the maximum size 
of context_size for all use cases, which seems reasonable and can be 
checked at build time (on each LSM side, and potentially with specific 
context type passed as enum instead of context_size) and run time (for 
this generic helper).


> +	return 0;
> +}
> +
>   /*
>    * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>    * can be accessed with:
