Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C1074F773
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjGKRp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGKRp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:45:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2090.outbound.protection.outlook.com [40.107.92.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68662E4D;
        Tue, 11 Jul 2023 10:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs4MBiqhSCpwTIM712U9wvAw3js12MlL63KfwU3YZPGv6viWugKlKidCeVbl65l0xGIMcxBSdsxy1qMGefbKnGFVh9XlRtTvIQ5sXTrw9LZAs2V7c0gd/4AjI5HVFY0+GHoGNJBb8iGAyYa0EnQWkyyPllA0O4d0otJbZJn0JMjPozETReijX/bSMiNy5AUCJ/2DUMUTVnx5HoueTmwshaECMvjVP3pMIGPFHHgc3GconIZnio6E795wmVTQAx9qY78vFED2zB3mZuD3OLJhbFDOXq526xPR424fAnDrxxunvFJ+vZfELaL/uIznt8C4BFPAYrey0fkCw0n1v9Mm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6387FydgPVvoTaiKbL4MGM2QP/I7o3dCh89SLQBxAkI=;
 b=nvqEB4CfceW/zELtMkPQC0rmnFMGaNxbpm6wd2MvVPWcrojgCEDjHcYO91bmcYVAiUmRMW0svwmTc8ZWW1pt/U5YXcDi8cm1BYGjyOP//e21RIhUAZlK1OwWDZCtZi2UWabfgRF3+7T4a8nfCoM05Qy2wrvsz40a8ArsMRur48lAIEqwIBcUKkPOYA6FVHiNfZMC/MmndYrEy+qvWJm0ys52nhDPlA9ZHBhSEUY/2sbqcwEZtHes8IbyJoY5w9Tg5CGCp0EC5yBB6mpwTySIqqRzfxHxGkW78nogkpUU8Z+Bh40JccKIlIwgRX4OdA/ERvQkWtCKrupHRzJS0XHxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6387FydgPVvoTaiKbL4MGM2QP/I7o3dCh89SLQBxAkI=;
 b=udOVfApOgJdlrf5YFSsY7dbUdB63A74XB8S8NowEEZJn6HT8uJ0tGm6e0TVaudOP7usmHeBV+ouSH/bUbvMnip35zGbTbU0HxRag16YviuG7J0rBbLHNnkq2eDwTAVOyvIfTF35vv8rYTMZF8zC0Fc3PJb8+HlRCra740EsHcyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ2PR13MB6523.namprd13.prod.outlook.com (2603:10b6:a03:55e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 17:45:49 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 17:45:48 +0000
Date:   Tue, 11 Jul 2023 18:45:41 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 2/2] net: ti: icssg-prueth: Add ICSSG ethernet driver
Message-ID: <ZK2VRYwW8DxIZCY2@corigine.com>
References: <20230710053550.89160-1-danishanwar@ti.com>
 <20230710053550.89160-3-danishanwar@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710053550.89160-3-danishanwar@ti.com>
X-ClientProxiedBy: LO2P265CA0214.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::34) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ2PR13MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dea915d-874a-40bb-8e12-08db8236a962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hr/wsP2P4qlxQVFo9Q5mQnOPPK1X973p8s2HCGiawKrQCLk0oHDqW/WXBU+J78B06qBD7PsyEEVJzbMdFq5CPSzdL673l9vTxnsvVDhfBEENCrbIDGj9NlUKdZ1n/kdsK/jjygP+7yGSMb+q/EWWmDEE1n92gYlPJNGv3Rfw+V96YW+5pTniCm/FK8Okb63q7uEGwWZMhNeuW3CB0Y6Cji6bveMH7BkyE1vCWO1XWOzQeS+FGiWHNaNqntwYojdkdCPvcv5XbEwuiZrAfwhaj3uc5892BDyphuAlI6h8MFB20R5eHVI9pWaZJQKAtALoMK61/CwV0/dFn4Y6G2TwX9+Yvrb8si066vxClsfwANvNoyLJd8wbA0g8U1AeeZSsodFCitBz4KxQdQe9b4BbIpbuWpOqwrIeaBIsHYpe+ZnGOib3Hy3HUNfDzyTRVoqYdlQC3vFsgU7Aheya2kw/v+3Rj5SlzdK10VB5OBcy2kszMSghqA6ncztK2tbF6/cWA9CNxC+TNBSW6BRtRe44qRxQDlfx826mwl2d2ix2pDllSNHLU/c0UjOCEa7XKpUMIhBGNhOTlduCL0hfUOE3Mu4wb+eEJboPKj78697Cqlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(346002)(136003)(376002)(396003)(366004)(451199021)(36756003)(86362001)(38100700002)(478600001)(8936002)(54906003)(6486002)(6512007)(8676002)(44832011)(5660300002)(7416002)(316002)(2906002)(6916009)(4326008)(66556008)(66946007)(66476007)(41300700001)(2616005)(6666004)(26005)(6506007)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/ZjT1HyyHrQ6wdVhgJoMBkfQmd91C2PBu0yzLZ93geGZUSUniFyBjt02jmt+?=
 =?us-ascii?Q?AONozjT9LCRp3WWT0D5SyqWAC5jj17chXdBEd+4tjwTEHwWN53YTeygVqvMD?=
 =?us-ascii?Q?IZU8FOKvDiOXg5lwF89tG46ggwqfPpm89Zqg05ZeKsXD/cisTKs0awBC3yBJ?=
 =?us-ascii?Q?bTh1rBEJ9J2BqPhH1HOBX4TJ0//JnHQ4sNBi58ZXbwbVXJpKhd8kS7azcRLu?=
 =?us-ascii?Q?LsvjLYDrdGGcFAZhqwVcPzOQylJhz/diYb+4bnCefXaW8062HQp6atkWhgAF?=
 =?us-ascii?Q?9ZpylbSAUYe0uKqIR/YAyQhofmWpcBnBjN3lzRSUbBcOuENKVBA7wQRBGjbO?=
 =?us-ascii?Q?D2/whXPb8k2FpfJmswDx1p2CgoLepx3I1AQ/oEErBMyId1okos2hJC+Frl+m?=
 =?us-ascii?Q?mVv3eivss5uk+15DrQhJHhWFOcs7D1w8VfElvtfxJ0azlB5w8XoSkL2J1Rnh?=
 =?us-ascii?Q?uiDurYfob+woHC7y/KIUwq0bkQH/8jJg9fgSMkhIM+hZtKXYLaU8uBNFE7YJ?=
 =?us-ascii?Q?XmK6Zjk0ve8EuRV7UEBUFURBbsqZXL/VL6FJaw8ZO5zk1YemvDvGvAPnyacc?=
 =?us-ascii?Q?qCHXQTpEUhZ/BCj2Vqv9nSO1UWaNkLyqyY9DWooxXJ/cw6zDpcmB82NbaplV?=
 =?us-ascii?Q?Ts3x5/+upi7jZfoX4JJ8DqnUSkh41QOk1Yx8ecd6R+/bTSDvjAfj59N3anLw?=
 =?us-ascii?Q?s/1ndpNpRtaV+DZsARRfnQVJX+3Gb9r06GPGuwaprm81lbAmdgom146zmuSs?=
 =?us-ascii?Q?WzIovtqxqAFhBynVkooauBuelv2JD3byZB2nsBuP0iZ5Au+SeX+cfgZm6myD?=
 =?us-ascii?Q?eJJZm8XsF1PPvwQ3TJzsuXjP2eqZDW/WWDItWwkaZGSIFlsJwS64e9jBrk+u?=
 =?us-ascii?Q?D17HtVwQ6/FEDbZ5uFkIL3VglRVbrv4KAGSOW4VZoCASW2PiU6hp+V4SPq1d?=
 =?us-ascii?Q?y05iYNQIemIIGJtLhxNio5VJ0vgbn4KPzFw0wvELM/EcxtzrIc8Wkv3Z0K3z?=
 =?us-ascii?Q?teHEzDwf4XhnZ8KMJ416tPFiHEshDO1jf1IE/FkzPfVySDy2V9YrHvhG9kL6?=
 =?us-ascii?Q?DPJRbv22LP0/HFCJqVVPevNvv1AIeAb1IjC3MwvtNttel14fVidM6Xxbva7+?=
 =?us-ascii?Q?8+Q789PLe0VgvFyUNVva65HnYs1R91MLj0ylkeUuFpHsZsRaWZQoWOxRMo8z?=
 =?us-ascii?Q?S/ZMPeB78KV5dtCudU2LOCZaW+eEywnxls3NlNdytaoJHXOrNNTuiW4r8Hty?=
 =?us-ascii?Q?+/RCnlOjHw5x64YDQ2QxSXNGLN2Jj+Jg/Q4LHAd1zq/ztbDCksbEXs4/Uf3N?=
 =?us-ascii?Q?rV0noJBDoQrFwr9oJ8rYZKTqg56fFlg3Dr4K/wyv5GDF1t+A7xXtX0huVTrJ?=
 =?us-ascii?Q?7LB4hP7ENTDpyRnE3Zks2vnvspNcQdStsLZCozOIx/QDb9X4WY+JLyjwAD4H?=
 =?us-ascii?Q?vwhuAuwk0UWAMH0FEkpq7p+4ZSNE4tt5+jSf/+bs5La1AMSsR/VDydH1s2Be?=
 =?us-ascii?Q?cMGmXxrvb1WM5SCDQYg5se3cRgCu3TlQ1xguAPga1hLgZWdafOzaTt2v5Z2W?=
 =?us-ascii?Q?ayFGTzpCSMfwZ9AMtY5vgX5d7mK+tmi8L8AXdB/No23Fk+CXJBtVO+6gd6Z/?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dea915d-874a-40bb-8e12-08db8236a962
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 17:45:48.8182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XOkiLz8u15J8V8MftHY8gxbJmLiAXyIjl1l9r9jLXvrmQ0h7EnzTlY0e7k9gqXCZ5uFN88hEBmCX3iFlhrcsTCWzOwNlUvfuhIsyMJNKbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR13MB6523
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 11:05:50AM +0530, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> This is the Ethernet driver for TI AM654 Silicon rev. 2
> with the ICSSG PRU Sub-system running dual-EMAC firmware.
> 
> The Programmable Real-time Unit and Industrial Communication Subsystem
> Gigabit (PRU_ICSSG) is a low-latency microcontroller subsystem in the TI
> SoCs. This subsystem is provided for the use cases like implementation of
> custom peripheral interfaces, offloading of tasks from the other
> processor cores of the SoC, etc.
> 
> Every ICSSG core has two Programmable Real-Time Unit(PRUs),
> two auxiliary Real-Time Transfer Unit (RT_PRUs), and
> two Transmit Real-Time Transfer Units (TX_PRUs). Each one of these runs
> its own firmware. Every ICSSG core has two MII ports connect to these
> PRUs and also a MDIO port.
> 
> The cores can run different firmwares to support different protocols and
> features like switch-dev, timestamping, etc.
> 
> It uses System DMA to transfer and receive packets and
> shared memory register emulation between the firmware and
> driver for control and configuration.
> 
> This patch adds support for basic EMAC functionality with 1Gbps
> and 100Mbps link speed. 10M and half duplex mode are not supported
> currently as they require IEP, the support for which will be added later.
> Support for switch-dev, timestamp, etc. will be added later
> by subsequent patch series.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> [Vignesh Raghavendra: add 10M full duplex support]
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> [Grygorii Strashko: add support for half duplex operation]
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

