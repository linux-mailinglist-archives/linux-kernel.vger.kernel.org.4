Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCF667E314
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjA0LUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjA0LTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:19:14 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AC810A80;
        Fri, 27 Jan 2023 03:18:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYRvPga3oUCkEyQ3qOj5KM/IZXQqYLlW5qxzzZpRSp696AqC9IbIvfh9+TYkVSRGHwyBlCSOIh5NAFiBPvCtbr+tZwVNJNeaQLNSaLV++szkoCsNJoVYPWPrrY75zt50cL4zz1S9OiTYyS5Xk1EiQZIWtvlkV3rtU1EbF6dmdec0vNJAQ3OgFme+k/6YtiB3t0any3RdpQP8/JNnukGF7DVM7Eug1DQFdm705nZBlHWMSL1fgiwfd+9siLESCEl//E2kfjQU7IRofoubYHGo/txewQyHslDnWnqKhpLGuhEPRnJ7BSPsSTgX0h3pW2k0A4QhIwOwCaOYp2gyGEt94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKXfuoRIR8aC97UEs6wDSVQg+vWBxV+BPBh36bjsHcw=;
 b=kER/DEF8lGG4qj4L81vCHp+kE+YTCMGSJdGUY/BJ4Isn+vKjHt9vdQB9JhokcVMZn/TpImjglbJ+2sA808aMTk2Wmka04ixyRDs439+seJEe1ZlwSWUnT2a+U8bTj7LDhvDC8xP4k3yZS8otH3QIygr0V7Rx3cH9LjusMCWDUPgQAjkTQc2qAd+cZ9+UOVGC22uxnvmO7K7gvbUdQiPypnlF/eUoNoI4pXCKbmK9cwqLZBLVNqLMiEycPFywY89mrQbxlvBa0aokluwJu/YP248yOmkSEJ3aBkJPTaaMCbRMrNjABXICh1y2cEkvFwCwPtuTyeX0kCfqYa5kYBjQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKXfuoRIR8aC97UEs6wDSVQg+vWBxV+BPBh36bjsHcw=;
 b=unZVPH3L5Ig2fKUI3lFTMmWp9zW/3iip47XWZ3ztE0+EjIp8KF1/7olTqtSl1VQbn+7ktTp5iOlH2fy+3PYOoK1fSYRPVJ56ayLdQZ/aYiszKwJvt617MTlEhzyWboICG4nR7EEUeZxxS+5d+D17XKns4Mj71H5ibcCienAGITA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (2603:10b6:208:d2::32)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 11:18:05 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::d822:6ace:2a0b:eccb]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::d822:6ace:2a0b:eccb%5]) with mapi id 15.20.6043.023; Fri, 27 Jan 2023
 11:18:04 +0000
Message-ID: <9d0a15ee-c5d0-7d3c-7aa8-58383211f637@amd.com>
Date:   Fri, 27 Jan 2023 16:47:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 7/7] cdx: add device attributes
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        saravanak@google.com, Michael.Srba@seznam.cz, mani@kernel.org,
        yishaih@nvidia.com, jgg@ziepe.ca, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
        masahiroy@kernel.org, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     okaya@kernel.org, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, git@amd.com
References: <20230126104630.15493-1-nipun.gupta@amd.com>
 <20230126104630.15493-8-nipun.gupta@amd.com>
 <97a939cd-3898-3d54-e496-a8f33a62856a@infradead.org>
