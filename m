Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94479644F52
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiLFXJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLFXJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:09:43 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBA841986;
        Tue,  6 Dec 2022 15:09:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMqMnHwZga+fRErp11/0Jn02vmO9vIYFqxHxjTOx5yOBrVYQToNXQA+K5nTgUhkzK8puehwgFXwLOWXJsA1FCHrQZtRcAhKICezFxiIoEEVViMEuk8fdPNENES73fBZMZDRYjxzefr1HvJbwm1Ix3GhOoAh83+RVV/qLESBjKU4K7EQnxWges9tZmf748+YaenrYBQi2Hlogs3XypQoVLlDyvwzKMjn2n58OwTDswr8jCz6eLqYSo3xHvySvwLfCuxj+14+iKgiQ6cswBd8X7cPVBurNrJTQIXv5hqKsSzErSih7VRJWc9m2NaOoYY914x+Qg9aPKbBULLUYpDgsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=907fOOLSpfn68EgMkyOdbmnXhZqYT8AO2DzK8E2varo=;
 b=TKb/ED/n6NetULgYM1A7yI3cuYkOOgsYDrDLsSQ0uBR+AxxNkpKrv3cZFZnyARmeeoFin1K5n1LXPVXKL1hfOJGc9MC1Y5aw95pUZ4jyOOZaU4G1zldEcOPMuPhuhg4R0OfCkoBB3mikbM4ZGSTsDOInn4t5lJv2e4Lp6E8EGv2u0pcLKwrfWw+Y0lL7Dz2azDXgrQZgXlLPkQhfGtzfzIDxjk/fqqO0TI3BNTCb0rWMgOMpsJ73RT+mbJDbm+FRl/w7Q/lvaSpL3+zjm4n4xL46SCcQxDKCbyA9qj+2/rNg5U1kxgPTFuwmj5nhHttt5Pb7dHpTBKvXGD70pNIHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=907fOOLSpfn68EgMkyOdbmnXhZqYT8AO2DzK8E2varo=;
 b=rXQuat9z1GT8U4GeXxoutU2L+gPx3wdsfmAlPMJHRSQM6i+OdbFGmBp5169Vx+7uUenIG496yTaVzQgXzgMz2q9H2y+HI4+2yV3Owgp1BzBPVBMrq6H0b21wsx3sii+iK8+7l4kPoFMBwYJ+qDJJSlZOPgi6QuvKeJnZNutmkCpC4Tq3+hD2jp1Tfo3qIQsfVMQsbLQgg3os1MsaeDOZ3gmXfo840qfC0Iv5v94mTslvkPjZFK1OKEkFU7/Rd4Pv106QrbL4RZUf5svb11m7ht2J/S9SCVETQVy47DgwVb5XtJNvwOHeWrcgaHxdjwYjLaPwUFifu756FtPOymn2MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 23:09:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 23:09:38 +0000
Date:   Tue, 6 Dec 2022 19:09:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
Message-ID: <Y4/LsZKmR3iWFphU@nvidia.com>
References: <33eea9bd-e101-4836-19e8-d4b191b78b00@linux.intel.com>
 <9163440eb6a47fe02730638bbdf72fda5ee5ad2c.camel@linux.ibm.com>
 <Y4S3z6IpeDHmdUs/@nvidia.com>
 <52fe7769ca5b66523c2c93c7d46ebc17dc144aca.camel@linux.ibm.com>
 <Y4TjWOXYD+DK+d/B@nvidia.com>
 <6c4c3a3e-1d8d-7994-3c03-388ef63dddb3@arm.com>
 <Y4ZCVgLO9AHatwXe@nvidia.com>
 <eb30ad63-92d4-2af4-22e7-d82cdf08565e@arm.com>
 <Y4Zm53o1ovdIAqr/@nvidia.com>
 <4b34be4433856d9a3a5bf13dad7a77c1ba93db13.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b34be4433856d9a3a5bf13dad7a77c1ba93db13.camel@linux.ibm.com>
