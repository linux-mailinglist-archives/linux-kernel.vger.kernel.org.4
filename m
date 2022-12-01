Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD5463EBEE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLAJEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiLAJDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:03:41 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F8E8DBDA;
        Thu,  1 Dec 2022 01:02:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYaZZHCBsWRaTCM25D+wJWTfPQ5ZJYXT6VL5G3t+UWXD7s3XlbWiRiAX+AaKg0f8SR/9Sfp3HlrtfSduegJ0UpM89ID/+tqte+oMxxJYap4wJyidEgbTTByTU+h8557Gv6PkB1g0eWgueouOseVeDzU5rapHC5KTF3gJF9iJL9l17h51m8l6KXlt5JVeahiKqd24hBc/cLZ60U9eIDuLqqNUb8vvkW5e9c2yAAbcYz0IYBzRdiYFiMhBxgTOtWaBByWHPfSX0zdHvcGls5pz6NDkOG5+EDc11NHsWlYl8ib7zzLjhffQC1fGsm5ZbHs/CVyeIEFUKi/ElmJ8LqYJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcdFz9FkmJIxfr/+yM9rS4Kjzifb2H0xt/ry1Ew11nM=;
 b=h1k7JugF2rbYPE8vApGolf2aIt6bFGl+7YXTtsIZpgQXljRI26qfvp2hIkzBXUO/GIbhTteEVZ57ayJoCkuGvr0J/qzyBKJ0HiVfFMb6yArEqMnO+YeQVddZAy8rODWqT/iKjPLxJG2c7fu0yU0EQbx6ZaXN6UJjB8939Lcfk4VZvO/wdEnAUxFeJ/b3nBhOt6xRR4D2jVcmZ5qhVceke43lsPRKF9sZ08L/OruNn+zi6Nebtvg2d+UTZ+zyTceZ7QXGrEjwMtozxtqW4NrEef/biMC+EyEf6Bq0PS8FWbmyAdWpbbV9freapsq5p72rXukxbmhd8ACbd9Zei3EadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcdFz9FkmJIxfr/+yM9rS4Kjzifb2H0xt/ry1Ew11nM=;
 b=kwNAwvpWpKDjSIzVsB2Z9VNPzJlAqmP1OsAjcafB0BWajsSTQabc3qLz7YP3bGWcOM/I6yvblsxQSA2mP3ttXiiNwd2hiHgoeQCTac1/kZIqpZyJSrNrRruPd+VO7g8yJK4qB2EilFhLjMA430jC+r/C6UxeWfGzQ3UQkyVKJ/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DM4PR12MB5312.namprd12.prod.outlook.com (2603:10b6:5:39d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 09:02:28 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 09:02:28 +0000
Message-ID: <444e806b-4593-7ea9-a8aa-27d2f726a751@amd.com>
Date:   Thu, 1 Dec 2022 14:32:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH] perf: Fix interpretation of branch records
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        Anshuman.Khandual@arm.com
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <20221130165158.517385-1-james.clark@arm.com>
Content-Language: en-US
In-Reply-To: <20221130165158.517385-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::9) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DM4PR12MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a285ac-ad10-45f2-537b-08dad37ac551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZeaBkTtSo7hmebvBlUObssYNWjY6ySadiwuanL3YPApO9J+oVFaoVkurMddUGInI0SGkOE1yKPkX/Hf0ZDNwHnepz8keyZcmYGrH/ZwSrUA3DN57L0DkeCjQKoq3tvTiChkHZ9onpLWUbPVYhl7t12NTAPVGtL6p72f5n1mbNZGEetoxLsVWra2yCSOEtgy/FYfc8ikrvznfxbKEh1GS7/QjeKglI3OkceWIWYd7Z2e0RjpTCF6MrrH2HStvuxp9rG+AcEc0hNiYTocVHVtF7bCyDWBL1k+5oPR2Z1VHyiHPFxE5jVS5Wt3sTimzvmDs6xWkvZEFZRawiwisB8yvQ19oKgJhvWEp1RsqPBJYYVeM/xDIj3x2fBO316ydOB1oubCKibMCvvi4QbYX+18T+qKJmKHThvo5hV2k6UBV7uOz6494XGVQK7aEQHy/yTI/4ypYwKRGTC1cum+HMQKcJmHrhwJmIrXm8qMMjXuwCSbI5BVrfrPc3IrswLrX+wFWIpayDgAmcR782bj7ciuseC4eQsVrCJEE6HkcVUSs5Y/+r/Wm0Jwjl0SF3RqSpWEZ52SVuz5lbA6Ty1cKF2JSrMITqtrOd3xb82YomOVHk+NAaeU6dz+05bm0Vxp82w21YhBcjXBnr2hVgAZRfB+8q/+/HnBEl1eiQLQEKN4dQWqBEli2NxygCoqEYgFQeNeUu8Qv5xHU/XpLvkXJVN54AtBZMfIpwHPLG+KxDjEeaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(36756003)(86362001)(31696002)(6486002)(53546011)(6512007)(6506007)(6666004)(26005)(5660300002)(7416002)(478600001)(41300700001)(54906003)(2906002)(8936002)(4326008)(316002)(66476007)(44832011)(8676002)(66946007)(66556008)(186003)(38100700002)(2616005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGdNU2JjbFRiUzBpTkNaQnJXRUY1aGZkQk1scXZscHpkZVQwMndaZlZQc2pG?=
 =?utf-8?B?MFk4cXpYcWN0bTgvZGhHb05rRjNNWE9jaUFwb1MxaUtPQXlEOStGY3R0a0lw?=
 =?utf-8?B?YXU2cnI1VXg3THVnK0NUWDJGN296L216OFRNQm9YczRKczM0VW0ycm5YelND?=
 =?utf-8?B?c3phVXVYdEo0dWdMZHFqV2RwdjQ0SUNSSXNTRGNQbEhpWFUvNzJSSWswNkxv?=
 =?utf-8?B?RU1vWFRPS3ZXTkQ5eEh1WWw0aHFuTzRiMVFSbVNtenFnaVVVeDJPOE1PV1pQ?=
 =?utf-8?B?NU03aDJGVXZRV2dVMjIvTXZGODdpRTBHa01nRGE2TjkvU2w3UzBQNGE2TTZO?=
 =?utf-8?B?QTMweWF3L2JuZkVvNy8zVVRZb2d6WjBEUGVacENzaGtZTDZDSUNFc2RvZ2xO?=
 =?utf-8?B?dkM1MS9Hb0xwQlVrZVZkY2UxTStGRVg2eDVJNENJUmlCWU1MN0tFSmtBcTdh?=
 =?utf-8?B?cHhqVmhGb0pCcVJoU0xFVHhROW93UlZsUjZLRFBQc2JPQktiYjFldGFZQkNU?=
 =?utf-8?B?T00vNXFmeEEzaEN0K1JNVmZ6MDhFeEQvNkJuYUs5bVlVM3RTTkg5TWFRcEtU?=
 =?utf-8?B?SGUza244NVdWWkU2M2lidHNkQ2xzU0NlL2FLOVVkZmc3aDY3MkRYUmxRRUZV?=
 =?utf-8?B?NjNVWmdPMjJpT1JtMFFSeTk2SnZsTzg5SThtb3VkNHdlTWpGbWM4djZSdVUv?=
 =?utf-8?B?WVBZaC9ldXJLZEM1UHNDa2VCYVBaRDFMM0VFQXBRTlhmWXU3S0NhZVBxZlo2?=
 =?utf-8?B?SFA3aEo1dWZaeEtnbmRFU1doMFM5bWFEeU0rUXg4dzZzZ1JjY1o2VG13dHNi?=
 =?utf-8?B?ZnFaTEU2R3NUSWRtOHMvOVpVUFNuclBwVlVKa0ptRlNueklnYzRxZEVidjVQ?=
 =?utf-8?B?UFZsNnRLZ1BDclBDSHRMMDA3bEMvMjJteDE5SzdXUDIxeGRsR2hQQ3plSTF6?=
 =?utf-8?B?Y2U0d2lBT0E2WDFBMVN6QkVSU1BOZDlEWUFiVE1IN0V1SDZ5UzNxeEpGSDBv?=
 =?utf-8?B?L0M0NnNGSkxsbnRzNDFIYldLTGFmUldXYkRuZXNaem5hc1Q2eUJTTTBSMlUy?=
 =?utf-8?B?Mk5Oc0RxRUxPMVZsc0FmZmtJNDRhWXQrdkZJOElqeE9yOWJQb0o4TEZRK3ln?=
 =?utf-8?B?OCtlN3JiQ1l6RlBKNGJ4RzlWU3cySGVwaENkZi9zbDhSck83MHdBUnBkcHpN?=
 =?utf-8?B?d3NTMjZOZkRLZ1VoeWhBdmFhWnB3cy9RUndDSjE5UHd6MExVMnp1bUpTdzBJ?=
 =?utf-8?B?ZTFvUEgwS2dGSEM1ekhINmpwN2lnU1h2am1iQ0twSi80MW5XblBlQW9TSis2?=
 =?utf-8?B?RVAyeTV3SVJqcld5YmVRSmhhRWF3eG1ZbHBnckQrZzEwc0lEVHIvNVNLdTBz?=
 =?utf-8?B?T2U4a3JoQ2VCZ01jNVgxRE16Unc3ZWo2RzRQNHY4WmtoaDdhRFhvSVEzdUVR?=
 =?utf-8?B?VTNEMVZSa2k4dlNkQnlSVjNrbXBYVGhTQjBYa1VnOWsxRmVIK3JZWVNpdjE5?=
 =?utf-8?B?a0F0c3dKOUowT0VzbVg5a3dWVXNORFk1dHhpMjhFSnJ5RjI2S3kwTDQ0NXdB?=
 =?utf-8?B?WjJnWFJ0d3FmRzJ1Sjg0YktpcVhNa1Y1Skkza1NoRlg4OURqeVJ0R2tOeUdX?=
 =?utf-8?B?ZVgrd01pME1VRERZS3RaYXlMdnVXUEJvWFMvVFJxSkN4S3R0VkZaaHZLL2Ry?=
 =?utf-8?B?WXJzV2VoVlg4Um5Hdk4xTXZPdWN2bWNPeVVrUThmdEhFS1Q3VGI0ZWVhWmhn?=
 =?utf-8?B?ZUp5aVJYblRjemxQYTNKbm1rUUxGTFJJSFBjOHB4R2l0MENoYkZsVHRPTEpT?=
 =?utf-8?B?NTNNaG0yNSs3R2dMeDdQWGVJRlEwclpHZkJuVHlxR3R3aDV2QjJ2ZUEvd1o0?=
 =?utf-8?B?elJ6OXhYVWkvcjRGelpodmhxblpheExYNG54eVJZelFIWXNGRm50ZEIxNUJV?=
 =?utf-8?B?REJDanZZNlZYYlE2cjI2V01yY2NtdzFpMlNXMUY5SHltRWR6SWVTZ25weW1B?=
 =?utf-8?B?RTh6UldDRWtHRUh0UHQ4OHZkYzNDUC9vOG95TStGWlNuQ1dXNXd0S0QyMVBz?=
 =?utf-8?B?L0JUREVEL2J2YUFSZGNzaUtJS2xYRGtoOHdwQ3VMTmpVYStpMSt0dlRhYkRP?=
 =?utf-8?Q?S08sPN6KDyX1ATgx4Y7Q6mtDS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a285ac-ad10-45f2-537b-08dad37ac551
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 09:02:27.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQ0bK8DE0nwWf48iWml1pPa9tK6OzShaK17JrnyldmIg9tMEXiZMquDbm4i18XQlVYuYIkvVLfqdiu+8x6nekA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5312
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/2022 10:21 PM, James Clark wrote:
> Commit 93315e46b000 ("perf/core: Add speculation info to branch
> entries") added a new field in between type and new_type. Perf has
> its own copy of this struct so update it to match the kernel side.
> 
> This doesn't currently cause any issues because new_type is only used
> by the Arm BRBE driver which isn't merged yet.
> 
> Fixes: 93315e46b000 ("perf/core: Add speculation info to branch entries")

Technically, in the kernel sources, commit 93315e46b000 ("perf/core: Add
speculation info to branch entries") landed before commit b190bc4ac9e6
("perf: Extend branch type classification").

So I think the Fixes tag should instead have commit 0ddea8e2a0c2
("perf branch: Extend branch type classification") which added the
UAPI changes to the perf tool headers.

Aside from that, the patch looks good to me.

> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/branch.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
> index d6017c9b1872..3ed792db1125 100644
> --- a/tools/perf/util/branch.h
> +++ b/tools/perf/util/branch.h
> @@ -22,9 +22,10 @@ struct branch_flags {
>  			u64 abort:1;
>  			u64 cycles:16;
>  			u64 type:4;
> +			u64 spec:2;
>  			u64 new_type:4;
>  			u64 priv:3;
> -			u64 reserved:33;
> +			u64 reserved:31;
>  		};
>  	};
>  };


