Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60725FF98B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 11:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJOJt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 05:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJOJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 05:49:53 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EB2101CE;
        Sat, 15 Oct 2022 02:49:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUWkKLpq0gHov4fEpr8k9myj6j6YOcgSxTe4VcXMkWvQrXA6qVlXmCJtns8j+kiEBd1IDPWZTM9o1HysN5BHb3s866CA0EsAHXTx3PvFZcYbQ84RAASOMpZaOz0BxZtup7VbqLw7GmmnwRmNLqpzSlgg3GXzmsBcZNvSL9oEXxVTwls0Wg5yxTM051wnYfEbXz9j1E7he+Nwrkq1VdgN+E7uo6uldsgUgIqWIu5Vn3KOmJT6DZp1IY1WFgIIyRFryHsKHB8fSD3qxvs2C3ZKfuLt6XAhKyu02fvepKdu/o7KV7nXdNVQ1acO66rz5qDdRjUIpHpA3ad7SUlS6iVpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0q3cEL5CmMh9a8UEAFrTkmT6aShTa8n3uwryV4bUaU=;
 b=Nbd+XAAb/IkmjLEjdYAsh6w7GcmREGffSxvP3SuyPs45nmYfohXnM1IJ3PqhCcUZaOx60KBvzBaWIZIrEiKLQmyguVCb9nHAsFGGG8S9FrCfjcNNdcg6usPm/SX0ov3wGOpOex5dcqJ8G7CU72cGxDFCW6JDEeJVOBC0pVUNdWkw8JVM/RonrV6zNdIHXJpGIwjPgmTwLYOzQyelKSaNfQiNyB3JV5MRRcSzIvUY70EhdEa5tT4PMyTZDlFr90h5sZvibNyNEaGq7F6sqlsYxDS9itZZsulLoxu3j45zEil3yGIBUkxKZpGJ6A0xvtIfy4FQahVrFqOtEhcDlQzg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0q3cEL5CmMh9a8UEAFrTkmT6aShTa8n3uwryV4bUaU=;
 b=pA26s6YJsoB1X7EPWx52joNorIbP8wRLDu1Rd4HsERahReiOo078mWsHDozVpkISpycVjwo7+VhqNJJxBiGhcZeA1XOqd6e9JRhII6ExjxKB2kj/DPsLqIwnsk6jJrH37OdGx8CnBgKg6Y9ttW/xagTlpQs8+rK7M8SrhPN7w0gjJL7Vf2OSEPolQ77Oeug/Iusdf3PUGO9yhECaRpiHZx1soak2gUAI2usoIuXAzg2oHV1/6gIxgKAlDUCmWUpQaBcIv4LLFMb+94VJ844/34wE0ZvzSRY+WSrM9V2gR3ExRWUgTlE3mZ+3wxcAIwjY8hhNrSBHqObNSYVM2XbV1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by DB9PR04MB9554.eurprd04.prod.outlook.com
 (2603:10a6:10:302::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Sat, 15 Oct
 2022 09:49:47 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::7f81:2760:2539:7115]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::7f81:2760:2539:7115%2]) with mapi id 15.20.5723.029; Sat, 15 Oct 2022
 09:49:29 +0000
