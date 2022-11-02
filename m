Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4638E615E65
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiKBIxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKBIxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:53:15 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2E827DDD;
        Wed,  2 Nov 2022 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667379195; x=1698915195;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w3jWxbw5dHXjPDc5u/16fCCSExHxlfG/lNca5qp+Z5o=;
  b=dTIMkHYorTSS7qNS3uu2dvmUsGwcNrWg0E/D7rDDxkva5TJwJmTw6cfA
   pSE5FOPi08DPd3bfeSHPbh5aD6gX2lVbbiisAS421vgtg2R/3RS+BNSYt
   SXUYEV+onINWBIPWMxwVJ9MAI9BWWdtE1j+yBDzwvMu7YYUaxshftuai8
   zypo48z/08mS/COfVSp6FEdgveBOLH76ILmRPIyvzAKzPY6TnGehvN5yR
   nGTl/XDUnWmpj19rxuE5Z/qrja4yHwEUkNi3ydc9Scsvtb5V+atDPxEX1
   rarrHld9aPreC60dRJ/gVhiVm/y+FkaqHMCVKU49FAxLfw5fvHFN6y9v7
   A==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="215299082"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 16:53:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nu+63qezvMKwloNoQmd5975jg80VoFpfYTlXPn6kZ5E7vHkyRoq0BWworJJOnuexHpZ3aXaLNaXcbn2JCiI4qMSQYY5mlt3Tb5ksy7t8q8Wx5EUF+4u7xCPz5/YIoKYvtlhQ4MhwNc6ADyYDjrQnN0y3Lw+qqz+kKJILtZVHaWfde2ZOgAQsEKdnOClMc1mw3vEUQvrV+LHzIUlkx/AKZCsUE6tqGOnEpW7nwfKi1UFGjo4ygteUFezScYgSIbwuTQvxZV6U7eAfeAWK4/2Mep2/vMqNosO/zLvdq3O4/DzeOuxJ+4ZmK76xLXnOBKIs07YOO3TGnsy9FNHy9AGBJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2Xf3G+eE/WXH3tYTRkl5+eMJNLsNR32IKpCbXWzRXg=;
 b=oLbHDldyGo3NwQLSs6GTWXeT4ck8IL7U3bXj6af9RDbbdCIeGHCVZWmnLuZiAXtUiXblknmvK7anjLhuN3p4HHtKXWEcfsKrVs5Xs9RHhUFRv+vgSW1eojPJ+4VKhRLsRCsi2ppEbvhcTnOWnu2RzGlUFPFYb/HstUmtxm8U7O1ubRFHleWhf3QkxAOHCArD0KnBuGldKGde2D+2DP1Kwm+dUe/AJ4ozmI9JVTuHvNJtRo3WrndxwSydVvPnC+1Oq5TIVeBMDD4JCB6i5iP9ct9d70Kt0DrbaQLzhyERrjHUmo3lPY4Zsp/4RlVOZltz6RgS7jkqJMkAHy3dXj+aTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2Xf3G+eE/WXH3tYTRkl5+eMJNLsNR32IKpCbXWzRXg=;
 b=Di4LH0mIHopioS9sq3PC9OZtO2BC/5Xxmznz3hoKRY2BmrBp0ZuTvrbf4YCtrOCdcRTOSTskj/3OHJsBxh/awfDxevGwuzxeG1vUrZ/MM+rMg1KWI8ApnJcDNxSxKm9RcnYZO/B3hm7/4HR/B2miBkAh9ClcZxmrBSaWcymfsXg=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM5PR04MB0699.namprd04.prod.outlook.com (2603:10b6:3:f6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.19; Wed, 2 Nov 2022 08:53:13 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%3]) with mapi id 15.20.5791.022; Wed, 2 Nov 2022
 08:53:13 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Jiaming Li <lijiaming3@xiaomi.corp-partner.google.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lijiaming3 <lijiaming3@xiaomi.com>
Subject: RE: [RESEND PATCH 4/4] scsi:ufs:add fbo functionality
Thread-Topic: [RESEND PATCH 4/4] scsi:ufs:add fbo functionality
Thread-Index: AQHY7nxlUv3NNl/jJEm/wfyLDEt8gq4rTM7Q
Date:   Wed, 2 Nov 2022 08:53:13 +0000
Message-ID: <DM6PR04MB6575B27ABCF32A2BD502BE06FC399@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
 <20221102053058.21021-5-lijiaming3@xiaomi.corp-partner.google.com>
