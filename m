Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7226A5C78
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjB1Pzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjB1Pzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:55:31 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F1A14487;
        Tue, 28 Feb 2023 07:55:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXRPK39T1qHh49kxFmnVz4fhfRqDq7z2pb4K3Ub+U4PAIOZn/Ui0JE39zuFFv7rWKB55NC/gAjgetTFM99FS+u0PsSsCpES99uKN2e2wil41jmevZVSi1eCcsaF+QRY+aSzsKMjmv4xkfL9t1MNlvPPCQr1mIGY2cxnff9Q8K301Dw6A4plARvXfLJOiHih3USqhr16PPmieoskqSahDcv/RYGRXCRNf+ByMLhoJuJv1hYh3wAJ3PTrympXq4aK8Z1DkKBozLvPmC/OJJz4U4L7br316+eQeGCP3zAkL4z+9i35NevKoiUMr/jZASySbkVAeNdPR02Fo1FR1n9BNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzODzWYOh6iYB7/fOHmPZ+KaQSDRQXP0SNdeC9lPHFk=;
 b=TA8A5I7UtwZoRkLhdFUkuPaQ2AX+CYZn5sgWrysYx5ulA/jFPQnsav1tsCglGhC5OmkiZiC3K/iljPLGnMeONdvQTMJIwSRPwgbeWDtPjdo2539Q59fzsJOj0JIBrHSHQBmB8p38bpb5e83fLnm4p6lIRJbAlKtWEeAF3FRBxuKPieIBUgusce0r7GGktU91x1/GKWPAgQSNrQPWMWq5/CtiUymh3p2JQKsQOuLb1JjvxclNlwdYbyeXfTfO/zrsylWVx3ipI8FcHNg2pdSx3xU8SBLBB60/vNTmaftIj1zb59L3rkt+q7gnebuFtOt+x0v6jgvg5ekT/ICs2KTuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzODzWYOh6iYB7/fOHmPZ+KaQSDRQXP0SNdeC9lPHFk=;
 b=hLp0X8CnH1FrrtNqEiQk+xkBpjcHK8346JQUfMajp2KT7TulBXbTXCeuory3/eDQal8zKA2la/lsspT9bGUJFdkNTzvN3Dj+l6yiRMLf1d1ZN5m7V9QlAVLLyvXGINftQ3HjF8lkOBHLo35KMEh/JA2bESKHEAoAkeAvZjkZ//E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 15:55:26 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 15:55:26 +0000
Date:   Tue, 28 Feb 2023 21:25:14 +0530
From:   Wyes Karny <wyes.karny@amd.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
        ananth.narayan@amd.com,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH] perf/x86/rapl: Enable Core RAPL for AMD
Message-ID: <Y/4j4q97NAKM6YfX@bhagirati.amd.com>
References: <20230217161354.129442-1-wyes.karny@amd.com>
 <Y/NdUjLiQu+D0q7b@hirez.programming.kicks-ass.net>
 <CABPqkBTU_gnTr9ayvg220T4pO5NAguvu_UJAkZO2RUATWuMJ3A@mail.gmail.com>
 <Y/ROTsCSCFtrwwTK@beas>
 <CABPqkBQ_bSTC-OEe_LrgUrpj2VsseX1ThvO-yLcEtF8vb4+AAw@mail.gmail.com>
 <803f7ef2-f217-65fe-d0b9-98ae469556fa@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <803f7ef2-f217-65fe-d0b9-98ae469556fa@collabora.com>
