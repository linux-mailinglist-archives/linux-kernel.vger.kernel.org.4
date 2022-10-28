Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E38611512
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiJ1Orv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJ1OrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:47:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BA21FB78A;
        Fri, 28 Oct 2022 07:46:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMaxEqGGkKVh3Z+vKaDDw/I1sY/iR8FMuPdVXb06+DfsAvGgxAnWnFvtyn9oEfFOgpOnxZXPQbRp5n08UXa7CENDmNT8DaHjjqu8PmRPXOaNKrVYcnu04ouXmWjIh9Oa3xtfpiibCjikxM12ACeJehQSVH+FrmjCG2pUl37boBQMypa+8dfZi9lzoXQlwTv6TCUeTjExKdhL3aXQ3NM1uGifZtZdSPtZhUr4egPp5xCDE2SpcxvgfVRq2cq05dTLnHSaF7kNNP2S87WmYc0+bWTtFwafVjtaryLZ5RvRfFjm4A/qzMWzYohV68XFRAg3MoRnCXn1mdexBVe5lFYlVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTzvAp383YNQCzc6xK6AJqaoXkTrh+IOem8Bly39Xx4=;
 b=P3cTrebi1GpbsvC2mZDbElrX7FDZYoQfVpB2YK6SZFmvHD7T23eZoWySt8YdwhvfqX8scT6HZkh2GCgWhx2FMDSlLAbeNursbX6/ECI575C61xpMqhhH6ZAW9DG/EnkNGXjSOOVkvMs5xDnGwld/I674OHd0z3jh7ZscOABhL+oP/nedRxZEdeJWwpr06u7nID+qBOsW8rtjCdaSxi5bWcY/ug8mD556sw73fE/Zylt4h2vKhx5QkdPlntBj0t2Gm6VmKATWY71S5cjladn3OtdSWznjoNqk75YK+nXd+T4WBbatLD9MTal/RtB9NlFJmiZ3AlRKJKBLLMYk5DSnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTzvAp383YNQCzc6xK6AJqaoXkTrh+IOem8Bly39Xx4=;
 b=x2TY+KI8oXBtNHfI06KhuXBLgaKFrVpGW2l0NybFDuRz0t1EY0v4QCYftWAwA7UK2Tu212FXXoJFhDT4zDJqm4u0ulPXk0e8jfLirUYdnOB17Ql3NY/7OxZw++VWaKzfyFyXDWu8GXw3G1GI5GRBJkNt4NiXscbGuds8LUvW8wM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.15; Fri, 28 Oct 2022 14:46:37 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::191f:7d6:2182:dc89]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::191f:7d6:2182:dc89%5]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 14:46:37 +0000
Message-ID: <b39809c0-69d1-1647-a61f-737e66e021f2@amd.com>
Date:   Fri, 28 Oct 2022 09:46:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 3/5] cxl/pci: Discover and cache pointer to RCD dport's
 CXL RAS registers
