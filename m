Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6538600A33
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiJQJPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiJQJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:14:03 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4893FED5;
        Mon, 17 Oct 2022 02:13:27 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 129so9920136pgc.5;
        Mon, 17 Oct 2022 02:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJyxTTeGNHxq9RsExK67ky3HBRhQX3BCNFgWjcG3gFE=;
        b=UUQskCnTbYHvB1seZphzDZF7q3qA9B2Svw78Jq2hwRG/epyeH6a8SoYf887239wUYW
         dDbYGV7y9+ghmGzE2hfWXzRawvAOzoqWDeA9ZYw08g+l7ZMD3UtlV8AfyTQRgXp698ii
         nSPGWOJHb5M76FeajPQIIJG+vXRLyrmMhksLffsE5XX2VleI1KGVdnCdqt3K06tPdJyG
         ybl0e91jtKDTJilArAcHHjsnuflt9Mg2ZY60J+w/L3Ctr4xW7VsGo2MnQzTNkIJJ2rbO
         W4htSKbOJ6CbjGXeGJmOjNRwDZ9rhS8Lw5PRc4OoVYJwiEIaFQRVICCnhgsRIR7diuSi
         lppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJyxTTeGNHxq9RsExK67ky3HBRhQX3BCNFgWjcG3gFE=;
        b=3qgqVgEm0ZKUYdwX+3QQ2HHd44jz8tQhtCc2FdLOgs9IvHETxqRmNm6BiZ9z3tMheX
         IhR9poDtguZjZICsUMlzxYUb/KwdvywW8ao042Mc3/z2mK22D/43wn56oxHXizGIJedA
         eJOslEm5lktFyUHhMxpcRQvDyhh41ujBnzLq17ekMNa7oh5f8TMPkJle4J7tuAisfAWX
         DWzH2syZ0VFIVHg2yT1aKcl3P1BFRtxX1GFIBMgi6hhz0ex3S8zKHdHkIio//cbcXYqT
         SJS/G3ME3B+iRP0OSUJihjnTHooCoDKtjMO1lm2Thhy4449eZ9ymy8V+Zfy2NWF/zc8M
         lKvw==
X-Gm-Message-State: ACrzQf0sc1gT6G0r80KRrtw0F8jjBry4y+5JMwKGrv8FyJrfv9e9Yp9E
        n78/BOL4yzgrI+OrDQHIEps=
X-Google-Smtp-Source: AMsMyM6v1dx51CZmTHpX2YniNZQRqu7Bt+5N/kdsHKcB2EhZZYfyjJHSl43ez9mH57TrcXaXAZpWvw==
X-Received: by 2002:a05:6a00:1ca4:b0:562:daf9:6162 with SMTP id y36-20020a056a001ca400b00562daf96162mr11578722pfw.40.1665998005104;
        Mon, 17 Oct 2022 02:13:25 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-4ca3-4989-34c1-7890.emome-ip6.hinet.net. [2001:b400:e258:8c34:4ca3:4989:34c1:7890])
        by smtp.gmail.com with ESMTPSA id t22-20020a170902b21600b0017f75bc7a61sm6091996plr.166.2022.10.17.02.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:13:24 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 24/26] mmc: sdhci-uhs2: add post-mmc_attach_sd hook
Date:   Mon, 17 Oct 2022 17:11:51 +0800
Message-Id: <20221017091153.454873-25-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
References: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
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
index 943701aef22a..e81de556cf78 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -746,6 +746,7 @@ struct sdhci_ops {
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
 	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
+	void    (*uhs2_post_attach_sd)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