X-ClientProxiedBy: PN3PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::20) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|IA1PR12MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b1466b-6914-499d-eb1b-08db19a43537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2oJFjzRxYM41kpsNHXg6XHPPH3F7bmo9N9p2cX1OFC0kYjJMp2lujzAe7FAav8cS/fFpd3TFmlzWrwwk6zaUXvFVMj5HwdzhGHi6mBye47Bl+Onx17zj7PtSCGydpjLtQBSMmIQ1mmE7CM+Dy7AveTiVpowGPMkuOVyHUizduH+BA7nHXEU7Zool4hEEkECtLAWXar0UOR2PTuKD9faWhrOC29/5/Fo8JEcmwTK6i74slOUwAKosGaBtf2qmd+pLK/et+z8/BuHy3dDvxnZqfYnrET+q+fp0Z7kicnTeib0kS/SWI/qPcfYxfY3VFUkz2FVIksiD6C3x8/uhNuebljPjUeLDDJB5TWMzZ0aOe7jAJej0rp/hvWHcUV/hviBg8A5fwBEIWuVJqcN37A3GBA0ytDWJTzrddkPwy3p05+Qtb6acRjwF47KuUIgezY+GCdoKOPBie2Jgi7fntol8HNPc2eoUestk3u7TTQDUBI4D39RxheiL4fsnV6Bkg5B7mzCgwLmykg0Y/ZMXB2szKoNpVzF60tRPNzA77s8uHIDwfUHZkpfkPijYKP4QPGMZvgQpCfyRTrovLLOicmLKx1SwCdnYKX0bewU7R1y8gX/1CQmdSN4Rv3TYQyEFvB5Tlmjavuahn/X3sbFeHCmBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199018)(38100700002)(86362001)(44832011)(8676002)(5660300002)(7416002)(478600001)(2906002)(66476007)(6916009)(4326008)(66946007)(8936002)(66556008)(6486002)(41300700001)(6512007)(26005)(186003)(316002)(6666004)(6506007)(53546011)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2VRRm5XTmUvRWNabFRzanJyQzM0dmVxVlpXdFRraVJNL0w3VVEveEhRcFpU?=
 =?utf-8?B?cWhYZlMyTy9WMW9XUGp3SkxFcmtzZGdlcXhOaEozSTdRa3hPOGFRY0NoM3Nu?=
 =?utf-8?B?ME1SbUtpL09uTEVPcTg1VW04c1dFZllVdUZMTHFxRlp0SUk1Ym5oZVYyRXlJ?=
 =?utf-8?B?TnBLd2lqWW1DbzV1b2xvWUlNR3hDTjJ4Q2YyTENsSC80OHdkeGNzci92REFL?=
 =?utf-8?B?WGdaUlJrT2JaUklpallEWjhPRDBiVy8yb1FGdXYya3ZZV2pyaEE4QkZWcWZK?=
 =?utf-8?B?QkE3bEhiS05oeEdnOVJHNjJSMVNwQzNoRzhKVThuSGErUytRYkhhMS8zTXIz?=
 =?utf-8?B?STEzbWU2MnFteWdLOTNNbHhCV2dsbWVHVnY4WUl0WTBJcmMrQlhvM1RjazNa?=
 =?utf-8?B?NFBZR1N2bXg3SUVHdlhiRG93cDQwOW5WVzBxbVJkcTdvWnJCZzZhMHB6SWF6?=
 =?utf-8?B?ZmVuTElhYnU1T29RNjFxU0NKV0dJbXVUR2VrVHJrQTE1a3JTRVMrUk1oaE9h?=
 =?utf-8?B?TS90a0pXMTdacTUySlMwMUt5TTQzU3VvZjAzNFp0YytidXJyc2V2SGh4NUJX?=
 =?utf-8?B?QnU0S29Cc0RNdzZWUzlBZ2JGazdldFVKZkNvZ3ZPTDVoSjFQbE1BN2JDTGZR?=
 =?utf-8?B?eXEwN3RGbXF1VTg2YVFZWjd3SndWdHpYeE1Na21JcjhWaG1oMHcvUHd5NC8x?=
 =?utf-8?B?aTV4MlJEaGsyYzNkQmJ6TWJpaE1SUmUwbHl4VnNRV21odnFmb1N0ZUdGVnY0?=
 =?utf-8?B?a3crTXo5UWMyck9VQ0o0dFNNSVpQQ3RKdG1UYjlCOGtPNlJYTFNCUDZuZ2s4?=
 =?utf-8?B?ejh3YzN1VVg5WExMb2lmd0QzUlVGTzNNYXJQT21Jb2I0NGo0cmJpQnN5UHhi?=
 =?utf-8?B?ejE2eEJiS0xuMkhNQ0ZzTTFLMDRvMTI5MGQ3eE16RHNzVHUveStXWlN6b0di?=
 =?utf-8?B?by9PQ3pBb25zOHoyTWcwdzZXanAxbWVWOG9RdWlZd2R0UVpONlMzYXBHcUEz?=
 =?utf-8?B?K0U5elhZS3RyOXR3a1BTRmMzSnRmeWJpbmxMdmxXZkQvN3pLdGxGbE8vTHkz?=
 =?utf-8?B?aUdELzZHN0haeitKNmh0c2V6TUVUeURQQWZ0bm15NVdrWk9DbE1Kd0lpT3My?=
 =?utf-8?B?RDkrUXJjN05vcmI5bklqdzc3Q0N6dWRZMTI0eTRiL0pLTnBmQjNsTHhhY2dx?=
 =?utf-8?B?YWxqdnVWMlI5bFV6YmNpL2dJbFVVTDEvSTh6SCtROVEwQWlWSTVhaDROZkxF?=
 =?utf-8?B?aEFCR1VxaTd5aFpvTGVyQ1YyUDdOeHlPUkN2YWI3R3VjdUZwd3FVQ1FRdENS?=
 =?utf-8?B?d20vdnlTcDNLMkswK1ZKZkhweTBzWEt4dFdpRWRPT3owNisydktsTDVhOTl5?=
 =?utf-8?B?UWZXNUo0c0g1NVZ4MC9nTWhvbnErVStPOFhxRllOZzdkSno1YW9UY2ozTFhr?=
 =?utf-8?B?YmxvUENQNURnNy9hQ2V6MTFTeldUUWF3aXBmenUzQlNMbG5MMXlkOGtQeERP?=
 =?utf-8?B?enNmMmgvR2dzTUN6dWZEdkxubnQrVUhrY0l1UkxOZVBSeUxoUTJJbjVVb2Yv?=
 =?utf-8?B?R1YvcGJmUU5LcmFlMzEvbndkUGs1eHk0Z2NaTnlTLzh1eklTanB0VWlmZVp1?=
 =?utf-8?B?SkxNallrV2p5UXZXNGhRNHpuN1hoZGJOR1l5WmhEcjd5eVpmQTRKR0g0N0dw?=
 =?utf-8?B?NlFYZm5rSFRtNDZvTnZxRXhiMkpObEhSblR4SUI0ZGQzN1VmcVQ0L0IwaUZj?=
 =?utf-8?B?RUdSY0g2eTJ3U3NUTUhxM2ExUFlQbjJrai94YzZEenlaMFFpdTlqSDNZWUl6?=
 =?utf-8?B?aGFYb0FGTkRDT3FkWm04c3E4Wm10RlRmSDVNSXhPSjZRcW5JcmJOV29YOHk3?=
 =?utf-8?B?L1lLeWYxRkRqR1hveEZteDZxRit0blRYYityMzN0eTlPcVdSVHlkTnJIaFY0?=
 =?utf-8?B?SU1ycWovVmJPeDRMbDJ1QUZ5UUR5UWtKMjloYlcrL0dETkpGZXpOdVp4dFhm?=
 =?utf-8?B?YnQ0UVU1SWNNSTZqZFVjTXNTTlgwZWRsbmRsTkpjdEFNd05wbnBlVTRycnhU?=
 =?utf-8?B?dVJGS29TY0ptMUQ4R1kxNzJHWUlaK09jTmh3WGZVdXd5MTdKZVdmNzBxQ2cx?=
 =?utf-8?Q?6fHqwefd3QFvqTvZJcmRKy67r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b1466b-6914-499d-eb1b-08db19a43537
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 15:55:26.3432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f63eScFMIePyrvQmK7AX1ooTnOuW+RtT1r8cKaNEIQ3+9/vlugwLOuKmhitXWPctZYyvldgM1Z837VJW8vqNWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muhammad,

