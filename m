Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCB569B186
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBQRBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBQRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:01:02 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFAC6243E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:01:01 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u14-20020a17090a4bce00b002341fadc370so1922374pjl.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CmMG6Bjrj55x+g0WwIsSci8pNsPP4XDLQDm9PqSpIM=;
        b=RAUUWFldyLPjGSheNOIq6G8uYWWP0gAKTPALYQvcwHJRP8rIYOBIYIqZ0l0QiOgpI4
         BmRN2EH3XT44R1QVRQbtFM+sez585aP618jvo+nftzHfykjas90LU4RWFK+7D09c9TWG
         HLQW/Q6lD0zd0Os5D/neaKqg0GgxwV8B3Y097zSAQdttWlnzcUlsUYNv/v8k1sSLN9hf
         rWxCPN2Ye+aNIiHB1e9rnXHREG1I+CAMMWuz7Tl/6PoHfcufOJHSspnvCVpb9DEuC8l6
         Iehw0teIWwAQ0cS3KSr3Khnn9aPd4nSTCJ6e+LAApn2yrXIW6suB9yeimWF7QcJTU1qD
         U8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CmMG6Bjrj55x+g0WwIsSci8pNsPP4XDLQDm9PqSpIM=;
        b=RyCDTr2d5BYFLsRuFvFJmcJwPKQ0HG7s9ilONL+aKXP0t19/GIA7EJe/nIXlW5nUpw
         tlIkmR7CS8gRLOFOgEo03mNI2m41FSUniW8injPDp/fDLlHo9Up2orcxqjJvLwLaAbMU
         dZ1r6asGibM2P+36oIZUmDh9dpYW8zQGeSD7dnHHKDy1dUaJvpz8iR9FpquUaeP3xF00
         M6NFf9bXLj9JBEr+L3e8rE0uv5LNeJt4s+rklKyJx72+d8zTXnmHZIVGh+ySyMguld4w
         QuNLet1eU5jUOc4KzaPC4jg/05kHi7GuchjZ0h1s5YJdPdme1Bd/sxVZzjXNv/cfdcnX
         uObQ==
X-Gm-Message-State: AO0yUKWgZRMykl2C7TYOpY8SHcamISpDvd8MGbRZh24aeeXZ0CGOLo4+
        q4U9BJRtchpW1GD0Ysa23cs=
X-Google-Smtp-Source: AK7set/4ilB4G2TkmFxdRwuCoA6bW6LLDRjvY2SEttqZb4vbAwGObXZU5dNtLdu1y+2r/zAwusaHNA==
X-Received: by 2002:a17:903:48f:b0:19a:9610:b237 with SMTP id jj15-20020a170903048f00b0019a9610b237mr1540289plb.45.1676653260569;
        Fri, 17 Feb 2023 09:01:00 -0800 (PST)
Received: from udknight.localhost ([117.30.83.51])
        by smtp.gmail.com with ESMTPSA id jb6-20020a170903258600b0019a7563ff15sm3401546plb.115.2023.02.17.09.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2023 09:01:00 -0800 (PST)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 31HH0uab030595;
        Sat, 18 Feb 2023 01:00:56 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 31HGw8bo005510;
        Sat, 18 Feb 2023 00:58:08 +0800
Date:   Sat, 18 Feb 2023 00:58:08 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     bbrezillon@kernel.org, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: ubi: eba.c: fix return value overwrite issue in
 try_write_vid_and_data()
Message-ID: <20230217165442.GA28288@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        miquel.raynal@bootlin.com, bbrezillon@kernel.org, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/mtd/ubi/eba.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 09c408c..4e32b25 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -981,10 +981,17 @@ static int try_write_vid_and_data(struct ubi_volume *vol, int lnum,
 out_put:
 	up_read(&ubi->fm_eba_sem);
 
-	if (err && pnum >= 0)
-		err = ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1);
-	else if (!err && opnum >= 0)
-		err = ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0);
+	if (err && pnum >= 0) {
+		if (ubi_wl_put_peb(ubi, vol_id, lnum, pnum, 1) != 0) {
+			ubi_warn(ubi, "failed to return physical eraseblock %d",
+				 pnum);
+		}
+	} else if (!err && opnum >= 0) {
+		if (ubi_wl_put_peb(ubi, vol_id, lnum, opnum, 0) != 0) {
+			ubi_warn(ubi, "failed to return physical eraseblock %d",
+				 opnum);
+		}
+	}
 
 	return err;
 }
-- 
1.8.5.6.2.g3d8a54e.dirty
