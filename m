Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77BF68AED7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 09:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjBEI0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 03:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBEI0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 03:26:12 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425D91CAFF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 00:26:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYFbe8UKnFTk7SOFQeanEbuTXRAEzPFaXNNjVxaBXmEY6Mv2Sea11OxxF7Tp4GH97q93y+2mOWRVVxUTeTazRjsN4gZGni2P4E5jjgr3ECadfT1GzbDFo2x7OSfCItSjlaN8gvQirM2u+8JgaP4HHb88mtdItA2YTSyJRh6fB9maWQoG0EPlMa9SMOT4n520n6D3+DDLwhU5V+GC2v3OcRJbW/+4DfApnPY4Ten76A6Sxzkby4Dc82hcAfjvlnEbCuapkUAAhJmiDSb+64ZZA/DPI5uj996l6ToY2bcXVHMjz4rc1M8rVAIUjdoGVc5gAts5skIGzGffvrHk3ZBvdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnWrbkOOeTsflN5uqObcSF0m3oM9rPoqajV80CSje98=;
 b=E4EIInWRKPvZ+UxUFCGzyv8r4pbjQMymMENLgZ4c+yaL5XgURV3qpzJnTWnrIgkgfZ+W1HeC8ST+uFKXApauUka30498hgckTLiqhpm35GY+t30izWldWaVSnThw7nh76XyUMhM9b8aNUCnWc6r5oCTcac/lzJUe6Dt7YRLLJAtARDFlChRl5fPe1kQQb8Tpm+P7lubGiB/VTg9eiGAz4hxoIycsnNsWSAtT0PAWH84DPtGlgV3RlLZXAR38DOJn4T6by8w4aWG7CwV1Pjrkc8z97bqPD+fOsIJHPoCKlYe2rU0oGl/OeQv+Vxt1AjpJFIbweYUg0nTRTF5FpyxEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnWrbkOOeTsflN5uqObcSF0m3oM9rPoqajV80CSje98=;
 b=QH3PNafOAF4y73reOXXsi/JxRW5pW5LB6BU/53TJ7kXH8lJ9l1zOj0RUkOEIPleA3HM8qz+EwhBbeZGGHnpZD4xkKy54rM8fXQ3qQbWI92SDlC7XZO/wNXh1uUt07jCOLcrWg2cILqmfOI+rLWta5317jImdADpiHgwOGwEQVW7zJgFM4UKqoHNVFaf0ICaa7jjB74w6Dl+GCxltPOl8aXTG/iQZejzZKC5jLBbXkamaKFrYJI1Oti4PG7bcGofYy9WX0vn3cDPMm7edazUT9IxrGoNF/hnGN4zbvsX648cozFFblFAOfC/zPp0LJUzK5BpGctLT4W7L4pavV0trbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Sun, 5 Feb
 2023 08:26:07 +0000
Received: from PH0PR12MB5401.namprd12.prod.outlook.com
 ([fe80::87e4:2a28:53f6:1b89]) by PH0PR12MB5401.namprd12.prod.outlook.com
 ([fe80::87e4:2a28:53f6:1b89%8]) with mapi id 15.20.6064.032; Sun, 5 Feb 2023
 08:26:07 +0000
