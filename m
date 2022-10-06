Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39E5F653E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJFLe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJFLe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:34:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C682980F;
        Thu,  6 Oct 2022 04:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmIp8TG0p4BJmd1BKnLE8Msus38yiCMd8hmEB8QcVEF19jX+SqJZmsoJAXVjZ3/HKsAeo1LSo9dbWsGNdVUJkJpxcdJ6dTOMHYFtruTKGLfZ0BmGV6Go/p4iVLtIKti4ZkEgeBSPQEuHrr5t5egLAMpNOOscHU/CgAVvFqn38+cFwmFjYMBeaZGU5tE5IAtMs/MOLp4hmeBjPOGVq0Qnmxa/iETQje9X+kIpyjXLs5iJDZ8TS387RYI46tUSagseMF+Wj24r3QsqBAbpGeWT1mN0mtKDCA6dvP7mu6G6hkixceYpHoOI0+gDNx58b9WOsbAbElo9DTICKXPWUKgVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/sGTH5BpMlUZh38ELOAjbUXLw7AUL6pO4SpiaJVAnI=;
 b=BW/CAIPkfRtTaU0L/x7t22NeP1qshCn/seayhD8P2ckWOyAU9gSLTJpS0p2PV9MUL9OsXBAGi1p5mmzU3xc6asCaeEQaoNCTd6rmRahtQpDWYPvXt48q5TjvCevrLr02ARwLFbph5nPUn07I4+uSP24vv0uamhtmXnOB8IpoZmc46WEgG0h0iK0Ls6uVDarxG4ENDBIzq4bINiOU1yn9SCjDgJeqVCsN6N7t/HVYW118xK8riJ6ysEMTFaIWMk+wCKYmrYz1ZhLtDfaYuGpQtCHSfXW66Thk9nYtlvEx38SdbG1rhL8jCOuCm/l3KIPRp7yQeJuCG4OWHDYQDZuShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/sGTH5BpMlUZh38ELOAjbUXLw7AUL6pO4SpiaJVAnI=;
 b=VWL+p7Vkz0sRilz03NrJCsSRAWEyowwPlmrSSnlaMg7k5vz1y9Z/K9A+Rd/JGi+ejTf37bSI8Tsv9bZvvI0Tef2fv+LTegQZbU0YWWJhRjzNX4Qt7XukQSuiqg0lbv7zQjzvDjV8L/Q9qA55035NhQdf3t9nkGXqNlbjete9Gd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 11:34:23 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::4a1c:7d22:b1b:1adc]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::4a1c:7d22:b1b:1adc%6]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 11:34:23 +0000
