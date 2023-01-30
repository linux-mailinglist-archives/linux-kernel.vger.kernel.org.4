Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2E26819F7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbjA3TIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238355AbjA3TI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:08:27 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B7019F05
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:07:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjYPOOH6lyTAQAdd2TdrKzyc32Mlwbp7HluokyR/8PuMKkzayHUHJJFyWL+EGVLvPmtMrAaAyQrow0uVETI0H5O3RUi7oUYkCT1KZju6dvt5YNAR+ZrTf9HfWtHDLgte+pSnKNnacyIViKQPs5JFz9BZvtFbl+q25eSiSJsakxb9MNBTliKM+0hUGsdq4QyvpkXzv0LvDawJz6CbbMfKwCY/4DbxgO99ASbQUVEJVk2uIiHW74ABApMOcc7pnxlNP1l6SdW8irHQr2V/rsk46NoAbnK6D2te6NmR0jBv1o1dqAVCwkeEkcDdQCIZiKenis8fst5cEAikuWgObGolKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwK/WRUlbexkzc4yhWpkBxr6TlcRtZEteRwJd1eD0vs=;
 b=XHSWyg/u1CB0bABvQi3eBk1W+auB7ZGyLX7gsO+6RBUgW6TGtOIf9e1GEJbhhze+JSa919SbsZk2ye2zgSinoQdaM+xEYUHy+7nP+lNzujwGEld0pPU4HAAsRuFqimkM+KPR+Kxf72EYPIKs6Nw9C9vV7qQO3X0ES3h2GOQipXyZiG+TbgJQpuq57iD1OGcimrEYjKYVQYJFXmHVKzsm6kcQMZOkjoYBWkAcxaW9KY79uNsvFAd9AnXuiO5QxIbzwuJ0pQ3J67SnRsl2IxByaOpOrOVfvUdr7WGMbynmY03g5mr56qJuwe73Lm5TVUQc7W+1wCK9FV0bu1uPXEwdVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwK/WRUlbexkzc4yhWpkBxr6TlcRtZEteRwJd1eD0vs=;
 b=bVeBR2O6v+BnMYU+VeZGGUsMb/LBdh5+4ISRRlxb8nzIwkNhfJrzcEcs/ydyIGTorCj85SXg7N43wfLr4Z5ZDgHTO3HRHy+CcuGKYcS1madF22LYub1bAEYAF+/YdCDPFrYChtPRT0Jy8534pGtCi+J9UljKBG6F1DTnLNIoWAvszJxi/u/AKvLHyt94C0ufvU8+s3GY1ebifAyYtkkgTH5Aw+LXObkeQmOy67cn5c6BXnarylEQlqsEyXUPZniNQ0cUMnpI0cKWB6hqt+poymditjFavAn9VoD0UJLhq4es86qTz15GhE2mP30UA36etSDpqD6WPUHHlrygovD1aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 19:07:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 19:07:51 +0000
Date:   Mon, 30 Jan 2023 15:07:50 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iommufd/device: Make hwpt_list list_add/del
 symmetric
Message-ID: <Y9gVhqCIl1xN3seC@nvidia.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <6f388b1f20622957518ec5a9ddc7f0037e7671c4.1674939002.git.nicolinc@nvidia.com>
 <Y9fbVHytj12rpmZD@nvidia.com>
 <Y9gUbftU6BRqFc9b@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9gUbftU6BRqFc9b@Asurada-Nvidia>
