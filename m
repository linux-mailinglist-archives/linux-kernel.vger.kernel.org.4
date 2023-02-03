Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E52689043
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjBCHOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjBCHOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:14:19 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C547D6F71E;
        Thu,  2 Feb 2023 23:14:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D72gH7XhKn3JkgWSdhE46Fpzu85wde9+r0i3xI3j/07KdxtXcL+AIb8BqYRPMPHuR3N5vKSIEUwn+rWJeaNcR6U/ZOhlEuxlDsr1A0mOzKX6GTb/ADDtW+gbE0091P7IL56k17Hkj93edtacxYuOPa/FPY5oY+GGlGxRtAOTxuaCNjMx7ItoMe/8UOvxO/B1HZalYx3+4eJcBoEZqqAnjVbdBkA67UBYAfwo5RcEJAGszP0mVtNc3j+iJKyj3IUw7fCdOeCIaXLAC4CAkasEt2cScRloQT70GTXgQmyFqG5TzoCuHT/WCSF6pQsbpmksLTNO1DWV4NaMs/YceeFmvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYcutsInjJ45tUXbb9Z82xkKa1kE1tNKRA6jQoO2mds=;
 b=QLineOjL70DBPJ3Aj505EhZT+GPCYqHDFgV0teMCy1aOTqZ62H4jVGNNOeHV+9RWhmV3Fur8ITK4APm6jj3oNQGJ+a/ZyIdVnkWRWi11S3+9md4i6QljVltals5CXT2yhQznwI0VO8QSmiPue9Qy3EYoWYfhCEBaGphGqjxCyhGw186c2+iq7Yy79TIILCvC+ghkhnbKvgIosOplKPRpc5u9x9l9vzr9PSNZnToTpKHMAcnoTpj7m2zJixWl0D2dGQFXIqt8H+nsNSilVU2mAQcHS0gmGroyU2t2SVR380WM+fvFDMwcTA/1rkXHcbBC7lDTmIGW9ZzoC4rYOkF5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYcutsInjJ45tUXbb9Z82xkKa1kE1tNKRA6jQoO2mds=;
 b=LTEfZvn5xjy+wg+nuLsvAqrEVzF84WmvIPvZ+v9AeraH+EO4DWbYSyRpAl2F12T/OYx5dxd4vVy/TC/hdcstuf2ZL5hr+nivY0MAlRBYrIheMZ40NDelef1KuJjTCeNCv+qdTPBsYFILiEtL1aUeMcqahormVpjF3xyTta7Epgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.38; Fri, 3 Feb 2023 07:14:14 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::40f4:29ea:fc74:a9c7]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::40f4:29ea:fc74:a9c7%7]) with mapi id 15.20.6064.029; Fri, 3 Feb 2023
 07:14:14 +0000
