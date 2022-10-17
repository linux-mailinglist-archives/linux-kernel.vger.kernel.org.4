Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F69600A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiJQJOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJQJN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:13:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD3020F6C;
        Mon, 17 Oct 2022 02:13:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d10so10522780pfh.6;
        Mon, 17 Oct 2022 02:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnqdZrpjB39egxtL+QCzwuA4NRAaJFbgBz0XDUCs42M=;
        b=nd36XPAfDfSTx/DgtkL1HGUbatdbwalbwITd1kDXsmYT72i/kdQsKBSlysBh01WhYs
         9XVXJFLT67zS8zBm7Jf5d1kL2y/14fdKa73I/qUwJEKf/YcgDAueUic7cVNmoCCEzT1h
         I/ZWCpa6X49lPwVZ9cm1wQp5WjM27MglqkICXUcJZc3wGV/k4ZY8PSBz45VO3HkEVCnb
         VK9J7qdByc7nlweGQ5LuX1yZFxcHOvUa/aQN+cM68KN2ldp8Q7qtmOcfKdiUWq8QXHRq
         7X6oBZsibeyPw2BG0wZtmfvW6FnDa1PbxQsJBCgUJyq3OwJEmCxwRzAzPodO5Sduq7ZX
         Miqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnqdZrpjB39egxtL+QCzwuA4NRAaJFbgBz0XDUCs42M=;
        b=WKj/JrbWNNGpiyvgpHaUchSH9YS1VZtkJgRiVrHcqn/j5BQEVXC2WfSOn/eOYdmjT4
         fqiIvUHQF0tTYRgf3yURcalQWN777Mjg55A2cY/VVLE8nYlWRWXUggV7lr5CTZWmcbXB
         HgmeFpKTu7nnCaRaz7T4dtQ+R5qutgA0ay6JLJPfx9AJ8uRwTnWdRsZBY4XZchUu6C3h
         nFbZgxwY8Xb7Pc9C6rhKj/rGX/6/M1ASTFSJDJ+5z6Nwqb0vUKdvaR/qvDrRnhlXQAbL
         EkGmHNvQgoJsgQNIBzmpUpEF7VJiwumuBw4cwjdjnKrkJ2bwQEn3TtuHCJognXXGD2+c
         jPbQ==
X-Gm-Message-State: ACrzQf30+PB5YbYv7JgaWb65F9MqKfKN1Qo5zFEr/pawgxfRTC7U+7zq
        g7IPHMXrzbVT1mn1cvzmuoMJ5UhtDKQ=
X-Google-Smtp-Source: AMsMyM6QtHdlsuCl9xz9mrUjyDbSmA1eOCVEM4Mtf087T0lknWOpB6Vk/UEsRpX/41qbXZ859GwENA==
X-Received: by 2002:aa7:8a15:0:b0:566:1817:6fcf with SMTP id m21-20020aa78a15000000b0056618176fcfmr11620969pfa.85.1665998001583;
        Mon, 17 Oct 2022 02:13:21 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-4ca3-4989-34c1-7890.emome-ip6.hinet.net. [2001:b400:e258:8c34:4ca3:4989:34c1:7890])
        by smtp.gmail.com with ESMTPSA id t22-20020a170902b21600b0017f75bc7a61sm6091996plr.166.2022.10.17.02.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:13:21 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 23/26] mmc: core: add post-mmc_attach_sd hook
Date:   Mon, 17 Oct 2022 17:11:50 +0800
Message-Id: <20221017091153.454873-24-victor.shih@genesyslogic.com.tw>
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

