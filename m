Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855D362C697
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiKPRnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbiKPRnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:43:32 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D12317D6;
        Wed, 16 Nov 2022 09:43:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqdcNbuUmmsuaFPY1hFrIBBqrtQ45ZZpcCLVWOwm/EE4rvZwfjNhzSziZMymszlfbVwrHeGlPFzg5u4X8elyXPcRzmWnYdHMaTOnuLn4svBKbZLUlsdMcsXzwlC4cx+XRCI0Tw1krUtG/NhAuNKH/sCLeYMa8I13RqfrYgi6/aeHvA0W4VeYaUpmsGlobxKqfw+5krl63Vr3dspk/msX/Z7AmVTSPC36j0y5E2RncOOR4Rm4wnGqqx9FXltVLIiRho8QPJf9snOVqb5uSfTkwrQ7dvGSSwvlAvR56oSoDXxOe9uaTTINNDahy9qsrg9ei3LcNWCUYa1FSZeOSQxq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRv5XjAnG1QEbUeXGCtSV+UQDB+r3jnEyZEw+L1zyfY=;
 b=UcONmHnk7Bs/h5ixfvuwZlF5zCNofnoDvqNDSmkDHhmtLHPYSwyILtwwu9v4mo/NanKtvXfyGoolIN3y3r0bYc+vAzzs7xFuyJ/qbMzhra39Z1s1W14rmcYsYqm8AbDb+wK8eZiUNhWgP+wMSRkTDh7vux1SVmESalPUNY/RPHVuRrEmpt0dzEDmiE4BlsTWilsk+3ossVXq4kYjYgnsLPJe8M56sBVvDJtC74n3jeC4Bwv2Kwh+F1vNubWpHP8MxGInx2FIPZsnwAxWJHnYSpwUTGFSQ97ZU4N0FoZ0N6KAVcjsirTtDQHaaguC3577mIqkzaqlCsIS245fGt3Pbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRv5XjAnG1QEbUeXGCtSV+UQDB+r3jnEyZEw+L1zyfY=;
 b=bWtMGVJX2UEbCLjv5FD51DLj7hzWeHXizwKCD8Yn78hU+UnjD9X3QJ85HmUfDvCA9jwIezIJuwZO3OEg/Vb9q8XxLTOB8JvTwBsivO3X06gHiL7MbxyMEmjmaZMelU9qXogXXr9VRHDMdYWpjMplUBcUNWE1aD3PXnSYNfXL/dUXrU8cakxZPps45sLd0ctaELlw4lnakMtW66MpaG3aQCw3x8/GyOvMZnVnZ9b9dcTUXWtaDjRY8VvxUQGjSG9RIQpo0008rdTgwzm1zM4CD0/8O/OaZlgqGc6bxFUZ0Z6lgTvVmc2AjdBRaBb6YG8SAS+3xb7pwhaIl7hK8N+CfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 17:43:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 17:43:30 +0000
Date:   Wed, 16 Nov 2022 13:43:28 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 04/39] genirq/msi: Use MSI_DESC_ALL in
 msi_add_simple_msi_descs()
