Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DD760DAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 07:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiJZFqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 01:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJZFql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 01:46:41 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE68329C8C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 22:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB4kM+KxEk1yxj5e9MOnjExDnRpDvwCww18Vk6lr1PwMRtJSM94SF5GIv8YBCdAK+N6w87ctHDqbC2MBL/HZgBLoCETz0o4nrvD7vOzMXjns7Rjct9WDKU7ESCS27E4k5dFKfs+kWI8YFxgbrJprSvjWTnqiO666WRhBXW7MprsLTV8elXN9lTkBfCpv4uR4ddW1ydGC9dDfyYSPxyowluWtJSHj+iXQz/pE2vByYFPlqgMtkZYOMFOv3xSXKABYqkuorVsano4a68LNIiOJPtiuT/SZ2+rcM3YynxcEcYjg0NgG/HpZUFSGe4tTstthB5dT1n3FR5R3p/hmLo7YaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEqBQU+FtQGXXfPFI6WGosuR/cO7t0JjAtfceb6WGEs=;
 b=f0dNaFijsmuNuKeSwCk5P4pxQVaPnRuWEdPwadkwi/zrEgT5vo7MrS+7V8d7YbrRqUOTVJGsQg8GOJEPIbphB/Bin/DArvWLJ50lL9RjqoCIf0Li+hbfxN9e4SFCb+Kq6P6Hcc45Z/A6sR1rkukOgjoQaUAUdQOoGBRMp4WLHnM1+OP4HiOaTm3Et+4HReDERnKEXwmkoQMk+iXSLetzandS1a+6/+muV+bZGAbL27hBa7FjduslE9g6+6E5lQ+ufrEMBv4V1ws5AjG70B6ZIAZq5tEVhhUu+jxHHMq6aeWHOHXuXfpC+5i+cNnNHorfA11n1GuZbET69ZjYUnfiFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEqBQU+FtQGXXfPFI6WGosuR/cO7t0JjAtfceb6WGEs=;
 b=1p12+JF7qpeHOMzIwTA/RE0C1nl6KYGu5h6+vkCP9vcYwK4QK6Je0JHG35/irSFDC0vz17E6SOotIWDccxk8vQz6EHral4voFYoCSEObBmYnbZR3Eo3Mn5GWKky5b6gRZNq+RTfpszIdBKJckaBd3cJhC31BV/ErzydGYK7tjiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 05:46:38 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::fa1e:a29e:2f2c:43d1]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::fa1e:a29e:2f2c:43d1%9]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 05:46:38 +0000
