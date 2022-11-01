Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A9E6152A2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiKAT6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAT6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:58:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A017A1BEA0;
        Tue,  1 Nov 2022 12:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBAuH/mOUMCSsTmJIYu9Dct3keP2DzPI3rHQAFKceuXHf+JLwogx3mdQzNE5N+Zl8ps0nDLMV1pAECaF1a+BLhCYNfwJX/D4+V0Pkr0sngJV26t41nOpA8iNN8MHaRHRhgJSWTMev9NhE40ynUme1nXa4TZ8FJ1sGgWbEkFIFqsVy5ASW3gU8gkGYNYnPbhrpgmFzW9IKw1D7/ZKS52mcb/mv/M/K3hDkRRWtmhrirurLRRmYTcTB9nBKMdwPN+Zk1PjTw0VU/9zXt+oaU31fhPtsIh1Ny1tFA3Ra2s5Pto2ZbMkxtjI7r90nl+LX02UgXdi+NS48ttLnIe3ZDWwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdmuB/CkmpbbaoUlOmQqUsc0Nyfs2Y2QnhEqVEAVP+4=;
 b=aXwReL8kvZVKQXaDzv7OLlADPwEAkZQZfVg+MUlhILXL9Sbl9kPWTty/UZLQO35XgwmfXweDiFROEAc5sD3UpYqN7JLq5kNvXpNrOJFUTfsK5CnUVj+p+6psJVkoj1nuwJAMkCBP+9eXF4wvEcDjeVhTK5KKKeX7No1B/VaR3uRofuSLcsGS11rwrasyolMp1GGwtEDfiLJBT64GwVq+j3nZW91bt6v83JZAltSBAA30INLx31UDqqeaqKTCaaObQlR2yZjPEoyHD+5VbhXvafMphZ55VMYEWUDkbJd8kM6n6TnBbVW9lCcMyLMresBpKQzw9fWzc3eGnmdowdbQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdmuB/CkmpbbaoUlOmQqUsc0Nyfs2Y2QnhEqVEAVP+4=;
 b=vrro04S1fAbe01Q0DlaMQbKVU4/dLMR4CQmQJX8Sic0wbj/3Airwzl7Laynorg6hwb8fnl3zbci/fwiVzndOui5yFbBKLiBGkVUN2MBFoPKpXfFDkssW0rddzQM5b98CbPbzrORBJNcrS2hwtFf7148OHDA2PJvbPxvPnLZ89o8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 19:58:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5769.016; Tue, 1 Nov 2022
 19:58:43 +0000
Message-ID: <23c353e0-078f-91e4-26fe-bf552319eaad@amd.com>
Date:   Tue, 1 Nov 2022 14:58:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC 1/3] PM: Add a sysfs file to represent whether hardware
 reached the deepest state
