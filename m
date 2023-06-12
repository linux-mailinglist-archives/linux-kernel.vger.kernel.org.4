Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FDB72CEC2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbjFLSxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFLSxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:53:42 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2071.outbound.protection.outlook.com [40.107.14.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EB5189;
        Mon, 12 Jun 2023 11:53:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djxOk+LFu9joxFBkycqjiYIwCgugWNj/1jwqUFRfjzXNTzW5DgnhAmehwtBAYZe+F28IRihUSOkxka/OV9sPYcYGUdVk75ZJ0zQlgXiqfkxToWr8xZlAcOhYfy1SYkDRNaS0vwqZR3cEcwCNzQws/cK06H9oouk/FjUPwjL5E0eLRXg5Mbk7vfoA8BMxb8bIzhPXtddDDjB0rBBsR85mwECZJutNhLfsa/jx7s+nShvnmGUsJGtfCbJq2odJhq6iXJARDvxllQFcijBR+hKQMt3VyCpxaR336qfpxfqQOVrE0sq0t4oSl8JhfNONXXaL3/xu8yybDIBWHWJDTWJdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wtJp4XEZ4EAp7QNn3nwHulj1PV0ahNAGEuPN3tbq3o=;
 b=Z8l42W66wN2NnvUNVQfGp4eVZ9GvyF3nQ6asMFRttpgOXRAKcykO8FzSGBh+/MKZUchW2b84smMd+3is4ATsxWhvmY8mS021OoKFFQZHLrd0lMcRggaWkOvWPvHwFtzDMcJ+2zv1X2rr4bMlmUQoPkxXaYWGK6KoDyTwRMVyCoYh6gn6KCkV0i/86FCy2WL8S67NbwpjKl/w+cpTOWo0mS4on0SUD7YtoAr3mAtX1Kft8p/ysmzgZytzXsQ58ybYdsPyPQmXtD0vhyn14wm0vzRoWBegtPQ29aSBRqaB6nhsD0Th1gpt+OUOaAFXf+nf+A3KPSs44GhlFwkIKxYtRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wtJp4XEZ4EAp7QNn3nwHulj1PV0ahNAGEuPN3tbq3o=;
 b=erPsANrgsif7EtRymn/sh3BhgCGukqDQiC4w8fFfWlSTrW2JQSoXuzdRydXWbGTdJD6q8MoMTzN4SQsM/OS6IHAijz6d9hPhVdVLvJAoGvojyd8rNgIH37Zcnj0JfOFm6Pc0+uu4ZF7HB2Tk9qyc3lt4FX8nIcro1JiEsDAcyb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8408.eurprd04.prod.outlook.com (2603:10a6:102:1c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 18:53:37 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 18:53:37 +0000
Date:   Mon, 12 Jun 2023 14:53:23 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: Add coresight trace components
Message-ID: <ZIdpo8UOg+d61xP6@lizhi-Precision-Tower-5810>
References: <20230505195151.1874071-1-Frank.Li@nxp.com>
 <2229161.iZASKD2KPV@steina-w>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2229161.iZASKD2KPV@steina-w>
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f72b102-0898-45c6-5470-08db6b765456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8xEr51RaJVa1fSGvIb19lh/g5cuyx+g9QOfNFKQNPjXorCcv2aoTYhs2fTOLwWqcFFRXK1WrIOtsn0+PtQRmD4dYEdDf/a+IrFCDl8Sb5ghkEJ2t2EkKMmQvS71B9ydJ55KXIxhzkrbZlf3CH1EvsCxdMcks/1PK8iQxQwT6w+H3X308f/Ki/++qG4im/JUBV8kjVRaaKpl9W02QyF9JmueVTajs9aWKcy3tDuiAzRayRadXhs8wyLe1BBpDIupP8g0zLRJQ6taJfIO+0pdagJe3FKixnANTrNkkI/Cjw+HB3A0193hS2nJgwawEKl8jef0Sg753CQ6A0LWHyFUe/qfa4j5toho3dfXnwxHlifDBP3bLCRqG72dHyo41Cdl4SHYxTrkoH8gf9yiwaPy0a2xJ85Wg0zn99/ZRqH5r6DOVxQg6hBVORrT3n2vsx98E0iSnpzbo0IVFUcoYkf/sHehCZe1FCUE9GFd2Rz7e4I+cVnjW9sMm4SW+OzJJ291l8jM6g45DaLscH7g8/QAYxA+mdW9wobu2O031Q3cJZu2tVHE/4IweVQaxN/0h8I/Wlfy67dzsiFn4K1VUdA8Ocn8lS4lprpUkmXISW/VQEVfCxOi8R5ON29UWOEcZKyJvDGTtZVKDnBFSiMAisVwfdlv8AVpS76/ZJOBdVtq/wA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199021)(86362001)(7416002)(6486002)(316002)(8676002)(33716001)(41300700001)(83380400001)(5660300002)(26005)(6512007)(38350700002)(52116002)(38100700002)(6506007)(6666004)(8936002)(9686003)(66476007)(66556008)(4326008)(66946007)(6916009)(478600001)(186003)(2906002)(4744005)(54906003)(32563001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f4AoKl9y7nKE1lnz5k1I/59H8NbkkZ+XLN2j0y9eHpWmxLt3t2WglL69pFtY?=
 =?us-ascii?Q?HHpsbEM1FO4m9uw7bAOJsOhpRQh67sxJqeoPhc3cBSfnEDYI//kLu3XpEP40?=
 =?us-ascii?Q?o94CyBq0o8dlEpKuIBMBgq2fesw/GD3wRYMy8b+zk+UR3d8OXYe1cqMsjmfS?=
 =?us-ascii?Q?vep/DYB5Z/AY7sP47rtBqVY1O+SdfH0nx3mBEQ+TergDGecTDOEY//xu7vnB?=
 =?us-ascii?Q?nUrJ9EAQoAbRjaKJUp+OiR+LnpNb6GrwrwZ6Rz0cNFY1OCxImZyzaolYRwqs?=
 =?us-ascii?Q?9TmC6l4Eq2up7Z7VuVx9dogGXg9eA74SDJzSQap0d+qxqWI/Nv3wm673glOY?=
 =?us-ascii?Q?hXOHapTfvDN6dQI9QxgbzKMUcSCKYYYB6kk521oi3j8+mW8udqFrE176dsWJ?=
 =?us-ascii?Q?LO/HaNK/cpm593kVQQ7W1YmwElleM4GnY2k9Z6b80kEFODd5W1OFPyL2ryjR?=
 =?us-ascii?Q?eqG4eIBFQ4/h33Hr2/SOma05/l8Im6nvqTdLBYMZdiRP06C+M8P2nZRtaN8O?=
 =?us-ascii?Q?9NKqqux4/BtrhVMFgvfCAD9u0RW95CzOpePXhoKPZQ7S0Jhr57vGruJcgV9r?=
 =?us-ascii?Q?en3zhsGRh6zbbpfDlHbiHeOjMY/uD07HDqVqW2BZz96enfnf0GR/GyPRZ27f?=
 =?us-ascii?Q?pPTrPyf4HsOlWyIr8BhnGBeCXyQSqt/17MvVA5WlsvFNOvelVpfRe3nhNPXy?=
 =?us-ascii?Q?51kAAK6hkpnZ9OHv/92Al9BlJ8tGLbwZ7dMUokx90p0nqj9OPUEvpAyglMLk?=
 =?us-ascii?Q?H6gY7/dqjObNb7iHKEMDM3TC6+j4smo/4yIp5vCTOXy5MPLLl3BCHXUp+Xg3?=
 =?us-ascii?Q?r6+ToSqHX1tC7SPB1bjZ5CZdcAWijozuA1SNFIPI+DwXvdY+HekNpT/t7xMx?=
 =?us-ascii?Q?NfKVFUsMGfcOlxV7DfNvVmtVYVjJmd7QrCMx1MNPzpvCYOHk840pa2Rs6gjf?=
 =?us-ascii?Q?w0S66cqymkcirOgDEkwmoVxN71g9dAfeyQ+FhetKedJeGq+QnX9V+I0xfS20?=
 =?us-ascii?Q?9a/oFpyluGWAmap219sfx2RwFysuyzOp7bjvS+pN+USJI15zuONvLq23ceE+?=
 =?us-ascii?Q?1YaMVRCSNDGyVwzDGjaS1yovGTPDHPIRFMBEo0zlRGvJ4fDPNXxNRXQopD3b?=
 =?us-ascii?Q?EWCbwdqL5i1r8SRYxkvPKj6KkZ2xB+SVy9QukEoxjBjE6eosJx5lhukTkN3E?=
 =?us-ascii?Q?67VcsbK+vQyt6KHFG5pTJ4Nj4m4Kh0Kmirx2M4pI8sgOEOvwxR0qVqAWDokL?=
 =?us-ascii?Q?O5LkVeEgSScq84TqOh5DE7IS3pFb28VqBBWEJXkSRhah8nPqzQES4p7JGgdb?=
 =?us-ascii?Q?/912z3qBVoVwDBBoRUMbAaz6iAJ7PCcD6VxjcMdBRSfc/X6pa2AaOy7yXcwZ?=
 =?us-ascii?Q?JxxjgFkkxz4EbeKStDQX1R3ofyQUazWgnXbb2UpM6/cJn3Bhi038CKazMaq1?=
 =?us-ascii?Q?TvOCe8dCHJsrNbAE+LYyDEMaFVUCqLBpz0ixZpzFdC0s+p6atiAb2zGwAGpw?=
 =?us-ascii?Q?DF9XTG2QRtUegFiWGa9w2TlEH+xrYptZS1ERSyPtfiKGCkCQCOkJZ3Lvan+r?=
 =?us-ascii?Q?lWZB5nS+c3rQQDhCfaFQyp7Ta8T79vAHqsf1GlB4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f72b102-0898-45c6-5470-08db6b765456
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 18:53:37.0738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9MNO54ydq1VA057tfrdXFAlBmaMbAN9KaM0lJKzCpv+Zr/Fh/DEqEkJanxxqnixGLA9CJZZKqEtuogDEh45PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:20:16AM +0200, Alexander Stein wrote:
> > +			};
> > +		};
> > +
> > +		etf@28c04000 {
> 
> The reference manual states "CXTMC_ETB" for this address. I don't have much 
> knowledge about coresight, but ETB is not the same as ETF, right? Which one is 
> correct?
> 
> Best regards,
> Alexander
> 

coresight tmc driver can auto detect etb and etf according to register value.

Frank


> > +			compatible = "arm,coresight-tmc", 
> "arm,primecell";
> > +			reg = <0x28c04000 0x1000>;
> > +			clocks = <&clk IMX8MP_CLK_MAIN_AXI>;
> > +			clock-names = "apb_pclk";
> > +			in-ports {
> > +				port {
> > +					etf_in_port: endpoint {
> > +						remote-endpoint = 
