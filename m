Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD315F6E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJFTWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiJFTU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:20:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0034E8F956
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:20:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h13so1511760pfr.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6tAF1hlKcRXRaglDyCMR3c9nGqh5Uv8s0KPPalHG8Lo=;
        b=m42jC3QQ45EZrv9ciU7E6Bsoxm+6yP574gRbkfmVlNXV7lq8SmCSUXzuW2LT6hCpqR
         maqsDe/ELxw8IOcN9O2THLkKMoh7j79XqVCwGP3LjemyLoUs1FeIQiwCdhCDmUBTB/Uq
         t2t8p7T/LTM7nOTFsHPazbR/o3E1tDyzQZU0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6tAF1hlKcRXRaglDyCMR3c9nGqh5Uv8s0KPPalHG8Lo=;
        b=TtMd6wWNRZWAzmtotI8kiePfjAaiCPgU8s671AUHJ4B44qkaPIxYS2uKgwNnYEqfV9
         D9H5nQBjZ3vLbSdyURQS3oZTqnh1/sEX15rCTIRiEoeCkSCw8Z3X6UxunN0K9OrT70KH
         nrm44VtuOZS1Wkl6ta3MLT48kZJ2M9Qe2HSltbv+oIph+3jspC4vSL3GbF5LZlsQ1Bwp
         uNrdTwz//w8hVBYR6K9FBAYSx7q+I3OleVMFkYCh5FuE0kJhf4dGFWNCFj01Q/12rgmz
         wCsyhDiUP4nfeGNWwbmB4SpjTWcGTcmcjjrFE9wZNYdhixTVSjNyY6DLj1HPNVU5Iynw
         mYBw==
X-Gm-Message-State: ACrzQf1W9lFjWXihQwkcns9ki/8HocpoTYAgQit7MlQxz7P3I0F16Izx
        k76860QHr7qL0Np9Ngv1IGtWNw==
X-Google-Smtp-Source: AMsMyM6/Af9FYpQkSADmEp8NGwuvcd4cDCoe/9P+QYpwLMh5Jy0ea+KZ2vHqGQkCd1HD33R12fG6eQ==
X-Received: by 2002:a05:6a00:1a91:b0:562:b0b9:272f with SMTP id e17-20020a056a001a9100b00562b0b9272fmr440985pfv.71.1665084055494;
        Thu, 06 Oct 2022 12:20:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k3-20020a632403000000b00439920bfcbdsm103398pgk.46.2022.10.06.12.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:20:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>
Cc:     Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: ethernet: mediatek: Remove -Warray-bounds exception
Date:   Thu,  6 Oct 2022 12:20:52 -0700
Message-Id: <20221006192052.1742948-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC-12 emits false positive -Warray-bounds warnings with
CONFIG_UBSAN_SHIFT (-fsanitize=shift). This is fixed in GCC 13[1],
and there is top-level Makefile logic to remove -Warray-bounds for
known-bad GCC versions staring with commit f0be87c42cbd ("gcc-12: disable
'-Warray-bounds' universally for now").

Remove the local work-around.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105679

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/mediatek/Makefile |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/Makefile b/drivers/net/ethernet/mediatek/Makefile
index fe66ba8793cf..45ba0970504a 100644
--- a/drivers/net/ethernet/mediatek/Makefile
+++ b/drivers/net/ethernet/mediatek/Makefile
@@ -11,8 +11,3 @@ mtk_eth-$(CONFIG_NET_MEDIATEK_SOC_WED) += mtk_wed_debugfs.o
 endif
 obj-$(CONFIG_NET_MEDIATEK_SOC_WED) += mtk_wed_ops.o
 obj-$(CONFIG_NET_MEDIATEK_STAR_EMAC) += mtk_star_emac.o
-
-# FIXME: temporarily silence -Warray-bounds on non W=1+ builds
-ifndef KBUILD_EXTRA_WARN
-CFLAGS_mtk_ppe.o += -Wno-array-bounds
-endif

