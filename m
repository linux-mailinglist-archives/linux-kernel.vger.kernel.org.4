Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD664D546
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 03:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiLOCSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 21:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOCSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 21:18:51 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDDB537DD;
        Wed, 14 Dec 2022 18:18:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFk2w0T6ZTYEX1NdEWzI19XnhW1NqRn3BmDVjtvF7LQYcan1tcWDCn8uRzeCiQV6AEbJR3wYLoiWfoEvyllPzHN5JeIa86PA20TaVwmCjiNo7ZzCxDBDu8ERJcjHZ5hLlysoC6cvTCQknbp1GC4PUIanaeMYQ/EfBuVyqXwpOZ1EuwYxzvWTuCzXcdu6iRBUUEe+71YiMfOFdlvFilwIn+0F9XZr7GVzci9yX638m3y/0HScKKPAuO2zfI81iyd4TBXU8KWQ2N9EJD++vsu6frEBQjsabrgTx8DNu4fmeYjEWSt1vA5OhCo07RX9I6R4SCkn/koq2b1wafR2I5jG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smXtqnx7ANeXwx7Dj7BbEXRffcECQxjuWfGEI3zPSpA=;
 b=RKhELSb+tKnSvTOISyHGpTwcz7EIkXSjGPlGflRoLS1WQGsaYxpiwtPpLwNUrtSFTcIkDQuNq0LOQ3n5ES6tBuHOCakCasSYRUSdfjldZkBrYbRx4FOTEMtfhqKjyPqysRtQJehYtO1duUuo8v8H6GLPTrsyzcRwD/Lns7ORq4upUbcUAewdKPsidvO+Eajft+u8R/dM5EsAnH2IHEJfrHNglauRs/g3sAavZsRthwzaGaegQFnOIxx9tO43UOJdZr1kBoFO0D3X1ubiz0Ft71KXaAOnTtEqLrtcglY0Unhc3A72/3aEv84Mtxicc8GKop2/T1UuRpbH13fcvIvU9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=holtmann.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smXtqnx7ANeXwx7Dj7BbEXRffcECQxjuWfGEI3zPSpA=;
 b=UEEfPZZKVTyF3vnQXi3scFJzHnGPq7VLz5kOcLV1rNew8krRDtP41hK1EY/7kOmheVel0kp/zMmi1oEN2mXb8MHs6hrkg4oX8U+61YCU3GllBg4GvaItHu3/IKh8JihsutQgB3dr+lj9Iq8KihOpuIb1MU5xwldVrTS1i8Vp3KU=
Received: from CY5PR16CA0007.namprd16.prod.outlook.com (2603:10b6:930:10::18)
 by CH2PR12MB4969.namprd12.prod.outlook.com (2603:10b6:610:68::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 02:18:47 +0000
Received: from CY4PEPF0000C97A.namprd02.prod.outlook.com
 (2603:10b6:930:10:cafe::4b) by CY5PR16CA0007.outlook.office365.com
 (2603:10b6:930:10::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Thu, 15 Dec 2022 02:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97A.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.10 via Frontend Transport; Thu, 15 Dec 2022 02:18:45 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 20:18:44 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Mario Limonciello <mario.limonciello@amd.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Anson Tsao <anson.tsao@amd.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] Bluetooth: btusb: Add new PID/VID 0489:e0f2 for MT7921
Date:   Wed, 14 Dec 2022 20:18:54 -0600
Message-ID: <20221215021854.1429-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97A:EE_|CH2PR12MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: 4623d70d-cb9f-48d1-ad9a-08dade42b1e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/euQDTDSFJNQ4nh1mdivmc8ulG3P1P2NWTZ0sdpFT7sGrfwndJcdbLDjRKe6NpQg7Yot5bGqVxXaMaOc44S6xI9hI0NESJJiInmtS0+ZAAzkTjB8T+WHe6WILmWA7RkClG59VJenHTp20Cu74H1L94WdoLCaCkH3ha2mmynBW89jo2C8yauXwLAv8k3wDj8CsdvZpYAzd0htExlT7m82l646slp2LKIc0FbJfo37BiZX0+94Wfn0218ZVR+gRZpEs/vFb4XrXjHmZCEFvYVHYnFHv8C4GHPNNvLMk3w5C+iq4JCyJjWUfDD6S2bPoyZaEpVwwZmiD70/3cQUlDZZbZgTsjVHha3HQ9y7WRBzbnATqfdLwIc2ZooruUgiNTWC1S1ejYvdsuVgGFJHWslv0EVYrIb5sV4osrbsD269IFP6TlT+IEIBu5a9+29Uye340FTF3gnbzMjfZMNXODqqPKJy0BjPsCjAbMxSc0/aN1S29fI+mnrgi1Zp8ed/jyvX+5v9yrfuH22asUgesx/+wdPSNAfLlWcqSKcxmSGU/LN14QrRffXwGr2jqnpMjr9VX2Uu93lk/SG3rq7eFLkhfVEhQvOLhbS4nMrOh8C8jQmybIV06FMg8MUhac9u6HlnJGk2vYLH3h6dxIyTRDrsVGHQpsjNqNQOKIbePUGPjHNCksDxvrvK0l8weyWMo2rGS1lMT2oMaMW+cnJAEdNejLMWAEN0bxzgoZcFkxWKKU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(356005)(81166007)(16526019)(2906002)(186003)(40460700003)(82740400003)(336012)(1076003)(2616005)(44832011)(40480700001)(8936002)(5660300002)(47076005)(41300700001)(26005)(36860700001)(82310400005)(86362001)(36756003)(316002)(110136005)(54906003)(426003)(478600001)(8676002)(6666004)(70206006)(4326008)(70586007)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 02:18:45.8924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4623d70d-cb9f-48d1-ad9a-08dade42b1e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4969
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bluetooth device is found in a combo WLAN/BT card
for a MediaTek 7921e.

The device information:

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e0f2 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us

Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Anson Tsao <anson.tsao@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f05018988a17..c413826787b5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -473,6 +473,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0e0), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0f2), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x04ca, 0x3802), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
-- 
2.34.1

