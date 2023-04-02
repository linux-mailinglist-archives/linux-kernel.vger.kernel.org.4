Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233166D389D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjDBO4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDBO4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:56:34 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E284D6A7A;
        Sun,  2 Apr 2023 07:56:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vf8O9Kq_1680447388;
Received: from 192.168.31.179(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0Vf8O9Kq_1680447388)
          by smtp.aliyun-inc.com;
          Sun, 02 Apr 2023 22:56:29 +0800
Message-ID: <3cb9b024-d124-b13d-a80e-f5788b023065@linux.alibaba.com>
Date:   Sun, 2 Apr 2023 22:56:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/swap: fix swap_info_struct race between swapoff and
 get_swap_pages()
To:     Bagas Sanjaya <bagasdotme@gmail.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-stable@vger.kernel.org
References: <20230401221920.57986-1-rongwei.wang@linux.alibaba.com>
 <ZCmFExoOsho9pt+Q@debian.me>
Content-Language: en-US
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <ZCmFExoOsho9pt+Q@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/2/23 9:37 PM, Bagas Sanjaya wrote:
> On Sun, Apr 02, 2023 at 06:19:20AM +0800, Rongwei Wang wrote:
>> Without this modification, a core will wait (mostly)
> "Currently, a core will ..."
>
>> But, a worse consequence, panic also can be caused by
> "However, in the worst case, ..."
>
>> In this patch, we lock p->lock before calling
> "Lock p->lock before calling ..."
>
>> We also find this problem exists in stable 5.10.
> So, you claim that 5.15.y and 6.1.y aren't affected, right?

I think above both versions also be affected. I can check they next.

>
> Also, Cc: stable@vger.kernel.org on the SoB area (as pointed by kernel
> test robot [1].
Thanks, next version will to do.
>
> Thanks.
>
> [1]: https://lore.kernel.org/stable/ZCiuGEkyk%2F1Afisk@ec83ac1404bb/
>   