X-ClientProxiedBy: BL0PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:208:91::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b48d94-ca1e-4364-51c0-08dad7def2e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +UzsL0S0og92Z5sCWCCeH187BdEV3cKhPVTlwPM6T+NIKSyyFzf5qxey8txdNU6/ij+hw3kL4i50HbaUQNkfUHa850UUl2qDrIZYBBXd6oXl9lnIar3TYFDn/qLGDbQj7RNwdaCSIgeO0GnYksi+GDUx7ZLsHGZ6CBcw0xsqnFTfWYoF0jz0wQOQyWgFmrptWJEq1wmdhEr5zd614s0DPBRnVqedI35UxoXpHV2htnIq7yTIPRO6bLm5AF1tzYwopTU2wIkOQwijnZPqXiCeaJTEkqeOMojjsVaD32tCA34PXQ8S0pwb/5CxntYTjZgL5vDKxcyC2FZT2+CdeyJWmXn6EM+ycohakxViE7HxwYwOBd3Be7UN9SpkONxmaFYBocJ7rQeWA9PwealTZK1J0egBkIok2QrB/Io5CP3lXACsQqE4rpvFEvwjYEMl/+JneacWRAPPlATLvyErc/KgLnUBGEStZnhB7ZRHmk6FhRs6eqzppUygsYIYiI5eu7wxiqkBXnCx3bYlS7qNfrEZ+OrYFTZQrhtD8cZbq5Qx1IMWpK9vE761qmHHQCbjWbchpqnlp9w5Rvfs5Nj4WmmEFKVZSTkBpAKtKKm8X/w/7zYI3V8nGtQY9IUPn4xM/kWWVfxWclqe53h49IKaEHls3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199015)(26005)(2616005)(36756003)(478600001)(4001150100001)(2906002)(86362001)(316002)(6486002)(41300700001)(66476007)(38100700002)(66946007)(53546011)(66556008)(6506007)(8676002)(4326008)(8936002)(7416002)(30864003)(186003)(5660300002)(6512007)(6916009)(54906003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nxF//GVE7hEpiSjnAwi2TG9oUkaDaNJXW/dRQD5th6rnylz+pvL1WMkqTdKD?=
 =?us-ascii?Q?DoQ6UO3+zBZaJnJm8tQfkK1HAOmsZU3Jgxmtvia4ZyqQDhCirtcNNYuBO+zp?=
 =?us-ascii?Q?3wOd8Dn9nwctzcLyizYV1rW+c0i1XQ0R0fF0hHhiA5tzMeNyCCDla0wAPM0o?=
 =?us-ascii?Q?TK4kzBz/kK0pOyPS2WxHU+WijLU1vB3cgNPJF7ly8Woh9//qG4U6csje91ft?=
 =?us-ascii?Q?aJO/I5CssSp82lztnyIF7ITmv7XFPV/zXITWIVoVTPCfpiNN78j7Jd/0XXUE?=
 =?us-ascii?Q?OVMiEg8ZEAcSV4rrCiGl31Et3fOasExl/pGdloxLhDPgDt1HcualFZwwL8Ji?=
 =?us-ascii?Q?lJF2fALuob6xTwbtM6hO48yvPPjJrahx+h77c3j5f8NSWxUfMNPmJzoZ9RRF?=
 =?us-ascii?Q?Fh/Ueon35zE7xb9Ia436DHcEC0P/V3bJEQ4VL1EXPLEzHOzdgpip8t8Ihngi?=
 =?us-ascii?Q?N//e53Fe0fWFKkg6O+JE0pQ2rhm+rsa/UK6qbVN825cOEmOCvTai9zz/pIkj?=
 =?us-ascii?Q?33gXERTRLSK0fiJtdQAprX1n0jjk6in/dFZIocgD/4WVIdR6+Sqk7ygM73JX?=
 =?us-ascii?Q?NbgPYSpEJGoQoIpHVmxd4jTp7dsDfnF91Xl0h+8qomrU/6PhNMgiYPfzCaPG?=
 =?us-ascii?Q?8QfxrDTZvNwMDHzbAXNIlHN+yF9oDlZyOvEf4HBMPcqB/Oq/tELRd4Wr4XLn?=
 =?us-ascii?Q?VXiokEie9KqyMJEFiW+u9VKTIMGjhfqHM9nWHmPv+cmBdbifjy9tt/ZA42cN?=
 =?us-ascii?Q?T4KQwgGZvrKDNeiLOcI5DBy+l2jQ4gcFHGJl5G+icJlpzDnBizXF3Lg+MnCH?=
 =?us-ascii?Q?xgtADG48IMVc+Erofx2OfziSdSJiOYzmhNPwwK4jInVe5JdEef078uzYi+wy?=
 =?us-ascii?Q?Mix4D1LNjwHHO1ZUK4R1MtEkWXAiLeSRS0apBEGR+C8+yNMGOpfQPlBPSFp2?=
 =?us-ascii?Q?zEg/6kYkgW2mnfC3ynSdcV+OJRuQHd3fd+ecnGA98PhV2cm4SfEh/pK8Jcnx?=
 =?us-ascii?Q?Gf6HJNYgO2J/iHAFeFwcP+XvatYcAkg1KwExKORkjLwGTBIzWt2kYLXdmfnt?=
 =?us-ascii?Q?gKHH8Nj/o/CzJQSLz2xFHMISSP3YBrbM5tqsmhWI77hWOSvyHxs4OftKH46N?=
 =?us-ascii?Q?KVOoBXVElBv3SvG/xYEJeYk5NFRN6j4/20otTJyuoEopkkIdV4FA5eZOdtEW?=
 =?us-ascii?Q?DAkk8MdOq7xivO1Ck3cIaQXOkMKbHXoXDmbBshy/Gh0jRv4H3d8vVKGVFVH2?=
 =?us-ascii?Q?NQv3n7FugBjOx31/T6jQ0997E/WYqBEDnSXJsTR9uWOKEvw5fZFN4XRLeO2s?=
 =?us-ascii?Q?cCIZwD/OUShYBEb+SDQjo6y54VVjqRApDplcK0Ip2G7PvZ2j5KYSxlSdMcPN?=
 =?us-ascii?Q?QGxGBtHTPY1pZ0dTEOnYxaeqe9J+5U9Cijd4Uw0VTyWcJtskuXVIsFIana4y?=
 =?us-ascii?Q?NU/4KeSZ/+iC4UFSjgAZIy422wuX4Pm4qUkHcZuB3wflyJuBEqruyHQn3GY6?=
 =?us-ascii?Q?ZxTjCXP/3Z+Andnb4Wjq2E7Z2oSXoVAfcDlSzrij3s2SqcC9yJXhs9XqAWxY?=
 =?us-ascii?Q?g3ZPzMEz12VYwLtJg0w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b48d94-ca1e-4364-51c0-08dad7def2e7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 23:09:38.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8cXEuRvfoWEW7gc0XUDPQFkVvz+tH57w7z2qtOsGsLYVKAYzAaFUcfW5x3DE2ZV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 04:34:08PM +0100, Niklas Schnelle wrote:
> On Tue, 2022-11-29 at 16:09 -0400, Jason Gunthorpe wrote:
> > On Tue, Nov 29, 2022 at 06:41:22PM +0000, Robin Murphy wrote:
> > > On 2022-11-29 17:33, Jason Gunthorpe wrote:
> > > > On Mon, Nov 28, 2022 at 09:01:43PM +0000, Robin Murphy wrote:
> > > > 
> > > > > I'm hardly an advocate for trying to save users from themselves, but I
> > > > > honestly can't see any justifiable reason for not having sysfs respect
> > > > > iommu_get_def_domain_type().
> > > > 
> > > > We really need to rename this value if it is not actually just an
> > > > advisory "default" but a functional requirement ..
> > > 
> > > It represents a required default domain type. As in, the type for the
> > > device's default domain. Not the default type for a domain. It's the
> > > iommu_def_domain_type variable that holds the *default* default domain type
> > > ;)
> > 
> > I find the name "default domain" incredibly confusing at this point in
> > time.
> 
> Yes it definitely confused me as evidenced by this patch.

