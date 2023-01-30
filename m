Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30DA681762
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbjA3RPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbjA3RO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:14:59 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7040741B4C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:14:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVVfskRvv6c1S2B5AeNp1bVZyedqNQ0r3OO99WnvoMK3yoewSssfmqkbI1D5tO3nahmYP3HOXjy9JKaMeD2xAE0Q21N91ulMLTsdbbIHkPihT/ShI2+eKULFCTEEgca7seV6uJ9v0V15zxCVnMlKOfEZsCRSsoqNntlRkV1JCqKREJdWYYEOLPvWEysbtrW/9N7ZKOM55eiaq2rsRoE2I9IphHOZpU+emTwNjvtzmSryEVrjfwZLSxppRH0i24xWlmP4lFZ33cMrR/H3yYp1zHieKWit+OIJroy0MLuKpXerJ9OsEIjrZ03JZa0dYXwwktOvwWgo6E/UlZvm6rXMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3O0gFs1+WStRc2Hybv937bTWswzaUXWz0a6aDgDfnc=;
 b=fs1o4S8plMqlqTl4+wFptFIfbYNf2iTSoDO+cvzFKQwat4EzBMJpwuIYvSqCfADvKDkXxy36UyctCYevqc500kiNHpv8ZUkcph3cdYI7dHdoU99ZVZmzdJWdG4cZ4DWRmRJcI7uOc1jM1OH+5tpM2YrDkeoSR+mmt3MT9f5jLjgqeiZtuCGe/7swlnKawqD/6Q3iVAamCbNd/hy8s9kyLyWqfYuNRmqOSLYUEBhbhx0DKXJofDz1029OMly2YQxtRsEyd9FKrH8PQxVLzuCFxrduBQ0Jq842TmoYxbXjhPZZYdVmFD4QG7msAsfKN7hnHJc504wRgS0nGbA9hVmJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3O0gFs1+WStRc2Hybv937bTWswzaUXWz0a6aDgDfnc=;
 b=HqFg5b7cF9vqn0kskZOmmhbbcUf6KYs78cRbc1GrhAL8E3lYUySDCszB29GI5SAnKGR3P/6t5vxqegClZebat9xR1IUCxHgoR/hYd1gx4AZUZ5g8jjD7Vw3QxpW2Gy7FiNLG5SR55TaXe3ppM4VrQdoYChiz/jfKPW2Pob4pbCGpN8qRBCZUULdb/BU8722Q+B0wBBKtRSKVZVZLrfLoFJCzOr2i4t/cVd/ah9yAsJPLnljReRWANEyCozmkvFp0J0u53CZazYlW0BIHd8CjnWeWr52VA2zkZxOzATJ5gr73lKzuUffeTPf1LfKOEYViz8ix8YXC4OQTXUUDhUOs1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 17:14:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 17:14:55 +0000
Date:   Mon, 30 Jan 2023 13:14:54 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 6/8] iommu/arm-smmu: Don't register fwnode for legacy
 binding
Message-ID: <Y9f7DvikGv8Zs12O@nvidia.com>
References: <cover.1674753627.git.robin.murphy@arm.com>
 <93678b819d70079797734d9a8b0ebdc5beca43d2.1674753627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93678b819d70079797734d9a8b0ebdc5beca43d2.1674753627.git.robin.murphy@arm.com>
