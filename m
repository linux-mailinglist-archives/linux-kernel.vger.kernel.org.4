Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF832725DEE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjFGMDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjFGMDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:03:51 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5450619BF;
        Wed,  7 Jun 2023 05:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzMnTGWZ+MVSZbP2DehGRR2MgmNwj+Yi/ljhJpKxy6h0ZNb7pP/5v/pEkd3vQSp2I5357WZ77D5IAicNAotgbCbsoWZVzBY8K7ViE4ibfcrF8nCzChwX75WvpBn/eCwm/RtlzMG+/r2JWeUV2hyI4vSdZU6e5a40xmuQdDPAUhCE9Iymf4vH513MB+cvhMEJif4ZWp9mhfC/gmlmdGxNztQnb7U1qzNCc/4YSX0ybrSe6WeOvM7ywMJtxdkCFHy4cnM9XXs17U8bKXsCpyqk+ohYJipzE41sdmyBEs5nWSBfjABKJYs9UhyXAJTJ7Evf5LVS2txVDFXgybCwBPeGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWxIlF5RU/NMGlL98tlfSK4bMftavk0c5PQDihu5VS8=;
 b=f+bRQEDpbx06C6v8SYkxOoFbjWrsVH5Zrss8hcjrXY46LvbQCfG5plhZzUJ/bWdd8o1RLTzspg90DtuYfUACAy77RjbFrfc/7RjKH6q/UABiRlFEqtPd0Oxoco/oQF4BN91wplZFIT6wR/fqN7/Dm2aRfPyrLFggNR6NYQLbO6yQWoDxQbSmJ01esW1/aUkLHHF+0f/einOUFjhhoCXPq2PWqt4HN37c9MMgHM9EiJK8j7zZtrtos8rSoX7CV51E2f6SnUIeiIWJX3QLlD1krhK8RUX9eMbJ6W41HEhaL6PeSI+BcSvThfxgsdzG+SBjZI4khcaWU/NqZWAm+Oaosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWxIlF5RU/NMGlL98tlfSK4bMftavk0c5PQDihu5VS8=;
 b=kSJF9j0iLLgivIvUZo+IRcHMihVH6N4itzh6SoceHDdOQhDFVda2Qe2vpnGCbHPPwB9JQVL1prwhQlPuoxGsElBOUU4umwfEwIt2NTkROZDm9pdwNnlvS4rORQ61hNG5d+9bWWQzHweHZRRCJokTJUFL91B/tM5Ht1gruuDWyOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 12:03:47 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 12:03:47 +0000
Date:   Wed, 7 Jun 2023 15:03:44 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Vladimir Oltean <olteanv@gmail.com>, linux-kernel@vger.kernel.org,
        Lisa Chen <minjie.chen@geekplus.com>
Subject: Re: [PATCH] spi: fsl-dspi: avoid SCK glitches with continuous
 transfers
