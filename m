Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B12273630A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjFTFMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFTFMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:12:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B432A10D4;
        Mon, 19 Jun 2023 22:12:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKA7QHbqVNbvR8pQIGA9qLjLf3YZ/eq404HXprmFGhENjCO13UvDjqr45yH78K5S+YGZLe1HyEBUb5xPfdPPZkdrbRAXOPrxKoa6FujGMbIebXN6u9284MbzTaNhcfnXsPnjFFG1Kyg/yC2TqD8mAtZGdQkaJQlRR7E4Tmin6cOczIkk5/KISvDH3MoC4nMVxP46Rw3SMOyNUUKO9LtbyWVP0zwlciR1DDzea903nOv7vvRdMRH3OsRTKfKXZ1hjXjfRB2qT1bP/zVePbiZE5VFCOo4Yefo3mOtATINQAMfCFBosLKXV9t1HF/1L6TkPm93NMyvyW2hwLmuxFjw+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1VGdimn+O8Ux8wTfb9ncK5aZkGbxan05s4nsBMoUIM=;
 b=aBTR19Vu2cNVnrxUr9C66xqgw3KWjn+cHlLuPSnM+oFQ0mjMIFcGAUIZguL2Hh83NUWr+BMHy5jZRkMR9TWB6gOQtS7Sw+7us+mXPaLqFFDtJcQ0BGpPcAVRqqcXw02KAJkxbf+/OqMxd96fNHXEunrYcwvZ1+dmFwm3r528VbHEguc1VlSzH7xB6nr0MThN4/dqobPmTRigIOg5vLXbYipSe3pIfdfYCbVO6OplG2gb4/W+wY6hTfiwfeYDigPOZneQ6fB2CkDdo35i6dQnwBISQfFuQLkEKB57G2up63/pBlE3PD0hlc6OsfqdS93uTDxaGNq2yA9H6GyD/RWvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1VGdimn+O8Ux8wTfb9ncK5aZkGbxan05s4nsBMoUIM=;
 b=j/7x+vOYRerlsRhMtKCUdrEflCM/gO/VaB895ewxsAMxoh9lMW+glqHaGfE4JyR/iNJlavpBUKzuxGLJc/I0kmG51pKSIOTrGdGIOpsz1g1K9gus1OGYV/upUNw+5w5s7zNm+ARvvG9rO/tKnhUNbchjgLQiCXH0qf1WJIcJApyPmxDzTPo8JMB0coHy0zArEodAZlcn74kdZlOh3ui0J9gH7W+RlRqdMJoV/gHnvwefjDGtUCCLyDESThF6VvbbEPugy2YvR16zpSdqJ3pqavmi5TwXgKI/LGxutoZknBkXuE1kxWGY1GzzbKBvoBTnoyYkkLldF9rKBjKdEJIsCg==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 05:12:44 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::9a2d:7483:7e1a:5bbd]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::9a2d:7483:7e1a:5bbd%6]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 05:12:44 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit
 writes
