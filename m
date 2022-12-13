Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E82464B1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiLMJE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbiLMJCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:02:23 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F541057D;
        Tue, 13 Dec 2022 01:02:21 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 130so1727916pfu.8;
        Tue, 13 Dec 2022 01:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Kq/ZXg9ME6XTZIY0I3C/hVCMUMiXGyK0OXCfujvze4=;
        b=PCZigT/krisCTR5uD3N9K8HerxEPS2PQ0keSaKkk92eH+il+pE9hWS1lZAH4Rr6E08
         tV55ylKX8z/8bh43cmHVZyXNV6N9pEbteplRpCoMmhkBX9zd73FJjn7leu6kLHC2J/uq
         nExiU9+v2tkwNuzxZaIAXxfKBa2wR8LYYgxz5BBjKp448/LmdzvtD3mxAW44mHl0Fhy5
         T1XoInGXH1vVQnUs/pQ/tD0FjBPkaPBtV3txQvv1JAkphFaRZvqXx3JlmuHw/mSGoE5L
         FukBcZ45c8EKEqWUcobTqtA91h8OB4jhKkku4xk3or8WAGmvsJ9vWbpPjEFgK6EqXdq9
         lxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Kq/ZXg9ME6XTZIY0I3C/hVCMUMiXGyK0OXCfujvze4=;
        b=IwQyxJ81dMpAJTFsyce4d6eLB4gYTymKewM/ffbZ5b+TNVgGSTkJKvEWm3gf/JUAKI
         uNRpCz5xHx6bJeHIO5Ou6huDe+PPBIFkj8w4/C8oE9B3CmSGOGIDQMtx+JwwR5edTXeO
         OY/bdh6wZSc1kKx05VmHDzSWY2o13MrocyJhF8/l93d6ajEVv1OvFORv+BRrkCbF6DGA
         ZTfUvG5rk9pwgBu+blc3lN31fUdp/5KCFASdxGRR1fK3nhNgq3NjXmhgTMdPpZ5X0s2P
         Xmb9R5ewEtDTt7Q663UH71AzpVwwQtBQk3oJqISz2IVW2kgpl8C9eXbqwFREPgoPNXhY
         kFMQ==
X-Gm-Message-State: ANoB5pklafeymbFA7nkJtJTnsWDpim2geKDZ1EMfPT/0uRr04u0dt46S
        m3r5SxOKd9FD/ThMaFWLqUI=
X-Google-Smtp-Source: AA0mqf6IDPqKp8k4XFuNlBk+OAEWGVjfEYXBN2DJ8h+ZEJztM2/ZCYLsB4UBROSBRCdQfyonnrwYig==
X-Received: by 2002:aa7:93da:0:b0:576:de1:cd32 with SMTP id y26-20020aa793da000000b005760de1cd32mr20411121pff.0.1670922140695;
        Tue, 13 Dec 2022 01:02:20 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2dc-5c03-264b-f684-a8c9-21ae.emome-ip6.hinet.net. [2001:b400:e2dc:5c03:264b:f684:a8c9:21ae])
        by smtp.gmail.com with ESMTPSA id 81-20020a621954000000b0056b9ec7e2desm7141682pfz.125.2022.12.13.01.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:02:20 -0800 (PST)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V6 22/24] mmc: sdhci-uhs2: add post-mmc_attach_sd hook
Date:   Tue, 13 Dec 2022 17:00:45 +0800
Message-Id: <20221213090047.3805-23-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
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

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "post" hook for mmc_attach_sd(), uhs2_post_attach_sd, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index e5f64b38e339..4aac22b58d79 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -728,6 +728,7 @@ struct sdhci_ops {
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
 	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
+	void    (*uhs2_post_attach_sd)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

