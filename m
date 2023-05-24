Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9757770FF2F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 22:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbjEXUZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 16:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEXUZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 16:25:35 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857F510B;
        Wed, 24 May 2023 13:25:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cqy9ozxBt97ca+G4xApzQAjHdFpFTzsKSEVnoJHVSnEdw7vIGBz/w7jPcFfWtbVb7d0sa3io+DJePDktoRka/nXXQgktQLBq5siq/XjND8HhUefVr5aznZprGQ0zu6gEt+zJc04Ooy352x6EilLGtX/gDR1XmPFlTf0auXIZV78pvJDppiOij3SzcI61yHYOU1TqvlCv+vdR/63V9KwOEoEEBdQLIKPFadahetmKE6CXyTfMRYvWU1KFLUrOS24/2D+nr2w89TsUPyCp3K8zk69b4Huod2/6kn7+S69xX/TuQpLzGAGyIabW8Jdbpr3ZzT83oFRYF6FN5tRA3kHXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GX388/+WfSgCCEP/TgwXCz7DHKpR0M4xVyBKEIK5nc=;
 b=LqdB9bBTXWfFC3WFpz4W1dLziRGD5VEnORl8L5hz7btreVVKMS6/HRZ+4A3JYhEbfu3nNJ/5QOBRBamg5/ZHCBLIu4H0wNqxz92P9bpfWj+6vm69X2XZ/qA5tbMjOcSkmfOsAAxiCf/m/q0S0eLkiXjp6DRjaXBUt3P4XEW2npjnkEE/MFiolBLKGdy8RAbZltJLdyqkzqYnxYqMFTxwVpgTinphDrWnHNRYSfY/wAV5V1uSJiZT0kcCkNT7D/zSpiORwCt5uZMzJfpZ7I2WM2413/CKbHmNh0/nKQZxxzk4+i6BfrHjmX/b7eH+agkRNOy39vc/oCy3v1R6c+KDIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GX388/+WfSgCCEP/TgwXCz7DHKpR0M4xVyBKEIK5nc=;
 b=iQsUsMCRi0qjjpSLrHdtEpEjKEV7svwKOBweHTr1qmqvxPFj3fAGpdVfj7nebaTuLNJ7lB0dRzrMvn5Pvm2K5jo51q9d7MoQfmEsLpMY3aWJ7sDi7dHHIbtg/z/mfdF0sXWwpmm+u7U4XtZxUUHaCJDGD75Dy6a+p936726wyCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 20:25:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 20:25:29 +0000
Message-ID: <ba71422a-e7b0-a5d2-d5d6-d0016c896f28@amd.com>
Date:   Wed, 24 May 2023 15:25:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 3/4] pinctrl: amd: Use pm_pr_dbg to show debugging
 messages
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     hdegoede@redhat.com, linus.walleij@linaro.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com,
        Basavaraj.Natikar@amd.com
