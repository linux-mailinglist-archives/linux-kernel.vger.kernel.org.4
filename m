Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47117636434
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbiKWPng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbiKWPn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:43:27 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89485CE18
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:43:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBwoUdfV+POxFoQCN0QZY5R536DaoY1PKrrW9NX96KFwFI95KeHBdAk6HC5cdGxhMjOLUjaYi+xCpYcAUQtenj9CxSOIDuzV72CCPmBA1rYheskPo7mdWDHWokTNaBhZux3IYzp9DljeCpukjg+Vx0FsHMWLNwrLIyoPXohlcg0VhLAoiSz8Ycia+jB2eNIq4CC4Q4xwCy8WaTsdrit96PTDuUx9jrZR4f3vXVe/fOUSCFM1XhEVgpw2jTql+u5byqv6gSIsNLdcpp7MJGQJE9/wP6ZDt55QakBtvtP5Jt4DYd+MNfLPB7Q8xsvgd/9KhBbKH+4I3kCRjMPoWQdlyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBzJAXzirXBgyW+wonn6TfS7mrnUxbJpzdieOW5Q654=;
 b=cbji0CflAauKKwfWUvOozYOahMq1V+Iu3DOXrjLq2P9FaC4tIZUlW3+hSoQ7GQpMdbn/RQrOHnj4DWNyYlb21FIenyorgnUdvpMhugQPfj/BiCgpu3/R/mHPEucclFrmgxNeOCYB7Jh3p65rL2HU/fJ0Gy+W5fIKa3g9Ra2of2W9p28cFm6G2UTgW1vY0XDyXvhx+ZgBbhJgP/6RGMqdV6oE6pPbAf0eEA6Ck1QZBZcwIRI09Av/d9wdzsJ2Z6uc4xFKVx5elQQcwOM5dz6nt3bT5skrKPZNNwIYIQMeEde8ziZxWsurkXyUaAlIZNL3annaVhdOwLo4heHz2AqfEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBzJAXzirXBgyW+wonn6TfS7mrnUxbJpzdieOW5Q654=;
 b=wwJ482/KQQzek2v0PbN7alMkqZxx/QWBOkjJDk5oLXA5cqH1KcG1iHQywNZyjzwLoVKcByRTr8kL7E8q+Iy2bl6eICnqsPNAMeAXLEJ7W20t2mF8vvkVEL42WxubmWPcsP1ij9iqRWLrUlB8Akyyq4QZSNHFP9rcDVhRzteO76kpGCbewpuzoRgZfAvSyGO5yI0k5lQLsszl1b8A25N4JL0JelbRwi6VM35dbJJI4gOqb0EsREWHjDXa1edWGy+KF3pIwGhf7h6BS93ksSHg9/rzNp/ziG86n6MV8TUZtc16uCcS3OKBX2AN6jJorMnfX6xRTMHhOtDy0Grznhqwbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by PAXPR04MB9325.eurprd04.prod.outlook.com
 (2603:10a6:102:2b9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 15:43:23 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f%7]) with mapi id 15.20.5834.011; Wed, 23 Nov 2022
 15:43:23 +0000
Message-ID: <1af5ee66-5ab1-45b2-f229-182f89dc6b94@suse.com>
Date:   Wed, 23 Nov 2022 16:43:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] x86: Avoid relocation information in final vmlinux
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, nicolas@fjasle.eu,
        masahiroy@kernel.org, kirill.shutemov@linux.intel.com,
        tony.luck@intel.com, michael.roth@amd.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org
