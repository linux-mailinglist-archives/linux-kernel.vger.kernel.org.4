Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9748E676B6B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 08:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjAVHQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 02:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVHQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 02:16:36 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7771630C
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 23:16:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYM/Monx45PfFlZv4BBjGVOsyvNeiRcRqdNn9riQ1iToWPTR5qq4nTsnnexcJZ7egD4WdcLMtGrq69xcWufefw5DMmgfe6f11YhspweknQ6sLnxls1E00wtRtpKvLlCU1kt6ZQ4V/DSLrcm8QMEKcpGcZCa432raOpQaQpcIrurSn3W+CuDAELpYMVshYqvhJA4yJa/dKjZkwMzKU/zVHKK8Qm1yZLRmdv7vaEJLcXhRCnDJtHA8jysZGhKOOIO8NOuSCLZi4MG07mynRdhR1AiPzJsompdbdwrFHT2lZu1kNegR2Fl2/a40vkTs/SObuRObnodetWRzbqvrjvJO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX1nATzuJtL1u13Me1L/26hAnqkznS4Qg0647quPGSA=;
 b=Jq3w0qbvfua673wpedIqerCdoQWXsf/Q2DQpGoZi+v5QDCYPdKZS1J3JTWBkWEyll38OzOEQ6nIvsRgMo2yBU51iTyqE4x/Vw69tlDrUQD4j2K4gtNmmuHG0Lif/seBoF/hY/52divAIUwrpt8A8kosCInN1VJJ/9uXDrkAZ6sTPfZdFqgpS15mLPNf9bxeyIsLKiXT7VSsXlDDHo0T0rfmZTof4mEzeVQpgW0cVjPDL3aY41ktRjxfVmOnli2ItMmZwpcN0f8uQwjJh6p1UwHmW/J+HzbNmYrHAWJq40z2r3HvG15yt4mOyuKm0qunJG/dahvWrj9QbOelkLFeT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX1nATzuJtL1u13Me1L/26hAnqkznS4Qg0647quPGSA=;
 b=i05YorIyEpVV8CEAgooan2+fYuPLVp58inng7QpKGiLMY2hfpK5OPzrNWBP+XBmPlM4/gCvt1qoOdelc3TquqPrGLLgjjX6zIgZOGNvAynBFAgM8M/qDWGbziyvOSHo8DwdF0TtFqigXXPRpGOwUA99razH9fAsCtpTCrvnQ162xsusZnTMAxMtlg15dRav7OPp3XUwIIHopAcGQcu27T+DdJltyi8USJh2/zhuMVaqGKjCAR5b2lf5Wu67sW7e8TMEb5RzdADe0SpU5TWqxuy8gwTwhufCaA36Icsz5tMyxuKONGyJiixT1Q4rvaKUj9Sw0UCkzd5j5hgmrcMaAiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 CH3PR12MB8356.namprd12.prod.outlook.com (2603:10b6:610:130::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Sun, 22 Jan 2023 07:16:33 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::d01c:4567:fb90:72b9]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::d01c:4567:fb90:72b9%3]) with mapi id 15.20.6002.028; Sun, 22 Jan 2023
 07:16:33 +0000
Message-ID: <2cd58d67-aeeb-bc88-59e4-cbc5a6387c65@nvidia.com>
Date:   Sun, 22 Jan 2023 09:16:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: .clang-format vs. checkpatch: Lines should not end with a '('
To:     David Laight <David.Laight@ACULAB.COM>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
References: <88d82daa-811a-0cb7-8b83-7eb828b4fae8@nvidia.com>
 <4337ebe4b5d2456385fa026a72e67d15@AcuMS.aculab.com>
