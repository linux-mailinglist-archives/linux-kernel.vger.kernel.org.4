Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41383628B29
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbiKNVNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbiKNVNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:13:05 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B1DB56
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:13:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHSpdaeeYjBwOkGAEyyi9Rr6jtlLLQ3nAH3DdRzDh0Ga5tj7wmqjrhLIstg7LtxfWBrKVLViOZrCgcPPETq6kTizbTuGJS6WQ3QVWamjhfhLdBO8xGBfVsfzZoypF8XGf30/jeSc6yDLK1RzDadbwY9QATLxU3G+J6YTNatrJLlXCNaTUV3yK/O+NZqgf7PIeU7ETjK/2m3YhJ/M96Km2IOezAwXNWzgS1AtTmRZbwl/i79xkHp5A+Q5R2bPJJXmWpGBh4UWk9bOiFz0Vn2tcpd26IHCVgWRzGt+p+eSVPRoXwOz1jom63ICTc1yuIW5+iOWexAYZaTH8uKHnp/+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpbM1Z+ZjxB7zYZjnM1BM1IuLs4TuL3CUMZhVh8MPEc=;
 b=THPVe6/02lX2Pvkr8lYxlWinK4w5n0mn9PnJMRgomBk2xaSYKTSFgpHWWxWYdJ+ggdQ/EsdDaLEH4Jtxpk38VsOzLdIPM3xSAi5ibQdZEa5ZG8kDNibAnE/Oz+Z7euaW4UCJB9CryE/WSJnkolICxym9IDWxejRaOEOaKMfcVybaMZUWm7zoUBUGAlClYLoL8W+OOLPO+YkcopDfQ0diQF+7rWBd0QP5aJfBgWlW/jrmYmUicOaDImJE3+NcXjyz8M6+TF+RgujxhZfjXpZ2asZp9glx8+hcVa17qSsjs57HSe8Vl6WKRkEIFXiSpDlGR0T24c7fsBZ7Gz4skGOnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpbM1Z+ZjxB7zYZjnM1BM1IuLs4TuL3CUMZhVh8MPEc=;
 b=IC8Xv3Os2BmZJFIv2Bteg6lHMiVA1dyL3SWjUiNBxjRpQA+qRxcOkEQL4NSfe5liQcck92P2ZK5IPqan5NNIAt97XvclCkswG3MK9XSTgPB8yreVWPtOXXXbI2p9nmZoZU6wARiDotn/zfUq4nTdfIZmmjRSp7d5gFEz+rvXt+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 21:13:01 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 21:13:01 +0000
Message-ID: <518bfa74-ee4a-4539-3310-130c07916300@amd.com>
Date:   Mon, 14 Nov 2022 15:12:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 3/4] virt: sev-guest: Remove err in
 handle_guest_request