X-ClientProxiedBy: BLAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:208:335::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 427f7462-26a7-4d5f-c694-08db02e581af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTT3xP5AUZ7rPkHQA5TVeQZZG7S9TgRyP0ai6PZ+MDDwqScGdUdiAAoigGxnO5ZxDo6R8qr0a2MtrnI9Vy9lN4KDMPW0z+1udsIOdrah9mPhsm2T+sOwxTGsCOItHoladUYA9lDfRpvW+Dzf+FDY5q4gDE7vx+ohhVmGTSvpblUi+B2VWGpRyjf3M94KeFvXdSWbSflDN7HaYExHy7vEeLdmvcHKdSj3CE0ETk2SFsX//7KxK3gmXRTDuyRAyKT//FFciizv5M81++eP9KJeUsfRaG68F8dE0ZybmJDTWmjoigM1hxRT4B3HrlfUcfv5SeVdHDJPIP16B0CH7nmcynaT0HNV9wISGoZBUplg7dVh5vRBOHFDCrsHrKFv7UFG8au7+HzEIjuJpZVK/PsJ7NkYmFRcdf4FVvLGCZnqMauhlEAkkHmkOC2TwapyoRKe1lJrQ55X5Frm/h/qqbSy64/+U6ilQ5Rftu8KenYO0NyUvPrMl7JE1tGg2oC7Rj4S/lS0Yish5rKWv8swm38HVkYO/YNDgx9CqlOAOlP5P8PLby3euJ9kkg2R+skDt7esJonQQ31PLLqjbvwLUFgL6LFaz68XtJLBtLAOWQfkp6b4GnHSJFiT0AdbC0V0KHUr3oZZkPsO7TupXGa9lOuGcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199018)(66556008)(66476007)(8676002)(6916009)(4326008)(41300700001)(66946007)(8936002)(478600001)(86362001)(316002)(2906002)(38100700002)(6486002)(26005)(6506007)(5660300002)(4744005)(186003)(6512007)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D5gICgjjgLRYextyAg+ek0Qs4l3fuWoDWB+12gjskv2JFrQvoJFYTu8oqNP3?=
 =?us-ascii?Q?BeWVigc+LJNHLTnER4t4B7T7Jqhk0R/CAfubsUPibW8UBD/szVzI0JWLcCpc?=
 =?us-ascii?Q?b8tWXstRGXTODinnJSyU93Y7skjLwowNuPfZ4iqc+lZsBczR2bAuY7QSKpDB?=
 =?us-ascii?Q?dX4vbu3RUVvT3u6RTlSRr9hnPOZHlHuRkLdFf4p7JeCASIdL+0T9B5ISVXmL?=
 =?us-ascii?Q?STMseRmPKvBmLCgu3R4jPS1+dajojSEQ5NbrAiHwy0tjzJF1bwazq87Aesik?=
 =?us-ascii?Q?T8R2nXV7mzn/EQarYC0Xgd1N4eIYkEdY9ZwDwnIw//JSSw6MSM+fthPXqyBs?=
 =?us-ascii?Q?fMmCzV5pkbBRnyMOhCGTIwUXeaWb7xN+WDTln12QpY2D7ab8fm7BeOa4xfpZ?=
 =?us-ascii?Q?yPRXklmNfl+jMUAvV1ps40cTmp4+Xb1xVf7C3d3pA/2LGpf2su3l3VMeRdIF?=
 =?us-ascii?Q?rUy7wS1QuIj/5Bkp/zZdUZ354DKtpmxRtStH65+K9MUORNmjzatWYFdBN6wv?=
 =?us-ascii?Q?2pdpxYOTyAHkHsx6oFmtYMq9DDya4Yt5PMO8DuJQBeyaOecSziSlpgB/8IrT?=
 =?us-ascii?Q?+eDY4PYpmjUElEe4jS9sR2/9i9jGLylMbmHZz6i9ECr8j0dT5L2LpQc3im1x?=
 =?us-ascii?Q?KloSCOY7R5JdzHd9zVZIleY6AwF7IOmJuUOyv1a/L2ZCZ+yuR7fAeUsSi1wV?=
 =?us-ascii?Q?zMoj6c2VVZEMGF1PBQxo3eXSnWiOp/IqwnZdKERBvbgSynmLnVyDYxCQTQz2?=
 =?us-ascii?Q?yYhL4XBYFFPL+OvkZC23Be1iykjOEgsh5t05JBq3uZn8FgPMsbSYdCpE32sy?=
 =?us-ascii?Q?SCb6XjpmSxhXP2qD0DOLx3kGEnasutmgGemnpnpHFQITVA/QixBaYgVBN5FX?=
 =?us-ascii?Q?6sPruXYPdIqp0TAaRUM3Mj5Y2Rn6IL9AokfL8CZCDD+CVzRK0DZpQGxtaCvh?=
 =?us-ascii?Q?2GxZ9XJIDpFDpktnVTBzf+LQr8X4cCnkRhezOBWJ9vXdvIDNBpla/rC5VDnT?=
 =?us-ascii?Q?Us5ASUFnLzVwjCR0oNK1leltYrDxIC3XB2N5n06213fxv+D7Xl8hPTUfj+Go?=
 =?us-ascii?Q?3dxBvVeAx9HIaPLUjrraY6QCqkfIZIl27Won3rb1k/aqnUabRTBw/NX+JbCg?=
 =?us-ascii?Q?pE33/HUe07MzUHgR6vQ8gZcg+xe7DPYqPkdn//wdq4a3BlTh4n/Fndb4OOTT?=
 =?us-ascii?Q?zN+UMZmqv5hpFzaa4VHIdoLhQZ2glf0wW6yX4huoFDuAZ5HbEKBcz5wdyxNC?=
 =?us-ascii?Q?HSliSntxGHGZK/J4qQy9optb2XwHGUNcWnBuGYCreDq4j5qYnsOymsK5Ni6n?=
 =?us-ascii?Q?0o4biApdxcd8F2vZCeeCaW0rZpkyOaEfTSnF3OU+QJHziY2Sjg2q5sVtp0wh?=
 =?us-ascii?Q?yVWSOSAkb3fTrFEBiRFAnUyferb5Fdmb38oH/biN6m7HdlqEbC7EpVd3Vqkd?=
 =?us-ascii?Q?3JDeogP3bSNSSieRELRx3e/1Z8+dH1TpWqJc6LMDApHP+4+QgEr5cORU3mR4?=
 =?us-ascii?Q?kTpBIEyJLHbhEcUYR7MY9nmJJagmePH+ZL3sG4aC28Gx+Hp2rQ3kadxF5ghL?=
 =?us-ascii?Q?74OJizBHbhLT/YPywyb8ZInHd6gGOULDWXSaTdAD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427f7462-26a7-4d5f-c694-08db02e581af
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 17:14:55.1322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjkfJ5BHrjgaRdU5cGPJjg2dhCyjAUwr74gvGp+hWNvFQtUzpql8UzNpMXr/eTmF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 06:26:21PM +0000, Robin Murphy wrote:
> When using the legacy binding we bypass the of_xlate mechanism, so avoid
> registering the instance fwnodes which act as keys for that. This will
> help __iommu_probe_device() to retrieve the registered ops the same way
> as for x86 etc. when no fwspec has previously been set up by of_xlate.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: No change

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
