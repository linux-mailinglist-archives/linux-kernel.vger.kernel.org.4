Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53316612AB0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 14:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJ3NGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 09:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3NGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 09:06:08 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408BA23B;
        Sun, 30 Oct 2022 06:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667135167; x=1698671167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L9NHsHgJD2IWOR3aSvd82WtmF3AoHMvFVY47+w5iyQs=;
  b=bZVAsxDUfq9ltErjv1BqqfLjac3gtGgff/NTSvWyEkMIbVRj4maE8bqU
   Hh395HYakPID5TMEbGKrU5pyvpL+cRq9h4ygSZO7lgEp3BM3flKUNhBDo
   1vBzPRxAI8wL/Mjwul462zZ3x5hunFr3aiduTC+6n07I4mSrZxNDxJ+45
   9VYamBUCZ32oYmimSWe5LxVlEW+lALzQwvH5kPrI3vyoQNtWCnPMNqRRf
   8rGlz0BMa+yfocasHp+4dSEn9oaMCjEPv7PmwEmbEB1pGhyNs/8Qbuoer
   kqkE1WFs80UzPGuy5WOusb6qe23pL70BlnekVZ6ZYR3OHEaDiFvuV7Q63
   w==;
X-IronPort-AV: E=Sophos;i="5.95,226,1661788800"; 
   d="scan'208";a="215068310"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2022 21:06:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9ZoWzjWrBxwWfbwGnNV5C6ZLx90lL/Vwl/z55aQLwhG49trN0W/t0gIakGX7SnDE7Hy6eYdJZE5WRLABCxw+A0Bb6NFMOWrLt2fzPlhtLkzgS3DuDdKLDsHm+7BMvwNWrsFcL3BhbR3KDk9DuDXstPWWSVPVxllyjaTY5OM73tX558jlmAfQBIUkt1KggxFHtEC5m78NjpaUq7TRakhIhzgTiszqna4Z4QYVC2IGUYVJd61wnY5uyaeJU6GM8iw6yTwCIuRVfc6SkSK/tSu7BtPcGabieCuzmcx39zWuP8fJfo6afh89sAb8TPBuXYn/M3WjrvNto3c50wkjlD+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Qf9GSgOrGFOPL/thzQyKURV2AvUItQnD5K+t/b3I9M=;
 b=JInOquq1V4KayHniyazMY5Vi1nyliOw7Bw7xF+tUloe+S2nhNoVsXFKQ1jkLjPuGZOeMKIY5lTxyoxnsqnDkhfCqEUiBKkDD5dRDKNMMgqeCZZJyaP3shFThWOPGS6tp0KaWD/RqGBSWpeCWMgqH0pm1FgjNPYsXo+JnpTgO+CS1PwRXJmIZC+hx+tQe9vKePHg67Sy2xhwjJoVYHewo2ftwhT8UXp8aa8p7aRSGFTCPaGtY4l7EiTwDGueRWktWtI+XMJ9oKVIHNWa5XjLjGjvaFm281SK8/zlj067hQJy+TPCAy+O+Kjp8bw0NUnENXcAAZtCQandZy1kYGpahOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Qf9GSgOrGFOPL/thzQyKURV2AvUItQnD5K+t/b3I9M=;
 b=I/wc0O1bCMlO4xJjSye5GB48Avg85ACjwaxZAR9UCdbj7YsTnwH/duZ7X/9JkcGE7WjjHA/lwhD6nVcrpROSeloDVMS6cw9Gp1hMQMhVbjUwPi+kU6uj8Lt1h7/TJoziXYSwMgaVcsl71moPuKlqOMjE//+f+LTPh7lCgI53Vvc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM5PR04MB0941.namprd04.prod.outlook.com (2603:10b6:4:3c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.18; Sun, 30 Oct 2022 13:06:02 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::28ea:75a7:9653:f151]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::28ea:75a7:9653:f151%4]) with mapi id 15.20.5769.019; Sun, 30 Oct 2022
 13:06:02 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Asutosh Das <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "eddie.huang@mediatek.com" <eddie.huang@mediatek.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 10/17] ufs: core: mcq: Use shared tags for MCQ mode
