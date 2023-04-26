Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611686EF7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241339AbjDZPkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241140AbjDZPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:40:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195FC35A6;
        Wed, 26 Apr 2023 08:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klvdT+wgtegKhie2jJ6XNi3mKJ2BLbRlAOyMY1gM2plO0JvzGlpXfQ8Vqo5Zez3i7nRVOQA5PJVpr6zE1gYZ0CDzWr70eAYaEYd8oIFxa9NeSjIhDE0YqfGQ8OFKTPDEqoh+Hu4VsTcZgGmo1ugxk9FBE8wgF89l9Mgvk10L196/cJxFRmddNJRvKQ9Eaz07wddSRuii1f2vB7ghAxJlRmwh3z5dm74jEjbKlK39E5xS4sFfp+acRyrvbb0of58xjSFM43KOQNpAW+dNVlZfpPPb1eg/FoTVO+kZ/hXQixhzqvQVGJrRA/29GwKiX0vm5NN0kXJPActvyQWvx+TloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MilBx1PQ/5so6yeCvLmNpb6KikdERI6KxH1lqY1tD9A=;
 b=RgEvFHS466YszRsIqC6G7F8ijO+FZd1qnoTuCaGm/AKs9jXW6Wgetchyf+K0BTpsRYEG71ymJX5cHfu4/IslD55vNnQalIkd+n0hZVznKNXNCIE/GGk8VnHnry+81R/isPSim8drHayULfF3pRbt57WmRSWNyAq20xv3AMu8in3cjL7BI2GCMcTKcmS3s6OOdw7gmF/a2vC1WF1AXAM9CrpRx8OoQ0DAfAUQHVvI2KEfgTb4lHLZbNRWZGzjArak8zHo9E40rZ+GIW/vpV9Q6q1olqd+OxR1eD6c+1pzueRgbKPlOz2HwZUGp1AxCIvzVI4Ap9UUb72JPZP08/2w0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MilBx1PQ/5so6yeCvLmNpb6KikdERI6KxH1lqY1tD9A=;
 b=Ei2Qi63KUB3jSZKi2iCYkk97b8bLzbXqtN9NXfEOsHI2BBFg1exWcnTUXUYc3UzTe3V9ru1FeA2/lqlKyHywGZg4GBXRvnMXnWMIk99meZHK8mQR4Ct8QFH0KHsVjdxx1x1WzOVLgF/TQABiP9vkeF+yeMJqhT+eyggEe1sshS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 15:39:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 15:39:59 +0000
