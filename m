Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6404173E1EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjFZOTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjFZOSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:18:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20620.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::620])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD9C2974;
        Mon, 26 Jun 2023 07:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBPO7/QFJfG+x7d5c/OKIy304beYc2YBf8FOQSIVI2OSktPZ6OOgosoVkpvjhSGI6+ORR9m57LkIOfA3WOdXhP+aRKQKW1UpzQz3kYzHk7nJYg+RRLZX9EH/6lCIwB5WT76WtPJluf7V0IyDnaj6eEXZP31naPhbuqpwtNhauf4pkZRAbCXyUAGGY8kfrMGcDf0/jJ1M+H9dhOLNdTRJltT5wbgoYjhmQeoqMQiMb1pi92YQ3nOtw39AKk/1VqgNr0DlOoCu1p+Yra2ud79fAEuLFlf0hxFfRoNhZ+hcedn/04HLgOm/TMGY6egBS18tidPSYaUV/Q6PFUbnSWlupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQslgKF8AsYTBz7E5/esZK6fMQdIxFJU/vIoJRPTPDQ=;
 b=OyPtYT4bFKZoTgMLyUjxPxqOjH5CLYxkIUP72kgJ/+UlhGXS8CDPWQz9KuA3z8Bm8P4UvGmEdEbdHC8CrdF7+Dqu7a/Wo03PGs1/NlIiK6L1WPz6kSHtJ1ENPm6C1CCLEA9sn0Ru64RHqc9X9XJVpxYsTNHTTYHVBnY+cj39tM1wwV1bkgpCYLyIR9Yqze1X/Uzh1jh/M0PtR1LztcDjcH8A1CBto4nFfE8ILy1SVpbXN889+Z2wj0zBpsAkACoeSeVt6O1ocs2b2SxeR9HSmFG7bG2B9iL8IRVYVJGFpEa0EZ0Q/W7BoKQ3p2OYUBhBVhN2nHiqn7uckPMN78bwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQslgKF8AsYTBz7E5/esZK6fMQdIxFJU/vIoJRPTPDQ=;
 b=4q1TRbkuIkxWEanHZjngFLJY9/i0KFdi/kDh81eo2HsVv+0LZIXe1uSWCtVUB1TawO4R4V4Ptau+SV43Qd1wUApJ34Ljy4WYrMDk9rSxUYVIjW8vLdw7Wqz9NtldPVVKqgnCnaUZJrowdNlUjtgVBba5hUQhPY8HoxFNoLIU1Pc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MW3PR12MB4523.namprd12.prod.outlook.com (2603:10b6:303:5b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Mon, 26 Jun 2023 14:16:31 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96%3]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 14:16:30 +0000
