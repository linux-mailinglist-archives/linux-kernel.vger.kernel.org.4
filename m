Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFFB6E21F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDNLYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDNLYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:24:50 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9E510F2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hw03sgp6lOK5y/yHquA6r2SIRGdBWmFOQBOqR4bk9lv6Onj3Y19oCNfFHRN0/EbBrid5Kk6gMX9IQ3n+F8YohFmKuIXjekMewZtIF6gCgqGrlLva4ejFjReCQDyYdNSKhpIfUFXrwb1ax3ElNjc3QUY8xrmBLXk6qKU9hnfxgN0+5t+T8Fh14mcWXnkfmDJXQm+od8n4+IlKBY7Pr3EhR2n4QDGaX3qHLrKqw+IF6MUlwAcybefcrliueN4kjYigWR2AwOQKB6w6RJrQPIAB3hhLPLMCRjpJ8eMfdu4PAz0SQX+ms8OAoxMyfYDE2czG7lX33j3ksmF7Ve7MVKaonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOtMfMyOq6yn2Vx75byy1NJuq54TcKjrKUCy7xPe23k=;
 b=m2r8Zg/SmVnPM5rynwkVzXHVQwL9G4gbQ2gDhdJuA0CzZDtIjZYb1JcLxpsnY1jCKyzz82uBLfY8ZhHZpjKflQXvQpGPHrRuqc3XAZC5pDRfPVFlwsLJWZUsjD63BqJjzvrEM9CYZTNHzhFwAoTfumf0x8jGKrQ/gawHkfGjgD+eLqvsobfiBkw0QGnlpwu4vWyGs/neIJhgfvPZdykuAa4d6ogSa96m3eBHMSQUtW4KTIExOjZtAM5nDPkUDQPkKLp5iluwDmtlDavnGTQKHOZJhWNreEX/gEUtxOEN3pF/ArbR07hzXitznClHNfgUyVFbecEt/PPDtYK5LxuT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOtMfMyOq6yn2Vx75byy1NJuq54TcKjrKUCy7xPe23k=;
 b=sOfMReBWpJF+kvErGt+Y8I8XyJGEu3Xx0vh3DmNGLvyVdXOCRaxu9rZtjqtcIAIiZwqCHUyqOkfCBYM5EMq30JQMVIb3F0X/6g3oQVRP5ru7EgGgWH+bY3Xdwp8qsEaRv4VXvy+5fYfsrIc5nR/iEqxuFqKlg1iwJr2DYJQ/hD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (2603:10b6:805:73::15)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Fri, 14 Apr
 2023 11:24:45 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::5b9b:f31f:ac6d:be94]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::5b9b:f31f:ac6d:be94%6]) with mapi id 15.20.6277.038; Fri, 14 Apr 2023
 11:24:44 +0000
