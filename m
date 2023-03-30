Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140E16CF87E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjC3BKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjC3BKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:10:35 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3C05592
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:10:28 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p15so21664172ybl.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 18:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680138627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SGh3fZWr7hGlmOJJyEOV+nHbXyUtBvRhIDq9a23Cf8=;
        b=bmTUyijVn1l5Flp50doP9tPK+ixFjShRWiQyZM/Z5EPAuv6t3tWyTSPK7SH7Ywn6TJ
         ofpimuXBl8593gBSB4VG8NvpOa/x2sqXARQK7N+iqUMtqTUr0PDGVlvzlhBNWXBP/cWm
         kSnyDU9lH59nY8zlkBHtV3EYvU8x/2DZnmummRNE5xT27AW0lMWEutv7p3rZIDSO+Qk+
         CnnqZJnu6NT/7qqI504i/SksAnqSD4GjZEyY1EuibJTdwEsOeZZwOic4gc45la6y3Poz
         5g8Uy8XPHkeicYBTnkTpn4porfisuodnF125fBmozroANNnp6HVnjPg1synrSVBbU3HK
         rccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680138627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SGh3fZWr7hGlmOJJyEOV+nHbXyUtBvRhIDq9a23Cf8=;
        b=OQRpt0OPHvpns2AVCb7MH9Ks2zdTxrrkPzBJWAOY8DPPG7g+uSkIQHvl/8q9sOXRRt
         84f6AGLx7y5yMuNUyxMckVERjYYtpz9ghQiMb5NvHUKggoTZvD1ITfZIcA0U0ZnwsqED
         mWXPKthc8b/9vXD/uk+nP1nWUpJ2u/GDg/e33mZ91n2fzjrHxyAzxOekC9dmWbhs9XVz
         7dVS7sqT/BjgbA8VRtrVcnTsSsn/yRcNxUT0MIPEyNF5Xnl5wAlf0Ht4xGz5kTF2eumr
         8HF1/N8jthadEs0NugcAafEcnCxt6Ha1dzsKsXxPPSMkwuzdy2Igh30V/RhRIk/kX3ea
         m8eA==
X-Gm-Message-State: AAQBX9dhqcWkU8QzIZ10+e5Pp7qumMaKEn+co1tJvuVMh39YpPcNGkfR
        OkjH1gj+/kx2lGYQPDAiTiBxirXI1dlAi4gd6io3
X-Google-Smtp-Source: AKy350Z/cQ952yf9ZDOWZown0C3FWIiWHZiMhKCaOLerWDAR4sqXen8YH7/P0OZwdzzR7iZBQF6gbXJJO2/73tXA4rg=
X-Received: by 2002:a05:6902:102a:b0:b71:f49f:8d22 with SMTP id
 x10-20020a056902102a00b00b71f49f8d22mr11290085ybt.3.1680138627424; Wed, 29
 Mar 2023 18:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230315224704.2672-1-casey@schaufler-ca.com> <20230315224704.2672-2-casey@schaufler-ca.com>
In-Reply-To: <20230315224704.2672-2-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 29 Mar 2023 21:10:16 -0400
Message-ID: <CAHC9VhTdiKi99Hx1OVDQkG3DEf_V_LV0DhB8n2=BoyH7r69TCQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/11] LSM: Identify modules by more than name
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 6:47=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Create a struct lsm_id to contain identifying information
> about Linux Security Modules (LSMs). At inception this contains
> the name of the module, an identifier associated with the security
> module and an integer member "attrs" which identifies the API
> related data associated with each security module. The initial set
> of features maps to information that has traditionaly been available
> in /proc/self/attr. They are documented in a new userspace-api file.
> Change the security_add_hooks() interface to use this structure.
> Change the individual modules to maintain their own struct lsm_id
> and pass it to security_add_hooks().
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
> arise in the future. This may include attributes of the LSM
> infrastructure itself, possibly related to namespacing or network
> attribute management. A special range is identified for such attributes
> to help reduce confusion for developers unfamiliar with LSMs.
>
> LSM attribute values are defined for the attributes presented by
> modules that are available today. As with the LSM IDs, The value 0
> is defined as being invalid. The values 1-99 are reserved for any
> special case uses which may arise in the future.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-security-module <linux-security-module@vger.kernel.org>
> ---
>  Documentation/userspace-api/index.rst |  1 +
>  Documentation/userspace-api/lsm.rst   | 55 +++++++++++++++++++++++++++
>  MAINTAINERS                           |  1 +
>  include/linux/lsm_hooks.h             | 18 ++++++++-
>  include/uapi/linux/lsm.h              | 53 ++++++++++++++++++++++++++
>  security/apparmor/lsm.c               |  8 +++-
>  security/bpf/hooks.c                  |  9 ++++-
>  security/commoncap.c                  |  8 +++-
>  security/landlock/cred.c              |  2 +-
>  security/landlock/fs.c                |  2 +-
>  security/landlock/ptrace.c            |  2 +-
>  security/landlock/setup.c             |  6 +++
>  security/landlock/setup.h             |  1 +
>  security/loadpin/loadpin.c            |  9 ++++-
>  security/lockdown/lockdown.c          |  8 +++-
>  security/safesetid/lsm.c              |  9 ++++-
>  security/security.c                   | 12 +++---
>  security/selinux/hooks.c              |  9 ++++-
>  security/smack/smack_lsm.c            |  8 +++-
>  security/tomoyo/tomoyo.c              |  9 ++++-
>  security/yama/yama_lsm.c              |  8 +++-
>  21 files changed, 217 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/userspace-api/lsm.rst
>  create mode 100644 include/uapi/linux/lsm.h

