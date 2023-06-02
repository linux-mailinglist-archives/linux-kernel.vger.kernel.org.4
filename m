Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1732771FC37
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbjFBIjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjFBIjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:39:01 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54B61A1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:39:00 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-96fffd1ba46so123860266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 01:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685695139; x=1688287139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jda3uobQ4e/ZCA/aiprMO5o6cFc2zo/SCaAFYYc33tg=;
        b=DFvkh47N53HAnKMaSELW4V5UCNV57afHZfDpHsQbNPQWG6vVmWUAMyY6VtEXz1YQiR
         3Lu8UG9kFZRFFyB7VZynWl6GfzLf/9jfmOZzCopbdFVjW9mWsEnD5D4sTMlZu8abGq9S
         95d1erpNNU62jVar/aq2xsolB5nR8c9G424Pu1mpSvMhhYLphXkcBe9vFcPYXTsglELv
         RfFFxliEjuCBwqR0XXwlZ7n2k7vawot5a6B+4TrWtqV54/bqkwEaK+plPxtRgCkZo6P4
         xGI1AxScgSkVR93gdRmYPvkXiil7QfLJA9bZBVk8Gcp26NbOAJcfT1CEbOWO+GElbUGu
         Jl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685695139; x=1688287139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jda3uobQ4e/ZCA/aiprMO5o6cFc2zo/SCaAFYYc33tg=;
        b=aJWAyNgrlXNStkksy2d6hJIU4pnE2MBYO8Y8Ydd4AIToK1yKVgZhxqizRuVXZXLszi
         KzgB3dFADOa3ho8U/A7QrxH/GcLggHamflJPhaPxhzNYaPwQx2hBf521Y0uELX/nv81N
         H5b/qg2YyZl805BBB14yTishVGw0fo4KnknP4rwqpo+6FsQAbJb1h6inAr6OYC/vOgq5
         nbwFx0ukqMznPOzbCSNpI1QZDsTDqdIC0oKLyevm+r/jqjD8cqyOD3bnW5A/HqKozT5W
         C7VwkhDCCrJiN0mjTQ4VsYBLRH0JWdniMuhCdUchsf2sNUqWZULxaT9G7w8WLFn5Yqxf
         H1jw==
X-Gm-Message-State: AC+VfDylvIdFh3u7uZEFKPONk+jLlv63ws1xy/TTDW4JMQ9eLB0XLm49
        iN2kLeJqnCuZIoMoaRFUXC9OkWJV+NUed6Q=
X-Google-Smtp-Source: ACHHUZ6p0OA0St98mrnqz58Xij1YzPbb+WIUM8sQ8BLm3L74+H/j0k8sMNI8pjyEhPfjUu11IO+HfiJ8jyQsn+k=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:270c:b0:965:b935:91f6 with SMTP
 id w12-20020a170907270c00b00965b93591f6mr2890718ejk.14.1685695139208; Fri, 02
 Jun 2023 01:38:59 -0700 (PDT)
Date:   Fri,  2 Jun 2023 08:38:56 +0000
In-Reply-To: <ZHjnDAEmimeETrNZ@boqun-archlinux>
Mime-Version: 1.0
References: <ZHjnDAEmimeETrNZ@boqun-archlinux>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602083856.1035444-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 5/8] rust: workqueue: add helper for defining
 work_struct fields
From:   Alice Ryhl <aliceryhl@google.com>
To:     boqun.feng@gmail.com
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boqun Feng <boqun.feng@gmail.com> writes:
> On Thu, Jun 01, 2023 at 01:49:43PM +0000, Alice Ryhl wrote:
>> diff --git a/rust/helpers.c b/rust/helpers.c
>> index 81e80261d597..7f0c2fe2fbeb 100644
>> --- a/rust/helpers.c
>> +++ b/rust/helpers.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/spinlock.h>
>>  #include <linux/sched/signal.h>
>>  #include <linux/wait.h>
>> +#include <linux/workqueue.h>
>>  
>>  __noreturn void rust_helper_BUG(void)
>>  {
>> @@ -128,6 +129,13 @@ void rust_helper_put_task_struct(struct task_struct *t)
>>  }
>>  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
>>  
>> +void rust_helper___INIT_WORK(struct work_struct *work, work_func_t func,
>> +			     bool on_stack)
>> +{
>> +	__INIT_WORK(work, func, on_stack);
> 
> Note here all the work items in Rust will share the same lockdep class.
> That could be problematic: the lockdep classes for work are for
> detecting deadlocks in the following scenario:
> 
> step 1: queue a work "foo", whose work function is:
> 
> 	mutex_lock(&bar);
> 	do_something(...);
> 	mutex_unlock(&bar);
> 
> step 2: in another thread do:
> 
> 	mutex_lock(&bar);
> 	flush_work(foo);	// wait until work "foo" is finished.
> 
> if this case, if step 2 get the lock "bar" first, it's a deadlock.
> 
> With the current implementation, all the work items share the same
> lockdep class, so the following will be treated as deadlock:
> 
> 	<in work "work1">
> 	mutex_lock(&bar);
> 	do_something(...);
> 	mutex_unlock(&bar);
> 
> 	<in another thread>
> 	mutex_lock(&bar);
> 	flush_work(work2);	// flush work2 intead of work1.
> 
> which is a false positive. We at least need some changes in C side to
> make it work:
> 
> 	https://lore.kernel.org/rust-for-linux/20220802015052.10452-7-ojeda@kernel.org/
> 
> however, that still has the disadvantage that all Rust work items have
> the same name for the lockdep classes.. maybe we should extend that for
> an extra "name" parameter. And then it's not necessary to be a macro.

Yeah, I did know about this issue, but I didn't know what the best way
to fix it is. What solution would you like me to use?

Alice
