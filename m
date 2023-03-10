Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3926B3E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCJMAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjCJMAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:00:35 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA35BAEFF;
        Fri, 10 Mar 2023 04:00:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnPv2ZWrMDudbMYlxApeQNGnf6sZwtZnQJtHu9VziTscO4PCcIe/H/lQgtQb+bEdvb7hYzwInJZ3uQ6bGvix7auBhfL5PLRxzo1xIStqusEk1TJpFumsFx9E5QjLrU6HqXj4jcdg7yHq34MYPDDKlT+y5DphsD1TBCxh2id991em3Cj2TfwbmH6L9Y+dr7nBspR8R1IKo1fnHQ/1XDhSWw1zAS8uSlLlecNzCUTnM829LHOkpCjHYd2HqSC2u3H0GVpj2L1bu/K84FCuqLbmILNJKonPub6on+Ff2P15SsZKEpv1e7mfv8G3sEwWwfq12egvNX20MGYou57M5OuWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Xa78VU/iWug8RQI9Xv9o91JfY+QKT0PYej0jgkWCkM=;
 b=IpklbLzC78rvO3HZuPJvCmgI87qfayCiNhf3cGiSJIu/OpWGzSKm/qoSjvKh+vn7gq8H8hKOwxxt3eUhX3DvW75a3sNJMJJbL5kBKTVzJnKFE4pqJ4hefo5Kz8ZpU7F2Vnkdp7TeqLdy0NV83SQM8nqOl8kg1KRXXGiIcm+4MEA8ii3vrV894tGKFpC+pZA8MsA0rQg0Ra+9d98YMpZf9SJBZA/bFc36uR6deWAZYLT5dYlNMX7CyP6Yog3xwEsOxUYYuT5HmDicdK5SWSE4+V6LSdbmRmpGbfY1zLt6A9AgcappnVAyn2/AdgBSxGhZMyuEPIxMRj3Da7Sd3wFSFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Xa78VU/iWug8RQI9Xv9o91JfY+QKT0PYej0jgkWCkM=;
 b=UTGNwUQ4eBnbPWn95CUOu9Dy/lHyNlf5oCXOwKY/Q2ba4STy6aAQnmN4nKVAUQpD+6HWYEQ6Bj+PkbUz6ZSePpE54T91HnwzB6nLDZa3B1Tnn2nKX0c3z3wb7I4AI8sKFl0SDMho4//1N7dTKENgv6G4rFk3X9f7X2jnObx5+aI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 12:00:29 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::8d69:5417:b5e9:92a1]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::8d69:5417:b5e9:92a1%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 12:00:28 +0000
Message-ID: <65fe6e54-e676-cbc5-062d-d1525bd8eda2@amd.com>
Date:   Fri, 10 Mar 2023 17:28:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v9 7/7] cdx: add device attributes
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        saravanak@google.com, Michael.Srba@seznam.cz, mani@kernel.org,
        yishaih@nvidia.com, jgg@ziepe.ca, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
        masahiroy@kernel.org, ndesaulniers@google.com,
        rdunlap@infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, okaya@kernel.org,
        harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, pieter.jansen-van-vuuren@amd.com,
        pablo.cascon@amd.com, git@amd.com
References: <20230307131917.30605-1-nipun.gupta@amd.com>
 <20230307131917.30605-8-nipun.gupta@amd.com> <ZAnZNEgA/6pXhj7g@kroah.com>
