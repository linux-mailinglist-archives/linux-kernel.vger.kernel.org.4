Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6ED64C4E9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbiLNITI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbiLNIRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:17:42 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DBBE09
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:17:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAuZK69/8C3NqlJTxfRrHSBTD1QrtkjoFOyPqef0PJqlqQNhnxzz+QWT++OxJLWET2a7+mNLd9iIl78Am6d7n9wluuzDW1lkGydJrBCroXzWQtljOmRnrS9hkXfyhnis/JHOoPFS/h8FS20BzOHyd6Yh6lvTjt7TOW03EHD/7WD9FeSWqPrj/evdHpDVGRK3+ZUZi2liZ3jPRCDwQ1fvQFKsvQW+DCQ1ZWrQ+7a3iUwrZn3JB14LlImfrYsX8Gd5zDogckE0EwpDm7udR3xWdzMUC7HOuzTXlm4LmpvP+he51T6GgWN2hx07eVxgbEVYAMygbWUNN/ydzVAk1q2W5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4MBS3XTcj8lsac6eceq+OnUKOQ4/NzZ3T07a5HQShY=;
 b=J4m1ckZaUWOZWNMvqMr5f+R7y4SFWI+V+KMfVEQQwd8+8lL7SxlcohJyLXaqXK1qEIkoTJJvAhMzWTkBq/Te5Py/1kPAZ8rz2l+RksoSlOJFWBDtWnRy3EZQArZgvXppK9YDdSX8UJvJANt/8oXCp/K0TXg/gM4ASDRUh4X64eqhOR+/AY6TQvqaF4B+Pld6zg0TvgQaoaJNfqbysFbLv5KM37n7i8sms4w7IxYhsa/n8JVX1Ab0fz/6BHRCoyHaVuxTJzTQlS5p4XPUG4lFxTabcU4HD74gSW57bIK0fxlv/RbvPyCgooJI1fUc6prC5wNfUKsxmUKhL8m6Bke8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4MBS3XTcj8lsac6eceq+OnUKOQ4/NzZ3T07a5HQShY=;
 b=5WkC7DbV+LaddJzCT86WCNR6DjOJGEOcZGg1bOtSrbQOabMxW3sGTKubRELHne+HGL+jrUfx/3Y7vgjBeiLWHzV6vj4uvCDbedWeqP53Bqq7P5PtiiWELh1r8gZHxlRhtLeBiAN1EoJo9F9X7A7ktAOb0ZnL7ZtkgVU20/LQw/Ftw030tBjObeX3+eGKfTFBsTPgud1ygSodFv2n02W25gNuOtKhGhxspeH2J17nq1qQ/VJvSLZpy5LpMycQW8+An1bmGnmiMastHpLR3iy+edkSxnYX8JaBfCJIdmMZU6VWkmqQbNxYPiEkMizc46jwcBnzz1NGMbuTgbfCfPAAAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AM7PR04MB7096.eurprd04.prod.outlook.com (2603:10a6:20b:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 08:17:26 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::4da2:ea8b:e71e:b8d8%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 08:17:26 +0000
Message-ID: <9bec6472-1f61-8b36-102d-7f7c884be869@suse.com>
Date:   Wed, 14 Dec 2022 09:17:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH linux-next v2] x86/xen/time: prefer tsc as clocksource
 when it is invariant
