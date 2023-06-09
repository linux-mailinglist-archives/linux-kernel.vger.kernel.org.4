Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB61729147
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbjFIHgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbjFIHgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:36:00 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF151FDA;
        Fri,  9 Jun 2023 00:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686296158; x=1717832158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9HGo/pwFWlya1YKhXqoBSNckgXXbEBH9nM34xFZTg1Y=;
  b=nEMpvMLb9A70lLxIitpCwsbUQhVWfjO+a9+SNpWkIjrPcbmHuIFi8C9x
   86DtGW+aJip/Vdk31RVNKhvDIVBL8j5Y0AWs2X9snZPh9jrR50Q2Iqklo
   xUQjrCluculWleIuuuFMbFuWje0ad6jfs9TKZc31Ek1O+iDuX6Oxl57Ys
   T9qqdlk1YGTQBu9HBn9jPc1mMP1+HO74P8pqtwDb/+jhzoBiwuNzm7P0r
   oBqVPOtUQ3dgkHMxqEg9KR3g9iq7oRxyOyEFi6w/2FUINEzdPIBv5EOqy
   L4SPAQ70io81rVmgxUVggx6cwdTYst7OFnCbKnuwGOIj2LpCEgBJbsYQH
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681142400"; 
   d="scan'208";a="232582781"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2023 15:35:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEa/NvYiJwwbrTh3Ba4JXEVr9AgbwpNHAgMSFUvYOc89TrvwnqXbz3h20aOGeEnT/aPLLtF4yGfs7CSK/JXt0djQm6irTiKLvJdFDSbK7YxsKv8KK4Qtrd6O5gEKaPT8SwMNCUx4BewjRxtIqN7uoug2diVONR4LzkeO3pfMrRWRuyH5c+7cKHYqM2svNEjop6hJZE7G2yMGkvQwi2aLhKWM0mXsWVgLSCwIghyhDpMLVJpPOJFRbwD3cp7y8O9ISeKyQYHVPpc5aOVn0eRudIxJ9b+IfOT/d0vPR/H+D4y5+kdjejhTuv+WRvHfkUul+vqytpbwZuIj/VWI/QtN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZfsFtCz+DLPArmnPl0a5XwnoKdHNq5juUlu2TAlHqA=;
 b=Y9S6qQlt/pHQw/oEodJFeYaGzi000CJmexOovA1+DjS3YayWGVsPIrn2psTGfD0hmAopyZpsFVtYaz250HSn/eYofZTTy2d9A9fPKUF3FwdWVomM83c99E+gQ8IIybdEX6J8VtOTiW6FMS/OiF166lOxg16Cyn7iw1ZlILHdUcyr2+USt29RzbOlLQ6fZ12KP4jQdsapftYH2wLr8TqWYHXWbL5cLAp1RfqZiuL2CY4FpsoerM/xVVuLOGZIpuExV1JjvCkWo+pbtCt1FmTJtToKYVfkIob1QDlrjSt0nKU8alKvtjoBsTCxH5boKjBhrIe8bb/P3Hekrx8ZxKLpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZfsFtCz+DLPArmnPl0a5XwnoKdHNq5juUlu2TAlHqA=;
 b=dyFch0c9LXsA0q5V0owpCId7f1yWzLv8sQyJ4dlaZ8ifjEIF6FgGrLAX1BAVOtsJJeo0HNyelHraTbXln5WSPtqEm8oIwUn6uvpMEtjuzgrumu72O+wp/Svtx9q3W9sZX8rfy7HP5EdsmEQJPtmiP2cM+OmPGMRFwMYZnfyLLEE=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA3PR04MB8978.namprd04.prod.outlook.com (2603:10b6:806:382::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Fri, 9 Jun
 2023 07:35:54 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1a88:334:dff7:848a]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1a88:334:dff7:848a%4]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 07:35:54 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Lu Hongfei <luhongfei@vivo.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Daniil Lunev <dlunev@chromium.org>,
        Peter Wang <peter.wang@mediatek.com>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER" 
        <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: RE: [PATCH v3] scsi: ufs: wb: Add explicit flush_threshold sysfs
 attribute
Thread-Topic: [PATCH v3] scsi: ufs: wb: Add explicit flush_threshold sysfs
 attribute
