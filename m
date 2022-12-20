Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA05651AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiLTGxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiLTGxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:53:00 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7860A9FEB;
        Mon, 19 Dec 2022 22:52:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ibn+Uc0qv+7tCGynz0FfZm/IqWxmnsQCI0Sy6UvWLywHxrcNWDMVu+ZOtzxlMwX+f0iUf9SsKqjR9xFQp9nCZ61vZs1OlM+0XG3QpBWCygl8FrCMqLxZakO6iMw6ojXRAy3CbUk6mxjZTubU1mHP2vyOnY1ohYxeM95IkuupORdPevQjmy3cHVNbNlpaR2t/7zY0XXw4seAThajVWBtqO+Rc3qC+N2KREgd9FwBVKnj/vNfNa6zVAyHohW6djiND0Mz3r4qUjGBhYFk/O/O2teUlZjKEyZkV1doRN38aRk1eKSznO17BCpiEj+BmiZ9inTgYTlSMsAMp/P1ifD38kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3LbiqKqVBj4/lLB41lnyfLloSE2FJocfe5gXLzyDCQ=;
 b=G0K7OLVQlVqU390tvVVMaL7Ty8Oh9bEnTI0FrJE5bXQc3coRnGepNXFaxF8tEK6J/QSrTaTtWzGsyCqHIBtpd9CHd4xIYfTkQnRRUDPOfHGuQRbNxy+348pTA2LuzFPfcI94UwGdKb8XDpP8VROVUvCE3nfzb/we5j6yA/CQiKMAbwzfwNITlNKMlNQmwpcT9CbMGlSA8BbI1lITv65kmGA5xYyXOAGIeveYxDrAWb67VV1frksEZezzQ7F/rR4oREE6YrbcLgqZMn+fMywffsGqwwBpyJcoqzSAPXskoxlcDGGhmHD37gsv6Vvo/ILtkNvJq7SYgu5B1/cq4VmTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3LbiqKqVBj4/lLB41lnyfLloSE2FJocfe5gXLzyDCQ=;
 b=ZgKFPZwxqJ61OOopkS3ELUID4WFrUQpg1+wtET9KdWjwRp0B4zVEQnClDvKwRZfTAw8npp7wdn9l8PRoi+PmYQ3AvQcO/0GZs6ZKNK2NqUIHE6D0cNysmvbOY9wSBFtTbPoEmVmscsrfUfRCNNMKHbu6bgKY/hRlUUI3iIS0Txc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 06:52:56 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9444:21e0:2a65:da95]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9444:21e0:2a65:da95%6]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 06:52:56 +0000
Message-ID: <035598f0-3174-9677-0b53-f3ccbfb54155@amd.com>
Date:   Tue, 20 Dec 2022 12:22:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] HID: amd_sfh: Add missing check for dma_alloc_coherent
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, basavaraj.natikar@amd.com,
        jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221220024921.21992-1-jiasheng@iscas.ac.cn>
