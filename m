Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FF16C1289
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjCTNCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjCTNCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:02:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB05869C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5UN0HECYp2aZhh3vK2fsBB6MWSaX1pjHRbBWG7aB1ZPJXZJbAsVAdrAqSlXOmXbaf0vX8oDhvu/q+2fO/Fswna32i3BT4MqWHjjlKgBlO7eZQOfucRnXA+lovFDPAvpiZOihe2iyY/eGdjE4qTIOxGTXNUelUYGlp0ftQ0PjHOPRZZCb8vaE7IvwyUTrdPcXoAWnedZmAhZoMecZt+F2DMhh0pCAqh3hVqohdXXkLIP4StE3bUfC0/DNj8ZfjUyy6EFpPf+qqagUw3QGiXVpHXDBiyYh7rrdDpV58gNPSlOzHePjhWb9jE4/2jtM0LeKLxe3UtDuZ1YN17u/SW9Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaKE65JlT5hAphJvF+iuwKrvyyKbMsr+riSrODdiNAg=;
 b=UQy6x8apKmzTKzv677L+dLDbN+c3TAjlN30ustNnpfu4l+/OcaBTr95KyWVqFEWv8pJTRYt9SdIS/qtS4yUlMzQFZe9GXzQuyihq+HquZtl446uq8Sz8XvBr7CUlykcQ9iTgTHxpB7O6ZFOkVGg/i35tuK/hHJZXCGb/pLDUSscELxQLi3+npGDza8a8MV8Rcqw+hfHOy/aYgBrdIIFf8o7H4CUV70nGDL6hL7LV/qhH0a2gQ56HDkv+RYQNDKbqiMh7gfeZzDFpAuFpE0Vji8K95BhwJUVTscPC/z/v1fCEnCnU8Gm/rri6cVliyI2UhYzSw1YMTjheAK8hjvo6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaKE65JlT5hAphJvF+iuwKrvyyKbMsr+riSrODdiNAg=;
 b=TH+skTsH4inrYXU39mUZzbQLebUW1V6c9rF4V0q7cmoWXD6/eYbThChCVPb/9KM3lxks4DUUgU2K8JOTWInVNlezQDW+wqNZuur/JiVuBOVLN84EMYiy1RLHBM8oWqsNa9dFypPaUpGY5fefSLAleMbR0F1XPIUWcZBKOlzHeTwiQ+jWGLRIy+DjidjmtfuybImifbQpGnkDGKSOiTwn8HASYcDpFBmu4mY4MUNq70WRB/HwJetqRKu7nc0GoSECLRTqdKpf5Uc2I21RolGpROv+l3+qaM3SdLalrj5VFbMc1kwJqQjnSgfgxxNIYUvYbQjKVnni5mh7P/Xl4LKG3A==