I did some fiddling what this could rename could look like and came
up with this very sketchy sketch. I think it looks a lot clearer in
the end but it seems a bit tricky to break things up into nice patches.

Jason

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index beb9f535d3d815..052caf21fee3dd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -34,7 +34,12 @@
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
-static unsigned int iommu_def_domain_type __read_mostly;
+static enum dma_api_policy {
+	DMA_API_POLICY_IDENTITY,
+	DMA_API_POLICY_STRICT,
+	DMA_API_POLICY_LAZY,
+	DMA_API_POLICY_ANY,
+} dma_api_default_policy __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
 static u32 iommu_cmd_line __read_mostly;
 
@@ -82,7 +87,7 @@ static const char * const iommu_group_resv_type_string[] = {
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
 static int iommu_alloc_default_domain(struct iommu_group *group,
-				      struct device *dev);
+				      enum dma_api_policy policy);
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
@@ -97,6 +102,9 @@ static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count);
 
+static enum dma_api_policy
+iommu_get_dma_api_mandatory_policy(struct device *dev);
+
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
 	__ATTR(_name, _mode, _show, _store)
@@ -125,26 +133,6 @@ static struct bus_type * const iommu_buses[] = {
 #endif
 };
 
-/*
- * Use a function instead of an array here because the domain-type is a
- * bit-field, so an array would waste memory.
- */
-static const char *iommu_domain_type_str(unsigned int t)
-{
-	switch (t) {
-	case IOMMU_DOMAIN_BLOCKED:
-		return "Blocked";
-	case IOMMU_DOMAIN_IDENTITY:
-		return "Passthrough";
-	case IOMMU_DOMAIN_UNMANAGED:
-		return "Unmanaged";
-	case IOMMU_DOMAIN_DMA:
-		return "Translated";
-	default:
-		return "Unknown";
-	}
-}
-
 static int __init iommu_subsys_init(void)
 {
 	struct notifier_block *nb;
@@ -161,19 +149,27 @@ static int __init iommu_subsys_init(void)
 		}
 	}
 
