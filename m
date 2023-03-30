Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE276D10CC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjC3VXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjC3VWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:22:53 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0245AEB5A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:22:32 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 14295 invoked from network); 30 Mar 2023 23:22:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1680211348; bh=QIY+Cqwr1th//Ivh3IGu99VnIHLYr17wMK1kIJKbAKc=;
          h=From:To:Cc:Subject;
          b=JaOfEGmcfDHi2WfT15c3/7x9kzcXdm8yC7oDQUjL0mtc8jKzfW1/x34K1kYRfoWrt
           QbUdXbXkWnqqDlDWzDZjLBLRSgYSVTvDnRGwXdSPNhypIpnYj1H3VpCffMSo6Bm95Y
           zS7WcRC3oPG1v+09MEOKFcYcqIjZO1gN2ynGdJSc=
Received: from 79.184.247.17.ipv4.supernova.orange.pl (HELO LAPTOP-OLEK.home) (olek2@wp.pl@[79.184.247.17])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linus.walleij@linaro.org>; 30 Mar 2023 23:22:27 +0200
From:   Aleksander Jan Bajkowski <olek2@wp.pl>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH 1/2] pinctrl: xway: drop the deprecated compatible strings
Date:   Thu, 30 Mar 2023 23:22:24 +0200
Message-Id: <20230330212225.10214-1-olek2@wp.pl>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                      
X-WP-MailID: 49b86376a3219b7503751b9624290d06
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [kaOE]                               
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code are marked as deprecated since kernel 4.5[1]. Downstream OpenWRT
and upstream switched to the new string compatible 7 years ago. The old
compatible strings can safely be dropped.

[1] commit be14811c03cf ("pinctrl/lantiq: introduce new dedicated devicetree bindings")

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/pinctrl/pinctrl-xway.c | 252 ---------------------------------
 1 file changed, 252 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-xway.c b/drivers/pinctrl/pinctrl-xway.c
index 3a03beb8a755..858abb23b337 100644
--- a/drivers/pinctrl/pinctrl-xway.c
+++ b/drivers/pinctrl/pinctrl-xway.c
@@ -107,243 +107,6 @@ enum xway_mux {
 	XWAY_MUX_NONE = 0xffff,
 };
 
