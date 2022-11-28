Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DCC63A9BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiK1NjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiK1NjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:39:07 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEF21EC5D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:39:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZVzoZ6I7SVq9D3dWOQgi/Q5gsGv5R/lBvlM/+hX9OENOnOGhX9BVkoBgtrcc9fzmKqVxYOLWhiZnGPO+mC7u0KJyzJcw7RDOx4cugFBcqMFO//LcRuRpXeGBC2vrZCnxKfvzb2GEQQtp5jInKpl8+YfHFL3wsAYyCpgVlCZLvgdh7No3oDY3sn737VrE2p0XgI8eoeU8tdkMqD/ZisE9ZwP/Z9qkQXlodlCsEFcdxjmbI7txIaReL71IKERCZc7T136+SGWS5ZxrXCxpCWhBxEtv4CUEOhD0Hccc72ym/OHLazBKg0w6gRf4zo/Tc/PjwjL3qB+JrWlUKT0rzDFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1e8bGlBUOGsgljOreSvCXKOG2yQva2INP5g+q3OSuc=;
 b=L287x2wIOOGHRhmgoKal9oMqxIv7BCQjFUb/PN5jtzGRivVJs+1ltbXVr3qTqmU4JYPNdtUS0g8w3omf21iuosgksntZ8nTlj9sETq3UTapt0wQ7e/wQKgRz9rdOQ4gX5vGPjRpVErx0EI6YwmZ6SRMarD0YoOKdbj4jtLLVo4VkmwfXPyfWdI/4HrGUx5hsP3uC95B2McGj7QP+4HKH3xpWgC1kcTEs8Oq0OfXFe4wIgxJm4jB1X3/Rtpr1i5jme6IUAtX8GS49MPyAy0+FHdHh5dTL5zFRaJ82SSiE389pWokSZO+6GjZhsixsaWUlSim6zyX/iQzjM1brvKnjew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1e8bGlBUOGsgljOreSvCXKOG2yQva2INP5g+q3OSuc=;
 b=HPr4t/EK6+ETIUZV85dOWW4pHCdEseJGqKNZ0sq3yIitL0FiRgunOhOAOcT6Yo4TdQxqAAYsw4fARDhWuL1V1vozsubavkWdrg9sej5yYIyNikmExsnClgrhtbhKc0u5m0fOLYvim+utZKPRiCxafWI0MN/ux0i75cMEe/aC5HtsOrvIj0S1enFOYEirtzbovHZe/zSXY6YQfEA8kAOeulabcI5vxm+UOsFljIpv/8mF6p+gwYN7iefzCPAc9JROXW857/UGFFUJNJ3VLyIHtKXrJ5KAnwz48ldpSXKTyVEkEcw4K/YMMtS2R4mg0BXLKPUWvAskK6tGXsFr+qIh3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 28 Nov
 2022 13:39:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 13:39:02 +0000
Date:   Mon, 28 Nov 2022 09:39:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        john.garry@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v3 1/5] vfio/migration: Add debugfs to live migration
 driver
Message-ID: <Y4S59c2dWqdrdUlg@nvidia.com>
References: <20221128031200.11017-1-liulongfang@huawei.com>
 <20221128031200.11017-2-liulongfang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128031200.11017-2-liulongfang@huawei.com>
