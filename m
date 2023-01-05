Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C50965F524
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjAEUXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbjAEUXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:23:47 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36536338F;
        Thu,  5 Jan 2023 12:23:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hV0E5fVOWbJ7HW9JIrnAqORao5WeZzpnRzFV27DmvtlDKSQDFMZlKYF32yB4HeVQaZ+n49PSE+5cLnuQ0iTiXWBz9/Zeqx4sr30OquVGovzkhQHYp++vHLgyTd0SmNPrkc3fIlVmTB+bog18MLERkNgguGk0hG1aCIOTmWEr8Vi4Bjqqg51alG2uoBD0ge7XMx95HToWorbPoVyhpUJ1XNfJR+zSwx0OH1QwVHDmbljDZAgDGU7oyust3mrjj01wd6/dvC/yGry/EJB9s5gVs5FuU6rxOuVWNfBPhEzBpJeSsS7zPV9ykhq0OpwIEKc9oSlF1G2S/0dMYKECm5JL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCPTyArg7F67jvZzI6slvdkHUhycB7H9egy0tcCHuoQ=;
 b=UU7CH06jp5iRqm3rM0KWQkS2G60EYZDYFgswf8pEq7AqmrAWbyox4QMuj108KUhXXwJoFoFrfZiggMlVnHkwV4yX+FIrhS2p47oiy7bx3QRcOgRyZ6QPVyJDpHTZpgh2Zms6Okir/cmQ0Oi4CunPES/rIQ0SpmxXomSvbMwJlW1ZOBMwV+KmO87v0teOaTAfRgt0/b/wZBSH/ssO6pwfBY8imRU4hiPUwaL3Osprv1xqSGUyKOlb7wnkBLLkxv9nEUAbbsjelwRdkQzz7jWDPPvPnIjAyBpUI1rcRF0YTJ8rtcwB2+DeHXeEVxlX7fk+8y82DGULm2RtUHjxz61JVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCPTyArg7F67jvZzI6slvdkHUhycB7H9egy0tcCHuoQ=;
 b=nNZCuT66x0TVO0nQxe51RcT+LHGt9fzL3B3FCgKb57IR9Hpz0eKY+tWbpmklXWV9PUIJctyKzvugUH57LS5jrjfMtFSPUJx8Ap2j1HTKvrRXp2M9Fq8z7IFf6D5BZJSbsyn1ySbU8A1LRTiXlpVtvlLOGHny8tnn1ljrXpuYAm85I0mhX25yjZMhzF9WJ9VtbKpXBXCR/QOoohsFvMYffcKZHfh5JYS3hkTmOgWDAKyt9e4GIXQHQm2/5eQmQWojuWzw7jL3bqzAkYKQUuGzYfeKLVDqeLtMWK1Zo/1UWUbJwfMw7Q/T89XY7/b2E/fMQo07aPs1bfjONbW2C2Q53g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 20:23:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 20:23:40 +0000
Date:   Thu, 5 Jan 2023 16:23:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org, axboe@kernel.dk,
        logang@deltatee.com, hch@lst.de, alex.williamson@redhat.com,
        leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH] lib/scatterlist: Fix to merge contiguous pages into the
 last SG properly
Message-ID: <Y7cxzPVRJAkQOk9X@nvidia.com>
References: <20230105112339.107969-1-yishaih@nvidia.com>
 <Y7ctsw8ffhSsBZ4v@nvidia.com>
 <Y7cxVx3qGShReJAZ@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7cxVx3qGShReJAZ@kbusch-mbp.dhcp.thefacebook.com>
