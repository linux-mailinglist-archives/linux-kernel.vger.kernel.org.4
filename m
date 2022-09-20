Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DC55BEC7E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiITSG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiITSG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:06:56 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DE02DAA3;
        Tue, 20 Sep 2022 11:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3xg4nOjr1j3GZyLuOvtEC3qH/75AilVAESlnO0LSxairds25QAAq+NUmGbckH5QEfJW0i1X2cK2c/q9UpZqRL5h3Ws+e9ITc0j9mMH+wnMYUjU7PdhLd2t87aJnDtcRE/YTmQIIMEoUxnuV52KzMzVer6JxKHdcUBXWfM+gqJx6EjX9jkLEfIULQk5ETn7JCZ9XPozg4Wq17cLp/EUm+xalHtUEo9yEWLgIbGuFDd51D4ZYsrKhXx3UxsKkwoDCbAjG5oc8gljaXcluP6MK0ZL4HII147ensp1T4wc+YKAyCiaBey/a80ZLgC+ULerahgYFA569Dx/fpUEOIJC9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elt4EDAM2W6uenHPGGaT8UUQTvBHGnkaO37Ju0rmF3o=;
 b=S9PTxU9sHGAJf4NJrdC5USiWxSy6++Jsdy8S/VzDFAWgttIOZk0bg0xo3J54f9wb0PrOi++Za5iy51cyyRCZiyD8et3Soe80BC5SdfVfqkLjTHSLQk+LUDq5oDjpJQl+WE59cEp5FtXYuE9EpyOer1LNz8eY3+79yEqJDpflFXzP+RxMkl8ZlnrqhgZwJKmzEv2Cvitc1Gh+H1L9z1JqQBzDm1G0+0cOWQubzfIkDuq4J2dSqrV9JSuKdbyg0K1tmwCqFRP5l7MXRSAptM4+JV695tI3RiEMWwBpNzxUpUeN21A9mS3gezZoDtt06RB6SYYfrkUBD7twbV07Lvk5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elt4EDAM2W6uenHPGGaT8UUQTvBHGnkaO37Ju0rmF3o=;
 b=pZLHOgSg4IOrBtWVNPYJZ6igClmPmPteQ2iC/oHPo0gV9vE1BiQa3MFWJ29LoQORCmLv+RsJLIcELmcHpuFGzEg2jz5lhR+YAWivyb2lvxefDKlXCx3FFyPTfKBH/zUxeCwmlK+q+qbWWFYIwlqtZoPEFi1aBP/UDovkAtcXBFu+dU+pGPKqfJETBhDASSJRZwKLVwqCM6m7yNMsVY9MZxX+MQRjrGYOpntAXQCfpfToyg2vriMSbLGn/gq1TZHBujhnzH5qVtGq72xSwl3zEYeO4r4dI4jFuQ34ckzOjO+rQun0cXHG27wp8Uub7/7ziHitYZUsDEIYoehLBKbm5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 18:06:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 18:06:54 +0000
Date:   Tue, 20 Sep 2022 15:06:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "sricharan@codeaurora.org" <sricharan@codeaurora.org>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "yong.wu@mediatek.com" <yong.wu@mediatek.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "quic_saipraka@quicinc.com" <quic_saipraka@quicinc.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3 5/6] iommu: Use EINVAL for incompatible device/domain
 in ->attach_dev
