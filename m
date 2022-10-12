Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565C25FC5C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJLM7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJLM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:59:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E48B9783;
        Wed, 12 Oct 2022 05:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDmzA8M+6MdRR/NIAMvncReGhmwtwMew1/nc7IOREJlFRaClcF2Kry4Oj1h64Oc7sTwDGLZpTZ91ai8p4yEhrOrED9AXYMjP4Zd1E/QoF7RabkSeC46OGnU68vLoiop3+iRfJPiM2vABVde6L20djPTHLiGC8bvhHfN6Yuy/cuON2Ws777LwnUq+eIPRk3a9JY34qX84NwgE/bbHna1CPjaFLhjJhmgWyiYtnXUiDKa2A/z5gDbuBjKTilQuqDK3rmoMj/XDzpIpAl8kjBrX0UvvIrzLs9bglidEerXSZt0P89SHwNnf/d8y6Bgxc8Xp03/qvYPcbC1ncFU4PHpFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okX+mvxr3HcRfNe7xur7BUtptqQ3buJrufgtx9DMvvY=;
 b=kjuX2wPfR7vSX/b6+tOriRVuxHXSXO5QMUDw4QjirjJdv8QP0pD7CbTubWz5rsESpVav4XIzBIFoCnwodYuyBno+aUR4LlxFGcO9dkbAnnhgM3xGWrah2f10HQu/pWhSWtamNCSRscW0Up44uNDuF6aW504+uu8m3Mm5YQ/ciRGhrU7WYhphEREA9I7udTBQwj1oXDI5hV/XMfoO++y7Yi9qVwPt713GtWWg50TSHfgTpZg8s93p+HpCY7GaB2N85o1jxyHQHnHBm5W5Qmz5WXOO+FIyrXVlWwOHG0RFkYsMwgTARPPWrmq58dB+uEawef+ZHObRy5fWMYoAoEp1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okX+mvxr3HcRfNe7xur7BUtptqQ3buJrufgtx9DMvvY=;
 b=0Kz83Ur0oLFEk4DwXeAhrD6MabvbVabAIPV/VMqiLHkxaEaa4gHr6WbBHx09HhiatEJmKRQdLLCNLn7q2FlA0nxqN6jAHWCBOIXakRGG9ID7tBSHzcvYY4F9I71fOl/wGA9kjkji/Pxc2qY3LENZd3U71+sp0IcnFeSvsR0Qfp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH0PR12MB5060.namprd12.prod.outlook.com (2603:10b6:610:e3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 12:59:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%9]) with mapi id 15.20.5676.030; Wed, 12 Oct 2022
 12:59:05 +0000
Message-ID: <bbf46b1b-0c1e-7232-ce53-37878f049cf1@amd.com>
Date:   Wed, 12 Oct 2022 07:59:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] xhci-pci: Set runtime PM as default policy on all xHC
 1.2 or later devices