Thread-Topic: [PATCH v3 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit
 writes
Thread-Index: AQHZmRqjP1qCOJ9kPk+GTjwAXRrjIq+TNiOQ
Date:   Tue, 20 Jun 2023 05:12:43 +0000
Message-ID: <SJ0PR12MB567659A4B500A2E3FD004452A05CA@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20230607083139.3498788-1-ilkka@os.amperecomputing.com>
 <20230607083139.3498788-2-ilkka@os.amperecomputing.com>
In-Reply-To: <20230607083139.3498788-2-ilkka@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|MN2PR12MB4342:EE_
x-ms-office365-filtering-correlation-id: 8d8b7179-fc90-43e1-abf1-08db714cfa9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9aSbz1ntgKtMDq9Op8fMYPvdEL6shSXc+LhKm3Td7hDz2K+piIfc7Ntj7BoaKYpKZXOK3vO3jnPlUZ+PVPPtLzcud0PlctazYOskd5tXi2NFVvtHAq5hj9LJ8wqrUlv8EN3r5fvcDbV0XV1Et37hKugptmdcyJhBINOtFj6yueua3Tn4zadmcG13re2N8WWNbnZdNo7xyhS5Kt7+SIG4cEEEZaeh1c6xYf7EIaWNqUrXxtH4TLTBEwD06H4bmImHiYJqUM9m+M7BF2p6p/dWgg8GFToHGHV3KjqGP4c7bS3gVoHWBwL6i2CaW7McRYVVMGCMi8T0nLfcby5RkqM25P/OO2Q0XB/kcjvyzO0+wxBXPaM/W2nYrdddRXU3s3StZqcAA5PlmzwRa7+mwQlGL524OkCkndDSU8GZFmU+yBhOiZHy1/+gwBJTu02PLmhlPgIiHPmh5U3LCZFhxzU3dK68rFhSBwlMtdDzCcXLvfv4F3arhYsG8CrV3TwLPoCv1Ta1B7rfF+kgPG4U/tCHluFOQeAmkwrFkk0bCf7dFy0qLbSXIYMLAnat56Mv3dY+WFUYDAjjAMJm8tqLWoK2FqiDISSY1TAUuB6NtL49DMB/AHGvnfFoT2gGjhpuOGC0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(186003)(38070700005)(9686003)(26005)(53546011)(6506007)(55016003)(83380400001)(38100700002)(122000001)(33656002)(478600001)(4326008)(41300700001)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(8676002)(52536014)(316002)(110136005)(54906003)(8936002)(7696005)(86362001)(71200400001)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hPHwyvN0ubQO2UYW+gYjpsMGcI3DfWGwMUWKS4fYo1X6bluDbq5XXSFlhamP?=
 =?us-ascii?Q?WanqyuWRR2CBf/lVpYh0BanFlOHb8SW2RIi6Fx37v+j2dpZdogQYk1BQiELi?=
 =?us-ascii?Q?NYJUshEyp7937/9NGJp5fj3Wp3u+YnpCNXWJbVhJI7CUeZATSGhhqhopVXpz?=
 =?us-ascii?Q?SuhHk76+phlbA7uF0zSQMD3XOwHeRtfgEzt4JQrb8l/aHrsuo0MlMWM4jnmR?=
 =?us-ascii?Q?0QKu9bLN+lhfCtUk96thyROqcvhxjq7/XefwsKRHh/7554pq0yXlDJrgUAQg?=
 =?us-ascii?Q?YxaHZv886k7uHg6isNwS2Ns/D5vEnzsmglA0+GYVkCXxAXq67/mEpqrJ9009?=
 =?us-ascii?Q?4UXUWxQXMkhi2RQWZ+0mAOuuxmOWwNSQff6qFjngRv1nBCVeHj4eD4r40w0N?=
 =?us-ascii?Q?eeby9cQdyHtdgDkLukro9InqpU+TwUSLrYwDqtSxjvAGYLhePOH59MD9Bkmg?=
 =?us-ascii?Q?+Z2NYjH1xHhbPnU7kMCC2JA9uhyA6TYh/BJ9G73hYhh+4eT1XyhIBixABEBS?=
 =?us-ascii?Q?uBn4sM1J+NJPUzz5NOHYckcwCFG4BpmfPOyvQuxja4K+SthstT8f/gI7DEEF?=
 =?us-ascii?Q?ruk7VVr/EIlhQ/T4fPdEDkwptXPfSJzGdltBldTc0Qyiwr9lciCxkjdILqBP?=
 =?us-ascii?Q?AZeuEjG7Xi7KRmD/25T15LeFOLEkNMw+2w1pOJnQA2OtR/V12hsOKmIr1kCm?=
 =?us-ascii?Q?g9EWl/tlOArv3lq+MkySg28Ggs8VspQSCRcBOA75wzI3EMp66upLsfCyd3G8?=
 =?us-ascii?Q?5cXvaOvzkT57ycSsOTLgaPIf0SXNcX2tY8/wJUKAXow5mva4IwkcO0mUunPK?=
 =?us-ascii?Q?+Zn6rKWfyHHQ9pAQnxe1dKsJfzppsjLqXnWY6qYC4422eWCzjGm5w8NWSqwX?=
 =?us-ascii?Q?I5eMdg2pD3XCE94gkZUm3PQQlEcFjNTMhL9N4kERSzs2lqJQYgUw3QOg1K+1?=
 =?us-ascii?Q?gJOvWNAJPXx/AJpVw70fvdGH/udepowuckdwjh29xsCVwIR0eKP+A/vVdjTX?=
 =?us-ascii?Q?e2iR1mWYWvPCj/TDtlGTGNOzzft015ZOCZHLDp5fQ/egiJ8hrtB01F4MVGZh?=
 =?us-ascii?Q?8qeIBoTPyUsRiex+QZAgLqSVJzzXyT+wFJuYH1nRgnx73eDlQ2AXSgTWWQbm?=
 =?us-ascii?Q?MY5YBaVX1moDb7Ne8DUswKCD4ug0/Mh3N+W07XI3Ni+g8hs7BTrv2lVY//dD?=
 =?us-ascii?Q?UyMB+a0bmVEqmNkl5za4mhcbLR7oj+n+POqLtnvdPFNP4jHB5mPeKpCv21Cw?=
 =?us-ascii?Q?X24B/K8qrRzV2Bi4eGFmsu+/l/DMYVAwMa91e/drUvwbm6YiK2s2qs2o3A1f?=
 =?us-ascii?Q?yjgN95eWKBxZWfs3HBis/oTHpToRfcvIexQztJEyBI0V/MHHs/7W37eMo7EU?=
 =?us-ascii?Q?ud/1+XJl7V6z2YgYr9LMFZQMg765GnTlMQkLNXqZbaHAv0nebDJvqlLqsLd9?=
 =?us-ascii?Q?3pulh6tMgZEEWeFh5bj1saajodyK3v54fu0eOxfA7tlq++h69dj3Mdw6yGvJ?=
 =?us-ascii?Q?kHFC847Cd2lzDlLdgHD4Fok/x+N7rx29KPyHZSWt4wBJpN4r8GdnvlUBCaZS?=
 =?us-ascii?Q?Iym/dSSWfqDuEouuFRYwxySF95sDSrNNlWuvy3bm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8b7179-fc90-43e1-abf1-08db714cfa9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 05:12:43.8680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZSslg9u0ltYczceFItafxqb4w+N2ng5Qm3yN88ZV6c1G6JZCxi8WlvI+wfFxKUXYCqxF8xBPVDWceVybjV9uiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Sent: Wednesday, June 7, 2023 3:32 PM
> To: Jonathan Corbet <corbet@lwn.net>; Will Deacon <will@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; Besar Wicaksono
> <bwicaksono@nvidia.com>; Suzuki K Poulose <suzuki.poulose@arm.com>;
> Robin Murphy <robin.murphy@arm.com>
> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Subject: [PATCH v3 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit wri=
tes
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Split the 64-bit register accesses if 64-bit access is not supported
> by the PMU.
>=20
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  drivers/perf/arm_cspmu/arm_cspmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c
> b/drivers/perf/arm_cspmu/arm_cspmu.c
> index a3f1c410b417..f8b4a149eb88 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -702,7 +702,10 @@ static void arm_cspmu_write_counter(struct
> perf_event *event, u64 val)
>         if (use_64b_counter_reg(cspmu)) {
>                 offset =3D counter_offset(sizeof(u64), event->hw.idx);
>=20
> -               writeq(val, cspmu->base1 + offset);
> +               if (supports_64bit_atomics(cspmu))

Looks good to me, but this function was recently replaced by
arm_cspmu::has_atomic_dword. Please rebase the patch.

Thanks,
Besar

> +                       writeq(val, cspmu->base1 + offset);
> +               else
> +                       lo_hi_writeq(val, cspmu->base1 + offset);
>         } else {
>                 offset =3D counter_offset(sizeof(u32), event->hw.idx);
>=20
> --
> 2.40.1