X-ClientProxiedBy: MN2PR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:208:23d::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f51c273-7986-4a48-0c1e-08dad145e937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiAxaXsPjYflQVBmVZoJTzhQqEq1D4HpbT3l3eKKAI5lvV68PUGHup6aKZ+RqOYWxovxKWmc54EmH3FZXcE85XrAhRZv2qi1c0TEjX9+M5PDO55OrBmlCLRkUJXMB29VyKQIzc1wUHzMc7TlLmYZKzdG39dulVh9sKyjDJ/WL1/EEpESq4QrcqOZZmhXOBmGPLsqKb0YOPFbigffujHQpreLpDPm7BFk4i4WGH2bWBnOR9MzMWGU3FJrRsT7NxpXD2v7VhO1RdMSpUHVnmax3Fehn0Wg1jqgPAHs4oJ40zXP78LcFs/Df/KhAOr1kjLNo4j/bMALxCvRDWsTYjSHN3r01wektXCt+oR9iBBH4fN24x72g0ypupAhLp2/IqWqFCZ8DMBVUZrvhnuB0CONgQsjK3TAWTqJYVcvPneIH2x9HF74oBIRyXmmjfV4yyNUjMHcUp1Phl6N86lrDezVD73/YM6GMZR3Sb7g/MBlLmOhMcNEAHmDOITelnRbf6nJSwSnrHVd7847bcj+fkxU894hxgtQI3m+ebRF6iwlHsy+WnnXSch9+s/Km57dM2smhQ35SyvSar8IKsBMXm/ECRIgpr37N4P+OpolBRCwFaHOfZdSTzGnLY+RYsvX/fWvBamPokfjfJ58dt7//Qb49A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199015)(2906002)(6916009)(26005)(4744005)(36756003)(41300700001)(86362001)(316002)(6506007)(5660300002)(2616005)(186003)(6512007)(38100700002)(66556008)(66476007)(8936002)(6486002)(478600001)(8676002)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C3/uTHlcrABLT61c37VJqJLLJub8qSSYVF+LRMLO7pECtiPa0U2Jkf7do+6A?=
 =?us-ascii?Q?tmyZWtZhygSWpIreKb+gblpFElTjJSoxmz5dJeNGZKgx25hY4rhBYnmfsQjt?=
 =?us-ascii?Q?q7P+/78fy50ta5G2TiekEob9eJ9kGwjjps7XQY8kkudPoEFSpxpZMfts5/5e?=
 =?us-ascii?Q?plaZhMTFlOX9otrCADMF0zp/hPF0FgB8i9dlm/Ed1wS1wbWs4VtlgBg08EPc?=
 =?us-ascii?Q?6mOu5Hwjg24fyO3K2Wo5nt0oXoo3kaw+vhqccyC+VJqXfm2d+rBoARuocuFX?=
 =?us-ascii?Q?1clMhKbN77Y5mLF3r0II89bjI+dwsr2JnqxbZ97qsP9nmt7qmvMnegipR6yF?=
 =?us-ascii?Q?+ej0jrylN7zDJKbm25jCTBln+g5IhXE5Q52ue5BzyuVQQPymfOzL8cmb0aQo?=
 =?us-ascii?Q?GKoGU5XEXUb41gduAbrFjLug9GF/DVz+4oJv34v88MvMAXxoCKQReKmEUSQb?=
 =?us-ascii?Q?lvKnsq2HMtUd7V/C4KiEBkQpC5hL9iMQVkmg3oQ3rpQLPNZOxFKdBa5ygN+K?=
 =?us-ascii?Q?geRz820907KoSX0w39eAZrO73JGP+p2ugICANXBssc0uhdcA0748BRNcjQ1Q?=
 =?us-ascii?Q?2WtX28M8Z6Ci7kcQOj9j8UhSmYMaGAlSgJU0bt6SzAnTBz73D7swxonfdJ4x?=
 =?us-ascii?Q?qHHE7f8pKznZ5zTeQJ4tcx4SDf+30ofnlIXUXXrZ3LEkewfYI0ZfzfVirk5h?=
 =?us-ascii?Q?zYDh1vWXFoNHXVYqbB+7cPVN9aiovxvm4Tkk36QzskVr8jjeZPQMfe4JmKs4?=
 =?us-ascii?Q?+Valqh5qvG3e8l5QWU0eUFHOTa9avESUK+sXHB9rDCLWvz9C+gw277Ta537y?=
 =?us-ascii?Q?k4CO07A2ektCRWE2ANApL60dfTNdiN9V1a3UsFFcNAfJusMakqY5+rsnYCKM?=
 =?us-ascii?Q?RJAJXHABmm4OJmt3lqNl9QGH2Iafh4ci0y4DefAY0EYfNGsaBISzJkz46+y9?=
 =?us-ascii?Q?KhZeADddNCumxpGo877dwXkBUtgisg3RFPpojntoLGOmCLuA4MPS1Zh3u5SD?=
 =?us-ascii?Q?17X3zvKJCi1wGVXi3Wt+Jw299gvEHl40Pkb93uZrjzbwYkD2Xh2PlZRSTJ45?=
 =?us-ascii?Q?CfqMcEGyITVZH60p8nZcBNP9MjXnGrRQRKyg/vP59gsP9EdAUZV38weq6kiA?=
 =?us-ascii?Q?y8fEJsRK1pGL5hPREatXJLCtezEoXKhl57leRUWzDpaoo4x4ETwBi9d+ibof?=
 =?us-ascii?Q?ohbJuyZ797dLLYPt+TQd8JDGw+3fSx/uxV3g/hM4ChI7OOtK/qy/2DBySXvf?=
 =?us-ascii?Q?4LWqOizmgVa3rM/iUIwx+UXrbTAh2C1E+8ihEh0li2K5nPvENS0cgwEqBt8V?=
 =?us-ascii?Q?foAhNT0GljPuSy+OZDZn+gWDr1sEHv7zl5fcvT3mxzI/fQcWoChACecCTPg0?=
 =?us-ascii?Q?UyiHNKW1hiYHoR0NHsQaFaVHxbRFzzkczvczoHHn4kpE1o3cD13Y+G8jYLR+?=
 =?us-ascii?Q?YeApq5qHQG4ZnNC8oT8FgDHeR18/1mqmdhbqls/xn0mE9tP8+Rn5PgVCaKbz?=
 =?us-ascii?Q?HPNSIVfrPxgc4TSxB3+sTmn067jXoEjL8jLtUyA0ZhQ8/ufFRspbX+TPLuDq?=
 =?us-ascii?Q?/hgT8UTnYUwocr8YQ6U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f51c273-7986-4a48-0c1e-08dad145e937
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 13:39:02.2943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rb82RLMIo0WqL5HKqC4+/QU2DsBF8AO/fM4UtVelvgSzCmfQgvCdxJ3FDV5H1Au
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:11:56AM +0800, Longfang Liu wrote:

> @@ -119,6 +132,9 @@ struct vfio_migration_ops {
>  				   enum vfio_device_mig_state *curr_state);
>  	int (*migration_get_data_size)(struct vfio_device *device,
>  				       unsigned long *stop_copy_length);
> +	int (*migration_get_data)(struct vfio_device *device, char *buffer);
> +	int (*migration_get_attr)(struct vfio_device *device, char *buffer);
> +	int (*migration_debug_operate)(struct vfio_device *device,
>  				   unsigned int cmd);

Please don't do wrappers like this, give the variant driver a chance
to create its own files natively under the debugfs directory

Jason
