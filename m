Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AF9650B43
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiLSMQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiLSMQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:16:25 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63018E4A;
        Mon, 19 Dec 2022 04:16:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRCSvrXIhlXEaIEOKtV5iVXC2i6Zf3ClYIopOpSjRjHmXGCqQeNIyeC2U60Xwo85w8nXZ5uzIXUeCgMzQVTxl00sO9EGuMWhAhD1ZeBeA67xZgLgWAJb7T4/p39Wwp9OCRk0qwgp2nOyzfm/YqtM1JRn3f9X48jTtuqlLPhusLWemdLFu7zScjC5CG/PU/81SmWtvxTGtVGhSx/JqX32D/e6UrOfbvLvaQi3szdDxHX+wf5t3EygASy4TiKDds9sF3cIKmy3SITs7hy7F3GnF7FCs5FTXrtW8cNDbVO/ZSG7JOp4m8GlD0/5Bpwvr9de3ArjaGNHwdqh9sPpjyiyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STyyCqE6/eoNjeJCenG5ppoJ7nRGOlDWfvsmqgYhQA4=;
 b=Z5yoecMqp4jeLtJeFRkjBAidZajmYsc0TlaaaOgpXBCzItuM64zm2LevOkmDfrENm69zFmJv/9DC43wJ6ktGkjCjRj1DWVR7oyP/c3sjlR1KQ2khL238qMohLOzGHKDqeld5IYtztOEsePRH0ePWrBltpDILNm4J2hd064Ar1uccpVGpmiIWYT+YRL8+sep+2Ws9oZzVwpLOjV0ZnE1o2Uxyj/uT1/aO7KGNa3Bs8fWVkUVtQJ3N6FSLOqidcrf8w0qYFCqOxjJ+2Ri8WtoYJrfYDVUttNieLp48bPePH3ZkwwJJrKc3AgzLQsLAezlZeUL/sxquOct9ooYnBmdYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STyyCqE6/eoNjeJCenG5ppoJ7nRGOlDWfvsmqgYhQA4=;
 b=HLPIarcJ3GLJ8mTE4FJGFzDSX2U+EF/h3k17zx/z2NnPrdW78jZXFvA7KN9ESsAOxHwTW0qzYSwsikSoLu/dhVmxY0QsaRSVHnB/L/2MWYVP3nV7EJcfLJKluUAxrpmQWa+uemkLoAJvjtmu6JxdmwLUmxjEkNLAt/FnCO0FmCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AS8PR04MB8054.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 12:16:21 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::7c13:ef9:b52f:47d8]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::7c13:ef9:b52f:47d8%6]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 12:16:21 +0000
Date:   Mon, 19 Dec 2022 14:16:18 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     devicetree@vger.kernel.org, iommu@lists.linux.dev,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: Re: [RFC PATCH] arm64: dts: ls1028a: mark ARM SMMU as DMA coherent
Message-ID: <20221219121618.z3dcyob542cnmdnk@skbuf>
References: <20221208151514.3840720-1-vladimir.oltean@nxp.com>
 <2a188b8a-ab16-d5d4-ed5f-f8eec236e4ca@arm.com>
 <20221214165356.6tbzmfyoifqt4cwk@skbuf>
 <3f3112e4-65ff-105d-8cd7-60495ec9054a@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f3112e4-65ff-105d-8cd7-60495ec9054a@arm.com>
