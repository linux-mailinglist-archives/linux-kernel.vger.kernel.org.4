Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC686D43CA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjDCLrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjDCLrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:47:17 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D780F1FF1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:47:14 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Pqpz46kG2zMqR6Y;
        Mon,  3 Apr 2023 13:47:12 +0200 (CEST)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Pqpz22sdDzMpqjL;
        Mon,  3 Apr 2023 13:47:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1680522432;
        bh=l/Miq1FXcuzbR9T4SFEdiVhywd+ZoHuDueWC1NgtO10=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=parMgoYOeYZBV33/rJmJ+eAckFCZZpy5lx7PAuQfzAOBTgtwZdaa1gNnPCiHnV/j/
         0e8VE5xQzF5hJjMMvL5TcYZoPAxf+pMVCT4+24NSF2SeOz+2KMdg+K4NkzU70S6nO1
         XgaXeFdMsajoahOpGUvZ/v4zaLVmH3yBfS61mpks=
Message-ID: <40081d47-14f3-b86c-59e3-6f78aeae4e2b@digikod.net>
Date:   Mon, 3 Apr 2023 13:47:09 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v7 07/11] LSM: Helpers for attribute names and filling an
 lsm_ctx
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20230315224704.2672-1-casey@schaufler-ca.com>
 <20230315224704.2672-8-casey@schaufler-ca.com>
 <544a4809-1a79-9dd7-61a5-5fce1f4a5f10@digikod.net>
 <539e698a-1ab7-a390-a3a4-6c7e43db4eb6@digikod.net>
In-Reply-To: <539e698a-1ab7-a390-a3a4-6c7e43db4eb6@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/04/2023 11:54, Mickaël Salaün wrote:
> 
> On 03/04/2023 11:47, Mickaël Salaün wrote:
>>
>> On 15/03/2023 23:47, Casey Schaufler wrote:
>>> Add lsm_name_to_attr(), which translates a text string to a
>>> LSM_ATTR value if one is available.
>>>
>>> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
>>> the trailing attribute value.
>>>
>>> All are used in module specific components of LSM system calls.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>     include/linux/security.h | 13 ++++++++++
>>>     security/lsm_syscalls.c  | 51 ++++++++++++++++++++++++++++++++++++++++
>>>     security/security.c      | 31 ++++++++++++++++++++++++
>>>     3 files changed, 95 insertions(+)
>>
>> [...]
>>
>>> diff --git a/security/security.c b/security/security.c
>>> index 2c57fe28c4f7..f7b814a3940c 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -753,6 +753,37 @@ static int lsm_superblock_alloc(struct super_block *sb)
>>>     	return 0;
>>>     }
>>>     
>>> +/**
>>> + * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
>>> + * @ctx: an LSM context to be filled
>>> + * @context: the new context value
>>> + * @context_size: the size of the new context value
>>> + * @id: LSM id
>>> + * @flags: LSM defined flags
>>> + *
>>> + * Fill all of the fields in a user space lsm_ctx structure.
>>> + * Caller is assumed to have verified that @ctx has enough space
>>> + * for @context.
>>> + * Returns 0 on success, -EFAULT on a copyout error.
>>> + */
>>> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
>>> +		      size_t context_size, u64 id, u64 flags)
>>> +{
>>> +	struct lsm_ctx local;
>>> +	void __user *vc = ctx;
>>> +
>>> +	local.id = id;
>>> +	local.flags = flags;
>>> +	local.ctx_len = context_size;
>>> +	local.len = context_size + sizeof(local);
>>> +	vc += sizeof(local);
>>> +	if (copy_to_user(ctx, &local, sizeof(local)))
>>> +		return -EFAULT;
>>> +	if (context_size > 0 && copy_to_user(vc, context, context_size))
>>> +		return -EFAULT;
>>
>> Can we do a single copy_to_user() call? That would avoid inconsistent
>> user space data, could speed up a bit the operation, and make the code
>> easier to understand. To use the stack, we need to know the maximum size
>> of context_size for all use cases, which seems reasonable and can be
>> checked at build time (on each LSM side, and potentially with specific
>> context type passed as enum instead of context_size) and run time (for
>> this generic helper).
> 
> Well, actually the context_size should be inferred from id, and the
> "local" size should be defined and check at build time against all
> context ID sizes.

@ctx_len should already be known by user space according to the LSM ID 
and the requested attribute. @len should already be known by user space 
because lsm_ctx is part of the ABI.

The only reason I can think of the rationale for @len and @ctx_len is 
that struct lsm_ctx could gain more fields. If this happen, they would 
then need to be inserted before @ctx. This would make this struct 
lsm_ctx too flexible and complex for user space to parse correctly (e.g. 
for strace, gdb).

I don't see where we could use @flags instead of relying on a new 
attribute type.

I think security_getselfattr() and lsm_fill_user_ctx() could be changed 
to avoid each LSM to pass their own ID to lsm_fill_user_ctx(). We could 
have a lsm_get_attr_size(lsm_id, attr) helper (called by 
security_getselfattr) to group these relations, based on fixed values, 
exposed in the UAPI, and checked at build time with the size of the 
related LSM-specific attribute type. This would also allow to factor out 
the total size calculation needed before calling the getselfattr() 
implementers, and then rely on a common consistent behavior. That could 
also be used to not call getselfattr() implementers if they don't handle 
a specific attribute, and then remove their related error handling for 
this case.

For now, the getselfattr() hook (not the related syscall) doesn't need 
to pass a "flags" argument to each LSM because there is no use of it.


> 
>>
>>
>>> +	return 0;
>>> +}
>>> +
>>>     /*
>>>      * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>>>      * can be accessed with:
