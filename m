Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8245696BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjBNRlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjBNRlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:41:17 -0500
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85863244A0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:41:10 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PGT5c6MkxzMqqNP;
        Tue, 14 Feb 2023 18:41:08 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PGT5b6DFLzMs4GY;
        Tue, 14 Feb 2023 18:41:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1676396468;
        bh=CW77+OpiO7YTRCJgB+UFdsaJXkh6BiQFaJbuB8LdzHM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=o6ygYeJZPTpFzRuhTu/3CHHNFQ6iEsk8b9oJn30qItF18Gr/8dQZyt9B0J15d+1tw
         KcueINTwRCeL5qm5KW6rMGU2trusVa0wpR/bvC2M9gOcUK19Y3m/PGOvmpSU9eDdEm
         VEDXnNSNaaUTtD0dDA3ETmxsK5RvmvURyIE0uCtw=
Message-ID: <3977d478-cb41-832b-7b5e-73dd247f267d@digikod.net>
Date:   Tue, 14 Feb 2023 18:41:07 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v5 4/8] LSM: lsm_get_self_attr syscall for LSM self
 attributes
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20230109180717.58855-1-casey@schaufler-ca.com>
 <20230109180717.58855-5-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230109180717.58855-5-casey@schaufler-ca.com>
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


On 09/01/2023 19:07, Casey Schaufler wrote:
> Create a system call lsm_get_self_attr() to provide the security
> module maintained attributes of the current process. Historically
> these attributes have been exposed to user space via entries in
> procfs under /proc/self/attr.
> 
> Attributes are provided as a collection of lsm_ctx structures
> which are placed into a user supplied buffer. Each structure
> identifys the size of the attribute, and the attribute value.
> The format of the attribute value is defined by the security
> module, but will always be \0 terminated. The ctx_len value
> will always be strlen(ctx)+1.
> 
>          ---------------------------
>          | __u32 id                |
>          ---------------------------
>          | __u64 flags             |
>          ---------------------------
>          | __kernel_size_t ctx_len |
>          ---------------------------
>          | __u8 ctx[ctx_len]       |
>          ---------------------------
>          | __u32 id                |
>          ---------------------------
>          | __u64 flags             |
>          ---------------------------
>          | __kernel_size_t ctx_len |
>          ---------------------------
>          | __u8 ctx[ctx_len]       |
>          ---------------------------
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   Documentation/userspace-api/lsm.rst |   9 ++
>   include/linux/syscalls.h            |   3 +
>   include/uapi/linux/lsm.h            |  21 ++++
>   kernel/sys_ni.c                     |   3 +
>   security/Makefile                   |   1 +
>   security/lsm_syscalls.c             | 182 ++++++++++++++++++++++++++++
>   6 files changed, 219 insertions(+)
>   create mode 100644 security/lsm_syscalls.c

For new files (e.g. lsm_syscalls.c), it would be nice to auto-format 
them with clang-format. It helps maintenance by keeping a consistent 
style across commits, which should also help backports, and it avoids 
nitpicking on style issues.
