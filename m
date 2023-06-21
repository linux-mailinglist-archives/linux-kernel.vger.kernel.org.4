Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83656738F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjFUSxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjFUSxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:53:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE0E1728
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:52:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f87592eccfso4805024e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687373576; x=1689965576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YRiupOCUSfro8Q/9oyxaI+CCWZXMNt299nMeuHo3LM=;
        b=n7IhLCBWGp9VoSxr8L1eXKpHDWYgIC9mZYIlsTjcyTgfZCJQuEVCgIQ4N5USK6tPdb
         bsjXTn65pAgaHVjeHX0XxoLd+eVuBX/6AS9QK4HLQ2xON3PPH88oI43eM1K6G8OI/TK/
         COyBswnq6BxTKZnYaFG0Gl2NlbRe8giaGVojgtBmjc1yTkQ6VWoUeAijc+4/vB4Z6jGA
         oWPWE4/ELy47twulDMrW/uwWUdFKibCEKyQ+EBptjuFL4kPKFJLvjKC+dTtxz2oabnvd
         v8ORvmQQdOtodMR97ZcHs7bbeCx7Hzb2D8iW5I5vREIpOPomvuLoLBlXu9gcMgYfHkzl
         x5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687373576; x=1689965576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YRiupOCUSfro8Q/9oyxaI+CCWZXMNt299nMeuHo3LM=;
        b=hN2vkRmgLNoEML4IswCa8qglLs8a4qKGgXhcKr2X8No3hQSD7fMnckCuZc2cV8stJC
         vjDs8uI2iEsNg4MeuTRZCIjhtmNXpTui5M9sbisFqz+RPo5oom70ChLUuEywLVKKISIP
         IzUM3qw9xKrMLOqZTqy0JQS9hCGXwON4U1qi1eYBsgVGajkehBLCLdoY4mNqQQC9b32g
         rt0rpUUTErBz2AajkaCDOny6fsVte8NKMT7AgNlTvVu8H3zZ3mLBACL/yjmBq4DzPQYa
         JBmQ/UBac0z6C0wG3WQtDfs2EWQolLqfVsDUNt//rjEJsaxkqSS3/SUsKmNSWMHbY3gR
         K3NA==
X-Gm-Message-State: AC+VfDw+Gxpa7C+TkMC7Fbfo5Juvn+z/8ksFrPlwz2t0EqNYGIC2I2ml
        nlVO/8n/MrOtiEHo800kngM=
X-Google-Smtp-Source: ACHHUZ6W6LhlchgK22SEtatwlG5kmv0rEU6LJ8Eh91nnTz7/sOqBLxwESdPVVF23VdUkMdlogCyfzQ==
X-Received: by 2002:a19:380d:0:b0:4f8:565e:f4ae with SMTP id f13-20020a19380d000000b004f8565ef4aemr9143048lfa.39.1687373576369;
        Wed, 21 Jun 2023 11:52:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:5d4c:afae:7fa:7038])
        by smtp.gmail.com with ESMTPSA id l20-20020a1ced14000000b003f9b19caabesm5725118wmh.37.2023.06.21.11.52.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Jun 2023 11:52:55 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     franziska.naepelt@googlemail.com
Cc:     eperi1024@gmail.com, franziska.naepelt@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, quic_vjakkam@quicinc.com,
        tegongkang@gmail.com
Subject: [PATCH v2 3/5] staging: rtl8723bs: Fix block comment issue
Date:   Wed, 21 Jun 2023 20:52:53 +0200
Message-Id: <20230621185253.25241-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230621184635.25064-1-franziska.naepelt@gmail.com>
References: <20230621184635.25064-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch block comment issue:
- WARNING: Block comments use * on subsequent lines

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index ca642eb5d73e..3b64d0f1b4df 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -329,11 +329,11 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 }
 
 /*
-	Check the given bss is valid by kernel API cfg80211_get_bss()
-	@padapter : the given adapter
-
-	return true if bss is valid,  false for not found.
-*/
+ *	Check the given bss is valid by kernel API cfg80211_get_bss()
+ *	@padapter : the given adapter
+ *
+ *	return true if bss is valid,  false for not found.
+ */
 int rtw_cfg80211_check_bss(struct adapter *padapter)
 {
 	struct wlan_bssid_ex  *pnetwork = &(padapter->mlmeextpriv.mlmext_info.network);
-- 
2.39.2 (Apple Git-143)

