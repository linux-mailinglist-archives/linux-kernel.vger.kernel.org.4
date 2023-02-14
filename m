Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E81696A37
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjBNQsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjBNQsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:48:17 -0500
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6501D3C0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:48:11 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PGRwT0VT7zMqdTZ;
        Tue, 14 Feb 2023 17:48:09 +0100 (CET)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4PGRwP613lzMrY8P;
        Tue, 14 Feb 2023 17:48:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1676393288;
        bh=StyQV5VlfkbUqiAvO0zOrs/9byjjPFA4+fUSOycYmmE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=1/F48u5CG0IsU99YnekoUmb0RzF7DmvDMzBOukyFkT6iIJhdfpZmTt71ylV0xLMF7
         K8IhQ8TUc/LZ4Bpb8nN8nk5YnxzoIsT93HzI1QjaKfBkYrmTDveT2QHfb6BlyqnwS4
         TNaemjyBVXrPwG1xleOajIUz73mJQrjML+N2qesE=
Message-ID: <b25a6279-2531-4711-1876-b181fce4acbe@digikod.net>
Date:   Tue, 14 Feb 2023 17:48:05 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v5 4/8] LSM: lsm_get_self_attr syscall for LSM self
 attributes
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, Kees Cook <keescook@chromium.org>,
        john.johansen@canonical.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20230109180717.58855-1-casey@schaufler-ca.com>
 <20230109180717.58855-5-casey@schaufler-ca.com>
 <f8dca9d2-6e5e-4584-88b3-f71f62988dab@app.fastmail.com>
 <CAHC9VhRRRo9V-q8jT7AbSh1eTPGN7OmxP9hrPz=GTPQa80RjCg@mail.gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <CAHC9VhRRRo9V-q8jT7AbSh1eTPGN7OmxP9hrPz=GTPQa80RjCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/01/2023 22:39, Paul Moore wrote:
> On Thu, Jan 12, 2023 at 9:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Mon, Jan 9, 2023, at 19:07, Casey Schaufler wrote:
>>> +/**
>>> + * struct lsm_ctx - LSM context
>>> + * @id: the LSM id number, see LSM_ID_XXX
>>> + * @flags: context specifier and LSM specific flags
>>> + * @ctx_len: the size of @ctx
>>> + * @ctx: the LSM context, a nul terminated string
>>> + *
>>> + * @ctx in a nul terminated string.
>>> + *   (strlen(@ctx) < @ctx_len) is always true.
>>> + *   (strlen(@ctx) == @ctx_len + 1) is not guaranteed.
>>> + */
>>> +struct lsm_ctx {
>>> +     __u32           id;
There is a hole here for 64-bit architectures.

>>> +     __u64           flags;
>>> +     __kernel_size_t ctx_len;

This is an architecture-related size, which makes the struct size 
different according to architectures. We should avoid that.

>>> +     __u8            ctx[];
>>> +};

I suggest packing this struct.

>>
>> I think this should be changed to be the same layout on
>> all architectures regardless of __u64 alignment and
>> sizeof(__kernel_size_t) differences, to avoid the need
>> for compat syscalls and explicit clearing of the
>> internal padding.
>>
>> Maybe just use __u64 fields for all three integers?
> 
> I have no problem with that ... the ctx[] field is variable length
> anyway so keeping it as a __u8 should be fine.
> 

For Landlock, we make sure the UAPI structs don't contain holes,  are 
packed, and have the same size for all architectures. We can check that 
with pahole but for strong guarantee I suggest the same build check as 
for Landlock's build_check_abi(): 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/landlock/syscalls.c#n68
We don't need to use 64-bit fields everywhere.
