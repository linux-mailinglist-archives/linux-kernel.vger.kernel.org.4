Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836136D4FE3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjDCSEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjDCSEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:04:23 -0400
X-Greylist: delayed 21617 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Apr 2023 11:04:20 PDT
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399CF212E;
        Mon,  3 Apr 2023 11:04:20 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PqzLB3rJbzMqR7q;
        Mon,  3 Apr 2023 20:04:18 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PqzL51PS1z20rr;
        Mon,  3 Apr 2023 20:04:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1680545058;
        bh=x3pa1ABcp4jbN+EAw819rV8jrTRCvkGXv9lnDc+NOiw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KeqqlNSMZL9G5pjaJxBrHrSPjM6cJXDPxib4Uaw6dYWqwXfJlFDC1Ygk/VwKfsXUE
         T5ZRSYJSxLJEh7dWy3yL34co4ZRWGkMUmNyPJskms0zI5sgNNvO3sEj73Ig6IwE+xr
         BMpryzF55hSOtGrnq6V/WD594GMUrre3/plXNt44=
Message-ID: <f8faa0c2-83aa-ddfa-5a4c-a4dc3c4c7ed9@digikod.net>
Date:   Mon, 3 Apr 2023 20:04:12 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v7 04/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20230315224704.2672-1-casey@schaufler-ca.com>
 <20230315224704.2672-5-casey@schaufler-ca.com>
 <b63f1957-d3d5-28f9-fd27-c0e629456a9f@digikod.net>
 <521dd15c-1dbb-77ed-0c97-0ea38688e219@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <521dd15c-1dbb-77ed-0c97-0ea38688e219@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/04/2023 19:36, Casey Schaufler wrote:
