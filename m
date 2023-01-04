Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A764465D405
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbjADNTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjADNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:19:36 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE611EEDA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 05:19:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ2iQPUzcHpNKPDkFy1QuVyndcEE3r+gpUYvEwll9KI72/oRLuRFEr3XvK4VB38tLxcaQdrkCZGDWpQ+bPQaH19DyoJVq6Kem3X3WINvMTFv74G7op29nHUyjMz2MzuqF3GDVk+68kPWOYeldDiZ/ySSBlCNL7gV5EiVtBakZTY/UBOJ5tq+5WLGHO3lu0ABlTVollupQ0Nays7EcHTPCHL+OU+aqVflIh4KSCj/Qea2c7E11WNH8YYJO+PTPJGDBy7w+XPZu4o9TyeKfn7JUSf3iJqcTFJuGFeeW2mfKGIRK/Y6UwxtF69Hr6fPaHYubpCxfnQkri+6yB2SbYrjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VA2YocFDcr+8qfSBr+o6hIzx8Apw7D1Glm5AvTkaclY=;
 b=Z2ZZuBE3YdkfPEbXypXFw3/YcP4x/IXAwzaHWNmPxgGj8MSn+cFyqbgLaG3DEY8wB/1ZGEKdenvXQEZ2cABRn2DdOeEWJb8KBIif/se+ZIaVmzy4zEWQWzKXKb9VNNfAjbaaiMiQIfT2PVJAfNWrOL0EzT831lr++FdTs0692DWJ54XwSOqUpkFKb6ikYr4G84nKNDKhKVz9vf5FHIkqTg+scDQPGjLPvpvA84oCG4JWrQGNfj9FI8NRo6BSljzoSyDVzc6ss3Wf++H6CAIepxBl89CCfAQWxsO/6cb06TmxTe5H0K7pHH/cAiVn83+7xuppwZTh+PzjQ+yZlNKA1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VA2YocFDcr+8qfSBr+o6hIzx8Apw7D1Glm5AvTkaclY=;
 b=pvBcgwNyNJjdrNLlN0gTXv8thJQA8Lmt74p2YJhxqJ3XpV0ZVNuMFIQFdc4UupwYoIpGILopiqn2kwSTx7N+q7Rs9jyLEpWO2A4GhuKvGP+XOz4LTgbN1+pZPD4xdgaUC6zFldRcRVCBCPMd17L67kzBo3dfYQqJaFlLQ+sd6MPQX0fWtF+J37Aw8oZ8d/AmuuweytUuxGtqwkQ6wn7zBVYBgCG1Em61QE2fpQ8G0/djmxc4G8TB2ZiYezR8YA4Z23Kg7t2bv1yZaEr0ZDtMzkSH19XllArUD7AXMcW96DPua2JrhCK26/libo9mSvL6I/4fYi1Y0euh3ozQHHP1vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Wed, 4 Jan 2023 13:19:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:19:28 +0000
Date:   Wed, 4 Jan 2023 09:19:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/19] iommu/fsl_pamu: Add set_platform_dma_ops
 callback
