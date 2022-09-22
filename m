Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB8C5E69E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiIVRu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiIVRu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:50:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDF7F3133;
        Thu, 22 Sep 2022 10:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZhkixHcsKV2RdzKKEG8ph8ZhIYSjXzqt5RIYz859+pyR1MNcrZE8NTHjKNGU3GcQhuOKVQci9GEhK6Imup62cgQhEpd7Str6oXKTGWhrL4mwZ7Wc6hllmbIxRVjkldLL4+QUbXaRviCq8/QqHop0blRu6mEY+N2FfEPXYvhqGqeYtW+TcHfbxKoDMG/reEyBN7w2Fmjfk3tGHv7IolohitlZyphP76ioVadUOMhLYEHCr1I5e4Rt5Xn7W58TFsYP7juKiDvs+BD+Md5OyTqV6HmmLExol5al74NIiUMfv015JMQZbuIKaVWXdkdmbwXeYM4IW285NC24saXjGTokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDca3etjMb+WI2On9FQsKOy6IvqkybpFnGrPyRXT60E=;
 b=YSopVJxbvGW1mH5BclkqHqV3YQJzF5GMNnFV7Wv39u6Kzw2wQqeUdWZVlTGHJUh/wdbJ0G1mh9FejlAFjBfx5/0iXuxUid3xAA39ORG3oq11yERRC6mt6oMVHvlI/Gyv/U8bqQAomCt8hV5nfUKAtgrL1t4vyfTG9Vt8wGGFwoVxn+7ToK4jnP/LC9ys+0179/TZE3J7pTOW+BLD+21kVedMEeMHjaSo1+QuVqoZg4yHe5kE75ws+R252U5CKimtNHZ5xgBlabZSHl9fp1K4jhrqZvl11UCQV1omfpkTQkd44mNoyl+i+zdp9Rekn+QLCgX4oUukZSzb+rWVwQKD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDca3etjMb+WI2On9FQsKOy6IvqkybpFnGrPyRXT60E=;
 b=QmwtwxtD11UfagfAdMcKZaiBeqvXymtIvBRWi3ShL25BwVHvodvsp2kz7VxWCV/YewSRdQAl7WY8zWhVtLtSk9I/BCSHoe48y9zxJDPhSgeb6BZqwassSnUQ57tcPeoX4cL08KLf49zRg6OkpPxfDmpb0JeL/ofhbLPWUrKwkiKrj8gNatJ3sGxLpyqvY0Zv7Yf4lFzqgRT1SX0GKx3FXvFdbnwBP24kkLnuWwnffVF7BQG0K6OWFVzwTbfVG5o1eQmCO21WJs5ga9EAZ/Ov7Hda75AH6QlvyqYEDhI2j1fwaWpkZEoG51onSG+ojrKeGmwuH2ezjxpcbZpIBoB6kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 17:50:51 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 17:50:51 +0000
Date:   Thu, 22 Sep 2022 14:50:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, robdclark@gmail.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, agross@kernel.org,
        bjorn.andersson@linaro.org, matthias.bgg@gmail.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, jean-philippe@linaro.org,
        sricharan@codeaurora.org, kevin.tian@intel.com,
        konrad.dybcio@somainline.org, yong.wu@mediatek.com,
        thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        tglx@linutronix.de, shameerali.kolothum.thodi@huawei.com,
        christophe.jaillet@wanadoo.fr, thunder.leizhen@huawei.com,
        quic_saipraka@quicinc.com, jon@solid-run.com,
        yangyingliang@huawei.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 5/6] iommu: Use EINVAL for incompatible device/domain
 in ->attach_dev
