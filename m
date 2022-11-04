Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7E2619644
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiKDMdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiKDMdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:33:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BEDDFB1;
        Fri,  4 Nov 2022 05:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnYxI3X5TzhCKGtemeF3NgyDmS6CRfN+KFFglUydbBKiEEOtQaJTv62I9JgACXXhahKCGoZr8rP+sNXaK8x6iCqHqPL9MHf8UUde0gjXddgk2DtLWJP+C0eYgosS2hlD2McEDPLROPk56UwH+LhqeyQ5FGUE/RZA0yJxXl66TNl4w0LQHKw1OQX0JValzDPFVjBGfmMcuIUq0br74Mi+GUVWFsCWVl1u8oVQBZrq0ePeAYSjbzWwBoHRSHWV+lg3iMNec+HsevyCE3jghmYjH7sBJD6X7591Sw9MEsLe6nRxOsRtEx+KA7BqbeCB7Ncd0DdQyiRTNNizksyYRdB4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWMCMV8nGDbgbliBd7FeXGeBBHmKJuC94LeCBhzdZyw=;
 b=UVOXinwgsuFDpFMGgc7imdjSFlioCs9GjjXP7j8FRnK7Src6EQVOysPaR1H0TeT/aDH0bHMOsl62OSIFDERu68RrKgDDX3pUWZRXFF5q3RRfBgJn763Ifu7Bfl6HP8kNjtTrSig5crRHhadDXkDxWarNxREZMlLrss+rITJSM+BfnHTbg3qbwA10CVbWYr3j0bNMr5Sf7diKucbe5kmcA0YUiN666B/HH3XTEESApRNHga9qv/THQD54Ji989ml01uzL15c5F6HXNOsVuP58WacWBP8g6YWoWYvYk1exTm2z1r9x36idKep6lnk/aTzArGfK3RmOC2E2NYrv/myh1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWMCMV8nGDbgbliBd7FeXGeBBHmKJuC94LeCBhzdZyw=;
 b=C5Yljrb7nws2cjTWlF2WdxSNdXIJwPPZ1m896H2kwuuo8w7yMVnG3NwxnrChRkLgDIsGWfy4bi7QcMutt1wjj4A2olZaS0jCTSmRa9co2SxF6qQcwKHaqUmIVsl1qneMYrxFu3oNPrR7wbSvkMi72h66SAozZzAy9bY0qOtYKNfZnSm8X3xWIYfag9aNx2FYkIzBbOLr0kGSkMiJxO/RSQ1Ruyl63FMzRDeuutyysWVAHvzx7A8QHp3160McanC1B57cowwUPk+NXfDBZgGuYMTn/70LdOqelliAL5BkGTfY1ByIgF/Sw82FeArBOeIIcjbJReYhER1RBmy9nLowcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6068.namprd12.prod.outlook.com (2603:10b6:208:3ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Fri, 4 Nov
 2022 12:33:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 4 Nov 2022
 12:33:29 +0000
Date:   Fri, 4 Nov 2022 09:33:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <Y2UGmM7nP32KUfmo@nvidia.com>
References: <20221104152434.7233ed45@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104152434.7233ed45@canb.auug.org.au>
X-ClientProxiedBy: BL0PR1501CA0020.namprd15.prod.outlook.com
 (2603:10b6:207:17::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 2436a877-0b38-4cae-031c-08dabe60c6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hv2OMiWkNNPxMQNMCN9eWUu5Q7qPwdPKx8hP3+70oKrsW532gTA77vcfxVcBHWeGaJns8ljNpatWyU40ifDkarp8Q2Z/WhjKflsmCk0JGY3SNiAAzWQuU5cLhpoGgb+N4MdrUxhFysoc79i9gBmrxwWhD/ichDbPp2B0dB4t1Fb5UTpSYXfTt+A3ubPMQakG3K6xPrUEhmS/p8DLc0CzRdWvzmhbvk6xiCwaJJvMOwPfaRsvyMLyqYS3hKE0jnSjijoAUUmRANrmOMtaVPp5rZzIcolfGK2+kwI57h7pCjEmrgEJ+s+GyS8LXeJFGK18bg4JR9B9XL26xGEGpuOeBA0G6eeDW607oMqEncqvqrgCcaxrSqXSHh7v3tpXQacQjYRmUnZcJseLR3MxLt6InzOmuPlI3neAhrTyp+/djlP+2gNRh7YwPc8wltZPTEl/+ijqqg/C53u7lIIzrn/O3pwihuJyU7Ga0HYPpTn1kMhkLf8/44IFfBx5NgR5FX8LBemFwFmI7Ce6LjOglyRbmFcBBR9f3AGRDOthLmu0BYrBsMT6/TftCRq9KGKfdcrN3fpsSWcYU8LfbqTmdU5imhlWIRkKJEJzX9JMfrpOAdMICV82uCKlUeZZiV1LfXrbiMdwNarBly/cIZD2DsqtLiYWrY9AIl1KosxXFXIHeZq2Lh+M7QN4egSgg0zNevxInhJYg51c/w+eFN6bGxrZLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199015)(478600001)(86362001)(36756003)(38100700002)(66556008)(26005)(2906002)(186003)(6506007)(2616005)(6512007)(6486002)(6916009)(8676002)(4326008)(5660300002)(316002)(66476007)(41300700001)(8936002)(66946007)(54906003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aSb/1bfBfKXm4t93ciwF5jc/zXdskMNRDmC4TZwSulPuCu9zYi+HQX4hhe3/?=
 =?us-ascii?Q?T5pmTy5AREnMUtNLtWD5hEUo2hlJVraGd2vwSOktx+vDc5lLvFj6MScFm2U4?=
 =?us-ascii?Q?YuXUx4Rv/yONfJ1FuMkNyHZyTu2VU3W940PLG7/wcRRq7EimzkL39tfnQX16?=
 =?us-ascii?Q?pqEXAMrj98YVvjYyBFBAVTywwQ/qqE2J1zMt+FC8O1eRewtKQ8kG5J6txTqN?=
 =?us-ascii?Q?RanvKQ+HCrEdTd5cDXY7FiFKzxvCxBkH9RClPIwP5GUFxozjiY2X5AQw3d0i?=
 =?us-ascii?Q?rHYLg1M4c3aY9yYQmRDcFsEueBpaqJe217xmcm6bSpphpa+Dm577od2570BD?=
 =?us-ascii?Q?hi3L8pX4hNPjdBAsUptZG7zGHF/keJI8IrUZ9qNOMGZMROJdwjCLJxP/vhcX?=
 =?us-ascii?Q?b9fbq6+GPrc+CpHoLYkyAft50IXVDcMhcJwv/5uHbf3LYWFOpZng5zbzzdUz?=
 =?us-ascii?Q?WcXbSmePt8WUT6x1Uvgk2OBLGB+GgcF1MYngyOddaUahvjec+0T3cSyI5vl5?=
 =?us-ascii?Q?SDvtkHruLreZhu6RnNzWOCPYG+oWsiyK1H7Uj5h69zJpP82u9D7wJdS/lJIc?=
 =?us-ascii?Q?IjMCrgHNBJEN8cylVccGDWazp7mtjJNaeMVC7szJgt5BwNhz7y/heuqTsogo?=
 =?us-ascii?Q?4krWA9FQe7EMWpmNaKYqmyzRZzHcZUYJfaDl5WcVe26s3yqCysxnL26Q8Qfw?=
 =?us-ascii?Q?nQ+1+0dr8V3ifl6PAMxdN3UsLnqGc/KxKzax71JVWL6sgQbSGdJGCBy3MZ2B?=
 =?us-ascii?Q?/LJbtyNDCOrZ0yMUVV8k23p93lHJE5fk1+d4Fo6vSSrZioQ/eOtSeun4NfR1?=
 =?us-ascii?Q?KLwPEZ61EG2PzyhMBov9p5dUVqxXUPNxutjE0LkDl2pfnDRpdc0eknfd29+L?=
 =?us-ascii?Q?7HcHcgip2cbJta5C6awtbcsvC2r1hWPlyw/aUZKCV307BqYsoEicgOHodXPC?=
 =?us-ascii?Q?723OrK9nCYXB3tC1XeCtz3ld9Qdkp6baEIaJPMqVJcy7CJSUfdgJjlE8kf96?=
 =?us-ascii?Q?vay2IlOx4lqjirbVIY1wyC/ET8+WKPqaXvkWFOdb32M0veFsh9HK0ATmSp25?=
 =?us-ascii?Q?SJS3AZa5/97Zj018yxsBBUNqYnBbFFv4i9g328b7IHrVAWN7pUeNeSVxTwY2?=
 =?us-ascii?Q?0wEbeoGBVsj2nYU+U4K3gTgXQJCTMz0HU0/l1DVqFPxYt1TLq0MrxQXyeQfP?=
 =?us-ascii?Q?rR43n6wVmT5BCUYJy29NalbmmaalkSraUpBtW5lBCbtMK1zLX1N9AmUdVmnz?=
 =?us-ascii?Q?XU3lKfBPngf/BkiN8ORtA4bYCEO/MetlAixm4tlwkqde+oLDW3Iug+zsyng6?=
 =?us-ascii?Q?Iirx+JYEDpTws6PT+yuno/GlbKb08x54dL2fCvsR/Hxlp8dlB9ELZwNmHWWh?=
 =?us-ascii?Q?zPBxpY0zGeWK1DeYCfwRwXH0KnTwq4Bw0cm2vKyNl7WHE8hiSlVbXvptKKb0?=
 =?us-ascii?Q?mDK2rXEna/a99CjDdeTT/qoXeCag0JcdZzvQfv+yu67Qd3+yMNdZuWRIQF83?=
 =?us-ascii?Q?RpMpLayT+tw2jCE7GZMaIi1JguJ+a5/UUAEHppxXtR07B8zI7SulEzuC6tSM?=
 =?us-ascii?Q?cDZVYBdVwDUp3hiduDE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2436a877-0b38-4cae-031c-08dabe60c6f6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 12:33:29.2214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXBUCvBzrum30aFk5H9HsF1TihSu95Dm+sv66huhOhmJ6A5i4pjlVw8Vfdk9gq7P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 03:24:34PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the iommufd tree got conflicts in:
> 
>   drivers/iommu/iommu.c
>   include/linux/iommu.h
> 
> between commits from the iommu and iommufd trees.
> 
> I don't have time to disentangle this, so I have just dropped the iommufd
> tree for today.  Please coordinate.

Urk - this is caused by merging the Intel SVA cleanup series into the
iommu tree

Most likely I'll have to take commit 69e61edebea0 ("Merge tag
'for-joerg' of
git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd into core")
from the iommu tree as a shared branch

Check again tomorrow please

Thanks,
Jason