Message-ID: <0f158916-aaab-0afd-6cd0-382f54ef26d9@nvidia.com>
Date:   Sun, 5 Feb 2023 10:26:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/6] vdpa: conditionally read STATUS in config space
To:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        jasowang@redhat.com, parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
 <1675400523-12519-3-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <1675400523-12519-3-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::11) To PH0PR12MB5401.namprd12.prod.outlook.com
 (2603:10b6:510:d4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5401:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: b4478b1e-4838-4240-7146-08db0752a0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7j/eeQKruH3xhe6n2zWzWBwZsMRSeNIx8xd/eppC6X7gPNwj+RoelNHXjakE2FmKGx7QJyknS9WQizItkoKzJdRg6RcSkSzCoGTbpSYaL0vSP0DHLuiMshpC9Ncld0cbyk9gh5PZzVVvfo/EImlhHPH/aykG9tHahrbbqkaeV3hh6Hvn7UewXVUQiq8IKdQRw9XI3L7c6zb5zS7Sq7O+h9I0RxeTPgTTnAJ0Iki+3CjeTOxJPJNr4vXmnUyrmu7uwqLv5/5fRbhTbmLLlLXTQ7xaA/+t/P1IQoQicjCoUsks5ssF9DrGB9lGbdVuywSVrrflUUH6zCNa+KKKbereR2E6ADEE5mhza1Rr/HlxH23p+7max42uAKjSL6OaYXvm4KSlfOHT+hr9uc9xiBg2i49y9gqyob3TTh3DDU4AfP6j0c9mH828UB6rx7c5fkmfWx54+9K5m77WrvJX/FN/vBMCOcG/xwR1s8JeKmt00hoT2YWuvpQN9MjHR5vnLx2l/TSqVCaf02bcO1nWDADs6UyC1pbSLkb7fCfTC3lOOz8NfToUMEHK9Qu2guK2Aab2y2id3eXHpS6kZcpB1VY2Nbz91Im4ClxU4tq+3CGc1vkHGHh0RqjSXUQeJ6+NTnex4XlwxCw5NcM3F6HiJIru1vTBeu9BW0dFowzM3eoDDi922/Mk6vGpTE7PdFUqgfWjLec9b3TU4s9CfggzmQJWwsy5ajhu1HLEcxOLDnOxo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199018)(478600001)(6486002)(2906002)(186003)(26005)(6512007)(66476007)(8936002)(8676002)(53546011)(6666004)(6506007)(41300700001)(66556008)(4326008)(66946007)(316002)(6636002)(5660300002)(38100700002)(31696002)(36756003)(86362001)(83380400001)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXltNE1vZGQ1dnBvNENWbXl5SUpNZDJNbTB1YTI3ditrN3NsMnpHS2MwNnpG?=
 =?utf-8?B?SGVSdnRBeVJ4MXdqSlVnSjdMeEllZEF4ai9SZEtnNFBpSnd3MUZUQmxNM0g4?=
 =?utf-8?B?ejEyK0c3NlpuN1dINzRQTWxaelVDSnlwdDJyWThXZzYvTUQ3UTMxYWhnU3NR?=
 =?utf-8?B?MGJ0b2lKdzY4S3VkTVgyWnZhV1dqRjNualcyUlAxSWJqQ0p3WUIzUlp0OVNN?=
 =?utf-8?B?U2JPa1p2bmNRVG5EYUVqOGNzVW5PUE9maXJwVHdVNkNWU3pGUVdRS3N3M1JH?=
 =?utf-8?B?MEs0QVEwWkJlUkNSOXVQL2JSN2FkZEl6dlZ2ajZaRDVhM08xZFVONmh4TVhP?=
 =?utf-8?B?OUlIVUNLdk15OUF3NHp1R3BVWUtLTzlaQzV2MnNUQW1pYk54djh0ZVhpaEdi?=
 =?utf-8?B?Zmdub3FVTi9yMExMMWQ4QnlTWnFIcWhyaFQ2Ni9rSnpORnZjQ0xpMUt4VEhF?=
 =?utf-8?B?WDI1MFZtblBEekVPZE9Vblg2L2ZxUi9wNkh4VFJZdllZbXNlamVQa00yZ240?=
 =?utf-8?B?NTNqMG15eEpQVHh5M2ZuVWlWMXFSRU9kRVdZYXlQckVLSUZ4REJHdTU5b29O?=
 =?utf-8?B?WDBFbFNxbDFBOTdZQU9lV0lXeCtKZ0hIaDdhcGw4VlpUVzBPaDhFbjUyWnVW?=
 =?utf-8?B?c1IyaHVoMlFlTTlhSnNzbTZkQlQySjFQcmhKdm1UR0lOOFBuYWRDQWJuRUw4?=
 =?utf-8?B?YXdEOXNEZ2VHdVdaUVFBVFp4c1ZBdnd5S29zMTdPaTRMWHpvalNNUWRiWWVB?=
 =?utf-8?B?cGkzaFVOQWxiQUZ2QU1lMXQ3NFlRbEFsRG5zRSttNDNjKzJack9YTklxL0I1?=
 =?utf-8?B?QS9kT1ZRTEI0cFVKSzBqMHlSS2gyWGVpM1ErbThkWEc2dDN5UlUzdGlZTng2?=
 =?utf-8?B?YmxXV2NIL2RyR0RLYjF3S0g3aTJDMklROS9pYk13WDVUZDZwYVo2ZGhTT1Yw?=
 =?utf-8?B?bEN2U0M3YzRTM05kZUNJbmE5MGZ3Y200dWJVSEdrUXNUa2lGRUpPZVZnMHFy?=
 =?utf-8?B?aHZyVUNISWJCeVd4TE53aXBQYVExa2hsNWYrWVJkc3MxKzd6RU5qeXluYUFR?=
 =?utf-8?B?MDhDK1JwYWxyOThGaDU0dEExMkdtWWNwTU9CRjhLdnJTcmRLT2I1Qmt2a3ZO?=
 =?utf-8?B?RkxOSXdHbEVXQlc5dG9RVHkzd1lJRTM0eUpFcnBzQnc1TXFndlJRSGtyRGwx?=
 =?utf-8?B?L2U4c2FjaSt6Q0NNTlNHY3huY0VXVkp1N1NTcmk2Uk44L1VXYTNhR2orOVNZ?=
 =?utf-8?B?SHFNUnRFbjU2Q3IvSThyaGhEdmxkUDdSdnR0WkdvK1I3dTY1ckpvUllqeUZm?=
 =?utf-8?B?R2pScmY3dVp3S2xFemdHYTVXRDFzVm81SWc5anNpc0JlbEo0ZGw2Y0ljRmdp?=
 =?utf-8?B?bXZBMmxESktFaWV2K1NETmpkNDdHM0tYOHJnbm8wU0MrWDllVWpORHIwM09o?=
 =?utf-8?B?M2FCci9sOFltdTNjOUtvMHpFMGg4cGNwN2VkN25PVTBocVpxVXVWTDVWK1hD?=
 =?utf-8?B?anFKZ0tPMTFNT0Jia2hpMDRvcGlhMGRaRFJteW5mUmxWeVB5R20xRG8zVlpD?=
 =?utf-8?B?VW1wcWU3N2UrQmNvd3JqbUFyMlhQT1JxTWNuVEdaTGpJYS9kRWJiUGJsMG1G?=
 =?utf-8?B?T3gwOFgvQVZlZHQ2Mmo2dkZRUVRFT2VzMFpxMXkwNmg5dXVUZDhWaVcxVzVI?=
 =?utf-8?B?WnFZRFM5ZjlremlRdEJHcS9tdmg1eS9vUzVULzhqREJCYjVCZ1Fac3JiZkdI?=
 =?utf-8?B?enQwbVVnVnFsOGZEKzBncDJDa1dpYm9jN0I1OGdSQ3V6dmhvbDJuRUhCTGxB?=
 =?utf-8?B?MTlZdVNNaDdmTFJ1NVZYMTVBVE9zdU41bTRXa1JjaTQwb0I1YkE4alpXcmMw?=
 =?utf-8?B?ODVkMVIrazdzakpiUm9CcEVJVjRPV0ZlTWhBL2hhVEtUM1BMUktuelNGQnE3?=
 =?utf-8?B?bG9qQnR0Q2ZKM0VGNjU4M1A4dXM5b0VFa2tzTnVxWHVyTHJtMHk3MVdvTkcx?=
 =?utf-8?B?YlB6K1JsYUg0YmdjZnVIQlpFaTRxbm85VzdxdUZOTWZKYVhPRHlyaGM3aVpU?=
 =?utf-8?B?UHRlM2Q3MUZXV1huS2RhRXE2aXFwdnJjWm9FWmozdlgxT2l5U3RheW1oSlZR?=
 =?utf-8?Q?FwduRUEKiz8Yc0frJF298Enl3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4478b1e-4838-4240-7146-08db0752a0fc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2023 08:26:07.5167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/Tway1CX077VClOVZAsOhWb30svhjtfp3ad9bpcKUVM0Zg6yH856MQR/pEYDibi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/02/2023 7:01, Si-Wei Liu wrote:
> The spec says:
>      status only exists if VIRTIO_NET_F_STATUS is set
>
> Similar to MAC and MTU, vdpa_dev_net_config_fill() should read
> STATUS conditionally depending on the feature bits.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 3a82ca78..21c8aa3 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -843,18 +843,25 @@ static int vdpa_dev_net_mac_config_fill(struct sk_buff *msg, u64 features,
>   			sizeof(config->mac), config->mac);
>   }
>   
> +static int vdpa_dev_net_status_config_fill(struct sk_buff *msg, u64 features,
> +					   const struct virtio_net_config *config)
> +{
> +	u16 val_u16;
> +
> +	if ((features & BIT_ULL(VIRTIO_NET_F_STATUS)) == 0)
> +		return 0;
Instead of returning 0 here, it would be better to explicitly put 0 in 
the message field for

VDPA_ATTR_DEV_NET_STATUS

> +
> +	val_u16 = __virtio16_to_cpu(true, config->status);
> +	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
> +}
> +
>   static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
>   {
>   	struct virtio_net_config config = {};
>   	u64 features_device;
> -	u16 val_u16;
>   
>   	vdev->config->get_config(vdev, 0, &config, sizeof(config));
>   
> -	val_u16 = __virtio16_to_cpu(true, config.status);
> -	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
> -		return -EMSGSIZE;
> -
>   	features_device = vdev->config->get_device_features(vdev);
>   
>   	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES, features_device,
> @@ -867,6 +874,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>   	if (vdpa_dev_net_mac_config_fill(msg, features_device, &config))
>   		return -EMSGSIZE;
>   
> +	if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
> +		return -EMSGSIZE;
> +
>   	return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
>   }
>   
