Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D113D6FE137
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbjEJPKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237504AbjEJPKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:10:13 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8760A7AAE
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:10:09 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6439bbc93b6so4979644b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683731409; x=1686323409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BbmQvMf9KzmVdxCSRKyarW++yF6GCnmLwgE9M2RotW4=;
        b=ZtJb+YQhL1NxXiVYXH/As6s0vhSNRYSvBGb+N15NM9sSTgykg2AjFG9qO3PG1SSAdX
         3CzT1p1aXATma9d/PmwuFlgGVy7iPV0mFxdq0s4DTw30wK9x5u6+A4moyvlsOiikgmKe
         AebpEZLZg5GoW77NMWMF3/j1eyyDOkLUUU0EqMnk6swb6Fa0hyQ0dXmmyn2aywJMC7Kg
         zOTes6Wbgk23IVk/ItcrUYD/ki8KW08GvSbIgX6luFY4S1pMla1MDbBqgHS6hjyOjwtC
         ShxaC9GcJ/6967chkJuXT2NCet7fFBrtkg8OgXdS0F6KlQH5bM+1Nbl+4E+PuaK1vc+S
         7C8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683731409; x=1686323409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbmQvMf9KzmVdxCSRKyarW++yF6GCnmLwgE9M2RotW4=;
        b=UirqQkQ/Mi0NLqvFo1lhlWQ059tueRdiPn11Q/xTlIl6VfeKNP0EyX+Fp0d9p0j7Z9
         g8N40WxDWhRwbb/Hd1N8am8VvgcJsiplAw0afcfiYkue4gzhtIz1oKMzum8v9Q0YJuBm
         okHl8J+UornBTo3ET+Fj5UJRIc7APqoGIVDPB5THH9b7Chs8Su3DU0Sc4GrNrTPKuDOC
         pav9LXAqnblz1+Gb+bxq6QQTdZhJW+fmJ00T6a3IaEZSFkMX87M0IovFPit1mn1qvVJA
         c725W39rDRgjs1KHyaLzbwLmZuBlE+1lwxYCMVYmfWcxJivQvWpFBf3jaPISj23oG5h6
         MbMQ==
X-Gm-Message-State: AC+VfDzKQDr9t8b+NZoW3uS+75N7ZppmfgxFf6enq7+mYcS/QznXNHpq
        bOFkcIq4GG3O4Kwwvodt1SI=
X-Google-Smtp-Source: ACHHUZ4t+R6GTCWUl02uKMGgbAc5ywYmosUfP/6Gl+Jt3HupOylaw31Ww4uk5dzkv3/izFGWD7N64g==
X-Received: by 2002:a05:6a21:788f:b0:101:37b2:62f3 with SMTP id bf15-20020a056a21788f00b0010137b262f3mr8536263pzc.61.1683731408908;
        Wed, 10 May 2023 08:10:08 -0700 (PDT)
Received: from pop-os.localdomain ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id x6-20020aa793a6000000b00640f588b36dsm3697217pff.8.2023.05.10.08.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:10:08 -0700 (PDT)
Date:   Wed, 10 May 2023 20:40:04 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: rtl8192e: Refactor tmp_ofdm_index variable
 assignment
Message-ID: <af7bc22ec142c33cf7346c1ab13d192b55095d1e.1683730854.git.yogi.kernel@gmail.com>
References: <cover.1683730854.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683730854.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor tmp_ofdm_index variable assignment to avoid multiple
assignments which is not accepted by checkpatch.

Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index a44be3f810ab..feac50cd8fa0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -689,8 +689,8 @@ static void _rtl92e_dm_tx_power_tracking_cb_thermal(struct net_device *dev)
 	priv->thermal_meter[1] = ThermalMeterVal;
 
 	if (priv->thermal_meter[0] >= (u8)tmp_reg) {
-		tmp_ofdm_index = tmp_cck_20m_index = 6+(priv->thermal_meter[0] -
-			      (u8)tmp_reg);
+		tmp_ofdm_index = 6 + (priv->thermal_meter[0] - (u8)tmp_reg);
+		tmp_cck_20m_index = tmp_ofdm_index;
 		tmp_cck_40m_index = tmp_cck_20m_index - 6;
 		if (tmp_ofdm_index >= OFDM_TABLE_LEN)
 			tmp_ofdm_index = OFDM_TABLE_LEN - 1;
-- 
2.34.1

