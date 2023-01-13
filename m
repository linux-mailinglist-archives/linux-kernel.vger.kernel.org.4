Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370026688BE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbjAMAyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjAMAyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:54:09 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3D7AE64
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 16:54:08 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id v23so16996982plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 16:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xsayLyP7nh0k2HOHnHJ4pw0bqMbBUybwNSC5DyRKIC8=;
        b=bMip9NCrJH3DnbTyVthFl9yIiF3j/16C2WV0j690Wq/w/Ow5h3S79FZMagva/XpF7e
         tXprTN8l54WBgwPZqJBu+hiHHC+UWMy0S1sDG/zAi1P0y/InvPPN7uWHrPBB4hYIiGUO
         0K5gjGa5AztHL5McB0FbEiUggdnsWQcrr3g/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsayLyP7nh0k2HOHnHJ4pw0bqMbBUybwNSC5DyRKIC8=;
        b=SYuRKLtYbVaBle0Y3bHQNnzaQqOXGjZBz6883AoHnwXaguWlAFPQaSZEPdmd5QYDUh
         /VpPf4FjlhtcFnx+7P+pX36j4qv/Es41U3JSwEyE5pghzG+/mZYI7uPE1OwctdyEFMXu
         LPosn5IH0AMGJOSgqmcgAIoaagKlbnnV7QxZiAn0fdjYnJf1+xAweMc/62rDeYON1j+p
         CoiNq1rV92K99U4BF5Mo4GisIq6ItOjR+KvtOfvRs3hRAVH7cbd6LiM9BJV9CybBeHF7
         1biUZr5CUy0IeE9cT0uGQbTbX7PpedD/nxE0eoMtYmxWb18movSEtZ/LvG0Jsj+M1ZRx
         Nvjg==
X-Gm-Message-State: AFqh2kosthovRWt3kd5mLP0GY9kXZbEnjjDbw25czttBNTJF396lmDCJ
        vyamSuMXTZjRB4orJlzZXegQXQ==
X-Google-Smtp-Source: AMrXdXsLH6UhWCasDyJvsSNInG39OEZLlwb5rDlmlSiORB314t+bQ4mWVdUfo0L9yrPzsFD0DI9lCw==
X-Received: by 2002:a05:6a20:9591:b0:ad:7428:d326 with SMTP id iu17-20020a056a20959100b000ad7428d326mr100677310pzb.30.1673571248151;
        Thu, 12 Jan 2023 16:54:08 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:4652:3752:b9b7:29f9])
        by smtp.gmail.com with ESMTPSA id u11-20020a6540cb000000b0046ff3634a78sm10676614pgp.71.2023.01.12.16.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 16:54:07 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.15.y 0/4] phy: qcom-qmp-combo: Backport some stable fixes
Date:   Thu, 12 Jan 2023 16:54:01 -0800
Message-Id: <20230113005405.3992011-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the qmp phy driver was split it looks like 5.15.y stable kernels
aren't getting fixes like commit 7a7d86d14d07 ("phy: qcom-qmp-combo: fix
broken power on") which is tagged for stable 5.10. Trogdor boards use
the qmp phy on 5.15.y kernels, so I backported the fixes I could find
that looked like we may possibly trip over at some point.

USB and DP work on my Trogdor.Lazor board with this set.

Johan Hovold (4):
  phy: qcom-qmp-combo: disable runtime PM on unbind
  phy: qcom-qmp-combo: fix memleak on probe deferral
  phy: qcom-qmp-combo: fix broken power on
  phy: qcom-qmp-combo: fix runtime suspend

 drivers/phy/qualcomm/phy-qcom-qmp.c | 72 ++++++++++++++---------------
 1 file changed, 36 insertions(+), 36 deletions(-)

Cc: Johan Hovold <johan+linaro@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>

base-commit: d57287729e229188e7d07ef0117fe927664e08cb
-- 
https://chromeos.dev

