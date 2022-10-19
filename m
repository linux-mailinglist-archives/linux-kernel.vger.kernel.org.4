Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF0E605155
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiJSUcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiJSUcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:32:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99118171CF9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCDaIOvf36BibAHn6KHQpOdywcPez3/dJ3yKCPw+/WGvkezpz9BmgrE/Ia2fUU7b63Eaf9dODMv+3NLyPuhnHa5fciogpYsGgaVgMlGIW8Ghs0QbNEw2pVId9TseYhxy0+readYL1NngA/IuO+ZzHXDMZGplfgoCgoFWK0B8nploys4yDR+I4PkbwMPzJhXeqxeXazds1EsJm55czRobpUM3dbq0rtNc+xCFvZCsH4VGziS0D5QKf57QP0J1AIluqep3HwO0dFGltnwgwJbNg3dZoWvJUKyM4ibCCZlgU36oncusolONqw3mAK0G7wmjYa6LGZ3QOSj400V9vnDvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCBfGEuRcNmA4eBue8yWbtiSW9iI4mm8jWAKfTOzMW8=;
 b=ocimUEIrM+cJO+7BITumkpYnx2s+7SHgWz220gSO7RpHF2wdQC/xJPOI/S9JKnfu5OJG686x1N3hPntAJk3Q6dZsq4wFsaTh87mMCjOXdQ/ZeMtMJhPccCc1mbQGOZh815Glliba8l/gfZE6O7wXs1J11Sy4eQO1TwIVxU7sP+vVrZylBufAop8rIg84fF4864kMt2cmRsMcRiLivArGyKcsnKBC4o3Tp6isxFSJ6gKoag+c/ErObEqwyKEH/G8s11+fno6DkT5hZW+aW7apqD0ppxrPWhR9KYNB7rGg3Xq3iFJDuwdWoOhL1BOYDHoHE/+V4a1R+lO59Gk7jqqeFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCBfGEuRcNmA4eBue8yWbtiSW9iI4mm8jWAKfTOzMW8=;
 b=zTO6C1eYOhN8HrpHieRekqg0jR1vWQzwsNpD6BNK3Gnak/2JYTyTv2/8vtufmzH/t86M5BC8+mKwN/BWhjEkhsqo+xbeGE7P6F0yvJMJqMS+2Rz4wxdXqWg4iWksilpYKMFMcGie93raOw9ewyciMrKOD0Ag3Of22SP6UnXMW4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB4580.namprd12.prod.outlook.com (2603:10b6:5:2a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 19 Oct
 2022 20:32:12 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 20:32:12 +0000
Message-ID: <3265d311-0e02-6e98-377a-d93a5d0b90cc@amd.com>
Date:   Wed, 19 Oct 2022 15:32:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] virt/coco/sev-guest: Remove err in
 handle_guest_request
