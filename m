Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC07F618309
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiKCPl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiKCPlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:41:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE80313DD2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTTlEDKHK6F7PLDfjtLtgiQIYTwMKB2NK3XLzkVUOp3QG6M4b8IXAR0a6DqUfxvlFu85OadpgCWor8a7FJzb2JZ0tga1s+xNdP+sAiZrUoGarQda3HGB39LDA1JwgbG4ZA1G+6aTqqGoH0zOpKvW7CnVS5/0/+JiSI1UqCYSW546on7sh8NXYyVfDzehT+82DwecDR/I64PMGulv5lndbpwQE4XnJLNgHnJ0z0N7odFgOYmQrqbZ3dNjPTsrHvehuvASj8HWuIy2jOvoMdPrizQcFtXutq2vJpKQIxX6B9kW0qKCiBLG024TcfFhZpHREKoYDK8qD9DrScSR/PmyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hmyyJDgZX+O8LBzevAvj94q2P3zDTo/q2+m2tXPemk=;
 b=XFcFDn8QnunmAO9/gE7RphsZTpg53Ehe9v+y7PryenFag555n2ICKlsC/dtAAjDyLhJF2mE0s7uUWb/W20I2OtzBB8DmnujbIkuYkEN9Thc1/T5ljlomG5vFxWK7pEqg/E8W6gg9zg9cdF5XVkBABFRu6YacVMXkb2u4kzKN/KOr0IxsN2HeyU/ztYcTYQ0pFUK/r28stm6vJOJxqhqBAnXoiwxxfqCQJtsI8GvCdtLisOi9TEzALvq17CDQGQsstgbTXfKHdLQOGCuRdWop9ApFUP9MnaQKSufWHYjs5VN/R4jKF8+5pa2eeU5/8h09IpVuvPlSm7IhIlELTID2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hmyyJDgZX+O8LBzevAvj94q2P3zDTo/q2+m2tXPemk=;
 b=SEV6zJzZST2Ey49GCuJnErx2jyNO5fCUh/sNxVJ7g8E8uiz6doR4xAoOKHTBpkE3ib4K1EK7F9Z+40hpFnu3yKxO6J/MGjIdAKA3LJE5v22wliL/jR7K5/2gRislFgVqCzMlImkX+imeBkgyXTdYh1n8UN91pGAr68qcoZ270zgBPq4t6HZ5wQnDCI+ziocEs3TplQ42P80vtH8UUYI0UMa1/51v6dDh3CR21DnYkny7A33Z+0xRSoWSnFYRcpPb+aOpp3LxHNtI8uoP0M2k+XrLwUPQ2uQig25XL4meYJKQA2sP815NIGVDQWwxmk+TH1iFjAHYr+cgOJ1op5fuOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 15:41:21 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8%4]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 15:41:20 +0000
Message-ID: <e7341a89-208c-8845-fbab-cb0326cc0883@suse.com>
Date:   Thu, 3 Nov 2022 16:41:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4] x86/xen: Add support for
 HVMOP_set_evtchn_upcall_vector
Content-Language: en-US
From:   Jan Beulich <jbeulich@suse.com>
To:     Jane Malalane <jane.malalane@citrix.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        xen-devel@lists.xenproject.org, LKML <linux-kernel@vger.kernel.org>
References: <20220729070416.23306-1-jane.malalane@citrix.com>
 <1918c63f-0065-b468-3691-de6e314f4374@suse.com>
