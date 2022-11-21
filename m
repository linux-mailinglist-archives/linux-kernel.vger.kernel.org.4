Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FAA632737
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiKUPCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiKUPCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:02:19 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714FEC1F49
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:51:37 -0800 (PST)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1E36E3F328
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669042295;
        bh=NsHTwi+hBHPSGZtz4i+0KmEZ/6fgGJoyxYvuPwYMvZg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=XVng0iAM74/4eanISKxSP9Lyhv82p8oqnVM7I9vLQ2MJgmJrrnVkaKNXZp5asEkRr
         4Thl8ttiqs3emjVWt85EZvGHpojFUjwkdRHZIT76b6f/O7uxCs62dijLqTTQGVWYYJ
         rYDVJHLjDN/0b5imeEwE83I00V9NlRgORmYMd5O3iRkse/R0l0cJ42a2Ghzx9ANqJ0
         fw/YgGsAbYPnrssgwmRMjZUUq4gcReJr1/Y18yV0iBrvB0/a2gfqOnwgNSah1SE53i
         d/xWo0bvZ0dX7yZYWLpA44nXA35XSwqidwX+PstUsc4hRGCqbXQoYA0MGM+PdphVjc
         3sKTbUJ7kbQ/A==
Received: by mail-wr1-f69.google.com with SMTP id e21-20020adfa455000000b00241daf5b9b2so807237wra.18
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsHTwi+hBHPSGZtz4i+0KmEZ/6fgGJoyxYvuPwYMvZg=;
        b=RUFOPHPSRY24u5/PgOMjks1ug1xMHobEeKqPTwad5dPyLi/7hrK5GIKZLT8yEIZhsg
         r6o7TfC7LqKLtOvlowGc3pN+RRP0P64QjcDTitFSxmMnaLJ7NCSAKj4Z2bNuQF0zfFpT
         mjMeNibNjT+SpzRKuHnlejVdTyxnf2yArZ6O8RsZTe3ucBFdBrPeXJWzUFbObyEHxNFd
         fDi9A7/A/VIY+Wptue3MGF7LGQh6K3rOslQCHQUJUfuid9aUo0kQ1YR7wQAJMvAKrMLk
         su2WZwNupymtbKSVo0+6888k8j73XiF1NhaSifk3L9a3ZVAxAYlehVCy4HZ//x8C3n5x
         HkRQ==
X-Gm-Message-State: ANoB5pmNRNiPQ+/P6R0g7OmSc0dmrHhvtNaUv5YnpGJu/jNlKHYyBrm6
        hjoE0XDjBVwpv1CLHo30NAUnBgbOlTIPSqW9VI1pPE6w2pfE9YHCoiIiQSMYz+1A0qWUm4+/uZx
        LEOZJ6YO3KDb17RFZXYu2dRVhGg2yQJiDEhcqwYHorw==
X-Received: by 2002:adf:ea50:0:b0:241:d7b1:b405 with SMTP id j16-20020adfea50000000b00241d7b1b405mr2846700wrn.53.1669042294727;
        Mon, 21 Nov 2022 06:51:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4YVQzlKq0DV868WdWNL6UcqtlF4covNMAZVB0l6+D/LmlLvrK6aXvlDROcZ6Z3TnxVCwm17g==
X-Received: by 2002:adf:ea50:0:b0:241:d7b1:b405 with SMTP id j16-20020adfea50000000b00241d7b1b405mr2846689wrn.53.1669042294458;
        Mon, 21 Nov 2022 06:51:34 -0800 (PST)
Received: from localhost ([137.220.91.195])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b003d005aab31asm14305722wmq.40.2022.11.21.06.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 06:51:34 -0800 (PST)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] Bluetooth: btintel: Correctly declare all module firmware files
Date:   Mon, 21 Nov 2022 14:51:24 +0000
Message-Id: <20221121145125.1303097-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Strictly encode patterns of supported hw_variants of firmware files
the kernel driver supports requesting. This now includes many missing
and previously undeclared module firmware files for 0x07, 0x08,
0x11-0x14, 0x17-0x1b hw_variants.

This especially affects environments that only install firmware files
declared and referenced by the kernel modules. In such environments,
only the declared firmware files are copied resulting in most Intel
Bluetooth devices not working. I.e. host-only dracut-install initrds,
or Ubuntu Core kernel snaps.

BugLink: https://bugs.launchpad.net/bugs/1970819
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 Changes since v3:
 - Hopefully pacify trailing whitespace from GitLint in this optional
   portion of the commit.

 Changes since v2:
 - encode patterns for 0x17 0x18 0x19 0x1b hw_variants
 - rebase on top of latest rc tag

 Changes since v1:
 - encode strict patterns of supported firmware files for each of the
   supported hw_variant generations.

 drivers/bluetooth/btintel.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a657e9a3e96a..55efc4a067db 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2656,7 +2656,25 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
-MODULE_FIRMWARE("intel/ibt-11-5.sfi");
-MODULE_FIRMWARE("intel/ibt-11-5.ddc");
-MODULE_FIRMWARE("intel/ibt-12-16.sfi");
-MODULE_FIRMWARE("intel/ibt-12-16.ddc");
+/* hw_variant 0x07 0x08 */
+MODULE_FIRMWARE("intel/ibt-hw-37.7.*-fw-*.*.*.*.*.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.7.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.8.*-fw-*.*.*.*.*.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.8.bseq");
+/* hw_variant 0x0b 0x0c */
+MODULE_FIRMWARE("intel/ibt-11-*.sfi");
+MODULE_FIRMWARE("intel/ibt-12-*.sfi");
+MODULE_FIRMWARE("intel/ibt-11-*.ddc");
+MODULE_FIRMWARE("intel/ibt-12-*.ddc");
+/* hw_variant 0x11 0x12 0x13 0x14 */
+MODULE_FIRMWARE("intel/ibt-17-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-18-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-19-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-20-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-17-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-18-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-19-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-20-*-*.ddc");
+/* hw_variant 0x17 0x18 0x19 0x1b, read and use cnvi/cnvr */
+MODULE_FIRMWARE("ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].sfi");
+MODULE_FIRMWARE("ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].ddc");
-- 
2.34.1

