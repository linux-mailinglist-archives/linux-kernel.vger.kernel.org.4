Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B141E615A4E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiKBD2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiKBD2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:28:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1484D2649A;
        Tue,  1 Nov 2022 20:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFDbg+rYyIUyKfr/OHbWn8CBc+GAjFsXHmw8DF6mjAq8zZyh0f3BrBCOI4zJFaISjq5yHBZYePk2mVnmrmx9TyCNdFqivwOPcODGP1UUfiuMHQFXSilyzHH6Y9aKhFUoNP6O+aCNeipx6ccE6ki2IQlvIYLLbeneHuB+yjcIgPe6rNGhWoq+3Zt8GAHQkyRfo9L0VczGVW8iSWVBJbZ1W0FESNkxN9MveApnVxV5XgwBu5ludzIwxGMJb41nEf0aLwlslDKg5UOM8A5oPtghyVXMMh9d+jIRE6uA2N/IIsKXvp+avep338UNcYTwYCgM4bh62ifARD4RyV2xcrgeMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kYR09R0SEPd3PYq+/O3UkoYKiF7/2VEZmrPjxZHoZs=;
 b=PezlssaLKKr+JnabO90B7ZPhNcxRc70DPlv2kwHPMBz+yGzG9n4yxpE4EYvl2IeOkC1MX30IyOk1iJg9nXv/JHEZ1bqCiTVjuqIhJXK29Uj4AhJWF7AC+G8dwM5s+d+GLPPqStyHSRk1+5xhi/PAefCLv85TTXpGEOAaNH+ltYIXvIIbZuy2frXS5x3lamp7+h4blrqLKT13/jgGTUUpIVGOe67cuAgj6yHlTNobStA0CpvMiu+SzeX6cJ0A3I4gTeFw0yleBlELWWvLGumsZpad9whsC9M5T+KwxmP1dtdWsj1/0ulIAzTG1ba8s+zHJkNb/R+OCxs47IWTzBBnpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kYR09R0SEPd3PYq+/O3UkoYKiF7/2VEZmrPjxZHoZs=;
 b=zA5+edhnHIrInJR+4S9/W0XqnfDSUH4JSoPEWu2kEYI2+yFrUpD0P/jKQEnXhGP7rjD0p3dvdAV+2MGhKGbgiPtzRkZLhfnQeLQXEgcwiyV0Lu0nRu38a4zCbk+UD//DVPB6ooVGGnY8+wRiciCtdH0UPBBkre8FytkDfa7JDFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 03:28:14 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::2bab:22af:45c:7c9e]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::2bab:22af:45c:7c9e%6]) with mapi id 15.20.5769.019; Wed, 2 Nov 2022
 03:28:14 +0000
