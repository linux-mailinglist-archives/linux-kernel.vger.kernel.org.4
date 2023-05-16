Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519257047AE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjEPIYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjEPIYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:24:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4CA19A7;
        Tue, 16 May 2023 01:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684225443; x=1715761443;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YrJlUljJXyK+eBAreN/W1l/YH1cxrd0Rx+yCDufQIaE=;
  b=OF3vnwA4WCI4/yJRlkVmC8+0xrZkRFTAh9Fq2+YIvewFHa7OV9+gRB6U
   Kv3RBEid5IupnzRsMrUvdsJAw/BxlnVKGXzgLEgPMVo2YBPGbWOmdrGGx
   LZNB4nPc8eSyfq9edwGnSjIVcLkcjG+YPpAJmgIWSIwgMNkixAd71IWZ3
   0sS6PVrA5ZpqLlY8nvd+y9hkAR4cNg8WHzkStyzruyiJhwpi8JU0THsWZ
   SEbfLRbn1f20WawwMbr7An+POLC1ofpQ4X7uknD5w1FQ/4r8VEWS90R3e
   bw9X6rCmc67akwd/12O/RCTwcWal1yPMbDw7rkdlwk4drap+N3zd7cc52
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="348917149"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="348917149"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 01:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="704306765"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="704306765"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 16 May 2023 01:24:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 01:24:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 01:24:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 01:24:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 01:24:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itHyyWUyTR6MQgX+0Bf+zD1EeoAqGLYYuiGDbrXQCJBTTLp74BiutjTUjiY1Jz/4LKPC8EfkI0Q0fEU0YzB9pACtZuhOjpskV/U3ThEq5RkJqos1J0spIBIUcxP/cabb3c8VCMIF4znT06/g0hsK1fafffbxjNkmiwWy65xlEZayEA5GgqLpq8PGjaDU+puqU4uRG61dhYHuL8bYHFf6/+0kC3PU7lDJwhiXkn7+zM+r/uUvuKbJmyutml/NFbJQLL56x8W0chdweZvMPRYHSIDapP9RpN2LZ841PFTNkp+iyq7xry7vs5b43wzbM5n0ZnrAAuEIASqghoUUnIFD1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3SMO+Wa20nVJ5/52w9gth74Qoo2kq/msHYljNVSn/w=;
 b=kPei2KNWkslBp4RYM+Cikd+AIU1d1nTANxdRJtxsbz5vC0OvcN9bdmrBhaslDrES/0wHlgufX/N/wSUH25RxPOJaAzjIrw2f1TNT90vRx0nsjdAwn7jILwWmOdSgftc1+XPumMUscI7UHNiSZzE63+XXBQlpHqQtFDGFMvEny4PezcWBekQ7ULsfaSv4h5ZWavR7+xL3maw+6b/6mJSTkx9q7RN+Dna6wyZoaJq29HmilUuDGRbiE9fMSyJYTZNqEj+dGzv0fyCsKVy47qZyQ3dgeJVbkg7b6tANwUKUwaYFr9XpEyFfZBFVu0/pQam1TUdoM2FyqU5Vf6hFwtcIag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 DS0PR11MB7333.namprd11.prod.outlook.com (2603:10b6:8:13e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Tue, 16 May 2023 08:24:00 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::b1f0:4762:2bee:138]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::b1f0:4762:2bee:138%3]) with mapi id 15.20.6363.032; Tue, 16 May 2023
 08:24:00 +0000
