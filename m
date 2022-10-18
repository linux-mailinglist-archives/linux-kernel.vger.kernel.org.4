Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B011C602B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiJRMDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiJRMCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:02:32 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2060.outbound.protection.outlook.com [40.107.96.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D8148A3D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNSWfuG2/JsepbfpSOtMcQCoEV1przsyckKRxNjveSdOQZiXStP9cEOzZMDk9AqRA0WJnPXNzI7gp2BRaJJoGYGK1DrIwwdw2o+MdfFlxssqf4V3enTCrvYlgIXEL0uaDGC/wqfIRIustwVZolDOS3o/Z54JmX4u/mm7MujtXJ6W4tKg2MHCOlzAPBa7pQ+k67qCumw8LDqHoMYe763OATSOKEjt5DJy9TQGmGGR82YEF5u0SnKONII5GeG+S7X5Xlm/7KCR0l8B6zOS/uJ3u9KwydoK8h6d5AmtaAwwxxTfVHcqC7NyQc8UZfY6Aurs/YMJqpOwW1MgzCuPBrKd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXIMhEBlKShj/GKq2+RPRIt1EryiKCsrgXnbS5eWgI8=;
 b=PgMMDMsDdfzv1rdpsvdhCtxOcNUyzOi/Tyeh93J1G4iEbjXr2p2I2a+qcqDgMmKLH0M5mvO6SM0fxzLwDxFma2Q/5MhDqgs+fci77hQkM9813PQc4osFvKsHrjNnSiV83ZuO8fuT2jIV+enPwYclkWpRPHF+ZoAkodSeSd7v0k6erVc8pDRFWDBJKDlB6mr+GYz8apfy6zn5yewsl4wkmXYiAnR63oH6XSp+jDsokaNSGxwyh3KwRZbBFOX7nxXPSKQ28Wo/K+IBMySNxTil74bMU5WvviHvJhPTex4e6vdcIW0DcXr8DdDI1W3rpAvn5roOIkk415+uSJjzF4jLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXIMhEBlKShj/GKq2+RPRIt1EryiKCsrgXnbS5eWgI8=;
 b=pkRgYFoahdczpqj5QNq2SoN1kOACSLU9tQhKb2YiIxrZWI2xepwQEvgPBcsSpDLj+JtxhD+ZTdGJiXZgtK9ZEifVFIx/axO8G62s8wfoSgzW3jjqpQJoNIePyIPAiV7LwsXv3KXx/7AeGOmNL8BzpnBNyti6zLnjiwguQQ2L7sd32vFM0Or4E7GV4g25v3HvEXQ2BVd6UdRr8YrxkaG/0OGxNnTgxHR/i3yvbBEQBOgieoMM0Zbo8spDbH2ODyHx+VeL0iHrK4LU3vJCznVnM4lSXtS1x9TJ0r3OBDrfbx0747Bo+ac3q6aA6diUieTupT85XkTKkSBG9+k+fGVcOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 12:01:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 12:01:39 +0000
Date:   Tue, 18 Oct 2022 09:01:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liulongfang <liulongfang@huawei.com>
Cc:     John Garry <john.garry@huawei.com>, alex.williamson@redhat.com,
        shameerali.kolothum.thodi@huawei.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [Linuxarm] [PATCH 1/2] hisi_acc_vfio_pci: Add debugfs to
 migration driver
Message-ID: <Y06Voma/Prezqmag@nvidia.com>
References: <20221014025757.39415-1-liulongfang@huawei.com>
 <20221014025757.39415-2-liulongfang@huawei.com>
 <42d12308-4777-47a7-a1ae-50dfada050cf@huawei.com>
 <7c041671-71bf-d558-d47a-70296fe5c30e@huawei.com>
 <Y01GdiFbt2J9La2Y@nvidia.com>
 <9826a418-4a14-aa4a-9eb8-6faf3e43c8e3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9826a418-4a14-aa4a-9eb8-6faf3e43c8e3@huawei.com>
X-ClientProxiedBy: MN2PR19CA0044.namprd19.prod.outlook.com
 (2603:10b6:208:19b::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ecde675-f90c-4659-a23a-08dab10083a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWG6eICezAuF4PEuyZzuXmi9yZr2xuElL+yF8LwNKBof/j8PrMZnvQFY2/tW4EKOm23nHxp4AHixgx9W5wu9Xu9uaUWuv1Vfo1NgRTbD71pYFcCH7FpqZ0sZnFGgsb3hN/cmSB+6LC/OveSw/VWl+Fx8bYDTVV/2RZnfcdU207KNkXmx7FEpZqih5aATgkqzqEsdNjX/ZULYdrtB1LQV/I3W8j7M+TnK0ChY36Z5RSX9k1NkimpP09ndNC6WEbrjdhG0n6cZ7yn72ntjKtk811JGPmfATEgHoB38MUQFkvfeOra3CpcO8jXjdDJXR+QXgXf3UBPfGnX2Y+nIpVTJut8tK6fWFd0MLoLlousWu0TQa22P4z8ukKTrJklwiosWDl6Rt0E8NQAVQZ3sgq6BY99WuXDSU3sl6zOLbVGnZtd9cGieAnnu8pISjqW9of2QTFYUqpuKWvFzsiK3Jqa0rLZYKNXIbFziI8TvnxNwi4BqldOPcLttxWjmM+mkt0N1LWNvZubkQ74jtN+PwRZc4GnFhtoyEzQHziDICMBIfyIp9CCRSBfmX9u9aMJNyv2IbqGVtKJGr4+JRoPwkeKCB9ZukJ93ggph8nbtYy2ElN4uD2KUtLeo8g7LmIvPTM7rJR7bgUKIRw1dwTeGr29jB4Ko3H2trbRRLefBFRzqr4/b9tpbsZK6dxeLtzOKeqOLap6N1N3/aGaRpbX5i4T4VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(38100700002)(478600001)(6486002)(2616005)(36756003)(6506007)(4326008)(316002)(186003)(6916009)(66946007)(66556008)(66476007)(8676002)(8936002)(53546011)(6512007)(5660300002)(2906002)(26005)(86362001)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0hhOHhsNjBpb2NpdHpFNlUrSGtWVzF5MmY3bDUzZnZmVXI0TDhCdUVGS0RZ?=
 =?utf-8?B?WWlnN3dpbUJGRVFhclR3Lytsbk40NTUwVVVwZy9yKzFFZ3lEU3h3SXIzbnlk?=
 =?utf-8?B?b280MTRuQnNVdzdkclZob04yeXViZUR5NlF1SFo5OXpOQWZhQko5V1NrcHNB?=
 =?utf-8?B?Zm1ESVh6V0ZvdmwwZFE3WnVtQmRvRHN3SytXZW10R0tXWFR0cG9DMmJ1R1Rt?=
 =?utf-8?B?TmY4UFlrcjRyS3M0ZDJhVFd1aGR3b2c0YnNpcmh2VVRvOUJmeEJ0dU44VkJ4?=
 =?utf-8?B?eGRYYXU4SDNlVDIzcVR4VDlIUkFVcVhmbnhiQmlYcnFQMUh3Y2tpTThZRzI4?=
 =?utf-8?B?TCtxeHFZNS91VWl1bnlwUUFYZG9EMnZ6WXlsK3dUSCtON2orRFc4VzZUMHR0?=
 =?utf-8?B?Y3RyUVhKSmNCb2pONTB6S3VZQlhseWE5ZHN5TlVkOFc3bTQ1R2pWc0FJSU5Z?=
 =?utf-8?B?VXhJYkZYS0lTNGdKeDRrdWZuU1gvMFVEV2YzVVNHdEl0Ymp1M3VnQ3RtUVVz?=
 =?utf-8?B?QXB2aVk0YTh0akVkMjZxS0NCUzFOOU9WYXBiUjlTWW1odE0wcVNHdkNUWncz?=
 =?utf-8?B?bFk2MWQwaDZBSVVPOHlLNFVqVDBXU1RjekNFWVg4UzREMkczeHRCSHk0MnVZ?=
 =?utf-8?B?UU9yWGdGNXRsRllNMkNHRWhLeWptRDBORGZKL2ZtRTRaR2g5cm9FdDNOUk5h?=
 =?utf-8?B?R1R0RjU2b3VvRkk4Rnp2VlptU0Z0engyT2ZZQXFxSkRsbWtuM0lETHhGcEFa?=
 =?utf-8?B?RU9NZ3NHOUJHTkwxKzk3dUZ5bmM0SmhrQnkwaXcrNUFjMEJXOWlpb1FTOWFG?=
 =?utf-8?B?UWMzRzlpTWUxRXZrTDZLbVRzQklKT3NjVnhzdmlreWw5RUlsb0JUQXExN2Zw?=
 =?utf-8?B?b1JNSStxMG1MbWhJWlV4NDNhTW5DMDQrN3h5TWN0UlErRDZqY2pwM0JWdVJH?=
 =?utf-8?B?bjVYMDZwZDYycFROQ1l4QThmTkpFSUxzUjdpUG9VSStBTzJiVkFhQnI1UDUx?=
 =?utf-8?B?QStZbkprTHM4dGxjQjhQTGd6VTJ1R25DcDNmSXdhVExscDJtK3dqVHVNYzdy?=
 =?utf-8?B?U3k3RUtzcEZXM1I5N1grVmJSeWNCYVNnU0ZnVWN2QzMwOUhNRGtKNUttdUJN?=
 =?utf-8?B?a1BzQkRyTnVSY3hsakl3a2RXTEQyczlialRMNDkvN0hXam42UnB4QnErSHVM?=
 =?utf-8?B?NCtWMURsblhVYWdURkJnZDBoNFY4dGtiTW1WMWVHTU1VbFhVZTk4aER2M3FY?=
 =?utf-8?B?SVNzeG9ySlVVV2QxUU9laHUzZDFyWXZoM3JFcmQ4RjhXTWd5Tk53S2p0Qyt6?=
 =?utf-8?B?VWtUbFFUTGFKNnpUZUhTa2wrNzlwVUU5NnBEK2lGYmVaZjNhVjlpWE5XeThZ?=
 =?utf-8?B?Mld3eWNQeGdFSTFDT1NBNDR6Z0dxZ1pJRU1iTnhCakFHbmZORTRoZU9kVkd6?=
 =?utf-8?B?d1pyamNwWmQybDdLYUhuV2lMWUV6VjVMSk55bmdPMDZoSVIrRUZaT1Z5RTIr?=
 =?utf-8?B?cE1YT3Z0cER6aW5PMENkVThOZzYzdEJUcXE1RERXL0wzNUp2NTFoV1pOeGRr?=
 =?utf-8?B?ekVrejJ0SEdmWHQ0RlJjRG5US3BydmJCYkJiM1JrbkV0Y3RyYkNSYkJjVmhO?=
 =?utf-8?B?VW1SS3NMbCtic1p4Nzg0WHdkTHpmL211SXVPMHgvYVBJcW9mTUwwYWZnbEZG?=
 =?utf-8?B?KzBVUmVsaFU4TkdINXY3NTVqcVFBRlF0bFVUSjRIN2N0aWllKzZnK0pJdHZQ?=
 =?utf-8?B?WWwxTVI1dkNlL3BiOEZ5bEtaSjg0ZTJsMGY4ZjFSdXpSYUh5V2I5TUJkYVFR?=
 =?utf-8?B?NC85SDlFempLVk1VaDZ0bGtzZ3ZpSkx5MDY4a1VzN0xFaWRrYlNRWEtTN3Z4?=
 =?utf-8?B?a0w5UWdFb0grdW85RGRpMlpJZHNRYUhPUEpRZDNabGR2NDVSeHJvMEpjQklr?=
 =?utf-8?B?Y2xXNFRsV21jVjdPTDVBbFpsZC8zbURyVVEybWdJQ2FMVXRGbDJPT0NMNlda?=
 =?utf-8?B?NnpJeUxkaUl0OWxjdWVncGFZY09xZTBkeWppcXE5ZGt3QmZoNnJiM1RZcGJo?=
 =?utf-8?B?cDZxeW9oaVJyNEcwcHVaN2pMaE02NUJCTFVyZHJPYW45VnEzNUM2RGpSWSsz?=
 =?utf-8?Q?D4AI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecde675-f90c-4659-a23a-08dab10083a3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:01:39.3938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzN4//YJMwJaJW09ZtEpGxt7+1/dhou3aSPQupcMmcO1qVlYyrua6AOk92JKnj23
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:06:43PM +0800, liulongfang wrote:
> On 2022/10/17 20:11, Jason Gunthorpe Wrote:
> > On Mon, Oct 17, 2022 at 05:20:34PM +0800, liulongfang wrote:
> >> On 2022/10/14 17:20, John Garry wrote:
> >>> On 14/10/2022 03:57, Longfang Liu wrote:
> >>>> +static void hisi_acc_vf_debugfs_init(struct hisi_acc_vf_core_device *hisi_acc_vdev)
> >>>> +{
> >>>> +    struct pci_dev *vf_pdev = hisi_acc_vdev->vf_dev;
> >>>> +    struct device *dev = &vf_pdev->dev;
> >>>> +    int ret;
> >>>> +
> >>>> +    if (!atomic_read(&hisi_acc_root_ref))
> >>>> +        hisi_acc_debugfs_root = debugfs_create_dir("hisi_vfio_acc", NULL);
> >>>> +    atomic_inc(&hisi_acc_root_ref);
> >>>> +
> >>>
> >>> This looks totally racy, such that I wonder why even bother using an atomic for hisi_acc_root_ref.
> >>
> >>
> >> When enabling VF, it is possible for multiple VMs to enable VF at the same time. The atomic variable
> >> is used to ensure that only one "hisi_vfio_acc" is created. When other VFs are enabled,
> >> it will not be created again, but will be used directly.
> > 
> > It is still completely racy. Use a lock
> > 
> 
> Do you have any suggested solutions?

If you want to keep it like this, use a lock around the creation.

Jason
