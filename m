Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F8B682C71
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjAaMSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjAaMS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:18:29 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767B524493
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:18:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U71nGS5Le1La/1jh+zF6O0V7/qSF5FCaXvPIMoBJw60icdQ+SIk9t9S8K9OMnbs2fdk+Z1k7v7pj+EkWqCVzeAzuhLF6ZYpzrYZ6bltm6HQDxbPeXN+kBmNx3qGMRPD9US0dWLEAGwxbHZ0AgO/StCEWD2qJSK5jYk3U6pWLvZwtKsO5Oe+xAd54NT8eW0rKNcCG5GVpd2XhlbTdn/PCuwvgHm4RPrRSPa88F0eZN1djCv2ORLJwuRgehg1sZ27HJgwijbGlhqH/UFGHkw+ligqtiG22vmVnn21UAbbwXImUnMM7tJoVQgT5jcztQZsHBLRq/OrfCCYsdBKO4lEMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGWlPZ8+y4mbkKMFJ15uLMe/GwkTJwSMSz/YKhBtITs=;
 b=JSbJ0HKp3VO7uLXSjBVGpja6iBS7+yaja8e1cQuGeIBu9ukfcqHZT+smn4IMRV5oMNqe6GELRxtduXYUwkbMQKNNMZ1FOgveFZNhlLyX2b5iHHYaiAawuaQUvM3ZqicgWNYk0OUDlHvtRouYP6prlTqmSD5smywlW7+spoVvnIyOLzLGJJYX2y2AmvPfIcRN0suG/9Lsh/hBAH/u5TKwoWRf1qJN8kCoZ8rwv/mEVVSwVv6L3U3sePwPL55iTwORZ9ibw7GcejyStKWc3Yl7tHw6HlRq2uWE+AQG153jisnlVpNfvKgCY1LzvF1u8ejhKar6jRodCJEUiVg7JyOJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGWlPZ8+y4mbkKMFJ15uLMe/GwkTJwSMSz/YKhBtITs=;
 b=I1u7YBMYcx5/b8gYB2uwNE5L5gyTKmu0SAY2Nv+bnyX0gAJu8jF7L/zX2xCXAJGpX8PElicUZvqbPgqbz3VTZgQTBgKqhb5Mk4vNiH24qgEWI+CCrUP4fbdGXNFchUfN4eowG/EBheyzQFuHzYUcclc+FJqwBHzjPEtec4RmZYREyWcCSzLo2G8SBS26Iog3SXU47xU7EwpLotyoCLbvBLcDGUnASzmd2SMMiduAI1m65p/xt0bVaVfKM9deCUIqgzx7aGLRxZuD1b7B4aRsfviaVwBX1gLnPFyszcYblZ50mVtaP+g+3f035BAsjDs4KRxqxw04GPdXRuL1ogup2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 PH7PR12MB6906.namprd12.prod.outlook.com (2603:10b6:510:1b8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.38; Tue, 31 Jan 2023 12:18:06 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358%7]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 12:18:06 +0000
Message-ID: <6edac894-b660-d8f9-9d21-25746c5109b2@nvidia.com>
Date:   Tue, 31 Jan 2023 14:17:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/6] vdpa: validate provisioned device features against
 specified attribute
