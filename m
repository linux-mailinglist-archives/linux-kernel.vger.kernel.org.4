Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9006CB2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 02:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjC1AHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 20:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjC1AHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 20:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0436F1BC8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 17:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679961986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oVSllWMtZWdtDUnZueS3ZITI6/5YaR00xl6fOWFPgxw=;
        b=XnhdH8wwJKXFa2Kv6XMYVXTxhtjPrb4SOcz2AUjRDOqVP1qcDEB2F7yGo1qFl4kr3JtuqQ
        XvjP/qu2NKXYtAk+wy/9S62zH3iUNoSSDAgy1Gc1RaHb0CyLSxLDqv6ETDk2YikS0JaDhQ
        wLDGHHv7HT4ZR7sMnNfe66JMX1hacT4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-KSeopUydNTuPObXxxmy_8g-1; Mon, 27 Mar 2023 20:06:24 -0400
X-MC-Unique: KSeopUydNTuPObXxxmy_8g-1
Received: by mail-qv1-f70.google.com with SMTP id l18-20020ad44bd2000000b005a9cf5f609eso4327074qvw.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 17:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679961984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVSllWMtZWdtDUnZueS3ZITI6/5YaR00xl6fOWFPgxw=;
        b=S4OWcYJEKGuM8N7iBzpUYoI8glKWzoDDOvigVr7vbZBz3jPEFdADJX06x7WjYGvGvw
         H8AU4Rb0wNQj67GxU+T9PIvDKW8Bri2t5JwvH+cEdhIc8VNPmBZ6HWe7mxw+A56U95XC
         S9OhIajp9DBG/4qL7OWRuvOI10ulB4iyLGfKwip4LSlyoe+EbMdh+KmYZ/i3yyXNQ258
         ehjqIjQSESZ2JxIZ1FXe+8diCNrc+bbUB+TA0mWZNiL2owUYTBYNq3O/zJvN6D6zQHyT
         PswsKDYSTolP4kGiq3kUijIttOx0bdJ0xnqSzkajIAAD4hSyjxz9CY/cImXPYr73QVJh
         arMQ==
X-Gm-Message-State: AAQBX9e2PrlT6lJGFyZ67mWN09ZUXpdUB23qzW1Fns821XaKO8+YIjol
        WZM8jZck5OrXX45SYWYhthwN/1AW4AHZ6W8FQvnhL48He95zM/qihnPBrFr5NYKeoZqOcYu1qqi
        mDtQTqQQM9pfb9J6huS+aM7ns
X-Received: by 2002:a05:6214:27cc:b0:5af:3a13:201f with SMTP id ge12-20020a05621427cc00b005af3a13201fmr20749281qvb.37.1679961984162;
        Mon, 27 Mar 2023 17:06:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350bosbW29PT8iFMSLN0sbn5umQV3b5UqmtN5qZQaOtgas+0CV3b7wBzisKLHjUrsN/FUDALfvg==
X-Received: by 2002:a05:6214:27cc:b0:5af:3a13:201f with SMTP id ge12-20020a05621427cc00b005af3a13201fmr20749256qvb.37.1679961983880;
        Mon, 27 Mar 2023 17:06:23 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q21-20020ac87355000000b003e387a2fbdfsm7130695qtp.0.2023.03.27.17.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 17:06:23 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] mtd: lpddr_cmds: remove unused words variable
Date:   Mon, 27 Mar 2023 20:06:20 -0400
Message-Id: <20230328000620.1778033-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/mtd/lpddr/lpddr_cmds.c:409:31: error: variable
  'words' set but not used [-Werror,-Wunused-but-set-variable]
        int ret, wbufsize, word_gap, words;
                                     ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/mtd/lpddr/lpddr_cmds.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/lpddr/lpddr_cmds.c b/drivers/mtd/lpddr/lpddr_cmds.c
index ee063baed136..3c3939bc2dad 100644
--- a/drivers/mtd/lpddr/lpddr_cmds.c
+++ b/drivers/mtd/lpddr/lpddr_cmds.c
@@ -406,7 +406,7 @@ static int do_write_buffer(struct map_info *map, struct flchip *chip,
 {
 	struct lpddr_private *lpddr = map->fldrv_priv;
 	map_word datum;
-	int ret, wbufsize, word_gap, words;
+	int ret, wbufsize, word_gap;
 	const struct kvec *vec;
 	unsigned long vec_seek;
 	unsigned long prog_buf_ofs;
@@ -421,10 +421,7 @@ static int do_write_buffer(struct map_info *map, struct flchip *chip,
 	}
 	/* Figure out the number of words to write */
 	word_gap = (-adr & (map_bankwidth(map)-1));
-	words = (len - word_gap + map_bankwidth(map) - 1) / map_bankwidth(map);
-	if (!word_gap) {
-		words--;
-	} else {
+	if (word_gap) {
 		word_gap = map_bankwidth(map) - word_gap;
 		adr -= word_gap;
 		datum = map_word_ff(map);
-- 
2.27.0