> On 4/3/2023 5:04 AM, Mickaël Salaün wrote:
>>
>> On 15/03/2023 23:46, Casey Schaufler wrote:
>>> Create a system call lsm_get_self_attr() to provide the security
>>> module maintained attributes of the current process.
>>> Create a system call lsm_set_self_attr() to set a security
>>> module maintained attribute of the current process.
>>> Historically these attributes have been exposed to user space via
>>> entries in procfs under /proc/self/attr.
>>>
>>> The attribute value is provided in a lsm_ctx structure. The structure
>>> identifys the size of the attribute, and the attribute value. The format
>>> of the attribute value is defined by the security module. A flags field
>>> is included for LSM specific information. It is currently unused and
>>> must
>>> be 0. The total size of the data, including the lsm_ctx structure and
>>> any
>>> padding, is maintained as well.
>>>
>>> struct lsm_ctx {
>>>           __u64   id;
>>>           __u64   flags;
>>>           __u64   len;
>>>           __u64   ctx_len;
>>>           __u8    ctx[];
>>> };
>>>
>>> Two new LSM hooks are used to interface with the LSMs.
>>> security_getselfattr() collects the lsm_ctx values from the
>>> LSMs that support the hook, accounting for space requirements.
>>> security_setselfattr() identifies which LSM the attribute is
>>> intended for and passes it along.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>    Documentation/userspace-api/lsm.rst | 15 +++++
>>>    include/linux/lsm_hook_defs.h       |  4 ++
>>>    include/linux/lsm_hooks.h           |  9 +++
>>>    include/linux/security.h            | 19 ++++++
>>>    include/linux/syscalls.h            |  5 ++
>>>    include/uapi/linux/lsm.h            | 33 ++++++++++
>>>    kernel/sys_ni.c                     |  4 ++
>>>    security/Makefile                   |  1 +
>>>    security/lsm_syscalls.c             | 55 ++++++++++++++++
>>>    security/security.c                 | 97 +++++++++++++++++++++++++++++
>>>    10 files changed, 242 insertions(+)
>>>    create mode 100644 security/lsm_syscalls.c
>>
>> [...]
>>
>>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>>> new file mode 100644
>>> index 000000000000..feee31600219
>>> --- /dev/null
>>> +++ b/security/lsm_syscalls.c
>>> @@ -0,0 +1,55 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * System calls implementing the Linux Security Module API.
>>> + *
>>> + *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
>>> + *  Copyright (C) 2022 Intel Corporation
>>> + */
>>> +
>>> +#include <asm/current.h>
>>> +#include <linux/compiler_types.h>
>>> +#include <linux/err.h>
>>> +#include <linux/errno.h>
>>> +#include <linux/security.h>
>>> +#include <linux/stddef.h>
>>> +#include <linux/syscalls.h>
>>> +#include <linux/types.h>
>>> +#include <linux/lsm_hooks.h>
>>> +#include <uapi/linux/lsm.h>
>>> +
>>> +/**
>>> + * sys_lsm_set_self_attr - Set current task's security module attribute
>>> + * @attr: which attribute to set
>>> + * @ctx: the LSM contexts
>>> + * @size: size of @ctx
>>> + * @flags: reserved for future use
>>> + *
>>> + * Sets the calling task's LSM context. On success this function
>>> + * returns 0. If the attribute specified cannot be set a negative
>>> + * value indicating the reason for the error is returned.
>>
>> Do you think it is really worth it to implement syscalls that can get
>> and set attributes to several LSMs at the same time, instead of one at
>> a time?
> 
> Setting the values for more than one LSM is impractical due to the possibility
> that the Nth value may fail, and unwinding the N-1 values may not be possible.

Indeed, so unless I missed something, why not passing the LSM ID as a 
syscall argument for lsm_set_self_attr() and lsm_get_self_attr(), and 
avoid managing a set of contexts but instead only managing one context 
at a time (to get or set)?


> 
>> LSM-specific tools don't care about other LSMs.
> 
> That's part of the problem. Are systemd, dbusd, ps and id LSM specific tools?
> They shouldn't be.
> 
>> I still think it would be much simpler (for kernel and user space) to
>> pass an LSM ID to both syscalls. This would avoid dealing with
>> variable arrays of variable element lengths, to both get or set
>> attributes.
> 
> ps and id should both work regardless of which and how many LSMs provide
> context attributes. They shouldn't need to know which LSMs are active in
> advance. If a new LSM is introduced, they shouldn't need to be updated to
> support it.

I agree, and making the syscalls simpler doesn't change that.

> 
>>
>> Furthermore, considering the hypotetical LSM_ATTR_MAGICFD that was
>> previously talked about, getting an unknown number of file descriptor
>> doesn't look good neither.
> 
> If you have multiple LSM_ATTR_MAGICFD values and can only get one at
> a time you have to do something convoluted with flags to get them all.
> I don't see that as a good thing.

Yes, that was another argument to *not* deal with a set of contexts.


> 
>>
>>
>>> + */
>>> +SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct
>>> lsm_ctx __user *,
>>> +        ctx, size_t __user, size, u32, flags)
>>> +{
>>> +    return security_setselfattr(attr, ctx, size, flags);
>>> +}
>>> +
>>> +/**
>>> + * sys_lsm_get_self_attr - Return current task's security module
>>> attributes
>>> + * @attr: which attribute to set
>>
>> attribute to *get*
>>
>>> + * @ctx: the LSM contexts
>>> + * @size: size of @ctx, updated on return
>>
>> I suggest to use a dedicated argument to read the allocated size, and
>> another to write the actual/written size.
>>
>> This would not be required with an LSM ID passed to the syscall
>> because attribute sizes should be known by user space, and there is no
>> need to help them probe this information.
>>
>>
>>> + * @flags: reserved for future use
>>> + *
>>> + * Returns the calling task's LSM contexts. On success this
>>> + * function returns the number of @ctx array elements. This value
>>> + * may be zero if there are no LSM contexts assigned. If @size is
>>> + * insufficient to contain the return data -E2BIG is returned and
>>> + * @size is set to the minimum required size.
>>
>> Doing something (updating a buffer) even when returning an error
>> doesn't look right. These sizes should be well-known to user space and
>> part of the ABI/UAPI.
> 
> No. The size of attributes is not well known to user space.
> They are usually text strings. The maximum size will be known,
> but that's putting additional burden on user space to know
> about all possible LSMs. It's not always necessary.

Right, I forgot the strings stuff… The lsm_get_self_attr() syscall could 
then return a ctx_actual_size (as one argument), and a ctx pointer (as 
another argument). Similarly, the lsm_set_self_attr() syscall could use 
a dedicated argument for ctx_size and another for the ctx pointer.

> 
>>
>>
>>> In all other cases
>>> + * a negative value indicating the error is returned.
>>> + */
>>> +SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct
>>> lsm_ctx __user *,
>>> +        ctx, size_t __user *, size, u32, flags)
>>> +{
>>> +    return security_getselfattr(attr, ctx, size, flags);
>>> +}
>>> diff --git a/security/security.c b/security/security.c
>>> index 87c8796c3c46..2c57fe28c4f7 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -2168,6 +2168,103 @@ void security_d_instantiate(struct dentry
>>> *dentry, struct inode *inode)
>>>    }
>>>    EXPORT_SYMBOL(security_d_instantiate);
>>>    +/**
>>> + * security_getselfattr - Read an LSM attribute of the current process.
>>> + * @attr: which attribute to return
>>> + * @ctx: the user-space destination for the information, or NULL
>>> + * @size: the size of space available to receive the data
>>> + * @flags: reserved for future use, must be 0
>>> + *
>>> + * Returns the number of attributes found on success, negative value
>>> + * on error. @size is reset to the total size of the data.
>>> + * If @size is insufficient to contain the data -E2BIG is returned.
>>> + */
>>> +int security_getselfattr(unsigned int __user attr, struct lsm_ctx
>>> __user *ctx,
>>> +             size_t __user *size, u32 __user flags)
>>> +{
>>> +    struct security_hook_list *hp;
>>> +    void __user *base = (void *)ctx;
>>> +    size_t total = 0;
>>> +    size_t this;
>>> +    size_t left;
>>> +    bool istoobig = false;
>>> +    int count = 0;
>>> +    int rc;
>>> +
>>> +    if (attr == 0)
>>> +        return -EINVAL;
>>> +    if (flags != 0)
>>> +        return -EINVAL;
>>> +    if (size == NULL)
>>> +        return -EINVAL;
>>> +    if (get_user(left, size))
>>> +        return -EFAULT;
>>> +
>>> +    hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
>>> +        this = left;
>>> +        if (base)
>>> +            ctx = (struct lsm_ctx __user *)(base + total);
>>> +        rc = hp->hook.getselfattr(attr, ctx, &this, flags);
>>> +        switch (rc) {
>>> +        case -EOPNOTSUPP:
>>> +            rc = 0;
>>> +            continue;
>>> +        case -E2BIG:
>>> +            istoobig = true;
>>> +            left = 0;
>>> +            break;
>>
>> These two error cases could be directly handled by
>> security_getselfattr() instead of relying on each LSM-specific
>> implementations. See my suggestion on patch 7/11 (lsm_get_attr_size).
> 
> Yes, they could. My understanding is that Paul wants the LSM layer
> to be "thin". Where possible and not insane, the logic should be in
> the LSM, not the infrastructure.

FWIW, since we are defining new syscalls to make user space's life 
easier, I'm in favor of a well defined common behavior (e.g. returned 
errno) and factoring common code to make each LSM-specific code thin.

> 
>>
>>
>>> +        case 0:
>>> +            left -= this;
>>> +            break;
>>> +        default:
>>> +            return rc;
>>> +        }
>>> +        total += this;
>>> +        count++;
>>> +    }
>>> +    if (count == 0)
>>> +        return LSM_RET_DEFAULT(getselfattr);
>>> +    if (put_user(total, size))
>>> +        return -EFAULT;
>>> +    if (rc)
>>> +        return rc;
>>> +    if (istoobig)
>>> +        return -E2BIG;
>>> +    return count;
>>> +}
>>> +
>>> +/**
>>> + * security_setselfattr - Set an LSM attribute on the current process.
>>> + * @attr: which attribute to set
>>> + * @ctx: the user-space source for the information
>>> + * @size: the size of the data
>>> + * @flags: reserved for future use, must be 0
>>> + *
>>> + * Set an LSM attribute for the current process. The LSM, attribute
>>> + * and new value are included in @ctx.
>>> + *
>>> + * Returns 0 on success, an LSM specific value on failure.
>>> + */
>>> +int security_setselfattr(unsigned int __user attr, struct lsm_ctx
>>> __user *ctx,
>>> +             size_t __user size, u32 __user flags)
>>> +{
>>> +    struct security_hook_list *hp;
>>> +    struct lsm_ctx lctx;
>>> +
>>> +    if (flags != 0)
>>> +        return -EINVAL;
>>> +    if (size < sizeof(*ctx))
>>> +        return -EINVAL;
>>> +    if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
>>> +        return -EFAULT;
>>> +
>>> +    hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
>>> +        if ((hp->lsmid->id) == lctx.id)
>>> +            return hp->hook.setselfattr(attr, ctx, size, flags);
>>> +
>>> +    return LSM_RET_DEFAULT(setselfattr);
>>> +}
>>> +
>>>    int security_getprocattr(struct task_struct *p, int lsmid, const
>>> char *name,
>>>                 char **value)
>>>    {
