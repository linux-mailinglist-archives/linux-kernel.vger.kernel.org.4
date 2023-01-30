Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02093680AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbjA3KWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3KWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:22:32 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B497EB5B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:22:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiBpx+QDTOhoOc+UiGmONDNFxpTZzi1lywjER/qpL55fSgD1hrTX9uyrVovSFPHMJ6DiSb8EBcxPy0QV2kjQiBk7kexkWSgfuAOetwcvKxmOVSuLpH/4ZqYZNqxRpTbcPEAaeaj+1nksRPLi9IabvvmJKkhlmY3diqWpY5nNDmbClCDGotdevZpbZeSWw64+dCvNMxku5A/cPDgqA5KGKbD9CTnyq+z5JPNujwfL0A0l8VmUm0F4X5k5nqTSEl2qrXJzH7aPrpEHxqvKpmz9W3/0iYGrlaGwHi4noqjl/SWaHAI/aV9CrBquaTlQjY5rYhO4V1n2vVQlBFVF3MH+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HmNeLlROC//UVgE8HBNviQ8yiQdGmzDNIJiqx0t7Go=;
 b=BBhEmVAP5dOh7GocRemtpcOQvCZLFjnYEkVupB8f7Et77FrxUBhxKA+R4C/EaCq0mFJUKMbwHAX5FMG3uFDVuMEQEYEA1R115hcuLmrC0Udh+/72i1eugpxnkc8H08WYc1AiUcVzThJwW+RjDF+D5Bf8IW5Ng+WWMKb2q5LPhceJS31NWuo4emQ9RXvdA8jRfpiNuwsIPJD8jeZZEjh+9o6LthBMM2IsBdFIfJpWXEiAnjGsR1FcUI+lp2pCYCc8YFVH162u06ThD/Tv/gQ0pLTfprEFhHcFdFtAlDEIJKMnB5Y1IkIQbLnYuNNaa1Zwhyg41zjm7Uf1Q0PR/1ya4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HmNeLlROC//UVgE8HBNviQ8yiQdGmzDNIJiqx0t7Go=;
 b=jfOHj6Yl6zOOBvp87On5AmGpnifAtX7frZQQg0JHBc0BC8iN8tAQATlIJj43R86QeRLDOrTCO0hRfxX1adKXOxjOnmw9qTg+HpxKriO9sIAtp87cl+bRfJ8QoK2aF55zwCmlxQDrtUwOoORTT5gqQLxgWmPUtA0inq0G0ua1azUxFfrEXHP/spVbsrI7R7jF7kToEaSkgKz2pe59BNdS3ofHzvNeHiSMZSbjsaZyjF2LhDe2SlvlkRlp4bqNAjzduXb10vMaYGsGNejFXCj9IlsZFvWv7/Yv26+LC0leWrDlXv4d76ZBjTiBQdRlYCRjsDWei3fOLk+17cfg62pg2A==
