Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC2D71419A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 03:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjE2BOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 21:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2BOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 21:14:35 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA9EA6;
        Sun, 28 May 2023 18:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAJVaErb8CC5JW10l937ckWgpS2e0hMtAa1al9DblQv+5Rl/66C7PeUzEl5iFdDE8Shwb+Eu4LFnE/FEki1FBL0YizqdlHTnjjDmko/uZX0wKnfoxZ7uePwJaAtb9VQaWfYLEIhDIpe9LPDN7VBzZ7cIjW4MQYMPCBRm6kFuB/PLUDSqyVaFRv85ZeYbyUQvG23HMNvQl4mW2Tt655AECdOour0euQj3Vm07y70NcdbUtzTrEmHie8HtLnPFoCZumwmq6HGJDn5rIVQirUmokVRnEIBUK536oyOBP3Z26kFvshcIjmPbL5UAggyNICwk292LE8PDE0EHlozRUS+nzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AU0XBuD8BPJRy/mJfcwPg++O1OVC68nTqEGJqvhUyfQ=;
 b=YVdqYiW041w0GSDk60O3ofdZfOkHC2496GKc3EgdZ6DiNjAq4H8cF/YQy0+grd5HpKBDLhFP/aWWie3I/rt418fQZuj+55H7WIFWPugWmc2QnW0IT9GQU8E+jsa7GfZR1o7YiEKzEZZ5vUAt6Qb+BiMhIblwiSXdrXTA6QvWGtKsLXnFBbGw3VuItZ3sJbTBjXhvpABCwsIGm1QYwIijOJcPDelK5G3f/2tAnlrXMo4JLM61nJHN4E4qRHx1NVIdf/k8/+eu0ouJ6sV4+ddbj9UeUrRwdnxacmLE/+EQngd4a7/tE4SaJU8qBPOYVfg2rsTJ+/Mqu+E9ofqnG5FVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU0XBuD8BPJRy/mJfcwPg++O1OVC68nTqEGJqvhUyfQ=;
 b=oi608u2v2l074TvEaTGtnUsmiqjzBN2g7TVwQCZGWQSfb62LTJ/SEKDbmU3JmClB6lIdET4wiIbTZtGcUnr/8sVbheffj38b1iS3ALK99W+46x03RV9XYCVLMt+Jn75YevXpT1/P6R2gXDPz/hIVHNbHoIvDM68kcChTAtbHaOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 01:14:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 01:14:31 +0000
