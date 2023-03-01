Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4D76A67F1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCAHGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCAHF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:05:58 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11783771A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 23:05:56 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32154Qna021732;
        Tue, 28 Feb 2023 23:05:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=yjI0qsSOu4v077IEjXBSjEKogcxbXz9YPyQvDkl1d04=;
 b=GjfKs1aFYUn7eIZcWL6FLdMRMwzrMyc+Y9ifGTxF3LjodN+07jfs2G6sT0uxynN1Gbv3
 4o7pAf+KM1JQg9O892xo9ajKbQNsWcDdDsv0NPlkHLop8HzZpnz+R8DOmGNpolGuLqfQ
 ifPEw+831cY+pB0ufJ4T6OovgK4nHliJuIe/fWbvr0E3leV5xdxEL+0DdILgksHuWLQA
 5QLKTAfs68H97Xp97VBtsEhbmQa0GiiTsrsfHqZiBVXF4dFCwwpXy5WNOkg7PcHAYr3O
 Oqd6noNCX6m8461L2KBBKwOmZWFj7u2oefRNRVKcubMpRPiuLUkUtrPN4PbRxK96Mc7e mw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by m0089730.ppops.net (PPS) with ESMTPS id 3p19d5rndy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 23:05:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lt4+lM0lCiRzBVbMedegfHltzQED0saqpd6z03kpQ+owNCmQwnZkNW7lRxDs+xFNm9lDwxxV+wG1uzWV1NDhdheZ6UBGkF7uytQymECW8VJ2VUwMKOj+/IbNtx1FImfdomb+dKEgly2uNEKrrD8z6xkUtdMpBmKeCbbojFN5RPryHBNs6Lx4mN4bSG6iPN7SJ5n9y04vYqiz2B5FGJhb2p9BdwBGqsxAD91sTdRNM8jPrrWb98HKgcY/R87OC4B5dzStmtrEveq/Eg+nneLIvDvKZ7xloo6Wb6PLfW5W8ZycQ52v4PbrHA/lmt8tLUUm/yQr7s8iqUXnus1AQP7low==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGjqCeVA5v4XCheuQ+sIuWvxnP/zvgVooBgT0rs38Jc=;
 b=DNcm0yRpOiRQDLs9Ug8isMh++dHmKy9bdv5Hs7DUtdR5kC0FBBiecW6v7AxguA3vTVe0it4iaj8S2Boq9LpuJpdUGbs5A+t8EEBSlL2acA269Y0c5Xs533R7edRjuAaekmkLn0plb4801vzsS4yPjAKw/gJuX34lj010GuUsikT8VUOxnDOxtbYHFT051iEQdXSTARmkQu68h0whKEIcsY8h4NIRG16/aMQ5yyRwW7C0AlvFs4GBeW+ah61GHwZKARZVg75nEmPpO9927Go82ksKh+WqP6moNIV67+w0zt86NvdiJ8n8q496+5aDKrNG/Cph+4qwbW0hE3um89pX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM4PR15MB5568.namprd15.prod.outlook.com (2603:10b6:8:10b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 07:05:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 07:05:45 +0000
Message-ID: <1f63f410-6bfc-7b59-7a7d-8fca323ada53@meta.com>
Date:   Tue, 28 Feb 2023 23:05:41 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko]
 undefined!
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Yonghong Song <yhs@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
References: <202303010701.KWYce0Mt-lkp@intel.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <202303010701.KWYce0Mt-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM4PR15MB5568:EE_
X-MS-Office365-Filtering-Correlation-Id: 543dba8c-7e99-45b7-07fd-08db1a2360dc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7Iwbuw311UMRkNPfCKPzPzK0XrANc8am3Lo4CqGmdWlAvzjbGOC28ftLinOK8iQadpzOS88xkdqca6rWp/Nv46oFskToizqsQmIzNh2on4DsgJyZV7KbWzTu+mXhbNi1OdpBFFvIDVjy4rFz8L8D/fAZiJyMdQToXjFrWG9oKTv1y03PhZtlkV0pqywZcQKjHRSD3LgLCLCk8Xy4iYq3B7rD7LX7SJYzG4GjWVMROGJljG/ig0Xzq2PM7BeZdQne6KtqmVj14lI1HtwQZ5bcmWBASfEfx/yceiQo7V4LhnTZ2drOEl7lMgvhIUYFd/4ONSeFeVFhhY2zvTepydpa43QOmAvqo7NUIEEXN6PzAhLgpelkyr7ynyXf6zWJedyEBmoJg5DhIalFvJeP5Cs4MQ/xl13E1HwviKUqe5bNP2IxcnWbkzpa/9Dfsmfm6Bb3Y4YpO3abidr+stnrhHFvlHUVxQVIYF4K3t9qRtlmdzC3ee82dWoGPZCd8c+AK2sPODJEeih5oTwm/T4U/ey8GzFxWGPfbV/vTp4+pWIud7XDpPu4yrmfe+llkyOxKFUQyP4o4YSUh4gKMuPHU0mKqQreRXnYGa+kc0CFeo0pWMUS7ecv6ndl2W8/bcrqpVcPXbE1/P9VdJ9FI7ML/ujmSUM07OGSFJMjxaNDEOrsUZBMsATx388MfC+qY34d1G5zMqgckFnadIpyemrtzjrErey4zjPCVuHTvnfuiJub5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199018)(31686004)(8936002)(5660300002)(31696002)(186003)(8676002)(66946007)(41300700001)(66556008)(66476007)(4326008)(86362001)(316002)(36756003)(83380400001)(2906002)(966005)(6486002)(110136005)(478600001)(6512007)(6666004)(53546011)(6506007)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW5jYmdkMUZmaVJQRHpScnNteVhjVVNHNWF1Tzg4Y3JEaTFOamJoa0ExTjhD?=
 =?utf-8?B?WHArU1BYcmpMalhMY3lOTm5TMlh6d3QvdXZjem0zdzJIWFdoVGw3ZE1OZFNh?=
 =?utf-8?B?Y3NCK2ZVbkVKd1JaZEVjZU1haE1haTIwcUZvaUtWZnB4a1lFQ1hhZmdkUTVP?=
 =?utf-8?B?a3owYnVicHZWT1VqRkozRGdMU1FzakN0dVFhM1FORndERSt6Q1ZaMW0rRStM?=
 =?utf-8?B?QXFwalRtV2c0a3U0WFZIMDFsU1gyWDN1OGtjZDFSMERMNklrQXR4S1hZVDRa?=
 =?utf-8?B?S1hWNFZLa1V1VnFRWEU2ZTlkL2RvdTJqYlYzSjYyRmhJdGFMU0NCaC96Q1V6?=
 =?utf-8?B?cDViaGQwR2VrM1BRQTZiUjl1VWI5emR1ZnB3T0ZydGhlS0NpaEtUWkp5SmJR?=
 =?utf-8?B?YTdoeGdEVE5aOTdab0xISVhVZlNHNm80ZE9wQnVUV0tudWZCbWprM2w2cnNR?=
 =?utf-8?B?bm1Ca0dERDVhYlJ4S2Y5ZFRXN0pDMFp4MnJWMGJXVmlSMXZLUWJLOHBxeE4y?=
 =?utf-8?B?UHF1WmlqYW5jN0tibzNqc2YrQzRwbExUdDlKYmlsN2VmTmx6S3M3dVRDemgr?=
 =?utf-8?B?VmlIUXBIMGg2RUhtR2U3S0NubWNjR2NMbHdraHZPWUdEUDJCS3FvOHRUSk5l?=
 =?utf-8?B?azNRVjR6TGxyandJbjI1SU1lcDQ5bjFyQ1B6UCtIbjFVTlRUTFUwSERkbEUz?=
 =?utf-8?B?SHprb0wyT28yRm5vYW1ycU5MTW1vRmE1SEg0b0lrU3FBSVRJTjBOVXFEVE5w?=
 =?utf-8?B?QnN4aWg0N0VBRzVLemY1UVQrRGhabGVzcVlFL0NvOFZtSFllK2d3a2w0UERS?=
 =?utf-8?B?SnFpTEVvRm03cE1YRVhUbWVzRjlSMEZxUWRnYk51aUdMWThFLy9ncEVjb3Ev?=
 =?utf-8?B?all4MTQwSkcvV0oyMkE4ZDFPMFVsZUNzN21YU2IyTTMrZWViZE01VTk0eW5C?=
 =?utf-8?B?R1NlZmkvQ09IQ2ozNkYzRHlLWVNiUmljNHM2MlFjd1dFVzBuRWVPSlJIM1Zj?=
 =?utf-8?B?NHp3NE9OT3NISzVUYXVIdTJjclo1TEsyRkE2NjZWK3VHNDBEL0Y2QmQvNW9U?=
 =?utf-8?B?Kys2b2ZtNjdSSGFEZmh0QU1WUUVJS2ZyeEVlZVV6SkFiVzc3UHE0QlFiSjBz?=
 =?utf-8?B?VHZoWDBIblRCcVd5UzVHaXVQTy9QdHg1Q001UTZEVlJOOC9uc3RueHBYTGRv?=
 =?utf-8?B?bFJUS1NOUWc1TFVyQk1GVExiaHc0MDZaTTZLakVOOEd2bWFKU2tKcTdnZWtl?=
 =?utf-8?B?QUl4UFBuV0VtbWMrTVBqK1RvZTBESFlNLzFDcXNWSllUWkhBUUR5VExoN0hK?=
 =?utf-8?B?eWdwbnY1TXBmZUU5MllqazNZQXJjdi9wNVpyd1VmSGxYNlppRTcrR2ROMDdj?=
 =?utf-8?B?cFVUSXZ0cDhjRC9acE5XeVNTeUpWajh6ajJlRmg4VVhVazlDWTM5aTJNOXhm?=
 =?utf-8?B?OTlZNUdyUkVnRmYreTJnakhvdURJS3JnZlNlV1pYMG1LejVwWnVqekZSN2cy?=
 =?utf-8?B?SmF2RHZ2S09OTEhvTEpaMDdnU29JN2NGcCt6Tk96Z1pwbDFPaHpEZ0FNdlFz?=
 =?utf-8?B?WmRnMm1ldDBLbFBXMGpwNVJNZ0dYaS83NVQ1akN4R0pycjdmbExTU1FlMmlH?=
 =?utf-8?B?UXBlQ25CUnloN0dKV0tnSG4zS3h5dGxYSVlRNUZDaFRIM1crVFptZzNTNGpz?=
 =?utf-8?B?eUlPUUd2ZzkrVzVVTFhnWERjU2xJbU5xV21neWdtUFZ4MUZheWNKWEJlWEhs?=
 =?utf-8?B?RldPV25mblRHMThPYnJuRkVZU2ZrcDlxRE9jaWpmU0JTUkI3TVorYkNiSy9o?=
 =?utf-8?B?MzZLNis3NnZzUjY2QUNYZUpMaEgwMnYrR1J0Z09lNjlEbldXc0oydFdBMVho?=
 =?utf-8?B?c21SaVArZCtidC9oYlV6eEZYZlhTQ09WUDhQUXZDZ1lobkFiQVhacGd1VUxG?=
 =?utf-8?B?Uk9vdGZ5b3I4aTJkdjFNMS9mYk1hbFkzVlBXMkZhZGc1TGlvQWJ2NkRPcXA2?=
 =?utf-8?B?ci9mUUNzWGkzNDdYblVwTjQ3M1h2a1FRUHVIeUpkUzRTK3NEZDZ3RGlDSkFP?=
 =?utf-8?B?NC8xUXdxeXFWbHJIT3o2enAvSGVrNEd3T1l0QzZwZU80M3lwNWs3WFJ3MHNX?=
 =?utf-8?B?K2M2cEI0WjJCSWNzbmJEVnV2Wks0cUYxS2dDVlpjMXo3WFU5NElWZCtJNXFJ?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543dba8c-7e99-45b7-07fd-08db1a2360dc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 07:05:45.5829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCimhHiA0JIQIqnBq4Yytg+aSJevwcdYaqlipzhfjroLt/+M6Y74Z+og1xboYaq2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5568
