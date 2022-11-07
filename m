Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395FF61E8CA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiKGDEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKGDEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:04:48 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46F660E6
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 19:04:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VU5LMBj_1667790281;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VU5LMBj_1667790281)
          by smtp.aliyun-inc.com;
          Mon, 07 Nov 2022 11:04:43 +0800
Date:   Mon, 7 Nov 2022 11:04:40 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, zhangwen@coolpad.com,
        Yue Hu <huyue2@coolpad.com>
Subject: Re: [PATCH v2] erofs: fix general protection fault when reading
 fragment
Message-ID: <Y2h1yAXZhoWHBF7M@B-P7TQMD6M-0146.local>
References: <20221021085325.25788-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021085325.25788-1-zbestahu@gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:53:25PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> As syzbot reported [1], the fragment feature sb flag is not set, so
> packed_inode != NULL needs to be checked in z_erofs_read_fragment().
> 
> [1] https://lore.kernel.org/all/0000000000002e7a8905eb841ddd@google.com/
> 
> Reported-by: syzbot+3faecbfd845a895c04cb@syzkaller.appspotmail.com
> Fixes: 08a0c9ef3e7e ("erofs: support on-disk compressed fragments data")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
> v2: fix return value to -EFSCURRUPTED (Xiang)
> 
>  fs/erofs/zdata.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index cce56dde135c..55c13cd6934b 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -659,6 +659,9 @@ static int z_erofs_read_fragment(struct inode *inode, erofs_off_t pos,
>  	u8 *src, *dst;
>  	unsigned int i, cnt;
>  
> +	if (!packed_inode)
> +		return -EFSCORRUPTED;
> +
>  	pos += EROFS_I(inode)->z_fragmentoff;
>  	for (i = 0; i < len; i += cnt) {
>  		cnt = min_t(unsigned int, len - i,
> -- 
> 2.17.1
