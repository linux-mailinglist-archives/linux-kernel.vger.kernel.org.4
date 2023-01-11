Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1928A66653D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjAKVDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjAKVB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:01:56 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AE31AD82
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:01:13 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id k19so12326785pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0wB50/PYHnsCVzSdqZEtqGHtz8ZKWBEKFp2OtqRRLNM=;
        b=T/JsqEKnQwcJ1y3x59tBZwl/DrxNWMLBSzdCy0Tuw5Zfy0H/NHUsMUXexg4ppbwTdY
         E8a4odp8Vv11bF/oBEkiy3+ydA9ywADYSNSw6uS3DbJGRP9rL1FjYfP9HCLduvWmrh/2
         vwNmNMWF1FoxUe7KT2Cl5vOUsqovekmBsKGnadHfQlMqTAt5Dfi2acUjJWlqljJ8t0R3
         NEsJYibnUdsoOpIrvW8qqH01K8UE4cMSH41gKh4FNBUUmd6MwmPudVu7WyfU+UmLSfik
         Ylea0wuX+7f4uIrptMJiQJnpR/EduL8jCayEeuCVEFjK+S9uawiR0x+aUQTAsoV1i17n
         9mKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wB50/PYHnsCVzSdqZEtqGHtz8ZKWBEKFp2OtqRRLNM=;
        b=sFF6F3Jww2+tGQ+o2kGjt60snNXplxv+pYh5VL9Rc40LMbtqwzvhHAHZfk7dBmhxc4
         2JAfC8ixuQRroGnfvbBbToeEr3AItyCWszy4lCCt0raaHH6c7fYgFkBdGBUBPzX9Stix
         92v/DYpmE+ffrAyP9rx9pVabwDCQw9KfFqzhi9VJOwDBJ4rrPD1xq9R58+7B/H47zyeS
         cMBXMriimvP8aeyX+kU7bhahSmA3aet1wUVQroRVqcBhLhz3hJFmeqjZG6UphKinH1Kf
         oY1vyvgICjlJV19p7jFUxaUW4IQUoLYCOywA/j+YDERzs0rN/49fJE0KGTSdbE7aHt71
         fj/A==
X-Gm-Message-State: AFqh2krQLjCkufwmUk2/UmuOv/3fg8NvdVas6UFwi8IscOUAnGz+5AVy
        9XFGTaGqBvuyVhjCv68RBeNKksJCTFPnVG1DubUy
X-Google-Smtp-Source: AMrXdXuES+1yaEcpWHZ3QZ1xqpDmznk0NXFDWEsxkG/7LRPR+KviYc8rPn7baqlyYrsMFnZB6uJ9eiNfQx11b8mPFgI=
X-Received: by 2002:aa7:924d:0:b0:577:62a8:f7a1 with SMTP id
 13-20020aa7924d000000b0057762a8f7a1mr4986518pfp.2.1673470873246; Wed, 11 Jan
 2023 13:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20230109180717.58855-1-casey@schaufler-ca.com> <20230109180717.58855-3-casey@schaufler-ca.com>
In-Reply-To: <20230109180717.58855-3-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 11 Jan 2023 16:01:02 -0500
Message-ID: <CAHC9VhTaySsuvkj0U9Jbp405+WoRfhtq+ib5ynO-a9BeM+a5Ew@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] LSM: Maintain a table of LSM attribute data
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 1:07 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> As LSMs are registered add their lsm_id pointers to a table.
> This will be used later for attribute reporting.
>
> Determine the number of possible security modules based on
> their respective CONFIG options. This allows the number to be
> known at build time. This allows data structures and tables
> to use the constant.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h |  2 ++
>  security/security.c      | 44 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 39 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5b67f208f7de..33ed1860b96f 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -138,6 +138,8 @@ enum lockdown_reason {
>  };
>
>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
> +extern u32 lsm_active_cnt;
> +extern struct lsm_id *lsm_idlist[];
>
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
> diff --git a/security/security.c b/security/security.c
> index 07a8fe7f92bf..a590fa98ddd6 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -28,12 +28,29 @@
>  #include <linux/backing-dev.h>
>  #include <linux/string.h>
>  #include <linux/msg.h>
> +#include <uapi/linux/lsm.h>
>  #include <net/flow.h>
>
>  #define MAX_LSM_EVM_XATTR      2
>
> -/* How many LSMs were built into the kernel? */
> -#define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> +/*
> + * How many LSMs are built into the kernel as determined at
> + * build time. Used to determine fixed array sizes.
> + * The capability module is accounted for by CONFIG_SECURITY
> + */
> +#define LSM_COUNT ( \
> +       (IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_IMA) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
> +       (IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
>
>  /*
>   * These are descriptions of the reasons that can be passed to the
> @@ -90,7 +107,7 @@ static __initdata const char *chosen_major_lsm;
>  static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
>
>  /* Ordered list of LSMs to initialize. */
> -static __initdata struct lsm_info **ordered_lsms;
> +static __initdata struct lsm_info *ordered_lsms[LSM_COUNT + 1];

I'm guessing this 'LSM_COUNT + 1' logic is basically just copied from
ordered_lsm_init() - which is okay - but can you remind me why it is
'LSM_COUNT + 1' and not just 'LSM_COUNT'?  Based on the LSM_COUNT
macro above it seems like LSM_COUNT should be enough, no?

>  static __initdata struct lsm_info *exclusive;
>
>  static __initdata bool debug;
> @@ -341,13 +358,16 @@ static void __init report_lsm_order(void)
>         pr_cont("\n");
>  }
>
> +/*
> + * Current index to use while initializing the lsm id list.
> + */
> +u32 lsm_active_cnt __lsm_ro_after_init;
> +struct lsm_id *lsm_idlist[LSM_COUNT] __lsm_ro_after_init;
> +
>  static void __init ordered_lsm_init(void)
>  {
>         struct lsm_info **lsm;
>
> -       ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
> -                               GFP_KERNEL);
> -
>         if (chosen_lsm_order) {
>                 if (chosen_major_lsm) {
>                         pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
> @@ -388,7 +408,7 @@ static void __init ordered_lsm_init(void)
>         for (lsm = ordered_lsms; *lsm; lsm++)
>                 initialize_lsm(*lsm);
>
> -       kfree(ordered_lsms);
> +       init_debug("lsm count            = %d\n", lsm_active_cnt);
>  }

Given 86ef3c735ec8 ("LSM: Better reporting of actual LSMs at boot"),
is this needed?

--
paul-moore.com
