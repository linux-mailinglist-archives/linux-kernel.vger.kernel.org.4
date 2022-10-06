Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591385F5F95
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 05:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJFD0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 23:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJFDZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 23:25:22 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA8189CCA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 20:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQJdLIhmErgqawgqUddSQFWamF85wJl3io4j1L2TIEJzKCw2ftMi3qzvy+Pu8f0hJjr6PVh1xQYsp4HRtF0GLoml5h1EXLKRrBPHAoI3Mt5Oz93Lr1ZC3g5ImOMH4fhHqqoOPRdNReIpJSHdh2MLOjVo75/Yzvp5oM7/oRKeyOsAdITT+dRHEomDzG2tiRkSyXESJLpBKPTLsQi33SK4yMH1ZyVW9rzCTKMBeR6Byfbp1Mtri0G/NUOVHaxubdD1jCJhdlxo2FAxJMlMjPZEvEjajyZ9q29GTx3cXVblTnv7qJwuYYqWFNO03wtlc5W6qKT/HNUEFt2bzayDAZRQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVq5tj+4RyWRWBb5WXXCFt93bEskGCCAFVBaQ6MZ82o=;
 b=iSLZyH/eNWb6DU4fkj8n2bu+5EQnH1JZJIzA2Sc1zIq3gkFVtzDTP9cnt6l4edqN3RpVY7ZuY1JmxsliPjz/A0i8wosa1iyxKic41e5peQOLURv0SM03XPY6fbspjm90RZECst7uTNH5WFzWTsJVB8/421xFb59jEG9T6qqlOmrK35/5PzTqVXi2WrwxJk88ZlnUfdNWT1HYINrbevlnWn3tAP4wOt9XUfTvAfX9fB5N5Iox0BBDdyeNPEWnBWPm1oXlkIIIdLeNHCuYc5LndnCEcI91baXoVkjcZsjAjw8oiPd14cE6maElq/wFvfp5VRiHPLp09LQ4xnhpF4fRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVq5tj+4RyWRWBb5WXXCFt93bEskGCCAFVBaQ6MZ82o=;
 b=EAC1jak2qIdJ4/kINxAg3Hs5xw0IS2lGGhZFHL9t7IZyak9HqUBuwjYfdl8jnYHeWOVG1zsB6AFDG5osC9ACucNd46DpudIb8Er90P6IRJh3QzK2ew1m6ZLttrCwXRMs7y5G95lFOKkoSqURPcxIxnWKAyfBieIvjyZnrOHeMVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8498.eurprd04.prod.outlook.com (2603:10a6:20b:341::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 03:22:52 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::181b:75f7:dbc8:b4bc]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::181b:75f7:dbc8:b4bc%7]) with mapi id 15.20.5676.031; Thu, 6 Oct 2022
 03:22:52 +0000
