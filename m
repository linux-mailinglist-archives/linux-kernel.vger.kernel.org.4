Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCF96FD9E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbjEJIsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbjEJIsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:48:45 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1786DE69;
        Wed, 10 May 2023 01:48:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbD53cRZuJBiJtwNGE1X4zzj8jNcjNwcWUqg3ShOdYezVME6S1AcPWR0P+C9PusuZX27rpkD2G3mf2NzqbyOateiOBEQXm1mtSmE93zwtwPGZ5eD6EytglDuVWYT4HD5eAuOAwCugXsX0zAuA+oQTPeqeGcACIESmbObgquYNZOI24MXhJKxFUJAsNYqq0+3QSrY6ge+5jlzJ2jmDUgPAfYmn9esBxM/cVU4KODfNSpicuE7/BkJEVcuc/YvCmr1LEJuJkkAefXxhwGVjjLGHUwqMORRLXT0vOgsnW7NhbDtJlfXUjbPEHLC/sjEp3CtPvvSvgXCOzs1ubOD7Dj+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bluWGJmrtO6+YoJNSTOJX3xpI9wJAGqGZ2MBcPqzMbo=;
 b=aySY4pU8z9DVdZK3Z4AL5vgy/LhFScvYE29Sg/PGa4q8Ecjfe5ci/5WdLGc4jkaoMEdSvyg52VqeDrAymzZ4djYEB2tmZphmsvq4EBhWgG+1NpFP6tYlSg2fByHpqqyfAOkgOD4E7Mtfs9Uc6qLxvUH4QCbIT20pAk+XRFdfnhMm9O8/gjMIZp3ayxXgJniSke8aw5uB+QQaSVEOcAoWiqZwNR4bMBST+LEILnejRu6DxBX3RHt7oOkKT7APv4vnY3GqEJ1sZvDO7S1EyPNKIU5mbZ3XzY0Bk5Dhi6X7R2cpe3Z9IL9KRZv885a+EPhaXGc2P3YUwXn26DS5WI0s8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bluWGJmrtO6+YoJNSTOJX3xpI9wJAGqGZ2MBcPqzMbo=;
 b=ir2Wl3vRteTSD6UHsfflNxZNFkiTO/LCwZFNIj6bZv97fVCiYa2pAsS8Z7NJtu+LjtfrYwp8RfgwaqDY75UgrliK2l3nD4rIj3mKIUYWRIyAw4ZYUDZe3w8bwMvE1j0CF68orhn3wom0AVv7oOzXf/7ogEsXElDX5DXUL/pNLcauv/PHy6bnK5Q6tFWfImYQ32fTuZkV5DPRKI+V8anR1xx7Ndrtio+tX8wKwxGmgUtJQ9gL96+nVDaQprV2EYUMIpSrdeka7Ey5HK+rceN91xgEzF+D5jd/H+bRbxzXUk7IWaIvMu2+6XGbRGr9JI71ObLtfAmcQrVZHZn0suoxgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by AM9PR04MB8082.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 08:48:40 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::c1be:e15a:5cf9:b881]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::c1be:e15a:5cf9:b881%4]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 08:48:40 +0000
Message-ID: <d63c25f5-0b10-b153-023f-4b2d4a42f9a5@suse.com>
Date:   Wed, 10 May 2023 10:48:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4] ACPI: cpufreq: use a platform device to load ACPI PPC
 and PCC drivers
