Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9045B7BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiIMUCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiIMUCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:02:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6AC7C744;
        Tue, 13 Sep 2022 13:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKl+kBKusRFW95Nnme1cfOx21ZWyCX8EvWRo0dfrPJ5uk8kXx3h9epnQH8pBEklOLUJ5qYm6ol8hRnEX2RgSFuHCG5qnCdzRl1Y9l1MrDqVZ6w3Q1dg8ZxsatHt7k5/PShoF77aR9fcSByTJlGXklIjKDIt7GMHHR/ZOqlTAJ2KsICtJcYKanaXKFKyd0zuhavg/6yy7QfFzXk5k/mZ5neqgcihIsvHQ8F5dNhN56mBomylMHvEZkrxDsotEJgVn1eQrbJCrCOsj7BvGjRsW0UsgoIrSeD9ITXmEJ7H+JQ6XPLnLJIkdyZYzNfsBsqIPkZCthhGrmqy+BcptSvrR/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZfGFrNYfckX8y7d1ap8+ifboVX6qxI8DDXWoZjUUz4=;
 b=gjwKV+fxfudWoeeAI1++r8CuvMoWjtxtBzwg/ZuQP6gX6W4yV9gmo8R2k+GDNu8+67uKNEPN6T7fNveR6gZRoDujtgX94jsjap5/PVxUxLx1GXTz1yHQd9yXDuCeQ9Y670Qq6iVbW3lxkjKyyu0e2E670qzzGB+lKzeCCM+85GaH9m30Php7thkk2nJrjqobpDZhYPVZgI/esQc4yJI4zBP1wUeRPOc0SwDZqpIkEKm0KHKFmjnFNk9xOP4UsdmhuQdpCca/zDyqZanQintMCHJFtkYwVd3KxNug9D9TE7YYMF71Izm0XREmsVMSw0SJe7qXSGh4JwAGvG9xvs16RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZfGFrNYfckX8y7d1ap8+ifboVX6qxI8DDXWoZjUUz4=;
 b=e3tqAY7JPDkmFU0NBEaLIxvqvigQut/jhYfOWrHJOch/tdHLGbHnb++Cu5XQn6awt2CHq7GB4rBHxyz3ByZxSJPcK3kUGX6EyNphOg+V1SMZ4n7LbuuZVu2wPGY4WjFPzYHi0AbudFX85L64xYwcEaI2KJHzmjvzPg+ySiNBKj6jRDkD61zoTbAE3u2xCx7og3QRA/p1Rf+Fmdsp+ls09t6bRtM+ge01ZucuDDmGXYkfJ25vhkSYIzjKZTXVSpoq0+GaBRYuB83mIArpsf8Qz7aWVWE146Z51X0fQ0Uav66WncZGNrXSguvrSrXvMyON7PD7FQmc5KQp5xjyDKtInA==
Received: from DM6PR08CA0045.namprd08.prod.outlook.com (2603:10b6:5:1e0::19)
 by DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 20:00:31 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::ee) by DM6PR08CA0045.outlook.office365.com
 (2603:10b6:5:1e0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Tue, 13 Sep 2022 20:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 20:00:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 13 Sep 2022 20:00:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 13:00:30 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 13:00:28 -0700
Date:   Tue, 13 Sep 2022 13:00:27 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
CC:     <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
        <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <matthias.bgg@gmail.com>,
        <heiko@sntech.de>, <orsonzhai@gmail.com>,
        <baolin.wang@linux.alibaba.com>, <zhang.lyra@gmail.com>,
        <thierry.reding@gmail.com>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <sricharan@codeaurora.org>,
        <yong.wu@mediatek.com>, <vdumpa@nvidia.com>,
        <jonathanh@nvidia.com>, <tglx@linutronix.de>,
        <shameerali.kolothum.thodi@huawei.com>,
        <thunder.leizhen@huawei.com>, <christophe.jaillet@wanadoo.fr>,
        <yangyingliang@huawei.com>, <jon@solid-run.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 3/5] iommu: Add return errno rules to ->attach_dev ops
