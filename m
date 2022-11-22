Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C6C6342B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiKVRn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiKVRnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:43:13 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6EDDE9F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:43:12 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMFnIdO011187;
        Tue, 22 Nov 2022 09:42:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=w6ax4P1uGXiDIlVRAANZ0dTzU8nMz98ytWYb1VIJhuA=;
 b=Fyn7ZEG7ZyZ5OQXzl2jLbpl8Wr9pwBNK6onLSCEmKrUNjGwZFAKqrGphblRm+F6SLRTK
 /gHG7ebCeyjkNVejMfcAb66rZeyHpdCkwBJYvhTmKDytDKGFmq5Bd0cGFOFtorGM1AaE
 BV4rxBb6aVIeixIOIPty6zCe10laQK0pNNzvWG6rt8mm8dSriCqRCFtRlEtMX4oftuly
 mCXfilFmYar8JP9LVEpRhQHbw/J55FLNI+DRm7TGCzfGEdJs2GUQrxI7zX8PinXexewQ
 4ChzquvRgF/9B12nPALc3Iwp+GPl1cAw8vf8Gk+rnqjkDF6AMF+mXBSzY3dYu/6X1sTn 1Q== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m0j8bpeay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 09:42:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcIQxBzvPFpn0VgGA1gJed5WJ2UhyBDr4+N2Ay2mpAb4xo5+fh+TVpwmDNNwVKrvf2Ha8NNq+2m5tvwLJIrL42G6CWrs4fvl3NbHlkgj8IUZ5pWeG/WdHu4pmhBNlVxsRTfD7fF097IIu63c64CjECploR+AlRDEtN1/lez8wyZZd/8iiNWPdnpRzIbFqjWBFjah5Hz82aqPwMnZZ+wfEM7ka5XW3eWTlrLFM9MEet+xhJNm9DY1amtJTKEk5p7Q8D35QMG9l2Vj9ppAd3QfkCvTmG/HdcRK6lE6P8nAyDOy9lknJtHV0ZpZtErZRMuUnQKy69Q8ZDpp2QHkiM3aTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6ax4P1uGXiDIlVRAANZ0dTzU8nMz98ytWYb1VIJhuA=;
 b=QDVTlTD9Vh89Pa2REdsbhLMjOdbpZnV9dyafTvaZFel7oUkiERfIDAaEYtbF4lCFOyJMe7osfRgFWjx3PYAG5Zwcfzfdcr0NZO/DeAPasNHGw8FjjOXDCQN4you95tnV0EmB90FEsi/ig4o6Q+ao+CaownPA5sQ/dRBh32LSLF5A8t5hmoK2OsfDsdBknh9Bj7IdGkMpzpePsCfokrMfftSuMgUQA1jezRiRLOc1zsr5jD2AOYhLlOIy4uUwRfqPyvjDDlArecx1MI8US4n32uLmQOM4e+ryru1YnPi3ccBBMGKcRA/muXGmem2X8nDSLrp7J7n8/XYTCmfEbx0OGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by BN8PR15MB3137.namprd15.prod.outlook.com (2603:10b6:408:8c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 22 Nov
 2022 17:42:36 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::563a:dd91:dd5:6a8f]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::563a:dd91:dd5:6a8f%7]) with mapi id 15.20.5834.009; Tue, 22 Nov 2022
 17:42:36 +0000
Message-ID: <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
Date:   Tue, 22 Nov 2022 12:42:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] error-injection: Add prompt for function error injection
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20221121104403.1545f9b5@gandalf.local.home>
 <Y3vSQo85ofkfD/L8@zn.tnic>
 <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
 <Y3ymzAYRyH5IWEe/@zn.tnic>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <Y3ymzAYRyH5IWEe/@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:208:329::16) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|BN8PR15MB3137:EE_