X-ClientProxiedBy: AS4PR09CA0022.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::14) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5136:EE_|AS8PR04MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: bca004ba-c872-4b7f-7134-08dae1bad727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BG7XHB7S44lOkzu5cHvLz6wU3+g9MqZmpSsHQaoQ7BuciEDyLwVpUOFPiByMzeTz5mHQTrsq9AjndzysRuUyr1mFLKC5L7msu0Ru0Xu+Q9J9lv+R4s7JpPlov/8fmpahLZQTp3H3F5GOd4QkiJRITiJTcZBV7yElFZVzTzIrrhcGb2PTxSu0xwlKkIMcnKdlmunnHHJgNKolxozjjFiO++oxEFDj8a9zXaLWL2xldsTpLV/NKLmhpXGNz10Waj0LZxAeDbdh5xUG9dfdQbaivmlq6RFCc9v8+Oj2BvtaY+Qn1xkBGg/jI+I+BXIVNA/4Ep5i3vVnI55xEsSxdmzZfqIZyTdeJi6pD/TG3p04espsp3JP20YZwOCjacyvXTlUwAJjnqXSL0w+0JyBJSw1sF50fCpltgF4G0gYtCKZUxgSSRAwvxLdyAoVE6fd0tug4Wkf3BhCNiCn+bFjyoDJKk2UZ4aWJXZarO+IAMnigH/bo//8Vl1C7jjRGS5aJ6yPeHqY9+i+Fyouf0WvE9gRyBwWojOTsvwvDy3WG9OYVa5j5nKHZppW8yL4JgmhTK64oz/x7cy283G1QiwiqhaAT1YUlDwhp/fXyqQE00wCZZE1aGLrQLfeyc3HUjXXbfkjEd4RtKvFAVK+IIt4OEU0HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199015)(86362001)(38100700002)(6666004)(26005)(9686003)(6512007)(2906002)(186003)(6506007)(478600001)(6486002)(6916009)(316002)(8936002)(54906003)(66946007)(66476007)(66556008)(4326008)(33716001)(44832011)(41300700001)(8676002)(5660300002)(83380400001)(1076003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TKuA/lFB+j+Tah9SRljbdo3bBnM0qje4dmZQ79TcWv1YFBOYbqUqjYrFqIFZ?=
 =?us-ascii?Q?2QMoRDlxRBgFIsnB0AODptRuqvL+wrakoPg18tR0Hp80tjIse+Vtw8ZApehi?=
 =?us-ascii?Q?CgKlAGgwVxe2fIrqZVH/qH13sF7LVDlUy8uNihrkbfOrsC9y1x12BjDt+feT?=
 =?us-ascii?Q?nzPremR0rV0WsKRfEawEQlpMTml/+CjjqasX3dXrZePMvOADOins6xRWwo5Q?=
 =?us-ascii?Q?Z09r3KMVlXABtVo8L/bvP09KRHtICMvEby4RS1cFRAC6+rkbLvFDmDMkw2D/?=
 =?us-ascii?Q?otmyjtphABo18fa6CsXNhkwyNkFzTs9utm1DrNl9OJ79u932dWr5BYTnWdAE?=
 =?us-ascii?Q?A/tgc/2+v4W/vDJxs93cDpA8iziFmZV30ec13dXpbthHiR78t+2GuK9fDSr5?=
 =?us-ascii?Q?vHKaVmT9Nb+STUIRFV61lZXWfbYbB0v4WhYSX3iT2kr2oAJpqAbxF5xYlhRW?=
 =?us-ascii?Q?yIaI0tD4GLx4yKL5m1ijFNKFAwDDajsV9nJ85j9qyCA98kR5AoUDPDl3ZJE6?=
 =?us-ascii?Q?oCCVD/fvZ7qlt5rIOi9dVFOxAbfsSqh8dWES6KGhTjlLzUWjE8eoTMtVxDGt?=
 =?us-ascii?Q?ZQZYkJp0GcpNaW1W3lPpLD9JWrD6oYitqKgUcX2DHZF37n3G0sc/06RMG9MH?=
 =?us-ascii?Q?s+SvDLO/SuCbEaOFj96BFyl7OcqJvfCo0M8Lh3hZN9q1A7jbiqLo6tkiXkIb?=
 =?us-ascii?Q?c3CuOFbK1V/amKukQpPo1RzQ/knJdvS543eidBh7cHIyWkbDchjHFqk7IhUY?=
 =?us-ascii?Q?iIiqfUzPejBIGogPdM7TFSnr7GOAUUHj2Gk/JFp5d96vqjv93Kubqk31abib?=
 =?us-ascii?Q?rrSVTyY7ZHYg/JDTefQiN6mFD1Cb0TgpfWq9aG9aTJlCskL5o6Lv6Y6d+/7A?=
 =?us-ascii?Q?9DNEvwi2fprvA3dK3yCPvHJUdjNXj6eTNAPJcjtouLagrlpxEtx6bTUTDU6Z?=
 =?us-ascii?Q?f2P4C6umUu1Vxl+HvhMoLANRn4ymP7fDBmlbZhAeKLNwUmmgqJfRAB4AgBd3?=
 =?us-ascii?Q?6d5PosVVcqwIiAmKcsYC4gt3DA2Qh0v61l3IHDe8qJCvypoNWVV8Og2qgeGK?=
 =?us-ascii?Q?Ejser57MrT31gBzJvNUnQHMpYgjQHB05Y6R2ARKuVaaBGVinC/59tApfhQFE?=
 =?us-ascii?Q?g8bQ9hd2bD2senhVzhZIFAIacXDPvdXEsmCTPdz/FGj8NBdtAgPAKhU5si5q?=
 =?us-ascii?Q?uYlO8xhcJZgAZ5lVjO+5ZcKQyEhs3JFgaXyUN/PmIZPVP03mC3W5XzStMlOn?=
 =?us-ascii?Q?VVsmWDpmGQMvrhD28aBMCMjCT5+2AunzxRFCTDVNroocQsYbc2bwKGom6XUW?=
 =?us-ascii?Q?1dVnx7IwOB24nEPD+jndAVZMHQjH6XJtLF5eNcZWXl8un7Nxuw6aebi6htje?=
 =?us-ascii?Q?sdVH+YOeADNRsMDjBV8KsdfUpyrBBLX2gcOKecsDG7wkba0lwGtOXxE+L4Gk?=
 =?us-ascii?Q?tgqHlmAwBa+u1FA9/3ZQjpCWptp6RlgQETCv0htf6K2vaBVPVewgXurFKe3s?=
 =?us-ascii?Q?DxMl0J51BhAtN6mMa2uXDX7BIGCfMq2O8W/gUnAAsaIXmCDlZXgUz/06lRZN?=
 =?us-ascii?Q?06MszOOcaqBFXR1sHasxM/jtaMzhHMMj07NBHHPVANhj8PlD4ToAV0wJi08F?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca004ba-c872-4b7f-7134-08dae1bad727
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 12:16:21.7761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XshcokpHHQU1T2BzCE9QOf3vM0PDOP9TjTVzJ+lCg3YliKUYSBt9Y00sytaaFy+UMXGrKKkguUP8HuMF9tIYiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Dec 14, 2022 at 08:33:10PM +0000, Robin Murphy wrote:
> > Does looking at the CTTW bit make any sense for MMU-500?
> 
> In general, yes. The result above does imply that NXP have inadvertently set
> cfg_cttw wrong. For the avoidance of doubt, here's another MMU-500 showing
> SMMU_IDR0.CTTW set:
> 
> [    3.014972] arm-smmu arm-smmu.0.auto: probing hardware configuration...
> [    3.014974] arm-smmu arm-smmu.0.auto: SMMUv2 with:
> [    3.014976] arm-smmu arm-smmu.0.auto:        stage 2 translation
> [    3.014977] arm-smmu arm-smmu.0.auto:        coherent table walk
> [    3.014979] arm-smmu arm-smmu.0.auto:        stream matching with 128 register groups
> [    3.014981] arm-smmu arm-smmu.0.auto:        128 context banks (128 stage-2 only)
> [    3.014984] arm-smmu arm-smmu.0.auto:        Supported page sizes: 0x60211000
> [    3.014986] arm-smmu arm-smmu.0.auto:        Stage-2: 48-bit IPA -> 48-bit PA

Thanks for the explanations and the patch you've sent separately.

I have a side question, why is the dev_name() of your SMMU set to
"arm-smmu.0.auto" (determined by PLATFORM_DEVID_AUTO if I'm not mistaken)?
I'm asking because I would like to study the mechanism through which
your SMMU platform device get probed, to make sure that it's not
possible, during shutdown, for both platform_driver :: shutdown()
and platform_driver :: remove() methods to get called by the driver core.
This is generally not disallowed, and even possible if the entity who
registers these platform devices has its ->shutdown() method pointing
at ->remove().
