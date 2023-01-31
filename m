Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C44F682BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjAaLnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjAaLnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:43:09 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D3BBB92
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:43:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOcO4xpq+9oGZGZNMEo8aYDlnwrh9aaZAzuEPJKx6I2COOWNgbGwN8ajUx4PMFT/QxCHqDOlVEUXG+0cv07g9vIc3/q0FcCSUo+294TTdOXZLdDyVPMaIwvFLz6TpzBKYPdDt3Fgpe0PNZJHYdOPnFVlJ86kPexTVx4ubQX5wL7DIbaL1omNHkVXgx5Bqnm5casMcCiQ6itSUz9dqXjM2FHwQSNj/qEEtBYEBBp8A27rryyaM5Y70cX55ikm6xueYCPSiVD9xGWS5J+bdX2oFRAAc/bpORO5/VQ4KqBJoDRY0/KcsFvSym2xj26cer5IvhkugnZuEvo8oBxNz8nrug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ou1AyGEJ96Ks77k2YJ9QWwcEHXfYk+Cl5COsk4SKwPw=;
 b=lwhw9RW4k9Egp6TO6IrQQ05GRFUFAwlU9CTEZDJZ8j8vX+asNqGVd/S4U4P4mh6645Z8z+Knsy7W+0fF9LKzL5r21PzktHiCcOa7V1xbPIOncOqk4ln4n24WJUNXyVkgbsc3drx/VO19Z8lPmvxBD8Ya/xtRb/OF+45tsfzpGFvQtnsmBzDONi2VDQwGREXT6IzPAl8oxKsMN0Gb+bmFCoewatgShbtT9YSQZ58TYOXAGjp5VJorBkzBCuDAAN5/SVeAS8D+TMBWFHzXTaxitmWmcMv51edvubbnDwSamZ1UsNJuzR7DAAmbtSD7HdM0HxCQEjb8Cb3Hkeun6U58FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou1AyGEJ96Ks77k2YJ9QWwcEHXfYk+Cl5COsk4SKwPw=;
 b=f5MxFAX2cPr936bbtb23R66Jm2oX6K27qkhoHxwmCVEjtXzHD+/XNXyGcij9Avms6wgsG5vo20Q/cT8nledZIGaSZDLhM2sQvXkZYxHFgNFfM6qjqZ+WHxZ4NsYcZrYKa+WVbDFQoF0d0a1kozSEFpujwl6R6AjEPjQkKNOua2hTJ7Nzc3bi4H1GUJTPc42dxAXT1A5/fcurJjaSEvs2DwNlLNz0O3YoHcmii+oxghchDjkV8J3N4wB8hdQ3B0U5SNDQax7vkBf2o+MTnmDblEVO6hcdOGgzrIxfj4WuebdgfdvrEeqFLTQOnujAN19HMABtvM/7C6dT9AQIIsY0MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 SA3PR12MB7922.namprd12.prod.outlook.com (2603:10b6:806:314::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 11:42:59 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358%7]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 11:42:59 +0000
