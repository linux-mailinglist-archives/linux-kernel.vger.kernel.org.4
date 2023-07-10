Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA43974CB51
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 06:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjGJEkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 00:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGJEkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:40:18 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCE9107
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 21:40:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vmxcfaa_1688964012;
Received: from 30.97.48.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vmxcfaa_1688964012)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 12:40:13 +0800
Message-ID: <555b749b-5102-7bc1-109f-15b16be406a2@linux.alibaba.com>
Date:   Mon, 10 Jul 2023 12:40:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] erofs: avoid unnecessary loops in
 z_erofs_pcluster_readmore() when read page beyond EOF
To:     Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org,
        chao@kernel.org
Cc:     huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230710042531.28761-1-guochunhai@vivo.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230710042531.28761-1-guochunhai@vivo.com>
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



On 2023/7/10 12:25, Chunhai Guo wrote:
> z_erofs_pcluster_readmore() may take a long time to loop when the page
> offset is large enough, which is unnecessary should be prevented.
> For example, when the following case is encountered, it will loop 4691368
> times, taking about 27 seconds.
>      - offset = 19217289215
>      - inode_size = 1442672
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

It looks good to me,

Fixes: 386292919c25 ("erofs: introduce readmore decompression strategy")
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
