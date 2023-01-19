Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BCC6742DA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjASTbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjASTbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:31:21 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7553F9371E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:31:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLa2NwGzETfBzWeAEKbGSi0KVSA4yq9BclJfPCeVoR+DWrMI0HQ+nTTXumLbssdux9O53Hzn7TPgn32cYcd4/3jVJIPogkoppdlkZRtXon5ntdtYe25ldKIxx4QCuDSuxUQaP0QpfsklMRAcmO1VzUhVWz0WA3MIUz47cjS76HRd3S9BlsfwND1LMUCiUJI/q1BVgUlcBrSbe3WZI/WW76DwpLO02Q+Q8sXxFFYimFp7rXhGXVhaco4vvo94+seKyQXUajRnJ1bo/KMFjHv14kkID493CxLQDAVMrSFoMpazYIH9X5E/9ekfLH1iqOzf8D+gzIER5UOkkjkMX1R/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dm7Diquo74JCbI8qgtcgdVIdh183fv0df7JM4U4HSh4=;
 b=h0AZ/efSl7ZuDdqs1F2fblfqaIdVmh3MpwNB2SO1r2RMo2owKxpFWlNCy4NPEUAvP/3tR8fIL+AVjDhr3qYmAfHl7WPGnDx6OYjZgpuaNb+db8rnh+JV0oClgStTLsHkq//adB5LI6F8xjCsvFQCITyhEDYp3WdvVUPkLXXWNR1MIFcYwCve2YhMVV65Gq7tg5HwdU5BuqilHdYRIpuwJuC6V7WmrrVQquDRbk9Y4HH4O/nbJsJj68lg8Sq29iEMuwDgZ7M8o5g+D5aoi0RIeMm0vjt+pPmuLuy84dFkUkLyjfYGUAWtR19LKwKDRWDQ3BLtjib8RM2+9Gig2Yq5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm7Diquo74JCbI8qgtcgdVIdh183fv0df7JM4U4HSh4=;
 b=mJ/jl1hWRR6OIc5nJSVPwTxksOvHtKSmvrRs5sQzqfCUCUbvHdgRv3eH2WX2SomOhOd23RbCdnm6b92J8PDy8F/cM3EI/HLSlZsrFHeXR6nOkbRPA4XXHTPFQ9dZMuR+HY+3GoBkSlX4IPu4HegFurul7kpNCmusdXSPcGgzAI9SZC0BZqECe0oauF6nkIYOMUwx0FNBYVDNKcW4iXxtlvyi4VxCa9DLQF99EdawPsXiu6YoskbYryty3p2h2RF9b3hh3PKASiS6ixRpum5N+XOCcE2IEJ26ik6kPOFZxi5+uuZFadcsxpCXKweK5UgohhJ5pFIAnPXy4tez+Fim7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 19:31:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Thu, 19 Jan 2023
 19:31:18 +0000
