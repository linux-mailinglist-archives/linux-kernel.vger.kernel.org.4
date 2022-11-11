Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46566625B16
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiKKNRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiKKNRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:17:15 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70078.outbound.protection.outlook.com [40.107.7.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086DF77E52
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 05:17:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANXkdngUoHz2SdpUe5XRaK48zCD1icWa9slvhMiePhKHU6m0XI5L7GujXvabU9Z7yNz5Z49L01rVivVgxmw56KRJiySH/r1Hnlq95Ma+jCKW85d7QPSDCjhGJNA3lQGbR94CKqNQTehfeYdXVPde/5FVX5iF4JHEz/iqq+sPTa6Egpygg0k61bt4DAGnwRRheadOWhoBNVEUMjX/PNrQyUfBkun1FNBufYXnFZP9bhK64ruoGyDcj8bjZTTilsibTskRHerlG0noIh3Ds7xGx0oHAMzJmBkIbwh7fCTkB23gLWQyTn4pLlkkofwaarhnqaz9LN6UTSKuQHMzRli9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gVJNPOdGAhOJDsHLjXSVBNI9ScG0dhMwplf0lU6tTs=;
 b=IomPxy1R+MGiXjxz84+K9v+8a0dN6iGd+ScY3BwJ9wFGXBa+dq6UNff7JU97ltbuMyOxZLkJ+oNXPpBc/xzirNaw46tRnABngBn5plWtduRvhCXve4QqRCESEeiP//dRNeV9C3QD6H+Is2+TL86oeR5F02fetASlRryCcwkAW5hhlmLnO235Lk8o2mUX1dpRusiNjs2D3tfFmLM3VDAvSIg/ttNqeJpQZTXYuqRbfuOYvCE6r2u46OaFoTWrBjlSE6G4tlNBIhVyVANyOVCdxMxJfnhxSYCUo36RtZI6kPG81sVZPpdYKHjD/k8CICsknHio78qHL+H35oSHfJ4Lmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gVJNPOdGAhOJDsHLjXSVBNI9ScG0dhMwplf0lU6tTs=;
 b=wngRwgYWM92C4S3R0kit61Z8KJ5U5w+QWEI+Q3H2SML5QrzAQ6T2lAMde3/vdRjL8DKYRA1VPg4xXTmvxpw1CMH7iA42QrDQGaja2MMORMRi8nzqPx3glK6yh/MSTCoJaFo4z6PrZGuweGEjUa3Za8ikMilXVnOHUgHTsasmzen+WaO+/qKQli9/ZZSj/4PygAa/D9eQKWMg1LkcZjcFPAwJTHyxxW2aYBWJ7Pjfgy2EAhhLehCrnCg2gBtMNkqUvtLth0oyokabKfLKJ+xb8LvwoLp1cZVC2wC1jISCYyFUhnElmt1WZ2OrSDUnpkx3kIz1pIQtcLK8tSrH7hUJ/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 11 Nov
 2022 13:17:10 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8%4]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 13:17:10 +0000
