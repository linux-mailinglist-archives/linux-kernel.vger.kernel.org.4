Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FF568B565
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 06:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBFFw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 00:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjBFFw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 00:52:57 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46140EC6D;
        Sun,  5 Feb 2023 21:52:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2c5kTRY89dw6AS/Si7h6fLvYJRDQ7ECdDZgxIOexoGAsWcigmWstyeZ/xUgl92zlgRvWLmby9lvy/6AKXdpPYS3vc1RuKKrLEsq1Iu6uhjlLWPKFhsZMbdJIf2EZhNA7qGYvKWAvMw4y7cvqp0+VXTfXXPb99REhwb5yN74OmyMiooPOzkGwnuN5dbdVi5H0vAEElJg0QjeU32ZFQE2pWSNKpQJE91u3YfUIkSeVxpYoAvb3Zn/0tZRmk8WFnFvjp+WiYazgskG4nPvLe70q7yVQhQdU36SAkrfN0j8qNJ4Y0AX/NNwZGMijD6Vm3gQfVnx4BQb7DHE8xe7plNpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F71x9i1ySWU24cO3LlXvQMQFKPV+FtUDMMlUUz1Yeo=;
 b=PiHvEVAKJfW7m7tJ53IA4/4bWWe4MG90n/FvS8MDJX3FGfYtwZ0ZcTBQlwZpoAZaDXklqYLYu1dIBMhw5NkU4xN9ZbpNtfsnKc5xBqm8TmVNVPTOJJ5mY59JbeBMoTZglZDrLPlXlf8YLLwUoWaFduKxdzvvs+Acfj+TsB52Q78LFVcC6DOw42f530QV/Bv99c71hBXtV3BmoYd9v9YmUx8EbCA2uQGRrPWZUmfyFqa/gUY6SSjvcYSslzZefXc0oMHP8qBXcADjmym3CzkHcPdH9+oTHn93kBD/AK/cBVH8Fu+aDYz0J6WJORpkclGT0tO+47S96skEaVfDr22mNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F71x9i1ySWU24cO3LlXvQMQFKPV+FtUDMMlUUz1Yeo=;
 b=xzrThjfCOHWNTGZf40UHYR8eMLqFqvXKzE/QqrQk07jbs04cEJYvKhp6smNqjIGFhSpvNHCG5dFcaz4e3jY/ZjYTTmBkTd/I8iilcgrmfPqUdZc6qANR/h39XFQwlDILE111DiyAoy8EYv3qwjnAsyd5o9OcRHDmni5A38rO4S8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 05:52:52 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::40f4:29ea:fc74:a9c7]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::40f4:29ea:fc74:a9c7%7]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 05:52:52 +0000
