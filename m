Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE11668AA8A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjBDOVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDOVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:21:39 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F7B1C338;
        Sat,  4 Feb 2023 06:21:34 -0800 (PST)
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 314ELSA5007186;
        Sat, 4 Feb 2023 23:21:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sat, 04 Feb 2023 23:21:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 314ELSp5007183
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 4 Feb 2023 23:21:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
Date:   Sat, 4 Feb 2023 23:21:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Converting dev->mutex into dev->spinlock ?
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
 <Y95h7Vop9t5Li0HD@kroah.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y95h7Vop9t5Li0HD@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/04 22:47, Greg Kroah-Hartman wrote:
> On Sat, Feb 04, 2023 at 10:32:11PM +0900, Tetsuo Handa wrote:
>> Hello.
>>
>> There is a long-standing deadlock problem in driver core code caused by
>> "struct device"->mutex being marked as "do not apply lockdep checks".
> 
> The marking of a lock does not cause a deadlock problem, so what do you
> mean exactly by this?  Where is the actual deadlock?

A few of examples:

  https://syzkaller.appspot.com/bug?extid=2d6ac90723742279e101
  https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174

> 
>> We can make this deadlock visible by applying [1], and we can confirm that
>> there is a deadlock problem that I think needs to be addressed in core code [2].
> 
> Any reason why you didn't cc: us on these patches?

We can't apply this "drivers/core: Remove lockdep_set_novalidate_class() usage" patch
until we fix all lockdep warnings that happen during the boot stage; otherwise syzbot
testing can't work which is more painful than applying this patch now.

Therefore, I locally tested this patch (in order not to be applied now). And I got
a lockdep warning on the perf_event code. I got next lockdep warning on the driver core
code when I tried a fix for the perf_event code suggested by Peter Zijlstra. Since Peter
confirmed that this is a problem that led to commit 1704f47b50b5 ("lockdep: Add novalidate
class for dev->mutex conversion"), this time I'm reporting this problem to you (so that
you can propose a fix for the driver core code).

