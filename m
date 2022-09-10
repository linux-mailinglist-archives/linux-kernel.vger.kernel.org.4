Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FC25B4792
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 19:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIJRCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 13:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIJRC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 13:02:26 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33693F33D;
        Sat, 10 Sep 2022 10:02:24 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4MPzgM60DhzDqvN;
        Sat, 10 Sep 2022 17:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1662829344; bh=40CNOPy3Zf9G7CPKUjgzQ5b0AiIYJrWS6ye7Qa6omZo=;
        h=From:To:Cc:Subject:Date:From;
        b=TV4fw4wzJlZjZIr7WONiIIE6dNAsUsTx5ntrqKSg/PaBo0ATN7H5ny0OUxdW06luV
         jS2gJwMq45AOPCPcWTT5OLiaE0IcQ+6Ir5f2lZxuFaRPkwCR6YfL3AA453C/OQHpl1
         YBIiXnMzZyDNfDg9X8YGM53O5NrqHWr4+Ihtb4W4=
X-Riseup-User-ID: 6F74CD9EDEECAE30F2DB5A65239CCBA773B5255B67D994F2842D6A0BD7DB0A28
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4MPzgJ2gkcz1xwy;
        Sat, 10 Sep 2022 17:02:20 +0000 (UTC)
From:   Dang Huynh <danct12@riseup.net>
To:     Dang Huynh <danct12@riseup.net>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: sm6115: Select QCOM_GDSC
Date:   Sun, 11 Sep 2022 00:02:07 +0700
Message-Id: <20220910170207.1592220-1-danct12@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on the Fxtec Pro1X device, this error shows up with
my own minimal configuration:

gcc-sm6115: probe of 1400000.clock-controller failed with error -38

The clock driver depends on CONFIG_QCOM_GDSC and after enabling
that, the driver probes successfully.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 drivers/clk/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 1cf1ef70e347..d566fbdebdf9 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -645,6 +645,7 @@ config SM_DISPCC_6350
 
 config SM_GCC_6115
 	tristate "SM6115 and SM4250 Global Clock Controller"
+	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SM6115 and SM4250 devices.
 	  Say Y if you want to use peripheral devices such as UART, SPI,
-- 
2.37.3