Message-ID: <21491c35-a9b8-9161-311d-a01507dc296f@suse.com>
Date:   Sat, 15 Oct 2022 11:49:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>
Cc:     mcgrof@kernel.org, pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <CADFyXm5AP8pvXAKRBVNsZd5SUPziKBV0UktwORokuLU7c6Sbvg@mail.gmail.com>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CADFyXm5AP8pvXAKRBVNsZd5SUPziKBV0UktwORokuLU7c6Sbvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::6) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 206dda53-f6f5-43d5-81f7-08daae928d7c
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aH+4cq9p3chetXimTH/hx0f5GZGCKwtinyeIfiBzQXLQ3mB+nIiZ+WEU09Dh/7c3N91CcVQq9GTSSuxMDHE5OfN8JZj5b9J8s4TBgjOGDmHwK2mHYukZIvVLmP4h5irEaa06T8fOuIrHnHDm2/Z5xU5uqxTOgVZvWAQv/kTtjJOCNWs5zGp1551gz+FFm7jB0Azp5znhJjcIkJi8UthkBJ1QLqp8HVHpdAWQPiIXZvJsOWvTOC++mxaDzZiifL5erDEMyVz4L7Kqu/B1b0XhUdPlMdfQw17G5fKYLhMZdCT5iQArN3/8tsfeevO2uendD34NOQLnfuOK+YXupThzgddytrI/8hLe26opbVPCii5WjE/cfN7x30miSUPmRd8rvj9dcP7SNT7wBQ8l3nOVP147z3p7vEns5AYIGXf6qbcpqeLthk/ziwLqfoEVZNOdY8bDT6b5kFeQ8pauLU+mH5OF3As4zeNwgrHwQqWoJO86T/BdIxBNjaUDVlWJHyQSm3i4hrzHVQb7Tgo/Im2at9Oxp3ftzTqHGJGalLzdkY6A/4acAXqy83dNZ7iRZ117pbqy49oxss0CtVQ3X3pffYqjzZwzdgJEaCh49TdN0rZvbwVvrhP0TRwKNXT/oSx/D3I1HSWe0PQ6l9vbQDweKh6ZuUZ07w1lnBWdZV4t8iuaH3/NhJvfMkJtTck2qOwcPeqQHP8PMYSsnHjThRatf1qf56u+VLFyQGVo4XZ7bByIvsN+TwBU1QAo5bdKMzB1MCep9oIyhgQ0borCFZbkqPsGgM2IWhbdLZ+pU1Xl0xZjBQAh+YGeT9mVzaBlr8xnnimbMo/+lvKqjd2y1RQ8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(31686004)(2906002)(44832011)(36756003)(5660300002)(186003)(2616005)(4326008)(6486002)(8936002)(6916009)(41300700001)(66946007)(478600001)(966005)(66556008)(316002)(8676002)(31696002)(83380400001)(6512007)(26005)(53546011)(6506007)(86362001)(55236004)(66476007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRITzcwQ1NBWDBvbUl4UWQ5WTBZNjVtZzRlWkxPT2pWb1RpeC9CQmxXakps?=
 =?utf-8?B?RFdkQkJ2aENrRUVsY08wVERnc0lBNndhaThlWVV6cXd3eFBMakRqcmhsc3JI?=
 =?utf-8?B?aG5VdnlqeWJTNVkydDkwS0xUelg2cjFtN29ldUxBeUhHMGc1UzhDY2ltTHFD?=
 =?utf-8?B?QzFxT1R4eVM3eE1yVzhONWRNZEdUUUNTNEJFcHZUTjRpNkJ4VDdWVEtSMUpt?=
 =?utf-8?B?MElXelViOTQ4cG82Z0QxbVdrd3FNM0dFQ1RNWmZVU0Z0dWx4U1J1SlRyaG41?=
 =?utf-8?B?MjY4UjQwUUNRYWF1eldaSFpUV1AraFVOS3BVdXhSdWxVdUNKZTZUcloxQUdW?=
 =?utf-8?B?OFYrcTVEZVh2WXpPNDNQa2R3T3ZJMllDWlk0bWROV25kTkxzeWs1MmVnaWhO?=
 =?utf-8?B?d1kzMWlVdHZHZitUbDh0ZmdmY3VmbTFtUzE2U0h2emkxYm9hVnlTZm4vKzcr?=
 =?utf-8?B?MERrYUdQZWZiRnNnQTBIbnhsMzY0dHpzNmFmTk83ZjM2LzFWcjBnYXhqSGRB?=
 =?utf-8?B?TG1RYmtNMVRTV2VGTEtvUWFrV1A2RFpIZllIRXVwTTJ6T09NYXRkT2pURThr?=
 =?utf-8?B?SkpJSkFNU29NL3BFaFlXZ3NFbFBSNklaY2V2bXNtcWQ4UjZtb25kOFhVb3pl?=
 =?utf-8?B?dnVRMThkcnIxNFlYTzkwNHBIS2FtU0tSNzVnM21RdmpBZVNQTWNNT0ozdFlp?=
 =?utf-8?B?a0xMWnJKT2hnMGVpVE45NnFpSFlZUHp6ajB6d0VnVHNRMEt0dnZyMHhyV1ND?=
 =?utf-8?B?NUtGQ29xMW9JeUpaMElFc3k4WjViUExUb3BjRHpITUtVK0p6Q1VBdGhGNjVW?=
 =?utf-8?B?WkNPeVpUVDE1RmhnalM2YUtKZWVVRzVzdUorV1JMRDN2cm02UFFnZk0zSkFG?=
 =?utf-8?B?ZjBUblY5TWZoUG1LTEtBVGtFY1BPYUI4S1lZaXdsMlFwRUxCSzRPTFVtdjFM?=
 =?utf-8?B?b3dXQU1mTUtTZmczQUE0ZjdWeExHZGxmV29KaHgrYW4wdlNMaGo2Z0N5bkxj?=
 =?utf-8?B?WUNXQTFOYUlNdWduYXcralg5bUN1Y2ZqcXNTbC9GOHpKMFRJUm5xTUh2T0th?=
 =?utf-8?B?aU0yOGFRT2F6bkhFVUl4cnNuV2lRL0t3STlOM2drQjE3WXlXV1IrY1lpcmhV?=
 =?utf-8?B?Sm9Yald3cWVkeDgzRUtDTnhKblJXSVFMdDVGMWI2MFByWThhV3ZPbmJ4UEJY?=
 =?utf-8?B?aDM3OVNmTjZ4TE5BZ25hdGVwb2hBM0h6QUUreGs5MmpuZ2dSTjBOUXNtNzJD?=
 =?utf-8?B?VXNVOGdxbTd2NW5sMmRwV3FUWkZOY1d5aWtMMnFlamx6ZXBsMVJTdnFtbUNx?=
 =?utf-8?B?Z0lFZWVwVk1nRk96alg2eXRvR3RWcUZ4VmFzaXZxT3NDRnAxaFBFUVlPWlk3?=
 =?utf-8?B?K3c5N1YxR2FPMjBFdGd2S2FRWVdzaWdTU1FSL0xHa09FVWo5eCtGQjRyNmky?=
 =?utf-8?B?Z0xUcVM2ZDRWNjVMdEwyTEVNYVMweFk0SWUxbFNxY012RExpcWFmVDVlUWdG?=
 =?utf-8?B?dFBra2FmRFpqMXB6QnY2ejRmZThkdGlBeVR5aW1laXhTWEo0QXpTRkxUZkFw?=
 =?utf-8?B?aFBxVkNkY01jUnNzcStrWCt2ck82YTFPVjZ1eXJ4MGJzWXNBNjVyVmM1TFhy?=
 =?utf-8?B?K0c4TkxPbzNTMUJETzA1a3VzaXpsbHI2eDhkMFNqMTk1dXd2Q2VETmR1ZlVZ?=
 =?utf-8?B?aUNNeWxjRTIwSldxQnVDTWtsS21GYmFTYkJOcEcwOVgyMXoxck1wZEZGVWpQ?=
 =?utf-8?B?ZTRXbXZ3SzJFR0U5bHNiWFZKTUV6ZTc1UitZMHpoS1hVdW9IdGN5R1lnM3Vm?=
 =?utf-8?B?aDV2OTgza2Y5a3pQU2dUQmVieUhldlYvdmxKci9zdkdyZ3d5WlVTUFhqRGFv?=
 =?utf-8?B?a2U2ZzdKdVZ4V2h3VDhiMm1ZdXdsRExIQWg1cEc1eW1NQVNoWFFSZ2NKcmF2?=
 =?utf-8?B?R2d0RHBLOGxPY09VclJ2ci9uNWtlMk9HZUVHZjc4VFNjS00wQXpiQjVXSyt6?=
 =?utf-8?B?MUE4RW1mZUVzUFBxL3pueEsydzBtalpIbndQT0pzcW84a3Zqd0haN1ArM2RR?=
 =?utf-8?B?eWhpQWZrNENockZhN1F3Njk4c05BTmlIdS84SXJNZVQrblpOMDM0azE2VnZZ?=
 =?utf-8?Q?ucKxath32vFZBJTp9YB8+VJSo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206dda53-f6f5-43d5-81f7-08daae928d7c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2022 09:49:28.9801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7D5fV09i09FG151gLhc79XiOEkrBrNsnPzu0feyq2BsGoNfoLiVlwyZwqzL0hy6g11U3R5yayibV6Ebw8bITzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 09:54, David Hildenbrand wrote:
> On Mon, Sep 19, 2022 at 2:33 PM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> During a system boot, it can happen that the kernel receives a burst of
>> requests to insert the same module but loading it eventually fails
>> during its init call. For instance, udev can make a request to insert
>> a frequency module for each individual CPU when another frequency module
>> is already loaded which causes the init function of the new module to
>> return an error.
>>
>> The module loader currently serializes all such requests, with the
>> barrier in add_unformed_module(). This creates a lot of unnecessary work
>> and delays the boot.
>>
>> This patch improves the behavior as follows:
>> * A check whether a module load matches an already loaded module is
>>   moved right after a module name is determined. -EEXIST continues to be
>>   returned if the module exists and is live, -EBUSY is returned if
>>   a same-name module is going.
>> * A new reference-counted shared_load_info structure is introduced to
>>   keep track of duplicate load requests. Two loads are considered
>>   equivalent if their module name matches. In case a load duplicates
>>   another running insert, the code waits for its completion and then
>>   returns -EEXIST or -EBUSY depending on whether it succeeded.
>>
>> Note that prior to 6e6de3dee51a ("kernel/module.c: Only return -EEXIST
>> for modules that have finished loading"), the kernel already did merge
>> some of same load requests but it was more by accident and relied on
>> specific timing. The patch brings this behavior back in a more explicit
>> form.
>>
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
> 
> Hi Petr,
> 
> as you might have seen I sent a patch/fix yesterday (not being aware
> of this patch and that
> this is also a performance issue, which is interesting), that
> similarly makes sure that modules
> are unique early.
> 
> https://lkml.kernel.org/r/20221013180518.217405-1-david@redhat.com
> 
> It doesn't perform the -EBUSY changes or use something like
> shared_load_info/refcounts;
> it simply uses a second list while the module cannot be placed onto
> the module list yet.
> 
> Not sure if that part is really required (e.g., for performance
> reasons). Like Luis, I feel like
> some of these parts could be split into separate patches, if the other
> parts are really required.

The shared_load_info/refcounts/-EBUSY logic is actually an important part
which addresses the regression mentioned in the commit message and which I'm
primarily trying to fix.

> I just tested your patch in the environment where I can reproduce the
> vmap allocation issue, and
> (unsurprisingly) this patch similarly seems to fix the issue.
> 
> So if your patch ends up upstream, it would be good to add some details
> of my patch description (vmap allocation issue) to this patch description.

Thanks for testing this patch. I will add a note about the vmap allocation
issue to the patch description.

Petr
