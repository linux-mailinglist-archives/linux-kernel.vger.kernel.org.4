Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73C074D271
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjGJJ7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjGJJ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:58:56 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B59187
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:56:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vn1LFNN_1688983004;
Received: from 30.97.48.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vn1LFNN_1688983004)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 17:56:44 +0800
Message-ID: <ea709cd6-4f82-2c68-3fc6-1ff4291d2241@linux.alibaba.com>
Date:   Mon, 10 Jul 2023 17:56:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] erofs: fix to avoid infinite loop in
 z_erofs_do_read_page() when read page beyond EOF
To:     Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc:     chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230710093410.44071-1-guochunhai@vivo.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230710093410.44071-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/10 17:34, Chunhai Guo wrote:
> z_erofs_do_read_page() may loop infinitely due to the inappropriate
> truncation in the below statement. Since the offset is 64 bits and min_t()
> truncates the result to 32 bits. The solution is to replace unsigned int
> with a 64-bit type, such as erofs_off_t.
>      cur = end - min_t(unsigned int, offset + end - map->m_la, end);
> 
>      - For example:
>          - offset = 0x400160000
>          - end = 0x370
>          - map->m_la = 0x160370
>          - offset + end - map->m_la = 0x400000000
>          - offset + end - map->m_la = 0x00000000 (truncated as unsigned int)
>      - Expected result:
>          - cur = 0
>      - Actual result:
>          - cur = 0x370
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

I'd like to update the subject line manually to:

"erofs: avoid infinite loop in z_erofs_do_read_page() when reading beyond EOF"

since the original one is too long...

Otherwise it looks good to me,

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