References: <20220927084632.14531-1-petr.pavlu@suse.com>
 <Y34SXeU6JEk+UGfV@zn.tnic>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Y34SXeU6JEk+UGfV@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|PAXPR04MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f76c29b-d6ae-447f-e437-08dacd6973fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqCIvH/HopJHzLYF+BUPbA9Sbg+bJgr7BNelyfY/FNOJJajcKE5MfjyXHu940dj8tCoEyaXBDwLwbOzQVc5F17jHZYvru1zG8KHIDM2Zd1pHTMBETwD1PjsujYTj1wM+P3+O9rvRBBplAg2XQf2VSsHIyMbliENxMnwZWQRH79TFsPgVGf60zwTo8zF0dFduf0eLfJuLD2InFwK5X+ZxJL6t5QmzXE5utHdfIuM3yv8+cpYCe1triVQLmshyrTe3yGmaJKnnSKvyPcBrqnXm1helQAdQOn7EzzUIaRiG4ca4OnWCo6egQkqlCzF7dkVuQ3JZsRlLfIb1fwn+pU6yvgBmWMTxd6vfb/p6u/AkxjyCEp22qmzhM7GffnqksS8+h8UWL0RVOw5w8HOU/TkAJzLjGqDC+ZtvmRUj6E09HebJy8fjSu7a4LoEWKK6foU4TFfL5wPrrHo/hTSG80KF+cABYmJKxrpgEzB61AWBthwSog8aPSrbqLX04PRcX7CclIGCRY3XnfMhcpwcwnABnBkVeI+wi1aV0S+U6BWOlQmb6u4Lz0/sRQlLgWkMTTx5ZO+DYrdFQWnQdqgpusXk5h1rBIMflm1ebD/X5cBqEaVXxxn557NGrhzYXCZDQBfONMBXUcnrwEFxtiaMrQa220sGvlRxuXTSOa3RvvO4IgjqR/7j9bIF0PTfxxA9K7t0LAyQSuXsdoV1K8OYZLaY05xFejc+DoMah0spJjPZ16U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(36756003)(31686004)(6512007)(31696002)(86362001)(38100700002)(2906002)(83380400001)(186003)(26005)(2616005)(44832011)(7416002)(53546011)(55236004)(6506007)(478600001)(66476007)(41300700001)(5660300002)(8936002)(6916009)(316002)(6486002)(4326008)(66556008)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGIxd3E4QTNLTER4TDFIWHR2UDNLTzZzQjJSell5eStYUlJHZGFIYU16MmVX?=
 =?utf-8?B?S1ZkODgrMmpZdktnMHc0K2J2WVZ3OXZhQ2haeHhxQ1Nhd09wbjArNzNRUmQw?=
 =?utf-8?B?dWhMYnZZSTZlSHpqKzZUcjZ0cjJibmxRelZ4TEUyU2V2eG1rdDNjSjlBRFc5?=
 =?utf-8?B?V0o2RGptdElrdW50aWEvYkhFbFllbDlZaC9tcVUvY0ZDaTFlVHk5aVBsM1hM?=
 =?utf-8?B?YVpXKzI3V0N6N0wzOFV5ditLTXZFT3V3cDZiUnI1OTZtbTdKUzZmM1A3akUy?=
 =?utf-8?B?azNHV3V1YUlQQ251QUlPd1UzbWFPWUhsQWxFRlYrYXJQajlCUHRmSXhXK1l2?=
 =?utf-8?B?a3RWa2VWb1ErblBYRUk5Wmg4NVNINXdla1ZFcE42NlYxb1BSZzdhOTArdEVr?=
 =?utf-8?B?SlJwb1R4YWNWUzN1dUtiWFBSYSt0TXdCbzVmYTN0L0srUXFpM3FnbjBnRDhP?=
 =?utf-8?B?azlYSmorVGV3Tm5uWXl5cjY1WkxxdERKeDdBcjBRYUU0UXh0b0Yzem81eTJD?=
 =?utf-8?B?dllja0k3dTlBMUludDhTNkEyVVYwSW8yMXViVDk0Y3lob3d0S2NabFFIUGxl?=
 =?utf-8?B?MlNnRUQ0V1B3UG8wMUVCdXBuZzV1YnpPcjYwNFMvaTZ4ekJodThHdDg0QUY0?=
 =?utf-8?B?aFZWTEt0U3NHWmxOcnV5MEgyMGJpMWRzc0tjL1pGbFo3d01FVVFKc3BlZXVj?=
 =?utf-8?B?L0NoTi9Va1k0UGRyLy8yYTF3ckxYWHlJLzM2WGJEZUx2UVg4d0c3azJlcTBk?=
 =?utf-8?B?dUt2QkVTQVZuaklQMURxRVA0SVd5aEw0RnNCVTVGNGVxUTFjclB2KzJJdjdV?=
 =?utf-8?B?VTBIQWp4QWphaEdSMjVvZlp0RmRXM1VmT0JPdGNzZFlkVFVjd0NPcUhHTi84?=
 =?utf-8?B?ZUJHVHBUeml6a3JDTStiOC91RHVoUlVham91OGcvc2tXSHlaUWd6WCt4ZW5z?=
 =?utf-8?B?Nlp0R2J4a1NTRWx1NExEVGJ0dXQ2djAvcW5BUDlscmJwTDgwMzh0VFlmRUhC?=
 =?utf-8?B?UjVzbGJLQUM3V0dEVGZyYkNhT0ZESHRtdHVpOWNOZ0lIZkpudVhXQTFoZVBK?=
 =?utf-8?B?cTFjU1gxVjBBYjkrSHphMVJSdkJBZHd6M0ZMUWNwZXBWdmhFVjNwV045RUNt?=
 =?utf-8?B?dzRDK0p6TVNrY215UFVrOXRIekdhbGh3NmhGK1JVVktzYmx1TU03ejlNQk1H?=
 =?utf-8?B?TmlrelZSbE9GcTcvS1o2RU9DV3FyZS8vSWR0eGRmMlh6V3NNZzRQNnlyNTha?=
 =?utf-8?B?U0h0Yi9CYTJkUGhyb3JHOWZENkUrOVo4L0kvRmR0R3cvdWh2VlRqWldpaSt1?=
 =?utf-8?B?STZlV3FMYlU2cCtJZWcwcGlNVjVYa20wTW5oc0E1Mk1qdHpjN1JSYU9WL05R?=
 =?utf-8?B?UEozYllScmVIR3htL2hNcTRGMXYzWFBnS1h3T205RnJVQ1E1czBYd3VsdFZF?=
 =?utf-8?B?akptRFJ4Mi9GNjZkNWh3MzQ5NE1kLzY5VzhmRmZjYlB2d3NkcHJQcXYvZFJQ?=
 =?utf-8?B?cVpSMFVRSTdlZlk3Q08yWC9Ea3c2OGNGUmkvZFkxSll4cEdUTHlVcVVYa1Fz?=
 =?utf-8?B?ZHVzWnRwc0VrTE8zVkJlMjlqOTNMYlFZcWxBektPb0VnVGZ0Ny82SlFVd1Fj?=
 =?utf-8?B?SlE1N1BKWDQzOU5sWFlOdnhjcVV4UFBSQkNHNEF5Tk9KeFVLT0NSMGRORFJp?=
 =?utf-8?B?Q1ZRSEM0bUxsYzB5K2pNbXpLTXYwSlBLVmdUeldNWXp1QVJDcXAwUUJRczcy?=
 =?utf-8?B?U05HUnBVeW1EbUJqQUg1bXdyQVZiSFFiUW9UOXhUUGExU24yTUtyUDk1MG5E?=
 =?utf-8?B?d2ZxTXEyV3ZiL0J4NXNRb2g4NldDOGQwR2NudnJQdElqM1FBcURHQ2F1dUZQ?=
 =?utf-8?B?bTNHbnluSWlVQnlyeFZIaElVZFp3UC9mZG5hQi9YTkRGRXgzSUwvbldsQ1Ew?=
 =?utf-8?B?dXl3RTEzeVJwbVBlZUMvRWpqWk5uMFRxSTVDeHk1UEExb1ptTFVnYmNpc1pj?=
 =?utf-8?B?RkE3YzFsaU5SZDgzSXR3U1RhNDc0bXRJN3MzSnJsMTlZQngxUTdPSDJ6UWtV?=
 =?utf-8?B?dHFOZXhIZWtKczBvVVFSb3ZVWGpBT0ticXpMV2xFUndUVENybkZDWHd3WWdj?=
 =?utf-8?Q?Ns/KdoYfDAxzWvImtcT4RSdjU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f76c29b-d6ae-447f-e437-08dacd6973fc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:43:22.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fE2FOIvQEtKUTvaIG+yUV7Tdn+iyFqJemULCaxj0IYSXEMuad9WEHfKDYXcIKewDy01TBpkFKobVeNsJ0BEImQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9325
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 13:30, Borislav Petkov wrote:
> On Tue, Sep 27, 2022 at 10:46:32AM +0200, Petr Pavlu wrote:
>> When building a kernel supporting KASLR with CONFIG_X86_NEED_RELOCS,
>> vmlinux contains also relocation information produced by using the
>> --emit-relocs linker option. This is utilized by subsequent build steps
>> to create vmlinux.relocs and produce a relocatable image. However, the
>> information is not needed by debuggers and other standard ELF tooling.
> 
> Hm, my ld manpage says:
> 
>        -q
>        --emit-relocs
>            Leave relocation sections and contents in fully linked executables.  Post
> 	   									^^^^
>            link analysis and optimization tools may need this information in order to
> 	   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>            perform correct modifications of executables.  This results in larger
>            executables.
> 
> So what's up?

