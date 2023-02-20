Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B014669D289
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjBTSGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjBTSGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:06:39 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2105.outbound.protection.outlook.com [40.92.107.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18C1193FB;
        Mon, 20 Feb 2023 10:06:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/z/ESsWoSS8YGqfbG38/iNo5mVMLkpDp4WjTNI/AiLV5c2yfRa3oHxhb4dM7EaZuWvQOa7IurisFYIPK9YglO8DasMsdQm40sXba/WyDZKt729xzIqzbxDYzEwMe4dXn1NrsumMS/iVDIeN+QKRHLhMX4pYOla8yWYMSk8E5cbZclGbASMePTzqCKTkqdfhWtmAfL5kipxFMIQm7lX/JEmEmx0B9sHgi8Rl1kW0MIzWNvvd/fXfD5fBgwtv0WYAca0GRWnyu9TEois0qbP9O8AgtvWsSBtMW+7N1MwJAq0SsZAJKExQCWshOGlHDDB5hBa0nqcMJWkDqXORzr7t5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfHctjYze/5K1MKNW7xyLN7q9dclN/fbEBJzabXXauU=;
 b=Zr6mI0O+MOk8VZZrbo2zTSzPdqkxx+M9xSEJ5T9RoH6Rm268OSciUVPQH5FHy5VLuTQq/7t3qADj2BjjqOpFV5oP0YujqRpBBH/tt2eRhm13dgPUG2Wo2KbuoT2fuPbvac3aztf9Ao5ezS0VrVGfuq3R4hyFHCj9RJ/h8v/B5MREoIoTuuXb3pK8CAAsKTWnfDn6vyOxZNkuMyq+o/ni+XSNtzDjnrpUF8U63DL5ELPVEo1ptpk/pk3IgwShcruI/SIzMq/tzFtjwcoduBUehRDPIGp/nFrNCaZRzHN3pmM8a2itVeTtfqY/Jj8Es/zhz1O8DCnpVGcvy+syMk62Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfHctjYze/5K1MKNW7xyLN7q9dclN/fbEBJzabXXauU=;
 b=Uq4by6lG78VX4jf9IZBWoYiatFZJR/BL0z8WK7C55HDWNy2iVoL+TSzh0hfQ0UhmoO4cHClQQH8anw0AdnaLO/wz/tqmKP8KgPWCVelWvRF8cdMUZAWCcc7XZ1tifCW5zS/SOmhakzWlrq0pF/sXxpwIVto4AfnGwYe558GGHhfyhuZhempNlrO4Fy86/dIblbD11OXRheRhRtD9jEEFxyk4H6QwAa1U4S+S/Bnt3DW0vRMI4Boc4jAh2nMeYNMgNdaB+TnSHeeobqLXMW2gPohXfSuBr96oveKF77p9r9olOIgXN3dd0SOH//pj8W5Kzw9wRcRVMOb/OveWGuMyiQ==
Received: from SG2PR01MB2048.apcprd01.prod.exchangelabs.com
 (2603:1096:3:21::12) by SG2PR01MB4171.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1ca::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Mon, 20 Feb
 2023 18:06:34 +0000
Received: from SG2PR01MB2048.apcprd01.prod.exchangelabs.com
 ([fe80::d398:3ca4:6877:ffaa]) by SG2PR01MB2048.apcprd01.prod.exchangelabs.com
 ([fe80::d398:3ca4:6877:ffaa%6]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 18:06:34 +0000
From:   hzy <hzyitc@outlook.com>
To:     hminas@synopsys.com
Cc:     gregkh@linuxfoundation.org, fabrice.gasnier@foss.st.com,
        amelie.delaunay@foss.st.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzy <hzyitc@outlook.com>
Subject: [PATCH] usb: dwc2: drd: fix inconsistent mode if role-switch-default-mode="host"
Date:   Tue, 21 Feb 2023 02:05:35 +0800
Message-ID: <SG2PR01MB2048C724CE08E7E3D6719C75C9A49@SG2PR01MB2048.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [MZZofLLa0ImPUDQHGfxQHrvhqQiB4nDn+G1roq9tRMountyIzvI+1g==]
X-ClientProxiedBy: TY2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:404:56::26) To SG2PR01MB2048.apcprd01.prod.exchangelabs.com
 (2603:1096:3:21::12)
X-Microsoft-Original-Message-ID: <20230220180535.1495748-1-hzyitc@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR01MB2048:EE_|SG2PR01MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c9c956-a1f7-4bcf-b972-08db136d3345
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKz6kvxH6h/F9mRPKGbrhla7nSi7cRKL434PsYf7vg2izUwCXfMXKnCGr6EifAf+o9tKELmh03AlzN+UVyYLatXay2CwDH5MCYQ+ICHkS+XJ7aQMqzJd/O0jxUvqFRUaz947sHC4vV8XOUShe80JRQmmspO+ds2siaDOxAnHk0B+NsirNSN8nDimmg6u49GVpD9RSPeiRtFzo/OvKV48EyjIMZic1cGoK8ugOwUbjv6z1V5uOygfLt93kjKkwBoF7a1s7XWr6p7+KBapzrO0L81pfdpAMyAG51P90rjNNojmpTAbHOF4lcnPbIa6l0mpgRrqDNMtudPyalJzHsPiFQ0f+xj5+vRYExJA8eEDL9JXnAe4hWA+GIu1RVT9bmKg6uERmmWRlp3CjENnH9BSd5gXaKFkG9QSPdKlM+drjWoGQoWHqmVMz4Aty1gAB0fnYhaWzBc4q9Msi4I1HSKYgqU6Bj0T1zc/kAVpq5tCiF7hluDBAFO0Pf0xY+s8bti6KKDaTCb/twDIVNG0+YEQgsuFKEBkvhzSAD13lROuQ4uxTSukNidwa9wTqVF42jPtGC+ax0BQEOS+UESCg49cB3HBHgZqHV2zKEP7OEOuWp/JKy/RMCUD5eNGvoyitwjy6BWZSch1sLB6H7mqMw8ZXQ6+OcDOeeLuLXrU2gtbaWI9L8eT5mZJ2dP5+K45MWhbXfu1t4asDBcJ/lvBDgQ2jDSqWOKxw9G3ue0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aDbaemzpzJvWxd6kkjKlAM/+JUgxaGgJorz08FdXkKjBaBYUywLU5F3IRZRhv3Q0L3D40YdxSZ/Vfe31lmr5mHKioy9ba6MBsA0vNFMPvb00dHWzJOtjs9EIx0yxPbgb2mu++rXoAggRYdHm5IdMRK0IhznK7fWmE0FH38j/5NJCr6yb8dqjtUs5A4Soa3koE2duoD1zgcND2Oco+yfXt4RdR/jDY5475O74grBdJVfTQrSLXoOxk6FlS7U5tpFvkeJAgJq2ej3tcYD/csOz0D4eDR0CGuxlhagBAzHDNH2J9O0R1SbkyIRLIFRNOSeEj3zmQ08OV+b0JEd79mhxHS1pSzsnGBAFI3TPoStxTOVroNkPjPmZtMQHMDNPnv3SR4F45Z2sr8U4l/zilmqn+/wbICCfQS2uuGLTu2lxeOKnaT4BrK+uSM/9SPFzJ/6fm02wwPLnRmveLm/eIdICar8CVFvaWFBf1OZJLgu1YpK6baB9452uQHc6CwoIBNbdo5zlilya9GLEixI5Q7B6eQOeUYF25RuGEYyzAUnebGxjMqM8mdFJMRm+hyBjRarXUlIIMiN/VwuWn7FNHz/qAe0v+Kpp1IVhF3sZZ5WdkHVqaBxuXmdFmdQxIc4UKEW1J/HGwS+OMDH00BVjTxm2OA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v6LJQ397JT0trBFftxH4bG0x7LjdCblTmVnZhxtgcEUnDvnRmglgspvNgxPY?=
 =?us-ascii?Q?BLk4MWA0LcQCY50epr3PJp9dSTapCBe3CA9eXvhRMotfqcFetmzbOjbTkBT1?=
 =?us-ascii?Q?PR9o0vJ6ZF/Y8r/OfTjlcXiB06N7f1lkXUU94VjnIflNjDJXZIVWhbpO5Y3L?=
 =?us-ascii?Q?RFzePhG4qxy41YBhLdnjcGXdy4X1JqOJ6fdZV4+E43Phb5DrP+uVJOldTvhO?=
 =?us-ascii?Q?62wSnmNN48TUHZ5ZJbDjvx8ha2kpGu9k/NsyM1rBBHQFwqrpNecn/WG7NCoq?=
 =?us-ascii?Q?nVktyZ1MCBWglpR9UE6hZlBkqL1gm7pLrItd7uK98FVMZOSRKalbAGVwTpDm?=
 =?us-ascii?Q?fEML2UXLW6zQP60k4eQ9DSJQrcCwamfeBOwkEmYHR2OQ1Mswhb8R5T1kd8co?=
 =?us-ascii?Q?1Jx8kNd1JL0srlOEg/hcgKliujlJxBXCVqQmueEhgXjNoUs1N9V2IF5EdQzt?=
 =?us-ascii?Q?736coHHc6wF4yqGmrOf6CYAQzxMIW76j9cXRpoDmOtbvHOkUlEOisGhInIek?=
 =?us-ascii?Q?Gx1lIcsK2NppRCO6e6qRfR2iCXc2AXbrCs68Xwvjn89UY5LIDjsJSVw8fRt0?=
 =?us-ascii?Q?n4mjZ9Tv3skfbHz32uH7ozGlywcDEI4j/V7UqA5tqKBOYQZcmFi01aopAkeF?=
 =?us-ascii?Q?Q/SJtkczwd/VZ1VW8AY68KME0OA+uPf8ygYoLocvQ73XOg966zXeafW4pL2L?=
 =?us-ascii?Q?s7cUVqz5+/eXEz0p1zW31RMeeBUThfq2GWhLr3Y/8J85cZi3gn4nCwFQr53C?=
 =?us-ascii?Q?+LxP6CplugllAobGLc8W91TNjPc8nCOygw9xxkattrr0SMbSHcrDe9TFfDUm?=
 =?us-ascii?Q?A8M9mX77dYsxTMrPKvxZR7wlC7YsTNdalIpkXRGW+PoZ84mp4fDxnG+cARp2?=
 =?us-ascii?Q?E/wC9C00Bg1s1+TcwjfurEvhMPtDm9oMsPGt37EKmK7FMcz5JuQBoFQsjVwR?=
 =?us-ascii?Q?E8m+A/YYelxxc8a3JQGxYFlFbTOxes8v5RNn/rHFoX4RNNIKOob0ai/Zb9xx?=
 =?us-ascii?Q?dY7Em4dXOcdhg3uMYPxdfCR3BaIyRXbrE902Ez8K/OYVwCnxbHCbhV0F1c5P?=
 =?us-ascii?Q?YZSy4GCA12lI7k92GU+Rbt6EZ9uXpBQs6jwDZ+6ZLyoSyKvJVWtqOt8DxMnI?=
 =?us-ascii?Q?eVdz6N4DnZE/NqAk9xrsqAwgpTYiYEynR4jNl2QSQ4sAS12sfrRdA+I/5FpG?=
 =?us-ascii?Q?qHb8FkW+PRZpTpXqE86BfEr69AxsxtqNSDkZKOFcvFA8aW93KzmUHXaKow2r?=
 =?us-ascii?Q?Rq2TFsCh1rEIAZN5BNt6QNiqIP4sGAfi5SiEmJ7Bn8va7lYqKcrZ8FEsWlQf?=
 =?us-ascii?Q?mTQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c9c956-a1f7-4bcf-b972-08db136d3345
X-MS-Exchange-CrossTenant-AuthSource: SG2PR01MB2048.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 18:06:34.0627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB4171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards might use USB-A female connector for USB ports, however,
the port could be connected to a dual-mode USB controller, making it
also behaves as a peripheral device if male-to-male cable is connected.

In this case, the dts looks like this:

	&usb0 {
		status = "okay";
		dr_mode = "otg";
		usb-role-switch;
		role-switch-default-mode = "host";
	};

After boot, dwc2_ovr_init() sets GOTGCTL to GOTGCTL_AVALOVAL and call
dwc2_force_mode() with parameter host=false, which causes inconsistent
mode - The hardware is in peripheral mode while the kernel status is
in host mode.

What we can do now is to call dwc2_drd_role_sw_set() to switch to
device mode, and everything should work just fine now, even switching
back to none(default) mode afterwards.

Fixes: e14acb876985 ("usb: dwc2: drd: add role-switch-default-node support")
Signed-off-by: hzy <hzyitc@outlook.com>
---
 drivers/usb/dwc2/drd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c
index d8d6493bc457..a8605b02115b 100644
--- a/drivers/usb/dwc2/drd.c
+++ b/drivers/usb/dwc2/drd.c
@@ -35,7 +35,8 @@ static void dwc2_ovr_init(struct dwc2_hsotg *hsotg)
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	dwc2_force_mode(hsotg, (hsotg->dr_mode == USB_DR_MODE_HOST));
+	dwc2_force_mode(hsotg, (hsotg->dr_mode == USB_DR_MODE_HOST) ||
+				(hsotg->role_sw_default_mode == USB_DR_MODE_HOST));
 }
 
 static int dwc2_ovr_avalid(struct dwc2_hsotg *hsotg, bool valid)
-- 
2.34.1

