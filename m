Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2EF6F03CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbjD0J5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243426AbjD0J5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:57:35 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1DB449D;
        Thu, 27 Apr 2023 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682589452; x=1714125452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tm5tpPS17TeMfZCSXa+0YvpsqjGengTaylKND034Yp8=;
  b=m8eKBvYUyAYYBY2l13Y5LwqQvUs3DzJDAbc35Ya9Nj1W6MUS0UGNdwql
   JuNgYcvipkM7TiUuWR0/dvhr5WbbwvggIQ1QjodDuSNt8RYlkHYcbuqBo
   3ZKhzyavY8AMyMizVAX8jFQU3oqryHl0WMOB7mZIcFJkxkyeu3lrH0Czj
   VSDNXjF/EeVRTu1btkvUlWoKArFH3CLqZdQGdXJCSeIHjdPqxkBfOtlkV
   6Xc0TNKTAVE7ccHAkIthESZDNrarDa3bClrhTg5iikF8SO/Q3asQzVd6A
   mgliAmJpn6Cmb/JjDkCoaDzvfaTIuum2JnVE58z3tu6puelZ1QO/zdlAi
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677513600"; 
   d="scan'208";a="227624103"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2023 17:57:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFuPIAV2WONTGqW2W20hf82vcj80tcVKxlYA2Aav+1UyVh/Lq/Y6otV4y310XYPcL06IuvoD8hCyv/ZEjXa3PvMue4eJS+qEp0AYSdc+onnjkH6IXp/rsL2VXJ2UsSWFbVHD4fS6QLbbUzQJhfsuZ4uPjJh8VNd1x6qZ4dNo80f+lbk1DJS17pT03IpNYKAkvRwFF/X3HUnNWL2PMnW9ofzmp51GLn8iJ3uvNxpa1sbZFDGkwMQTfL8ABo8/sXcS+4v71FNPHJ7fGlShJY5k/D6K5lU/YfmsSlx6XSZbwZ9xffWkDORtEpNfm1YnVKclm2TxL+jPX+PtKUjJYjA62Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwgIiVJqTqk3f/agkNNBtF3yunuToeJ+nk2D/bRLMP8=;
 b=e4P5VVFx1Yw8gJ50Q3RwqPmCn9rwf9uDtJSEBAyPdOzSFYzXftq+AzRe0+KgUOt916IJePHX3aKqdaK+gdpaBlqKtHj/+d8waG0Qfn/S0BcxiQkHbf47BuQsJoDeROf96GuNG/cEHb9DBIfdumrDJyajZIhy4hyos8IznPaZ/IdMwPTiKw/3SKU2ovOSRFSZaoWTvbxlZ/Vmfoxmp0NU0lNyVu46/zSAUdEnT04znjcoGhRXeEOsu6F9RrLEKX8tffXgW/d51GVM/+pvTgCDj3pPs3Nl+okkHxEeJtZXq2lbheKcUVPgSA3rt/219bzZvkhJ8eaT0xRFoLAy32HAJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwgIiVJqTqk3f/agkNNBtF3yunuToeJ+nk2D/bRLMP8=;
 b=sGXrbePHeHiamTCqOOdws5Qeb3NJzo+BlUDrXQcreVgEd20xRAlWG0KKPPnWkzUkQiuxVOaGwWU0jYMI1JOSk2wJsUd+HGy/c38EIH/ry09eYDAg2Jo6jQFlsfWKcP2RjABjCSSM7h9P3YS3EcNJmwZ4MTbQR92z4QOWFyXWlDU=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BL3PR04MB7996.namprd04.prod.outlook.com (2603:10b6:208:347::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Thu, 27 Apr
 2023 09:57:28 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::188b:9005:b09b:81e2%6]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 09:57:27 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Alice Chao <alice.chao@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] scsi: ufs: core: correct utp_transfer_cmd_desc
 size
Thread-Topic: [PATCH v1 1/1] scsi: ufs: core: correct utp_transfer_cmd_desc
 size