...

> +/**
> + * struct map - ICSSG Queue Map
> + * @queue: Queue number
> + * @pd_addr_start: Packet descriptor queue reserved memory
> + * @flags: Flags
> + * @special: Indicates whether this queue is a special queue or not
> + */
> +struct map {
> +	int queue;
> +	u32 pd_addr_start;
> +	u32 flags;
> +	bool special;
> +};
> +
> +/* Hardware queue map for ICSSG */
> +const struct map hwq_map[2][ICSSG_NUM_OTHER_QUEUES] = {

Should this be static?

> +	{
> +		{ PORT_HI_Q_SLICE0, PORT_DESC0_HI, 0x200000, 0 },
> +		{ PORT_LO_Q_SLICE0, PORT_DESC0_LO, 0, 0 },
> +		{ HOST_HI_Q_SLICE0, HOST_DESC0_HI, 0x200000, 0 },
> +		{ HOST_LO_Q_SLICE0, HOST_DESC0_LO, 0, 0 },
> +		{ HOST_SPL_Q_SLICE0, HOST_SPPD0, 0x400000, 1 },
> +	},
> +	{
> +		{ PORT_HI_Q_SLICE1, PORT_DESC1_HI, 0xa00000, 0 },
> +		{ PORT_LO_Q_SLICE1, PORT_DESC1_LO, 0x800000, 0 },
> +		{ HOST_HI_Q_SLICE1, HOST_DESC1_HI, 0xa00000, 0 },
> +		{ HOST_LO_Q_SLICE1, HOST_DESC1_LO, 0x800000, 0 },
> +		{ HOST_SPL_Q_SLICE1, HOST_SPPD1, 0xc00000, 1 },
> +	},
> +};
> +
> +static void icssg_config_mii_init(struct prueth_emac *emac)
> +{
> +	u32 rxcfg, txcfg, rxcfg_reg, txcfg_reg, pcnt_reg;
> +	struct prueth *prueth = emac->prueth;
> +	int slice = prueth_emac_slice(emac);
> +	struct regmap *mii_rt;
> +
> +	mii_rt = prueth->mii_rt;
> +
> +	rxcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RXCFG0 :
> +				       PRUSS_MII_RT_RXCFG1;
> +	txcfg_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_TXCFG0 :
> +				       PRUSS_MII_RT_TXCFG1;
> +	pcnt_reg = (slice == ICSS_MII0) ? PRUSS_MII_RT_RX_PCNT0 :
> +				       PRUSS_MII_RT_RX_PCNT1;
> +
> +	rxcfg = MII_RXCFG_DEFAULT;
> +	txcfg = MII_TXCFG_DEFAULT;
> +
> +	if (slice == ICSS_MII1)
> +		rxcfg |= PRUSS_MII_RT_RXCFG_RX_MUX_SEL;
> +
> +	/* In MII mode TX lines swapped inside ICSSG, so TX_MUX_SEL cfg need
> +	 * to be swapped also comparing to RGMII mode.
> +	 */
> +	if (emac->phy_if == PHY_INTERFACE_MODE_MII && slice == ICSS_MII0)
> +		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
> +	else if (emac->phy_if != PHY_INTERFACE_MODE_MII && slice == ICSS_MII1)
> +		txcfg |= PRUSS_MII_RT_TXCFG_TX_MUX_SEL;
> +
> +	regmap_write(mii_rt, rxcfg_reg, rxcfg);
> +	regmap_write(mii_rt, txcfg_reg, txcfg);
> +	regmap_write(mii_rt, pcnt_reg, 0x1);
> +}
> +
> +static void icssg_miig_queues_init(struct prueth *prueth, int slice)
> +{
> +	struct regmap *miig_rt = prueth->miig_rt;
> +	void __iomem *smem = prueth->shram.va;
> +	u8 pd[ICSSG_SPECIAL_PD_SIZE];
> +	int queue = 0, i, j;
> +	u32 *pdword;
> +
> +	/* reset hwqueues */
> +	if (slice)
> +		queue = ICSSG_NUM_TX_QUEUES;
> +
> +	for (i = 0; i < ICSSG_NUM_TX_QUEUES; i++) {
> +		regmap_write(miig_rt, ICSSG_QUEUE_RESET_OFFSET, queue);
> +		queue++;
> +	}
> +
> +	queue = slice ? RECYCLE_Q_SLICE1 : RECYCLE_Q_SLICE0;
> +	regmap_write(miig_rt, ICSSG_QUEUE_RESET_OFFSET, queue);
> +
> +	for (i = 0; i < ICSSG_NUM_OTHER_QUEUES; i++) {
> +		regmap_write(miig_rt, ICSSG_QUEUE_RESET_OFFSET,
> +			     hwq_map[slice][i].queue);
> +	}
> +
> +	/* initialize packet descriptors in SMEM */
> +	/* push pakcet descriptors to hwqueues */
> +
> +	pdword = (u32 *)pd;
> +	for (j = 0; j < ICSSG_NUM_OTHER_QUEUES; j++) {
> +		const struct map *mp;
> +		int pd_size, num_pds;
> +		u32 pdaddr;
> +
> +		mp = &hwq_map[slice][j];
> +		if (mp->special) {
> +			pd_size = ICSSG_SPECIAL_PD_SIZE;
> +			num_pds = ICSSG_NUM_SPECIAL_PDS;
> +		} else	{
> +			pd_size = ICSSG_NORMAL_PD_SIZE;
> +			num_pds = ICSSG_NUM_NORMAL_PDS;
> +		}
> +
> +		for (i = 0; i < num_pds; i++) {
> +			memset(pd, 0, pd_size);
> +
> +			pdword[0] &= cpu_to_le32(ICSSG_FLAG_MASK);
> +			pdword[0] |= cpu_to_le32(mp->flags);

Sparse warns that the endieness of pdword is not le32.
There are also other sparse warnings added by this patch.
Please look over them.

> +			pdaddr = mp->pd_addr_start + i * pd_size;
> +
> +			memcpy_toio(smem + pdaddr, pd, pd_size);
> +			queue = mp->queue;
> +			regmap_write(miig_rt, ICSSG_QUEUE_OFFSET + 4 * queue,
> +				     pdaddr);
> +		}
> +	}
> +}