Message-ID: <6561b9c1-4256-46c4-68de-bc9d06c7a9f9@amd.com>
Date:   Fri, 3 Feb 2023 12:44:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] HID: amd_sfh: if no sensors are enabled, clean up
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jkosina@suse.cz>
Cc:     Xaver Hugl <xaver.hugl@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230112190131.24460-1-mario.limonciello@amd.com>
Content-Language: en-US
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20230112190131.24460-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: da99ce20-77c2-40ba-5705-08db05b64169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XGzQEgRjPD3DpCKX1CHFLo31h9NLuHCbGouj+I/8f1UdPascqppFG+n8GgXB6XSbq48HIUI4+4AsvDmXD05K2c9T3a1sSFooLqrJtO5QSRWks7pNJ9sbv99mEsyF575IMFshUzB74JL3kYA+1s37qOoE0Szjz9kJ/m8/PQKuDakw3iV9qXAtpcgtthnFyZ91pQ7exHLZ8issdmxaTSrOchL5Q8Go7ITy2suMdOWruPQAAXq7evapcCTjwaX4vgjtdr2wevELpUDuLWZXZb5fzNSx+KcCTHoXMenjm1BmGcxQ9yPSTDMlDjgixmBHlNiI34jTlU4tr+i0+YYtIBaQNMowD95rnToQa7W0vS5cVmssmuGwhdorECdR6eiqYQavfXB2IA1vC4XCWl/QDWlOmHdt1LQZTNytyGZ+V28lOT6SocC1CFhoruXeplL0d4npGM+dVBveGGtlx4xosmtngwK7044jD9HXAyjEcpkbH/iTZMXRQnes+rw+CpxIN6OVWWFmyoERWuK5qVPFR2MChBzJ83AcbNPYu7bQhVDo31Vqfcut1bf8s/O7r83AfLrTFmO5yTzAE3st8ZIqQFGax7JYsr5z77kvWHOL5vyxd5QtyV/+XyqmL6/Z2uIq1jD1dmz22BFg9iBQLgUWpWhFoZ5I16IfgfCtMGHYyrtcn+ZiKNfcFjkrCwyN9cfAFY7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199018)(38100700002)(966005)(2616005)(110136005)(36756003)(8936002)(31696002)(5660300002)(54906003)(316002)(41300700001)(2906002)(83380400001)(6512007)(66476007)(6506007)(4326008)(186003)(478600001)(8676002)(66556008)(53546011)(26005)(6666004)(31686004)(6486002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2JmVjhvQmtldDZMaG85YlBjNTlWbzBNNkFmL3NYU2d2Q21URzE3WXJKUmxL?=
 =?utf-8?B?bzFTM0JOQktkdHY4disybnhINWltYU45TkE1SVhBRFk5RVdSL09JR09tK3hz?=
 =?utf-8?B?OTNXTXpOVUFvenFkenAxKzlSSklleVhWMDUwODkyY3VKN25qc3JyZ1B2ek1y?=
 =?utf-8?B?aEdSWHdMMUpEK1RvbEJjQ2VnZTF1ZWdrL3hEbzA1azY3ak5kMFN1NXRYOW9D?=
 =?utf-8?B?S216MmUwU3lXQ3d5d1lOaHVTTENmSlQ3TUhJdVhzc0tVaUJPYzdqSkNUMzZX?=
 =?utf-8?B?UzNDWjJuYzFPWEJ6NGxHaDd6RTdKb00rMC9aV2UraGl0eXlUVnZ4aUVLS0Fu?=
 =?utf-8?B?Tzc5ejVkamF0dEtoSmNuN2M4b0Q1MDVQWnNKbXRodEdPYmtXa2hROVY3Z3Mx?=
 =?utf-8?B?UnhJeWtRMkozOVBYSE9hSVZwN3hkYkxpeEVta1ZNUVZNNzg2RVdaaHVLTXJq?=
 =?utf-8?B?ODNrQTQ3RHVDb2dhQWM4QzFZMlQxRmdGYUpvRlJjbnJUWWoxYWhYQXc0T1pT?=
 =?utf-8?B?cVNqejA1d0hNVHc1N1RGTWM0Q3NEQkgyUlNvNUpENVJGWUJVYi9tVHovNnpN?=
 =?utf-8?B?MVJWL3FiTUhvaC82WktmaEFURWlrUFdQd0pjbGcvY3pWZ1ZvR3RTOEQwZjBM?=
 =?utf-8?B?VjhscGZOTHVxaUg1ZXE4bGY2ZmxLQ1psUEg1TXBRaUd3VDB4WUdwS1BIbm5w?=
 =?utf-8?B?WFZKcVVRaGtCZ3Z3UnBYZ0xKVlpyMGRqTFEzS2dwU2lCdmk1c0NWblk3RGdE?=
 =?utf-8?B?VWFMNmNSVXZ2TU9TZ3lseUpnb1MzSjFvTlB5MWg0U3JjY1p3Rks2Q0VmK2kv?=
 =?utf-8?B?L044NWdXVEZDRi9CdGZ5ajhEMVdhbnlZalJiLzRzeUhSQzBxYnVmeTc1VldL?=
 =?utf-8?B?UDVHd1VocEFXVElvRlYyZEJJWXBoQ2pOaFZyNlNWYXlmc0ljeHU2cDhWc29p?=
 =?utf-8?B?Sk92Uk1reTNraG5nL1FGRkR3RmpRU2tSME92WElCOGF0UXFWREhjS050NElU?=
 =?utf-8?B?ZE1yWEN6MDNrbkM4dU8rM3pROFdkRElpRzNpWU1YcmxaMDFZQnBIU2tiTTNX?=
 =?utf-8?B?WnhlaGQ3SnZQZitmNVdOa3VnbkwyZ2laRjhiODk2Kzk0WEVhb3J1ZDJsQzJq?=
 =?utf-8?B?R0l6Wit0SWoySDBEcWVRV3N0bTU2TDNUTWpaUFlKVXE2WFhEMERJZjYyOW9L?=
 =?utf-8?B?emU2VHg2c0I5dWlPbzhaNmpYU0ZORjBCWXgyRWsxMks5YzdKRXZaWnoyRE52?=
 =?utf-8?B?Ym1xSEZqTklEcE4zMVBnL0JkeisxQWE2VzROSWRvZko1M1REMVFFc3Z5RXJv?=
 =?utf-8?B?S0dHRStMR05MK1VTY3VzWFVNWVdhK1pZZE9CTWswS3Rsc2tmTEZ1d0hkYTdw?=
 =?utf-8?B?c0lhMUZ1WlQwVlpGR1ptdUlDWmNwc3ZxNFZYRFlDK296QTRkbFpaZEV6SnZt?=
 =?utf-8?B?dXdtZFpHa1BKaVJ6MUNnNU54MVF6Ykt2bU5rUTJCRG9nNVRFaVRtZFhEeWdX?=
 =?utf-8?B?Q3ZEdGIrNXhZbWNNMTVSa3VINVRGQ0xxVGtMS2R4RkpyUDk3cm9CeDNXRGtU?=
 =?utf-8?B?WEJ5MHdRTnFjQm1PeGFFN3NuRzRmKzQ3L0ZUYkRTUEh4Qk11bGt1TEU0NjM3?=
 =?utf-8?B?d2xaTEZMTDB1WXJmZlJJZDd3bHRHa2ZKTzQzNnZidGt1aG00a0R6Y2JQd1hN?=
 =?utf-8?B?VzFvcmtKcC9La0QxN1BueFJjUWIyaldtQStXamFqZFY2VEpJZGVpcCt5dHcz?=
 =?utf-8?B?cUdIUDZ2ZkxTTzNSb0ZSYjJndW5FZ0Q0VnhjTzQ5eGF4bmE0MFZreDJ5djFz?=
 =?utf-8?B?emFCajRPL3R0UmpTeHk1MlIxWndqRVdwYitxWFpWWVRxaWFRTWN3YUEzUDc4?=
 =?utf-8?B?OGEzQVkrOEVxaSswYkw5cDNtYytBUmNLUXBFMnF5bG5iYzZlL2ZTa1ZlVm0z?=
 =?utf-8?B?ekdKcy9jNlp3RW5OQ2NuZzlva1l3Y1Z3eUZORXFxUlphWS8wTG1scDdXN3NM?=
 =?utf-8?B?UzVPV3d0NGJvbVFjaDRrZG9wQTRoYkx2bjJTakhoalVqMklEdU5UUzNING16?=
 =?utf-8?B?UVpzSlBPUDZ4dy8wVnIrblg5VlhIYi8xWlpOTmZIVzdIUWpXMmVIYkJTN1BO?=
 =?utf-8?Q?AcevqfIBEd4BsonuwldqmLAdr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da99ce20-77c2-40ba-5705-08db05b64169
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 07:14:14.3928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDahJ5GGF3MTZAaEdubagdP+CNzxdImAmy9KYCIM5cxM2+j5/cgJjHxgpCCB1XK61iQ12PESU0ru2kaNeXFMIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/13/2023 12:31 AM, Mario Limonciello wrote:
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
> Tested-by: Xaver Hugl <xaver.hugl@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/hid/amd-sfh-hid/amd_sfh_client.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> index ab125f79408f2..7469691b4a633 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
> @@ -227,6 +227,7 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
>  	cl_data->num_hid_devices = amd_mp2_get_sensor_num(privdata, &cl_data->sensor_idx[0]);
>  	if (cl_data->num_hid_devices == 0)
>  		return -ENODEV;
> +	cl_data->hid_dev_count = cl_data->num_hid_devices;

to manage more effectively. we can remove above statement by 
declaring bool is_any_sensors_enabled = false; in declaration block or in 
cl_data

>  
>  	INIT_DELAYED_WORK(&cl_data->work, amd_sfh_work);
>  	INIT_DELAYED_WORK(&cl_data->work_buffer, amd_sfh_work_buffer);
> @@ -301,12 +302,18 @@ int amd_sfh_hid_client_init(struct amd_mp2_dev *privdata)
>  					cl_data->sensor_sts[i]);
>  				goto cleanup;
>  			}