Message-ID: <130dd1d2-d37c-d266-3fa2-923359b7bc33@amd.com>
Date:   Mon, 6 Feb 2023 11:22:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] HID: amd_sfh: if no sensors are enabled, clean up
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jkosina@suse.cz>
Cc:     Xaver Hugl <xaver.hugl@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230203220850.13924-1-mario.limonciello@amd.com>
Content-Language: en-US
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20230203220850.13924-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::22) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b267dbe-caf6-4ecc-bd41-08db08066254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Em1Q9Am7mRD5X6JvZbLeuRoXpiW5wrdF0zuNknoYnmTRB3EXPcRFmYYXow8VoGfaJS4AhDmCvYnXcTCkh8wexVKv41Cjm1c8oeue1izZS6QLg0GoqDYy5Xw3mLpDJflbf//m+WBfadsMF/XtmYBBgbivvu+hjOWr4gXMxqZA87pQO/DwLlORxdSRz2tly4+3z4bgjlSKISE+Feyh5RVRghPLdAzx3qi4p48Jyc7lrLfdajc2g8QIgNLOJ4kiPhqeZAepv3WewPer0wSMSOphFGfr0NnAqR0sEeKs7aq7BLoEs7wBnTRCPjVf95FnCTV/MYd/Cl43iI2G1BzyCmL4ihrO3v33e86CKnNnc/JcPwAg9S/bDj/AiqljFRal+r/PAjxuFruAkIx5DhvzlhE0u66X3y8guq/6/5L31uOmoGrMuSoR06+VGw/1IcpIWVBheaJB/RtqThq5hL5HEe5C5G+o84w/BoninMt7eGOV/VqrcGBolVE3XX4UvrfVtReKrVe8rg+vjm+L6q7yWjjWNAbgUeu/fRnOmoi6hOaB0MKTArlB1itCbUYz5TUPjxwYfHvN2hZx2UPPUXJOwrWPbwsH2A5foa+2iQ51nkI+7j/YuAZ/TgGZZfkL14x+Pr/UKo+Cd61AIKELyHXxGuh3I61ltxw57f6UiTKAiSiqbMmqJEPQT9/PMmSs1tOv316U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199018)(26005)(186003)(6506007)(6512007)(53546011)(6666004)(2906002)(2616005)(38100700002)(31696002)(31686004)(478600001)(6486002)(966005)(110136005)(41300700001)(8936002)(5660300002)(66946007)(66556008)(4326008)(66476007)(83380400001)(8676002)(316002)(54906003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am1SZ3JpL0U1ZUZMcGRaak45YmFVdStGVk0wZENPM3ByUExaMU5qUnF2OEYw?=
 =?utf-8?B?aUplTEUzNDJGYzFCZC9tSjRNUUVYOElvRUJzQmdVZmsvNjREaHFwcjZMbVRC?=
 =?utf-8?B?Y2orcFR3d1Y3K05TVFo3VTdwNFliMzB2b1JFVklMdDFWODBhQ3RjY0c3dFVv?=
 =?utf-8?B?MGluSS9QWDRhaitjeVdlVnlxbWN0S0RtMnlWaG9BeFJXMEk0VHFyRStuTjhG?=
 =?utf-8?B?UjgvYmVTWXhMT3RBN1NVY3VtR1VxSUFxOUR2aDBHcHdUNXpxcDBWK2pyUWV0?=
 =?utf-8?B?c1lKcmNMeURpcGsxRFVqMWh6ajVyd1ZJS0ZzN0FqSGJNalgrSnFMb09wbnVX?=
 =?utf-8?B?TTlndWNsU1pMNUtvV0ZiZHh5MVFWZWY3SjV5UDVvaVBXQ1BGTzVsU1pScXZl?=
 =?utf-8?B?QlN4OFdaRFNMUm54K1ZUbzZuZmFCREN0SzdZRWlNcXcyd01LNldiVXAycDhY?=
 =?utf-8?B?SkFScE56TEJzZHhoSS9YV2pxa3c4RjltOXdIOVNVVCtvN1l2MU9WSFNQWGEw?=
 =?utf-8?B?eHZDZThsMElBQkQ5QkV0UllHZXUwNXNKR2tFd2dpc2MyS0ZWZjZNNHhidGxm?=
 =?utf-8?B?K3BtdkI1ZTNBQ1pPZUN3R2YrcnFCQUpESk1NL1pnTFdvcDBYbEVoaTgyYktC?=
 =?utf-8?B?cWZYcFZvRmpCWXpIRnJhSzNlK0pTRjRJUHRrN01tM1ZVWW9mcjA5dHBxaWVB?=
 =?utf-8?B?cnBMOWhaakRvNS8xTWZzbTRaeWNZWGpzZHJja3NtbWtpMndUaFZCMnpoS1RR?=
 =?utf-8?B?U1oyelhVc1FUalJrQmEvQXJOTlh1NFp0R0JkV0w4dGp3bDRBKzFYdlU1WjZ3?=
 =?utf-8?B?UlN6RzRZUjdWYWdzUXR5NitHRGFvSEhtWW1jYVBLV0hKWWk2WUVOSEhRazJ2?=
 =?utf-8?B?NEhxWDNPdFl3cWdMakFOTUFHeDR4YXpXMVpuQ2tSV1daaVFzVTYxSERuMDVO?=
 =?utf-8?B?c2JzQ2RZTXM2bWVWeC9KUm1SWHdBZDBlYnRTTkZXMW1XTjl4d3E2cS9WWHB3?=
 =?utf-8?B?V3V3d2MyaGZNa1NqZDY4RWR4RXNnQUZYRW9pUG9sS1B1eURlcXZER0hxbmMv?=
 =?utf-8?B?STFKNkZzbzlTTHpRVUFWbFhyMVhndWhJUm9IVW1OdVRNWSsxOTNCR3lyaWo1?=
 =?utf-8?B?amtmdTMveGJzZDNUOEkvRktsSStrZEhPUnlxWUZzb1Z5WWtTRytRYTM3RTJO?=
 =?utf-8?B?Q3lsdGErc1pObXhRWWdmU2pPWmdQSnd0NHM1dGdJOUxocDN0OHB2V2tLMFQr?=
 =?utf-8?B?RVg2bUpxcE82cUVSLytjSGh1N3U1L255eVNsem5QRGNVS2I4ZHhleFZMRGx1?=
 =?utf-8?B?U3NQclFIaVhxaTFYUVJMelh5bS91YjFZR1VjMTV5dmc4bjEvMkpPa3U1RkU4?=
 =?utf-8?B?d1JUS0xGK1YyczUvZzFLS3h3UWp1MTdrM0IzRUx5a0NJanFRYlZWOHl0RW1S?=
 =?utf-8?B?SWoyWVFlazArNXlyY2MvVXoyM0NscUw1QnhMSytYckgyOWp1T2dIdUlaRnh1?=
 =?utf-8?B?TkV5SzA5eUhHUDRURUh0R0gvK0xBUUZVNU9IcWpKRTR1VDRmaTNtNk1NT1F4?=
 =?utf-8?B?RlNPY2lYdEhiRlVNSTRuOTkzNjIyOUxBOUVZd2I0SWVEY204cCttakdZbUph?=
 =?utf-8?B?N3F6ZURXU2hvM3BDSVFRMlBUWm9uU2czb2RPMWFyendmakdXOU1yTEtjejh5?=
 =?utf-8?B?VG8rbTVyK3FZZmlqbWhTL0s4ZjhEd2hLcUZ3b20rMlFqelZIczVwUngxNCty?=
 =?utf-8?B?dkoxVVlRcFlGVHhBa0lOM2dTRkw3REpiVGgveGQ4Q253SE9XUk1rQVRuWDU0?=
 =?utf-8?B?U2RDUTFQVWxXQkM1TWVORnZDUXRKSGNlK1dweEJpc0g2THdkeWFXZVc3bURS?=
 =?utf-8?B?NVdLVnRrck1SY25ucGJGTkRxUFpjL2FQdnMrcDlFMkJQRVl5VG5PcGRWQjVZ?=
 =?utf-8?B?N2RSK0xLVmxEYlg0cDI5YWxDd2FQZVJFYlYrNEplemtXZ2hIdGoxYXlMRytQ?=
 =?utf-8?B?UjF4UUlPMWZIdmlldDQ4eFVZeVhzRkpBTmhESTJtRWR3U3RWUjVkNEorMjRO?=
 =?utf-8?B?a2tUSkZKMG5yNDN4dm13QTcyakxXcmxWeGR1bUZLNFZFMjNadDcxTGY5VjVW?=
 =?utf-8?Q?yFtdKruQZiJeDiOVVmf3V0sc3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b267dbe-caf6-4ecc-bd41-08db08066254
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 05:52:51.9508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/gUT3aC353iD5HgB9AqbZmAZek6O4D+b+SuE1j6vFmlSrsteGxSiJyY3R18QnmxvFR5+83f7bEo6tddN/llcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/4/2023 3:38 AM, Mario Limonciello wrote:
> It was reported that commit b300667b33b2 ("HID: amd_sfh: Disable the
> interrupt for all command") had caused increased resume time on HP Envy
> x360.
>
> Before this commit 3 sensors were reported, but they were not actually
> functional.  After this commit the sensors are no longer reported, but
> also the resume time increased.
>
> To avoid this problem explicitly look for the number of disabled sensors.
> If all the sensors are disabled, clean everything up.
>
> Fixes: b300667b33b2 ("HID: amd_sfh: Disable the interrupt for all command")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2115
> Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Use a boolean parameter instead
> ---
>  drivers/hid/amd-sfh-hid/amd_sfh_client.c | 13 +++++++++++--
>  drivers/hid/amd-sfh-hid/amd_sfh_hid.h    |  1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> index 1fb0f7105fb21..c751d12f5df89 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> @@ -227,6 +227,7 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
>  	cl_data->num_hid_devices = amd_mp2_get_sensor_num(privdata, &cl_data->sensor_idx[0]);
>  	if (cl_data->num_hid_devices == 0)
>  		return -ENODEV;
> +	cl_data->is_any_sensor_enabled = false;
>  
>  	INIT_DELAYED_WORK(&cl_data->work, amd_sfh_work);
>  	INIT_DELAYED_WORK(&cl_data->work_buffer, amd_sfh_work_buffer);
> @@ -287,6 +288,7 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
>  		status = amd_sfh_wait_for_response
>  				(privdata, cl_data->sensor_idx[i], SENSOR_ENABLED);
>  		if (status == SENSOR_ENABLED) {
> +			cl_data->is_any_sensor_enabled = true;
>  			cl_data->sensor_sts[i] = SENSOR_ENABLED;
>  			rc = amdtp_hid_probe(cl_data->cur_hid_dev, cl_data);
>  			if (rc) {
> @@ -301,19 +303,26 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
>  					cl_data->sensor_sts[i]);
>  				goto cleanup;
>  			}
> +		} else {
> +			cl_data->sensor_sts[i] = SENSOR_DISABLED;
> +			dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
> +				cl_data->sensor_idx[i],
> +				get_sensor_name(cl_data->sensor_idx[i]),
> +				cl_data->sensor_sts[i]);
>  		}
>  		dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
>  			cl_data->sensor_idx[i], get_sensor_name(cl_data->sensor_idx[i]),
>  			cl_data->sensor_sts[i]);
>  	}
> -	if (mp2_ops->discovery_status && mp2_ops->discovery_status(privdata) == 0) {
> +	if (!cl_data->is_any_sensor_enabled ||
> +	   (mp2_ops->discovery_status && mp2_ops->discovery_status(privdata) == 0)) {
>  		amd_sfh_hid_client_deinit(privdata);
>  		for (i = 0; i < cl_data->num_hid_devices; i++) {
>  			devm_kfree(dev, cl_data->feature_report[i]);
>  			devm_kfree(dev, in_data->input_report[i]);
>  			devm_kfree(dev, cl_data->report_descr[i]);
>  		}
> -		dev_warn(dev, "Failed to discover, sensors not enabled\n");
> +		dev_warn(dev, "Failed to discover, sensors not enabled is %d\n", cl_data->is_any_sensor_enabled);
>  		return -EOPNOTSUPP;
>  	}
>  	schedule_delayed_work(&cl_data->work_buffer, msecs_to_jiffies(AMD_SFH_IDLE_LOOP));
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.h b/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
> index 3754fb423e3ae..528036892c9d2 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.h
> @@ -32,6 +32,7 @@ struct amd_input_data {
>  struct amdtp_cl_data {
>  	u8 init_done;
>  	u32 cur_hid_dev;
> +	bool is_any_sensor_enabled;
>  	u32 hid_dev_count;
>  	u32 num_hid_devices;
>  	struct device_info *hid_devices;

Changes looks good to me

Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thanks,
--
Basavaraj