...

> +static int prueth_netdev_init(struct prueth *prueth,
> +			      struct device_node *eth_node)
> +{
> +	int ret, num_tx_chn = PRUETH_MAX_TX_QUEUES;
> +	struct prueth_emac *emac;
> +	struct net_device *ndev;
> +	enum prueth_port port;
> +	enum prueth_mac mac;
> +
> +	port = prueth_node_port(eth_node);
> +	if (port < 0)
> +		return -EINVAL;
> +
> +	mac = prueth_node_mac(eth_node);
> +	if (mac < 0)
> +		return -EINVAL;
> +
> +	ndev = alloc_etherdev_mq(sizeof(*emac), num_tx_chn);
> +	if (!ndev)
> +		return -ENOMEM;

...

> +	return 0;
> +
> +free:
> +	pruss_release_mem_region(prueth->pruss, &emac->dram);
> +free_wq:
> +	destroy_workqueue(emac->cmd_wq);
> +free_ndev:
> +	free_netdev(ndev);
> +	prueth->emac[mac] = NULL;
> +
> +	return ret;

ndev appears to be leaked here.

...

> +	prueth->dev = dev;
> +	eth_ports_node = of_get_child_by_name(np, "ethernet-ports");
> +	if (!eth_ports_node)
> +		return -ENOENT;
> +
> +	for_each_child_of_node(eth_ports_node, eth_node) {
> +		u32 reg;
> +
> +		if (strcmp(eth_node->name, "port"))
> +			continue;
> +		ret = of_property_read_u32(eth_node, "reg", &reg);
> +		if (ret < 0) {
> +			dev_err(dev, "%pOF error reading port_id %d\n",
> +				eth_node, ret);
> +		}
> +
> +		of_node_get(eth_node);
> +
> +		if (reg == 0) {
> +			eth0_node = eth_node;
> +			if (!of_device_is_available(eth0_node)) {
> +				of_node_put(eth0_node);
> +				eth0_node = NULL;
> +			}
> +		} else if (reg == 1) {
> +			eth1_node = eth_node;
> +			if (!of_device_is_available(eth1_node)) {
> +				of_node_put(eth1_node);
> +				eth1_node = NULL;
> +			}
> +		} else {
> +			dev_err(dev, "port reg should be 0 or 1\n");

Should this be treated as an error and either return or goto an
unwind path?

> +		}
> +	}
> +
> +	of_node_put(eth_ports_node);
> +
> +	/* At least one node must be present and available else we fail */
> +	if (!eth0_node && !eth1_node) {

Smatch warns that eth0_node and eth1_node may be uninitialised here.

> +		dev_err(dev, "neither port0 nor port1 node available\n");
> +		return -ENODEV;
> +	}
> +
> +	if (eth0_node == eth1_node) {
> +		dev_err(dev, "port0 and port1 can't have same reg\n");
> +		of_node_put(eth0_node);
> +		return -ENODEV;
> +	}

...

-- 
pw-bot: changes-requested
