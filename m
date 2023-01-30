Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34072681752
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbjA3RKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbjA3RKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:10:44 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7420A4109C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:10:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llx5zCinCbym/pRY1lf6mN2qa889sforqGrBegmDjv7A110cd52dWfo20yHLMoUtsx9PBp+x0gUtA8sxyE5BfxVaijL8bC5BQMvL5OoDjP86bV5sOpaNMnvUhaStawqnbr5kSVJwmNHKFEP8AhreF8jvOaqrKbat4wddvKQuvPNagXol+6+sVH57rTnX0adCIom2uTaBd1Ku2F3ZLpvqJGQ0ciL6wrOZ/a+YmpU+0PWO/SRjz/JlC0fG92LrHITv+9RVeClWkjiZWH1yWB8XQnsrtyGPgOtr/TXKrbkNU2vbvAfEgxy0vNZ0YdiPYrL1VIhMtiMshjUjucHpak7nYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJxQ6RezW+/hDapPh3li1PFee0Sy9StCv5WpMMze3aI=;
 b=AB8bJxSrlBNNjOQYaXX4yjbCUGY+l0pWcT7RgaxsWDmQeHRAzDods/e0xvK2ZKEoEb0oyZGoMlzWODPR5+7JvvvK/frmNbBMahF9kaKfnqIUthbIbzUsJ70bO1uW10ApSIXcV4oEGEfmCETfV6AiGap0CiG/isV/119OBeurNHjB28eRPQjY0jwjn7kQt5YeIoK5gGvZHIy271lInkGSZSRPKCxdhtL/ZiSDFlDH3KmJSlfn14brWdcI9jr5nuKscA0ujCPEkp9eP+2yfGjc82J3Zh7MdpJIEnp+2vCD+Uv5IBiDUWsAzeu6zYsKcjy4eT3V/5ui9on09buf4/iCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJxQ6RezW+/hDapPh3li1PFee0Sy9StCv5WpMMze3aI=;
 b=HRwxkVjmZjfW8LdY2gtSlRgvr8lqKxbZ09oEX3r2B7IIXH12FXFtCcynu0ZfPmvEFB48JptPiePlQy00f7UyonFPUaTLF7qSe7arJM9gN6U6ro5UYUYWc0DYcKQ0+5OZ8CvAzpKB79u+lZaHxwW5vlT8KTBuBFzoNzB78VHuOXJsj8Jnv5ecfseFxVb6f731GCzDKbMiNb/7FmJk0xczK0qLjR61JlQLGzC6MtXQ90bF+FjsaOVqXR5TlDF/Nm7Fo3flkOJwo0mzHc/uqVlIFiLLgIBM3QdYL/Q3VCrZd4Rw3z/tUieTlSd1wlsivrlWcpZodbhhJUkC4sYw0VCGQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 17:10:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 17:10:42 +0000
Date:   Mon, 30 Jan 2023 13:10:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 8/8] iommu: Clean up open-coded ownership checks
Message-ID: <Y9f6EbUEJufJ6Ryj@nvidia.com>
References: <cover.1674753627.git.robin.murphy@arm.com>
 <af9d39475ac0811650e617983d7e7859c7b0e856.1674753627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af9d39475ac0811650e617983d7e7859c7b0e856.1674753627.git.robin.murphy@arm.com>
