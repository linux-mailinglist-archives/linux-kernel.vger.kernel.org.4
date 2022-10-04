Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD9C5F3B98
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 05:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJDDQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 23:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJDDQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:16:45 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FF72DA98
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 20:16:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id v186so12022474pfv.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 20:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Flg3/SpxZ4nlW0rldGn9nsAn/YMX4bI0O25ZeoXC7Ig=;
        b=ctblUqYuosqB1quvT3Bznf0Bk3tuq0qXvibeg4/bptRlCh2Y3wcYoeB8YaviOCSfrX
         mHLBG4QygPS4VQ3GVdIIF19qv62BE320QvDB6QMzmNZsGCqRN3/apITFrxWSANT9Lrum
         hFoM9n5NnCm9XgZB2AUZIAelG6AX4MPvKsdD/2Z/v3bs1DdZSexsi3HExGMqu/6HqEvF
         b3It2bOzeW8Pzjp6kHEldbRIkrRE1rL6l16DixN/daHAdZo8Px0RP6au1IkL54l/3Cv/
         czKo9QmRkjh7cakDPAts4TkKKuSHAjoCSlp7DyjlTxNfEt4c3xx5wz/QvxEbzfhxj7a7
         3KEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Flg3/SpxZ4nlW0rldGn9nsAn/YMX4bI0O25ZeoXC7Ig=;
        b=kbgJfkzHaw5O6OcSIsufrD/M/3HWdaGHkRarpulE1U1+QO6OSgHn+bLsFsP12npuAq
         VtISxEN4s2Xasq6pdxfhqTG8i8U3VLgSqBgitHqnwHzTPU4OIavWbr+0exzG96rTFGGU
         Kj2Q81pCDtLxLIbTTg766DJu79uDJUiid5xs2uT+HW1fXt8gT+dRQW80q+PL1Q5TeX9C
         IaJksxGxlcdxXvwa1rEqgkdgxuvqKyzH+tRj61iXjM7e6sHa8RHhMwcpU+cCxT/G6g0m
         kjGk+R3CcudVDjRHQOMz4rTtJnWaibUJoBcNbSpXiCG7L4hRfFVqTLfbqXwfbGXubEgv
         9OBA==
X-Gm-Message-State: ACrzQf14AY12dz0NVjXf+PrbR9PKRTXM0Nsm0kPb+blc8E0I04X8mEFC
        VExplRwyzf1LcBMm66awBM4=
X-Google-Smtp-Source: AMsMyM6ihKXmuoIzYH2AKcrJ/ujeBN/lJxh6ggAJBg3SJOS718b0OtaKU0DMRJLYCNDSxjMdEl6uwg==
X-Received: by 2002:a65:6a12:0:b0:445:84f6:676a with SMTP id m18-20020a656a12000000b0044584f6676amr12807775pgu.40.1664853404600;
        Mon, 03 Oct 2022 20:16:44 -0700 (PDT)
Received: from localhost.localdomain ([171.78.165.127])
        by smtp.googlemail.com with ESMTPSA id w8-20020a63f508000000b0043b565cb57csm7609408pgh.73.2022.10.03.20.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 20:16:44 -0700 (PDT)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abdun Nihaal <abdun.nihaal@gmail.com>,
        syzbot+fa4648a5446460b7b963@syzkaller.appspotmail.com
Subject: [PATCH] fs/ntfs3: Validate attribute data and valid sizes
Date:   Tue,  4 Oct 2022 08:45:02 +0530
Message-Id: <20221004031502.20007-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <000000000000c2333105e9cc7b1c@google.com>
References: <000000000000c2333105e9cc7b1c@google.com>
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

The data_size and valid_size fields of non resident attributes should be
less than the its alloc_size field, but this is not checked in
ntfs_read_mft function.

Syzbot reports a allocation order warning due to a large unchecked value
of data_size getting assigned to inode->i_size which is then passed to
kcalloc.

Add sanity check for ensuring that the data_size and valid_size fields
are not larger than alloc_size field.

Link: https://syzkaller.appspot.com/bug?extid=fa4648a5446460b7b963
Reported-and-tested-by: syzbot+fa4648a5446460b7b963@syzkaller.appspotmail.com
Fixes: (82cae269cfa95) fs/ntfs3: Add initialization of super block
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 fs/ntfs3/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index e9cf00d14733..9c244029be75 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -132,6 +132,13 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	if (le16_to_cpu(attr->name_off) + attr->name_len > asize)
 		goto out;
 
+	if (attr->non_res) {
+		t64 = le64_to_cpu(attr->nres.alloc_size);
+		if (le64_to_cpu(attr->nres.data_size) > t64 ||
+		    le64_to_cpu(attr->nres.valid_size) > t64)
+			goto out;
+	}
+
 	switch (attr->type) {
 	case ATTR_STD:
 		if (attr->non_res ||
-- 
2.37.3