-/* ---------  DEPRECATED: xr9 related code --------- */
-/* ----------  use xrx100/xrx200 instead  ---------- */
-#define XR9_MAX_PIN		56
-
-static const struct ltq_mfp_pin xway_mfp[] = {
-	/*       pin    f0	f1	f2	f3   */
-	MFP_XWAY(GPIO0, GPIO,	EXIN,	NONE,	TDM),
-	MFP_XWAY(GPIO1, GPIO,	EXIN,	NONE,	NONE),
-	MFP_XWAY(GPIO2, GPIO,	CGU,	EXIN,	GPHY),
-	MFP_XWAY(GPIO3, GPIO,	CGU,	NONE,	PCI),
-	MFP_XWAY(GPIO4, GPIO,	STP,	NONE,	ASC),
-	MFP_XWAY(GPIO5, GPIO,	STP,	GPHY,	NONE),
-	MFP_XWAY(GPIO6, GPIO,	STP,	GPT,	ASC),
-	MFP_XWAY(GPIO7, GPIO,	CGU,	PCI,	GPHY),
-	MFP_XWAY(GPIO8, GPIO,	CGU,	NMI,	NONE),
-	MFP_XWAY(GPIO9, GPIO,	ASC,	SPI,	EXIN),
-	MFP_XWAY(GPIO10, GPIO,	ASC,	SPI,	NONE),
-	MFP_XWAY(GPIO11, GPIO,	ASC,	PCI,	SPI),
-	MFP_XWAY(GPIO12, GPIO,	ASC,	NONE,	NONE),
-	MFP_XWAY(GPIO13, GPIO,	EBU,	SPI,	NONE),
-	MFP_XWAY(GPIO14, GPIO,	CGU,	PCI,	NONE),
-	MFP_XWAY(GPIO15, GPIO,	SPI,	JTAG,	NONE),
-	MFP_XWAY(GPIO16, GPIO,	SPI,	NONE,	JTAG),
-	MFP_XWAY(GPIO17, GPIO,	SPI,	NONE,	JTAG),
-	MFP_XWAY(GPIO18, GPIO,	SPI,	NONE,	JTAG),
-	MFP_XWAY(GPIO19, GPIO,	PCI,	NONE,	NONE),
-	MFP_XWAY(GPIO20, GPIO,	JTAG,	NONE,	NONE),
-	MFP_XWAY(GPIO21, GPIO,	PCI,	EBU,	GPT),
-	MFP_XWAY(GPIO22, GPIO,	SPI,	NONE,	NONE),
-	MFP_XWAY(GPIO23, GPIO,	EBU,	PCI,	STP),
-	MFP_XWAY(GPIO24, GPIO,	EBU,	TDM,	PCI),
-	MFP_XWAY(GPIO25, GPIO,	TDM,	NONE,	ASC),
-	MFP_XWAY(GPIO26, GPIO,	EBU,	NONE,	TDM),
-	MFP_XWAY(GPIO27, GPIO,	TDM,	NONE,	ASC),
-	MFP_XWAY(GPIO28, GPIO,	GPT,	NONE,	NONE),
-	MFP_XWAY(GPIO29, GPIO,	PCI,	NONE,	NONE),
-	MFP_XWAY(GPIO30, GPIO,	PCI,	NONE,	NONE),
-	MFP_XWAY(GPIO31, GPIO,	EBU,	PCI,	NONE),
-	MFP_XWAY(GPIO32, GPIO,	NONE,	NONE,	EBU),
-	MFP_XWAY(GPIO33, GPIO,	NONE,	NONE,	EBU),
-	MFP_XWAY(GPIO34, GPIO,	NONE,	NONE,	EBU),
-	MFP_XWAY(GPIO35, GPIO,	NONE,	NONE,	EBU),
-	MFP_XWAY(GPIO36, GPIO,	SIN,	NONE,	EBU),
-	MFP_XWAY(GPIO37, GPIO,	PCI,	NONE,	NONE),
-	MFP_XWAY(GPIO38, GPIO,	PCI,	NONE,	NONE),
-	MFP_XWAY(GPIO39, GPIO,	EXIN,	NONE,	NONE),
-	MFP_XWAY(GPIO40, GPIO,	NONE,	NONE,	NONE),
-	MFP_XWAY(GPIO41, GPIO,	NONE,	NONE,	NONE),
-	MFP_XWAY(GPIO42, GPIO,	MDIO,	NONE,	NONE),
-	MFP_XWAY(GPIO43, GPIO,	MDIO,	NONE,	NONE),
-	MFP_XWAY(GPIO44, GPIO,	MII,	SIN,	GPHY),
-	MFP_XWAY(GPIO45, GPIO,	NONE,	GPHY,	SIN),
-	MFP_XWAY(GPIO46, GPIO,	NONE,	NONE,	EXIN),
-	MFP_XWAY(GPIO47, GPIO,	MII,	GPHY,	SIN),
-	MFP_XWAY(GPIO48, GPIO,	EBU,	NONE,	NONE),
-	MFP_XWAY(GPIO49, GPIO,	EBU,	NONE,	NONE),
-	MFP_XWAY(GPIO50, GPIO,	NONE,	NONE,	NONE),
-	MFP_XWAY(GPIO51, GPIO,	NONE,	NONE,	NONE),
-	MFP_XWAY(GPIO52, GPIO,	NONE,	NONE,	NONE),
-	MFP_XWAY(GPIO53, GPIO,	NONE,	NONE,	NONE),
-	MFP_XWAY(GPIO54, GPIO,	NONE,	NONE,	NONE),
-	MFP_XWAY(GPIO55, GPIO,	NONE,	NONE,	NONE),
-};
-
-static const unsigned pins_jtag[] = {GPIO15, GPIO16, GPIO17, GPIO19, GPIO35};
-static const unsigned pins_asc0[] = {GPIO11, GPIO12};
-static const unsigned pins_asc0_cts_rts[] = {GPIO9, GPIO10};
-static const unsigned pins_stp[] = {GPIO4, GPIO5, GPIO6};
-static const unsigned pins_nmi[] = {GPIO8};
-static const unsigned pins_mdio[] = {GPIO42, GPIO43};
-
-static const unsigned pins_gphy0_led0[] = {GPIO5};
-static const unsigned pins_gphy0_led1[] = {GPIO7};
-static const unsigned pins_gphy0_led2[] = {GPIO2};
-static const unsigned pins_gphy1_led0[] = {GPIO44};
-static const unsigned pins_gphy1_led1[] = {GPIO45};
-static const unsigned pins_gphy1_led2[] = {GPIO47};
-
-static const unsigned pins_ebu_a24[] = {GPIO13};
-static const unsigned pins_ebu_clk[] = {GPIO21};
-static const unsigned pins_ebu_cs1[] = {GPIO23};
-static const unsigned pins_ebu_a23[] = {GPIO24};
-static const unsigned pins_ebu_wait[] = {GPIO26};
-static const unsigned pins_ebu_a25[] = {GPIO31};
-static const unsigned pins_ebu_rdy[] = {GPIO48};
-static const unsigned pins_ebu_rd[] = {GPIO49};
-
-static const unsigned pins_nand_ale[] = {GPIO13};
-static const unsigned pins_nand_cs1[] = {GPIO23};
-static const unsigned pins_nand_cle[] = {GPIO24};
-static const unsigned pins_nand_rdy[] = {GPIO48};
-static const unsigned pins_nand_rd[] = {GPIO49};
-
-static const unsigned xway_exin_pin_map[] = {GPIO0, GPIO1, GPIO2, GPIO39, GPIO46, GPIO9};
-
-static const unsigned pins_exin0[] = {GPIO0};
-static const unsigned pins_exin1[] = {GPIO1};
-static const unsigned pins_exin2[] = {GPIO2};
-static const unsigned pins_exin3[] = {GPIO39};
-static const unsigned pins_exin4[] = {GPIO46};
-static const unsigned pins_exin5[] = {GPIO9};
-
-static const unsigned pins_spi[] = {GPIO16, GPIO17, GPIO18};
-static const unsigned pins_spi_cs1[] = {GPIO15};
-static const unsigned pins_spi_cs2[] = {GPIO22};
-static const unsigned pins_spi_cs3[] = {GPIO13};
-static const unsigned pins_spi_cs4[] = {GPIO10};
-static const unsigned pins_spi_cs5[] = {GPIO9};
-static const unsigned pins_spi_cs6[] = {GPIO11};
-
-static const unsigned pins_gpt1[] = {GPIO28};
-static const unsigned pins_gpt2[] = {GPIO21};
-static const unsigned pins_gpt3[] = {GPIO6};
-
-static const unsigned pins_clkout0[] = {GPIO8};
-static const unsigned pins_clkout1[] = {GPIO7};
-static const unsigned pins_clkout2[] = {GPIO3};
-static const unsigned pins_clkout3[] = {GPIO2};
-
-static const unsigned pins_pci_gnt1[] = {GPIO30};
-static const unsigned pins_pci_gnt2[] = {GPIO23};
-static const unsigned pins_pci_gnt3[] = {GPIO19};
-static const unsigned pins_pci_gnt4[] = {GPIO38};
-static const unsigned pins_pci_req1[] = {GPIO29};
-static const unsigned pins_pci_req2[] = {GPIO31};
-static const unsigned pins_pci_req3[] = {GPIO3};
-static const unsigned pins_pci_req4[] = {GPIO37};
-
-static const struct ltq_pin_group xway_grps[] = {
-	GRP_MUX("exin0", EXIN, pins_exin0),
-	GRP_MUX("exin1", EXIN, pins_exin1),
-	GRP_MUX("exin2", EXIN, pins_exin2),
-	GRP_MUX("jtag", JTAG, pins_jtag),
-	GRP_MUX("ebu a23", EBU, pins_ebu_a23),
-	GRP_MUX("ebu a24", EBU, pins_ebu_a24),
-	GRP_MUX("ebu a25", EBU, pins_ebu_a25),
-	GRP_MUX("ebu clk", EBU, pins_ebu_clk),
-	GRP_MUX("ebu cs1", EBU, pins_ebu_cs1),
-	GRP_MUX("ebu wait", EBU, pins_ebu_wait),
-	GRP_MUX("nand ale", EBU, pins_nand_ale),
-	GRP_MUX("nand cs1", EBU, pins_nand_cs1),
-	GRP_MUX("nand cle", EBU, pins_nand_cle),
-	GRP_MUX("spi", SPI, pins_spi),
-	GRP_MUX("spi_cs1", SPI, pins_spi_cs1),
-	GRP_MUX("spi_cs2", SPI, pins_spi_cs2),
-	GRP_MUX("spi_cs3", SPI, pins_spi_cs3),
-	GRP_MUX("spi_cs4", SPI, pins_spi_cs4),
-	GRP_MUX("spi_cs5", SPI, pins_spi_cs5),
-	GRP_MUX("spi_cs6", SPI, pins_spi_cs6),
-	GRP_MUX("asc0", ASC, pins_asc0),
-	GRP_MUX("asc0 cts rts", ASC, pins_asc0_cts_rts),
-	GRP_MUX("stp", STP, pins_stp),
-	GRP_MUX("nmi", NMI, pins_nmi),
-	GRP_MUX("gpt1", GPT, pins_gpt1),
-	GRP_MUX("gpt2", GPT, pins_gpt2),
-	GRP_MUX("gpt3", GPT, pins_gpt3),
-	GRP_MUX("clkout0", CGU, pins_clkout0),
-	GRP_MUX("clkout1", CGU, pins_clkout1),
-	GRP_MUX("clkout2", CGU, pins_clkout2),
-	GRP_MUX("clkout3", CGU, pins_clkout3),
-	GRP_MUX("gnt1", PCI, pins_pci_gnt1),
-	GRP_MUX("gnt2", PCI, pins_pci_gnt2),
-	GRP_MUX("gnt3", PCI, pins_pci_gnt3),
-	GRP_MUX("req1", PCI, pins_pci_req1),
-	GRP_MUX("req2", PCI, pins_pci_req2),
-	GRP_MUX("req3", PCI, pins_pci_req3),
-/* xrx only */
-	GRP_MUX("nand rdy", EBU, pins_nand_rdy),
-	GRP_MUX("nand rd", EBU, pins_nand_rd),
-	GRP_MUX("exin3", EXIN, pins_exin3),
-	GRP_MUX("exin4", EXIN, pins_exin4),
-	GRP_MUX("exin5", EXIN, pins_exin5),
-	GRP_MUX("gnt4", PCI, pins_pci_gnt4),
-	GRP_MUX("req4", PCI, pins_pci_gnt4),
-	GRP_MUX("mdio", MDIO, pins_mdio),
-	GRP_MUX("gphy0 led0", GPHY, pins_gphy0_led0),
-	GRP_MUX("gphy0 led1", GPHY, pins_gphy0_led1),
-	GRP_MUX("gphy0 led2", GPHY, pins_gphy0_led2),
-	GRP_MUX("gphy1 led0", GPHY, pins_gphy1_led0),
-	GRP_MUX("gphy1 led1", GPHY, pins_gphy1_led1),
-	GRP_MUX("gphy1 led2", GPHY, pins_gphy1_led2),
-};
-
-static const char * const xway_pci_grps[] = {"gnt1", "gnt2",
-						"gnt3", "req1",
-						"req2", "req3"};
-static const char * const xway_spi_grps[] = {"spi", "spi_cs1",
-						"spi_cs2", "spi_cs3",
-						"spi_cs4", "spi_cs5",
-						"spi_cs6"};
-static const char * const xway_cgu_grps[] = {"clkout0", "clkout1",
-						"clkout2", "clkout3"};
-static const char * const xway_ebu_grps[] = {"ebu a23", "ebu a24",
-						"ebu a25", "ebu cs1",
-						"ebu wait", "ebu clk",
-						"nand ale", "nand cs1",
-						"nand cle"};
-static const char * const xway_exin_grps[] = {"exin0", "exin1", "exin2"};
-static const char * const xway_gpt_grps[] = {"gpt1", "gpt2", "gpt3"};
-static const char * const xway_asc_grps[] = {"asc0", "asc0 cts rts"};
-static const char * const xway_jtag_grps[] = {"jtag"};
-static const char * const xway_stp_grps[] = {"stp"};
-static const char * const xway_nmi_grps[] = {"nmi"};
-
-/* ar9/vr9/gr9 */
-static const char * const xrx_mdio_grps[] = {"mdio"};
-static const char * const xrx_gphy_grps[] = {"gphy0 led0", "gphy0 led1",
-						"gphy0 led2", "gphy1 led0",
-						"gphy1 led1", "gphy1 led2"};
-static const char * const xrx_ebu_grps[] = {"ebu a23", "ebu a24",
-						"ebu a25", "ebu cs1",
-						"ebu wait", "ebu clk",
-						"nand ale", "nand cs1",
-						"nand cle", "nand rdy",
-						"nand rd"};
-static const char * const xrx_exin_grps[] = {"exin0", "exin1", "exin2",
-						"exin3", "exin4", "exin5"};
-static const char * const xrx_pci_grps[] = {"gnt1", "gnt2",
-						"gnt3", "gnt4",
-						"req1", "req2",
-						"req3", "req4"};
-
-static const struct ltq_pmx_func xrx_funcs[] = {
-	{"spi",		ARRAY_AND_SIZE(xway_spi_grps)},
-	{"asc",		ARRAY_AND_SIZE(xway_asc_grps)},
-	{"cgu",		ARRAY_AND_SIZE(xway_cgu_grps)},
-	{"jtag",	ARRAY_AND_SIZE(xway_jtag_grps)},
-	{"exin",	ARRAY_AND_SIZE(xrx_exin_grps)},
-	{"stp",		ARRAY_AND_SIZE(xway_stp_grps)},
-	{"gpt",		ARRAY_AND_SIZE(xway_gpt_grps)},
-	{"nmi",		ARRAY_AND_SIZE(xway_nmi_grps)},
-	{"pci",		ARRAY_AND_SIZE(xrx_pci_grps)},
-	{"ebu",		ARRAY_AND_SIZE(xrx_ebu_grps)},
-	{"mdio",	ARRAY_AND_SIZE(xrx_mdio_grps)},
-	{"gphy",	ARRAY_AND_SIZE(xrx_gphy_grps)},
-};
-
 /* ---------  ase related code --------- */
 #define ASE_MAX_PIN		32
 
