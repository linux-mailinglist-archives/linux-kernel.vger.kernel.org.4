Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFC8638E60
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiKYQmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKYQl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:41:57 -0500
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957FE4D5EA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 08:41:56 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NJgcb4n5JzMpnww;
        Fri, 25 Nov 2022 17:41:51 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NJgcZ3nxyzxP;
        Fri, 25 Nov 2022 17:41:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1669394511;
        bh=vY+S7rKe5zpryvGZvzJksTXeNwdZsTX2Q1EFwQxVL4o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UWwFvsxG6ej77/ZxWnJTpNkNNZMwhBgxujN2eExdg+tJTsIu6kfdbBgW+jbnQ8fWX
         NOoHhSPRywQ9QCP9W7RLCSPdmYIAM78oDF8SliVF3bnNczPj7hQFEFtxY17wXl9uqV
         9VMMmibt7qCt2F0juj8HjBfa9pfkwJg4jZXNTx44=
Message-ID: <a94f2bf6-1429-af6d-64a2-3403f60c8ba3@digikod.net>
Date:   Fri, 25 Nov 2022 17:41:49 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v3 2/9] LSM: Identify the process attributes for each
 module
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20221123201552.7865-1-casey@schaufler-ca.com>
 <20221123201552.7865-3-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221123201552.7865-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/11/2022 21:15, Casey Schaufler wrote:
> Add an integer member "attrs_used" to the struct lsm_id which
> identifies the API related data associated with each security
> module. The initial set of features maps to information that
> has traditionaly been available in /proc/self/attr. They are
> documented in a new userspace-api file.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   Documentation/userspace-api/index.rst |  1 +
>   Documentation/userspace-api/lsm.rst   | 55 +++++++++++++++++++++++++++
>   include/linux/lsm_hooks.h             |  2 +
>   include/uapi/linux/lsm.h              | 12 ++++++
>   security/apparmor/lsm.c               |  1 +
>   security/selinux/hooks.c              |  2 +
>   security/smack/smack_lsm.c            |  1 +
>   7 files changed, 74 insertions(+)
>   create mode 100644 Documentation/userspace-api/lsm.rst
> 
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index c78da9ce0ec4..6feff0fcd88f 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -30,6 +30,7 @@ place where this information is gathered.
>      sysfs-platform_profile
>      vduse
>      futex2
> +   lsm
>   
>   .. only::  subproject and html
>   
> diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
> new file mode 100644
> index 000000000000..6ddf5506110b
> --- /dev/null
> +++ b/Documentation/userspace-api/lsm.rst
> @@ -0,0 +1,55 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> +.. Copyright (C) 2022 Intel Corporation
> +
> +=====================================
> +Linux Security Modules
> +=====================================
> +
> +:Author: Casey Schaufler
> +:Date: November 2022
> +
> +Linux security modules (LSM) provide a mechanism to implement
> +additional access controls to the Linux security policies.
> +
> +The various security modules may support any of these attributes:
> +
> +``LSM_ATTR_CURRENT`` is the current, active security context of the
> +process.
> +The proc filesystem provides this value in ``/proc/self/attr/current``.
> +This is supported by the SELinux, Smack and AppArmor security modules.
> +Smack also provides this value in ``/proc/self/attr/smack/current``.
> +AppArmor also provides this value in ``/proc/self/attr/apparmor/current``.
> +
> +``LSM_ATTR_EXEC`` is the security context of the process at the time the
> +current image was executed.
> +The proc filesystem provides this value in ``/proc/self/attr/exec``.
> +This is supported by the SELinux and AppArmor security modules.
> +AppArmor also provides this value in ``/proc/self/attr/apparmor/exec``.
> +
> +``LSM_ATTR_FSCREATE`` is the security context of the process used when
> +creating file system objects.
> +The proc filesystem provides this value in ``/proc/self/attr/fscreate``.
> +This is supported by the SELinux security module.
> +
> +``LSM_ATTR_KEYCREATE`` is the security context of the process used when
> +creating key objects.
> +The proc filesystem provides this value in ``/proc/self/attr/keycreate``.
> +This is supported by the SELinux security module.
> +
> +``LSM_ATTR_PREV`` is the security context of the process at the time the
> +current security context was set.
> +The proc filesystem provides this value in ``/proc/self/attr/prev``.
> +This is supported by the SELinux and AppArmor security modules.
> +AppArmor also provides this value in ``/proc/self/attr/apparmor/prev``.
> +
> +``LSM_ATTR_SOCKCREATE`` is the security context of the process used when
> +creating socket objects.
> +The proc filesystem provides this value in ``/proc/self/attr/sockcreate``.
> +This is supported by the SELinux security module.
> +
> +Additional documentation
> +========================
> +
> +* Documentation/security/lsm.rst
> +* Documentation/security/lsm-development.rst
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index d306db1044d1..7e88acc37a29 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1606,12 +1606,14 @@ struct security_hook_heads {
>    * struct lsm_id - identify a Linux Security Module.
>    * @lsm: Name of the LSM. Must be approved by the LSM maintainers.
>    * @id: LSM ID number from uapi/linux/lsm.h
> + * @attrs_used: Which attributes this LSM supports.
>    *
>    * Contains the information that identifies the LSM.
>    */
>   struct lsm_id {
>   	const u8	*lsm;
>   	u32		id;
> +	u64		attrs_used;

I'd prefer this field to be part of the previous patch. This doesn't 
change much but it is to highlight that the struct lsm_id size should 
not change unless properly handled by userspace.


>   };
>   
>   /*
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 47791c330cbf..8e9124bf622c 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -29,4 +29,16 @@
>   #define LSM_ID_BPF		110
>   #define LSM_ID_LANDLOCK		111
>   
> +/*
> + * LSM_ATTR_XXX values identify the /proc/.../attr entry that the
> + * context represents. Not all security modules provide all of these
> + * values. Some security modules provide none of them.
> + */
> +#define LSM_ATTR_CURRENT	0x0001
> +#define LSM_ATTR_EXEC		0x0002
> +#define LSM_ATTR_FSCREATE	0x0004
> +#define LSM_ATTR_KEYCREATE	0x0008
> +#define LSM_ATTR_PREV		0x0010
> +#define LSM_ATTR_SOCKCREATE	0x0020
> +
>   #endif /* _UAPI_LINUX_LSM_H */
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index b859b1af6c75..3a6bf4f95d84 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1206,6 +1206,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
>   static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
>   	.lsm = "apparmor",
>   	.id = LSM_ID_APPARMOR,
> +	.attrs_used = LSM_ATTR_CURRENT | LSM_ATTR_PREV | LSM_ATTR_EXEC,
>   };
>   
>   static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5fcce36267bd..e831d9c38c54 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7018,6 +7018,8 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
>   static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
>   	.lsm = "selinux",
>   	.id = LSM_ID_SELINUX,
> +	.attrs_used = LSM_ATTR_CURRENT | LSM_ATTR_EXEC | LSM_ATTR_FSCREATE |
> +		      LSM_ATTR_KEYCREATE | LSM_ATTR_PREV | LSM_ATTR_SOCKCREATE,
>   };
>   
>   /*
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index c7ba80e20b8d..c2a05217bde4 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4791,6 +4791,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>   static struct lsm_id smack_lsmid __lsm_ro_after_init = {
>   	.lsm = "smack",
>   	.id = LSM_ID_SMACK,
> +	.attrs_used = LSM_ATTR_CURRENT,
>   };
>   
>   static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
