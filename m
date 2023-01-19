Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E493167313D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjASFed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjASFeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:34:18 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E5D5B583;
        Wed, 18 Jan 2023 21:34:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kz2yA80HSj64/NoZdkWbshaTeVEXhwFxfHLNYPLLK3BWB29A13yCkDCpKbZ4JjEodg1Hn5ahZqQUw5TBnCCx8JZaWWyPPV7VKycu/GmrBOtZ9xRlS7npZwxOCaN+ogR1OW407BpkthxqGqlYjYWD5au9XEq4DRGsoGRn6yUfHom17VCBvSuywQzRzK7MTDUS1fopzghjBSeB4DhNAeceSwSr50iW1v1zZxeEe5gT1tkBWUjXvufX8A1OaDa5/lRUSKS+/qZOfaFOE4O5NU7EyzrHTNXZw4+5WIjbnpAnvBb3+jBgSli3JNVpA32kbCxJHgm+8g8fIGzsbRMWk58Few==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QE9CJnMaNxV0g9ss2twCz4dn1dfA3pd/4XSR/0Jew5w=;
 b=mZScOMOwb41KrG1G0jBNb/abisaF3OVOtdPJq7XPrNTTwpAVlbCd+u0Q8Jd1DDM0rE3J/b7wP6/2RS9ONpaTRZgu1E5yx6tjrCOgHgwHuBPJpLiil4C2jyhItnpPawCTx8yQdzUKKxzwDh+0X0JADxLGIzlgHMbMFmvSmorN2NjwGBiooFGF8f6WkhAlnvhmfZSx4eVarvvGa7P00Atz6/13P/drbRdaF849izQreq5WldD06fv29PduWkB4R9GZWSoD/KbMJpQT2SPPjNCOc+vWzEY+gmQBpegS93dtSsY/r2SFQZeeGHnuYJ6OCc4ePkc5PFGtqJ7YUL+/C2yFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE9CJnMaNxV0g9ss2twCz4dn1dfA3pd/4XSR/0Jew5w=;
 b=uVnw+owozrxEgdBw3xikhW8DkzmcED53tjnYz5JjwYhHIxgPLcfPfWL/+ikIa9xL1bo4qJBRdv6dzik3rxzr6O2l4iIoYLF+o1gq0YmF5LMTxckdenbi6YrlHXw6IyjZJEebyylcPXhxPAvgh7NYXp+t50/u8hieBqdowFa0kS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 05:34:09 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.5986.018; Thu, 19 Jan 2023
 05:34:09 +0000
Message-ID: <43acfc0e-167b-3514-76ba-db3db8810bbc@amd.com>
Date:   Thu, 19 Jan 2023 11:03:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 11/11] Documentation: amd-pstate: introduce new global
 sysfs attributes
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, viresh.kumar@linaro.org,
        ray.huang@amd.com