Content-Language: en-US
To:     Kevin Locke <kevin@kevinlocke.name>
References: <20230316151036.10181-1-petr.pavlu@suse.com>
 <ZFreh8SDMX67EaB6@kevinlocke.name>
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        pmladek@suse.com, mcgrof@kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <ZFreh8SDMX67EaB6@kevinlocke.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::18) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|AM9PR04MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: b83fb943-f798-49d8-3b05-08db513359e7
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EoHulkyO4cQ0k5qq7Oa1nRCLyBprP8r0LfEFc2b4aLz6kcktbAH8GStvs7uUqilTDF+MN4UHcpZZv4v72EmEIR/OrFUlxgrX+o7IkA4B0lJOYjW5+nTaYUb0rPiMAklBI3og9KCRyRFDF0UsWLMe9L7G6Z4+J4kxxVabuK1B86dHyhXCGBsHmtvpgCcbFxSesfdY1UVtV1HhKCTNBEjb+139hTSTJwrU84IqkMv01EC6EYMpuoVNIlwgqDvYwzUwF1Zh9jLcjp4YbOJPd7/atBfy0SIq+l4CPg1ZpdBvJ0b9F9j/gC5FMFXA3ObznZn5h9ERyzA5ZH0pAC/rj6K9BmzBCV6+SOusY1JH56ed2UbiSLCGuU6YTpWKAqDz3RZAN6syhFD8Wsi1mrd7rgyreChhsI6iTod12oVwjs5E06XWz9vQ0FpLwi8dSdlcpvcg1WduPJv4ARZsU2qheWdKTljjDicvqvLbqpggpYVdDKOoyURCAnm9Lv1V/EwAZ91Up8LTKovoP1dEEz3446+ap32WxFcFgAMqKBVAsMFU6E7uzXJkt21kMp23cDmM5QIdlHw8GAVENv7XxsonwswxBMP9JZkH8Ar+4Oq1kylT9UziAzTL8LpQRseRuP7fiLINWH6qe8DmBOI8vVlH7PofkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199021)(66946007)(66476007)(66556008)(2906002)(83380400001)(2616005)(38100700002)(86362001)(31696002)(6486002)(186003)(53546011)(55236004)(6512007)(6506007)(36756003)(26005)(478600001)(31686004)(316002)(4326008)(6916009)(8936002)(8676002)(44832011)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDdYR3VJUklJdUxJRzZ3MmJmM3FoSENxVHhiQVVlR1FnOXBXcWoySFdUeDlJ?=
 =?utf-8?B?SytJY1drTWh6Umovak12WHp0OWE2WU5XL3BXYVo4TnhpTnM1dVY0a3I4YmJa?=
 =?utf-8?B?M2J4NW1oZldzWExSYVVOZUJIdERzbndUMVVOL0pQYmxKUWVDTEJyRkJHV2tQ?=
 =?utf-8?B?UWtGMVB2ZS9RSUtwRWtxTVdaZmJhSEROYWNEczRiWTgwQjN3Z0lLMU8zWnBL?=
 =?utf-8?B?UWRFV1VEbC81NUZESmlXb2c1d0pWWU9qckl2R01uZ2ZzY3NpejAvZVd1UDc0?=
 =?utf-8?B?NG5hUVlsTG8zS1ZHUmdMbTlyNkJKeHN1QWNjV1JtM0xxeXIxU25McFh0QlFX?=
 =?utf-8?B?ZHp6alhLNU5oVHJPdFd6ZnpFVkkvcEI4VGVxb1p3aEJaUXIzWFFIRzJrblhD?=
 =?utf-8?B?ai9oMDVpNlZ3cTBxOFlvOVRVaW5rMEs3ZC9RMTFNTnVLd0JBQXRuK1ZFUTFu?=
 =?utf-8?B?TTI2QkFBTHN3R0RhSG5Tb3BjQ2xBQjgrQ3J0V09OYzYyTGZuQ2Y2Q094M2g2?=
 =?utf-8?B?U3IrMWdyQThFRVVUZFNvblJTbXN0RlJybkUrcEpBcWIrWHR6REpzM1hscXJr?=
 =?utf-8?B?Sys4R1doSE5pZU51U1ViU1EyRWlVVWh3cHVHTk5jbnZrZHJOUmF5QkpzQ3k1?=
 =?utf-8?B?RkNDaDc1Ky8yajZrK0c4Q3dTSnc3bWJsR0xic29lb2dtZFp4UHY0OGk5eEZa?=
 =?utf-8?B?akFNaFp3bUlBa1BrTTdsMTdMOVdSR0daYVE5VHhPZXZvU1hOdERVMjEyY1N4?=
 =?utf-8?B?bzJiVnRpRE0zS1NPcXBEcVc3VkVVSDM1TFNXWHIzcDZaZkVId2RaSDdxMWhj?=
 =?utf-8?B?VjJPMVhQNFNCM3pmZTNmeDlnVFcrR2NMMWVLZUIwYzRRd1BldGZZZnJ4Vk1l?=
 =?utf-8?B?aitYY2h4MTFTMGVvSjBrVWt0Y00wQjN2SFhMTFBOaTVNOUdpbWRnQWdMRVdu?=
 =?utf-8?B?WUp1d0JJc0JmYVQ2VXRzV0ZUV3VzTzdQTjVVZ3hZUEZwYUtCbkUvZEI0RTdy?=
 =?utf-8?B?ZTFxMTV4THZ2cW8zd284bE1KZExFdkpLekE4SW1LL244VU56WW5vNXdTK21B?=
 =?utf-8?B?TUFBcWpIanR1aGhxMUZTZVVPbEE1cFFXZFNQOVg0elYxVXdxZHRSeHMxWUVP?=
 =?utf-8?B?dHl6U0djd0FFM0VmY0ZBTGw1ODF1V1R0R3VGOFRSQlp4emQvK2EvWlVWWFFv?=
 =?utf-8?B?UDJIZTQrdlRUN0oyUGZob3FVZVE4dTVaclBHRVRzM1AwV2hxTmZETVNoZlFx?=
 =?utf-8?B?MEdpajBObk50eWtpc1ZGSkJSZzVROTgra0p6dUNIS0ErYnZ6NThEcWZHU2k0?=
 =?utf-8?B?NE5mS0laK28wWkFYbDVJZDh4OUhmL1A2LzhZRzhodThHYWU1S08yRzlJTVJl?=
 =?utf-8?B?Z2ZBYXZrVUdwcDAxQ1V6eVNRY3ovYXlpRUV4Ui85V1hHUittZ3ZDWG9wQmtG?=
 =?utf-8?B?bGxPVzVlemVGZk1tSW8wUzZwa2RtV1JYSkh0M3JFMnNPVFMzYUNYeWw3Q0dr?=
 =?utf-8?B?S04vdjZWVWt5cXQ2NGdHMW8yRkU3Q2g0ZWJwd1BIcVd3STdlQXAwWlZoUjY4?=
 =?utf-8?B?TnRPRU16Z1FLN3FjSjkyM3kvTkM5UFE0OEJuVktLcW01UXUrZWl6NFhHQUxK?=
 =?utf-8?B?TFU5aWozbjhNSnR5YVZyeDlOVkVLMk5KRUV6NzlGbWR2VnV5QXBjUEpYeUVM?=
 =?utf-8?B?bEFkb3JuWkJFZ29Ib2dSL1JTVmtQUHRVRVdtQWYwTFlrQ210cXlDSGdsbW9B?=
 =?utf-8?B?VXNmZmtKdkRrd01IR3E5QzBma29IN0h3NmhEbVJFRFlLcEpCZlVmV1Bqd0oy?=
 =?utf-8?B?c2pDMWQyZmVZV1k0L25PTDAza0xoRVlhdHU5TlAvbXJIUVl5LzNOTjY4NTk4?=
 =?utf-8?B?Q2ZqNFRncEFPOGtybk5MZlg3NG5tMFF5S2dNZ2ZINDdiNE9mSFZIWDFIU0Rr?=
 =?utf-8?B?VDlYYlRvcFllbkNiN0d6MWt2dHRvRDkrS1VldUQ0WHVtbUJQRTVaazFiYk9o?=
 =?utf-8?B?aXJVdGF2ZFp6alVWQzFRVEFndEgyT3N1ZWpxRFc4MDIvckhEM0hGM2l3R1Zp?=
 =?utf-8?B?U2VRTXV2Q0tyZXp5TFJxTThUaE1qckhxQTVDV2RKaHNYdWR3Z3Z3MlRrazF5?=
 =?utf-8?Q?bJdBo+juSbmjPwac98Cr/mOe8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83fb943-f798-49d8-3b05-08db513359e7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 08:48:39.8239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ySClGdg//1wB7DZG5vwTCKJkpsharVzhNx1elL8yrlCUDy0sF88msJpxSdskQLTYYehBgoKNEVfJWTBrPyKew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8082
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/23 02:00, Kevin Locke wrote:
> On Thu, 2023-03-16 at 16:10 +0100, Petr Pavlu wrote:
>> The patch extends the ACPI parsing logic to check the ACPI namespace if
>> the PPC or PCC interface is present and creates a virtual platform
>> device for each if it is available. The acpi-cpufreq and pcc-cpufreq
>> drivers are then updated to map to these devices.
>>
>> This allows to try loading acpi-cpufreq and pcc-cpufreq only once during
>> boot and only if a given interface is available in the firmware.
> 
> As a result of this patch (691a637123470bfe63bccf5836ead40fac4c7fab)
> my ThinkPad T430 with an i5-3320M CPU configured with
> CONFIG_X86_INTEL_PSTATE=y and CONFIG_X86_ACPI_CPUFREQ=m (Debian's
> amd64 kernel config) now logs
> 
> kernel: acpi-cpufreq: probe of acpi-cpufreq failed with error -17
> 
> during boot.  Presumably this occurs because loading acpi-cpufreq
> returns -EEXIST when intel-pstate is already loaded (or built-in, as
> in this case).  I'm unsure why the message was not printed before;
> perhaps a difference between driver probing for platform and cpu bus
> types?  Although the error message is not wrong, it may lead to
> unnecessary investigation by sysadmins, as it did for me.  I thought
> it was worth reporting so you can consider whether the change is
> desirable.

Thanks for reporting this issue. The patch moved the setup of
acpi-cpufreq from being done directly in its module init function to
going through the probe logic. The reported warning newly comes from
call_driver_probe() when the probe fails.

One immediate option that I can see to silence this warning would be to
change the return code for this case in acpi_cpufreq_probe() from
-EEXIST to -ENODEV/ENXIO. Function call_driver_probe() then prints only
a debug message about the probe rejecting the device.

-- Petr
