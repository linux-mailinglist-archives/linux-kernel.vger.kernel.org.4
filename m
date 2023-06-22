Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA232739E40
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjFVKRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFVKRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:17:50 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BEA107
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+yiEajWGfx2+Sp6usq1yr7c4nbMbK/0bDAOJrXPWAJ29W90MwbretxJJS72GCwNDniz6BGVXD1NWe3xtcIqGn/1uN7TP8dDjKREFzTWpcDHBorgGVIhUlAHpyPosVVfPMrS3G10+ANt86bPdNF8KUVPnZnHmAdysfDVt1Lyk2bUcBasPOV+sZ/H99orLVsp9rchi0YUoj0CNDWEFg7j/u0CaBe89BLVtlBMEue6dHKJP3mHcC5SobCV7I9vNjqUvoz/ZG2Ivhbbb3XeX+UbnkDFCYX2XlYTNJQARVfRXDqyu4cAFO4Ni4Wfk9wVdKJT4wuFVT+reuZVgoUp82myww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6heYg82L74XfRVCJJ/WwhRw5NnkVDTswla3mS7ZKTp4=;
 b=cf+2CfzI+azZjBJrtXBuoyijQPQ1muctuosowL0tbyyHkA36RDS7YuFNJqmAZhzmiuDzvatZ06f5JyKpEjzdMu3wOyvTle1vgX0exh08LEMJU6dDpWdn4uJyVYxRzMjv058VyEY8ZYkQ7yba2cnWpOKdLhilbhmB4cRRSWfE+9F4IiC0082h4yYM+GMgtwSDi7Q/qXhdoouD/ApyB1xWXupFoM40fcG3o6ZQLfw6gC1aoJxBv5JKcJvxVslJhaCF4nCnBiQausM37HRXPPtTRB+n+0WjLxxzU2UWNGAQqW/QOpoZ1703xjvBQkjj6y5RUSwf0RUX5CDHQrcjbJFwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6heYg82L74XfRVCJJ/WwhRw5NnkVDTswla3mS7ZKTp4=;
 b=px8h4OMW7Pb4MGuKUlF+KcVonRk6O/oGfljO6kWBaw4Vjmq+ajuhtCQHT+wbOQZp7ZLuobZv81lWasP8BCC0XJLeY7RhhfhM7MpXWcIjTWkYH0EuGLAukiZ+GWMJkOghNwJyyrd38P3nJT4C7TKiozwKxCFxD5EKucsnsgeSxF8Q5705qfTD86Op5c5JFPXBf0NrdJ07FS1QMz03YsDc0T13a7yXbXMzfC3dVXx+11V+or0uBM5TvYeeTK2nN5dCMsPl6dX32CNMqn8rWuXwocBCK8unJldQGbWmXJBWGIFr16O/KVn2SCWGGQJNVlgh5uew3R765o/9uWcBYTkt0w==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 10:17:46 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::9a2d:7483:7e1a:5bbd]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::9a2d:7483:7e1a:5bbd%6]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 10:17:46 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit writes