Content-Language: en-US
To:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Haowen Bai <baihaowen@meizu.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>
References: <20221104230040.2346862-1-dionnaglaze@google.com>
 <20221104230040.2346862-4-dionnaglaze@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221104230040.2346862-4-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:610:e5::6) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f54a42b-fab0-443a-9e62-08dac6850362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQ8jadZrRot/2wP7ADQcZw4sslNpLKWyL+w7Qpym3CebQoU5RlZXyon6rCxs/vc94XSxbgyGZy3pfUyZZKIMdnjNuetc/DkoOrfdu4ktbH3c4MftgRgHi89ISwjXJggoGB2rzhP97H5/W4iQkaOHM+Hb6wqGUyKLaR48Hae3WIxCNOIo3Qruoe/4Itv/fZw/SqtVDf9qsyOPx+AtD1KcgNbuIXlJUqYKX8TR0AZSZ1cGIVpLNWSc+sB1ekPbKDDXz2273JrozbDhnleq330CFNI8kcUJdLcILDUYJjnlgZgwJaq+naf0dflSCevslbgH/Ol4uEkW4dwqSOPE3OTUqDxT75x7fa9iinyUjstR0wjeMDz+zBclmirqVwVtOG+XhikZ8JB5mrlY/onPBrJusEtKgNXohDt9eX7/Bh8yTcH+9XyiLqDY9N40xr5KyYEgzTDMKzidxMezstBAldJZYvHoNZMIRUlTrNJMr4NwuK+jvy3C2A8Jz0GNxzzt1lBfzV8MAIErc1lXiw9tsQxRDrEraGFcgJwayAh4lmH5Pgcb0RC+mweIJ6Xug/xbpPe1TfypQNGHqXQd0335BrWDwZUZ4JRMg0CS45anxeHeNQEhLSMRPe5yK2VdRMUJV1IR5HGfGYqcmFQ2OzJs0CT/el7GinZcnH6sFaS4B/YpMNcFLdUENyt26WLqdR6WGYaueiG61mi9RAP5DyTmk/8fmJ5371/dEdtX5qS2kihVWD64nLWNtJysEfpxAjw1jpLh+UdzV+asQ2ylXwPJRzk8BGmOHt1cq//dmHtflk0Hnr4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199015)(478600001)(54906003)(6486002)(31686004)(8936002)(7416002)(2616005)(36756003)(6506007)(41300700001)(86362001)(2906002)(26005)(316002)(53546011)(8676002)(6512007)(66946007)(66476007)(66556008)(4326008)(83380400001)(186003)(5660300002)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVptS1BhRTcrVkFXcFhmdjgyWWF1Ujh5Y0FLdTA4V3NpMHNRWkRMR3pMV3VF?=
 =?utf-8?B?TVFOc3FxL2JQazZaZ2hZN3RDSWVLOGJ6M2hYOTJyVENDN0RYR3NRYnBtMDgw?=
 =?utf-8?B?N1BUTXNya1N3RVB3QXJ3eVd6bCtDbGVOdnNGc3NYajVhQ0ljWk1iWS9FZ1Jq?=
 =?utf-8?B?U2xRM0FPZDlvTkd4WTNCMDhPanpLNUVMdGk4bmhaQXl2WUZ6c3FzeFBoU2h6?=
 =?utf-8?B?YTlmdkJnLzNldWhnVkRaZ0NTb0kyQTNDNXhwVXB1ZktPQXlCUXFpeGQrNTdh?=
 =?utf-8?B?NFE3TXFuR0J3QjlqMG1GS1M0MENIaUc2WkQ2NTVEK3RrQWFsZWFNN2U1TElu?=
 =?utf-8?B?THVZdmRlYVhlSDJ4V2dYQWZjTlBpenFaQURvNVNoVmhialFLRHBXbzhiT0Zq?=
 =?utf-8?B?L3dEa2tDbjhwYTRXbkpaZnhoTzFsSUhxRjVjQkdnTnRKT1dzeTNDY24xaVpY?=
 =?utf-8?B?Z1R4RXgybERQbGQvOU1DR1N5cGY3Z1plMHhWWVJkNjR3K2paWGF3clNobVR6?=
 =?utf-8?B?NE40d1oxVXlGeGxqNGNybHJnd1Y5QmJxZHFvQlU1MWRRVDVEM2hNRWNVYUlW?=
 =?utf-8?B?eWZXdjJJaDBWVDJyQm00ZzJjN2huZHcza2dPOU95WVB2aUJoTW0rRDZ5dUVq?=
 =?utf-8?B?dy9qdXdmc01aSW9GM1dHWkNUL1F5Q1lqUHdXTDI3dHdyK1Y4UzZSK1RhVHZt?=
 =?utf-8?B?NnYvMEs3c1FUdkVVcjFEcnBRa09PRDVIcXBpdE1JdGN4UEl1WFNEWHBlbW9M?=
 =?utf-8?B?K3RaaWYxK0k0c3U3Y1RyNjN1cUdhM0ZIT1NDQld0eEdLcUFBVkx1UUNzMDhi?=
 =?utf-8?B?VVE1Tm1VSnhrdHJnR2NuTXRYODB4MThxUEthcGR3OU4zWFJhSG91ajdmMUlp?=
 =?utf-8?B?T3A1WHNEbTM3UmZpcTd0TFdKekFVTFhhSnNobExnOHQzbGphVTNFMnJVOGRo?=
 =?utf-8?B?Q0hOWXMzekViY2NwY3hsVDFDb2xiUTB5Z2F6clA5WlJsZE95Y1dMbFJKdzRF?=
 =?utf-8?B?b0liL0s3YzJOQ25OaGRXeElGWEFXVTd5M3V6SStmTWN6N3pxdWhKVGRzNXQv?=
 =?utf-8?B?SklmSVQ2ZUl3Wm9GeVpyaXBkOGEzYTI0WXBmSVRvTnpuVGMwNmRmcEN3aDNu?=
 =?utf-8?B?UENUTWp3clBqbWpUR2JVdjdpMUdKQXo0U01May9kZmpIeHBWR0Y0dWF3T1BF?=
 =?utf-8?B?ajA1dzNSSUJZOUphd25EekVqRTFMczFHT0VuV2gvYXdXTXVLQnRHS2luZUJI?=
 =?utf-8?B?ZXZ4OVlFbjdJbEpRL3c1SWdJSmFlWFI3N2ZMZlYrWWlHL0lmcG02ZTN5T2hk?=
 =?utf-8?B?Rm00YmE1UzNvbmN5eVVSZi8wdm1IdkxEbTYwZENId2VSb2g0ZjFPOUYydWlk?=
 =?utf-8?B?VFVma3ovbFZoVVYyV2hEbDFqR2xxak9hdFdxMW9jWUEwZmdUYXFKbDF0TTZr?=
 =?utf-8?B?dDJwai9RMmZYK09Xa0Y2OXJVVllqdG5VWUx4RkkwV0tOQVVubUk4eGpscDBU?=
 =?utf-8?B?M2ZPOWdFdWVVamMvSVF5OVEvUENSWGtBODFVZEtGaVBVQUQ3dzJ0azNHZWpQ?=
 =?utf-8?B?SHVSeXN2QUt0UlE1T0ZsSm5DZHkxTFZCdFJxenhOWitsZW52bkN2dkNtT0xQ?=
 =?utf-8?B?bVBMOHV5R2pacDZtTmFDaU5RT0hzLzNlZGhNdG1za2lLUFUrNXZzRmhjUkI0?=
 =?utf-8?B?TmZJUjBlckNYVEE1M1ZBaVNLQ0IvQldGKy95Yy9NTFROVlV3a3ByRWdpQy9j?=
 =?utf-8?B?dnk4bWNFbldocWpkUlJiZEMydTdFTE1VYjg4RUVLM0FFSVR3QWpzL1V2ZEZm?=
 =?utf-8?B?c1hpUzltMHdnSFFQajBZQ0pjRHFjbFJITFIwWWYzQS8zc2tsQ0ZHL05PSkRj?=
 =?utf-8?B?bUF3M213cGRQYVV0QytNRjAyWnFPMlJDUWowdlNac3lmRXFMaEtCczJ2SmVF?=
 =?utf-8?B?aG9WeEpNdTlzTjdqZXJORk1vRmRySTYxY2JtUnZlWkQ1TTl5akhZL2p3QlB1?=
 =?utf-8?B?MDlLYWYxZndreU13T1Btbjdka0svNklIV1lFbS9UTW5TRDNQdXN6aXJYYkY5?=
 =?utf-8?B?V1NCM1grVWxqSEc3bEdPcHA4eGlRcWhxOGt4YlZSZm10aWtxbnN6SmRBVEtl?=
 =?utf-8?Q?bSR7LhlToXB9a4oa9+Ky3mPJf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f54a42b-fab0-443a-9e62-08dac6850362
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 21:13:01.7185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LDt5o33b32sIpRhGcQuYlwMWao9oy3aYV9k+hYQXzaveO7Nuu/YfiIawbavsL+GsU3ek6K075RZbedZVl0HDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 18:00, Dionna Glaze wrote:
> The err variable may not be set in the call to snp_issue_guest_request,
> yet it is unconditionally written back to fw_err if fw_err is non-null.
> This is undefined behavior, and currently returns uninitialized kernel
> stack memory to user space.
> 
> The fw_err argument is better to just pass through to
> snp_issue_guest_request, so we do that by passing along the ioctl
> argument. This removes the need for an argument to handle_guest_request.
> 
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Haowen Bai <baihaowen@meizu.com>
> Cc: Liam Merwick <liam.merwick@oracle.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> 
> Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 37 ++++++++++++-------------
>   1 file changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index d08ff87c2dac..5615d349b378 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -320,11 +320,11 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
>   	return __enc_payload(snp_dev, req, payload, sz);
>   }
>   
> -static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
> +static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
> +				struct snp_guest_request_ioctl *arg,
>   				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
> -				u32 resp_sz, __u64 *fw_err)
> +				u32 resp_sz)
>   {
> -	unsigned long err;
>   	u64 seqno;
>   	int rc;
>   
> @@ -336,12 +336,14 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
>   
>   	/* Encrypt the userspace provided payload */
> -	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
> +	rc = enc_payload(snp_dev, seqno, arg->msg_version, type, req_buf,
> +			 req_sz);
>   	if (rc)
>   		return rc;
>   
>   	/* Call firmware to process the request */
> -	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> +	rc = snp_issue_guest_request(exit_code, &snp_dev->input,
> +				     &arg->fw_err);
>   
>   	/*
>   	 * If the extended guest request fails due to having to small of a
> @@ -349,23 +351,21 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
>   	 * extended data request.
>   	 */
>   	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST &&
> -		err == SNP_GUEST_REQ_INVALID_LEN) {
> +		arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
>   		const unsigned int certs_npages = snp_dev->input.data_npages;
>   
>   		exit_code = SVM_VMGEXIT_GUEST_REQUEST;
> -		rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> +		rc = snp_issue_guest_request(exit_code, &snp_dev->input,
> +					     &arg->fw_err);
>   
> -		err = SNP_GUEST_REQ_INVALID_LEN;
> +		arg->fw_err = SNP_GUEST_REQ_INVALID_LEN;
>   		snp_dev->input.data_npages = certs_npages;
>   	}
>   
> -	if (fw_err)
> -		*fw_err = err;
> -
>   	if (rc) {
>   		dev_alert(snp_dev->dev,
>   			  "Detected error from ASP request. rc: %d, fw_err: %llu\n",
> -			  rc, *fw_err);
> +			  rc, arg->fw_err);
>   		goto disable_vmpck;
>   	}
>   
> @@ -412,9 +412,9 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>   	if (!resp)
>   		return -ENOMEM;
>   
> -	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
> +	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
>   				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
> -				  resp_len, &arg->fw_err);
> +				  resp_len);
>   	if (rc)
>   		goto e_free;
>   
> @@ -452,9 +452,8 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
>   	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
>   		return -EFAULT;
>   
> -	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
> -				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
> -				  &arg->fw_err);
> +	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
> +				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len);
>   	if (rc)
>   		return rc;
>   
> @@ -514,9 +513,9 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   		return -ENOMEM;
>   
>   	snp_dev->input.data_npages = npages;
> -	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
> +	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg,
>   				   SNP_MSG_REPORT_REQ, &req.data,
> -				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
> +				   sizeof(req.data), resp->data, resp_len);
>   
>   	/* If certs length is invalid then copy the returned length */
>   	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