X-MS-Office365-Filtering-Correlation-Id: df71f960-4b98-4fe5-8d49-08daccb0f11d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: feNTNT39tyTJ8yfCCfE3Xf7LG6GHy2vxi+qik5LCCje9ZCpLeZ4wk7guMaFzRuitfU+EDTkHXsx/kz9uCDFH7PCgnMWaoxYS/1y0H2/S+eIyTxL7vHFl5LkPw+bGNWRVRpxnEhLSj7pDdBYJ4kdt8YXv8tViGj7Rq6pcd3HdXYLM5qqgKxnxrkaIWcChMOqN+7tsrLiVdP8m+q8UStcXWhfiUvGZD7eSMArncQjWP8tCjNQwXF7Fi4i7q7DFfJZ7jZ+DAxWb270OqyrBQ6Z0SJI+TzyONo5qNz39ruH5a/z+mw0KMR1CNgWiv6nkgxnqHvNbbfkWwWWyUyXyrA4Wz8kUZxUhIuZIG6Nlhb656Chag1JlmxHkpyWwn0crLWQVbdr2fC+xhhYUwaMCqUzsH5EvyDDNo0NGA6uKpm2jORfSGkFQTD+VjK9iZoeQue//MSwXY8MZOXLt6KPQheIrcpRch8fP/NNveQyT8izbiQhotapVW+MUNesUASj3BL6K7yULQoAbgPrWxVvHlnINW3lFa0suOz+MBT0kL3edTOCb7Mct7jodTBAEiayapjZPH29weBOeBZpknwkTTk/wc/9y8UjhzYFhnFWIhv+Q4WDjlVmCxw7qfr2DpMEeuoe/SetstYtBEB3GDMNfFjtatyHfooLqv3jLL8CkJ5GkcoR5LDobYnaTCcmYyV4/Cg/hIyY8z0rhH+Xbwqvs6deLBEMi9URD2qKX4QdcJMC8KY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199015)(26005)(6666004)(2906002)(83380400001)(6512007)(66946007)(41300700001)(31696002)(2616005)(8676002)(4326008)(86362001)(316002)(66556008)(66476007)(36756003)(8936002)(7416002)(5660300002)(6506007)(110136005)(53546011)(54906003)(186003)(6486002)(478600001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkMxWk9WeUNVZncxTURDcDhJMGZMdDNmV01QbXdhTzU2VjBkYXB2ckgwVXRp?=
 =?utf-8?B?YkF3NFJVZlFLWEZzRXRKUDlzV3hJd08vNGZlU0VWZXM0WE1EVTRZUXljaXVW?=
 =?utf-8?B?cStEZ3hhQUJBRy92NDhJbUtCU3JmMjRVZFBCdEIxMDREVmVTcGRPY3VDQ1c2?=
 =?utf-8?B?U2x1SzNnQzU1Y1haNC9rWlZnQlFsY1lsejRVNVFDZ29SVmJDV0Y3UFBucE5U?=
 =?utf-8?B?T0xzQXBJeHNIT2N5UCs5NjBUM25HaHFrTm1jOUNaTkUwbm9NT1d1WENkbkZ0?=
 =?utf-8?B?eHFxWktEWGltNnA2eEsxdXZBMkw1VVRTdXFIUUg4UWZJZFZFVkFXdHlJTGZ5?=
 =?utf-8?B?d2kxZDNrRUtlTVJPN0hhMEVEbHlUdUhxVEJXU0trb3kzQks5YkhYYStKUWo2?=
 =?utf-8?B?U0hNLzgrbWFXcFpmTGV3b0MxZWJMYnU2R3RZR2JRc3N3Q01OZDUvblo3N2hq?=
 =?utf-8?B?VHMvblRVMnlZS0VOMFlRMVVkbDJHSzR4ZlFGRU1STkFMYWtnOFRGd252c1BI?=
 =?utf-8?B?U25paGtqNUN6bkUzS1VnYThBVURuS3Zjbk5JSGRrbDk2UXZEcHZjTTdtNEJK?=
 =?utf-8?B?MHJHSGphRjJIejUrbkV3YnUwWXUwZS9UWW1KYVdLRWZBUlV6UFIvelY5RlZq?=
 =?utf-8?B?VzBGaXhheXpXWDkrcUNiVmx3NGlyeDNlY0VKeXYxRzRtd1doeksvWGNRdkY0?=
 =?utf-8?B?SENLQ2ZjdWpMMXRIaHBibDN5WWJEZktFL2NPSGNLSytLcXAyNHREcW1rQS80?=
 =?utf-8?B?N0xQQngrbDgxZ2RmNGxPOWZ6K0t1cHc5K0d4SWwyOUtmNHVIeFlhdmMyS2ZM?=
 =?utf-8?B?TjRQNGo2OVZKTmpvUXFFOEFKOVVCRDFRWUdVT2tuTkhxNW5aWlE1Um1Qa2Z1?=
 =?utf-8?B?NHJWMXBxdDcxNy84Q0l3RVUyTi9UUWtNdUM3M3EzdXNiazh1VFUzaE5Wb2c4?=
 =?utf-8?B?S1MrWmFUNDBqTUFkOE9ySmZ0SUk5SEJZUWpxQUNxRCt3K1FBOEdxS3huVnpV?=
 =?utf-8?B?aHB0Q24vMi8rM2VQR3FwRXpIdnR4ZmwyWVdnZUlLTExCRkQzMEcwSUIrQnBO?=
 =?utf-8?B?WEJPZ2dJNnJVODBLdnFjTzhEcmJUYmxvQ3NjR0UxbkZFdHZiNVMydDJPQjd3?=
 =?utf-8?B?bVNzS2ZMaGU5WVFhVFF2MzVvMW1LeU5KWU16RHpZZ1ZTc2EzRnJHM3pGN1di?=
 =?utf-8?B?MVBEa2dpUWR6L2s1S3dUdy9rVktuRE40cHhIYm5QWWRFWS9qL1RaY3NSR1FW?=
 =?utf-8?B?MG91NHZJdHBybXJ4aUFrMWRBL0kxTzk2VHdWejRyTFZ4NWwzN1NDS1dNUzh3?=
 =?utf-8?B?bUFTQXpEZFVrYm1oUTc0VTZKRGNYalgzQ1phY1NpYUdDYURzTG55V1l1YUxX?=
 =?utf-8?B?cTRXbmhUWmJBbWVkRG8xSGk2bHErdFhPSGs0NjZhRUNydnU2WGYvTGVUUGtp?=
 =?utf-8?B?cjlCazNjYlJJMDdQSzRpQkxjeFRzRFJFK1JQbjlPbGN2LzROemxHZkhSNzYr?=
 =?utf-8?B?YkYyQ0FBeVZZZHJrRDRiL0twYmkxbHAySmxpN3JPRnMwcitVcWYwNlBIdXdQ?=
 =?utf-8?B?WWlEeVJLTTBhc2U2bkh3OTMwazdIRWlUclB3N2h6K1pCVzRnK3UzWlA4VFRl?=
 =?utf-8?B?Wm5IOUwrQ1gyNGRlSmVnR3hXZXJHWGFMZnVqWnZJbEhkOGlHdU42OFRWVUxr?=
 =?utf-8?B?MjZ0K1o5YUszNlF6UUE4NFEvakFlZVZ4ZUQzaXBITTAwYlBrVGlyanR2MnpW?=
 =?utf-8?B?SThQSEdhbEVEUC95WTZzOGlFczR3NXh2N0VEUWw2N3ZUZ1ViZHdHMWp2aU4r?=
 =?utf-8?B?TWx0czZaRDVkY1l2Umxsbm42NVdpOTg0VVJMOUdGT09ibzJ3dTNDeVBoZEdV?=
 =?utf-8?B?N3BSS2ZBNSszZzNSejYwcUdrWjBzL1FqdmZtNnB1UllydUZUUUQvSnhIRTE3?=
 =?utf-8?B?bUZMaUNuR0JyWFlGb21Pc2draEN2MmFnVTROdGdRQWR1M2gyRERsU0RYTlJu?=
 =?utf-8?B?cFdkalBXdlZ0OG1MOVNoOTR4S1plYS9xYTNmVXFuaDV6cCtQMWlxUnRXNVNy?=
 =?utf-8?B?b1hNT1F4MTUvVEJMamE1UkZmQnJkVzB2bnBwbFNmZWRBNnVqT1RMSTE1RnF5?=
 =?utf-8?Q?NXH4=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df71f960-4b98-4fe5-8d49-08daccb0f11d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 17:42:35.9465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiP5/8kZG0xFpTmB5cwN8spVXewABQCeCTT/2gz4LB/pX+kvbRTq8TOC95+Fw5NS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3137