...

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 6e156d2acffc..32285ce65419 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1665,6 +1665,20 @@ struct security_hook_heads {
>         #undef LSM_HOOK
>  } __randomize_layout;
>
> +/**
> + * struct lsm_id - Identify a Linux Security Module.
> + * @lsm: name of the LSM, must be approved by the LSM maintainers
> + * @id: LSM ID number from uapi/linux/lsm.h
> + * @attrs: which attributes this LSM supports
> + *
> + * Contains the information that identifies the LSM.
> + */
> +struct lsm_id {
> +       const u8        *lsm;
> +       u64             id;
> +       u64             attrs;
> +};

I would either start setting the 'attrs' field values in the LSMs when
their 'lsm_id' struct is defined or I would leave it out of this patch
and add it later in the patchset when it is used.

> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> new file mode 100644
> index 000000000000..aa3e01867739
> --- /dev/null
> +++ b/include/uapi/linux/lsm.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Linux Security Modules (LSM) - User space API
> + *
> + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> + * Copyright (C) 2022 Intel Corporation
> + */
> +
> +#ifndef _UAPI_LINUX_LSM_H
> +#define _UAPI_LINUX_LSM_H
> +
> +/*
> + * ID tokens to identify Linux Security Modules (LSMs)
> + *
> + * These token values are used to uniquely identify specific LSMs
> + * in the kernel as well as in the kernel's LSM userspace API.
> + *
> + * A value of zero/0 is considered undefined and should not be used
> + * outside the kernel. Values 1-99 are reserved for potential
> + * future use.
> + */
> +#define LSM_ID_UNDEF           0
> +#define LSM_ID_CAPABILITY      100
> +#define LSM_ID_SELINUX         101
> +#define LSM_ID_SMACK           102
> +#define LSM_ID_TOMOYO          103
> +#define LSM_ID_IMA             104
> +#define LSM_ID_APPARMOR                105
> +#define LSM_ID_YAMA            106
> +#define LSM_ID_LOADPIN         107
> +#define LSM_ID_SAFESETID       108
> +#define LSM_ID_LOCKDOWN                109
> +#define LSM_ID_BPF             110
> +#define LSM_ID_LANDLOCK                111
> +
> +/*
> + * LSM_ATTR_XXX definitions identify different LSM attributes
> + * which are used in the kernel's LSM userspace API. Support
> + * for these attributes vary across the different LSMs. None
> + * are required.
> + *
> + * A value of zero/0 is considered undefined and should not be used
> + * outside the kernel. Values 1-99 are reserved for potential
> + * future use.
> + */
> +#define LSM_ATTR_CURRENT       100
> +#define LSM_ATTR_EXEC          101
> +#define LSM_ATTR_FSCREATE      102
> +#define LSM_ATTR_KEYCREATE     103
> +#define LSM_ATTR_PREV          104
> +#define LSM_ATTR_SOCKCREATE    105

We might as well add a LSM_ATTR_UNDEF for zero/0.

> +#endif /* _UAPI_LINUX_LSM_H */

--
paul-moore.com
