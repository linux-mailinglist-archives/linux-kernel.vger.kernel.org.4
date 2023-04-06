Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BB06D8DF3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 05:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjDFDTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 23:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjDFDT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 23:19:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002FC1FE7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 20:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F43B62AD2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD653C433EF;
        Thu,  6 Apr 2023 03:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680751167;
        bh=WBcX+ALJsZXJgSLglT3gOMa4spLs5SiX6NUnA41xE3M=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=JWpjopWcb1gxv3B+3Tu/v3M8rDkH6AFSw5XcP2WFtSXRie2EBRGXRlb0vD+OXDfPQ
         xQrB7CCfz+3UTgtE86XCkw7n7VH/g3t3P9cee2R56xUp248EAxdvU0Fb5Ps0gxwBHn
         QBgXNcwNZyPOEeIWfiqmJ9cB2a4PUq/cwb+I6tWi0aFGD1st4bgSTzS4rW0oDoZYXb
         gnG43wDFaOFpwZ9lj6xx38qQHBQAYdx01CUclXGOAZPgHT+/VCeaqRvz/wNyIoHbsN
         vzCRPQpn7EgrEkAF5hCuavDa7xaZgnZn9mz5opKs2QffgAYy7TAPu7QUmjTjIobmF1
         8/kclKZQnVwJQ==
Date:   Wed, 05 Apr 2023 20:19:26 -0700
From:   Kees Cook <kees@kernel.org>
To:     Andrei Vagin <avagin@gmail.com>, Kees Cook <keescook@chromium.org>
CC:     Andrei Vagin <avagin@google.com>, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/6_v5_RESEND=5D_seccomp=3A_add_?= =?US-ASCII?Q?the_synchronous_mode_for_seccomp=5Funotify?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CANaxB-wjNAuFGcNErnfz3gy1TG=W6XoJSb0hQM=TtB25YoGSqw@mail.gmail.com>
References: <20230308073201.3102738-1-avagin@google.com> <20230327102715.GA7701@hirez.programming.kicks-ass.net> <CANaxB-wjNAuFGcNErnfz3gy1TG=W6XoJSb0hQM=TtB25YoGSqw@mail.gmail.com>
Message-ID: <C7D9CFE1-0FEF-41F1-81CC-E3D5C4E61213@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 3, 2023 11:32:00 AM PDT, Andrei Vagin <avagin@gmail=2Ecom> wrote:
>On Mon, Mar 27, 2023 at 3:27=E2=80=AFAM Peter Zijlstra <peterz@infradead=
=2Eorg> wrote:
>>
>> On Tue, Mar 07, 2023 at 11:31:55PM -0800, Andrei Vagin wrote:
>>
>> > Kees is ready to take this patch set, but wants to get Acks from the
>> > sched folks=2E
>> >
>>
>> > Andrei Vagin (4):
>> >   seccomp: don't use semaphore and wait_queue together
>> >   sched: add a few helpers to wake up tasks on the current cpu
>> >   seccomp: add the synchronous mode for seccomp_unotify
>> >   selftest/seccomp: add a new test for the sync mode of
>> >     seccomp_user_notify
>> >
>> > Peter Oskolkov (1):
>> >   sched: add WF_CURRENT_CPU and externise ttwu
>>
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead=2Eorg>
>
>Kees,
>
>Could you look at this patch set? You wrote to one of the previous
>versions that you are ready to take it if sched maintainers approve it=2E
>Here is no major changes from that moment=2E The sched-related part has
>been cleaned up according with Peter's comments, and I moved the perf
>test to the perf tool=2E

Hi!

Yes, thanks for keeping this going! I'm catching up after some vacation, b=
ut this is on my TODO list=2E :)

-Kees


--=20
Kees Cook
