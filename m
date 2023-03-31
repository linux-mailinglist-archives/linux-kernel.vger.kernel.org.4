Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278046D1E95
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCaK7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjCaK63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:58:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884D120334;
        Fri, 31 Mar 2023 03:57:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso8436757pjf.0;
        Fri, 31 Mar 2023 03:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680260221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOx1y1Jd69koEjxiT6HO9K3rjpe/SDeJDjw2BGkWhNc=;
        b=dNFqwmJoAtjAPbH36EklXZf0y1aBwi5QcwLEzcpFo2UuRIVEKEYIMZ3Jgi9WzHyL3s
         4t5w/Ba0kq9jucRG42t3gYfbSLnsMWsxWk4TyYsrsxpPgXa8kIiHTdoNiSuoxjoBdEqf
         tIjYL0PzKT86JtQrZJ38AszIvqu+TfZ3hWe6IRoZM4I2kTQjtDkkndoftROUG8iwJxEX
         27Xoag4FOqtlvDG9/hebA8U8anIA0JY6agdVeBitpwMvlnvN4F7PdZ7R9N0zKccDoPaG
         gmrwxtMQqHZ8MAu+2UhKz95YO9ux9v1deqrPP4nrl47wwyWpjHSrnsuaAwyHiS3E1KXv
         RJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680260221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOx1y1Jd69koEjxiT6HO9K3rjpe/SDeJDjw2BGkWhNc=;
        b=Z39HxTZCl39hklVSleApcCeceW3PTzAW8rkgE7oaO7ryrECsVMOlzgDLiAfsB22XYI
         Hdr7GBGZlE8PV0aPBTZWb2UY6nDJuFSPgE1ATnRFRUaBKe3ZqiOKEgTqg8kJiZKCnbFw
         e4PV1VUhyT/im4y4OB/QqEWzH3WgfAjYn4keycUeujtS90q5h5fJUPwuV2s7rSCUsalT
         5j2XLBmpZQCNoICrhgmrBA16G4R/yS0kPdzWrZzWF50MeR20rR4fz5MCpBSB8U7OdtMZ
         IBp1VZxzl1k9DErwVvVOQCi32+inMG/ViXx1pH5zq8VXk//rELsIQ6gDQu0ot/XYt1WC
         vRPA==
X-Gm-Message-State: AAQBX9fiG5SuE5/DbyzQfJRiO40LigqulmtaIgQg5uF1DLvo9QXEE2yJ
        VAtFR4S3SRqi7zW990LjmDc=
X-Google-Smtp-Source: AKy350anmb6+ePaom2PlqOYuBl663fj/kmDFL50hXN8wj6LJV6PmgAmki9h5JTEDck7eZqNc2y6/Bg==
X-Received: by 2002:a17:90a:b10f:b0:23f:e4b7:afb3 with SMTP id z15-20020a17090ab10f00b0023fe4b7afb3mr30577831pjq.9.1680260221253;
        Fri, 31 Mar 2023 03:57:01 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-983f-c7ff-3efd-77d9-6c16.emome-ip6.hinet.net. [2001:b400:e25c:983f:c7ff:3efd:77d9:6c16])
        by smtp.gmail.com with ESMTPSA id f19-20020a170902e99300b0019acd3151d0sm1287665plb.114.2023.03.31.03.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 03:57:01 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V7 21/23] mmc: sdhci-uhs2: add pre-detect_init hook
Date:   Fri, 31 Mar 2023 18:55:44 +0800
Message-Id: <20230331105546.13607-22-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <Victor.Shih@genesyslogic.com.tw>

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 610780d425bc..610cd57864e4 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -1295,6 +1295,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("Begin do uhs2 detect init.\n");
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n",
 			mmc_hostname(host->mmc));
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index e16267f5a3c0..ec7e5d77a18a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -725,6 +725,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

