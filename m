Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15FA6C09B8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 05:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCTEfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 00:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCTEe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 00:34:59 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676611A646
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 21:34:53 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32K4YpbX067261;
        Mon, 20 Mar 2023 13:34:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Mon, 20 Mar 2023 13:34:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32K4Yp5K067258
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Mar 2023 13:34:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6b5de584-b31f-9045-a438-b42da350326b@I-love.SAKURA.ne.jp>
Date:   Mon, 20 Mar 2023 13:34:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Input: iforce - Fix exception handling in
 iforce_usb_probe()
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <521b63e1-9470-58ef-599e-50a1846e5380@web.de> <ZBffPEIWcmYcaXR3@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZBffPEIWcmYcaXR3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/03/20 13:21, Dmitry Torokhov wrote:
> On Sun, Mar 19, 2023 at 07:03:00PM +0100, Markus Elfring wrote:
>> Date: Sun, 19 Mar 2023 18:50:51 +0100
>>
>> The label “fail” was used to jump to another pointer check despite of
>> the detail in the implementation of the function “iforce_usb_probe”
>> that it was determined already that a corresponding variable contained
>> still a null pointer.
>>
>> 1. Use more appropriate labels instead.
>>
>> 2. Reorder jump targets at the end.
>>
>> 3. Delete a redundant check.
>>
>>
>> This issue was detected by using the Coccinelle software.
> 
> I am sorry, but I do not understand what the actual issue is. The fact
> that come Coccinelle script complains is not enough to change the code.
> 

Right. There is no issue with the code, for usb_free_urb(NULL) is a no-op.
Proposing as a cleanup, without Fixes: tags, could be possible though.

