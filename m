Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8096955EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBNB0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBNB0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:26:08 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4F912061;
        Mon, 13 Feb 2023 17:26:05 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VbdH-ho_1676337963;
Received: from 30.97.48.79(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VbdH-ho_1676337963)
          by smtp.aliyun-inc.com;
          Tue, 14 Feb 2023 09:26:03 +0800
Message-ID: <dd2ba3b9-8fab-ce3b-4f01-eadbb527f3bc@linux.alibaba.com>
Date:   Tue, 14 Feb 2023 09:26:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [GIT PULL] hotfixes for 6.2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230213140812.db63c7146ebc396691594b73@linux-foundation.org>
 <CAHk-=wiBrY+O-4=2mrbVyxR+hOqfdJ=Do6xoucfJ9_5az01L4Q@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAHk-=wiBrY+O-4=2mrbVyxR+hOqfdJ=Do6xoucfJ9_5az01L4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2023 6:19 AM, Linus Torvalds wrote:
> On Mon, Feb 13, 2023 at 2:08 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> Kuan-Ying Lee (1):
>>        mm/gup: add folio to list when folio_isolate_lru() succeed
> 
> Ugh. I really hate fixes like this.
> 
> The problem came from mis-understanding the return value of
> folio_isolate_lru(), and thinking that it was a boolean
> success/failure thing.
> 
> It wasn't, it was an integer "success/errno" thing, and the sense of
> the test was wrong. So the patch is
> 
> -       if (!folio_isolate_lru(folio))
> +       if (folio_isolate_lru(folio))
>                  continue;
> 
> but at no point was the code *clarified*.
> 
> Wouldn't it have been much better to write the new code to be
> 
>          if (folio_isolate_lru(folio) < 0)
>                  continue;
> 
> to actually make it clear that this is a "negative error return check".
> 
> I've pulled this, but I really think that when somebody notices that
> we had a silly bug because of a misunderstanding like this, it's not
> just that the bug should be fixed, the code should also be *clarified*
> at the same time.

Yes, agree, I need to check the return value of folio_isolate_lru() 
every time when looking at the code. I can help to create a patch to 
make it clear for all users.
