Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D076CEFA2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjC2Qlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjC2Qln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:41:43 -0400
Received: from p3plwbeout17-01.prod.phx3.secureserver.net (p3plsmtp17-01-2.prod.phx3.secureserver.net [173.201.193.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98129A7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:41:41 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.144])
        by :WBEOUT: with ESMTP
        id hYrkp77KGWrMGhYrkpobIF; Wed, 29 Mar 2023 09:41:41 -0700
X-CMAE-Analysis: v=2.4 cv=AqsrYMxP c=1 sm=1 tr=0 ts=64246a45
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=k__wU0fu6RkA:10 a=4ao_m9BdAAAA:8
 a=A5gmrugz_5UGpGwqIrwA:9 a=QEXdDO2ut3YA:10 a=MsgbvsnFcLE8lbaOJhbn:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  hYrkp77KGWrMG
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp07.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1phYrm-0002Rj-6u; Wed, 29 Mar 2023 17:41:42 +0100
Message-ID: <e1df6748-d923-6ff5-9012-359cbfd8a718@squashfs.org.uk>
Date:   Wed, 29 Mar 2023 17:41:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] bio iter improvements
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Phillip Lougher <phillip.lougher@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <CAB3woddAP_6uOUJ4Yjj_PATme-CQao3p2JErBBtjtpzYxQejng@mail.gmail.com>
 <ZCMcbnlZchi3kWIL@moria.home.lan>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <ZCMcbnlZchi3kWIL@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfM+s2+e1DosdiwrYUVgGPgnCp1D5xyNuRbLTGuWth5A1cSnTuGkDlxbH5I8b3s1Bxs2f1YpQQNIsHqd0Oo9foMqf6Ag8CKAxRMKxIEO6TJZdEuERQp69
 H7SmJYL/j3ZzsF7CsoZcMsXtBqOizcYvFFqdCY1zUHXptizEuYaYzs+ERap1CDqP8AbR4WOo1kO3KwCBtjiBIY45AXkcZZEq05w4/V3et8cAoUO0IQwO9hHJ
 8rWAxEIkZD+lLK1QBILVMA==
X-Spam-Status: No, score=0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 17:57, Kent Overstreet wrote:
> On Tue, Mar 28, 2023 at 02:42:28PM +0100, Phillip Lougher wrote:
>> On Mon, Mar 27, 2023 at 7:02 PM Kent Overstreet
>> <kent.overstreet@linux.dev> wrote:
>>>
>>> Small patch series cleaning up/standardizing bio_for_each_segment_all(),
>>> which means we can use the same guts for bio_for_each_folio_all(),
>>> considerably simplifying that code.
>>>
>>> The squashfs maintainer will want to look at and test those changes,
>>> that code was doing some slightly tricky things. The rest was a pretty
>>> mechanical conversion.
>>
>> An eyeball of the changes doesn't bring up anything obviously wrong.
>>
>> I'll apply and do some tests.
>>
>> Phillip
>>
>> BTW please CC me on the cover letter as well as patch [1/2].
> 
> Will do.
> 
> There were some squashfs files that got missed, there's a fixup patch
> you'll want in this branch:
> 
> https://evilpiepirate.org/git/bcachefs.git/log/?h=bio_folio_iter

Patches applied, and I do see some issues in testing.

I'll reply on patch [1/2] because that's where the code is.

Phillip

