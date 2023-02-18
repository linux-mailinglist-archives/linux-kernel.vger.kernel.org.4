Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4569BB2B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 18:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjBRRKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 12:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBRRKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 12:10:37 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2091.outbound.protection.outlook.com [40.107.92.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B77E17CDD;
        Sat, 18 Feb 2023 09:10:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j120TydXqp67aTcTPy/9g8CvOqcH7RaxPItgR8S5f/gPHv9eUvZQjzlqxEx//ZLgUrqnq+kOk0sKKmN4XsAjGg2eypZgVJAUNNCZQ8Gbs5NuspzGKtcQzxKVkbeeI4MhzibyilAKww+wEijath1doA32aVtgfRhmwyj6ZgWBxgrIWSNV4kkfHTMDGyuH40xlxWXTvt9O8YgHgwBjA9SUHELwCPQY9uRfzeATuhIVIlBv+OTljjmF/rn+SswHhchuQl6+7zOSluQKg568NqV0FRXlnfzYisYigdwQ5ns0IV2CklmjuZFU/fh0tszv5e7dpGPDubQJu+l8hQoYRuVqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg3wppsGM/VdqzPSASw13uXclav8wZ4Nr9tFxcmxUmU=;
 b=aY4NbJQUIEoHvXEeWIoT6nIPYtNtVAjnvtvAD7smKyGP/wjnw2a7c40go85abbX/RSz6aoU5RY7L14IAx1UYqP3LAQOhhRSSUr8GyNrYTILhRX+hN1m252CR1345pK5LnG8mcSinya3A+m5YcTtN1JSzX3kI/2xngElIKsMd6AVVxrmTftRgVIzfZS5mGPDlKKSXPWV8EEGvjCga9Rrx8eF/xGGhWj428OaH+m+3DDe9PKZgq0CVSH8B2VFLko+dpFz/Rjy8bHWALwMM5jp/vdmSoayMLXjmb+zSkOl3PbbeHEm+PBhgVvtOzyk0NY9U3XCzI8JBTQ6TfiDhvS7tew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg3wppsGM/VdqzPSASw13uXclav8wZ4Nr9tFxcmxUmU=;
 b=uDUpUHYyMsWK5mPAyAQsvu5vrmkkbjbJIo3ZBfw2Zur5hDaG3JbNijAJ1xOXuyQQpTge/P8mggXITVEwSud9/Rg99YQyNZn3L1OPFVCGqQsPbhxO3g/QNwjDqURUH/TNchhHtEz87IRaLofnlGibneFa0po9yS3eN8CcsFUYu0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN6PR01MB4973.prod.exchangelabs.com (2603:10b6:805:c4::13) by
 SJ0PR01MB6464.prod.exchangelabs.com (2603:10b6:a03:29c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.17; Sat, 18 Feb 2023 17:10:30 +0000
Received: from SN6PR01MB4973.prod.exchangelabs.com
 ([fe80::a807:4f38:56ee:b079]) by SN6PR01MB4973.prod.exchangelabs.com
 ([fe80::a807:4f38:56ee:b079%4]) with mapi id 15.20.6086.028; Sat, 18 Feb 2023
 17:10:29 +0000
From:   Chanh Nguyen <chanh@os.amperecomputing.com>
To:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Chanh Nguyen <chanh@os.amperecomputing.com>
Subject: [PATCH] ARM: dts: aspeed: mtjade, mtmitchell: Add OCP device temperature sensor
Date:   Sun, 19 Feb 2023 00:10:02 +0700
Message-Id: <20230218171002.8725-1-chanh@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To SN6PR01MB4973.prod.exchangelabs.com
 (2603:10b6:805:c4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4973:EE_|SJ0PR01MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3ee555-f845-4a72-5bf5-08db11d30909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJCu+Q9iq1WNa3VusroiC2ssl5ZmUGYGG4KVjBzmPwbxOWUfN+21eI028WZIzapBwmK7ujel/g/FMrmsDfhTE3/Y+uOb6TjWSwPlnznwQS7lnWinHnbt3Z/AUnnH2iQFhbTjgvvfx34Eyp+GOlff4A3ADSD5me499p49BEOigzZXk86J2SQoWrp3XjiDhxZdjdWRNqtyLnYDZ3/Q9J5Iuddwe1W1OYGSiCBzty2jI4qsg4/+oGJB6IrfOnrzcHENT5oRcVshc499bAaycdFRV7Csh3zj5+w29H9cl1LWd3ZEFhJFYsg7XQp/Hp9HBZyyFV9Z1/P/ubYPnJCtJA58OP9cXcQku+y8Sy/IxQ+CrgAaOPkD/fRtiH95savGzcsY+urz53glL801EzAcBQk9vXIs7LkjkvXIOXhxvGeAhIBVI118+dbZ/qJW0JhSwgvYU5h6M4DV5bhY/on27pRFMRSZ6TY/uANfMA5mma/200l7VhQf8e4qqRKZvy2ezIa+jfKMDvRc87b5F6fvnxfhjPD2hjtJcMUoWooEI7d7V0NxuRYI2B0W58rn9bS8UkWaSyBLMheQsNPTUtdpYgI024GLBbdxFrnYqCMkKGp4THvh987W8sHjTtIviDoVxQYNss9QWnA7eRIcWL0i3zKK7/mqG4o+0JU7sWk5lj92R05dAhkzW1ohpTmg4n+9KQjs9T0J5lfFeywlLfTI1iyOPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4973.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(366004)(39840400004)(451199018)(86362001)(38100700002)(4326008)(1076003)(5660300002)(8936002)(66556008)(8676002)(2906002)(66476007)(66946007)(38350700002)(52116002)(41300700001)(186003)(26005)(2616005)(6512007)(6666004)(316002)(107886003)(6506007)(6486002)(478600001)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uyba9Omj4PvF/L9NBsIbxOoe7rnfxWa5KE9aZ0Zl0VQaJLQ37QXCemMT3Wno?=
 =?us-ascii?Q?vGHseUNH+Gx90sJfIBJEUkIiZyFgEw6BJnjS7HnCxhleZuLgoDxphnAbiI8e?=
 =?us-ascii?Q?hYPy5Nzcd9upcpP8plRdDuCJj6IvHM1cdXOlUDoasxYgd8mJ750RopzoO+h8?=
 =?us-ascii?Q?A+/Y0ZKGYHuc0SGIyIOqpRMyt4wMbSVfD9wdxeia3A6PNBrW5y6VazYfHhdw?=
 =?us-ascii?Q?Yej/IuigRKzDFcOAbSGKXnXDCDSV5xXRQgbp7LAeoL8UXihAKWPHN9YNlNYK?=
 =?us-ascii?Q?e6IM+9Eca77KDmpclJmUHsMFc0QH7rMBVAgfdkGlqEW7mk/HWK3j9Sqgmi6h?=
 =?us-ascii?Q?0KYLeuOjNe7qW9gtjECnDo3l062lsPxTAuy3tgDidjC8eaYlRtAFygEdUhcc?=
 =?us-ascii?Q?xoICnitOsnqGIEeK0erdm5wBU/H+4lhylZkgGUDi9mcVR7XEM8LU/T0RzblB?=
 =?us-ascii?Q?+QGbaoZUogbhu22N//niPvcMd+oPZxRQOaLP+twZ/M9rON927bfE0tF9akq4?=
 =?us-ascii?Q?i8gtK2fnTuu8kkLhLz1fYBXtva0CqnDAHyRlKLfNBehuGD6ENjHByoBo5sNy?=
 =?us-ascii?Q?7TiBHqrGrU0b0GJlz+Q7HUc7sCTSVnR6tJnUWHgccITq5r6YquJCdQLaXwr8?=
 =?us-ascii?Q?mGT6yLAOquZlYpZ+T0ythn6H/U7fE7MnF2sAVhZYSoM8A5TqpudCUGw6Laqv?=
 =?us-ascii?Q?4TGYX10WyusOOZgOtDMXguPtuie45qfIVsThf9xkKpseUEcD08VgkwGKavLE?=
 =?us-ascii?Q?kSzMMMtPAS5uun1+6JTl7/VBt4IytKKl1Jhhpup26OHAtOdNbXzP5oYsfiRr?=
 =?us-ascii?Q?W4aM6MKIpBroQUYBvs0p4VMnKkCH06JNXWjOFG6Rkrl3lEfhF+O5bkPtqhph?=
 =?us-ascii?Q?yP/aDpci2Jy3bZgnao0F5bHICR38758ukyyh7YRjKSuknMSAZmrQtRK4cQAz?=
 =?us-ascii?Q?bpZmHqdHh39EvaMEbYZb4pb/RbLzmQ7ZsEFNUcc10qfmJ7VaHAyzeGGhBEIL?=
 =?us-ascii?Q?1dKbKBopVSpHf4TMv7wkpGiDnw8XLv5QPftGrbbc8qoFYEjw3Ato2C6gdRUB?=
 =?us-ascii?Q?RTaF+GeOaEJHcGxsAq73VOGykFRlVyl7PvIRCKq0Xyg7zeFXaeYFWd7tOdLb?=
 =?us-ascii?Q?KO3hlRhtJKOKDF0uEkJo68g1CfOLRY+ZvF41XR/KJoDUTefjw29H1n7aQQyK?=
 =?us-ascii?Q?2mJpwr1CTiSo70fIZ1/kF7tH892BX5An8AXmJnVSulBVFDW6hWMH8/wEkQDe?=
 =?us-ascii?Q?mBj4G4OFxf+BGLLIzCHbFdBFuBdH77yqOXhy7atuD5z7s24v2adTL/T4hhHT?=
 =?us-ascii?Q?3HgAnQEDjI/iE4SLBD9famclxzbERnAx+BajcdQziCiIqK9zw7CmyrnR0310?=
 =?us-ascii?Q?ElxlmEFPNWlMFu5IuQ8iDJr5tIvSeVenjiDdlP06/mI9xetluCI6/TGlmsQh?=
 =?us-ascii?Q?ucSdIqKKXfX1tjdjZhSRTmBL4yEO0mCH+50NkltG/OdVhIpSryvafI7TOREq?=
 =?us-ascii?Q?CVlcdcwZjS0FyhLx/1RD4BJ0zh+Kj2dlWKkCOQ8z3oSdnkFBMbCa+/yofAey?=
 =?us-ascii?Q?hR7H6vpSQYtkSbO5Pw1CIUzU2AuhkDRWKVSPDb/8wTw5VoJsbBGI0v34y9CN?=
 =?us-ascii?Q?eXjkPnLgkMfoXmdKmxN6zg8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3ee555-f845-4a72-5bf5-08db11d30909
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4973.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 17:10:29.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAx3ZjXE7Ju4Ih3MS4T2VzvPpNGbCFLvFazo+gYlYMv4uNJL+shJOD/93YOsxoBCYWlh7pIIO+R3SHlOR8UFYfz8NBv1lBuefEQFmAypslt7EImBeshSb5aMWzUqWD9Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6464
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define an I2C alias port from I2C Switch 0x70 at I2C5.
Add the OCP device temperature sensor via I2C alias port
as a tmp421 sensor.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
 .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 16 ++++++++++
 .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 29 +++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
index 0a51d2e32fab..b93339ed61c0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
@@ -49,6 +49,11 @@
 		 */
 		i2c80 = &nvme_m2_0;
 		i2c81 = &nvme_m2_1;
+
+		/*
+		 *  i2c bus 82 assigned to OCP slot
+		 */
+		i2c82 = &ocpslot;
 	};
 
 	chosen {
@@ -420,6 +425,17 @@
 		reg = <0x70>;
 		i2c-mux-idle-disconnect;
 
+		ocpslot: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+
+			ocp_temp: temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+
 		nvmeslot_0_7: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
index 4b91600eaf62..c832b8ae5999 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
@@ -10,6 +10,14 @@
 	model = "Ampere Mt.Mitchell BMC";
 	compatible = "ampere,mtmitchell-bmc", "aspeed,ast2600";
 
+	aliases {
+		/*
+		 *  i2c bus 30-31 assigned to OCP slot 0-1
+		 */
+		i2c30 = &ocpslot_0;
+		i2c31 = &ocpslot_1;
+	};
+
 	chosen {
 		stdout-path = &uart5;
 	};
@@ -424,6 +432,27 @@
 		#size-cells = <0>;
 		reg = <0x70>;
 		i2c-mux-idle-disconnect;
+
+		ocpslot_0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+
+			ocpslot_0_temp: temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
+		ocpslot_1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+
+			ocpslot_1_temp: temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
+		};
 	};
 };
 
-- 
2.17.1