Content-Language: en-US
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221010160022.647-1-mario.limonciello@amd.com>
 <Y0T68lC6bUY7dg7D@black.fi.intel.com>
 <7c08c4c8-562d-553f-e513-c925080300a7@linux.intel.com>
 <MN0PR12MB6101ECEA1CCED9B65667031DE2239@MN0PR12MB6101.namprd12.prod.outlook.com>
 <7df4a91d-6829-5ebf-18ca-c0783c03f443@linux.intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <7df4a91d-6829-5ebf-18ca-c0783c03f443@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0054.namprd12.prod.outlook.com
 (2603:10b6:802:20::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH0PR12MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: ddfef65e-bd33-43b2-0a98-08daac518b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vAQB2QQ5dHcdgfJtcI+0I2hxW9G6UXxsWFUuOZ5LQDkdsvnY6DIOyMPanzsALzk3CU5lTqt251eM3frdEJGwc8nlDbBjC+O+E6UNVXyUXaW22ceYIxkZ8Z6+Y5cW374a3FGUCSXmdYG4KkwthHMdai0ryxVgZNu5TnFcwXCFlG7tfrvC4WMKfuDiH7amsaoh9bNHml/HyFxN4A3ohnX15M/hIng/D4D5AvKoeqYhXr1m2iT/wkdFjOiG1dIrg8agYgV7vLwrtwcAgg8OnTt2LFF9+dkCnJVhZWuNIf+OEhLcDBzSBS0l3hO8NlPo9CNWJaqdJN6sDWyOeuqvQhDYd1Y20Er4XtJ3+4tG/LyEFG5NI0jCz670Tna7ChI7zNSD/ybeuI3IR2KCZac79CByetnZEECN5lE4WSw+Rqrcc4srHB2yHSOlqwMX+LITHX0iJzMz0LB43cs4vjptZwGu1mUKu1s9faOjsWvLfA0jlmFQj+QAl57tGT8rKwmqiKCuxL4AROS7hUObaXK+T7x1aH6hucO1Yjwj2QRr/q2j/jSCR7h8HEfDh8CM/9QvppJ8mOjPPD/Ec9QCVINi71IcN4YmAYrSGiZ6uEQpz53mZxY2Ih3eIYS38qg7dKRWSxu7hD4hqMDzX395kqM0rgj5Bb2deHpJ7JT9svYqFV80YwAPrSszBNij3fglcPj6WoVJoG9+OS72IhECtWfHAQH55jx705dY6sEM/skcZ9O258IiZs86z9onAJ6MlrZIvc1b7hRRIy2s62KwVRGUa1Pnx0mYPyLqQwa8TphhxMvzm0jCzoDweBk4jBMfaClDjakE+cLNyDVvAw4p+Td8pBv6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(83380400001)(186003)(2616005)(2906002)(31686004)(8676002)(4326008)(6666004)(53546011)(41300700001)(6506007)(38100700002)(86362001)(31696002)(36756003)(316002)(44832011)(110136005)(66476007)(54906003)(478600001)(5660300002)(26005)(66556008)(6512007)(8936002)(66946007)(966005)(6486002)(45080400002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVdxS3lsNEdoN1UwdkdwclVQc0dJQzNkbFJWeTBTcDRDNVJQdWFRZ2JCUmgv?=
 =?utf-8?B?a3FBa0ZGMTBzMitVUU9uY1BIRVdZWUtxbHVTU1BMNFl1cnoxenlJalc0OEgv?=
 =?utf-8?B?R05LWDBBWm0wcUQwQ1ZWMThWdEFUQ1RObmErRkZJU1JWaDBNejVQOWNrVG4x?=
 =?utf-8?B?TXRIemxRZThQZit6dndMT3QwbDJLQ2J2Z1hFTG9QazhNOXByTG1ER3JncjZH?=
 =?utf-8?B?TzNvdlhwVWFVU3prQnB3V05CTGU2WC9BbThxUC9KNzhxUkNxR2xaU1AvY3Zo?=
 =?utf-8?B?YWF2MFp2TkVXVWY3dkdxeVZGaCs5a2ZtVENtTHFoaHJVelhObXRKQTdFNnF0?=
 =?utf-8?B?U05wZXdKaUpWNUVsd2JsOHJPZEZ3TkFOcnFOUTk2c1JWWVovaDN0Z2liU2xt?=
 =?utf-8?B?Z2VvczFSNjBIODh2NlVWL0pYZ1NlNWRqclRTa1FoMlZPQzZLclZJR3RaZ2ZM?=
 =?utf-8?B?bVdzR0xta1Q0Z2tzeUZwbUczL3ZCV3ArSkI5NC9wMk9JZER2S0pNd1FTc0xq?=
 =?utf-8?B?MGpiVXJtNmZVY3JmS0w5dU1EVFpZeTc1NEVwWjlScTE5SSt2UlAyeVQ4Um5T?=
 =?utf-8?B?aDFlblR5TEtWU2dheXVRb3ZCQnBIODJvOElMTkVUSmMreGJvRHlWdjZrL2I4?=
 =?utf-8?B?b3F3dmFWeDMxVThSMDZYZmhpd2hKcTJ6NkpxSStGZ0lDTFhrNVoxY0tTdjgv?=
 =?utf-8?B?RFJ3NVl6NW96Nm9nRHhSNldwSjFBbHBoZUxHOFhlZWhUcDhPM0dER2Z3YUpn?=
 =?utf-8?B?eEZqVnY3b3ZjRmgzY042RTY2Z0ZsRG0vRGJOQjZxZEZpcXFCYWNXZGFhZTdM?=
 =?utf-8?B?dkNpODVGT3k3bER2VE96NjZhakt6ZG9tc0xCMEo5MDJweHNqNlVPNlMzemJY?=
 =?utf-8?B?N2plVTY0YXZXOURZTGhXUDNXU0ZtZDVsOEU4T0dOVVk1R3YxcGZFYks0TGRl?=
 =?utf-8?B?RkFxMWt5QzRoeXJycTV1d21FdGN2a3pvWlNBbisrcHBTY0M0NnZjRFJkNm5P?=
 =?utf-8?B?ZDdqME1adWs1MjgzWUYyYXVUait4ZjZJRGluZUh6U2RxR2trWmRjNzlmRHZ4?=
 =?utf-8?B?MFFZbU5Gd3JYWDFpd3NqUkU4bStJYWtlVUE5Vmhwb3hYQ2dOdmlSMTQycGlH?=
 =?utf-8?B?Z0VycEVhRTFBbEhJdmNIcFNuSXNhR0dUenNvSWNaZGZvZlhPSjdVV3llakJH?=
 =?utf-8?B?OW1OcmNuTGVQMTlCMW83MWpEVXhaRE82dUYraUQ0UE5Gei9kNDNGK3JHUGdo?=
 =?utf-8?B?YS9DelFpYnJqSkNNelNyRjVvOWI1Rktvd2VlRXBQbHI2akZicnBRZGxpZzBX?=
 =?utf-8?B?anAwUi9TVC93MXhWVjV4cWh2RmdsOCtJbVdENDNrZXZFK3U3Ri9RTnRucVBp?=
 =?utf-8?B?dlBacHhGcDRmVGxqQTBSaDhJTVNyV3B1ekVJcmI3ZjhyY3Niek1ZZHB2OVdj?=
 =?utf-8?B?NkZEREQrY1JnUlpsYUcyT1ZGcmM2elVHWlNUd1cxVTl1YlRjOER0am0wVXpi?=
 =?utf-8?B?UjZ4ckVKNkFaZGxVOTBnYXJRKy9TM3doQ3NtZHFvQ1VWYm10WVBpQmxKNGRU?=
 =?utf-8?B?WjFuSmdaZkdOcVB1TE9CYWdjRWJ6emxtcXI5dmFiQm4xZE9lM1podzMyVlNY?=
 =?utf-8?B?amp1V2g0bGJhZGZNSkRJTVRNWHU4a3I2RVEvTFhHVnFXWEFPSFNEMWtGdXpj?=
 =?utf-8?B?RG9uTTlWWXNVdTBrY3BWSlpPcjBBOUZtVkxlYTRRSTVqRXNVUHd1WThSS0JP?=
 =?utf-8?B?NXd2M0Y2dkJpZ0FzQmtFZTVBZDk0UzJGOVJYZlQ3V29YREZFYlpMdEZTcWhu?=
 =?utf-8?B?N1Yrc1h3b0ZjcjBYL0thcjUzeUdMZzYzemNsMXZNd1g3KzFPQnppOHJDRU9L?=
 =?utf-8?B?bERSUzUyRk4rWng4TXFzamhWdFJicmZKREJUaXpKamVsaHV4OHhCcDdIWHRU?=
 =?utf-8?B?YU16UkVLOTZOSkZEbWd4UXJNMWU0RlpiUFM3d1FxU0JJMzR2WDk3ekJTTXN2?=
 =?utf-8?B?bnUreDlGNTFqY3E0azBVbWZYQlhCMWF0VmhvakJtK0l5UDFtN1hFSDR1N2tj?=
 =?utf-8?B?SDIwOU1sUkl5NlRwaitPNVJQNldUbVRHRHMyRFA3ZXIvdEpIRXdvZjhLTFRH?=
 =?utf-8?Q?h7pgG9ptWWmlbtnO1kt17084w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfef65e-bd33-43b2-0a98-08daac518b1e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 12:59:05.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFPwo9i+0sxqV+in8pIH+5p29dcMs75MATiREwyptnVkhba/7LSSci13JXTGEJ79m1l+rmyQPxeAssg5UW+eLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5060
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 03:34, Mathias Nyman wrote:
> On 11.10.2022 19.46, Limonciello, Mario wrote:
>> [Public]
>>
>>> -----Original Message-----
>>> From: Mathias Nyman <mathias.nyman@linux.intel.com>
>>> Sent: Tuesday, October 11, 2022 08:16
>>> To: Mika Westerberg <mika.westerberg@linux.intel.com>; Limonciello,
>>> Mario <Mario.Limonciello@amd.com>
>>> Cc: Mathias Nyman <mathias.nyman@intel.com>; Mehta, Sanju
>>> <Sanju.Mehta@amd.com>; Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org>; linux-usb@vger.kernel.org; linux-
>>> kernel@vger.kernel.org
>>> Subject: Re: [PATCH v3] xhci-pci: Set runtime PM as default policy on 
>>> all xHC
>>> 1.2 or later devices
>>>
>>> On 11.10.2022 8.11, Mika Westerberg wrote:
>>>> On Mon, Oct 10, 2022 at 11:00:21AM -0500, Mario Limonciello wrote:
>>>>> For optimal power consumption of USB4 routers the XHCI PCIe endpoint
>>>>> used for tunneling must be in D3.  Historically this is accomplished
>>>>> by a long list of PCIe IDs that correspond to these endpoints because
>>>>> the xhci_hcd driver will not default to allowing runtime PM for all
>>>>> devices.
>>>>>
>>>>> As both AMD and Intel have released new products with new XHCI
>>> controllers
>>>>> this list continues to grow. In reviewing the XHCI specification 
>>>>> v1.2 on
>>>>> page 607 there is already a requirement that the PCI power management
>>>>> states D3hot and D3cold must be supported.
>>>>>
>>>>> In the quirk list, use this to indicate that runtime PM should be 
>>>>> allowed
>>>>> on XHCI controllers. The following controllers are known to be xHC 
>>>>> 1.2 and
>>>>> dropped explicitly:
>>>>> * AMD Yellow Carp
>>>>> * Intel Alder Lake
>>>>> * Intel Meteor Lake
>>>>> * Intel Raptor Lake
>>>>>
>>>>> Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>>>>> Link:
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fww
>>> w.intel.com%2Fcontent%2Fdam%2Fwww%2Fpublic%2Fus%2Fen%2Fdocum
>>> ents%2Ftechnical-specifications%2Fextensible-host-controler-interface-usb-
>>> xhci.pdf&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cb286e9c
>>> 63e9e4c3a1a3708daab8a9b23%7C3dd8961fe4884e608e11a82d994e183d%7C0
>>> %7C0%7C638010909687542135%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
>>> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%
>>> 7C%7C%7C&amp;sdata=CetIs1VuAqj8nNBoLnXaGncw6Sl4JcImYY67JpVxyjg%
>>> 3D&amp;reserved=0
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>
>>> Thanks, added to queue
>>
>> Thanks!
>> For my own clarity - is this something you'll still take to 6.1, or 
>> are you meaning
>> 6.2 queue at this point?
> 
> Was planning on sending it to usb-next after 6.1-rc1 is out, so ending 
> up in 6.2
> But if there's some benefit in having this already in 6.1 then I don't 
> object that either.
> 

It's a blocker causing higher power consumption on some of the affected 
platforms.  So if you're amenable, I would like to see it for 6.1 so 
these things have a better chance at passing energy certifications.

>>
>> This thread originated from enabling Pink Sardine.  Wherever it lands 
>> after it's
>> baked for $long_enough I would like to bring it back to stable 
>> eventually too.
>> If you think it's too risky for stable later on, can we do separate 
>> set of commits
>> that adds and then removes the IDs for pink sardine that can go to 
>> stable?  This
>> would at least mirror more closely what has been done historically for 
>> the other
>> USB4 products.
> 
> I think we can add this to stable. It's fine for Intel xHCI 1.2 hosts.
> 

OK thanks.


