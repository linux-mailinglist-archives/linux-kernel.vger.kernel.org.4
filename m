Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB9C6B2316
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCILdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCILc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:32:59 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC37C5277;
        Thu,  9 Mar 2023 03:32:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrATZLpBnqqzapAULjnhtcfHhsFGyrH62Dyn49YR/eP1YwztQniLcn58P8oZmOR0YK0CREEuRG+/WktGV3ZkWUNAU0GW/w7ftQnsj41Lu6GpPY7eTUXB48fxoYqvU3q0rdbzmRh4tYmWqjp8V/Hz8ERHw9VL9Nzrla6mDFliEHuK/gt4CJ2dOsG89ZqiQKkuQbxwbHE8C1lgP6rmE7FIOC2ZrnNKndJo/gcwOeeCEcgd26C/WP3Jwj3TC8AGWKzSbhIAWu1YDoUVriZG7Hfiiw3cwOa/gO5FQk67AXvPrP0EZkZQkGw7Rhn7Yt/BVXBGVmidZ11bnu2l/R5A+sZSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wt+irh6E4LNDD72G2FQCU+PsBXMEjcPPzE0oZD5hlk=;
 b=T97cjVCNiqFhXTXRy7V3WwIy7Zs/e7voHz4OeUqiY0LkQ8srvBHDmvdvqJ1XL0e4V6Y98qYd5+8t6BaT6ZXKJM74loIKUP0bDCFClBkDGCLZ8WKDGV9QzE/CQGreS1oLG9cG4UY1oQlIw3OMjRtSpOPvBQxuCoR0gz1gnGZiLZOmlPehM6z/CI4uPTL32l4L1b7uNLl5ohdknnvL4peU2oBYvXAEx+yTueNLW0kloSD3aq/ObcnCwR6Ut8IL+zpARbndephqfiMkAVBOwuUA0H6qRBSX9jdhSYoR7L5hPgz+1CGMpPkESH3HxYNOi4VmOCckpD8b4ineEFZ/pS3k6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wt+irh6E4LNDD72G2FQCU+PsBXMEjcPPzE0oZD5hlk=;
 b=Ti8skcY3wE32Tm36NJsstXhIpD14z16xheW10g3lmULX8r8Q64pdoNs/cgrwEwuY6OprM0PNLSvOOdB6Oprw0A4PeCS3ykKUMrGzpeC8Ca2mii2bz4sqDVkEkIc3TIyY5fYNhHftgQgKArrwJVR009Gh1GAGorL3y7FM0pxhIWWIRO7EvDwawVyUqv3XyHPENloLEyr0E66tkwoQ9m8kz/waJekkyrJjv1Sv4dT5M0Hejj9ouVe+ZIJLcZ6wZtbyqX/67YQLwf+1ttQNXTfHS59qhugytLH5P0YQ4mqZr4xeY1faSZEgdxXy+i8T8SSUEpcvMQsOq2QijWMQcN19Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AS8PR04MB8200.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 11:32:52 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%3]) with
 mapi id 15.20.6178.019; Thu, 9 Mar 2023 11:32:52 +0000