Message-ID: <26e77f98-a960-dc84-f861-2bac00c32cf8@amd.com>
Date:   Mon, 26 Jun 2023 09:16:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 16/27] cxl/pci: Store the endpoint's Component Register
 mappings in struct cxl_dev_state
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230622205523.85375-1-terry.bowman@amd.com>
 <20230622205523.85375-17-terry.bowman@amd.com>
 <64987b92ce13c_2ed7294f4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <64987b92ce13c_2ed7294f4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:805:de::41) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MW3PR12MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: 217a979d-e3d4-446d-b8c0-08db764ff016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: razLcL7yxUb/jinbfY8W1EtvGjHU3ZGhs6/IkflJwnDJxjlzgrzihsLXF7Fgs8XyN/Dw1nqTtQUvRQ2mkNW6/0zIA9NiAH/DLfwGOxhQwfCQahJP+h9GfJrntTKtkrP1B7O+Ea7KbtvUdynVjr4cqj4TB5cB5EYpGW/tCrW7z+i8At2GhQ7fh4eoCEe/8lEsQAuDZWnrKRLV1JYoB0HZEabkWHUJB5VEENTnCbXx/k2Z17USTgDtCxRIaHjeTGE+CVZ25R6vnK3GqvlgDayiPVkcRcFrn1sgj5zsMzBs7EwBBEP57kOWCNWleYPAPU84HtI5SQTh6ObZMF7VnZISoT1KW2/R0yHh2I6QiaGjm6gwtwuWOtrF6tEfStNX0vXg79nK8siLwu18lgf0RAPzwclyv8XEMKwH1DMuaxYwG8Vi5sYDd20kYlD/AMjyd7QOBWgFn+eQv/iLQd/pq0b1oGcAZq7RECUg3cFZ7w9pjfxgA91Ici0ZFhaPUcG9uizIlnwD+rCU9bcDtoVbbDU+DWj76Ymb+ppYW8/Ww9tx3Vvedey51GyBqMPUBygi285DxNrB9SC4vZEcrjYzMxwGVMVqnZESvWfIMGbhBv6DwUmBEa2+FXzhaSoJi7GUCDIECiZd9RbFelCci+KM9DLNqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(478600001)(6486002)(2616005)(83380400001)(26005)(186003)(6506007)(53546011)(2906002)(5660300002)(7416002)(36756003)(38100700002)(4326008)(66946007)(316002)(31696002)(86362001)(8936002)(8676002)(41300700001)(66556008)(66476007)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T081SGszSW50RnZRcEp2Mk1uek9pU09od3VSdHFsNUVnMjU4b3hCcmpYcEFx?=
 =?utf-8?B?bEs2OWtzUHdVV092UGtOUmZPTU5jZmlJL05ZcStOT0JyR1pWM0djUllZVDNu?=
 =?utf-8?B?RG5RYlR2cEFjL0pldVNqaXE1cU5pS0YyMTFoSFV3U1p2MXlKbjJ1ckNSMTdx?=
 =?utf-8?B?NXdBYmlkUUxMOHpFYjFiSHZFVlNmWDRUeWRkbTdjclluMUR1Vk1QdnpmUWV4?=
 =?utf-8?B?aWhoMDRIZnVXbndVbnY0UnU4cG5LMjVuQ2p6WjJRYmc0WGQvUm5mNWp4NEEr?=
 =?utf-8?B?OTI0MGpzTzRmUmh3Wmw2TFNLS2gvVXNwT3NoSGU4ZUJuT3M1dC84bkVLM3Ny?=
 =?utf-8?B?UjU0RHlKUURVUnRjYzhEdDdWYUdEdUJOTGQzc25PRzhRZmpaNFlqQXR0blpX?=
 =?utf-8?B?b09peG95OFFxcTZFc2RBWU4vOUYraGNsVjVGdmE3R1QwM0NEMm5NZVluSVM0?=
 =?utf-8?B?VXRTY0RWMHlIN2o3a1JHbmJGMmhEUk9sVHF2c2NuNVd1cklKNjBkanRuYzlu?=
 =?utf-8?B?dys3SDV2QlEvL3Y3NHZ2aVNocjdScTNjV2xmWkhMVU5JM3RDZ3JtbUtTOHRB?=
 =?utf-8?B?WHgxZE1vVUdETTQzSUlLcGE4bFhrekFIQVB0aE1rVEVtZ2xPVTFvbktQU25t?=
 =?utf-8?B?bUg5ZlFqdWNla1JlZmVtQ2xmVnEwTWtxcDdhY1U5OGtzZG50em1XV1A0RE4z?=
 =?utf-8?B?UmRWUkJFbThKTmRqT0JuT05tY1BRcmtrMWk4V1pMSzNYeVl4T1drSm9kOXM2?=
 =?utf-8?B?U3d0dHcrUnFWd0hNYlc2ZzU4dm9jVEtaVjhKUTR1QXBjWi9FTFQycjRiZG1I?=
 =?utf-8?B?aTVDRUNMbEVPc2p1R1VFY0JXQnFrOGE4SEZVRWRlOS8zdjh0b3JvY01PZkd6?=
 =?utf-8?B?alJ3dEFwREZzWDV0ejJtMG5LWTROeWNOeHBFWVZqeVpPaEJHeHpWY0hkRThw?=
 =?utf-8?B?OE1hZGF3Z2xpaTVsZmpsY2lOd3dhalcxTFZCMG5ad1MvbE54MkJHdS9KY1M5?=
 =?utf-8?B?aHd3K1hkcG4zNlNTeTI1bnlRZVpXQWN1V1o2SVlIQWhYN0prUk9UekRRSDhR?=
 =?utf-8?B?aFRBcmNUNFlDNnBmdFYzRldHRjRUZDM2Yk4xdjJKZmVCeXpIWU9Xa2J4OVFO?=
 =?utf-8?B?VDU4N09VT28welo4anRVQWdEUkprdG5qYVNSOHNCaUpzdWUrLzF0dTlLeGZD?=
 =?utf-8?B?RmwvOEZ5UURYTGxlMllDZzEzZHU3TlpFb0NOMWkzV0FHdmFRaUpqRFp6ekdV?=
 =?utf-8?B?bEpOanN6UnVsMUh3LzcxekdjbVpGOWVBZVBrdlZ1UFFlZUhVdGRoOFFGZjM1?=
 =?utf-8?B?QmNVQ1drV1FEM2dYc3AvcjFNc0U5ZkFpMVJxbG13R0NWeXIvcVhtOFVVMEhL?=
 =?utf-8?B?Q1JxUlF6UDVXY2xzSnozcVp0MU5pZXB0UndzaDNvalhOSXM1eUk2akREK2ZI?=
 =?utf-8?B?eVdTV0tLYXNTZE12dldBcHljNTlndU9GUi9rbklNclRiRkpxMUYwQW9HaUtm?=
 =?utf-8?B?QUlIeGx6S2pKTDBzalF4Z1Y1Z0kzNVVWU2l6a1JZMHRxTWNUVTNMa211Y2x1?=
 =?utf-8?B?MmRMc0NZVUROK01KSWhjYmE0bitqc1IvY3RPa1JLMUxuQkR4ZjVWOEQ3UDNH?=
 =?utf-8?B?OTRpbXNlc21WbFUvYlBYMFNpUEh3cjVlZzBPeGhDV3d1elFXNUpkRUxoUDJC?=
 =?utf-8?B?U0lZSUZrUTMyQUR2eHUwalNUWDg0Si80aUdjSWtUekZuU000Y1MrSTdpSGll?=
 =?utf-8?B?SjlZU0FsQW9SSDZwVDJSWGtNY0l2VURocjRRU093cmgvZ01GSkNkVHdLOGhx?=
 =?utf-8?B?a1Fkd09wSndRZ2tLNTRJb29PcERSeStZVDNXUDRUTlpBSzRyOVV6V3g2ZU9W?=
 =?utf-8?B?RW95d21MWHF5Y1lWeTh0ZTQweWY3RlJHVlRsTmFmdUtiQUJWeHVRcEVzY05Z?=
 =?utf-8?B?ck04ZmdvUVRUYy9qdjJBM0lKLzZ0SUQ4cnVjdGp4enNTU1kvNFRGY1JCczhM?=
 =?utf-8?B?cGo3dEFjbnVJWEViTHB1Z0k3ck04UXdhSHY1cVJQS1NlRlFxOGVzYWdmRllL?=
 =?utf-8?B?U2VsTndYMmlSYTVnRUpYbGx0cjRSSGFLeGsrOXRMM0Q0UU8rYVJVUVp4aTFX?=
 =?utf-8?Q?U8i6Yx/IKG2y/6xLD3NPieySY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217a979d-e3d4-446d-b8c0-08db764ff016
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 14:16:30.7164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sq3yx53erjwGbPMVQCopKmyT2bZ5Vo6mMt8drvrzbPVMs/SayEw8Tiqfx9r4uqEf2DWtucTUu7uWRyVpIhLcDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4523
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 6/25/23 12:38, Dan Williams wrote:
> Terry Bowman wrote:
>> From: Robert Richter <rrichter@amd.com>
>>
>> Same as for ports and dports, also store the endpoint's Component
>> Register mappings, use struct cxl_dev_state for that.
>>
>> The Component Register base address @component_reg_phys is no longer
>> used after the rework of the Component Register setup which now uses
>> struct member @comp_map instead. Remove the base address.
>>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Starting with this patch my QEMU cxl configuration fails to probe the
> device:
> 
> # cxl list -Miu
> {
>   "memdev":"mem0",
>   "pmem_size":"512.00 MiB (536.87 MB)",
>   "serial":"0",
>   "host":"0000:35:00.0",
>   "state":"disabled"
> }
> 
> ...the next patch changes where the failure occurs, but it still fails
> and applying the rest of the patches does not fix the issue either. I
> have not had the time to debug it. Please have a look and make sure that
> at every step of this patch set the driver is still operational. I.e.
> 'git bisect' should never find this conversion in a broken state.
> 

Yes, we will look into this issue now. We will verify each patch 
builds and runs without degrading. Can you share which Qemu release/branch
to test against?

> For now I will look at proceeding with patch 1-15.
> 

Ok

Regards,
Terry

> The cxl bits of my QEMU config are:
> 
>   -object memory-backend-file,id=cxl-mem1,share=on,mem-path=cxl-window1,size=$cxl_backend_size
>   -object memory-backend-file,id=cxl-label1,share=on,mem-path=cxl-label1,size=$cxl_label_size
>   -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52
>   -device cxl-rp,id=rp0,bus=cxl.0,addr=0.0,chassis=0,slot=0,port=0
>   -device cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,lsa=cxl-label1
>   -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G
