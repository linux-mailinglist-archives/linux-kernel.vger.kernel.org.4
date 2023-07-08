Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C60A74BAFB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 03:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGHBTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 21:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGHBTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 21:19:18 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056C82123
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 18:19:17 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b2f0a140b7so2155631a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 18:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688779156; x=1691371156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pMf2ttY6PRhnasWEBwuZ08fJpAiDwds2NhjWZz0hZDw=;
        b=VMs7DYqKojHWgdK9TvcNIKSkf/E3g9IclSwld5/+ANWhlIjqwQzY+Y9DLAdQbpi8ez
         UMoe9exDemLi63bFv/V9fd3YjqrRCv+EiZ6Yi/hIexM0Rr4INCKkzqyXo8gmoNtnmbf6
         5MW37M+Mq7/x+NxLL+LtEyz4+pbxOmQ51keXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688779156; x=1691371156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMf2ttY6PRhnasWEBwuZ08fJpAiDwds2NhjWZz0hZDw=;
        b=SEYz+bhFVEpH5nqZGYamDeMdnflpqQRiWFv1NhKBmrRfS0vt6NeHTQDqDQINNAktVb
         shh9ozaIOA0Fc3OitWmE4dxwfNUwOlwi/eMJpqtqZMFe4ksom2YISHCttxu9Q/tEgK3u
         KctgSZ08kznYnZbKwPxfTOtfv4zth5XW6xVqPn4HUpRUaxtY6YdMnLLdU8WELgcrwN8w
         nhEzXujpi7PDthl6gp79VTbtZlNKx0zGJvqltCXdO2umwsYVGx7fLmtCmYA7VeL/Y4aO
         lU/W+gHq3/ToWoO04Bj8GiXhwaHDWKdywMct66PxFFGvaz+0isWOqTu9aFqSXhlTfAau
         48dQ==
X-Gm-Message-State: ABy/qLZ0Z7RlHuGiSyLn8BnVMINBCbPw9qJwthnmECAIq8Kh2vv5uU+p
        38sY8tbdI/WxJDNAJ1MxT+JLLAY6O8WHHuQ00aQ=
X-Google-Smtp-Source: APBJJlEO/z8kw20FTdp4B5Ds+WqJA4+yUAwNJ80NBAv/B4rD/TQbA9fO2P0EeoQFLn2YjmDlr948aA==
X-Received: by 2002:a9d:7617:0:b0:6b8:19d8:6925 with SMTP id k23-20020a9d7617000000b006b819d86925mr7099672otl.12.1688779155962;
        Fri, 07 Jul 2023 18:19:15 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id h14-20020a02c72e000000b0042af7792d7dsm1607169jao.97.2023.07.07.18.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 18:19:15 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     mario.limonciello@amd.com, kramasub@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Li Zhe <lizhe.67@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zhou jie <zhoujie@nfschina.com>
Subject: [PATCH] init: Don't proxy console= to earlycon
Date:   Fri,  7 Jul 2023 19:17:25 -0600
Message-ID: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now we are proxying the `console=XXX` command line args to the
param_setup_earlycon. This is done because the following are
equivalent:

    console=uart[8250],mmio,<addr>[,options]
    earlycon=uart[8250],mmio,<addr>[,options]

In addition, when `earlycon=` or just `earlycon` is specified on the
command line, we look at the SPCR table or the DT to extract the device
options.

When `console=` is specified on the command line, it's intention is to
disable the console. Right now since we are proxying the `console=`
flag to the earlycon handler, we enable the earlycon_acpi_spcr_enable
variable when an SPCR table is present. This means that we
inadvertently enable the earlycon.

This change makes it so we only proxy the console= command if it's
value is not empty. This way we can correctly handle both cases.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 init/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index aa21add5f7c54..f72bf644910c1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -738,8 +738,7 @@ static int __init do_early_param(char *param, char *val,
 	for (p = __setup_start; p < __setup_end; p++) {
 		if ((p->early && parameq(param, p->str)) ||
 		    (strcmp(param, "console") == 0 &&
-		     strcmp(p->str, "earlycon") == 0)
-		) {
+		     strcmp(p->str, "earlycon") == 0 && val && val[0])) {
 			if (p->setup_func(val) != 0)
 				pr_warn("Malformed early option '%s'\n", param);
 		}
-- 
2.41.0.255.g8b1d071c50-goog