Message-ID: <1cb7d428-c047-1485-e39d-465806f6ef0b@amd.com>
Date:   Fri, 14 Apr 2023 12:24:38 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
From:   Ayan Kumar Halder <ayankuma@amd.com>
Subject: SMP enablement on Cortex-R52 (using PSCI ?)
To:     mark.rutland@arm.com, lpieralisi@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0586.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::7) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2621:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f97b764-b6c4-4d76-ebc5-08db3cdad8f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHc9T/4GFYcuMQXdgg9mwwh8xRyeldWM2yp07L46i1AfdwsLqUxtUMJAAKXRpVXcxX6HpfWEotrOJh7uJpqXECap3N+f7jqGn4rxNkTiOPtJxg2dbP42eibFT/ZYdTC5o5MjfRAL4cvcnPT2Hssdi5NRvmm9l0QvHnIYvOoZbFDFakpzoFy7h8ORBXfqp8Dswi6UfjlykZmRN/G8Jd+UFaYP6R8I/DNgX/V2VlAhgjXdKhF64yZF4zK5x1IPfldhJO7TAFQ/68YTC+I1X+M7knbrbA4Ih41/OCprOkHwZvuFwuns+HdP51ZNOfLxg300/t6agaUPXVwi1oSahL4X/VWR5UXkFT8n2/5ou8HbsfblsYvvlnpwz81diKnrLi6VdlCJFmK3QjORqxrOrWry/0C6URVZVMavC2HpMEmWYNOSABwhI01O+1zMqdQgBUO0OIUyUCW0NkH54bV4E0eqGk1L8VdrUVXX9242sE5clH6SP0m1wXw3uQC6ix7xNPJtXB81e8bLPwqPtAG9ulzA/aejLHglbxLFebVEWsQVXgi7LzmS+RxEbQGpUdlceCLFnf3RFZULXJOvzpLeOzZ4l/j1x9RM4t0umOz1PwBLeEv1fH0pPRbQkljXhi9IzaZF7qjnuyh6xa5ypwASrTozORdqRHeah9I8RGiBrZxPN/QlaAiYXiga8Xu3Qy3FnRz2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2621.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(2616005)(8936002)(66556008)(66476007)(31696002)(66946007)(4326008)(8676002)(6486002)(38100700002)(41300700001)(966005)(54906003)(316002)(36756003)(83380400001)(186003)(478600001)(31686004)(6512007)(6666004)(6506007)(2906002)(26005)(66899021)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T09NRDY2WEEvcGRrQzdaWEZCRXgzbndtZDBPUmh4aXh5NXlIaUdORWgyMkNG?=
 =?utf-8?B?dkJiNkZKaTdZRnJMemc2ZDZIVGN6UUt4MzYyOVcwa1haTWtTL2VwUVNmQWFM?=
 =?utf-8?B?NUZUSENkNGVxR1F2R2VJdWZlNk1WVVVaVy9zenZ4eE1BYjg0bmE5cU5ra3g3?=
 =?utf-8?B?eHVtSEJ4bUExb0lISzIzdU41RkxPOHVXZkw5QWhSWHNZK2JjblBzT0IzTlFx?=
 =?utf-8?B?WVZQZXZPWGpjWTZ2R2VwYnk5RXlFLyszMCtZSDNMdVBTa1F4VHZqY1cyMllN?=
 =?utf-8?B?cUNFcGRoTFdEbWZLRVN5d29KUzlKUi94L2FkcGUyOVFjc2JHR2xQaTlDQkVE?=
 =?utf-8?B?Y0VkbldoTmp3UWNjS1dINnlnWjg3RnFIQVhnZFFlWmdjcXlQbDJTVFJFODdI?=
 =?utf-8?B?N25ZbmdOeXFPVGg2NFRTdDJ4elVacUxOcTRkWWtib2s0SEduRnVLa0VGT0Fu?=
 =?utf-8?B?bitNLzd6SGNGbDcvbHZLNmZrYmxTVHVZOEVBV3E3V25rS1VIOTQwVG9GTmN1?=
 =?utf-8?B?a3F6NTl4QnQzK1ArZ01qby93c0pJTWIxaE5JSFlIMFB6cGVOQzFDOGZidVNl?=
 =?utf-8?B?VUJQZ0RKWWQ2VkJ4d2pWdUNudGJENEFydzRydjhaM055ZVNKQXcwRkVVQVEv?=
 =?utf-8?B?bkpRYmxQUDZiNnBNZTI3Z1VmaGlvZUN2QVBSeTVxZVRFUnFSdzdtOTgrRngv?=
 =?utf-8?B?czdqM3Z1WWgrc3JUditNRTgyQzZycW1iTmdXcjh3TDlNWkRBWUJSd3lOMkY1?=
 =?utf-8?B?ZWhwSG9XVWJZVXRkL3R1d0dOdTZjWUsvVEp0Tm9GT1Q3Z08ycHlNUkhSaFZZ?=
 =?utf-8?B?SUZ5S3Z1alJmOHZqL3JFekN2QU52YjlGRVFqNEdCc3NqY3g3cnJpL2xxNklD?=
 =?utf-8?B?QmxFamlkSlUyam1UV1k3cjUyczFOREhEblFsN0h5U0ROVGxtOHpYZ3B0VnJC?=
 =?utf-8?B?SUI2eUVsUGw3US9kWVBMT1BTZmZsMEdaazJ1SitlM3h2NDJiR0NNdFBzelVF?=
 =?utf-8?B?VzQ4a2tsOE5FV08rdDBXN1N0MmlQTTFpbmRPL2FmWVVwWUZYdFhxM2Y1SE9q?=
 =?utf-8?B?a3JuQkVQK0tMS0FhMGlCbHhhbzVNTTg5SmxGN0tSdm8wVy9NTmN1dUNJNUdu?=
 =?utf-8?B?c2h4MkFxemRlUkRUMUtGSlpVcmVRYnZiRFJKTlVicllKK0FlV3ZTMFlKSWIw?=
 =?utf-8?B?SldEWXMyd3FPMDYrVkJzQzNBWEVZeXFtV1FaRW1jdWVlZXZ1YlJGcFZWcDJC?=
 =?utf-8?B?RnhCUXJQeGl2Y1BJNDZMTDYyZEMvYmlUazJpQ2ZwZmVtcHN1cnJuMTVCdklS?=
 =?utf-8?B?bk9yZEtndjdFQUpJRVBlb0o2S3p4elpqc2dkck9tQWtvbklGNVV1clYvL0hp?=
 =?utf-8?B?TUY2TmozOENyRm9VQzhPYUdoVENTNEluQ2xYdjV5aFdFNkNKYlphR1h0aHly?=
 =?utf-8?B?UmZvRitqZEY4UVFoeU5RRTVEd2RjYUEzMWgwUGdyaVZRTUlaRU43TEpQKzMx?=
 =?utf-8?B?UTNrRXQyWGNTVy9sam1yTFpLMUtucHVmWnFxdldQOGlTaWRlci9EaEVHMkdj?=
 =?utf-8?B?dEtSOGFHUG9wUkZqZmpFWW81c3djdDlRd0lTczM5SWlVdCtJb1dUTUQ0aEtS?=
 =?utf-8?B?N2dTSUxYbG5rZWxQVitkNUxSa1J0dzNOdjVtNHY0MFgrQ1kwUDMyd2JrVVZS?=
 =?utf-8?B?RmVYRHU0RWZ5dlVOVldycFZiRlc1OGhqK2JmMFZtV2ZTbSthK2JKTS9sV2lS?=
 =?utf-8?B?c0x5dVZ3a0NYaVdnM1ZVVkZqMjBCUC95QmduYjU3cGRkQ2ZJZWFMWG9zdk1j?=
 =?utf-8?B?ejMzN3VIQTBWS1N5K2p1b0xtSVVObmxMWVlTbTRNRWgvRFBrSUsyQ1pUbm1V?=
 =?utf-8?B?U05lc1pyZzAvN0F4RlhHcmk1eWZFMjFIbmJGSGNkNVpVNjBBcFdLakN6V0l6?=
 =?utf-8?B?M2JYU1EzS2FDckovK1hnaHlZVzZFOVhGcjBmVVptMUZ6Tk5qZEYxbGFiMnZh?=
 =?utf-8?B?Y0dqYTNRbjAzczdmNld6anJVR3VjdllMeVU3amZXWFhQL0pubXNTQU9QbXF4?=
 =?utf-8?B?c25EMG1WZllyd1NHUkRKVW0rbnBYYkdaTTZ2S3l5TE5PSE5OcWRKNFRyTUgz?=
 =?utf-8?Q?Fsgn6yyFJ+xX0VEHqBOhDoXbA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f97b764-b6c4-4d76-ebc5-08db3cdad8f4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 11:24:44.6064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMem4fn5aWLXPaVyCJPZnPYAnmUOwERCmOIJ8Sb0ORqQUY1NJrykya8RX7WWnvRQwC7wMqlp3B0IK1fmGqeboQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi PSCI developers,

