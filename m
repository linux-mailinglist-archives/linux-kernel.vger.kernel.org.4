Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEE6695494
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjBMXTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBMXTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:19:39 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDE713DFB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:19:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diN0Iw9iQH5f7AXCs8Dlxl+GsLVEQwpNX6ZCzQ802jIqAi9wqeSnWiSzPQUH1GobsRIQmMI8+l4vOUcZKFP2VUkgxrg6t8eRkdqPpbmSTvwAwTXY0Gc9GAva8yLQ3VMtxf46o2DO/pH2WNozBO5vyybnlne7ad5OKi19uZKwPPKddu+vt5MQJGFia6paP8vtnFn/IaHROF4UYBXJIJXY9CxXmdd4E2gzpRKTbCKKye4Rei1lHaXDB/t6HrjRj/HpVpzvwY5dvDdHm8XmxAsU+HXH1LIbBVuSHkrkQcKBVXo1pSz+oe+ow8Gy/az6YAACxKA6GZ/DSFuk5eSXpTc51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I60thnCQv17/NWZQ9vafYbcunSodVRuGnK4yOtlnzKI=;
 b=eJWkfhQsf6y164R3hmdYQnHE9mrKuA42c/EUrOOhdIacIjBTpvlf72ZZvgdDiYdzv4CMLNiSPtzZswLUDPc9zvhc66z4qS773peZtRrwyyJ0TcS7tXvJjS/e6uhqx4A6w+b++dYQcr3g0+eWRCZvgq4rF6RqOQysyV7USaUK3jjJEdVfN6A6WfsMbH6pFEFziGMV93YCWVbUxAX3fTZhHnjA2z2QnfKmhe5+Wl2F1k0DxExBJPJJ31G0xXtPiA7LJ+bj/UkwiOqaoV0COGnUJGzI02ya2dLMll8Oc4fDzEMv/evu8nvm84+7JbHTpKJ4akjOMeyD1j8tc7A1Ej7mMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I60thnCQv17/NWZQ9vafYbcunSodVRuGnK4yOtlnzKI=;
 b=UY0cJ3AvKv0F5a+GH0qGSsTwmU6k9bXMt+hKh7g88/y3hNzm5uOeE7K5FoJUlLJR1zUNX9wIiPIC6KgRKloQ9+MxwuN57XyS2w9NBZu4krwUB/DzInZu8I5CIpysyrKVJrbE8y2/JfCTrm7X5jS4CKW+/cpqVEvMChZE7OsBLKgnY/BqfLaK5djJqumfrDhOzPRpDY8B8eimfL312Slz1bLFvPKeJxch+fiOSKRGMrQZ6yuhsHf0Z2nkroRn6YVQ5ys+Wr17+zLTuHyNWm55JCsvhKSuWK1J9+MM+XLeRt725fomL+KDeodNE4UX84Y6krMld9vYfZuZPO4HORsWJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 23:19:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 23:19:36 +0000
