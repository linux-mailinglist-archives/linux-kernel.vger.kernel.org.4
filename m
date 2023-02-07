Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C3D68D649
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjBGMR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjBGMRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:17:54 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A878EEFA8;
        Tue,  7 Feb 2023 04:17:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQSgyOUOfGRhbi1CEEB12Mu85GDj1cZNvndsbEWB1fN8eu5zUyVnu10OefRI5yYgpPZJgXBPpcReHz1XcA3l+KRlO9iAVsXKp/RFKPoweqZ8xwkvJf8poBJHU5fZBRanj6vtSXQo394I+f+Y0BDr2+ecyz5r+nnPVaXcKz1zIomfWXISfAig9FbIOSLuUhzwiMw9uKp5ABWkxVowtUJabSuU+oKw5imgtXwRV03xPpV6KCIP5ZfsZd9bSxDsirCHWYobr5+gKDawhwSWBXawjULwZGf9Qj4b2DPjRHCV8oYgW1J5aHY+4fs4f4doFQnUXw09GDQ0kqhqeLQkRWXV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGAD3ptWh7/i1WoSLsWpb9oj0xDI0+dFiO95W1TqCEQ=;
 b=loyXl3uRV/geNAMOYO2As0gvXFpRIj8YC3B9k8eEFZ96JGyAEcDGXC29G0Yz03ZOtCOqjBaRFicpdzoljeksGsV3TKZQKHeds/qKKVAo6f+1Fz+tR2Xxexqh5xLjJ8gaopz4+abmyMYFBPwviRusZNm5IoCfGwbBtS0eU1nE7Ug1Ems1LjSLbuF6XmpS0f5qbF97eF5IHUZmOjJbJGFZorqH8jn1V439+CYhrv0Xx/7KbdJLUy6eVhd6lRH0Nnj5Kwv82bBapl+/x0fmhcf4YxUrlHvOB+6SibHfHgF4xKieWnUlDnJs1xvXB38JMNp/Jnb7iCVqstQoebR6iu1DHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGAD3ptWh7/i1WoSLsWpb9oj0xDI0+dFiO95W1TqCEQ=;
 b=VsL3HIovLmAzpsY3K/VLdZXEp/LUeo2Mhh3IkRSCEFxibGvNdxC78t3hT8421ZF3EUeYXlR9PWmK7uiK/3A5XPggnzSR+ow8aKuo1z8IYaJyb6ot90cG54XhKc7A4TJE/X3iHtf2Gv7qoMyP4jxpX1QWvldARFCd2Uk5MG7sX9ckKYzA/0WSLxOVhSHVa//c9O2k1ZGFjvInt0o2VFTarKW3NUTdkfO1jLA8M555vRem9axnBYYXmZ+AfUxjgR7oILmE8yPVoCg2+0kU4v6sj5HILHrN3C1Qz7zN9uNkiYfYI2fxLtS2n1g/N1+Owt5wF+ZSOAinNW4wXDtj1SUzMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 12:17:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6064.031; Tue, 7 Feb 2023
 12:17:47 +0000
