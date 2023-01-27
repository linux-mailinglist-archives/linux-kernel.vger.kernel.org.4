Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10DB67E7AF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjA0OCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjA0OBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:01:41 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD8888CDF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:00:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANgRYnRkpqBw1ZFTA/VyI9rLW6DmzALG7wou/3KADx29jy4iJ1yAnMUEQyj5p/Q7kHEw+RztWYxbDetWCwQfdCVYb3gRc9pfcgoXnrDrgzRZ1pNtGvXKMOsLEQ8D9KSAV3KnlqK/ol0vI1SOv6VAA8BH3ZTSxRnYZgyH++FZXXE0CimgrmmVL1hEVM2NZprd/xgoQT2yr4vW8XfBQj6oBd9OEqrXOo3JdSI6mb5kbVothAL6XyLyHr/rzygcImtVbwHC/HCcWxelr0i5mmUBk5/iKhq6R6xvBABVkhz+CgIHCzyR27a1ovwGgEURlzd1xLdBRj0nRkRpQN2WQseA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWoaOfATD3r9o1GFkDSmUOKEffaYCWpB3xtlCkcE9+A=;
 b=lJheoddjsGsUUZacOQbDgKYwjWG1L36PpYBKdY90FbSpvo6gIQxbf6k9l/gidbulfLd9IkBI+SA5JqWozVYYqI+w8pDisxYOZ3POSk7CfdeObYR7qF4HIGFVeRh+tCA4X9+IVvXK8XAvqKZo3sZ33HxaLI3lkE5radfTF3/V/CWnhImXQ8G9EF7FkUmZaqOLG8BSIUIpgly14VKlxnwpMzCT+r09uG1itRAoNeQbW/zSv9alriUVU4MuMfwbkU58HjFDnwKuAPvdJ4MQ1Nb5AmIjEQMqaqHiDe7T6y7nT0xE2Qnvc7tO1FsJLgr5w38JdtRj2sMDLWQC/H62HzccnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWoaOfATD3r9o1GFkDSmUOKEffaYCWpB3xtlCkcE9+A=;
 b=ADQuDZCMm+CDVEU+ogTGZebAhE1DHRjcKFP5EDDK/QqRMFZISs87Bti91JAtffiqDfPy7Ut5JkrmJku/fvyLpTdsu8FoG0mzoVCuSFh0gLctX+LU9g/hYofkmzH/Gm9iWx5U/SIRx4DxzLDD0ahsZ+ttCMfTzAdInvxFLiF4ycPW/N/DTrjO6jQwxxDWIve5z+hdc533lN8bOuS7jjxU9/sDAxcbm0SOCiFEZiBPbJTavxOa8kLv3PLuF7//vOYAVmH41Ujk5ivC29D3LM/G/FOh+0Qm0TbEfVKSs39UaWYOrXBAjkcjppteRSlwtwxt51dwpyYOsgKrRPTh5GD/Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Fri, 27 Jan
 2023 13:59:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.021; Fri, 27 Jan 2023
 13:59:03 +0000
Date:   Fri, 27 Jan 2023 09:59:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org, hch@lst.de, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iommu: Decouple iommu_present() from bus ops
Message-ID: <Y9PYppHmuSVSqQ62@nvidia.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
 <1fb168b22cbbb5c24162d29d2a9aca339cda2c72.1673978700.git.robin.murphy@arm.com>
 <c96aaa6c-0f46-39dc-0c72-f38394e37cc3@linux.intel.com>
 <ce25dcdc-99a9-61ff-0cad-6c6cd9552680@arm.com>
 <Y9KRBRKdwSIRrvQw@nvidia.com>
 <b6b55688-1390-4e92-8184-770154a8955d@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6b55688-1390-4e92-8184-770154a8955d@linux.intel.com>