Message-ID: <Y3UhQLz1x34pt6Xz@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122013.831151822@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122013.831151822@linutronix.de>
X-ClientProxiedBy: CH2PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:610:57::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: a39534a6-278b-46c0-b936-08dac7fa12ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qINBN9OmnUoWYKZk5CYryTnbLPVdQpwOxhdFPLgQXoffL9+rE6ps6c8RJXBDdzZ2fwLc1gH7NCQIA7wc7CLNIRJbYGVUL7tAonxgdDQROu1u6NOZa0ky6IsyTMc54uB9piy6dsVK51/Gf5Q3pgnqYiY/kX1p7HqEAOdDYslfiJ8Ua82Vj129q8fcy3xa+FtEVU/M8GVXrJT5H8+6yUexF2lz42nUJBNF1JJRNPfI3lmLj2R6DvNhoL7SpGvywlcseoCk+3093IfFRAx9l+NUmxqU1DPxtpC7tOkvoohu4fcEti/2n99EEGWHQKrCrz5+hLA3LOs8f7ImoIcbRdDMWhAditpa8sITaIUgdb3OopCYPWkpP4FZC/Zgu0lohB+U+ZdmSYq8ZANpbnQ9ggVO4vQCS6ZnWqW4/D3VPDfNb6Hmp6xjF6bUk3Q9IOTiMyVDg3THkW53AcejiwEdRtemwWKJH+WUwde/hL2hR7M1vGwMzLVs2hHdSlLhxGO+Kcrc5ixCJXbMpYoJxRD3NlK/uTK4LyMYErO9GUHfYrgXSwZVxKG2UfUyfv375KagtWCgIsixcCWS5mraDDzAxkee00us8OQ2vSji273zqRWM+1FCGIq+hYq5FdiUH0tKmvwx4OKtAhX9VgGe9+J0Y+PfvUQ2e88YSjrtdMHrvjGFs6Zdg2l6cwMRbroEe7H26Y3pexnh/Hd0uyAJcJKgpl1CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199015)(6506007)(6916009)(54906003)(26005)(6512007)(6486002)(66476007)(8676002)(4326008)(478600001)(2616005)(66946007)(41300700001)(66556008)(186003)(8936002)(2906002)(83380400001)(7416002)(5660300002)(4744005)(86362001)(36756003)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NIOmnheVK+gQQS9IoG3jCUGK9lZzEr+NSsTudEchlaWNwfYrq+ku9LfJHcmx?=
 =?us-ascii?Q?ql3nrkTm/6iCCMTS/aavrnAGko5CfEOAh9sUySK1RmM+/CsH9Y3J40T7ZX1n?=
 =?us-ascii?Q?eS46ymDp/Qq8bX6G5Sx0fJyvnarPF76FR5kCEbYUmA3cM3Lq3oxA5R0/zwrd?=
 =?us-ascii?Q?wWvm0wEdS771QXA5uBUXb4C43mXe8db8BuYbjAlQgJeMXvcMwwe+Wn4RvWKt?=
 =?us-ascii?Q?pv4vjoN2gbfmaodY3O/EsFe7LJ0ohiqzaMLhNCHzOXzSDYs1mX3HKbm6jSUI?=
 =?us-ascii?Q?rKZmGlC6znWMr0uFqzH+3qcp3LQRPQZyGbkKjhuS0h1so7jbsB5AOLNhDnaq?=
 =?us-ascii?Q?THyLRA6v3vyn2Ifj9keeP7VpeOmlZ7lsVQGNkOkhadpgQOJYneivId45mZHz?=
 =?us-ascii?Q?ivjFaFJk8FENmDJeS3i6YefrZX16qozDM9gfh0FxAuqwtX9zE8yQ7MezkfwY?=
 =?us-ascii?Q?YBwER1or8KnouWVyo7itOLYNjpoIy6hy5f2yLwqaU3rukKjy1OP8yyYWflNo?=
 =?us-ascii?Q?GkJ0l4oMZ/FWDyg+oacFS1seo1pBnspo1/IToVzqgivqq+MGyHyrZbwrc6Uq?=
 =?us-ascii?Q?aNISsXmTpE3GQ9INeFFmdk9OjSvd0ZtdwSuYfxPSsg71aG1a2ZtYVvh3UnH6?=
 =?us-ascii?Q?V9dSZHtCB58uhYlmPlmwFBjPlru506FsZEBXIYz1bI/qeY1P2cRz/PhsNuZu?=
 =?us-ascii?Q?JiCMaxAuuGqgNeS//qWCgWVzrOiX758pRd90vmYf+DeCJRFob+Bq0l9WO7xj?=
 =?us-ascii?Q?KQBgtEO1zlRjMH1vzNurY1k6UHfjdshYJgwxB2lS3PTOWpvUNojXXw4uVioy?=
 =?us-ascii?Q?Eho7DaSFxlauEUo+oI0SBRhBnXjVMO0dggFZDFyEGV33J98WgpNWNd/eEE7X?=
 =?us-ascii?Q?EWNWjZuNGOn7udrYEydU43uTD7ZN1sE7f8csqtZ6wW5R9uxfxzoWphcssfT/?=
 =?us-ascii?Q?XGZg+OyhIa3knwcJpP1kPlIkx94eZoSn7j0BWgqQaWxaPLfDgP7DNZKCLpvK?=
 =?us-ascii?Q?0iK05PsshCK6SV3SaJPg4+61Zf24LfwJoAnbXyRaLKRAzwSVIFulLAbVVjIg?=
 =?us-ascii?Q?l57k7VuXHNTcBQ+QIkKDsWpsVfwjDLan5DgUM/eVh9EAcVDiYZYKn3B7Jcy7?=
 =?us-ascii?Q?x2H6xMAzdJk0avo1iNS2XbbxATBnnGYkjxrxAQuWTTWOs1pPuca9rALdgpiL?=
 =?us-ascii?Q?kk7zTaxBLWcQUde8wwG8gYIKQ5vlcqIkT4GobDfWUx/J/8ZUm07I7RyslxyS?=
 =?us-ascii?Q?Axik6uMx2D7Nam4k0NSf7UfSjA6/uwLkVJRD8PwyZomPL/LUQ6Cf2Of7BPPs?=
 =?us-ascii?Q?dP7URPiYv6vys9nzuP59xnAkI+89YNy7ck9loXeWDYO/ye5zX2kCURNCDc/S?=
 =?us-ascii?Q?fUr3Pqp2r4GJ6GNGvoPh+q9GJ/fcgF+N6i4215mq2XXBCBwwvOrEkjMpvhYW?=
 =?us-ascii?Q?M80tzKgeVOlabzT6FaFvBY2vPkmi6rJUE/doT/cYcaUH+85Ms5nnEVuIKKCw?=
 =?us-ascii?Q?FlhRQ9/bdGqnlM8s8eXO67q9LbNLi6YYEL2k3cveEg2XbdSc4/6n2DGRPXtt?=
 =?us-ascii?Q?BTPsnZLd3HQQgPEtXINWAdNf1Bi2GSksTTjZiYjk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39534a6-278b-46c0-b936-08dac7fa12ed
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 17:43:30.2010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sa9b6oRrnNhSKASXozeS5YHo+kBrgkgeBEcGeVMWuQESTsR5/0NHZ23gB6kwtDv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:20PM +0100, Thomas Gleixner wrote:
> There are no associated MSI descriptors in the requested range when the MSI
> descriptor allocation fails. Use MSI_DESC_ALL as the filter which prepares
> the next step to get rid of the filter for freeing.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/irq/msi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