Content-Language: en-US
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20221220024921.21992-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::10) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CO6PR12MB5458:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b13ae8-62ea-4716-d4a4-08dae256d31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAVJce55FwdYz6+GTsA95RWSovhkmtpFL6eq/j8TGjfFs+FDgOeLdJ0HQYrAGj72PkAMUH+VX47nkTosC2MD5izu5vDG3ca3N1vdv/BAJjz/Qfw01mt0NNkrJxsKaUkMEondfYnsQJukUGN+8StNp69LVJWYS1ffEp2WCGVPMslhj1adVY0wKVVXQGjZfAQoW+QIQDL4j9BndzpOO68D6U5V5S7fngN1b90Ua/YkDa+QCwCB1y/NpA+q8ClXNvlLPv6IRiZSxwEChFj0Gnh/P/xd+WKnvVfj9mcpKfF6F5J5yIyTfx/Fxccl5qvCzSCdAjjAt2zQxZ/4Ce8dEw8kbE2HDUDQUmRm8jUDDwe52CcqjaN4JjJEjIXK4EHyQbpGmO3yFKGWBn0HpZAZipCenyCINZ8waQbUZgpBtyXGZMTGuyseKTsXVSsTc8Mgp7Pe3zhTtC0FLT8aGiVGNzG6d0I5VUwCP1ktYvVv8bEbkDz1k5ALjQ3tgG8IQYmiM8MXgq64UDoCyU1QpyumD99eMcrA4YMnQqTMhYoThcVVsc31sZ34ZzotMny3Yf4Tf1/ezLXkECenl8ycf+6ZYu4xWrSANYP56IMDzPjAKzPWEjDC39T4RCRcCjsMaFWT2tVi3unuWVT2X8bGZmKibvObgjHTMFPB1ibL35XQbxm5uH9mcYZpRTTNOoC6pi7A97YxqItXrky8LT8fzN+gfiozo8il92sy6BKbDx6VdbWJP0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199015)(478600001)(6486002)(2906002)(316002)(36756003)(83380400001)(38100700002)(31696002)(6666004)(26005)(2616005)(53546011)(186003)(6506007)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(5660300002)(4326008)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3pUT1JOWmZUZmRMUG0zbHd6SmMyTTd4dGtSMXNMMGJOODIrekk0TTVGOFcx?=
 =?utf-8?B?NzdNOTNoZ2VEcTNUOUVTSW9CY1hJekVhNXJpYTAza0RqVmk5NGJJS2IxMEt3?=
 =?utf-8?B?TzRzQUcvWENGeGFMVzAwcjl3cFFPSkFlWlBMS3lCbnRMRGs3RnNzcUlqVDN2?=
 =?utf-8?B?RTY0ZE84ZFYzcnN5UEoxNHJtZTBybE40aUU3NzhlWjIxVjR5Y1lTT1g1UExT?=
 =?utf-8?B?QlRHVU1MOWkwVjl0N01ZMnRHc2NYdXZSMXRZRytzS25jL0N1WGxVZDE4L3F3?=
 =?utf-8?B?QXJhYk8yMmFhWUdmWTNTR0VyVktHb0xiSWd6SXBVV0pncGJXc0RraEdoY04w?=
 =?utf-8?B?cUJTVnE3bHhjVXU2bVFxRHFlbnVDd0srMGtFZGJqWkl5RW1wUVdyZmF6Zmcw?=
 =?utf-8?B?YmhQTHBqV1ZPNnJGYitSZEk0ZXF6c2RxUEFOOFo5S0pLVU1MSXRQb1BXaUVN?=
 =?utf-8?B?a01tRmlVWWdJV1gyWVd4SmJJZDhVU1FpU2NrK3IxSHZSRjk2M0R0YkRUald6?=
 =?utf-8?B?M1B1SVB5YWtnOVo5NElZalhVMzVvMzJ1QUUrZGhpUEE4S2xNQkE3NDR2Qkl3?=
 =?utf-8?B?YnNLNGtMeXBXait0VFZLY1Y5cWFVUFFUMmVCTFJ2UTJkRmI4RWMyeEhoaHB0?=
 =?utf-8?B?YkJvZ0ZZNm9EeWtzMTdRQWg4VnY0SWV6MTV4SzlOUWR5M05Qd0gwYnZLQU5p?=
 =?utf-8?B?V2pEWDlBdE5kbXJxc3hDMVZLY0xzaGxKYWx4VlZwdlRKZCt4WGZDMUMwS3FS?=
 =?utf-8?B?NE1pVnAxdGhVaHVKVk0ydDRZNnVlbzlRQmNJUlYzN2NpekNNNU4wRS9BZGYy?=
 =?utf-8?B?NFNZaStuTlpIaTNuczgwNzRnWGdNNjlMQ2hZbVRaWFM2UmE2TnFpTnZub3dB?=
 =?utf-8?B?NGNXYWFuNEVVQjJqNEZrbFNoV3BIU2J5eDU1NGF6R25CM1hrdEcrV1dXKzBy?=
 =?utf-8?B?czI3RXFCT0szMFIwdjlrenRlTWdsTGhqd2wyRU5pTUN6SmVCUEZIL2k2cCtG?=
 =?utf-8?B?MlFrcElmRExEbXBzTFBqN3R5Ymd2M2ZRR2kyY2VrQWg2Uk5wWlp2ZjBleFFO?=
 =?utf-8?B?ZkVBSjZybDRUbE5OOHFZcnUwYzBMWkcxWlVpRzYvenB1aWlraU1jQitCU1pG?=
 =?utf-8?B?bVljNW5jR3lLOXd0MUVQSlRvMFhrWEpJenRiMUluQkdYQ0IyaVB1SkZaWGhX?=
 =?utf-8?B?WGFZZERFVm1mNEFJWHcrSzdSS3lMajE1N1Ayb0dHYTlWajg5WURiNFdSUTIr?=
 =?utf-8?B?b09jTlh6c1UwMHpLbTNUSHg2QUhuQWNPT0VJS3Jmbm9qQVh1NmpQVUpWeGtm?=
 =?utf-8?B?bDBiNTREaDZyQno3eWpVMFlOR2tYUXZCV3hhamlINUFkMTFia0xhYjR6dTQz?=
 =?utf-8?B?YWdOMmlMM1pkalNuZjEwalhsNVBSVkJQTE5lbUEyeVpucVY5c3VVWkVIZUp2?=
 =?utf-8?B?Q3dEYVZzUjNjUGxOaEhQcStaYk11eFZUM212N014OHNXdWhOMVJNUHAzWnFi?=
 =?utf-8?B?N0RrRTUreTk0NklaY3haWUt1RVZNSllMUXJFbEJ2dmNWSEw4ei8rY3lWRFlh?=
 =?utf-8?B?TWRpTFJ5Q09RTitWNGRiV2ZQcmdjb0J5QWx3dkNZVVZxekZCNGhxVlBvWTFP?=
 =?utf-8?B?aStnZjgvUVRzOWZCWEJNZWtVUDV0K0JOS2V1VnhHa1g4WDZRUkVDWlhiYjUx?=
 =?utf-8?B?d1FIK3NIUXA3MmFBOGd5M3NBZENlbUc5TTBDYVJSaTlDaGpSaGtmOWpCQytM?=
 =?utf-8?B?TGRCYm8wSU9XYm1DSHVVVXUxWDFPQWE4NXRYVzdoMjBqS0QzWFl4bCt0Tzg3?=
 =?utf-8?B?cHZOUzJEU3FDNk9oTHYyeVpGd3hzSjk3M21pa1ByMFRFdEU2WitSQTdITCt1?=
 =?utf-8?B?TmFielBwUGpFZFUreHA3YkJFK3pwTkxhcUp2WFpYYzRkVkQ1d2R0aVZqTjIw?=
 =?utf-8?B?SndmZnhFbFM4WVZ0dG4xZ2ZMM2M5eDV0RjJSN0VZWEN1dytERUdybDhQd2Nv?=
 =?utf-8?B?Zk5tdENReCtpTm9kV2Eyalp3MW01SWJ6K0VuL2R1VmJOdTdFY2h0UENIM3p2?=
 =?utf-8?B?RkhRQ2JsRTJoMTQrK2o0MkJhNHJNL0ZrVmkwWjNscG01Z2dzUURDbUs3QkpZ?=
 =?utf-8?Q?j1+S1N8Ujl9/wJ75u1mgQSg8v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b13ae8-62ea-4716-d4a4-08dae256d31e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 06:52:56.6392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOgYwWJmKKe5hlH3ZsvK6wOR80vXQTQNwdSF0XZ9R8lYawz3wJ6yCw65rEOV6GUeKhPj5/WeHXA4gI20d57u3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/20/2022 8:19 AM, Jiasheng Jiang wrote:
> Add check for the return value of the dma_alloc_coherent since
> it may return NULL pointer if allocation fails.
>
> Fixes: 4b2c53d93a4b ("SFH:Transport Driver to add support of AMD Sensor Fusion Hub (SFH)")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/hid/amd-sfh-hid/amd_sfh_client.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> index 8275bba63611..ab125f79408f 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> @@ -237,6 +237,10 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
>  		in_data->sensor_virt_addr[i] = dma_alloc_coherent(dev, sizeof(int) * 8,
>  								  &cl_data->sensor_dma_addr[i],
>  								  GFP_KERNEL);
> +		if (!in_data->sensor_virt_addr[i]) {
> +			rc = -ENOMEM;
> +			goto cleanup;
> +		}
>  		cl_data->sensor_sts[i] = SENSOR_DISABLED;
>  		cl_data->sensor_requested_cnt[i] = 0;
>  		cl_data->cur_hid_dev = i;

looks good to me.

Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thanks,
--
Basavaraj

