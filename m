Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114386D527C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjDCUb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjDCUbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:31:55 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C6F40FF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 13:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpYnV5JfO9HnJ0vNS66Wzp1ThM8PrBDRxCBeSTFNfGFjAlhzgrpjZraIjMK6xpv2Pi+p5svOq/uZ6dO2VpkT4oYXn7Ynh2WRkwBlwVpdyFkdptsCR1yVGo1HVh/mqrsk4f603tsH6tFX4FsM5yKI+SnBxtqTh3E7WgOS2tQQBcm6vXvexqPZx2KmLqCTX7fAAkrgqzU2T17MnNEAxUSpwBYiLmaiLCq3WpfJAEqJZKLikPW7STQmnYHrBmTGZMPXTQRxwyH5E295QU9Uzxt7zaB+eR2QZuhz3PA4X8+M1Lhh2BsmZ1Wq2N91el4T83SJ/zcaNLNnySQnDY/1oE8CUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QXh1JgWPThjMwgMaCvSjumpCvn8o/mK13RUlS+zDkw=;
 b=gqjSikqrN0EsfZXwof+XWnYq2hfENVuccaXb1BspxIYy2pb/bdDePqZjBhpYLPk14Pyw4VVCQR1oTNwJd/Q/6bUYGqDwJpN84St0iOZF1KuZ3t5IZPTXy11pNZzminlThz3hlaS0erW8f2laHsX9DHu75tr8zF2uKIyL0db+9FHN2gTObxvQKAScpwSxu0OSRqG7ZftJRw9y85thhjazjcB+ovv9r7vMATV3kbS6oUON2WoHY4lVnWJ9u6ES0Yx0xG54BQQo7qLJG/s83/F+jwB8u00NTdsvL+zRyX8PJBcOffuqhuJXfwyJ8RSSKLuGAEKwDPJ2as2AUm+9+RYhzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QXh1JgWPThjMwgMaCvSjumpCvn8o/mK13RUlS+zDkw=;
 b=Wp8XpnGqFcIdQlD6CYEOpjE8VxTKUKDMRAOE8vGmlfPn8QkIKbSBCStRSS2HEJ3jKs1aj+gzr/9EmWKd1KUFZdva+dFukNQoIHzJEVMiKH/I/mSzD/254NCCgQQ842H71MZvfN/JiGk4UXWZEhRA8Y5JqxU3Dplv0tX+0ImuEPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 20:26:18 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 20:26:18 +0000
Message-ID: <47f0e94b-e392-ec25-c0df-6754c673e44a@amd.com>
Date:   Mon, 3 Apr 2023 15:26:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 04/11] virt: sev-guest: Add simplified helper to assign
 vmpck