In-Reply-To: <1918c63f-0065-b468-3691-de6e314f4374@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::15) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|DU0PR04MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 2226bb3c-ec66-4738-e682-08dabdb1db00
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4aFa/tXcH3M3RSsGsAHkOhm0MzmyOgKohsrKdUuPEvviNUuaEyjhyhhtucyUFc59rkchqy+XIyALWvllgUoTe2E/PvA0wNGI63sqBZmodnEF3tbx8QPIlJhU0QJ7nXH0ZSkhWcddZZWMqstBCepM0tUwMIOoSEB/ymkjaqlJURWxyZvE1Pdx8zAGFFtGnAVznRfh4dLoFdCV7tc7kGGDqe8pC89A1NqENon0tREEsycsn6QcX4jmQBMM5bPKZDC3+R2GdAjRLBw95TAVAun7yMg2XAWDFmcnYNPU+YVpZ55YU0UuoiKB1GgVHnqm++oNDuqtdjxxzm/7To1nttJCFCMU9L5TfR8hoPdj4ju+1Wyjl+Zpmhhp8TIJR4P1i2ngC8LhSJzo6JqRLg7G0Lp900f1NF+dS/7uf7oD0zQAG54dHAQPuqF/Xk/uAYit9/K2xodpoDnpwDtveDjMrmPvHSpfEejZQGSHZp/1SKEnk1FIY9jvENwARnvf1blp5jR1lD2gVAc0rsiTnW+GZCkhkPat6QgcF1akvyFxyr5UqrI8fZW1b5VoyKHPdgww67YpnBQcwTmzk3Y/4sXlQjzlvef+fmaCwW+d0tVLW+LqrLATcnlnz9wLAxAfs/5Aly5HqHYzXxCGNTlZlmbr5dJ1b3euSNBck/ggcw/C46VTd7NszKWYIJxFuufqlhCzbG+2iv9hzjjy13faar9cujGulQixP6v1L6GW833103dJv+cPwT+hfQNmQCz7MLZyYtOSPyDxfrzlOyOLjFfy6K8PbVwDsBWg2XZEaAj6JC9gbMCYtS1oq6Gj3K3vAeBc24WCH8F9w0ePhnrTg/yKBHq4Zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199015)(31686004)(36756003)(66899015)(7416002)(38100700002)(5660300002)(2906002)(86362001)(83380400001)(31696002)(6512007)(186003)(6486002)(2616005)(6916009)(966005)(478600001)(26005)(4326008)(54906003)(66476007)(41300700001)(8936002)(8676002)(66556008)(66946007)(6506007)(316002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk1PdmpyKytBcE9KUzN1S0oyTnJGdlJYN3BZU3hEZnloczgzTGYvQ3c3dHlY?=
 =?utf-8?B?NjFQYmJnV05CcTUzR3huMzN1WE0rT0xiRXgwaEdicEF0VFRJMVU0dXc2UllJ?=
 =?utf-8?B?ek9wSis1TmwwSURjako2Y2VsQTFrZkhOK3dYa0JHQkp0bFBDWVR3b2hYQ2hC?=
 =?utf-8?B?YUUzSU1xdE95cFBnWnRwdkt5TzNVeEFxYW5Bck9GRUFmMmxMbk1MaXkrc2Rs?=
 =?utf-8?B?dlF6UFl4Kzk5YWFJTklqSm5vR1kzMmtIV2ZqUlI2a0JoOVYyMnF6R0NXaWIx?=
 =?utf-8?B?L0JwRzlDaDlMZXlHU29OYTZBNDgrMjlrdk5pdU05MFZxb2w1NTI3S0lSRzI3?=
 =?utf-8?B?Z0RyenpNNUp3TFhVNHpsVk1SV2JlSDZ0UUhxeGNnbFBreHdpRWlMS3pJUGU4?=
 =?utf-8?B?T0daMVdaMnNPbUhtajdJOVBtVldES3lkMzVpVDQ0a1dlQUdCNVZ2b2VCQmhC?=
 =?utf-8?B?TTZZc2RTTVIreXZ5Y2U1eE9jRmI2ek5TWDVYOWpDV1kxVllHM3RybHNSM3lr?=
 =?utf-8?B?NFc4ZHBIOVZpZDBod0g0Y2hoMytaYWpkUnJyNWE1K01VZHVPd2hFV0xBekNO?=
 =?utf-8?B?Mk9pc2p0MUIycm8rQ3gvSXpuWUV6Yk5IS0c3eUE1b2VkWjdGQWFhQjdsbkhY?=
 =?utf-8?B?d25oWnNvZHE2M0xJck8wUlhxVVRqZmRZLzZhTERnMGdQUkVSRVRQbDVKZ2Zo?=
 =?utf-8?B?QmluOTNSV0lydUlMOTdjdStXNFZXZnRzQnN1Y2tNUlBkWWFRTnRYNU9pKzZx?=
 =?utf-8?B?RUl1MDh6YXNuQUdVMDBmTStIVk1heEFMdDQ5ZXA3Z0RLa0V5Q1lpNVN6Q1c2?=
 =?utf-8?B?SXhnd3FGdWx3SStpbXV4cjVvdnZKbFFJd21nN2lkNFJiRHZmUGJSSjFhSkFa?=
 =?utf-8?B?QldNcVRqZEJ3SmZqYnZkTTdYNG9EYWo1MDAvQlBjTG5RWGxZNGFCTS9jdmF6?=
 =?utf-8?B?a3FXQzJnN0pGK3QwYXo4ekhXcUZYQmZNWHRvY0xNMFY1UHd5SkE1dlVkS0tX?=
 =?utf-8?B?cGk4MWpXZEwwK09lTXI4eWNmdXp3eXdHbzV4ZUJ4N2lRakg0SHB2UUs2M3di?=
 =?utf-8?B?RjFmZlRFLzJ0SWJwTkdacjBsdXVvaTU4SDF5RWZCZDMxUDlvM1dMdTlydWNl?=
 =?utf-8?B?ZHVhU1ZQSDBPNWQzQ1A0TElGaDJnT2I0Y0E2SUlxS0VhQ0xXWHFOSjhiMHhC?=
 =?utf-8?B?dHJoUVFRdE1MUitvNDJ6TThmOEczekJGTHVjakhwYmJLNU1DaCthZWFpOEFF?=
 =?utf-8?B?TU5IWnRPMWw2cUJ0SDI1MWxCR3hDWUlHdW1xdnE5b3FacDZaVi9LYWJ0VlFk?=
 =?utf-8?B?bjRvZEFldTR4bE81bUEwY0VYSkRTUUFQWVFxdWF6S2dJMmFBRlJNNTRHbW5E?=
 =?utf-8?B?VmhSc0NmSkp1TlFHeWxrN212WnpLRU1XRFVPdWczVFQ4RkhMU0JzWU81bk43?=
 =?utf-8?B?c2R2a1FJSzI5VGU3OTB3MmdsK1ZIbFJXVGZEUlpKWVNPajFkb3IzaGYySkhY?=
 =?utf-8?B?TFRNSlhzcitmcjBMY1luOFNaTnd6OTBNaGJmcE03NzJRWjBTV1U0WjFnRTAy?=
 =?utf-8?B?WFd5R1BRdXl0QkVmQXhZdEJVbVhoRjR1NWQyYWtqaVFrQy9qc0RMLyt5OE9a?=
 =?utf-8?B?Qzg5YWlyaVIzeDhmd3lMYmRqWmZHMTR3R3huY2ZjSzVUQlNHSk9mSGw1MGlU?=
 =?utf-8?B?WVVoU2FMZFoyUExwLzdyWUJZMkVWYk9zU0VPSitRRjVSSkFxQlZXcTFFZFVH?=
 =?utf-8?B?VGFtTVdMM2lCVTNGV2s4MkRNYTVjMEpmdHZNQzdsYjlGbWY0L1pEZ2ZZcmUx?=
 =?utf-8?B?QytvT0d1UldaYmJhbWRkZ09BZHhxM3cyWjZqa3Zqa3JEWUoyV0wyN0VzU1pm?=
 =?utf-8?B?K0dYZDE3ZjNJRFhGK2kwaWtWc1A0N29FKzhYN3hHWkRzSXB2bTNmaVI1b05u?=
 =?utf-8?B?WkoxV0kyK3NicjJkcTBhZ0FDZmdzTmRZR040Z0haVTc4c1FQVU1aRnZvMS9Z?=
 =?utf-8?B?c0MrTmhWei9FR3dRZHpnT1Zid1dKMWF0OFhQYVpSSndhTko4ZGc3QUhqc284?=
 =?utf-8?B?YjFKWjk1V251SWpBc2VXQnZ0akUrSys5Z2tmcGtLR282ZUhWSTBSOXBuS1Z3?=
 =?utf-8?Q?ItHdY98FLNXe7Di3gggf3XrTW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2226bb3c-ec66-4738-e682-08dabdb1db00
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 15:41:20.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDVNdi7mCwnlptPV9/Q2uSZKne8iQVH1ZlRq2dZeLHaAl4QaIcLmsLnjSfmfAtWbwFyJsptnZDZsLkfnr9uc6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.11.2022 14:38, Jan Beulich wrote:
> On 29.07.2022 09:04, Jane Malalane wrote:
>> @@ -125,6 +130,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_xen_hvm_callback)
>>  {
>>  	struct pt_regs *old_regs = set_irq_regs(regs);
>>  
>> +	if (xen_percpu_upcall)
>> +		ack_APIC_irq();
>> +
>>  	inc_irq_stat(irq_hv_callback_count);
>>  
>>  	xen_hvm_evtchn_do_upcall();
>> @@ -168,6 +176,15 @@ static int xen_cpu_up_prepare_hvm(unsigned int cpu)
>>  	if (!xen_have_vector_callback)
>>  		return 0;
>>  
>> +	if (xen_percpu_upcall) {
>> +		rc = xen_set_upcall_vector(cpu);
> 
> From all I can tell at least for APs this happens before setup_local_apic().
> With there being APIC interaction in this operation mode, as seen e.g. in
> the earlier hunk above, I think this is logically wrong. And it leads to
> apic_pending_intr_clear() issuing its warning: The vector registration, as
> an intentional side effect, marks the vector as pending. Unless IRQs were
> enabled at any point between the registration and the check, there's
> simply no way for the corresponding IRR bit to be dealt with (by
> propagating to ISR when the interrupt is delivered, and then being cleared
> from ISR by EOI).

With Roger's help I now have a pointer to osstest also exposing the issue:

http://logs.test-lab.xenproject.org/osstest/logs/174592/test-amd64-amd64-xl-pvhv2-intel/huxelrebe0---var-log-xen-console-guest-debian.guest.osstest.log.gz

Jan