Content-Language: en-US
To:     Dionna Glaze <dionnaglaze@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20221019195815.1298915-1-dionnaglaze@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221019195815.1298915-1-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:610:b1::16) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM6PR12MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf0fda9-c44d-47e7-cf36-08dab21100c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9Qq1XRYb2TWInDRvAeOnIxWynOswjHyEPftxncCOas0Zq8RMDZVD9w75dAO0RVcZ9NNKidlKWO8aBY/aLlFHqJlV9e2z1uXjaISTF78ZLV3CjDeg+j4JwRa0rJrTKPawGsCLbcM5RJPfTfmXO6BPOm0CnPW4dlblPGjqlYk59DDepxxgH9w8p8NzUIB+Zd7IvYfN8g/hIr4S+ycjtitWopBLEKK4lTA1AEQCmSz/NVkpTtd32F7nsljCDXEd2inXWoQjb7BtqYH0hcnYr1lYMy6S7B7TywwcULrMKllxY9O5JCre2T9LOuSubkFao7DMMfLaKZxGfS44trpORah1WiU3bP7kn9QV0NSK6wSx5cwoFqGNt08BLyEizlBSbKHaSmJ86hrz9/gfYbaRgm+9JpfpqKDs0Ui7M8zu8qVu4TKEQugpiFooY1qSU5kK/VdaDlZ2HmAAuAFwp6RfCSTQBq/vajioJK1X906ChyfPMkDcQxp9Oz/YU/4A5BxvWlmkZlzUfPInJRqhZhdODmkRA7kUZ0Ba0R+rv5d4udjUEfpUVbCvMz1oQ/w8HyvTF5wGyqJB12OgEIO30F9wG2SZWSZ6iyAG/UnuEjDorbvYJjLzw63++Nht22g3vBb4iuBsZDMh5/5cRftL20LhQZ6kLjZ1SeCT2n7HSSnYph9r1H/PrO3wX8N6H9cA5eY7YQRbgxpZxeFtBYQMc8g5qcgvDZ7eKZR0vMOYPh+a3WFKJNtAoN7WSVlHljESYeg8UnG8k+6BqWNL5HUEztP0v8/l3vuat2+JNEAYRynzOZlGsOgJefc+TZsl+8qo91dQWKjv1bQxvJ1R+2+NCd7hqEELw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199015)(316002)(54906003)(6512007)(8936002)(26005)(2616005)(2906002)(186003)(66476007)(5660300002)(8676002)(66556008)(4326008)(66946007)(83380400001)(41300700001)(86362001)(31696002)(6506007)(36756003)(53546011)(478600001)(31686004)(38100700002)(6486002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2JYSlhJMFZMRHBlZEd4NmZ4QVFoaFJiQUhkc1dCR2V1TDRBTy9CSERldlla?=
 =?utf-8?B?Sjg4Q0UwZ2ZZQjZkL1p6NHJQQmxvN2V2SnM5cDloRVFSUFFKRzdoKysxY3Vi?=
 =?utf-8?B?VFNjOHNHVENXaFdiMmp5K1hSMll0RU9ZWnhUK3kzM0ttL1l2Y2gxbnlMVFFW?=
 =?utf-8?B?ajcyVVA4dktld2p1WUh4c1poSHVsVVV0eUcvL2RJK1RhZUZ0aW9JRGUzb3RL?=
 =?utf-8?B?TXBxZUdLcWlOK0RmWThDZk51QXFCQkhEcEFObGRGa1lxREl6N2lSbDM0V0xh?=
 =?utf-8?B?UWdZMHE1R2I1VFdrdUNiamNCRHY5azZBR2hncHI5OU9iOW1lN1crVHlwSXpV?=
 =?utf-8?B?UW1RUHNORHkrRjhvNHcrYzI3U3NyZG1qREViUUphVEo4TUFScVBJa2lBRWFz?=
 =?utf-8?B?bEsxMmpCdVVpbndZczhwM25PYTgxckFwenlMQjlkdmE1a3lOZU96emVHSjZN?=
 =?utf-8?B?Z1JtSUxaS1NVcWt3MnVVNnJid1hWRXpISDVlS0ZnN3orU0FxYkM2eWFjcFB3?=
 =?utf-8?B?RXRJNlp2VmF6TVhqZlVJT3BkWnVOdUh5Qno4UVl4K0Q3dVNMUUtDV0x1MXFr?=
 =?utf-8?B?U0hGTU5iMHlTNllRKzVrQzRDM0dlV0YxaFZiWGxKbTFUTU90TTNUSWlEZ0xo?=
 =?utf-8?B?T3N4azRHZWFHWGdyN0p1RUJyT1JHMjVKTzVDckhUQm9yemx0bG8vUkM4Tlp5?=
 =?utf-8?B?VDMyeFBrTVhPUjg4MXBBRW45SzZrYU1kK2NJT3NZZWl5UE90SThzSTVYVU0r?=
 =?utf-8?B?bWxtZ0J6WUFpdno1VVkwM3FKWUZ3eG41MnJuNXNldHdpWDJwNnI2dDNSbms4?=
 =?utf-8?B?TUMxMnhqalp4ZWtXZ2ZVZlJ1THQyM1BralAyb1B2QnZJMzFEa2wraGdkc2pl?=
 =?utf-8?B?Y1dNWXNHMGlUeGgxcnlVUlladzNmR2E5U0k1UW5RR0dlMmVQME5SRW14Snp6?=
 =?utf-8?B?Z2UwRysvTWpRaHVLc1gzRUM4NWFZMW03M0o3dmlDWE5XT3gzdDJpV01YQlMv?=
 =?utf-8?B?eUJSaW1ta282R3dSM29jSFUzUW5EdXJPNnd0U21Pa2QvU0tvWVJDSXBXNzZP?=
 =?utf-8?B?a1g5WXIvN05PeWVvSjZ2MVpKYVNDUE13b1EzcXh0TnQxRDc5S24wQ2VzZHcy?=
 =?utf-8?B?Yi9hd1N6OUprV2xva0lDMzF2Mkc1R1UyODVZVkd6WlRBYUtMYUFTQnBBRHVp?=
 =?utf-8?B?UEtDb2lETk5Va0diYnIvVFdpUkhGbkpRQnVkRk1QanhRWFZRVElUbFpKUGQw?=
 =?utf-8?B?SWR1WEMraytoSXJYcnRWQ1J2S0VoQWRSY2o4bEFLUzFPb1NQSWhwY1BkY2g5?=
 =?utf-8?B?aEJ6V09abk9iQ2RMZDBldHZ6dVIvbSsrMHhHY2JJcmlnUnRuMXdIMjBSM2F0?=
 =?utf-8?B?eXpzYkM4WVFDSFcwZzhkeWpuMThmVUlab1ZXeThuY3ZpTk5uVDI4WUc4VTZJ?=
 =?utf-8?B?eDJ0RUU4M3FnSW9nMlhaYzhraHNBN2trajdoRzM5YXJRa2ZLbEI5ZWExSDNk?=
 =?utf-8?B?U3ZvYUtqdEt0NFN4VFh4RThiemxJRG9lZlNNZTFodml2V0kzVVAvWWdIUUo3?=
 =?utf-8?B?OTZKVFF4bkYzWEw5aXVhMVU3aldqNUd2Y0NqcFJtQ1BYRkYrcjZST20vQ1JK?=
 =?utf-8?B?TWkwVE9WR2srei9QNFFRL0w5Mm5SaDNyRjdoOFByTmUvVVl1RGtzK3FZOFB4?=
 =?utf-8?B?UjJ2NGJObGhpVlVPUjBQNTJMUVRrS1VYYVROWFBTNGVwQ0JjclpWUEVnNnZp?=
 =?utf-8?B?RVl6MTFablVFZHA0VXlNTG9LMVpQMkZteWRQelFEeDkrVWlTQ0kyQWs2MUVP?=
 =?utf-8?B?d2xjYkhsdHJuYmhYa21GYVhIb0NnRUpDcncwK3dVNUZXbER5TkVoZXRSb1M2?=
 =?utf-8?B?YTBPcnpXMzdMeVlIck5iNXJtY051dXFjeW9Nak9kZXVEUHVpa3NxK3ljeGRK?=
 =?utf-8?B?ZlVnZDd4cDdvNmRmMG9Ybm9yZEVFSUpOSEtRUnEweWtaV1poWGE4eVZYQjRt?=
 =?utf-8?B?V3diWnpueXV2czNjQmJPTmEvYitnS3Y5aHBtVkhLdXNZWEV3cTdJOW9aSnl5?=
 =?utf-8?B?WEdPZytuNStZcExZTnBJN05CekN5RGhHeEErQWd6d0NCam1aYjBFTmMyVXF0?=
 =?utf-8?Q?RE0sYCRnA77DxlbsB+wtMsA1q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf0fda9-c44d-47e7-cf36-08dab21100c1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 20:32:12.4016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJZ3KfHStVSzCorVoo6P4HstUOpubqrq5JxzOjs3NOfLjxfCuH7qtbrtsO6Y4hWgeddvecaCwie7LlnQJ77XFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4580
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 14:58, Dionna Glaze wrote:
> The err variable may not be set in the call to snp_issue_guest_request,
> yet it is unconditionally written back to fw_err if fw_err is non-null.
> This is undefined behavior, and currently returns uninitialized kernel
> stack memory to user space.
> 
> The fw_err argument is better to just pass through to
> snp_issue_guest_request, so we do that.
> 
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

You should include a Fixes: tag.

With that,
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

Also, you may want to base your other series [1] on this one, since you'll
likely get conflicts if this is applied first.

[1] https://lore.kernel.org/lkml/20221019173537.1238121-1-dionnaglaze@google.com/

Thanks,
Tom

> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index f422f9c58ba7..00708b4491e0 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -305,7 +305,6 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
>   				u32 resp_sz, __u64 *fw_err)
>   {
> -	unsigned long err;
>   	u64 seqno;
>   	int rc;
>   
> @@ -322,9 +321,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   		return rc;
>   
>   	/* Call firmware to process the request */
> -	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> -	if (fw_err)
> -		*fw_err = err;
> +	rc = snp_issue_guest_request(exit_code, &snp_dev->input, fw_err);
>   
>   	if (rc)
>   		return rc;