X-ClientProxiedBy: YT4PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: fec64f7e-82b3-43da-1c56-08db02f548db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jliihli1/igeX4WbS41PAnpJUk+6QR5IMcfICCRBBitL8xGvku0ciW7QxDBgplvv8uyrSMfXH+dYWYwNn+/t9rVrLKfBhz8eGbHIiLe/KdeO0adidSSxC5pTjNMgj9yQYjpW0mZrp+R1RaYMRNiSNzW1tBMtiBtjdB6HfdfxhwlNpGXlqZqLMovczLwnOHjIMCPTPgPz2v4j02NEK2HJQrjmXOSJ266gJ9X4Z3MPvC3fBUvrHyHiSJLIH3CuzJ1/xLG5sods1Tx71wEL1SlGS/tJGCXNJcuHwRMXZYKuGHFEn+AeC8Al1qluKOLqmy8EJ5Q6/06rp+UbZqy7u0mDrib0knoVg7y35zRLVzjGyGbh0PDVLiW0PeCn71I3IFKzLQsaeCtaVt2GE0HJ8qwd0mObQ7Jy7vrNmEfzDUeOa+7+6v60yBxeEqBDGF2yRfkmu1S0D7XHJTlTu8ys1oVPP2yLi9QLfEVUwKKyCOPcrIqnG8dr3wQHydC2E6ZV9oH/8VWwGZt/et8p+OMCsWM5ZR0+vUf6j9BQ49DF80ZOGX+FgC8CAnOCFHypOkc66kYobcmLh0LMRzX4Qa+lQfgZmJn65UZRfvgT5OVO34QhgkSzPuXmEmQ+uSn11K37OPwl5drDcXf0G5AniLDPyhcVQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199018)(2906002)(5660300002)(36756003)(38100700002)(6512007)(186003)(26005)(2616005)(83380400001)(66946007)(4326008)(86362001)(8676002)(6862004)(316002)(41300700001)(6636002)(66556008)(8936002)(6506007)(37006003)(66476007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wCcFB6kLa+QTlIv50Zq36x+U30h/5XmK/dlBsIV4ssL0uJnMPk7Il7R3E3jP?=
 =?us-ascii?Q?xTUFQJLDvMZtaUzTQoDUNybQx3ARlOvoxpUIRXseHnBVdemM8cleOWFlFfXG?=
 =?us-ascii?Q?VPovG9yQjXq7DDWk6EODTr+uoHk4GQItFedluU5Xagzs5TMO+VR86/AgKoZW?=
 =?us-ascii?Q?+74zQ+usOLbJ8lnHwY6BpGlVpF2YC9Za8meyXKNE49gvE2MoTdK8XJn3Nnyq?=
 =?us-ascii?Q?DFEgtCMCCJ7asZyeGmY/F+nPjHPBMVodKXAWBF6hHgCEj3DwuVLFp2eMkGTm?=
 =?us-ascii?Q?5lXet2DZUF3YerYtvbn6gffdwdMrLSD1vVCCatiejnZkfTGT63EoCYUJlDUt?=
 =?us-ascii?Q?fIYdDxGywD4x9jE5Enftw+HiJ1GxDYCZWZ/CHJmtj1v+uL58pGvKs7lPNcwk?=
 =?us-ascii?Q?hDYnTZDP0BkPXKJPG5Wab3EIBOJ9ljh8MdQvWw66uhDbSJVtzupXTWz8OY1/?=
 =?us-ascii?Q?zmwPO5q7/SoFcgpRK8NP/uz3BeJUOhgq8+dOUGccRZkW2zGyA7XjzgDhyo+q?=
 =?us-ascii?Q?jniyFCwTD5XVUoXAS6+RGTuKufdU4zuVmvfpfl0GMKJwM4KFRzSurh34q6Su?=
 =?us-ascii?Q?K+/iTS5aNQj0ZfBYZic2b0MGeXSgDeEmJjjXJisJMqquPDZcGQHRf6Q8qWo4?=
 =?us-ascii?Q?03jUZ22pMe/VWgst9e1P5hUKn/W4vP3VdWe/4lV1thmimAdvRiub1lyi3mIh?=
 =?us-ascii?Q?VAjfvqrUs2oQTIdN3dJyfxTLyL8XQhx04zNNizqcj6KnuaigrSWou7BbaO3i?=
 =?us-ascii?Q?eshBbyg6jigNM0GDqbwNJNaFR16kf+MpxSgii24vVy9jV8Ns+vICVTWv8ijb?=
 =?us-ascii?Q?iN5aXj0aZA3yivXIV13APWrbaxsrTInlVhKdNVgPYUaqeMtL2B/75jWDbgUx?=
 =?us-ascii?Q?QzvPMZDUvzidD3iALErE+SFb5z5u3Fk6fuovW1ieGWx+2l1BhJogee3rXWlJ?=
 =?us-ascii?Q?vEkTSaNGdgvZMzFo9WDaNarU2X9yB4Ulu8Hny6LNWm9rc1BGsgzRFB5ZEsxy?=
 =?us-ascii?Q?J6BdvJ+iJkMoG1b54DXZ6rzztd3jwHXO9OYEt7ijsJwsHWOD28hJMge1vnwG?=
 =?us-ascii?Q?oZtj8sBQvTXsjBi7xAASlRpojwYXIBkNUWs19kzF9v/Hk8FRvW00/S0zVOGq?=
 =?us-ascii?Q?yQN1yUO9wM17GVruVXx57OJj/dmXTtBGjXiJcbbEWB82SMaB0Bb70ZIbUv6R?=
 =?us-ascii?Q?nh5sFMc4ZohC4Trgf1434fs842xzVZLFBKOKlDkySdIwf/oXBz5iWdbZXaAn?=
 =?us-ascii?Q?RWCp8ue6k1WmoD9QVTIEhbG+3G0C2B67LJqbYtP4iVXwHBqn7431Wt7LdXhG?=
 =?us-ascii?Q?n85k3+Po3JUqhFR/iKGTAFDMTAp50rDi7b0CP01BzV/CpY5mDv4dnVPO2xkA?=
 =?us-ascii?Q?WuAaWx84bbUWlewIhe4OrpjEx7RDi3c7KjJXUS2IJQzRWuQKsOOKZw5sQ9sT?=
 =?us-ascii?Q?uHTd7zWPvfoobabj74G1XchO0EzYQSKz2eJL5QOIzaM4dA9oKkrj9DnMTejU?=
 =?us-ascii?Q?rwX2l4xxxVPFLM9tGa62ZuHB0fDUe/CNkdq+H3bvfdQfvvOlZZSRbHuwl62o?=
 =?us-ascii?Q?glIzqQCGShQHRdLjb6rZ/bl0YVVKKuOv7ygZZ5mn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec64f7e-82b3-43da-1c56-08db02f548db
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 19:07:51.6556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGt2ziMLntjvwODDVvo41bELdbiGyNxQPqC/rb5R7xNLAdUr1hdwki/CC6VI+W3G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:03:09AM -0800, Nicolin Chen wrote:
> On Mon, Jan 30, 2023 at 10:59:32AM -0400, Jason Gunthorpe wrote:
> > On Sat, Jan 28, 2023 at 01:18:10PM -0800, Nicolin Chen wrote:
> > > Since the list_del() of hwpt_item is done in iommufd_device_detach(), move
> > > its list_add_tail() to a similar place in iommufd_device_do_attach().
> > > 
> > > Also move and place the mutex outside the iommufd_device_auto_get_domain()
> > > and iommufd_device_do_attach() calls, to serialize attach/detach routines.
> > > This adds an additional locking protection so that the following patch can
> > > safely remove devices_lock.
> > 
> > That should be two patches then, this is just moving one line of code
> > from what I can tell?
> 
> The mutex is used to protect the list. So moving the list means
> we'd need to the mutex too. What this patch does is to enlarge
> the protection scope a bit to cover iommufd_device_do_attach()
> and iommufd_device_auto_get_domain().

That doesn't explain why iommufd_device_auto_get_domain was changed
around, it already had the lock

Jason
