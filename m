Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED876C4D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCVOKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjCVOKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:10:37 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020015.outbound.protection.outlook.com [52.101.56.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A100027D73
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOzO2ON5bIywXahRMqvJk8GNOI1LiB3EuMPBI6T2DRbXsEkwXQ9/dGK5CICqyJlkF/2YHUI4dYSIMSsiJDqpRQ93+xc1XBalAAGs7uZZtNjjvoYe+alUnCAY4FSfEiI9u1rifYC6JOAHu0j5geW8YSHbnyY1NHxaDPBl8JN4F5JagotBxNv6PVjRm21XOnc9SS+eXt2SFjfpsqeR1aES84B5tNSjNE4MA2pyAdKAUK+PKGyf+kZqdnggMwrDyrJYRDx7BGw8/D5fiI+RgEMMv/6GrEtOCZlwxoGJP2+hEWpmj3I5mcStHTTXwGuHZX73SV3tirEYFiufsMG+ZrghvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rq0/O9VKPwsfF5LcV0QL/aCcBpAGQupZAkkqiNxe6/Y=;
 b=Eb4JwVMlSQ5dOu0YhgyA8LogHei+ParRKE66/kkke2Jg67aNAQyUIseRkqheLyhFhbQyWY3jEwBTeLEankk+PYako/HnGb5P1sHD4uzL9fqfhGSPki2mpseB73AjP8J+EXJ204Rek/UreaC9z52S2HXUP533shCrV9WmQI7g2NeMLnthZqEhh+LnqGesd0k2HxuVCqNDCP5JRC2TOQI8bvvo8r3utzWlc0bDaNHElTRYLWZM00wekvzHAqqPvTl7FSvHO++W0adMYv9kqpebdcAFzZBBSOpU1ooHchbNbT5sfTtEhW84Y5LNvLE22DtgxT7d/uK9i1CGiJ4KMaZHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rq0/O9VKPwsfF5LcV0QL/aCcBpAGQupZAkkqiNxe6/Y=;
 b=HtKaMQCmjoHhhiuOn+R3WRvYISaYIxGz0+/2DX2DwBUrOfRkugAY1jV/BktYwErVfw2xoXjKusuc8DtungBNtDRG49mJYCGbs4if0FKChWaYn6JOn3RAwFCPwCaJ0uMVodMqaKOh+fES7QJhMC5yc1/HBpM9sH3k3Fn7JGgkbeI=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ1PR21MB3480.namprd21.prod.outlook.com (2603:10b6:a03:454::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.3; Wed, 22 Mar
 2023 14:10:32 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::2e52:d6aa:9a99:500a]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::2e52:d6aa:9a99:500a%5]) with mapi id 15.20.6254.004; Wed, 22 Mar 2023
 14:10:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] swiotlb: Track and report io_tlb_used high water mark
 in debugfs