Content-Language: en-US
To:     Ariel.Sibley@microchip.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
References: <20221021185615.605233-1-terry.bowman@amd.com>
 <20221021185615.605233-4-terry.bowman@amd.com>
 <MN2PR11MB3645BDC3B58C198BDB9B7B0888329@MN2PR11MB3645.namprd11.prod.outlook.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <MN2PR11MB3645BDC3B58C198BDB9B7B0888329@MN2PR11MB3645.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0003.prod.exchangelabs.com (2603:10b6:805:b6::16)
 To DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MW3PR12MB4441:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cfc57c-f4c7-418d-4054-08dab8f33714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2k38yYOY3qHTNE+mqjkcgLV+nmFN9vx/IN+yscZLcbngUxHll473wvGMoZdCc9l1yUVds9sYY+/q0/9YxiE7Ik+5cu3hCssOzGZIEY4x24JAjDBYBetlrJ6eED+Jv6kpsWPtyCermU9iKnrM+kW5pLshVjgSv6Lanyw+WEwXfscfIbhH8690FjxjAeeFgkRZVI5UYcIG5MjekkAgzNRFk9ChfqAQtZrSx/7lzbmsvriWvRXxnr31eHFN+/DDMjLCu+aSpMkgjrHNT64ZM/yOAfYlaSCmdsZl/V+ZM6AJYs4HElc5F4EMTw+4hY9l/CHyoordT6HVi3L1DyE/LyCF4N2cLtqaOU1bapOzVW5u+HI4WJkxdtV60JfE//zq0sQuV7yl6AkG7VIZusPv4wv3hy3GetENjr+9bQ4szVD5ltisCKLpRX+o6RQ0g8Fsy0ZmN06Phhejw7Ka/Fts5cpTjYNPN6VcODSA494IEldtZBRw8aMG8TD6n859nQBnBHrT4aLtWYmLk3qdhakuac04219dytYERrNuG39XeWxE/7iiE98mHqJ/psbadI4ssze/OWCpVwgJFiuIoKwoAmhTEmIwLKfCciksOsXLKJTJN9X1J2fySfLBqCESbNwWguqLAOWcjmVivdBy81ZJdhaGIWIp23SGBImMWjIXNiQd1YP3HYQHEB6gMT5fL1z0ZHvO3cVfMXS+V5Z+TsaUF9at+80S4mN0ViGIe7T85MdcwNTHvYDkV4sq+4/fHM5zjnpVQEHcgek6T99RTM6HDDwhsDTvb7Wa/WjzFP8/GShLCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(83380400001)(86362001)(38100700002)(7416002)(2906002)(5660300002)(31696002)(66946007)(4326008)(66556008)(66476007)(8676002)(41300700001)(8936002)(6506007)(6666004)(2616005)(186003)(6512007)(316002)(53546011)(6486002)(478600001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGVnM3oxdFZXTkgvRDY3cFR6aG8zNVJiWXp0UjAwYlhQclZsRnJPb01RZVNR?=
 =?utf-8?B?N05TcmNaZTBHcFhNZkVyY0o0NCtWRncwSFFkM254dC9DMjNHUFpScVM0UW5V?=
 =?utf-8?B?dE10cC9nbVBzbFBrL2FZSWh2Z3pvWjE4aWtGTTJjYmV0dW9PTTNDR1NSQnlD?=
 =?utf-8?B?M3hhd0t5UFl6N1JvUlRlVWZqMk1YdjhXRjJ1T3JDYjdQWjVkaStRVllFODJ4?=
 =?utf-8?B?RXc4OXcyUnY5Nk5CcU41ek5PUHRNY2VWM2JOTTUxdEtVdTVsMHRJUFhYSXJY?=
 =?utf-8?B?S05tVEduNXRuMlZyekRHeGRrR09UZmE4WVFLcjdVcGJyNmtFRlFSN01JT2Vt?=
 =?utf-8?B?RFBnVVdpT0FIaTRPdE40OURTR1ZyWmsxUHJWT1Q2elhuNWc3OFJwUHJ1TmhH?=
 =?utf-8?B?WnoyMy9xNXN2eHY5RlBJR0pCRXgzME52Y0ZrV0N6cjRCcnlEQUVKZ0NGL3Z6?=
 =?utf-8?B?aDBRWnB1Uk55VHFMdjBYTDFVWWhrMCtQbkJLa2xvTStoZ3MwMUxIOWZDUFNU?=
 =?utf-8?B?Uit1dG5rcHBjaEVCRy9FU2ZsQWFkM0ZhQVhDci9MK0c4TlBmbmZBdG1aVFEr?=
 =?utf-8?B?US9DZjJEaUgzMnF6bDBTRmV5MDdkaDF1a0ZEb2I2WTBtREhsK1FGWFVLZ1Bu?=
 =?utf-8?B?dUZsYjFadDFjb2srR2Z4bzBESXMxdDBTNjJSRE5id3FMSWdsZnJwQlBnb2tG?=
 =?utf-8?B?S0psYjBVU0gyTzcwanUzaEVncG9EVXFiMkRtRGJxc3BNQk9JT0VJbUFtR2xw?=
 =?utf-8?B?aDF3T01vZkxGcHlnRzJnSzJHUEgvejVBUzMrVXhGODZCN2Zsa1JQODJESVhi?=
 =?utf-8?B?bU9XVzUvSVMyUlQ5SHhOYWh3Q0RML3VoL0ZNQXZkRmxpVmc2RU9MSWpPV2ZW?=
 =?utf-8?B?anh0cTBTS3E3Ui84RkxtYzhHRGREOU9JL0JwVFdJTENBQWxIQUZFb0R3WlJq?=
 =?utf-8?B?V3p5SkFWbHZTYmhVWUxpMzhDekZnNHo2S3VmMEgyQzYzaEhiTFB0eUtSZmV0?=
 =?utf-8?B?TmFZaVQrR2JZT1ZkcW5HUjlpYXRpeTJtdzBtd3BZci9zaERjbzROVCs2a0Zv?=
 =?utf-8?B?YUp5QVVQZVFjaVFYMENqWlZxUTJBRmd1aG5MNkl5M0ZPOUhHUWd3cjNoaVJm?=
 =?utf-8?B?aWZQdVpJT2RhWDdYTDNLMGc1NlgrRGhFYjFUUWQzQzVGSlB1Q2ZUZ1c1dFMy?=
 =?utf-8?B?dEJtcThEb1UydHRiTGtJQmdoVFdvKzdYdmptZWQyTXdqc3UwNEV6LzdnUStC?=
 =?utf-8?B?YXBOU2dyTnFtVWRDRHZzUC94ZUlGaXBDc0NwTXcxdnFtd3ExWXJGaXp3VXEv?=
 =?utf-8?B?UTVOcUVtbWhkcVB4Wm45QnFIblNycEJQZUVLNnA5VTBFRVNZd05EbzRMSUNS?=
 =?utf-8?B?dVZMbGdvN3dOdWVBdUlZWEVmR0p0SjFEZDNXWVpYZzhMTDFhdzd3S1d3RTFr?=
 =?utf-8?B?d1JsTUhOVkNDZEVXQWpYb2RySFdmVkFGRWI0dlNLaDBJcmJCVVVOR3RMMUk4?=
 =?utf-8?B?alRNb01JeFN1RGtLSjF0Q0kyamJiTDBmenNEZVllMEpzRmVtYll6WmVpeHpL?=
 =?utf-8?B?c2tiODVDWTMzUU9HTDZVRU5rc0poUEo5VW5RREYraGxBa0Vob0hKcFltLzV6?=
 =?utf-8?B?SXJZQVJLdFdza2FkQllXMEdXYzFJMmQvU0pjd2YybElBejd6NDhRaXpXYlRl?=
 =?utf-8?B?YXo3S0FjQ2tzcnhFVFRQMGF1NE1TNmZpYXF4VW5MR1pRTlZCWmFPYmNuVlNR?=
 =?utf-8?B?VFZ5MGl5a3JBZ3NwWW5pbk1lOUNqdUJ5Z2VBYS9LWU5uWEY5M3FiWU5DU251?=
 =?utf-8?B?dlpJK291MVNvK1RhN1FjWjViRWFOYU9XV1czUzNnWXJMRHo0a1F1SXZvTDZY?=
 =?utf-8?B?eVFyblIxcjkyZ25ORnIzOVRQbldzQURpRUVKZmtxRXpMeFhIbUo0N1ZwZ0I3?=
 =?utf-8?B?Y0NiZEdrTlNCZ0dGdXBJMUtCOVR5b2h0dGZteVpFL2c1dlZVSEw3aEdEaml1?=
 =?utf-8?B?WGpTR2F0RmY1L3o2ZHNKTWlocVo1Ym95ZVdjU2FuTGVBOTdkMENBUGE0aWsy?=
 =?utf-8?B?RnphaGFkam44YWJrbm91R1NwdW9vbUJvcVo4RGRRVWY2RklqeDdnSUdmUVpi?=
 =?utf-8?B?bldYMGIzUWxaOFdSamVBbm5pVzA2Z3pDYkJKalpuRFVqOGVkZHpsbUNxUDdy?=
 =?utf-8?Q?SFuD+oxxSEsmmrsrX8DUheXcNcMx3PfQbko+IKoS8kIM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cfc57c-f4c7-418d-4054-08dab8f33714
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 14:46:37.1045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZBHDekuRHq9P1SSsMWxL3AvDAoQDEhbxc2k6iNa9h7bVF1eF0H1iqKWJ4mv7Titf312CbFoFKvE4nhJSHJGMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ariel,


