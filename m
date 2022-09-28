Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555335EE0BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiI1PnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiI1Pm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:42:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10FACF495;
        Wed, 28 Sep 2022 08:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1680FgVTRAqjpOElc0HTI8c2zcpvo+hB+MGlJSTUMpuqdelxvJy3hpcSuwCLrvzR/15ETByPOJUcbpQnnoXrE4gq09IKo3PEI5KSM0ALeBx4IStj7AZaI97iBL4uLuO4N90tmTQ2ra4X+Q4pL1f9DrNly5Q4APBrKqa/s9H7ChYA+VdHxT/hzuUhUoG3BRNKZc/ArmL4rd62+b3QpH8YATWzSLE20JNp1D/KEmtwMBypKlO607nK2AWkvPy4Z42zRbf/NVxrQuvpIEt3KkYPJMOI9ZsijcfTbo1xfGSW7DIu4rrdLR6Xa6aBRG6BCO4XQiW/PgP4hGZTB4novCbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmMhwmfNjtfjM5SpJGUMq9VEsS1rbLi9Da5Mi6O2vq8=;
 b=VS1GpbzSZSJ2xFjQxvGRTxf6VTc3y+sFH704RUFSnGiK2bv4wiW7pCD5i1cmo6xd7ywH2csXDaowvksENXr9np+bu05lHV06Pa/oHeRQxlDJQ6n6cENp4wddG2ACxxUmtrTHGo35w1g5dyOOygkiLAq3qJyc2uAxpWNdkHNiBwfgc+8G7HFuoDQzMJI0TXdIoNO8ThBzfcCyCk52ynAhZLzJVUK+hS1MsTJ6FRkhch97/h8jpOnl1Jr1IUDUBwWkWJC/A5ab8d70xllQA8IK9iTNapESkn2C7JXxMdxnWrO+frlb+by3VlYRoMtOf6PA3sGZNGs0pCY8MqvlcS+sxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmMhwmfNjtfjM5SpJGUMq9VEsS1rbLi9Da5Mi6O2vq8=;
 b=TsyUAnvZ8WTms60Qn8n8J3esr+4p9Y+c9cjiBZr60po6O52OHsTv6vQT4lUDqQ2iQiu7FQZFHtxmGgtCmStA5HlfdC6mVkVM1sOP5CY+PltQN/pVJx0x6DFwCqIx8sIcNIe7rcOP1sk94HxuvIP6JpkeCOvqEtXBROX22kInT+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 15:42:53 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3441:5a68:b4b7:e988]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::3441:5a68:b4b7:e988%6]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 15:42:53 +0000
