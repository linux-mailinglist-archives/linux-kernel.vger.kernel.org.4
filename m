Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8786D59D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjDDHl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjDDHl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:41:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B2B10EA;
        Tue,  4 Apr 2023 00:41:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so35232138pjt.2;
        Tue, 04 Apr 2023 00:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680594115;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLZXH9LKQ7+V9D+5CMfFVNwTnI59Wm1ssSfTYrYAXlw=;
        b=EK6HPTDKWjHlPWtWEQiBLeIj0HG/XbgwL0my/OLwgDd2a8/bbSuWJLGOMEgTRSbAyj
         6G1q9JpHdgnJazUvFIsEwn83D5M/NuWtcnCMjEj2VS9iEh/G4dODb1tCozuvrM1wWX82
         yOC+aa0CwWvQkrrP1GBjHtRynyGfStF7davUQSuEefNdATdWixJ8DoEloVEQXO8WxHvy
         gbIQqZQZIoa276UC+SmrqHN2lcJVpG1PmOJ0HMTO88Rw1IEY64lgUO4tW1qIXa0YDvRh
         G5ym5Ej6wTmYTjki5hn2GtjOLjR31gGoEgDVeaBj7a3rjw3sg6k2VIFVG/1bWzy/+9h0
         0Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680594115;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLZXH9LKQ7+V9D+5CMfFVNwTnI59Wm1ssSfTYrYAXlw=;
        b=wCUzStAK6hgECGGYMymU2wip2wl8jb4hHpJWn7ysBAwhmYkwWEbh/JwwL2pxIIfQrs
         4RNpy9i7AtmqcTYb4C4TAJefCe04cUJJWLIvxF4OrNL4kV7tnijQ5DxgrcJL5eqLyOI6
         WKgGzLnn21W/ZKkY38nICQpEVZf4CjVS6nO72d8g9SMkxZ6haiVshXuJGRU56pBtTLKG
         fNBhiEjZkd81cLjgh/FL7WQvqxMK+AxQ0Qq3Ww8anz/k8RFUlLRql28chKY1GAWx3Ota
         1vr3hU++UVzcsNBu60EqsiaRtp3I3Uv9kiDcCtRzeWVCJgBasd3zTbPWU6jlxumWFjkw
         icwg==
X-Gm-Message-State: AAQBX9c4/rldnuJ9GBKlT4L5TE5CfZPjs0OjVR92KSW6tY60pzavEK7D
        xwSJIChVsX3+7W4teeCmS1gKAboyRiOo1w==
X-Google-Smtp-Source: AKy350blMTRFDIdKJ/XpubXFkEOOGGoCSPcjrA8g7Uhqh/eMU1v9iP2DFkO9UrzAn+6d+pnClqSc0g==
X-Received: by 2002:a05:6a20:4e13:b0:c6:c85f:da5b with SMTP id gk19-20020a056a204e1300b000c6c85fda5bmr1479492pzb.55.1680594114951;
        Tue, 04 Apr 2023 00:41:54 -0700 (PDT)
Received: from Negi ([207.151.52.77])
        by smtp.gmail.com with ESMTPSA id b24-20020a631b18000000b0050f74d435e6sm6975617pgb.18.2023.04.04.00.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 00:41:54 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Soumya Negi <soumya.negi97@gmail.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: Check sanity of pipe in pegasus_probe()
Date:   Tue,  4 Apr 2023 00:41:45 -0700
Message-Id: <20230404074145.11523-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix WARNING in pegasus_open/usb_submit_urb
Syzbot bug: https://syzkaller.appspot.com/bug?id=bbc107584dcf3262253ce93183e51f3612aaeb13

Warning raised because pegasus_driver submits transfer request for
bogus URB(pipe type does not match endpoint type). Add sanity check at
probe time for pipe value extracted from endpoint descriptor. Probe
will fail if sanity check fails.

Reported-and-tested-by: syzbot+04ee0cb4caccaed12d78@syzkaller.appspotmail.com
Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/input/tablet/pegasus_notetaker.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index d836d3dcc6a2..a68da2988f9c 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -296,6 +296,12 @@ static int pegasus_probe(struct usb_interface *intf,
 	pegasus->intf = intf;
 
 	pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
+	/* Sanity check that pipe's type matches endpoint's type */
+	if (usb_pipe_type_check(dev, pipe)) {
+		error = -EINVAL;
+		goto err_free_mem;
+	}
+
 	pegasus->data_len = usb_maxpacket(dev, pipe);
 
 	pegasus->data = usb_alloc_coherent(dev, pegasus->data_len, GFP_KERNEL,
-- 
2.17.1

