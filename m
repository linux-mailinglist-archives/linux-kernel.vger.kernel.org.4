Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CFC6439C3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiLFAEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiLFAEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:04:35 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED441CB24
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:04:32 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r18so11880890pgr.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Du9fC8uNx8ue3fvIkuE2kVsiCyslxGafpD/Atw5Se3c=;
        b=dVrWEz+M2VbizK97uaojc0bn58XNs+jECIOm4Dk4fuhywQcVIsQVd6m7RXVPtwsL8m
         ga6n0cdybF4Sh/FS6pqSX36CNLgxugRZ74aKcrmpBhw/lymbZwnHdW5+zTwgAZhesOFX
         P77S7byXu92e/BpKcIVT+gkAcCOPiTUr9HXqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Du9fC8uNx8ue3fvIkuE2kVsiCyslxGafpD/Atw5Se3c=;
        b=bnX89aIpmB3gEu1RuLt+Bqw+ChlrYL3ptb/VVP3/EIExpQE7R55eNA4nb/4cI9MgTx
         0xWsyNLqpIuzMIn/WPeid1rwbL7iBJhcpOa/w7wKK2An5YIePHOIPKuA05yxxkuVjolk
         5JZUZw2OSk27r0vMjVGjlteLe4Nc9aDjD1SF6qdjutc+ct7eJQ5B/d2pv54fX6anH6xt
         ndWByutSzM9GOOjuLrOhby38hT+2AvX/OsSAqZtZ2zdPyEpipgW6jEzqU6cCV3IvTH3D
         OJ6baqeKqXTAbXfUAF1Niq9ehTmn5ojv35e1ZjrX/2zHKuch0DJ7DNrB9mUmx55G4UON
         KwXQ==
X-Gm-Message-State: ANoB5pkWkThvwMDIXtBlzvWykIjrlOUhobYClj7GDagPicW+lTNWB+Rq
        2cWZAYSnpqbpDqTafIiv4Yd0lQ==
X-Google-Smtp-Source: AA0mqf6cuyzm+Fr2zJihuS/WC3/UZVnopQl0riVV+wrA94t5wzAD8Eq3DBs/aDN9xSvKEHFXMqaDCg==
X-Received: by 2002:a63:de4a:0:b0:429:983d:22f8 with SMTP id y10-20020a63de4a000000b00429983d22f8mr56608777pgi.165.1670285072207;
        Mon, 05 Dec 2022 16:04:32 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:9b83:ae6f:f47b:bb4d])
        by smtp.gmail.com with UTF8SMTPSA id z27-20020aa79e5b000000b00576f9773c81sm2382267pfq.211.2022.12.05.16.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 16:04:31 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Brian Norris <briannorris@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mmc: sdhci-brcmstb: Resolve "unused" warnings with CONFIG_OF=n
Date:   Mon,  5 Dec 2022 16:04:06 -0800
Message-Id: <20221205160353.1.I5fa28f1045f17fb9285d507accf139f8b2a8f4b5@changeid>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With W=1, we can see this gcc warning:

drivers/mmc/host/sdhci-brcmstb.c:182:34: warning: ‘sdhci_brcm_of_match’ defined but not used [-Wunused-const-variable=]
  182 | static const struct of_device_id sdhci_brcm_of_match[] = {
      |                                  ^~~~~~~~~~~~~~~~~~~

Rather than play around more with #ifdef's, the simplest solution is to
just mark this __maybe_unused.

Fixes: 1fad8422c989 ("mmc: sdhci-brcmstb: Allow building with COMPILE_TEST")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202212060700.NjMecjxS-lkp@intel.com/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/mmc/host/sdhci-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 55d8bd232695..f2cf3d70db79 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -179,7 +179,7 @@ static const struct brcmstb_match_priv match_priv_7216 = {
 	.ops = &sdhci_brcmstb_ops_7216,
 };
 
-static const struct of_device_id sdhci_brcm_of_match[] = {
+static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
 	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
 	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
 	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

