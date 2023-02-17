Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4A469B188
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBQRBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjBQRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:01:02 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBB465342
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:01:01 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id ay25so910657pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CmMG6Bjrj55x+g0WwIsSci8pNsPP4XDLQDm9PqSpIM=;
        b=CDxh9ha/p7kDOFlK/BJFvPSDqguAqH41H/KUfvXimtiGlw476lp0SfOhlQGM0aHf/u
         owV4GJ5DnvuA2ku8qo4KfYn6TvIlNQjy78A8TqAfSPOywaWFXcEUI3cchY1m47uR+H02
         fm8+OqJyYWpD0tVk1v5Z5WH6q7QZ08cnByc8aPtbopOED5GnO6hXTSzi6NHh3JGnFfHT
         pbvgzYk8c1AobHSyDPmIQxQlttBlaUEgCwieMpQgwosphXBp6UqJdCtijhnPx7DmnUKN
         EC/J06wZCtzYlhLim8kOajDJ9bArSLSAQXtOKlZu6Uw0xKNo6PFIiAkQ1N1QMTIYI6ce
         PE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CmMG6Bjrj55x+g0WwIsSci8pNsPP4XDLQDm9PqSpIM=;
        b=mHIeXQjtEgNJBQ0X/8M4y+V3k8y6/pt++2gcmf8T3HfhNWSglEOAXAFnoo20550m6/
         4Jci9/5IOxz2gxcfY1p7yflRNdXv0Mf0Cudfpqirwgh7A0rE+Vmcodx4i37spKBDCtHV
         qRWxpBJJbUk8M+sHdBlG7z0+HL2fJZR96Y4TlVSTspzcX4OVw8tjzitrPuA7qxtPXnEi
         cWgMLjBplOZAJTJYVUO5TUIUUKkcde/0pDCBRQSTQMXkcwSLk1yL9mC/GhUvwObXSjmj
         kls+Yce2WwbrLhhEUY4Cxk4hfdLnqKC0/zMNwOl4Za38FOhgbz3jJ/19eixgIU34wIZg
         xECQ==
X-Gm-Message-State: AO0yUKUOJkjVsqXuJWJS32ShqHexlkJPk65VV/7/v7GsRvIsFvMDuW7u
        i18gKn6noIlG9lO/sc3W+Mc=
X-Google-Smtp-Source: AK7set8ArPq+Ci7Tf7WaI5qKK4aJz/jBzOCI0k5KAcs4APamkjAl8gSXUrNKT7i7NluYIIlNLaIDIQ==
X-Received: by 2002:a62:38d1:0:b0:5ac:41d5:ded2 with SMTP id f200-20020a6238d1000000b005ac41d5ded2mr102043pfa.1.1676653261209;
        Fri, 17 Feb 2023 09:01:01 -0800 (PST)
Received: from udknight.localhost ([117.30.83.51])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b00571cdbd0771sm3303121pfd.102.2023.02.17.09.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2023 09:01:00 -0800 (PST)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 31HH0uad030595;
        Sat, 18 Feb 2023 01:00:57 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 31HGhqK4027318;
        Sat, 18 Feb 2023 00:43:52 +0800
Date:   Sat, 18 Feb 2023 00:43:52 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     bbrezillon@kernel.org, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: mtd: ubi: eba.c: fix return value overwrite issue in
 try_write_vid_and_data()
Message-ID: <20230217164352.GA26537@udknight>
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