Message-ID: <9a05953e-fc43-3223-2c96-8e12eac93bf4@suse.com>
Date:   Thu, 9 Mar 2023 12:32:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 27/28] sound: usb: card: Allow for rediscovery of
 connected USB SND devices
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-28-quic_wcheng@quicinc.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20230308235751.495-28-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::12) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AS8PR04MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: ef912e41-d57e-48b0-6460-08db2092048c
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKixnNsVS2SRwESte1ztiWbxBWS4LyU0P0Bgun0OUHvG3GhdX9JH/et2UT3rwMcrcMvMghB2jN7HZsNAqLf4smPUvLUB6rzbGRSooCN0iUtjMMBNJyXXiU2XS3+PFpgvO7qYP6WU7uAzD4sx6Dlfim8I7vS6+F+3PIoZDqoNsIqodk8jzJHUBVu5YgCNaU8e06Y9NAbrtRE9C5Tx6t5Aotd5k0Sl9SGxTKKZXhIyF/pczUX8UuGpXp+fg2GibQYb3vo/RDoSIyY5yymTrcLRDJo2VEqC4y5zTyX9hl+zhkyVNsdG87k7YqiHtQWSRVK8u22HQKtGyA/tqYF+gviE1uDLxGklqXESggbY3NuVYP8ngIFRmcdzy73qtEC34hJtbdU5n6EVRQ03XxuzAUx1cArd3h5Vg6o6qOE/s9s+6Jq5gjr3fKx7Cf2SaNKp3p/gJuzX2dJEHuclg5AMkrYmu7Yk/tQP2UEPxKOVVzdo6FpbhjK+6u48p88YpNdeZrY5RZJGMt5zKFCY/pU+fTOomofFpVbJwrDst94CXOJ8xmA/h5p/Bti/8FuLIJN7g+ds4Is044Z03uVclBOMwdCKur4J10cv/ukajH0GCwZSJCdCv/MIkv5B96lk6sqRSp3ZLCW0UXTuzuNAuQab9yNh8beb+/mQkKON2kQSaN9ASAXxROC7+AlknKFTAxnEk0U76IVSigadps0Fz3jnpyJ10ebIoEcLlx5Gs8zx4zk+bToKYucKPy0wmwC54wS3sDHV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199018)(31686004)(4326008)(36756003)(5660300002)(41300700001)(7416002)(8936002)(66476007)(66946007)(4744005)(2906002)(66556008)(8676002)(31696002)(921005)(86362001)(38100700002)(6512007)(6486002)(6636002)(478600001)(316002)(6506007)(6666004)(83380400001)(2616005)(186003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEVEcjBGQitjVisxd0ZacHAvWWdVQjJiRkFUSGtXNVZId3RLS1ZLTWd3ZStD?=
 =?utf-8?B?U3BIVVovMWNRNHk5VTJ3UXhNc216NDhkL1JTZFVUVkRicW4xOHRYRE13ZHQ1?=
 =?utf-8?B?dkJRVlVGWHFOaCsySGZ4UGVrd3NBM3Y4QkxaRXpCZ2Rwdzg0VkhzeGx4RlFm?=
 =?utf-8?B?bEF6akJNbkVHR1YrYnRWK2VJb0lRTWtHemNZNlNzam5IZW1HSkt1ZUMybFVT?=
 =?utf-8?B?akIvOW1GR1d2SWQ4aE5ybUdzbU1vK2l2UDBCMk5EN1RlUDNUY2RWL0ZyZXc1?=
 =?utf-8?B?L3N3RHNZQlhGMGhZeTdnYjQ1RUs1SmhiMS9ydWN4cGdZWnVvVkIrSi9QaHo0?=
 =?utf-8?B?dzNkeWRONTllZGFMZ3l1eEplOGVnakRiTzM5ZThUNVplK3pudXBnM3VHMHlV?=
 =?utf-8?B?QVdhZXZGL3YyMThZLzQ2SDJBSzhEZ0czbTNJZWNwTENzcUU4OFpGNkFJU3lY?=
 =?utf-8?B?UmthRzZNRFRGamI3bnprdklENDUyaWZOWEkrUmIrcWRJVDFnU0xMYjV6MWhy?=
 =?utf-8?B?aStDdmMzR2ttWmdaTkREcDIrYzd1UEJDRDNCQXpLZEZ3L1MyNTc0MGFvd0Iv?=
 =?utf-8?B?VGtKMzFrSDVveDhIQXpOSzNKamxrVnRjTmxKaXc5aGh3T2FwWmVnTmx4R0Jn?=
 =?utf-8?B?QUV4OTJGNXdrTU1RYm40RFNLYkd1eHhxYTRFUzErYWtacDduRXBnVlNSNTVo?=
 =?utf-8?B?OG1veFlCUCtpVkw2TGk3SmJKaXlVSm9NQlVqLzJmdVdRTC8rQ1piR2Rkd01a?=
 =?utf-8?B?RDU1M25jYVVaTEtNakl2UVlYaURsVUZRSjREQml1cEpHRTJKbHduZSsxam5D?=
 =?utf-8?B?RXd3UUVkQU9oeHYxd09DcUVpc0FBSDNKZWR0b0JMNXAwL3ZaUy9xLzFWd3Zl?=
 =?utf-8?B?eEo5U2hFcEl1alV5NUFJTXppRmhmK1ZjU1hueGt5TUlFVEJGMXN2dVQxWk9I?=
 =?utf-8?B?My9oS21CYll3RWM2citmamx3NUljTEdrQzZNNWM1MmRVMzVVTlhBaldabExS?=
 =?utf-8?B?MnN5cjdhYndwemF3Skl3Y0lmeHNHQkZKRjlwYVQ3ZktvWE50djBDQm5Gc2k2?=
 =?utf-8?B?dlZZd2NXR2YvMTNZM3lLTU5vMVdOVHBPQS9yT1dreFBVQ3luNEt2ME85K1Ev?=
 =?utf-8?B?UWtkN3B2cXgwckJJVUdSMUtMTTg1ZytvRDdvdkN4SURYYTFRUzd6RmcyZGZu?=
 =?utf-8?B?REc1cytQTVpRbGZFOFJLMkRtb2tjOGJxSWh6Szhjd2EvbHE2aGdya1hUb2xR?=
 =?utf-8?B?d1RsVG9VSWp3Wkh3am1tSGJXZzFmSnhvSEpaUFAyNXFPYU9yZUptcS9kWjht?=
 =?utf-8?B?N2ZWek43M2w5K0xuMk93VVo5T3YzQmxWMlhFU0pYWDdicnF0VGJwaDNwSll0?=
 =?utf-8?B?MGY1UXRxOU1MSnozYS9ZVFRLTlE2Qyt5V0ZQL2tVcDN5c1JVVmkxdTBzT1Nz?=
 =?utf-8?B?ZFdRMlkwRndmaTYyTVFBa0Z1aTFSdkdGeEZ6c1pNcEJLa1NXN3oyMlA1dExo?=
 =?utf-8?B?NVlwQmFtbjlIQThNWjEzcXlqdGhkNE1vVjhlM0EwVFV4OXRlMnpVcm5taHpK?=
 =?utf-8?B?eG5NVFZ5M2R1K3lPTjZpTE9JZ1FpU21iQXZFNkp5b2E3Vkdoazc1aW5DT1RT?=
 =?utf-8?B?Y09iUW94RzJqVnp6akdJQmVQaXllYmxBYWNEMHFKK1Vwa2tKM1JBak9JYTRu?=
 =?utf-8?B?Q3lMWExPUXlMNEY4eE51Qlk2YWpPbm50WjJvVjA3UE9nYWE3Q0lTKy9kRWpq?=
 =?utf-8?B?Snpib3pQMllzZ1BYTXB0YzNNcW5ZWmJ0VjNVUFJla1BUdjRkTmxlMnJ3VTA1?=
 =?utf-8?B?c3h2cWloYXA0QldxQUZkRjBrcEptUFNhOEdoMDdPa0tHRjV6b1BtUWZjZ2N1?=
 =?utf-8?B?dDNqekhqZEg5ZmlsM1RTWTU5aXRRanIxWXlmTTlyQ1dyYkg3VXdJajlzL2NB?=
 =?utf-8?B?UE5KdkZhczBQNDBlZHVKOE12UTQwekVyTWZuQmFyRTI5cktTUzZ4cFhTM1Nv?=
 =?utf-8?B?ZnFaM1JRelRJb21hT21RMUdTbUN1YUxNNThDV2tiNEZPZVk0UVlPOE1vck5P?=
 =?utf-8?B?ZnVqLzRicXdMMkxPdnBST2lsMWloUmtjblVoSFZxMlNoOFg3dlk3b2NlekRF?=
 =?utf-8?B?cTg5UEZFMzhrbXBkV3JSaVhxMGhCOWFweThGOS83cEdsZUlqWEJDbXpNWFNX?=
 =?utf-8?Q?rzGidzUUwFAA/9n+L/TSQu+Mwm7FltOxUxpu+ar82r/V?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef912e41-d57e-48b0-6460-08db2092048c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 11:32:51.8243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2EKruafpNH6a5roXDjl1SJh7VHSZVZWlIFpg1jJYbo2SyL5FMMqPQw0c39NXw3oRly4CP/lVk0qhmmhzavpHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8200
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.23 00:57, Wesley Cheng wrote:
  
> +/*
> + * in case the platform driver was not ready at the time of USB SND
> + * device connect, expose an API to discover all connected USB devices
> + * so it can populate any dependent resources/structures.
> + */
> +void snd_usb_rediscover_devices(void)
> +{
> +	int i;
> +
> +	mutex_lock(&register_mutex);
> +	for (i = 0; i < SNDRV_CARDS; i++) {
> +		if (usb_chip[i])
> +			if (platform_ops && platform_ops->connect_cb)

Really check this every time?

	Regards
		Oliver
