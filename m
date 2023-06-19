Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67007735D54
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjFSSMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFSSMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:12:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABB612A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:12:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51a3f911135so4369185a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687198353; x=1689790353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+9yzantCwRm4FcYrNICqbhK8i/swOUSMka8dPN5+64=;
        b=CeGYnMzigtPR/nqfkfnU4ejWwYkY8x92hJCLspMad9X9dfeqH/MpjHAOdux37fyKd3
         pAQjdRBqvmVczLZ8iaw0Eo/niR3UhEeSNWzcLyt6w2ciBx27/yZMscMDfQR36tOGXxC3
         LC909lVEdZ53y22JQb3IiTpSFoK+oLbJmcEU8I2d/rpxwk3oPCp7LhTtrtQYqzHOxDMt
         ULDl12qyOixveL0w0OMLWuF7lfU9lNP1KmDv9ATD9vhlsDVNRBRGaL2xJlqpLWSvhgrP
         BK3yGV6tqY83NNYDQbBBNcN067ndTX3YyAkNwasRuQp7Fj8AyQuHwU1aHXNn0ux/7alX
         N+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687198353; x=1689790353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+9yzantCwRm4FcYrNICqbhK8i/swOUSMka8dPN5+64=;
        b=cyGqa6TLssFB3ubA8aqTdWNMMAKE8pi4BLUI9S57pPK1vTO1RJop3ouuRR1nbUPspy
         9J1bA5s3aEE0RXfzxN8p+zNK1lP0g9qV+1qhiISGZXqnfNsH3BXRtvgqOm0s2xu4MpPU
         ak/ghxiE9bnFfzXwuV0lbjrVK4khPJHJAad4WXMwnPyeBAqhWIl6AVhYi4LguHwtcLiU
         DLxV0KZLOB8MHCPV5EtXPHhxl8izTNF1Zt2MhkAND5M7a0S8jLXiskWnGKHlB/c0xd56
         zEBpU12MDpfnYDXlGQ9YlV3TZHSj8AvPjV/EZkS9mzP8BCekwvmdCOQa+Lp91qIR1NBV
         TpVg==
X-Gm-Message-State: AC+VfDzjnXfdSKr9/cLBPCr5u0+AyPDaEFywciN1wJ/y2l/eDwXppHB/
        wTyPml74Z3W2yMpgv556YfbaWsctaIguqA==
X-Google-Smtp-Source: ACHHUZ6IEh/9j6fKs7xILtT7GKtRkvBhhp02lyKwWifu/78E8OJlga48C9TCvaocwOqN6Hu7bnM1TA==
X-Received: by 2002:a17:906:4793:b0:96f:2315:29fe with SMTP id cw19-20020a170906479300b0096f231529femr9809250ejc.0.1687198353486;
        Mon, 19 Jun 2023 11:12:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:dcda:2154:7873:34])
        by smtp.gmail.com with ESMTPSA id lf4-20020a170906ae4400b0098822e05eddsm27361ejb.100.2023.06.19.11.12.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Jun 2023 11:12:33 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     franziska.naepelt@googlemail.com
Cc:     eperi1024@gmail.com, franziska.naepelt@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, quic_vjakkam@quicinc.com,
        tegongkang@gmail.com
Subject: [PATCH 3/5] staging: rtl8723bs: Fix block comment issue
Date:   Mon, 19 Jun 2023 20:12:30 +0200
Message-Id: <20230619181230.19070-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230619175703.18826-1-franziska.naepelt@gmail.com>
References: <20230619175703.18826-1-franziska.naepelt@gmail.com>
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

Fix the following checkpatch block comment issue:
- WARNING: Block comments use * on subsequent lines

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index abda4e0f0bf5..b65b5372bbcb 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -328,11 +328,11 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
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

