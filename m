Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62A5747EAE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjGEHz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGEHzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:55:52 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8476E6B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:55:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VmfoNa4_1688543745;
Received: from 30.97.48.243(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VmfoNa4_1688543745)
          by smtp.aliyun-inc.com;
          Wed, 05 Jul 2023 15:55:46 +0800
Message-ID: <afa51f3e-5ac8-86bd-364e-f55706c40470@linux.alibaba.com>
Date:   Wed, 5 Jul 2023 15:55:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/2] erofs: boost negative xattr lookup with bloom
 filter
To:     Alexander Larsson <alexl@redhat.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20230705070427.92579-1-jefflexu@linux.alibaba.com>
 <20230705070427.92579-3-jefflexu@linux.alibaba.com>
 <CAL7ro1GuPZE8ek=uvfHEqGFrbbt=NO1=oO8_B-dVBF9go=StSg@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAL7ro1GuPZE8ek=uvfHEqGFrbbt=NO1=oO8_B-dVBF9go=StSg@mail.gmail.com>
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



On 2023/7/5 15:44, Alexander Larsson wrote:
> On Wed, Jul 5, 2023 at 9:04 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

...

>> +       if (erofs_sb_has_xattr_filter(sbi)) {
> 
> As I said in my other mail. I would really like this to just always do
> the filter check. It should be safe as older fs:es have zero in place
> here, and doing this allows me to create composefs images with the
> bloom filters that also work with older kernels.

As my previous email, this flag is on-disk compatible which means old
unsupported kernels will just ignore this and go on mounting.

But this flag indicates a new on-disk feature in the image anyway,
users could know if an image uses the new feature rather than seek to
individual inodes.

Does it sound reasonable or some other consideration?

Thanks,
Gao Xiang