Content-Language: en-US
From:   Nipun Gupta <nipun.gupta@amd.com>
In-Reply-To: <ZAnZNEgA/6pXhj7g@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::15) To DM6PR12MB3082.namprd12.prod.outlook.com
 (2603:10b6:5:11b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3082:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 59123dbd-364d-47b5-be5d-08db215f0a3c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s32wG98TEvqrSfdGBdLYZBSwJDsHAbPRSgGkSDMC25KI2VnvXbbrnqzz2F3lCRhELR2D6jE38hvNcwuDp5GCRMCliXfjl4hNVnkERrs+bSRIcb973lS9FrtGFcMKf1NGTnZkrim1sXSlZ9tDOnynd8og0USNRCsR8Sus3FqR73eGbyAaaKp6UXxsjNlDg3ajWSHDXkUo2earVQHdCHW5leMjRhzW4yQV5NWyPquHwROCOR6AgCpjw/tObvc77eoMOHJWFH6YACNnXuvtO+StHbbsoifYPD+l9RUOdFBD7PlXaVdy/JtDuBDNmYyN5PxaT4vLZJvHN2/aCIsx8HnXKUfWwPQyihAJDiAj9DY+34CC9lhFhrDo2RFMxftFjXVFRcjMtFqiONuaoc2DmIdwG1plEavFAJhZOzYSCV3/68/oIjLfb+sIWUbjWcygYTArn/BITqA8ssJJZvLAa7Hj8vwm3duXkV9GPQKRfqopIVvjIZrsu/W8Iq5WqOrAgVJG3qmuCUrmobmyU7YXGQutizeqDnpfcrZz3ICACQm0uxnSUjWAo+4Nh69X/fkCWfS8f9ZTItE2ya8UmpuRP2Pfku4buZiBILJCoEQvwUAXyPGQ1VIY3uCWwHHrJdB62brwxqJ5PsYwy3OJVllcDdhuHN+gUrdeU5tie2iDKPvdjt6U5zCkmnmjN9FhfJxEGPhcSqfBZteAlCSYOgNJIkTv0xikswyUOPT+91XQQTZqhQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199018)(66476007)(66556008)(8676002)(6916009)(4326008)(31686004)(41300700001)(316002)(66946007)(5660300002)(30864003)(44832011)(6486002)(2906002)(7406005)(7416002)(53546011)(6512007)(26005)(6506007)(6666004)(2616005)(186003)(8936002)(478600001)(36756003)(86362001)(31696002)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czVYZDdmUTdVbmdFR0EwWlZZS1NUVFM0c1N0T2VVUGdnaHBUNlNHa3VMbExj?=
 =?utf-8?B?WHI0UVQwaHdsUEhKVHcxd3grL2lYWXNIOU9OR3pkSjdiQWE4YU0rcDNhNXdQ?=
 =?utf-8?B?cm1McEt3azJ3cEtBaE1oRE1NSXFJY1BCMUFzODA0OUJ0VnJSbXR6akhyZjRk?=
 =?utf-8?B?SzdHM1I5b0R5dWJ1OGxxOVRqY09LV01OWFlhVkZRQzZBQ3I4QXhHKzJFK0Rj?=
 =?utf-8?B?dHVGMGpkUUxlUTF1bXV6WUFOODNESEJhNlBxdko2eDd0dlZGeUhIczYvVmR5?=
 =?utf-8?B?SGFPYjRSTi80dUR6a25CY28yb2JhbWtydkkyeWxmWWxQajBiYkw5QlF4cFIw?=
 =?utf-8?B?V3MvN1RPL2Y2M3ZMVmcvT2dpVlBKSmVOb0Nsb0xtRHJ1dlB5K3R3bU9CTmpE?=
 =?utf-8?B?YXhCRlJoQWx0eXNINmt5Z1M0STI4dUZkMVFtUjh3Mllid1pLUjJQUHQydmpO?=
 =?utf-8?B?SnVrSUp1MXFNMThqZjFzWEE0VFNJc2lHN1lpazBNYi80QXpyNkRUU3VvQXZo?=
 =?utf-8?B?dzNYWTRWZDB3d2xhV0wyV3Q0eEhvdUFxSW9VckNCaUxDSUpvUFBCU1F2c3JQ?=
 =?utf-8?B?dndLUnBxZ1gyVDlQVnh4RHIzUU05Z3BSRTFUZ0NuVjR2YjRqdnc0ZHVHdmdi?=
 =?utf-8?B?U2hnZXpoQ1NaUnlyRE5wVUVXb3pNZVBpbjBLRmxVZ2t5QkRGUlpzOVI3M3J3?=
 =?utf-8?B?aUk4dDVHV0dNNkZUcTM1MlhQbkVPdDl0blhDWGo2WWh1M2wyRWxTTFFUSnQ2?=
 =?utf-8?B?SDkvVnNIWjN6U3cwYkZNVmR3dGxPcHNFWGZtUVhJOXI3aTF0cGZBOFV3d0lB?=
 =?utf-8?B?anM3SjFjSTNzQ2FjaXQwMmlrdW1QeFhITTJEVTVZdGQ1UFNNWncrazNXUUJi?=
 =?utf-8?B?U1VjRURia1o0VjJUZGxBd1FjOEtBeGRPcmIvRFo4UUhMcFlUbllZU0VJMWVV?=
 =?utf-8?B?K2d4eVFHMm4vcTRjQ3N0NlJ1QTZ5akMyaGptcGNoNnk4NWtiQkdMcVFxM3Jw?=
 =?utf-8?B?QkliWVlzWStiVWF0MWc5TTZKVGV0UGExOEg0VlMrZTA2YjdkSjFNQ2hKSG5N?=
 =?utf-8?B?THZ6eTNoYzJ0cW14SjBaN2l5d3czTlVvbVZ5Z0g3bDIyL2JaWGU0Q3NUWXBv?=
 =?utf-8?B?RWxyVlR4bldMSUk3TG5RMGduSVJwdGRaejRPV2EzRXNJZHpwT040N2E0cjRw?=
 =?utf-8?B?Yk9BRW5HekpFRnRVaHY1cCtFUXo1STU2MU95MU9COEZMR2ZjVnFSMy9Ea05P?=
 =?utf-8?B?TXNkQ0hOL0w3MlNmcms3a2Q2b0dUWGoxODBUWjFDSHpOWDA3VkJPSU16SitL?=
 =?utf-8?B?NEdqTkxpbjh0RXU1UWhkWjIwRzFrSUJ5dDdXR2w5YTFmYlliSmZjRkJlNnhr?=
 =?utf-8?B?UXR0cVVFeGpNWGtNMFVVZnJ3MmJIamhJaWQ5ZWUrd1Y3UkRkT3d0aE9sN29T?=
 =?utf-8?B?Y1F1d3dRZFNZUnBSODlybEF5Zm5ycWd1YXFiQm4xcFZKTGQzYjM0SnAycGR3?=
 =?utf-8?B?SWVtTnRXMFdwaUQ4eFNxdHFqQ2l3QlovWVlWR2RlSWw3eDIxbTJVTGRIcHFS?=
 =?utf-8?B?aUYvdkZZVDNzeWpFUkxMYVRJR0N2dWtIV244RFhNNTd2QklhVCtTckQ0bmdS?=
 =?utf-8?B?OWdIbTBZOWN6VnlkVW5hUC9zcGM2TzNFZmEwWXV3ZHlyYVBGVEdFYjZTR05p?=
 =?utf-8?B?RzhocnhWUHZvaW0wWkdITlVOc1h6UDVIMWFVZStlaUNva2x6MnhRTHJaUjdP?=
 =?utf-8?B?aTU5SVJMVytiVmZGbktINDhkYUxvYWZNMWk0S3N5Z1kzdDNoUXF2YlMvNFc1?=
 =?utf-8?B?RVg1eHZPS1dIZXJjblJhV1RDSmhrc3BScnh0M0dSbCt4V3M1Vk1Yc3ZwT1ZL?=
 =?utf-8?B?RGZyZ0hPQ1RXT25sNTBsOW1NWjlrYWdmS3ZVSUJ4NWpJb29IVk5KUmJZMlJa?=
 =?utf-8?B?RS9iNVdJUHlHMGlZc2g1ajVlUEJMUE9pWW5ybUZRNmhQbWFPbXhGa0tZejhO?=
 =?utf-8?B?VE0zSGU5VzJub1hDMGpCT1l6WDlHakVEQVBIbzQyL1p6Zlc1VDlWSHY1TzBR?=
 =?utf-8?B?WnRmUUpWMGhkaExHLzdqcHBiSE82K0Q3ZG5FNk9DM0FzajI5VGdmLzVBN0dJ?=
 =?utf-8?Q?m4yg1r2RYD8jb7rwSg4DtM95P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59123dbd-364d-47b5-be5d-08db215f0a3c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 12:00:28.6357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6samXzKExj2QYVFgXfxWNCvxtEV2zUC3vs/POIz06CPZxD0wjBSBCgRb/rFs/lv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/2023 6:33 PM, Greg KH wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, Mar 07, 2023 at 06:49:17PM +0530, Nipun Gupta wrote:
>> Create sysfs entry for CDX devices.
>>
>> Sysfs entries provided in each of the CDX device detected by
>> the CDX controller
>>   - vendor id
>>   - device id
>>   - remove
>>   - reset of the device.
>>   - driver override
>>
>> Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>> Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
>> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
>> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>> ---
>>   Documentation/ABI/testing/sysfs-bus-cdx |  44 +++++++
>>   drivers/cdx/cdx.c                       | 145 ++++++++++++++++++++++++
>>   drivers/cdx/controller/cdx_controller.c |  19 ++++
>>   drivers/cdx/controller/mcdi_functions.c |  14 +++
>>   drivers/cdx/controller/mcdi_functions.h |  11 ++
>>   include/linux/cdx/cdx_bus.h             |  27 +++++
>>   6 files changed, 260 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
>> index 063d1a0dd866..c553ce3a449a 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-cdx
>> +++ b/Documentation/ABI/testing/sysfs-bus-cdx
>> @@ -10,3 +10,47 @@ Description:
>>                For example::
>>
>>                  # echo 1 > /sys/bus/cdx/rescan
>> +
>> +What:                /sys/bus/cdx/devices/.../vendor
>> +Date:                March 2023
>> +Contact:     nipun.gupta@amd.com
>> +Description:
>> +             Vendor ID for this CDX device. Vendor ID is 16 bit
>> +             identifier which is specific to the device manufacturer.
>> +             Combination of Vendor ID and Device ID identifies a device.
>> +
>> +What:                /sys/bus/cdx/devices/.../device
>> +Date:                March 2023
>> +Contact:     nipun.gupta@amd.com
>> +Description:
>> +             Device ID for this CDX device. Device ID is a 16 bit
>> +             identifier to identify a device type within the range
>> +             of a device manufacturer.
>> +             Combination of Vendor ID and Device ID identifies a device.
> 
> Are these printed out in hex, decimal, octal, binary, something else?
> Please be specific.

