Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6E75E5DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIVIj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiIVIjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:39:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76746B4EBB;
        Thu, 22 Sep 2022 01:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9RLzyKQu2pxTj2wDoJp+9etZ4PSKMbjDrW1hlZWuInO5mQPBGqPCR1Hzky6nV1juDBw5rBffczNwHtZLfQS5xY9OEFWeQ0FhEqluO2Mn0jErr5EbCRkeUVVCIHyuFAq4hMqQVkiM7BnzzfRsr43Re7npxKt0lPhrnB7K1DffSIhwmqeXLTt1Pph5uxC5Dt1qo8OpjXn8wr5Mac0Ju1dvYLHGEUqjbf2GAXROUP1y/mD4iRRerw0lW8VZi7rxKKYrcNmrWNK5ecbbCX19+2MghtGL9fYaQNBOkgMTMoqDBAl4LykMtpL0wgKH1bz1h07Vw8apcQ43V8/p5RM9r1wzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpfz99XHWcxC8rKUalTz+Mpv2bUvQnYEfePhQa9lAlw=;
 b=N3bsAgJmf2NMPtGZGLUHJrK5WuoFFFX0xUm92C0duFE7tYUyMYab5RqdUJJQfiIu11809A2gDnD/idT7vpy5KAGJxnxL6ttREIWWYfvSGGOj8c3vm5mgftxXgNcg4bBuvA2Fc6YAcvmHmDmB3KF98vntrE1TQ1w2CHdElySidnqRDnqraXnzh/tZPRDX/EACaOI86rdAEr+kn1L4e6w6GNRZ1nZb8BX6CeCMEE4OTkZFxi983iKmEuZD4VEcEfXPnfw4eo2UP7R87VQ6Y8D0ijvaX/L9HpktmI83CxSnjoBVczDcVywO72XxxH707Al56AoePbXI2MXh42P4FPKPZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpfz99XHWcxC8rKUalTz+Mpv2bUvQnYEfePhQa9lAlw=;
 b=NrlBjWMJFnSKTQb42jMrVQTJB461+zSuUxjJb5Km/uglHu1UC1qAaVhQiRS7B7ElIUoTc4hl1ekbffR782GiYDg79xliIeG071ObUw3ePmBLC/HHhX9Li21fkJNPFOFNxQbR9ZzI+uJD3p2eHp0cGiuXvF6zyFXlZnrLFLrQbKJeWEfDI5fYd+V4MZe21P2N9oI/yiM/rDN6bAhMqbix+Ey2IM8wj7d8hAF01eIYxtFiSfT01t5iS/F2wwyv+IGZ845t5pIX3qelsXmiTh6gskybU531i3/vFIsy9lYQBWhLUzOpnwFWbZg1Iw2g9usSA502jbVi5clI24BdwrqFrg==
Received: from BN9P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::24)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Thu, 22 Sep
 2022 08:39:12 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::56) by BN9P223CA0019.outlook.office365.com
 (2603:10b6:408:10b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Thu, 22 Sep 2022 08:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 08:39:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 22 Sep
 2022 01:38:59 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 22 Sep
 2022 01:38:58 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Thu, 22 Sep 2022 01:38:56 -0700
Date:   Thu, 22 Sep 2022 01:38:54 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
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
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
Subject: Re: [PATCH v4 3/6] iommu: Add return value rules to attach_dev op
 and APIs
Message-ID: <YywfHpMG/PYhKqN1@Asurada-Nvidia>
References: <cover.1663744983.git.nicolinc@nvidia.com>
 <8c3dbf153b63a3002a46bab6e707c63fd8635bb8.1663744983.git.nicolinc@nvidia.com>
 <BN9PR11MB527632E5F21AD412991509458C4E9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527632E5F21AD412991509458C4E9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|BY5PR12MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: 223b8f33-97c0-4ca2-73fa-08da9c75ec85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k71Q93eumvnN4i8le+GNjTZLK0ALOEztJYSzELskH+mD3Gls3JuduuGmxQ4It/gLnwGkqJ7CSiemh60EBURvd6kJ2BbUn0Cwzo+OYf88oYHC9MIlil1e7Dh3WP8KG7w9VqbB1/GStjxO9i12NE3BBpIRw37MSXeKIFM2QRFiKecSJRvd2voitfE115rQYk9LuHfWiReZTQOv9PJPHNPjq1fzx6dOHznAetISKtZY1cePZ2ec93VFk6gpUbey38g55iprOnVJzWKp+7BtLS8C4myhej24FiG64mzhaH7AQQFi5126SzYaKzwicvzqrQ1PGlKybCIfbeeeWyKVuOv3RdRasOV6Om6nGbSnwZNulN5+hloSEJ4giBGb5th0xNQW2W60SueK1ohmqXYNVtIEOCB2o/lKwBUi4TxGwxThuAyo/OB7RDO/ImqdIEnMPj0HJhIHbYWUuI7QHxqiBrL/ByzKETlKr3v4bGCd/I//VCdiPx+JDi0kc3SbcDlmesdZIRpsKGIEX2Nr/+kY3KQSCb1o7dlXnVvaTJchjsoDYApkoy1XVINWI1t0zJE+3KrDikJzOm7AhmI257TPOPYLlziiLMKR3Y56Hy48/O/GVvd2K25fes0mXLC2TPbY0vzrLeeYPAa+mXgUYwWI4D6fI9ZSGQARwjnRAj4Zzvey9+MLq0jbBL0i5/4K03La9ayLnekPROeHMkqduXOGw6KFTnGjf9FEzjDP7ZLNslhg2CkrzufW4aIxScZNATZFqBLAn5Jd1bN064vLbUA+nxmpbQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(33716001)(7416002)(2906002)(8936002)(5660300002)(4744005)(7406005)(70586007)(70206006)(82310400005)(4326008)(8676002)(41300700001)(6916009)(54906003)(40460700003)(36860700001)(478600001)(26005)(356005)(316002)(82740400003)(9686003)(7636003)(86362001)(426003)(40480700001)(83380400001)(186003)(336012)(55016003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 08:39:11.7591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 223b8f33-97c0-4ca2-73fa-08da9c75ec85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 08:17:03AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, September 21, 2022 4:23 PM
> >
> >
> > +/**
> > + * iommu_attach_device - Attach a device to an IOMMU domain
> > + * @domain: IOMMU domain to attach
> > + * @dev: Device that will be attached
> > + *
> > + * Returns 0 on success and error code on failure
> > + *
> > + * Note that EINVAL may be returned as a soft failure if the domain and
> > device
> > + * are incompatible due to some previous configuration of the domain, in
> > which
> > + * case attaching the same device to a different domain may succeed.
> 
> Revise a bit:
> 
>  * Note that EINVAL can be treated as a soft failure, indicating
>  * that certain configuration of the domain is incompatible with
>  * the device. In this case attaching a different domain to the
>  * device may succeed.

Done. And added all your "Reviewed-by" too. Thanks!