References: <20230522200033.2605-1-mario.limonciello@amd.com>
 <20230522200033.2605-3-mario.limonciello@amd.com>
 <ZGzwCdTO2LptPeQs@surfacebook>
 <CAJZ5v0hO4hq=TLZ=tK5vXv_pA4SsAo5Gqr5K9g=EU6bFRPYU6g@mail.gmail.com>
 <CAHp75Vf-0ap+hSeTFUFqaTNsH2+dEodd=E3xPnfRmvMNewfMxg@mail.gmail.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAHp75Vf-0ap+hSeTFUFqaTNsH2+dEodd=E3xPnfRmvMNewfMxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0212.namprd04.prod.outlook.com
 (2603:10b6:806:127::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7e195a-a89f-4c3e-5c01-08db5c950433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F82m03qqvyi1ax2VMaYvP7lUsyFz6oPZpOWgtjbZFFGmgPUbAj1maRzSm6J+O92mWEmP+V63evzRyDmLGep1zy0d1hBxobyTgpMbJhIwKRPbaZTgBxtpJq5rh0VegaYJnzVGTvcvRXa7t47/lK8pQWxL1Rsx5E3ZcH1xKPJQaCfiL6TGTdj/l3e5kUHoe8q56VhS45lmpgy/337Dz1epYxcAkF0uOZ7/9aS7MlgQnEBb27XQjzWJjQ9VtVHI/UXr8or8iV+z+5BUb0eZ+e3tnDfAQzkjiwCay+iG1OFwH+vMy79i5bpq6xj1k5dVgLyBmffm4G+bSNWL/UFlE15aq1kbrZog7mHyrZ8qbhILo2NkHpjkxxTLtbSGkq4hNMtiw4PHiLxcNSkZXGNT+w4aV9Z235trFtRaT8oIP5SSuHgOD7EgIdIfgMrK3h2eSLml2LRfRszoSJTypazPKGYZDuvcYyG312kIYw2ezY4G1CWdJYbHtifAZ5Lp3uvAGkM2MW4D+/p3dodVtFFqokMvXyz0Jox1ygvD74eDP962ABsZmcgXJWPWDXCaRxecr9oIwHQKtRs/7KcxclD8DwmbL5IApjMpqtMW+z8aIDwDPNsaIoAfWyluc274KqPLFHAU70h+l733kpDe1GrrTCYD0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(41300700001)(31686004)(66476007)(66946007)(66556008)(31696002)(478600001)(6486002)(6666004)(966005)(110136005)(316002)(4326008)(86362001)(8676002)(5660300002)(8936002)(38100700002)(26005)(186003)(53546011)(6512007)(6506007)(83380400001)(2906002)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHh0L011b1l4eVE3S0ZxNlFGQlBZbEh3WGdZeUZyRDFJWm9OSmRxN0l1OW44?=
 =?utf-8?B?cFdLMm9hY0lqQ1RnaXhSU3A2NFRzcnBkeGZQaC9LSDRBdXArZXB4K0ZoMkJP?=
 =?utf-8?B?WTFaWWxWK2VRbFFPYU05SEJFVm9zUHhRZ21JSmVML2NCL3VJcDR2ZFZoSUJB?=
 =?utf-8?B?aS9oVVB3bmZzMTNkaFBEOVdzUjZPYlpaQ243Rk9KeGd4VnA2L2FlYlN0Zkl2?=
 =?utf-8?B?dzRFNDV5bmI4eVJDWE5qMlNQLzVMcy9JMWJmTG13WWRqaWJkR202blFudmY5?=
 =?utf-8?B?ZEs2WFBZb0dzRFdNcXpMMXo4NGNZRW5vaDcyazRpMlBUMk5BdUgrdkRCWS9k?=
 =?utf-8?B?aDMzenVTZmI2dWUyY1lTOW1wMVNacmJ5VmJvMHF6aWZFeGt6NFZlcXNFOXBt?=
 =?utf-8?B?NkV0ek9jb01qRTdpMUZTcFFpUWpiV085NElRV1NQNEY1NFJqYXZnVzIyNy9p?=
 =?utf-8?B?bWNSMjMxZ2oyRTREWlJ2R3l3YVRsbkRKNU9yNVVScSsvd2hWY3BwNnk0bDJE?=
 =?utf-8?B?K1E1Qk5mMUpCM1BWNVExWDFDRjJkN2NUYjZFTmpEZVN1UmpNbkI1dUZtcmVm?=
 =?utf-8?B?bit3RW5ZZ2hqZFRwOUxRTThUQytFZXJ3RHRiQ0tLbTBCcjZaR05JZEtQREdy?=
 =?utf-8?B?dWxnczJ5K2lpR1doRGhCd3JnRkZUR1o4ZWJkZlNIV2kvSUVVUERxcHVIVi9t?=
 =?utf-8?B?WVBRUG9LVmp2cmJYKzEvT3h5Nm1QRkZmOHlDUU9yTk5Ha0k1ZTg5cCtmL3NP?=
 =?utf-8?B?RU1CUUJNUzdSZW5sTWJHcjE1KzY4NEdBdSt6QWpyeFZiTFM0K2kvMWkxSkxY?=
 =?utf-8?B?YzZLVC80OHZJVlRqdGRTTU41YUFBK2pTTy93aHJDYmh5ZjRNUDJ5ZStKRnIw?=
 =?utf-8?B?Q2NqNU51aVJ4SDczRWtxTkNlM3p3M3hqWTE4TStPNUhUWXcwTmJwME9wVy9o?=
 =?utf-8?B?eHlpM3NQMEszT1VRd2lNczd4M1oyamF2cFY5bC9icUVxaGdSSEJMT1JrWFlt?=
 =?utf-8?B?eUQwTFBHMnJwMk9hWFBZazgyMnJLWm9nZm4rQ3pZWFE2VGlYMlRSVUpVMDJZ?=
 =?utf-8?B?d0JGYTl6V3plemUrOWFpR2tSeUdLUHFYU2RxbDRXL0tIMGhIWmhsazVMTUNv?=
 =?utf-8?B?MllhZFVjd0RmSzlOV2x3QXp0WVRwdFV2RWpHYXNvM1AvVzhXT0VtejlxQ3Ew?=
 =?utf-8?B?R25sNlZINEZBczV6WU85bmVVWERvM3ExdVpNTDRwY1JFTHJMTGVzQngwWkVs?=
 =?utf-8?B?SFd4MlRJVTdOTHhSM0tRdUNjLzNLUGFDbW9oNThUTldyM0RDRDBwK1Y3YVhP?=
 =?utf-8?B?UjdKYkpEVG92TEQrend1eFNnS04yNDBySzhaOVlXK2tmcnJMUGFWb3MrRzJt?=
 =?utf-8?B?ZmNDRXJ0UjV4Vm90TGMzODdWSnlZKzdTMGc1dHBPSE04dWpaTmpGYkNlaVBj?=
 =?utf-8?B?ZWpNdC9ESFNSbzVXRDgra05nZ2pRTEJVaUNnZ29ib2JyZU9ZdFN1STZkaU5Q?=
 =?utf-8?B?QWJrMmttRWsvOWRORDIrUHE3V0VJMUFYVWdmeEMyKzJwdW50RFpNQ0hLaUVt?=
 =?utf-8?B?OEV2Wm04UUNZUHYxcEZZWDZPYnBuR2hzbUtJVHAxZjIvdEJTRG9oaUdYS0Ev?=
 =?utf-8?B?MjVpNThZWHplVytKbTNYdmtraC8ydThyL016eVgrZjZ0L0JCQmNiMzlLcTJa?=
 =?utf-8?B?TTZvaVI4ZGlGbythNnMxWjZjSXRHN21KM2UrOEVhMjNOUlNGK21QVGlUZjcr?=
 =?utf-8?B?UExpTVRyb1BHL3BsdTlKcXpzK0pBUXN6NVl5c3QvNDNicTkzWEFTaENhYVRZ?=
 =?utf-8?B?TTNWVDBKRHAweUJodUJLWFp3N3BXWkU1U25jZC9QcTFrUVczWEFmYXc1Ykg0?=
 =?utf-8?B?d0NKYmdqUG1lK1c5d1BuOGhLczVXLy85OVlidm5lYUloMi9EVDJJbTBJU3lI?=
 =?utf-8?B?Tmp0MFlwaURpb255ei9oMHdKaEltVi80YjNRdW9zZDhIY2MvbGNCZW1uY2Ri?=
 =?utf-8?B?c0RPSkdzUnBLYmdHWkVma0JZQlExUDg4VTRzMHQvMWs1Qm81OTZhQkhjY3dm?=
 =?utf-8?B?R0hTSG1JYzJ3WXZidEw1MVJ4SGZuNzRxOFcvbkpOMWhRRHNPUythWEY2dnBD?=
 =?utf-8?Q?Yh5YVxZo/W8TQTdQta3QPRGXG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7e195a-a89f-4c3e-5c01-08db5c950433
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 20:25:29.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcRuBvLSWsDP1D4f2G7+NnLqaIKziAG9MMSePTZgOcz1NMrbyCNFQ20IruF7ECekeGAXBlgaszu/+OZVs8HSyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/24/2023 2:57 PM, Andy Shevchenko wrote:
> On Wed, May 24, 2023 at 9:28 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Tue, May 23, 2023 at 6:55 PM <andy.shevchenko@gmail.com> wrote:
>>> Mon, May 22, 2023 at 03:00:32PM -0500, Mario Limonciello kirjoitti:
> ...
>
>>>> -                             dev_dbg(&gpio_dev->pdev->dev,
>>>> -                                     "GPIO %d is active: 0x%x",
>>>> -                                     irqnr + i, regval);
>>>> +                             pm_pr_dbg("GPIO %d is active: 0x%x",
>>>> +                                       irqnr + i, regval);
>>> Regression 1: The device is now omitted from the output.
>> Right.
>>
>>> Regression 2: See https://stackoverflow.com/a/43957671/2511795
>> Care to elaborate?  I'm not sure what you mean exactly.
> dev_dbg has 3 cases how it prints its content:
> 1/ With dynamic debug when it's enabled.
> 2/ With -DDEBUG if it's defined for the certain file(s) in the Makefile.
> 3/ No print.
>
> pm_pr_dbg relies on CONFIG_PM_SLEEP_DEBUG, pm_debug_messages_on and
> not on -DDEBUG. I haven't checked all relations between those 3, but
> it seems to me that DEBUG is not equivalent to the others.
> CONFIG_PM_SLEEP_DEBUG=n prevents printing with the dynamic debug on.
>
> OTOH I dunno how this is relevant to the functionality of the driver
> in question. Maybe it's okay to have such changes.

The main reason for this debug statement in the first
place was for debugging sources of spurious wakeups.

As the statement is in the interrupt handler, turning
it on at "runtime" usually makes for a very noisy kernel
log because things like I2C touchpad will fire interrupts
constantly.