Thread-Topic: [PATCH v3 10/17] ufs: core: mcq: Use shared tags for MCQ mode
Thread-Index: AQHY5K63tjnb0X6EukKsPbej6n0ENK4m9mnw
Date:   Sun, 30 Oct 2022 13:06:01 +0000
Message-ID: <DM6PR04MB6575F436DDB2AFE5500BF0A8FC349@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <2fea9d4f0b8dfc2e2c82d176f0c928b0525d8110.1666288432.git.quic_asutoshd@quicinc.com>
In-Reply-To: <2fea9d4f0b8dfc2e2c82d176f0c928b0525d8110.1666288432.git.quic_asutoshd@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM5PR04MB0941:EE_
x-ms-office365-filtering-correlation-id: dac0d281-b89d-44f4-6a2e-08daba777efc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LjWTeVATfxFeDQmifV6jrzN6rorA4myKt6YajH4n+8V6tNmZu2SFL8awYLIMschLVIsvxXDcHDIO9G/6JQO5tI5fX3CK2hz5FxOMxX81nOgHaUSZsaVkEe4IvdDBtSek/vLDbVDOAzRCGeaK0HnauP7XxWj10SMyg7dvlhRzNOGA/bnxm1MEOroT4avdDPTD7AZeOs2qE5rXm5gMJab62UMOK4TwfrHTJs7I+5i54BcuMtu5HSWT952B3ft7px1EKkUcf0dSPsVD3NZRhfU47opdbECq9T4bc2gyXkb876Ako8Ruj3C7iqkWhcdR8zJRrZII16WMVZTpRISBEkdx4AKSEiO7r0HOMCn15a4SeJrlWZLcVdl++1oFlzHs6fyscQi20OaryWNOa6TxNTofLcJ/a0JIn8rSbrH0uBFdec8UtISsZnOmVYRdhjFnGBE2ULh7y680Pyb0WVnGzPiags4YPeMhAe2tVldUrmyGuGO4CLzJo3fzR6IhVptJLfW28OOwOSsKmC15ZMVp43OxqIAiSuWutTa1O3OL0g5KSy22FBUKIhaqaPE00/8joQtVDzEyGaXsO+uPiVgv1dawI9aSlrB7sAykGZmjG72QRq0chLozmxdGMFJFhk/SaNeiIeNQQyGpiIabF4UZRnl9+mrjKDh/kuMLu8U9kCBfnJWkszp5X54qkmCEdoeQjrcizeHzZlO46I1iHgVVYcHRrZe7kFMtQ879qyj8fPfWJC5bKLyTRWUdEq+FLK0pW3PYufOTDcPXKaQ8iFXgwb4bfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(55016003)(86362001)(2906002)(71200400001)(82960400001)(38100700002)(38070700005)(122000001)(33656002)(9686003)(26005)(6506007)(186003)(316002)(7696005)(76116006)(66556008)(66476007)(66446008)(64756008)(4326008)(8676002)(478600001)(52536014)(110136005)(66946007)(7416002)(41300700001)(8936002)(54906003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gER47ztCxS9v2M238WzJMwELUA+cccYaS30h6lpRYpKgLx01pDrZjAXmgZ+4?=
 =?us-ascii?Q?slh7gGw9KMfPbet7dOzDWxKTFbkhK9xOaG58pvY7RBC2GmQuOb+1K72Sx2QU?=
 =?us-ascii?Q?iCwLVAcZM0i4t0Os20uQfES+hBz0Y9XZ4ggd1ik5xSVcpX+OjF54Eq73jjaS?=
 =?us-ascii?Q?TXJ82vR9PfzLkEkdUcpwnQBORjEqLW2ONz3NhQGFjBxPTB6HcR8pn2vALRZ3?=
 =?us-ascii?Q?MFy5sI6l12e1N0ZVl3EpcVLNyrHg4z0hbF+cJ8ylOTqc/Tb0egaRbO0oxAZw?=
 =?us-ascii?Q?t/tct6xZdrPt9MUUlkgfY977mlcmSUig3MJoaUUzTz9CuIEO4rl1oSkVzKC/?=
 =?us-ascii?Q?fywp5MZDPq5TIIKJQjnrHfecde5QMbNerp/2Jz8nLmsfOrfakiyCAV+LxdFN?=
 =?us-ascii?Q?M15qsCe6K0nbcOYR+LNApkdqQB2xxB91gWsStVzzpU9GhhYlnwKXmIuewFGr?=
 =?us-ascii?Q?BDtaFWvv8G1J4SqnEbl3P6viRBVMCb+gIlILQl8sczvSx98FODTPQ92X4A1B?=
 =?us-ascii?Q?prAyYtj5FcYvPoqk0DgbsSKWdqy0mfF5C6FTlNr68P5DzUt7wY3Znw+GRxpi?=
 =?us-ascii?Q?+jASMYZcRXhe/25stf0WSI5Mw3C8cDnVD5NCr8CASshT4lUEVs7FVVGJt+FJ?=
 =?us-ascii?Q?x/aftu5u/KM0z4FOsBq6bAnr7hUQ90etJVWzGXfB0G04D/OcaQ8QZtbKEjgH?=
 =?us-ascii?Q?BD3G8R8q6lkyAbr/nDFc0CdX3Moj8ufV/XUTJ8ywqPiWzVZvlGdZ/DbfDiKA?=
 =?us-ascii?Q?DfFvuXktKM25Mms52ZqnUyKmL5gjM9uKeKa3MiIu35bh55zZg4Prp0iP9En9?=
 =?us-ascii?Q?K/CWIU3aBrSIpOK9d2wvOreGskV8dPGnA0hEm6GcVbPcxUskC7422ENj1uu9?=
 =?us-ascii?Q?uez5VWgD/U/BxeOtQjKGMx/Z0WFxDtiXtYo13TiWU3CUFMLL2FUOUVJw8B88?=
 =?us-ascii?Q?E9+3P1J0LCCDqIyi0zN6TkpazFwv1G81L8Gg+D8gyrXv3cApIHsAkl4bRIBE?=
 =?us-ascii?Q?+l1fMbNrzNC92hOkrdEANsyxSyenc48F44RqCxBgzOYZtkLq1rzMacSifKAb?=
 =?us-ascii?Q?91kGlW9ClbSDRbb/xQbl4JHKjxoeA7zDh2dVFQ4ptrcLxKzKSoJdpaiszzTr?=
 =?us-ascii?Q?COTedAox6d2qz2Ad30kuMDWurQLAW/dcrMnd+t2UXZgCW2obq3sdQQO8J2f0?=
 =?us-ascii?Q?QHLaGaKLWinLfWLPajVjTmX3i9FFunLSsT3N4ahO+YZrrFxgD2U1o/S2m2M5?=
 =?us-ascii?Q?4ExsN4e6P/Vw1nlfOFAUmZeCCZ5dVkck3KhcU7L/HycYWJdCqnJJ0EUWbbnk?=
 =?us-ascii?Q?kBwpkB0+KWEzEsG952QjK4e0evxUsglKcHXNiItCio64KneTUawEwnP2pT9x?=
 =?us-ascii?Q?nkwS5NdLhTEgH9xAtG44FJdq4UpICCqOUVfEgylmb9rEd2Y3aI7l3HUC7OHX?=
 =?us-ascii?Q?VGich7ngHYb63/wDPCZivrqBI3ONYa9v0fdiV0cZA/4KvXj+hV/NLFlXuZpL?=
 =?us-ascii?Q?CipdH90geqtkq6A5zGqh1yqt4e4dx3L+z8NwwRkgXj/vMmKXc+1EN+elww1s?=
 =?us-ascii?Q?fT9yU0p7ImxGmWRdjlUrUav1TbH/2ynqIk/kbfJQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac0d281-b89d-44f4-6a2e-08daba777efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2022 13:06:02.0223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqnLneobPU2Pk+9Q9815HlP9HVXL0sSqTiEEv6H2mU+y4I8FRKbZnT0Ku+b30V2Bu0b8Pd0HE89qisbt1eK11Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0941
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static int ufshcd_map_queues(struct Scsi_Host *shost)
This seems like an old version of ufshcd_map_queues - returns void now.
Needs rebase?

>  {
> -       int i, ret;
> +       int i, queue_offset =3D 0;
> +       struct ufs_hba *hba =3D shost_priv(shost);
> +
> +       if (!is_mcq_supported(hba)) {
> +               hba->nr_queues[HCTX_TYPE_DEFAULT] =3D 1;
> +               hba->nr_queues[HCTX_TYPE_READ] =3D 0;
> +               hba->nr_queues[HCTX_TYPE_POLL] =3D 1;
> +               hba->nr_hw_queues =3D 1;
> +       }
>=20
>         for (i =3D 0; i < shost->nr_maps; i++) {
>                 struct blk_mq_queue_map *map =3D &shost->tag_set.map[i];
>=20
> -               switch (i) {
> -               case HCTX_TYPE_DEFAULT:
> -               case HCTX_TYPE_POLL:
> -                       map->nr_queues =3D 1;
> -                       break;
> -               case HCTX_TYPE_READ:
> -                       map->nr_queues =3D 0;
> +               map->nr_queues =3D hba->nr_queues[i];
> +               if (!map->nr_queues)
>                         continue;
> -               default:
> -                       WARN_ON_ONCE(true);
> -               }
> -               map->queue_offset =3D 0;
> -               ret =3D blk_mq_map_queues(map);
Ditto.

Thanks,
Avri

> -               WARN_ON_ONCE(ret);
> +               map->queue_offset =3D queue_offset;
> +               if (i =3D=3D HCTX_TYPE_POLL && !is_mcq_supported(hba))
> +                       map->queue_offset =3D 0;
> +
> +               blk_mq_map_queues(map);
> +               queue_offset +=3D map->nr_queues;
>         }
>=20
>         return 0;
> --
> 2.7.4

