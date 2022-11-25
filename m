Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29536638272
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 03:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKYCgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 21:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKYCgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 21:36:50 -0500
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C60201A4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 18:36:48 -0800 (PST)
X-QQ-mid: bizesmtpipv603t1669343743tnh7
Received: from localhost ( [255.247.32.13])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 25 Nov 2022 10:35:42 +0800 (CST)
X-QQ-SSF: 01400000000000808000000A0000000
X-QQ-FEAT: QityeSR92A3dShHjHF8RsM9yiu2Q2Ne7hsBOlzPkuXjJQ4IpaXKqVyouhC9My
        GEYFCakqW2Muw1oYu9JfMPPQGqFxcO5h6LQbRJpHuUJ1KyyykS5O8YXKxzci/zGelBnHOsW
        Maq0r8WTL5SnME05uq0YQoAsu5PXhKLQ8WGFf4jgoFF+/aXeA4VDYQ5XYLacaEPhHKttDJ7
        1MG6bEIyUrG2fQGK484smlhekFmmYomsJZ1RJKDe7cd8s8yE9W9s/o3EhNvDeVvLbIxocNv
        YMrlc2mQYbTW+5tOIYxg6KgFP6o3BQ3x2Rq9pvKUf+DYvpRLpRIF30yzUddm41ppvb40imP
        C4qtE/KEdECtNAS6XnJlywEU+Oy7Q==
X-QQ-GoodBg: 2
Date:   Fri, 25 Nov 2022 10:35:41 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk-scpi: Modify to recall scpi_clocks_probe
Message-ID: <950BEC68ABB5129B+Y4Ap/WUNrJ2BTmYD@TP-P15V.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:ucas.com.cn:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify to recall scpi_clocks_probe
and add to support Phytium FT2000/4 CPUs

Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
---
 drivers/clk/clk-scpi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
index a39af7616b13..fbc624c5a94a 100644
--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -268,8 +268,10 @@ static int scpi_clocks_probe(struct platform_device *pdev)
 	struct device_node *child, *np = dev->of_node;
 	const struct of_device_id *match;
 
+	/* Wang Honghui modified, the func will not be recalled
+	 * if return -EIO, but will if return -EPROBE_DEFER */
 	if (!get_scpi_ops())
-		return -ENXIO;
+		return -EPROBE_DEFER;
 
 	for_each_available_child_of_node(np, child) {
 		match = of_match_node(scpi_clk_match, child);
@@ -299,10 +301,18 @@ static const struct of_device_id scpi_clocks_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, scpi_clocks_ids);
 
+/* Wang Honghui add to support Phytium FT2000/4 CPUs */
+static const struct acpi_device_id scpi_cpufreq_acpi_match[] = {
+        { .id = "PHYT8001" },
+        { }
+};
+MODULE_DEVICE_TABLE(acpi, scpi_clock_acpi_match);
+
 static struct platform_driver scpi_clocks_driver = {
 	.driver	= {
 		.name = "scpi_clocks",
 		.of_match_table = scpi_clocks_ids,
+		.acpi_match_table = scpi_cpufreq_acpi_match,
 	},
 	.probe = scpi_clocks_probe,
 	.remove = scpi_clocks_remove,
-- 
2.34.1

