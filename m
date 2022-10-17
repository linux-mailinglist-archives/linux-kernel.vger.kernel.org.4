Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FDC601940
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiJQUTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiJQUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:18:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C6B1838F;
        Mon, 17 Oct 2022 13:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yiu5WPywCtau2tf/wFN5BD6D9X6tWJYgI89NPCmp2ImhhqYuKPIYvxBKDoXsrJa9sDDf8s+GTNcMnNDgRlwTHwa3wzj5coo5MC3cTH6F7bQzi1+Ad4dvdJ6IG8OSiyUbn4hARDRc/JMS5OmHsxQj28N1rRWtut8QV/Rtgv9hqxQord4p5LtUhUbEj7/VfD1fjvm1s+Tmbvf7cZz1jPjQ009eQXHfqDaEjHztIK9+ozVKqT7KQoUO4L9DZP/b75i0ZenoHvNLF2RM/tkXQAjA9aDK3ebBJ4XdlJdcseH0iP0HfmFHT42F5l+ST3JYEoCED7g0O973bTCUpwa2kK4fuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TGl7AKM0cXrk5rXNDYMnLalbKV7htQpzlDhQ9KrKdI=;
 b=oHKQv0y5H4ArO1y/X4ClxoSusItQbiIaTr9FBhDILdlrdOGXf2tkYn68bzo0g6f0y+3BPMKPZlxxBy5X26VYirWp+Myf4zvH3DMYLTGOQpsWI3SYVE9MOisT4/POW/pI6K5mfVqTwHgM0y585Foh3W4bh39dUrKn8Pw60JJ6qzKFqEXfgmF0F+ixJdCpYp1pKri1NixbPyzZdVJRdYwON5724yY1/mg7KDlMS/lbSFqyO4pAxvEytDHMYcF4yZUV0oy05XTm/7KnjAblbpkRpjxJr0J5FM4mnzCBdBjijJ9ccRqWMsH5zecZg93DfeSfHgG1LQJG5NtZNuhoeSeWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TGl7AKM0cXrk5rXNDYMnLalbKV7htQpzlDhQ9KrKdI=;
 b=fk/TpcFQMe4FEFxrGMsLK+u0HY27D7DUf2fN/Q+F79XhmoeNXXd0rZmyX16HGR7rIbVsuv7AOjKT0hcoq0oG91p5vDAna3cOu4OL0VgqK5ibdB2VCsEsgSxlStfrWSfkuJ/mnq5vQOLR5p2p83VBLYW8HXMUVrazdevqR6d8RQMTunSxP2gphKdHTB3xX51lpWcleOcYP9tPmLVChLIhwIvdtY9H/G/gz1OeAC55C7a3Lo47QOePDM1KCBkTKeMT/KfSvYAmKB6aMKNkj1O9DEVK6IEW/OZitjKMMYcT6BdJ9aAWc9NuT5CmsTvWjIJgHs2IUUexpI8Kznr70W2Blw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB5008.namprd12.prod.outlook.com (2603:10b6:5:1b7::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.30; Mon, 17 Oct 2022 20:17:37 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%5]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 20:17:37 +0000
