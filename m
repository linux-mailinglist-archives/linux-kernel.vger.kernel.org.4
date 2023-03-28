Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5076CC72A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjC1Py0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjC1PyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:54:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C98F0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:54:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so13093418pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680018855;
        h=user-agent:content-disposition:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmzh57wLBrZsBEEJz6ToKyLCm+TGSn6BgiPXbEgYDl8=;
        b=CQ2x//wAX2D9QYCI81rqpn6kAGgKdd9XHlvuviib1LAaaHKu4iaFX8B4zPDCgo0tCp
         EyK2a7AyJ2IMefysra0INrsVdL33x5lhYVB5QS9gYIAjDSsag4pG9VTc+uW1Hy79UqnS
         5CrLyqpoNiWzxXEmpyR6n9rxVXu1l4yIv/e/ufxiJhCEqNAbrtIfkxtNihFLM2i8mwEx
         WvHNH8B5OKhhja6ZFOpM6UcWbuuNsn3auoV9W1CkDo2Wib5ms/xp46IYOQAEEHnJ1tGi
         9Ew1IfYkZrb/XTdqRHzwBHMO3qZ6lw1QKpMPbNKw0jXl9WjsgOf32NyZHXSMa088jvGk
         tlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680018855;
        h=user-agent:content-disposition:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmzh57wLBrZsBEEJz6ToKyLCm+TGSn6BgiPXbEgYDl8=;
        b=TCl4aP5aGx1IIhTCESOkUmj0pNcP4PpUw9Hlg1aJ/8+Ckq5p0QwyZ1QnhpoQb2PMzF
         ziPh9piO6dNpJU5lWqYPzad3XYLteWFqcjkqILNLaDniFttfa3sdJh2ow3d8atCbhwk+
         xeLb4s0NPgGnQS1wgPm5P6Owi2I03l4tHSrO8RS4cSJG0p6DaPbl9hxuXz/S0+ayJ9oU
         tofVzEf4dEF89ZlVcH3TgNZAuvRYwjbzxX8I2HDY2ljEAAWRZilXkDquPPFgkyquBzGW
         bEXYg45poBPjgZ1qkCDtnf/oOLTrpQz4xfBdnhz9LfarBcp1oOK1H0pW7dzuYXK16j8Q
         7spQ==
X-Gm-Message-State: AO0yUKXViaEZB9gCvrtOcAIuhRMxv0te/tXrwVOUie4WCDzoq5qsKPcp
        IP353GRiaAN0aY0CIb6NkJnncGiGsfe23Q==
X-Google-Smtp-Source: AK7set91ezqdli3CwELBU+35ka3BsRC37ewoWiAeckTNmB9RKHs6VAH3rGAKBDpoOeBx0tOzPJyBKw==
X-Received: by 2002:a05:6a20:bc9d:b0:d6:80a4:f0b6 with SMTP id fx29-20020a056a20bc9d00b000d680a4f0b6mr13689838pzb.6.1680018855349;
        Tue, 28 Mar 2023 08:54:15 -0700 (PDT)
Received: from udknight.localhost ([117.30.91.49])
        by smtp.gmail.com with ESMTPSA id w4-20020a654104000000b0049f5da82b12sm19783510pgp.93.2023.03.28.08.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2023 08:54:14 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 32SFZbwv012706;
        Tue, 28 Mar 2023 23:35:37 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 32SFZY5F012703;
        Tue, 28 Mar 2023 23:35:34 +0800
Date:   Tue, 28 Mar 2023 23:35:34 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     richard@nod.at
Cc:     miquel.raynal@bootlin.com, bbrezillon@kernel.org, richard@nod.at,
        vigneshr@ti.com, chengzhihao1@huawei.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: ubi: eba.c: fix return value overwrite issue in
 try_write_vid_and_data()
Message-ID: <20230328153534.GA12409@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, richard@nod.at,
        miquel.raynal@bootlin.com, bbrezillon@kernel.org, vigneshr@ti.com,
        chengzhihao1@huawei.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 2d78aee426d8 ("UBI: simplify LEB write and atomic LEB change code")
adds helper function, try_write_vid_and_data(), to simplify the code, but this
helper function has bug, it will return 0 (success) when ubi_io_write_vid_hdr()
or the ubi_io_write_data() return error number (-EIO, etc), because the return
value of ubi_wl_put_peb() will overwrite the original return value.

This issue will cause unexpected data loss issue, because the caller of this
function and UBIFS willn't know the data is lost.

Fixes: 2d78aee426d8 ("UBI: simplify LEB write and atomic LEB change code")

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 Changes v1-v2:
 1: add error code in warning message, suggested by Zhihao Cheng
 
 drivers/mtd/ubi/eba.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 09c408c..4e1d807 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -946,7 +946,7 @@ static int try_write_vid_and_data(struct ubi_volume *vol, int lnum,
 				  int offset, int len)
 {
 	struct ubi_device *ubi = vol->ubi;
-	int pnum, opnum, err, vol_id = vol->vol_id;
+	int pnum, opnum, err, err2, vol_id = vol->vol_id;
 
 	pnum = ubi_wl_get_peb(ubi);
 	if (pnum < 0) {
@@ -981,10 +981,19 @@ static int try_write_vid_and_data(struct ubi_volume *vol, int lnum,
 out_put:
 	up_read(&ubi->fm_eba_sem);
 
-	if (err && pnum >= 0)
-		err = ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1);
-	else if (!err && opnum >= 0)
-		err = ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0);
+	if (err && pnum >= 0) {
+		err2 = ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1);
+		if (err2) {
+			ubi_warn(ubi, "failed to return physical eraseblock %d, error %d",
+				 pnum, err2);
+		}
+	} else if (!err && opnum >= 0) {
+		err2 = ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0);
+		if (err2) {
+			ubi_warn(ubi, "failed to return physical eraseblock %d, error %d",
+				 opnum, err2);
+		}
+	}
 
 	return err;
 }
-- 
1.8.5.6.2.g3d8a54e.dirty
