Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9465C0262
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiIUPwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiIUPvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:51:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0359E88E;
        Wed, 21 Sep 2022 08:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQNu7jkZIKYzFQ2uvvVchDvhLYezTc4+5llpL0wel3kyz8uZl1wKBEbJ8E+S06ZYu9dOS5ucEYpyktJslOyuVMZVjX7gBL7tTwaQq7G9Zanx4lNAku5ll+6LmwawHT2k06jffU0L4PTqussinBpHITOxOIurW44KICi2K5NWVyTFivTP1N6wA0Y5nM4pv4M4XWu6e8EaL8WvWBxTkbsEWqK2TTDhZCgZe45G0tnua4KDeXSgYaHxKGRb73j0C1mDQsy88P7joYcppJcXluq/CjRxyxGQ6Xx4LQkcB5OuHY/+MVqndLxYPOYomQcT+XdVNG/KH6NbOv7X5sHso7QOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FolUt+/iiQAL34Am8hSLaOR8WWXEFXWNLa4jr6OnKbQ=;
 b=Q74bq2EQfGfGfFt/w8BUeOfv2xvFDa9v8z7ZmIVOGankW1ZjTSA0o+lChimQq77h/8fF8iPqt9PYKd8TQI9A6snTguIrTBsKJxYXIR7lOGCwvdh/BpQ7+ue4Jq8j58vng3mgUeRRko8MaYkDDly7CW9sTycw6hCX5CJo3EIRZmNRcbihjPK+/TnknP/mx7EORsiZHOqDmO6MbmRJW7UrueTHTESiN3+OcN9qElXz8GrwVx2/08huXwe1E7ssnynzBG4T8UqSLctNgMdkouKDvrmL1xorb3YN2nooJR9ph5kOEtaqwpAoptXKv4GFFhRh6LAixry3lGF8B2XZ5+4eIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FolUt+/iiQAL34Am8hSLaOR8WWXEFXWNLa4jr6OnKbQ=;
 b=s2vO+v7ehWRf8x/zr8FDvvoTRagjJbk/y1mBrJXd3HZ4HEl6lUl+SZAQAggg8koBdWm3BFpm/IyGfLCI9sNDfE71b28Ugm5YSJSq4oRkLa8Yfu2VetxpFy2qV50s/cVce2yjXhScjzs9u6OhsHF7j5PvIFzp2lSoWvh2a6ywDBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Wed, 21 Sep
 2022 15:48:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%7]) with mapi id 15.20.5654.017; Wed, 21 Sep 2022
 15:48:19 +0000
Message-ID: <6283792d-3c91-0ec2-6f2b-edd647d0de67@amd.com>
Date:   Wed, 21 Sep 2022 10:48:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/2] Fix some hotplug event issues
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>, sanju.mehta@amd.com,
        linux-kernel@vger.kernel.org
