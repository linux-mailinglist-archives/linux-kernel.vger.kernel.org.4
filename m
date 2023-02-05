Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE62768AEDC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 09:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBEIcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 03:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBEIcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 03:32:02 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFFC1CAFF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 00:32:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCOkb4kzo2BYxk5U7yCaX17yaZ8Pr6INWQ8+m2kHRms9MiK1Hld9umTtbAfEttYG4dQexOxuC+XBdQ18CKmFd8jshf9VuM/vYzftvNf87coAbiPr9KRBkCg1khGyT42E14egHooO/zweTjgTo/HamLjMacKb8yZxKEY4wpQKxsaNdPei+BnRRS7iuyM1m2Ln6Oi60aHUW+BGP7NtBlH4PIDuv1Jz5Z3QzLhSikhkpVitRZFNA4gmfPIQxysiAHof2QmWnOC8mc7ahvNE5iyOE8UotozIeayoKdn4lVRO9w4V6Qn60qoGKKDhmWZbkUQIZpEl2xKEgpu5ncGgQmg/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSmbY/1OUBReNxMI4Z2xlOcDSlaaMVXW6reHT9WAw3g=;
 b=hUqW4/MT3WlzWeIAn8XVfVa9ciDDizKp6CiTDUxe13lw2v9R8oYCs8a7WV6YCvq8MramaVbPS+sXONh7xMyrxqXZEEk09BraTxhqaJMeCfkYAfsronZrd3yUZ9N1tFsvtiX+IW4eA7gwJdOkF7+yMQqJJ6/Eiko+ZvEythTpAiGWh8JJuAQwzrx5eRIAH9R/8gCYPSktYNlDaIzR6ZkX95SvUBeJpT4Wx7sG2M85H5M14PZcVrkfS6nZkEi5dsguqzy9l6DBz+5zG3UZUAayB3/JMIlfQBy+TqFPxx7JVFTiU2k9CEjVFccG+8SpZzLSmN06p/8zyQnqPTPKKmwbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSmbY/1OUBReNxMI4Z2xlOcDSlaaMVXW6reHT9WAw3g=;
 b=jtnbUP34J16ESJhIwAkZwqbidhVBP+0jla9Sq7hwpsLeWpZ/sRmyPIVS+IovkVLu7Z1BjM/XGwv11oB37ABFRyAcfkrxxUhjJPuJe1fCoIKDbSsYE3rt8KQ9lALtT4xLWbMXu7V6eEIgk0PGcTiLuQG1EMU9HFNhx+O0Nd2Sjb496zUe0AkdEtJwR4qpLnEpVlIiVzZTud5kmx4SsyPXp7r4XHtseqM3xbk9KKP+B7a0s1jwxYTTryQdaU2u4wSlk+ySFyUK4A0o8zqYdDK7wI0KjvM3OzDyZGt0gnO3gcaukOARaUWbsaByuxJZoE3t2nHZm77RUXpH6Wtcy+cVjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Sun, 5 Feb
 2023 08:31:58 +0000
Received: from PH0PR12MB5401.namprd12.prod.outlook.com
 ([fe80::87e4:2a28:53f6:1b89]) by PH0PR12MB5401.namprd12.prod.outlook.com
 ([fe80::87e4:2a28:53f6:1b89%8]) with mapi id 15.20.6064.032; Sun, 5 Feb 2023
 08:31:57 +0000
Message-ID: <dc790c21-ae7c-cc5c-fa9f-a9c107025cbe@nvidia.com>
Date:   Sun, 5 Feb 2023 10:31:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 3/6] vdpa: validate provisioned device features against
 specified attribute
