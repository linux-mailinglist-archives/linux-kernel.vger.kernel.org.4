Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373416B1D50
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCIIHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCIIHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:07:09 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE88761302
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:07:07 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VdSijHi_1678349224;
Received: from 30.97.48.237(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdSijHi_1678349224)
          by smtp.aliyun-inc.com;
          Thu, 09 Mar 2023 16:07:05 +0800
Message-ID: <0261de31-e98b-85cd-80de-96af5a76e15c@linux.alibaba.com>
Date:   Thu, 9 Mar 2023 16:07:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: erofs: use wrapper i_blocksize() in erofs_file_read_iter()
To:     Yue Hu <zbestahu@gmail.com>, Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        xiang@kernel.org, zhangwen@coolpad.com
References: <20230306075527.1338-1-zbestahu@gmail.com>
 <20230309071515.25675-1-frank.li@vivo.com>
 <20230309153709.00003876.zbestahu@gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230309153709.00003876.zbestahu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 2023/3/9 15:37, Yue Hu wrote:
> On Thu,  9 Mar 2023 15:15:15 +0800
> Yangtao Li <frank.li@vivo.com> wrote:
> 
>>> @@ -380,7 +380,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>> 		if (bdev)
>>> 			blksize_mask = bdev_logical_block_size(bdev) - 1;
>>> 		else
>>> -			blksize_mask = (1 << inode->i_blkbits) - 1;
>>> +			blksize_mask = i_blocksize(inode) - 1;
>>
>> Since the mask is to be obtained here, is it more appropriate to use GENMASK(inode->i_blkbits - 1, 0)?
> 
> It should be another change independently to this patch. rt?

I'd suggest that keep to use (i_blocksize(inode) - 1) here, for example:

https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/tree/fs/gfs2/bmap.c#n963

Thanks,
Gao Xiang

> 
>>
>> Thx,
>> Yangtao
