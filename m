Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0991161249A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 19:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJ2RXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 13:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ2RXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 13:23:39 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2038.outbound.protection.outlook.com [40.92.99.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08393FF14;
        Sat, 29 Oct 2022 10:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PF0CH+xU9AeEPgNSyXA26EJhhARc9hxY6PCZsDw3OLlLDCAbpJ0BYpIRNOwoua0zuSf0g1RZWN3lcERgcS3DI6knbmBglQyK03e9mVy5u7yTVCNCp8AFW6PTH7ikz0I2Wo6CkP8zJqMPmXc03cphMay9Kh2EfsHAMrG3jidGcm7SguqeQp08NjFXXLNRUhQ0OTMoIj+/DJx6pPZn8mz9sx2ECEzP7GMWYgRI8mVWAYodvNmSGWYZKavHWj8u1KA5uHXEnuDSUXEfXvOmXl11/uHs6Slz0x8MGK+cxiruCBi/Dv3VI4HUM3ImUb8gvTrlMf3CDnIM8xoCHdYh7IO8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7TV2Yh0je6pVVsH3QCx59DI87he9aJmHrnfel1EOxE=;
 b=KOTQSyBY9xe9Us594NWrUJpKaBlEEPuwaNbbBzy+Jt5N9XolqrO3zYjj2CZsLfyDqZhZbtoXI3DS0ZLC/R6jV8uWaWunk+wvy3dAp477Mc24+LTPzm4vYZr+b79cZP/ivg1FcddF0seGFlKj5QMYBSvuf6ha2SYmzVdBV/eHw3ICCiEvVeJzoYplwNroczTF8DR6finen5l+fY4jUrEr3q2leBr+ZJaV8S8L/SzlzOJGweQzwLorPOhIEQz5J8sCAhpEf7koYXamu3P5R7La04tgNm8I7AvE/Tfy/Dj6l1PrcN3l5F82RJpCf6FfA0FqIU5nGQ6CmYu0aKSWJIQWgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7TV2Yh0je6pVVsH3QCx59DI87he9aJmHrnfel1EOxE=;
 b=icPwHSM5CkQ3q+uKIeA8N3rqyJPtZnlsQv5Pez0wB4wYT1VzQ8e1UunFM2koKWaUuOLDQxMnxz9eq8aRw2Y1/hdZOzRKZh/xfrajPz9kaSgP0IDC+WSoPndGtrqDpb24+TEjuJUWBkaAuuTpBB4EcKuBa1IXXqdI6LEn/+oFB0tK/28YGeoVCNoAjIJ6gaesYTI2RwVbJ6VXddlsRmwqiwkJTJ7I9e1FuhOYSJa1dy0/3TTHU/dL/0c8aUQfVXkKMzxUJIPcimcdKdBZ5YsLCsMaZEpmgZRUDOZiwzbBiTt5vqFZUatyqO44jEvLIjj+EIynNdIQ4DB2uM+mHKhSwQ==
Received: from OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f9::12)
 by TYWP286MB2249.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:172::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Sat, 29 Oct
 2022 17:23:35 +0000
Received: from OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5c85:eeae:9c31:93fd]) by OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5c85:eeae:9c31:93fd%7]) with mapi id 15.20.5769.016; Sat, 29 Oct 2022
 17:23:35 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [RESEND PATCH v3] Bluetooth: btusb: Add more device IDs for WCN6855
