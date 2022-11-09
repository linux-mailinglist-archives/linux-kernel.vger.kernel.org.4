Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45771623783
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiKIXe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiKIXeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:34:23 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC322DA99
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 15:34:16 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13bef14ea06so544524fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 15:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H69kl+BZM9mu7qjWYSR2TO9mixGoFPcMaOgCgdllHIk=;
        b=dvBjk7jh2RmiQDokWvgnl8UAvVwjeY7pponPtbdQi2EZH3TyC18Lf8J27d+Zf3h5XJ
         LcBYXHMsrbqWdOPzpCZs2ACpNfJj5DCZtxA3OCOlcP8sXdHvhKVjrWJDMoF6KM90cfre
         95AiSG3scJDkrlY0xuFJhpf4rbGyBW74OxzkEDlo3NvDAtGCDQAt8L1SMdYXxIN3frcN
         aXswrZwe/L3NrE3e3RGpA2NSvmGOklrnSx+8ks9+cFXhUZtXQ6CtQAk9A07V5JmVWL4+
         oVBwsyEnImP7Qpsz3dr89BhfS5Xp+bdaNGnc0zSjU6XaYK7EQilj5Z25r1cl0yCjmdTq
         72iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H69kl+BZM9mu7qjWYSR2TO9mixGoFPcMaOgCgdllHIk=;
        b=46likWRZLbzEbS/dJVM1k8lnqFjc6VcQj7co5KiJzDXMhrO7ikEZZ5q9fD9oWox/Rl
         ME840GQILC9IrM1KVZWLh++OGlez/cgUx9yji5+tM2sbSK9CflI3xS8m32+SY1BN1700
         DVMNSSdbIg3BcfvlztwsRezhln+laItQU3pDu1Z4Rqnc1h99beeA2L60Zw2xlGVYXaGc
         bpkGKoxhRbSKTMaoGLNS1XxEKH8znIDbi20bru3kXdagvu/2JGoyhVpIcfd7zWa3lSsy
         YekxCvKO10lW/jU7v68nZmXx8cc4oxy8mTixYcQTarFmcF+kMIOBF+GpBnmKZ2LyThOA
         JbAg==
X-Gm-Message-State: ACrzQf1IWasbkdu80WpAV/C/JrXgwNHl6/+yw1k8R01Bagl5Zs/KV3Bz
        1NDOj+U515fCNbMUDbEZquQ3aiTt0HV+tJvIN2D8
X-Google-Smtp-Source: AMsMyM4qjyOq5UcyAbU3fCpDSj4bUqTY7Ut2MpZl3tFuZIzDm04cYZA3gQPE9DPmipGtZc6srHv0u7g3+BFjwprwPfc=
X-Received: by 2002:a05:6870:f299:b0:13b:ad21:934d with SMTP id
 u25-20020a056870f29900b0013bad21934dmr37063952oap.172.1668036855843; Wed, 09
 Nov 2022 15:34:15 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com> <20221025184519.13231-4-casey@schaufler-ca.com>
In-Reply-To: <20221025184519.13231-4-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 18:34:05 -0500
Message-ID: <CAHC9VhRv2biawm1w=8sR=DMBhy8FLNwxRch13j4EUBkCRUpxrA@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] LSM: Identify the process attributes for each module
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 2:47 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Add an integer member "features" to the struct lsm_id which
> identifies the API related data associated with each security
> module. The initial set of features maps to information that
> has traditionaly been available in /proc/self/attr.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  |  1 +
>  include/uapi/linux/lsm.h   | 14 ++++++++++++++
>  security/apparmor/lsm.c    |  1 +
>  security/selinux/hooks.c   |  2 ++
>  security/smack/smack_lsm.c |  1 +
>  5 files changed, 19 insertions(+)

Everything Greg already said with one additional comment below.

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index dd4b4d95a172..46b2aa6a677e 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1608,6 +1608,7 @@ struct security_hook_heads {
>  struct lsm_id {
>         const char      *lsm;           /* Name of the LSM */
>         int             id;             /* LSM ID */
> +       int             features;       /* Set of LSM features */

I understand why you called the field "features", but I worry it is a
bit too generic for 32-bits of flags. Let's make it specific to the
LSM label attributes; how about 'feat_attr', 'sup_attr', or something
along those lines?

--
paul-moore.com
