Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A80717A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbjEaIb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjEaIb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:31:56 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E4411F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:31:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vjwun5s_1685521906;
Received: from 30.221.133.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vjwun5s_1685521906)
          by smtp.aliyun-inc.com;
          Wed, 31 May 2023 16:31:47 +0800
Message-ID: <997002c8-2008-3209-3542-2ac0bbda99c3@linux.alibaba.com>
Date:   Wed, 31 May 2023 16:31:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 4/5] erofs: unify inline/share xattr iterators for
 listxattr/getxattr
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20230531031330.3504-1-jefflexu@linux.alibaba.com>
 <20230531031330.3504-5-jefflexu@linux.alibaba.com>
 <349a1523-6d1c-9e96-d948-78dd4f2a209d@linux.alibaba.com>
 <d86cdf32-bc4d-bbab-d756-baef2b12cace@linux.alibaba.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <d86cdf32-bc4d-bbab-d756-baef2b12cace@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/31 16:16, Jingbo Xu wrote:
> 
> 
> On 5/31/23 2:57 PM, Gao Xiang wrote:
>>
>>
>> On 2023/5/31 11:13, Jingbo Xu wrote:
>>>    -static int inline_xattr_iter_begin(struct erofs_xattr_iter *it,
>>> -                   struct inode *inode)
>>> -{
>>> -    struct erofs_inode *const vi = EROFS_I(inode);
>>> -    unsigned int xattr_header_sz, inline_xattr_ofs;
>>> -
>>> -    xattr_header_sz = sizeof(struct erofs_xattr_ibody_header) +
>>> -              sizeof(u32) * vi->xattr_shared_count;
>>> -    if (xattr_header_sz >= vi->xattr_isize) {
>>> -        DBG_BUGON(xattr_header_sz > vi->xattr_isize);
>>> -        return -ENOATTR;
>>> -    }
> 
> In the original implementation, here when xattr_header_sz >=
> vi->xattr_isize, inline_xattr_iter_begin() will return -ENOATTR rather
> than a negative integer (i.e. vi->xattr_isize - xattr_header_sz).

Ah, sorry I misreaded that.

Thanks,
Gao Xiang
