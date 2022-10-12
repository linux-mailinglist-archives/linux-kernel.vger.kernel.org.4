Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0075FCCE2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJLVPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiJLVPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:15:12 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517D331DC9;
        Wed, 12 Oct 2022 14:15:05 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Mnlm41LkRzMq807;
        Wed, 12 Oct 2022 23:15:00 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Mnlm32qB4zx0;
        Wed, 12 Oct 2022 23:14:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1665609300;
        bh=fx83Mz4AIMBjr53VwrwbBCCP/YPMy/451Tj8F3Rjndw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hQKtjoZcMRy78nmhwi+nGDRrs45hlVucxxMBxbSgs4uQLqm4t7wUNVM1miqjRxD2r
         YD7kqzoWHyPNRAROsHRSYwwkGU3nHOVRUUnmsaMYCje6WMpZjwP64p9B6fwCb0+ngP
         dVcN3a5NZ1D9RA2dAdNazxJ/2z+iD9E0Ta9uCBF0=
Message-ID: <00f438de-3591-1d3e-905b-1df267da8833@digikod.net>
Date:   Wed, 12 Oct 2022 23:14:58 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v38 02/39] LSM: Add an LSM identifier for external use
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927195421.14713-3-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220927195421.14713-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/09/2022 21:53, Casey Schaufler wrote:
> Add an integer member "id" to the struct lsm_id. This value is
> a unique identifier associated with each security module. The
> values are defined in a new UAPI header file. Each existing LSM
> has been updated to include it's LSMID in the lsm_id.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   include/linux/lsm_hooks.h    |  1 +
>   include/uapi/linux/lsm.h     | 32 ++++++++++++++++++++++++++++++++
>   security/apparmor/lsm.c      |  2 ++
>   security/bpf/hooks.c         |  2 ++
>   security/commoncap.c         |  2 ++
>   security/landlock/setup.c    |  2 ++
>   security/loadpin/loadpin.c   |  2 ++
>   security/lockdown/lockdown.c |  4 +++-
>   security/safesetid/lsm.c     |  2 ++
>   security/selinux/hooks.c     |  2 ++
>   security/smack/smack_lsm.c   |  2 ++
>   security/tomoyo/tomoyo.c     |  2 ++
>   security/yama/yama_lsm.c     |  2 ++
>   13 files changed, 56 insertions(+), 1 deletion(-)
>   create mode 100644 include/uapi/linux/lsm.h
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 23054881eb08..407f57aaa6ef 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1603,6 +1603,7 @@ struct security_hook_heads {
>    */
>   struct lsm_id {
>   	const char	*lsm;		/* Name of the LSM */
> +	int		id;		/* LSM ID */
>   };
>   
>   /*
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> new file mode 100644
> index 000000000000..5647c3e220c0
> --- /dev/null
> +++ b/include/uapi/linux/lsm.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Linus Security Modules (LSM) - User space API
> + *
> + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> + * Copyright (C) Intel Corporation
> + */
> +
> +#ifndef _UAPI_LINUX_LSM_H
> +#define _UAPI_LINUX_LSM_H
> +
> +/*
> + * ID values to identify security modules.
> + * A system may use more than one security module.
> + *
> + * LSM_ID_XXX values 32 and below are reserved for future use

What do you have in mind? Why not "reserve" higher bits instead and 
start with SELinux at 1?


> + */
> +#define LSM_ID_INVALID		-1
> +#define LSM_ID_SELINUX		33
> +#define LSM_ID_SMACK		34
> +#define LSM_ID_TOMOYO		35
> +#define LSM_ID_IMA		36
> +#define LSM_ID_APPARMOR		37
> +#define LSM_ID_YAMA		38
> +#define LSM_ID_LOADPIN		39
> +#define LSM_ID_SAFESETID	40
> +#define LSM_ID_LOCKDOWN		41
> +#define LSM_ID_BPF		42
> +#define LSM_ID_LANDLOCK		43
> +#define LSM_ID_CAPABILITY	44

Out of curiosity, why this order?


> +
> +#endif /* _UAPI_LINUX_LSM_H */
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index b71f7d4159d7..fb6c7edd5393 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -24,6 +24,7 @@
>   #include <linux/zlib.h>
>   #include <net/sock.h>
>   #include <uapi/linux/mount.h>
> +#include <uapi/linux/lsm.h>
>   
>   #include "include/apparmor.h"
>   #include "include/apparmorfs.h"
> @@ -1204,6 +1205,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
>   
>   static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
>   	.lsm      = "apparmor",
> +	.id       = LSM_ID_APPARMOR,
>   };
>   
>   static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index e50de3abfde2..c462fc41dd57 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -5,6 +5,7 @@
>    */
>   #include <linux/lsm_hooks.h>
>   #include <linux/bpf_lsm.h>
> +#include <uapi/linux/lsm.h>
>   
>   static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
>   	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> @@ -21,6 +22,7 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
>    */
>   struct lsm_id bpf_lsmid __lsm_ro_after_init = {
>   	.lsm      = "bpf",
> +	.id       = LSM_ID_BPF,
>   };
>   
>   static int __init bpf_lsm_init(void)
> diff --git a/security/commoncap.c b/security/commoncap.c
> index dab1b5f5e6aa..4e9b140159d8 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -25,6 +25,7 @@
>   #include <linux/binfmts.h>
>   #include <linux/personality.h>
>   #include <linux/mnt_idmapping.h>
> +#include <uapi/linux/lsm.h>
>   
>   /*
>    * If a non-root user executes a setuid-root binary in
> @@ -1448,6 +1449,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
>   
>   static struct lsm_id capability_lsmid __lsm_ro_after_init = {
>   	.lsm      = "capability",
> +	.id       = LSM_ID_CAPABILITY,
>   };
>   
>   static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index fc7b69c5839e..1242c61c9de4 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -8,6 +8,7 @@
>   
>   #include <linux/init.h>
>   #include <linux/lsm_hooks.h>
> +#include <uapi/linux/lsm.h>
>   
>   #include "common.h"
>   #include "cred.h"
> @@ -25,6 +26,7 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
>   
>   struct lsm_id landlock_lsmid __lsm_ro_after_init = {
>   	.lsm      = LANDLOCK_NAME,
> +	.id       = LSM_ID_LANDLOCK,

Please only use one space after ".id"