Content-Language: en-US
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Anthony Liguori <aliguori@amazon.com>,
        David Reaver <me@davidreaver.com>,
        Brendan Gregg <brendan@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20221208163650.GA3225@templeofstupid.com>
 <1e6c1b08-d573-fba9-61fd-d40a74427d46@oracle.com>
 <20221212155730.GA1973@templeofstupid.com>
 <20221212160524.GB1973@templeofstupid.com>
 <1eb6048b-bf23-78a0-9c3c-54bbd12c3864@suse.com>
 <20221212220519.GA1935@templeofstupid.com>
 <60582b25-4fb9-a2c8-9db3-9b5593f039c1@suse.com>
 <20221213185842.GA1987@templeofstupid.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20221213185842.GA1987@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::15) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|AM7PR04MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 986f6ae6-f606-4e94-bda6-08daddaba2c0
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6lblFOAjfJvopnMfxiMVeXGYwU6l33TZbaMC25+ODHFbAzIg4VT1btVesuUL9rXrDzASnhC56odrxX9ckYrWma1cS1Mu7Kz6Jmw2ZMOQUrGq7kv1+GZb/FosM6g86SD2Dud6liKObpZXB8yM9eradlrlJKelIOzkNBSZaGMwGjYjJ2ch69reZ0OAs+zaK5gZlvbRXTpuT4qZdFfFoA+tzSZvd3kX1vRJrKR2E3bMYSfGugazEbxaiGtDBn0Ok+hLbIrLJYRWuXzauEVdQiCct/NUL6X4oknL+P0Ut/VtzWlqkaP5crBS0ppZUw+LASIh/rdw9nLyI4MQd5M8lZf9YVqNEDMfDQ0j5fLXiih17Qa+yWhA0cCtLHU9F23p+e+SVDO+GAaiHMi51RiLeGXRYSC6OcWjQGhfZj9HtK1Bcy4j0i/EaMx7DIf7Tz4FSYp8KkV5ljG3JeM+nZrGkA5PkuwIp/GgGYfvse38Ldik2JAqnLVpQ0QfqLu+01GCxHcak+aTnqX6oA9xhFDEeEBhS2uU18BI1LE2l837zpd4r3uLRk6U8KGDSmQbs7CehImkxcU4jT5J30/+4HNpWb+5MIW43SBB62qdP+vmXzdSdK7DbuicBy6zvfM2HHQKrGEPhwq9TVtXEH52rTgqw4LGt66ZBYwE550gN8fa6JNO3cJmStHqNh/7tSu1zLMz/icxwsKIUY1YjKeReWseb25pwDkGX8+MF3Z3eRoZ2e6p0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(38100700002)(5660300002)(7416002)(8936002)(186003)(26005)(66946007)(66556008)(36756003)(66476007)(83380400001)(4326008)(8676002)(41300700001)(86362001)(2616005)(2906002)(31686004)(478600001)(316002)(6512007)(6506007)(53546011)(6486002)(6916009)(54906003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlJTb2JJNG02bFZ1eEM3MStXenFWUWFXNUdaWFZaSk4xeXU4N0tFeW52RkNx?=
 =?utf-8?B?cloyeHJnQUR2cWFCWVFXV2VZMjE5M0JzSmFJcXJrdlFqRTJEYUdDbC8wUytw?=
 =?utf-8?B?WEtJSXZSZ2l0Uk5PTC8yQ3ZNVXIycUxIb0NuU1RmN0Urd2lFVVZnVjBwVU1k?=
 =?utf-8?B?NFByTElPQzB6NEFrUjQ2aWMrWUJVdkZpZmhrekxKUlhpaDB4ejNubjV1RWd6?=
 =?utf-8?B?Lzc2dUs2cmY5dXBYSzNXTzJhbVBvM05hNXFpdysvSGJjbHA5R1hZWFJrWmhZ?=
 =?utf-8?B?R25MamZmWTFYbFhaR3FaQXEzSUJ6dlZkUStVai9CQkx2N3p1TkM0ZHIxTVdZ?=
 =?utf-8?B?VElpTkNBRk9GT2s2UXR1REswMkZtdE8rWVFUZ09BdU5OeUVGRWV4ZGk1TGdC?=
 =?utf-8?B?bGVad1Zuc013RTNMTmRuYnZHUEZPVlBMKzBPVW51QXVPMDU2SFRvcThvK3l1?=
 =?utf-8?B?eEdmc1VJQXhkOTVUQlVRZDM3bGFvMVg2OGUxd3JVTWJiczBtTTdPRXFtalkr?=
 =?utf-8?B?aXJDOVgrajFVam9nUlpqSHRUUlN6cjRzckdyT2ltSDFNdkZNZG5OUDZHS1M1?=
 =?utf-8?B?ZXpXa1Bkam8vN0Q5czRjWjNPLzdHMGNmdloyZnNobWJwa2p5U214R3N0ZnJx?=
 =?utf-8?B?K3lJZ2lLdXNnSDB1ZFpwY2hobzN2aDB0RmhydWU1ZTROZ2FUSTdmTm04N0Z4?=
 =?utf-8?B?dVBDMUpCUDRGSnhEVEEvNHJ4YzBOejRIWWFTWVV5ekowUU1FbStDM0JVUUsw?=
 =?utf-8?B?V2pEOHU2U0JzbkpVS3ZVc3p2UzhHU0Rtak90eDRicVZhSjNLMG10bGdQYmkw?=
 =?utf-8?B?U1RIamx3NFBrVy9xWm8rS09xOTgwUzVLdEJmMEd2VGJKS01wSzNLRlRkTnZV?=
 =?utf-8?B?ZFFlczlueXAxcldidWk0akt3b0ZSK09lZXhoa2Q0UkJSTmZJNjFJa3B6TThF?=
 =?utf-8?B?VUVHOXo4TWtCRFZ5d01pTzh2K29PeFJZcnozZXVkNFZuVVh6VkpIdUJyQzFG?=
 =?utf-8?B?S2JyakJ3UlFEdmpCR2Q4LzgrWlN5OHJmSTIvVE1iaDNpTWlQMW9ISmNUVEp1?=
 =?utf-8?B?VVZJUG1uNG1FRy9Sait5cGJXZHR4WU5FM0RQZVBjUkZqYWd3MHlTNDBoZk51?=
 =?utf-8?B?L2s3bUovcXMzaklqcHVmQlpYaE5GR1ROUnFYaGErY1k0YXowcGdHdVl5azJ6?=
 =?utf-8?B?UXFWT09GcVB5ZWs4ZGlvNm84NzdoVk1RRXVuM1BKMFM4U3BpNU9nRklLWXFD?=
 =?utf-8?B?WGF2ZUVNcnAwd1R2bFl5N0F2OERSS1lpSVpZTGE2b3BKK3AyMDdjT1JBTHht?=
 =?utf-8?B?SHVPTnMwT1E5bVpHa0N0cmg1NHhpNEVsKzRsbjl6WUVXczExZVNGMUNHSmhB?=
 =?utf-8?B?UFB6dlJxUjZ2VG0rT3ZNTVowcVJINVVGYk1yMVluUGhRQWwxa3RFbS9iQ0ZC?=
 =?utf-8?B?Vzd1SUVNWE0wZ3VRajR1dzVERTh1ckNCckF3ZEt6SFNnUFhnVjQwK21UV3Zm?=
 =?utf-8?B?TjFPbVRuL1pWMnlhVUg5Q3hrNWh4MHgwa2JSSkxlekN4V2p2TlVLSTBSQnl2?=
 =?utf-8?B?SnZsZ0FTMmFWK0xLbXJrM1dybENiR29KTkhKOXZxQ2tvT040c0gxYUgzWkRp?=
 =?utf-8?B?Sm9tQnpIWTBnYUJBNTFtdjBDOXlIR24zSHRUdzVjc0EwYlNBMXBLSXFTWmNK?=
 =?utf-8?B?TTZKRCtZczVEdTBsWGVoNUorSGZIVU9CN20zVkcrK3BUUWk4MVFjYktzRkZI?=
 =?utf-8?B?UnpoRjB5Qmd5RWtCcEVrWG40RjRlR2tvc2VPcERMNUJSTWppV0NPc0ltN1dQ?=
 =?utf-8?B?eGkxUzYvRWtrQTBRWlFyY3lZUTBFbWlCSWFrbGpISmZua3pkSlJZanloL1FT?=
 =?utf-8?B?ZCtVRHpYcHFWbmk4VDJJcEpKSXY0Vjk0aWFxbG9UamxKMUJ6R1NWMVdTU3pS?=
 =?utf-8?B?djhjZ1owQWZQcFVyM1J4NnZGdU51blFlZlNFUHMvVDRrZFJQODkrZk13K1hN?=
 =?utf-8?B?d0xnOC9hZ01pUURhOUJEanVtT2JiQm9NNHVPZHk0bE5wOVZuT3VWYnZKTGd1?=
 =?utf-8?B?Ukt3MmdDTU9oZ1hnV2RuRktuTUk5bmJMVDgvTWFOMXIveERMdjB4TU42Qlps?=
 =?utf-8?Q?yP+pHAMq2aE/zu0fEtOBeEn2K?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986f6ae6-f606-4e94-bda6-08daddaba2c0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 08:17:26.7126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wFYGQ3b4q1w9HZgsaY0PfGSnLkcouAVT/ZoChii3NsIRiAmSWGTap2GJAWJxS4mxxXQ3fKPyJzK4YwaO0AbpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.12.2022 19:58, Krister Johansen wrote:
> On Tue, Dec 13, 2022 at 08:23:29AM +0100, Jan Beulich wrote:
>> On 12.12.2022 23:05, Krister Johansen wrote:
>>> On Mon, Dec 12, 2022 at 05:46:29PM +0100, Jan Beulich wrote:
>>>> On 12.12.2022 17:05, Krister Johansen wrote:
>>>>> Both the Intel SDM[4] and the Xen tsc documentation explain that marking
>>>>> a tsc as invariant means that it should be considered stable by the OS
>>>>> and is elibile to be used as a wall clock source.  The Xen documentation
>>>>> further clarifies that this is only reliable on HVM and PVH because PV
>>>>> cannot intercept a cpuid instruction.
>>>>
>>>> Without meaning to express a view on the argumentation as a whole, this
>>>> PV aspect is suspicious. Unless you open-code a use of the CPUID insn
>>>> in the kernel, all uses of CPUID are going to be processed by Xen by
>>>> virtue of the respective pvops hook. Documentation says what it says
>>>> for environments where this might not be the case.
>>>
>>> Thanks, appreciate the clarification here. Just restating this for my
>>> own understanding: your advice would be to drop this check below?
>>
>> No, I'm unconvinced of if/where this transformation is really appropriate.
> 
> Ah, I see.  You're saying that you're not convinced that this code
> should ever lower the priority of xen clocksource in favor of the tsc?
> If so, are you willing to say a bit more about what you find to be
> unconvincing?

With the not-for-PV justification not really applicable, the main question
is how else you mean to justify that aspect. Once limited back to HVM/PVH,
it may all be okay.

>> My comment was merely to indicate that the justification for ...
>>
>>>>> +	if (!(xen_hvm_domain() || xen_pvh_domain()))
>>>>> +		return 0;
>>
>> ... this isn't really correct.
> 
> The rationale for this bit of code was the justification that turns
> out to be incorrect.  That sounds to me like I have unnessary code,
> unless I was right by mistake?

The PV clock interface was specifically introduced because the TSC could
not be reliably used by PV domains. This may have been purely due to
limitations of the TSC at the time, so taking into account more modern
stability guarantees may make it okay to be used by PV as well. But
migration needs to be considered, and validity (for PV) of the deriving
of the two synthetic feature bits you use also needs to be checked (I
find X86_FEATURE_NONSTOP_TSC particularly interesting, because PV domains
don't really have any notion of "C states"). Note that e.g.
early_init_intel() derives the two bits from CPUID[80000007].EDX[8],
which is an opt-in feature for all guest types as per the present CPUID
policy logic in the hypervisor, but then goes on and sets
X86_FEATURE_NONSTOP_TSC_S3 (which you don't use in your patch, so just to
point out a possible pitfall) purely based on family/model information.

Jan