Message-ID: <bfcec885-9dc4-ff7f-f7ab-1481a8bae559@intel.com>
Date:   Tue, 16 May 2023 10:23:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] firmware_loader: Fix a NULL vs IS_ERR() check
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <36ef6042-ce74-4e8e-9e2c-5b5c28940610@kili.mountain>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <36ef6042-ce74-4e8e-9e2c-5b5c28940610@kili.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|DS0PR11MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 574fed80-b96d-4cf6-258c-08db55e6e669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0iZ8VND2jT3dhVcIYV+U51Dw0F3bC74FGVX9e6hT7hoUP1VI2lYToIV/WkIG+8YKIFz+tYORN+MdzjIriQnC/sJ9M20qhTzv/PcObRVCDcyHNqq1xwWajh90ft0qAnW8ODWfH8TYH/JopLwxa/Z7lpC2OQy0hrOLZCHqJ4nzln4PPQI0YQaclK4SApj3VNnQdp629Y/MWph+29aOFGzy+3ggKXabPPvjGJuMbpwyEBmCCB3YqnxlXa1/r3aPVc5LWsaBIKuoS7brepRUqtvBi2VypL5tWIHwYXHXh0S9Rr9IC70qCW0/NA2rPx7n5xMoKdzY/+tCapVQ38eSWNv5Qi3o6dVoXNx4gotlzbn4xz2AzdquxI/dVJi8WE8aWDp7D2f4//O6FEOr40j/1JdKUx/EP1KTqpUzejXZhc8kQUgeyqow0/HLbhCuyMdstI3tabgoRIh5PFgYgoduhQMINYCsYQVkxY6TZKCGLQaXs3zWVRz89DbA1KYcgYjsTKT8Iv1FdMkkGDVo2s+IKg9WNi8jpcdGGK/IdxIwdibGpNNwILxkpG1dKK37OgRdoBA9VjeeKd5+M/iyvXEO3FreIPGPeX/t4q4eaJHTRNxp8VMbEIjSdm8J3z2Dlsl2rQNnrU4Hf8mDJQ1HocKrHX2aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199021)(38100700002)(2616005)(26005)(186003)(83380400001)(82960400001)(53546011)(2906002)(4744005)(8676002)(44832011)(6506007)(41300700001)(5660300002)(6512007)(8936002)(6486002)(36756003)(110136005)(31696002)(478600001)(66556008)(66946007)(6666004)(66476007)(316002)(54906003)(4326008)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2ZFalh1eUZwclRnUG96YnZUdUExUWM4OWtiUkt4Uy9CQmdKMVZDWUdRbjZj?=
 =?utf-8?B?Z2tXU05vTUt5Ukk4STNUNzZyekJJd1V4N212dklWUHJVbGU2dVQyay9BalRL?=
 =?utf-8?B?bTNCMjBHVElVblRUNFUzNlZGazBWZXdRcUU1VXlQREswZTd6aW5HVWJFNmk1?=
 =?utf-8?B?MkRtaTlVdiszb2ZBVHBXRzZGYnhYSEVuNDNmWnhLaHg1YVJCSHE0V3hPT0JG?=
 =?utf-8?B?WTEvelJFVVdYV2hwcGhEYU15VHJWamFlZ1Bjb252R0ZGTXRrdWVsWE94eFNL?=
 =?utf-8?B?bDVvTjhwTGRNeWhCdDhHVnF3RmJxODM0dmdYai9KbXVkTkJPaEpLdmZVRlh6?=
 =?utf-8?B?MThtaG9ja0t6cVk4ZS9uNFFHTTZlNFJjUEN5S0Y5TG9GMTFzU1JJYWtNdHNH?=
 =?utf-8?B?VlRDd2xKbFc5akZHcGJGazFPSEVSbUpQOHRKbFpCRW1FcEZRcndJbERpUjNo?=
 =?utf-8?B?WGkwRnpkSnIwOFNTZjJpVFpHU080UjdUclVvemlpQnZHTUJnQmdjYnQxdTlr?=
 =?utf-8?B?Ti85bXROQVZGNjl5MEswVUIzTjl2T3dMU3FhQlVsVDdrS0pydit1eHhBSkFr?=
 =?utf-8?B?V1VjaFdVazlkMGRKR2ZscWJDVWlydTZCT2dlZDZBYkdiUFhrUk83M2taNFJJ?=
 =?utf-8?B?dXpxeG5XdVFldzhMNktKNFdFd0FieUFnQ1NFak1Kdm1sN0pBNGhma1VlVlVL?=
 =?utf-8?B?MW5SYXE3UDRiNEJNUmNseitwYWJmckozaU4rTlRaeXY5YUxQNXdrRHBjenB3?=
 =?utf-8?B?eFZjaEx1THdRWlZLa0lTYUprYnBBOVRoTXZpTlRHUVVJdVVySFpvMkRCbktR?=
 =?utf-8?B?UzA0UFRLc2tITE9pQzhGVWUxVGJnMEhrREN0WW0zSWVKSWFiQWRsMkNMWmNv?=
 =?utf-8?B?WFlwVWFXNC8zamtBNkpMOTFSRjNkZ3lOQS85S0xVRDlqR3dpYmd0WlBJZUtk?=
 =?utf-8?B?SVNTQ21reWQ2TFhnVnNXV3F3VDJUNkIrS2M1TVQ5ZzBWbHpSNVptS3lsR2Nl?=
 =?utf-8?B?dGYwZFE0RnlsSXJtMG1IVWtkMk9zRFh4dlJpOUFqM21SNHFNNElKYlVKOXJq?=
 =?utf-8?B?YVpRWlNSN3JXa2oxTjhvUzZNNHVCcUNNUnhiRGpwZzVWODBUV0hERWlidEVF?=
 =?utf-8?B?YXdLbkJ2bmswR1FTdkF0R1JUVEZDaWs5NUJiNG4vcExaRHZDdTNNUmUzSllL?=
 =?utf-8?B?ejcvTGVqM0lWZ2tRblJrMThscHJmSklZTHV2VlhXL2txTlkxeDkrVE1yNW5G?=
 =?utf-8?B?N2s0Q3NLZ01jYmZJa0hubWlnYzNCTzM5bUhQMTc0QWhMRDBnQ2tjcUppUDFW?=
 =?utf-8?B?V2VPdjJMdnVxVmpmUE9UTlNSVk9KckdPUWV1MzZ6NE5JbGs1T1hzNmR4dzAv?=
 =?utf-8?B?SStrRGpJdTUvQ05SR2I3VVVUdkFwc1IvSzFEQVh1eHZsbDZaemNEcjR4d1Zk?=
 =?utf-8?B?M24yTFV2ajEwZjc3WnpIVS96WERkQVZKV1B5QTVZTFhCV0trZHRNcDg4TkEy?=
 =?utf-8?B?K3hJVzNLM3NxU0pzRGo0bEpwRlpjNjN0MGo2M3N0RG4wRERwT1BUTS9WNkVr?=
 =?utf-8?B?TWRKVk03YlVDNk10dU5ZODRuUmtPeE5idEdWNkZEV2dIaUtqeXFyRlBWalRQ?=
 =?utf-8?B?YXdKQmZXQ2lSZnNRZDgvTVo5MGxxTFp2SndMamtUV3ZBZVZhRUlXZWNUYVBq?=
 =?utf-8?B?NWtkNjcwTER0aU5RN1A5czlyTVNPM3RUcXE5TGxrbDJ1K2NGVkJFNWtxcHVu?=
 =?utf-8?B?bnE5bUZYM1orRDJBR3dMYm1nMXFBS1VGSkcyNVFlUktObDRzRUtqUHFzeHpU?=
 =?utf-8?B?Yy8vV0VkQkFnb1VaaHNWK0N5WXJlMWlUL1JkNlBpNG41R0RKbUNNWlBLWUxj?=
 =?utf-8?B?NVhsdVFKN1BpR0tBYWZrcGRGUm9YMXB4SlpOR3ZkeVNiNEFMc0xlbkUyNk9u?=
 =?utf-8?B?ajg0RkoxbFE3SkM0NUR0cWZ1TEJwd3RYNFBlbFFsTlMzWmFmYjlsaVFJMUI0?=
 =?utf-8?B?Wm92UWlOYWZSYkxpVG5sVEhrc1BJQ0ZiU1ZOemsvSFI0Vk05akhHakRKZytK?=
 =?utf-8?B?Zm1pM2s2QUF1M0dQeEhUemhRZzA0QzgzYUx4eGRzQ1ZLVk9CNWg5VUROYzZx?=
 =?utf-8?B?ZFZYQ1ZuN0o2S3hCUHdCYTM0L05QeUVMaGNvZ2cyQ0dXaWhxajZLSzZubGVu?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 574fed80-b96d-4cf6-258c-08db55e6e669
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 08:24:00.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHMSJmbijYeSBWnw+zBlcIkldkYZUXkNrOouKStpHDzZSBMSBPMN8Fg+bm0x5P5Gwk6HUCeAacG3STTprUugDHWTVDsTfR5hFPFV2xLf1QE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7333
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-16 10:12 AM, Dan Carpenter wrote:
> The crypto_alloc_shash() function doesn't return NULL, it returns
> error pointers.  Update the check accordingly.
> 
> Fixes: 02fe26f25325 ("firmware_loader: Add debug message with checksum for FW file")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/base/firmware_loader/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 9d79d5ad9102..b58c42f1b1ce 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -812,7 +812,7 @@ static void fw_log_firmware_info(const struct firmware *fw, const char *name, st
>   	char *outbuf;
>   
>   	alg = crypto_alloc_shash("sha256", 0, 0);
> -	if (!alg)
> +	if (IS_ERR(alg))
>   		return;
>   
>   	sha256buf = kmalloc(SHA256_DIGEST_SIZE, GFP_KERNEL);

Thank you for the fix.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
