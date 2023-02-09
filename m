Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF52668FCBA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjBIBuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBIBuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:50:18 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A900F25286
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 17:50:16 -0800 (PST)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3191oDnK061127;
        Thu, 9 Feb 2023 10:50:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Thu, 09 Feb 2023 10:50:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3191oDG3061120
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 9 Feb 2023 10:50:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1e3085b0-c19e-a585-60de-5f5db5261920@I-love.SAKURA.ne.jp>
Date:   Thu, 9 Feb 2023 10:50:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drivers/core: Replace lockdep_set_novalidate_class() with
 unique class keys
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
References: <Y965qEg0Re2QoQ7Q@rowland.harvard.edu>
 <CAHk-=wjoy=hObTmyRb9ttApjndt0LfqAfv71Cz+hEGrT0cLN+A@mail.gmail.com>
 <Y98FLlr7jkiFlV0k@rowland.harvard.edu>
 <827177aa-bb64-87a9-e1af-dfe070744045@I-love.SAKURA.ne.jp>
 <Y+Egr4MmqlE6G+mr@rowland.harvard.edu>
 <a7d0e143-1e68-5531-5c2e-1f853d794bc0@I-love.SAKURA.ne.jp>
 <Y+KOeJlvQMYAaheZ@rowland.harvard.edu>
 <a67e24eb-b68f-2abc-50af-ae4c2d4cdd95@I-love.SAKURA.ne.jp>
 <20230208080739.1649-1-hdanton@sina.com>
 <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
 <Y+O6toMmAKBSILMf@rowland.harvard.edu>
 <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
 <CAHk-=wg_E5qAOTtZ6BSJph1zDN7Unzw_ct8wK1pr+E8HTnooRw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wg_E5qAOTtZ6BSJph1zDN7Unzw_ct8wK1pr+E8HTnooRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/09 9:46, Linus Torvalds wrote:
> On Wed, Feb 8, 2023 at 4:23 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Did I misuse the Co-developed-by: tag? I added your Signed-off-by: tag because
>> https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
>> states that "every Co-developed-by: must be immediately followed by a Signed-off-by:
>> of the associated co-author."
> 
> That doesn't mean that *You* can add a Signed-off-by:
> 
> Nobody can certify sign-off for anybody else. Read the sign-off rules:
> you can add your *own* sign-off if the rules hold, but you can't sign
> off for somebody else.
> 
> The "Co-developed-by: must be immediately followed by a
> Signed-off-by:" thing only means that if there are multiple
> developers, then ALL DEVELOPERS MUST SIGN OFF.
> 
> It absolutely does *NOT* mean that you adding a Co-developed-by means
> that you then add a Signed-off-by.
> 
> That's like faking somebody else's signature on some paperwork. Never
> do that either, and it's hopefully obvious why.

OK. Then, how to handle a case where a developer suggested a diff but
he/she does not propose that diff as a formal patch?

Hillf is suggesting diffs for many bugs (an example is
https://syzkaller.appspot.com/bug?id=ee93abc9a483645fc0914811af9c12da355a2e3e ),
and some of diffs look reasonable/correct, but Hillf never tries to propose as
a formal patch, and that diff is left forgotten and that bug remains unfixed.

I don't want to steal Hillf's effort. But given that I can't add Co-developed-by:
and Signed-off-by: on behalf of Hillf, how can I propose a formal patch in a way
that preserves Hillf's effort? Is Suggested-by: suitable for this case?