Thread-Index: AQHZmn8WXHATsQGzxEGzwCQ9x4MRgK+CE/6w
Date:   Fri, 9 Jun 2023 07:35:54 +0000
Message-ID: <DM6PR04MB65753B9E63B07D53A82EB8DDFC51A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230609030357.64360-1-luhongfei@vivo.com>
In-Reply-To: <20230609030357.64360-1-luhongfei@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA3PR04MB8978:EE_
x-ms-office365-filtering-correlation-id: 660346b1-c139-4f97-8b2c-08db68bc2891
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jp/tu6HzDWvhHb62DqrZgWIfQ2cujEA7n2gsf547ZnuoeZNG9ARb8/BpgnNAuzpgwg+iDCINYxDG1WO+RgUKhO6FIuiFN79tRL4vtWLigCUeeg/TbcJuwgghaQsTXkO09/YD670BRzZuh5ByPgEjqgeRU3GwLo0xyqSlqClvZcyjwpWmoDahKCm9ubZyHoLOHQhgiiRNsyIrmZdicLpFhI75mJ2j9qC6raBMkJSuz051PsSnMZD1kASqmep+uC5gWE2Zo3Rzhou5S8X5LMfBWqZhm5CG7DWUvL2+DWCZOMHfvf7ZxABv8jv7bly9pQ95zxdMxNpT/0hSskOGFCcwErE/IPy7v6ivW7NMCQOtvh0XktKRo6QgMGXRKUUMsZkmcR0wpK5R2klh8eNhwYiEOEIlLMciDBWYHlepIz/vQiPkkgudvY1e0dylK/kvtrkAOdYJJdI76uUhZCjKmZJonrWhTGv+vLvCoKErgnpMYw1/q2KUaLhRT0BpuQxJzNTocclAF8jLCnDwT2dWveZz7bCIMr5p7LPCDJohqI/3rbZkAAV9sjyuTBIKS64RCj6vfQSSKAdbBjpd2nQsh4GlWQq3XA8Z3WXX0GVGn4pB4s3bGZxr97ZB6ioue6N0nQkyL873w7d0q5lyYASszzY0vQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(110136005)(71200400001)(478600001)(52536014)(8676002)(7416002)(86362001)(38070700005)(8936002)(2906002)(33656002)(55016003)(122000001)(66946007)(64756008)(921005)(66476007)(66556008)(66446008)(82960400001)(316002)(76116006)(4326008)(5660300002)(38100700002)(41300700001)(9686003)(6506007)(26005)(7696005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mXh/oMDEx6/6TPusWt4CDGFmRNriK3IJA7TPqo7VN4LG51YQJd7GYiEXYPNt?=
 =?us-ascii?Q?PnHaI0bFDQu5/ngB1Ao6CG9+AbNoOF34FLEvHXBrwRMi5F17FyVHHQYXuUQb?=
 =?us-ascii?Q?Sh7h1j6ufBTWbjHuroyqxYcW5KLJ/VRE0d/nrzILEXCxsmPz36GPzreSAKvq?=
 =?us-ascii?Q?dAZL2lsX0cjvQkcnkveW41Xc9gK8KwzNRoLcsC2gt+cDcrQz9UB73SVuVayh?=
 =?us-ascii?Q?F6b86h60SxUvNCNtqtORWo0t4yygpqGk7uSD8oVC8R6O0bUwCuoh+iOmrYsJ?=
 =?us-ascii?Q?ki6MAG2G/a26hVmUdWNSemP2s0dSusqKXnbvpOBI7UTyKvC39XXuZrewhAax?=
 =?us-ascii?Q?iyRRzzChBcxNoHn2F7FgNi8XEG59Swr6MKdOJXOiGaDqtFdwpiy1sorgMeor?=
 =?us-ascii?Q?WgkzgIczSHjxWL/OOrSR/1MeEHKddMA6wLPQ8nwd+LI4873CzVgqNKNRACnR?=
 =?us-ascii?Q?diFa3u/pv2POebAFfWLKOsEw1FkhUW1Xr1DcHR04/HID0h5yXJNSevE12v2N?=
 =?us-ascii?Q?qgq3XeJi91pYBAEWiaFo66cg9+mZMSXwZCWLZDO6SHQPZz5qH25a5b7ZwuSo?=
 =?us-ascii?Q?ecy4IncMUO4bJcrbQRDabvHpaRA9m8xsmK0XgRgYXxEGAYNye7y30vuKfcIS?=
 =?us-ascii?Q?Jm8DraVzeY7boaeILTjSBtr+kwMOgGXve/iXp20cuTn68v6u4zkueROB9wMj?=
 =?us-ascii?Q?nT/H1asGlRnkmkYcgaGnEvgYMzBl3gmQsE7N2SmQNc8BpBfVnWwwjT/Hc1ki?=
 =?us-ascii?Q?Sq265oRts5PM2050JdwVzt3emJyngh/7X9YcWZ+ylHH1PNWNrLSLf8C95O9e?=
 =?us-ascii?Q?NCgJhWP95u9NXFBrSaxPIyzRAnJ8dJbZQmLcRPi+nTZN/4UQ+/7//Fso5lId?=
 =?us-ascii?Q?0mwMvEKHMZEizXWFoInkX0xukB4IQchR6BYikFvBMQCrZGEkDqhrDWPFNMIg?=
 =?us-ascii?Q?+JH9aagVgEjhrzqEShOSDNT5UpjL3n2wCcdfrOaX1WGXVkB9tx2sVUT13JI2?=
 =?us-ascii?Q?VasKISZpuUV6PnLD2u4SrE2rJYZ/+bxh2TL3JvR6PxGzYDNmPjkNgi4siERv?=
 =?us-ascii?Q?zdDVR3W3XMO7XJZ6ftD0rGXuO70ZIFDNOwGpecTQJhqE3uertYfZO5ZxRbxm?=
 =?us-ascii?Q?p2smm09nLRmmBzd15225Io4MpYjJEa+Mpn8kLtlXA0lKOiq2XrZIkG+I3rtf?=
 =?us-ascii?Q?GJvR3JYOVLHBm0px/palBBELq0NbsUR8r81kWuhPkLDlJZdYfzjfdP4uRjjx?=
 =?us-ascii?Q?+qnE9fnVdY8X7sYF9MbbrQ+p+5iDgtao567sXnE3BCMoE1BPsHk6PigvpZ0V?=
 =?us-ascii?Q?Zjx9cBBK1zStloT47aEPfUY516VC8BnmgtKZjxelqevB6PkaNJ64o8RUj3Zd?=
 =?us-ascii?Q?KVtrqHua2c6uUY2NTUS4pZaQLClRIbClldot5L9Kri5p336gvWX+VvSilj08?=
 =?us-ascii?Q?VbAk7IGZ/mJy7a/8u5O8dMxVFOyvG2IrU+tdq9yjs3WZttil6zXA6mMqXjbE?=
 =?us-ascii?Q?BeLUTRaOG+phI6E9gGAQgD1+iizJ73RJ5DGGwbJqyXXH8XB3HhgCBPoNs8Jq?=
 =?us-ascii?Q?0+NMzFqksXgbF2SELo9A96H9b/0CgmpohlFL4jYi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9bCpT7URD5RdZHOKzMdhB4PgQwoCN1HNCJ5Q+cjZPhy2MjsvN3MWexyqWGpy?=
 =?us-ascii?Q?OwB2ZOtu82ojOn8FTxdGh0yeN0g0LA+N96E+Sxs98z6Pz6YvuNUGnI9mLwDG?=
 =?us-ascii?Q?NU75z4n/pbwEIlHC/QQoUTq8louS0/ssJmcOXYEuL+Myi2e+3VFKwBl6gurj?=
 =?us-ascii?Q?fHa+fTe8KhYdaTplTdCzby5Hgra3zjx8uiJ7E9Ew0TjfZZKJ5edDB1f/asGC?=
 =?us-ascii?Q?JVFPWgmBBx53vc2JdUnBi31FINqb/5m5pt4Bj98Eo05c0/vkGNtLhzumAdr3?=
 =?us-ascii?Q?dh/npoz3PypzMRh/A56fmiG9wK9+owj4yAse/Bjah1G8ufrvEcGzaYf04FCI?=
 =?us-ascii?Q?IXUpfzI0HWakiNNX76PuCfg60bJHV/z9R6xseRHL5gWga0YWzzmyVgYDfYy9?=
 =?us-ascii?Q?cX1j1CEpLLKIyywGe26d6j0/W22Ur/h/I89AOIr+owOad3llR4XfSSPoylSV?=
 =?us-ascii?Q?NbZ77RXIZYBYqbh95FAQAp2oK5ZVEEwAoN7L90M4cZMknAbdxKrUlfusShk8?=
 =?us-ascii?Q?tpavxPcau4Z4KBAb784I11c6gfGcIW9PMw9u4qAyFJtDoGgfl6CtQHwyIXG6?=
 =?us-ascii?Q?dRClhffRNe05Ihrv+rALGhR2n596PvpaHAGSusLt72IPxMZB/sg2d5CeMy7T?=
 =?us-ascii?Q?CFnC9D807J2a7iqmjtX2IBOlnB50ZpNekzMnvpLdtijOkynjMb4Z0bwPMg3b?=
 =?us-ascii?Q?ye6Rs0yz/R4DaF911xU+/r6spLqwdO1mfaIAdqemOt1kEXRr8u3Z2uaAkIu/?=
 =?us-ascii?Q?myE3a42IJwNfYqRsEH3rurgIN+M8S9RaEfNid7pog4WsocngfYZJtUtdqTtN?=
 =?us-ascii?Q?IO+sKP93I/VihGBggJCEyU9VT5mMo9iZVS9oESYOUB+qFeHmiSCf5hn7pcPk?=
 =?us-ascii?Q?6KuEV5wj32DOYUkUbSbTmNQgc7odcJXRm+6jO9FF9vqW30ymID8yIpx52d9Y?=
 =?us-ascii?Q?EZzH6jtSlztHytrdCusEOYDt0cNycNeq82IpZAauHavEZ84J6EO9FkZxjbbg?=
 =?us-ascii?Q?6ZbtVcuG5x1/dmMwLaoLmLs61A=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660346b1-c139-4f97-8b2c-08db68bc2891
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 07:35:54.6231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHOUG9JPEjnbnVvamaEjfjttrTkW+ZmeJwAkNVXy8HxFOyS3Vwv53FsMDdwn0C+6qY/vPlCFtyAsbrjf+gNC4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8978
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> There are three flags that control Write Booster Feature:
>=20
>     1. WB ON/OFF
>     2. WB Hibern Flush ON/OFF (implicitly)
>     3. WB Flush ON/OFF (explicit)
>=20
> In the case of "Hibern Flush", one of the conditions for flush WB buffer =
is that
> avail_wb_buff < wb_flush_threshold.
>=20
> As we know, different users have different requirements for power
> consumption and performance. Therefore, we need the ability to manually
> set wb_flush_threshold, so that users can easily and flexibly adjust the
> wb_flush_threshold value, thereby achieving a balance between power
> consumption and performance.
>=20
> So the sysfs attribute that controls this is necessary.
>=20
> The meaning of wb_flush_threshold is the percentage of WB's total size, s=
uch
> as 1 representing 10%, 2 representing 20%, and so on.
>=20
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
> The modifications made compared to the previous version are as follows:
> 1. Using 'wb_flush_threshold =3D=3D 0' insted of 'wb_flush_threshold <=3D=
 0'.
>=20
>  drivers/ufs/core/ufs-sysfs.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

You are missing sysfs documentation.
>=20
> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c =
index
> cdf3d5f2b77b..347207f4e8ee
> --- a/drivers/ufs/core/ufs-sysfs.c
> +++ b/drivers/ufs/core/ufs-sysfs.c
> @@ -298,6 +298,37 @@ static ssize_t enable_wb_buf_flush_store(struct
> device *dev,
>         return res < 0 ? res : count;
>  }
>=20
> +static ssize_t wb_flush_threshold_show(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        char *buf) {
> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> +
> +       return sysfs_emit(buf, "%u\n", hba->vps->wb_flush_threshold); }
> +
> +static ssize_t wb_flush_threshold_store(struct device *dev,
> +                                         struct device_attribute *attr,
> +                                         const char *buf, size_t count)
> +{
> +       struct ufs_hba *hba =3D dev_get_drvdata(dev);
> +       unsigned int wb_flush_threshold;
> +
> +       if (kstrtouint(buf, 0, &wb_flush_threshold))
> +               return -EINVAL;
Maybe also make note if wb not supported:
if (!ufshcd_is_wb_allowed(hba)  {
               dev_info(dev, "It is not allowed to configure WB buf flushin=
g!\n");
               return -EOPNOTSUPP;
       }

Thanks,
Avri
> +
> +       /* The range of values for wb_flush_threshold is (0,10] */
> +       if (wb_flush_threshold > UFS_WB_BUF_REMAIN_PERCENT(100) ||
> +               wb_flush_threshold =3D=3D 0) {
> +               dev_err(dev, "The value of wb_flush_threshold is invalid!=
\n");
> +               return -EINVAL;
> +       }
> +
> +       hba->vps->wb_flush_threshold =3D wb_flush_threshold;
> +
> +       return count;
> +}
> +
>  static DEVICE_ATTR_RW(rpm_lvl);
>  static DEVICE_ATTR_RO(rpm_target_dev_state);
>  static DEVICE_ATTR_RO(rpm_target_link_state);
> @@ -307,6 +338,7 @@ static DEVICE_ATTR_RO(spm_target_link_state);
>  static DEVICE_ATTR_RW(auto_hibern8);
>  static DEVICE_ATTR_RW(wb_on);
>  static DEVICE_ATTR_RW(enable_wb_buf_flush);
> +static DEVICE_ATTR_RW(wb_flush_threshold);
>=20
>  static struct attribute *ufs_sysfs_ufshcd_attrs[] =3D {
>         &dev_attr_rpm_lvl.attr,
> @@ -318,6 +350,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] =3D=
 {
>         &dev_attr_auto_hibern8.attr,
>         &dev_attr_wb_on.attr,
>         &dev_attr_enable_wb_buf_flush.attr,
> +       &dev_attr_wb_flush_threshold.attr,
>         NULL
>  };
>=20
> --
> 2.39.0