-	if (!iommu_default_passthrough() && !iommu_dma_strict)
-		iommu_def_domain_type = IOMMU_DOMAIN_DMA_FQ;
+	if (dma_api_default_policy == DMA_API_POLICY_LAZY && iommu_dma_strict)
+		dma_api_default_policy = DMA_API_POLICY_STRICT;
 
-	pr_info("Default domain type: %s %s\n",
-		iommu_domain_type_str(iommu_def_domain_type),
-		(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
-			"(set via kernel command line)" : "");
-
-	if (!iommu_default_passthrough())
-		pr_info("DMA domain TLB invalidation policy: %s mode %s\n",
+	switch (dma_api_default_policy) {
+	case DMA_API_POLICY_LAZY:
+	case DMA_API_POLICY_STRICT:
+		pr_info("DMA translated domain TLB invalidation policy: %s mode %s\n",
 			iommu_dma_strict ? "strict" : "lazy",
 			(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
-				"(set via kernel command line)" : "");
+				"(set via kernel command line)" :
+				"");
+		break;
+	case DMA_API_POLICY_IDENTITY:
+		pr_info("Default domain type: Passthrough %s\n",
+			(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
+				"(set via kernel command line)" :
+				"");
+		break;
+	default:
+		break;
+	}
 
 	nb = kcalloc(ARRAY_SIZE(iommu_buses), sizeof(*nb), GFP_KERNEL);
 	if (!nb)
@@ -353,7 +349,8 @@ int iommu_probe_device(struct device *dev)
 	 * checked.
 	 */
 	mutex_lock(&group->mutex);
-	iommu_alloc_default_domain(group, dev);
+	iommu_alloc_default_domain(group,
+				   iommu_get_dma_api_mandatory_policy(dev));
 
 	/*
 	 * If device joined an existing group which has been claimed, don't
@@ -436,8 +433,8 @@ early_param("iommu.strict", iommu_dma_setup);
 void iommu_set_dma_strict(void)
 {
 	iommu_dma_strict = true;
-	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA_FQ)
-		iommu_def_domain_type = IOMMU_DOMAIN_DMA;
+	if (dma_api_default_policy == DMA_API_POLICY_LAZY)
+		dma_api_default_policy = DMA_API_POLICY_STRICT;
 }
 
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
@@ -1557,53 +1554,100 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
-static int iommu_get_def_domain_type(struct device *dev)
+static enum dma_api_policy
+iommu_get_dma_api_mandatory_policy(struct device *dev)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
-		return IOMMU_DOMAIN_DMA;
+		return DMA_API_POLICY_STRICT;
 
 	if (ops->def_domain_type)
 		return ops->def_domain_type(dev);
-
-	return 0;
+	return DMA_API_POLICY_ANY;
 }
 
-static int iommu_group_alloc_default_domain(struct bus_type *bus,
-					    struct iommu_group *group,
-					    unsigned int type)
+static int __iommu_get_dma_api_group_mandatory_policy(struct device *dev,
+						      void *data)
 {
-	struct iommu_domain *dom;
+	enum dma_api_policy *policy = data;
+	enum dma_api_policy dev_policy =
+		iommu_get_dma_api_mandatory_policy(dev);
 
-	dom = __iommu_domain_alloc(bus, type);
-	if (!dom && type != IOMMU_DOMAIN_DMA) {
-		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
-		if (dom)
-			pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
-				type, group->name);
+	if (dev_policy == DMA_API_POLICY_ANY || *policy == dev_policy)
+		return 0;
+	if (*policy == DMA_API_POLICY_ANY) {
+		*policy = dev_policy;
+		return 0;
 	}
 
-	if (!dom)
-		return -ENOMEM;
+	dev_warn(
+		dev,
+		"IOMMU driver is requesting different DMA API policies for devices in the same group %s.",
+		dev->iommu_group->name);
 
-	group->default_domain = dom;
-	if (!group->domain)
-		group->domain = dom;
+	/*
+	 * Resolve the conflict by priority, the lower numbers in the enum are
+	 * higher preference in case of driver problems.
+	 */
+	if (dev_policy < *policy)
+		*policy = dev_policy;
 	return 0;
 }
 
+static enum dma_api_policy
+iommu_get_dma_api_group_mandatory_policy(struct iommu_group *group)
+{
+	enum dma_api_policy policy = DMA_API_POLICY_ANY;
+
+	__iommu_group_for_each_dev(group, &policy,
+				   __iommu_get_dma_api_group_mandatory_policy);
+	return policy;
+}
+
 static int iommu_alloc_default_domain(struct iommu_group *group,
-				      struct device *dev)
+				      enum dma_api_policy policy)
 {
-	unsigned int type;
+	struct iommu_domain *domain;
+	struct group_device *grp_dev =
+		list_first_entry(&group->devices, struct group_device, list);
+	struct bus_type *bus = grp_dev->dev->bus;
+
+	lockdep_assert_held(group->mutex);
 
 	if (group->default_domain)
 		return 0;
+	if (policy == DMA_API_POLICY_ANY)
+		policy = dma_api_default_policy;
+	switch (policy) {
+		case DMA_API_POLICY_IDENTITY:
+		domain = __iommu_domain_alloc(bus, IOMMU_DOMAIN_IDENTITY);
+		break;
+
+		case DMA_API_POLICY_LAZY:
+		domain = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
+		if (domain && !domain->ops->prefer_dma_api_fq){
+			pr_warn("Failed to allocate default lazy IOMMU domain for group %s - Falling back to strict",
+				group->name);
+		}
+		break;
 
-	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
+		case DMA_API_POLICY_STRICT:
+		domain = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
+		break;
 
-	return iommu_group_alloc_default_domain(dev->bus, group, type);
+		default:
+		WARN_ON(true);
+		domain = NULL;
+	}
+
+	if (!domain)
+		return -ENOMEM;
+
+	group->default_domain = domain;
+	if (!group->domain)
+		group->domain = domain;
+	return 0;
 }
 
 /**
@@ -1688,52 +1732,6 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 	return 0;
 }
 
-struct __group_domain_type {
-	struct device *dev;
-	unsigned int type;
-};
-
-static int probe_get_default_domain_type(struct device *dev, void *data)
-{
-	struct __group_domain_type *gtype = data;
-	unsigned int type = iommu_get_def_domain_type(dev);
-
-	if (type) {
-		if (gtype->type && gtype->type != type) {
-			dev_warn(dev, "Device needs domain type %s, but device %s in the same iommu group requires type %s - using default\n",
-				 iommu_domain_type_str(type),
-				 dev_name(gtype->dev),
-				 iommu_domain_type_str(gtype->type));
-			gtype->type = 0;
-		}
-
-		if (!gtype->dev) {
-			gtype->dev  = dev;
-			gtype->type = type;
-		}
-	}
-
-	return 0;
-}
-
-static void probe_alloc_default_domain(struct bus_type *bus,
-				       struct iommu_group *group)
-{
-	struct __group_domain_type gtype;
-
-	memset(&gtype, 0, sizeof(gtype));
-
-	/* Ask for default domain requirements of all devices in the group */
-	__iommu_group_for_each_dev(group, &gtype,
-				   probe_get_default_domain_type);
-
-	if (!gtype.type)
-		gtype.type = iommu_def_domain_type;
-
-	iommu_group_alloc_default_domain(bus, group, gtype.type);
-
-}
-
 static int iommu_group_do_dma_attach(struct device *dev, void *data)
 {
 	struct iommu_domain *domain = data;
@@ -1804,7 +1802,8 @@ int bus_iommu_probe(struct bus_type *bus)
 		mutex_lock(&group->mutex);
 
 		/* Try to allocate default domain */
-		probe_alloc_default_domain(bus, group);
+		iommu_alloc_default_domain(
+			group, iommu_get_dma_api_group_mandatory_policy(group));
 
 		if (!group->default_domain) {
 			mutex_unlock(&group->mutex);
@@ -2600,19 +2599,19 @@ void iommu_set_default_passthrough(bool cmd_line)
 {
 	if (cmd_line)
 		iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
-	iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
+	dma_api_default_policy = DMA_API_POLICY_IDENTITY;
 }
 
 void iommu_set_default_translated(bool cmd_line)
 {
 	if (cmd_line)
 		iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
-	iommu_def_domain_type = IOMMU_DOMAIN_DMA;
+	dma_api_default_policy = DMA_API_POLICY_STRICT;
 }
 
 bool iommu_default_passthrough(void)
 {
-	return iommu_def_domain_type == IOMMU_DOMAIN_IDENTITY;
+	return dma_api_default_policy == DMA_API_POLICY_IDENTITY;
 }
 EXPORT_SYMBOL_GPL(iommu_default_passthrough);
 
@@ -2832,103 +2831,40 @@ EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
  *    group's default domain type through /sys/kernel/iommu_groups/<grp_id>/type
  *    Please take a closer look if intended to use for other purposes.
  */
-static int iommu_change_dev_def_domain(struct iommu_group *group,
-				       struct device *prev_dev, int type)
+static int iommu_change_group_dma_api_policy(struct iommu_group *group,
+					     enum dma_api_policy policy)
 {
-	struct iommu_domain *prev_dom;
-	struct group_device *grp_dev;
-	int ret, dev_def_dom;
-	struct device *dev;
-
-	mutex_lock(&group->mutex);
-
-	if (group->default_domain != group->domain) {
-		dev_err_ratelimited(prev_dev, "Group not assigned to default domain\n");
-		ret = -EBUSY;
-		goto out;
-	}
-
-	/*
-	 * iommu group wasn't locked while acquiring device lock in
-	 * iommu_group_store_type(). So, make sure that the device count hasn't
-	 * changed while acquiring device lock.
-	 *
-	 * Changing default domain of an iommu group with two or more devices
-	 * isn't supported because there could be a potential deadlock. Consider
-	 * the following scenario. T1 is trying to acquire device locks of all
-	 * the devices in the group and before it could acquire all of them,
-	 * there could be another thread T2 (from different sub-system and use
-	 * case) that has already acquired some of the device locks and might be
-	 * waiting for T1 to release other device locks.
-	 */
-	if (iommu_group_device_count(group) != 1) {
-		dev_err_ratelimited(prev_dev, "Cannot change default domain: Group has more than one device\n");
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/* Since group has only one device */
-	grp_dev = list_first_entry(&group->devices, struct group_device, list);
-	dev = grp_dev->dev;
-
-	if (prev_dev != dev) {
-		dev_err_ratelimited(prev_dev, "Cannot change default domain: Device has been changed\n");
-		ret = -EBUSY;
-		goto out;
-	}
+	enum dma_api_policy mandatory =
+		iommu_get_dma_api_group_mandatory_policy(group);
+	struct iommu_domain *old_domain;
+	int ret;
 
-	prev_dom = group->default_domain;
-	if (!prev_dom) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (mandatory != DMA_API_POLICY_ANY && policy != mandatory)
+		return -EINVAL;
 
-	dev_def_dom = iommu_get_def_domain_type(dev);
-	if (!type) {
-		/*
-		 * If the user hasn't requested any specific type of domain and
-		 * if the device supports both the domains, then default to the
-		 * domain the device was booted with
-		 */
-		type = dev_def_dom ? : iommu_def_domain_type;
-	} else if (dev_def_dom && type != dev_def_dom) {
-		dev_err_ratelimited(prev_dev, "Device cannot be in %s domain\n",
-				    iommu_domain_type_str(type));
-		ret = -EINVAL;
-		goto out;
-	}
+	mutex_lock(&group->mutex);
 
-	/*
-	 * Switch to a new domain only if the requested domain type is different
-	 * from the existing default domain type
-	 */
-	if (prev_dom->type == type) {
-		ret = 0;
-		goto out;
+	/* Shortcut if FQ is being enabled */
+	if (group->default_domain->type == IOMMU_DOMAIN_DMA &&
+	    policy == DMA_API_POLICY_LAZY) {
+		ret = iommu_dma_init_fq(group->default_domain);
+		if (!ret) {
+			group->default_domain->type = IOMMU_DOMAIN_DMA_FQ;
+			mutex_unlock(&group->mutex);
+			return 0;
+		}
 	}
 
-	/* We can bring up a flush queue without tearing down the domain */
-	if (type == IOMMU_DOMAIN_DMA_FQ && prev_dom->type == IOMMU_DOMAIN_DMA) {
-		ret = iommu_dma_init_fq(prev_dom);
-		if (!ret)
-			prev_dom->type = IOMMU_DOMAIN_DMA_FQ;
-		goto out;
+	/* Otherwise just replace the whole domain */
+	old_domain = group->default_domain;
+	group->default_domain = NULL;
+	ret = iommu_alloc_default_domain(group, policy);
+	if (ret) {
+		group->default_domain = old_domain;
+		mutex_unlock(&group->mutex);
+		return ret;
 	}
-
-	/* Sets group->default_domain to the newly allocated domain */
-	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
-	if (ret)
-		goto out;
-
-	ret = iommu_create_device_direct_mappings(group, dev);
-	if (ret)
-		goto free_new_domain;
-
-	ret = __iommu_attach_device(group->default_domain, dev);
-	if (ret)
-		goto free_new_domain;
-
-	group->domain = group->default_domain;
+	iommu_group_create_direct_mappings(group);
 
 	/*
 	 * Release the mutex here because ops->probe_finalize() call-back of
@@ -2938,20 +2874,15 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	 */
 	mutex_unlock(&group->mutex);
 
+	/*
+	 * FIXME: How does iommu_setup_dma_ops() get called with the new domain
+	 * on ARM?
+	 */
+
 	/* Make sure dma_ops is appropriatley set */
-	iommu_group_do_probe_finalize(dev, group->default_domain);
-	iommu_domain_free(prev_dom);
+	__iommu_group_dma_finalize(group);
+	iommu_domain_free(old_domain);
 	return 0;
-
-free_new_domain:
-	iommu_domain_free(group->default_domain);
-	group->default_domain = prev_dom;
-	group->domain = prev_dom;
-
-out:
-	mutex_unlock(&group->mutex);
-
-	return ret;
 }
 
 /*
@@ -2966,9 +2897,8 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count)
 {
-	struct group_device *grp_dev;
-	struct device *dev;
-	int ret, req_type;
+	enum dma_api_policy policy;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
@@ -2977,77 +2907,30 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 		return -EINVAL;
 
 	if (sysfs_streq(buf, "identity"))
-		req_type = IOMMU_DOMAIN_IDENTITY;
+		policy = DMA_API_POLICY_IDENTITY;
 	else if (sysfs_streq(buf, "DMA"))
-		req_type = IOMMU_DOMAIN_DMA;
+		policy = DMA_API_POLICY_STRICT;
 	else if (sysfs_streq(buf, "DMA-FQ"))
-		req_type = IOMMU_DOMAIN_DMA_FQ;
+		policy = DMA_API_POLICY_LAZY;
 	else if (sysfs_streq(buf, "auto"))
-		req_type = 0;
+		policy = DMA_API_POLICY_ANY;
 	else
 		return -EINVAL;
 
 	/*
-	 * Lock/Unlock the group mutex here before device lock to
-	 * 1. Make sure that the iommu group has only one device (this is a
-	 *    prerequisite for step 2)
-	 * 2. Get struct *dev which is needed to lock device
-	 */
-	mutex_lock(&group->mutex);
-	if (iommu_group_device_count(group) != 1) {
-		mutex_unlock(&group->mutex);
-		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
-		return -EINVAL;
-	}
-
-	/* Since group has only one device */
-	grp_dev = list_first_entry(&group->devices, struct group_device, list);
-	dev = grp_dev->dev;
-	get_device(dev);
-
-	/*
-	 * Don't hold the group mutex because taking group mutex first and then
-	 * the device lock could potentially cause a deadlock as below. Assume
-	 * two threads T1 and T2. T1 is trying to change default domain of an
-	 * iommu group and T2 is trying to hot unplug a device or release [1] VF
-	 * of a PCIe device which is in the same iommu group. T1 takes group
-	 * mutex and before it could take device lock assume T2 has taken device
-	 * lock and is yet to take group mutex. Now, both the threads will be
-	 * waiting for the other thread to release lock. Below, lock order was
-	 * suggested.
-	 * device_lock(dev);
-	 *	mutex_lock(&group->mutex);
-	 *		iommu_change_dev_def_domain();
-	 *	mutex_unlock(&group->mutex);
-	 * device_unlock(dev);
-	 *
-	 * [1] Typical device release path
-	 * device_lock() from device/driver core code
-	 *  -> bus_notifier()
-	 *   -> iommu_bus_notifier()
-	 *    -> iommu_release_device()
-	 *     -> ops->release_device() vendor driver calls back iommu core code
-	 *      -> mutex_lock() from iommu core code
+	 * Taking ownership disables the DMA API domain, prevents drivers from
+	 * being attached, and switches to a blocking domain. Releasing
+	 * ownership will put back the new or original DMA API domain.
 	 */
-	mutex_unlock(&group->mutex);
-
-	/* Check if the device in the group still has a driver bound to it */
-	device_lock(dev);
-	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
-	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
-		pr_err_ratelimited("Device is still bound to driver\n");
-		ret = -EBUSY;
-		goto out;
-	}
-
-	ret = iommu_change_dev_def_domain(group, dev, req_type);
-	ret = ret ?: count;
-
-out:
-	device_unlock(dev);
-	put_device(dev);
+	ret = iommu_group_claim_dma_owner(group, &ret);
+	if (ret)
+		return ret;
 
-	return ret;
+	ret = iommu_change_group_dma_api_policy(group, policy);
+	iommu_group_release_dma_owner(group);
+	if (ret)
+		return ret;
+	return count;
 }
 
 static bool iommu_is_default_domain(struct iommu_group *group)
