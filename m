Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0B56E248A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDNNqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjDNNqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:46:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02451E4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf3x9qMa68x2By5Km6LIpm4xbCKgAO0vY3ge+Dbh/bZsJ6vo6DwpElnwFmY80uHhL3VqQMI9QCp2EW1aC3W32Wi7mVeNis7p02H7fc1HTaZllrE5gKCb9PpOyemH98HzP1Njm8lUAN9Bnj5myQRF0Rjk3M40N9wNjkx0Utq2xkCpnhQQNbchs/vmvkM86WPVyqo0rQpsdrKZkwVofO+jvhDqMaXNctWwCHoR4El9Dimf4Ys2txixYzDnajced+hh/ruAxvWh0tRs0WjdTWQ2bJ+iWXn28jXVDulE4WQiS7iZ1jDdmSaupBFOspJZ4VPD0eI9q6Zu7lGqovNfcYjSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZvoBsTqr5eaUyh7OvgnrBBCSsV0OYwudnEccSp9Un4=;
 b=G8jgx0vxE22GMV03/bSyrYwOn+HkDssYVjvS6AlFSLdQG0BrHAj76hgzs53RodkNYILt4jiLLx62apit3WJPlClnVRq+p0gxIu8zA1v51VmJIURpIOC5PzlvQVN7iDoOk31WmeLPgPSyegS2HuG3cbIGS6cqZBuqplH/SXiEASdSY4DedBWbPaJ0osrKPZu4GtMdxsLHsMzUNMkuI8BCbysM52Dif+D7RImpk5aytwyoT9LjSBWzDUNkM0mvWB8SPzMinCMuIyK8dkp8XrTNmrWiMwVxhcMASC0bdufMCNFLKROga8orFYtXb0DdMXjRLr7H1RN3z7JGs2CiEUX3RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZvoBsTqr5eaUyh7OvgnrBBCSsV0OYwudnEccSp9Un4=;
 b=iY3uQmdwmP197bVZ1amM650rt++932Q/lBlVSprja7XaqSlhNDpTLh4JEN/Gnx/1hrc8q28IxcokSESl1GEdqO7WQ8cb3eLqrecrD8OnU/C5wGAxBEDUdNkwKELUh31cgsezI7ie2Cr+FR4262A7rf/49EvprrMDTcZre5A9HSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 13:46:49 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::faa7:21a2:a446:973b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::faa7:21a2:a446:973b%6]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 13:46:49 +0000
Message-ID: <8568f43e-8bce-1ee1-d304-a8a38de78ce3@amd.com>
Date:   Fri, 14 Apr 2023 09:46:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     yazen.ghannam@amd.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD EPYC 25 (19h): Hardware Error: Machine Check: 0 Bank 17:
 d42040000000011b