We have a SoC where there are 4 Cortex-R52 which is distributed in two 
clusters. So we have 2 Cortex-R52 in one cluster and 2 Cortex-R52 in 
another cluster.

We wish to enable SMP on the 2 R52 within a cluster with Xen hypervisor 
(EL2 software) running on them.

We are trying to explore if we can use PSCI for booting the secondary cores.

Refer Cortex-R52 TRM 
(https://developer.arm.com/documentation/100026/0101/?lang=en ), it 
specifies the following :-

Page 24 - Section 1.4.1

"Support for Exception levels, EL0, EL1, and EL2."

Page 30 - Section 2.1.6

"The Cortex-R52 processor does not implement TrustZone® technology. It 
does not support the ability to distinguish between secure and 
non-secure physical memories."

Thus, there is no EL3 and secure world in Cortex-R52. It implements 
AArch32-V8R architecture.


Refer PSCI design document, 
https://developer.arm.com/documentation/den0022/e/?lang=en

Page 18 -
"The PSCI specification focuses on the interface between Security states 
for power management. It provides a method for issuing power management 
requests. To deal with the requests, the PPF must include a PSCI 
implementation. A PSCI implementation might require communication 
between the PPF and a Trusted OS or SP."

Page 17 - Privileged Platform Firmware (PPF)

"For Armv7 systems, or Armv8 systems using AArch32 at EL3, PPF executes 
in EL3."

 From the above two statements, I infer that PSCI requires a PPF 
(running at EL3) and a Trusted OS (running at secure EL2). If this is 
correct, then R52  cannot support PSCI. Please correct me if I am mistaken.

I wish to know how do we wake up the secondary core if PSCI is not 
supported.

Kind regards,
Ayan



