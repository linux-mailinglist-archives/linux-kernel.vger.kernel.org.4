Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF636C7CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjCXKca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjCXKb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:31:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40FA212A9;
        Fri, 24 Mar 2023 03:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YO6V34tseUYf8u+5DbEh6WUorI0HLSeaGFwEJaHl/v7rRPuTmHc3TfFL+t9p9ch/WPQczwrpsaFFfdmaPVPcAaeeuj8UQNPif7BHC5ERUcmHUxoXB4eceBRmRo0XBMoP1K1is8MN/wkgTiLdrgBKTjdS5OE+tbP68GvbL7Ti4gEkl+QONnOkT0lMOlPI3Aet7KyiNW5csJMPKkJ7WRd9biWb9U/oxwOJmX63hJ/xeuxdrhIhiBGZWdILP4CW5+AuzJgtoPD6kFPV90HWyoYeGgweOgtb5xLOi7YHym3hDpcuEvH83Gn2Hkv2hptO89Eu1uY5VmaQ16t9V30YluCFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jcF6B4a/F4a9SZ8K9Hb8PxgFGRdbHrnKjoA3zqbq6g=;
 b=YtpDwxga6a/6BUjvWmy8P53pc24Fw6fDV7XCiSYXlHjpK7TnFgCEE2UStNXi1lkxFywXgV/ccBE5HGKNWsG1lPLCc+uXtk/WRlJhP/YKlzXTLulAHWBAWXNrer9Q691VXKkPZphKbKzOrVKpp2HO+icL3mmBCw+JHncpyc8M9MNBG3IoDQIry01uSj0kfu4Si7MFCQf3bjV8jaXZYTDwSlbkSuqEmJh3OYWdnCZ924K6bv6MLHiIQ6L1KFy/KXI/Trw+FUUJ/5IvwYs/dotUu/CjQmUqZeF0QFyUr8JMmItFlfarl3XF8AEE0g95hGhXX+GwYbZ61cSKMv29K2R/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jcF6B4a/F4a9SZ8K9Hb8PxgFGRdbHrnKjoA3zqbq6g=;
 b=qHBUuXm1wwSdEoA9ZdLUKF4SyOOwqsEhhn3ec/Fcp7NEGn96yHg6TfUo5tGroObjSOCL+R2mX6Z8tfZowbc34CtjSWCnFk4NXrBKZi/GYlRm+Bo3PW/0HPzxnaTL3dumG4g59JvOduV4UJygwJvMAZj6J200L1tpWv4vCM9EHIG/mpuxvR6M/CnvD7R+3TkMprcxJjPs+M1yov4/kNCvq9q8jVmMzuluamm4Q8n5W5w300WTTXi17ApRy0d856QFVQROzFWh7ZbM4ctBRo98akhqzdg582OfMLwfNV58fKE05HwHfDGrHF+NHjAm8/dh0XJ8QQqPinZ5zYc23Mh8FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by DBBPR04MB7562.eurprd04.prod.outlook.com
 (2603:10a6:10:1f6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 10:31:51 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::34da:496c:c4b1:9929]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::34da:496c:c4b1:9929%3]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 10:31:51 +0000
