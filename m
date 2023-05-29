Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B587151CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjE2WVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjE2WVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:21:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D32A0;
        Mon, 29 May 2023 15:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJ13FpPITO08ytDhYLYGZ+ZA6nDnKocjpVOvF3NUE+vA4iLqz2imyA2kQ+WYw4z+rbikLm3NQijB88zUflnaIv0Cfs1j55WZaP17h7BZ1+gmUChmXSXw34syeUoiqhAK4gP7m/VqWZa2GETJgKsb3b9sCu71yDaKtvOfjVDHz7pLZQ5S1ajuS/029eSH6d+CSeNaYyWOKiF6rEcq2a6HNbb4hCcgHNIUrzAjeMYaiiA3okXpkaGD5I8KMo8kjVnRKiF1BBE8z3cBHod2zGC4r6xs2bd0gng4JOEFSexB6WJLtLoFJAdahJ2/nHv0GbKuJpEgnqW8UF5ootF5Chnznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWOnow795rwzC8JB5KMVFQH77R3JokfcEzuT6m9WsKA=;
 b=g5EUphxDOx/hoFMMz79+u6K5kEc1ZWWY+nnvHOyz2UwmmZz31FfK+jNmuvaaQ/MYXcJgH5ngnveDxqSCRUQc/ewsSfuwn5mE0DefMmaJl+o9TJe+vgedyC+JU5Evxwvmtt/ofPoShAgUTHIsPTcl1ElnGCP+4rVi9GhCVcAMqa8z4XWjN9pcdgECKsFhlo1PQDScYeqlr0EFUCIsHXZ3UIOI7n+WUh3BE+9sXgtAqq/sxQSqL5R16QLl31ILgdcwPvPpywC9lcCKElrmodB5frBox6BZK7vvU70k57XISYdDQ0akjhp9NgI6Ur7sGwcFKgmVXXyKT1KnRDap5vHPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWOnow795rwzC8JB5KMVFQH77R3JokfcEzuT6m9WsKA=;
 b=iSgJuBx8/MVuLr8ESOoXPbUEcQNrCVOgGMz0yv+RutEoASTIu+wvEURrVuQcGXh+g57jhCPR/T1l7mJsPBvjzDXYsefdRMtXalaIN3fTZJuEA6Jt3MRk3qrP9K213K1n4JEEjjGAdvFqg15qv/PeKaeCEjhUb5L7/KxOX2DKeggtf29htp5nDBxX/2IjEi1UBDrGz3GxC80/K9AlAcRtFKaZZVehSSc+PmV/bAar8xivYNj2DC4rFxAOFVL5rJ5zRBiptAHkGUYZc4VqAAUV4PdCsR6ZvFDl2yU3yXQ6DchZ4zNypXlO9G7ES82JSZxtBlpKOntc2QYRsKn6Hdv2Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by BN9PR12MB5355.namprd12.prod.outlook.com (2603:10b6:408:104::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 22:21:05 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f3d4:f48a:1bfc:dbf1]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f3d4:f48a:1bfc:dbf1%5]) with mapi id 15.20.6433.018; Mon, 29 May 2023
 22:21:05 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RFC v1 2/3] HID: nvidia-shield: Support LED functionality for Thunderstrike