On 28 Feb 19:20, Muhammad Usama Anjum wrote:
> On 2/21/23 1:50 PM, Stephane Eranian wrote:
> > Hi,
> > 
> > Testing Wyes' patch for energy-cores on Zen3 server loaded with triad
> > bench on socket0:
> > 
> > $ perf stat --per-core -a -C0-63 -I 1000 -e
> > power/energy-cores/,power/energy-pkg/
> > #           time core               cpus             counts   unit events
> >      1.001019203 S0-D0-C0              1               1.28 Joules
> > power/energy-cores/
> >      1.001019203 S0-D0-C0              1             231.38 Joules
> > power/energy-pkg/
> >      1.001019203 S0-D0-C1              1   4,294,967,130.96 Joules
> > power/energy-cores/
> >      1.001019203 S0-D0-C1              1             231.38 Joules
> > power/energy-pkg/
> >      1.001019203 S0-D0-C2              1   4,294,967,126.23 Joules
> > power/energy-cores/
> >      1.001019203 S0-D0-C2              1             231.38 Joules
> > power/energy-pkg/
> >      1.001019203 S0-D0-C3              1   4,294,967,122.50 Joules
> > power/energy-cores/
> >      1.001019203 S0-D0-C3              1             231.38 Joules
> > power/energy-pkg/
> >      1.001019203 S0-D0-C4              1   4,294,967,129.92 Joules
> > power/energy-cores/
> >      1.001019203 S0-D0-C4              1             231.38 Joules
> > power/energy-pkg/
> >      1.001019203 S0-D0-C5              1   4,294,967,121.49 Joules
> > power/energy-cores/
> >      1.001019203 S0-D0-C5              1             231.39 Joules
> > power/energy-pkg/
> > 
> > I think the result of energy-cores is not reliable and I think that is
> > why I did not
> > include it in the patch.
> > 
> > Could also be a problem with the kernel code, but I don't know why it would only
> > impact energy-cores given energy-pkg looks reasonable here.
> > 
> 
> I'm getting consistent per core energy measurements on AMD Custom APU 405.
> Probably consistency depends on the chip.
> 
> sudo perf stat -a --per-core -C 0-7 -e power/energy-cores/
> 
>  Performance counter stats for 'system wide':
> 
>  S0-D0-C0           2               0.51 Joules power/energy-cores/
>  S0-D0-C1           2               0.51 Joules power/energy-cores/
>  S0-D0-C2           2               0.51 Joules power/energy-cores/
>  S0-D0-C3           2               0.51 Joules power/energy-cores/
> 
> What is the fate of this patch now?

I'm working on the issue reported by Stephane. Will send v2 very soon.

Thanks,
Wyes
> 
> [..]
> 
> >>>> Stephane, this was an oversight?
> >>>>
> >>> I think it may depend on the CPU model. I remember it returning either
> >>> 0 or bogus values on my systems. They may have improved that.
> >>> The commit msg does not show which CPU model this is run on.
> >>
> >> I've tested this on Zen 2, 3 and 4 server systems.
> >>
> >> Thanks,
> >> Wyes
> 
> -- 
> BR,
> Muhammad Usama Anjum