On 10/28/22 07:53, Ariel.Sibley@microchip.com wrote:
>> -----Original Message-----
>> From: Terry Bowman <terry.bowman@amd.com>
>> Sent: Friday, October 21, 2022 3:56 PM
>> To: alison.schofield@intel.com; vishal.l.verma@intel.com; dave.jiang@intel.com; ira.weiny@intel.com;
>> bwidawsk@kernel.org; dan.j.williams@intel.com
>> Cc: terry.bowman@amd.com; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org; bhelgaas@google.com;
>> rafael@kernel.org; lenb@kernel.org; Jonathan.Cameron@huawei.com; dave@stgolabs.net; rrichter@amd.com
>> Subject: [PATCH 3/5] cxl/pci: Discover and cache pointer to RCD dport's CXL RAS registers
>>
>> CXL RAS information resides in a RAS capability structure located in
>> CXL.cache and CXL.mem registers.[1] The RAS capability provides CXL
>> specific error information that can be helpful in debugging. This
>> information is not currently logged but needs to be logged during PCIe AER
>> error handling.
>>
>> Update the CXL driver to find and cache a pointer to the CXL RAS
>> capability. The RAS registers resides in the downport's component register
>> block. Note:RAS registers are not in the upport. The component registers
>> can be found by first using the RCRB to goto the downport. Next, the
>> downport's 64-bit BAR[0] will point to the component register block.
> 
> I realize this patch is for dport only, but regarding "Note:RAS registers
> are not in the upport.", the upstream port also has RAS registers.
> 

Correct. Thanks for pointing this out.

> Per CXL 3.0 Section 12.2.1.2 RCD Upstream Port-detected Errors:
> "1. If a CXL.cache or CXL.mem logic block in UPZ detects a protocol or link
> error, the block shall log the error in the CXL RAS Capability (see Section
> 8.2.4.16)."
