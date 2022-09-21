Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD975BFCB6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIULDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIULDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:03:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEB595687;
        Wed, 21 Sep 2022 04:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXp/jJriNheoAoaUjC+LMu/dIkakdtqgOP6iY6yiGnSpNVV/GIZisYeSlX58z21xkr2r6vMxGwjL+uU+c9XRIIqooR55MAmjnMEkADH2vqWeinDZDVbeD72lLtEUmMKx/cUpZF6YftjY67SqJtt3s0cf5/RdTSqqQ8lF0ImlhsDbEKdt23V0S4Pijm0WNHzOJLxCiz7Y8WQH+YfO9n3MhhI2TshRv6PlQsgT0j7S0yql5ju07GT3PHLC/HFKlbYEsew4OnSLYyIvN3wJt8U8c/QaAowmlSbCOmbRbziNR+3oa/lNSOF61oAbAzlfj90iXNWeFxjo716+/lpsOb0rhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sU+zHnPgLHJJCT5N3U3450AMd2QJ1YJDl9rRNjsSR2w=;
 b=jfJ12Dk0jYzwGIXzJPTRt7HEwsJkoJXpn3C5CTaWbduqrC/vsQ9H+M+GVQFmbAHyAOdGDpj3hUk4tcD/kcjOX1WXstC97lRcb7Gj3D1/ZZKiymFB92/yRWCwyeQyb/sp3DTSf1K/r+/CF80W4cGUBbmksQTwB2QYMDGjfyWEqfdIQQqgjRakCSUU3c5hXJW6gO3fCEaRCsGmTERFRBNov0TjKZ2Y3kB5lUqVHN8MQuXewCINzS8HiiOTLQsB2C/Jbp/tAEWkJCvzs2n9xV3Gg/p8cQKbs0DsBDFXDXoCYbCJFdDMMu9HSJYeyOGPCZ+4U9wDbnNR/7CdxBNllh0/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sU+zHnPgLHJJCT5N3U3450AMd2QJ1YJDl9rRNjsSR2w=;
 b=Z+f9ene4Rp6SxPOheHSN4bHlXGpEIoIAJouhKm1XeWT84SdbIX3wq2xsNyutZ03nlZBijRaQuzFufhCmuXs35EIz6dC4BhyCZMynJgjfZaoLOlrvbaWWSYmHO1O0R2r9mFUy86UGFMmErARAHQOzhPGLKjD1ADjGFVaipPY6VMejauNOXEU5SO/FOkr/+bJ0cJBRLyfsBRYZBM9AgZRw8DJhczy7nurue7neGRS0JJXmaVAMmlsowH5FnpcZrQ+KUUTY9XmJfR/sL1LYxU8dcvZ+CcC8c1k2XpoY1v7dcrqFUUIe4Lrvq5IkpkyQhIoWRbEogWYf4O+ZVHHsAfx8kA==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AS1PR10MB5261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 11:03:44 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e455:6769:fc57:e85f]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e455:6769:fc57:e85f%4]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 11:03:44 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/6] tty: n_gsm: add enumeration for gsm encodings
