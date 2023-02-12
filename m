Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A9E69382F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBLPqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBLPqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:46:01 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A719C169;
        Sun, 12 Feb 2023 07:45:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klnrCccxA1pQDKXGzyo7MmsGZ2nNk01FWrP724+gFGgbBVHvpJ2X5iLnTQUL0U2lwiV2D2qs48wIS6eaGL7w/MHIdXYDpxGsZmy/d22iXlorRXk1RDlmZd5ThE/DPuN6DRJDll7m4IRaw3ctADYvqG5oAKM1sVuUM4C5H356yzQdZEndiWQr75Jq1beU6dMS7ajwPaw8m+LQhnjX1GCL8V9+3uHCrKfaKhYcZg1MsZsVz5dCgyirwPNTu+yYcXA84FceHL9caGhhBb5XnksKm563460exK0QPYJX2wVqu3IuRgaTOyBXL7Q7XtbPlV8gnVEp1gr40jbvN/wIRrWsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAJT88bSPJX8sprU72mhHJwKoFBgjxhiq1rvtTVGrCY=;
 b=UkjFLC4XxH8gHfT60uPxUPIaUUz/GBTecaiBcm88Ro/ELCsHY8pCKFSSfzEX9eTFbsf3wX3dSfbQ/5UZutFeUMfMa0UZT0RCZBanoIa6mVK//Tsh75Y+ocm7YzX2DU6BPEmKT4ccJvXkhMy97a/nzg9F3xx4AKDc/ug3KP7Mh98On9BZ16HOap0noeJ60cqpCQTNVZx2qyIJkNFmyskJYnINvwZotbPVps5VjcXQbr1QXQDi9jrGRgZZUHcYp2qac0mtCmnIoHlEI49GwlUXXc7uebgXpszAEA5d0jsk46ACGKsIwZ4ugcpp6tjcPOJp8EB9NufUKmSiOUCwew1Mwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAJT88bSPJX8sprU72mhHJwKoFBgjxhiq1rvtTVGrCY=;
 b=WA8A1LxIYwXkLTz1er2/kx9rW9jNkr6bt5YwW0C8CbyGKyzppeQ7JjuLQPchU6cHPT7e2h+3ar32R8QId0w4JW8zjJBNZawv78cu+0MEhk8P9gd7FFkTrVi/VVuZ1pPdEXopChD4ew9577RdT5rmHKBnntmAjSUEX3ClflbFxGEuhjY2tqXyd3po0bH6zw9wvxLGllQt52xbOk1jXPkmfvZN76A+exSDD31CcnKXSoDXDiqjhENOXXavsfEdCZL23AlhMY/HHgr4SAsBt3cD0BfwO3JgNBCR4Y/YZ9eSRu6bzqApetpj7I7ZPwIYbqwgj7kWYtlQK/uvyyhflcXu2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by AS4PR04MB9243.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sun, 12 Feb
 2023 15:44:49 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::cb43:d6bc:dad3:3dd]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::cb43:d6bc:dad3:3dd%7]) with mapi id 15.20.6086.023; Sun, 12 Feb 2023
 15:44:49 +0000