Message-ID: <678160a9-49e4-76ec-f002-8c19521a4ef5@amd.com>
Date:   Wed, 26 Oct 2022 11:16:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: perf amd: PERF_MEM_LVLNUM_CXL -> PERF_MEM_LVLNUM_EXTN_MEM
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <Y1g/H2/ljZ1rGmM9@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Y1g/H2/ljZ1rGmM9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc1e569-1b89-4061-c5bd-08dab7157311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bs8M+YGz0u60jGorxEVRZZWQwB3azGnEz3Yx8G/VsYmV2uJ9mtZFTWbbXtD5vTiVB4nqYba2qmyQakLjTTz7/Sd2KsyAbHc6LbdKCZl+gmrjq9sm31Sc4ihzAC2sYicybHdvyDKQmt2uXtwEy7YJCelBnO4eQf4wXOI1PZlmNpYc23mZPWx7xzr+TK6mnr7XyP00jamPD0jeFafaenijpyu13LFMIp3NtVPvqOkSjhYM5lrWS7Jqii5n44g6+SEyXpxgwyXBAUCnIMrQl713SWSLu/P1wqTPK/HoWllRgpaCJUI0z+tIt1F69XlsFfDTEsbP583xdYa7WsVip0TMH9LXzFVwQc7EO3yrpIEHf1TAjgP0kMaOr+0XcqEG5bPeFLzgIuRKoVQyIXXX7Z5y5duhI7TOmFdBj2SbUf0ykBt6Pkbah3TddzI37L+bAozOcLHXnUSy2BWDdy6F3sO9Iady05EO4SN7sqOk76KBvGUID8DJJnFz5sd4fQCc1Sm07vh4rkyRALvQMK5nw1EDMnwd/yqna73PJ7hS99LtoMyAEXvvtEcLrPoUSwJd9peq6YGFvkHBc2lxCltW5OOo8qGan3CSX/laG+Dmj6QIzIr2xwXawzcrqWaCJ7JYUD+2FsmNnHcYMpd87bGqipxCXHCmG/dF6Jq2zJwh2/GXGHoH5E87oMOJeUOWUXbopCZtgXAzkCZr3OD5MwO+9YssnrHvYM5BNxBJBPpqvC6i+lY7oso5ZK8WAAqkdK1Z0+PWJDNBMkPZGjJockBA97P/J1OoBt5bEuPRnKGZLuZ5DSyFAJreQMInU0JU2h0NNPiazcrNu7dqUBg5oSqf5kMyAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(38100700002)(966005)(6486002)(31686004)(478600001)(41300700001)(54906003)(8936002)(26005)(6512007)(36756003)(5660300002)(6916009)(86362001)(44832011)(31696002)(83380400001)(66476007)(6506007)(4744005)(66946007)(4326008)(186003)(6666004)(66556008)(8676002)(316002)(2616005)(53546011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RENqYk0yQndHSmRRNk5tbHJRUTdsYVdTdDJFNC9aYVFnQ0dCckRmRU0wQnUz?=
 =?utf-8?B?d2gyNWRYOFBCUHNCL0JLUlRDWit1czQ4Z3UwQjR0cXdhLytKbFZpbjVYT1hO?=
 =?utf-8?B?OFJHK05sOHdIQmRWL3hoZ3J0dWtkclNpOXBZYTRpbkRmQnEvS0pVRlNidHFT?=
 =?utf-8?B?aEdjSVpmeEwvN0o3UThUNmJJYlF1ZldoczdFdkpGV3ZrQjBWQmFzSklEbzhI?=
 =?utf-8?B?ZWcyMEk5eEU2UFhTTUdQZkZSM2k5eXArYWFJZlBSSGRJcCtLYTlWb2hXNWlu?=
 =?utf-8?B?MXBQVzdnNW52MFR5Uk5LWjRDOSs2UHJuejRWL1J2ZkgyT2NCdmtHVWk2azl1?=
 =?utf-8?B?Um14SVErbHVZemtEUmpENWFQOUNPQ3daRWd2aU1KamtQSXlnSWlJcFRnOUlF?=
 =?utf-8?B?R1E2aVdvUzRWS1M4WHdHODlZaTFxMjE1U1BoNlhUVkljNDlMbDRsSENQc0tj?=
 =?utf-8?B?cDczNERwUndZYVFyWEtqTzRPMzlmSEg4TzV0alVQaDZXSWhjS0ZuRm1VeCtJ?=
 =?utf-8?B?Q1BDampXT0NFR2JDYWsvVW1RYnhiNTNVOGRoV2gxVnVBSzZpVUlodGtvck5i?=
 =?utf-8?B?QytkNnVTMmdDSDJwSmJORlhydkFFR0lCN2lRSk5NQ3hzTUVzM1poTllRSkJ1?=
 =?utf-8?B?UGZsTGhFb3NDV2w4S1R4YnVqbzFsSGhmZUFIYkpVbURqV3NVTmErZHFhNFZp?=
 =?utf-8?B?K2JJMkw2WGdSU292UVRkWlRjeEpxL0dxZFA3ckZWVVlCUWJvT2FxN2JtcDBk?=
 =?utf-8?B?aGwyM3Zxb0prcC9wSGdZdEpOSWNQMi9zeUpqcVR6cXlpU1h4aWo1WE1COEFP?=
 =?utf-8?B?SEYzV0lPdEtvZ0hETm9xazRGbWRnT0pwZEtndFBRYWlYODdGTUJlbDZRRWVP?=
 =?utf-8?B?ZlNmQXk0TEdrVjkrcWtObDk2NUlhVUs0VXhpWUtQZENiR1RuNWRJQms4SFpk?=
 =?utf-8?B?MFBIc2Y3bTFRaHpySFkybVRyKzFZR09USmhKQmN6MVl5MDNEN2xTVEhlNnlz?=
 =?utf-8?B?RVVrdllsZmlTb3Fxb3IvSXJCQk9hRmp4NCtiN05Qa3BnYjY3Yi8xM1NhVkx3?=
 =?utf-8?B?M2xMTHZsRmVlWjRUbUllM29QcW4wQUtkVngyRUs4REZHZkt5eEVldHdDdzU0?=
 =?utf-8?B?VmhMcHdmV1BiYi9XWUkzaEpJMDZCamJQcTFLeUpHTlhlTTBaaWxRVG0rWlJl?=
 =?utf-8?B?OElXcjFJczZVN2pDS2hrbkRJc0xpUEZ4QmpMa1c3MlpPYTJwYjhOUGgxeVdM?=
 =?utf-8?B?Q2ZxWjI5T1NDd1BqTzVGdzlXaDVOYjRiYUdTNVJHMzdveXphTHovUkJPVFRn?=
 =?utf-8?B?WnM5OVV1YWxmUmJKdWpZOXA1NFV0ZHdmVzVycCt0SVpITFkvM3R3UjBNY0x2?=
 =?utf-8?B?VVJWUlFNOWZDVUdUMzl6WG9WaFEwTFFWTnhHUGtZWmhMVkN4R3VyNUMzdTdI?=
 =?utf-8?B?OEZVUlg2Q3VUQXY0bmlKSEJERHJxOWREV0l4K1pNa1NiU051ZndkQUlLSXBB?=
 =?utf-8?B?RmFab2pBS21rM0pBa09QTm9KRzYvSzNlOXNlYkhndlF0WXYvcHhCTnF3Z2dK?=
 =?utf-8?B?TW1qL3E1VEdmcE9GYWdjWUFkcVRCc2RBc2xsdXlSNWlyMDBUV2twRW5hOGRa?=
 =?utf-8?B?c0lPTGF6WEV4NFFFMjVsSlhTR3NFT1Azb083bXJMSHhEM0w3MTAyTGZ3UmE2?=
 =?utf-8?B?MUd6bzF5Yit6Q3JXMUI1eFYrakNWU1VydkU3bzlWSG50dmUxU1dWL2NNVmQ1?=
 =?utf-8?B?RHRtV1ZCazRsZFNsMmRLS2hxUk5xWnRsYmZCckZVeVEzU2hmU29GZWUwMklo?=
 =?utf-8?B?aUdNamE3MUVSRVM4RThzclQwelRPOFo2STRyNTdYN3ZvTmh4UFU4ZlRsNmtw?=
 =?utf-8?B?OUNLSnJKR1JXQlY1VEVXVEp0Y2oxaCtob2lDRTJYM3ovZzZrWkpDR3I3MU1o?=
 =?utf-8?B?WGUzTlhZS1dQWEl6VWw3WkpaSC9GUWZNN0VLbHVON1d5NGc1YTFKc1FtZHgx?=
 =?utf-8?B?N1M1OFNmMnduUkdkM05SNDBlZnFSNG9tTUZ6UVQzbHVkMG1zTlpVWEwzWkxQ?=
 =?utf-8?B?VXRpYzZXdkdvMFRBeVBZRXVva2JqUGtRc28xM1o5NmVwaFE3MW1ITUlqTy93?=
 =?utf-8?Q?xDa+NPrXzKclaPo3Y3Nc/zrp4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc1e569-1b89-4061-c5bd-08dab7157311
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 05:46:38.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keyNaK11/3lnBn9T4UJmV3q7qwVqxnwO5zqDLEw0utJ2o0SVtHiJoyeu++r5asslH2i079r4jQDe8O3Xsa2a5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo,

On 26-Oct-22 1:25 AM, Arnaldo Carvalho de Melo wrote:
> Ravi,
> 
> 	I'm updating the tools header copies and noticed that a previous
> sync brought PERF_MEM_LVLNUM_CXL but now this got renamed to
> PERF_MEM_LVLNUM_EXTN_MEM, so I had to add this change to the sync of
> tools/uapi/linux/perf_event.h, please ack.

Kernel header needs to be fixed as discussed here:
https://lore.kernel.org/lkml/f6268268-b4e9-9ed6-0453-65792644d953@amd.com

Thanks,
Ravi

s/ravi.bangoria@linux.vnet.ibm.com/ravi.bangoria@amd.com/
