Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B9A6D09C8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjC3Pfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjC3Pfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:35:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA85D315
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU2iIDZFzjgAxKsXybnfBCHfenWkdw4ZjKhFMdXM3FINs+VpA3LXs5jzGRmXMwinh2J/EXUM+9F9Th53aTsZoHbtgM9CHAUBKzP3zq/bT6yDS+p2+PbQzOubCcjnQxc3Ne+4Xf20Bw9ekdjBKOb/6T5CoJQUsyMjsXOHKITaPmwakEBZWI616WsLUqnBHtHv7HC0msaSvfUEwUY4AvoXt+D+bB0kS9UEOj/yx8gkEppl0Hp9Efo1QIL6xHqWmpOKa2nMj0UJa6kEY4yKRVeLxV/7sKjgbbAJstF2RTF0PwehbdLlsu/Mdg1rXSDtkV2PrXmrrmiiEYLTalr92GHQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsEV9Q236CzD2tjPrAYdXgBS0WBg48YUC3V6LwQJqAo=;
 b=K1/zYM/c4sE+VG1ijYP+E2i86zm80QKwHk1dxzxKa4Ls01BPTXUpxNmXiwN7P1spnGmNDnn+9SGoDMAioMhuXbCI0MaHxVTrZAmFEQpMpq3X9ZtsoL3XcqhjNp8Rp6Halgf/jzjGCG8kP73BRqMVvxeEAdtRmOjqx6YR4EX9cDMXpNgbgGXzE9i5yXcRpoDpPWh7o1RUXOcSpAHf/tvBe+Kmt5dGB/Z8y6Olq4j4BQZKO4LbHJpRnuYJwhdfplMSs3vWavOnwB4UMcsnNt69n5xiDLEnItHzKuthRZb28wpqqm5X9p1zskeODDs9wbo508qnQyjYJXomAvRa5NIXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsEV9Q236CzD2tjPrAYdXgBS0WBg48YUC3V6LwQJqAo=;
 b=FnPBQvhi4itlEEu2fVvBFCLXnMgizXulYoNmMFqSGaJ6ZEYe2gW91CWaSw+oTY6WglasJ1DZHBwBn+KRjz7BrLUcU6XHUsvIrxiTAW8KQWYgUGxYQuWuyGiCUJrSxjSFs4uoJ+56g44Zf6Lp3SLi8jL0LOmTx7fEGeuI47MC9LrcGe8mwv+2PAmf2BldkrfUbPg3w262UoyE2TLlx31qij1byKLyh2B3VtCR70imUTCL+Q45S3Dax6yDb1fC6+30f2782M/z1YuVVvKxOD9Zh0ZHEB6e59S4m3zcTmXcA8jCCRBgRCJmN0IRMqbSigFnRiE5RUgoHHyEWRvrY2fsjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 15:34:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 30 Mar 2023
 15:34:37 +0000
Date:   Thu, 30 Mar 2023 12:34:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Steven Price <steven.price@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        John Keeping <john@metanate.com>
Subject: Re: [PATCH v3] iommu/rockchip: Add missing set_platform_dma_ops
 callback
Message-ID: <ZCWsC38WGyZi3Y0p@nvidia.com>
References: <20230330144604.2431436-1-steven.price@arm.com>
 <3356d18f-d1ce-4995-2b95-16938df1b7d6@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3356d18f-d1ce-4995-2b95-16938df1b7d6@arm.com>
