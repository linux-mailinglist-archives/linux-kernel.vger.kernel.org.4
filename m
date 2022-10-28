Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F2E611666
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJ1PyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiJ1PyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:54:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A3946846;
        Fri, 28 Oct 2022 08:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3TWE+afihhaANl5ZmQjinVi4hBdwKnTXzGk5vyYyyXz0VSeBxqDSPrF1rjEhEEoZJ2/X8An6OH7I0Cx9jVaP6KTJlkcNSHbquxLKC5oSR0MAoaxPXYVSk3QOzNWzb3AGNenWn44Kmggnxdx9IKQYhfHXgTVxxQuV+fScVNHCECQh4+c8ycvm+LX1Dy/MTWjjGAX84em1LNXUvAex2m80PUCKppmhbiFW19c6qEY8fEUdk2CLfW73eth31TsKiJWjvXhimqtwvFpU6BNvDxsliiQbzjyYW6p9t5ZFmvYdZNQ7BxDY34PLUg0JNptFmbsIessQHjScdWE5M8WNoGs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqAEf613Jgy5NiQqI0HbJ36S2WxfxrPKZfIpFp6NJ68=;
 b=jtvcVR9gF5t9cYGGhpjYRQihFsEo9GZGOPNYftO6ULw3uBPwQx9VM/9N+veGv5a2jQ2bURdI7YTCp5trquEM/TO38T+926Z+8Bl7Zf8LiBbmpmSDOesRL6ilUPEa3soG9CYGW9jUi4z09gm7ZTUOjjZ/6LEVxHksd5dR4zCrsGeEhbBuzxYgZ0HbMDa1ZYKtnTCF96dxZFt4i7gD8PWVh38OLr4wNlqUG5xnAjXbbAYY4kTg894hYEZ5looyOoABcism7lSI/jekoU6HThChWGQszrkOLDvR8+bFgLYZbcbQp7PRB38sVjfI+VbRlUA1haWji2V7kmKkd1k4ED5w3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqAEf613Jgy5NiQqI0HbJ36S2WxfxrPKZfIpFp6NJ68=;
 b=o7dNarqY+M4zYcj4IlYtwZxbOsnRFPC+IjitUbYBUOq/MYSKkbMSuLNr9+JUBCHpoQXxcOby8UL3jat3FMyXhmvifRNyhNVwoJ7bHKemkFzFECM4OW2xaGPTVlviGhrgL3bg1DDARS3p/MKguOjLtoTAflwijyfsZcSo/m5EFtcMDIEhDdqdeILd3HBMARbUJJ2xrnBBsveGszZaFBlmqhbzPMtf0E2ErmOYOp9ZtAqpnMAWYSUZ5ABPTSGAkQ2xgcm3hlGpJyMEX+nu6O30T/iusQGi+kF5UHqPNZpx2/el53rkQCJsaDjh/QH8iZHOsn/n9w5DF1SX1sKo+WdNXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4972.namprd12.prod.outlook.com (2603:10b6:610:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 15:54:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 15:54:05 +0000
Date:   Fri, 28 Oct 2022 12:54:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rdma-fixes
 tree
Message-ID: <Y1v7G01lpV0d36GF@nvidia.com>
References: <20221028062339.44cd0f11@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028062339.44cd0f11@canb.auug.org.au>
X-ClientProxiedBy: MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c41ce82-a45b-4b42-b38d-08dab8fca403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+bAnMVl6Zen0W6dFAWIwfWfk9sg7qcYSfofswEHJeU7ub+c4umublDwkLSWYG2OmqKxjMUq5SjYMwOEZzP3f+0vXQbAt5onEchzhnUFe+sRr7N8OY16yJ6RUIhZrjWPVz+1skIKFkc6syUUlTlFb6v4+L9XCQhIQmi34F+sPFPeliw1NvsRltLC+yVKj4e97X3QMXqarDxvPOymNsZMaH3OXinQ1irQThdocAKqJXU5yeDUsgR6LSwSQ9gDoHfmLlqOOlZu1M6hMrHL3bHpD+hC71VOd572mBk2RNILfYZ9DlGFq19MiAuOEYj6cvOlvRMvFX/eblr+6APCqSihtL012KlkO+c/Ls3BYAYooPAC/da7Dq0mx8f3lfFTYvOx5eXthACqUfTaQawSNAIlFmxpQ6DPEWbF1FuygWN3rTh8kFiBPZHv74siHFk3ggbAOgLwL7fJYBr5xwZJ9J35ZmmO6sgDnWSCJZ8p6mXESolh+HkY9XY8ee+mmAwKXZftz/iSMrzcVLo6djpd1R5/8sKh7Wa0cOtnWusdBzu/kQ7nIKcHy5KiPd8XFAZFNcfSqGn4MvVOQLZlQXPVSqia4Kqc9lJFsd9F5KEivf4PEXDtQwqyHVjpyMDsagXoCUD2su6XVeW16PBVS2RcUKLkK+ISFr63w1LUxXMXXeUTkCyFQGpLQ/4mcOX+bEj89dHzJTejne0fbC+vmhN/5IJ/Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199015)(86362001)(38100700002)(66556008)(8936002)(54906003)(41300700001)(5660300002)(8676002)(316002)(6916009)(6486002)(4326008)(66476007)(66946007)(186003)(558084003)(2616005)(478600001)(2906002)(6506007)(26005)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h8KLyuYNUl/wJYKCwEByqPx9KLqZLfz2dgxISSlX3RdI9ngKigl5/zIydCaW?=
 =?us-ascii?Q?05ByXODU+fruwAQh42Y2OM/7a09/8USBjHhSGvyBXy5RCWFyXGSTgexDYl6z?=
 =?us-ascii?Q?9ERXnsf67I5wc9Sr1/neAZCVQRTdFE58Fj5raENUOsg79HYxnu77SkG55G0A?=
 =?us-ascii?Q?WzkUAxGqpPOSef1Qtmyf49LPR9pF00kltg/mlr0Rr6nKPR43ix8Tu6UFtU+6?=
 =?us-ascii?Q?TFoN/57WlTx9U2ziajMdqSAZxFXt28E+pg+47utjAHp3xHo/5yf6VS+MNqVr?=
 =?us-ascii?Q?W48Z2Ek07EjsGvebQbzzA/EgjCnBGgoMrA/QcOcx9HTqaNnj5EfzA50sbMD2?=
 =?us-ascii?Q?Kafg6StSLd0PKiu8vTq1nnJ+fuxfa5sSuPTkjXfjatk7KhoM5C5RCHpt+7FE?=
 =?us-ascii?Q?TdtLcPtFk9rry+S6P/FjFffbiLL08c2GwAM4PUlslCFw2KC/GWKHhHfUHl0I?=
 =?us-ascii?Q?ImQQ39gGwY7OUL+RfZAaIWxzOFlfNoT/DFF9sEtdrwzq+N5nMyyHy0wGtYky?=
 =?us-ascii?Q?tcqmsXYzoo1bt9ZB/eJwrggJMBzQCS2YxABdxIcCJqeuzY6N3TE4CNTnSbmF?=
 =?us-ascii?Q?Vv0njY8EmkGt9XTUCjh7shYrWRPBQYFbRSy1PYmeAMEIhRwWGBXnYDbVshDu?=
 =?us-ascii?Q?jfE5vvKkVU+x8Thqhp/4l4Ep3giWJ/R4lopjj1RH4uBlcISZgRoV+1We2BdO?=
 =?us-ascii?Q?kc1Bm+Y9uZPFb1JTugO8wURGglPcmyCFWtt1HQL7FfHipv6h48Ptbb6i+Fnp?=
 =?us-ascii?Q?EhbQwHdBRLLry8t7bIZO4Q3qXbuWiTISjpg1eRGTIfYzHPvm1OW9nlCF+y7q?=
 =?us-ascii?Q?y0Sqxe1vNdByMwVe1DEHgyMGoVPHxXPTQN9J6acMxPoRPJmnocmAgohWxX+r?=
 =?us-ascii?Q?FzAfsdrr2NuoIJsGDIH1Z8eGNO2msJdTIqcmokcn2cnD9hZYqAIxLiRpeoAW?=
 =?us-ascii?Q?UOUoS/FC482Tj+QnFEsbUMHlfd82PDW5TaWoJ5uZAK8U0u5ErsMZSVx1UAP9?=
 =?us-ascii?Q?P8hgBexIDYEXcfHcp5oYxTxeztI5BRMWC+1iq96em+MZ4DkF8gME5915cpnG?=
 =?us-ascii?Q?YkEMXtoG23a8rnStfzI0rQJooK/GiDIo6gxNCpIQ3clIPwb4vO90ldPYHsIK?=
 =?us-ascii?Q?Py0jIv1Q5v6T1X+w/DlKbYRPmCuBCrpbzUul/q4fA4DRvC09qSmXnNJK5Pf9?=
 =?us-ascii?Q?kW7jhVMRdVDSUETRDVGPv1DuyA6U00R/xn5rJzhY5gnnMzh+InLQYuE/0YVv?=
 =?us-ascii?Q?/R5bx8f4vRhzFaxQVu4FlQBWnX5d5dRs7/tVk/Q1iih2uZqhCg6EftdCIU/6?=
 =?us-ascii?Q?Vsdt6s/6w3w/DtS4rbIP2bmvpMCttBJMupcgJ5t7ZAmGPCk6nWx3SUMoVD3h?=
 =?us-ascii?Q?JgcfoiGJ5ZQdYRRnG/BUmaiDP/tNxiAPxjqoOtUfN1Z5ihdZzrHKXgFPmE4M?=
 =?us-ascii?Q?2ztcRoaGxBTm4WUA/gQUVFTDFtFJQHdDEVLH2sa25VaZZDzx54WEa8ZYmsO8?=
 =?us-ascii?Q?yfkjU7IlwyWq4+FdLnZJkmVCPyv/Mxd2sgjBn46Y3tLxYR+K/x88v3kQ/VbQ?=
 =?us-ascii?Q?acn7QqEaPrHlSsFySTc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c41ce82-a45b-4b42-b38d-08dab8fca403
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 15:54:05.0271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7i1H/QP3bfCJoFdv3sg6RrT3GrMMgtsrfcT+8BGzKXs5Z7mVJ6jfT771/N18jwR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4972
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 06:23:39AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   b45b6ae88fe9 ("RDMA/rxe: Fix mr leak in RESPST_ERR_RNR")
> 
> is missing a Signed-off-by from its committer.

I fixed it up, thanks

Jason