These will be printed in hex. Will update this as suggested.

> 
>> +
>> +What:                /sys/bus/cdx/devices/.../reset
>> +Date:                March 2023
>> +Contact:     nipun.gupta@amd.com
>> +Description:
>> +             Writing a non-zero value to this file resets the CDX device.
>> +             On resetting the device, the corresponding driver is notified
>> +             twice, once before the device is being reset, and again after
>> +             the reset has been complete.
>> +
>> +             For example::
>> +
>> +               # echo 1 > /sys/bus/cdx/.../reset
> 
> Don't do "non-zero", make this explicit.  This implies I can do "echo X"
> and it will work, do you want that?

We will update sysfs implementation to use kstrtobool and update the 
description accordingly.

> 
>> +
>> +What:                /sys/bus/cdx/devices/.../remove
>> +Date:                March 2023
>> +Contact:     tarak.reddy@amd.com
>> +Description:
>> +             Writing a non-zero value to this file removes the corresponding
>> +             device from the CDX bus. If the device is to be reconfigured
>> +             reconfigured in the Hardware, the device can be removed, so
>> +             that the device driver does not access the device while it is
>> +             being reconfigured.
>> +
>> +             For example::
>> +
>> +               # echo 1 > /sys/bus/cdx/devices/.../remove
> 
> Again, not non-zero.
> 
> Please use the built-in sysfs function to handle yes/no values being
> written to sysfs files for this and only accept the "yes" value.

Sure, will update accordingly.

> 
>> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
>> index c981232486dd..0c4f300373e5 100644
>> --- a/drivers/cdx/cdx.c
>> +++ b/drivers/cdx/cdx.c
>> @@ -71,6 +71,39 @@
>>   /* CDX controllers registered with the CDX bus */
>>   static DEFINE_XARRAY_ALLOC(cdx_controllers);
>>
>> +/**
>> + * cdx_dev_reset - Reset a CDX device
>> + * @dev: CDX device
>> + *
>> + * Return: -errno on failure, 0 on success.
>> + */
>> +int cdx_dev_reset(struct device *dev)
>> +{
>> +     struct cdx_device *cdx_dev = to_cdx_device(dev);
>> +     struct cdx_controller *cdx = cdx_dev->cdx;
>> +     struct cdx_device_config dev_config;
>> +     struct cdx_driver *cdx_drv;
>> +     int ret;
>> +
>> +     cdx_drv = to_cdx_driver(dev->driver);
>> +     /* Notify driver that device is being reset */
>> +     if (cdx_drv && cdx_drv->reset_prepare)
>> +             cdx_drv->reset_prepare(cdx_dev);
>> +
>> +     dev_config.type = CDX_DEV_RESET_CONF;
>> +     ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
>> +                                   cdx_dev->dev_num, &dev_config);
> 
> You configure something off of the stack?  Is that wise, it contains
> loads of invalid stack-provided data, how does this work at all?

For reset it is not using any data and checks only the flag, but yes it 
makes sense to memset to zero before passing to dev_configure.