Message-ID: <08a9285e-4a4f-ff7f-0ec2-8958d0c11a08@amd.com>
Date:   Wed, 28 Sep 2022 08:42:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH V8 0/2] remoteproc: support self recovery
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220928064756.4059662-1-peng.fan@oss.nxp.com>
From:   Tanmay Shah <tanmays@amd.com>
In-Reply-To: <20220928064756.4059662-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: c566c916-4697-4d9f-d1d9-08daa1681b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1iPQQsNqWOBTmcOQIIuPz7WEeafxR0+T/2pA4QKO/niJB7WWrVxXdEmaOEthWmZnTkpgPlw1Hrn+9GTHNV5A2M2SFMQiHphNgm2rJ0YiS6PH4Gx30Ms1raGXXP3v4RLLrILaI6dd0NMDd+YFblS32xUSKjJoLky+HfSBrkgKZhEiQ9kFyWYEqzpadDPOVeyUhKyXu964WL7Fif0mzFnSUGYCtqGJtRDyBFpmOygJdvBTXcZox+XiO4fNOg7qq2KwadgmVbXuwzykPcMbAFngUYSqN1VOeRwd8oXNts1QiCB/ycs3cKvQRWQKlOUVMBvZQEd1D//6w03eQ9L7D+Ns/C3kCtwdAnSxBO94s4ZQUhd42sXZxQHcyGjX+TO+V7vQj44ubaFI/lJNnKLoRDa6Il0rpBhLgkvboFlK/80wEVqlv24SK5vikaTUZCvxhxxsLClMogw6slcYKl/oIwvuYvu8oBvmLN8t5XKydsVThLTkPJyF+SNa8RxNpxRNnxZcbo/hLuNd1XzlTa5PFUGpNxBJ743jQUXLtHFus9P7BoSTVZMuw1qgHDhiQ0fZNzJHZhLXBAw2fSgFMK9E4jOrwpwsrEk/PL4I/Y/A7sohbvouQQ/lF+nmrotxT3v+MyreIU3YmF6tcJkWKrEEZxG8lP6XfJ7Cp0XLsUyWPc8X3xraytz4Wn2Jv3PQ9b7IPNgoa5newaeVD76Ux0Ks5T7MWeU6Dgo0h4UfdVp+l6BPP86yz6RPmKJ9qef9Fa9byog7s9HPe37ey/WgPVPRiVUDJRLeeWYeRxPoTDplujXUHWNLrhE8YWHBMPs+oieR+QL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(966005)(41300700001)(478600001)(6486002)(8676002)(2906002)(5660300002)(316002)(4326008)(31696002)(36756003)(66476007)(66946007)(66556008)(8936002)(186003)(31686004)(38100700002)(2616005)(83380400001)(6506007)(6512007)(26005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHR2VEppWWxQZmpJcDBVSEs0K3FiZzI1QzZ1Mzk0dmZabFFSTjhiYUNYUU5z?=
 =?utf-8?B?VHJEN3ZTVGllN1VDb1RWQ0xKd2NpUHVKQjc2YzNpdlF6T2wrZDFVV2xhRzFS?=
 =?utf-8?B?eVdQVVdzY2duK21UU1BBbmlLWWFJOGtQbnB6NWtydE5KVFVJbGsvSWg0TmI3?=
 =?utf-8?B?WWxyeE1jQk1sU05MYTJRamRPQ0N0ZTVla1dDR25QN0VsaXRGSW5ObHViTEcr?=
 =?utf-8?B?ckF5eWNoc3NRLzZqUC9qWjQyaVN5a3ZXMFduRXIvanJPTGxteWNqV0lNdFpQ?=
 =?utf-8?B?bHBRTCtwanFlZlBUdnRaRXlyb2tNb3JrVFIvNWd6cjNZckY2SG5EdE0vRGcv?=
 =?utf-8?B?dDhISVFMc3dyRXlsaUx3SVJpNGUwYkRqR2VWVUYyTWJoNHN6bEVDQ2hEcHJZ?=
 =?utf-8?B?NDF3L3doMW1VKzJhRmxYZkVGNFhLRkxOb3VCd2UvUkk0a0tCenVmdVhUanRn?=
 =?utf-8?B?LzQ5YXd1cUN5MXUvdlU0c2x1bys3bE0za3Y0UmVDVUJEV3BDVlpHZDQvb3pP?=
 =?utf-8?B?MDI0Y2ROaUFHbzdqTjBlNlRpWFdxOHh0dnR3VU1XNTZFbCsyNWxzckdtL1JN?=
 =?utf-8?B?M0dPbUlDZ3VDamppeWxVWHJBdmhwM0tHWG81VG1BMUhoNDFrRnhpcDRnUFlt?=
 =?utf-8?B?dXFYT25HcmYzcWVsRG8vZGd2T05xc0FsSkwrdTVOTURnMlYrb1NSamxteFNZ?=
 =?utf-8?B?S2pXa1VTZVNKZFNlM0VIYVU2cHVZbzA3WStwL2VYY2ZCdk9FWXFEWmtUaTN1?=
 =?utf-8?B?N1l0ZXA3VUNiOUtId0FCWUNnVFh6SjZVKzZvdytHcWQ1aytOaXhSSE9idHBr?=
 =?utf-8?B?b0lWOFhnMFBzRjg1elJpemUwd2JTQndyb2JvOEVVYVluSmVvUVVNZDNZTEpi?=
 =?utf-8?B?NEI0alpOdTNPa2ZkL0JRcUhlMkcveVlvVW4xSGh1WXNVanFiZWQwUHZzZ1pE?=
 =?utf-8?B?ZlI4a2JqRjYxV2hkVzZRbUppL2NXUmV1RnRBS3cxS2dMU0kyV1N6WHFwMGd0?=
 =?utf-8?B?UXpQeGpjOXpubXhtL0ozTUQ4ZWpZT1hRN1NzRTh4QVJOSXBnRmRoNThEMDFG?=
 =?utf-8?B?a2pLS2gvRHdoSXZDNTlKTllCWHlEOHo3QlJTaVB5R3l4blZxaytmd1hQdS82?=
 =?utf-8?B?SDhlQ2tyamFTWkQrWmRvdHNmWkZuTmtLRHdUdSt5d0VDekpwVit6emdGZTR6?=
 =?utf-8?B?Rnc5MFllT05sNUg0eTc4TktsZ0w4empNWDVtTHJJN2xlamlZQ0xkcEdNVVNK?=
 =?utf-8?B?Y1VleFU3eS81THBwMEx3SlBsbW5LQXhJcjEwUkFIdEhla2VxUGxScnd4eHhm?=
 =?utf-8?B?dlpSVGdybXowNkhCV2wzNllNQzVUdlpLeXFwajRNREJZRlhmUFVweks4a05p?=
 =?utf-8?B?Tk84Qlk4VjhsZXlmelVpTGtJT1ZOUHYyM25PK0JpL0E3QmJCa0lyVGtQRnVW?=
 =?utf-8?B?eEVBMVNaSlQ5NDhZNDdsQlJ0L2RPbUI3RzJBeTd6L1JXK1M0WW1nVWd1T0xa?=
 =?utf-8?B?SWgwV3NyRnFWd2k5bWtvS3JyODE0N0M4eHlWVDNiNitsV0VqbVhjdnpnZjcv?=
 =?utf-8?B?NTRxL3ozRVhmclF0UTZOdUcvd2tyREduRFcrZHZwc29QNHdjMGNtNEZXaGRG?=
 =?utf-8?B?MFdIay9NRTZVWHJHUmFteE5ETWVvS2xnSkNiOEVQeUFFZlJMSDZVL0d2MEtN?=
 =?utf-8?B?Z0IrOTQycFZNMGtxSmRFekJoWDZyTFhBWFM5U3NmcFRpcTdTaFRWMDJpbDlm?=
 =?utf-8?B?YkpCa2tRTkI5eXVRb2tPNGpwN2RQS0UxalV0VlNVelRxaVI1NXB1Sm1oNkpV?=
 =?utf-8?B?TG5WMVRaUWVzSnZwUFBhZHNRRld4NDZObEQ1UHJiY2pVWm5ZNFJaMW93SG1G?=
 =?utf-8?B?WHl2dmM1bDZFRmU0aGFkdjJMZjJwY1pHY0dTYTdvUGh3K28xc0ZTa1J6YTkz?=
 =?utf-8?B?a2ZqbHF6M3pPalMrMGx4dDd3Y2ZVZG1TZ2xJMm93cTJYakFnTm14R2k5Qkli?=
 =?utf-8?B?clY1cUttKzlmdVNnaExmV3VXNGtjM0dvRmtrVzJ3WHorbWpHa3FNTHJqQWFv?=
 =?utf-8?B?a1F5SGpyUk1wS013ZDNqMWRpdlhmL3JROWlQeG9jVDVwSWN6TFM3bGwyRXVZ?=
 =?utf-8?Q?ENIpuVWHxohdVrRwLRsBcEiTX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c566c916-4697-4d9f-d1d9-08daa1681b48
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 15:42:53.4336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoDyQGI8OFbX2nqYw6MJQ34sYwO6ijgG6rlua+6DmAXye0i5Z7q8LV1DrH7kgmQZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/27/22 11:47 PM, Peng Fan (OSS) wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> From: Peng Fan <peng.fan@nxp.com>
>
> V8:
>   Rebased on linux-next/master tag: next-20220927