The only post-link analysis tool in this case should be arch/x86/tools/relocs.
It produces a vmlinux.relocs file which is appended to vmlinux.bin. This is
all internal to the Linux build. I'm not aware of any external tooling, such
as kernel debuggers, that would require this relocation information in
vmlinux.

>> The issue is then that the collected vmlinux file and hence distribution
>> packages end up unnecessarily large because of this extra data. The
>> following is a size comparison of vmlinux v6.0-rc5 with and without the
>> relocation information:
>> | Configuration      | With relocs | Stripped relocs |
>> | x86_64_defconfig   |       70 MB |           43 MB |
>> | +CONFIG_DEBUG_INFO |      818 MB |          367 MB |
> 
> Hmm, I see a different story with my tailored config here:
> 
>    text    data     bss     dec     hex filename
> 17131605        128673450       37339140        183144195       aea8f03 vmlinux.before
> 17132217        128677706       37363716        183173639       aeb0207 vmlinux.after
> 
> 361M vmlinux.before
> 361M vmlinux.after
> 
> and
> 
> 738K vmlinux.relocs
> 
> and before and after .configs simply have RANDOMIZE_BASE =n and =y,
> respectively.
> 
> So how do you see such a big diff, even with defconfig?

The size command used in your example includes only allocatable code, data and
bss sections. It does not show size of any relocation sections.

