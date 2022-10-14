Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67845FED95
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJNLtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJNLsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:48:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EFBEAC97;
        Fri, 14 Oct 2022 04:48:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id m6so4724982pfb.0;
        Fri, 14 Oct 2022 04:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnqdZrpjB39egxtL+QCzwuA4NRAaJFbgBz0XDUCs42M=;
        b=gmJd4C5XOlGjJN+ycAuRwR9WfRxIaDNiG388OYwTvK2aZBntqYU33knr6MlRUQ6uXX
         yuLavc0u0tiIyptUqvhjZPQg5CxTYDYJOKq2m/gvikn1P7J26N8iFZICJdOksq8TOr9Z
         +2pDES0pidz10ETxC/NqQXPPM5QSLDtfcbnkJTGtYK51ByCkT22dM3UBMW1b+wwbGDI/
         90N9KceqlYhiMmBcH/E4dlxSKMhbuKJyg1BsjsPrh3FSKFfoN6edVfkvim2uUtyq6FzM
         cdoZ/oVaxdXsVP+uhJVNxa4+iePvzsnoSWSi5Iz+DJarL1DXhWkkutjPITw5/DRUVeIO
         xqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnqdZrpjB39egxtL+QCzwuA4NRAaJFbgBz0XDUCs42M=;
        b=sRfkBTouR44W4r40dcaD1alcy4CYlqX7pFkdkxZOEYA002frraxT/G+YqtRfqBZJdG
         rXtQsOhtSXHC7H/jgZnndeVI+VCY+/xCWAfcQz2hAmMKursyvByGlS00SZfrRcJJRyYW
         UI29KSArrtpnICkQ80vK7/jH5BRWOk6B7SgGzFattgSFBfwIjLirqR2Lx0L99qKYhcwm
         TOhsw6+sMlgpi5GK/EABAkkRfM7ovcRjH31tzaezNi9B0uCXVwm6glV/qFYr9rnX1eYn
         n/Ww8bDd+/nTH3fx8qjnhHd465coemsth8bO7yY+9OXhgFmCexir2k4gHNm64UwVwJoy
         TuJw==
X-Gm-Message-State: ACrzQf2mFWl9VF3oJioMNaf5ZSkQiNyszGLVOOpuJo1ffc8lP98lo/Ms
        0HFf8ompCv/jSC3oG7yEi/8=
X-Google-Smtp-Source: AMsMyM6NqJF4IH45VPrLnr+zaHePKt5M0BCmaF+/oUMK6Q4L7/YnXX73EAUuhI1YBRwl88rSb6eEZQ==
X-Received: by 2002:a05:6a00:26f4:b0:563:3fdc:8af0 with SMTP id p52-20020a056a0026f400b005633fdc8af0mr4698709pfw.63.1665748098162;
        Fri, 14 Oct 2022 04:48:18 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:48:17 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 23/26] mmc: core: add post-mmc_attach_sd hook
Date:   Fri, 14 Oct 2022 19:45:58 +0800
Message-Id: <20221014114601.15594-24-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
References: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
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

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

This "post" hook for mmc_attach_sd() will be required to enable UHS-II
support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/sd.c    | 6 ++++++
 include/linux/mmc/host.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index cab4725209c1..975987fb02a1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1855,6 +1855,12 @@ int mmc_attach_sd(struct mmc_host *host)
 		goto remove_card;
 
 	mmc_claim_host(host);
+
+	/* TODO: Is this the right place? */
+	if ((host->flags & MMC_UHS2_INITIALIZED) &&
+	    host->ops->uhs2_post_attach_sd)
+		host->ops->uhs2_post_attach_sd(host);
+
 	return 0;
 
 remove_card:
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index cf5adf26b6e4..e58be4ccb308 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -279,6 +279,7 @@ struct mmc_host_ops {
 	int	(*uhs2_set_reg)(struct mmc_host *host, enum sd_uhs2_operation act);
 	int (*uhs2_disable_clk)(struct mmc_host *host);
 	int (*uhs2_enable_clk)(struct mmc_host *host);
+	void (*uhs2_post_attach_sd)(struct mmc_host *host);
 
 	/*
 	 * The uhs2_control callback is used to execute SD UHS-II specific
-- 
2.25.1