Message-ID: <YyDhW/HJaKMygccm@Asurada-Nvidia>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
 <20220913082448.31120-4-nicolinc@nvidia.com>
 <cd92cfec-0a68-a42d-1fa4-a16e37e59d53@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cd92cfec-0a68-a42d-1fa4-a16e37e59d53@quicinc.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT040:EE_|DM4PR12MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3b88e3-1aa6-47b3-b11a-08da95c29cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDYPSxfbai2zCo+qcmdiJ9xYaB1OPrc6aYYh/UsRMNreDfAp9rdHFG2RyhT3wOkax7xznsaoXFUeZh7p4ymv3Mv1hBLegPWgFMtQICmXJvF7o0LSwUCgRBA/xkT2pC60scXt6jjRdGvs2la+NyWeOXbL2AKZjJMiiDZpy0cu2JJrENGcR1URIfxLV3dDLrBqbppQEb9eJQbJrOm3KQ4F6M29rYworgAye1JVsCjBXGLym8oF1JfTApfwxGQm86qilgzIiQN7drwX0SpmvS6/WPbhR3fsDqVwUeaO2hXQmeqHDLVcMQbVTlsLlHB9TruRqWX+oHOdpEjvdxJXXp+B3J/56l+VmbgRj5r7SX2jx6aHY6WAB42ZFyJ4QZcJDmOPD1jAHCDOftYTmrCmvCblwP3vdNuYtuNCFEEWygvu4cLMIVUbViOVZjFPcAemhbZYxJmYqkdltZv+e2rFTnqRMU1p+NRoWmLCNu2ASlxBi9+ofw+mDTBSkvCqQDiWEnjtM+fy/IaiOIXLkmyHGA8cRGSHOauPw0DhFFWsUswF14Qs14Pb8AhBBhUu4mHt2elsuc5j1Z1suV8fTPl7m6w1dXaJmoqQHp3maKJ8fAaFhEGjt9sS9KO7zvxOhTx4npAayyzyLaL2wA18cRkueLQ1LJfIszNK1f+SciFTHpIPnzk1eFVclewVU1ry8w6brYQkXiismmJz5C5Z1/PMANkDWvbet53iJkVJu5efTAvUxwMFpk1zXWc58Hp3YECKzixYhVsTTBTRd0xos4apFJlf3jytQOifTw7OhAJa1Pf3/nxfotASH36diEhNVliGai0aUBSsFxvm/xcxx3R2FR4dhiInmgxm3wU2S3luXeEwFiaiKhjFpQIVrknQBRj59/ZC
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(7416002)(47076005)(186003)(9686003)(40480700001)(356005)(82310400005)(86362001)(81166007)(41300700001)(316002)(40460700003)(7406005)(36860700001)(478600001)(33716001)(54906003)(82740400003)(8936002)(6916009)(70206006)(4326008)(70586007)(336012)(5660300002)(26005)(426003)(8676002)(55016003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 20:00:31.1582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3b88e3-1aa6-47b3-b11a-08da95c29cc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Tue, Sep 13, 2022 at 11:41:35AM -0700, Jeff Johnson wrote:
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index ea30f00dc145..c5d7ec0187c7 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -266,6 +266,17 @@ struct iommu_ops {
> >   /**
> >    * struct iommu_domain_ops - domain specific operations
> >    * @attach_dev: attach an iommu domain to a device
> > + *              Rules of its return errno:
> > + *               EINVAL  - Exclusively, device and domain are incompatible. Must
> > + *                         avoid kernel prints along with this errno. Any EINVAL
> > + *                         returned from kAPIs must be converted to ENODEV if it
> > + *                         is device-specific, or to some other reasonable errno
> > + *                         being listed below
> > + *               ENOMEM  - Out of memory
> > + *               ENOSPC  - No space left on device
> > + *               EBUSY   - Device is attached to a domain and cannot be changed
> > + *               ENODEV  - Device specific errors, not able to be attached
> > + *              <others> - Treated as ENODEV by the caller. Use is discouraged
> 
> It is my understanding that kernel-doc won't preserve your formatting
> without extra directives. See the "Note" after
> <https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#return-values>

Thanks for the review!

Perhaps the following one would work:

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ea30f00dc145..14f078b58e17 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -266,6 +266,17 @@ struct iommu_ops {
 /**
  * struct iommu_domain_ops - domain specific operations
  * @attach_dev: attach an iommu domain to a device
+ *  Return:
+ * * 0         - success
+ * * EINVAL    - Exclusively, device and domain are incompatible. Must avoid
+ *               kernel prints along with this errno. Any EINVAL returned from
+ *               a kAPI must be converted to ENODEV if it is device-specific,
+ *               or to some other reasonable errno being listed below
+ * * ENOMEM    - Out of memory
+ * * ENOSPC    - No space left on device
+ * * EBUSY     - Device is attached to a domain and cannot be changed
+ * * ENODEV    - Device specific errors, not able to be attached
+ * * <others>  - Treated as ENODEV by the caller. Use is discouraged
  * @detach_dev: detach an iommu domain from a device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