Thread-Topic: [PATCH v3 1/6] tty: n_gsm: add enumeration for gsm encodings
Thread-Index: AdjNqURiP100NjxhQNOEr5eDABoNCA==
Date:   Wed, 21 Sep 2022 11:03:44 +0000
Message-ID: <DB9PR10MB588158E9108FAE41061B4790E04F9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2022-09-21T11:03:41Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=7a128268-309b-4f96-a0ac-ce0ae42076ab;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|AS1PR10MB5261:EE_
x-ms-office365-filtering-correlation-id: 3d1d21c8-484f-472d-3606-08da9bc0f374
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XKuG0yvhv3KfyZ3O4Jecj8lOUdvCzqLbKy2iDDALVg6DpAzFqmZh7YuHK2HVds4Hs/7CWvl/UbSQ7CjAMDttcf4d4Vuwh6xwtqkb8AHwhhT/3pa1Bgf6neN2LUJAvu3Ysm9mFxi6ep+pjW3nMuTbb9x4fe7vtLTyHtqB31VXXGOh2y3GPYrbvFwRKPIlPGIRbIrWhgIFVGO05OsuMvsYpsz7ogZFWPP9NiP9RyRNxdEQR4dATGxqrpDUIXBpL0Dc1rkWs8vUEiQbyPPJbGaHI904LR+9MtjCk56dRrLY3ODjIatypR/3zfsCXQuKXZ+31zELIqB31YGMGYoRF7HTsaJ9j7tUEnUfNIxjqSZJt4490bk/yvKAKvLypTpiz5ViLPrgBhSI4Jk0NeQofZbpQ/P3wPObtemebqN06qR0/MYVW/d8PnJmauM9o7erKyAFkMdH0ojTKTC6OKdJIWHtv5+KtFJBylCEeigUEW7YPnNwyVdU9iMlSv1Y0DradeCAOWaAp94JXIM8p1cv7refr/aSyXPZtD8zT7ohCx2Jodp0HAgRe51ceWp5vHZj0VOjk0HycwdjcanSLRsYNQXpeJGZKkv/9ISaef0yTmCXaj+2S3mn1t2uBmQaX7O6c1vPaAW5y5JLZKLjGu+mSVzrOidWoAV7oWcuKebV612TTLtqiyGUh6UaJNQSvxDoKy1e21sqkLUsq8QXpe6SSqfpjZBtp63Y+AgDA4zmRB5kkAewjgC5Ucu+5HlTWQJ/PyD1CiB4GhRkgVExDteeudXwcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(41300700001)(186003)(71200400001)(2906002)(76116006)(4326008)(38070700005)(478600001)(66556008)(66476007)(8676002)(558084003)(5660300002)(7696005)(86362001)(38100700002)(66446008)(122000001)(6506007)(316002)(33656002)(66946007)(8936002)(52536014)(110136005)(26005)(9686003)(64756008)(55016003)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DeOPf1lNg8eyhvMSCqy/0b1WlQhTT3obBUQlJnKePkOn6KKuFDfX5qONBe47?=
 =?us-ascii?Q?5BgEGS21J6JZsVK9jggqhHu3cPJENZH2skXytACSafGEnMs41ATMyI9rFOmz?=
 =?us-ascii?Q?GMFSO8dFUHZtB/NTanANn+tCvmqe9eY9BaPaGR2s/DeDRIa1A0FfetbRQof0?=
 =?us-ascii?Q?BOR0Ijal4vLwa7tfcOzDQpelb0MdPKAlxy/gxU48e56jaIXK9GCEvFNelVYS?=
 =?us-ascii?Q?jZ8rvhL/KmmVBQdvJwSyMMq0nessFUaYGdEqPOqPbuoGCSr4NLILnlLw0SdJ?=
 =?us-ascii?Q?KpHoAEPVR9opJhZ5HvtJN3Tc34Z9+EkkPDZkXha6ssU7ZTHHLSNKx4TSDTdA?=
 =?us-ascii?Q?+8HIqTZWPGwHwwfnQyPqIIoQvjK+Obwf25yW01Nr47cggKAPDREA/vtJ7JAA?=
 =?us-ascii?Q?1nJsspiWxVTmsOETgqRLsLl+IvanaYSc/TnROxAfmKs/60sq+TByiBWqu6Q5?=
 =?us-ascii?Q?J6x/gRIketKXhc5L9I3LTsDXcO03sV4VfOhNr9hErK4DJrV4d08gwAqq3v5e?=
 =?us-ascii?Q?DL4nCJvfQL0vqVy5Li8IiJb1KU43zwNSa5qMABK7AnveIjwopx6qmI7Gm2KV?=
 =?us-ascii?Q?3MVuhxh7gwqSo5e78YPcJClUhNk5z3x5GLiuVHUOacS4nSJiLH6wiOm60Hz3?=
 =?us-ascii?Q?1QwetXpccQng0T4uO9CFm9dGQUVaIsukZg7K2plE6h6tSBtJKHn2llyjBZRX?=
 =?us-ascii?Q?knyJsMZgmAeUR0t35SeCLN4vANM1xG0uWkjJhHa50ozTg8d89UMwHj1xVpWI?=
 =?us-ascii?Q?p41wmrwVTimi7vwQJ5mCoMQ6tcDwfjwhb+mcDCH8efr6tyFDZ09NzmUMwvQg?=
 =?us-ascii?Q?Rm/eGzw+t6uqKt0FsgItclzpWwpuj17lBWu1zQfVThN5H7tWfG6KRYlCvoaG?=
 =?us-ascii?Q?ZIz0+/WYTD40/JmhfrM+wkCQjxe4ZIWqoMYvl4p+DwtKiXCP+QGyP1Pt4kBz?=
 =?us-ascii?Q?V5OTneH9Ax1rI5uySsE9T9YtTmf5d1xcSX03sAcXFE85hnJ2q6Y3T+ERj3ts?=
 =?us-ascii?Q?IE5OSgRk4XNpmIxCcWlgjiY2QcUnIKBWai8qBcJQ//ZT1U3yy/HifdQbH9+i?=
 =?us-ascii?Q?IablFRRVPYGSODyYMM/a1HdGAVwxBtn82nIeARfX1P2V78ag3Ey277h5xX5P?=
 =?us-ascii?Q?hhm26K4QpxlFSE416t303pKcExelvlCVYIiT+xu9/1U9DYDAI1AKCkjEvbNh?=
 =?us-ascii?Q?JnRuQH4hTph3JVvkOsGGGj2S+0zpz9VTJfvdLaXJlSsgtj75dmhiq/03DawL?=
 =?us-ascii?Q?t/2qdV364zZ3KKiYBwgqGKPAN0kMPl4boJdLeQUCtyH391radCWOPXIkdWD6?=
 =?us-ascii?Q?1mkyIo1ljIzoZoHBBPilRKjEteYbH386pbW9QWuYPNi5l+fYTVMm0xvQLwrX?=
 =?us-ascii?Q?hBeTKmkEfN7jrwcXGjB1LtG1O5T33h5+TiNXXpFdiXHSWwLn+5VLHQIVoelw?=
 =?us-ascii?Q?cwDiYttPr3yGt07b7SOXoYAjjOSOsv3vkOgq8VEAN1sbZ9iRdytuPE+93j+A?=
 =?us-ascii?Q?xIgRqiPm09iaGPXygmhtKc0iSl1ezdNlppyNeQHw2mcQyrfh7NbyX3cLT/g/?=
 =?us-ascii?Q?CCQ4ufdQKRI4BKD7G2Z78OT9z4j+HqPg/4CFXfbHnXV3A8znTdtaFVQGwLP0?=
 =?us-ascii?Q?/A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1d21c8-484f-472d-3606-08da9bc0f374
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 11:03:44.6695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWRrWWG2ZJqt1omIAsCTKSVMqAxVdR7fBWtQR1EA5oaQq90m6nWNoktTpDmCnMySJWDY33nted2abeh7CaSdM6haNF5xe4j5qXIYTuNg25I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5261
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any remaining issue with this patch series which prevents
a commit to the kernel tree?

Best regards,
Daniel Starke