Message-ID: <Yyygeg+Hf1/sUKag@nvidia.com>
References: <cover.1663836372.git.nicolinc@nvidia.com>
 <9cfa41b3aceba02cacba33d86849277f5d1c3684.1663836372.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cfa41b3aceba02cacba33d86849277f5d1c3684.1663836372.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:208:236::10) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|DM4PR12MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4c285a-61ca-4f05-720f-08da9cc2fd53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8XQutagL64q3R1zWgN46DNfSlhe4n5oqfMlQDFDD9qlNSsYq0clDKBsj48l1BitZV++TU1z3MVfVcTmZiyZxrXLleZN5xF7LhmVeFzpN1VffxvF2dQnZoQULAcrEXzSK/fJeGClnNNYD2J5uSyjQBV+xXrICcCvDFAd1RaKY/TOVXzt9x4ljIh9Un9JcJP4cvmRpdWeh4/ABkVweQkN7cMkJYoDoZyoJlkM1/vzBU1T5rDgScDscRTRaLpdCkcOUzw89xMpCge5G5KtbHEfsH2oDKV9VCEX/yuChyWjg2ew1smx7W8T/irI382ej66fX8aJz984Z9oSfSs+AQ8rX3MGZLjkXfW+jetpoBu6G3OI4TytjFwnKwZzyOw0bLtN0Nbzsp4ubscDXXe5tv+mghK3Rl5CNmxK3cBld3/rOBJagg5q6KmqumxoP2JypOWxOaVxkK/F7NDIotJ6EN76ZCq+VWnqAhnA+ftfm6tk4JEWFJyx1ESi/5lC9AaPF2MXuYyMaiztT9+kvqiFEJPW6J8AR5wKO/NdBHJvGD040ckRaqiuEbN+m2Y0pf/hBivS7WKJjhxh5o4Bq5WR8WUjobgPab4wS9EwAG0Ktcod7VEXTFRFJlTls59CrzrGKaogAm4R84PgxzziEsS00WmotJf7ghrLDSX4nQupEViOHzPnhgCYOJlw0QIIedF5XMgJWizSBcHzbc7LI2f11HjOFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199015)(36756003)(86362001)(38100700002)(37006003)(316002)(6862004)(8936002)(6636002)(66556008)(66476007)(6506007)(8676002)(66946007)(4326008)(26005)(6512007)(6486002)(186003)(2906002)(83380400001)(7406005)(7416002)(5660300002)(41300700001)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AbQD7lqDajLYr/CPU0gjTg3ujdHw/rMhayiD8bJjaXRF0gcXSAvQrWEaJaqf?=
 =?us-ascii?Q?cGKraozjwcSPJJKYj78BMDXzz5k9CfzsjUM/TQ6J/V9O38ubFxdzf3ugX36H?=
 =?us-ascii?Q?pZttFrmNlOo0/2z+rPwXogZR5h0hhjVrMADF0O3fegX03Gwpjz+U2fTGi/B1?=
 =?us-ascii?Q?6MeDATdYLmYtD+E4aVpoGTwjhbqgFf7LtTDGbs+IZxHoUj2+z7OS+iEt2BOc?=
 =?us-ascii?Q?jiIJhiWP/mzQ0JSHkz4o4cEz7/uE8bEkPFBY72M/Zokuc8Hn9u9z7BRSo8bb?=
 =?us-ascii?Q?1Jde5AbbrRyjQSD80EyMdJWTchmnPLKFvBRRIiqVrMv7G41d1DDlCd0TFPnn?=
 =?us-ascii?Q?LccwmiykJtCtMgGxwtZUWe8J649LsMe4OxVOw2RSGPzfzO6Dxh4VsceWgPgB?=
 =?us-ascii?Q?AF/2QCKJzKAhbA9Vwwvp00r8D/2LTrGZzLsQz3iNk+O0VAH7yCoP8qdOjyDw?=
 =?us-ascii?Q?z3WpLY9TtAs7JC96X1RPOdN8S2CG/zqQiYyhrQg2+cDXXfefKQfjD00/9599?=
 =?us-ascii?Q?xSvHjukxBefyCSpChRd3xI3arGtz6nYZC3+Xvu5GCTxvgURcO94TftGzyUCf?=
 =?us-ascii?Q?hb6RizJKv2f7+nqIXh9E/CCqc8Oki2IMB1rx1RyZc7MmlsTjK19EftR2Eg57?=
 =?us-ascii?Q?hzG0bpOLmtwcCbpTnasAN+u4uqWbuKB6Fq868+EKiMp6+KOUibs9ReBJ/eE7?=
 =?us-ascii?Q?G7HE5AFz/7Dqb7P4+icoagVyTr0HBHzucPA0xLchEKu8AadJNBDUxHf7y4T+?=
 =?us-ascii?Q?+5C/fShlHDTGS90iP7vre7DiNvriznpR1RephrYUeB+alpEC0v+eGPQ9Qpd0?=
 =?us-ascii?Q?BTlADQxHcswiROOJRLDzjwdPzHWL8+xrN0q/Fi3XYY314kt1Gp1Cna2B9lS7?=
 =?us-ascii?Q?xMX8Jk8g2QKRokDCvmoNCEFJWiCCII4lgjbAEpLWuLtNshYvLw8SJl7wXdxE?=
 =?us-ascii?Q?TMQExML7GhjO/1bAaPE2O0ghnTmhPyTu+aqJlEw9eragHDNh172KWdxAN5gu?=
 =?us-ascii?Q?RnYT2e1wGi2BWE6brEMUOhmoRDM6R7J6a66c3X2EhLEEEgpfDiOh04Th3Jhq?=
 =?us-ascii?Q?PQBuS+LEqBekaCcEI3JOpG14I1gyvqZ/UT/w8wk9O1Vbb5Y4/lYD2tje9xGH?=
 =?us-ascii?Q?C74E6Qb/GyrHzE3ex8BW7M4h/rvScYb8bt/DaTmNfWnwemE52dMg8jkTHVQs?=
 =?us-ascii?Q?ekoZoO1gI3R76rIFCFELSl1mzZISPqL70iNnbxJ0nhOPb16uEvmt7r8J0u46?=
 =?us-ascii?Q?ERjJaER6YlMr+AqoogeFvJq+Klh7W6Sekzby2DiDUayqKOLofFSaHeCl7kxq?=
 =?us-ascii?Q?ICO/PLN2X5bq9P3mqxC2QUmWbuQrGHArBZ3bkF4nEidxYqdmdby0CEPR7Vwi?=
 =?us-ascii?Q?cEqYbLf9VajKW6v93133bkFFdScKnNdwWLQCPSQYWCwsAwRTewy+mt+QY8pD?=
 =?us-ascii?Q?XyU7wXnQx7n6BpoeRCFnQ8EGEb8BMhUN1qP1DWYgvQQZWaHmPDTKMpSwqmx3?=
 =?us-ascii?Q?j6ebcKIWAa69G3pLdHhwlEB8262osm62DT8S8V6D++iTYsG2rKEqj+eqJI+r?=
 =?us-ascii?Q?0QYbg6n6U5Lo3b6SQJfxoi8l78zP1FH33+pA6//J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4c285a-61ca-4f05-720f-08da9cc2fd53
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 17:50:51.6226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPaSyUGgcq1h7YTZGyy7kFUdBAipgTbFjum3oGEp9HxM2tx2qfI+0Hn0+lvZZCBN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 01:54:34AM -0700, Nicolin Chen wrote:
> Following the new rules in include/linux/iommu.h kdocs, update all drivers
> ->attach_dev callback functions to return EINVAL in the failure paths that
> are related to domain incompatibility.
> 
> Also, drop adjacent error prints to prevent a kernel log spam.
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +----------
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  3 ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  7 +------
>  drivers/iommu/intel/iommu.c                 | 10 +++-------
>  drivers/iommu/ipmmu-vmsa.c                  |  2 --
>  drivers/iommu/omap-iommu.c                  |  2 +-
>  drivers/iommu/sprd-iommu.c                  |  4 +---
>  drivers/iommu/tegra-gart.c                  |  2 +-
>  drivers/iommu/virtio-iommu.c                |  3 +--
>  9 files changed, 9 insertions(+), 35 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
