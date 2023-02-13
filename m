Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9AD695493
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjBMXTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBMXTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:19:05 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E8220550
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:18:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2xsIaPExDhWlrACwkGZON1DPkkUzcdZaGZDQdwJZulCFrmFRnxtda+fqpJ86ajP3xXL8ZBOqHGnU9NoFlQ1Ga/kOmEB5jKGhRKQrL3CFZetHtDTLuga1p4gJ+q61ww+pVsQFihLn0J9CjXDB3RSvmnZvjkDn+l8rp2lHoyrFb0hf99xPidN4ZVZI4bEtemLIWMSilVa8ZBlbf3fL7b1cBa22jr06eDS4+4yEJG0VUJKiYTrPgM9EqcwMJKjufdr3JGr2JsnRnTVGwaCSN8qwld870xk6kchsAbCNGd8PAnbaKusFiyhdAuRatpTNGF22Kweqp1lT9AQBopqoRZjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mI3nmk8c9P2COx+pbkFyZTAKf864W/5BJ6YOAqmUOvE=;
 b=FWipEQ/0BLWa3D8jMWt3CHrhgbPJCnKcxxx1voTvH5a7DEJLBQWbQCH1JLEw+aVQWYgQCaWQhsEMKpxV6t3zU0R7G5sUrUCUAxtIpI7oUTlqEolkJ82q2/DyBxoyauwS7K4i1usMIPTBZHM88WSMOyxQkCSmlk5Ykl6rvtjHNnvqJL5jKOAjHO2/JE+0VbhqSDt73PZilzNdb5z3erUUraFRPLjSBsZt/gQl+vxORK7FlbJJDe4i7IxKfxkSfY9SwDt2/dm5eLDwyycM/uv1+fD0CliIwYX+mZkkkEx6q4or03UlEBKKBKmfei4MGeDYojC4knZVWbQ19i/tDa1VHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mI3nmk8c9P2COx+pbkFyZTAKf864W/5BJ6YOAqmUOvE=;
 b=aseBsUwQ4p8YKfWujAQ4lB5dtJhiAuCzHH+BcWpFeq6MnY2oYWLy+f6C3WM3/xIB1gAaYZBrqTXUNDkDxCsOPtmibu1ufWNbCCOJDecYpsLUAuT93neVoeM78gzAiwLssXQKFHWx8LdMKui05FRcsTACDFeOyf9wK+OkSteXlUsirTNJG36YKHWX9NZDh+/WzbUlBdQgkG4bmekqSnvFK0cF+aN/EG6W5CImR8AQD7S6tgyK04EL7AeRwfB7mjZ9PtAW4Mp56wTIjjQug1XGN/+aPBrLWR1QAilzoJ/tJvRgnXmWEHHcDN/Q452YhfFSrNacRnJ8YJDGxdraODGZFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 23:18:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 23:18:52 +0000
Date:   Mon, 13 Feb 2023 19:18:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Message-ID: <Y+rFW80DUHvf3hQP@nvidia.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
 <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
 <Y+pjTR80bnl9rMK1@myrica>
 <20230213103455.02f3ac37@jacob-builder>
 <Y+qR5zC8ZOkVphgv@nvidia.com>
 <20230213134402.194ed7fd@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213134402.194ed7fd@jacob-builder>