Content-Language: en-US
To:     Sven van Ashbrook <svenva@chromium.org>
Cc:     Rafael J Wysocki <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        rrangel@chromium.org, platform-driver-x86@vger.kernel.org,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20221031204320.22464-1-mario.limonciello@amd.com>
 <20221031204320.22464-2-mario.limonciello@amd.com>
 <CAM7w-FXAGki+k9aP0wV1Qs8dKqpPXgY9ZJR_a83ETrUF6ZRZOw@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAM7w-FXAGki+k9aP0wV1Qs8dKqpPXgY9ZJR_a83ETrUF6ZRZOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:5:bc::38) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd0377b-83f7-4047-4ed8-08dabc437aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jra/+7tezDP12KzMb3RmrXGbNf+Adeku1nwYI3MHH+4cNKJCDal5RWm9gJtwFEfU7neDZ67vQWnauDW9d+xKyyxFFEuoqID1xyvZA9tSQ6JybjiWWtq8mCHcz8EaUwRsKPCn1kmURyPCyunI1RrCJG/rlU7luLHfry6MH4SHmJkoMM1AOh811ebyYOqcKO+/ns12rus39/xbb4oi9NKfr5ImmrpVp7sZYcbM5JyCPEJwnEpZFXKtrXOIjOdIbHO5H+Ubm4bFPsHg5Dnr51DSYgpIs/4329eJEhR7m4VMPOXqHBVaRmvx8sKS44XDGtvJ72zw/te15g/jY5BUpUgtVKwne67KycFnp8QGliy5QzImsgBs+upqmENjGZhuAvpxDTpTg5GjkOCFjXym3mIxaQY/lqEs7RKu13sE9+7nHDwJ20lq3MmF7ccPnWXHO0TluMGt2K+apdkyGgwp2pZOxg4O9C441Rb4mrV+mbl7wNhqeO8UslWX9OB551C6wtjcyv2iS61M78iHwdSM5K80j1KXcMfVwaWEr8bsy2IrC1OVvY/oZfNPSbAHBcdQCgpMKwKqcS0jINgG7pusgb4G7KMSJ5KQwLzx9K0RwLrTzk5VR2rAftlGhpTg7Zb2sgfWxNfR3npFrf6BLaoxdPjISP+UdfHut8PuOQMIbdALAL9WMTB95zY2onu8PHXqaO3Gben1GqPyKTm/PPRUVYOIpx1nBOxEOpJV9XAr48raT203Rz2IzRC8oP2LqXCJSAQwl9xW5RLHNMWWZ4JFbOdPR03pjWoySHfpvmAijIZUQwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(6486002)(54906003)(478600001)(31686004)(38100700002)(6916009)(86362001)(5660300002)(36756003)(316002)(53546011)(31696002)(8936002)(2616005)(26005)(41300700001)(66556008)(6512007)(83380400001)(2906002)(186003)(66946007)(8676002)(6506007)(4326008)(66476007)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTdGVDhzUXpVUlI1aldDOWtsYTJCVSt5bGtheDE0Y0pZWlh1S3pVNE4rQ3Jy?=
 =?utf-8?B?bmNRanhUVFVCeE9URFNlVjFsa0dLMXZkcklqbitNbDR1WFlvZUFHYTJsNDJ0?=
 =?utf-8?B?NVEycGdpM0E2a1lNclMwV2gvaDZwY3hyWEhxUnZBS2YvdlZLS3hIK3VJMFQ5?=
 =?utf-8?B?bTUzZytNSmMzTytSaEFyNTBjUXdGZUlubjRxSFdmL3NaRm9BcDBVNHN5c2RG?=
 =?utf-8?B?SkhYWFV0ckhiT0cyeTc4b2cyV0dJNlpmVTdaYk5IMXRVRnBDbFBTS3lpMFRi?=
 =?utf-8?B?dDBySHJ1c1FmYzIvUmVlbHlvdjZkeDdUbUtBeUIzTnhXR1Q0bzNBWE5jN2FN?=
 =?utf-8?B?Y2p5Mzg1RmxVcFc3d3ZhZ2NlWEkydDBPZmdKM1B3UWx5R3VKbVVZU2xleFFX?=
 =?utf-8?B?Z2lybmVZSC9JbVROeTNSbmZGclFCcVZQaWpsS1BwZ3pLQWFvdHhuVnFDSTZJ?=
 =?utf-8?B?a2lNaUJ0UFJiTGI0aUVvZ0lBWEtsSSsrajNMNWt5ankvLzZlZTNlcEcya3hu?=
 =?utf-8?B?K045dFpadFVnU2VqQTdXak5CbUVLSEUwcllhYnVyWThjcEROcFYrZGpNQjE2?=
 =?utf-8?B?N0dONHg4K2Zaa3FqdnBhUzlvOU1RckVtaGkzOVpxdkNJUWtlOEdwR1Q5c0tN?=
 =?utf-8?B?N2dQNTN2STc0Skd5VFM5N2o2bUtQN3NlM3NKajJJSUR0VVhJdUVzU3NzSjdV?=
 =?utf-8?B?MVFMVHk4TVNBVXV1VGZ3aEdvck5SUzg2aEFkclYzZk9ERWM4MW9sNVZJYjZo?=
 =?utf-8?B?U3F1MkdPVzQ3ay9Mbkh1dCtuZUFoK09tckMyK1RmQXJnNVRlTGFmWE1JVGxz?=
 =?utf-8?B?SVJha2JqUG92VkRjeWJKcTE0OGlMVzZIN0tOMEpGdmtIZ1RsNUpvTUV1TWVp?=
 =?utf-8?B?enhaWVIyOHlMV0xxNlg3RUtnRElXbHZVb1kybTBqRlNRRVZNN1J1OCtab0VD?=
 =?utf-8?B?L1phRTgrS0l4dUhXcU5SSzNGYU1rS1Y1NFRKRHpDNDU0bUJNSTd4ZkpwMVBj?=
 =?utf-8?B?U3NjdnVWaWJvZElwdHQrNG1uRzJ0cnRqRTRyOUhNU0JGZmFIZW9vcmJ5em1l?=
 =?utf-8?B?QXg5MWtQZFNPWGJaQXBKaFF6MSs3UUQ1QXkxdmJUUG01WlFGenI2T2RkTXJK?=
 =?utf-8?B?a2RtMDBnT0h3SGRaemJQL2FXQWk4b3FNNU9PMlNyeEU1emhqYjVxbkFxcEJT?=
 =?utf-8?B?cjJhYWt5WlVHY1Fvck9LaTIzR1dxRi94b1JRZzhZQVk5QzNibGZWeU9WSHBw?=
 =?utf-8?B?YlowSzZ3L0pqNk9JSnExM2JTaWpMUWFMSjJTTlA4S2psSmIvUC93Q3VpWVpV?=
 =?utf-8?B?OGZqcllaa3BwMC91eEo1cDRGSER1ZDFzRFZxMW5HRFdmQWZoTGxzcmFPVUhP?=
 =?utf-8?B?amNuTnJpbHhJcVl6V3dja3ZjQmtERzhIcnNKaXNNWkVvVUhMYkl5T2x1REg2?=
 =?utf-8?B?N0ViZ1BBVUxkVFpuQmVpUXVKTXJpZ0N4VVBxZXJHc0FZTVZJeENLRUdrNTNB?=
 =?utf-8?B?TDdzNVdPeWZpV2dYaXhVMkNMblhUc1pBMkV2RDN0M2pmRUdEK1FNK3A5SHlJ?=
 =?utf-8?B?T0xYNUhqSjJDbURZT3VFRTh1VTFTZlI1azloWlh2c3NNUXkwenA2b010UkRy?=
 =?utf-8?B?MzhJNDdGMFZ0MlhFb1BCNjZrVnlDWExNYkJkRnZGNXBHUFFrOHZkcDBWTWtK?=
 =?utf-8?B?N2l6dWFaKzFiRzIxZmFEZDJNVWxwSXFXNGZEMkQ2TTIwNlZMSTdqdDIxaG5L?=
 =?utf-8?B?MG1DZHkxbmtZMUVTb3RkZzlwampBcDBPelZ3amRYUkQ4N2dEMzJVWDR3TG5K?=
 =?utf-8?B?MSsvUjdWRjFheEJqOFdHejJqbVJPa1lGckdXT2NoeU40b3d6T3BVbjhrUDdp?=
 =?utf-8?B?K0RpSzJ2NG1WMmZNN3IxN0hmTy9qbkdTeGlSNDdhRUhWc3F2MWhrSWdQaTRZ?=
 =?utf-8?B?dFlLdlNvVy9PY3hCdXBTKzFaVTR2SVBvM3Q5SnRmT2dpNEp6SzdBd0NzTGpz?=
 =?utf-8?B?cXhaU3dONGY0LzZ2SGg1QVp5SFN3YytMeWlLMWgwK0Ruc0FBK0FjUWZnTWxY?=
 =?utf-8?B?akdIWFFQSFU4aEY1TU0ranFHdUp4MkZJQ0I4RkczclNPYzFUNnk0aW12Qm4r?=
 =?utf-8?Q?tUix9FgQ2tZAPc+/NWxoKvrM6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd0377b-83f7-4047-4ed8-08dabc437aa9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 19:58:43.4967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcBHKL9Km6zG6OwCRZkhYqAC7j6H8yd7IeML3ciaHXLxcmXjhb+d9yFIviTuCKHfkUDXNzkpiI3ah8hX4tpD1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/2022 12:37, Sven van Ashbrook wrote:
> On Mon, Oct 31, 2022 at 4:43 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> +void pm_set_hw_deepest_state(u64 duration)
>> +{
>> +       suspend_stats.last_hw_deepest_state = duration;
> 
> I'm wondering if we could add a userspace notification here. Then
> userspace wouldn't have to synchronize with the suspend/resume state
> of the system when reading this entry.
> 
> What about sysfs_notify() ? Or via udev?

The question I would have is what kobj would you notify?  power_kobj? 
Lots of other things write to suspend stats, but nothing else sends 
notifications.  So why is this one going to be special?

To me I don't think it's much different for userspace to "always" read 
the file after resume vs wait for the notification and then read it.

To make userspace flexible to multiple kernel versions it seems to me 
that userspace could check if that file exists before suspend and if it 
does then check the value after suspend.

> 
>> +}
>> +EXPORT_SYMBOL_GPL(pm_set_hw_deepest_state);