Message-ID: <07f5a4cb-2a55-c774-6b23-d3fa6605cb43@nvidia.com>
Date:   Tue, 31 Jan 2023 13:42:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/6] vdpa: fix improper error message when adding vdpa dev
To:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        jasowang@redhat.com, parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675110643-28143-1-git-send-email-si-wei.liu@oracle.com>
 <1675110643-28143-2-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <1675110643-28143-2-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::9) To DM8PR12MB5400.namprd12.prod.outlook.com
 (2603:10b6:8:3b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:EE_|SA3PR12MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fad7ad6-9d99-45fd-f498-08db03804d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yD2JBtTnPTOGK5Vhz5YLJ8E4NHdaVCwuHJk8TBzDM1awGqc0x+E87e5TzapBdxZ4dgNu7r7z11ltakWmIsomQ3VKSxXyZ6ZY2PFD1FF9TFfD1MC7OyzU2RAnYuOWOIROMR/2XlxtrP8hl/MmNEUyvFvpLrELn+1yJKCqxpGF3xe3HRohRzlRLf6s5W/uA8lTWQ4wZLSCnUnfDVEUBBEAYYo/lSUyQQ8kCw+XFlRRZrJw+GNzn7DsqwGdGVTnvhIbte5Bd/dlwEJ2FdZ6OQGHRBq1qtV5POFaWCNtMy7tR5daKC4il+PgmRVEvHdCwF+xrHxkhk8NgfF/2y4vG7sOqoIvU8yXmvvz8iIjqw1oAnH05niARzPiTqRt4w4IanohjqnnLLxxSC7Au3z7a8301laUzAgh6+z6/ZzScNUO0faF3i7Y+BVqHBj/FaeW3uOs3T5BF4ige15YRQYTTXrpuTsLfiUOmTTQ1B12+wVngkMBHL5XZk5P4yyW3Rts+rEMchBTG+P6BrJhRKTAs+f0xmc2RZaUhEsClc4uHRqF5T63or+wg7p2bFN6adfF3gf0oYe0Dez5giu754NGyQEETH1rhL6ifysiMWGBoe/LOQ3JZAp+QC0YbF+ppMSzU1Kk/1NwA4JLVJ0U5UBwbs0aQG1dIadXynPwwnclbHT6wHybe20XhBad+vvkdX8pj4S9VrkrddYK2+Pu25ZB/0Aj/EbE/Y/fsxmUd1/xEOIRbbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199018)(36756003)(31686004)(478600001)(41300700001)(6486002)(6666004)(6636002)(15650500001)(2906002)(38100700002)(86362001)(31696002)(8676002)(6506007)(53546011)(316002)(186003)(4326008)(66946007)(26005)(8936002)(5660300002)(2616005)(6512007)(66556008)(66476007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm4veWRCdXFLRTZvOG9SL3RJckxYTXNQVjNzV2RsVXhTL2JQYkJvRURSQXZp?=
 =?utf-8?B?d1E2SWNMTHp2L1pSSHdBc1g0R0RMc1ZVdFdXaVlTM2g1dmJGMmFZT0o2N2lt?=
 =?utf-8?B?NktwSDdXMmpSTWcwYnQ4QzdHS2R6NmNWRzczZkZ0VEJJZEF4T0ViZ2dwTGti?=
 =?utf-8?B?cFFlcks2a0IyenZBWDZ0QUpHWjVkUWtWMklrRGFpTE1JZFdlekJwOXpmVWIw?=
 =?utf-8?B?VWhheENKSTladVhqZlo3SWVwekkrdnR0dVFIWkFnMlJCbFNDMHdyVDFpazJv?=
 =?utf-8?B?L0VyQ3luZXZjOW9pYmdESC8ydGxNc0N3SFk5NTRJTEFWT01OdmZTU2FrVk1a?=
 =?utf-8?B?aDdvY2lDaHkxNG54WTlxMUVjNVBKWHoralc2dEtqOWpySkhWbXRVdWMxTFpi?=
 =?utf-8?B?K2tMY0UwaHRNZU1GK0FYYTlWRjFkS3hYd0I1YWVKNmExZ2h5VXF3cmVvT2Iy?=
 =?utf-8?B?S3hvVkV5V2pRUDNoWjI1SWNtN3RNeVg4Q1B3Y01ReTNIZ2laVTdmZXBPTG1k?=
 =?utf-8?B?TGlyNFhPYWhrRjhiQzBlYXg4Q09tNGhZTmNFN1REMnc5WHNzaS9IajRmaHcy?=
 =?utf-8?B?M1FLL2RFMTd1NTNoU3FrYU1MKzlPeGtmOHI0c3RIdFRBdjY0d29GVnVNbkJr?=
 =?utf-8?B?alRPMWtoNUhMRmRhakJyMVRWeHRnZ3cwQk5OQ1V1cnF3SDliazJQZ0pLb3Zw?=
 =?utf-8?B?NU1rSjBvWDdoNEFBZTdFdGRFS2FJRXQ1bCtzV2ZSQTdCMEwzRjhYamNPVndo?=
 =?utf-8?B?NnczNVNHZlZ1dmd5dkZXRTFCejBxcWpiTzROVTBjN25YQ1pjTTQ0TmRnYlh3?=
 =?utf-8?B?UGl5bzhKWUp0UVdqUXFvR3NkVldxTVdpTWhkdHgwdUVtYXBkbG9sNU9TYUJv?=
 =?utf-8?B?eXhaaWs5NHFlTy9FenZCUFdQTEZaZGM3VlNJaHdxb0VGOUpxVkRTMUdjVVQz?=
 =?utf-8?B?ckszcW53VTlVam1MdmF0VUNjdmR4cmVqNXF6MmFxc1pveGp6eVdOU09RNE9h?=
 =?utf-8?B?OC9DVzFzemJnTFBLcDJoVHZ4THFkbmtubDhMWnBySlpjMlNFbVBoSG1ienVV?=
 =?utf-8?B?bTNFanFyM0R5amdxTG9KQ2xwTGM4U3phdXNLSW1KQmdDejdNaGxGUS9SMVBa?=
 =?utf-8?B?K1JDRGlpV0xBN09lemN4TmpRTXFKOXFycVdwMFo1NnUwMnh4WEZCUndHci9F?=
 =?utf-8?B?L3J0enZRYzVTdENNU1M5UkNXOUN4RE5OOUFhUVYwWU04VkczaTZUWXlFOHpi?=
 =?utf-8?B?MDlDUkNLSTR1eXVuUTQ2OEdKcjh1UGM3eTQwYkZ3a1ZsMmE3N09JY3c5K25H?=
 =?utf-8?B?RHBGVVJCc0p4Y3BOVk5rQ0UxUzBLK2l5YjVZYUVSbnB0cEF3SjRjRG1wQXk5?=
 =?utf-8?B?eVhRT3JGRmRlTnVMQzFTVG5PWnZoS3JISmI2djl4eHZGbnI2TkVCUFVIMDdq?=
 =?utf-8?B?U1FCY0VQN3ZMYlRiWnR4ZXd5bzZTMDEzN1NiUi9vamV0ZmxGQldKMnRJQ0Jl?=
 =?utf-8?B?VjBrNkIxL1d4MmYydFZYODR3RnJmNGhJV0xjR0pnVkxqN2FZemlRc1hSYzgx?=
 =?utf-8?B?KzJsdVNsZUdZclB2ODBqY0FFaEJ1ZHdxdyt0elJ3NTk5RFhvMG9jUUNTTTds?=
 =?utf-8?B?Ly9lNkwxbWVQMVhZQ3JYeUZMY2MrMC9vd1RlZ05LM3JTVlc2Z2dVajdUOS9W?=
 =?utf-8?B?bk9GZjVFMkE3Qm1kZThwVU5HRzFIdHo5S0JQaXZ1TkpCdXRsUzIvQm8wRm5i?=
 =?utf-8?B?ZnFnQ0RkTTlDNlV1RFdyU2k2dS84dTFLSmVpKzAvRXd0U1orY050NDNwNTNq?=
 =?utf-8?B?cEhWU1BXeUZmcWllamcwb1pORGUwT1B6QXlKN3FoQTliZlkyMGsvRkthd1Vk?=
 =?utf-8?B?VXdNM3JiZlY4L04yYjd6ekw1M1dOSkFBLzA4WFdDWmhTOFdQY1o3UkU4eGc0?=
 =?utf-8?B?a1ZldHlGdTE4V000QXRFRW9FbmV0SnVBZ2dpNzFzQ09GRTdjMzhkSWNLaHJ3?=
 =?utf-8?B?Q3RyM004VHBGeFprT2YzNXp0Q0pKWTZvYjJoNVUyeUltTFJWK2RWeFFvMGhF?=
 =?utf-8?B?Rno1aFBHZENIa0NQdStwaUlVTk1XM3UyNDhqU2RhSktEQmxOZTRVMUh0T3pk?=
 =?utf-8?Q?Aqaprv67jduU27+r+FI6UaG5K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fad7ad6-9d99-45fd-f498-08db03804d58
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 11:42:59.7669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGnXk7hcg497Hbc7kDtT4IHYI8zx/8BpuFlKCnTUjkZUCeQSgRWx1gSWPL9i/R+0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/01/2023 22:30, Si-Wei Liu wrote:
> In below example, before the fix, mtu attribute is supported
> by the parent mgmtdev, but the error message showing "All
> provided are not supported" is just misleading.
>
> $ vdpa mgmtdev show
> vdpasim_net:
>    supported_classes net
>    max_supported_vqs 3
>    dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>
> $ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
> Error: vdpa: All provided attributes are not supported.
> kernel answers: Operation not supported
>
> After fix, the relevant error message will be like:
>
> $ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
> Error: vdpa: Some provided attributes are not supported.
> kernel answers: Operation not supported
>
> $ vdpa dev add mgmtdev vdpasim_net name vdpasim0 max_vqp 2
> Error: vdpa: All provided attributes are not supported.
> kernel answers: Operation not supported
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>   drivers/vdpa/vdpa.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 8ef7aa1..5e57935 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -622,13 +622,20 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>   		err = PTR_ERR(mdev);
>   		goto err;
>   	}
> -	if ((config.mask & mdev->config_attr_mask) != config.mask) {
> +	if (config.mask && (config.mask & mdev->config_attr_mask) == 0) {
If config.mask is zero than the condition is false even without the 
change so I don't see why is this change needed.
>   		NL_SET_ERR_MSG_MOD(info->extack,
>   				   "All provided attributes are not supported");
>   		err = -EOPNOTSUPP;
>   		goto err;
>   	}
>   
> +	if ((config.mask & mdev->config_attr_mask) != config.mask) {
> +		NL_SET_ERR_MSG_MOD(info->extack,
> +				   "Some provided attributes are not supported");
Changing the message is needed but maybe list the attributes that were 
specified but are not supported?
> +		err = -EOPNOTSUPP;
> +		goto err;
> +	}
> +
>   	err = mdev->ops->dev_add(mdev, name, &config);
>   err:
>   	up_write(&vdpa_dev_lock);