Thread-Topic: [PATCH 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Thread-Index: AQHZSsqBAEWh9nqUUUmkQXhDk78K2q8Go2MA
Date:   Wed, 22 Mar 2023 14:10:24 +0000
Deferred-Delivery: Wed, 22 Mar 2023 14:10:00 +0000
Message-ID: <SA1PR21MB1335022D514B2232953D43A9BF869@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1677516106-85971-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1677516106-85971-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ac2d93b9-de41-41a3-a4f7-46e48cd0a71f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-22T08:58:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ1PR21MB3480:EE_
x-ms-office365-filtering-correlation-id: 4a89d5dd-f0a6-4420-df93-08db2adf32bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rlgcNpUH3XkIDPbTcHhiO8KF6z3zJVB+tU8FzS/Q23sHOSZSwSzWeLx0B/xvbY4OxLs+HSyAeTtpezZHjP079xsZKIUA5tH3U1PDEfaW0vQHDtnLAISXWcN+xeuUERqUOASKby7s9cmZSUlcaXM47ZpHdnDicUHb5XsVPz6Tg1h49fTgEqmLaP6LB1VwQx6U/nkdK+6TuSG1u0wcKDr05l3XuEdGbRJpd7utcUhpwpLkA/vbI/xizl78M7w/u0FT1tBFZOLRAZ12+eAYOVcZFm+WB5sKK+tPDo9i0Wykl80ifWQqFaTbmikXVIp//5v3exxjJfrs8DrRJDGem1Q8VWuWUqzf6/WmR5I59Ak1vXar1aXuN3VecKe6J5xCR+OnGRNql0VeJItdSSIZMuN6QqRbI4Njo23IZKqWbnP/K1TVAKGafESeviT1NKUQNMIjiF5pP3R+EgsmygXkqL4pLru63iLRqx1cAIRUvtBL2BemNqWXwuBQhzsLcocV4qPAUh7YANF0QsCxvaBeU6BOt2dNj4tl0XIYFEn4rEsAT96Q+kyYFkYKack1CxV/9fgBaRs5i8+UlV8tCEEY1txDLJ4h5YZqmsGZu0gWEUGhlEwEULyzPbPjpxBsB67xXkU89o8sCRWlSFNBOP/5FM8KylkPWcZTv6bzCpWtd5TmbZQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199018)(7696005)(110136005)(71200400001)(8990500004)(6666004)(83380400001)(316002)(86362001)(55016003)(66946007)(52536014)(5660300002)(8936002)(478600001)(10290500003)(2906002)(122000001)(82960400001)(9686003)(33656002)(38070700005)(186003)(6506007)(82950400001)(26005)(66446008)(66476007)(76116006)(66556008)(64756008)(41300700001)(8676002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gvIN+gng4ev0gr2anViQ1mJuCp87KMCTdN9sx+eCZvchxdV5v3DgmsdWhLJI?=
 =?us-ascii?Q?u97MLQH/NhLJBZQB5Ud9AldM4Sdtw1YyWnGJ8oz1M6GOtCfHWhpBElEqxb7R?=
 =?us-ascii?Q?F1YXDWLGantW7bnWIKzo6/jlUyM0Ix1UcMjhkc6qOh3kCj6zXJAHAicD9im6?=
 =?us-ascii?Q?PapyNBfSHD1RJI+VIl3ovBJ72IrSQHpeEhWlrVKrSncq/jlMiUmhYeqH8IGw?=
 =?us-ascii?Q?AFXIKjXG+0dFptoZbezImf72BWz/5sDB5GydgApm2WBEX7u04U5Slu1O6/ef?=
 =?us-ascii?Q?FXGrB3ayON85qGTJqdJ56wW3c2rohBVVRUQrVpVGvDwu79lv13mAJTQDtjwR?=
 =?us-ascii?Q?gTKX7grS66ZI6crZYSoy+rThck7L63MVCFfsrZuNdZsIPMpWZbjsz4IJtuHE?=
 =?us-ascii?Q?1GU0RdP0Qqo+Lv64CxwdKwHDv5CfeN0ZUmB9D72mZWf9K7Q3XFtF8P+N0mBD?=
 =?us-ascii?Q?bK7T3WawXvDvbp72jnkiSoa8DtKO1uDrHFJivMapuYMT0lIv2qMopKVKlvr5?=
 =?us-ascii?Q?QOeTkqae7NeRPnqST6+rdD/zLIJaTTphTcZQRLO3xDECpdxg2cKL1PgrjTUb?=
 =?us-ascii?Q?2tXtBpor0/t+rVmNUc8iTUNdh0HhZNKd+PWwCqRhObWSHk7oe0wbGyg3KfK2?=
 =?us-ascii?Q?+VJwusBKYsX4MLuHbVvERNNtEq/ILtKwoXNbdWI8Mamkk6DniK53h4p3MDKh?=
 =?us-ascii?Q?SgB36PLYm3fXXu5889fTVTvtarBl4jFXq1bfJD8TnM7dOgD16hesGrVUpBaB?=
 =?us-ascii?Q?FlanzcIiKtKG9KJ2D+N9jhZW24mNRxa8dSziDEsDVFStQpm7UQPO/dfP+Odp?=
 =?us-ascii?Q?CvpW9w25MbQuijup/ph7y6gi/RRFtaYZaiHiCwQWa77zbaMHmuZmvJnR2lGe?=
 =?us-ascii?Q?OHVb98oj8AAkCKRxnIAM3Amq6gMaG7tJ476luj+5Y64WR7Ul6lA2+Ok7pL7+?=
 =?us-ascii?Q?kTnQI/MWMupdhfHTW3wbieatDurv1krkhdMb3o1EgUoiBO2IL82xRgwSONny?=
 =?us-ascii?Q?jpKmhBk2JVAtMDgHVTb1jz50rXxWxwRaCBnKxmNthjP5JNR7fIkeYL3xVaj7?=
 =?us-ascii?Q?M8DRXu7kxtdHDEfbdH0K3BhWMSk+gk7WPnfJWCff77KHyCKyv55HNe+flqDU?=
 =?us-ascii?Q?adMAorJk6NeSqKL8kpvy7ZyRvQZWmg35WXFd4lnjQbTN1x8XEh93i+tl3seU?=
 =?us-ascii?Q?dkrwmH959xA/tBzJeJB3CP6D+hFdOPlcYxkgCuJbVqMdWmza91ltyyqnHilV?=
 =?us-ascii?Q?HMX+qDKphPAU0+FI98ttPDnU4I1iyROq6YSBLsStKIkX2XU99i9eXV9daLVp?=
 =?us-ascii?Q?2JXPf6o9eC70u5tyJbhcXNloAtY54hpRn95kdnpTBxFd36Nfh7oQBKoFHl34?=
 =?us-ascii?Q?zrdLv2jZIy39fo/VciQVp7Z6QFQqFtix7XWLKJKubH43tKIgOYNS+1NlsBZi?=
 =?us-ascii?Q?dsHmnLs5kfnRc2mkuEn6L+hvH4+HZ9r63VxFQfcX9ehSwh/mjYxNP5y2VZ8h?=
 =?us-ascii?Q?KIBU4ElE3mlVV+uQRStGjyhhgC9x4+V6sGibzc4232YdUMs/YPjiimRpwUVM?=
 =?us-ascii?Q?W3+XjCTAt+Hr9ilY/gL84osqrGDfG3w//De7kaTS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a89d5dd-f0a6-4420-df93-08db2adf32bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 14:10:31.9709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYNzpuf7OB9TnSAVDF1fZdXkWegrloT3qV23EGxPTjloRoRl99IveTkRBvcsOLISASz/wy6r2qsi+fENe7jfFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3480
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Monday, February 27, 2023 8:42 AM
>  ...
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> @@ -76,6 +76,9 @@ struct io_tlb_slot {
>  static unsigned long default_nslabs =3D IO_TLB_DEFAULT_SIZE >> IO_TLB_SH=
IFT;
>  static unsigned long default_nareas;
>=20
> +static atomic_long_t total_used =3D ATOMIC_LONG_INIT(0);
> +static atomic_long_t used_hiwater =3D ATOMIC_LONG_INIT(0);
>  ...
> @@ -594,6 +597,7 @@ static int swiotlb_do_find_slots(struct device *dev, =
int
> area_index,
>  	unsigned long flags;
>  	unsigned int slot_base;
>  	unsigned int slot_index;
> +	unsigned long old_hiwater, new_used;
> ...
> @@ -663,6 +667,14 @@ static int swiotlb_do_find_slots(struct device *dev,=
 int
> area_index,
>  		area->index =3D 0;
>  	area->used +=3D nslots;
>  	spin_unlock_irqrestore(&area->lock, flags);
> +
> +	new_used =3D atomic_long_add_return(nslots, &total_used);
> +	old_hiwater =3D atomic_long_read(&used_hiwater);
> +	do {
> +		if (new_used <=3D old_hiwater)
> +			break;
> +	} while (!atomic_long_try_cmpxchg(&used_hiwater, &old_hiwater,
> new_used));

Here 'old_hiwater' is not updated in the loop, which looks suspicious to me=
.
Imagine the below scenario:

Initially total_used is 0, used_hiwater is 0.

Thread A: total_used =3D 10; new_used =3D 10; old_hiwater =3D 0;
Thread B: total_used =3D 20; new_used =3D 20; old_hiwater =3D 0;

Thread A enters the 'do' loop:=20
used_hiwater is 0; old_hiwater is 0, so used_hiwater =3D 10, and we
exit from the loop.

Thread B enters the 'do' loop:=20
new_used is 20, old_hiwater *always* is 0, used_hiwater is 10;=20
because used_hiwater always doesn't equal old_hiwater,=20
atomic_long_try_cmpxchg() always returns 0, and we get stuck in
the loop forever.

I think the line
+	old_hiwater =3D atomic_long_read(&used_hiwater);
should be moved into the loop to resolve the issue.

> +static int io_tlb_hiwater_set(void *data, u64 val)
> +{
> +	/* Write of any value resets high water mark to zero */

Maybe it's better if we return -EINVAL when 'val' isn't 0 ?

> +	atomic_long_set(&used_hiwater, 0);
> +	return 0;
> +}