Content-Language: en-US
To:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        jasowang@redhat.com, parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675110643-28143-1-git-send-email-si-wei.liu@oracle.com>
 <1675110643-28143-4-git-send-email-si-wei.liu@oracle.com>
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <1675110643-28143-4-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0255.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::8) To DM8PR12MB5400.namprd12.prod.outlook.com
 (2603:10b6:8:3b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:EE_|PH7PR12MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 021ab7ca-3a57-40c7-70e1-08db03853540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuyZ+7hKE/94hLPyvCr0UBLKkKHDnypaV13BhqVqIdzfvHhGl9PM5/ZjBF6k/OrQsJpu5g+Y5mkPxK1JA42omRGnQSKJai8hgwpmsjXRHDCnCVEHoj2FlZw1ENe/sFzjxvM2+Bgi4MDP8FuXx61c2yU/46YcGwDu/SvaCtiLF9fv4ELXZwrDRq+WseSLF0Bq4TBDxE6ZT1RdOc04ln+YsQXhW4QNzS5AbTWajez0c6AWsYamegk0i231FlNOO4/251BR878PVkqPr3meAcEBbGqYItF4vG6R/DYBKVPn7GGkIh6d24M+i04RsuYgTRFOeTPZT7wFu2fMLZXs4CBmEVgNMQOfGxY7ECMMoVcuHzo/P6tx/IkfkTQRDZ+WKqokABSLsrYvaXO3uIxV+cU2mRpTu/8E40ry5b0ekyCvKWwI9sfwdMvNRHiXnhkV3L7+0gss7NE74dUO+wGer1p7NR4pP7awJbIrzVeeT+nmJhGEW6OQ8d46W2S0jVriRBERiDNYHUJ6sM0gNk7Pc9vNicmqrBrZrotJeFwHdsmuRQvQIZftXmzmDw3uNcnKCSuqbIaV+ZemkuTQTy5XKmiYZs7nALXYX/BPmDGSG3UYzVOvSRxBwvMgt6OxpQwMCKggdj1JtUH/2UhmrtH4txB5SFqEW88MvcHAVFzeJDTHP8atZgMpPVv1T4T6NQFAOOXwHAMSWuHOXw+mA6rwELw5nL61RV0uiUTrjhTUFIO/r64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199018)(8676002)(66556008)(66476007)(66946007)(2616005)(316002)(6636002)(6506007)(478600001)(6666004)(6486002)(53546011)(6512007)(186003)(26005)(36756003)(38100700002)(86362001)(31686004)(2906002)(31696002)(4326008)(5660300002)(8936002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0U5Qmw1cE1rKzFTeStJS2JUb1orL0s3L0FLYWxwS2VINTVuMENUODc2Uy9I?=
 =?utf-8?B?NmYwYk1kVnJFangvTFM1Qmw5eVQ1alJKUW1XNnRtSCszVGlDaWJRZnArK3p2?=
 =?utf-8?B?Qk9kN2J0QWJQeWt5ekh0eGxpcTlFYSsrcnJ5U25sa3dBUHpYOXI0akltNGJo?=
 =?utf-8?B?VE1NbG1ncndHTDNOejkyQzBFbGd0dkVjelNHbkhhMXhzNzFxTDFBVUdsS3hl?=
 =?utf-8?B?VkM4QmVoaW12dHNqbU5BZC9pajRJUFBway9qY0UzK29oZE5oTkpWaE1NNkRy?=
 =?utf-8?B?aDdzZ2F3MHpIYW1QaVJubnlLZ2lKemlpMEtOZzRiS01RL0pxL29KR3dpV05q?=
 =?utf-8?B?dk1VZWxlbTIyOVA0RE5USUpmMllxK2tYbHNFSmZTVXFraGFrc2lxL3orQ3R4?=
 =?utf-8?B?SjM1YmVSNWtuenpkU0JscjZKcU9may8zaTNFWVBJc2l6d1JGQmtJSHA4Wnd5?=
 =?utf-8?B?RGxFUXNzc1NPSk1NY0J5TFdheExvYkpNZ05WYi9RVmNjdEJhQVZsbWpDNGxZ?=
 =?utf-8?B?NnJpbGc1enRSVmg0R1crczZLd1NKT0N6V1ZDRVMzdWRwS1htbWkrdnZleXpO?=
 =?utf-8?B?SU1OUWlhS2F5YUFrREVQTmNnUkVpQmJRNG8wb0V4bk9zQjJMU050MS9GMWg0?=
 =?utf-8?B?Nk9OMlRta0pjT0JmRFFXT3UvdXZZNE1NNVVoZUlMVmM4V1lOblpObU5EMUlM?=
 =?utf-8?B?VkpZOElQbVc2VWg4MWovR3h4Y2FXVzMrb1VmNWhaeEpQNlhhRzVHZ25hcC9s?=
 =?utf-8?B?YWphdHNYbmU3d0Y4RGgyM1dpb2ozdytXdDA3RU9nNVR0RnZiL3VHSlRkcUJY?=
 =?utf-8?B?aDlsY2ZFRGxSNlRMR0liUGw0SEVxdEtZektRRzVSNnA3KzZYbStic0dIamhW?=
 =?utf-8?B?NGYrc2JOd0dkNUluMCs2VmpaVzkwUEJCOTU3SG5KaFowUkI0eXdLaVY5RDVS?=
 =?utf-8?B?UUdjb2cyNzdNMktQOEtEMi9Fd0cyem9LNTdYZnNNUWVyZWxaUmJiaTdoN1ho?=
 =?utf-8?B?dkc4UWo1M29mSnNYbzQrYitIN2hVMWI1L2hqWmwwSkhNNkZpcGoyVGtKcVZC?=
 =?utf-8?B?TkY0L1RVM1RUSTQxK3IzMXJZejFMUG5pMkhIRzN4VzZ6SG5GcHhSbGFRTklm?=
 =?utf-8?B?YmlMTWpPY3k4UzhRZVJTLzBMenZuWWVsb1V3VkJUL0dBaWRLNUVaSlRCbzVv?=
 =?utf-8?B?ZlFmWEVBNVRxSjVwY1U1ZWRtQk1CRGJPOHBRVGNNRG5pVVBEWnFmZU1FcHVN?=
 =?utf-8?B?UXRGQ2YzUjJFcGJJNzJ6U1RNek1XbGxnY0swclZGektIdXZkQkJyR0M0ZGxM?=
 =?utf-8?B?WGsrSXY4MEU1dWZwRWhKVUZtTkw0Z1ZqckhxQ3MrMlVBYXpoMW5LOGtHTHZ1?=
 =?utf-8?B?djZDUnZTc0ZTZHgzRitJMHZxYkhEWDVMeWxJUktPNzMwNVJZMVRZcHJOQUtN?=
 =?utf-8?B?aGM0aFlTZmZaV3JnZTRLbkNlN2tGU3RHallwbEdpeFdpd3hzbm5BQ3hMeEVm?=
 =?utf-8?B?Vlo5SnVYeDhhV3pkWWRINGErVXpYUmg0YlJUY3ZQMlYra1F6eVZlR2FGSFVI?=
 =?utf-8?B?M0VkVmJubEtIbng1ZkNyQm9kMWQrbmsvWHlPU3hEN2JPRUVldDlkSCt5Wk5P?=
 =?utf-8?B?SW1NU2p6VjBqblNtSC9uTWM4Mi9rN0h6S044dmI0MjRRTkRqM1VtaGNFQkg4?=
 =?utf-8?B?NVl5djhZS2tRQVdOanRVQm5xNmd5bXg3ZUo0ZGlDNVl4ZVJLZzYxc3BhUEww?=
 =?utf-8?B?QlNiaTNYZDF0TzkwZEpieS9wdWRmRGxBcjF5SEFsN1dtcGJ0UXBSYm92bHVJ?=
 =?utf-8?B?cWxKNERMVWxsVFA4TnB3VmxtMmlNWXJuZnBLblBJdUxIR0h6UVBpQmt3aU00?=
 =?utf-8?B?OW9hcEpYMkFjTEZVbG93eEx3ZFExNjJIVllrbXRUbXhjSTFZd1NwSVk1a0Rl?=
 =?utf-8?B?OVZUNDJsT2JoMmdNS0FWdWY0Tlo4SFQxWjJsOVJsUlY4S21WV0crNzdxRXdy?=
 =?utf-8?B?UGN2RW4wU2ZLdnIvVXY5aitoVUdNKzkvcTlHTVFBbm9kaUV5QjY0RnNlZjQr?=
 =?utf-8?B?bUJDdFdmb20yNHdPZWtwTmZaZEpka0pOOGY2Qlk0MjJMZVZqaFBpei9TNGI4?=
 =?utf-8?Q?JtIKXjQD6Xz8d3IbeD7fBi08y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021ab7ca-3a57-40c7-70e1-08db03853540
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 12:18:06.4974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncqU3yHzSmTGjQ+bmehVVA+SlfAZGDWPZ+b8voiG2a0q9p5P/NP+BQWvAGFnc63k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6906
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
> index 5f4883b..6d02b8c 100644
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
