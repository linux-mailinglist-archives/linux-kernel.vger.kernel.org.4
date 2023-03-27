Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862006CB056
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjC0VEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjC0VDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:03:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6626B2705
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:03:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h8so41556364ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679951008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AozKR2DoQOOyJHBglyYFmZBaHgy3GkeNuTZPAIS6qrc=;
        b=MVgyfKsxyF7IMhk6z/KTbB4cUeKi3N9CiLUP5+wDXffu0NBjZ1vTVkD9gutrRv3/28
         Nyj/Y2/H+keaqnF016TTUdblXefz0kpYHeoAFQKmLOdCwiO7ZaZ+wLYSPBEtPkFk/O1j
         eganBRmBIgU+utePVhgEk8Vk/i/WQIvVtvmXCswmk637rDwGiszFpX4SHrlp+5sxzL49
         jW1JrUUyW+7GOJSe/B34JY0FCI5cEb/7cnFbxV0VhaW9aoKJmg3UxcPEtxESd6r8BDO6
         feL5qQQf4yrI7s6rZAJjL3tyiGmclltYVZOxKsBeSiE+1cvDB6M0SiFveoohnu6sR0cL
         8BUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679951008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AozKR2DoQOOyJHBglyYFmZBaHgy3GkeNuTZPAIS6qrc=;
        b=Oi8MfS8HPjV3wFDsCFMNP1cFzFrjLWUXLrEhLlpkHidkZvqYrar8ffEIZfcN9PMR1o
         XW3JDTAPUDzQYAZVOS+rP4aDoTX1fEEBmQ9ZJqCqCiF/XKFeTgihBwJq4ZACCdtqNYoj
         xtMDeQgTT511/kqrlrlyDd/2dylXQYXNrYsaNrRHvSneBqqqFd4GaHmqI26TwJajdCZN
         Aer7bu2/4vHC3yMenj9u8562pbTD3nuscwN9rXfbjVMKYneHIfDqUqcsdJxd2BhkGqDp
         RqRgDSgtNtlwfGiu9OiOXT86xMfewANa5kbRfvcf3nEPaJsA8BN/ZGPHvzfHDf18GVSc
         fbJw==
X-Gm-Message-State: AAQBX9fYJgnsXvNy23VT2QjdbZnF3MLsYrJpAIOIQwpFA22OFvqm0qnb
        hM4u3PiULCrUPIkmgaeyBaI=
X-Google-Smtp-Source: AKy350ZK0tpkIhJczcUkPG0Uonl+xK8i3Ec6WYb/RETj2/9m5xG31AKWZnZq2aowbnlkT+3PpTR5vQ==
X-Received: by 2002:a17:906:49:b0:944:4d7:d3d9 with SMTP id 9-20020a170906004900b0094404d7d3d9mr6011882ejg.2.1679951007840;
        Mon, 27 Mar 2023 14:03:27 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id lg10-20020a170906f88a00b008cc920469b5sm14541859ejb.18.2023.03.27.14.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:03:21 -0700 (PDT)
Date:   Mon, 27 Mar 2023 23:03:06 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] staging: rtl8192e: Remove wireless modes A, N_5G from
 rtl92e_set_channel
Message-ID: <aaaf832fe5f90ad2c618bef22c1bdbd5209c4359.1679949171.git.philipp.g.hortmann@gmail.com>
References: <cover.1679949171.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679949171.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove WIRELESS_MODE_N_5G and WIRELESS_MODE_A as those are not supported
by hardware and to improve readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 139d8268c8dc..dd666701138e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -696,15 +696,6 @@ u8 rtl92e_set_channel(struct net_device *dev, u8 channel)
 
 
 	switch (priv->rtllib->mode) {
-	case WIRELESS_MODE_A:
-	case WIRELESS_MODE_N_5G:
-		if (channel <= 14) {
-			netdev_warn(dev,
-				    "Channel %d not available in 802.11a.\n",
-				    channel);
-			return false;
-		}
-		break;
 	case WIRELESS_MODE_B:
 		if (channel > 14) {
 			netdev_warn(dev,
-- 
2.39.2