My measurement was simply with 'ls -lh'. One can compare output of 'readelf
--sections' from the before and after binaries to see what sections are
removed with the patch and what is their size.

The following sections are dropped for defconfig on v6.1-rc6:

Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 2] .rela.text        RELA             0000000000000000  02adf908
       00000000009457f8  0000000000000018   I      60     1     8
  [ 4] .rela.rodata      RELA             0000000000000000  03425100
       00000000001781d0  0000000000000018   I      60     3     8
  [ 6] .rela.pci_fixup   RELA             0000000000000000  0359d2d0
       0000000000005028  0000000000000018   I      60     5     8
  [ 8] .rela.tracedata   RELA             0000000000000000  035a22f8
       0000000000000120  0000000000000018   I      60     7     8
  [10] .rela__ksymtab    RELA             0000000000000000  035a2418
       000000000006fff0  0000000000000018   I      60     9     8
  [12] .rela__ksymt[...] RELA             0000000000000000  03612408
       00000000000609a8  0000000000000018   I      60    11     8
  [15] .rela__param      RELA             0000000000000000  03672db0
       0000000000009150  0000000000000018   I      60    14     8
  [17] .rela__modver     RELA             0000000000000000  0367bf00
       0000000000000540  0000000000000018   I      60    16     8
  [19] .rela__ex_table   RELA             0000000000000000  0367c440
       000000000000dec0  0000000000000018   I      60    18     8
  [22] .rela.data        RELA             0000000000000000  0368a300
       000000000011e5a8  0000000000000018   I      60    21     8
  [24] .rela__bug_table  RELA             0000000000000000  037a88a8
       0000000000073b30  0000000000000018   I      60    23     8
  [26] .rela.orc_un[...] RELA             0000000000000000  0381c3d8
       0000000000aea9e0  0000000000000018   I      60    25     8
  [31] .rela.data..[...] RELA             0000000000000000  04306db8
       0000000000000180  0000000000000018   I      60    30     8
  [33] .rela.init.text   RELA             0000000000000000  04306f38
       000000000009f8a0  0000000000000018   I      60    32     8
  [35] .rela.altins[...] RELA             0000000000000000  043a67d8
       0000000000009dc8  0000000000000018   I      60    34     8
  [37] .rela.init.data   RELA             0000000000000000  043b05a0
       000000000002ec50  0000000000000018   I      60    36     8
  [39] .rela.x86_cp[...] RELA             0000000000000000  043df1f0
       0000000000000078  0000000000000018   I      60    38     8
  [41] .rela.parain[...] RELA             0000000000000000  043df268
       00000000000015f0  0000000000000018   I      60    40     8
  [43] .rela.retpol[...] RELA             0000000000000000  043e0858
       000000000005c700  0000000000000018   I      60    42     8
  [45] .rela.return[...] RELA             0000000000000000  0443cf58
       0000000000170fe8  0000000000000018   I      60    44     8
  [47] .rela.altins[...] RELA             0000000000000000  045adf40
       000000000001b0f0  0000000000000018   I      60    46     8
  [49] .rela.altins[...] RELA             0000000000000000  045c9030
       0000000000004d28  0000000000000018   I      60    48     8
  [51] .rela.apicdrivers RELA             0000000000000000  045cdd58
       0000000000000030  0000000000000018   I      60    50     8
  [53] .rela.exit.text   RELA             0000000000000000  045cdd88
       0000000000006870  0000000000000018   I      60    52     8
  [55] .rela.smp_locks   RELA             0000000000000000  045d45f8
       00000000000420c0  0000000000000018   I      60    54     8

Total size of these sections is 27.2 MB.

>> The patch optimizes a resulting vmlinux by adding a postlink step that
> 
> Avoid having "This/The patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.

Noted.

Thanks,
Petr