X-Proofpoint-ORIG-GUID: 2rW9BuewkKpK1ieLVJwGzhsMaW-1WmsC
X-Proofpoint-GUID: 2rW9BuewkKpK1ieLVJwGzhsMaW-1WmsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_11,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 5:39 AM, Borislav Petkov wrote:
> On Mon, Nov 21, 2022 at 03:36:08PM -0800, Alexei Starovoitov wrote:
>> The commit log is bogus and the lack of understanding what
> 
> You mean that:
> 
> Documentation/fault-injection/fault-injection.rst
> 
> ?
> 
> I don't want any of that possible in production setups. And until you
> give me a sane argument why it is good to have in production setups
> generically, this is end of story.
> 

I think there are a few different sides to this:

- it makes total sense that we all have wildly different ideas about
which tools should be available in prod.  Making this decision more fine
grained seems reasonable.

- fault injection for testing: we have a stage of qualification that
does error injection against the prod kernel.  It helps to have this
against the debug kernel too, but that misses some races etc.  I always
just assumed distros and partners did some fault injection tests against
the prod kernel builds?

- fault injection for debugging:  it doesn't happen often but at some
point we run out of ideas and start making different functions fail in
prod to figure out why we're not prodding.

- overriding return values for security fixes: also not a common thing,
but it's a tool we've used.  There are usually better long term fixes,
but it happens.

Stepping back to the big picture of debugging systems with bpf in use, I
love hearing (and telling) stories of debugging difficult problems.  As
far as I know, BPF telling lies hasn't really been a problem for us, so
even though it's a huge tangent, if you have specific examples of
problems you've seen, I'm really interested in hearing more.

When I talk about production, both overall stability and validating new
kernels, if I compare the BPF subsystem with MM, filesystems, cgroups,
the scheduler, networking, and all things Jens, the systems BPF
developers put in place are working really well for me.

If I expand the discussion to the BPF programs themselves, there have
been rare issues.   Still completely on par with the rest of the kernel
subsystems and within the noise in comparison with hardware failures.

In other words, I really do care about the concerns you're expressing
here, and I'm usually first in line to complain when random people make
my job harder.  I'm just not seeing these issues with BPF, and I see
them actively trying to increase safety over time.

-chris


