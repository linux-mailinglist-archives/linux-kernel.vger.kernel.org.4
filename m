Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711E06F21BB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 02:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347139AbjD2Auh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 20:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjD2Auf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 20:50:35 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0271FDC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 17:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1682729430;
        bh=uXmLRJCXUMtgrh3QRYxDEF/Jvand7ry+DuudTApOWts=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ej8/3XYPAkMI7Y2jzO9bKsitNFVlbfhoY/xuL4oKQ66EDzv7nNk7idbvi+Jyb7XgR
         taYYTAF6YhEp3kpk1z5ovI4uX3Q+zfG686Vcv1VfCHDvBnsA66H906Zs5Rw0uzKngo
         izPUUYqKw8KFzU/whxzWGrknM69t3Qx40oc+44ajY+XZEa3+GF1V+8QnGU6Oip8Si5
         /UxBxrhKKgqAwyAshotFY5AqdW9bRtZytOH0oMKEkLLitZZ8pSP48fBc54nFz7p9Sq
         ZrSgURuwtElxhSiT0nMna5GtMH2Xfhehrdj1w8QFaOiTAkTew/K+bHvpGRDTBdsZEh
         2IZnKhGL5tG0w==
Received: from [10.1.0.205] (192-222-203-73.qc.cable.ebox.net [192.222.203.73])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Q7W9K5C4zzxFm;
        Fri, 28 Apr 2023 20:50:29 -0400 (EDT)
Message-ID: <3f452ee7-6430-e7a9-590b-b211ad4c7ea5@efficios.com>
Date:   Fri, 28 Apr 2023 20:50:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] scheduler changes for v6.4
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
References: <ZErgOfOLrBwluTbd@gmail.com>
 <CAHk-=wj-t1N7a2dH=y7MCjctk_Zw77C8_V6cfS-UC7f3jXAF6g@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAHk-=wj-t1N7a2dH=y7MCjctk_Zw77C8_V6cfS-UC7f3jXAF6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-28 18:02, Linus Torvalds wrote:
> On Thu, Apr 27, 2023 at 1:51 PM Ingo Molnar <mingo@kernel.org> wrote:
>>
>>   - Fix performance regression introduced by mm_cid
> 
> This causes a conflict with commit b20b0368c614 ("mm: fix memory leak
> on mm_init error handling") that came in through the MM tree.
> 
> That conflict is trivial to resolve, and I did so.
> 
> Except I also checked my resolution with what was going on in
> linux-next, and it's different.
> 
> I'm pretty sure the resolution in linux-next is wrong, but I thought
> I'd mention this, since clearly this wasn't caught in linux-next.
> 
> Or maybe it's me that did it wrong, but hey, that couldn't actually
> happen, could it?

I've reviewed both merge commits (c79e0731da from next-20230428 and
586b222d74 from master) and I confirm that your conflict resolution
is correct. The one in next was wrong.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

