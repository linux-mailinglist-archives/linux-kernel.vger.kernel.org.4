Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282BC609E82
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJXKFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJXKFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:05:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3780715FCB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 03:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaBOcjjAcF6GeT5FIqZAJgUTliqEBX7mk6D0R9wDbUedY4ivUduxf4H65KBYJT/bWDKtDNqeA/rgb18/mLaQvnX0JEd6e1iVROMoD9tO3rFlNx25AobLX3ZfUzbqZc03NGSXYxDxPhb+3dji1M8zIK8bXm0/YpfxWJ5M2LxSqYvYEFUvOKgZ+BtH7vM62uwwCkNZ3uH4R+Mz1YMNBkYXh9cnzCezmYRctuvlzLgedZXxvBVw0m29NDwAaq+kctO28U+1y/ijuOGKiTwQqgDhP2daFubbSrEPWnjUPGlUm588k72cyjKdMc9H74s/FJisq08S5BAEGlSy/rkHgxp59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCeWKjb0PKvmy+iW/2C8HqNbYoYK4U880GvG0ivyNRc=;
 b=LjjyAmiNQurk8JSh9K9PuR+RWGsodduMPu8pZihngg4LbWja2rsMTQ70pQ4vjDH1mNnsFxlLrgQQo6kLm/AwhbDMPvsR5aNb4jj+/irraomjlCtfZ5N3BtKAlz+eVSjCI92bS5vFsHdgcWWAFhp2mYeq30dgcKFJ7K38H0VPntMEirX7/zLbgXZ6lhWYkz1Q9mCLwRj1sIPIQV0Y5WRiO2JoAjb3PUnW5D1aVfaqUHUJ67AkPtJ2LyUBAVylh746pl06O25pJrZfhut/4aOJX9BKto0Tl708ek+8rcBdM+yEp/nqd/Jsbo4DAT/LwxkotrPD7K20d4x8EjRZ44VjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCeWKjb0PKvmy+iW/2C8HqNbYoYK4U880GvG0ivyNRc=;
 b=ZBkPgDQAVR5VRBOF16StRvVCkQ2IUWfZ/+9GTzTjR2r9XtKQcMiVhWKgQ8n4LOnGFnLktiZ16XIaq5lf58TsXOvwsm/SIKVk4iPtyEQwH12lWhJAfES8JpbZH/0ZAwVZw5uEDT3uOYcEpdKFw33/BUuZQpEaLpOkLgkL3915ueM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 24 Oct
 2022 10:04:59 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a350:f29a:f287:7279]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a350:f29a:f287:7279%4]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 10:04:57 +0000
Message-ID: <be10fda2-eeef-ba74-0f6c-8ce01e7e2087@amd.com>
Date:   Mon, 24 Oct 2022 12:04:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/display: don't print messages that contain %f in
 dml
