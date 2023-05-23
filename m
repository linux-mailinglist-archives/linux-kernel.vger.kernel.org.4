Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C0770D17B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbjEWCnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjEWCnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:43:16 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BE9CA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:43:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjI7rPy_1684809791;
Received: from 30.221.129.40(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VjI7rPy_1684809791)
          by smtp.aliyun-inc.com;
          Tue, 23 May 2023 10:43:12 +0800
Message-ID: <002ed0eb-1195-ce7e-06a0-d85155f67f04@linux.alibaba.com>
Date:   Tue, 23 May 2023 10:43:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] ocfs2: fix use-after-free when unmounting read-only
 filesystem
Content-Language: en-US
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Heming Zhao <heming.zhao@suse.com>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
References: <20230522102506.9205-1-lhenriques@suse.de>
 <a57047d6-8f57-3dde-f15f-b24f63d675cd@linux.alibaba.com>
 <87h6s47dxw.fsf@brahms.olymp> <20230522123623.eozzedrogy4oaj3w@p15>
 <87cz2s7b6m.fsf@brahms.olymp>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <87cz2s7b6m.fsf@brahms.olymp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/23 9:22 PM, Luís Henriques wrote:
> Heming Zhao <heming.zhao@suse.com> writes:
> 
>> On Mon, May 22, 2023 at 01:23:07PM +0100, Luís Henriques wrote:
>>> Joseph Qi <joseph.qi@linux.alibaba.com> writes:
>>>
>>>> On 5/22/23 6:25 PM, Luís Henriques wrote:
>>>>> It's trivial to trigger a use-after-free bug in the ocfs2 quotas code using
>>>>> fstest generic/452.  After mounting a filesystem as read-only, quotas are
>>>>
>>>> generic/452 is for testing ext4 mounted with dax and ro.
>>>> But ocfs2 doesn't support dax yet.
>>>
>>> Right, but I think it's still useful to run the 'generic' test-suite in a
>>> filesystem.  We can always find issues in the test itself or, in this
>>> case, a bug in the filesystem.
>>
>> It looks you did some special steps for 452. In my env, without changing
>> anything, I could pass this case successfully. 
> 
> No, I haven't changed anything to the test.  I just make sure there's a
> scratch device to be used.
> 
> Maybe you can try to enable KASAN to catch the UAF.  I've found the bug
> without KASAN (i.e. I saw a NULL pointer panic), but enabling it also
> detects the issue -- see below.
> 
> Cheers,

We'd better append panic dmesg to patch description as well.

Thanks,
Joseph