Message-ID: <20230607120344.ui2ubzdkb6cbjm5o@skbuf>
References: <20230529223402.1199503-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529223402.1199503-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB8677:EE_
X-MS-Office365-Filtering-Correlation-Id: abbf311e-fbdd-45a1-bc2b-08db674f3fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PURQeh5hUJfqYGUiBqW6ZzTFSXsrHvv0qOyn1T6ipOGFcPANVKvWVtLCQHvE0EAgbgGVqMPxQhG1viab+O8eEn4NrsCCq+ofRSlRL3Sf8/ComGkn3F2jAdchAFuNvYcVNK7JRZ8ICRMgIBcpwyrYF4IBxJHElO9WrXQW2Qccm3LYLsAJcEw7zIVg4Y6jZOmt+2USs1xjd/nySkqqtfeDQZ+axcldOR/GF98Q4kSIDSyVGv1Sdlfg6pCT+urC+sLjVKJsAH6A1uumMZ01W7wnx6+3AKUWFbsK8mqKcMJkDzD9dFEvIRLHFB8I9ZH0lOrFaH4qDI7VHtHNJAuKILG4tbSbeDVbs0Q5v1Q3i5pvAHcuF5IuyCYXfIc0lCWoTV3T7JajHrew3dtwBXyUkKzYzL6uT6xT0gIvHqbakxog6YrMlpsG36NFkp0BrOU2NZQcTEX7O3F/hmQHrdl+/Rj0pqAgHXQfxM938wiO9KL6BmDAIIIf4cZm8vbbM8CmpOsdzAZInllImB9/324HRv0RHT8ptYfkBZpFMGhDwLPmPYRcaXbV3nPPndGwbZkOAUJy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(54906003)(478600001)(8676002)(5660300002)(44832011)(8936002)(33716001)(86362001)(4744005)(2906002)(66476007)(66946007)(66556008)(4326008)(316002)(38100700002)(41300700001)(26005)(186003)(9686003)(6486002)(6666004)(6506007)(6512007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+u/7DNGhfgXBihbBpt3+angrIfVEeV9Nqlk4SiiId7/7I2B9G4HpKSi4Y6m3?=
 =?us-ascii?Q?GgsCCwCFUhgcOSIYxQl2y04DAcY9lsWNNG6G0CvQui7eN3FOJEH1Iy6D2yrM?=
 =?us-ascii?Q?pN2muS8pDxMj0XOZDKm7mbwZvK08Oq1t9rTqa0rNHHbUooodgLlj86bSLz/e?=
 =?us-ascii?Q?Jro7ekDnmEhBh7mQgW0k9cg0MCHoL9jMl4j1vBC6MBUqj/ofpaNivOC21UL2?=
 =?us-ascii?Q?xqSLjHobJJ6Wzs5T4gQrub/uJvzimbulrD2BnnZ/yQLkkqrUmuEU0TBpSi6K?=
 =?us-ascii?Q?hjWTTGag4BHNVIYlOEHQ7b3187uRLdUPpR+v8T+QuPchJNUFhcKUxmL0DXSL?=
 =?us-ascii?Q?XVjjhRGe0MnTBK0TNCY9ci2xxECsSdbhkTkGSiePAllQeBX5J+Otnt7LzZmn?=
 =?us-ascii?Q?JEIhqh0rXQj4AKRxINEplUDLVtMQQnRNysrc8sEyacKJXngp/XKa/QuhezpI?=
 =?us-ascii?Q?jwZaivoA83pZapX8lvi08qNrKG3xuTojkkwbKwMXOKlEv0nJ0flWZ50hK5cS?=
 =?us-ascii?Q?1873LGym6f1PnVwbLOP3VgDUd/kXmrdYmddeyBdVtdr+VMd0siHqGM+QyuNv?=
 =?us-ascii?Q?z8HH/AJeP+mfLt0gg9wWST2geLTbRsWRLIzKNQ+BkmW4DEFrOzyvpGu9yyAW?=
 =?us-ascii?Q?vHS1nMuMJKEL47cpdZct7a1dTLKB6UT25ePAJBxIfZmlmuFHZdo4rqc8LQmH?=
 =?us-ascii?Q?1sHjhtLNoKJvLjq5ssIufXuSFeSNxZY+DrOk3lX6zRH4txkR0dNPiA65fcER?=
 =?us-ascii?Q?PRzPeSrlQFC2/A7MJ8RWrYaxxLW0BnHf6hYoP+nTLQLPvfFj4O8TsSiRlFRh?=
 =?us-ascii?Q?5ziuhfOXAe06rYMSdhzfIyPX/jX0nayK+5Mivz1Jv/2n8XScbYrxvC8Hr4in?=
 =?us-ascii?Q?5yVUglTeupQrDGV/FgrceJJQy/PIKjmOWasE16SUCoo7G7W741LuZUsZbCgT?=
 =?us-ascii?Q?iYGJBHVbpcP/uBIDl2Zq03vgNgdoellKBHkfCUhnEMyVWmPvNledijEGvcgt?=
 =?us-ascii?Q?SaceyAVb553iiSYfMhdAy0K8yd+/HDzmyOQQdayWOq3qD9lWVGDVK5FhjqNf?=
 =?us-ascii?Q?oSPWEwWRVRZPF6sxe2lo655BZmzoXFj6FhgpM5uskyOhmxLrtN/9nPMUt4Q+?=
 =?us-ascii?Q?NPDGXDIFrwzRtoWPddSAc5iTw64ZZOgxlE+2p35WqQjC49suinOBuVPOkLdY?=
 =?us-ascii?Q?2mzrDVupMJDeM1QI6ivDBHoPXvznFTPzI92xusCUNwadTcGNelQ/2PMcbIQ3?=
 =?us-ascii?Q?n7wDxd2p9YczKuETa9806kzKE/4FF0SigY0gfDJlup2ubG707RgUjS843MVw?=
 =?us-ascii?Q?dgKzYeC7uIKqrvFlmxQuHJDRZiuWfV+PjXrxTtnCE2Ye6kj5/3/8TZxHR87t?=
 =?us-ascii?Q?UJgMQbPFvxb3m9vhevEbTs3nlpzRnr2OJYRXuuioQfkH9pfUEzlL6SLRVIkc?=
 =?us-ascii?Q?mqgdZdPTLt9tUAmWKdzui0HR8C6DDvZRWrXunQ3TCgisEloNqxznTR4tcd3A?=
 =?us-ascii?Q?EqIB4opGVDHVd2FY2xLr0XvM6dL+fCJwvyTdRjrbnjFvqNo5mfjEIrl6be4+?=
 =?us-ascii?Q?Ern5PDVi7S7YbLV6G0ISLQ/YyzM+QuKky4ftwnecL2YTKU0o07dh9q83OT3+?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbf311e-fbdd-45a1-bc2b-08db674f3fa4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:03:47.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuaeEQpXQBNjP5jbj0dTEfa8Tmvw2Bckm9LFxb6h5LYJAlWVTp2h5WVZ9Cd6nzab/3m59stJo1MbDq4djfU9RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8677
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, May 30, 2023 at 01:34:02AM +0300, Vladimir Oltean wrote:
> In other words, the default values (of 0 and 0 ns) result in SCK
> glitches where the SCK transition to the idle state, as well as the SCK
> transition from the idle state, will have no delay in between, and it
> may appear that a SCK cycle has simply gone missing. The resulting
> timing violation might cause data corruption in many peripherals, as
> their chip select is asserted.

I know you don't appreciate content-free pings, but is this patch on
your radar?

Thanks,
Vladimir