X-ClientProxiedBy: BN0PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:408:e9::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8cad74-0696-42b4-2bd3-08db31344521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vteXrEmZoAn8SbDrqsE8Si6bkQqts8n4U+/1GS8ecY16CrpBSXiYQldCamQ0rIc/CYS0NwNPGwJwcVUR6EsbtUsbsxhAFdFydpaOAm8epIJ/t7fQgX7DaZ5Yymc8v7lerjnn+rOATwNJQyen59x3XsQfz5P2lYcgzaDHSF/XSvyrBrW4iH8lvyW5RAIU9rtZ1emxVpVTfFt04ba1mRW9celed6Xc+tzH0bZdp1tXw7NrHTaZAqlSXeXTY/yDDB+XPqPk7yVZWDlZWvLwlSxz1tXzIH5TCr3FIlc9lR4ckoZFhaEAXjLiAFsvfQU4g0vm0cTrsM5599FJlQsBxf5qs+fOC3HS5wOOda8BOaawgzeOOeQJ8WfDvrZy74V9krY6f2eS1oWFu8xec7hJzbf4XwMN3oY1OUBUw0+Tjgz107kieRijkULHCm9cZplISlRlLKP7IF0sl+akVvNqG6xAdX5YB5llnJF1nRjszuo19vILorI+WngjYu8pXkFqZyHPm2PW1OhWw4nA1XypxOk4ciULgwWmfFbCHwcAe9a64zh3kBTU1QE7DJizdsPONqhi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(36756003)(38100700002)(6916009)(8936002)(86362001)(4326008)(4744005)(7416002)(66556008)(66476007)(5660300002)(66946007)(8676002)(41300700001)(6486002)(2616005)(54906003)(2906002)(478600001)(26005)(6512007)(6506007)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rRch4ovX+UKqzbdJ5rtbhm9OX+uDh9X1o4VW7filKyr3s7J5qtXyZMSY6/Ha?=
 =?us-ascii?Q?tRECSXSDJAbZn3CNZjPilZW20ZRLn42fXgPtj2xNslKD9qWjjASn2Eem9AXV?=
 =?us-ascii?Q?deHxVJmSbapgvnSlbuh4x9SI88+9gknCZoHofBZxi2iXZo3kiwuMVK8KHpAB?=
 =?us-ascii?Q?1p3tUqp2TWvxKOauwNzSSowSL8yKZIjr1kXvSbOhGpB9XZUkiOVVnuiiHKDX?=
 =?us-ascii?Q?uxvxWnpnvZ2kga+YRg31tyxj18dhSsDVE50KTbOPm9hf/FklBczcQF/HaQlc?=
 =?us-ascii?Q?LzJlhwM99B+epTmT3NSVxQyeYcZ4YdiAF6xpvOIVGZP8NR3r6DElyvNW9u9D?=
 =?us-ascii?Q?TAhMxkqur0FC6VF8Z0W/9nBFlcCMbguQwMguJRc12MBmD4Z2S6UcsHedVYUQ?=
 =?us-ascii?Q?G44Ozi//fkhaqqBMWmK6ufbPozk+86o0uDacicxh57BJ6KswrtPiFGPrdU9X?=
 =?us-ascii?Q?9fIbEM9MdP6paQtE9eU31swAHVI8XOcYL0rVr6fYFjheT2zJUC2LyOOkQCzu?=
 =?us-ascii?Q?PEMG8/cElN3Fx9ckRdg5ytMmd4RLv2ofKO1vSLABkG2JBSMa8p1F1ENrajdG?=
 =?us-ascii?Q?TL6Yy/sQ8kDmVwFCcMlatEHGeKm6YxsAIaMu5EO0r9IzAoSggQiX93OErV41?=
 =?us-ascii?Q?8IXswCBmRugE+s+t48q1BB5pPw0Sehi902evQgbpe4Id5Q9Ss1Rkb6PbaDwJ?=
 =?us-ascii?Q?138EM/NdbF7IFxwH6ohRVcbp7JEITfGxMLMggJpB61OhXr5VCeCQxYgC88Qo?=
 =?us-ascii?Q?laJMH66cNisoEFnyVHNgxO+S+yMhwnOi9z3pbEgrQlDL7ys3goPGNvwIjY+4?=
 =?us-ascii?Q?OqM8BY/rz7w0PWmIRP8cAQyP/UsRozDr4H+eE1Zdj1u98V+1YZbzrN7OBnFJ?=
 =?us-ascii?Q?KVczYoOmjakdrWajKzC7lGfDZCytY0EtgAQ00VFgonzJCdPRRh/8qEXAENFj?=
 =?us-ascii?Q?mmWwrzpT2XkG9yv3T8EdJ3HNWIcYi2MDmvuoTGGMKR/ej9LzDN+FX95j3Jnu?=
 =?us-ascii?Q?LjfNfqoPsEBpNcUmYM633XAj/ZtEMVngJLQuXrLwi5DzZrw3zjr5ptA8ROQZ?=
 =?us-ascii?Q?pVmkNaaZ0CVf5jRldcLmG2VP8AtEFZLUY/AUHYIsvWxzjaqxrx7m/kgyNSq6?=
 =?us-ascii?Q?4TpQ11YiyN1j27uF4XgAsedyJWA8/BxKfVKOWRjSUxVstnAJIMUMZziLKbe5?=
 =?us-ascii?Q?Xjrz6alle/O0RADtTf01knjS3B+pODYeyJKVyySJOk5jZ+bVLZ8YHC6XNwQM?=
 =?us-ascii?Q?HrT4hehXk1TRQrO3Fc+AJjOm37SN0vqHydA/15lDnJUJPh9407RsPHwIOrrY?=
 =?us-ascii?Q?4lcLAIAN1vf5Je0NkObuMTWq8+9Xzly5uZ8S3p8RVJL9Y8qN8aBiFk3rh5hJ?=
 =?us-ascii?Q?6RN7dB1ZvorQVT5B6Nxl+41LU9Q0Ihoec+Df3igzKOrNOUO+csjtF8Cw5gYo?=
 =?us-ascii?Q?vMV2fE9LHcHZkWJxWvmsPtf3jvn7QNi3KCspGtsRSUiDvoqS8wtGAiPWtCsr?=
 =?us-ascii?Q?WBlKgx0gbMIy7AEH4AY0CxfQyEeff84yCrvhWhaW68Y2af9DcnpAQV8ZCCR5?=
 =?us-ascii?Q?vgAx8uSnED2xaaUweS1G7GTyfbvlEQc9AEF5Kbco?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8cad74-0696-42b4-2bd3-08db31344521
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 15:34:37.2481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwZs81K4av+yjfwQ+Cw1XNIS/IiiDVTQkKoTuoiLAJ9tpXyhMph+L8xAuULjvb4m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 04:09:03PM +0100, Robin Murphy wrote:

> > +static struct iommu_domain_ops rk_identity_ops = {
> > +	.attach_dev = rk_iommu_identity_attach,
> 
> Since it's going to behave like a regular identity domain and be treated as
> one, it needs to support .free as well.

It would be nice to provide some

static void iommu_domain_static_free(struct iommu_domain *){}

Or adjust the core code so NULL is OK..

I think this pattern of static singleton will be popular. I drafted a
patch for the DART driver like this too

Thanks,
Jason
