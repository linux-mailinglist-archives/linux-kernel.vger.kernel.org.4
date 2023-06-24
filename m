Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BC873CBA5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 17:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbjFXPra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 11:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjFXPr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 11:47:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2109.outbound.protection.outlook.com [40.107.94.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353911BD2;
        Sat, 24 Jun 2023 08:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4KIlYMhKTuPE0V9nNllCA8mYp+N1xCef7lSzgc0cYjNhB8J+Mt4hD1lM2FKiWx0sdExIlkcTpHdErZsnBBR/Hm6rlMYkcx1NpFX6h5ZioVvvtJ+UK8Qw4QSV9U7YnjTBCXn+xc/JhbGBSwtRny2bS1CESOHSVTLqEIHgfCqlt0iOrtyyO8lo7TKs1S440RpWv9a+gD4yf4p13XUQe9kEcRqNXHc9IzAlrVCEGq42J8+kNgRPK/eqyX3IRx8WvIxILEesNUL8hKYupTxsnfg+0zYzR6g3ZgRfe1gz3zVHqWbuhVm6cQUp67Uzixf/bX56MT9ulJGD+Jw02XJTx6mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V93s8n/DpaQNRW0661fpqA17p+Qv7FrV+MFz4fv2IeY=;
 b=XRELcpBN4uStiz+cZKRSZ2CTFjdOsTUzOCzfAxhMPl5xDffabmWxqVD+OuMGKaFv8gk9cpY6xJz1P97iDyPG0O3O2cKPuQKIuOdAN4kW9gnwI6DVF+GDRgsSfzRhMI/rKAbIapmaC89BhyiNeoN9RN1a9wOEQl5q1BqCfCycviWDGbJDtGvz0f/3oQnluJUFpS+XXQj2LE6vM3438h/ymyOyAwRm16FOlzRyIBt1iu0K/QeDWO7iA4CbxLjnEdgxgshgrVO8vf+fyf0TITsUa/XIQdTbIayq6ktAzq9Fwzwo6rC4Cq2O/++1qiAdpQvRAkDFa2vOT7foEQgO5jzRqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V93s8n/DpaQNRW0661fpqA17p+Qv7FrV+MFz4fv2IeY=;
 b=uOGpQs2gbVtJddznFsTQaPvIFcol++ACH4pPPm9laO2+YEp2BNgpMCAZE4Mabc0FsPvj/QmV8wOPTHomdMLepcFf9w1DQ67ersvqyNCE2njQfJZCmmx132BU2w73bsDD2KORFTV4ombyvIqAeY+y64GG2S/gwxO89JtaaSBclzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB4895.namprd13.prod.outlook.com (2603:10b6:806:188::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sat, 24 Jun
 2023 15:47:22 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Sat, 24 Jun 2023
 15:47:21 +0000
Date:   Sat, 24 Jun 2023 17:47:15 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Jeroen de Borst <jeroendb@google.com>, keescook@chromium.org,
        kernel-janitors@vger.kernel.org,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/26] gve: use array_size
Message-ID: <ZJcQA4baHKWgo9zV@corigine.com>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-5-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623211457.102544-5-Julia.Lawall@inria.fr>
X-ClientProxiedBy: AM8P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::19) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f2beb5-2397-4c43-5e20-08db74ca4c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHXYHSCEvJf58MOlIZCoKsNnLpjUVk7OGfTN56NDDyqA0fsSLL98ps2sslA4V5KU/vL/mQpRrh0xYXw0U9wh6Mzu4ViWL3R66Q8QnufHZY9FomdDpsbSiLB0GXly/nVHoN+b2j9u2oJodLHb2BPwiFxRd/KndpWA0K8wxmFXK+6ywZDAHHvuEKC9ybLof5T3ik0PxFzdoB8e4hhXzn6hbnRyTdc5LH5D9YzyTevsUeCGXCBWsxlLS72QSeqe1PgdB45JPF8w2ZzajZxAZU3CxrkRm37on13VL5iOK29Xepgzs6eRrgJfDciNhkPZKt1HRbkyZ6iMz2MvvoUvR6GUPK8YdIxxrt3Bicw5XhmWWKlTPY7UKutemc8AnCi4NKtzGF4SQsxwSNveRodlVLNx1RVfxxyskX8Q9xFXMJ9WzMdCQNun2HG043NrWFMNnivrVU0e09Y8hpBTgQmzqzSBD1EC6/gPNUVg1FDkhy7dYXgW5pPpm2h41qcGIpsiC8pj9DJw3ToxT9F4ILuPSbJFGlkyon3CdA7rUuxCtHkQDb2JZItlPv0ZNf6RFhq5wXIT1mjYPQT+8v00ZEFegqaTmL3PkgS/GQ2z9wJQY2RU2QU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39830400003)(136003)(451199021)(36756003)(5660300002)(44832011)(7416002)(41300700001)(316002)(86362001)(66476007)(6916009)(8936002)(8676002)(66556008)(4326008)(38100700002)(66946007)(6486002)(6512007)(6506007)(4744005)(2906002)(186003)(478600001)(54906003)(6666004)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WUMM0BfyAJCxCxTRf/cayYvP1WaBsXAeJH3rXep3o8+5vfXUUly8tv8f/VwW?=
 =?us-ascii?Q?X2vt+gY8swV1YJ9kYS1Z7bA1koMpCeFx4711YL7wOunFUDFIV+CAqB3fPwb4?=
 =?us-ascii?Q?up2NANTfhM5knslDzr6t6grC/2taju1fMdBHFeTK5abwzxYO1hH+YqDeM21d?=
 =?us-ascii?Q?9a4I+T4TRGfdEbyrDBrsW50T4/LbEn9TWJwma97vUizaixuiqWZo2V7E/ZNr?=
 =?us-ascii?Q?nt1PfRocJkfJsXzy/2rLhH19xP0HoaiBsUSOw6z8M0lO+luqWeg85OH1P+X0?=
 =?us-ascii?Q?+SpHVFJRQlHpmi3Rn3Xo60lklo6KkJUqD2XypxrZhZUJXEDUCbE1EqLTtGqQ?=
 =?us-ascii?Q?whnvo6yfFw8htUQGK4ksPJsFlXvYWujQZW5P3hW7p5+HkSEkmBmSVHbzoRyz?=
 =?us-ascii?Q?tGEJTtNbjn7obDXl+HjvGsAqdfX6jDj9wDLZlYQzd07FLlzhjYhWsYdq7Pz6?=
 =?us-ascii?Q?T1dlm783xOPmYAQqi1EI6z0CV3t2/bxtF4mXyLlmKMSVI31rb4RVy7uWSNpo?=
 =?us-ascii?Q?DXLoIsoQi/igN66fcUO2nGmw9IheMQreiB4kTtoQqY5P48NN/rIxKDFHXjMA?=
 =?us-ascii?Q?HX4BPRw+TE6ajui+rW9/DtHUZM2EWLluUS4jpweqiLVNXkRc/1wH53IWihKv?=
 =?us-ascii?Q?Li/qlMSCas/eqhKfP0BdauPEL7sj7JRFbCY0rEubfHjHmIJZAfpBWgOBnrRe?=
 =?us-ascii?Q?TW/yzHVhpFU7/nVhts2upgQAIc+h9FnzT5FyeY/FsoEIQs7FvWignrITir/0?=
 =?us-ascii?Q?EIvby3QAGiQQ2k71iP9AwNh2UJQs8yQqU5nkLZr1hhIWaaU9J8VxjTMNd7+o?=
 =?us-ascii?Q?e2s830xCtELUktw4Kcg8nLk9OUREFBJ+U4b8UKjjgCJkEgs+yufZRiaH2Eo+?=
 =?us-ascii?Q?nlgg1xtlELYPZc6907W8DpvC44inyUvaFj9kBe88iqpgk/G/hTzpQDLP0sZ0?=
 =?us-ascii?Q?c4f4WTPifswHZqwbYtqxBmkRtNUARDVObgzTZX5LOW4MSBzO0s4dPcMmzYiX?=
 =?us-ascii?Q?cgsDEcsCWVeIw/Kb00IiYvDU2ryIgxvhmW2SL7ylmmBP9FggTxpLVf7U43Oy?=
 =?us-ascii?Q?QdlIuBszChSDodEe32+j5mpxKkTZ2vM7T6C99So0c3J1lkGCwJGFgtxjLlkG?=
 =?us-ascii?Q?DTjnKcOgW0WZh9Cmf/S5TCSvOScT1/MKvexip3FVE5k/cvXrEltga3KJjUEW?=
 =?us-ascii?Q?FnTzEF3lTV2SxfRBu55lL+YSPkuMlkrprD6QGDmwNnC1vApVx3+Dk705zo0j?=
 =?us-ascii?Q?ybq2pHWKSK8eauimr/UWpuHtxjtX0+VI32gY7wv8jIkcUSLWUweydNHwEpdp?=
 =?us-ascii?Q?hwlAfJ32or0M1RSZzSmdxJ4vmiDLeluVABMaU4SD6pRdq1oUSffmRP5MDy0S?=
 =?us-ascii?Q?IQFFZ7yVtUJaKm/wUPBjsNvL5qyJBcvDfDO9IuzGcsvxxea96zbs+V4yafbq?=
 =?us-ascii?Q?SO9UJVhSxrEqyJppbP+yae3742FpcXvcnfkl+Z82/GsyctX8r5YYFaGyF588?=
 =?us-ascii?Q?TMuIxgrgbl8uBHwKCRmmwrzP5nHoy3cTxWsGJ6Uag7bla7yO6oFI/soz3cGq?=
 =?us-ascii?Q?ABLqq8jdmJd0GWHIJkywIWcDwSYtPKgnxBCss18CilPyx7tiYuC3dR3wAAw9?=
 =?us-ascii?Q?drENw/LpoCsIMQbJP7/ux0F0nZBuSwSpKRgsc/+CIQ9LmhAEXM6U8rdFUR+4?=
 =?us-ascii?Q?oLGnMg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f2beb5-2397-4c43-5e20-08db74ca4c56
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2023 15:47:21.6994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTR7EyxX9cBUvtEO8Q5sTnnGiQOqPd1Rtbx1dsh5nSOcSGhGB0t28eLj3JYXn2zg5NIkwuC+NvqVhcC8N/4KjSSlms3RcJ7+WIlhyoeXsnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4895
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:14:35PM +0200, Julia Lawall wrote:
> Use array_size to protect against multiplication overflows.
> 
> The changes were done using the following Coccinelle semantic patch:
> 
> // <smpl>
> @@
>     size_t e1,e2;
>     expression COUNT;
>     identifier alloc = {vmalloc,vzalloc,kvmalloc,kvzalloc};
> @@
> 
> (
>       alloc(
> -           (e1) * (e2)
> +           array_size(e1, e2)
>       ,...)
> |
>       alloc(
> -           (e1) * (COUNT)
> +           array_size(COUNT, e1)
>       ,...)
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