Message-ID: <7b869715-dd1c-d35d-f075-ec866f0b00ae@amd.com>
Date:   Wed, 26 Apr 2023 10:39:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] platform/x86: hp-wmi: Add HP WMI camera switch
Content-Language: en-US
To:     Jonathan Singer <jes965@nyu.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <20230426152139.1692-1-jes965@nyu.edu>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230426152139.1692-1-jes965@nyu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:408:fe::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c043b4f-b71e-4003-fa05-08db466c7e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LNs4nFWb/9WMWhOpanTAyHcKzNgEAW5hvjDZBW3XimtRSqAXDjn621Zwnx8qAGSW04IPbIuMAzcJ+k4qtZ9v9BPY2Obm2+aSH9JR7t4uN17KVHcNeYnbQLbUzl3xWyAnwHI3aJDRpwwCGujmgC4sRaXL7RWvyZI4my0DgeQRDAohX//FgvwjomI+A0pynznYrJNC/avHh+QHDluUXaT0zQTTHrpAxF2a8m2adY4sv90cZ9vcjgxXa++LFfyNAH4RWrZBYx9QjYsLEk503ZPZSm+vod20KByCPSSe1ixTBbkzRwOX6aw+DWdlxZc+lpmZsB9IIPn5sQUejkgAmZkklxA988G/mm5HD+Iz+Fp1BsjIhZVMyTggs8+R3zVCgIfVLNRdUq/HpRlv2s3Wqaovq9tXBjt/zmN+XqmpGzU4uoyyJyITyOE9tWWM3J4F70RJNy1a9Ctu3h6BU4xJyhJTmzHT1xhac/suToYnfh5laIFI0RZs8ruCTlnGt8JybMdlDDnGHbCp1xudfuFH8QOzw9ofy9keYGkJqfHlkhE80F6/prEpw5Xf53B4ZxD3mCFS3uTG3Vngdz3WL1VVO0ujXRiMPuS/hvSeQ9ut5sje60zzFEbQb+YP1f3dm6oTUwDUbJOajPnVzTVaWCk+7QnCBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(478600001)(6486002)(2616005)(110136005)(54906003)(6506007)(186003)(53546011)(6512007)(44832011)(5660300002)(36756003)(66946007)(31696002)(38100700002)(2906002)(66556008)(66476007)(4326008)(41300700001)(86362001)(8676002)(8936002)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q01GaHhIR2ZSQ0RtelF0dWR6b2lFL1JqdGJ5ODFnUy81TnlHYStvMGZ3a2lY?=
 =?utf-8?B?R2liTVo2cU1zdHg1RSsvTWlVSmRQTTkrczdPZlc5aEloZEpXalA4eEx2UnBh?=
 =?utf-8?B?YWdxV1lsU0o4NWFKcFY5TndnbExiN2wwRjNWcEhrL1owSllOclJhRDZKZjJB?=
 =?utf-8?B?OFRSdU9OejhHeTlONWUvd2hERVpsVUg2b1lRQkFJYWlyU0xJeXAwWG5UbjMr?=
 =?utf-8?B?UkF6K2E1ZWlyYTdKWUZhOWJoZXVsTWtnMHVwRWhSSjY3bGFNdFBnVG9FNzNu?=
 =?utf-8?B?dHRBejBsa2FhRWMwemdYUVVHczNGeHVkazVUV0crSGh0dUFmbkFBdWNWQWEy?=
 =?utf-8?B?NVp6K0RzZEcwNWY0SjJQQ3dhTWhFVExOT3R2QTdTSko4bEJ3S2hJaER1aXYv?=
 =?utf-8?B?cGNTNWQwdEhlUmhBeXpnMWk1SFNZdk9MY3dtMlN5cTVUeW9LaFdWTm5SM0Yy?=
 =?utf-8?B?Sm02KzliTGVUVFIxeEorN2FoZDd3Q2RoUlgvcG5PUERUMlhVWTZLTnpWQWcy?=
 =?utf-8?B?ek5ySnNzbTVNVmhxQTZMbEExYTd2VC9YZHhBeTQ3ZUErWlMrSEtmSC9ENlVu?=
 =?utf-8?B?bDhocitlbWwrNG54U3U2SHhza0lycHpQYnc3REhTUUViRHlEK3R1RmlYSHo4?=
 =?utf-8?B?Z21vRGlydjlXMmpuYnRtbi9MclRQdExzbHRDUDdXL2licXp5MDBoQnY0QXYv?=
 =?utf-8?B?V28xREtUQ2QyVWxiRzAxcndmK2JWZTArUUx5RldIdmJ1T1U0NTR2N1g5VEtz?=
 =?utf-8?B?N0crQ1pUQUdqRHZoeFpVV2Nzc2FZd3BFYm5CNXpaQ2JkeFVFblRxUWdYWlYx?=
 =?utf-8?B?Tlkzc0M1a09oUDc2QUp2blNGaHpNSDNMZVZEWE5LSm9RYU5qV2xnVTA3OFk1?=
 =?utf-8?B?ck1HNnAzQ0xpZnE0ZW4xZnYrYnBkak9Ubkg1NW9WK1QwWVU1UUlmbndXTkdE?=
 =?utf-8?B?cDgrUm1wOUNBa3M2VmZCNGx0M3cySTZzT1B5azdlWmRhWGhCakNkd1VLeGJo?=
 =?utf-8?B?YkpmcXJ1ZFR0ei9rb3R5VlJSek0vZGYydG9QclFMWDkxR0crNjI5WjdjZStS?=
 =?utf-8?B?dzZhR29hS3NlQ2hGL3d5SStSN1VxcEVCZ3QvQ2NoZ25xR01iQUtXQkoyeTAv?=
 =?utf-8?B?cDllUWt5RmRmV1djL2k4aUQ3VEZOTUZhSjBJTmxMYVdXaFRXQ25Tc01LTVo4?=
 =?utf-8?B?cXBJSXRiN1dHaENoUEpaWFBVSmpDVm1WOStYd3Ara2E1SHBJY29PNjdjUXNu?=
 =?utf-8?B?SlZtS3FTMk82aitzeXA4LzdraUNPa0NNcjQ3N1hlV3lPNEdlZk56TE1NMlZM?=
 =?utf-8?B?eTlwb2pFY0l0Nm5vNHZsd0JYQWtSSG0wemxGVmJUclNzdXVzQVZLRDFzd2xT?=
 =?utf-8?B?OFFJbWxBRjVaOEd2R1JVeVAweWhwcmd2STZ6SE1rYjBSZVQyUlhaTHFjY0pt?=
 =?utf-8?B?dXBYTWNQVmdBNTA0L1BSanVIdXVJYTFWMlF0dnkwZ0hkQUZXZUxqWEpzR3pr?=
 =?utf-8?B?VTQyYTZrT1lHV3NHei9WSW9TZkxhbjZqSGRwZkdSWFJLR3M0RUdsSFhaS3Uw?=
 =?utf-8?B?Z295RWZ3NDhVM3FvaE1jd0hxT0FiRWJxcEw1M1RrRk1IR09mL1RncWd5M2F3?=
 =?utf-8?B?T3hubm93bWZmMm5GNWdOdzZzQnNkNzhlWnlMSFVPeGRaazV5Mmo3eDc0Z2NH?=
 =?utf-8?B?QXdNWTRVcmJrdlBlQzd2anNtaThBU29CQS9lRUhIaWF3eHFhMGEzWHhYWHpu?=
 =?utf-8?B?VnF1VEpBL0kzWUN6SGZVUjIxK0VIY0dIbHNsK1VCV3gvM3JVT09tcTdRbFVh?=
 =?utf-8?B?VTZoYk53TzQ4YWJrMkEyeHFUR0hxYmNHdlVqMEV1QnFlV0Q3KzA1eHFnRkVE?=
 =?utf-8?B?U1BBbWZzbi9hMmNFWVhVaTlCa0d1TitNa3BRWGMzejZuMU50TVVtRDNvTU42?=
 =?utf-8?B?ODh4M2Z1c295MHlCdmZIZ21DWFNibmtaLzdrdGdPSGJLRnFndDhJOWNmS0lE?=
 =?utf-8?B?T3NZTHFodDdmU2laUlRQQVl4QWF1c3pGMGltUzdEYWxiaDNoczRPa0YydnFY?=
 =?utf-8?B?VnNnb1VsNU9jNWFiK01nSlZSL3lEcHJid0tLcC81dzJKd29TTG9lemprVlJI?=
 =?utf-8?B?ajk3c0NwS3RhVExBcHlKQ3JvN2lsSVRLbzUwZURqUGNBVXk4a1BLSXRTM1l1?=
 =?utf-8?Q?v4bTCJ+SwC1bU557DLCe6KEBldK5A/O+Iw3GkOVhh9jU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c043b4f-b71e-4003-fa05-08db466c7e88
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 15:39:59.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYqYBxM6oLKD+3yL1+syn6wbOHvyUodBQnbJW2HmaUTEA6HF3UZUP3J+h/CyEYcmjhNdmGdR3TCjSL45nTbVwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/26/23 10:21, Jonathan Singer wrote:
> Previously, when the camera toggle switch was hit, the hp-wmi driver
> would report an invalid event code. By adding a case for that in the
> event handling switch statement we can eliminate that error code and
> enable a framework for potential further kernel handling of that key.
> This change was tested on my HP Envy x360 15-ey0023dx laptop, but it
> would likely work for any HP laptop with a camera toggle button. Now
> we emit an SW_CAMERA_LENS_COVER event, on a device that gets created
> on the first such event so as to not report incorrectly the state of
> the camera shutter before we can know its state.
>
> Signed-off-by: Jonathan Singer <jes965@nyu.edu>
> ---
>   drivers/platform/x86/hp/hp-wmi.c | 50 ++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
>
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 873f59c3e280..a7fb33ac49b8 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -90,6 +90,7 @@ enum hp_wmi_event_ids {
>   	HPWMI_PEAKSHIFT_PERIOD		= 0x0F,
>   	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
>   	HPWMI_SANITIZATION_MODE		= 0x17,
> +	HPWMI_CAMERA_TOGGLE		= 0x1A,
>   	HPWMI_OMEN_KEY			= 0x1D,
>   	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
>   };
> @@ -228,6 +229,7 @@ static const struct key_entry hp_wmi_keymap[] = {
>   };
>   
>   static struct input_dev *hp_wmi_input_dev;
> +static struct input_dev *camera_shutter_input_dev;
>   static struct platform_device *hp_wmi_platform_dev;
>   static struct platform_profile_handler platform_profile_handler;
>   static bool platform_profile_support;
> @@ -739,6 +741,36 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
>   	return count;
>   }
>   
> +static int camera_shutter_input_setup(void)
> +{
> +	int err;
> +
> +	camera_shutter_input_dev = input_allocate_device();
> +	if (!camera_shutter_input_dev)
> +		return -ENOMEM;
> +
> +	camera_shutter_input_dev->name = "HP WMI camera shutter";
> +	camera_shutter_input_dev->phys = "wmi/input1";
> +	camera_shutter_input_dev->id.bustype = BUS_HOST;
> +
> +	__set_bit(EV_SW, camera_shutter_input_dev->evbit);
> +	__set_bit(SW_CAMERA_LENS_COVER, camera_shutter_input_dev->swbit);
> +
> +	/* Set initial hardware state */
> +	input_sync(camera_shutter_input_dev);
> +
> +	err = input_register_device(camera_shutter_input_dev);
> +	if (err)
> +		goto err_free_dev;
> +
> +	return 0;
> +
> + err_free_dev:
> +	input_free_device(camera_shutter_input_dev);
> +	camera_shutter_input_dev = NULL;
> +	return err;
> +}
> +
>   static DEVICE_ATTR_RO(display);
>   static DEVICE_ATTR_RO(hddtemp);
>   static DEVICE_ATTR_RW(als);
> @@ -866,6 +898,20 @@ static void hp_wmi_notify(u32 value, void *context)
>   		break;
>   	case HPWMI_SANITIZATION_MODE:
>   		break;
> +	case HPWMI_CAMERA_TOGGLE:
> +		if (!camera_shutter_input_dev)
> +			if (camera_shutter_input_setup()) {
> +				pr_info("Failed to setup camera shutter input device\n");
I think this should be pr_err.
> +				break;
> +			}
> +		if (event_data == 0xff)
> +			input_report_switch(camera_shutter_input_dev, SW_CAMERA_LENS_COVER, 1);
> +		else if (event_data == 0xfe)
> +			input_report_switch(camera_shutter_input_dev, SW_CAMERA_LENS_COVER, 0);
> +		else
> +			pr_info("Unknown camera shutter state - 0x%x\n", event_data);
I think this should be warn.
> +		input_sync(camera_shutter_input_dev);
> +		break;
>   	case HPWMI_SMART_EXPERIENCE_APP:
>   		break;
>   	default:
> @@ -1564,9 +1610,13 @@ static void __exit hp_wmi_exit(void)
>   	if (wmi_has_guid(HPWMI_EVENT_GUID))
>   		hp_wmi_input_destroy();
>   
> +	if (camera_shutter_input_dev)
> +		input_unregister_device(camera_shutter_input_dev);
> +
>   	if (hp_wmi_platform_dev) {
>   		platform_device_unregister(hp_wmi_platform_dev);
>   		platform_driver_unregister(&hp_wmi_driver);
>   	}
> +
>   }
>   module_exit(hp_wmi_exit);