Received: from MN2PR12MB3616.namprd12.prod.outlook.com (2603:10b6:208:cc::25)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 13:02:44 +0000
Received: from MN2PR12MB3616.namprd12.prod.outlook.com
 ([fe80::2731:164a:b932:d08b]) by MN2PR12MB3616.namprd12.prod.outlook.com
 ([fe80::2731:164a:b932:d08b%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 13:02:44 +0000
From:   Khalil Blaiech <kblaiech@nvidia.com>
To:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
CC:     David Thompson <davthompson@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] platform/mellanox: add firmware reset support
Thread-Topic: [PATCH v1 1/1] platform/mellanox: add firmware reset support
Thread-Index: AQHZOxm4twa29w0p5U+wuxQvER00lq8D4dOg
Date:   Mon, 20 Mar 2023 13:02:44 +0000
Message-ID: <MN2PR12MB361617473A67AB50CFDAF29AAB809@MN2PR12MB3616.namprd12.prod.outlook.com>
References: <10da04fa43e8acce5d4ec173e225c28b9e979e4b.1675790783.git.kblaiech@nvidia.com>
In-Reply-To: <10da04fa43e8acce5d4ec173e225c28b9e979e4b.1675790783.git.kblaiech@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB3616:EE_|PH0PR12MB7930:EE_
x-ms-office365-filtering-correlation-id: b11b748d-af3e-4da8-5b51-08db2943658e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TzOJC6RWIySZ9guN/B/951mpoXTTUJk3X1r+cs20NUfZb9GCrD/n12oUgk3ejwUpfV1EJsIuKbs7zCfih/FFmGU9dgcckOAASvA5ySbQcDP2mF6qC8kRiJNhhFMdg6T6J6VKiIqB2bZDihYKRShNug0KbmP9XyN8vqRssrI0xmCp1FBTVW9rKEQg3ywh4WekRyXKZQgTMUbmgzkReyE7mOz73yLHWGGLU+ScE/0+lRCy9YevpI4D9CxDJ9Gf7YlLGZb7TDp9fOeqNk4mIq1C6euQagNyyXglH78SCFzVFCPuwyci2qrBlUSHGQUYnlzZqqCy+P2nNiikNXhxIm2HzblRZi+SV6Kcp0Lq08sAmAZe7O2ahDTuar0MiDvMiEj68tWgS9bAaCn5XaREmOAGdXdXWZ/HpjopYQZZNFHtFrMxlPqabHB629RdXmsljdLuknlZfK6TqwIeN64QNmfeQt0ev0TZyAJMEZCLgePp+bC2QY/n2t3P/eolIb37TVsryAaV+oO2jHkBDxxkCkqd3VUtdOrjB5DbsM9tv7uZU2LdGdEx/bq3SfB5hkwdYsHUnfYhYFXFEoEqgcJJT3BE0mZ9aF2IGR7QKsQOohw5WGzzB7fp6ZVbbaATfXf/GHUYfNuyEjheOhLiE4RiF+/HjQmXeUJW3dh+bPNiNNEY9yIdqbA/EPa+ePrHmnTAzW5ehHRJxIsGr1SVj5SMceXk8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3616.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199018)(83380400001)(54906003)(55016003)(86362001)(38070700005)(38100700002)(122000001)(66446008)(4326008)(8676002)(64756008)(66556008)(66476007)(66946007)(2906002)(8936002)(76116006)(52536014)(41300700001)(5660300002)(53546011)(186003)(9686003)(33656002)(26005)(316002)(71200400001)(110136005)(478600001)(6636002)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bPo+ncAerK7vjdka8O2mQ+d1UURcJrnnUgHVmRPIiHDybkaySk+Ww0Eu/BJH?=
 =?us-ascii?Q?XOwfYOgI/DoL3GYOxm/ZketWj+A52Wd9t0bvQ4KLqCah1IB/VkOwTWTot0fR?=
 =?us-ascii?Q?Kw0o7Q9O4HMjjkpV/yIkSwPHzuvbbfBEon5UO2FKNDF9TALXITcvuDq5vx1c?=
 =?us-ascii?Q?ZLX+dom2uRvaTYZNxGAFMPW7kLxI9yN0wxLj+Ae5Au9+5ulzDIJ3cEFdPpQm?=
 =?us-ascii?Q?7HNPCNNy5ziPYtO8rkMRokCk01IU1LSO7wYbxbWIe4jTbkAlUBBI4TP5UWT+?=
 =?us-ascii?Q?WCETJzwIMZYvvEb/z1+0NsvrOrQMkDDRIRN1RpgUkhWNrzczQxy2fljsYNLI?=
 =?us-ascii?Q?VrMQzinMzDwW/35SUymtJORq9rESDYGsgRWRDk33/3OIv4bUUHSDaIQq1DNr?=
 =?us-ascii?Q?HA/7afjMynd7p0DcI9UddX+WEjhYQEkUCZ1Ss252eX0N1aZUQOk1+3cxFJDK?=
 =?us-ascii?Q?5MvTcM9IPCR8wKebZjwx8Ws1DQ++W2vTPP3qIHrbaq/2m+HcrwdXkq+POBwb?=
 =?us-ascii?Q?CUOboczVK7D8i/8GAsZvt2+eoGeo5CXZYlsSzPXGLd031oHGLKocqZLhe9R+?=
 =?us-ascii?Q?3isXiyBN5YEycYTbxtYXoXfPs4rSpKG2jBJqQIdu2RxyJMLK5ms1lHsx6TGd?=
 =?us-ascii?Q?835WBHslFaXDk5uulNMcOl0QA2e4+i6xeg8exm+1aNOCeXe8LhSlxssYz/RN?=
 =?us-ascii?Q?G27ndow2sjREXlgvbjxWJXnIyNfB9bHqUHFrDtFVcRvW2DqaXor8m2VhuWvj?=
 =?us-ascii?Q?UMngc1GbQKzsF7vleYRn7rcn7bMa0FVE3DerySSX+hc7zoEmlmMVutT/lP2f?=
 =?us-ascii?Q?R6roZkxWi7heCuZ4SrRH3CemkLt9HmaSlOnwJAjRUkyRt7p3xKiKW8EQqEs3?=
 =?us-ascii?Q?hVPV7sOWYyKkm9HB8abiRpxcbZzmzeggIHRcllPFQls4ovTbITwruvaAfTzO?=
 =?us-ascii?Q?Lm1D+lVX2oZdInjOUnzRPViW07IMC7xwCIrShElKv0wF3xIU3W8sywva9MGe?=
 =?us-ascii?Q?pdFT5eDiUT0uEXJ93ziLDPDPU9UTKWUyIYaanauZm7fA7+Ofx3iRlB+Qn+em?=
 =?us-ascii?Q?Xdqi6yNVTtQX47BJFEeKRoTtILt9qQ+H1wTbJTGzhttSvTQ9ugqoEPjN/SZn?=
 =?us-ascii?Q?L5oIi3lS9O042nh8N4C/Mpe6S72T5TgF1HAFyPWSxumoX+7lnSPqeEhzLu0k?=
 =?us-ascii?Q?+jc/imzmGFo/b52qVkZKuKmUJUWckQ65pO5X4aHOsBI8z5fYqQLYj9uHkE9/?=
 =?us-ascii?Q?GiEnC8aQfYP62b3KvXUZyNzIq9dneVN3EZsf2KUUwvNRhioYhr4iSdJ3up/S?=
 =?us-ascii?Q?tV5NkL3YNn9HYbn1vHuXxzyWEjFhQjW9Zzq2TXlW0WnXAKOFLBBfrx+nnXqq?=
 =?us-ascii?Q?UfFkU8ieWlz7TQDOF6GnmQPAsuCmDLjgKeGSt6NvW/7TXYXdQ/Cu9LnT6EXK?=
 =?us-ascii?Q?dArbRq1hwf4mLHW27M1jQOWN5cdxV0qMSEV/T54V4oAUy5B5g/e5tOguChdK?=
 =?us-ascii?Q?JyiQMOrZJ6PXOpJ78Uy7/ZqywzEqnGGkdl1XF4TqV8nJnd62NOP1jbVJ9tm7?=
 =?us-ascii?Q?/ETBN68VNGe3JVAP6FiVNN38mrxegndaRr2+KN2M?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3616.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11b748d-af3e-4da8-5b51-08db2943658e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 13:02:44.6120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xFOm/B+gSJbqUm29oxIjJZkUCepYBJxcpB+QSzZJdhsQU5mzooV2juVPrCYR5sfH8RYsTzxRjlPVSuliIsIzow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-- Have you got a chance to look into this?

