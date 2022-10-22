Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48731608ED8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 19:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJVRsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 13:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJVRsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 13:48:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183AAB2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:48:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id q19so17010207edd.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kA1RUYYc/4X5sRFnjwWDavrb0+igVW51vZRNo+KLENo=;
        b=pk1JPaO124kD9FUXsMNgIuLUnQeM7DtqHs1KwuFroXIGt6EGsnRBXLTXcE0liY6YNM
         QR9Z3txWC80+cz19T4MJOkXDvE2bf8gO4lrGGFyaq4hPGBH3/ZA4Hj6mNzhuvdnaEAea
         dtcwslJnx/X2Fl80CsqK1QTxyCuGNyA3KmtpcMeXJhpDADzfdLIj1scB6BS9ixy4uQKj
         jIQxALXTWuEBXMZloxPF861qOIXYfsdtiJbJF9ipavXB/43RBhmxXatbjtONQEXEgRgG
         W0Z6i7wt7n+9KtVHRCfuqUrjxY2+gxsWUWE5BgwueYwNvGUZEnGO05kr+8ao873HagD2
         8lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kA1RUYYc/4X5sRFnjwWDavrb0+igVW51vZRNo+KLENo=;
        b=hL/26eqRjkZ4aj6GsSwRrWE4XYxfvbcm5DySo/r0ztpxJ1cyul3ZNqIs02HqKxnDYF
         0Xcen95shEuOTbYBw8pSpG2xvdYUteggEiXFcQXkLXB7xvr6+WEihkSojcmh8AtaFBXz
         XaZwBsEmoTMNsiJHWEcfh4zPrnXaaYTNlt2K5ZXn5upiKHUTDu2eXRMqqXURWeSH1AfW
         2/yg1f4v8C1zkU4HCLENVH92AqUkS7N0JZpARLUnNb5zuNGWdO3bvJ0QkYiAqd8angBe
         RagWYhRXk03cCTzF1sytyTqrUJsOkvejpXRfkgQ87UbjZZv9VCSLOyXrDIwn199shueq
         rGHw==
X-Gm-Message-State: ACrzQf0oE9t4OJmuXLjJehN9uZpGezcpeFtSiH0mqeMuNVA29iE1aUX6
        8wqt1qbnnOv57Uvy2o+IvLE=
X-Google-Smtp-Source: AMsMyM4SZU4916e1mjGvrI/QPalwjrfgQvBYyCvFSL8mRnRuFa9koJtArq77o9k2/1EDQWi8zrqhdw==
X-Received: by 2002:a05:6402:520f:b0:45f:b7a0:a31 with SMTP id s15-20020a056402520f00b0045fb7a00a31mr15742960edd.379.1666460895540;
        Sat, 22 Oct 2022 10:48:15 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-178.ip.prioritytelecom.net. [217.105.46.178])
        by smtp.gmail.com with ESMTPSA id r17-20020a170906351100b0078d4962a46bsm13054235eja.190.2022.10.22.10.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 10:48:15 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     namcaov@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-tcp: replace sg_init_marker() with sg_init_table()
Date:   Sat, 22 Oct 2022 19:46:36 +0200
Message-Id: <20221022174635.15643-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In nvme_tcp_ddgst_update(), sg_init_marker() is called with an
uninitialized scatterlist. This is probably fine, but gcc complains:

  CC [M]  drivers/nvme/host/tcp.o
In file included from ./include/linux/dma-mapping.h:10,
                 from ./include/linux/skbuff.h:31,
                 from ./include/net/net_namespace.h:43,
                 from ./include/linux/netdevice.h:38,
                 from ./include/net/sock.h:46,
                 from drivers/nvme/host/tcp.c:12:
In function ‘sg_mark_end’,
    inlined from ‘sg_init_marker’ at ./include/linux/scatterlist.h:356:2,
    inlined from ‘nvme_tcp_ddgst_update’ at drivers/nvme/host/tcp.c:390:2:
./include/linux/scatterlist.h:234:11: error: ‘sg.page_link’ is used uninitialized [-Werror=uninitialized]
  234 |         sg->page_link |= SG_END;
      |         ~~^~~~~~~~~~~
drivers/nvme/host/tcp.c: In function ‘nvme_tcp_ddgst_update’:
drivers/nvme/host/tcp.c:388:28: note: ‘sg’ declared here
  388 |         struct scatterlist sg;
      |                            ^~
cc1: all warnings being treated as errors

Use sg_init_table() instead, which basically memset the scatterlist to
zero first before calling sg_init_marker().

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1eed0fc26b3a..dc2def86076d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -387,7 +387,7 @@ static inline void nvme_tcp_ddgst_update(struct ahash_request *hash,
 {
 	struct scatterlist sg;
 
-	sg_init_marker(&sg, 1);
+	sg_init_table(&sg, 1);
 	sg_set_page(&sg, page, len, off);
 	ahash_request_set_crypt(hash, &sg, NULL, len);
 	crypto_ahash_update(hash);
-- 
2.25.1