@@ -1611,18 +1374,6 @@ struct pinctrl_xway_soc {
 	unsigned int num_exin;
 };
 
-/* xway xr9 series (DEPRECATED: Use XWAY xRX100/xRX200 Family) */
-static struct pinctrl_xway_soc xr9_pinctrl = {
-	.pin_count = XR9_MAX_PIN,
-	.mfp = xway_mfp,
-	.grps = xway_grps,
-	.num_grps = ARRAY_SIZE(xway_grps),
-	.funcs = xrx_funcs,
-	.num_funcs = ARRAY_SIZE(xrx_funcs),
-	.exin = xway_exin_pin_map,
-	.num_exin = 6
-};
-
 /* XWAY AMAZON Family */
 static struct pinctrl_xway_soc ase_pinctrl = {
 	.pin_count = ASE_MAX_PIN,
@@ -1689,9 +1440,6 @@ static struct pinctrl_gpio_range xway_gpio_range = {
 };
 
 static const struct of_device_id xway_match[] = {
-	{ .compatible = "lantiq,pinctrl-xway", .data = &danube_pinctrl}, /*DEPRECATED*/
-	{ .compatible = "lantiq,pinctrl-xr9", .data = &xr9_pinctrl}, /*DEPRECATED*/
-	{ .compatible = "lantiq,pinctrl-ase", .data = &ase_pinctrl}, /*DEPRECATED*/
 	{ .compatible = "lantiq,ase-pinctrl", .data = &ase_pinctrl},
 	{ .compatible = "lantiq,danube-pinctrl", .data = &danube_pinctrl},
 	{ .compatible = "lantiq,xrx100-pinctrl", .data = &xrx100_pinctrl},
-- 
2.30.2