Message-ID: <Y7V833MWTyZHCZa6@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-12-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104125725.271850-12-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR01CA0043.prod.exchangelabs.com (2603:10b6:208:23f::12)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 1463d7f3-795b-414a-e026-08daee564eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DCZ0k/mHoTHfjGfWHwP2rJYvEjRmolrpmW6uZO0QzkYkHJHUt73wwI89JbiA8ger46wYbpqesvP3rGH0D8mcQmgtFQoJou5lKypMI9qfzvUjSLXLAu9o+PblxUeIUdGs+Shjshnqizi8FhtBtjyjrT2e1E5tYlJ5ctjnsFMyfH/0763IOFq95/xv109J1NJNKz/DkvUMwJtgxOZyCiHG99BTjrsgxJMyQcOZs0CubSDTznzDS1LDYFn2/LES71yHB75+okRQjUzHKMmUy1m5L9/Yme/dO2d4WqhEXBxW0dinz1XJ1UjtOpRHKP3GDFACq3TCWe/Uh6Ui5/NFeezGAmXhpyLhdQop40rCksZhm0XpgxXc/yfvqcRlfRN0gqfseuHxEU2B+53Iupczc4qy0/UiwC3xYjuyDj92txwbrm+vaCa+w71YAQF/GIlq1HddU/q5JNySWS6y4xWin97MljCMX92V6YZZ2yscoquxfGWL761bvTh9y4MnKmDoX8PWAgEx9l2uooUx5FESUY+H2vweWREano19Ti/RY7wHwvKz1E7Wl1FzjHBTBB9aPW37pIDmbOcNh+5Tm88l++UI+d6afGvH9dd/+33jMlKI7DZFiIUMwvtyHjSWypNkLOds2CLaA8QyBCvByjf2bMrpSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199015)(38100700002)(2906002)(86362001)(54906003)(316002)(6486002)(478600001)(8936002)(5660300002)(4744005)(7416002)(66946007)(66556008)(8676002)(66476007)(6916009)(4326008)(41300700001)(2616005)(83380400001)(6506007)(6512007)(186003)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hodjbiMfQA9CeszIdOskZ8WdOUIJfin3EJRC3nP4UGAf8LawhI9VJtfSpGUh?=
 =?us-ascii?Q?2lLYEORKMIPdozgOYoM+4EM1Ne99FgZ1akMBnaoukdd7pk/xKs4vA4UM616K?=
 =?us-ascii?Q?7BnyR55wHbz5BBZrjRFlegANjCyfpgU9v+9e4eMQX14E2nRhvjyCctYh0icO?=
 =?us-ascii?Q?002YPrQtqq5KzJqBu4tasVt2TxOJN4Uc/T5GOGenaQWwtjCltYXQf421bor7?=
 =?us-ascii?Q?Y4gSz2hOEDajPvSNkYBi9rPP7JbEDzmc5mAbuz3vWOGBtjogGqrFDzZy4T77?=
 =?us-ascii?Q?HhS7x5d0wtaI2aguwtBTERVSSgyzLi0djbrXLdt7OFByTroNUbWGuONS5kTC?=
 =?us-ascii?Q?0gKN3nZnj+1lpsAQeEduQq4d9FsT+InnTkjjZFQgPbKd2InHBX9RTHAx3fmv?=
 =?us-ascii?Q?2825beaix6q+hWeOq9bZFbIIhZx2xkSBrilpfuWKErjJgJhyxtHqP5qQ7rMg?=
 =?us-ascii?Q?xWmUO2c6LTGXA/WPv86M8A4qZ16aYO+alCPd5l6WfXd370g23NLOQFNAk+AD?=
 =?us-ascii?Q?dGHV6KSxmlYj7e3soBPMdcagWNAfKzi5q7KyGIrmnGomT8DBex9hRLH5AKtc?=
 =?us-ascii?Q?5h9Rm3IDL7LldqH4v/qlRNB2TjApEcsObepkkWVQpNIYnbmNczpzx2EgGt/2?=
 =?us-ascii?Q?Zsh0nR/7ytfrIS7DLlNczT2HW8d0ErrvvpNFSZjy+THLjVG8EK/IbVeDwkqz?=
 =?us-ascii?Q?U8r5iv6FGTorU79vIEPJI5CZPJBPbBkeKBnpWN5CsdSVndafdGFvdXXBRTV+?=
 =?us-ascii?Q?qIa53VnzaBdEsQW6LcPT65ufhpfWf9U58fAprG3HdoNoBYz0YJ1hrEwovk4l?=
 =?us-ascii?Q?CL0WgtOWa8qWygXcV3weQuGwmB079cPGi6mT2LRCbHUnLE8rT27jq3J9UmAU?=
 =?us-ascii?Q?o7fkNcymqVRcdhCwJ5xlyL5hO5pyhbPCCCAqytQ22IIq7Z6rD7dUEoHyfWJV?=
 =?us-ascii?Q?wNdgTGrJECD+1VwmJnrPSZOaAuJSPZZc17Y/ZCPmoJHre8m61Tm24npdPPH6?=
 =?us-ascii?Q?B4eDDCcnW4WaM7l+yGUvCR0tbshW/ZepvGFnG0h/sIjtng/VXrGuP0/r+K44?=
 =?us-ascii?Q?gtn65T0nO6JRrMXePyd7kqLTI0bblVKbTIbBRyvwqQKuuVyGNR7f9uPoR8Zj?=
 =?us-ascii?Q?LtOD7MBMoPXYIc0tuIa28kyZA1D+Vsf5o4XkRYlMhwqA2/ZSaAMVDeRHYS3a?=
 =?us-ascii?Q?jed7/cgrdt8DQQ98YsR8hFhzdnlw0V+ly+pQXotelpSvqzHOz4IkmbgR1sF/?=
 =?us-ascii?Q?Qpg3QPCqA0LKBWs1x/6ipjlKAe/RE3bj9Gr3lMIivTC76BUcVO6V1v6L8Y+B?=
 =?us-ascii?Q?NnyixCoY4NUGosOnGuw9zl1gSJ7nWeSq6yzBektN44U2cpDU77TKjNDIrEFw?=
 =?us-ascii?Q?0qN0VejJva4OvWKp/28APuLU48yNUXwe4QPpIgVgvrFs8RP2/gBhkFVFQ/2W?=
 =?us-ascii?Q?Ug7BJuaaPhyWzieHED/T+bl/H5ftp/QvtrVJndBQKwi1Zgs49K1K25M2dyvt?=
 =?us-ascii?Q?2bvOqjk0emLsH92B6Th4AXR9TAxLVV7daqn57ExfnTHOppSBEZaTE2R831nZ?=
 =?us-ascii?Q?otePaiohJFIleuCKJfsdS1jv6ydPnMy2ZRxr5MLK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1463d7f3-795b-414a-e026-08daee564eb4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:19:28.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwJ6JpldMcK/VYR/HwCellAzls2wTwEMJGYwCzL8EQBbd1tOdBixOWLE9XwbKof0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 08:57:17PM +0800, Lu Baolu wrote:
> This IOMMU driver doesn't support default domain. Add the implementation
> of set_platform_dma_ops callback so that the IOMMU core could return the
> DMA control. With the set_platform_dma_ops implemented, there's no need
> for detach_dev. Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/fsl_pamu_domain.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