Thread-Topic: [PATCH 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit writes
Thread-Index: AQHZpKafRv5fenNB+EijuIYrdy42ta+Wm7gg
Date:   Thu, 22 Jun 2023 10:17:46 +0000
Message-ID: <SJ0PR12MB5676D09F6B1D2600AFFBFA8FA022A@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20230622011141.328029-1-ilkka@os.amperecomputing.com>
 <20230622011141.328029-2-ilkka@os.amperecomputing.com>
In-Reply-To: <20230622011141.328029-2-ilkka@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|IA0PR12MB7555:EE_
x-ms-office365-filtering-correlation-id: 1a0eea10-76e7-41a8-9d94-08db7309ecbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: seyeXFnS/0Ji1b4M28lXlsrfWa4R87GMW3uI6ia+jLrz6YLXa1cre7ypAWgK+oxc+S01/PYwGC50sJpj6BRGaPUaor5ABRHoHsUzFuftMUSqptxlT05yagwqJs3HxFI4goCZyCA9M8L1ji/1NOeoLs/2JlwJkT8vpuM5eS82cE4hpNVXVI/pbfn58afBk7I0y7g7445U9IA8gpwzUVfKUiuhVORZibrsjWziXY4kmgjIQI9r1FZr3crTe5s3DTsY0tIDvnQ7Nk0WfHx4xIHIzV2afILbraG5VSIuIZVQuVay4g/sECrvzN3yIPnMml58tprDBV1bLulmUKbphS6FJWgLe+bNrSBaoUV73AiZtFOeb9hPHfbZ8j6pt77Nw5zYYZbCDQohXDyn+VkUsKzloDH/UbTQ6TWrVHMgHoKay6dYgccCJ2TABgFwexAxBjaKqNqcgdikn1ZNGI7W9eQz+acqXVbvcJB9GKOpQOt7fhZYVGifl+spWmYG47ptv7mR2THKa8ZYr8oXG0w0skJNBOSG951xAGzsrIbbU32/HIn66Iq708c0//IJEnZ+tjGHVz0BBN7Pm8kiE3vRQiYZPki1u0dcpd6TgaY/DZL0TgFA2FRN+NZ0XT6lp+5mFewn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(38070700005)(122000001)(38100700002)(86362001)(55016003)(316002)(66446008)(64756008)(66556008)(66476007)(8676002)(41300700001)(8936002)(66946007)(4326008)(76116006)(33656002)(83380400001)(5660300002)(6506007)(7696005)(53546011)(52536014)(71200400001)(478600001)(54906003)(110136005)(9686003)(26005)(186003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b1gDl/wwU4Lye6TgrytnXVDHGEkrj3D90+gBZ5IGT4/Uu3oxmG4YtkHInibc?=
 =?us-ascii?Q?t2F4jz80JQ5VZh1pfUUTdJJgUs3EoDYBcdM2UMp1RUpcv6Hk0tg2inUzUiXd?=
 =?us-ascii?Q?xLtJ83Vm8096FPQIIQ0cBdOxc5w9KcwkGq3Iz8DnGTHCmcg3JQYbDcR7gIbb?=
 =?us-ascii?Q?JRM0fY8xAaBB2phIter/2iiDg2XRXNN6hllJjehx8XNRR+16Cfqe7IhCn92m?=
 =?us-ascii?Q?HxYGE97x1e0xS7A9Vs37HhfsDlgGJHEy8wTEz+fduhQL8pTQH6xVJuXyn7jH?=
 =?us-ascii?Q?7JjYM+S/SRgV0Mzgu4xzUrS6pLi5QR8UXtVmz7l64CP69incEp8fcKC5lKHL?=
 =?us-ascii?Q?n1739XDTCEn65eTxORKuWvAKi75fu9g/GkyqjHDIxVNHkZ5ooHD64Er/MhyK?=
 =?us-ascii?Q?ts2c0wvXY/uZDYLihHuM4NvydyovbnIVEzLAbkOdnc4LmiATZ1PIiVmpi4Gn?=
 =?us-ascii?Q?UyR6PjT8HSHlLEW3GaQ4wEJshW8Zm9nB/7DCDrQaSAFez2QlJVJno7SjrbQ+?=
 =?us-ascii?Q?HgE6cVQx/jOkyqpdm5U9j8UdzYhp0IIQETPnT8Nzm1H7Tv7KvSnR1N1EhgNj?=
 =?us-ascii?Q?MbGgGNagvYZoFZEf5I5Y5p7jOXlrsNbSssLLbi/mOYdL/skoKPaagf/CPCME?=
 =?us-ascii?Q?Gzn3mCimwSjczWlsRYi/lFr7LwNvHZBfzYKlgASwso41yMNQxvK+CRUwEOrA?=
 =?us-ascii?Q?WKfnNl+hkF3vu/1tYK+GeJDfsFJHhAJ2ZWD4P3vxSPT8A9i+BnuIKhnEndu7?=
 =?us-ascii?Q?q8boERprE74T/HXF/dEb1KtWn/kQc0gCDNe0WzStXMCTiT8jr9sCR8cakvFR?=
 =?us-ascii?Q?7FMcmzAn+7IzBnrp5o/cuPWaNqUrrizyjrlsl08UbambBtbNo75qqiSqd4LY?=
 =?us-ascii?Q?WFKV3wW9m9YbA4mDBSk0Nq+uIwOxqoRaCjZ9sdp6mWTNDG4VgPfRatw7l0//?=
 =?us-ascii?Q?nWTnqSZYNkuKEkmJbZsneJp5m1JcK7s+dnKAT+AbUuayagYtRRrLdQxzJ+5y?=
 =?us-ascii?Q?AqAMjojgTp7Lv6CsadsAIApm0rwrc+CjdcsTdwu55WHUgVANuwIRmYXpXghu?=
 =?us-ascii?Q?pZH288MkTKZnH/JvJk+aUuqzFl4wqkWYvoUm/jZvWLFlrEqeFjlAFUOS29Ce?=
 =?us-ascii?Q?hdHWuCUY0VC5f+BKKftO3tpbXEt77iMmMOErp5c4AXCKegNt5wRhVDeK5fox?=
 =?us-ascii?Q?SpsN0PIJvCD5T9CioubkDYon8Ynw7aeo722rfHrQAzkSbjTXS+BRadRvZ/qd?=
 =?us-ascii?Q?GNRWbJEp0EVmrcpLxMPlzzCVoIxNYdCzHYV4Lu/snGiYrTfEj9I4N89h6uxk?=
 =?us-ascii?Q?mxcc6SxNQdoK3hbNIKe3MAk3tpB6RYNBgym3zxc3NBsfHSruAtIv4MpHhRQq?=
 =?us-ascii?Q?Z0fLXS2EFJMYvmub/N7HPRGab1kyQbgLRnbs+EGjgkmETjZW49/URnfBV93r?=
 =?us-ascii?Q?VqRzlMz3HVkSfjnxqKJS/6QTrr9J9AoRCm/yy/x0YDAnyO85cTMPXdm0j7G4?=
 =?us-ascii?Q?1KxwYz8/OEtiB7XjHlOSKLebVs/M3E7DgE7bcoUY+FN2iiLjOs7RjAUOsj3B?=
 =?us-ascii?Q?MpoJzMKfPYmzmM+HdE4cS64QAE9cTtVru241ygWo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0eea10-76e7-41a8-9d94-08db7309ecbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 10:17:46.6551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtR7oAZHzToGZ1gnVVVulCuUQPz/0FrgXLoOsVuEtWFOaElV22d3G3KSZloOxBnY3WaNtfzk5v1Lr8F8Mru+hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Sent: Thursday, June 22, 2023 8:12 AM
> To: Will Deacon <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>;
> Besar Wicaksono <bwicaksono@nvidia.com>; Suzuki K Poulose
> <suzuki.poulose@arm.com>; Mark Rutland <mark.rutland@arm.com>
> Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit writes
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Split the 64-bit register accesses if 64-bit access is not supported
> by the PMU.
>=20
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>

Thanks,
Besar

> ---
>  drivers/perf/arm_cspmu/arm_cspmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c
> b/drivers/perf/arm_cspmu/arm_cspmu.c
> index e2b7827c4563..0f517152cb4e 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -696,7 +696,10 @@ static void arm_cspmu_write_counter(struct
> perf_event *event, u64 val)
>         if (use_64b_counter_reg(cspmu)) {
>                 offset =3D counter_offset(sizeof(u64), event->hw.idx);
>=20
> -               writeq(val, cspmu->base1 + offset);
> +               if (cspmu->has_atomic_dword)
> +                       writeq(val, cspmu->base1 + offset);
> +               else
> +                       lo_hi_writeq(val, cspmu->base1 + offset);
>         } else {
>                 offset =3D counter_offset(sizeof(u32), event->hw.idx);
>=20
> --
> 2.40.1

