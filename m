Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8B45FACD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJKGa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJKGaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:30:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F13DFACF;
        Mon, 10 Oct 2022 23:30:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so15100223pjs.0;
        Mon, 10 Oct 2022 23:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6UtDTfgFsScPFwM9ThkOEZaeBo79ZpfsnwoNicUbs0=;
        b=MZwiGYYcJBV3L+vUZdlbsY47foIqgnLFMYz0M7jMl31jIxPRcmfqP1fcdDY7dlEx4p
         6gydKHnNfK4FaNOlzu0VJ24kAW4Jj9bAD+h+/UupOmCwKykyC2Bxq5+JI+fr8CTwyI8g
         9tjlCR/t+uFD7TTsEklgqOxvjny8gP/B5yxFIMO5uD+5JOZkM6hnAqHhzYuDAGcbcUyc
         zo9dFFkSpW238SzUmcfu2bnjZkPiL8PIZReNHw6pYjxyE+/Dj4cgs7FzzSGF8uOvhG8l
         nZ0AJ4JqA0akcjZnK9NHEgvQDp81BaiJc+wiYUN3DCnqdPgAxYBAIerlvfWyBeASVwv6
         Pxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6UtDTfgFsScPFwM9ThkOEZaeBo79ZpfsnwoNicUbs0=;
        b=4PoCmcKrvMqtNp9Yj1YwmmPLqGOwFhk2bziQztIEKvMYXwfI9t87w4FRTq6vLsrcI5
         aX6KeVMzve659LbmGsAGaSoZq6wGDvO0TjMqDiN5Y3QQPCwJLIIA8ZKdVrqGr2sdKrpG
         /xNrp+ESoJJSc4uaVttzDC5hTvtll2WR/5NDBcK4G1Ax/tqqUS4pQkA+rcDkOs8DN+z7
         CANG+eR9zYa6+cdcZV5Gu9uYUkT1YCgugzb9Ib21kLsfrin0gyPLPEDTK4d1W1N5rhs9
         91Ua5kLza92hkXEUKka16wOwZ/u8eJW8PmUc494NuRxOE1KkESicHfItUfDNBtZ8W1HP
         gMEQ==
X-Gm-Message-State: ACrzQf1p/RW6/nSpRjkl0uIVAMhZOFKfZZr96NUJDpouOspMmPKsNzZa
        q8JP/UYRMuU1wucc4SMCssc=
X-Google-Smtp-Source: AMsMyM6UPGGuYpMTkXQsECnqXsylOwk/pfeTfcQnyjHJYCdIzecHGfTkWhwpYa7XQm2Sfl4U9oxRXg==
X-Received: by 2002:a17:902:f647:b0:183:cb8d:40a0 with SMTP id m7-20020a170902f64700b00183cb8d40a0mr1075546plg.18.1665469850890;
        Mon, 10 Oct 2022 23:30:50 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i16-20020a17090332d000b00174c235e1fdsm4096307plr.199.2022.10.10.23.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 23:30:50 -0700 (PDT)
From:   Wenchao Chen <wenchao.chen666@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
Subject: [PATCH] mmc: sdhci-sprd: Fix minimum clock limit
Date:   Tue, 11 Oct 2022 14:30:43 +0800
Message-Id: <20221011063043.11074-1-wenchao.chen666@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenchao Chen <wenchao.chen@unisoc.com>

The minimum clock supported by SPRD Host is 100000.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/host/sdhci-sprd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 46c55ab4884c..b92a408f138d 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -309,7 +309,7 @@ static unsigned int sdhci_sprd_get_max_clock(struct sdhci_host *host)
 
 static unsigned int sdhci_sprd_get_min_clock(struct sdhci_host *host)
 {
-	return 400000;
+	return 100000;
 }
 
 static void sdhci_sprd_set_uhs_signaling(struct sdhci_host *host,
-- 
2.17.1

