Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FAD74F39D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGKPgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjGKPf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:35:56 -0400
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98F810D4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:35:53 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4R0lMC50vjzMtJnJ;
        Tue, 11 Jul 2023 15:35:51 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4R0lMB09bbzMpssD;
        Tue, 11 Jul 2023 17:35:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1689089751;
        bh=pISZbjvWdRFmYd/uW0vuC0BoKCv93cLxjo6u3w0pKLY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F9kxdq3v/oi7bXKqtBKc579PUBfSyvUvBBaPiV1QqTyXF16V3BSdc8OaN1wOOCPOW
         TWO0IfnI75dXlK8fQNxqmir3Q2KXesqd28Xp8Z7slisz44B7ymtloWzCsK24NRgpe6
         3w4ILn81/weISa3Cpp1BU/Gk57MHJRXuCmVBAJRs=
Message-ID: <9b09c571-9288-73e1-18c5-9023b909a5d9@digikod.net>
Date:   Tue, 11 Jul 2023 17:35:49 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v12 02/11] LSM: Maintain a table of LSM attribute data
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20230629195535.2590-1-casey@schaufler-ca.com>
 <20230629195535.2590-3-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230629195535.2590-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/06/2023 21:55, Casey Schaufler wrote:
> As LSMs are registered add their lsm_id pointers to a table.
> This will be used later for attribute reporting.
> 
> Determine the number of possible security modules based on
> their respective CONFIG options. This allows the number to be
> known at build time. This allows data structures and tables
> to use the constant.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> ---
>   include/linux/security.h |  2 ++
>   security/security.c      | 37 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index e2734e9e44d5..569b1d8ab002 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -138,6 +138,8 @@ enum lockdown_reason {
>   };
>   
>   extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
> +extern u32 lsm_active_cnt;
> +extern struct lsm_id *lsm_idlist[];

extern const struct lsm_id *lsm_idlist[];

>   
>   /* These functions are in security/commoncap.c */
>   extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
> diff --git a/security/security.c b/security/security.c
> index e56714ef045a..5a699e47478b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -36,6 +36,25 @@
>   /* How many LSMs were built into the kernel? */
>   #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
>   
> +/*
> + * How many LSMs are built into the kernel as determined at
> + * build time. Used to determine fixed array sizes.
> + * The capability module is accounted for by CONFIG_SECURITY
> + */
> +#define LSM_CONFIG_COUNT ( \
> +	(IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
> +
>   /*
>    * These are descriptions of the reasons that can be passed to the
>    * security_locked_down() LSM hook. Placing this array here allows
> @@ -245,6 +264,12 @@ static void __init initialize_lsm(struct lsm_info *lsm)
>   	}
>   }
>   
> +/*
> + * Current index to use while initializing the lsm id list.
> + */
> +u32 lsm_active_cnt __ro_after_init;
> +struct lsm_id *lsm_idlist[LSM_CONFIG_COUNT] __ro_after_init;

const struct lsm_id *lsm_idlist[LSM_CONFIG_COUNT] __ro_after_init;


> +
>   /* Populate ordered LSMs list from comma-separated LSM name list. */
>   static void __init ordered_lsm_parse(const char *order, const char *origin)
>   {
> @@ -521,6 +546,18 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>   {
>   	int i;
>   
> +	/*
> +	 * A security module may call security_add_hooks() more
> +	 * than once during initialization, and LSM initialization
> +	 * is serialized. Landlock is one such case.
> +	 * Look at the previous entry, if there is one, for duplication.
> +	 */
> +	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid) {

Isn't it possible to have interleaved security_add_hooks() calls?


> +		if (lsm_active_cnt >= LSM_CONFIG_COUNT)
> +			panic("%s Too many LSMs registered.\n", __func__);

I'm not sure we should panic, but from a security point of view it is 
critical enough…


> +		lsm_idlist[lsm_active_cnt++] = lsmid;
> +	}
> +
>   	for (i = 0; i < count; i++) {
>   		hooks[i].lsmid = lsmid;
>   		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