Content-Language: en-US
To:     Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-5-nikunj@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230326144701.3039598-5-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0057.namprd18.prod.outlook.com
 (2603:10b6:610:55::37) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 2401001c-ffbb-45d2-d06b-08db3481ae49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wq1PWE8rbSSfpbpl8P3+Zmtob0wNdeLmy+Gfwt7o99ywgAHfNd/P88adt1I78A00fEv5bHL2TszSBQ+mwBOpPPryqMurZIKfS7v3t/tnbSCRXq5Onb4V/Fq146rOD7BCyHOkzVZf0F54wRipx6xci+y4DZvWYheMNn/XhDov26XZllRJ3lQyF5l1oW/a4THKvF1LJPr+CTuQxddOAD3ghavTcbxobn4FhycM0HUuBCMEyBqrEb86KdOQBbTXcr/Hw/QokUH3X25O52Y/Y7N7unqFJAgQAURwc4q0Qwmglni3mtnV3jTQvSacHiAekEIvMGlVi4KLD3+X741hEUyKf3FaBYaPL0oeLw0Sgf/XbzPPkNbUkxIFfaJ+0xD87grETXb5Ft4rFBq4eH8VblxxbZc6+4wEn5/dQ12cJCCdTn74rvQQqdIwlbz2dqfoh9GupM0C7E1xJJWsKPh3sslYdxjN5kj3AeyUwpCPFcfA37ILKyAN4GmUee0sWDzCWPJgO3G64tanjPs7BO/7r6Fl45ZHqEdAJhjuw2FEzuOAF1pLlRKzw6Gu1wxFAcLdWxlwQkb2/ufIjYvefxPldoElaNWZ/MkWu/gINBQvD26jMy0u10SzcCyfZhU6wzCP9Wgs/ZgRWjSnGr5dYQxBM4NvPf6eeAhoJ+DTDD5CdIIMYBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(8676002)(4326008)(66476007)(66946007)(66556008)(478600001)(316002)(8936002)(5660300002)(38100700002)(41300700001)(53546011)(186003)(83380400001)(6486002)(6506007)(26005)(6512007)(31696002)(86362001)(36756003)(2906002)(2616005)(31686004)(17423001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlJSM0ZTdC9hWEtwVGZCSXRGbXd1MDJXTWFBb2tlWUhyOEdib0tZRTNmcGN3?=
 =?utf-8?B?aDlpNGJmcmpZY015L2RHb1ZhK2s0bGdtSTlJZW1RSC9Oai9Kbmk0L3RNZXgy?=
 =?utf-8?B?SEJaSHY1REczTUhGLzdTOHNhYWEySC9XV2tvK214cC9meUIzUjNmMWRRem1I?=
 =?utf-8?B?REVZWThxZEVSK1dJeXE2RkZ2SGZjOFNSa3RQRThMMUp2dVNJa2VMSk1vZ3Q5?=
 =?utf-8?B?UzR1TWcwS0VUMzJLWGJieGt3UloxVnEvM1N1VU9kaUF6elhmdzJudWs3aVEz?=
 =?utf-8?B?WU03U0tGZGZjZU00UURKZUhKY2NLc0RQcEZTRnBPVENaNmdqMWxrRjFSeXZF?=
 =?utf-8?B?Y0VadXFKSGIrL2dpSVVNOHVUSkd2YmNLeW1sUHg2NWMwU1RSb09mNDFXOWV4?=
 =?utf-8?B?S3pTakd3dzUvNmFLa21DeUlaTSs0Wm1GUFFTS2ZKWDg4TG1Jd2RvYUozZUdM?=
 =?utf-8?B?ZG4xMzV4ZlBNRFVhODYvejVOaDRzRU04aUg2NnMyWnBscXY4QkhtNVpkNzI4?=
 =?utf-8?B?VkRrcjVOR3ZEWU00bE1OM1JCM01rRW10YnJCYitkWHV6TlVXaWJndFdhMUpa?=
 =?utf-8?B?RWpMVXdNOGNKUmhQWTlCemdTWEx3Ry9rdmxvMExRbEtaME5PSE5XdnVONUlL?=
 =?utf-8?B?cDcrY0U0ZkR3SVdVWHNXNVV1T294ZnZDZGthU1pXdU10VE9KSW5GOEhhZUtG?=
 =?utf-8?B?YThVYVJHVXB0cVBpMWppbmpxMnZrSGtZN1NiNFBxWE1ybnJGTjZJN1pHL1FG?=
 =?utf-8?B?OWFKdDlzbCt1ZEtaQTA2T3NNQTFmenB3cnllUmRReXd2MTNYTG9pK2NHbzZU?=
 =?utf-8?B?Z2pkZEUvMkZ5bjNVai9EVnZUYy9IUlA5dWtxK09xRWpraHVrT3pURVVSdGFZ?=
 =?utf-8?B?cjhuQlg0TzRQOS81N21sbHVZQ2R4YnlWeEp2SlBsdjIrZDJEUE51QzQ4eThJ?=
 =?utf-8?B?elZyWi9RZGpvQzJ0anM0Zyt0ZU8vRG1idGk4RFJJcHk1WHA0bndhZHNKVktv?=
 =?utf-8?B?OTVlQnJ6N1gzaUZ3UmpRajdzVnVxQWdqMUN6SWVLMFZWUUhBaHJRayt2ak56?=
 =?utf-8?B?MysrRHY4RVZQWGpHanEyNEw3cGw4Q0V5ZTVkbzh5Q3c5dkFXNnNEUmM2VFY0?=
 =?utf-8?B?QTh6MzBGenBMbHFjcHdxRGJ6Y0l5eWxGR2RVVHY0eFBmOWxaVHR1RUgvNjMr?=
 =?utf-8?B?dWJDNmVBQzJpQUN2UUNiTzhsWmxpNHBnRTJsMlhlZER4MlM2bEdGMWNqVjQz?=
 =?utf-8?B?dExhZGVtcVgweWJsLzV5bmhabTVZR1pmNkxaUXFyUW1IT1krTGdiR3A1am51?=
 =?utf-8?B?SktxYSs2elhuSEhDNzhaTms0NnFtQ1NVbGJQY1ZleTUwU2tSbjVqNTN5SUh6?=
 =?utf-8?B?R29NaVZmT2luNjJ4Vm9kM2VxVTl0V1dPUVd6N1YzRXNyYkNSeWx2TExEeDRi?=
 =?utf-8?B?S204dlBPcnpxNW42SEl1VExnNkZaZ1FMQ01wQ1BXUTlWR0IzZGhka24zTGhD?=
 =?utf-8?B?TFV3NjFVcnVrVkN6ZEYzZncwSEQxRDBPNkQ2bU1SR1dJWlhxUzZvemtxMEhw?=
 =?utf-8?B?NWN1bUQrMEl3MWc3dyt2ejZOTjA5VWRodTBHYjBGaURKSURaQitQQ2hnMEZs?=
 =?utf-8?B?cjdDcGk1QUhqWjBNK3VOZGxZZnpKWkhFYitsckVUWXNMYWI0TTArL1hJaFFp?=
 =?utf-8?B?T0c3ZThycEtlNDFKWEFoMU1lOVdXOTFmdFRrOW1KZDJIQnBrdmxjUlFFYnBp?=
 =?utf-8?B?Z0FCZFFITWNoa015SnFrR3IybnhRelpOeHFacWl6TndXK3JqclRNYk90TnIz?=
 =?utf-8?B?M1o4amg5VmpIdHFPWWJIT0V5SnNQNUlyQkV2VkhPYnVUOXB1NmZSRHVIYUlj?=
 =?utf-8?B?ZFAyMVY4Yk5sWHZ1NG1uMkZrTUVhMmxZNWtsclpKKzZZMUtqVVkvN3JEdGdS?=
 =?utf-8?B?QlY0NUxTTElYT3IrR3c0MmRCd1JUMEJxY2hxaTNwSGIvcUljZ0tidDA4TW4v?=
 =?utf-8?B?b1IvOWlNbWZJazh6R0JYL1ZWRHg4bFhhM0VkYjdCMFA0QVpFMWlEbm1WSUl5?=
 =?utf-8?B?RmMrajUyMy8rek8wb2FlOEhhOXo2NU82cEI5b0JXV0Z1aFYwV2hqUW9QWGM4?=
 =?utf-8?Q?tx5BxR2sdYJ102T7tnN6LQjiI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2401001c-ffbb-45d2-d06b-08db3481ae49
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 20:26:18.3972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCQSvWc672Vog7h/8OrSfizUk0Q9VHEcNJbv7X0mBposoYRmejFU8/5NE4/s1zMtU2UxU7TYIfBLo/Hs/EBNpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/23 09:46, Nikunj A Dadhania wrote:
> Simplify get_vmpck and prepare it to be used as an API. Update the
> snp_guest_dev structure in snp_assign_vmpck(). Added vmpck_id to the
> snp_guest_dev structure which can be used in SNP guest request API and
> will remove direct use of vmpck_id command line parameter.

This needs to say more about why you're doing this. The first two 
sentences need more explanation as they don't really stand on their own.

The last sentence talks about removing direct use of vmpck_id, so you 
should probably do that in this patch since it seems to be the real reason 
for all this.

Thanks,
Tom

> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 41 ++++++++-----------------
>   1 file changed, 12 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index ec93dee330f2..4901ebc8fa1a 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -45,6 +45,7 @@ struct snp_guest_dev {
>   	struct snp_req_data input;
>   	u32 *os_area_msg_seqno;
>   	u8 *vmpck;
> +	u8 vmpck_id;
>   };
>   
>   static u32 vmpck_id;
> @@ -80,7 +81,7 @@ static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
>   static void snp_disable_vmpck(struct snp_guest_dev *snp_dev)
>   {
>   	dev_alert(snp_dev->dev, "Disabling vmpck_id %d to prevent IV reuse.\n",
> -		  vmpck_id);
> +		  snp_dev->vmpck_id);
>   	memzero_explicit(snp_dev->vmpck, VMPCK_KEY_LEN);
>   	snp_dev->vmpck = NULL;
>   }
> @@ -339,7 +340,7 @@ static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_gues
>   	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
>   
>   	/* Encrypt the userspace provided payload */
> -	rc = enc_payload(snp_dev, seqno, req, vmpck_id);
> +	rc = enc_payload(snp_dev, seqno, req, snp_dev->vmpck_id);
>   	if (rc)
>   		return rc;
>   
> @@ -364,7 +365,6 @@ static int snp_send_guest_request(struct snp_guest_dev *snp_dev, struct snp_gues
>   	return 0;
>   }
>   
> -
>   static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, u8 msg_version,
>   				u8 msg_type, void *req_buf, size_t req_sz, void *resp_buf,
>   				u32 resp_sz, __u64 *fw_err)
> @@ -625,32 +625,16 @@ static const struct file_operations snp_guest_fops = {
>   	.unlocked_ioctl = snp_guest_ioctl,
>   };
>   
> -static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno)
> +bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id)
>   {
> -	u8 *key = NULL;
> +	if (WARN_ON(vmpck_id > 3))
> +		return false;
>   
> -	switch (id) {
> -	case 0:
> -		*seqno = &layout->os_area.msg_seqno_0;
> -		key = layout->vmpck0;
> -		break;
> -	case 1:
> -		*seqno = &layout->os_area.msg_seqno_1;
> -		key = layout->vmpck1;
> -		break;
> -	case 2:
> -		*seqno = &layout->os_area.msg_seqno_2;
> -		key = layout->vmpck2;
> -		break;
> -	case 3:
> -		*seqno = &layout->os_area.msg_seqno_3;
> -		key = layout->vmpck3;
> -		break;
> -	default:
> -		break;
> -	}
> +	dev->vmpck_id = vmpck_id;
> +	dev->vmpck = dev->layout->vmpck0 + vmpck_id * VMPCK_KEY_LEN;
> +	dev->os_area_msg_seqno = &dev->layout->os_area.msg_seqno_0 + vmpck_id;
>   
> -	return key;
> +	return true;
>   }
>   
>   static int __init sev_guest_probe(struct platform_device *pdev)
> @@ -682,8 +666,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   		goto e_unmap;
>   
>   	ret = -EINVAL;
> -	snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
> -	if (!snp_dev->vmpck) {
> +	snp_dev->layout = layout;
> +	if (!snp_assign_vmpck(snp_dev, vmpck_id)) {
>   		dev_err(dev, "invalid vmpck id %d\n", vmpck_id);
>   		goto e_unmap;
>   	}
> @@ -697,7 +681,6 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   	mutex_init(&snp_dev->cmd_mutex);
>   	platform_set_drvdata(pdev, snp_dev);
>   	snp_dev->dev = dev;
> -	snp_dev->layout = layout;
>   
>   	/* Allocate the shared page used for the request and response message. */
>   	snp_dev->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