Thanks,
-Khalil

-----Original Message-----
From: Khalil Blaiech <kblaiech@nvidia.com>=20
Sent: Tuesday, February 7, 2023 7:14 PM
To: hdegoede@redhat.com; markgross@kernel.org; Vadim Pasternak <vadimp@nvid=
ia.com>
Cc: David Thompson <davthompson@nvidia.com>; Khalil Blaiech <kblaiech@nvidi=
a.com>; linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] platform/mellanox: add firmware reset support

Add a new sysfs to initiate firmware reset in isolation mode.

Reviewed-by: David Thompson <davthompson@nvidia.com>
Signed-off-by: Khalil Blaiech <kblaiech@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-bootctl.c | 19 +++++++++++++++++++  driver=
s/platform/mellanox/mlxbf-bootctl.h |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/m=
ellanox/mlxbf-bootctl.c
index 1c7a288b59a5..5e41c270195c 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -244,11 +244,29 @@ static ssize_t secure_boot_fuse_state_show(struct dev=
ice *dev,
 	return buf_len;
 }
=20
+static ssize_t fw_reset_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count) {
+	unsigned long key;
+	int err;
+
+	err =3D kstrtoul(buf, 16, &key);
+	if (err)
+		return err;
+
+	if (mlxbf_bootctl_smc(MLXBF_BOOTCTL_FW_RESET, key) < 0)
+		return -EINVAL;
+
+	return count;
+}
+
 static DEVICE_ATTR_RW(post_reset_wdog);  static DEVICE_ATTR_RW(reset_actio=
n);  static DEVICE_ATTR_RW(second_reset_action);
 static DEVICE_ATTR_RO(lifecycle_state);  static DEVICE_ATTR_RO(secure_boot=
_fuse_state);
+static DEVICE_ATTR_WO(fw_reset);
=20
 static struct attribute *mlxbf_bootctl_attrs[] =3D {
 	&dev_attr_post_reset_wdog.attr,
@@ -256,6 +274,7 @@ static struct attribute *mlxbf_bootctl_attrs[] =3D {
 	&dev_attr_second_reset_action.attr,
 	&dev_attr_lifecycle_state.attr,
 	&dev_attr_secure_boot_fuse_state.attr,
+	&dev_attr_fw_reset.attr,
 	NULL
 };
=20
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.h b/drivers/platform/m=
ellanox/mlxbf-bootctl.h
index 148fdb43b435..b48243f60a59 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.h
+++ b/drivers/platform/mellanox/mlxbf-bootctl.h
@@ -75,6 +75,12 @@
=20
 #define MLXBF_BOOTCTL_GET_DIMM_INFO		0x82000008
=20
+/*
+ * Initiate Firmware Reset via TYU. This might be invoked during the=20
+reset
+ * flow in isolation mode.
+ */
+#define MLXBF_BOOTCTL_FW_RESET  0x8200000D
+
 /* SMC function IDs for SiP Service queries */
 #define MLXBF_BOOTCTL_SIP_SVC_CALL_COUNT	0x8200ff00
 #define MLXBF_BOOTCTL_SIP_SVC_UID		0x8200ff01
--
2.30.1