Received: from DM6PR06CA0045.namprd06.prod.outlook.com (2603:10b6:5:54::22) by
 CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36; Mon, 30 Jan 2023 10:22:29 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:5:54:cafe::fa) by DM6PR06CA0045.outlook.office365.com
 (2603:10b6:5:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 10:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.17 via Frontend Transport; Mon, 30 Jan 2023 10:22:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 02:22:19 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 02:22:18 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 30 Jan 2023 02:22:18 -0800
Date:   Mon, 30 Jan 2023 02:22:17 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iommufd/device: Change
 iommufd_hw_pagetable_has_group to device centric
Message-ID: <Y9eaLpD1XIvE/3Nh@Asurada-Nvidia>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <002911839dd30990d5e3135f8a0f8d41f14e856b.1674939002.git.nicolinc@nvidia.com>
 <BN9PR11MB527697E1E24784576C3FB7628CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y9ZMulxEyGvnvW0X@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9ZMulxEyGvnvW0X@Asurada-Nvidia>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B079:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: bff0a183-b0a4-486d-1fdc-08db02abe475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Di+I/lEKIdqqSjcjLO6xwGUqwpL9/kBOmkOoyTxbgIGRTZ6ulOtFP/lru+o9OUi79UIPES1qsrV7TUEugd8RRSF75aMuRdI04d50+fAaw3JeajOIbfiHYWv0Cam9iy9gwbBHRS9o7ppLqAd6rlBn8zPwQCtl3fTX1F152UPDY/h4OYA5MZqAWquDSvaPYSix62OfhFPf911AzB4OWObK9/3T5CAz+oPJywhpsY8zeSX8/o/HnUjvr+rZlGj06PMolg7LiAfdwnaTyRAN8Fv2LoknyQqQuJA7bDiRtlX0kYQWUgGu4Vs2lV9dxI7nQmIae0sJrNE5wI1dN1K/PCCIv1zjdvMYnkxWB21VI9WrJ2kAYZnqZag1ndOYEajPz7goFfMKl+q+atiNS4TpCvO1RcguuxfaEwZ9chCmYBIYg6w7FADAVKTnZL2cPYu5bfLl1pxkgazFMax5akGELkxGb9RjoJ8y542CN+WQZ6cHPLb5/A0Ae7+7n3LtVih4d+S9QRCHd1jLHADwLpyOwdQbY0PSv9LiZJtjmfAvCLj4JTxHN4A6w4N9+fM2XaBlHvSukqb6hahxJLnNcEdN5fN6A6+yWP3OM/L6i9mmxP0f0a2tInlwoLP9HrIWnv1Rz/OOD/zzR6rpyyoedEDhdaKfQ1pdZ6WQt+JVFMf6lwSkZCwrGXcxnbswWtVEfro/P1qGeJC2t+KCEDpgKC13dF7JzQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199018)(36840700001)(40470700004)(46966006)(7636003)(2906002)(82740400003)(316002)(5660300002)(186003)(356005)(9686003)(26005)(110136005)(40460700003)(54906003)(82310400005)(55016003)(40480700001)(47076005)(33716001)(426003)(83380400001)(336012)(86362001)(478600001)(4326008)(8676002)(70206006)(70586007)(8936002)(36860700001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 10:22:29.7195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff0a183-b0a4-486d-1fdc-08db02abe475
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 02:38:55AM -0800, Nicolin Chen wrote:
 
> > > @@ -385,10 +372,8 @@ void iommufd_device_detach(struct
> > > iommufd_device *idev)
> > >       struct iommufd_hw_pagetable *hwpt = idev->hwpt;
> > >
> > >       mutex_lock(&hwpt->ioas->mutex);
> > > -     mutex_lock(&hwpt->devices_lock);
> > >       refcount_dec(hwpt->devices_users);
> > > -     list_del(&idev->devices_item);
> > > -     if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> > > +     if (iommufd_hw_pagetable_has_device(hwpt, idev->dev)) {
> > >               if (refcount_read(hwpt->devices_users) == 1) {
> > >                       iopt_table_remove_domain(&hwpt->ioas->iopt,
> > >                                                hwpt->domain);
> > > @@ -397,7 +382,6 @@ void iommufd_device_detach(struct iommufd_device
> > > *idev)
> > >               iommu_detach_group(hwpt->domain, idev->group);
> > >       }
> > 
> > emmm how do we track last device detach in a group? Here the first
> > device detach already leads to group detach...
> 
> Oh no. That's a bug. Thanks for catching it.
> 
> We need an additional refcount somewhere to track the number of
> attached devices in the iommu_group.

Wondering if we can let iommu_attach/detach_device handle this:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0d7c2177ad6..b38f71e92e2a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -57,6 +57,7 @@ struct iommu_group {
 	struct iommu_domain *domain;
 	struct list_head entry;
 	unsigned int owner_cnt;
+	unsigned int attached_cnt;
 	void *owner;
 };
 
@@ -64,6 +65,7 @@ struct group_device {
 	struct list_head list;
 	struct device *dev;
 	char *name;
+	bool attached;
 };
 
 struct iommu_group_attribute {
@@ -2035,6 +2037,7 @@ static int __iommu_attach_device(struct iommu_domain *domain,
  */
 int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 {
+	struct group_device *grp_dev;
 	struct iommu_group *group;
 	int ret;
 
@@ -2042,16 +2045,22 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	if (!group)
 		return -ENODEV;
 
-	/*
-	 * Lock the group to make sure the device-count doesn't
-	 * change while we are attaching
-	 */
 	mutex_lock(&group->mutex);
-	ret = -EINVAL;
-	if (iommu_group_device_count(group) != 1)
+
+	list_for_each_entry(grp_dev, &group->devices, list)
+		if (grp_dev->dev == dev)
+			break;
+	if (grp_dev->attached)
 		goto out_unlock;
 
-	ret = __iommu_attach_group(domain, group);
+	/* Attach the group when attaching the first device in the group */
+	if (group->attached_cnt == 0) {
+		ret = __iommu_attach_group(domain, group);
+		if (ret)
+			goto out_unlock;
+	}
+	grp_dev->attached = true;
+	group->attached_cnt++;
 
 out_unlock:
 	mutex_unlock(&group->mutex);
@@ -2071,6 +2080,7 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 {
+	struct group_device *grp_dev;
 	struct iommu_group *group;
 
 	group = iommu_group_get(dev);
@@ -2078,10 +2088,20 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 		return;
 
 	mutex_lock(&group->mutex);
-	if (WARN_ON(domain != group->domain) ||
-	    WARN_ON(iommu_group_device_count(group) != 1))
+	if (WARN_ON(domain != group->domain))
 		goto out_unlock;
-	__iommu_group_set_core_domain(group);
+
+	list_for_each_entry(grp_dev, &group->devices, list)
+		if (grp_dev->dev == dev)
+			break;
+	if (!grp_dev->attached)
+		goto out_unlock;
+
+	grp_dev->attached = false;
+	group->attached_cnt--;
+	/* Detach the group when detaching the last device in the group */
+	if (group->attached_cnt == 0)
+		__iommu_group_set_core_domain(group);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
