Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53A86E7886
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjDSLXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjDSLXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:23:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2399A5D0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgRru/iXgLupXwAyFS4exo1qnHq5vzde2vhXpk0XSbpiHQ3t7UdP376Jz9Qq+aTbx/SCeMLHp8sBYnYWQCteiiS2tOBmulPveWqXmA60TjirhqJj9t78qLAgIZSKJS0t/gJaUXLyFDlIlb++o62nDgcJa6IcY/RNQ2sPZn8KKNNGbTTsT4VN64bzE8o+exjnaBzLGW9zEAGEmEA40i7V+Ax6rru7YBTCnByfMYR13El+8DSa5YviBw+uAwUJf+EP5ChIPrLKfki+IpFPlwYBZ1h41QxwhKPC3B04nueUsa+7KeFjbG/Yv9R7LpswqnUy12Ldev9DuJah6z2X62h/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LR+9zje8XvKpoZ2MpuuQYQqDBhbytEjM1P2nPxcYLzY=;
 b=eAKXcsNTyMye6punECG56js71ZMF80ABtV9YMKG2Hm9JtUK1WMcK6Uof81yxRVSzn8HDqdoibVlwcu+zflsTiq4wQBEIPRxYPRgA9jk1IslW4ugjkObzE+HftBtSOFv+cilFG7LVDd9zS796oKDyDllwSBRAhyxXTSErPvOxkT6aY6g1PxzgKSLAuIpIsp0zuz6y132rhTz9NWoT8JaBbyUK+WOhYDsN49MDbxtQf//l5BiA6OtdA1VxrxzgcQuqeSBrQ98o6yptbXr50McpmqfjVRBhIc07GCWBx5QZjJtxacu9fJ4tIXkmQyy5YyCtpYspTQ7lmVJVci/NiIKpGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR+9zje8XvKpoZ2MpuuQYQqDBhbytEjM1P2nPxcYLzY=;
 b=gELsAhJS/X0wjAOAzrvjWk7sCbGMdhqELCPwzNsSgHVnnfFaTdxkHsZrpYA8tfvKlDl4B3vx5w3px2bTnPD8bLK1Won64orgv+ljdMD465uHw9U7vgIc4HO0nB4x4JlJxD9h2aOc2qpiIIxOB8GdizzqAPFldcEjDa2NbaA4cVM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 11:22:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 11:22:09 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "ben-linux@fluff.org" <ben-linux@fluff.org>,
        "Pierre.Gondois@arm.com" <Pierre.Gondois@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: kernel: smp: ignore disabled cpu node
Thread-Topic: [PATCH] arm64: kernel: smp: ignore disabled cpu node
Thread-Index: AQHZcqJM/EidvFAOA06YvdX6pirjA68yZsMAgAAWBQA=
Date:   Wed, 19 Apr 2023 11:22:09 +0000
Message-ID: <DU0PR04MB9417F83A1D487C6D447C73F888629@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230419094039.3140521-1-peng.fan@oss.nxp.com>
 <20230419100214.x6y6jgpvnupmgplr@bogus>