Message-ID: <6264eec36f0f383bd35ec7e3787775c4548b6aec.camel@nxp.com>
Subject: Re: [PATCH] mfd: Add Freescale i.MX8qxp Control and Status
 Registers (CSR) module driver
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     lee.jones@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Date:   Thu, 06 Oct 2022 11:21:51 +0800
In-Reply-To: <20220814080457.454056-1-victor.liu@nxp.com>
References: <20220814080457.454056-1-victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c3ef08-984e-457e-0814-08daa74a0d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgxbN+sCRX1HH1Kd0FPlJ+NHaPvPzS/sUYXlGsnsJvz7uWvH3DyceOs8WLZ+YLNwa75aQOgvsBiTgZlxnph2vFx4SgBB5HklRg3vEKoo3SSg+dLfVH17PQUpFxqCOBXNrpi0DsmAD15tuscPUJCeuUWmwCCgyqNq4phkfPoa/yH6ycyudVOMAw69iD5I8LOVSQA2pc9qIM0sf+Np+E/K+VLoKJn0b6OMekX5W67v7jkzlnNakXanySAoz96Op7vWv8Cn0DlVAhuRfaUgPXbXRiyB22cVcGSqVSf3fbMbJOezGLgr4MLTMZbOgSJEoZzh/p4KL+e78/HNdfG6/wm0k82B9L6C6xltiDHygoZCnl/KUs0bl6sUdiD4oVGuK+X1ivsUFOOSMN+emAEV3JnTvgPKkWBQqlsi1AjbXkyQCm4SdsZMnpg+wINvRzLJQp+HSaUoY26AogT6z28nq50qVKg2wE2a6EP7NbWh4VxZ5KVAwv3ry28jrSJtO9xKLXo9uFB6l0ARzDzX54qy1x1HgNA+ZO76TNk/lCO2RyjESP8M8HN4yqL38asOc15yZxFvzoEu7CbsA8trgpb9nBRxLIDNfKGahGkgigD0ZjYdw3OBbyxWpcn4bG1jnvWdcmlUQO8+bQRuSsGTrlZjgqf9ZUfQ4Am4S9pA09dK86dDLsLq6Bxjksf4EY4dZ2dgDHVuLuPxOeB14hWqwd+Lv301ocOIYoJqAleJBQ9IHI3nPaU9/f415YoXHFesoAUpb8NccnGo4k2f4JRs62Ai5vp8RuwqlQUEw8f/QONBYab8EYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(38100700002)(38350700002)(86362001)(5660300002)(8936002)(2906002)(66946007)(41300700001)(8676002)(4326008)(26005)(6512007)(52116002)(2616005)(186003)(66556008)(478600001)(6486002)(6506007)(316002)(66476007)(36756003)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFZFaVR3QVJFUE1RZXF2OVVrTGF6RmNaUUxxRnFFL2NKRlN5UlZZRU40a1hX?=
 =?utf-8?B?OVVKbElkSm80MUhtQWNHL25KaGRtQ3h5RXFzdFJyL1RqK0dXTUw1L3VwbGgz?=
 =?utf-8?B?U21PWU8ybS94ZkxhbGpUcW5aNFh0azdXL2Y2N2xnakJiSEtXTW4xVWQ3RFpO?=
 =?utf-8?B?RUhCdHNaNjM3ZU9Pc0FNVmorT0NmeHZIUTZQclMwM0JhaytxS0NQMXE4cWUx?=
 =?utf-8?B?azZBUmdBWm5WY1lDa1ozTXQxMXp6bm5ETVhqbE1Tb1M1aVBCbnJCQUt3bHlC?=
 =?utf-8?B?RFVHT1FKK3g0bnkyZVc5UmNGUkZFSzVha1ZpcXozdlc3dFhsTkJzS1pHY0lZ?=
 =?utf-8?B?YWhZL2hOSnhrN0NUNC9lWmtMdEVXZWEzOEZKclhYRjdIQXVaNjIwTFFxWWJU?=
 =?utf-8?B?ejMyckRSWCszUXY2a0V5dUFxdEc5bytrQS9pclYxaGcyQ2hnM2pXNnFyZ21l?=
 =?utf-8?B?bXFxeWdIZHR1bEpPcGRGakl6YUZRdTJiZ1ZoOFB1bzFjMEhldkJxajBIT2xo?=
 =?utf-8?B?YjVScGFKS0tzaS9WYllSNXdLSmNJOEFyT2VLZkNnK0xWS2l2TXdiclFuWDZL?=
 =?utf-8?B?SDJCZ2RVSFVlWXhERHg5a0N2QjVMNlpvYmttY29ZVktacm1oK0hxVXhmcGhU?=
 =?utf-8?B?Wk5qQUdOVDMrSVJ5NG94MjFOUDRIdWRidUhhUXIvdUVTUmdmWElUdXdZL21E?=
 =?utf-8?B?am5hN2JXSm15ODdKM28zWTUrcW5PTnhZdkgyaHNhdjR4ZHBhRDlUQmNhMUpZ?=
 =?utf-8?B?MzkrM3lBUUNxYWlnRlZncnFGWDltZjlBTElYcDhnL2Y4L21HSnljbE9WTkQz?=
 =?utf-8?B?Sk9TMHhBMEhTd3ZZcWtoSUErQmU3dkNNVklxTU8yTTNUNzRFRWo0dmQwUjlY?=
 =?utf-8?B?MjVGalBxSzIvblRaVkhyOHErY254VFhQZ2xGWFJRcGUzeHY2VVk4WE9Xd3lq?=
 =?utf-8?B?bkdSY3Z6OC9QRVBPNGVZdGhFY1FKemNUY25NQ2IvNnRaOVI0KzNaUnpjd042?=
 =?utf-8?B?YW1mUSt2aTJnV096cmZYK1ZwS1ZoMENoWXA1RGVmNHJkZzVBZ3I5dElaYWNZ?=
 =?utf-8?B?VHZGdFNMSFpnR2FtQzkwRTMvYXd5cHY0amZ3SDk5NFFqcU1waE5qZXI5OWZL?=
 =?utf-8?B?a0wwR01KejZEMUFNcWJoR3VWaVJWUlpRTGtlUkZiL2F3eTRIN29Gb3RuWC9h?=
 =?utf-8?B?NEZjYlZqdkVQNStHb3hMMHFwVUEyTm1md090ODk1bm10U09Eajdkbnl6WUtn?=
 =?utf-8?B?SlVQSzZRU1pUZ3d4UFJITmtET25kc1JSWTY5MFlqOW4xeE44NUQ0MGZvdWFy?=
 =?utf-8?B?aUw5K3ZMS1hLb2MrVXN0OEt6TVN0OHJCTmFTb0JXaitIdXk5c1Evd2Z5ZGxL?=
 =?utf-8?B?TnJ4aW5VbWtxMXoxWXZNRTJoNkMweGpwUWt0bUs2UjczbTUxaUM3QkI4M0NM?=
 =?utf-8?B?UkJZdTNRZUl4YkROWk9hd2p6d3FkNG5VTmU5bEN0Y1BDbUVyOXRTOVN1NmlL?=
 =?utf-8?B?Q0c3ZjVoT2pMYkxvRHBQQ29RSnlXRlBtMWVRYWtEak00Qit6azhoR24rbFo2?=
 =?utf-8?B?VFNFU2hxRnQ1d01BN2Z1ajhmZWpJOXdudjc2d0FxOXRxbDRGMHJMdmtxLzk4?=
 =?utf-8?B?WUtPN3BmMjFEd25GaitvYnJsYnVHYldoazErM0VQZS9Ndm1NQi90Z0hpNnNm?=
 =?utf-8?B?UjJSWXdjOG1EemZ6NFl4dy9xdk5OSWtKVmkyaXJ0TmsxUVFxZGJoVTZGa3hk?=
 =?utf-8?B?VzdBZkdBYjh3VjhHU2pVSkJqLzQxcEhPTy8wblhGaGlLNVRsZHhEY0pIa2l1?=
 =?utf-8?B?Z3p4djFYeTFybUUzdWdtUWhYM3ZVNFZzc1NOYUxGUnF4UGV2TTV4bG1iSUxU?=
 =?utf-8?B?aGpUN21CSFQ5eUJWbFRxWlQxWTVSaG5QRERKSHdNaXJNeit1WmdsMGVrYUlS?=
 =?utf-8?B?cDI0dXhZS1RNMWl6bmFZbndkbE5sNGkzRFBJTlovbUlMVzY1OWk1MVJRbHEr?=
 =?utf-8?B?R1FBSCtSWjFudlVPbURNeVBQVml5R0VqQnFmck95dWpoZTg4MjdHenBCUzFQ?=
 =?utf-8?B?ODVKV3dac0hRY2MzaVRiNmNNMldqSTBTYThHckRSK1UvRzJad1FDQ1MwM0xD?=
 =?utf-8?Q?xjJPYqDYUJ3CKMYSlhfybhsLC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c3ef08-984e-457e-0814-08daa74a0d3a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 03:22:52.0328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2VRkOMG/Ai53jEuYi5umJgH043Zolvt16dZWMDxNoQ6MiUK9oD3tPp4zSwtGrarPaL2aN75MFe5HiW2+uMECw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8498
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-08-14 at 16:04 +0800, Liu Ying wrote:
> Freescale i.MX8qxp Control and Status Registers (CSR) module is a
> system
> controller. It represents a set of miscellaneous registers of a
> specific
> subsystem. It may provide control and/or status report interfaces to
> a
> mix of standalone hardware devices within that subsystem.
> 
> The CSR module in i.MX8qm/qxp SoCs is a child node of a simple power-
> managed
> bus(i.MX8qxp pixel link MSI bus). To propagate power management
> operations
> of the CSR module's child devices to that simple power-managed bus,
> add a
> dedicated driver for the CSR module. Also, the driver would populate
> the CSR
> module's child devices.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> The Freescale i.MX8qxp CSR DT bindings is at
> Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
> 
>  drivers/mfd/Kconfig           | 10 +++++++
>  drivers/mfd/Makefile          |  1 +
>  drivers/mfd/fsl-imx8qxp-csr.c | 53
> +++++++++++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+)
>  create mode 100644 drivers/mfd/fsl-imx8qxp-csr.c
> 

Gentle ping...

Regards,
Liu Ying