X-Proofpoint-ORIG-GUID: B-231cOMegOiZcPJSpXPiKR5UuYyDLNd
X-Proofpoint-GUID: B-231cOMegOiZcPJSpXPiKR5UuYyDLNd
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_04,2023-02-28_03,2023-02-09_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/23 3:22 PM, kernel test robot wrote:
> Hi Yonghong,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e492250d5252635b6c97d52eddf2792ec26f1ec1
> commit: dffbbdc2d9889670c30e07d05fc0dd712e8ad430 libbpf: Add enum64 parsing and new enum64 public API
> date:   9 months ago
> config: s390-randconfig-r021-20230227 (https://download.01.org/0day-ci/archive/20230301/202303010701.KWYce0Mt-lkp@intel.com/config )
> compiler: s390-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross  -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dffbbdc2d9889670c30e07d05fc0dd712e8ad430
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout dffbbdc2d9889670c30e07d05fc0dd712e8ad430
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

I don't think the commit 'libbpf: Add enum64 parsing and new enum64 
public API' is responsible for the test failure. That commit is purely 
userspace and should not be the reason for kernel module symbol undefined.

> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303010701.KWYce0Mt-lkp@intel.com/
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "iounmap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
>>> ERROR: modpost: "ioremap" [drivers/tty/ipwireless/ipwireless.ko] undefined!
> ERROR: modpost: "ioremap" [drivers/net/arcnet/com90xx.ko] undefined!
> ERROR: modpost: "iounmap" [drivers/net/arcnet/com90xx.ko] undefined!
>>> ERROR: modpost: "iounmap" [drivers/pcmcia/pcmcia.ko] undefined!
>>> ERROR: modpost: "ioremap" [drivers/pcmcia/pcmcia.ko] undefined!
> 