Thread-Index: AQHZeM2t/+gGXd+zuEe0BzdD7MDVNa8+600A
Date:   Thu, 27 Apr 2023 09:57:27 +0000
Message-ID: <DM6PR04MB65750D13F7417242DB51E98CFC6A9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <4b778dbcfd1fc40140292166834f13e8d5b8e4d2.1682575115.git.quic_nguyenb@quicinc.com>
In-Reply-To: <4b778dbcfd1fc40140292166834f13e8d5b8e4d2.1682575115.git.quic_nguyenb@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BL3PR04MB7996:EE_
x-ms-office365-filtering-correlation-id: f927cfa2-9999-49f3-5c39-08db4705cf17
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9KxqTIuJqFf3CXpLMAsP9j45eGsMRK46/QtjUEu24VVBgMTGkCC305LPmngflCX7hrRhuZi6sRXlVs/RPdqadlkXpN+GfejvqHutQKwQxXCMIZFiyKveB/oblDrqRkYvhuf/24aebNfrmrriNM5QPbpPu96+dUNh//ESAdPqaEIxHbpYdOMd8bAXzytKEIglhV8nm1JB9/27EoLafGjyEhS5ycl+wPrtk38mhJeKU1EGYeiEAPBJhIAnf5lIn9eoP+2cIZnlsE6wAS7xjCEQJ6Ve48esrxCQUGKQZvAGPT3l/z0583VEkHytyxjfm2LTFlVjR0MRi+3sdbnUIruVy5M/yzuueG/ENQlwT4jb3n2zNQ8AS5VZlVIdakrItnlhFVv0DYTf+4K4fi0LCl3KUsCGcfRRP7gdRJa1SK0ZHyrpXtQLmZzMi1Acw5DTr8cX6HF989lMKDWKPMwerVcNlWQhz4t8Autq2DwZGlCNQpRjTEKjWhNjmxEvUEswGtNBtEDke3P3p1VAZ80rDBgKVGOb9mW2XPnJxxwEQjYXcAi/1LLBTpDehbpPINxJnwvbvn8zwBUL1w8zgk2/fS6d9td+g0z5+SyeQxl+yRX+dw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(9686003)(6506007)(54906003)(5660300002)(26005)(41300700001)(186003)(82960400001)(52536014)(7696005)(122000001)(8676002)(8936002)(86362001)(33656002)(38100700002)(55016003)(316002)(66946007)(66476007)(76116006)(66556008)(64756008)(66446008)(110136005)(71200400001)(4326008)(7416002)(83380400001)(38070700005)(2906002)(966005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f2JzcUhmb+5Da3HipIeOCm/DV6RsWMgmZur9P1H/I61zkD0txQzz7cTn0jDx?=
 =?us-ascii?Q?MczzwETnMAmbJX0cou7LsaBp16t5ErVyAyVfO7dAh49eOk8ZydX1uvgD9F/i?=
 =?us-ascii?Q?oHsEW/2jEaibXJ4Ms+8Bo9b5I3p1u0DV3/BWArpFtgTZ1MpAvDhRfeKTvNlI?=
 =?us-ascii?Q?4fy9RIRn6jaEcGx3g2XXWV7UIqLIRWdWgO8HHfKJIFZG7tVQTjd1BQiKAmLq?=
 =?us-ascii?Q?E2/4ok6GRFqet29DnfuelUQmDIBsz6AEetrQ9mDvyBGqDyQMpqOHGPXxXt4E?=
 =?us-ascii?Q?XsJnoPfO+7F/S9N4sREifUA6faHSJsQaRu6QBC1ZnmgXcWSKHfAd1odVKmvq?=
 =?us-ascii?Q?VQcNDwn1XSmYK8s80iquBGEnsmiZRaHtFq6cpl3sk09/mOpXccusqQSEefqv?=
 =?us-ascii?Q?P9tIGNSL17t0mzd1hnOZi/a/bFT2SVqjTnjsgTGlhlpeLoTKbIO6pm7vKnwu?=
 =?us-ascii?Q?4l1JvA2PQQHHV6h+g/KGzPV7EYtdixtyIdN+Z9dc/xtuc9ofdoOEiz2iZ+MN?=
 =?us-ascii?Q?E01mZvLIfquYjgt/MoZGZ87UKhSPco188Tga2aEJ8QVWDseTDznssUBkg0eJ?=
 =?us-ascii?Q?UXxZp3LLORK+zDi51qGb9Ss/DVcC1q4L2EKHzqHluCZfT9tg0r7P01642c9v?=
 =?us-ascii?Q?+FnMdJC7b4iN8tBjZBri3mpPxfn2kEY/vmekju3Rwdbd1yiFdg/6u7uq34kq?=
 =?us-ascii?Q?ui5RgpsZhQXV7wA1NVmtDQbRJRCdrQwAivIfUWOahpSoCTPPHfWg5S6LslUJ?=
 =?us-ascii?Q?P4PrzfLfTiaRdncZdRetedYDDwJQ1EwDXI8+9FjRcqVJj4A9NFDndtMFs+XQ?=
 =?us-ascii?Q?vnQERDHBUtoGeYyvVpKGc44IQ88SVyTSzWB7wFXukHURbKGx+c7/1iQEBeZD?=
 =?us-ascii?Q?7mVB9y6D8jWbOtxnTpfj8WzoiVoCGfgBUcU3XAlFUr37YyhLWQCAimzktOuz?=
 =?us-ascii?Q?SdrODgBvDSgy3a84bVKoIf1ddSiJSu7fGyi6WUoPZNKW4xqFUg3zpd1rdqTg?=
 =?us-ascii?Q?4z7Lj00JhzbObSaG/qSh2Q2jNDGEOl5CD2DIdQTP3y6BB4slqcjQfnu2AW2T?=
 =?us-ascii?Q?4df3JmpB7Yt4lg4vmnRedkR+/8YW+SZZiHA5A209H/XFXo4KybyfGMP9ErSC?=
 =?us-ascii?Q?QhKvchb/2FtxqMUUuaL7GxhKP18Wk/V2NigXqNFEqdFTe0ro6rDToxjAZuIO?=
 =?us-ascii?Q?GYes+R+eNCoQuG4DDMmVyLExIzJb04VM+N0thS0Jg//QGZUZMGDJtez0mkyj?=
 =?us-ascii?Q?QP/1IgwCvQaxoMy14eUAZUjtXhKp+VuYOrNuQOnLiXpgvLoVltC5zYicf2Yz?=
 =?us-ascii?Q?UyK0HNarfzy4Q44r5KoD1jyETcP7kugw1Vc0Khr9WSyC9DdeCT8e4blc3FrT?=
 =?us-ascii?Q?pYM5jjpkcgPiEGU4mr3fBo03gaBVSa5Dwsbk0IHcgHR00IL4DxfFm54UGbZo?=
 =?us-ascii?Q?E5yCqqJCZJtjOruOkCw4jPH+lYTbudxX+QxLL083dHqeALS+V6XaYDWVvQwu?=
 =?us-ascii?Q?PtO3Rqz9lXWadS2RhpJ6sBlUVIbbVpCrKrit+xmCpNNNyc6hl8hq4qdxP51A?=
 =?us-ascii?Q?SPQ+f4vVG1oLwgxllP7hwqfa54NiGZefsJ7vnmL9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jvZAl5N3rZ2TDSKo1cDWWsuuOi+lHjjd6OiuXmEpqdgZttyPs2WQjtu/gumW?=
 =?us-ascii?Q?utkcmvmuZjEu6kbIsW3Sgx2cibw6ojPouMz5EbAANmPDIu7mZoC1fKFeSCi8?=
 =?us-ascii?Q?cvaTW1W85MeC6jWGaxHwEpTk9Zoud213n4MgRBgw8/8FZzLdngBLjxVEhhhx?=
 =?us-ascii?Q?GlLkS8A3in2KdcHlVsDkoG0ElcuEmIgp5xba86g3XF3Iwe+OAHH49Q5Ei5vB?=
 =?us-ascii?Q?nS/gxqxP/ciSFVHTXeYsx2PS2EwhU7YqU3XShD1TOiODI9MXwBCJeyVizLmr?=
 =?us-ascii?Q?XdgFnlKWMu1FejJZA2Aem4zCj0GmJAvESGwRr+LTId1dV+skd75+n7wLZXjT?=
 =?us-ascii?Q?aIK0SKK4YGqY7dCDoM2ehuEid9MLTS7tST3Z6FjWhb7bgPiQBlv3d6WnoyAw?=
 =?us-ascii?Q?OyyVF4LuwhdCClVaBs6tecgCizNCNS/6tlHLh4sTBLLGaqiN+RYOoKODID9F?=
 =?us-ascii?Q?XMd1dcafJduwPHlNxCv0rOFFRZbDPhkB6i5EkBRWeENlqaGSDLLh94KU0d5c?=
 =?us-ascii?Q?toqWutpW+vObb1fQVbQiTSgtmYKjTnQismV1mGVas7qgNLJhwEoC/jcmTUMe?=
 =?us-ascii?Q?c2JrOdfjwWNDqYNfbgPt9pgFBGcIo154u7t72uTRaEPXNxaIY3TM070JPxq4?=
 =?us-ascii?Q?9oiAUOij5WqHtKHmVN1tGaJqrHJEu4aq3CB4wD5TdIsZwmP/Ta1o3igrTwif?=
 =?us-ascii?Q?JL8zHxXKWXueoVY5M2DnZqK7VvUQ9DAgE7by50HPDr6439dQfgUd6ZmDpRa3?=
 =?us-ascii?Q?cqfeWpMl5KBqExP/VwPK7Ci+8rWOu6RvJF3Qwb5fTm2rekjXMcbxPKk90jC5?=
 =?us-ascii?Q?yubk+LfvFmD4fzzZYHxcYrt6Zi1+TdGtaEg1OmOur/fRM1huY/xqiRhO//3o?=
 =?us-ascii?Q?ozgBpsE358nyHYbKhry07H78OUBzebnyRwNRnpmVZH5ZbiWhq8ffB3+9doCK?=
 =?us-ascii?Q?1eG0/5iuAPii/f3M8Z7/eQZz5UudD8PAtAwzgZxy/c54fZmzr0WlE2GdtcLp?=
 =?us-ascii?Q?ODf/s+jeRd2vDMTarTZqN5igMjp3IqVH5mlK7O3/xIi36dU=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f927cfa2-9999-49f3-5c39-08db4705cf17
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 09:57:27.7564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X727XTaRVX3NfZGS0NouEcL/+KLGcfkDCcwoXrpYvkczE/3RmEiEn1oryrz1fwcX6fG9AHhGy3HTchzXLUzsLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7996
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When allocating memory for the UTP Command Descriptor
> hba->ucdl_base_addr in ufshcd_memory_alloc(), the macro
> sizeof_utp_transfer_cmd_desc() is used to calculate the size of the memor=
y
> allocation. This macro includes the prd_table as part of the UTP Command
> Descriptor memory. However, when freeing this memory in the
> ufshcd_release_sdb_queue(), the sizeof(struct utp_transfer_cmd_desc) is
> used, and it does not include the prd_table size for the memory to be fre=
ed.
> This results in a mismatch of memory size allocated/freed.
>=20
> Similarly, the ufshcd_mcq_get_tag() incorrectly uses the sizeof(struct
> utp_transfer_cmd_desc) to find the tag number.
> This results in failing to probe.
>=20
> Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
Looks like this fix is suggested here as well -
https://www.spinics.net/lists/linux-scsi/msg184092.html