Message-ID: <09e24386-de63-e9e9-9e7f-5d04bad62d83@amd.com>
Date:   Sun, 28 May 2023 20:14:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI string"?
 (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Content-Language: en-US
To:     Nick Hastings <nicholaschastings@gmail.com>
Cc:     Salvatore Bonaccorso <carnil@debian.org>, 1036530@bugs.debian.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <ZG3mbc3zdR4KcUW/@eldamar.lan> <ZG6cY8xjfob4Bvcs@xps>
 <ZG98fQ+MD4O0nGGE@eldamar.lan>
 <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZG/8cxxTJ9ZzrVPQ@xps> <ZHCYRmD7YeIWoy2W@eldamar.lan>
 <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZHKrC4/G6ZyvRReI@xps> <ZHL5cCNUzVdleiag@eldamar.lan>
 <ab12984e-be17-903d-ba0a-f9c85b8c544f@amd.com> <ZHP4IqxBUPuVRvRV@xps>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZHP4IqxBUPuVRvRV@xps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0064.namprd07.prod.outlook.com
 (2603:10b6:4:ad::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: e85fbd61-e12b-41d8-3dae-08db5fe20e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ZzI2Z0xTpajNeBWG17y0mgr5QsiDy0IEfLx8yUQGpp2ZB9ne4Gb0Egzb65yhy3jWs+ucR/HnTbIqFVfIxKhVFTLqwkTfzb9o37eXAdJ4dPXFmwE5h+q10O2rwCRuw+Ayln/E59fASGAevBqO2wrrwi5TRkUD5/3nda0IyVkutOkc2pBmelzm4sZRdIPc+4VD9f0OGB4H1h4lalhmJ5ozL3IjME+pgn/0c7fZKdXidhgvjZ3RUvSjl4023sYO/2c9qBXTi1PpvMITYLmmpsIhxUA52mJbvhNFfEaRFRyneVvxofFPFFv5xCawEaOruuzNVFpOqSV8GB4/WfFFYnQV2+LGRuoi44JytDSgIfpZXksvqmu+SCmemq4oDD4pl6VYWcC7wmUUdFSo0mvDR4iVH8THKRhcAKUUlGrvWtTiASJFljTDQX4Y/S8xInFyKcGniMDStkfPg7okwDKyT+ZCJ57Q01IXFLOMfkKxuRohPn1UUEv1ZjmhZE2i7y1SDke+r0fFs6HTqUNLbgikag9M+9AuTo8taNXd1y0875s/hoPS4prrTkVtt93amxFQG2DdiPQCrgKLoRGwIyLAlg5V383c4VW/JOryEvU3UML2QZSsRmqwTZaWjNAh+UkjMMymK199cEcT74p2ZZ3mrOuYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(966005)(53546011)(186003)(6506007)(6512007)(38100700002)(41300700001)(2616005)(31686004)(83380400001)(6666004)(6486002)(54906003)(478600001)(66946007)(66476007)(66556008)(4326008)(6916009)(316002)(44832011)(5660300002)(2906002)(86362001)(31696002)(8676002)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0ZrRThPUDUralFhQWdwa0sxdjV5SGZYR0MySkxjaHAwVzNMR29idzUrcFRQ?=
 =?utf-8?B?RlBNcnlkME16UE54VVlEb1lVT291S0JpZlhTWFJDcUg5bG1mMUZvMUpLSFpP?=
 =?utf-8?B?VlY5clFlUVhUbmpUSzdVVTdrZmFPVUpwcTBVaDJqemJteENyeUUvNnRqZjN0?=
 =?utf-8?B?Rmx0VVVnczdhWW1KcG14ZmJhRTZ4U3ZidUpVaTVWd25SVGQxZWFSR29pdjNl?=
 =?utf-8?B?T1JQcGFJTXppRjc5QjNyaW9qTzhVMnY4bmsrYXYvdjFueEZZZ0VhR2VSVWZQ?=
 =?utf-8?B?VVJ1NERoUTdoRVErYnVZWWtFMGFJQlI4UXRmM2J1K3hybVhRN0JaZTJmaFU1?=
 =?utf-8?B?R0VpNHhtaHpyNlVrMUlBelBDN0RJVEpLaEl0T0JYZ04zanBVT2ljT1o4RGJN?=
 =?utf-8?B?Tk54QytHR3pXNEkzMVNkcG1xMWRET1RjSC91SG96bklIS3V3clhYVjdzWEh4?=
 =?utf-8?B?ZjNuYVZDU3Q3bkcvTXl2dWFRS2trcGlaclNYdEQrYVMyaXhpSDFvblo1RFp2?=
 =?utf-8?B?QWpIVmhKeVlWNytkUXl1UXRoMml1dmhZU1IvdHFuVVZPTXdiQllYcmQvZHpD?=
 =?utf-8?B?S1QreTBmNHZLSlBjTGg2MXFlNWNoUWdLM0dodWptLzVrU0FPQWZmZ2dJazhm?=
 =?utf-8?B?M09wL2dsd2ZRWDdWRi9ucE82d2s2d1h1SjkzTVdndyt5M1RSOE5uK1pDeTFE?=
 =?utf-8?B?WUtpT3pjVUhBc2J1TjNVZXRZYnBhYjU0ZTcyc1YyaTA4MklSV2RhMWl0SlJi?=
 =?utf-8?B?UHlRT3Q2dlpCMFBXemNMejZlQUc1ekNmSWtTcTM3dkM5b3BudnMzeHp3MUJj?=
 =?utf-8?B?MUVuYzZ6VVhJdUJXeUIyNEl2ckNnSzJIVXFmMmdta1JyeGV0YTBOZVhIVGxw?=
 =?utf-8?B?VVNZMXUvVFVDakFFVkpGcXJTM3g5Y1ZLZFZGZzZHYnIrU3dDZFZHWkFKUldo?=
 =?utf-8?B?Zm1Gc3pjUnBYWWthT2JFdFd3TFU0aGl3aHphMlBwUGxySVRmMHRyT01uSDdw?=
 =?utf-8?B?WS90QldWSXhLOTBmdmlkT3luYWNiaU5pL3dVY0tVRytxQ3c0eEF4QUFyNzNo?=
 =?utf-8?B?VzBYWGl5aXVxTmRqdmN0MjdTa0FQYVE2TUcrQlgzcE8yV1poRFMvYUxHWjcv?=
 =?utf-8?B?NUF5bCt1ZWJZc3VJZWNsMnZiZmhidmtNNEQ4a0drWHU5K2N0Vy9KQ0RNNGR4?=
 =?utf-8?B?TkpsMnNqczJscUhUcVFPUml3K3hEWnQ3cGtzejJEMUFveWIwVm9OSm1yM1Zo?=
 =?utf-8?B?cE5Ta1FFWFlyUEc2MllwM00zWkRlLzRZeGR2L1N0emxmR0JIcjJvb0RnVExv?=
 =?utf-8?B?RjBwZ0gvbHRKcFUvbkRxZ3JsOGcrTjhEalQrRUxLZDBhdGZqNGUwS0o0T1dG?=
 =?utf-8?B?aXArU2w3M01PcFRYQUdGVFNjcFcyRmxiVE9SU3MzWEVLakljRC8vdEl6SlBJ?=
 =?utf-8?B?NEtFZVAxaUxtczJsSk9pbmM0MEdjcDUydVVZVzduc3JpaThhdzFZU2xMWDcw?=
 =?utf-8?B?dS9FU0MwN2RaZkYyZVRITFRUQmlVR3dKK0NqK2VsTDdncUJGQVN4dDlsaXVk?=
 =?utf-8?B?SHZlaVdnZDJGQklxbG82eXhxUlNyQ01qWHI0NXd4YzhpSHp5MWREdDhTd0Ew?=
 =?utf-8?B?K3hwSnNvNE5aRDNXNDRaVWZaWXREZThZTUxha0kyc1VENE9hMmJIZlNXSWFR?=
 =?utf-8?B?WXF3WUlhL1Y0cTZEWTBOampIZ1dxbjVwWC9xY1B0a0c4K2lXSTlZclQ5SEFi?=
 =?utf-8?B?aDBTR1JZQnJhN1lIbVdWdk1VNkhidmFLRGdpY1g4dFJidlNQNW9aSTJUOWlw?=
 =?utf-8?B?elVOVUNhdWRVd1YvODR1dXBZbEk0US8yMlRuODZHR3JBZ3hLZkoyUU82b1hM?=
 =?utf-8?B?dEZVVGJyZmIrUlNlSjZQbitiS0oyRVlyeitaeFBQR0hQSEVJQmErZCtTZVFm?=
 =?utf-8?B?enRsNW81ajk0UE5aRDZ4Y3BER2xla3J1TEhlaUwvSVdhTWRDdHBvM3grVDB0?=
 =?utf-8?B?bW05NERXbzEwbThwVnhqN3Y5cGh0aVRrdUFUajErRmtuK09zMXZrVmU1cHJp?=
 =?utf-8?B?dWo4eEdMRUMzYVlMZjFzMUJUN3pPOUhNeWorb0FEVkVuanVaRDBZOGxMTDI2?=
 =?utf-8?B?SFB6eXoxVXFqTVJ4T1ZqMUgwMzZ5Y2JTK3JEZC9ocE95SzU2WEE5RXQwSUll?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85fbd61-e12b-41d8-3dae-08db5fe20e3a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 01:14:31.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWKLG4hgZJRrHVwWPO6JbFL3TrnHnm9DNSnf3d/24CLYpr1vipxxjsDy8Mus4vbW+ro8Sf729mRsTDcQsRtMgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/23 19:56, Nick Hastings wrote:
> Hi,
> 
> * Mario Limonciello <mario.limonciello@amd.com> [230528 21:44]:
>> On 5/28/23 01:49, Salvatore Bonaccorso wrote:
>>> Hi Mario
>>>
>>> Nick Hastings reported in Debian in https://bugs.debian.org/1036530
>>> lockups from his system after updating from a 6.0 based version to
>>> 6.1.y. >
>>> #regzbot ^introduced 24867516f06d
>>>
>>> he bisected the issue and tracked it down to:
>>>
>>> On Sun, May 28, 2023 at 10:14:51AM +0900, Nick Hastings wrote:
>>>> Control: tags -1 - moreinfo
>>>>
>>>> Hi,
>>>>
>>>> I repeated the git bisect, and the bad commit seems to be:
>>>>
>>>> (git)-[v6.1-rc1~206^2~4^5~3|bisect] % git bisect bad
>>>> 24867516f06dabedef3be7eea0ef0846b91538bc is the first bad commit
>>>> commit 24867516f06dabedef3be7eea0ef0846b91538bc
>>>> Author: Mario Limonciello <mario.limonciello@amd.com>
>>>> Date:   Tue Aug 23 13:51:31 2022 -0500
>>>>
>>>>       ACPI: OSI: Remove Linux-Dell-Video _OSI string
>>>>       This string was introduced because drivers for NVIDIA hardware
>>>>       had bugs supporting RTD3 in the past.
>>>>       Before proprietary NVIDIA driver started to support RTD3, Ubuntu had
>>>>       had a mechanism for switching PRIME on and off, though it had required
>>>>       to logout/login to make the library switch happen.
>>>>       When the PRIME had been off, the mechanism had unloaded the NVIDIA
>>>>       driver and put the device into D3cold, but the GPU had never come back
>>>>       to D0 again which is why ODMs used the _OSI to expose an old _DSM
>>>>       method to switch the power on/off.
>>>>       That has been fixed by commit 5775b843a619 ("PCI: Restore config space
>>>>       on runtime resume despite being unbound"). so vendors shouldn't be
>>>>       using this string to modify ASL any more.
>>>>       Reviewed-by: Lyude Paul <lyude@redhat.com>
>>>>       Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>       Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>>    drivers/acpi/osi.c | 9 ---------
>>>>    1 file changed, 9 deletions(-)
>>>>
>>>> This machine is a Dell with an nvidia chip so it looks like this really
>>>> could be the commit that that is causing the problems. The description
>>>> of the commit also seems (to my untrained eye) to be consistent with the
>>>> error reported on the console when the lockup occurs:
>>>>
>>>> [   58.729863] ACPI Error: Aborting method \_SB.PCI0.PGON due to previous error (AE_AML_LOOP_TIMEOUT) (20220331/psparse-529)
>>>> [   58.729904] ACPI Error: Aborting method \_SB.PCI0.PEG0.PG00._ON due to previous error (AE_AML_LOOP_TIMEOUT) (20220331/psparse-529)
>>>> [   60.083261] vfio-pci 0000:01:00.0 Unable to change power state from D3cold to D0, device inaccessible
>>>>
>>>> Hopefully this is enough information for experts to resolve this.
>>>
>>> Does this ring some bell for you? Do you need any further information
>>> from Nick?
>>>
>>> Regards,
>>> Salvatore
>>
> 
>> Have Nick try using "pcie_port_pm=off" and see if it helps the issue.
> 
> I booted into a 6.1 kernel with this option. It has been running without
> problems for 1.5 hours. Usually I would expect the lockup to have
> occurred by now.
> 
>> Does this happen in the latest 6.4 RC as well?
> 
> I have compiled that kernel and will boot into it after running this one
> with the pcie_port_pm=off for another hour or so.
> 
>> I think we need to see a full dmesg and acpidump to better
>> characterize it.
> 
> Please find attached. Let me know if there is anything else I can provide.
> 
> Regards,
> 
> Nick.

I don't see nouveau loading, are you explicitly preventing it from 
loading?  Can I see the journal from a boot when it reproduced?
