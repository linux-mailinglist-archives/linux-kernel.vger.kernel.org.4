Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58AA5F44FE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJDOAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJDOAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:00:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781C85D0C4;
        Tue,  4 Oct 2022 07:00:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6lcGfK1ipK3MQZBTT7GMDPi/FKppUD194ojMaqoWf/O3G2lrji07zlQDTCjDskKaJhc94PuH9zqFDCsrEPUCLDzq5AZZxgIxIcVmjpXmuZu+M3y3bdWoP+qYZ5sMtUhbvEKie0746w0wFCqpReX6UhROdwZkbsId7RgiecFkB0EX8MgTa9Eczph7Yczhpy+ELuIwfO1/jwn/W5+m1JJ5KGP3UQhlnOuOUpI+rRZsl//MIysVOuOLO0B7lLbUxBxqU/OOrkkM8gol7RUCwXqixqs+Tcecw+SNw6L7SUsJBu1PAakhmcca4ysd3btEte+wYi5ozN2rFYE6luIiGH4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/0ihkQ6WlS0dQ5PMTf6/c3UMFsUtJOmxFG5EAM4PJU=;
 b=mGbb4sh8IPwRXwVccz3y9e2b7TEcj2enZhr+AvbWnPa3FgOUcO0Q8AhuWb8KaSzmBGnTBQS0FAsz/j4sliYBmqBB7lETyDeJbiq4bEP/PHtCfm468pnfUiYDl1zHOJybkVkirHnAvcBYLN3C4y2ZGknz5Z4wODz6PGDABi+uzDUSDraxIA4o04kQnk/fCmPLz+dQ1lpIkOmFbFVuCVVoNdDO8VdMKc+Ux6uMCxzM4e+PjU5GcY+S4K5rWFEs85XcsOoRmQ5tBVnpFVW6BTLBQ96nwIAvvnZDd6QOw/1j7rFZ0Rsv+Sb3WmR0NaOr508ylAb1hYvbwYmiE7i+80i/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/0ihkQ6WlS0dQ5PMTf6/c3UMFsUtJOmxFG5EAM4PJU=;
 b=krY/2QqfbU2AFGbGMCzxgb8+iH/lKeTXHoJOsYuWv5/VmbOKLy2XvedB3xdMce1bdn2/pWDRKtI4XB24vjlgTTlsdGBsAgbid6xCqJV/sfRD9urePK/0aQLJlDzxHKJs60I1rIV4Idk58OyOG8lEvj4B/QHYgv2rSagYyxJFJ5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Tue, 4 Oct
 2022 14:00:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e%3]) with mapi id 15.20.5676.032; Tue, 4 Oct 2022
 14:00:46 +0000