Message-ID: <61f84da3-78ae-e2c1-62a7-a623a415915c@suse.com>
Date:   Sun, 12 Feb 2023 16:44:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ACPI: cpufreq: use a platform device to load ACPI PPC and
 PCC drivers
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, Allan Day <aday@redhat.com>,
        Michael Catanzaro <mcatanzaro.kernel@gmail.com>
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        pmladek@suse.com, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230131130041.629-1-petr.pavlu@suse.com>
 <Y+EqqRddrIZ8yWiT@bombadil.infradead.org>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Y+EqqRddrIZ8yWiT@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::20) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: f7aa739c-b025-4ef3-f4cb-08db0d1012f2
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ceISvtz2HgJTGjqywSLh4G0fEGU9IIuJoE+JUwau6O7ecJ7jEIV7NgeXP/mkMxBA6qikDnEOPGYjLZyTP0udJ0iUQCXd9qxBhRJC9Jd+a+LvvP/J/3Kmd95tvS+L69ALePEF5Up/GjxVU5lulredCHPjBIbExUSL7TMMPgsBopoY5+j/01PgOpxoNaJO6Qu7CAzniRc6J8ubGgbNgd1llXeP0RRwh1YUwKOV+HJbJXT88Uc+zHd6oqhkPa7/h4ieKql+IGrXlsjjvQr6mlt6laSFJg7rm5NIwp3q7f4ND7P1r0yDad8zPMkQ+EglXZRFkuSaYlvY+UCNys7050PS5DwaT8VRqbsqoUq9x+iP9ktCBenaVTjlSGkMuLWnsjiTp8egb1zXaZ04juJ+ieAa8hH5JifITedTOxJ05T3UkioEMQoRbDIXwTYqLF0s6zmN29QffFivPt3hSewZeOvJYLNa683uXMCFyRSFBOkK768GlM1tsXqgU0LTPzPg+CsCYPcZeyAJj+MqQuzabEVYzPva4EN55Z9RGDeD3IjX4VfkPbMWh8S+L4MK/cEj7taYLZtVRwe2esl44uhiC3S99vChxOa4TYpjta9l9614Ny+193pW7TfFkwgck5XdwGpsq81A8nAUuxr9eg23oS0ignYG6M3mHbcZJRtpXOkwSBAL150n/bQQYFeo8VKYhwH6mS9V2L0189kuiSEghfvb7j2y0FMOyZTVeehO3IzrVM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199018)(316002)(110136005)(41300700001)(38100700002)(44832011)(36756003)(2906002)(8936002)(83380400001)(5660300002)(66946007)(66556008)(66476007)(8676002)(4326008)(31696002)(6486002)(2616005)(478600001)(86362001)(26005)(6512007)(186003)(6506007)(55236004)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFlzRHRLS2ovWUV2d05sa0g5R0xEME1HRndHc29mcEwrZFQ4bGRDWXNXeU1V?=
 =?utf-8?B?dE1VdXp3MFJFcGwzV3BoMUpoMUp0MWM3Qm56b3RyZmM1ejRzSlV3MDZlSjU2?=
 =?utf-8?B?QzRSRldXWEpHZ1pDb2R1VDBxN3pFaGhhNWpDVFU5NnI0cS9pV09NbEk0U1JF?=
 =?utf-8?B?K3ppMG90bmFzRnFja3pJMjhSdkJ0ZFZ0KzBLQlRYT080NzFoTE1nOVhjQjhs?=
 =?utf-8?B?OWdrSWZsY1NVM0hHNW1oMTF3cTBFYmxZa0Q0QjkzZHRhTzhSODhvUWlNbmlp?=
 =?utf-8?B?ZEQzKy9jUmVNcXZMYlEzQTQ3bjlvZW1PRDJVVy9KUFdVY0dEMzlJRTltN0xp?=
 =?utf-8?B?YXZWYnJBNHZ2SnZKS0JXbDh1TXVianVsNHF2eHB3Y2pqTUFlS3ZPb1pGaWdq?=
 =?utf-8?B?YXlWc2pHNHF0TFZ4ZEhOY3hONksxN0lENjNJUk55Wkx2MGZCQ2MrQlhmSm1K?=
 =?utf-8?B?ZS83MmhtOW8wcDFVU1crTUREZmxzLzNFRUsxYm1qZHRrMG0ya1pZRSs3S2hW?=
 =?utf-8?B?cENzUlpMc2F1YkZ3dnk4MFcrRFBjeWlITEhhZUJnSHBVMXN1bzJTWXgyRVBS?=
 =?utf-8?B?Sjg4Z2xYelNpb3VsbERJa05NY3FyRGtIeE1rdXpoUWpKN21BYUFKbjliN3ZH?=
 =?utf-8?B?Y0ZVQVpaeWw0eHMyNzJhdE45eVE3R29IT1ZIYnRaVTZ4T3MzMHpYTklYTXpQ?=
 =?utf-8?B?Zk9jSDl2MUJSdmc2MXYwOURmV1pEcUR3dWRTdFhKVmtjUy9GZVQwd05DeGIv?=
 =?utf-8?B?ZlpTTnluUG0wbVdoWjROaDdCUGI2b2U5Z0haRm1DUUNQaHpuL2VYVTVKdXdL?=
 =?utf-8?B?akIwb3J2M0ZHMnZRTEorTW8yMWlRYTlVeTBQU2VSaHB5aFRPcTErTVhDWExv?=
 =?utf-8?B?dDhJTFlFVVB6Z1N3VnlWd0ZWTzBNNExJcXUzNnUrYitnZjhiYUI4UENDckIr?=
 =?utf-8?B?YmVGZ1BOaEFSRkFqWHVMbWc4d0dERGluMUFoSTVrd3RLYUdwWE04OXQ3SWg2?=
 =?utf-8?B?Z0c2RklTTUcvZ2Vsem52Y3IzUEh1eHVzK2NwQ28xeWp2ZDVMNkNUQWFjM0ht?=
 =?utf-8?B?MU53N28zM3lJZVZkekFLQ0g3d3U2ZW1CeS9XVHdJQzExUloybWN2SER6Q2lU?=
 =?utf-8?B?a2N1TjRhd01XbXQ4a3VIdkE5VWgxNGtVVnZKZ21Qc0lhbXJXbncrTFRvUWtS?=
 =?utf-8?B?UHpvVDF5d1E0SmFYcXBtTG5ERWJUTGMvZkxIbWozYVVwWXVPa1MrS25IeGhp?=
 =?utf-8?B?Um1HWHd3ZGxFYVF0NE1kMExoWXRLU21XWHRWcktPamtIRFRvSTV1UzI5ZmVH?=
 =?utf-8?B?clVlTnN3SG1lTmJWZHkwOGl1UWJzMXoxampmc2czN1BhRnlDc0dhUVltSzB4?=
 =?utf-8?B?S2g4aGE5TytUUVo5eGFHclczc056M2dkOU1JWU51SSt5TFpjWk9ITHdsaDYy?=
 =?utf-8?B?S1lSS0dsc2Y1LzBIV2ZnZlRhWVdZSDVBenNXWVdON3BJVFpkNVZXaHVsQkZC?=
 =?utf-8?B?QTIvTUNEclBleTBOMG94TTBCVlY2KzlUT3RVUDA0S0t0YzVxM1BDNGZQa0Rs?=
 =?utf-8?B?YmsrNzcrMSswRXJpYlNVaU42TlY3bkxyRzVGWE5KNytkbG1iQlhsa2JmQ0hn?=
 =?utf-8?B?c0UvTG0zc0RKOGJlbjVMVFNmZGQrcWJPMDlCTUJqWXErMTJoMW1FZ1Mxd3VR?=
 =?utf-8?B?K1kxM3BxeVVOcElWdTB6a2R5OGFia0JaRE1KV0lHQUFuL0UyZ0F5b3l6Z3k1?=
 =?utf-8?B?U2JEbFE1ZVNlT05KbHRSOENYN0tINE14LzNxLy9lMk05Z1Z0S3FiOWpPZk9Y?=
 =?utf-8?B?Vi95NzJGVXFWbFJxRlVBK21nclNLY2E2QlB5S2FyNCtBZW9kT0dRMEVsVExx?=
 =?utf-8?B?Y0VyQU9sc04vS0dKeUErTUIyRkwra1RtRFhwOThnRGZYN09TRTN0dlBZanlt?=
 =?utf-8?B?dHR3RWlPQTg4NWFpSmhBWS9hOUI3RXNLVWsrVkQ3Z25HUGxPa3hvUUl1eDlq?=
 =?utf-8?B?c3pWbzBFYSthb0w3S3BlcG1sQWxQU3BPTkRNMVdpYXlNS3NZQ1hqYTd5S2NU?=
 =?utf-8?B?ZGdlYytVbkc0VmJDS0REUjJudWxlUFk2aWJKRjlYOGtSUHh3c2gwREVuTmFQ?=
 =?utf-8?Q?g7y6ZtHhhlBnovZnpTYFL0jf+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7aa739c-b025-4ef3-f4cb-08db0d1012f2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 15:44:49.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAqZMi7iRhC7ehNEag6H+kipU4JNI3uur1PYB3YZMWBfvdG8R7O6QWxCdOVUo6tB4qKFmYSubMdos/CfNBfdGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/23 17:28, Luis Chamberlain wrote:
> On Tue, Jan 31, 2023 at 02:00:41PM +0100, Petr Pavlu wrote:
>> The acpi-cpufreq and pcc-cpufreq drivers are loaded through per-CPU
>> module aliases.
> 
> It gets me to question, what makes this "per-CPU module aliases" and
> how do we find other similar uses as they are likely incorrect too?

The acpi-cpufreq module aliases:
* 'cpu:type:x86,ven*fam*mod*:feature:*0016*' (X86_FEATURE_HW_PSTATE),
* 'cpu:type:x86,ven*fam*mod*:feature:*00E8*' (X86_FEATURE_ACPI),
* 'acpi*:LNXCPU:*' (ACPI_PROCESSOR_OBJECT_HID),
* 'acpi*:ACPI0007:*' (ACPI_PROCESSOR_DEVICE_HID).

The pcc-cpufreq similarly aliases:
* 'acpi*:LNXCPU:*' (ACPI_PROCESSOR_OBJECT_HID),
* 'acpi*:ACPI0007:*' (ACPI_PROCESSOR_DEVICE_HID).

These per-CPU aliases can be found as follows:
$ grep -E '(cpu:type|ACPI0007|LNXCPU)' /lib/modules/$(uname -r)/modules.alias

I think it is generally ok for modules to use per-CPU aliases. The normal case
should be that the first load succeeds and any subsequent one is then only
a trivial check by libkmod that a given module has been already inserted.