References: <20220921145434.21659-1-mario.limonciello@amd.com>
 <YysxhSh73nwMC1Kb@kroah.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <YysxhSh73nwMC1Kb@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0002.prod.exchangelabs.com (2603:10b6:208:10c::15)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 9052591c-d7a3-4f5d-923b-08da9be8b4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwDe69i3L05EL5F1SuzZeVnZsR53TvMOjMxYpm+7snAPHcZXADRHjtHmNUPDTlP9hngKjQe0fDWQdltE133VitiyuH5yxjOEtTklkjSeZEiffWnLC4fczGfC1rnBm0YbvbEEhBp6ynb7f3m9oRSBGBI3DeuDb48MXp4GHAM4mPgKBXxou+bGZhouwQ34lYGU9WCDwnhTQx/4/K4X/7zgBX5erGLC91EEqGVC/CrC7D3S8+kFaJAerrUCExisFWK9/bZcIP76bCJvbtyUUT50sf5iFtQ2I8FREHsNjiWLaXVA70e8WP8c9hmC4I6657QxVD/fv/ZV/7gPMeoJNKYOFLLhpXMg9wmCCoQAIvXN5GRBYgvE9Ne4NLJF6WYqYtKwC4kseoIm+n5isvQUBJtUFbxMN3s1hq+tKe+zquYRHuLQ3QDPceZuACNy0f58b9VGYFFNYiz1OaopjhIEVqP9SzHfhk+nvwlYDppp6OqajsEbjlHcVE4J175q3e0zwCQwgY6XA8aOgRKDFZd+DEWZlzsVdrO4HbspfUgk2/DfiT970jKLXsx5gQGJxty/8ligCcyWz3TxcTIucW6s6nbhX/bUrL2dKmBnfAuqKlhRVdw5Vtu7BsrWaVYK+sFkKGxLLwdwM03jfGLiSxaCfJ8NmQwsUtleG0sfOo45zQDvDVAPj8Fdo6SZSVgX32se4lqpKFRKHpR6TgPKr2koZxE+ws0DzTZnmsJMOYJrAb1xMub9/YcRp/VmLj8txyRJaQ048Eoyg57Rw9VyxGpCECf/OVipkkmlyuFQ/T2jWhSP+mQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199015)(6486002)(31686004)(38100700002)(478600001)(6916009)(316002)(4326008)(54906003)(8676002)(66476007)(66556008)(36756003)(66946007)(41300700001)(6506007)(53546011)(8936002)(26005)(5660300002)(2906002)(6512007)(186003)(2616005)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEFheUd0c1ExaEEvd0FrNitRT1FRYU05Z2hyemF5Wk1VS2xzODd1SnAySGxl?=
 =?utf-8?B?TXhmMzlyZEJBc1B4WEd5YXl1dnQ2VFd0NEJudk56RE9veHpxZkt5eVJDbFU0?=
 =?utf-8?B?bHdEM29lVEx0d0V1VkpOQzRSQjRDT3BXY1dHS05ESTNldGhWMVZoOFRJNDY3?=
 =?utf-8?B?b3RnYTArWXNlSDdra1o4N09WUUFCSXdwRk5kOXoxU1MrZW5pdElNMzFYNDhi?=
 =?utf-8?B?SWhjMk1HN3lHNHBJd0k1bEJma1dkaURhK0VtOEkza3pSUUk3bEtKU1JJNmtG?=
 =?utf-8?B?WExoM0x4SDVyVEkxUmV4ZFlUV2VpTkFHUUxyM2d2TlNDcmJTcXp5dDJuUEV4?=
 =?utf-8?B?UXJ6LzVQWVlGdm9XWlhvRzhOd29udVJoekJMdWNqN2lUNHZ0Y2kzNE1HUVNh?=
 =?utf-8?B?T3NJMUkzMmxUS3l2YWg0WVZGYnVLQTlGSlovYVg1NnNGMDIvaGFRRXJZOExU?=
 =?utf-8?B?eVJqQUlwT09UM3BaWGxDcng0bjdEMmV5K1JIVjUySlE1NjVBNGx2OVRmT3F2?=
 =?utf-8?B?dkpGaytIZVVCZ3FsWGxDMmkzZzE0cWNKTnM0Q3l6NW1SZVlROEJERWJPd2gr?=
 =?utf-8?B?UDVKREhEbTN4TDROSEJXV0hPS2pmUXJ6S2dLZXBJNWM2bjlMQkdEck5vT3Bs?=
 =?utf-8?B?L3F1c092TE53RDgra1BYVUxBQVduRkd2bEpKQUQzS3BFTFJvMEpZQmRtQjd2?=
 =?utf-8?B?MGtJTHRKOG1BaWoydUJsNm9ZcGxla2FpMllTV0VuZWdBT3FlcE9DUHhYL0tR?=
 =?utf-8?B?M1c1ZlZENk9LZlF6YmFVWEUwSE12SytscUJPWHNrbkJUZFNGV2Nhc3hHV1k3?=
 =?utf-8?B?Q2RxcThjdlpoTjU5UmpERWg4dW5BMFpRU1IzeHVOblduVHc4bERkME1HNjFW?=
 =?utf-8?B?aHFmeFpmazkvd1puUG1pWDNqSGVkczdRVTNOME56SEVCT0pJR2l1WHRFcEM5?=
 =?utf-8?B?YlhTZldDcTFaSFE2MnYwMEJMM25OWkhWbVlFZkJiTkVYNmx5UEtmM2hLZUFp?=
 =?utf-8?B?eVkrR2FhL1lpTUdKd3dLYUhjRUJieHRFRVo5WmNEamNGU091aFB3K2tkMVpy?=
 =?utf-8?B?OVBQeDF0Y0wyYy9Kb2hOYUxsdXptYlYzaEJ2eVY4REFrSlNlOG4zaEs0aHFn?=
 =?utf-8?B?RGpsZks0VytyRUlBUWR3UlFDeGk3bmtwWDlvRlVHNzlYelFvYlNyeDdMZWE4?=
 =?utf-8?B?NFNxMTdHb2ZzTEEzZkZoOUVmdTdEa2E0TFlrSGpaNFZXSmFrWmhPWU9PVmdq?=
 =?utf-8?B?YUhZT0ZDdHpkSUdDTERzNld2Z2E3ZG55YjZVT21ONGVnejJkVDE0TThIaFhV?=
 =?utf-8?B?UlZTMW1QTjNpYWtUeWJtcFk5Mmhnd2daRnNpNDdMemFlbFZ3ZWVKQ00weGxY?=
 =?utf-8?B?aGdrTVVuemtEaGk4aUVEVlh2a0RrekEzTHVFc1psMm5YeFFFSFZuSit5d2hp?=
 =?utf-8?B?Y3pyMzJtTUJWSWRHZUNWL0p0WEhwMXNYemx4dVNVbEJCemJlY1RBYVJTdi80?=
 =?utf-8?B?SHJ2dlNhak1IdHhpbis2dmViaEM4Q0tFektvYkVWZHl2Uzh4aklFRHJNY3Zx?=
 =?utf-8?B?U0tJdnRNZGZtZVNzMnJHenZ6STJKZTJ2aWlIVDgwK292NEVjQnV4OUdXOVFv?=
 =?utf-8?B?YXZjV1lEOWVaMk8zdTBVZjQ0cFJwZGt0Z3NjZHRZemVoVk4wRCtBbnJ1VlAw?=
 =?utf-8?B?dXRBZHJ3ZUpiU0dBTGtRVXl6M2FCc1c4NllVR2Fhb3hXVEJPU0g0NDl4WVNY?=
 =?utf-8?B?SmJoNHRTSFFzN1ViRzFtUU1NZ3FBRHdaZk01ZTFwbDBRQWhsZTlsMnE2a1Bz?=
 =?utf-8?B?WlFLekp6dWtaQzlJajNpeE9QR2x5UExGd0V6UXRzZXpoMFp6SGJGZDRERmtG?=
 =?utf-8?B?Mm1yNlZRNm9rKzhmNGh1QkJ3dEFjSkJYb1F5K1hxK3hUaUxtZXYxODRRT001?=
 =?utf-8?B?dEFjZXRpS1JKWkJHd1QrOTRrQWpMNlI0bjQ1TGVoelkrUlU5NVBIT1BBSnQr?=
 =?utf-8?B?TU45UHdtN21sa085Rm93d2xBSUtOV3pQdGdZRk04NTJxdUdQQURTZHJRSCts?=
 =?utf-8?B?REZxQXdZZmxWcWd6UUN3bzQxZ2lSdDhNSjhpSU14TU9tcDZvbnI3WnZMZFFZ?=
 =?utf-8?Q?73CIBQACAzIajeGKDrjtUjWYc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9052591c-d7a3-4f5d-923b-08da9be8b4d6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 15:48:19.6119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juxDRT4UXCTwBUdiIKJKoWq86H1teBKP5Djn0LcE2mcHYtn+RSJxDgimKCNzAGEeZvzScoTSv2UlT4rPIj9K+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/2022 10:45, Greg KH wrote:
> On Wed, Sep 21, 2022 at 09:54:31AM -0500, Mario Limonciello wrote:
>> On AMD Pink Sardine it's been observed that if another CM has run before
>> the Linux CM that some registers may not match expectations which leads
>> to a non-functional hotplug for PCIe devices.
>>
>> Explicitly set these registers that have been observed to cause problems
>> with hotplug to the defaults of the USB4 spec.
>>
>> Mario Limonciello (2):
>>    thunderbolt: Explicitly reset plug events delay back to USB4 spec
>>      value
>>    thunderbolt: Explicitly enable lane adapter hotplug events at startup
>>
>>   drivers/thunderbolt/switch.c  |  5 +++++
>>   drivers/thunderbolt/tb.h      |  1 +
>>   drivers/thunderbolt/tb_regs.h |  1 +
>>   drivers/thunderbolt/usb4.c    | 19 +++++++++++++++++++
>>   4 files changed, 26 insertions(+)
> 
> Any specific reason these were not tagged for stable backports?
> 
> thanks,
> 
> greg k-h


No; no particular reason.  If Mika agrees with them, I think they are 
good candidates to include for stable too.  If I respin them, I'll tag 
accordingly.  If Mika picks them up as v1 I think he can add the tag 
when committing them.