X-ClientProxiedBy: BL1P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e69fbb-7b4b-4c44-004a-08db02e4ead2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+CZ2RGD7w+Bjoe8NOYxpxeF17D6vzgX3haHi76aDxj5n2cmqzzxE5HR54xcMrYyUE31qjzhkxl1Vtz6qEulKCrw1gmbnBl9nntxsiKFtrly/X3lXl6BJdebz5WN8BG+zmjtc+4a88k/ikBEyjZGGNL4APxE+oDDtHpe73ZRokHUfpF+xsU8t8GiKqJGt1Ng8LEnUdnVdoxn0RViq87JOZrgeGKCmzyGFkiSBo3YvF01qfyOQ9/mfwQjT9nM1SC3n34qk4bKzThFCjIEBV9O7wUoSxkUIlF+04y1NndF+nZyCq3nDnaavRxPrpbZSuHEB4WW+05GChKfJWgoCydhjHbec7oYUY9iaElaqWXbPZn7SnQQUIiKOHQV3KjDPWmQswPmart5Dzr+dhA03bgEX9WbkiTOLYrqmOz04b+wIlba/ksdG9tYNhQMxS7ddD7VLVKeQ2Bp4e0WglAbg4VJIsFBarcyoa8ARJlhPVmopwLiHn2YbYS5+GbdH/hRzZOYc6E4OebSTn3HwdVF/h8ThiOXYJDjMqahGxn52Ttdh7yfhd5cGCXaoZE21n3RBxnS5amm0t4EW2OjQM1aDECIAm5g5Pojv1eyHBupwkiFSPMUCkp9dPZFCTevoyUUg+WDZSKpmZwVeIu1dgi4Ykq8sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199018)(4744005)(6486002)(2616005)(86362001)(38100700002)(2906002)(36756003)(6506007)(26005)(186003)(6512007)(478600001)(8676002)(66556008)(66476007)(8936002)(6916009)(4326008)(41300700001)(66946007)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a2A5TvFYEjYqSg5nGieg4ZxOIPUyGLAbdpMjZ8WrmjSdlJD16eVYJhRrxGMb?=
 =?us-ascii?Q?CJSvzTOfrJfhQBfCNG0be1JSWgKBeo8ohhg14KMN7OPm34oYimat57r8tPR7?=
 =?us-ascii?Q?Z7metWZLt+kjkIkKdi528iqmjoVGwJTDWEHmTNS1sZcqRO1paF+epUp7oG2c?=
 =?us-ascii?Q?p7mAxCOuuTJMIXYNrcvK2lUcMEpt7khQ6yTNeHbtl3nJ7TNF/yiKiNqUbB8M?=
 =?us-ascii?Q?d6DvHQXHtJ4WTs2JZlpwoXi3XOHWvDw43vLbQWafgOry+j2fFJIFSVKZX53S?=
 =?us-ascii?Q?xUgtY8CNjEFCzWuq9ZF7iSgI4dQIC44pC7xYk4ggDKIWiemeqOfHd2/garRs?=
 =?us-ascii?Q?PCilU36KQ6/Xj+ZpBrvhf0KNoQg0uHu95o2NDvaaLCO0DAZmSX4JEOCRoL5t?=
 =?us-ascii?Q?/Z0bG0+HRrqgcKKQKkg08wQxJKitqJGTFrS8xe8SRSpxsiTQZanz/ln+qh3j?=
 =?us-ascii?Q?PrMlxMxk++UJWy1a68v/3gzZmTq/wM88PlX+8CPW4NFQJacJQ1qNqEejVtHo?=
 =?us-ascii?Q?zRb4PnjV/Xi+V8JYBUi8QiL8lv3ux28COy/4DgIkgIlz4vxTfaoGWKM4IgQG?=
 =?us-ascii?Q?l1OV8l4uCSevM+rfHl+PFE6UtoIG3nzMEJDHbq5NyNHbdSkHTPUmr5OtWWWm?=
 =?us-ascii?Q?pw6NhWGfVISAZ/KIMPT45MNMH6gXhEoioG6v9/RuQUs21AXH9Unf/z0wAmPy?=
 =?us-ascii?Q?P36hTfL8UczKjm3RzobNGc+75apntkOC8jicinTL6aOYOyCA6F/lfCYgvrK9?=
 =?us-ascii?Q?dunYXk4xFZrU49NETvtRG4RNuyf7TWIR5z6sv2F58+X5QPmg+6+4sxGYkLnj?=
 =?us-ascii?Q?DdxLzWBXBfadE0uJOISfQ0+97cS3gsyk5YmWzJ6b0JOkSJvJTgIgeOKZlEbf?=
 =?us-ascii?Q?VVxGRcBUoh88kkSk7Jbzm8tgIXj35Hj8cJpoE9QBydffvpC94vTYyTuo6bvJ?=
 =?us-ascii?Q?9PUm+TE2dXZu07OCOSYNxqDTriyTwD/zrGjBFkNebTSQKQTUy/C22F7xnmvR?=
 =?us-ascii?Q?MQxQufMgH5HuewYyONW86bo9FdNRoqIsf2tRpIggQufgVqjojvgHsMpHE0G7?=
 =?us-ascii?Q?z/8L+oHl1LMq23YEF3L9IUTCU9dCtpN2qh8PItUyzen2l+ug/0YBunag65Tl?=
 =?us-ascii?Q?0p6k9KU4n5ZOG1ThIE4kjrwluyqR5NY4JJkF3cVRhgDb6g6xyLtnAufN79HV?=
 =?us-ascii?Q?pzmF5ZwBG7lUM3dqD8HfxkbGfgM8m2mKDSTn24QF75HFBGAM4l7xNqx8tuYo?=
 =?us-ascii?Q?XH2kNOyUUype1oNoQLbpHETAUSaaF7jkThNLQ70bS/gCQJhW569EeIbpWNrF?=
 =?us-ascii?Q?qbBcOJ2frXyevnpSXg7xBPMOaIMAl2GYpPdCIJ+MOdrUbUkOqh08iMPU0UyH?=
 =?us-ascii?Q?ni8cppczwVMUfofEQxrfYWONAlEFAkVl1U8MtwZfO2yAUZ7WWyoAe2knjF4U?=
 =?us-ascii?Q?WBWZ6USQ5r39g2enZ/sJBuZKiq41vZsBuckCL4Veh3+tFOVCe8kw+h1d+O+z?=
 =?us-ascii?Q?aCF9D1kVza/87n2szLpTTusnJ0/OJ42GtBt2SShBYC7eigWYjcf81m0qg1Np?=
 =?us-ascii?Q?JjEO5tTqe1yZgkIs6g4fVIkXyrD+mb3GRxfvs9BW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e69fbb-7b4b-4c44-004a-08db02e4ead2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 17:10:41.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZDrc39sz7kJp904YvOD+1E8Da6vWSyH8sD4aDUCTjIN+8zKxU9ma1XE/kAJphxZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 06:26:23PM +0000, Robin Murphy wrote:
> Some drivers already implement their own defence against the possibility
> of being given someone else's device. Since this is now taken care of by
> the core code (and via a slightly different path from the original
> fwspec-based idea), let's clean them up.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: No change, but I'll note here that it's really about the fwspec->ops
>     checks; the !fwspec clauses are just going along for the ride where
>     that's clearly impossible as well. I plan to sweep for other
>     redundant checks in future when looking at the relevant flows.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