X-ClientProxiedBy: BL1PR13CA0413.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c350a6-819c-4ba5-0d00-08daef5abc0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvIVGVyExmJAw3CT9Am3wTKpQDEUVn1b5I/l0XlAoA9c7U1+T/uZdBzaev2B/OEJAdCXzTNJYtM3eS3RBU0X946lyOAsPi//bdMIH/WXMC4DLynUW7LFkhyLr3fLjKFL0pmK69D74hQOoOEKTQ7xvIycUsdKOZd4I4dMTkqZTsRUkBt7i6ND1UKLLiErG5QFMsSQnJHIplNlta0gHiazQgyTg7yvBdWe+KRp3LcIKzI8Nln8PNG35feI0F6dN0CncfKx2raZ96nN9ShJ2Pq0D1JpNV8ze7KkKbpZ7TPpI6YrFQCqLGf0duZJOeAV74XT5OTsypz0MdfAAqvTndolaamzymWDc1wCjVk4CIEhqqXYmawBy3aE+7u9rbdy7GgEB/aWdCwkrckmMGNsbYDZh5M69cYRpvgZiQx5BeAxUyDQsZ9+wqF8dvRtI14UUyfOBBCqXVLYNxk4YJEhtE4yZprDZNfHCAJ3a6rSgdx4vauVaCQPBZLc3H6C/GA9gUaj7hZ1bcUMkupTpgmfFbYd1TYgk3zSw30AcGdoaP900TWu2r+wzYQ1z3RtasWZf5SeMWzy1sYyluDEZ2qYFPDWcVFa93S/Es3hdEmCNxAZ676kwW1Y+2l5iEsUCA/kyhOYRck6+v7/pNt7gcCh/xQzAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(83380400001)(186003)(26005)(6512007)(6506007)(107886003)(86362001)(36756003)(2616005)(38100700002)(41300700001)(4326008)(8676002)(6486002)(2906002)(5660300002)(8936002)(478600001)(66556008)(316002)(66946007)(6916009)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?urNajaej1iXcWA5laSdq4kty0P28in/b7eZsq4ko0QiVQQEs43ZAfGKN+D+H?=
 =?us-ascii?Q?9ustzT66b50JqKcTCzNuWHFEqgmo0hzPEZFWrfqq4GVVSvK1YIzw0Gr9SM5V?=
 =?us-ascii?Q?0sd8oCCqz7uI2nJo27F/OT16+mpJrmVrYbUyfVOlgAW5p/2wgPEt0N0Az80D?=
 =?us-ascii?Q?F0nvsvnLjafrqnYQhnjOv//6M7z2QPloW+s8FpPZe5f7qlv1yuUMdwLHRXht?=
 =?us-ascii?Q?NO0uJhsVJNaY1KMPY1QVYECeH431gQ239hkFIsZoAkOk8DbzM1eGpm2DmHTQ?=
 =?us-ascii?Q?6aWQmUZWmfdDTtV3D1igFWwtn4k8/4mPr9T0O2i67R8LlbC2ItiFQiPvDtGw?=
 =?us-ascii?Q?vmVjlSqWwbqkjYV+UhZVaFC7hyO+0mjoXVKI0PJC7FA0GXziWLVKDtvGrDPW?=
 =?us-ascii?Q?9pCqUn1UatJm/S63rDT0SucL/LA+3nNI+XCJM8NYkeUwiANDvaw1Z0hpUjkd?=
 =?us-ascii?Q?MiCWNnqUXOIwHZFDlZR/heP8HkgRcc2BTj0Gbcyl/WNqLUzRxWWZb4Qn5jsb?=
 =?us-ascii?Q?+0BGwZonjlixuj7TBCIwEcjVQGU76gexudKm1TltQqDQ+RVRiFTQ/agv/Rpf?=
 =?us-ascii?Q?C39KZtkRqzd3J3Zmkwb2ggBGphRDKeqlbmHIwHJhFMLtz4h5QcSL2At84UJX?=
 =?us-ascii?Q?l+2wJu7J948N3cSdId235uUj/frAHPomzMRnct7bu6wdoQtrr7uPY2/yOUiH?=
 =?us-ascii?Q?UTnvZMldtAQxD4sP05yfZTbEFNfaf6ImEE69ssfiSggiJpgJr9QWPvElHxVk?=
 =?us-ascii?Q?QweTSLArJTrzNCW+krZEnZQ8SJEwoAYhELF4OcpWAfe8tTCLcFOGY0P+B64O?=
 =?us-ascii?Q?ACn7FJ4ataHM94Uvg4yGYt6Mwq/WYCnaFqxuU4dKnCesYylUjFMZVCB4C2l6?=
 =?us-ascii?Q?TUta0+sDlMBf62hksSQV36+Ow5AGwFrrZljQy/YhZbonNqNiAx5n7yGw5Zb0?=
 =?us-ascii?Q?UiaHFcCxo3Pw+HqFLIY9L61oBKWOez7bxjudYD1qBms3XMnU3+/zc1aN5i+d?=
 =?us-ascii?Q?uzdsmigTcD/Oa9N+1nsGHcsJNtQg6V98x7R2Hc4i9bETZ2IfU35+5wKuZpmm?=
 =?us-ascii?Q?KTT+77KRuRdrNMMrIAaqn8aE7DNnKANxmddYPyOQFeOtMs8igxW4C2PRyYoV?=
 =?us-ascii?Q?LSJR9sf1wQ8WhnMccdJTv/kwUxZ/amwyOob87r/qqTbKZWWhQhTZkyWN9tMJ?=
 =?us-ascii?Q?JXzOyVRe+TxObIXAK9dzIDaM4m5HPvSjHtX2ijRYXfk1VzKtMhlQ/DSic08W?=
 =?us-ascii?Q?H7Qo3s+WuBio18ZnXzVW2COhc0bidJBI5lv2ivSOnif3DwICZUJLrOvr6y3v?=
 =?us-ascii?Q?hIGOOjEO7hB+mogHS12pqPOVmnE5KHrquo3wqR9YCf3xlOUT/illLqdfew9h?=
 =?us-ascii?Q?w1WctOu/Nv62YuM2cwttXMuc5DRIV3BvTXq6xSC8icAkKcKWc2PYsCWJ8Ik/?=
 =?us-ascii?Q?7jx03Qab/kDDmGrwd4fd1U/SRJXPhr9pJaMQow3cxPymwfE/cuhDdPX2m96+?=
 =?us-ascii?Q?NqQ/05SsFDErtOe0CxIurBjSODbYEiKPiO+UrBl6JULa3FcGYQBw+j+jq3p4?=
 =?us-ascii?Q?AxTYkzKjQKNxDeTkUzYVomIwwC8MpHE2UNigRF9A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c350a6-819c-4ba5-0d00-08daef5abc0b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 20:23:40.8544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xqd2h4h239AUIAfpc/vLEaucaJ+3cgBmrLX+n5YtIqI7509YIZG3v9Do6FSR18Qv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 01:21:43PM -0700, Keith Busch wrote:
> On Thu, Jan 05, 2023 at 04:06:11PM -0400, Jason Gunthorpe wrote:
> > On Thu, Jan 05, 2023 at 01:23:39PM +0200, Yishai Hadas wrote:
> > > When sg_alloc_append_table_from_pages() calls to pages_are_mergeable()
> > > in its 'sgt_append->prv' flow to check whether it can merge contiguous
> > > pages into the last SG, it passes the page arguments in the wrong order.
> > > 
> > > The first parameter should be the next candidate page to be merged to
> > > the last page and not the opposite.
> > > 
> > > The current code leads to a corrupted SG which resulted in OOPs and
> > > unexpected errors when non-contiguous pages are merged wrongly.
> > > 
> > > Fix to pass the page parameters in the right order.
> > > 
> > > Fixes: 1567b49d1a40 ("lib/scatterlist: add check when merging zone device pages")
> > > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> > > ---
> > >  lib/scatterlist.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > rdma is pretty much the only user of this API and this bug is causing
> > bad data corruption, so I'm going to take it to the rdma tree and send
> > it tomorrow.
> > 
> > Which raises the question why the original patch was done at all,
> > nothing ever inputs pgmap pages into this function?
> 
> This just takes any arbitrary user addresses, right? The user could
> provide addresses from mmap'ing pci resource files that resolve to pgmap
> pages.

No, it passes FOLL_LONGTERM and pin_user_pages will not return any pgmaps
in that case.

Jason