Content-Language: en-US
To:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        jasowang@redhat.com, parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
 <1675400523-12519-4-git-send-email-si-wei.liu@oracle.com>
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <1675400523-12519-4-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::16) To PH0PR12MB5401.namprd12.prod.outlook.com
 (2603:10b6:510:d4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5401:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: bbce222e-547e-4a68-ae83-08db075371af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKRFKv30XWvS+Fk7qf4+Hdm0gzbftgnkHSv12NHCDmzAmJBtvUzGoEBZbwgGR2ciOSZDdEIWAA7zLQFSHKMPGwm4v06DNqjmMMCU5ocYYQT0N3CfWL4gjVr0D4vAMuO2G01GB9dhtiWDRFDmv6EMZUFTYbn49qtolnFmXGhLelOz1FLRsqEBlwnqCwoQYaXLaFkwpnnmXjqEtYnxA2qs/DTaVV6fKm/5+t+ckjMKsE3LQ9fQ1a4a5gt9cRZudm0satcdJeg+GD5tZEt36d8JPeEJG7d8A8g+/hFHErxXxt+8pSr8XjpKyzSlnlpv2+Ub65tVd8yzjvuFeY9oWsL3ol0PnlK9wjS+FQ4YybQV8s2+2qU8XC835X3roWlwKU9XpwTMQ4hdLorQEWIBEhAlwNjjaXZ1/lesQPoItU1V+a9hMTYDwzHTtPBFHJIqLqBx1n8tGEMpmYfgiT/TIAnVhSQuc+njUfV8v1BPC9FnN30iafREGIjxAuS+vAqi/F/rzQrhv/XeoomAfkBHNMwKW341q6UXEc1hGBDTBR4gCHcnMSs4Osab05/JebCDmzeg+oF0nOClUl3Ap9sGVRRcttIeA3i3lb0+eoPBmmoVl0Xy5gnarFzDk6h7ohFIY6M5nU4EmGI8h7a3000KePkP0NgCV8NB4t1Q4j7/GOl2hNMWzxmcoQkbFNIL9forCZjS1gI0Tc1ecd/alzwfJDQ+SC3L+pqj+RNwSTGtD2Jya7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199018)(6666004)(53546011)(6486002)(6506007)(478600001)(2616005)(26005)(186003)(6512007)(4326008)(8676002)(66946007)(66476007)(66556008)(316002)(6636002)(36756003)(86362001)(31696002)(38100700002)(5660300002)(41300700001)(8936002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzNhOGMwMWVGNTUwZEJ4djNvbVJtVGFNbG1XV1JsYm5QVGV2WEFMTUNTT1Ru?=
 =?utf-8?B?NzlJREIvYmxobHBvNDJ2SjltdHF4b3VMa3JaODUralI1Y1JKL1A5TFhhRlI1?=
 =?utf-8?B?QnNOTHdLQzNTS3cyd25GS2JpdnMyQlVVa21iQ2dyamJDdjE2UTh4TFcwN0dx?=
 =?utf-8?B?TjJvZ2VtcCtHWjltaldaaHprRUdMekRwWUdqNGV2VXBtMG13aXlYeU9ZTVUv?=
 =?utf-8?B?ME5aV241RWZpNHc2bkNNN1VZeW1yN1dYYm11SG5xaFIvZEFUS2ZqcmxiYXAw?=
 =?utf-8?B?dXJNb0JCY3RnRElEWFNZV3RvcjdoTTQrenowdDJpUWx2ODVKYWRhcnlTSzND?=
 =?utf-8?B?NXlUQmlmUUZVVjVOSy9aZVJ2dlZ6bzE1NHJUNVBQWnJCeklsWEhVV0RBYnNv?=
 =?utf-8?B?VWZ5VU5GUjRhcnJGMUJvU0NIUjlzMDlhZ3pmOTB3RkwxdkdVajlCVjNDQitH?=
 =?utf-8?B?RHB4d1FkUERmSHlqckUrR2xFSmFDMGp6aFZsQytaYUM2Rzg2cWpDMXMvMFAr?=
 =?utf-8?B?ZlZTQ2NoaVEwa3NiR08rUUxFR21mclhGOEg5V0g1VlZyd3hGYTJDUlpjVXpk?=
 =?utf-8?B?dGVVdkxYdVRybjR4N2JwQXhLeUVlSFNCdVViZFd2M2VsS2FwSU9oTlNBUCsw?=
 =?utf-8?B?SWlPR2w1d0piM0piaTBMWENSdmk4K01pSHVzY0VwUVg5M3lFWW5zM1hTM1or?=
 =?utf-8?B?UTF6M2Q0NnBvVEg5aml2NXBkOHVlcy9mN0RzVll1bm1lWHgyNXlQWWk4bTVq?=
 =?utf-8?B?OERNZ1JvSjBQUU1pWU5hWEgzOEo5a1hBR1JkZVdNaVBwZnpnTEErMHYybnNw?=
 =?utf-8?B?aDl5YWtwSzQydlR2cjdFNmlDZkxLL2Z4djBaNHZidm4rRklpQ1JmOGFWZlY5?=
 =?utf-8?B?TnEveDhJc2Y1SHNydlVQQUo1VVVsSHFpQXA2ZEdiRy9QSEluZ3UwWERMU1Qw?=
 =?utf-8?B?eEp0MjZDTytuakQ3TDFZaTE4WkpqV0JzdzIzRjVzMFB0aUdxbmVBL1NsWmc4?=
 =?utf-8?B?SXpQZ0s2NXp3U2ZybUhDN1NOYTJxR1RDWU9zOGJxZUdzNUt5SEJ6cUFzdnk0?=
 =?utf-8?B?aDN1V0Y4Ymo5bVVhdXU1ay9CL0t5Uno3dmRnL1RmeE5qQ3dQYmM1S0hkaUhG?=
 =?utf-8?B?bEVuUFovYUI2UmJZazl2VTNRNUcvc0VYNDJ2bWptYVRoSWZ2M0FOSXVZdEJB?=
 =?utf-8?B?anQyMXlaVTlZNlk0REFxaTA1S2trRXpNaTVPOU9sdExDUDhmZzEvcURHZStT?=
 =?utf-8?B?Vkt3RnZVYjhKMXZrSlBiV040QnUwcVUzV2N1SEdXMkw3NDZCeEVBQmlFemZW?=
 =?utf-8?B?eXhjcG5iZjl1eGJXU3lYMWtvWndaZmt2bkplWjVTNFdGRWppVGszbVBodzNh?=
 =?utf-8?B?OS9sc1N0SjhZazRibXNMT1c3cmExTDFkWmdoMkxHSzMrYzN0ZDlRZDhXLzBy?=
 =?utf-8?B?bzhrem1LYlAxNUxSS20vNTBqenp0M0p0MTAzeUl0Ri9NWXJ2RXZjVzkrMC9w?=
 =?utf-8?B?VXVCcHhZR3g5OHBRZVJTWkIyNkQvbGFqblcvYUN5OENUZzJPYW9YSjdGZXpw?=
 =?utf-8?B?cE9HaUQ1cEZYQ25jS2llUG15amtqaWp6VnBPT3lwdG1RMTAxdFVuQmgzL3Fp?=
 =?utf-8?B?NWhkZlk5TUhWUUhXUFMzaDNGejFkTjgyUm5TOVNnUnR1N3RQNktiUUxmek0z?=
 =?utf-8?B?MTFhbUpOY1RscXovenVJblNseU1va0VmZG1pajdxWkNSQkZJbnhYUGJ3bFRp?=
 =?utf-8?B?TG1DVWkvc0VCelcyUjFKNnNOVUNGQU4vMWJmSmoxV0c2MXUxZjBUZ2YzMG1l?=
 =?utf-8?B?ajZWNVU1c3pSZExwcC9SeXNWNzdieCtDRnEwTjRLOUVsZFR3STlRN0pBaFZK?=
 =?utf-8?B?UDVXL0NZSEo0eDJ4K3ZTSXhyVERvNUVqL3RzZ29xZTMwWmg1WlRiRXVYa2Zt?=
 =?utf-8?B?QklOTDdaMHFnQlRCWG1yNjhEUm41MGVkUG5lN241bkxqTUhKNFNwZDErSmdw?=
 =?utf-8?B?bDlsVHp3RDVrenVGS2Ixd1RibklzMlhrUUIwYVNlNDN3ZHd5eUR0SFcxOW5J?=
 =?utf-8?B?citKdHcwLzN1QSs1bHF1cnA4UERxRjZzc1F6L3JXVkRoQTRHL1hBQjh2SU1o?=
 =?utf-8?Q?765mK3yrASh5nMkVPjl3xXwBT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbce222e-547e-4a68-ae83-08db075371af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2023 08:31:57.6731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ad9iMuv9Jq9RDLgwU6bbrje0q3rjB+eahEEqR9WU1nkz7N57tMdOMW/EbGqEdyaT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/02/2023 7:02, Si-Wei Liu wrote:
> With device feature provisioning, there's a chance for misconfiguration
> that the vdpa feature attribute supplied in 'vdpa dev add' command doesn't
> get selected on the device_features to be provisioned. For instance, when
> a @mac attribute is specified, the corresponding feature bit _F_MAC in
> device_features should be set for consistency. If there's conflict on
> provisioned features against the attribute, it should be treated as an
> error to fail the ambiguous command. Noted the opposite is not
> necessarily true, for e.g. it's okay to have _F_MAC set in device_features
> without providing a corresponding @mac attribute, in which case the vdpa
> vendor driver could load certain default value for attribute that is not
> explicitly specified.
>
> Generalize this check in vdpa core so that there's no duplicate code in
> each vendor driver.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 21c8aa3..1eba978 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -601,8 +601,26 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>   		config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
>   	}
>   	if (nl_attrs[VDPA_ATTR_DEV_FEATURES]) {
> +		u64 missing = 0x0ULL;
> +
>   		config.device_features =
>   			nla_get_u64(nl_attrs[VDPA_ATTR_DEV_FEATURES]);
> +		if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR] &&
> +		    !(config.device_features & BIT_ULL(VIRTIO_NET_F_MAC)))
> +			missing |= BIT_ULL(VIRTIO_NET_F_MAC);
> +		if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU] &&
> +		    !(config.device_features & BIT_ULL(VIRTIO_NET_F_MTU)))
> +			missing |= BIT_ULL(VIRTIO_NET_F_MTU);
> +		if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP] &&
> +		    config.net.max_vq_pairs > 1 &&
> +		    !(config.device_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> +			missing |= BIT_ULL(VIRTIO_NET_F_MQ);
> +		if (missing) {
> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +					       "Missing features 0x%llx for provided attributes",
> +					       missing);
> +			return -EINVAL;
> +		}
>   		config.mask |= BIT_ULL(VDPA_ATTR_DEV_FEATURES);
>   	}
>   