Date:   Mon, 29 May 2023 15:20:51 -0700
Message-Id: <20230529222052.68913-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.38.4
In-Reply-To: <20230529222052.68913-1-rrameshbabu@nvidia.com>
References: <20230529222052.68913-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|BN9PR12MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: da55a48e-613d-4ec8-3cbe-08db6092fea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7gFUwvY/NhrhenEN8NSe6e+BzcqV4EvSZDah96ssdLKulRjmHtBfES/OwpIFLUwMC8Ju23N3JDwhq0hFcJOD+VCCmybWK5OhqLUx7xugVHK/2HgfnnjoX3ErdkA2l0rmGc+KIICtdgtWyOCLI/9n/6Iwl3kQEyf6O5af9Yf44jZD1bhme5JSiw6FhgHBYktLP7Ekb+QIQYMYdHzl26V0KAOg8/bpWw2h16qEGgnTADg3HjyhOrd1bJzXYJIErauALDKo53dPYHY3sBrUjSwpHAYhw/EZv+JcfpHn/glVtg59e7vwSscm5aOcXouzt35yMF10MRRJFH02Nawc26EaASFPaI1IXxZ45910rY4pgTBeOciqzef1xCBQx7lo5EMneFpdV3OYLJV9GAfcsGa8Pc0jjLIckdFKOre7MGYkQc4nnO58u1uvP06rdgXsCMugRMwiBY3AikiueoKJIuC+yLOzO4vh3d1Ogo7qz7ecxs7czmZvQlGBEdOGh4T4OBdWFe7cDQI1WRCWSR8tE/uuqYsU4TEVD2n/fpEbOBor5DdTK+2gSHmuBOCMztJrFYE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(6506007)(6512007)(186003)(2906002)(2616005)(110136005)(478600001)(26005)(1076003)(83380400001)(8676002)(41300700001)(38100700002)(8936002)(6486002)(86362001)(6666004)(316002)(66946007)(5660300002)(66476007)(66556008)(36756003)(107886003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rG+GrhGA4NmfZi4zXKPRw+1pIq6UXAwzcY/ptzuD9juglDKY/HzqX7PPUgwV?=
 =?us-ascii?Q?do8EoP6OUElOkvC2PdLGfaMCB6W0KD8DMi46qf22b0/2UDnCTlDWVq4PDvQz?=
 =?us-ascii?Q?TNqC8ZVN1PgGlsghDnL9p6jM1wb0hZowV1knuRi/xzZ5/JgshVyCH8mZWaIU?=
 =?us-ascii?Q?r+hVxi71VhF4Q1Kzl0AQGI/Fveoi3rCEgz109eVrn06s7bW6xjSq8otqaRjq?=
 =?us-ascii?Q?91kqfD11T2Te6rQaRz7/1AHWz+4xaV3sBPGYMNumnVwv/k1sIZYcpT8hfA5k?=
 =?us-ascii?Q?P6zngqB1vdNAyJ35ngE/r8NFXBYX1Uq0vdBSco+dFr3FaMaNJhgAlSFJwuW/?=
 =?us-ascii?Q?AmaQiR//SJ+eW7h/F5D5JbCtYeXsgbKb6ZtzYtykDazp9Sz3N8KCbW9DFwES?=
 =?us-ascii?Q?52T1fl5FMdTYnTOhHVWkmoFQro002TCEZs+HwkMzhsRfpoNdlW0G2e1Nxa+B?=
 =?us-ascii?Q?UcKP0rqBUMmtOtcQ2eOa16lQEsnlfVeGhWAKfWd5bCPQjq/RKSMcbYTNPRmc?=
 =?us-ascii?Q?8jZPITIlaocvT0xeK8pqbyTihEop4TP4wJvIIGXw1u2sl6lgUMxtidFsioVZ?=
 =?us-ascii?Q?BaZhNeaWQbiqnBxyJldSbCTD6c7zyEjzT9b3TDWdtWQ3b3h3mzDMzoNBiN9e?=
 =?us-ascii?Q?iHBPbsv9Kloek5Rs6zispbz3+tGtBGffRX0GGeFmvfDtaP5cQ64h7OfSlAGE?=
 =?us-ascii?Q?4JtLfitBJFs3zCMnLyQYSdesrBOXoMGBT5vPLXMY5akBEG7aZHOvOI1tRgKm?=
 =?us-ascii?Q?DOxNdTLFjAYm1mzS0dcmXpl1p5QTZAC4/ORfD7ERHruFbPQT3ian18BxW7kG?=
 =?us-ascii?Q?7oKrYvxu9zdsv5MvTkA1JGZoOdse/tKQ2lwkeA94QvvXnBQo2t9BvtFXNqZc?=
 =?us-ascii?Q?A5S0L+t+n7yZ6XuI9C1N9s6AoBVnoLgJ4BHDoB0+eJnqRtKw+nJ7Fk7hgQiD?=
 =?us-ascii?Q?gOVPyA9UfemaHZdHzNdjAD0m/ADr7odzZyPOFwm3//Gvkbvea457eD7bM0xF?=
 =?us-ascii?Q?RCcZ68JzHkljWoTna0cECI4nnuzTl3PvUPD2OIB9AcWMG7/6w9gAU+JBmg6B?=
 =?us-ascii?Q?n+OWCeYGQvDBBSO+ldJvZazu3h6dYZa8Gxmivnp6KzVxDUjFYaAeto+XIIkO?=
 =?us-ascii?Q?tJL+IMMeDWXwlpEL3VGDk0/+PowxceqfPp8KG4tSjXS5t5NHvnTDFSQ7jgaF?=
 =?us-ascii?Q?dXowkqu/UJR2phFgfkdzCjwejbxO0UndtXVSVIIUbu0OoTloVNgosWpOo/Cd?=
 =?us-ascii?Q?649MJhi9a9jesTfw3gJqeA56bWug04NsxflAAexNSh3iADgh6bodcDsUhBcE?=
 =?us-ascii?Q?91yzDuw8Qm1qIawuIYBkY9URDbWoGbsZT33zDLieNrjK1eNAHx2By1fnB19k?=
 =?us-ascii?Q?SSQqgIn9gBihMm97HyJm8W36ti9PwgcmdgSPl1ik2vOx0pdU3IBrSptIh7gE?=
 =?us-ascii?Q?vIs5PeC5WcPIIDImc+ZTm13KcxGLzAZTPf2hmFvd80TxsRtjlHBGIg4zAYNB?=
 =?us-ascii?Q?SKMFtamUCBgBBDks/cMD9YJH5OJ2k80tQLbFFBfQQcXPl+vzvcAiC2uWBCIu?=
 =?us-ascii?Q?WFei89OLH8D4NzX8T7ReR6GzVn3C/qZhnnn2v8Rj3I6x6u2c9YxEMF0G8QAd?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da55a48e-613d-4ec8-3cbe-08db6092fea6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 22:21:05.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erAvVC2bxM2ttg3vGniPbdPOKmLIZGK+GR+Cmpt0gzc1RVZUtBlO3x6OXS/Hiv/E1AG2DmImHFcCCpR+PkNfUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5355
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the 2017 SHIELD controller (Thunderstrike) LED through the kernel
LED API.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 drivers/hid/hid-nvidia-shield.c | 116 ++++++++++++++++++++++++++++++--
 1 file changed, 111 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index 1a9d32b2c80c..7dfaec1c07e2 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -8,6 +8,7 @@
 #include <linux/hid.h>
 #include <linux/input-event-codes.h>
 #include <linux/input.h>
+#include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
@@ -35,6 +36,7 @@ enum {
 	THUNDERSTRIKE_FW_VERSION_UPDATE = 0,
 	THUNDERSTRIKE_BOARD_INFO_UPDATE,
 	THUNDERSTRIKE_HAPTICS_UPDATE,
+	THUNDERSTRIKE_LED_UPDATE,
 };
 
 enum {
@@ -45,12 +47,19 @@ enum {
 
 enum {
 	THUNDERSTRIKE_HOSTCMD_ID_FW_VERSION = 1,
+	THUNDERSTRIKE_HOSTCMD_ID_LED = 6,
 	THUNDERSTRIKE_HOSTCMD_ID_BOARD_INFO = 16,
 	THUNDERSTRIKE_HOSTCMD_ID_USB_INIT = 53,
 	THUNDERSTRIKE_HOSTCMD_ID_HAPTICS = 57,
 	THUNDERSTRIKE_HOSTCMD_ID_BLUETOOTH_INIT = 58,
 };
 
+enum thunderstrike_led_state {
+	THUNDERSTRIKE_LED_OFF = 1,
+	THUNDERSTRIKE_LED_ON = 8,
+} __packed;
+static_assert(sizeof(enum thunderstrike_led_state) == 1);
+
 struct thunderstrike_hostcmd_board_info {
 	__le16 revision;
 	__le16 serial[7];
@@ -70,6 +79,7 @@ struct thunderstrike_hostcmd_resp_report {
 		struct thunderstrike_hostcmd_board_info board_info;
 		struct thunderstrike_hostcmd_haptics motors;
 		__le16 fw_version;
+		enum thunderstrike_led_state led_state;
 		u8 payload[30];
 	};
 } __packed;
@@ -81,10 +91,16 @@ struct thunderstrike_hostcmd_req_report {
 	u8 cmd_id;
 	u8 reserved_at_10;
 
-	struct {
-		u8 update;
-		struct thunderstrike_hostcmd_haptics motors;
-	} haptics;
+	union {
+		struct {
+			u8 update;
+			enum thunderstrike_led_state state;
+		} led;
+		struct {
+			u8 update;
+			struct thunderstrike_hostcmd_haptics motors;
+		} haptics;
+	};
 	u8 reserved_at_30[27];
 } __packed;
 static_assert(sizeof(struct thunderstrike_hostcmd_req_report) ==
@@ -108,12 +124,15 @@ struct thunderstrike {
 
 	/* Sub-devices */
 	struct input_dev *haptics_dev;
+	struct led_classdev led_dev;
 
 	/* Resources */
 	void *req_report_dmabuf;
 	unsigned long update_flags;
 	struct thunderstrike_hostcmd_haptics haptics_val;
 	spinlock_t haptics_update_lock;
+	u8 led_state : 1;
+	enum thunderstrike_led_state led_value;
 	struct work_struct hostcmd_req_work;
 };
 
@@ -221,6 +240,13 @@ static void thunderstrike_hostcmd_req_work_handler(struct work_struct *work)
 		thunderstrike_send_hostcmd_request(ts);
 	}
 
+	if (test_and_clear_bit(THUNDERSTRIKE_LED_UPDATE, &ts->update_flags)) {
+		thunderstrike_hostcmd_req_report_init(report, THUNDERSTRIKE_HOSTCMD_ID_LED);
+		report->led.update = 1;
+		report->led.state = ts->led_value;
+		thunderstrike_send_hostcmd_request(ts);
+	}
+
 	if (test_and_clear_bit(THUNDERSTRIKE_BOARD_INFO_UPDATE, &ts->update_flags)) {
 		thunderstrike_hostcmd_req_report_init(
 			report, THUNDERSTRIKE_HOSTCMD_ID_BOARD_INFO);
@@ -292,6 +318,40 @@ static int thunderstrike_play_effect(struct input_dev *idev, void *data,
 	return thunderstrike_update_haptics(ts, &motors);
 }
 
+static enum led_brightness
+thunderstrike_led_get_brightness(struct led_classdev *led)
+{
+	struct hid_device *hdev = to_hid_device(led->dev->parent);
+	struct shield_device *shield_dev = hid_get_drvdata(hdev);
+	struct thunderstrike *ts;
+
+	ts = container_of(shield_dev, struct thunderstrike, base);
+
+	return ts->led_state;
+}
+
+static void thunderstrike_led_set_brightness(struct led_classdev *led,
+					    enum led_brightness value)
+{
+	struct hid_device *hdev = to_hid_device(led->dev->parent);
+	struct shield_device *shield_dev = hid_get_drvdata(hdev);
+	struct thunderstrike *ts;
+
+	ts = container_of(shield_dev, struct thunderstrike, base);
+
+	switch (value) {
+	case LED_OFF:
+		ts->led_value = THUNDERSTRIKE_LED_OFF;
+		break;
+	default:
+		ts->led_value = THUNDERSTRIKE_LED_ON;
+		break;
+	}
+
+	set_bit(THUNDERSTRIKE_LED_UPDATE, &ts->update_flags);
+	schedule_work(&ts->hostcmd_req_work);
+}
+
 static void
 thunderstrike_parse_fw_version_payload(struct shield_device *shield_dev,
 				       __le16 fw_version)
@@ -338,6 +398,24 @@ thunderstrike_parse_haptics_payload(struct shield_device *shield_dev,
 		haptics->motor_left, haptics->motor_right);
 }
 
+static void
+thunderstrike_parse_led_payload(struct shield_device *shield_dev,
+				enum thunderstrike_led_state led_state)
+{
+	struct thunderstrike *ts = container_of(shield_dev, struct thunderstrike, base);
+
+	switch (led_state) {
+	case THUNDERSTRIKE_LED_OFF:
+		ts->led_state = 0;
+		break;
+	case THUNDERSTRIKE_LED_ON:
+		ts->led_state = 1;
+		break;
+	}
+
+	hid_dbg(shield_dev->hdev, "Thunderstrike led HOSTCMD response, 0x%02X\n", led_state);
+}
+
 static int thunderstrike_parse_report(struct shield_device *shield_dev,
 				      struct hid_report *report, u8 *data,
 				      int size)
@@ -364,6 +442,9 @@ static int thunderstrike_parse_report(struct shield_device *shield_dev,
 			thunderstrike_parse_fw_version_payload(
 				shield_dev, hostcmd_resp_report->fw_version);
 			break;
+		case THUNDERSTRIKE_HOSTCMD_ID_LED:
+			thunderstrike_parse_led_payload(shield_dev, hostcmd_resp_report->led_state);
+			break;
 		case THUNDERSTRIKE_HOSTCMD_ID_BOARD_INFO:
 			thunderstrike_parse_board_info_payload(
 				shield_dev, &hostcmd_resp_report->board_info);
@@ -395,10 +476,24 @@ static int thunderstrike_parse_report(struct shield_device *shield_dev,
 	return 0;
 }
 
+static inline int thunderstrike_led_create(struct thunderstrike *ts)
+{
+	struct led_classdev *led = &ts->led_dev;
+
+	led->name = "thunderstrike:blue:led";
+	led->max_brightness = 1;
+	led->flags = LED_CORE_SUSPENDRESUME;
+	led->brightness_get = &thunderstrike_led_get_brightness;
+	led->brightness_set = &thunderstrike_led_set_brightness;
+
+	return led_classdev_register(&ts->base.hdev->dev, led);
+}
+
 static struct shield_device *thunderstrike_create(struct hid_device *hdev)
 {
 	struct shield_device *shield_dev;
 	struct thunderstrike *ts;
+	int ret;
 
 	ts = devm_kzalloc(&hdev->dev, sizeof(*ts), GFP_KERNEL);
 	if (!ts)
@@ -418,12 +513,22 @@ static struct shield_device *thunderstrike_create(struct hid_device *hdev)
 
 	hid_set_drvdata(hdev, shield_dev);
 
+	ret = thunderstrike_led_create(ts);
+	if (ret) {
+		hid_err(hdev, "Failed to create Thunderstrike LED instance\n");
+		return ERR_PTR(ret);
+	}
+
 	ts->haptics_dev = shield_haptics_create(shield_dev, thunderstrike_play_effect);
 	if (IS_ERR(ts->haptics_dev))
-		return ERR_CAST(ts->haptics_dev);
+		goto err;
 
 	hid_info(hdev, "Registered Thunderstrike controller\n");
 	return shield_dev;
+
+err:
+	led_classdev_unregister(&ts->led_dev);
+	return ERR_CAST(ts->haptics_dev);
 }
 
 static int android_input_mapping(struct hid_device *hdev, struct hid_input *hi,
@@ -599,6 +704,7 @@ static void shield_remove(struct hid_device *hdev)
 	ts = container_of(dev, struct thunderstrike, base);
 
 	hid_hw_close(hdev);
+	led_classdev_unregister(&ts->led_dev);
 	if (ts->haptics_dev)
 		input_unregister_device(ts->haptics_dev);
 	cancel_work_sync(&ts->hostcmd_req_work);
-- 
2.38.4