Date:   Tue, 7 Feb 2023 08:17:46 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <Y+JBak3Tt8Pdw3yE@nvidia.com>
References: <20230207153706.1821393e@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207153706.1821393e@canb.auug.org.au>
X-ClientProxiedBy: BL0PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:207:3d::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: d581dc4a-2546-4469-1eca-08db090552da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /mRF+TBsir+EjL//2fu2s5ul3zNVwtKGX5U2ZU6qX/3vzV7SJVmPIHcvQdJrSdM6O9jU0RMN3nnOb1724lz8NpSqpZAaRlL+1xkmDYyJ2fyOK1x2dw6vyq9m8PcqjYhf0GLaBQWeleSUBooh336VQUDAq0HmwXfhLhQQNTkqvJkNMxLNNssqu0uUZGFrMlX8TsR1qpxpMZCBPBDwBJwNQ/03XCbXk4YlzCJQ+yAGtokLwB8Bkv3J4AlgmetQDuwmEBp3iIMgzkDxqaDM3iU7GfuTxpY2hRKj0hVZGE3dbimw0ekRMcEbIN4TDH//usfzovqCRJkefxZ1NBOfGA9LlmZvLFDvZiH9mz44at1+7koRFX7fy4KpvW7+ZgtZ4Ew73XrVRMgP//aCPKb0Yjag5JKihzFVsAAR4Q56JZgzyl5bljib7FnZmZJu4BaWjk2VlAQ7FFtTz1T2BAkogdn7kiw/rFmmtn4+E2SfzCfuYWWWnveicB9ocsyJTlim4Aji58Wuj0ts17ubSmFnFJYyrnbCzw+TP4Nanxw7D3BBAc1q0FGjq8XzGlmD3qxSxq9HgPVUsnnlnzgWi7wtQ4BCSKLXeXjBDvEIzm5Bsneoe1RxPkRleKiIL6gOGsA0BFqAK2ajuRIPZ/gUnsgEiQzdBzju8500CAh6h08k7ErAWcHp1q19OvazK45bXEPHpymdEFSHcMcP046gD3cWUamzCaN0pMnya3G2Bv/+4stfg6MceSNdcloCSdfGiYI1+OGR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199018)(36756003)(6486002)(478600001)(86362001)(316002)(54906003)(5660300002)(2906002)(8676002)(41300700001)(66556008)(66476007)(4326008)(6916009)(66946007)(8936002)(26005)(38100700002)(6506007)(2616005)(186003)(83380400001)(6512007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?huNds0LelHt3gYlQMCkjbi4pYIFyHFLkd3/EMp7Zkw9qQeLq2La6n+Cq/KXv?=
 =?us-ascii?Q?IIXZkbuCFepCGvLxxR5PQyD+WSkkVa0UNnZnkyG7r/Wzlxc9WSkbKX9cNZXF?=
 =?us-ascii?Q?o4WHaTLXSCBj76UiPOdtflNO1Z4/hpufDtd4QmFkjdzdmlpqqY4ndO/IZEkp?=
 =?us-ascii?Q?Fxi/bIkvn5uQKgXKABpAFanBlq4OPTj/LXtvNPvR4Ibu8DNh7NEpSMVYfWlM?=
 =?us-ascii?Q?uzcfnrmXQNGgfS06vroQcqLMs4Xuo+qqMAnDe7W+sE36aDmyLUwSstMU5BqR?=
 =?us-ascii?Q?ZbRWw+3ffNJAhn2nnpPcwZZxj0j8Ubpz4UMohKyhCgBdEgvdsuNPKQl5h0kM?=
 =?us-ascii?Q?6akIDbUsi+nuoyfibpjlJUVRqyTsXP5UFAp3FBYOvom7mfjJvzKNiKTcvsrB?=
 =?us-ascii?Q?+07FCzcJ4uH0ofTXzPBtBgP6OA+rVuJf0/avSJy5c/v8zGJ9KVOBkISUfrPh?=
 =?us-ascii?Q?QNU/3/jsyCQEpJDeYFni3tcdOtGP8GR8WYDacmHmwUjGA2zlBRx2g3BCwYWG?=
 =?us-ascii?Q?KPYMTlNsD4oNCBy5od4pudguKTHi3JwWkT0czC7JorqMMSzCYa/qbIF0wmYV?=
 =?us-ascii?Q?CWDutEUk1tndHk0mEDQaNs12DarpQFQYwqFQ1Vg602Dntuee5Dg0D3Nr51be?=
 =?us-ascii?Q?Eu5xYwLkzRb6cdMx+ImXxc7DMI897JU2Dk+T4nrWcfDQCvfd5ffO1FW7oKXQ?=
 =?us-ascii?Q?EmMAp0XdB2APtJjaj6o8NB20IWwQdvXKYYSaqHgczzwwWWDYNTNltb4Ow6pt?=
 =?us-ascii?Q?KmQV6RRFDVtpo/opOI7BiBdJxLjy4ByNrkRtLvtrfHLYv2aU+zFhdHoTlvzn?=
 =?us-ascii?Q?Alg01+RJLlWp3+PtHr8pd8Xwr+hbxcL3iLMJ1R/fTLY9QxxSByJFFd4DkIx/?=
 =?us-ascii?Q?UTjxyg3ofdcxZfwyeRrYG1XduWy7QnSAAu2B1zSpooFkclAGzX94Mtr0+9j1?=
 =?us-ascii?Q?oukUPXzyR7LjaEOy7TH22s68ht5LFeOm96+ghNyBEMj9rAkox7YRRclUxh1m?=
 =?us-ascii?Q?Jk2EuaMZh5cfd1rVDCcT0szYVGMwSwpuzkiUQL0y2s4M7CDXXciG9CC0R5aq?=
 =?us-ascii?Q?l09PhYZDsLcHCHG+NzoyJEeIxOLepmP2yUukkH5SW8ZXno2dZZdsUmtmkS5I?=
 =?us-ascii?Q?XkVPI7yCPoUkR5h16MM86a51/0+Ag/pHRa1wYBVbJsPqkscRQCyq3dT/P++H?=
 =?us-ascii?Q?FGP1aVs8buJwu2rFEQchuOL/NARlipeyVosJBrn+hVSkNAQlY1vgCMEZJrQB?=
 =?us-ascii?Q?nRg//9BpG1Ei7rLshZWMS2PctPebnQgsjc6WTRwfQeD9T/7CmCXE97uPkFQ4?=
 =?us-ascii?Q?h2D1oQ58j5EC+m/WPJQbRXIf6V2Xp2ssqt0cX54kMQ/x91WVnQAVCnD/A7MB?=
 =?us-ascii?Q?A3odLTem1w5fO21PBzwDm8QMhV7KR413cZe2g4csoWJ/a01HQGIV2Y2zJ+EZ?=
 =?us-ascii?Q?cr3O6r4uMCmeWlIMfGWnAn6E3Ev39RcplaxEBgHnSyNHdOpsot9Af5HsPJK2?=
 =?us-ascii?Q?V/kiF5leicCe8uY5TbPJkdPF3F4qxur6JOK5FTNK7URv7MCCzk4lUbRvXypV?=
 =?us-ascii?Q?kiy5c1HPeFSnk5Zig5ZybGkRr71QkRmAjgFQPLwm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d581dc4a-2546-4469-1eca-08db090552da
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 12:17:47.3976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62oCv3Kmm7KE4Aj6FDecsSxYYso1QYQ6e/zmu0evTNlckSBQZ/Rm2olB4ZDUzxsX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 03:37:06PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> lib/iov_iter.c: In function 'iov_iter_extract_user_pages':
> lib/iov_iter.c:2143:34: error: 'FOLL_PIN' undeclared (first use in this function); did you mean 'POLL_IN'?
>  2143 |         unsigned int gup_flags = FOLL_PIN;
>       |                                  ^~~~~~~~
>       |                                  POLL_IN
> lib/iov_iter.c:2143:34: note: each undeclared identifier is reported only once for each function it appears in
> 
> Caused by commit
> 
>   0ff325d28700 ("mm/gup: move private gup FOLL_ flags to internal.h")
> 
> interacting with commit
> 
>   895d773054a2 ("iov_iter: Add a function to extract a page list from an iterator")
> 
> from the block tree.
> 
> I have reverted commit 0ff325d28700 for today.  A better resolution
> would be appreciated.

Just s/= FOLL_PIN/= 0/, it is unconditionally set internally when calling
pin_user_pages_fast()

David can you send a patch to the block tree to fix it?

Jason