In-Reply-To: <20221102053058.21021-5-lijiaming3@xiaomi.corp-partner.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM5PR04MB0699:EE_
x-ms-office365-filtering-correlation-id: cc73ab71-9403-4e61-ae81-08dabcafacf0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uSpy9X9AOAunaxLusjdFKO0Xdv2ycG/t3UISlOGnG7uRcTtaaSsRyEIjEAzWbR11tyyxI1LKYtdcashoLd7cHaFYfaNaTiW5Tw3wiLuhPl8sww1PePfPGVKWTdwUfJvy9mEhgihp71+7I1In2iu/qrEZ9jcW7JA9/UXzbwILvuuqHo8ST5MsUrT+jcb5EcJCpNM641ooTMQHKzZ8yim3watek5meFOaRNx3Ul1m8yy24t+SH0toAFLc3KdQLk1B2AxyBZtejv0/MIYKubgeXtFOKm8oDJ7yYpDksD7gkog5BVEORfn7Ws4iwCbV3s2W07eMhU2zSHayilSRmX4ZvaUBVqqwzWv1b/iFm4jCWkFENTDUSBk3fMCQZ2hp/74W45x5lkDd/fwhaKWlBBMWR0pzXIVYBx5pPecc3nPdbXl+8NSZIOsS4w68jPYixmTJwpGTWrXYgGhAEotEQL07uzKGOdM4+VZ0c0L2I+X4Qg9uEmetqt3T4jLNyKDZN5xccc5AvPh1E1w5gEKAY3aKdEfcHd7OTbdH4XQDwNgl5OEOXd7yNC45DTQHD4/sAtyGVjM7MFWaq47rCVaO0Xjc4QsD6u8U0E7KJZNwO0OCBWESMB+JrpuMtLNN2+d1c0b+KFhiaBowtIF5xQQMI1NW4zKtjIQHOo6W70z/Jc67VU++KCc3yRB9cXBg0g+CFzA9kBtVYcEzE9aG2jzB8vC8v9/F5Lk5FGcSYG53eVD8L6sAEs8+OFpGP4XsHilbqIFjhRzB5VS/nOhbOhrk+n6W8MoU+vvVXbFeogIDRQQ9lcWiglmaf6VJr35jrQ4mQ0fQH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199015)(66946007)(38100700002)(66556008)(66476007)(122000001)(66446008)(4326008)(64756008)(76116006)(316002)(8676002)(54906003)(8936002)(110136005)(38070700005)(41300700001)(82960400001)(55016003)(7696005)(86362001)(186003)(5660300002)(83380400001)(52536014)(478600001)(6506007)(33656002)(26005)(2906002)(71200400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4MwPghh2tmzyagv51a2PjPnKbkQ90QylyAQKkxrv/9Nvwda7tH8K3hgwhUS8?=
 =?us-ascii?Q?RrdeMnNbPQHKvqfP8uNnMm+HzjCB4I+1bQIj1+AVIYOL5AVMdHIr/WP19imL?=
 =?us-ascii?Q?0sbqIWh0LComSzCcy6jF2/OsRO7JZFS7eJodHcReaLEi9cDOAMbccFab/8mv?=
 =?us-ascii?Q?+EnE1Wxul5Qq3T8yuwCXVh7KvjhPueHS5kefqGiNe51FcvCESS11qTyp7Sfk?=
 =?us-ascii?Q?PfO/gOgUo/02P9kPYTTjEXL831L9l10FuQucvd1EYtjjSwkW7zFrXm8Pcq4g?=
 =?us-ascii?Q?ihA/Ng41WL1jzQI3+LrGpKdyvtYJnkarG+Ej3+ICLHcwGaEyHmWk2HYOWDbm?=
 =?us-ascii?Q?y0cazxfNP8QY9JkiYZYhTioJcUOw75kG+iKu3W5ZvMukzY/ffpnYo27WaJ5f?=
 =?us-ascii?Q?EPCqeNQoVnsY+p+q3jRW5aBWZ32HRag5lyw7cj9rmw1C+mMHa/W08oOadO3P?=
 =?us-ascii?Q?1SbELlMLRtZIVp9j8+twSthC4Jq8H77VIu6+tbQxhGlNwazTBpyo2rEV04nS?=
 =?us-ascii?Q?nGlpLB6umdD6jZkwzkFYj/lXdX5LRH6Og2ZbqvNi+8nK41kvFIN8YVGgzV2m?=
 =?us-ascii?Q?y6WWTX6p19jELyrzFIolg81GDtTneJyNc2ukcWFTYAYD9X2aTi0bwv56O4jA?=
 =?us-ascii?Q?ksVk9FOI+Hc09Rx93FVCq3nJegXzcRNheCroeVWifuM0Pxvk+GRl/4ojY6L8?=
 =?us-ascii?Q?XeKuf7Ns8j+Cwwi0343bXIUkWjM4EKyKYdTl9XVWRxsQMlPuhreMK00Zuptr?=
 =?us-ascii?Q?OuCr982/FMpJLZ3DhTYw7Mfczc9z3LIeOiQHnzo0llgVg6E+fL8SUNXPXX/U?=
 =?us-ascii?Q?It0A4XdVYB8Yi4k+rnqb7pN3GvNuprV2Mi+EY2pfif7zBb52azLlprhw72F1?=
 =?us-ascii?Q?RIHrcUyY7CPZ2AD39RzKlh3My1hh8m2Wfd78PvmrOnusvj/FlxEmpdfhoxyn?=
 =?us-ascii?Q?B++lapotQG0aABjUKQBi7ftUyMX2aLzXPtzVxfmPm66If6zoufkcFTSMUm+g?=
 =?us-ascii?Q?IQzKb5UxduPPSKdVqklX7GdZevrji6NurV4iqN1dxTeY0ZzKkR/Pdqdht315?=
 =?us-ascii?Q?+W9TvjpRMfcMf9/+/DpAnEHc+mLUngkkM/QYf8l6XbIeVNCDc2Whd3WUjc0d?=
 =?us-ascii?Q?KkHTzcQtPo1rDVezHtxXFF+fIWkV+ZmbxXY5vel4G/GM8CB5hOa/gcJnmoth?=
 =?us-ascii?Q?rj6kIsLEx+2zxXlsnqp/VDDJZEvaCtQR2Sscpr6mGXSw8MoDu1x4lxnRkf4m?=
 =?us-ascii?Q?d+60IGqDafOrJ63hHElViYKPkMGp4UOVM+dfdq4oCBjsG+twTUIEiV4qyuBE?=
 =?us-ascii?Q?FTnRWir73RQmnbaOm9ac3hGP7/95KIB8w7enTHCELiElbs/crsJZfOSsGez2?=
 =?us-ascii?Q?548xQ7AVi6Ql+v4MQ71gYhLgInb0wnTolhXuX5zJxrfTQf/5RvfEnni/FapQ?=
 =?us-ascii?Q?NKmH4B8eT8GraUna7OOx+F51iNChdZxgrX7DAFu4hfKd0U/iUUFNHAn6nppC?=
 =?us-ascii?Q?VevqDUUM0vYzhDh8rB8UBoBEMZFibH1v65G56i1as0J3zCsv+EH5Gy2yDp/C?=
 =?us-ascii?Q?FPsnKoMV06SwTC2CUjKOhrKpJvLEeZ25MZUEx6ZE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc73ab71-9403-4e61-ae81-08dabcafacf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 08:53:13.2474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtLlOXrRvYvpqb5nwbBtja9KZ9Emn02U1Bajmz3bfWK7JDNxQ/zhycxygoCWSLeEDdJt1M2NtQDuaUjXpsjVOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0699
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here also - missing spaces in the title.

...............

> +static int ufsfbo_get_fbo_prog_state(struct ufs_hba *hba, int
> +*prog_state) {
> +       int ret =3D 0, attr =3D -1;
> +
> +       down(&hba->host_sem);
> +       if (!ufshcd_is_user_access_allowed(hba)) {
> +               ret =3D -EBUSY;
> +               goto out;
> +       }
> +       ufshcd_rpm_get_sync(hba);
> +       ret =3D ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> +                       QUERY_ATTR_IDN_FBO_PROG_STATE, 0, 0, &attr);
> +       ufshcd_rpm_put_sync(hba);
> +       if (ret) {
> +               pr_err("Query attr fbo prog state failed.");
> +               goto out;
> +       }
> +
> +       switch (attr) {
> +       case 0x0:
> +       case 0x1:
> +       case 0x2:
> +       case 0x3:
> +       case 0xff:
Maybe use enum UFSFBO_PROG_STATE values?

..................

> +static ssize_t fbo_operation_ctrl_store(struct device *dev,
> +                                   struct device_attribute *attr,
> +                                   const char *buf, size_t count) {
> +       int ret =3D 0;
> +       u32 val;
> +       struct scsi_device *sdev =3D to_scsi_device(dev);
> +       struct ufs_hba *hba =3D shost_priv(sdev->host);
> +
> +       if (kstrtouint(buf, 0, &val))
> +               return -EINVAL;
Maybe also test for valid bFBOControl value?
And add the appropriate enum as well.


Thanks,
Avri