Date:   Sun, 30 Oct 2022 01:22:54 +0800
Message-ID: <OS3P286MB2597E5DC0322DE5839B85D7698359@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [jyRu3eEH0ItMcwgLrsvEYAaDXeRNX9Xt]
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f9::12)
X-Microsoft-Original-Message-ID: <20221029172254.23-1-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB2597:EE_|TYWP286MB2249:EE_
X-MS-Office365-Filtering-Correlation-Id: 9653d8e5-1f93-44bc-0a57-08dab9d24fa3
X-MS-Exchange-SLBlob-MailProps: kUamOxQfZqUZw1L0xBp99J2Lxi3OqOkldHumdZxgEBx4j4ij8mU+Y2GwNoVhJmRV/VOnyxNQkBbb8LMCUIP8afq5i2BehJv8Vb+NoeiDvHz3NqBR4QWRuWCJG/6Vty0Od22jBU80cedmLqS1Slqn/zoUyZo+9kbV+MipK8jYekkSUK1DrmeJOJrv06wWjPLtPSuUlVKaA9BXr49vGD5y9uOWZRERWQdI3nj6G7SwfOn/h/Bv6OgorsxOduYegxp5ssjlyUukFc2+ljjYLFKWpdaDBVQ4Lr1soEksYbheJ/+uJsRU+ovD6R9DczoXqyAiz4YyTF2m3bL1Dq+0oMuqoEbaNgPpDxxsRSE4pH3hLEtB3UKdOM4js7uzxOBsmLljah9RukubjLiy8eXS7gGVuol+ApvxUbZ4mDbblHQapoVjpmRIKMdLbjvRPymafYcmzd32nha4YqsonNNbJphQM+BaEesUA9vYzbHq+7E4U+/z2+axXOBS/e4I2kuKc+jZ9a2CnCvOPwH7/AcnLEmLGnt0/XoBssYAhDvkVcwVjDkpImT/pWuWq/aHGvp8ro70AyPEdJx4cUNWfGVLG9oKmQvEdlBDyQKUj7px6s4wEGq5natGMxp1VCxbJujziKiHUIBD0GVObxmggz+uMr2b4j2loDDt8MZI5RRlRifUY8MezIkuoshaifemRm0WtAn7OxqPqoaqVtGZrM2mScjx+p7dTGkoh1jVFDv0jKS/tYsIjH+tMxjbvPNp01D0ZIbIRThyV7HFaRXDxio8Kgl0BBqMA6rFLer5xwU52ZefPyE=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVPPzXJN8Wk6pwV5Hw2B9nBNBSaN7/dzIffJVe5a2py55G30E5sWaJMcC1fziaS9X8S//qlhrdt3WJUbJUQIM+CzEru21o4OG6R5K+Y8aVxReD3oWUcEKFKrK7saxQXhF/+FvP+PUahQe0oGD3shILh/f8olHta94IsW2w1Dimg5PVg8oOAPDhwWqD7ZWvlgOrd84w8HFthtNvlz1pp5NJK1J63Jo52ncShxWQPPdcrFlb28fDzIHcGQnBMWDYWnI8iJ3988UCv47WWLUbYz5ao5kL9ZCdUf73HJPofIGznYWQRDnyYx7ZDxU5TXxiCXl7fN8h9sFdXdpO/BvIQktLh0Y+9HlZOf1IX9leXrO5g1Uky3rZgyQfcb42EGlf1GiF3g+7MJgToycawQCcKXv3c5Ox7b2Q9J6gxclNNAIK1h2qv2+z/nZAQtcqi7r/aEx6sng9w/fkJb+F5OOyeeMrjuwo7H1V98v6td7V0y51Y7sHiurwR7B/SXiAovx4phww7JEYjMUDe9+UM3hsgoEFV49scxKT2WL4K491HUEJ0PSCdJ/AHHiylTT/RMMPfKF1QGHLDfr1Gt/K8r6rZmINvT9oTjfwmetYOijMorHNmMVbFYS9yWKNw9zXw26NU2VrutIrfttIgHJWmcCCjUgzPmOM2sdo1TKE18PmxiNeRRIkIbDz+dabTQMMlrbH3/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xDnqr/ISANsvI64fCWQLgT5SChDnH22TZ+nHB8Et1MiZDcORUM4c7Fi4xmjt?=
 =?us-ascii?Q?Rx2zFwJwGGnEqPvFV0bDxnLEWsRE3H4Cu8HgB+ugh3fTqWz7Z0OZ1C4pHkW4?=
 =?us-ascii?Q?oQYmbV0V99JQkgDwMavYfkxEv4h8N76w++WvdLeMh60ApnW9L3htJBSnlWtH?=
 =?us-ascii?Q?VTdbnk9zT6kcmMJfnDVW9Jrn9aM9uA6njvh5wfMykNG6FRH97o9zeHCCaTgx?=
 =?us-ascii?Q?oq30ZgIy/FN0Bzc/jkh6S4I+NkgWsunZjC1gk199uCpofqVRN8XakgUBcf2i?=
 =?us-ascii?Q?ww7c3bqrhW8QgEDWf3ge1rlFHQ+jFIKkju8fNmEm/cYpffxBXdCZyad4z7v9?=
 =?us-ascii?Q?CKKiufL/ShxPKzpZg1RsC91Re2imRmz2VH+P0qIK6UPpxz4+xhriYB1uYHZF?=
 =?us-ascii?Q?XdXGIoxYiF9oqPrCcxBz6JFYfg0PfL4PxA9iS5EVgr6g200rZneyfNPZcOSR?=
 =?us-ascii?Q?KRJxK+tTpCH8VTXcP+/4Ld/OyL+56zurwqK3q7g9Ng719qh/J+j4iNq7QEFZ?=
 =?us-ascii?Q?6th4JFefM226R07eB7bdNPs38WvwRZoyRtKE1G5QG7RHM0RboM/qlljopVZV?=
 =?us-ascii?Q?g8wkW2a0u2T9aPNGm4VrdEQ3YC06R3VfGT0QDyqAFgLDlSlLUYJfVktjNvuU?=
 =?us-ascii?Q?DE0QJS8Xw4feCJibbWlx1GMvLk0p3yKWb7iQoF2/7trlxiY1I9qjnaYdOCra?=
 =?us-ascii?Q?/hfwVEh5ghWVr7r0U3SbK9OL56u1SwLq0SD08ZvhPO22kMjl1CMsQYAK3mVl?=
 =?us-ascii?Q?+jD9JEoI9SMfruu93Ga0Rti1mCpBXNJ5ea687yrVyHm/jDQ8Op6xVfxSczps?=
 =?us-ascii?Q?CrFE8RU+9p+5CA59LJJPyvd+2pTKnVg++wG7O6YdZXh1PAnuB7k6fLlH3wwu?=
 =?us-ascii?Q?u+YZlSH9+497mlaewOH0MZp0O2ZuNpzUo5z14D9ZVPK/ty1/+Z6IVchqICVe?=
 =?us-ascii?Q?O2Ueij8NPGTdwaF36a0GJG7Dz2j0pX88zgunOpAqMPgMWXZkeO5VSpdeKFtC?=
 =?us-ascii?Q?HWp79zFApYlwVTwmPVLje7EeOnUXOTq06ZvwAXqk/NU1wqJq+zntiSXyHvEX?=
 =?us-ascii?Q?c3EuYrjqH/3sgEVJqXHa/8vQ+0oEpYWFSOKNFCv8duHC6GierB8fX3dol4Q2?=
 =?us-ascii?Q?jxwMcICREcWM1smSDhCM656AOWJTk19SukvRVp3YMma2GPSvat/aXHkVWnU4?=
 =?us-ascii?Q?Vs9j2Y209welOB3MQnvIEZhNJomSEhVtoq4VjEbvQSkUvwM1p3E6W7hCQbtj?=
 =?us-ascii?Q?xXyLL6O+ntEiVJl00+OVjPecP864qL1zCp1HXmkNvA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9653d8e5-1f93-44bc-0a57-08dab9d24fa3
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2022 17:23:35.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2249
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IDs to usb_device_id table for WCN6855. IDs are extracted from Windows
driver of Lenovo Thinkpad T14 Gen 2(Driver version 1.0.0.1205 Windows 10)

Windows driver download address:
https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/
thinkpad-t-series-laptops/thinkpad-t14-gen-2-type-20xk-20xl/downloads
/driver-list/

Changes in v3:
- Fix too long address for windows driver

Changes in v2:
- Reflow commit massage line width
- Add driver version and download link

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/bluetooth/btusb.c | 84 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 15caa6469538..adf68affaead 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -316,6 +316,90 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0d0), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9108), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9109), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9208), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9209), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9308), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9408), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9508), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9509), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9608), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9609), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9f09), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3022), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0c7), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0c9), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0ca), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0cb), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0ce), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0de), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0df), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0e1), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0ea), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0ec), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3023), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3024), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3a22), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3a24), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3a26), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3a27), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* QCA WCN785x chipset */
 	{ USB_DEVICE(0x0cf3, 0xe700), .driver_info = BTUSB_QCA_WCN6855 |
-- 
2.25.1

