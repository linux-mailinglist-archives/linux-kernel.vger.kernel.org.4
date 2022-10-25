Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258C560C29E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 06:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiJYE3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 00:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJYE3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 00:29:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC281108D;
        Mon, 24 Oct 2022 21:29:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E13TWYPMnZTR+sJLx0Z6Wozn8XxEM9q624wG6tb1v9tYV0YlraaP8tfM/tlWM6mxXYd/IJ3Sv08AWVAu81GvBMvNkUXbHbKcDAE8selzF5e/JkJ1UpT4pZQrCgKYojFsePzi8zlV51+A0BVp10ytCxIhq9nHPPaZhFIxqUs3xtIlKdGWyKCCmFt0zpcTjIwLpkzT7Y03MZB4wfoIk5H9ibG3U3yHwPgLcCmBpkE6S5w55d1UTUvFzGF66EIbIKOWOJOaOu6wFaYzwMznMhmn2TJB6uVdHQ0KzH607SjdnIzAlmRyunvBaxnnBhlLis6j9G7HCukiX4nHTkhLA+EAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D42U1U9GbUqJSYfiIjzJvQ/kYwBr5r+v0RcJLQLmlLk=;
 b=G7tsnvGjsaLaqICeb3CZR3tTMr5Vl+/p7Om+q2FH68AEstKafdJx2wiPI0DsPdNFtd0VbBaLuBsmgQcn69p8F3CRbUo5hqg++tunx+GTSP63ksVYOOndxpWMS4K/+yGhwUXwocRHDugLI5pdJDjt5OUl++XrWdVsN2OdRT/MifX+CFJoiIoZ21gT3llVBNjGmG8I/1XCaLNQd2ieicQeLmPPZ50cKVAAeBT8R34YMCyuGr8VTokAB/PjifxFEPBNjiLNBzefQf7rG/1oHCaLURw6QaSGZ2WFw5wWeZmPrP+ZMwCG2AilNx6nWK4Z1fju8w4k43ftQskokm4p/fNnzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D42U1U9GbUqJSYfiIjzJvQ/kYwBr5r+v0RcJLQLmlLk=;
 b=VwWWtcLUEUH4oP5alZwABbyPAzZG3pOd0E4UNhNroZngvWu0jxs5lr7jiRExgTwiSh2I1LYvvIyUOAi2C/WHPvnpW5XsC+nZsmxqEvE+0jTJ1mDhSmY09HMPTZV9BtTSkgBdR9l/p8UuQabSdK8rDkDAbousvJII0oideK/3iqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 25 Oct
 2022 04:29:37 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::fa1e:a29e:2f2c:43d1]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::fa1e:a29e:2f2c:43d1%9]) with mapi id 15.20.5723.034; Tue, 25 Oct 2022
 04:29:37 +0000
