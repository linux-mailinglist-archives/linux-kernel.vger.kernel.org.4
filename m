Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5781B70DF9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbjEWOq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjEWOq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:46:56 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2925BCD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:46:54 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 1233B4010159;
        Tue, 23 May 2023 14:46:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1233B4010159
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1684853212;
        bh=WjIqZeXgtE4G/zI0XOtx3zWtmrcxBElWuTM9Lec+WqA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=em5+wnNXj6hCrEQiF23O2r9tinzq/BP+++PJt+E8WhNc7tjRBxDVId/vJJu+PH2hB
         omexiFB7DKpFkruA6jJxtY9JckWeMTpIF46gW4Ys6mETiDKRbTwx5G77dGCE/riuQm
         BG/9MwDdQD8o4q47/ldEN0YskoRcA1GaEGyBMfes=
MIME-Version: 1.0
Date:   Tue, 23 May 2023 17:46:52 +0300
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        peterx@redhat.com, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v2 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
In-Reply-To: <ZGzJNvKu8h5nDXsa@arm.com>
References: <20230517150321.2890206-1-revest@chromium.org>
 <20230517150321.2890206-4-revest@chromium.org>
 <bb08b91c-6c7b-a7a0-d4a7-68ddea46277f@redhat.com>
 <884d131bbc28ebfa0b729176e6415269@ispras.ru>
 <d7e3749c-a718-df94-92af-1cb0fecab772@redhat.com>
 <3c2e210b75bd56909322e8a3e5086d91@ispras.ru>
 <c63053b0-5797-504d-7896-c86271b64162@redhat.com> <ZGy6q7v+7jsXb1bV@arm.com>
 <f47d587fe5a6285f88191fbb13f367c7@ispras.ru> <ZGzJNvKu8h5nDXsa@arm.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <a91012e9cde9046d98713835476cab4b@ispras.ru>
X-Sender: izbyshev@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-23 17:09, Catalin Marinas wrote:
> On Tue, May 23, 2023 at 04:25:45PM +0300, Alexey Izbyshev wrote:
>> On 2023-05-23 16:07, Catalin Marinas wrote:
>> > On Tue, May 23, 2023 at 11:12:37AM +0200, David Hildenbrand wrote:
>> > > Also, how is passing "0"s to e.g., PR_GET_THP_DISABLE reliable? We
>> > > need arg2
>> > > -> arg5 to be 0. But wouldn't the following also just pass a 0 "int" ?
>> > >
>> > > prctl(PR_GET_THP_DISABLE, 0, 0, 0, 0)
>> > >
>> > > I'm easily confused by such (va_args) things, so sorry for the dummy
>> > > questions.
>> >
>> > Isn't the prctl() prototype in the user headers defined with the first
>> > argument as int while the rest as unsigned long? At least from the man
>> > page:
>> >
>> > int prctl(int option, unsigned long arg2, unsigned long arg3,
>> > 	  unsigned long arg4, unsigned long arg5);
>> >
>> > So there are no va_args tricks (which confuse me as well).
>> >
>> I have explicitly mentioned the problem with man pages in my response 
>> to
>> David[1]. Quoting myself:
>> 
>> > This stuff *is* confusing, and note that Linux man pages don't even tell
>> that prctl() is actually declared as a variadic function (and for
>> ptrace() this is mentioned only in the notes, but not in its 
>> signature).
> 
> Ah, thanks for the clarification (I somehow missed your reply).
> 
>> The reality:
>> 
>> * glibc: 
>> https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/sys/prctl.h;h=821aeefc1339b35210e8918ecfe9833ed2792626;hb=glibc-2.37#l42
>> 
>> * musl:
>> https://git.musl-libc.org/cgit/musl/tree/include/sys/prctl.h?h=v1.2.4#n180
>> 
>> Though there is a test in the kernel that does define its own 
>> prototype,
>> avoiding the issue: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/sched/cs_prctl_test.c?h=v6.3#n77
> 
> At least for glibc, it seems that there is a conversion to unsigned
> long:
> 
> https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/prctl.c#l28
> 
> unsigned long int arg2 = va_arg (arg, unsigned long int);
> 
> (does va_arg expand to an actual cast?)
> 
No, this not a conversion or a cast in the sense that I think you mean 
it. What happens in the situation discussed in this thread is the 
following (assuming the argument is passed via a register, which is 
typical for initial variadic arguments on 64-bit targets):

* User calls prctl(op, 0) on a 64-bit target.
* The second argument is an int.
* The compiler generates code to pass an int (32 bits) via a 64-bit 
register. The compiler is NOT required to clear the upper 32 bits of the 
register, so they might contain arbitrary junk in a general case.
* The prctl() implementation calls va_arg(arg, unsigned long) (as in 
your quote).
* The compiler extracts the full 64-bit value of the same register 
(which in our case might contain junk in the upper 32 bits).
* This extracted 64-bit value is then passed to the system call.

So...

> If the libc passes a 32-bit to a kernel ABI that expects 64-bit, I 
> think
> it's a user-space bug and not a kernel ABI issue.

... the problem happens not at the user/kernel boundary, but in prctl() 
call/implementation in user space. But yes, it's still a user-space bug 
and not a kernel ABI issue. The David's question, as I understand it, 
was whether we want to keep such buggy code that happens to pass junk 
failing with EINVAL in future kernels or not. If we do want to keep it 
failing, we can never assign any meaning to the upper 32 bits of the 
second prctl() argument for PR_SET_MDWE op.

Thanks,
Alexey