To:     Borislav Petkov <bp@alien8.de>, Paul Menzel <pmenzel@molgen.mpg.de>
References: <21a09968-296b-5b21-8079-6d9d4e0769d4@molgen.mpg.de>
 <20230412163240.GAZDbdKHjmQcxqkeDQ@fat_crate.local>
 <a5ab1099-fd08-c708-5532-21dc2a622695@molgen.mpg.de>
 <20230414102401.GAZDkpwUHfFM64dpIK@fat_crate.local>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230414102401.GAZDkpwUHfFM64dpIK@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0898.namprd03.prod.outlook.com
 (2603:10b6:408:13c::33) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: becfcc02-f270-499c-d2b0-08db3ceeb218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5AlhzMSbMYCWGDpU73k+pLlZFbUnzFKUpQih1yjRZZyJ0fBt7Sb4EUSuk2A4gKrZg8xrvTXlLTj4oNYINM2OGwJDI01jrHFPXQed78p/LbjLSm3kHrnA6zvnR6K2PLRJgg1yHaAaubTi+Tr2BmlVSjGtU67oP6yCTDDWy5V4lCc/lo3nt2jjfBkSV/1MhbT66jiKwaHjq8kbjEULSsudIN/m84LyyOEXe+Xw63pXfi5yL2DOFmvwhOkvXV5MvnRDtzP+q6NEGDv5z9osin3JrQOlq/qsF/THh/LZeDZiyy5cAc3raCIs/jWFvwjHH1P9lV7Phub4korcJZFzuNrEMIO2RIr2119kcRtRsL0Qf3K4P0OaCQsfzAxTypN+Dz90XXzxTbKUaV1gjOTr62D6kt3KTtd58qJfty9f03bQNqIiWi2nIpzm07vCPteTWRzBJgIPTp0hEk2slJGMgECFI6694FWHIO22igmRLYqYX7wODxaq0xB2Pf7niExcK1r/i7hLIyeISjsFOy28neavl7L+IHat/fkcvSRqfYwevDSBinZL34vQ/fEmX6/fLSR0a3LQWcOhxc5jWYF0ZMxNwvTX1rmOLAs2Zin9S+jkEBwxTeYxaM9Gmob9SfdBrBy3l4t1NovE5/xlO4vsN9kkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(316002)(83380400001)(110136005)(15650500001)(53546011)(6512007)(6486002)(31696002)(26005)(186003)(6506007)(86362001)(6666004)(36756003)(54906003)(2906002)(478600001)(38100700002)(5660300002)(66476007)(8676002)(4326008)(44832011)(66946007)(66556008)(8936002)(31686004)(41300700001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U284TWp5ekt2cWNHUTBBRE9UNVVNSDVCQXFUVVVCa3BicnZDNE9MYnJWeUR0?=
 =?utf-8?B?eE9RcGVQSU5IS3lVYUhXWk8wQmFLV3R4QitJQ0RoK1BST3VsYnljb3RMOCtl?=
 =?utf-8?B?Z21nMVVnd2hLdzRJZzM3WFFTajVDSWo4QXRuSUtCUlV4dXNvaENZRFRRcUtP?=
 =?utf-8?B?YTU5U29ES05KbWZMVHVqaTB4bEY2dUZvcHVMZ2trRHRxVFBpbkFxdHJFblY0?=
 =?utf-8?B?bitCNjJNSUlRa3ZaaWdxYmh0azFRZ1Aya2JadGg2ak9rTW1mTE1SS1FMMU9U?=
 =?utf-8?B?TVVSSTROTmdoekJLdDBwRXpxOGdwSUlyUW1Hbm1GM0dPRTFyQWh5MmkwSmMy?=
 =?utf-8?B?Zko3TkNwYVlkV3lmZW9HQmJycGtLQmVQT0lhNncrd2VET3NNMmhLaVlPT0Z0?=
 =?utf-8?B?WTk3NTZqWnp2VDhNb1pXd3pnZlFZTytsbStvTjkvbW5VQTVFTGZyTzdnbXBF?=
 =?utf-8?B?aXl1elNZTmtFNHVzTmJzdnhKb1RjcXBGK1F6TEZBWGdiNUk1M3NlS0RaeXph?=
 =?utf-8?B?TnZhQXo3WSt2bjROUzdUQmxFdUFiMG1URlF5cGp2L1JwMTc2ZnJ0YUdzR2lw?=
 =?utf-8?B?RCtaR1pBbk1ZR21DbDBoK2RUbGwzZDJIb0Yzb052Qjh4b0NYNkJ4N1Y2VDlM?=
 =?utf-8?B?bjVYOTBjYkV2N05Nb1lsN3lQd2c1ZTRxb2hSSnkrZUJQR0lub2l2VnpuUi9m?=
 =?utf-8?B?a1dUNkJlSUl0OElZL1FXanFCcVl0dFZwd3l4NjF0YnlyaDRMbEkwWFR3aTJj?=
 =?utf-8?B?NXRiSXQ3OU15UU9GN0lpUlF6SFF6U0ZFdnFyQkFGcWFDVHYzS3hwSDJjOXF1?=
 =?utf-8?B?SlNTNVRnNVVWNlVsTDRDcitzenBhM0R6RGFEdFJPSlp3UGN4RHh0TFlXUC9j?=
 =?utf-8?B?RW1BOFVrS1Jtazd1Qm1KQ29iVTFKNC9KMGd1R0c4cXZiMmp3WFR4ZUpaRFB2?=
 =?utf-8?B?a2FneFpjYnJoUDFUTEhSTUdETUNTTnNkK1BpUXJVUXhlYVovZzVGaTBVSFNL?=
 =?utf-8?B?dm1CVlVJd2RGTDhleFp1UTlRaGYwTHhjVGJrSE9hZE1pOGZNY1QwcXVvemlH?=
 =?utf-8?B?aEx1WVRtWkNjYTFSTEhDcW5JUE1jUmhxeXdsdTNJS09ldXB0NUhzUFBDOXVP?=
 =?utf-8?B?TE1ISlRNeG82NkhJeTIvZDZZRjQ2RUpQQ3MrUFptUkw2STJVK2Q0QzBDcGdj?=
 =?utf-8?B?bTZRbTFHblk0NGtnTGZWNzJNdkhOdHRBMjhiM2xBU0t4UkpMSjFjb0lsQk1Z?=
 =?utf-8?B?bkNjTk5XQmw3QnBYK3hLWDUySnFHdHFRU2s0dFFnU2VPcHpYRDJOU1FvNUY2?=
 =?utf-8?B?dkM5WVRuZ3pCQjdEZmJFem5GdUczbXRTcjN2UjJpVTBJTmIwZ3Z3WE9ENzJ5?=
 =?utf-8?B?aEFhY0hmbzdScTFVTlZVTXBlQ2hRSGFEM2p0bHNVM0xXS3RGb2FZU1VTYzF3?=
 =?utf-8?B?K0RPQnpwbHgrRXV5SGpqaWczUGxGWnp2eG1CRENZbHZWVFZaN1VLVVF3TlFo?=
 =?utf-8?B?RVFYZWVkWllUbUw0UGtENEZxcWh4dkMzQXhlOWRLdWZndkxCUGRzRjB3Ykls?=
 =?utf-8?B?aTdGaGJ5SEwxdVVNNnFzWno2dVY3aUhrU0RFc1RndEJSVjd5dVlEOHpPVzBn?=
 =?utf-8?B?aktuRTY5enlPYldxK1F5azdldy9qLzl6MmtsQ240QTg4SGlVLyt6N09leUwx?=
 =?utf-8?B?L3NYRi9Xc1N1Y0p5ZGJZNm4wTmxDS3RhSDZ1bGJ6aE42N3B1cHo0eDdNdXNF?=
 =?utf-8?B?cVNXOGE0MkVEd2tWNjR3SjVHcU4xQUo0VG1tby9QQ2F1akxkSnhkVXR4cGgw?=
 =?utf-8?B?U3grL0Z2OEovd1p0UVFJV2dhVE96WHF0VzQ3UWk3a2M2TGcyeHk1U1BnMlhS?=
 =?utf-8?B?ODNNam0xaUxxaW9JUGZUelRHUlUzd1Zya1dVbmVrSXVxMlFxcjFaOWZJbkV3?=
 =?utf-8?B?SFlNa2pwQlV4L05aMXNJYVFyWnRSNFdtMG9UcktzdldIV0RmdDRnT0pkY2NS?=
 =?utf-8?B?QkFYWldsMzJUV2ttbWh5T2ZTclpXbXAzeVBHUGhxdVl6VmdSQXlSWUZYQUNF?=
 =?utf-8?B?TkM5K3MzRnQ4ck5zdGFScUU1dkJnRzlHSnpvS043QW5BYnkwcm5UQVpwSjcv?=
 =?utf-8?Q?oIJsbFYZhx0jS1C0859GeMS3s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becfcc02-f270-499c-d2b0-08db3ceeb218
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 13:46:49.2719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeKE/TojXzVKDn3tf7c5OYInNbLMU31lWyz7Mj/f8HzR8i1MBt7q1aUhgrfWaCoArxMwSrF7A6c2tR+4aZFUjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/23 06:24, Borislav Petkov wrote:
> On Fri, Apr 14, 2023 at 11:26:27AM +0200, Paul Menzel wrote:
>> It says “no action required”,
> 
> Yes, it means you had a single bit flip in some DIMM and it got
> corrected by the ECC so you don't need to do anything.
> 
>> but out of the identical 14 servers with the same workload this is the
>> only one having shown this errors three times.
> 
> Or you could enable CONFIG_RAS_CEC and don't see those errors anymore.
> 
> It all depends: a DIMM could be producing correctable errors for a long
> time before going bad. If ever. If you don't want to risk whatever
> you're running on that machine by a DIMM *potentially* going bad, sure,
> you can replace it. That's a budget call. :)
> 
>> Maybe the DIMM at bank 17 should just be replaced.
> 
> Bank 17 is the CPU MCA bank which reports the error - not a DIMM bank.
> In order to pinpoint the location, you should have amd64_edac loaded so
> that it decodes to which DIMM. You could try loading that module and
> injecting all errors you have to see what it says, it should work this
> way too as the error signature has everything needed for decoding,
> AFAICT.
> 
> But Yazen can chime in here if I'm off.
> 

Yes, that's right with one caveat. The info from EDAC will show the
channel/DIMM from the SoC/CPU's perspective. This may not match what is
printed on the motherboard. The board vendor will need to provide that
information.

Thanks,
Yazen

