Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC53E5B84DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiINJWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiINJWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:22:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD0582864;
        Wed, 14 Sep 2022 02:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqjEeCuWxNA1snZzMK8Jk1nvl8dF23+mYL1ncRPAr1KsJvxWGqq9heM2jU/zgnUeDawxoaRqMD4ktWp+pJFMAzNJdBmBLklnLkKnenkLMHrv6g193FQWS+q4SRpwsS/AOyKv96k30t4+Q9iNQFkffZyeDJnnA9jiDLdYOuR5uSN+mwJORD3LZnHjUamx1kmnBKQva6jWTo4ZUS6x1h6yXXvVFI2I+2G5/rNwrVotzFDv9JLX5RUuSU1nzmMAKMHNSqyZuWr6AEw3WlEMlj98bn+PQ98v5X/LNV+qvXvFXTxjzj8DWufXl0SNatloZIpj3/YknAlemFxApzjPKmd+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CgdsVOtwexyJHIaVRRSoHRaL4Shu61nh8PFdLHvq6U=;
 b=NZhWeQ+1yF2u/OD2I4zTpi27+04G5uha5Id+6qT/RA5SdZE9ECG4C2YNt7MivDFv69fPZA4noeDhQ3pF3eYd/t14aVV21YYxiZY0GJzgiusUgzifXk9AYdYXkllBe8XcHQC5Pp+mAdl8K4dnDdH3Qkn7rb9+RENgZne1o5h+5nK3PuVFysaaSxubDFGwV/foPoUeQulwhf+GtHt4wxQgTL2JdwiMtkHW3HIdz13JK/yVzhWWhcPQThLNElI6VELAoGVNqn4GPoa58T9lUSsw1+F90O0CPU0D6tnVfhjDQi9WFSeZw6I494JrYckg+DGZKqPfOljC97c8/OtffXsabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CgdsVOtwexyJHIaVRRSoHRaL4Shu61nh8PFdLHvq6U=;
 b=fEqj1J1L3y1MJZKRVpvcejPLZiR+auUGkPH5SGZPO4yaQXKO0djByEvi1AbAMb9Lzs7dvVaArcvv1qqowQi7UX5tniy7N/Y+IBa7WMlqV3sfyUdgbbWnSQr0Xe8Fns1c5SxxLdBBd+bVaTxWSbw3kn1DtKFZZXcRffHzcm1vOtF9X79WrplifQnDIFl9mEECSHZsrc7aTKgWztAO9YmnCAdMJTo8AfzN22ZiWDXnFR0Oc/H40/b/G9F235Tvr7EsWy1oIpU5hk9pgJrAnCEAamZz8KAELcTzzPS4NCkCNTil8LMQcu5uX5kvcPioM2UwyrubrHaW8rEa9/HgXKY3uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 14 Sep
 2022 09:11:10 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 09:11:09 +0000
Date:   Wed, 14 Sep 2022 06:11:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, robdclark@gmail.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        matthias.bgg@gmail.com, heiko@sntech.de, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        thierry.reding@gmail.com, sricharan@codeaurora.org,
        yong.wu@mediatek.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        tglx@linutronix.de, shameerali.kolothum.thodi@huawei.com,
        thunder.leizhen@huawei.com, christophe.jaillet@wanadoo.fr,
        yangyingliang@huawei.com, jon@solid-run.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 4/5] iommu: Regulate errno in ->attach_dev callback
 functions
Message-ID: <YyGaqsXSDMn8R12R@nvidia.com>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
 <20220913082448.31120-5-nicolinc@nvidia.com>
 <YyB3F/o3RfymqiFW@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyB3F/o3RfymqiFW@myrica>