Message-ID: <37feb67d-854c-e76e-1de9-256b7394ab09@amd.com>
Date:   Thu, 6 Oct 2022 17:04:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5] perf test: Introduce script for data symbol testing
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20221006101039.47870-1-leo.yan@linaro.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20221006101039.47870-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::21) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a71160-5525-43b4-bcc3-08daa78eb778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lls+/o4BuGyhsPYLQFs2NorVrW370gEyjUXI0RhxlsGKtU2uQIcBoAA+nP/0G3fqLHb1ucOhd7qO0J6ZU1nweJv8GFVXz3zgPyLREW/Ldy1Mf8NUK28kqgrEAFjfWLaO1Tj4K8uRCvb1OCRUJhxLbGQtJSQ1eUVsN/Ef1gfTier57Wfe3baeZQb27qTewcPG8ZHko+4yS76uudpYTXvfiSsTaF4YDMeCEhgSaSKsQnzmxe83PNd89vxyBaKxkQk8Gwb41zTU8o1Hmmk0JaDxHQU2Rdfv+QOcbbQBE3QsiBQ9JP/drJx/Ji2fXH6zTz9QQbpD+6J9NSdxqVmMpT9etT4SiYXl0fzWHoNCd8GUQsnmxLOPdrxy8nXdblmKyiTqOcQMQQbD1gjVS+wiaAo87i7963JELfLP1FMTTp+bTuczmfbVRwCfGmlrCz7XKSHyWGloQ14uiCdD0yJmA6I+M5IjvIgteL9Q2XR2MqCXHLhoNTkLzL+1k52wc79eUC7RhzhnCECp4z0LDSR5PrWQbWU8eU39uMFDfDE6LK7SLNNt/55g5IUQU8L2akRw3OKSXCEZmIhzLWs98qbzS6KhDpv6ffkEx5aj8KGpLljPPRS9qGa6vqmGkZoZ/YXwj2ohA8fem1mTVFMEmskicju1+u/Vd0xIW2fmBDxStfRW9tDpycYCFvYWHyWiGbAvlvhGc+9PCv8wHni7d/8xFhJYhHBDrIafjTNpH2P5enKyTXvW61B+TpsSoLyE65UHgYkI0rUJw2Jc6qIcHJE9pEJt3InRr5ZESIJD5H+niwwtea7bRWVUXu+KHvIhL01kdSHcmIxxw5T4fIOmhGoOv+0wog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199015)(66476007)(36756003)(6666004)(44832011)(7416002)(26005)(5660300002)(6512007)(8676002)(38100700002)(31696002)(478600001)(966005)(2906002)(41300700001)(31686004)(86362001)(6506007)(316002)(53546011)(6486002)(186003)(110136005)(83380400001)(921005)(66946007)(66556008)(8936002)(4326008)(19627235002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk5nSExMcDMzWG1lWWk4emI2Y0VKSWZ1MnU4ZjBNM0hYMHJSMnJLbWxOSVNW?=
 =?utf-8?B?M05FRk5iYnlTZExUdmcrZWx4Q2JpMEJFalkvT0VZVmFNZG55bHQrODZKUGZ2?=
 =?utf-8?B?dGxXSXVmZGs0c2V5TmRjK1dQcEV3ZGJIZG1CNGdpQk5iNUx2a3lpaVlXRWYr?=
 =?utf-8?B?ZEE4YXR2NERtTDlEN3k5cXh0YkNoYnArSFdBeUhPTVhSWUhpb1Z0L3VhTDEz?=
 =?utf-8?B?blI4TFppeXpPMXo2S3ZHYldWbjNHYUZ2SEVwUjZzbjhGVitFNll1QTlhR1NN?=
 =?utf-8?B?a29LVHJmQnR6K09OMm10aXRsTkxGdEhSRks1UDNtdUFJNTdCRUt1UGV4WUJY?=
 =?utf-8?B?Z25WdzgvNFdvczU5UGNTN1ZDZW8wOWluNWlSdW1HSGIydHdSVEN5VkNTcW1a?=
 =?utf-8?B?K1pyZkphRTRnOFU5WTlsVjNvQk1mbFdlU3ovblVQdFZCS3J5Y1ZrN1BMYUJB?=
 =?utf-8?B?S0pkdC9vejcvVjJFSEMrZjJqd1hiMUJvVWZORWJnNjRUWHZLRXVSQWMvV3VY?=
 =?utf-8?B?R2QvYVJSelFqbE9HQzN6V3dhQ01ZMmVOYk9Bd2hQQVhWM1RpY01XUHRydEtE?=
 =?utf-8?B?YTYyZzhCaHQvTlNxb3RvNXA1MXdndE1GSXEwckV1REczd2FiSTd4aWIzVitS?=
 =?utf-8?B?cThxc0dFd1VOdmR0UEViQXptdFNJamRscTdubUo5VjB3TiswdE1NOWJrMnFs?=
 =?utf-8?B?eXU5NmFmSzdGNXhNZGFqenVqV2hWR2tYZERxYXdrUjd4empINkx0TjF3bU54?=
 =?utf-8?B?aXNnbHprbzZ6UGE0Vy9KQWxhKzQxUXZ4WEZtNGlYMkJTR2tlanIySVZRcVIv?=
 =?utf-8?B?V09UYzBieFVrd2VNQlhCU2NRd3hiM3dEWElNRlAvelpJTjU0ejcvMFRxMjRG?=
 =?utf-8?B?Zzc0WG91RWlSRkdFRk81akhKL3JNelNRSWZYMkhZcmx2ZjFoVUQ4MWxQZkJE?=
 =?utf-8?B?ajFPa2JGMVJES1J1aW1vNERzdHE4WDB0L3ZCc1V3QVIydTZPNkJ4Y3FxY2JP?=
 =?utf-8?B?eC9Ha0FHdTNXa2thWm94RUZGVDFTOWtuaFlJS3hmdVVPMi83M1N3VkxtNlFs?=
 =?utf-8?B?TktJdVB6THZqTjVZRnJkQWdGOEpaYmNXTDJydUx2RnhFRTBNM09aa0lEaVRx?=
 =?utf-8?B?VjVFd2R1dVVNRjFLRGp2UlJkV2VJT3B5N041OTFEQTAvUGpIRzFDV2pzMkdS?=
 =?utf-8?B?OGZZUDNWVzA5QUgvcHExVE1ieHNOalpWVlJFa2JzN0NEdmhoekpNZ3ZDcnp2?=
 =?utf-8?B?UzVITDUyaEdwdGhTQ05rWGhSaUdsNE8vRXBRTXpkSVJ1bE9WK2dDTENoNnN6?=
 =?utf-8?B?dlBMeHk0WlExQndtK2VaM09KZTgxajFFcDNXK3FvTlcxd3ZyaVlGeno0TTd6?=
 =?utf-8?B?UDFlT2xpM1J6RXNsYlFWSmNKb1hwdldybTZNVGUva3pTQThmcUNCMmUydlZv?=
 =?utf-8?B?cXA4WjFFZ3VLb2lmdTFrQ2lrYnRkVXZYYU1DUiswSzlmdExXYmMrS05ORCtq?=
 =?utf-8?B?WUtGQkZ3RFBucjhxQktvdm05VGtLRVQ5VmtIdDAwUUVKQ0d0MFZJS2FBK0h2?=
 =?utf-8?B?MWpELzIrUllVVWkvOG42QVc3aHpKbnR4QVRXbUU5NVlmRThFSkNHcndmK2Nh?=
 =?utf-8?B?ZVJ4MDBOeXhUajdmY1QxZGZ4NnVERnZlMDVXVTNrOHV5b2hGRHhsSEdoenBw?=
 =?utf-8?B?dEFUL3c4ZXd3dGxTeHh0WFhpWjFKN0xiTUhSd2VWemEvRm41aU8zbzYyK2pC?=
 =?utf-8?B?UHBPbnJWNVRxMHRYemdGdXozN1g3Ulc2M0puSnA4VzR0Z04yeHBRWWowblJS?=
 =?utf-8?B?RGM3THBQRENzaHVpbXJlaTJWbEFBL1B1K00ydVNEZUcwRUduU3VyNGdtazFz?=
 =?utf-8?B?c3kvVlk4MUxFeEN4TDZmL0cwY0VER2FqQ2REYlJOVGlpTlRIZnpKQjRmRXlR?=
 =?utf-8?B?YVNrYTBDenJlcVA1Y2dPOXJlTHJSeVJ6N013U2dsaUNCZFEzWkZDRVpNUE1w?=
 =?utf-8?B?MXdFSy9jbTNTSS85Qk1OT2xGTlE0NTFMQzY2Qmd1RHBwVXgvOEdSQi81NG9a?=
 =?utf-8?B?eGp6YURLakhoczJNWFVoZWFqWWduN0dzOFEwaFArSWxPSXMzRUJ6NWN2c3A1?=
 =?utf-8?Q?oyW6ARMeEVAHsOPxLVVXWUXlr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a71160-5525-43b4-bcc3-08daa78eb778
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 11:34:23.5277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpRKZ4Wn4WWqRTyW8OTeMyUDLXRYiOhtGPQ26pk7nhm54ZYDrEmzH57A63VQqy2HWxU2hrgjSORTIkcJbqoSMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-Oct-22 3:40 PM, Leo Yan wrote:
> This commit introduces a shell script for data symbol testing.
> 
> The testing is designed a data structure with 64-byte alignment, it has
> two fields "data1" and "data2", and other fields are reserved.
> 
> Using "perf mem" command, we can record and report memory samples for a
> self-contained workload with 1 second duration.  If have no any memory
> sample for the data structure "buf1", it reports failure;  and by
> checking the offset in structure "buf1", if any memory accessing is not
> for "data1" and "data2" fields, it means wrong data symbol parsing and
> returns failure.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
> 
> Changes from v4:
> - Remove the redundant argument "--" before CPU list (Namhyung).
>   This patch is dependent on the fixing:
>   https://lore.kernel.org/lkml/20221004200211.1444521-1-namhyung@kernel.org/

Thanks Leo.
Test passes on my AMD machine (with AMD perf mem/c2c patches applied):

$ sudo ./perf test -v 103
103: Test data symbol                                                :
--- start ---
test child forked, pid 18048
Compiling test program...
Recording workload...
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.569 MB /tmp/__perf_test.perf.data.1bDdJ (3064 samples) ]
Cleaning up files...
test child finished with 0
---- end ----
Test data symbol: Ok