Message-ID: <a5342914-e9fd-60be-50c3-60f29ee27b99@suse.com>
Date:   Fri, 11 Nov 2022 14:17:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        xen-devel@lists.xenproject.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20220729070416.23306-1-jane.malalane@citrix.com>
 <1918c63f-0065-b468-3691-de6e314f4374@suse.com>
 <e7341a89-208c-8845-fbab-cb0326cc0883@suse.com>
 <9ab99257-844b-de15-cd20-7cda61295186@suse.com>
 <2476e467-1c31-91f4-1e75-86723b8da486@suse.com>
 <3cd62b0b-a131-b709-4244-0ae694c3d022@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <3cd62b0b-a131-b709-4244-0ae694c3d022@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::14) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|PR3PR04MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: efbb3f72-791e-4c74-45fe-08dac3e709ea
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCbG47FCQl6AjfO2+RL0Lg6rguLhSfxGiQh30xwYB5SI7eLTCNLWXKQYDDMc8cXEw/9sYGMQFn0nCZRDMlEWtCsxbNAPIumgWL1TgHobeje/lH9AjeKgAkYcCY76kLxTBKGp08ahN82YgUyVfNcuHdrw+Z7n/+q4QZS66geQDhgajE5DpNdqgFNUH7Ed6NUWUtbKBUoPqYfLUXCCMmZt+zQpF8dU5PDBkgetqt6LsKrLMs7lF6hFixMn0bMQFTbApP9mUhLE6pVrXQnQnmODJ7LjEE+DHB/Eq/+7NIl7/UIwPbpn1/oM4wXCo7B2Mb43KMU/rg94+krGwR3ET/HxKsLuu2bWWns6HOIn4L/euw0Mshmd5AH33j+ihaSTiWcL9pkjJ3V4ZeddU9Ya1j2+yRxUm0ROu3J8xoEr4TCt+zuEgSrvx1Qpoc0uHaJp39EI6asR4jMKhGRnPUY4OKu4qSBbCkgtKF5D1yyZOqwKNP3DFHQKWjZt4zoKs++vz1kjjVj7NJZESkIX5YoLY2mLYyc8Wu5YaIFzj5jJ50rFx+y5g8dytmWKg5i9fqYoZ9CvXaOkzpkxRR7DzobHsWDD1kA1Rr38F+viHSozqcQV0JDUWn/iP2sgiV1BJqEreCkNtqKFH5lnRPncgtURKAa447E+smbaBUKFDoO25LIumXFCJWgLw7fj6EIvDghncFJR9G80Mc9QgCS7U9+3KltEHZyvcNITTPAj3PbSpsNu8BaN8IRaS06fL4mNZ4UWMhAnQAwPDvq5G+Ce4lzoznSt+Lz0APt8T7/UCfDl4R4rgsYsJoXamnrjZ9VgwHVYCuieNTTvfNWg8UaJQumr6miPsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(38100700002)(54906003)(31686004)(66899015)(6636002)(37006003)(316002)(86362001)(83380400001)(2616005)(2906002)(36756003)(41300700001)(966005)(6486002)(66476007)(31696002)(66556008)(6512007)(66946007)(8676002)(186003)(4326008)(6506007)(6862004)(5660300002)(8936002)(478600001)(7416002)(26005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NCtTa0NRdmF6VHh1cU1xVkY4MzQvSGZ2WE9RVUVRZENId002elJGOEhVdXpV?=
 =?utf-8?B?S3YwRVdyeVFZdWc3VWVZdzBIWmdwZllsSU11bDRsODBIM00xaUNVN3QycUZX?=
 =?utf-8?B?aEh2TU42RURTZ0ZoYkt1L3QwZmdEMGNUVDdKV3NQWFdad2lQbEpSczkxdzRm?=
 =?utf-8?B?VENHS29LSEdITXFCTlZwUlBIU2VVQ0ZhMzlUK3hBS3RKaHNZaUNPQUtZVzZS?=
 =?utf-8?B?N1hCSnlob1JGMnd5TlZubWwyL3FhWFRsU3hKTXZKOVdBS1hIdzhJamw1WS8w?=
 =?utf-8?B?MVd1eWsyUmxKM095dVBNMFY0Mm5IWVlaVm0wYVhmN1JYVjlJbW5SS0R4d3J2?=
 =?utf-8?B?RGtReVUzbU9Uek5aVm1vTDd4b1FmZ3JpeUR2ZVJwUVV6bVRoQnUycGtoZkdn?=
 =?utf-8?B?c2Z2QnJYQjY0WmM4OFdmOU4wblJKMmoxYlBuN1NER0JNMTg0QzlUNk1JRCth?=
 =?utf-8?B?ZDRXTStHSTBPNnhNSXh2VWlLaU4wZGwwcmNFNG5wMHRHZW0wZW50L1UwejJO?=
 =?utf-8?B?cnBhK2NnOTJFRHVncW5iWVF2Y1dqYW9ab3p4MDhIK0pDSmdWUEN6NUNVL3dM?=
 =?utf-8?B?V1hXalZzT1RtZ2x2RmJ1ZDQ0ckJSV1lBNWc1SFdhWVNoZitFTEtwTzJhNGo4?=
 =?utf-8?B?VjFNTzJHSUp0cE8wU25GNDZkZVRoTUQrWEcvQnFRbWthdnhhK0xCUjZHaVFG?=
 =?utf-8?B?Q3hLMDIvTkNnbEpIR0g5NFBvbWthbHdtR1ZkT3d1MG9PTWdTY1FsNSt5QXUx?=
 =?utf-8?B?RnNpODNIeGtWQ0oyenMySTd3UW1ZenJJMkpsaDJqY3E4cndYREtqWitwdW43?=
 =?utf-8?B?U2s3OVVpcVpEdEZwM2MxbXJSVStMKzgrMXBSQ3UrWStONkRMdU5NMUhjSis2?=
 =?utf-8?B?RmU3cHVLZURuNVRIOG1XRDJwTlEwcGRHQk5HUDF5L1J2cEFIK2NZWkp3N1d3?=
 =?utf-8?B?UlEzTUJkRDFKZFBFK0lmOGQyZ3ZIcTdHeWRiNlJaY0Ixa1JUOUdsZ21lS1cw?=
 =?utf-8?B?UStab0tBVjdXNVRuZHAxVG52bE5sQ1lDTzRQQjNOQzdITzJ2czkyeHhLaEM2?=
 =?utf-8?B?czRyRHEraHduSFVpOXVrbWlvR3RrWFU1U2VXM3dieDZUeW9JQ2l0dGlFVWZD?=
 =?utf-8?B?bis0Tk9SOEtPcjB5U1ltUGl5TjZtZkltT0lZZU05c2FMemJaVi93bGR4ZXlI?=
 =?utf-8?B?Y3ZCK0gwMW5RL2cwSmszUzhaQjA1aHIrNi93TE8rVmtZakY2ckY4Z3BtVkpJ?=
 =?utf-8?B?aHJQczlad1BxZndON0F1SVc5dzFGbWZIb0JSTFNINzVkUjA2L2x3RzRlSWFh?=
 =?utf-8?B?OTdBcy95Y3hRZmFxRXVuVGNueWRkU29HNlR3YXJrWk5XNnVZbklhaGpIZU15?=
 =?utf-8?B?amNnekRzVFdnWHpFWTV1NWFqLzNOODhvbmJGbkduL093dDU2cG1pejZESXdB?=
 =?utf-8?B?b1BnK2FaVGltZ0hoejBuTUxVRUpFTS9MWkxEUllzcmd3bUZydWpTcm00ZGho?=
 =?utf-8?B?M05FT2p0bStyS1ZqRCtaY3FHQ3lMdlZSaGl6RkNqcEVxME15QXd5c3daVDFl?=
 =?utf-8?B?aWhuTEJENTZFV1hEVXkzTU1IYVdHQnFXcDBZa0ptbHJiOEVvOVFaN3p6RnU3?=
 =?utf-8?B?blhKcU15RG9nZVlTbDBoOEY5ckp6YU8ra21kREE1bUtiS1NqNER5THlXVm0x?=
 =?utf-8?B?Q1o4OGZkZUYweGdsbTFWMmIrbnh6VllqSmdSYnNYeTFYYnVFNHUrbU9hZDVi?=
 =?utf-8?B?bkdHRXl0bms2ZUNna3Fmbit1blo1ZlNSUW9pMm13TEc5aHBWaEM3T3JZeFNL?=
 =?utf-8?B?MkdzbTJzVnNZN3Bucm5zNGNhQm8rb3l4d3hPZlNFS3RodWtwN3h0aUR1UFFt?=
 =?utf-8?B?Y3RGd0RKTVcxQ3RkcytxNnFtaWNnZDgwaGxvVUpoNUx6WkhnakdIdmVBWHR6?=
 =?utf-8?B?M2R2S0s4alc1NFR1eTFOTnYyS212TjZ1eW55b3d0alRmOEhTVXord3phQ0t4?=
 =?utf-8?B?aDVicGhXRi9zY3hlZ01TM2RIUjNaODM3Wi9qTHkwSVA0ZVRLUHo0SmJBTzZE?=
 =?utf-8?B?UnVTSTVYWFhDRmY1ZzRkb1FlNFdINFNLVnJBcnJKcHBDSnc0RWpDS08veXRF?=
 =?utf-8?Q?mvHoLO96GjUf++D47rotIFtq5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbb3f72-791e-4c74-45fe-08dac3e709ea
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 13:17:09.9118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfuH74SsjDif+Gm6NJAymNqZZgc5OklAZHvskt0ghbqSQiG923oi8CP6Tq6GPeQNT5NFZWxudd5ToLaltBU2VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7305
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.2022 13:44, Juergen Gross wrote:
> On 11.11.22 10:01, Juergen Gross wrote:
>> On 08.11.22 17:26, Jan Beulich wrote:
>>> On 03.11.2022 16:41, Jan Beulich wrote:
>>>> On 03.11.2022 14:38, Jan Beulich wrote:
>>>>> On 29.07.2022 09:04, Jane Malalane wrote:
>>>>>> @@ -125,6 +130,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_xen_hvm_callback)
>>>>>>   {
>>>>>>       struct pt_regs *old_regs = set_irq_regs(regs);
>>>>>> +    if (xen_percpu_upcall)
>>>>>> +        ack_APIC_irq();
>>>>>> +
>>>>>>       inc_irq_stat(irq_hv_callback_count);
>>>>>>       xen_hvm_evtchn_do_upcall();
>>>>>> @@ -168,6 +176,15 @@ static int xen_cpu_up_prepare_hvm(unsigned int cpu)
>>>>>>       if (!xen_have_vector_callback)
>>>>>>           return 0;
>>>>>> +    if (xen_percpu_upcall) {
>>>>>> +        rc = xen_set_upcall_vector(cpu);
>>>>>
>>>>>  From all I can tell at least for APs this happens before setup_local_apic().
>>>>> With there being APIC interaction in this operation mode, as seen e.g. in
>>>>> the earlier hunk above, I think this is logically wrong. And it leads to
>>>>> apic_pending_intr_clear() issuing its warning: The vector registration, as
>>>>> an intentional side effect, marks the vector as pending. Unless IRQs were
>>>>> enabled at any point between the registration and the check, there's
>>>>> simply no way for the corresponding IRR bit to be dealt with (by
>>>>> propagating to ISR when the interrupt is delivered, and then being cleared
>>>>> from ISR by EOI).
>>>>
>>>> With Roger's help I now have a pointer to osstest also exposing the issue:
>>>>
>>>> http://logs.test-lab.xenproject.org/osstest/logs/174592/test-amd64-amd64-xl-pvhv2-intel/huxelrebe0---var-log-xen-console-guest-debian.guest.osstest.log.gz
>>>
>>> I've noticed only now that my mail to Jane bounced, and I'm now told
>>> she's no longer in her role at Citrix. Since I don't expect to have time
>>> to investigate an appropriate solution here, may I ask whether one of
>>> the two of you could look into this, being the maintainers of this code?
>>
>> I think the correct way to handle this would be:
>>
>> - rename CPUHP_AP_ARM_XEN_STARTING to CPUHP_AP_XEN_STARTING
>> - move the xen_set_upcall_vector() call to a new hotplug callback
>>    registered for CPUHP_AP_XEN_STARTING (this can be done even
>>    conditionally only if xen_percpu_upcall is set)
>>
>> Writing a patch now ...
> 
> For the APs this is working as expected.
> 
> The boot processor seems to be harder to fix. The related message is being
> issued even with interrupts being on when setup_local_APIC() is called.

Hmm, puzzling: I don't recall having seen the message for the BSP. Which
made me assume (without having actually checked) that ...

> I've tried to register the callback only after the setup_local_APIC() call,

... it's already happening afterwards in that case.

> but this results in a system hang when the APs are started.
> 
> Any ideas?

Not really, to be honest.

Jan