Message-ID: <d60a73cd-3228-84bc-dd49-52ccb9fd0015@amd.com>
Date:   Tue, 4 Oct 2022 09:00:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 12/12] Documentation/x86: Update resctrl_ui.rst for new
 features
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <166431042060.373387.8454967155095795574.stgit@bmoger-ubuntu>
 <71ca01ad-e563-3ac3-815d-0bbc3814ed6f@intel.com>
 <05f0ff0c-b328-46ac-c1fa-7aac09fbb9bc@amd.com>
 <39c3bf58-052d-fbab-3bbd-029f5507ff23@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <39c3bf58-052d-fbab-3bbd-029f5507ff23@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0069.namprd19.prod.outlook.com
 (2603:10b6:208:19b::46) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: ad320908-c706-4e00-9f0d-08daa610d57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBFRIZi4Yj7ygd5cIKCttej52XlE1kdbCGUtKQUWfzm5SVmxJpiOTpJbxfM7j7PWCFdnj37n5bb2YlGpW9zKu7DpifcdmLmAYh8HLu+sX37CrBQKMBucsMPhfq+XRTecr/edEfDqNyrYdybztwWIrmDy/VmSMRS1Z/AK1Gf3TV8FBg5JuQqwBYpNoaOq5VOgL6cW9iNORMKHgex+XrfyR+miSnaiqQd7poPR9PsB1GNlAq3k8NovpJ45qBGZVQzaiFOGVofOTEaBr565ZHJhKWyPQhrGBeaDxAqOHhugPHXApjtxMSqYr5xtCwqljl/H8U/hvo0oMVPyZkS2a+Ice66yzCc3WVdRudVf/iOC4y4fe9rd044gZoziYfAmHhtC6y1AC7EdMYz89gdE22BNEylSBKh37v6w7eX7bXjx2V81i73YTjcOxdKna8vf4wQF7TuKN9zhDLNH3dVfgb9oVRBI4PASBGRyXoHI3C7I+sFAvdrxJAGLjzPAuxBYAdEQdh0dO9NVo09Az6xZQ/nBkddjXRxaJJEdrkhAU3VGF8H1Arm4+Tkp6yvMun5il4q/4jIdWK+LtTHglE9BFGigORzVU1dsAtPI9rO2omKrFy/N9bNBEU4r8VIYs/PT7/fHcCzpeyWESp613cNF3e9h9wgRwWd4kJXj3CMe2A4h9iEzDhNPn7+BjT8YGs4kQp/jAkIIzHPrAwdGk0RIC/2Lno4ZPBCkPYN4VNzKniCQLlun5d4tyyVXVVIwZocwaxSbuKJJPhmeGp8A0TuEwm5pVGw2fu3sytWtB4eZiJFhn10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199015)(2906002)(66476007)(478600001)(4326008)(6666004)(8676002)(316002)(66556008)(66946007)(38100700002)(53546011)(83380400001)(36756003)(2616005)(26005)(186003)(6486002)(6506007)(6512007)(5660300002)(31696002)(86362001)(8936002)(41300700001)(7416002)(15650500001)(31686004)(3450700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZSU1JMMnVFRFZWOVdPL2UwS3dWdU9qcXhoSzhZUVRGditVUk1MZ2I4TDFO?=
 =?utf-8?B?bUc3amtEemZ1bzVRamlLcTVIVGM0TWVOWjVsSjhuVjcwdjV0ZG9ZQlBmazRv?=
 =?utf-8?B?K0VCVFJ3c1Z2SDZUVC9rTlh6OFI1UzIrYm1nVGFKaC9uTU9lb1JSaVowbkVr?=
 =?utf-8?B?ams0NDRnSG9NQ1JoQ3M4TFBaa1lsQUJraFZUTDZ2d0tZQzExVjU3N2QyS3RJ?=
 =?utf-8?B?eE1VSDYwOTljOXdMcFBnNXJXMlFuT0psNXc4YkdKYXVheUoyd3g1WlU3R1Nn?=
 =?utf-8?B?eTlqb2V4S1c5cGtNR2d6NEREMEV3a3NsUVFpcnp5Q3Z4aG5ZeFJtSSt0bDFB?=
 =?utf-8?B?SGZkVjdoT0lvSElMZW1XYWZBTW1qTnBzRDBtNzlGZXN6Y2hiY1dzck4xUmt4?=
 =?utf-8?B?N3dWRXFFUlhKNnhCKzY5VXgvbXhGMDhScVFodVplSVZyTS9TVDVFd3NPSGlW?=
 =?utf-8?B?N0xoMDZNcEU0aStxZ3lnUDE2bTV4T1RsVlMvUk80OHBJSExRRDBId1EwRVhw?=
 =?utf-8?B?MUR3aUwwUGVjRlRzUXVQRU14TDQzdEJRK2xuV3VIUnVYbVdmQ2pxRXRFR3hP?=
 =?utf-8?B?VmJGMEIyNDF5R3hmZy9BWTVLWDR2VWZrclY5eTBCcUt4MnlIOGtXS0cyL0Js?=
 =?utf-8?B?cFNPSWk2cnExS0FIMkRQTlRXWEtobjZ0Z29uWWlZRjVPcUxGcXpJbUtWdXd2?=
 =?utf-8?B?d3VJSmdQRk9KTUhpTU9mYzdVR0tpaVA4YkVJSmVFZEliTUw4T201VFFlTUNq?=
 =?utf-8?B?RkYrS3RXTk14UVFVMWd2VzZmK2ZhZVhQSlFhQTRtSTByeXRlZTYzY2hPOXhy?=
 =?utf-8?B?cmpRdVJxOVBaMUJrZ2F2MitTYml6R3RzbUZLNkkvYU5TTmNuSjZuK0RabHVo?=
 =?utf-8?B?emtjMTVVVDMwMHZzbFlyaEVlajZUbldjK1RrREdTb0hLdXBrYVl2b1VRZlVT?=
 =?utf-8?B?Q0hWdDdNWVd2SnAyMEozdVRjMUErS25oYzNkdWxRUjNnUGZwRk9DdWJvblA1?=
 =?utf-8?B?ZGtwbkRQMFlJOVlEeHZoWktyN1p0NUtsaVJmZTljQ0U2L244NkFpbmJUYnJl?=
 =?utf-8?B?aStzNko4U1VDcUFjRXlhYkxVYjllVElDcXRXSFlqVWpVdEtFTWhLUjk5NHh0?=
 =?utf-8?B?K1pEemNieEZrMnNFVkM0dDZZOHp3aks1VTk1Y01uSk91RjdHZUh4MXdreEVZ?=
 =?utf-8?B?Q3ZVZUZNRTUxMk8rN2UvWWYyRHpFQktxR2dCKzFqUGVENThFamc0TnFqdkJD?=
 =?utf-8?B?eG5TNGlPYUZLSzJCREhsQnJJaE90Lzc4U0FJVGFJN2tWYnQxcFBvOUx1d2hM?=
 =?utf-8?B?QmFiUzhBcTJaQnVKTklFbjJTd05uNWtsNXNWMUZacFMzVWdHaHBQKzF0N3BW?=
 =?utf-8?B?WTFSa05hakdpNW1aOS9zeWpnTmdtYSt3VDlTdVRhUDV4WG8wYzlCQitINFBI?=
 =?utf-8?B?TURnU29td1RMZy9HQXR3ZXM2Qi8xeVFhRkdySERlM3B0Yzk0WVF5OFVoaGV4?=
 =?utf-8?B?eHVCejFsMFFlT0VhVURmallsalhuYnlWSHVJeXFseDltYW1hYjQ1ZXpnZUpC?=
 =?utf-8?B?RTRCN1ZMZkd4QngwOUMwYkZhdzFCMHJzSmRFdVdDcFZPSXNDWHlWOTZlaFZH?=
 =?utf-8?B?aTVsSVRGUDhnaDN5K252dUxzKzE0aGN0RzJKUFo1RjRkWkw2K05tUUdPSkNq?=
 =?utf-8?B?TGFMNTVlR1c3bnd0blZtek13dWVQN0g0Zmp1Z0FydDZGcFpkMVlZeFNJYU1E?=
 =?utf-8?B?NmhPYlVvYmdkMldFZTNQVkhtNVBBZzJGR0J3QUtaVEswTlNyNy90bFpNWEZJ?=
 =?utf-8?B?ZjdMd0FwT1JaN2pJRHM4L1FLYWt6akR0eGE3R1RKaEtFaWR0SSt5Q0VTQmdW?=
 =?utf-8?B?M2ZOSm8yeHNiL1JMTEJ0UHRVZW00K1daTUdCK1doTHpTUXJPaUlkUExTMFZv?=
 =?utf-8?B?SjEwdDExY1hsaDNYN0JDMTEwQ1VTbmNiMVJhSWJDRm85MVBhMzV4R3RuaUNM?=
 =?utf-8?B?TFNVWWRjZmlKQktDeFI2anJEaGhPOG5GeTVXd3B5YkVzUzZ1Q0FkSDBuU0Rm?=
 =?utf-8?B?Y0dlQXgycWo5WEtzWEVDajdmTnUrWEFVNWp5QzdVZTQvZUdhRWRGR3hreWRp?=
 =?utf-8?Q?nJrI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad320908-c706-4e00-9f0d-08daa610d57a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 14:00:46.0565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQysk82tLSWNycSQaIVNRIVLQzRJiHl3PF8R1RvlT8vKVSSNCUAvUOcwZUH6LBIJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

Already responded to this but i don't see my response in archives yet.

On 10/3/22 10:36, Reinette Chatre wrote:
> Hi Babu,
>
> On 10/3/2022 7:28 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 9/29/22 17:10, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> In subject: resctrl_ui.rst -> resctrl.rst
>>>
>>> On 9/27/2022 1:27 PM, Babu Moger wrote:
>>>> Update the documentation for the new features:
>>>> 1. Slow Memory Bandwidth allocation (SMBA).
>>>>    With this feature, the QOS  enforcement policies can be applied
>>>>    to the external slow memory connected to the host. QOS enforcement
>>>>    is accomplished by assigning a Class Of Service (COS) to a processor
>>>>    and specifying allocations or limits for that COS for each resource
>>>>    to be allocated.
>>>>
>>>> 2. Bandwidth Monitoring Event Configuration (BMEC).
>>>>    The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes
>>>>    are set to count all the total and local reads/writes respectively.
>>>>    With the introduction of slow memory, the two counters are not
>>>>    enough to count all the different types are memory events. With the
>>> types are memory events -> types of memory events?
>> Ok Sure
>>>>    feature BMEC, the users have the option to configure mbm_total_bytes
>>>>    and mbm_local_bytes to count the specific type of events.
>>>>
>>>> Also add configuration instructions with examples.
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>> ...
>>>
>>>> +
>>>> +"mbm_total_config", "mbm_local_config":
>>>> +        These files contain the current event configuration for the events
>>>> +        mbm_total_bytes and mbm_local_bytes, respectively, when the
>>>> +        Bandwidth Monitoring Event Configuration (BMEC) feature is supported.
>>>> +        The event configuration settings are domain specific. Changing the
>>>> +        configuration on one CPU in a domain would affect the whole domain.
>>> This contradicts the implementation done in this series where the
>>> configuration is changed on every CPU in the domain.
>> How about this?
>>
>> The event configuration settings are domain specific and will affect all the CPUs in the domain.
> There remains a disconnect between this and the implementation that writes the
> configuration to every CPU.
>
> You could make this change to the documentation but then the
> implementation needs more than "Update MSR_IA32_EVT_CFG_BASE MSR on all
> the CPUs in cpu_mask" - that comment needs to highlight that the
> implementation does not follow the architecture and scope rules nor how
> configuration changes are made in the rest of the driver and why. Previously [1]
> you indicated that this is based on guidance from hardware team so perhaps you
> could document it as a hardware quirk related to this feature? At the minimum
> it should acknowledge the disconnect.

ok. I could document this in the code patch 9([PATCH v5 09/12]
x86/resctrl: Add sysfs interface to write mbm_total_bytes event configuration.
Something like this.

/*
+        * Update MSR_IA32_EVT_CFG_BASE MSR on all the CPUs in cpu_mask.
+        * The MSR MSR_IA32_EVT_CFG_BASE is domain specific. Writing the
+        * MSR on one CPU will affect all the CPUs in the domain.
+        * However, the hardware team recommends to update the MSR on
+        * all the CPU threads. It is not clear in the document yet.
*        * Doc will be updated in the next revision.
+        */
+       on_each_cpu_mask(cpu_mask, mon_event_config_write, &mon_info, 1);
+

Thanks
Babu