This breaks when a module repeatedly fails to load. In particular, arrangement
of x86 cpufreq and edac drivers is done in a way that they cascade several
modules and once the first one becomes a selected cpufreq/edac driver then any
further module load fails.

If a subsystem decides to use this kind of pattern then it should really limit
the number of such failed loads. The proposed patch improves the situation for
cpufreq. I've not yet looked at the edac stuff.

The second problem with per-CPU aliases is a burst of same loads created by
udevd (as also discussed on the linux-modules mailing list). The daemon
normally processes devices in parallel and as it goes through CPUs, it will
create a number of requests to load the same per-CPU module. This problem is
present even if the needed module is loaded successfully. A lot of unnecessary
CPU work and memory allocations is needed to handle each duplicate load.

My thinking is that this second problem is something that should be addressed
in udevd. The same situation can happen for other hardware devices when they
all have the same type and need same modules. Udevd could avoid attempting
a second parallel load if it recognizes that one of its workers is already
doing the same insert. I hope to have a closer look at this.

There is clearly some overlap in sense that if udevd was improved in this way
then it makes this patch less useful. However, even if this would get
implemented at some point, I think it's still good if acpi-cpufreq and
pcc-cpufreq is on a given system explicitly attempted to be loaded only once.

>> This can result in many unnecessary load requests during
>> boot if another frequency module, such as intel_pstate, is already
>> active. 
> 
> Perhaps you should mention that in the worst case, without the fix in
> commit 0254127ab977e ("module: Don't wait for GOING modules") some of
> these module load requests could fail and prevent boot, and that
> discussion over these duplicate module reqests ended up in us deciding that
> they are not needed, we just need one.

Ok, I'll add it in v2.

>> For instance, on a typical Intel system, one can observe that
>> udev makes 2x#CPUs attempts to insert acpi_cpufreq and 1x#CPUs attempts
>> for pcc_cpufreq. All these tries then fail if another frequency module
>> is already registered.
>>
>> Both acpi-cpufreq and pcc-cpufreq drivers have their platform firmware
>> interface defined by ACPI. Allowed performance states and parameters
>> must be same for each CPU. This makes it possible to model these
>> interfaces as platform devices.
>>
>> The patch extends the ACPI parsing logic to check the ACPI namespace if
>> the PPC or PCC interface is present and creates a virtual platform
>> device for each if it is available. The acpi-cpufreq and pcc-cpufreq
>> drivers are then updated to map to these devices.
>>
>> This allows to try loading acpi-cpufreq and pcc-cpufreq only once during
>> boot and only if a given interface is available in the firmware.
> 
> That could cut boot time too? If so how much?

The following command should provide an approximate measurement of what
happens during the boot:

# perf stat --null --repeat 10 --post 'sleep 5' -- \
    udevadm trigger --action=add --subsystem-match=acpi --sysname-match=LNXCPU* --subsystem-match=cpu --sysname-match=cpu* --settle

My test was with 6.2-rc7 which already contains commit 0254127ab977e ("module:
Don't wait for GOING modules"). Kernel modules were signed and compressed with
zstd. Test machines had intel_pstate loaded and so acpi-cpufreq and
pcc-cpufreq always failed to initialize.

Test machine A, with 16 CPUs + 62 GiB memory:
* vanilla:        0.20334 +- 0.00566 seconds time elapsed  ( +-  2.79% )
* with the patch: 0.08939 +- 0.00308 seconds time elapsed  ( +-  3.44% )

Test machine B, with 288 CPUs + 110 GiB memory.
* vanilla:        1.3439 +- 0.0232 seconds time elapsed  ( +-  1.72% )
* with the patch: 0.74916 +- 0.00253 seconds time elapsed  ( +-  0.34% )

Udevd processing was parallel, maximum number of its workers was in both cases
2*cpu_count+16. It means the reduced time roughly says how much less the whole
system (all CPUs) was needed to be occupied.

The smaller system A sees a reduction of ~100 ms with the patch while the
bigger one B shows an improvement of ~600 ms.

Thanks,
Petr