Thanks,
Avri

> ---
>  drivers/ufs/core/ufs-mcq.c | 2 +-
>  drivers/ufs/core/ufshcd.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c inde=
x
> 202ff71..b7c5f39 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -265,7 +265,7 @@ static int ufshcd_mcq_get_tag(struct ufs_hba *hba,
>         addr =3D (le64_to_cpu(cqe->command_desc_base_addr) & CQE_UCD_BA) =
-
>                 hba->ucdl_dma_addr;
>=20
> -       return div_u64(addr, sizeof(struct utp_transfer_cmd_desc));
> +       return div_u64(addr, sizeof_utp_transfer_cmd_desc(hba));
>  }
>=20
>  static void ufshcd_mcq_process_cqe(struct ufs_hba *hba, diff --git
> a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
> 9434328..b009e55 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8444,7 +8444,7 @@ static void ufshcd_release_sdb_queue(struct
> ufs_hba *hba, int nutrs)  {
>         size_t ucdl_size, utrdl_size;
>=20
> -       ucdl_size =3D sizeof(struct utp_transfer_cmd_desc) * nutrs;
> +       ucdl_size =3D sizeof_utp_transfer_cmd_desc(hba) * nutrs;
>         dmam_free_coherent(hba->dev, ucdl_size, hba->ucdl_base_addr,
>                            hba->ucdl_dma_addr);
>=20
> --
> 2.7.4

