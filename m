Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E906C3083
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCULhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCULhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:37:52 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237A9421C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:37:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VeMvco6_1679398665;
Received: from 30.240.99.2(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VeMvco6_1679398665)
          by smtp.aliyun-inc.com;
          Tue, 21 Mar 2023 19:37:46 +0800
Message-ID: <4102154a-1e49-54d9-b18f-c41da84e643e@linux.alibaba.com>
Date:   Tue, 21 Mar 2023 19:37:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/6] tmpfs: add the option to disable swap
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, linux-mm@kvack.org, p.raghav@samsung.com,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230309230545.2930737-1-mcgrof@kernel.org>
 <e1de614b-25e1-5c21-933a-880412ac7421@linux.alibaba.com>
 <ZBdxWsrYfPgBG6NX@bombadil.infradead.org>
 <edb78eea-a9a2-5c62-d203-6f2be39757d2@linux.alibaba.com>
 <ZBjR15Tr1o98crup@bombadil.infradead.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <ZBjR15Tr1o98crup@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/21 上午5:36, Luis Chamberlain 写道:
> On Mon, Mar 20, 2023 at 07:14:22PM +0800, haoxin wrote:
>> 在 2023/3/20 上午4:32, Luis Chamberlain 写道:
>>> On Tue, Mar 14, 2023 at 10:46:28AM +0800, haoxin wrote:
>>>> All these series looks good to me and i do some test on my virtual machine
>>>> it works well.
>>>>
>>>> so please add Tested-by: Xin Hao<xhao@linux.alibaba.com>  .
>>>>
>>>> just one question, if tmpfs pagecache occupies a large amount of memory, how
>>>> can we ensure successful memory reclamation in case of memory shortage?
>>> If you're disabling swap then you know the only thing you can do is
>>> unmount if you want to help the VM, otherwise the pressure is just
>>> greater for the VM.
>> Un, what i mean is can we add a priority so that this type of pagecache is
>> reclaimed last ?
> That seems to be a classifier request for something much less aggressive
> than mapping_set_unevictable(). My patches *prior* to using mapping_set_unevictable()
> are I think closer to what it seems you want, but as noted before by
> folks, that also puts unecessary stress on the VM because just fail
> reclaim on our writepage().
>
>> Instead of just setting the parameter noswap to make it unreclaimed, because
>> if such pagecache which occupy big part of memory which can not be
>> reclaimed, it will cause OOM.
> You can't simultaneously retain possession of a cake and eat it, too,
> once you eat it, its gone and noswap eats the cake because of the
> suggestion / decision to follow through with mapping_set_unevictable().
>
> It sounds like you want to make mapping_set_unevictable() optional and
> deal with the possible stress incurred writepage() failing?
Yes, Just a personal idea, in any way, the current patch is an excellent 
implementation,  thank you very much.
>   Not quite
> sure what else to recommend here.
>
>    Luis