X-ClientProxiedBy: LO2P123CA0026.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::14)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 8993b424-dbdc-42e3-eba8-08da9631101f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xp/Vf2W6Dv4jLI3CiFcwINcg81lQo83AmAS2lNaa3poF/e4IRSQu8qhd3CYzOKoVG/dSZ8EHBDt2SbPQ8No+eheKI7kfbQhTkvgpQpjf3Z1EZ4Tct1T1PwnjxEz/BtnljGbySdondzsWP/wmrIhrFWM8Gs9l55atzuBRj3vQXf6+S/5QL49kTaZELNl/hl62FglqYdn+gBHmPfkFD7y5hEpWpe6kLr8770+fa4HZyFhdwTEocNoUcbMWmNTLpxds3WTmQXT9jDtV7ALW7wjo+CbYOgL8AfqHPQFNzP7F21VvG6U9pjJE7pFmKNUgCSE6KGTTBDJTW3AfTil31SKbLWZGtLL3b7oaexzgOlzQR9VBvRonXtLIFRoqHczDSa3oIw+21IRhtVrBnfrqLRmtZPrqPvEkvhBGb1pObKR0woct8kMNPG7ZQcCewXJgpV9oNZ/m+/Ru4+CVDVFihnTwNkZq2thqgPqVu+90TtX1zxirp4Q63eYDp1YMHB41pI/kgCHcOqVm1tk/1+GEfctBrSGqtXvIGby2zYaU0Id1gFH2gX2ubqhEJw/ib+4vZxEzSqSzS3JuegYm2HqQfHufv3+172NuExuoh4jVp26MMUAt4alH2IWvBNRr7zKXI7ulzqge7PHODVNqL9FlQorgE5XKV/iVtApDMIhXQC2GQitGz3qqm861gzzXKN4+LoNTSvyVSPmAOJwmxCxlA7ZvQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(8676002)(66476007)(8936002)(36756003)(6916009)(26005)(2906002)(41300700001)(7416002)(6506007)(86362001)(7406005)(5660300002)(38100700002)(4326008)(316002)(4744005)(186003)(2616005)(83380400001)(6666004)(478600001)(66556008)(66946007)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7sDx4z4Ei7YWZg7fYs/La8uFhZkG4yg9yKcehgdk4qTHh62sxfvKknfRe/kg?=
 =?us-ascii?Q?u9+4y7SrTM94DRmNj2rvSojKXt0U4IuRCVZweYfM205vvMfA74JVt06aJ3Sq?=
 =?us-ascii?Q?GqfDODwQQP8dpzXaHGTMOjM8FPPZ1tGP5BIElkgj40Qm4UxnjgL76xZvghpQ?=
 =?us-ascii?Q?nFMJryeUBHTevipDajW+9nhzRfOoF3MjXiMdID2W9fc5anr+GE86GVucHVpr?=
 =?us-ascii?Q?D3eWTxb2bwg8RTyvNLPGetIYOVaNlR3BlPnqY/C992SIDnjQ7ER/8SuUOfAR?=
 =?us-ascii?Q?J7sV5qFPLEqRSmtR1bBfGkIGoFAPLsE4MY+Apc8H7p1C6IjIOkhCqOKBx0Ym?=
 =?us-ascii?Q?M+YEIyvZgdxDl7iJyIWVcYxZL0uX08Kg8lJU5iHh3BnylmgCFzBFvJqr4u4n?=
 =?us-ascii?Q?y+QJS824H+UeGFLu2HEtYx8AksqI4pkaSN6NfNOLw/KFBiqA6tOyZZJvoi+P?=
 =?us-ascii?Q?OCtgH2lbXLbdN/kkHvD9NbUhkdLuPnqtKbvCCJImSYKjlDcZqEGumHZZTUxQ?=
 =?us-ascii?Q?hW9fLZnC+5PIkBsrPg0zTsrrikMF77z1eBrDr/K5AF2htzEC7Qw8uUd661hE?=
 =?us-ascii?Q?6sY6vUsYThczJDulIUzuRO307pki++nYiR8WuIs8tfEYzYLhIfPlg/PjpBkx?=
 =?us-ascii?Q?8U/u8kE3FR2+Ybmt278u+3JNjweTX75oSq1TX669DsamxEzsjTdfpwcn7SWj?=
 =?us-ascii?Q?pZbPcFw5+JwteMC1nufH4h30UnskdinOlG1gounNulJfE0aq9otqz3o14CpL?=
 =?us-ascii?Q?XRGFlXvrzmdQrGL61BEbquKtyyOHH/gH8Kr+CHUFbKNZ2WRDvQC1zNKG5xpl?=
 =?us-ascii?Q?0Obe+Kyn6QFq/vsYSySoM0+zVwgZgQyibbuNovbQqMMONRkRcGiKdGgYtaRT?=
 =?us-ascii?Q?MkBpzeXg0s1swc9RVeOxFRuZDdhVLhhIberp/szlV1GdMWYLAtfbdtXLMn0q?=
 =?us-ascii?Q?Qyx5HDhi0bPuf6NmoqgrYI22Az+9nISNB+/12sxTHyAx8tQC6BzLLk7fqroj?=
 =?us-ascii?Q?4GeyJLlJu1YctjcFvt34uoUzMKLIqFkLOUPaoQl9YJ0VWdTOyZcDl3Wasjmr?=
 =?us-ascii?Q?nym4KIrgK4+IFNtYHnXuncFvLjKupjVWsxOF0duAk5JZMWxkm7HJmMh4ZU5W?=
 =?us-ascii?Q?c5M7/hsUiej6+tVhrZEn+L3xn7X61XSR4hT4Sso9J+Qji1EzWD8c/kwcSB78?=
 =?us-ascii?Q?RRYHeb+GY2CB5mwZGtZFmT1XEFzPgkPwgEWwacPOd3okgFKfhSxq6VkqZR/4?=
 =?us-ascii?Q?/wvF4OaUR4A2mHlDif8/h2Pu1skKTeYl3gur8dhEiAvdmPVDdZ8o/tVKOLC3?=
 =?us-ascii?Q?5j7fu3WX0MCHNYmoV275hUwM0MuAECkp1tFURVzC2GLl8PswoH86QYCQ9Yxk?=
 =?us-ascii?Q?6kRiubA377OvAyC+5GePz+nnA4BAxdKv2wzDfJpTZSqXY+zTCU2iEiKzo86h?=
 =?us-ascii?Q?6ehiQCy5lpIHdGL+qrErWZZ+2d1nAdjGBQHuvEhcb6xJXkH1C5KEpOnc4xe8?=
 =?us-ascii?Q?YKcQM8xK/iDv6AxAg8kumGeJZKTfVGmRhiooeecHqCMk0S48Z0RP6A/LAsqo?=
 =?us-ascii?Q?yhHC60Z8iaULCZmO9qU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8993b424-dbdc-42e3-eba8-08da9631101f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 09:11:09.8187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwxDJPdoj1wWUg2vxnSAk5/ijr1wZOZ1FiLVSz/Y4qBn4BPewMBS2mvVrKWDHttt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 01:27:03PM +0100, Jean-Philippe Brucker wrote:
> I think in the future it will be too easy to forget about the constrained
> return value of attach() while modifying some other part of the driver,
> and let an external helper return EINVAL. So I'd rather not propagate ret
> from outside of viommu_domain_attach() and finalise().

Fortunately, if -EINVAL is wrongly returned it only creates an
inefficiency, not a functional problem. So we do not need to be
precise here.

> Since we can't guarantee that APIs like virtio or ida won't ever return
> EINVAL, we should set all return values:

I dislike this alot, it squashes all return codes to try to optimize
an obscure failure path :(

Jason
