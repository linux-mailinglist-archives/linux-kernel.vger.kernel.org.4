Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C3C627D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiKNMLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbiKNMLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:11:45 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BFB1007
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:11:43 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VUmziyc_1668427899;
Received: from 30.221.128.223(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VUmziyc_1668427899)
          by smtp.aliyun-inc.com;
          Mon, 14 Nov 2022 20:11:40 +0800
Message-ID: <55b07140-f7b9-6c25-acf0-93e9fbce0828@linux.alibaba.com>
Date:   Mon, 14 Nov 2022 20:11:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH] erofs: fix missing xas_retry() in fscache mode
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     xiang@kernel.org, chao@kernel.org, yinxin.x@bytedance.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20221111090813.72068-1-jefflexu@linux.alibaba.com>
 <575542.1668426273@warthog.procyon.org.uk>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <575542.1668426273@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thanks for the comment.

On 11/14/22 7:44 PM, David Howells wrote:
> Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> The xarray iteration only holds RCU
> 
> I would say "the RCU read lock".

Yeah, this looks clearer. I will update the commit message in v2 later.

> 
> Also, I think you've copied the code to which my dodgy-maths fix applies:
> 
> 	https://lore.kernel.org/linux-fsdevel/166757988611.950645.7626959069846893164.stgit@warthog.procyon.org.uk/
> 

Thanks for the kindly reminder. Yeah this code was ever copied from
libnetfs. In the scenario of erofs, currently req->start is always
aligned with folio size and erofs doesn't support large folio yet. Thus
req->start won't be inside the folio so far, and I think the current
code works well in the scenario of erofs, though the issue indeed exist
mathematically.

Actually I'm working on the support for large folio now, and the
completion routine of erofs in fscache mode will be refactored quite a
lot. I think this issue will be fixed along with the refactoring.

Thanks again for the suggestion :)

-- 
Thanks,
Jingbo
