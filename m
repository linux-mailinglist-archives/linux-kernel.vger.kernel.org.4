Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B434F5BCD78
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiISNoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiISNok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:44:40 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFF15F61
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:44:37 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28JDiI3U060788;
        Mon, 19 Sep 2022 22:44:19 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Mon, 19 Sep 2022 22:44:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28JDiIvT060785
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Sep 2022 22:44:18 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <83fc4085-60cc-fdc6-43ba-ac701cfde80c@I-love.SAKURA.ne.jp>
Date:   Mon, 19 Sep 2022 22:44:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] lockdep: report name and key when look_up_lock_class()
 got confused
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <55111c45-0f8f-c6f9-640c-6919939b77dd@I-love.SAKURA.ne.jp>
 <YydkEtcVc0GtCizz@boqun-archlinux>
 <bd99391e-f787-efe9-5ec6-3c6dc4c587b0@I-love.SAKURA.ne.jp>
 <YyhI93taOenZMHrY@hirez.programming.kicks-ass.net>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YyhI93taOenZMHrY@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/09/19 19:48, Peter Zijlstra wrote:
> On Mon, Sep 19, 2022 at 09:52:13AM +0900, Tetsuo Handa wrote:
>> Printing this information will be helpful.
>>
>>   ------------[ cut here ]------------
>>   Looking for class "l2tp_sock" with key l2tp_socket_class, but found a different class "slock-AF_INET6" with the same key
>>   WARNING: CPU: 1 PID: 14195 at kernel/locking/lockdep.c:940 look_up_lock_class+0xcc/0x140
>>   Modules linked in:
>>   CPU: 1 PID: 14195 Comm: a.out Not tainted 6.0.0-rc6-dirty #863
>>   Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>>   RIP: 0010:look_up_lock_class+0xcc/0x140
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> Urgh, you hitting that WARN enough times to want to improve it seems to
> suggest your machine is quite sick.

My machine is not sick at all. I just wanted this hint for debugging
https://syzkaller.appspot.com/bug?extid=94cc2a66fc228b23f360 .

In a world of debugging without vmcore, printing as much hint as possible is
important. Therefore, WARN_ONCE() is more appreciated than WARN_ON_ONCE().

> 
> Anyway, patch is ok I suppose.

Thank you. Please send this patch and
https://lkml.kernel.org/r/9f42e8a5-f809-3f2c-0fda-b7657bc94eb3@I-love.SAKURA.ne.jp
via your tree.