From:   Nipun Gupta <nipun.gupta@amd.com>
In-Reply-To: <97a939cd-3898-3d54-e496-a8f33a62856a@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::15) To MN2PR12MB3087.namprd12.prod.outlook.com
 (2603:10b6:208:d2::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3087:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: b0512481-b94f-402e-f1bd-08db00582877
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTS3X0ZFYrNJjv1F7sg/4bG5JLnw/6mrtYAzOdgDeWUXB1T/G7p9ixsw3wL7+kAZIm1jAgTnQ4QIK/0GPUggSWRz14wK0HqQ2ZVzhnVRV64aS4r3I8vFgo16cBLf3LZm88LBvxyvZgXdsWLA1TekClTDLEAhiYODmmhu9C3WO7sqoxBoBAn3svCCApL/8IE+8qW7Xxvhht8O1CJEBIp/+4FILlAIMee7pheb3XJpQwjvwgMkIpdqMvusy8EXMsGjVlHhUbvgt/cEmobe+1x76qyNaGKmxWeWjYFcporIWWpzfo7crf/M+j/I10KKtQkqoJ4a7r1FQSkfkFmuWisDjtBf4mo4g0kd1Kvcnaim+6u6oi3ppQwiWZUKaHTwmyk4KNwuTSHupvhxaSG3l1qzS/rN3KIsTwqhYvOESJJfLc6qD3ifIv8gKuNGVwZ1ZTobPPGuT8A6s6ckhDhjR/va6gVMDjxgCFcKU+59hdyZ8Gvb4/FJPXGk6E2B/A3ZS1z13G7MidT/U4juMou9cGVQZjbQrOpR4anGwdF5VZQ4Jd/78/lpRn+9Fsxp3Ha511lOKlH2EW9EkI2vh3OKHtJ8CTW5K2CrfF2IO6gLWXUtP1Ds/lTXV/mInJXuoeTnCZI6iZoym5AjloE7a9DQE/xTNMLU8QfQslWuP6euY2xrDux+R+/Gux4E4nAv+BJ3tF9IyJCDM5fS9zA5mTzzV4FwVRcRKQ1UOaI0BykNChMWtbO2PGTGTTdgDXZT4zTg+LHZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3087.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199018)(83380400001)(2616005)(53546011)(6506007)(6666004)(478600001)(316002)(26005)(6512007)(186003)(31686004)(4326008)(5660300002)(8936002)(41300700001)(8676002)(66946007)(66556008)(66476007)(7406005)(44832011)(7416002)(2906002)(38100700002)(86362001)(31696002)(921005)(6486002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmNlOGtXdDd5dCtJSUxPMG9NQjJiODAvRHM2V1Q0MjRaOWQrd2gzN2hkLzdJ?=
 =?utf-8?B?NzB2eE50SlZqUWpreGJDempjaEhuRmZSZndxbVBCWTJ0bTg4bko4TytUWmU1?=
 =?utf-8?B?QjBmZ0NDY2hSYVQvaVhUMkdxenJZd3UzV0VGdzlpdVNzRW9TaTYxRS9pbFhl?=
 =?utf-8?B?SndwNjl3TTQyS2c5dXdRRmRLK0ZMZ1g1V2xUL0E5ZzQrcnZudVRXYkd3ajdy?=
 =?utf-8?B?L3Fud2pyS2djaGJmei9BSTRhTy9RT0pxVUUyTkJRSzRZY0gyYzdRdmZ1TnF1?=
 =?utf-8?B?TkdJSmRFN1dVSlE1NDcwdFdxcStDK1pEd1V0MldVREZkdkdPQzNvRHIrR1FK?=
 =?utf-8?B?UUlwTlYyM2NVczhWRnhURDJDTXZ5ZUt2YnVkc1hvbGhjWENUSG9FcDFUSC9p?=
 =?utf-8?B?WGQwQVpaSk50UWM2L3lLbEEzTkhFRzdnbUdlRGVvQ1ZWN2ZEUGZ0YXZBbmtT?=
 =?utf-8?B?ZHdtSEZDRXNtS3ptT1JvNUttR2tKUDlGSmhnUmVkckV5YTI0TFhYM0RKYWl1?=
 =?utf-8?B?Z1c4TU9jcGFGMGRaejhzclp4RFZ1cHRUT0tDME1GQTY5Z2pqaEhZK294NGpj?=
 =?utf-8?B?TFN4WHg1MGJ2OUVzTG0wWVlacFMwLzUxTmhKNC84RWdZUHNqUW5adDVySE5Y?=
 =?utf-8?B?cHUwakNpRHRyRE1IRVJSSEVXR2VLMTcwVTZGZnNyTmtWMnB0Qyt2dUp1clZN?=
 =?utf-8?B?dzhsSWgrRjJMMEYvUHJJQTlNTzJrUDhUeTNMYkNxTTNDTWw0Qk9ieEtTNFRS?=
 =?utf-8?B?TUdteGtqTGZjRThSOHFKR2pzWEJwSHNJZWRPN2NhSlh2RlN1QVRBT1V4SnlG?=
 =?utf-8?B?TlpXS3dnN1FmanVYdEFJS1B6MzF0cEVta09DeTU0WEdQZkhtYTFHYlJOMmtB?=
 =?utf-8?B?UUM3SURiMmw2bVZWVk5CMVZlaUVUNkpDVmMzV21BdFNobkhSYXF5a2tQOWp1?=
 =?utf-8?B?dy9NaitPMDAyZXpVWjB0RDd2U1EyeTZZMVJScjQwdmdtYmdiSTJqSUxjbW1G?=
 =?utf-8?B?dTFKSlBxcjhMUFVhdWh5VUtaYlEvUUNJcUxlYU9nYmw1c0pPUTl0U2VKaUpU?=
 =?utf-8?B?SkI1SW5nQVh1QXpUUXNUYVpZbVdXNHNZdFRJeXRFcHJydGcwb3VuSmZzWlE4?=
 =?utf-8?B?VTdBbE1TaERobFJHWnd2Z3dndUVIZHdNd0V1VGQ0aFo0THRobnh0bW9aeE5m?=
 =?utf-8?B?Lzdsc2s2eTJuZmVtczRVcjlMVGtvbG5QWEZxUDM1RlNmQWFYakI0eVo2cXEy?=
 =?utf-8?B?R3FSaWlBcjBUcWtEV3NsMldnQTMwZzlaTXJLQkNodU1zUW9hKzJBb0pYcmRp?=
 =?utf-8?B?V0ZDTXIwNWF2c1BVemVSSHhTbzdkRHpZVUpHd1I4bEM3TWEwRUpuMHRrYWNn?=
 =?utf-8?B?dGR4ZmZSU3c5elIxa002MWJZdzFZdUZLNXdBT2p0UkpHSHE5WnNQSy9WQ202?=
 =?utf-8?B?QlZRMGxyalRwcE9PVnkrRVlVc2crQnA1VmMwd2htbFp4NjRUbDNaOUVJdm5w?=
 =?utf-8?B?NFVhdEhpbUZSK3R1bEVIL1dmeFZwZVhHeCtoNG5FRlVheGtuVC9UdHE3eUgz?=
 =?utf-8?B?SkUwTmprckdvdWp0Um40RXcwMEVXeWZROWVTRlptK2RqbEFtQ0JBVGxxSW5y?=
 =?utf-8?B?YllZWEczcHIyb3ZuSHV5MG84RHo1dDJWMTEwQXhUdVNpMXBRWWxyT09qdkR4?=
 =?utf-8?B?OEhmaHdTakZBTVh2c0R2V3pvdWwvOEE3T1NBMjFMYk84TWhSVmZKYW9TV3c5?=
 =?utf-8?B?V0hBYzZkUldSS2dwbWM1UEZIeTMrMVc4MGQ1ek91TU5pYlFwbGdoWFNXc1hL?=
 =?utf-8?B?R3JFeXgvTUJhZVpLd0xNSFdELzJlZGZ4NDdTZ0VmUEF1VVd3aU9jM2JBeHQ4?=
 =?utf-8?B?YjBSeG54NnIzMmhEV1R0RHZWTEtZcWtYUWhvSVNQTWkvY2JEVGl5cUZJQ2FH?=
 =?utf-8?B?bG9yUjFRcG0vSS85bmV4VEFrdnVxR3ZvZjhRM1h0SUJDZ1RiY2k5Smd2TUhi?=
 =?utf-8?B?M3lPK2NiVEVoRFptWjMzN1dqL1BnN0o3VmxJeDV4ZjM4a2Yyc2xzZjVMVnNB?=
 =?utf-8?B?eERvdUQ3MGxOQk52T3h1YkpsT2ZlMVdPSGYrMmdwMXpRVEVCMWQzUS9PYUpa?=
 =?utf-8?Q?i3Lq+xVE+xTOEelZgF8Edeg8C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0512481-b94f-402e-f1bd-08db00582877
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 11:18:04.4440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZOn/yaph/CyeVT4n3NO1DxmMvW7RzgzCuegCXHeIJ8kKUIO2GD2HRfPAsu4EHj+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/2023 10:25 PM, Randy Dunlap wrote:
> Hi--
> 
> On 1/26/23 02:46, Nipun Gupta wrote:
>> diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
>> index 8c2425fdb6d9..69bdbc891743 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-cdx
>> +++ b/Documentation/ABI/testing/sysfs-bus-cdx
>> @@ -10,3 +10,47 @@ Description:
>>                   For example::
>>
>>                  # echo 1 > /sys/bus/cdx/rescan
>> +
>> +What:                /sys/bus/cdx/devices/.../vendor
>> +Date:                January 2023
>> +Contact:     nipun.gupta@amd.com
>> +Description:
>> +             Vendor ID for this CDX device. Vendor ID is 16 bit
>> +             identifier which is specific to the device manufacturer.
>> +             Combination of Vendor ID and Device ID identifies a device.
>> +
>> +What:                /sys/bus/cdx/devices/.../device
>> +Date:                January 2023
>> +Contact:     nipun.gupta@amd.com
>> +Description:
>> +             Device ID for this CDX device. Device ID is a 16 bit
>> +             identifier to identify a device type within the range
>> +             of a device manufacturer.
>> +             Combination of Vendor ID and Device ID identifies a device.
>> +
>> +What:                /sys/bus/cdx/devices/.../reset
>> +Date:                January 2023
>> +Contact:     nipun.gupta@amd.com
>> +Description:
> 
> Reads better without "would":
> 
>> +             Writing a non-zero value to this file would reset the CDX> +            device. On resetting the device, the corresponding driver
>> +             would be notified twice, once before the device is being
>> +             reset, and again after the reset has been complete.
> 
> 
>                  Writing a non-zero value to this file resets the CDX
>                  device. On resetting the device, the corresponding driver
>                  is notified twice, once before the device is being
>                  reset, and again after the reset has been complete.
> 
>> +
>> +                For example::
>> +
>> +               # echo 1 > /sys/bus/cdx/.../reset
>> +
>> +What:                /sys/bus/cdx/devices/.../remove
>> +Date:                January 2023
>> +Contact:     tarak.reddy@amd.com
>> +Description:
>> +             Writing a non-zero value to this file would remove the
>> +             corrosponding device from the CDX bus. If the device is
>> +             to be reconfigured in the Hardware, the device can be
>> +             removed, so that the device driver does not access the
>> +             device while it is being reconfigured.
> 
> and: (also fix typo of corresponding)

Thanks for the review. Will fix and update these.

Regards
Nipun

> 
>                  Writing a non-zero value to this file removes the
>                  corresponding device from the CDX bus. If the device is
>                  to be reconfigured in the Hardware, the device can be
>                  removed, so that the device driver does not access the
>                  device while it is being reconfigured.
> 
>> +
>> +             For example::
>> +
>> +               # echo 1 > /sys/bus/cdx/devices/.../remove
> 
> --
> ~Randy