we can add else or just beginning of this block as
	is_any_sensors_enabled = true;

> +		} else {
> +			mp2_ops->stop(privdata, cl_data->sensor_idx[i]);
> +			status = amd_sfh_wait_for_response
> +				(privdata, cl_data->sensor_idx[i], SENSOR_DISABLED);

slightly more checks even not required but good to have to make sure in right path
i.e. return status is not used so can we make it like below
if (status != SENSOR_ENABLED) {
	cl_data->sensor_sts[i] = SENSOR_DISABLED;
	dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",cl_data->sensor_idx[i],
	get_sensor_name(cl_data->sensor_idx[i]),
	cl_data->sensor_sts[i]);
}

> +			cl_data->hid_dev_count--;

not needed we can use is_any_sensors_enabled    

>  		}
>  		dev_dbg(dev, "sid 0x%x (%s) status 0x%x\n",
>  			cl_data->sensor_idx[i], get_sensor_name(cl_data->sensor_idx[i]),
>  			cl_data->sensor_sts[i]);
>  	}
> -	if (mp2_ops->discovery_status && mp2_ops->discovery_status(privdata) == 0) {
> +	if (!cl_data->hid_dev_count ||

can be changed if (is_any_sensors_enabled == false ||

> +	   (mp2_ops->discovery_status && mp2_ops->discovery_status(privdata) == 0)) {
>  		amd_sfh_hid_client_deinit(privdata);
>  		for (i = 0; i < cl_data->num_hid_devices; i++) {
>
>
more debug information like
dev_warn(dev, "Failed to discover, sensors not enabled is_any_sensors_enabled %d\n", is_any_sensors_enabled 
);

