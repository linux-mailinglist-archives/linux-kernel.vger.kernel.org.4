Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF35560437B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJSLkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiJSLjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:39:48 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE8818DD65;
        Wed, 19 Oct 2022 04:18:36 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id y10so11100044qvo.11;
        Wed, 19 Oct 2022 04:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OHgLhUIrNFIk0lBsYkdz6+DUf1rYBFKSCvJhBu6Nus=;
        b=Hr7WIXw3n/KUXdPZEuxRbxVyAto8O6+MJ2ZzWfztJmFR4z+c04rXBkenfPAHG4uadB
         Cj6tSeTcRLJs8lEvNARrE+ABNa7ttgCYFRG5d0FdXVSzNhVnBCK2dCxnXP4GdQXrAamZ
         S0YUvKh79I9bwhZEid4TkSdOYo9GaAsOzgkhIAIyOHwbLNYav5VhLem4NltLYlJPyJGJ
         ybQyYENVTjtuVhLBN90uXfWWO5ke/2cs2+WceuESR58ov2IQeawsST+TDtbkpx4UYmMc
         +JPlZbEOgM33JoGYWkq86a6vVYbff32YlH4QtVdpRH8K2nYwMAkisnXeYO3k3E8AFpie
         lnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OHgLhUIrNFIk0lBsYkdz6+DUf1rYBFKSCvJhBu6Nus=;
        b=vwFhyfpxdh/0h4nzL+UHqQzCG0usJyMymp5o8n6kWO+nN9YacXFDsg8c4CpAlVXEm6
         ZJfZDwlyw0wKDhpHskILxLl5wDnDPx0AzlPLmQjWJ2Ys2jChOsv8ZPE71bRgK9MKdxT6
         EVNG0Cefcp0CrrwjlSEt5DrXVHnq42ageIqW5xfzHLCOKTl4IyW8SENDZ1p0u6Q0WLpQ
         5YtCBzIBXEMmMi2DWzC+Xvi63UKy7b5uh46sj5GoNivyMJHlCrtCbQQdCl7IOP5wt6LH
         6JkAoxxfbWw9z7FfJQ1zUWhScmSy4J9IZTXNF1oz+7pQnsoGkAl8L9el+UCRZYENiKJF
         AUaQ==
X-Gm-Message-State: ACrzQf3q3IyjEjOjx96G718iDzDBFPKQnfRcs6KzP/QfJeWZxvldaDvo
        1/qZcWFzcGAa2p3TIcjvT5ccSOBRiFI=
X-Google-Smtp-Source: AMsMyM5/UNqbb3dhoIAfYr/LMA/1dWQy5BakQtlUW6zhFsdAqSfEWkeDMTOg09U5WuU0+Ry/buXhRw==
X-Received: by 2002:a17:902:d2d2:b0:182:a32f:5ba1 with SMTP id n18-20020a170902d2d200b00182a32f5ba1mr7865489plc.88.1666177687501;
        Wed, 19 Oct 2022 04:08:07 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-821b-9613-557f-bd8d.emome-ip6.hinet.net. [2001:b400:e258:8c34:821b:9613:557f:bd8d])
        by smtp.gmail.com with ESMTPSA id cc11-20020a17090af10b00b0020dc318a43esm8696225pjb.25.2022.10.19.04.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:08:07 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 23/26] mmc: core: add post-mmc_attach_sd hook
Date:   Wed, 19 Oct 2022 19:06:44 +0800
Message-Id: <20221019110647.11076-24-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This "post" hook for mmc_attach_sd() will be required to enable UHS-II
support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/core/sd.c    | 5 +++++
 include/linux/mmc/host.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index cab4725209c1..3edd1530ec51 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1855,6 +1855,11 @@ int mmc_attach_sd(struct mmc_host *host)
 		goto remove_card;
 
 	mmc_claim_host(host);
+
+	if ((host->flags & MMC_UHS2_INITIALIZED) &&
+	    host->ops->uhs2_post_attach_sd)
+		host->ops->uhs2_post_attach_sd(host);
+
 	return 0;
 
 remove_card:
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 249a9414ad10..89e82559cb73 100644
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

