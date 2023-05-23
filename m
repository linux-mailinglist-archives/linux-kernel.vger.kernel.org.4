Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE4370DB7F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbjEWLcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjEWLct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E81118;
        Tue, 23 May 2023 04:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 775A7624B1;
        Tue, 23 May 2023 11:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEBAC433EF;
        Tue, 23 May 2023 11:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684841566;
        bh=2bCPs80POr2NdwT8+Ons3d8PhiCamrlaGVRkZrlM6lE=;
        h=From:To:Cc:Subject:Date:From;
        b=nEZoTThKhYtXo+kWcB9qgcW7hG6DntBrWl26EKEVW7f2UNh/xaYl+GVOaEFMNaYyu
         zT1icWzPXXIcx09nmv2q/TC8KBveSSrvv+J5wiq7ne4KgoxoRS93aaYvhsU4wA3IOu
         jqKkuzItD/fQwDRuniETV2NkioYDDyPHzUc2suFmT8oWydw1Q4MMD/0+ok5aN3/b85
         tOc9X3dOwYCkXgr8YyPCXQ7cbLhGrJiSHbWnmfHdZNqfsL2z9ba/Ie8ENqy63GfYT/
         rlmwhIujRiV70+h73UN7+KGYqQW/oFLDS/sKCX5UCzW4aAbtWn/QAVaGLhaMi4Pr/I
         ArlTn3Vw2tf0w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ching-Te Ku <ku920601@realtek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtw89: use flexible array member in rtw89_btc_btf_tlv
Date:   Tue, 23 May 2023 13:32:35 +0200
Message-Id: <20230523113241.2772811-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

struct rtw89_btc_btf_tlv contains a one-byte member that is intended as a
flexible array:

In function 'fortify_memcpy_chk',
    inlined from '_append_tdma' at drivers/net/wireless/realtek/rtw89/coex.c:1579:3:
include/linux/fortify-string.h:583:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  583 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Make this actually use a flexible array to let the compiler understand.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 3a586a971e8f..bda0e1e99a8c 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -206,7 +206,7 @@ static const struct rtw89_btc_ver rtw89_btc_ver_defs[] = {
 struct rtw89_btc_btf_tlv {
 	u8 type;
 	u8 len;
-	u8 val[1];
+	u8 val[];
 } __packed;
 
 enum btc_btf_set_report_en {
-- 
2.39.2