Content-Language: en-US
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Brian Chang <Brian.Chang@amd.com>, Ian Chen <ian.chen@amd.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Leo Li <sunpeng.li@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Leo (Hanghong) Ma" <hanghong.ma@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20221021163412.82029-1-hamza.mahfooz@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221021163412.82029-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: afb8224b-92ed-4c08-dab3-08dab5a7344c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3k+dSH55BcP6IwBf61RlNvkK3omk6aywtjV3/m/pnKZMi1xLDuafWhk4uHhaf2t9xtAENf1S7EIL4+6Am4zuQ6Y19/86XIdUwe8SgzIj1xZ0IFI7b5GqdpcLNZtm42nJq+i3udMxm7LLZti7J51FD1EpLc7GM/iZM1PkyzHmu1N2Pua7ClFoaQaPYRPgJRnaBBcJgVlBSU6GqaIJQgkcjlSMdpm0eFZhgzlZYWGJvc5O9O9jmfWrCTY8KpgIVJgLPg+6w0Q0iODJMvI/XEMJY/aMJ7m/HFG75/jMPv6/mG1iCZcLH3bYAbR++E5F/GoaVEI45OL/aDEzuVRwOr0iXrNZNLDt/TWtk9DSh0kdGqc6cvm1NuztBR/EftTdnkV810N+8YiuYbO1WAVMKEUat0WSDZ+mW86hBFjeClgEqJ0iM1uSda/tesKla22s3OKtS0VZFrgyl0MpC0KBBJjL4FGEMhOf3XHVV1TX/mfNFxsEXKBjjD44UY1x2MBrlNWXX16zdJrRQmDwozriYPjImim938EcMyeIdSMExfraUOVHPlZxYIUzUiWYzaKUPguJrDM3G7gFH5c52+jMxtQpUgibUZUggTSgCkHdqLtpXdwP7bKueMLGnD9g6HFRXiQpeJ4lIX6i8NeT3svHJom8SKHRgSHcQ8OG/Mdl0jV7FJ4cg3DEjB3yw5iY4pjiEONxrJWE5P2boXQf25/V1FE5XKa1svIsFdWUE67r5XZ9BHxVdhoh0xVWBeeL+EIwdWh4+pVwsxubpMRBmOYGL4/BidOLEXLK8+rYeKcmmZxCgFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199015)(83380400001)(6666004)(316002)(4326008)(36756003)(6506007)(31696002)(66946007)(66556008)(66476007)(8676002)(54906003)(186003)(2906002)(15650500001)(2616005)(26005)(6512007)(86362001)(41300700001)(5660300002)(8936002)(6486002)(478600001)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDNxVmlxZUdNU1JDMWZJN3l5T20yZVFha3J4V0Z2Sk5sT3ZMMWNvdmJRR1VJ?=
 =?utf-8?B?MjJkQXZIcnlMckVWb1dHU0ZwbmV5MW5ES1IycUtaRzlPNmo5b2FQKzBZcHdY?=
 =?utf-8?B?R1lVUVNnbkpnMG5aTTJWcFJ1eDF4dC9TVXBsTnd5VFJYdEEyRWN0Vldibmxn?=
 =?utf-8?B?TzF3dDBEYlVyMm9JRHRCQzRCWVlmaE9pb1VOQmVMdVZ3b0ZqOHRza1FwWU93?=
 =?utf-8?B?T2NmQ1NuakJOK3ZDencrNSs1M1pDUzFPMUZncVVnSzBnVFRzajh2emxZMXVz?=
 =?utf-8?B?N0VRWHBNWUlIR1dsYmVZQld1bnVtNnNTMXJrVmcwelc4dnRDQzkzYW1KTUNG?=
 =?utf-8?B?aTgvdHRwRVpPaks2aXJkOEdsb3Y2cHZNVUV3RzVxYVhNdGpQMGFTcDRZTFc3?=
 =?utf-8?B?M2hjT1UrV3NiRi9jbHE5NExrV1B5Mmo4MTV2OFdQWVBNTy9LQnZvNW9vMGlh?=
 =?utf-8?B?bmJiUkRhU3VXQ3BnbWYvd1ZBRmd4eWNIWGx6ZktFT3laajcxaXhzbHhTVGEr?=
 =?utf-8?B?TmhvcEdNTHpwMlBtNThwZzdjbXFvRXQ3V2dFNWtkT01vdU11ZjdCaDFNdWhH?=
 =?utf-8?B?WmtiQmladEZwaXBiMysrV3JxM0E3U1d1dURNMjB6Ynp2UEs5UDIwY3JqaEc0?=
 =?utf-8?B?dWJ5WGFiTmlNNlcvWDJqWmpKbVV0Zi9rbERNQUl4aTV3bHhNRUViQ1Q5dlZH?=
 =?utf-8?B?SzV1U3FLNHZBSGYvVkZxTVZucDRKaEd3eWZ3Tnp4S2ZYNW4rZnVlZlFQQ0NJ?=
 =?utf-8?B?cFVldUZ3UEJsYnJ4dlJSUmVwVjZER1JRZTljWTJ3T1U1bGNLN3pxVUxaZ0px?=
 =?utf-8?B?TmNCWTIvbmxEOFBlM014N2sxN09KTHM2dFNEYWRYclhVTVVKMDIwZ0c3eHor?=
 =?utf-8?B?VW5VdnNib1Fsd0xoZyt1azRLMjFZNUVyaXJiekhTRDFSRi9wM1Q3VjlJM3RR?=
 =?utf-8?B?TFRpK1c1UytUWVN0VnVUNWx3QUg4Sms4aVkrMGxFa2lhaWFhZklnaVBMcHRr?=
 =?utf-8?B?ZEw3cU9QcGF6aVJ2aEI2RFBQOURYcVZXZFJyTjZ3OXdPb2FXNU5lS05oOFlD?=
 =?utf-8?B?bHEybkJNTzZ2Ui94bkEzaEErYy81WTc5b3EyVXZtUktxVWo4NGhTb2liSE5V?=
 =?utf-8?B?UjFqSEh3TGUxYmFmZnREb3lXdzlwV0dick9oZnB4VTd4TTlHTTh3K3Ztc3pV?=
 =?utf-8?B?UTdackJReUFRdHZ4TnQ2cEV0OVNCWEV1bTlleUJ2Qjd2Y2FrL1pjczdteW5X?=
 =?utf-8?B?NndBYUE0VzdqNnFKcnBqdHlhSDR5cVVXeEE2U3Q5Rlc2dHNuM0pnSjc5YUlL?=
 =?utf-8?B?T1QzSXBDanNzSWJHRVFuZ25HQ3FER2hTdHQrKzJqei91U3lRLzl6ZlNsY2h5?=
 =?utf-8?B?S3VSOUJqRzkwVkVCYUZhbG5DSGt4WkprN013V0JMdlBvNlhuNkd2Y3dOTk01?=
 =?utf-8?B?Wk5GRTNPZGFsdFhacnhYL0x0bGtPbDdsV0NGMEl2YlhZOHVuenVSbVBGOXl6?=
 =?utf-8?B?Y0tjRlRyQWdnOVc4ajlpQjcranplaG5pVmY3ZnA0OGwwUjh0RFZhSEhwaDk4?=
 =?utf-8?B?amszdUE2bVJLV3BOVzZ4USsvalJPOUV4cEd3Y3JCdHhhcmYvV0xhSVBuWDdj?=
 =?utf-8?B?K3A2UkxvNDFQNGlyeWU5eW1XaFpzL1ZQcldZYlpHaVFzVHMrZDBYSzBIUFdr?=
 =?utf-8?B?OTlrTFVqS09tQXNacjJoeDVBNFg1czdNTFBxU1laaHFvU0pobEJyUU9hejhy?=
 =?utf-8?B?c1VpN0U0aGVoNStPYjNxbDVyU256WHA4YzRQNUt0LzJPTDMrSEs1T2NTSHBs?=
 =?utf-8?B?WXYxZlJuSldEVjRGK1llRm81Y0JwRlI5d1RPSG1adk5sMWVxWGYrRURxcG5p?=
 =?utf-8?B?MXhnNm9DY1lMM2dUMUFJYWlicHNBeERnbG5mUng2eHlqZjkrNUg2cStBN2lM?=
 =?utf-8?B?ZGFmK0hpMjVGVVlrd05xLzFNbm51MllhZ2x5aUFYSkVMOVg0ekdjMGRneTY5?=
 =?utf-8?B?RnpmZ2JiWHlRTnZKbEpSb0lCWVN2NkV2WTVjMWpSMzBuNlVFTmNFamRPOUhN?=
 =?utf-8?B?TCtoTDdxOHVZSXNReHQ3RjZ0cDVwdmdmTXJ0QXo5YTlzTHhYSURwU1lJQTMx?=
 =?utf-8?Q?8ufQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb8224b-92ed-4c08-dab3-08dab5a7344c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 10:04:57.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cH+tAJfJeR5zrD+xtWVexCZ1pAdHeiX3D6o+aZh5y1/xXtI5WOIIzwDlRdlUg5uL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.10.22 um 18:34 schrieb Hamza Mahfooz:
> Unfortunately, printk() doesn't currently support the printing of %f
> entries. So, print statements that contain "%f" should be removed.
> However, since DC is used on other OSes that can still benefit from the
> additional debugging information, we should instead remove the
> problematic print statements at compile time.
>
> Reported-by: Jim Cromie <jim.cromie@gmail.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>   drivers/gpu/drm/amd/display/include/logger_types.h | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
> index 3bf08a60c45c..f80630adb5f0 100644
> --- a/drivers/gpu/drm/amd/display/include/logger_types.h
> +++ b/drivers/gpu/drm/amd/display/include/logger_types.h
> @@ -30,6 +30,12 @@
>   
>   #define MAX_NAME_LEN 32
>   
> +#define __DC_LOG_IGNORE_FLOATS(fmt, args...)	\
> +do {						\
> +	if (!strstr((fmt), "%f"))		\
> +		pr_debug(fmt, ##args);		\
> +} while (0)

This is absolutely not sufficient.

Linux drivers must be made for Linux, see the documentation about 
porting drivers.

So just disabling the debug messages won't work in this case. Either 
completely remove or properly fix them.

Regards,
Christian.


> +
>   #define DC_LOG_ERROR(...) DRM_ERROR(__VA_ARGS__)
>   #define DC_LOG_WARNING(...) DRM_WARN(__VA_ARGS__)
>   #define DC_LOG_DEBUG(...) DRM_DEBUG_KMS(__VA_ARGS__)
> @@ -48,7 +54,8 @@
>   #define DC_LOG_MST(...) DRM_DEBUG_KMS(__VA_ARGS__)
>   #define DC_LOG_SCALER(...) pr_debug("[SCALER]:"__VA_ARGS__)
>   #define DC_LOG_BIOS(...) pr_debug("[BIOS]:"__VA_ARGS__)
> -#define DC_LOG_BANDWIDTH_CALCS(...) pr_debug("[BANDWIDTH_CALCS]:"__VA_ARGS__)
> +#define DC_LOG_BANDWIDTH_CALCS(args...) \
> +	__DC_LOG_IGNORE_FLOATS("[BANDWIDTH_CALCS]:" args)
>   #define DC_LOG_BANDWIDTH_VALIDATION(...) DRM_DEBUG_KMS(__VA_ARGS__)
>   #define DC_LOG_I2C_AUX(...) DRM_DEBUG_KMS(__VA_ARGS__)
>   #define DC_LOG_SYNC(...) DRM_DEBUG_KMS(__VA_ARGS__)
> @@ -57,7 +64,7 @@
>   #define DC_LOG_DETECTION_EDID_PARSER(...) DRM_DEBUG_KMS(__VA_ARGS__)
>   #define DC_LOG_DETECTION_DP_CAPS(...) DRM_DEBUG_KMS(__VA_ARGS__)
>   #define DC_LOG_RESOURCE(...) DRM_DEBUG_KMS(__VA_ARGS__)
> -#define DC_LOG_DML(...) pr_debug("[DML]:"__VA_ARGS__)
> +#define DC_LOG_DML(args...) __DC_LOG_IGNORE_FLOATS("[DML]:" args)
>   #define DC_LOG_EVENT_MODE_SET(...) DRM_DEBUG_KMS(__VA_ARGS__)
>   #define DC_LOG_EVENT_DETECTION(...) DRM_DEBUG_KMS(__VA_ARGS__)
>   #define DC_LOG_EVENT_LINK_TRAINING(...) DRM_DEBUG_KMS(__VA_ARGS__)