Date:   Thu, 19 Jan 2023 15:31:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, hch@lst.de,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] iommu: Clean up open-coded ownership checks
Message-ID: <Y8mahcvlGlHNlh6q@nvidia.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
 <47109befd7a32d03bffe54192bf02f8c8a223858.1673978700.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47109befd7a32d03bffe54192bf02f8c8a223858.1673978700.git.robin.murphy@arm.com>
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 47912e8b-c9ab-49ea-6553-08dafa53bcc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtpTjDHAVqepFpfrYdcCPBdBTq+ts0OAcUBxa1E4+HPrtETt7gz+0XX/piIN3ca1Dqg/yvIkqHSY++YAsgJz1s4wxF63cPkzHagfW0vF5Km9kOJzKQ87v3eepiyjYLle8IYrcKUOOTrn/mId/K1keWFbu6aP9aKjQ1Zy07p4PaYRtFtR9wBwoJj1QpFYsZwt+Oqs9oW8/meQ6dx68HIqfffefysZOHEKO4oSNUFpHOFMCEg6Oca6pFTZG8mqqY6ypw8yMnMZVWS/E8Ml4e4iyqP6QWWkNgSfyfshaEECe/dF1oET5pgLIiRFl423ZdrxeTD5o7qcchtPpNfv0l3skW0WE82O49psNbtiKN8kDdfbUoa/OBvimPLNxFuuPw2wtkej4LPpb8LPH9pQxfn7l47yqH12Huss1THFmNrBrWXB5vNskBZtrW4Wkl+SXH2B9T8KMRRtOQd5A2WyImIaPljEQdI8+ZUmmVZKMZRqUt6voy5RVs5mDAhhxsSFhdVuqeO4jUMkmSuiZXTLAIb8HB1QfWDGvCPSdXG7ynaIxfEE2iIifajwUn+K/q4UBy0P2atq5cCXi1KE3Gj9EUPvM35O4wW3jJxCtKp87/AMbYVzPiOL0eGf4Or3wyO+/ySS/BSXYw3F2r4+tPHHLlxVtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(66946007)(66556008)(8936002)(2906002)(5660300002)(66476007)(38100700002)(6506007)(86362001)(316002)(6486002)(478600001)(36756003)(41300700001)(8676002)(6916009)(4326008)(186003)(6512007)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cu9li2ScjL96hBaVw2pzKzSkgGf/DXNaYLNPY09IvEmhv+QD1w5vL1chpViL?=
 =?us-ascii?Q?BhogqiBpU9XeWq1t8kgz2PEk/m/Kn1cs8jbDx5ML2OWFZ8sCfjIlJr6AHAhz?=
 =?us-ascii?Q?NXGtJnISukekzRXcL/KTxI0Kcal/xWdqu/v1s/JfEQKKoYhT5sF6Rlc9PKTz?=
 =?us-ascii?Q?rBLQS9RPTgnYBiDXzzDyDxC6ucbvl+KzlOfHJI6ejAojxqvratzIIbQS6OaG?=
 =?us-ascii?Q?7dBL7ATXfyX5bRINsLGjW5FyoerS6W9JpPfGbgDifwR2+HtDaJ++k/N50a18?=
 =?us-ascii?Q?HEoaHjNMGFAJnv4ZqnnA54WwSEHk3L/D8fIbjqQ/F6sDjB/sR2JB5/DTPdZm?=
 =?us-ascii?Q?QrkPWzRzbDompWI/oZ8U2jCdt2+t6xMEJ/QIeW8geNTiygw7fTWbmshjjkE8?=
 =?us-ascii?Q?dp4EaRLV1SXKv6pRSnZzujnLiJMdt0d2X6qIz1NFscARj03WCUJ/swtZzekf?=
 =?us-ascii?Q?tLGOKP+NsgrwMyq0C/iDXaGxuCaBCPFAmqkdlaBfbywuqt2UlDkPa2LnoAUQ?=
 =?us-ascii?Q?nnaobfFMSXIVIzeCXoMXlWG0pqYNKFXwluTWYTlmsCyCZ2+ivziSjEQTosDB?=
 =?us-ascii?Q?aFwBas3uawGShsMlZR3Jtx0ROYRqtHHO4GOxYYidQSzDGs0age4LVUD1CoFQ?=
 =?us-ascii?Q?1Xop+mgnGer6XOfzKPoGJuV0FaEDN+XKYZMZahJkHZbFBi2vu7MTgFZ/GE5V?=
 =?us-ascii?Q?LGILBa88ztCqW2qn+mAd7NIXMCxyjxkmadsprkFizt9pLn1EYxs+Fg3nISOl?=
 =?us-ascii?Q?aGFSzlgu/WCBJFqLH6T9qK7sXOurBTG7Yy2FDb7wd8pPKUhkv5su0uTS5eW4?=
 =?us-ascii?Q?9pmlPSlJvOkl06AOMS3W9pla6y0zztC1TB6ZWqFSAp90MRLplROhvEEFdP+6?=
 =?us-ascii?Q?V2QksNJrI4PUnUXWHFY2b5chqs+bUyvn4IvFH+/VbTNEgGEONj44DEXZZ1K5?=
 =?us-ascii?Q?dl1+BAwloivn+LHsZF95AeHRDdhkeRMmF2l8DQmT3xln0LTU+5OPvLgmE4GS?=
 =?us-ascii?Q?h6GIrKwpq/iv/HXGWYCugjMvexvPCBwFOckrMelKgkUjI/8d8xaftLbxz0Ar?=
 =?us-ascii?Q?PbS2draTikc/yfqn9FCMTDsLu3/e0BsvK+XYlzWY682i7hlkdK44y5wCji9E?=
 =?us-ascii?Q?7iAIcN86CJZUPBBgczkqOcFbOXgT8CMH+TyRfiIlcpaHFAY5Oh7BlXcJSdC2?=
 =?us-ascii?Q?fB4jY6Y4TM7x10Hde/Z8mLJcvVYeukIZjzwIduBg/lmuMfU9HHdxnBq5/UpJ?=
 =?us-ascii?Q?5wFe2TinC24MBr6HVLK8gYmqO1+vInOrmknpOHpdbfgFf2iidFufbIB0ztYI?=
 =?us-ascii?Q?PuHKpYplcHtTAFSzpAes6x1li2Q+f2kgMVqGLXyRZqub7ZU61teLSLJuHaAq?=
 =?us-ascii?Q?WPDBGRXkDLs/+COPIrzY0D420t2kZXIhbj1223R8fOFFDISoqcoGuYcmG88k?=
 =?us-ascii?Q?KM1TQTx+L+FRJVkzEpJ9cGC7NY/IYLSaRuWsapdodBTYPJYZrekspQ1YzdYO?=
 =?us-ascii?Q?tt+Nl0jYqL68K8JDML4Hz8IzzDWIHbXCzhW1f7CBOn3PWk2ZdLbR3nmDoxQJ?=
 =?us-ascii?Q?hBAikSLo+aUWyRjAoWS11PglZyReo2Cctlw8lQPc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47912e8b-c9ab-49ea-6553-08dafa53bcc4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 19:31:18.3657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaCnXvG8YPhVtAmSEFdKdBoOX3X4pHnE1jGIk3Hj+5iiWIg1zwzdmgmpvuNKf7UP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 07:18:25PM +0000, Robin Murphy wrote:
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index 270c3d9128ba..b2d3d309be1e 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -79,16 +79,6 @@ static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)
>  
>  static const struct iommu_ops qcom_iommu_ops;
>  
> -static struct qcom_iommu_dev * to_iommu(struct device *dev)
> -{
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -
> -	if (!fwspec || fwspec->ops != &qcom_iommu_ops)
> -		return NULL;
> -
> -	return dev_iommu_priv_get(dev);
> -}
> -
>  static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid)
>  {
>  	struct qcom_iommu_dev *qcom_iommu = d->iommu;
> @@ -361,7 +351,7 @@ static void qcom_iommu_domain_free(struct iommu_domain *domain)
>  
>  static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  {
> -	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev);
> +	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
>  	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
>  	int ret;

The confusing checks for null qcom_iommu following this should go away
too, right?

It should not be possible to have an ops set on the device but have an
invalid priv..

Jason
