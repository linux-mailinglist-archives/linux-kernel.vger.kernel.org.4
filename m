Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38896A643B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 01:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCAA1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 19:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCAA1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 19:27:01 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1416F166FE;
        Tue, 28 Feb 2023 16:27:01 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id cf14so12593034qtb.10;
        Tue, 28 Feb 2023 16:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677630420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJeL8n1akQBNQY4mRwitUTFXHR0Ml81lQFAgFs/9ooY=;
        b=K7bv3zo7nkCzf6deBRp4Lg5YJiKpmZGrVVrcwX6fMe04PLGbmPyiZ1MfpMFJQ3gczk
         PTyFy7vyLgLlx4rQsvY5iWzcRX3PiEerotSwO1e2S/uUms8G6rSLjchIcjEksVUEjiAm
         lqxx6nLANTkqsDfT2GGi0AknUbNFldAXU+7lx+ghL7WHK+3w+CaZW0Jan14INQZhOML9
         ojesxHzEYYczhj2+mxUoQOQVI0RHUXdx3ff+mDU8+OOYUEjKABkvjPah1T9R0sgtLfL1
         JRbjxDw92oE/6vsQ929iWXZ7ucRImszCuaADlO3+M6lK9IL4xYmXkipZHIL1URAUffnO
         DiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677630420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJeL8n1akQBNQY4mRwitUTFXHR0Ml81lQFAgFs/9ooY=;
        b=HG208m9fU3ciDls425w2tiUogZYUMWbUIOQCeRYakQUutMBUAzpJZgusb7lI35XXwr
         D/Tjei465eEM0zkt2rMPlUEmq0Gze3rMdyy4JFn1x6pZ+CZBSe5rTZCwp8MHjaSive+/
         tv3BrsUT+wEmFnfbp/0dsVNV0iIkOf60eYo+S/m3n9R2EgTolnBDOZGxIqM1rtNyi1N9
         3N0BC6+TWoMk+hiYmnYT1kAVcASsLNaKlul7UnCsbX7P84kDGXAYaAbSdK+N/stCDiuJ
         qUdy3v7tg7jwZyWFuYTxZgv03bnLcJr+gfvVP7Bm2RAfWlIZLeAi43NWWzEXE4tfraFA
         IHfg==
X-Gm-Message-State: AO0yUKW8YToiK82jw3Tm3H1ml+Wn+DMFD4itJ6m8BC9PmUU/37TFQYrD
        /zcvITfm5Kg4e1QsfmBIiFQ=
X-Google-Smtp-Source: AK7set8zokOxucIULtSs5zhdVozPV61o7zflDRvd+aPvYt9Y7AQE+0kZsw5WSyFy3Fvn+3de2l1rkQ==
X-Received: by 2002:a05:622a:1746:b0:3bf:dbd3:a014 with SMTP id l6-20020a05622a174600b003bfdbd3a014mr8768717qtk.45.1677630420219;
        Tue, 28 Feb 2023 16:27:00 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id t8-20020ac85888000000b003bb8c60cdf1sm7576698qta.78.2023.02.28.16.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 16:26:59 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Yimin Gu <ustcymgu@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/3] clk: k210: remove an implicit 64-bit division
Date:   Tue, 28 Feb 2023 19:26:55 -0500
Message-Id: <20230301002657.352637-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The K210 clock driver depends on SOC_CANAAN, which is only selectable
when !MMU on RISC-V. !MMU is not possible on 32-bit yet, but patches
have been sent for its enabling. The kernel test robot reported this
implicit 64-bit division there.

Replace the implicit division with an explicit one.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-riscv/202301201538.zNlqgE4L-lkp@intel.com/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1->V2:
 - new commit
V2->V3:
 - No change
---
 drivers/clk/clk-k210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-k210.c b/drivers/clk/clk-k210.c
index 67a7cb3503c3..4eed667eddaf 100644
--- a/drivers/clk/clk-k210.c
+++ b/drivers/clk/clk-k210.c
@@ -495,7 +495,7 @@ static unsigned long k210_pll_get_rate(struct clk_hw *hw,
 	f = FIELD_GET(K210_PLL_CLKF, reg) + 1;
 	od = FIELD_GET(K210_PLL_CLKOD, reg) + 1;
 
-	return (u64)parent_rate * f / (r * od);
+	return div_u64((u64)parent_rate * f, r * od);
 }
 
 static const struct clk_ops k210_pll_ops = {
-- 
2.39.0