In-Reply-To: <20230419100214.x6y6jgpvnupmgplr@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8216:EE_
x-ms-office365-filtering-correlation-id: db005ebc-0586-45e2-f057-08db40c850d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CcMHhLjYmIaGx1VfDfvMp3fq8aMglJarxNecjJv+iBSQsAzJUQF1CLn2uI7Es2VRXUeY4Sxthb8ZnYCL/E4h9O6+9tloUFImx0BWATJCf2UwnXH+n3JUN/D/7ixf0UxRFPjnQ3Sr4D97B0YlxkVQ10V8mjlyQNbkeTHa9BtmrdrlZWdIHi5lGZr0YSKop/8Vbf7PzpEVC64FdaWtIdurhtQrTvTP7MYm2PhFd9DB+PckzsUgsIMJbbwcZCQMqXxNLFdoFavUBn9vCT0slm7MgO6R0pD2Rc1wdYdcgzy5YJscLKMUt9JWp8HxZNRg2qp6N+TGmRLerUMBdFgJAqbA8HiAbMnVF29ujzw55ZbO6UKVm/RAg+OT9P1eVMcWPGTFrIbCH7ZDf/JUsJelW2VJI0iQtXtEE1IoWp06mNMo+lpyPOmDLc/Sn9cAGovlSvjMcnacD4AtcsdtMN+DMySC0hZrHdKJYbfMc+7t67a/au4aAL7M+tvZOOcArRSGfAx77z15mE/Sk4g80QV6GbjXV0ueO47HDq0q25gdzzK3H21uCWsdYEmBaCAXCmm1MkHW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199021)(8936002)(5660300002)(8676002)(44832011)(52536014)(41300700001)(7416002)(66556008)(76116006)(4326008)(66446008)(2906002)(66476007)(64756008)(316002)(66946007)(54906003)(110136005)(86362001)(478600001)(45080400002)(7696005)(966005)(38100700002)(6506007)(9686003)(186003)(122000001)(71200400001)(55016003)(33656002)(38070700005)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Hc2DfCxeFuY8QXRF/M/7a7p70b2wSgN4YSLtq/wPQ/BDk4rIfOCIQ6YPtcj?=
 =?us-ascii?Q?MDMa4uTssvyeRL+4LJQxRYFYDOBoV3P5kLU5Gspr+sSbxEfaZ66FBIG3rZDH?=
 =?us-ascii?Q?2CzknhzR2KJnykD+Tb2JR5WQiwfHIIvajgCN/dPt1xk4IhYAxdh3vjugOUTO?=
 =?us-ascii?Q?jWKhiuaF2edxcCPAPK8MVXd3hy9+wBfaDGPmSXxCdPZ3v9atvjZ3SHBvGYpp?=
 =?us-ascii?Q?n+i1HhQLC8ELVNAupdcPuRGO+2LZxeEdRi4x90L0KpSZ0ft9cYy5HrtlA6KF?=
 =?us-ascii?Q?482ikVxKTj4iXi0nD1fyAxt7rLtBKFz1vM/G79lLDma61Yiph6/mp1ZMW6bX?=
 =?us-ascii?Q?dheEKHdnq1I4X0a9zmXu59UZUHzoi51RhNt06UQVCA3GfRUYtd18HbRkkTdC?=
 =?us-ascii?Q?nudoZaPZZXRoagPrMqyXLfcLAQStynjEC7sVRnDlYIIw0YXchXseYlpcGD2L?=
 =?us-ascii?Q?gc0YCQIxgfkNxaf63FEzzyuY+oGc4PtKje9a1yn/fx8QxsUkgfdMFU76JK4r?=
 =?us-ascii?Q?FN5anzPKUOWFxQoMesbEeCixzhaSX193yZhYkuyh+flJXDjDLqY2g5WnOQ5g?=
 =?us-ascii?Q?MJXG0aZPBuXBcNjdDfin7XvO4F+3JLQbNC3gmikD8MAWJhLFaQe+sFDscrfs?=
 =?us-ascii?Q?w8nri9ngbgwk2gZM2qtx6vmW/Jc7WUj5B573bjY1N7pjfr0/K9YkFnj0t0a+?=
 =?us-ascii?Q?mouTa2iwC03qlczkpDei84B8JJIwPgmc+sdGjlxYXCGubigaS6ZFDL7bi45h?=
 =?us-ascii?Q?kXq0mn9ivAgRcCrlS7u8K9XyFGVnkycSeop3APHmyAMEnYlhXFT71iyDOokl?=
 =?us-ascii?Q?6MT2Lh4OfO3fY+RIDFAjlv8DeV66pPuZko4mFGkKbpSLOPrj+rxwlbJo2Xo5?=
 =?us-ascii?Q?OGjXnfTEK0PQ22CJL2F39kos6SyXcu1GUrabtu0RuuPvFKx5KegfVqv2k6Kw?=
 =?us-ascii?Q?WWowwfGLhmJJiEwQkMympFmCbBaNmZai9KrWZu5dPLMRoCDijabZPvPvAIsg?=
 =?us-ascii?Q?ajZ7VAiCjGmYwINdGwpoiVanROPkk5VgPyG5Mau1fItBsORjELqnsVFct4s5?=
 =?us-ascii?Q?AdIJ86vc94oN69LBejIS3Xe17cQLSHK96EX5gUQN34c21vg8uHRsoEYa7y7U?=
 =?us-ascii?Q?h/oRHETvbfGpMWzVazwl/KJ77Cf5Ngq3iwc2GQsEQ9rY0T4x5bpcpV8+XyKm?=
 =?us-ascii?Q?ZjTplW2QwfpEGaudKFqnSphkaAxyq2TotgOzWOMeQobNjWjN2rSiVjTapV6p?=
 =?us-ascii?Q?KmPCmj5R1TRU6WHnUhfH4XB72D102eQZ4JTU1Cu5ooZlHXzFhCwICcGah8fs?=
 =?us-ascii?Q?O7m0ICM3yh/i+HA1R0jdmkqa/u9Eybx5jeKP+HTj95s0f8f/YFCCp8CNEtNp?=
 =?us-ascii?Q?FvvMFSnRccHhmhOvLibnjj5s0DHfovPB9qA1n8wlwaX0FJ8h2ToDCO/Ndvqo?=
 =?us-ascii?Q?ZKACG8NqPMB8YCmz4vRN6nIOC3STlLqtggVnf6HRRjAoh4lfP9lCBZ/aJlxM?=
 =?us-ascii?Q?20pznQnIA8/jlUaTyZAi72nagbV9x3xxsJK4ny+XB5oSW9MdFKG5+rT7Lpqn?=
 =?us-ascii?Q?2iN6LdJFu3AcRmP/tgY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db005ebc-0586-45e2-f057-08db40c850d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 11:22:09.6578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jCGHgr6dC/Ojrn6+PQlXxtJ2wtUsic9vkraFGeoQ7Y++zf0BPUrp+WtRLHNNg09OYj6PRSY6Fgoy4KLrhcWiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8216
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] arm64: kernel: smp: ignore disabled cpu node
>
> On Wed, Apr 19, 2023 at 05:40:39PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > If the cpu node is set disabled in device tree, we should ignore the
> > node. i.MX8MP has some variants, which have one or two or four A53
> cores.
> > The current imx8mp device tree use the full feature SoC. With such
> > device tree to bring the variant with one or two A53 cores will cause
> > issue.
> >
> > The firmware will update the status property, and kernel will check
> > the property before bring up the core.
> >
>
> IIRC it has been discussed in the past[1][2], has anything changed now ?

Ok, removing cpu nodes also means we need also runtime update
cooling devices node, and etc.

Thanks,
Peng.
>
> --
> Regards,
> Sudeep
>
> [1]
> http://lists.in/
> fradead.org%2Fpipermail%2Flinux-arm-kernel%2F2013-
> June%2F174324.html&data=3D05%7C01%7Cpeng.fan%40nxp.com%7Cf0e0d9c
> 8626b4ffd8ebe08db40bd29ec%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C638174953417504770%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
> 00%7C%7C%7C&sdata=3D4wUcFCMArXHGL%2BGu4gAkRFzrqITYvWfe2uyw9Wj
> n00w%3D&reserved=3D0
> [2]
> https://yhbt/.
> net%2Flore%2Fall%2F1524697712-20208-1-git-send-email-
> rokhanna%40nvidia.com%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7Cf
> 0e0d9c8626b4ffd8ebe08db40bd29ec%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C638174953417504770%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C3000%7C%7C%7C&sdata=3D773VoFqxDZJ2C8QLY6jn62HnOxTVxNkMk0pA
> G6nue44%3D&reserved=3D0