Message-ID: <4429582f-155a-04d2-d139-a834bb325612@amd.com>
Date:   Tue, 25 Oct 2022 09:59:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: Perf: BUG: kernel NULL pointer dereference, address:
 0000000000000198
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <CA+G9fYtOP-spGS7gYyBB-8wpUDiKxd5e_Nk05J9gzWR_DLBeFA@mail.gmail.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CA+G9fYtOP-spGS7gYyBB-8wpUDiKxd5e_Nk05J9gzWR_DLBeFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0228.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::16) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7fae41-14e5-4fa0-1777-08dab641866c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gT61uJusNGZSPwx5vTB6oZGnyfLRO+9XeqTcIZ8iX+68P+SKakPT0bX8iUS4gcRW4jyQi+J6i7lwhAyndbOz15LtbJn3r8iNbejN+7IY9Y82o80KiI3J4GLsumsadsWeN11ofVFvJ+EjqIVrM37r9jXJBBUMKo5+K+SS8zfj8AzCMW606dZ+7ZXJOigY6pD2AMiR5btKLvIx8QVL5CMp9aMj6qomiHqThDOtpgMRvSApstwI/yfO5f16HYdmvWpJ7m0RbvJD/f4i6nVmlbbQQ+e3N1ghYPE4IVhiR0BDcZepArOIJ13AE9xHlrxZH02AV+EJSLzRGGnM6Sm4mY3UnqbMzJWdKfj0bLTSOLJzua/XouhZalTQHw9TLfvEammT1Qr8aCUS5a6PYxudD+21NkSvS1YePf+XSRyxLseZebmhi8dK/nuoxmKPJozEH/+lY2/UmjBdQCzozGGBtP4F3SlFXRFO9vUFMWa5fdYT1FU7d0Yp39dN6/8V2b5EXB1ZTT9u5ChMICGnjhizUWNFMKgj9of6W7NFDYuD6h4JXtlilSkRKECkcUGn3EhqlPICeYZzGpVbUT0oYwMpfc7f94IV3MnpNxlIOIyiwPcSJUad/PpYjRuraBzNwEVPcTkp4gMR6zLMEsrPW0YRPCVWBeNnpTMBuOn7+N5ibaFRAyFpxPVE+FoBJzd7oU/ea+aTFaQom2PENerYYGcYHwuGQudprmCCeJGLHncyWxMVX7kuesWsvyC6ng+f56wbvwOZJOjTmBSvIa+TWYjpPF38fUE9DC70Yx/CJIX2/lnnSg6CwuouxL4PKnG4uZlNQ2Qn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199015)(66476007)(36756003)(66556008)(966005)(6486002)(54906003)(6666004)(41300700001)(478600001)(4326008)(53546011)(66946007)(6506007)(44832011)(8676002)(2616005)(186003)(31696002)(38100700002)(6512007)(86362001)(316002)(83380400001)(8936002)(4744005)(6916009)(2906002)(31686004)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFladjNrVjVSRHBkUGluZHUzeW5uOGt6MjlFalNIUGpDOEFxaHNRMklhRjlp?=
 =?utf-8?B?SVlWN3FsanFMRlVIVE53dUtKSXFqeWhyUnNrZHVuZFFzQ2JWRkxWNi9oRURs?=
 =?utf-8?B?eDArcXJxRUthdGZVY3BwOThIRDNkUDdKS0RJNmRudExlSEU4WE9ycEtLVFNi?=
 =?utf-8?B?TUFTRkNOVGJDZktJaWJ6Qkw4Zkwvd2wyWVg1MStmTHVDcFYyNTZNWmZraHZV?=
 =?utf-8?B?VW9yRlUrRXZKU0U0Ky90WlpKOERKVmhneXBhb2dzQWNFZzhqd0ZIT2J4Tm82?=
 =?utf-8?B?Uk8xWTBoZExFL3ArdmJBdHZtWjZmVXovY1RFTWhHSGx4ZHlJaUZobFQ3cGZU?=
 =?utf-8?B?VUJzeE0zMlpsNk40OU5sZk9WNEpGL1M4T3pMQVU4L2E5ZkpKRnJoR2Q2L29Q?=
 =?utf-8?B?YWdXQTkwMkFnUVo2NzdvTHltNkQ2T1FrNjR6V1VSZitxbnl6UkpyeXRrVUI3?=
 =?utf-8?B?Y1AvL0VrYkUzVDd0TVpTU3pKZU1tSGRHaVk2OTNlRnA0SnpBV1ZsRkM3R3Ba?=
 =?utf-8?B?MmxFM3lMR1NQU0RwRE5UYkxDNjloNGdKZnNNRHJwYlFkaEpXZG1ST2VOekNh?=
 =?utf-8?B?bTRwOTNsajl2TFJFVlc0SDlEMzM2WGlEWTk0MHRMK2syNHZQZW5YUnZqaisz?=
 =?utf-8?B?YUhHYjA2Y01VejhIcVVHSjFOSXRDb3dhcGIweXE4VythSmdibk1LT0hHaUJO?=
 =?utf-8?B?eXRZYnFxSnQrR1ovdk56TjBOL0cxaXlGc21TMTBMTzVwbGlVTk80a3lsWXhu?=
 =?utf-8?B?Y3JPYkZoSkI0RkR3VDNZQ3NLOFlhelhmSEFZVnN4WmVBVUdHQjB6bW0wcERU?=
 =?utf-8?B?VVQ5d3JqUkpnbjJJNEtoM2ZXdjBaRGl5Mk94TEdHSGcvNzR0NWRhN1piQ3dr?=
 =?utf-8?B?T0dNQUQ4ZXQrWElzMnRwQU1zdTBabk5URHJzUzg2L1ZBcWd3Z1UvL1AzNVBw?=
 =?utf-8?B?UUswRDNEVVlRTWVTQUxsbGZheGZLRkxCeityNHdYU0U0bDJpRnMxZ2sxZ1ZF?=
 =?utf-8?B?R1F1ak5VdXFNd3JKOTkzQ1l4YzNPQ2NDdFViNzZrTE9FSlBYSU5tM0VtalVE?=
 =?utf-8?B?elRuU3h3dFpSRUZJLy9NT2k1Vlh1dUM3SHdVYXJ5MllMa3ZMR3pwUDdidXM0?=
 =?utf-8?B?d08yL0IvcmZkbVN4VXRMaXNUbjU0TEErNGhpSDhGS0xtaGtXQ0ptSmlzY2R2?=
 =?utf-8?B?Y2VpWVVLUzBSdVBZMmpvSmhQaUF3TiszQzNnLzUzQlNPbkYvYjhkU2JHV21n?=
 =?utf-8?B?R0VENXl4SFY3aTdnbWRaV1dvdTFPanArNUZVbS9oeEgra2dhQ0VFMEdYUzNN?=
 =?utf-8?B?UlVva0ZlT05OaHAzVzdSVldMYjU3KzAydkZTamF1bDJLMG16S1R0OVVRRlls?=
 =?utf-8?B?TWl1NDdhenJUR1lVd09KY0JyMnRvYnJJVEwxTXBCaURXR2JnZ0wwelRER2pV?=
 =?utf-8?B?TGVEWURPWktwcHk1d05LY1h4SVV6bllpWml0VGtRZ0ZnOGc0d3VPVFpienFa?=
 =?utf-8?B?VnJOd2pEZjFwY1lmRW1pTWZvNjVDcUIxNXZBNnBWOHV4M0xveU5NTDBrK3FV?=
 =?utf-8?B?WXVkdFZrdDkyQUpoMUJobXowbW8zNnhqWUhFVnhjbmUzK0lDL3RQTXg3OEt5?=
 =?utf-8?B?N2lmdmxVRkxwVEowVUNUenU0b2l3QW5KS1JlemdpVU5iRUtsTWVQc2JYN1dR?=
 =?utf-8?B?dnJuc25aM1ZZOHgvaUkxckIwZWNQLytYSm05eWhnUUFhZEhpQnpLMjY3US84?=
 =?utf-8?B?bkZGS2pMM3BudnozZ1NvRVFoTDlGQ1JTMDhrTGQ5MU5pR1Q0QUxTNGY4aTFw?=
 =?utf-8?B?cGVoZDZSQzFSMUVQQXZSRGk4MnQwWmVkL2VJMzJodDJtNlZiVDRBZzVITGsx?=
 =?utf-8?B?Ty9UdVc5U3p5amtXN01PTjhyMC9oc2xsM2R3S3I5MFZSNGVPMGF3UVpueVRP?=
 =?utf-8?B?R3RHcDJBcWxHMnFCUk5Ka0V2Mk1Wc2dzUlZFeE5zMjRHWWNaNVpPVGxWcnZC?=
 =?utf-8?B?bFlWUks2YXc1VzRuNWdodHZmSlo1MkpLMnJrdzI2U0N5amROQ3ZrYlRJcjdG?=
 =?utf-8?B?VHZ3dk5qclZBTVJPS21CYzZOMnJzeEFLOEgxU1NRNWZzMHZUSk94M3FZZ0FP?=
 =?utf-8?Q?uiJeRbiftAAa7g7/26ZmQndPV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7fae41-14e5-4fa0-1777-08dab641866c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 04:29:37.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6i3mVrbKOXwuiroSIemzSYktf046YNB2ioHdCQ+Ma9QsC9GkKunAZ7prmmvu0i9ud0GFqtCCAEkpxu1pUFoUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-Oct-22 12:24 PM, Naresh Kamboju wrote:
> Following kernel BUG noticed while running perf testing on qemu-x86-64.

Thanks Naresh. I'm aware of the crash[1] but haven't got a chance to
root cause it. Let me try to spend some time on it.

[1]: https://lore.kernel.org/lkml/5e69c472-b9d4-3813-70a4-f0d8bbaa14d3@amd.com

Thanks,
Ravi
