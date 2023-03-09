Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2752B6B1D81
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCIILP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjCIIK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:10:29 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22CACC327
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:09:57 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VdSZMAo_1678349394;
Received: from 30.97.48.237(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdSZMAo_1678349394)
          by smtp.aliyun-inc.com;
          Thu, 09 Mar 2023 16:09:55 +0800
Message-ID: <bcecc8fe-8e98-fe2f-2a7c-2eac51cdbc9c@linux.alibaba.com>
Date:   Thu, 9 Mar 2023 16:09:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: erofs: use wrapper i_blocksize() in erofs_file_read_iter()
To:     Yangtao Li <frank.li@vivo.com>, zbestahu@gmail.com
Cc:     chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        xiang@kernel.org, zhangwen@coolpad.com
References: <bee8eb33-ec23-de1c-0340-b2cc290f4d1c@linux.alibaba.com>
 <20230309074225.29404-1-frank.li@vivo.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230309074225.29404-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/9 15:42, Yangtao Li wrote:
>> FYI it seems that GENMASK macro is widely used in driver and arch code base, while it's rarely used in fs, except for f2fs.
> 
> I think the following usage can be changed to bitmap api, just like in f2fs?
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c4ca1f7164734a1baf40d4ff1552172a07d4fc4d
> 
> fs/erofs/fscache.c:135:         unsigned long flags = 1 << NETFS_SREQ_ONDEMAND;
> fs/erofs/internal.h:250:#define SECTORS_PER_BLOCK       (1 << SECTORS_PER_BLOCK)
> fs/erofs/internal.h:252:#define EROFS_BLKSIZ            (1 << LOG_BLOCK_SIZE)
> fs/erofs/internal.h:354:        return (value >> bit) & ((1 << bits) - 1);
> fs/erofs/zmap.c:66:             ((1 << Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) - 1);
> fs/erofs/zmap.c:69:             m->clusterofs = 1 << vi->z_logical_clusterbits;
> fs/erofs/zmap.c:114:    const unsigned int lomask = (1 << lclusterbits) - 1;
> fs/erofs/zmap.c:141:    const unsigned int lomask = (1 << lclusterbits) - 1;
> fs/erofs/zmap.c:147:    if (1 << amortizedshift == 4)
> fs/erofs/zmap.c:149:    else if (1 << amortizedshift == 2 && lclusterbits == 12)
> fs/erofs/zmap.c:169:            m->clusterofs = 1 << lclusterbits;
> fs/erofs/zmap.c:291:    pos += lcn * (1 << amortizedshift);
> fs/erofs/zmap.c:409:            m->compressedblks = 1 << (lclusterbits - LOG_BLOCK_SIZE);
> fs/erofs/zmap.c:457:                              m->clusterofs != 1 << lclusterbits);
> fs/erofs/zmap.c:497:    endoff = ofs & ((1 << lclusterbits) - 1);
> fs/erofs/erofs_fs.h:120:        ((1 << (EROFS_I_DATALAYOUT_BIT + EROFS_I_DATALAYOUT_BITS)) - 1)
> fs/erofs/erofs_fs.h:279:#define Z_EROFS_ALL_COMPR_ALGS          ((1 << Z_EROFS_COMPRESSION_MAX) - 1)
> fs/erofs/erofs_fs.h:377:#define Z_EROFS_VLE_DI_PARTIAL_REF              (1 << 15)
> fs/erofs/erofs_fs.h:384:#define Z_EROFS_VLE_DI_D0_CBLKCNT               (1 << 11)
> fs/erofs/erofs_fs.h:427:                .h_clusterbits = 1 << Z_EROFS_FRAGMENT_INODE_BIT
> fs/erofs/data.c:379:                    blksize_mask = (1 << inode->i_blkbits) - 1;
> fs/erofs/zdata.c:133:#define Z_EROFS_PAGE_EIO                   (1 << 30)
> 

Is there some benefit to use these? BIT(1) vs 1 << 1? also almost all
filesystems rarely use such APIs honestly.

Thanks,
Gao Xiang

> Thx,
> Yangtao
