Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B1870DECD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjEWOLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbjEWOLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:11:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F04D19B0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F11B061924
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2AFC433D2;
        Tue, 23 May 2023 14:10:01 +0000 (UTC)
Date:   Tue, 23 May 2023 15:09:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     David Hildenbrand <david@redhat.com>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        peterx@redhat.com, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v2 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
Message-ID: <ZGzJNvKu8h5nDXsa@arm.com>
References: <20230517150321.2890206-1-revest@chromium.org>
 <20230517150321.2890206-4-revest@chromium.org>
 <bb08b91c-6c7b-a7a0-d4a7-68ddea46277f@redhat.com>
 <884d131bbc28ebfa0b729176e6415269@ispras.ru>
 <d7e3749c-a718-df94-92af-1cb0fecab772@redhat.com>
 <3c2e210b75bd56909322e8a3e5086d91@ispras.ru>
 <c63053b0-5797-504d-7896-c86271b64162@redhat.com>
 <ZGy6q7v+7jsXb1bV@arm.com>
 <f47d587fe5a6285f88191fbb13f367c7@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f47d587fe5a6285f88191fbb13f367c7@ispras.ru>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 04:25:45PM +0300, Alexey Izbyshev wrote:
> On 2023-05-23 16:07, Catalin Marinas wrote:
> > On Tue, May 23, 2023 at 11:12:37AM +0200, David Hildenbrand wrote:
> > > Also, how is passing "0"s to e.g., PR_GET_THP_DISABLE reliable? We
> > > need arg2
> > > -> arg5 to be 0. But wouldn't the following also just pass a 0 "int" ?
> > > 
> > > prctl(PR_GET_THP_DISABLE, 0, 0, 0, 0)
> > > 
> > > I'm easily confused by such (va_args) things, so sorry for the dummy
> > > questions.
> > 
> > Isn't the prctl() prototype in the user headers defined with the first
> > argument as int while the rest as unsigned long? At least from the man
> > page:
> > 
> > int prctl(int option, unsigned long arg2, unsigned long arg3,
> > 	  unsigned long arg4, unsigned long arg5);
> > 
> > So there are no va_args tricks (which confuse me as well).
> > 
> I have explicitly mentioned the problem with man pages in my response to
> David[1]. Quoting myself:
> 
> > This stuff *is* confusing, and note that Linux man pages don't even tell
> that prctl() is actually declared as a variadic function (and for
> ptrace() this is mentioned only in the notes, but not in its signature).

Ah, thanks for the clarification (I somehow missed your reply).

> The reality:
> 
> * glibc: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/sys/prctl.h;h=821aeefc1339b35210e8918ecfe9833ed2792626;hb=glibc-2.37#l42
> 
> * musl:
> https://git.musl-libc.org/cgit/musl/tree/include/sys/prctl.h?h=v1.2.4#n180
> 
> Though there is a test in the kernel that does define its own prototype,
> avoiding the issue: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/sched/cs_prctl_test.c?h=v6.3#n77

At least for glibc, it seems that there is a conversion to unsigned
long:

https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/prctl.c#l28

unsigned long int arg2 = va_arg (arg, unsigned long int);

(does va_arg expand to an actual cast?)

If the libc passes a 32-bit to a kernel ABI that expects 64-bit, I think
it's a user-space bug and not a kernel ABI issue.

-- 
Catalin