Message-ID: <d627e907-8c2e-6a98-20ad-5f7c50e56146@nvidia.com>
Date:   Mon, 17 Oct 2022 21:17:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] xhci: tegra: USB2 pad power controls
Content-Language: en-US
To:     Jim Lin <jilin@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20221012102511.3093-1-jilin@nvidia.com>
 <37b168f2-049c-c01f-9f60-c119fabf8606@nvidia.com>
 <cf9b9c605ed06e59edd3ae5deba914cfbfa55be3.camel@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <cf9b9c605ed06e59edd3ae5deba914cfbfa55be3.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::34) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM6PR12MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: c16361dc-1724-4c22-abab-08dab07ca22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0duNG0w6Cg8fGEICoE6nQIy07Gil32Pk8nphvtIFOFg4DOf39uxA60tGaiVAYBfN/v3XhuftkrppYLEpKlguQkRwOcbBbm5AKi7aGoJs0LpdMgjWgKc1w/93q8HzdRmo9nBhb3YkCt/VzjqSx3isHN2lC0FfxscVNdtMiYHVinn0ZpZ+H+x5gvwqhJkEPOgVAo2KMaQv2nET30AbsOHaivg6LJhIlHoLQUqCdQ+9+u5vYPXDhG/IRbYuCs+JtuWmtKMv2OUdAsTco6iWPbVWVhV6jt2mr8UFRgbP+Bb6E4nf7tFf2294Q8CAOJvCqcHhOAACNIniQm59RG0unce9pcod+zjdcKlQn4aAKO/Bb4JOvMfQY3/Y48Pf7nx1i5GEJ6MYMvwaN/o4X7h8F4Zz5w7wCDDmEICVpKP9yUoOvG2FBfk3vpesW4ZU5X8CzQ54kutp1tcBawV2MuqcSSmkqr57e/EU1AmCYwh8SUqOPGYMqGhoOsABlBSN4pemR+1YECqy62OXXCGfNmQqBOuUHwHhVzwMmzUZk54chl63zo+WtJBHRJEgGgjUcXOEDlbw0g6jzwkmQ30uKb2sVo4Pap16AHtvOD6WKll7ChPar6mdampIodmyiHkkK3HYJcxrfIQ0k8/Ay8a8hMuy2K9G7a1k9o+nO7tDKmgCo2+d1WjN07cFWA0acG/G3K+HWcS+PvSWPSk3/gZ81FeeS4g7HTSUmW9qu8LJBJJ22e9iL03MA3B27a+xBUkY/bSEi0muOSXdZPwch6G8w65KMNY3AcK9LrdTW9Q9vl20FDidfLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199015)(6862004)(41300700001)(5660300002)(4001150100001)(2906002)(8936002)(31686004)(316002)(36756003)(37006003)(6636002)(54906003)(66476007)(6506007)(53546011)(478600001)(83380400001)(6486002)(6666004)(66556008)(66946007)(4326008)(8676002)(6512007)(86362001)(31696002)(38100700002)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SldxNERxM01nQXdoUkhRZ3pwbGY3YzRQZ1ZpcEdRcnVzaHZCN1o2Nk9NY1po?=
 =?utf-8?B?K0FoeGVNUVBoMEtrbGd2YmFlQWJiOFE5VWtMcmV0L2JpUGxMUUt3RFVXZndk?=
 =?utf-8?B?eXNLWWtLbnNiOGIwbG96b0MxckplcTRPNGMySndKVHBHU2xCMWZHRGkxdTY5?=
 =?utf-8?B?SmN1MEhaamhsVWN2S3pWeXFKa2diSDJBRWVJc2dQQkRvY1QySklhTXdpTHZY?=
 =?utf-8?B?dFd2S1ZEVkRKVDlsWG93bWx4Zm5qRUF5R3RRcmZ2RFNDME5YQTJPeGZscUZ4?=
 =?utf-8?B?aEJlMUlDaGhleFdZbTJYYmh2T0VOcUcvdStUWnNtMmFVUE1qbVhUZ0sxaDFC?=
 =?utf-8?B?dkF1NGFaOG5QS2ZNSWcybmF1VXJZRGtNWXJ3Qm1odGg2Q2ROS2lsNU9sd2Qw?=
 =?utf-8?B?V05xbGMwQ0lacDZhNzhMcnJTckoyYTNGYmZGN2lRYXEvUWdQUzB5Z3FsUnJV?=
 =?utf-8?B?eGVSWHJ2YW9JQXpReWhGUnFBUUVtYmVZTEVYSGFCbU05OGZldDJrNjlwekZa?=
 =?utf-8?B?V1Q5RGVxbmgzZmdVeUVjK0p2VDEyUUxWVWY0WmJFV01JVGQzUjZhSE16dkRB?=
 =?utf-8?B?Y0FSNGFSdjBWa0lPSVUxVDhwaGNVcWN0aHlzYVNyNUQwNVozVElNRy9McTV0?=
 =?utf-8?B?clVtdDVPLzBXWjE2MmtnR1ZaVzA5bFZPSjF1bzJibitmbFZ6SWRId1RVcVZh?=
 =?utf-8?B?amY1dmU1RDFnU1JiMzRJYm1HQ0p3NzdYNFgzSlY5c1h0Szc3M2NXZ1podXU2?=
 =?utf-8?B?ZlZFYllVN3ZhbWhicVNDOE9BSjVDTTdhY3NpNnNkTkZwdklzMEpMOVlMS3hy?=
 =?utf-8?B?dFlpR05OUEJiZ3NhcTVuSHBiZ0p1QkgwY2VWQzNHdGlXNzVGWmpOSEEwaUIx?=
 =?utf-8?B?aXBDYzExR09tRExSdWRySHUzMmQ0bmNXTytHZkpFaHVmRHQvYlpTUlhtcGhS?=
 =?utf-8?B?Ny9aOEl5cStyMnNFWUF1Q3FWREJORG5JbmRYaXpVdU9nZ3dQbG9kcjVjaXZM?=
 =?utf-8?B?T3J6Mys4Ykl6QmxyZFNlQmxjNWllcFFjUzZ6Rkh2QUJReDNCMjRXSGNFeElu?=
 =?utf-8?B?SkJuaTQzYm43U294Q3M2ekZZTGc2VDJNWFRPdHlJRkJBd1hDN3lwQ0UxQUJH?=
 =?utf-8?B?a2tHQVZCVEVNRGc0UlB2RWhRbEFYK1FySGFxdTlCRDZSMXVQbXdOUkJhaTZS?=
 =?utf-8?B?WjFLaUpiOXorK2FrTytjRVp6VzVScVg1UldsOVkyWlVZUnJweTBaNUpiVFNi?=
 =?utf-8?B?Rk50RUhLMVFpQTQ3eDJXZUtYcHIrbXMwQWU5dGJUQU5oMEliREQ5dlliOTNB?=
 =?utf-8?B?R0tmYkRBbFBpS2p5UVpqd0sySE5oM2FmY3NlUmx0bS9xUkN1UFZKR3ovUlVH?=
 =?utf-8?B?SDZGQVYxdDFnNEFadTd1R3EwMjllbEhBR2ZKRFNXb0hpQTE2dkx1MC9jUUZu?=
 =?utf-8?B?VXJBcGRjWTMzM2RyTGlPUmNCMVVOcm5RZW5lZW81ZWh0dmIwNkxHdWI0bnZK?=
 =?utf-8?B?dUZ0bUd3NmVqcStpNVRUdVpoOTNscExIK0t0Q0tFVERmQzgyclgremJ1ZG1Q?=
 =?utf-8?B?M3RNb3BvdHkwMGw5VTkzNTJIVHAvVmsrRS9yOWk1UkRNa2QyaDZhUzhGSHpX?=
 =?utf-8?B?TFd6Q2g3NjJ5bk11aHBPTEx2bzAva0xucFUraEpQaEpUUy9xRk1qMUZuOC9K?=
 =?utf-8?B?L2RwY05ob0xSeGMrZHM4cXFHUFpTRTQyRXBqWm5RNE9nSU9ERFZhT01hTFNv?=
 =?utf-8?B?M1RJMEtyMDdCYVNSZWxNcWgreWQxSDZiTzVreHNqMERzS0gwTWF2TDlzQ240?=
 =?utf-8?B?Q21HSjlucE1vY2pJYUdWSlJvU09XNC9TVXNEOXpscmNrWkpDbE9BMjBpNE16?=
 =?utf-8?B?MHllOGM4cU9YMkFxbGlSamRzUks3UG5EQ05YMlpqd0p2U3hXbzl1cUFXbERC?=
 =?utf-8?B?ZTYwMDVuQkR1Q05rOGR0QWc3ZEpabGNXc3VObGdWbzhadFZvQXI5b3dFWGYr?=
 =?utf-8?B?MjFoSWY0SGMwdTJXMnlCNXRMSmd1OStkQ2JqMjFqVUtXZ0lDMkJKempmc2Vu?=
 =?utf-8?B?ZlJidG5zY3dOWGtJazBXVGpvL3kxdjZyRkVVVXgyWUN5WnRjNFVDTFA0bXFQ?=
 =?utf-8?B?ZjZFdUlMcE1KbEpQTitpMVVtM2hGU0I1MDVQemI2cC9BTGYwdlZOaXpCVTNj?=
 =?utf-8?B?N1dqc2gvWGl4MjBUL2cxTnZEMklaY2ptUDFSc2UrRXU4UVZaUWF3TEdpbWpR?=
 =?utf-8?B?Wnp1dXVDczJkRmJmUmlQUEhGSjFRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16361dc-1724-4c22-abab-08dab07ca22b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 20:17:37.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpKKaAG5/S3KAB8doPUY7AEpDztLlFFmh3c+3inKRa2bU+EbOe1qRH9glZNpr6UFRiO8+t+VGEpYt6LllWEl/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5008
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/10/2022 10:36, Jim Lin wrote:
> On Wed, 2022-10-12 at 12:45 +0100, Jon Hunter wrote:
>> On 12/10/2022 11:25, Jim Lin wrote:
>>> Program USB2 pad PD controls during port connect/disconnect, port
>>> suspend/resume, and test mode, to reduce power consumption on
>>> disconnect or suspend.
>>>
>>> Signed-off-by: Jim Lin <jilin@nvidia.com>
>>> ---
>>> v2: Fix issue that wrong tegra->phys[] may be accessed on tegra124
>>> v3: No change on copyright
>>>
>>>    drivers/usb/host/xhci-tegra.c | 139
>>> +++++++++++++++++++++++++++++++++-
>>>    1 file changed, 138 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-
>>> tegra.c
>>> index c8af2cd2216d..996182a1959f 100644
>>> --- a/drivers/usb/host/xhci-tegra.c
>>> +++ b/drivers/usb/host/xhci-tegra.c
>>> @@ -189,6 +189,13 @@ struct tegra_xusb_context_soc {
>>>    	} fpci;
>>>    };
>>>    
>>> +enum tegra_xhci_phy_type {
>>> +	USB3_PHY,
>>> +	USB2_PHY,
>>> +	HSIC_PHY,
>>> +	MAX_PHY_TYPES,
>>> +};
>>> +
>>>    struct tegra_xusb_soc {
>>>    	const char *firmware;
>>>    	const char * const *supply_names;
>>> @@ -274,9 +281,17 @@ struct tegra_xusb {
>>>    
>>>    	bool suspended;
>>>    	struct tegra_xusb_context context;
>>> +	u32 enable_utmi_pad_after_lp0_exit;
>>>    };
>>>    
>>>    static struct hc_driver __read_mostly tegra_xhci_hc_driver;
>>> +static int (*original_xhci_hub_control)(struct usb_hcd *hcd, u16
>>> typeReq, u16 wValue, u16 wIndex,
>>> +	    char *buf, u16 wLength);
>>
>> Is it better to add this function pointer to the tegra_xusb
>> structure?
>>
>> Jon
>>
> Do you mean removing variable "original_xhci_hub_control" and save
> function pointer to the tegra_xusb structure ?
> 
> But that doesn't look possible over here to point to tegra_xusb
> structure and save pointer (to tegra_xhci_hc_driver.hub_control) into
> it.


Ah yes, this is in the init function and so we can't do that. Any issue 
with calling xhci_hub_control() directly in the function 
tegra_xhci_hub_control()?

Jon

-- 
nvpublic
