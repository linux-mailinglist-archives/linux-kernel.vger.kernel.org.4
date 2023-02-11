Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC71692CBD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 03:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBKCEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 21:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBKCEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 21:04:39 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F237358A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 18:04:37 -0800 (PST)
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 31B24agV025798;
        Sat, 11 Feb 2023 11:04:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Sat, 11 Feb 2023 11:04:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 31B24ZF8025794
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 11 Feb 2023 11:04:35 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <52c7d509-ba9e-a121-60c9-138d7ff3f667@I-love.SAKURA.ne.jp>
Date:   Sat, 11 Feb 2023 11:04:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] drivers/core: Replace lockdep_set_novalidate_class() with
 unique class keys
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>
References: <Y98FLlr7jkiFlV0k@rowland.harvard.edu>
 <827177aa-bb64-87a9-e1af-dfe070744045@I-love.SAKURA.ne.jp>
 <Y+Egr4MmqlE6G+mr@rowland.harvard.edu>
 <a7d0e143-1e68-5531-5c2e-1f853d794bc0@I-love.SAKURA.ne.jp>
 <Y+KOeJlvQMYAaheZ@rowland.harvard.edu>
 <a67e24eb-b68f-2abc-50af-ae4c2d4cdd95@I-love.SAKURA.ne.jp>
 <20230208080739.1649-1-hdanton@sina.com>
 <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
 <Y+O6toMmAKBSILMf@rowland.harvard.edu>
 <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
 <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y+RZ2RKVo9FNMgSe@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/09 11:26, Alan Stern wrote:
> On Thu, Feb 09, 2023 at 09:22:39AM +0900, Tetsuo Handa wrote:
>> On 2023/02/09 0:07, Alan Stern wrote:
>>> I'm happy to have people test this patch, but I do not want anybody 
>>> think that it is ready to be merged into the kernel.
>>
>> People (and build/test bots) won't test changes that are not proposed as
>> a formal patch with Signed-off-by: tag. As far as I am aware, bot is not
>> testing plain diff.
> 
> People _do_ test changes without a Signed-off-by: tag.  This happens 
> with my patches all the time; I don't put Signed-off-by: on a patch 
> until I think it is ready to be merged.  If you search through the email 
> archives, you'll find examples where people deliberately put a 
> "Not-yet-signed-off-by:" tag on a suggested patch.

That's a cultural difference. I know there are developers who use
"Not-yet-signed-off-by:" tag. But I'm not subscribed to mailing lists
which you are subscribed to. I'm subscribed to linux-security-module, but
I feel that it is quite rare that developers post changes as plain diff
without Signed-off-by: tag, for people prefer to see formal patches than
plain diff. I can see that only David Howells was using Not-yet-signed-off-by:
tag (like https://marc.info/?l=linux-security-module&m=130455572927447 ).

But even with Not-yet-signed-off-by: tag, his patches are formal patches
with description rather than plain diff. Unlike networking subsystem where
patches sometimes get merged before people have time to review/test,
developers in my subscribed mailing lists tend to propose v2, v3, v4...
patches with "Signed-off-by:" tag instead of posting plain diff.

> Syzbot also tests patches without a Signed-off-by: tag.  Here's a recent 
> example:
> 
> https://lore.kernel.org/linux-usb/Y9wh8dGK6oHSjJQl@rowland.harvard.edu/

That's completely different. syzbot is designed to test plain diff via
explict "#syz test:" directive. If "#syz test:" directive is not included,
syzbot does not test your diff.

Do you know any bot which automatically does testing plain diff? I don't know
when bots (or automated systems) test changes, but my guess is that a formal
patch with "Signed-off-by:" tag serves as the directive for bots to test
changes. Maybe we want a directive (e.g. "Test-requested-by:" tag) which
encourages/asks bots (or automated systems) to test patches but does not
want patches to get merged into permanent git trees.

>> I can update the patch if lockdep developers prefer rename over add.
>> What I worry is that lockdep developers do not permit static_obj() being
>> used by non-lockdep code.
> 
> I worry about that too, and I hoped that Peter Z. would comment on it. 
> But if they don't want the function to be exported, they ought to be 
> able to suggest an alternative.

Then, at least we can start without "EXPORT_SYMBOL_GPL(lockdep_static_obj);"
line, for drivers/base/core.c cannot be built as a module.

Since there are already several locations which directly use e.g. _stext symbol,
we would simply duplicate static_obj() into drivers/base/core.c if Peter does
not want to make static_obj() visible to built-in code.



Anyway, despite being posted as a formal patch, it seems that nobody was
interested in manual testing. As far as I tried "#syz test" this patch against
https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174 , syzbot kernel
was able to boot. Therefore, I think it is OK to stay for a week whether
this patch causes too frequent crashes to continue using linux-next.git .

Please propose a formal patch to Peter with your "Signed-off-by:" tag...