Message-ID: <092a6b6d-c3a1-974f-5237-01c3772daa24@suse.com>
Date:   Fri, 24 Mar 2023 11:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5] x86: Avoid relocation information in final vmlinux
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, nathan@kernel.org, trix@redhat.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        Fangrui Song <maskray@google.com>
References: <20230320121006.4863-1-petr.pavlu@suse.com>
 <CAKwvOdkFvMgYypc4w+UChO2O50wSHqXJUct2fkxrd+Qgn2C4Cg@mail.gmail.com>
 <20230321115746.GBZBmbujAI4ZBxVn0G@fat_crate.local>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20230321115746.GBZBmbujAI4ZBxVn0G@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::18) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|DBBPR04MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 67862e71-e504-4104-0175-08db2c52fafa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNEU0Ks0M2H5oAZLFPTIDLv3esqwmRkF0+DDx90vhv5TSiueGsO2YhO0zF6h9xg7muzCTclJOSRrTs1TDpJRQqaHNJKy/yttfwjD2auMF1AEa6zknHdGQbANMYZMDA+xPXxlOz2miW+BZx9szYthZWqoBX3BRFBfj9QRwELUvgUeMpfpk1l2PH+pFI8VdkAQ0SDtoSMKgTxY2hCNSvG3Z5nvdvpouJ6CAMwp222jv47A6ufXQhmqXNAHZIKdPrNZxdQffZBpnSDnKJGJlyBPTXPijcYCNQA3SWUIFzRHXPPY6Wci6mnlwhbQoXzHAiVSZfcKB0LpvExIvZlp/r6mbb+1HCOx7X8UPeZJDT4p4gWTSdskZtldLI4NpvPDFfRdhT/SQlPFwPMDjd0LOFBjAsC86SVG69Oir4WflxUqLW+/xsopwO5CPGyaUYS4+X6d6g2SnHEkHYCQDPksabvimBgCTztIZwUEwe4GQ6toYM9Yq6x8PHlJPwgCXZJkEzlM1H2oIH4q4dItsjQBymaY2hM5Pp3oI200IyEG5w/4rMkprvtKmDSPZEleL3Qe0PJWH1lxn0oSscRiwPcB4iIHLFrADereO5omRFPKdFINDxzf/DKwWiK4V483fF+c2cebcwLZxxpl6dzSp9WfChHckkS+dl3lPn8B7zsDHWmQUDgQObqGcGHZNP3S9USozUaQNTVogI79QYR/qzzMg8ncLZIV3If5lubP/r0CuVJDKOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199018)(86362001)(31696002)(36756003)(186003)(7416002)(478600001)(44832011)(66476007)(4744005)(66556008)(8676002)(4326008)(5660300002)(54906003)(8936002)(66946007)(41300700001)(110136005)(316002)(2906002)(53546011)(6512007)(26005)(38100700002)(6506007)(6486002)(55236004)(966005)(2616005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWc3aXNxNzQ4cCtlcW5BSkc0b0diazE2Z1ZxQlM1ZEFrSWtqeW83OFZaQmJo?=
 =?utf-8?B?N0EwUCt1M1V6eDZuQkh4TStMeWRBYWI5ODhzVHcvWDc2QmRjM2x2VmMwWDJ5?=
 =?utf-8?B?R2ltZGZjYTVKY0x3blVScTFmd1lPMXVNcWdsamV0QlVBRVd6cjBYTE5ZSm1q?=
 =?utf-8?B?NzF0eFl5emRFbnFacDdqYUVyV29JYW1vZnZGQXM1NmZBTlU2cmdXdXE0b3p6?=
 =?utf-8?B?bmNJWjFpUDlnZ1Vpc2E4TFVuV1puTU1DTmpvOXFycitJVUc5NjRLdmhmV3Zn?=
 =?utf-8?B?d2hkcUVOU2E3bkJtNmRnbWFoQTdJV0dPYUFQcEw2VmE3SVluVGFoT3Q0ZTla?=
 =?utf-8?B?UmpFTEVVd1ZmNG0xUkdiT2VGUDBGaitwMDhlQTZKR1VFZjA4UVV6aTZIU3F1?=
 =?utf-8?B?UmdyUU0zU253RlEvYVA0bTBySG9YZU9pMTREZDh0MEJOdVFPb0F2LzhGTlov?=
 =?utf-8?B?VEkrUEptMUwyVUxicUIvTFBjSzRCWmFYMEpPVE1XQzRodmkzS1lrNzRNYXRX?=
 =?utf-8?B?dWl6TTN3bnhLcmc4bjVvci9DZ3F0TWtpY0ZaSmNOSHlFcWJqaVRmcVBZWXNh?=
 =?utf-8?B?M05qMGFXcjNBdFFWZTMxYURwTnpEbThhTlptRzJ6VVc4enZjVzhVaTByK1pC?=
 =?utf-8?B?dXdnbzMweVgrUis0T3ZKVW1vaGpLVnR4bzlIa3Nxc1dPeEhHUlFibmZOZTdC?=
 =?utf-8?B?bHZqWnEvZzA0MEdYaDZUYVFhR2hXS0gwZFJRa2hNOWJRL3J3QlAvOXhUL3Va?=
 =?utf-8?B?ZTMyUldWV1hTTUYrZzh5d3VydElic2QwWXNtYXZucmEzeHNLU1pycnBPY2Q0?=
 =?utf-8?B?V3BoaWFPYWwvWTk2WnR3clZrcW4zWXlpZjhmUnlkTXA1SVBSN3poTlM5WWNt?=
 =?utf-8?B?dzJhcGpLMTRCN1VKbHI3MDZhUTBHNHV1dEdzVVdKRHJ0eHZka3FGdEVpWXZn?=
 =?utf-8?B?S2E0TDVzL2ZoUnYxZE1nbU1lVWhUMGR5ZG1idDFJSk1GZDM1YmpNK0pzb1BD?=
 =?utf-8?B?OHVheS9OOUtRS3BQNmRNY1VhMlZacmJ4ZThoNWEwM3pkNTByNU1nYUhVOVpG?=
 =?utf-8?B?RWM1dWpsWHdYM0Vub2xJRzhOcE5VY254WUlzU3d1UmJndm9XVTlCWGh2M09q?=
 =?utf-8?B?OS9QYUZBSGZJdnlZdGNET09CaGYxdEFlVzh6eTJMZlpLTFo4YmZWaHoxbmhy?=
 =?utf-8?B?RG5WM1JXV2xidmpDbWl4aFZweXpPZEhZdHFKZ2dVeGNZVWRDTXZld01xWkZQ?=
 =?utf-8?B?aStxQS90U2FpeVBscU91ZHk1WTh5bUJrb0JObnVtcU1xWjRtUlhaWS8yb0E1?=
 =?utf-8?B?WHVmRGlHMHkyZ1JwY1B1OHJNTkFHWE13akNrano1cHhSSG1Cam5PandnUUpP?=
 =?utf-8?B?MldqeGRoVHdDcTF2ak9HTDhrSVFaUCswdGgybk9CMm5ONG5OYTB2RlViNmVp?=
 =?utf-8?B?eUdqY01oanJybUhpWkl5U0dnSUxDRU5tMFcwSHliU0lLUU5xSFhsNTVrYU9s?=
 =?utf-8?B?L0pCK1d5QjVPR1g4bWhPNGxLTTNPbjdRUElWZkN2dytmVm5CUWxuNklBMDVz?=
 =?utf-8?B?ZUQyYkNVMEhOTEY0bmdRdjZFRnhTRXZCNGtCK1kvQmRsQVdNcXM3QkZaOUhk?=
 =?utf-8?B?TWRYUFZDalZYR3l6aGQ5VVRCdEhjdkFIWWczUS9nTWRSdFkxODBRZ0EveHh6?=
 =?utf-8?B?a1hDMWhJWFB3RWt5aXhuRGF0SThOZXY2U1VYZ3BFZ21GMmhrcFJyMHh1WEhh?=
 =?utf-8?B?UVRYTkxBWU1IbU05L1Q4RTltWVBTSVIrSXNKYlRsL05Ld2tEMXczMHU4VlFi?=
 =?utf-8?B?eCsrbjNLNE81Z0dzaFBMbGRQSXR0UDRpeDN1R2RhNjdOdDBFQlYyQ2ptMDJK?=
 =?utf-8?B?OXJqazRtYXhha1ZGNys3L0RRSlFQMFNFaFNTWkswV2ZkZmErVExDNm01Nkl5?=
 =?utf-8?B?aUJWRkVEOXR3T0tMV1c2MU16U1MzejkwdGY4dm1nVDZVMGZWMUlEbWx3L1Yx?=
 =?utf-8?B?R0RIR3JQZ2tRdE83ZGxYN0c1V25XR0ZjZFZPMERDaitpQWZFblBqWFJHbE91?=
 =?utf-8?B?OVVCb2xWVXhFTVVRMFg1Rm5jNTVvVDFNRU92ZXlTRmxod0JvSzZCYnVsbi9N?=
 =?utf-8?Q?3y0+tUslGE037wu2k0qhlgUb8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67862e71-e504-4104-0175-08db2c52fafa
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 10:31:51.4092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pR7pBivd8J5oVYnM4N9QohtftSclNCLJAxMj5Titv/ciVMhm4I5Nsj5UsKHpTCmexx8+VCOA+lEpmjqxwy6eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7562
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 12:57, Borislav Petkov wrote:
> On Mon, Mar 20, 2023 at 11:35:30AM -0700, Nick Desaulniers wrote:
>> Why do you move this from the arch/x86/boot/compressed/ dir?
> 
> I got an explanation here:
> 
> https://lore.kernel.org/r/16941b45-0f4f-e7c9-4602-d9acb0c612c3@suse.com
> 
> but my counterargument is:
> 
> vmlinux.relocs is used there, in that dir, so it should stay there just
> like the rest of the by-products generated there.

Ok, I can see this argument. I will update it and post a new version.

Thanks,
Petr
