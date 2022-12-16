Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44DC64F439
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 23:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLPWjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 17:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLPWju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 17:39:50 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C8F61513
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 14:39:48 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t17so3824383pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 14:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yjEe+X5ai3YWKYGRZlLXYmobd2SS86iVTcoqGfxRbbE=;
        b=VxNX8eyUQb3zZYlBnW5S7ZI9VykZHgS/jkDy6zng5xEZH1jF944iWMGoR7xFVzypd0
         rp/quzNibbqoxoDA0w7J8iTZyo8E3Rg8sC0J2Caee84D+8O6z5vXhVDPDC+7u7LXUVfG
         cKEA9NX5mxAaMraVmZ3TrZ3f4Mqw5eMZH4IePswnc7lAeq+sWoSHKztSgWjGsTXrX9CW
         +VgZZSFJlH6ItJTF1w2EAuVcch7aW7wDAdksgmATtt7X83KFRiQ7k4CvFuqBvNMTdm4G
         v1aj0MIiSeFxjXHVt5M7f+rpwk41w3q6IUpfFUXwi5lYEAjQA6tCTmBmEadbB1B9K5R3
         Y+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjEe+X5ai3YWKYGRZlLXYmobd2SS86iVTcoqGfxRbbE=;
        b=sge255XIornKVT2DRwCd6T2U+Z241EV78565cE/8LX/u8blsSEOZhCpA6D80CCbr2E
         DLTFwOgw8XIAFrETn7XX5A55smFW2R9FzO1SCQg3fB8gXQfOn2bHKlldiZ7PoIxW5MaC
         2BwiWLSVpnRDSRDXAJil9UWKTRj7O8nyPg7uPOMgoMICxgDNlFoOCMcAiSqTqfhMrYBk
         H33gPHHj4fXyhv+OrQo/0uxY13pwz7Aem/APuk9rdriKOvY1n4kAJIt8jj/7FyrSDyEy
         Q41qtzHeimt8WNB+msj8thQDWjZB3VOAdrPWA/MiOiaiaBXkPs9DIhOBF/nyMekOkTBe
         xFyg==
X-Gm-Message-State: ANoB5pknL+HB4hzrKPk32lbiwqbWee0qEnSorY6WFauE65+U4z6imIZr
        gcL4YADs34PVRiqwnLMA5IM=
X-Google-Smtp-Source: AA0mqf75zoe5LtK8gvuEH7ivaB6zaeayqoUteJTi3v5FfVT5ebMwlMi+8LF+ABC/TBzztgGUhjHY6w==
X-Received: by 2002:a17:902:b093:b0:189:dcc3:e4a1 with SMTP id p19-20020a170902b09300b00189dcc3e4a1mr31886523plr.9.1671230388169;
        Fri, 16 Dec 2022 14:39:48 -0800 (PST)
Received: from localhost.localdomain ([14.5.161.132])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902f7ce00b00189c93ce5easm2107031plw.166.2022.12.16.14.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 14:39:47 -0800 (PST)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH] staging: r8188eu: Prefer kcalloc over kzalloc
Date:   Sat, 17 Dec 2022 07:39:42 +0900
Message-Id: <20221216223942.334221-1-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Fixed following checkpatch.pl warning:
 * WARNING: Prefer kcalloc over kzalloc with multiply

Instead of specifying (number of bytes) * (size) as arugment
in kzalloc, prefer kcalloc.

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 34494f08c0cd..36ce1e3f9c81 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1564,7 +1564,7 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
 
 	pxmitpriv->hwxmit_entry = HWXMIT_ENTRY;
 
-	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
+	pxmitpriv->hwxmits = kcalloc(pxmitpriv->hwxmit_entry, sizeof(struct hw_xmit), GFP_KERNEL);
 	if (!pxmitpriv->hwxmits)
 		return -ENOMEM;
 
-- 
2.34.1

