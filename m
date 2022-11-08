Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F91621953
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiKHQ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbiKHQ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:26:54 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594E91FF92
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:26:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItiLh/5psAZMOH05DdHITWuIMLdm+mKtg0NQAMzBq4p7HET/9cw9lzGdEKzW2EKxYUwlm+wUaPLTnPM+3OMO75K8KphTZW0i+AAH83SkDkLnZHbUbvTgzwvEzrK+FR6hKxB6FnwOjOnSc3N857Zp1FSTMgxT93XXu663gaPtsQQoFPLDsHHbHbwYnAqxDl94svP5tmy/1BuZ528cFV+2dTZW9NFgRU3g1c+sLSB7hR5pP3eNAufDAcfGQ4bdTfLw+4YpmwZGeOjnJmPzpfyyS3dDK1+TLPYRhj+ng9AYXx9zM4WEF/e6GnxbgaTqEDbZdhpMmlK5m9BR5c35FgIFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAXhsaK+O3tLaR3xyXOR3ZgFF+JyPfWygz4BOPrUTyI=;
 b=GtbCdtdg7eLMF9Mh60OLg6yo1TF8YcOB6Kk0+jgEYGvSr/X9qknOMIKapmLrvdaUsFj6yra5TiRcKE3vLlWjrI3+nuGfbhIEz1RVcSgJBlvv6J27slASQ9wtGsToPYVlKornkLqFPJD+hfObmXpwGhJAp8JpsGIZRPDyQJMcGWgYPZEnsySeu//jD+fPvQABI984WUWr7E4W32bCNRI2UypFOHmEnmIIto8SXEHtU6d7o7rJzHv26J3d5nElPi4YbLNOC5J9H5KZ6G/jFnAYiDkzLvC3tuss5d8thaXW5VXP8KcWQWnw4XAPzDDIRXKcnv32+oesx3OcKbxTWC2/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAXhsaK+O3tLaR3xyXOR3ZgFF+JyPfWygz4BOPrUTyI=;
 b=pZlKYBlIGxVHxY2Nh+pBy1S2Xcl/ic7AU/MLBMUpq+3K31vdv3BrinCM2tHcDcnSRSzqO5LJT0XOjs4ibAw4wlv2NN5lQ9Wn421fD4DROvey+MXrZmphNt6xfv66+QDwXTIHA8ePUzFGqTGOTBKzFa7kibKVDsuur1d8IabgXoEQpYhjkj13WH8LE6zYgYtTVZnlXueCGyZ0S4RGyPJgY7rFzxAZHhhgJ8dYNNqPA3K2+KqkXgSsWvsxYn9/FSwkdHKIZ5zU+bqv0FWTYNFQdwj+M0YajLuv3BIg9NpzpqomEoWdO23ovH2Nmjh6Pi+dqFYdYMp4g1sGbvOfNLmJQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by DBBPR04MB8042.eurprd04.prod.outlook.com (2603:10a6:10:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Tue, 8 Nov
 2022 16:26:49 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 16:26:49 +0000
Message-ID: <9ab99257-844b-de15-cd20-7cda61295186@suse.com>
Date:   Tue, 8 Nov 2022 17:26:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
Content-Language: en-US
From:   Jan Beulich <jbeulich@suse.com>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        xen-devel@lists.xenproject.org, LKML <linux-kernel@vger.kernel.org>
References: <20220729070416.23306-1-jane.malalane@citrix.com>
 <1918c63f-0065-b468-3691-de6e314f4374@suse.com>
 <e7341a89-208c-8845-fbab-cb0326cc0883@suse.com>
In-Reply-To: <e7341a89-208c-8845-fbab-cb0326cc0883@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::15) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|DBBPR04MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 30945652-f8ac-4649-07b3-08dac1a60934
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyPiagfpf2Ap/vTo7UcoggFEy8UuyfZi57UGQCSzmTsjVfdZSZfMNmOkJkKDxeCukmlNG2xAwSDW9cGW26Ast6HJGknj8MciE4TGPBdFzRdlFnqd5Dv4dSLC90jL5wS2/bLvQGV2iCc6biI3O7aELUWs9MQ84Q7He32q1vp6oPiE20Z0u7bIpU23GGnNQYuGzkEpTnumPc6TrTH8AeDiYzwilk9eF7l+7SHGuPHngEm91/r73LFeb1IgkEwn5aSaZKlu7knQVQUAHGz4G1OkZcbS9TmMKHr8Jt6k7Bng1W2GXhQ5+vxUiN3yrUg4AC82083i8Adr24eIB5haTBGgWMEd7J2HWkfvA79erHqwlKCV7oQzAP63B4mgyt7TcPo00xEeqbyT6LsQLgHTI+NL7NQt0fymRKa+z57r0Kb+wJnLcD8SbHceyrBjXwRiRXxhQytCheHWbHOs/gbGLSI58Wz20d0WsDo5zsNk6+aFcAD4DfgHQQo8yLWPxowUMkH/iCaOxiZmeo4YaaCvubcYSwSTmaOn3B+M5VN4KVxYPQnqn3rn2emPSgyxT8zG4BcTC5yzyW60oeOrImxYH8iQE2HFCxEDoj2U+cgqMgBZzz5AvelDBEiOFAJSm0JxReEHt/TjyOQXu67dkbVJJXPV9nA+nCz+B+kcRoPtPSna5VjP+E/+Fq/SkNIuKiVMoPFYDju43qP5ICodO0Kz3KlxG2FZjEI8pHw+W2GMYHXPZrZxkf/8pXo8LEUaEJkiJIqLdxS7MvGYxv/cQ1FUh49L4MWVCcrE2+giaewJ64IcFLLEjow8LJXzyl8VdW8lVpk/flu/9wj4VirRJnvKYo3e7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199015)(83380400001)(26005)(6506007)(6512007)(53546011)(2616005)(186003)(38100700002)(5660300002)(4326008)(2906002)(7416002)(54906003)(966005)(6486002)(478600001)(8936002)(8676002)(41300700001)(110136005)(66556008)(66946007)(316002)(31686004)(66476007)(66899015)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEl3YksydDM4bk1ZckRUL3Y1b2NjWlo4ckRnZERIWmJjUTRGc2k1WkZuRjdF?=
 =?utf-8?B?ZjAwVDgrTEMrUXNqSVpCa2RZeXY5UVpVMFNlaDF5M3c0UlI2OGpIcTNxaUJF?=
 =?utf-8?B?anpCRGprbnhubTNxNVpSZFF5ejIyTjJReWd2aUlONjFtMnkvUUVaNzBUNFZx?=
 =?utf-8?B?SitYSVFVRnRoNXJrR09qaUl1VHU3Q2FyRlRPY0s5Ykcza0w3TUJoeGZNTWU2?=
 =?utf-8?B?RzNGL1d5VFVJbFhoUjVHRjJYTytmMktoVWdzSDJLQnBLMDdvcVhkWWk2ZXJh?=
 =?utf-8?B?MEZ2WmdrUURtOUR0c1NDWDU3UW9kTExWbWpNSFhZNWU3SjBOWU5RYTA5d29X?=
 =?utf-8?B?Sm56OGovRmFZVFY1eUwybHBibjF0OUpKVlhuWGsvUnRUWjRLNlVoV3dlU2FJ?=
 =?utf-8?B?dURkNkk4a0ZFUGk0WEEwZ25haEQrMjBQOGg2VXRxL3ZoWGhEY2Z3Rlkyb1ds?=
 =?utf-8?B?QjB4bmVRU3BMYzhHMnE2cWZUT1ZKSC9WUjNZT0xmamROZ3hHNUlPdlhndjdF?=
 =?utf-8?B?Q2FJYjR4Rktjdm9IU0I3aFEySHpiTmVqaEFqT1BsTXJnUEd5QnBrbnlqc045?=
 =?utf-8?B?RG5KLzZ1aUVKcFBBZWVzUldtK2YzR3lIWVNXVmNjN3VSc3drT25QdEtNWXU3?=
 =?utf-8?B?Vng3MEZVdWZHbUtYVm5ZNXdFTDBhelNlMVlEdlpQQ2FWOG12Vm9ZT2pwWWdO?=
 =?utf-8?B?MjZNT0ZiMUs3Yko2TFAxWU9zWDJhSjNMUDc1QnR0bDhmdnZTb0k0a3RvbVor?=
 =?utf-8?B?YWgzcGlLWUp4MFRCcTRzUFF4ZE1NVFVxT3pEOFVScHNlM3ZSTTB0bEw1REhT?=
 =?utf-8?B?dlJIMnR2YmZoQnoxWUpJYVNzbUI4Um80c3lHUjB5L2p6YXYzRUgxK1RWSTVz?=
 =?utf-8?B?Nmc1YUt0ZU9qYmovMnpXbG4vL2E1VU5nK2p1WHZhZlh5czhESDhRNDhUUXY0?=
 =?utf-8?B?T2pjNDhoMS9pU2lwQTdVMktMdWVMTHpJSXlFTlVIUEhmQUhHUCtud3JjdEhn?=
 =?utf-8?B?bWRKZFlmL0IyWFU5MDliYm1aeERvbXkxSm1nS05VSm51clV2aEtaNlN6ck5q?=
 =?utf-8?B?ZU9wTGUvM3dxdEtlOVd0NE5kclpwZVdVbXJUejhwZ2FyZFh3UkRjS2ltNTA3?=
 =?utf-8?B?NkNNMkdpdGREZkJ4VWE5anpreXpMSmZEemRDZVYxc2pkdEVoUld5RWJqRzE1?=
 =?utf-8?B?d1VYU0NicWwzZzM5N0VudHhQQ0lNQWFPcGs5Zng3a1hVU0tZcDREZzRZV0xx?=
 =?utf-8?B?Ui9XV25mKy92Q0pwK1dTZHorUkk0L3Z1RXVRa2M5NEM5YlFlNWRHQWhvRUxV?=
 =?utf-8?B?TWlITkkvWGo4WUVLdUhyYnRleE5OUG5wNlBraHA3cDhwaStKd3d3OURMSk9J?=
 =?utf-8?B?TEhBWGQ0VjI1SFJkL0pYVFdmL3VVODBETGlKT0VQSy8wUXFKWVpBVUx2S2xs?=
 =?utf-8?B?T2Izb0VGN3RjcGdvR05aQ0ZtZlp6Y1h1TkF4eWZCMjkzdEVnZ3YrOXZWL1NF?=
 =?utf-8?B?S3FlY0pRWEtwVU1XeGFkUmwwejVIUnJEU0wrSjVxU0h4UFhabENrcmx4dC9U?=
 =?utf-8?B?Z3Bad2xYRURwMldWQk5oeTlEK0lzNDNKTmlBNlVwRmZFZ0t4TU9Ka3MvSkcy?=
 =?utf-8?B?c0dlVEdUSDgzOFNaTll3UHpTZlppQnhSUkR4L2QyVXROWnFtUFFVSGd1Mkdj?=
 =?utf-8?B?MTFxNlp6Q1FrYUJHTFgvYzkwLzYvaGpQZVEvOHNFUlB0OVB4WmxmZkhlcGhl?=
 =?utf-8?B?T0NvQXgvVzBxU0orQ2R6ckZ0L0hmaXFLM2pSVlZoZXNGcVd2eUtUdlJYZVBz?=
 =?utf-8?B?d01ZZ0VhTXJRb2ZhRWtiTEhSZmpranMrbmVUMkx2RzdzVU93UjJ5Z0RKM1RH?=
 =?utf-8?B?ekZQZitLRCtKQUZaSy9xUXNReSsydERML0NrWk1Vb1JzKzZvNnJLZi93UVha?=
 =?utf-8?B?a0lkdUNGY3M0L0tBY294Rzk4Vnk4OVlva3RPbGhqR2dJM0FOQ0o4WjNKSzFY?=
 =?utf-8?B?bUZtdFJYUy8vdmNoVVJaVGlRbEZka2NKakpXQmFESWo0VzJyMXRxR3YrVWdi?=
 =?utf-8?B?OGdBRlBZSFRnMzlDTjZkekZMN2x1NFdzeWVTQ1BlSm5ySEhJcVlTVHdUVlVL?=
 =?utf-8?Q?PQdmzKOIHbyMgMEDbvkwNLHO3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30945652-f8ac-4649-07b3-08dac1a60934
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 16:26:49.0889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vyuiw8/TNV/DaGFR1538DPSaSCgxpaUw6cte0x2qQIzUZGFgnXRQtMox6zxMCZFErHcmA5Tn2B6H4LFGVSVreQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.11.2022 16:41, Jan Beulich wrote:
> On 03.11.2022 14:38, Jan Beulich wrote:
>> On 29.07.2022 09:04, Jane Malalane wrote:
>>> @@ -125,6 +130,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_xen_hvm_callback)
>>>  {
>>>  	struct pt_regs *old_regs = set_irq_regs(regs);
>>>  
>>> +	if (xen_percpu_upcall)
>>> +		ack_APIC_irq();
>>> +
>>>  	inc_irq_stat(irq_hv_callback_count);
>>>  
>>>  	xen_hvm_evtchn_do_upcall();
>>> @@ -168,6 +176,15 @@ static int xen_cpu_up_prepare_hvm(unsigned int cpu)
>>>  	if (!xen_have_vector_callback)
>>>  		return 0;
>>>  
>>> +	if (xen_percpu_upcall) {
>>> +		rc = xen_set_upcall_vector(cpu);
>>
>> From all I can tell at least for APs this happens before setup_local_apic().
>> With there being APIC interaction in this operation mode, as seen e.g. in
>> the earlier hunk above, I think this is logically wrong. And it leads to
>> apic_pending_intr_clear() issuing its warning: The vector registration, as
>> an intentional side effect, marks the vector as pending. Unless IRQs were
>> enabled at any point between the registration and the check, there's
>> simply no way for the corresponding IRR bit to be dealt with (by
>> propagating to ISR when the interrupt is delivered, and then being cleared
>> from ISR by EOI).
> 
> With Roger's help I now have a pointer to osstest also exposing the issue:
> 
> http://logs.test-lab.xenproject.org/osstest/logs/174592/test-amd64-amd64-xl-pvhv2-intel/huxelrebe0---var-log-xen-console-guest-debian.guest.osstest.log.gz

I've noticed only now that my mail to Jane bounced, and I'm now told
she's no longer in her role at Citrix. Since I don't expect to have time
to investigate an appropriate solution here, may I ask whether one of
the two of you could look into this, being the maintainers of this code?

Thanks, Jan