X-ClientProxiedBy: BLAPR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:208:32a::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f060ef-75d7-4cb4-d1a6-08db0e18ab99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8WXIZXCCMCWyfMEJk37bJN235EHOdqUZuplxtXfSG8hz45c9m8vJREZVNNWZ6Tk8DoD85YkD+AqB7tGWkPGLpZLIenyB5Af8kXFWR4/TF7A9SViMGGlrrpAlklnmlwB6WuCV6P9tgrNyL8hXnKH6Dws8jc0BpILWTQUh62+aLentbq5AQcU1M1MtShz5VdDZGBRtu16yULisdV4VA9i5m8zmimsqG8AVsdXWmJrffSQbRi2dYNSE4NCkUxlwcI5WcFXCkTenOojCHEMUPBMjAHvUNhxpaAbE21eDCTwzL7EGCgvKgiQsvGAiyCbWsi+UI5ogtwXK7QfxzWgkBFGaiAnXUX2uC5o2FVRdt+SktQQJ15qNlR5IOmj5sUPKPSJOmeEtj1uSKP4QZiSONGdHQ7tSqoQFg94a5uW+y4kzwqr+pjSYhukG5lpdzyzPzjDEEM1EzJNjA0cVu/3UNxNM1obncpUOk4fiEiMSpSSD0iSd69gM7g9UqsX66BB7kCtDW6vaekfE8WGB26xq1KtfOFsYDvQco3wunV6346TOGF2GP0EOUcYR6Z5BtpnvDHxyBKIQpbveWfLWznVDawweT94klyxyrRdLA2Zgubbx02Q9BRz2Pk+ck6Ae0e3rQ7BSS75h3Ys2XVqAJZ5cl3h49IRk8BhRPWGJ0aHcVYaDx/u2Z+v+E598MlmJ+aMAZB6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199018)(6486002)(186003)(54906003)(478600001)(26005)(6512007)(6506007)(7416002)(41300700001)(2906002)(8936002)(5660300002)(316002)(4744005)(8676002)(38100700002)(4326008)(66556008)(66476007)(66946007)(2616005)(6916009)(83380400001)(36756003)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L5ZeU9DKdFfL/fHKq6ybLqDvL1XQTw5r0QloY0VneYKXwmen4Eqnp2UgUT06?=
 =?us-ascii?Q?CKgbioXA9lHczJ0KzuVzo4tA56qLPTUSRqp4E0C5k1VxvI7vRw+YuNz3fB6t?=
 =?us-ascii?Q?iwEt1qpAxRxKJuNzVHUKElc5nTKDjT4GqbATqjbONOfhkeW+9qMdu/aSl4xX?=
 =?us-ascii?Q?loqG5YReAsnV0M3t7NipSPiH/iq39XZOHfO5eured/jw4i8LVZRQ+O/HGXVE?=
 =?us-ascii?Q?IiBoTMWb51G8D77quvg/UTGZjPiUrhyY7fmlD1JeYc4nRuGUSV1cEqHZFEf+?=
 =?us-ascii?Q?2D+JUXhJi2ZX+XFN9petYMKzt+zt2qSIHEnHwJsxE4M1kVGuU+iir3fZE7N4?=
 =?us-ascii?Q?rli5k3mE3mgCdn74fC+thRrcZCaOmF+vshw4v2ojqSM4B8HGmLCeJmRE7ZiP?=
 =?us-ascii?Q?0M9jS7dxQv3Nar67KQspRebEk4vGRMsDID+JJdtoQzNc7ffTy8RaL9ISVCK1?=
 =?us-ascii?Q?PNmFjcAnymESpIK3gsOwuoh8IVs+lTkt4kRCCTT2LaicyqxMTm4MfrrSYcYF?=
 =?us-ascii?Q?R854xgApfZAiX0wXalRFq+3AH/7vEebQ2A5xoB0c+uFRyy4o7Gb2K1NJzPcd?=
 =?us-ascii?Q?Y0cZcLJOBQPH016fRNdaFCZUh8c4nKl0l+BogK5QHwEh50HheknKNQJtVr7t?=
 =?us-ascii?Q?8ylN0Atl03nFz06Oc95nECSD2eVsmbMPlR4cLnDl5h2yu9fJU8DA6nJhEEv3?=
 =?us-ascii?Q?BMW6KUs86bDc7WDw1ioqKHSiGzFyoH37Gz5AGLa/WLZeXqkJ5axeEh+Af0dA?=
 =?us-ascii?Q?zL1YFgT3wjy5gJIWGHODtHw6DEmP1Vf2uH/jK6NWuMX/OHk5gmgXlGd6dpvf?=
 =?us-ascii?Q?iPlyYJtSLrLvwW/3sj/TlCdqVTU1q6uFsazKPQepdvkXACsjOu710QpD4NWx?=
 =?us-ascii?Q?C8UrEbQna+C9On18kdfMfqGIGFQbaO5N6sPbSIjVuroASW3XistEIiKevY3e?=
 =?us-ascii?Q?J0MMlyECiZukaFL83SltasOJL+aNVcJZp9dT++OsXxexozQn9oh2sVCwq+Qk?=
 =?us-ascii?Q?4R6hIjT+xRt8yzdZDY/DrarteioidKDyonfIb2729W4iMHg7Ld/4YT9fZRux?=
 =?us-ascii?Q?YMOG8JYvUGt6izn+DTaf5Iz2IQ9eYaMr5LLtm8qq+dfK/xH+kZawuoczA3pH?=
 =?us-ascii?Q?EnNIbCcXPJ2U3LTGyCRy8XwP7GlmnQqnRAattW4NhlYNlBRR6HedJDZIemyS?=
 =?us-ascii?Q?rSwALY82lALQRHXOdKWdDVt0nR2l63idgyWM+801LC1BIxVFiRJKEYm+DJKV?=
 =?us-ascii?Q?++EvkgOgrRCfDWEqCEkZan3pthYsCeQVhh+NXTd7EX7WtcZ2UubD0XOkoew1?=
 =?us-ascii?Q?6IecOC5Iblr/0xpCoAyCa3rBNtFo2C4Ztm7cTkhp7TuepEuvK7QfFnJSoT+K?=
 =?us-ascii?Q?VVZlrvEqEoajgBYbNjOPG2QWf9yseM4Ajv4OoV4HP0dZJXf2J2BaKwOrfcDv?=
 =?us-ascii?Q?8H9mRCaEG/bRwx0OJMHxZGpBzHajHDxIkCgU/s6/zixJyvshWGUmHVMz/tUA?=
 =?us-ascii?Q?bfP+o2RCLbyOZRBp7sFPRNY04OEeXkzR55hLSCP/l7N6qP2iD/4JcRSJU1xE?=
 =?us-ascii?Q?/pxFBdA1axOjuijGNgZ3rQrYnLlj8kY0z8WRc11H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f060ef-75d7-4cb4-d1a6-08db0e18ab99
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 23:18:52.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vq1WlKCGLXDZf4ZZymjndYia8q/AfmxVz3oNQRa4v9UitUeVHKceURKn98Y3D0j
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

On Mon, Feb 13, 2023 at 01:44:02PM -0800, Jacob Pan wrote:
> > Your DMA API PASID thing will simply need one new API to alloc/free a
> > PASID from the iommu_global_pasid_ida
> It should satisfy what we need right now.
> Just wondering if we were to do resource management of global PASIDs, say
> with the new misc cgroup controller, do we plan to expand in iommu sva code?
> If yes, do we keep DMA API PASID in a separate range/set?

I would say all shared PASIDs held by userspace should be captured by
by a resource limit, it doesn't matter if they are global PASIDs or
device local shared PASIDs.

So if a cgroup comes it is just a matter of putting charges in the
right place which is auditable by looking at calls to attach pasid
functions.

Jason
