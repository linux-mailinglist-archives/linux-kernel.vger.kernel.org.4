Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7B77085CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjERQSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjERQSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:18:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8509D19A;
        Thu, 18 May 2023 09:18:00 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-510d9218506so2752400a12.1;
        Thu, 18 May 2023 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684426679; x=1687018679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJG7cNfD9GJybjbmQLXmdru6I/qiVuV5EUWE6EfH08w=;
        b=F2/4bzQPc9xF0srjvaUH+bvGf11gMRAY4Q/OK4Yvx6mbtCo12zyhemvO5saLArEOeQ
         Kvjt1h+9f3DUuB0YahG13iXnTZI/q0TwrpdjpfWvd6CiEdZk/qo3dJRizjsprPNiV1Dx
         nq0+1uGg3F820o4QxMHROit5fBjO4AaAwBAhbEqDfRTK+jVmTm1iL2c4gWkzX+ux4RNw
         MkVugWS3k9iW6RYZolxEUakz1QRFhFSkoLRqgRSx2V/OvGxWoaPR2QIsuXSmmzkhbka1
         08S6QWzWP7y5AgbLFWAvM2jYiqceJDJwSIudKuPBzi94IvT1/IwOww2n0ojLY+ulp5/f
         Oqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684426679; x=1687018679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJG7cNfD9GJybjbmQLXmdru6I/qiVuV5EUWE6EfH08w=;
        b=gzoFRi1TKq/UC5CObSmqwbz0bwOBAjMcR0tHxU+QfCQLFMREOHPjkL+s+ROWf0RiC1
         kc9z6vwA4AVO5Qwv5cfDSroyz7Q5ohaooIUuAwg7e7KWfS70f8Fh9Z4Y0pDAcMrR+BFs
         BvNQ2GJMFMFzPVRZxXFTSRVio7yki5rlwQp8n34TQhGbXf0L2Tvl5IZToIAOQOP9aj8v
         JFkNyKdqaiSG1GGx1Uiy/Nfd2iKXQhi8PucuzjJ1BpWggL/GIxWE78cb9tKLZYG8qTOf
         KZRCM96xFsEljclqzz5R+YmWSevsSX3YO/ewcfTR90GbN/5cRNNO7Lbd7pBiXIOq1CrD
         TbmQ==
X-Gm-Message-State: AC+VfDxxUAv/G+nYiQPYrqhhCdNkstcwUOTczKTw6/MOmMMwFJ5DNKzf
        eBLT+vkwq+PzUu60xHN0MedU82WKX+I=
X-Google-Smtp-Source: ACHHUZ7tZ9FPO+whTVEVld8RsRFVt+us6oGHxp/7xjOf4Z2biT8gvgHiU6MAUiN/GVD7NNrLZqVwcA==
X-Received: by 2002:a05:6402:26ca:b0:50c:1603:654 with SMTP id x10-20020a05640226ca00b0050c16030654mr5774678edd.16.1684426678717;
        Thu, 18 May 2023 09:17:58 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-73e5-9e00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:73e5:9e00::e63])
        by smtp.googlemail.com with ESMTPSA id c14-20020aa7c74e000000b0050bc13e5aa9sm756307eds.63.2023.05.18.09.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:17:58 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, kvalo@kernel.org, tony0620emma@gmail.com,
        Peter Robinson <pbrobinson@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, jernej.skrabec@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH wireless-next v1 2/4] wifi: rtw88: rtw8723d: Implement RTL8723DS (SDIO) efuse parsing
Date:   Thu, 18 May 2023 18:17:47 +0200
Message-Id: <20230518161749.1311949-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518161749.1311949-1-martin.blumenstingl@googlemail.com>
References: <20230518161749.1311949-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The efuse of the SDIO RTL8723DS chip has only one known member: the mac
address is at offset 0x11a. Add a struct rtw8723ds_efuse describing this
and use it for copying the mac address when the SDIO bus is used.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 9 +++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 06e7454c9ca6..cadf66f4e854 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -216,6 +216,12 @@ static void rtw8723du_efuse_parsing(struct rtw_efuse *efuse,
 	ether_addr_copy(efuse->addr, map->u.mac_addr);
 }
 
+static void rtw8723ds_efuse_parsing(struct rtw_efuse *efuse,
+				    struct rtw8723d_efuse *map)
+{
+	ether_addr_copy(efuse->addr, map->s.mac_addr);
+}
+
 static int rtw8723d_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
@@ -248,6 +254,9 @@ static int rtw8723d_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 	case RTW_HCI_TYPE_USB:
 		rtw8723du_efuse_parsing(efuse, map);
 		break;
+	case RTW_HCI_TYPE_SDIO:
+		rtw8723ds_efuse_parsing(efuse, map);
+		break;
 	default:
 		/* unsupported now */
 		return -ENOTSUPP;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index a356318a5c15..3642a2c7f80c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -49,6 +49,11 @@ struct rtw8723du_efuse {
 	u8 mac_addr[ETH_ALEN];          /* 0x107 */
 };
 
+struct rtw8723ds_efuse {
+	u8 res4[0x4a];			/* 0xd0 */
+	u8 mac_addr[ETH_ALEN];		/* 0x11a */
+};
+
 struct rtw8723d_efuse {
 	__le16 rtl_id;
 	u8 rsvd[2];
@@ -80,6 +85,7 @@ struct rtw8723d_efuse {
 	union {
 		struct rtw8723de_efuse e;
 		struct rtw8723du_efuse u;
+		struct rtw8723ds_efuse s;
 	};
 };
 
-- 
2.40.1