> 
>> +     if (ret)
>> +             dev_err(dev, "cdx device reset failed\n");
>> +
>> +     /* Notify driver that device reset is complete */
>> +     if (cdx_drv && cdx_drv->reset_done)
>> +             cdx_drv->reset_done(cdx_dev);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(cdx_dev_reset);
>> +
>>   /**
>>    * cdx_unregister_device - Unregister a CDX device
>>    * @dev: CDX device
>> @@ -237,6 +270,117 @@ static int cdx_dma_configure(struct device *dev)
>>        return 0;
>>   }
>>
>> +/* show configuration fields */
>> +#define cdx_config_attr(field, format_string)        \
>> +static ssize_t       \
>> +field##_show(struct device *dev, struct device_attribute *attr, char *buf)   \
>> +{    \
>> +     struct cdx_device *cdx_dev = to_cdx_device(dev);        \
>> +     return sysfs_emit(buf, format_string, cdx_dev->field);  \
>> +}    \
>> +static DEVICE_ATTR_RO(field)
>> +
>> +cdx_config_attr(vendor, "0x%04x\n");
>> +cdx_config_attr(device, "0x%04x\n");
>> +
>> +static ssize_t remove_store(struct device *dev,
>> +                         struct device_attribute *attr,
>> +                         const char *buf, size_t count)
>> +{
>> +     unsigned long val = 0;
> 
> Why initialize this?

Agree, will remove.

> 
>> +
>> +     if (kstrtoul(buf, 0, &val) < 0)
>> +             return -EINVAL;
> 
> As mentioned above, just use kstrtobool() instead, don't mess around
> with unsigned longs, that's not needed at all.

Sure, will use kstrtobool().

> 
>> +static ssize_t driver_override_store(struct device *dev,
>> +                                  struct device_attribute *attr,
>> +                                  const char *buf, size_t count)
>> +{
>> +     struct cdx_device *cdx_dev = to_cdx_device(dev);
>> +     const char *old = cdx_dev->driver_override;
>> +     char *driver_override;
>> +     char *cp;
>> +
>> +     if (WARN_ON(dev->bus != &cdx_bus_type))
>> +             return -EINVAL;
>> +
>> +     if (count >= (PAGE_SIZE - 1))
> 
> And how can that happen?
> 
> And why does the page size matter?

Looking at the latest code, there is driver_set_override() defined which 
can be directly called here. It internally does the check on count. I 
will update the code to use driver_set_override() API.

> 
>> +             return -EINVAL;
>> +
>> +     driver_override = kstrndup(buf, count, GFP_KERNEL);
>> +     if (!driver_override)
>> +             return -ENOMEM;
>> +
>> +     cp = strchr(driver_override, '\n');
>> +     if (cp)
>> +             *cp = '\0';
>> +
>> +     if (strlen(driver_override)) {
>> +             cdx_dev->driver_override = driver_override;
>> +     } else {
>> +             kfree(driver_override);
>> +             cdx_dev->driver_override = NULL;
>> +     }
>> +
>> +     kfree(old);
>> +
>> +     return count;
>> +}
>> +
>> +static int cdx_configure_device(struct cdx_controller *cdx,
>> +                             u8 bus_num, u8 dev_num,
>> +                             struct cdx_device_config *dev_config)
>> +{
>> +     int ret = 0;
>> +
>> +     switch (dev_config->type) {
>> +     case CDX_DEV_RESET_CONF:
>> +             ret = cdx_mcdi_reset_device(cdx->priv, bus_num, dev_num);
>> +             break;
>> +     default:
>> +             dev_err(cdx->dev, "Invalid device configuration flag\n");
>> +             ret = -EINVAL;
> 
> Can userspace cause this to happen?  If so, please do not allow it to
> spam the kernel log.
> 
> If not, who will see this error?

User-space cannot cause the default case to be hit, and yes you are 
correct this case will not be called from anywhere. I will remove the 
error print from the default case.

> 
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>>   static int cdx_scan_devices(struct cdx_controller *cdx)
>>   {
>>        struct cdx_mcdi *cdx_mcdi = cdx->priv;
>> @@ -104,6 +122,7 @@ static int cdx_scan_devices(struct cdx_controller *cdx)
>>
>>   static struct cdx_ops cdx_ops = {
>>        .scan           = cdx_scan_devices,
>> +     .dev_configure  = cdx_configure_device,
>>   };
>>
>>   static int xlnx_cdx_probe(struct platform_device *pdev)
>> diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
>> index 012b52881dd5..0158f26533dd 100644
>> --- a/drivers/cdx/controller/mcdi_functions.c
>> +++ b/drivers/cdx/controller/mcdi_functions.c
>> @@ -123,3 +123,17 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
>>
>>        return 0;
>>   }
>> +
>> +int cdx_mcdi_reset_device(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num)
>> +{
>> +     MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_RESET_IN_LEN);
>> +     int ret;
>> +
>> +     MCDI_SET_DWORD(inbuf, CDX_DEVICE_RESET_IN_BUS, bus_num);
>> +     MCDI_SET_DWORD(inbuf, CDX_DEVICE_RESET_IN_DEVICE, dev_num);
>> +
>> +     ret = cdx_mcdi_rpc(cdx, MC_CMD_CDX_DEVICE_RESET, inbuf, sizeof(inbuf),
>> +                        NULL, 0, NULL);
>> +
>> +     return ret;
>> +}
>> diff --git a/drivers/cdx/controller/mcdi_functions.h b/drivers/cdx/controller/mcdi_functions.h
>> index 6bf5a4a0778f..7440ace5539a 100644
>> --- a/drivers/cdx/controller/mcdi_functions.h
>> +++ b/drivers/cdx/controller/mcdi_functions.h
>> @@ -47,4 +47,15 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
>>                            u8 bus_num, u8 dev_num,
>>                            struct cdx_dev_params *dev_params);
>>
>> +/**
>> + * cdx_mcdi_reset_device - Reset cdx device represented by bus_num:dev_num
>> + * @cdx: pointer to MCDI interface.
>> + * @bus_num: Bus number.
>> + * @dev_num: Device number.
>> + *
>> + * Return: 0 on success, <0 on failure
>> + */
>> +int cdx_mcdi_reset_device(struct cdx_mcdi *cdx,
>> +                       u8 bus_num, u8 dev_num);
>> +
>>   #endif /* CDX_MCDI_FUNCTIONS_H */
>> diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
>> index d134e0104724..35ef41d8a61a 100644
>> --- a/include/linux/cdx/cdx_bus.h
>> +++ b/include/linux/cdx/cdx_bus.h
>> @@ -21,8 +21,20 @@
>>   /* Forward declaration for CDX controller */
>>   struct cdx_controller;
>>
>> +enum {
>> +     CDX_DEV_RESET_CONF,
>> +};
>> +
>> +struct cdx_device_config {
>> +     u8 type;
>> +};
>> +
>>   typedef int (*cdx_scan_cb)(struct cdx_controller *cdx);
>>
>> +typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
>> +                                 u8 bus_num, u8 dev_num,
>> +                                 struct cdx_device_config *dev_config);
>> +
>>   /**
>>    * CDX_DEVICE_DRIVER_OVERRIDE - macro used to describe a CDX device with
>>    *                              override_only flags.
>> @@ -39,9 +51,12 @@ typedef int (*cdx_scan_cb)(struct cdx_controller *cdx);
>>   /**
>>    * struct cdx_ops - Callbacks supported by CDX controller.
>>    * @scan: scan the devices on the controller
>> + * @dev_configure: configuration like reset, master_enable,
>> + *              msi_config etc for a CDX device
>>    */
>>   struct cdx_ops {
>>        cdx_scan_cb scan;
>> +     cdx_dev_configure_cb dev_configure;
>>   };
>>
>>   /**
>> @@ -101,6 +116,8 @@ struct cdx_device {
>>    * @probe: Function called when a device is added
>>    * @remove: Function called when a device is removed
>>    * @shutdown: Function called at shutdown time to quiesce the device
>> + * @reset_prepare: Function called before is reset to notify driver
>> + * @reset_done: Function called after reset is complete to notify driver
>>    * @driver_managed_dma: Device driver doesn't use kernel DMA API for DMA.
>>    *           For most device drivers, no need to care about this flag
>>    *           as long as all DMAs are handled through the kernel DMA API.
>> @@ -115,6 +132,8 @@ struct cdx_driver {
>>        int (*probe)(struct cdx_device *dev);
>>        int (*remove)(struct cdx_device *dev);
>>        void (*shutdown)(struct cdx_device *dev);
>> +     void (*reset_prepare)(struct cdx_device *dev);
> 
> This can never fail?  Why not?

It is just a notification to the device driver to prepare for the reset. 
Though it may fail, but the reset will still be triggered on the device 
irrespecive of the pass/fail status of reset_prepare . It has similar 
semantics to PCI.

Thanks,
Nipun

> 
> thanks,
> 
> greg k-h