Message-ID: <8651f249-baf6-9708-2cdf-940d35de9c4c@amd.com>
Date:   Tue, 1 Nov 2022 21:28:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] platform/x86/intel: hid: add some ACPI device IDs
To:     Ivan Hu <ivan.hu@canonical.com>, hdegoede@redhat.com
Cc:     markgross@kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20221102020548.5225-1-ivan.hu@canonical.com>
Content-Language: en-US
From:   Alex Hung <alex.hung@amd.com>
In-Reply-To: <20221102020548.5225-1-ivan.hu@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:303:83::33) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|CY5PR12MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d21b28-5784-42ba-6bb0-08dabc824653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z9kzfASl0Y6T/E3mmD5NLPBPwZ+kzxXiwov169fhcg5+Im3yIV0Y96y1NJMHQTKFbU849ymvWlSYGH+jcKS6iO1jwDItchX/uEP/jgeegIp+zr/nA9uc7zri94C0szwE8Ulr/o0wUoJIPoRFt3JIrcFrcCH5EOa7jvYphuYDS4cS86hT4cy+4BbXSlIKMYP9cM1LWdujc0fgrfKXSmZ0oThkU6KKZeUtUGlys0mP3UJD2Fqimnk+gFdKnVVJQ/x5+qIzGWQHn8oKaMUQY5ODqwLzAcmbzC81l3U/uH2OM0tM2Ht4oEMlJD11tdIrN3zffxmKKC/R6c9t4vRl6um+8SRk1BxVnxFQ7VLRBzwnzfRR2FGi9e2bTJcweSpMXRhYEHxbZg/yL1ppMo4oVMNQtpRjPlJiUmQ3hF8cbBsHohUWdh3mrRHDlfhB0qIe81Ev5ToBklbPALuRhSWECHT9SbJ3+YDzMReqSUsh56c98A6SNPGH/WtNUgMlPr+JcCLiLCrmvSJnrjkP3SXK7si/YqsxhXbz9gDDYLOURTZbjTVpwphoc8gvhQUhoZIhFBBrJZ4TeDLktZWHujoicvKRc4/YJgOBg1obPFf7MHoBAlUsgcqZIjUGvnvXN0rbPlUYIu9r2RyxqFimfELA4cX5S5MvZAXunj0GNl+PGUR61CqZ1nycQNw0j8N2xGv1DmkaOetiOA2raGvq3KZKu2eTDTQ4qsjMv7GfzOsB7K9uWJZRxYnAsVgxawH+qgZdoqMIvIWjy3Hb7tZXBuGvOcrRrFdLKMNsB+Nell6YLVXU+UI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(53546011)(6486002)(478600001)(6512007)(6506007)(316002)(86362001)(38100700002)(31696002)(36756003)(2616005)(186003)(41300700001)(66556008)(66476007)(44832011)(8936002)(4744005)(8676002)(2906002)(4326008)(5660300002)(31686004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDE0emMvSFN3UDU5RkgyYWVpb2FtSDNjVzFTOTgzSVpGSG8zLzM4dnNpS0lS?=
 =?utf-8?B?NGZVaDYxblN2dElzNGRxUWdtcmxnNFJHbzRqNkI5Y0ZHOGRBVlZvVUx3Q2xX?=
 =?utf-8?B?akl4REQ2R2hBUUJiMGpMMkNoWjRjbnY2blBnUG92TE5oMzhGdExLbTN0U3dN?=
 =?utf-8?B?YVg4V3RmZTdnR1h3ZDhOa3Yyc3JUdU1vYml0b1JhUUVheG56UStGVDVGSWFm?=
 =?utf-8?B?YzFuQml0dk9UMzBHcUxYbXV5VGdNMmRLdWJyb2o4VjRWL3U5Sm5ZL2dwYjUr?=
 =?utf-8?B?UWE1ZVpnM093Z3V6RmFScXlDaEh2Vmt6U2Jla1BaZnloU2NMeTlQbXo3Y2R6?=
 =?utf-8?B?d1FOMHh6amw4M1AvWUtpQ29RcmJqa3o0TFV5Q1FUYnV0SzQ4ZzQ1Qno5UW1t?=
 =?utf-8?B?YW91TE4wbXNjVWpmM1NaLzk4ckkrSEFqa21TRjZvc2k2QWZSbW41OFJpeE5O?=
 =?utf-8?B?b3Z0dDBIS2YwdVdDbldoQjcxWEVMem9ZdnpDZXcxZkQxaDB4djdCcThrTFBL?=
 =?utf-8?B?c1hZdGxleDRjOWJFSitLUERBazFFeUtKNnc4cERiWUJEekNyU1huY3U0YVRJ?=
 =?utf-8?B?eVc5bFIyWVkvVUVsYmtPdDFMYkZEeWdleU5vYnRkZWR6a0J3UWFjWjZjb0JM?=
 =?utf-8?B?RzRUNkt5R2FLZ1A0SFUzdzIyblcxcTJsQzNFVFNTaXEzR2txa3c4enJQRjBF?=
 =?utf-8?B?bHl6SzV5NEY3YzJ2KzZTZkRXY0ltV3BUeUJhSk1uT0tySjZVa1cvdVlCeTFP?=
 =?utf-8?B?QjRkVllFRDg4ZFVqb1lDdVF4U3BMc3ZieTBaUFJoWnRzbW5OT2VLOWMwa0xV?=
 =?utf-8?B?ME9aZTVJM0d4OHdpOWZ1LzRkZDBXQzNKZzFqSklZNWFTalViVFZiVUJ6WjRG?=
 =?utf-8?B?eVR2ZWU1YW5XNDNiL0drUlM1MDAyU1RSMFBDNGpYbzhkMnQ5cFBORk5EaUpJ?=
 =?utf-8?B?K0JwemRzRldVSnJ2RUFhU3RBN2ZtZVBrdyt4cWswblVhSDcwVUprdHBqWmZ6?=
 =?utf-8?B?ZUZWeGxBQzRjSlhuZzY1cXVnMzVlZTF2bFQzdk15b3QxaFdIOXRoQ0NLU2xS?=
 =?utf-8?B?NWJCOWZjTXMrcnFzZndPV2p6RDV2QkdEeXpBRVRKSndzc1BKajlkVUgwTVFm?=
 =?utf-8?B?bjlYQXB2c2NReGFKakZQbzVlTmp2ekt3TUhjaU5RN3FwNkJFdFYrUHB4M2Zs?=
 =?utf-8?B?ZDNva1A0bFdXeUpOL1RxV05jZ2Nqd1BIWEZYL2ltMERoN3dZSnArWDJPSjBL?=
 =?utf-8?B?clFkcEkwZExPd0puNVMvbU5WRkFERGpqTDdZUGQzeHpISlpKMzNoQkJHbjNV?=
 =?utf-8?B?TnM0OFFsUmh4Yis2Zm9EK3NYQVRJN3VLb3BHeTdFWTJIaDQrVitrRDZqelZU?=
 =?utf-8?B?T3NXWmJRNVVlc2pBdlBMUlJBenZJbFJYNEhkMG9hci9DT0p0clJ6Rzc3ODBO?=
 =?utf-8?B?c3J1dmJkVkdodFRoeVhMVkpuM3RwaFhhQmhsZTltVGdWVGRNdHlWeDRXZk5z?=
 =?utf-8?B?enkra2xyQ3Q5Vkloc2VFWjlXblRsMUNjbVF6QWxidGF0SThVVklyRU9keWpU?=
 =?utf-8?B?Q05GNG5KZHE0S2RyQTdoMUNOU0IveUlZL2JlLzRFU09hOUhZaVNEc3h5bmNx?=
 =?utf-8?B?UUFRcmF3Q2Q2TGRDY2YvQmVZemZYZjV3blg2d2NyWmY2aEZCOWpIdDZDVVpV?=
 =?utf-8?B?c2wxOTJicStkTDd0SHl1SVdOZTc2SkUrMUE5YWlBZkw0MWlueXNXalV1dzdV?=
 =?utf-8?B?K3dZQk1BTkJPUmFYQkNUalJpNGFEU0lkTld0bHhPR2dXcUFOVHd5VElYL3hN?=
 =?utf-8?B?VXRKRHBERHppMUU2em15S1orbTQ0dkhIeTdkSUZWL2ZYMExadEdyRExENVJE?=
 =?utf-8?B?MGNOSGNlZmRsa2NBaENiRm1hL1Y1dVNTa2VhaUUzdVFYRVd5RjJjSU1VTXNI?=
 =?utf-8?B?bEhsaThiRGpnYTZFM2ZSd1YxREFab2hPSWtTS1p4R3oreDZzaWlrL0t6Wlhv?=
 =?utf-8?B?a0RCTTNWMzVONVBYK2VoSkJzdFFmMHBGM091YmQ3T2p4MWVlVTVMVlhWUDlI?=
 =?utf-8?B?MS84cWliTHdyeWRNdnhIOERmeWt0eGw4SmsrOEh5OGZ0ODJ2M2tZaDZtVU0w?=
 =?utf-8?B?ckkyRW40WjJlNnpDbmVlRThmQzRRUndUWUc4N1RKU3ZJOGZlWjNFMi9yRDMy?=
 =?utf-8?Q?jLTdTMDcQ0/V/D55dq27ihl3Bmlv1HtJkJlXOGDacJTy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d21b28-5784-42ba-6bb0-08dabc824653
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 03:28:14.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8e7sErJ4e9nIjV6XMiMfYfOcZAXBUy9jTK+oDP8t7wwfSMOOJOuN0Hh7wg3gsB3/nnm0zBk8L+CQaeQbtdfng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-11-01 20:05, Ivan Hu wrote:
> Add INTC1076 (JasonLake), INTC1077 (MeteorLake) and INTC1078 (RaptorLake)
> devices IDs.
> 
> Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
> ---
>   drivers/platform/x86/intel/hid.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
> index 79cff1fc675c..b6313ecd190c 100644
> --- a/drivers/platform/x86/intel/hid.c
> +++ b/drivers/platform/x86/intel/hid.c
> @@ -27,6 +27,9 @@ static const struct acpi_device_id intel_hid_ids[] = {
>   	{"INTC1051", 0},
>   	{"INTC1054", 0},
>   	{"INTC1070", 0},
> +	{"INTC1076", 0},
> +	{"INTC1077", 0},
> +	{"INTC1078", 0},
>   	{"", 0},
>   };
>   MODULE_DEVICE_TABLE(acpi, intel_hid_ids);

Reviewed-by: Alex Hung <alex.hung@amd.com>