Date:   Mon, 13 Feb 2023 19:19:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Remove virtual command interface
Message-ID: <Y+rFhwxyMstovCiX@nvidia.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
 <20230210230206.3160144-2-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210230206.3160144-2-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0238.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 37fb9abe-d3d6-47bc-53b4-08db0e18c5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05pwxBBmW5hqv0W/GtZ1OiKeB0ykzY/xTMPEtLo5xOQsAEfHfKYeyfD4T1xJV9+mbVtyC9WznpDR0EK+4sxvpA9/464EW8NXilNPQqv0IOjY6KTHGNPpg3hewrcwq8ZZB8juNf1v+hI87uL4viCvF6bVvegYhXMGqtS8gmHRIZF3CRDtTPo90fGMMfmEbcbafJyh7oSvT2YfBekaozclnn0CXzqTBlKPY+q7LsE3j3bsNz0fQFdYvUm9beux+6Fn0UY520nbPNirxdeHFlpK7aR4L1uxftTlrv4iy/miUrKOAPZYhQ3GTFMkx/L94G5Hcdw6h1uSIvXpRgDkyIMcao6/2zS9V6c2RmD3IKrXdLBzyp3Ch4jF7L33elkKAJdzFq35z9ctHpkQhcWxSnXFqg713Q9Ese4Kn5IC2EIKhOlrdiiINhHYesRXJSL3rBjG2HWgfDYJ3OQlP+Mxumiu0nKApuq5ht7hgRN+q5VN12JJmn7lzJuRwVJJ4rScypmBEjpSZTROoBhH9SXTCcGgW3boznJTMbqSDZgp7NMeAFctbnTdVsHzytCYe7hPUwa/K5yzrY0nD/wgXsbh2VEAO5JHwQNtBQ6JsF3z44qB2VP8cUkXvZZVVwanvZHCeCcvTeuX/YDXncJsPEP2Alg0Sys24LdKItNn9KFrIvM65aj0+mNqQbds+PAhKXg7xtor
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199018)(6486002)(186003)(54906003)(478600001)(26005)(6512007)(6506007)(7416002)(41300700001)(2906002)(8936002)(5660300002)(316002)(4744005)(8676002)(38100700002)(4326008)(66556008)(66476007)(66946007)(2616005)(6916009)(83380400001)(36756003)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3+jW2FQH224HbdW4lhZUViCKU1U50QOOntIcl2uEnI47r2RabdrlXGZubpuy?=
 =?us-ascii?Q?2a1i09UwDjTjPCR31t6izz62xvFYew327nqfECS1zuQ0Ej4RuCXtY+6MxTQ5?=
 =?us-ascii?Q?U7FIlfVAXkr7BS/Kb/l2Oi2WK2TLq0UlamCk42izOdrGAWlO5w4rUn6v99vV?=
 =?us-ascii?Q?aiFvLyvLcsOJ8KKLMIHmw5kYWnMmfjwPZj31LEbpsnyzs+mqiy8mL47hSz45?=
 =?us-ascii?Q?FGVZNT5XjTdRJDYINZDpS47bMHqojrJm8aRZWC8V6v8qIInbyCMLw5b8Pk8T?=
 =?us-ascii?Q?sfOacH7Hrq3ML5keLXwc/0MtFqEetI/C8G2nH3I0vq1J5OthlnDhCPDjRLj5?=
 =?us-ascii?Q?VXc/2oe5m4AEz719ke4MTNX72Y7CZnefNrPYNMWLHhN8Ip9BOFhmscivfmBh?=
 =?us-ascii?Q?0QMhApEIp+Yr0UEUGlCCQTgUTZwWlhloE0jA/KLFWsVggA/OezUNxzfn+TWy?=
 =?us-ascii?Q?zi4d7CQayzbh54bORKRBe4AN9Ty1FnttgcbjTUYLTeK8C0wOwwlLyZW2pDF7?=
 =?us-ascii?Q?wq7niC1k9AwhQe1hEUOe1xYOnq642quzgk/mG2HFa5UTq9eq7iLlEMQF6Osb?=
 =?us-ascii?Q?BXL5whtWg7BEpsDDJDdH7eCCmN19bnvyrd+MENSXculBgl8C7Xvq8+pAZWDR?=
 =?us-ascii?Q?73GLnMGJ4KapLbwRD2mYgTLa4Pi8PmFd+D9G2ZWgxus9pQF3DHQZO9zXhd2z?=
 =?us-ascii?Q?GzSIzHEnzQRJKaC0HlxsoLKZjEChG93iQbyn2VBSvfHwb/WEA6y1st42Ad8q?=
 =?us-ascii?Q?/zBKAJQtR+NqJe5ApWfPwiphRGbFVp2SoTup1eCIzXl+IwD1fJ8pxXyDJv8o?=
 =?us-ascii?Q?Lw+jocbr1lVoia0Lf25l7O3dSYcmVowDEZXAqwKdWFHIaJWhyZ+ZRUx0IHdz?=
 =?us-ascii?Q?8ZfJstXr5F1cnA/OEAGbmsUtej1t2CXQFpFbLNO6+ReEukSmVyDE15OyuKLJ?=
 =?us-ascii?Q?p4Qz+qY3Ly8bkTRxYkIV1JNLKJkamWG1nDs2WVXcRWvnNEXEv8kpE9XQNCej?=
 =?us-ascii?Q?Qlxd7TkQbNrI7xroxuJq0eee9x+aFkoCNkfGD7t1eYQ81SMiTSaVDPloB9re?=
 =?us-ascii?Q?80yuAaL1uhGkvEND0b9a6jelpvo2rmJ0eFIMIv7bwZ8HgyduTRGLP1GmX+pV?=
 =?us-ascii?Q?qjRTVJ/YI3qOQEQkJzR6w8VM9rQ9IhI0pfe+LeTTvlzLQEz+Unv5nmVhZqIK?=
 =?us-ascii?Q?eNUnm2TN5wd9IRspKmgnnmbfkj4GR0bpOqJnbwhOzvv5lv3awrngN0xe5q8J?=
 =?us-ascii?Q?12kOYxFRLhtdAH9MMsf3gSPbB2JF6/7o3gwmUax+OR7zI0saYERpT6HevV7G?=
 =?us-ascii?Q?2rgrykgn4LjS6QjQh9WtZWOQHywu7shx8edVq9xDwpt7dhIWKD/hWCZrNh2V?=
 =?us-ascii?Q?kA5dQH/YekBgxxMkbAA0mcH6b3NpQe5EdK2FU8L6RH403zSjSB9wyC4nSXrZ?=
 =?us-ascii?Q?Cb+BsWTkEhaMVXqtyhGhspHKP37ciMFKN8bNM4qWdQJ+N/yzRyMnbQ9RhY27?=
 =?us-ascii?Q?anfQtLszxNL1YIV3Mp2vRS/LbUkYq8E1snV0u8doOU9fC4LSxvTlS496mPOT?=
 =?us-ascii?Q?zzsXpJKjeVJQLpOP6iXxkIdkIQXeTKSXBHACoQA2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fb9abe-d3d6-47bc-53b4-08db0e18c5d8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 23:19:36.5912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQlJhTLFRn6zU6sbvhYDpy9HtRtza+rX5sKExUWcD9LULe/OOY9vvy8JJ4Q12egW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 03:02:05PM -0800, Jacob Pan wrote:
> Virtual command interface was introduced to allow using host PASIDs
> inside VMs. It is unused and abandoned due to architectural change.
> 
> With this patch, we can safely remove this feature and the related helpers.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel/cap_audit.c |  2 -
>  drivers/iommu/intel/dmar.c      |  2 -
>  drivers/iommu/intel/iommu.c     | 85 ---------------------------------
>  drivers/iommu/intel/iommu.h     |  8 ----
>  4 files changed, 97 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