References: <20230118075210.447418-1-perry.yuan@amd.com>
 <20230118075210.447418-12-perry.yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20230118075210.447418-12-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::16) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9ea738-0abc-4b0d-3e3f-08daf9dec998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpJ8lEum2U9WXJr/xfWdfrg4gWSS5HgT1EZEbdhkV5HhiaZEBM+OPNm12j5ZXYcioxHEz8rX6b1UsJOSCIIZ9YvqedFneY8tbAA6Wt38JqX2cEb3WiE7uIBL8uaH8VCxH2w4+XvCFMbR1Qubh1g5RNibDspCXqMe/ozM9I1smlH8SdxwDQHArTmnouN5ED/1v10pYIK4CsplasQPV/x1SNIecN3DHTnl/mxEoLzzsiY2b7ZM7cet2GpWwMfTYLcf1sY6XeXAI7xxhxYkIQeX7uwCxZf3zWKek+/vEr/NbX5YQN9O1L57g3CzLeEAR1RtFEF/yOzRfZcCkIuDtVyEvphL3T3loDseONvgCdpCWwJ7VB3kzhYBwRGEn3ortQFU9tkX7lA4YZ+kl5igq9viSGpMPd9cEaentm/l3Xd1a+iDuE09y3jKlIS6NThJlZ8B/MPN57HdadUzQUH4uYqVhAmDefIEfg7A4y4j3ZFvI4wQgl7GjlmPaNn/96jQlO1qCO7dvyTRwwnRrHt01TUe14yW1L97YslkrVvhOhHOAMto5iiwvysCaKp4BXz5pruA7MeRMkmT4w7ec82haEhw4X368MxN+eJ2kw5a2kuwA86neJHEEvehEwulygdv+V/YQbG1Y3mimuUm6MIiEECH8OH94uv0uql4WhyI8Gi02B4u2ArtI+m0oqyoEkD+h9YCcxpSmgHCNZQru/FUN2Wf3JSbHnDqqbURCjz5EgfK9do=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(31686004)(36756003)(86362001)(44832011)(66476007)(2906002)(66946007)(66556008)(8936002)(5660300002)(6862004)(31696002)(38100700002)(316002)(6666004)(37006003)(6636002)(53546011)(6486002)(6506007)(478600001)(8676002)(4326008)(41300700001)(186003)(83380400001)(26005)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0FaMkE4R05UazRuQ3JnblBBVGRid0FVNnJVM2h2UVdRcm5vNDJUTTdjOW9Q?=
 =?utf-8?B?eVZINWZlK3FNcHVKMmpBa3l3SlpSaThqOUlSNDFTMFhHS1NyR2liWGwwaFo0?=
 =?utf-8?B?OENvZ1N0aFBKZ01TSVVNUGt4MHZZMGpReXlDVmpTS0ExdG9SQlZhNmttNUxC?=
 =?utf-8?B?OFpGSTNMU3BIakVESnZrSUpDV3VoTkg3TTAzWkd0RTFoQldKZExuUDVnZ0hS?=
 =?utf-8?B?VHBBZC9tZk1ucTMyUWJjWXc4a0NUWUM0bythOE4xQWJhZCtBQzdNd0tZd3Ux?=
 =?utf-8?B?TFczdy84Z3RLWlJyejE2cnRNTUNVcDdzMEtwY3JMWjRhZmVnVjVZK1NXOEpI?=
 =?utf-8?B?K0IwQ2FYazNrUzcvZmZEd09iRW8zTXJOb3dEZUZOZ3dNMndySGk2WVRNSXdB?=
 =?utf-8?B?T2FKQm9NUUJrSTY3Slo0K0NKZUtaWTBRNS80cFE3V0dtNnJxZ0dWeHMxQVR2?=
 =?utf-8?B?TStGREQvKzBqSjhhTXVONXlOMnZBd3NDUFkyRGZPMjJZVjJ3V0hkbkxlWmcz?=
 =?utf-8?B?OUUvdGk0VStpYVllNG90dXlKMzJKZ2FqVVZrUCtESTlscDJXR3B5TnJGcEZS?=
 =?utf-8?B?WjF6c09ibDVBeDZSdThtSHlvMnlhejZXQXBxdDd4Y2FEYVRvV1laZ1VBSWgz?=
 =?utf-8?B?dlNLejlFakhFNTU1M0NnSWNVZVU2NjlaUnB2Qk5yMlhKSFdQQzdCRmtKS3V0?=
 =?utf-8?B?VHFVYjFsN08vMTZCdHhTMDdxd2RXemtpR0xacEpqdDEyc2RLS0Y3SDdpWVQv?=
 =?utf-8?B?TGtub3BvWGlVMEFGNHZkdXZyMWxSOGhZWHJWb2wxdGVZTkNlQWlYKzg4T3lS?=
 =?utf-8?B?aU5HL21ldm5pbERzWWdjLzlVRjNrWjc4T0RFTnNpVGoyU3VhSHcreDEyWDdm?=
 =?utf-8?B?RXpiT2tQdmlCUThSWXMwWUd4Y0wrQVhneFFnNVVYeGg4TGJSU1VYa2NsaWQw?=
 =?utf-8?B?OSt3aFBscmIyN2h5ZGN3TVE3MlVlZFhHT1dwVHpVQ0IxWDlQMzVBWFFZdmgr?=
 =?utf-8?B?dmJzb0RSK3JTbTRIenZEVUlDOCtQKzBnZ05MZ2lTRnR4Y2lodkFoSmJtbmZY?=
 =?utf-8?B?TjJNYStqUlZMWW1NZlJoeHBiSVBuMldwSXVKbC9LS3RKdGFWN2loL0VWOFZi?=
 =?utf-8?B?VnNTdUxDYVBnWWNkQVBNaktXTithcWR4TzNBbFplb1BFTjcwazFiWXBMMXNM?=
 =?utf-8?B?b0xHWGc2ZEdQa1ZkUUVYQW5xOUtrL0pWWXBidC92dkpDeVJNRVRIckhpTnZp?=
 =?utf-8?B?c2VVd2RFc0dESHMzREo2NHZYeFBGT0kybGwzdWprLzRneFNwYkR6VlQyUXRs?=
 =?utf-8?B?bTN0cFlwbmlxbmNGMkpFRGd6Q3VFTkw5aXU0RGxlWWM4U2tyQlk4aVBQeStn?=
 =?utf-8?B?UDEyeGNjZGkyTEdaTVN4TFFiWEFGS2phdzh6aU9rN05nN3I4UXViZ0JsQlBN?=
 =?utf-8?B?Rnl0Ly81LzhKaStEY1JLaUR4TjFvaTdmY1B5UkVQbXI5emd1NDNCVldnaEdp?=
 =?utf-8?B?R09rc292OXJjVXpOY2hweFNBRUhJWFlUVUMyNnBkc013SktuS3l5bXJYWmU0?=
 =?utf-8?B?cVByWEZWVSsvdTdEblo1YnN5dzVkWVBOUmF4ayt2ek15MmFLbUFQbTc1U0lU?=
 =?utf-8?B?aXVYaEwzM0FxYzhNUUhoeG85TU43bE0yMHFrV0dBVm5FNHRsWnFJa2lZaFJo?=
 =?utf-8?B?NWh6L1NhenF1aHNWNFBOMG1xVkN0Z3dwWUxWZGlOYi91ZkRiR21FR29xL2xP?=
 =?utf-8?B?bGhQMTliOXI4ZVpFUlB0eWxEbDBnbHRKeTdYWmFRaTBaOUxUVFBtSHVzc09C?=
 =?utf-8?B?dldlWnZ5N0lKS2c4WHBmTzVtaG44WDlUdFFrc1N4MmIzME5HSmZXTSswYWZk?=
 =?utf-8?B?K3hVTEV4WDZ1MXhNSDZvVmRNNWgrK3F6WEp0L21XMVcxSFZzeGt2bStNbjFE?=
 =?utf-8?B?dGxBTm1aTjcxUDM1a2dkNWdrdlNmcXNkQTZuZDlPRllLeG1aejM1RWkyYzls?=
 =?utf-8?B?aTZPOWxUQ0Z0clZVcm1idVhVOTZBb1ZEbThSaEpZNitNZWNPY0oyaHpWVDFY?=
 =?utf-8?B?Tmdoa1NmTWJPUjFlOGZ1N0tpYWFqTFJjb2NYVXY2cHhrS0FYb3RaekxNNkpJ?=
 =?utf-8?Q?755MDdIQ3Nsqzx73vCpA15Gk/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9ea738-0abc-4b0d-3e3f-08daf9dec998
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 05:34:09.0818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8zzPx3x4qv8FlNv5Cs3MapBghU+ZHpeI7QISEvRP0etzCdIEUtIFZruTC4V91ySzQl37WynxHB1KZ4mQkmIQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2023 1:22 PM, Perry Yuan wrote:
> The amd-pstate driver supports switching working modes at runtime.
> Users can view and change modes by interacting with the "status" sysfs
> attribute.
> 
> 1) check driver mode:
> $ cat /sys/devices/system/cpu/amd-pstate/status
> 
> 2) switch mode:
> `# echo "passive" | sudo tee /sys/devices/system/cpu/amd-pstate/status`
> or
> `# echo "active" | sudo tee /sys/devices/system/cpu/amd-pstate/status`
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> Tested-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>

> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 29 +++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index b6aee69f564f..5304adf2fc2f 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -339,6 +339,35 @@ processor must provide at least nominal performance requested and go higher if c
>  operating conditions allow.
>  
>  
> +User Space Interface in ``sysfs``
> +=================================
> +
> +Global Attributes
> +-----------------
> +
> +``amd-pstate`` exposes several global attributes (files) in ``sysfs`` to
> +control its functionality at the system level.  They are located in the
> +``/sys/devices/system/cpu/amd-pstate/`` directory and affect all CPUs.
> +
> +``status``
> +	Operation mode of the driver: "active", "passive" or "disable".
> +
> +	"active"
> +		The driver is functional and in the ``active mode``
> +
> +	"passive"
> +		The driver is functional and in the ``passive mode``
> +
> +	"disable"
> +		The driver is unregistered and not functional now.
> +
> +        This attribute can be written to in order to change the driver's
> +        operation mode or to unregister it.  The string written to it must be
> +        one of the possible values of it and, if successful, writing one of
> +        these values to the sysfs file will cause the driver to switch over
> +        to the operation mode represented by that string - or to be
> +        unregistered in the "disable" case.
> +
>  ``cpupower`` tool support for ``amd-pstate``
>  ===============================================
>  

-- 
Thanks & Regards,
Wyes
