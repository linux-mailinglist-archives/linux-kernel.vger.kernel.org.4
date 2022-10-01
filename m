Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACFC5F1A70
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJAHCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJAHCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:02:14 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FE8126B44
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 00:02:13 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v4so5842523pgi.10
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 00:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=UZi6urliHkT7uuCCwMJIEdfiFKYnQrKuVx0cI+vnDEU=;
        b=jj0QTDpgDeZfGbcn6HGHaPXlP88xl40rG7Pv4j42eH9P9CfKS18A/RSUi7ExdFCu37
         CPbHmiQ23xzPkU2WKU0+1760AmANnC0w052wPTKM0i1n+DQdxeU2G01si0Ql7OaMuWoe
         T9mOR3PK4ShjtJAlj6fzSzqPu+Qe4mrPb124p8mLQZA6L0tbb49F2E1J0C1ZXTx51OyE
         8BjJnaFLFYhwQIoeAIERiZrq6DJ8FcViu0Jor6jnsYh1VkpsByCAYu0WraPm3E60jseB
         emkBG78Wy5SQmcXIlmwaeCxP2KFBDShazS8b5Cgu5Y5oHEM9m9Zq+0SWZFSARrOpcGH7
         qD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=UZi6urliHkT7uuCCwMJIEdfiFKYnQrKuVx0cI+vnDEU=;
        b=JlIvUIr13M2o5R/tDZEIw6MIoFTjPXX19G85H79kKHqs5+fXJp5n81CI2KUPIN8HVQ
         htzoG05gjJiEjMgqodAuLZatnLU/F4Kf0tovdvs/fKHkdXEzpOjtDcV1oFrxRwoWg7Yw
         rb5QbpqxK62lU/bkiOpVPMjMd0X4MRzixsLzy7ERa3qhT/l05TLg6wju37FJJlAMU/wj
         0aTHYCgRvdpjfit1qQuxb7WJw2BWeAZAgg0QLGdnVZnQI09CycO3CpB5kFVXgJj1nnAW
         ubWhepc7JpXTt81sdjnzo2O4ysZi4fwi9sAaH14Cme7CCAeJiGhmFAMA8aK+vpxyv+B7
         /XXQ==
X-Gm-Message-State: ACrzQf1fuGS1LeTGv8NEmM7bvEEQ2d57Xnhfl6+UjsI41e3KUYnOLOp3
        OqdVFEsCQysaqU1V97rUj/MVTjuWF2Y=
X-Google-Smtp-Source: AMsMyM6NekkCQ+SPiH7FgzScGB7FRte1AggwIPEioxwjLKRo72tVf8xBr2hlsYj7VC29MD0zXyl0/A==
X-Received: by 2002:a05:6a00:140d:b0:52a:d561:d991 with SMTP id l13-20020a056a00140d00b0052ad561d991mr12604792pfu.46.1664607732558;
        Sat, 01 Oct 2022 00:02:12 -0700 (PDT)
Received: from localhost.localdomain ([171.78.165.127])
        by smtp.googlemail.com with ESMTPSA id 9-20020a631349000000b00429b6e6c539sm2764473pgt.61.2022.10.01.00.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 00:02:12 -0700 (PDT)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abdun Nihaal <abdun.nihaal@gmail.com>,
        syzbot+b892240eac461e488d51@syzkaller.appspotmail.com
Subject: [PATCH] fs/ntfs3: Fix slab-out-of-bounds read in ntfs_trim_fs
Date:   Sat,  1 Oct 2022 12:30:24 +0530
Message-Id: <20221001070024.1366018-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reports an out of bound access in ntfs_trim_fs.
The cause of this is using a loop termination condition that compares
window index (iw) with wnd->nbits instead of wnd->nwnd, due to which the
index used for wnd->free_bits exceeds the size of the array allocated.

Fix the loop condition.

Fixes: 3f3b442b5ad2 ("fs/ntfs3: Add bitmap")
Link: https://syzkaller.appspot.com/bug?extid=b892240eac461e488d51
Reported-by: syzbot+b892240eac461e488d51@syzkaller.appspotmail.com
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 fs/ntfs3/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 1675c9a69788..629c1ee97268 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -1424,7 +1424,7 @@ int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range)
 
 	down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
 
-	for (; iw < wnd->nbits; iw++, wbit = 0) {
+	for (; iw < wnd->nwnd; iw++, wbit = 0) {
 		CLST lcn_wnd = iw * wbits;
 		struct buffer_head *bh;
 
-- 
2.37.3