Content-Language: en-US
From:   Gal Pressman <gal@nvidia.com>
In-Reply-To: <4337ebe4b5d2456385fa026a72e67d15@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::9) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|CH3PR12MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: f32c54cd-94e9-4ce4-e073-08dafc489763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQucXnkbR7hN9e75P6kba5ArEtNqhM9VoEEQHzVNeyHku7ZrWuqIV8jQZspgTg2JEIuHWPIZdVw2mvbpz6y4DAe81A3XJGU89/sQAJek5D+q81MxX5QWSI/Q68crPxaaZHNTIR9wNAer09ptn2YN4ZIpXtSTCs55tProE3NCIQo4EGY1ra8dWzPsEP8SP1kF9lAQpRFuAQiCB7jbamlelRoft7v2oilBarZX9cQiDK4eY39wHuJWpP5eE8tODmSdVPUDIQpHqje5FFFMg4wsbPU2AqhPRcJssPBeqZnByEaDhJ8FMhqSWBf2n3aovAdq7C4adlUod6IqRGctUmU1jRy49867MeCfSAfl6Qa0xkz12yRMZu/aZ88Y2II1Gjf3jNYOX27HJvkc1+LqpsyefnP3ETgofHx7ybIMjQrzyQQcC+hC/DFgsX9q60bNO2vLJKmJ8sHcXaFw2ecU3t//BCi0T5x5JREEVDuszd433uOBOgUbRBgG2oNW/iDkueA16gqcz4UOPj0hfVhLNJSeSP9ke49CEwqAikLdRzl+YAvxPmGuBJofxfpWr3xoF/ElRddy7AKRiG6xvExKEuA8CABFDwG33lSUt606kN3mvdtfqkSbVin2YUtMHAKwblvyz48ko5nSzIZ+nEhqt+gKIy03IyqPeEqM/CI3GS4ppVeJ+z3k35DaIDzUKRZ8GJgeyW0UE4j+5X/DasxIFkAlHN5HcEniqM3UvA5iE/Ex75o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199015)(38100700002)(36756003)(31696002)(86362001)(478600001)(316002)(110136005)(54906003)(6486002)(8676002)(4326008)(66476007)(66556008)(66946007)(2616005)(31686004)(53546011)(2906002)(6506007)(6666004)(8936002)(186003)(41300700001)(26005)(83380400001)(4744005)(6512007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUgwMHZkdzdubXVXMHl1RTRvTG5qdEpWbDFRN09tT3NIa1kyQ1EremR2c3ds?=
 =?utf-8?B?UDZPcmp5RTdlU2hucldZOEZyS2E4eTdQbW9iUDZQSGwyOTlIaUh4dk5kcHlF?=
 =?utf-8?B?bFJMekl3N3BUd3pqcmwreGphTDBidHZGNXp5VjU5SVRQalJ3eEk1ckxjTWFH?=
 =?utf-8?B?LzFGSDRsUjYyRDZYT1UzZjVwNWxLODhqbC93dWkxcTRDZXFzS1Vxd3hmMzdC?=
 =?utf-8?B?SE9FRTk3NG53R2tiNnlVYUZINGZHUVVJV016S2Y2WVQ2ZytpR1Blc3NZcjdx?=
 =?utf-8?B?UkJJek84WUZOZEdwREJVS21NdllOOW1JR2JDdHNvTE1OQkdoNTRQTXFSRDYw?=
 =?utf-8?B?dGF4Q1FpNjJMY1Z0VjhFYzBITVVUK0VpRVcxWEtGUGpRNVJkZ0I5bWxJdzY4?=
 =?utf-8?B?dXR2QzhpK2RQKzduNlJNdXZta1kxUkc3UFVlb1NWdWk3MzBlbkFLUmtWem00?=
 =?utf-8?B?b0dsSFllN0kyNXlZemgzREFwMzRYNzlSdHQycnprMnRYa1NkMXRQdnJaRHpv?=
 =?utf-8?B?QUF2aVA1SlpsUHZyVVJKbWVqVXhGZ3hLMEVhdFRmWmJOYnJ4YjlLdzJPZThy?=
 =?utf-8?B?TlZMZFdXSXJITWNOUHZEUWxKaW0ySDBQemdBVi8yRmZDNUdpaTUrSEdLVDZS?=
 =?utf-8?B?YmpzbmdzeEpHUjlqYlNLS3FpdCsyME9rNk5aS2xmcktkTlNQSnI4cmJLa09m?=
 =?utf-8?B?M2IvWWdGL1g0MUFRd004NmppTWpjZUl4OGlMZVR1TXBVcDlNMzhTczMzRTJn?=
 =?utf-8?B?STFBcG9ZbG9WQ0swb1h3S2k4eUVmZkVMd2gvbzhLODUwNDlUTFJKNGVMQjlI?=
 =?utf-8?B?QWFnYjdZUU9RTTcrcytWdVNEVWhlb0NpQnl0WjQ5ZG8waDB1ck41S0krTXZT?=
 =?utf-8?B?ZDZSWFZIa1l4QnVMdXhXVVlpUFhDdTVKckwvVDd2VnMwanFkZEI4MHdmNXo0?=
 =?utf-8?B?T09yNUxaanV0TEhKc1JWby9WTFZBTmZkV3pXU3JDOW9rT0kxR0lyNjJ4Tk9k?=
 =?utf-8?B?QzJrTkE2RXBqd1NMdENZcDJkVWduWXBOWXVEeDYrUGgzMExuVDlyWjFyUncw?=
 =?utf-8?B?NVlqaE5aem5hekxhdHlwdmRNRndWWE80MzV5MzI2QXJJZ0JwMU5veUlXRjdH?=
 =?utf-8?B?d2hmc2k4WEdaQzZ1c0kzaVdWbHdndjhNa0tRNC84K0ZsSmVLVDg4SmtaOEVG?=
 =?utf-8?B?YUpMM0ljbkp5VlJkcTRrU0JXMFRPQVlNV0hUUEVZTDdOYVJFM0J1NC9RcDZI?=
 =?utf-8?B?dmFpS25Xc0lCdGh4YTFUYmgzMC95bUlnMDBFNXN2NytLSlpiN0d2dG9lUmov?=
 =?utf-8?B?dHpFYVN4ckZva0kxWE1HNmlmNEx6UzdqOWdFVFUyYUI3YlcyOGtlZkZsTWRF?=
 =?utf-8?B?SXRlSU45VEp4YU04TnQ0c25nZjh5TkJHemQvaG1rc2c5bGp5QjFlbWY3ZXFR?=
 =?utf-8?B?a2FiK0lQdzBNN3c0NHlSeXJtcytYR1c3eU8xaGFtenJONWVJQXRrT21kOE5B?=
 =?utf-8?B?S04zTWRibUc0QU0xOFRNKzFXVGh2WlhXMzJEdVVpZmY4Y3dXUTZqdXVtclAr?=
 =?utf-8?B?clF2aGVzTWRyNjhuV0N5aUhGWVhLVnZGdWc5SmFlWXBKbnFPZ2MxVCt2Y2lN?=
 =?utf-8?B?R2R5ZGpab29SMnBXamVXc3lXRDlXMys4M3hDZzdsZGxBMEZYSWw3MkFqVis0?=
 =?utf-8?B?cGw5UDU1RXJ3MVZHMmcwT3REdUlPY2ZKaFZnWGJMcU5iYU1iUldqWE16Qm5T?=
 =?utf-8?B?clJESndnVzdNUHcwWDhBUWF3V2puc0hBTkcyQUZJT0Vmb3hMb1I5MXd0T3ly?=
 =?utf-8?B?Uy9la3hNeERhZHhFQXg0cUc3QmhWWU43elpaYnRTVVhDeWNCRkRRVzFVWnFJ?=
 =?utf-8?B?MDF2Q21BRUt2aUxFaStUR2owODJXeHM1Wk8zakdpbW53V2FEOWEzQzVSRFZB?=
 =?utf-8?B?WDY3SnhLZjhRQW5TWXZzV09OMGpNTTNUQjR4ditzc3VLbzFFU3JwQkZ4VnRH?=
 =?utf-8?B?U2xxZFBNL0ZIVXNLTytXYUZrVjdVSVJVLzd3QkYyemdQd05IT2h5SFpXR3hF?=
 =?utf-8?B?Qjc3ZXI5MnpVUGFTa1g4S0cxYlhXeGVEQ2VRR0VKRDBmMytudFdlbVJEL2ow?=
 =?utf-8?Q?JFvYsXwIRlEUKiibQQFOATXvU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32c54cd-94e9-4ce4-e073-08dafc489763
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2023 07:16:33.6439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXVTWOT5ckoQ9OFSK+f7s7lxkQJ5ut9dp92cK3kfobw0bJ6+as2WG1GGK213UBGR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8356
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 18:57, David Laight wrote:
> From: Gal Pressman
>> Sent: 19 January 2023 14:17
>>
>> I use clang-format to automatically format my patches, but checkpatch
>> likes to complain about:
>> CHECK: Lines should not end with a '('
>>
>> I thought maybe adding a 'AllowAllArgumentsOnNextLine: false' would make
>> it happy but that didn't really seem to work.
>>
>> Anyone else a bit annoyed by this? Maybe there's another solution I'm
>> failing to see?
> 
> Reduce the length of very long names and refactor the code to
> remove the massive number of indents and you won't have a problem :-)

That's one way to do it :), thanks for the response!