Hi Peng,

Thanks for your patch.

Tags are useful, but more accurate method is to use --base option of git 
format-patch.

This can inform others what base-commit was used. It is also useful when 
you have prerequisite patches.

Hope this helps.

Thanks,

Tanmay

>
> V7:
>   Per comments from Arnaud Pouliquen:
>     Typo fixes
>     Added A-b tag
>
> V6:
>   Rename rproc_firmware_recovery to rproc_boot_recovery
>   Drop the unlock/lock when do reproc_attach_recovery
>
> V5:
>   Rename RPROC_FEAT_ATTACH_RECOVERY to RPROC_FEAT_ATTACH_ON_RECOVERY
>   Add kerneldoc for rproc features
>   Change rproc_set_feature to return int type and add a max feature check
>   Use __rproc_detach and __rproc_attach when do attach recovery
>   https://patchwork.kernel.org/project/linux-remoteproc/cover/20220615032048.465486-1-peng.fan@oss.nxp.com/
>
> V4:
>    Based on Bjorn's comments on V2-2
>    Move the rproc_has_feature/rproc_set_feature to remoteproc_internal.h and
>   Keep rproc_features still in remoteproc.h, because we use
>   RPROC_MAX_FEATURES to declare bitmap.
>    Update commit log for patch 2/2, and add comments
>
>    https://patchwork.kernel.org/project/linux-remoteproc/cover/20220323034405.976643-1-peng.fan@oss.nxp.com/
>
> V3:
>   Resend the wrong labeled patchset
>   https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
>
>   Write a cover-letter
>   To i.MX8QM/QXP, they have a M4 core self-recovery capability without
>   Linux loading firmware. The self recovery is done by
>   SCU(System Control Unit). Current remoteproc framework only support Linux
>   help recovery remote processor(stop, loading firmware, start). This
>   patchset is support remote processor self recovery(attach recovery).
>
>   In order to avoid introducing a new variable(bool support_self_recovery),
>   patch 1 introduce a new function, rproc_has_feature to make code easy to
>   extend, cleaner, such as we could move "bool has_iommu" to
>   rproc_has_feature(rproc, RPROC_FEAT_IOMMU).
>
>   Patch 2 is introduce a new function rproc_attach_recovery for
>   self recovery, the original logic move to rproc_firmware_recovery meaning
>   needs linux to help recovery.
>
>   V2-version 2:
>   https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
>   Introduce rproc_has_feature
>
>   V2-version 1:
>   https://patchwork.kernel.org/project/linux-remoteproc/patch/20220126085120.3397450-1-peng.fan@oss.nxp.com/
>   Nothing change in V2.
>   Only move this patch out from
>   https://patchwork.kernel.org/project/linux-remoteproc/list/?series=604364
>
> Peng Fan (2):
>    remoteproc: introduce rproc features
>    remoteproc: support attach recovery after rproc crash
>
>   drivers/remoteproc/remoteproc_core.c     | 62 ++++++++++++++++--------
>   drivers/remoteproc/remoteproc_internal.h | 15 ++++++
>   include/linux/remoteproc.h               | 16 ++++++
>   3 files changed, 74 insertions(+), 19 deletions(-)
>
> --
> 2.37.1
>