Message-ID: <YyoBPAE+POS0KfCR@nvidia.com>
References: <cover.1663227492.git.nicolinc@nvidia.com>
 <effc9efd2160ec19500e1f4c59799991f46674c8.1663227492.git.nicolinc@nvidia.com>
 <BN9PR11MB5276595A0BFC49F096C2D3968C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276595A0BFC49F096C2D3968C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR10CA0035.namprd10.prod.outlook.com
 (2603:10b6:208:120::48) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CY5PR12MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: b07cf9da-53c4-4b8f-a5d9-08da9b32e62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Da2d5DU2c98vVzCSaQnNFONwdVBTSlnfSrG4xZm8Z/rjG8QLhozOaPxoQmSLYGmYBp7arnQHF7IwkTS8FZeMJJr12pS9fG9lxoOK9h0b9F9EJd84hXidJbW1mpP+XTnT/7KjFnyKfJL6DDRR55od4BfuXGeLI2cHF2iZBFKnEPrXyrcuVStWLfIBJa9GlDfRC1y9DZKvO3g1ea/XVxDEpMUkrfU/HL8sr0iQ6kT3pVk4t1cG8aD1le7iUQwz0JGoXJ8jiXM2JxmRC/EcQV5PZHqKry6W+FUU/0MS5iMqS13aWMdtkr46MU6miIVfjmr043HDmUN+K5elsJ5aezdrxoPJFb2FX6zXEzcDbhtSH/61MxiRDc7i7pT2ew66vVFrz7Xl/wjwcddbpLc6oz/rX1PMWWDldgMES9TaDTey4cOW+dkqvktaNvWbwl4FKMb+OUMl3Br1bvEgsLREHvGxm1ffOkSZvnOarPuAZWPl4mKlceIf8pHSDZv/TB5T8MwUWDsKfeynAfe35vSJ/qooqfX/KXiRjvxgFRs2CaF/DH2wEbHr9QIgq2PygaK6oO1KL6Z9zgtqBZzHWYVS7/t05HZgM6Hk4UvFKkLf4rV2bIA0JwhiGnnpS01dhTFigrQfjOqH1TbBalu6KyS3+9pJO54FFtNz8y/AeH3FXfgo87Mm8YiHfMJMkvTMw4qzRIiAxMQfSvL8uOf5hrH8+li33M+K6kdfFeSd3l1QdvdljveyJfcea/TOwRf/sQuBDJIH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199015)(316002)(83380400001)(7416002)(7406005)(4326008)(8676002)(36756003)(66476007)(66556008)(66946007)(86362001)(2906002)(38100700002)(478600001)(4744005)(6486002)(6512007)(26005)(2616005)(6916009)(54906003)(8936002)(5660300002)(186003)(41300700001)(6506007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ygOk7bZVq7ZtvK1iFCVbat++xxH4vb9mJ8B2YdtIno9oGFAdhgmwZX9xZhC1?=
 =?us-ascii?Q?a7pTYzx50iOUeZ5Dz+9SW3uNulgseV6RfKOj/Y8fSYKNJMLjaNCjQers9wk+?=
 =?us-ascii?Q?VF5KxSl2YecOQlfuWSi/SAc9sC9Onq1jgRhQdRn5YfJMsd0veR7KKBZN5w85?=
 =?us-ascii?Q?UFY/G0g0kzi4fK39WQz8dQZbNyLzcg5chnKkX3n9mtRqB8aRdBpaHmLu2Vq/?=
 =?us-ascii?Q?h0b1XCuDC+AxZ4KrkMzffpXxjax5xAmrh6230nDpivQPMnGZ+7YjAOEQSmbV?=
 =?us-ascii?Q?4X40bFxqQL2gYLIPvHAqSAXezYfaMM++6x+FqH1AZn8AbR6yppfux20M7tro?=
 =?us-ascii?Q?LhKkvx99RwVBmZ+COUqAvH3uVrO/lmJl/2A16YXBMCiohkBVEkjVnO87CbEy?=
 =?us-ascii?Q?YCtej6ocauh350qsnOq4dQ3dkRYc0t3SW/wXiaGr1sEXzzOn9t0oIb1HwnvL?=
 =?us-ascii?Q?6e25jTgT7yL+BJvYx4lJsoVu6ZtAvydOS6YycmThEXH4fcbkZ9WjneQ0DdP0?=
 =?us-ascii?Q?YFIZZBU9FSkOeUyJrqxfs5lfifDwjFJDNpE9iX1dxU0thad9wANS/ZcGKKl5?=
 =?us-ascii?Q?lb4JG2pAuZRNGYxkQLLvmjoKGkw0bx49Hcoblsr0ruW6wBeBqaEPGXfQMrJH?=
 =?us-ascii?Q?D0Rwj1Np3YJb8LMhxrWjPXQar/gRKhJ6U9HAT/GQ49HN2S+RxjBg5PP+hQ6a?=
 =?us-ascii?Q?WBy9+8e3WuG7eq+ss4dql37DbbeDAg1GASb8SMYeGOJp4jPofM/wI4+diITY?=
 =?us-ascii?Q?9bKDKIIIqz6eho0jW/ANwMr9CdZeHochiL0Lc4RVmOfZWjMwDIgONbkPgTYJ?=
 =?us-ascii?Q?GuusLhgpgpn5CFOOqIn9xuHtTKSm4Gwhrqwy8j91BWSfPtXbwUhGi8Sw0DZ3?=
 =?us-ascii?Q?X9E95j/jpsDnbkzokUmVPu+q+LoQb7udD30PSdqRGHdisj4vjqW896yycgBD?=
 =?us-ascii?Q?gqq3f81XvWO2rT5Gfw/2A7L3phst+TRl2a6cFCsU2lEMtNuccpmVAM/nLL3p?=
 =?us-ascii?Q?DZ72oTkmmM4b/ezOnW9qHPJ1+a+XaX2nP6cvOsNiZtSCaHmqoMPYDq37iCWn?=
 =?us-ascii?Q?9PZ43JC1nAxel06CmQU7yHfCoYBXUs+NPe0xk0SpnJvKrccOek1yecLgSsIn?=
 =?us-ascii?Q?pkN1/Pkq6JtTgoy9e3tYTWJ9K45Ui+LeOaqLOQAnm0Viq3+jWJYlMRkeEp4E?=
 =?us-ascii?Q?TyHh7ujnz03vdfSkDRQdBPhN3OvcpM2+fqE7HtY554eQdQwI+uPwCXUxZ69x?=
 =?us-ascii?Q?hOrfZSj/LicaNjxK7j4dfZmtgAG6CA0bmlkjg6HVwJ1q5pPA6GP+7oaORfLg?=
 =?us-ascii?Q?jtrYpNFKPPodd47Uri9/5Dw5fP8dZ/U5GA/vh+PLBuurmGKwWmyYXGz8SBXi?=
 =?us-ascii?Q?cxiCXh284y441Gf6kU91mbWkxRCCA94Pe2o4SyM1rEYfC/jKBFqWF+s843oa?=
 =?us-ascii?Q?UQPAmRmsi54o7ti8BfJbFQWKTQacIhFwlI4I12w1UIud29voi+BR54byO6vO?=
 =?us-ascii?Q?rfJzdWO+xK3RIdqAX9YTZFyEodvDCwhMLng5aCFVxROI7iD+NDcagfBUdNet?=
 =?us-ascii?Q?MJaazTC8gaUiPuuKTxcJZwTyMqOPZuqyOtRW72mC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07cf9da-53c4-4b8f-a5d9-08da9b32e62c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 18:06:54.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oHNc7FqNXiMjYyfVm+9Wygld14aa2nKrPdFzQs7LuCTpfz9xnkTZuafeodNQMdw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 06:38:18AM +0000, Tian, Kevin wrote:

> Above lacks of a conversion in intel-iommu:
> 
> intel_iommu_attach_device()
> 	if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
> 	    device_is_rmrr_locked(dev)) {
> 		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
> 		return -EPERM;
> 	}
> 
> since it's based on the domain type, picking a different domain
> may work in theory though it won't apply to vfio which always
> creates unmanaged type.

IMHO this test shouldn't even be here, that is why it is so
strange..

VFIO should be checking if somehow the device doesn't support
unmanaged domains at all. We already have several drivers that can't
support full featured unamanged domains that vfio needs, this is just
another case of that.

But it isn't urgent to fix, I would just ignore this branch for this
series.

Jason

