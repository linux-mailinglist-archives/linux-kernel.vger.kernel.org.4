Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A406F8ADD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjEEV0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjEEV0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:26:32 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC8955B4
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 14:26:19 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id E0FC540755F6;
        Fri,  5 May 2023 21:26:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E0FC540755F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1683321971;
        bh=YzTjDO5OYKAUOnpUxl6IW3qFJylfZRNxVkvW9/ylYJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZDhE6Ub1nGbMI4arj7yjTmzX4qpw3obYRdW2873rLTzGGzBbJShhyxaggRkBf6JX4
         zcC3NtlcF8oiE8jLNznO9uAG8jC5RznwvHz3S11aH45UC9n2M0DrNHlYe4cvJ5cYtF
         4V9TDtNj9orBUERtUCEoVv0Btn8h13rvp8hYBX/o=
MIME-Version: 1.0
Date:   Sat, 06 May 2023 00:26:10 +0300
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        nd@arm.com, broonie@kernel.org, szabolcs.nagy@arm.com
Subject: Re: [PATCH 4/4] kselftest: vm: Add tests for no-inherit
 memory-deny-write-execute
In-Reply-To: <CABRcYmKXrPE0oP9R=qsn=mL3Nwm_mVqT-r-TvOvowTdiuYU--A@mail.gmail.com>
References: <20230504170942.822147-1-revest@chromium.org>
 <20230504170942.822147-5-revest@chromium.org>
 <66900d0ad42797a55259061f757beece@ispras.ru>
 <CABRcYmKXrPE0oP9R=qsn=mL3Nwm_mVqT-r-TvOvowTdiuYU--A@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <3a38319a3b241e578729ffa5484ad24b@ispras.ru>
X-Sender: izbyshev@ispras.ru
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-05 19:42, Florent Revest wrote:
> On Thu, May 4, 2023 at 10:30 PM Alexey Izbyshev <izbyshev@ispras.ru> 
> wrote:
>> 
>> On 2023-05-04 20:09, Florent Revest wrote:
>> > Add some tests to cover the new PR_MDWE_NO_INHERIT flag of the
>> > PR_SET_MDWE prctl.
>> >
>> > Signed-off-by: Florent Revest <revest@chromium.org>
>> > ---
>> >  tools/testing/selftests/mm/mdwe_test.c | 95 ++++++++++++++++++++++++--
>> >  1 file changed, 89 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/tools/testing/selftests/mm/mdwe_test.c
>> > b/tools/testing/selftests/mm/mdwe_test.c
>> > index 91aa9c3099e7..9f08ed1b99ae 100644
>> > --- a/tools/testing/selftests/mm/mdwe_test.c
>> > +++ b/tools/testing/selftests/mm/mdwe_test.c
>> > @@ -22,6 +22,8 @@
>> >
>> >  TEST(prctl_flags)
>> >  {
>> > +     EXPECT_LT(prctl(PR_SET_MDWE, PR_MDWE_NO_INHERIT, 0L, 0L, 7L), 0);
>> > +
>> 
>> PR_MDWE_NO_INHERIT is defined to an int constant, so passing it to
>> prctl() without a cast to long or similar may produce wrong code on
>> 64-bit targets (ABIs typically don't require the compiler to clear the
>> upper 32 bits of a 64-bit register when passing a 32-bit argument, so
>> va_arg(arg, unsigned long) in prctl() implementation might get junk).
> 
> Ah, good catch Alexey! :)
> 
>> Arguably, defining PR_MDWE_* to plain int constants is a bug, or at
>> least a footgun for users of uapi headers.
> 
> As part of the next version of this series, I'm happy to:
> 1- change the existing PR_MDWE_REFUSE_EXEC_GAIN to 1UL
> 2- introduce PR_MDWE_NO_INHERIT as 2UL
> 
Yes, I think it's the right thing to do. I suggest to spell them as (1UL 
<< 0), etc. for consistency with all other unsigned long flags in the 
header.

> But I'm surprised that most of the macros in
> include/uapi/linux/prctl.h are the same sort of footguns already ?
> Hasn't it been an issue for other prctls yet ?

Yes, they are. I'm not aware of a public discussion of this specific 
issue, but note that at least for some prctl() options the kernel 
doesn't care about upper bits because arguments are truncated before 
doing anything else with them (e.g. for PR_SCHED_CORE raw prctl() 
arguments are implicitly converted to what sched_core_share_pid() 
expects). Also, actually getting junk in the upper bits might not always 
be easy (e.g. on x86-64 all or almost all instructions with r32 
destination operand clear the upper bits). Unfortunately, I don't have a 
better answer than this.

Alexey
