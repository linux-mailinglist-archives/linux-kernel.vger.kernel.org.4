Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6EC6B1C81
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCIHiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCIHh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:37:29 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5174DF71C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:37:02 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VdSUpid_1678347418;
Received: from 30.221.130.97(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VdSUpid_1678347418)
          by smtp.aliyun-inc.com;
          Thu, 09 Mar 2023 15:36:59 +0800
Message-ID: <bee8eb33-ec23-de1c-0340-b2cc290f4d1c@linux.alibaba.com>
Date:   Thu, 9 Mar 2023 15:36:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: erofs: use wrapper i_blocksize() in erofs_file_read_iter()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, zbestahu@gmail.com
Cc:     chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, xiang@kernel.org,
        zhangwen@coolpad.com
References: <20230306075527.1338-1-zbestahu@gmail.com>
 <20230309071515.25675-1-frank.li@vivo.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230309071515.25675-1-frank.li@vivo.com>
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



On 3/9/23 3:15 PM, Yangtao Li wrote:
>> @@ -380,7 +380,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>> 		if (bdev)
>> 			blksize_mask = bdev_logical_block_size(bdev) - 1;
>> 		else
>> -			blksize_mask = (1 << inode->i_blkbits) - 1;
>> +			blksize_mask = i_blocksize(inode) - 1;
> 
> Since the mask is to be obtained here, is it more appropriate to use GENMASK(inode->i_blkbits - 1, 0)?


FYI it seems that GENMASK macro is widely used in driver and arch code
base, while it's rarely used in fs, except for f2fs.

-- 
Thanks,
Jingbo