X-ClientProxiedBy: BL0PR01CA0029.prod.exchangelabs.com (2603:10b6:208:71::42)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 157e0990-b220-469d-bbc4-08db006ea5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MvLuWK8k1QOEDhuGAiHjTdUX7FjnKwq28RAiHu4B/8xLG80rKeK29/luBLjHX/RJagN7DAKTo63NRdh/sDyLjBoFMkbjmQS7ELy42OeeaIrwTfnu7zWx1AcA99jSJ3eZMNsZjfUHBnfCFUPHwNbytWsBfL0JXOsIY51o+OyEJnpypz7HBZn7pmoP7yYOYYy95CAddz6Ce5/X8st3ZbJOhjGys9GATf+8aYhv5gMxi8O3MnS/3EFLt24flDeUUobQEzK6mEb+KW4ZaWbZGDs5AXA5Kgq2z8l07N40sJjy72oqtU0sVb5wG+UaxsotMg/pMHAL3BqMKyb+Vd9aMVLbgYSados4tLDpySR6zShUn/GwQ6pDyWw8LxIZlyy7BlbjVOR+PYAXsYFSXQJBl7C2a+wh6bTkVh87CeKjKn8hIONuvufvnM3+ZR16ifqxmDBZSc1DRsQtSONOz24PZmrZACDEbbhNLecp26mI5NSnBNjEMVkvlMN+pqPMXYiocXAzxB/CFVCXH8B3ohwsiMxUZx32gNxs+0WmkcFfk4keW5QUiPf51ikDtF0eMt2n7Wm+HvwjwJFj38s3YLK15FXLQz7TiE6QoENMvoJxkPZ3jFZkMnDzr+YX7RaColY6HeGbRMM0Ao/UUU4q/X3yb7uvqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199018)(6512007)(186003)(26005)(53546011)(6506007)(2616005)(6486002)(316002)(2906002)(41300700001)(6916009)(4326008)(8676002)(66476007)(66556008)(66946007)(478600001)(5660300002)(8936002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDBEdWIxWUhjeGlpWURxaWVvN3FZalpKb2VFdW9SWkdMei9QVFBHbm1sK0JQ?=
 =?utf-8?B?dGNkREZkZHJCSzRhS3Q4c3l5YzdkNGRwZmhiRFdmSGw5K2FBWDIvWDRoUCtZ?=
 =?utf-8?B?UXJnZFVWVXNtQ1ZYSnY2dkpGUjV6VjJJNG9tc0tYSXd3dGxWcENpS080L2xS?=
 =?utf-8?B?d0JCYXhvaGEyV2I1Y3F2S1Y2dDdJQ0t6RXY4YVFzWlZYK0xOTjExSUpmcThD?=
 =?utf-8?B?ZHgxNjRIUTFRRHJzREsyZkU3U01jcFhWaUloeXJYZnhLRWphQVlkSzgxVmky?=
 =?utf-8?B?Qk9zT1M5OTNUNVFibGtYRG1uVW9NbzZ5YWJ1VTFXdzhaM1hWQnhMRFhSZzVt?=
 =?utf-8?B?MDcvTU04ZTZuN1B4TXdiSTJ4cXdPUGkyNmJpbUJHOG4yYitCaGY0MTJtNC9h?=
 =?utf-8?B?UElyUEhnWmZqanp3RXIvYURvS1hlN2tWWjJIbHJWWjBMdWloTXdyVnRrWmdC?=
 =?utf-8?B?bUIvVnVmYytWN0NSSzM2eFZobEZHZzl3bUhPaUJ0Q1dPZXo4ZnF4VnFaTURL?=
 =?utf-8?B?eDFteFlES0l2RjdDZGd5RHBpVHpIazdPcWVDUUo3czE2ZVlHczUrcDROaWQ1?=
 =?utf-8?B?RG91K0pLODZWNFVtVUVjdk8wRHZkeE9XKzJUL1dNY2R6MmJ4Y2lDSXVzOHVo?=
 =?utf-8?B?SmQ5ZFNnNlJNeGdyeEFyQWJ1eHJUeTUyQk81MWFnTXE4S1hpZFo1U1k3MGxy?=
 =?utf-8?B?dlAyV1E5Zyt3K2xtRnVqNnl0emQ2cnlENWJtMmhjWU9UMEROK2wvallJVTB0?=
 =?utf-8?B?bWJyWmZ4dkhUM0RCZG15UXdFNUNmU2hlU3JSK3hHaXBuUWhZdllObTJobGl0?=
 =?utf-8?B?TzdhRVp6Yytlc0xwS2hERzRJWEtYRlRZUzdTWHYzaHVUTGtEK3QyeHlTcXJo?=
 =?utf-8?B?WHFVWVd0SXBUcWd4WkI4UklodmN0Wm1UVTVZMzUxbWFJZlFzc1pjL2tlK2xO?=
 =?utf-8?B?WHhNSUFhSEFrT1lkYzZMS2pRSjFWTjFDUXFRVVp5ZDd1cVJKY2xrRGJQRklj?=
 =?utf-8?B?RnRrTVJsYnorOHcySWVhRDVVSUZJcXZWOStZZE96YTYzZG1Xbzg1ZkI0Q25C?=
 =?utf-8?B?RUlCenRqcHZJUldBY2FWaldpL2pSOHUrQ2ljMEUrUmlmOTZPdVg1ZTZkYmhn?=
 =?utf-8?B?WG45WnUvL1FvTEVlZTVXbzhWeUpUektNc21IdXVMNVNYZ1ZQbFNmRkllOWhC?=
 =?utf-8?B?RENDMG1uNVFGVzE2WldJTHdKVVpQdDRnSlhRZ2JyYmZUcHRnSXhMRVJ0WEo2?=
 =?utf-8?B?c09lYndUb01pS2NWQTZ0UlFNM1dEK2hsTlFKRXFuYkJ4Umh1T2NNN0pwa1Zy?=
 =?utf-8?B?TXh5ME9BbWFxcFhIRnFZT3JZa0NKMUNTRWhMQ3A3K3B2RUV1bnpoNEVkMEMr?=
 =?utf-8?B?ajk1cWtNTXdQVnRtOWlJVGVhclEwWmJLQW9zblN1Z0lsa0grU1NUL3NKVkxD?=
 =?utf-8?B?V0dWWXZnMUVudWFEU1ZoaTFiUmVFV1RMY2dGZk1ZY0JSRzRySERhSmQyR1Fz?=
 =?utf-8?B?by9henhCUUJBM1FpWGFJQlQzR2x0dDdGWXlhc1RhcWRSeFF5OXBrSVI2TFgy?=
 =?utf-8?B?YUw4QnFSY2VWTGEwQ0IvNTZycUJ5RG1XSTFxQUdnOFVnKzd0d2dnRloxRkpC?=
 =?utf-8?B?MndpM0tWTTBUMzBDYkxub2daRTA5WWVTbUUyQ3UydzFjRVpKS3NGN0JqL3or?=
 =?utf-8?B?cElXRGNDTnZTSGpzR2JvTC93MjBaWEJqRVJ2UnY4RU5tckg3c2RiNWpoUFVo?=
 =?utf-8?B?NWdsRUNkQm0xakxpUjlMZWw5SzlwRCtDbzhBOEZUY3MyMXVuU2lFTUgwMjVW?=
 =?utf-8?B?eGJQeGhCQUI1bG9pSGFKbUd2NlNyc05uN1grcHdUL1BmL1E1Sms0YVpRaUp4?=
 =?utf-8?B?b2UxcGVwTUgwYW93UUpkRVo2OTdWK0NyTEpvTW9TK043UXBRLzFPSDE2UWxY?=
 =?utf-8?B?VXM5UUtjTDNRQStZNmZKeEpGcVJ1eHpkNURLUFpFZlQ5ajdrSkdZWStUWlNn?=
 =?utf-8?B?SDlXbEUybk5EWG1LZVloaFp4N0lOMW81ZG8xYlBnUVN0NkN0VWl2Z1hkdmYz?=
 =?utf-8?B?NFZYZGkrdlB1WlBSdndObUtZRk9qU0Q5ZldvOW56VHVyL1pBN3UzYXFwNXJa?=
 =?utf-8?Q?l4ItJdKaVq6+89xmfCp1LCoJ5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157e0990-b220-469d-bbc4-08db006ea5cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 13:59:03.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itzyitsAKUAZav8O211hcz0TCabp3cxMfYiDDaWL609tr+mqKuFexO6GD801ZyF5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 09:50:29PM +0800, Baolu Lu wrote:
> On 2023/1/26 22:41, Jason Gunthorpe wrote:
> > On Thu, Jan 26, 2023 at 02:21:29PM +0000, Robin Murphy wrote:
> > 
> > > The "check" is inherent in the fact that it's been called at all. VFIO
> > > noiommu*is*  an IOMMU driver in the sense that it provides a bare minimum of
> > > IOMMU API functionality (i.e. creating groups), sufficient to support
> > > (careful) usage by VFIO drivers. There would not seem to be a legitimate
> > > reason for some*other*  driver to be specifically querying a device while it
> > > is already bound to a VFIO driver (and thus may have a noiommu group).
> > Yes, the devices that VFIO assigns to its internal groups never leak
> > outside VFIO's control during their assignment - ie they are
> > continuously bound to VFIO never another driver.
> > 
> > So no other driver can ever see the internal groups unless it is
> > messing around with devices it is not bound to 😄
> 
> Fair enough. I was thinking that probably we could make it like below:
> 
> /**
>  * device_iommu_mapped - Returns true when the device DMA is translated
>  *                       by an IOMMU
>  * @dev: Device to perform the check on
>  */
> static inline bool device_iommu_mapped(struct device *dev)
> {
>         return (dev->iommu && dev->iommu->iommu_dev);
> }
> 
> The iommu probe device code guarantees that dev->iommu->iommu_dev is
> valid only after the IOMMU driver's .probe_device returned successfully.
> 
> Any thoughts?

I find the above much clearer if it can work

Jason
