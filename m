Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720756114AF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiJ1Ofv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiJ1OfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:35:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C133969EFC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkiS+ARE5eUrs4O6EFz5aUJxtl974e9r2xoKWXE2zgAirgYBbceWGFOQn3jZojy9+MKwLw8zxfkS4ujuB0CFtqP4QguJx2PBmW6gYfvG9vjSxUbnBrDRCCRwdGy7sA4wdlkeKMOxmpY0xfSzFjUCdYwxuqeTs+l7KP783Xmt5LAKvCgI9PyfRERlP4pnruCrDU2WbL5pH7OgrJzOd1e02QDnjBK762VIfoDEjAPyZIA6vYkkNK/YEc8U11mKQIo/AhwIGEAc6k0VSJe9GCU58hHCoVdKOW7YnCMrW1lUEE69HN1PaZ+bhCFnnlc5Cubb+CodTrkDqwb7stRRbRKy5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIi6oNYr5gxuijbtHtSK7K2/Fd2AENQTeV7DTEIWQiQ=;
 b=WBoiiVKch34BHEm7PRsr1wRB2YIb8dJiqbLHREMVn9LSWcj9DG/kkWtUUZB5nJfJ4UT+24FjJkheJQuabpwNHRK7AyrufORutRASbv902AwtOPBCxVjTis2jZ8oKlda+P4EE2Qjkneixqvw5jdPGo0p/h95zPN89JPhG/3p2QIKiX+lSzMVGJ9Ek78LHKub1axB0yz9GYZzUdgp0rREeYfOO4Ft1NkdgnQz+LXmmnQAMDtLlROsW4dH14X3wmKJ6Q8fBcojYVvqtH1wtQgI7r/V4MBsfRElzuyz+DP08qSUtUB/sz5aDIYsrUqyAs8bqTG5VWMG4BqnXZxDUoDHYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIi6oNYr5gxuijbtHtSK7K2/Fd2AENQTeV7DTEIWQiQ=;
 b=XwnT8THa1EqhUN48jM+JUHw+JC1BlkKTbvpcBuC+mF58RuYzqW1D1mAfuRUYSttsXEcGYk+2KjDN93/YxQqhALJPFFnP7OiwgiOV6OHzLdhvNlHbnRKjBown99gnlN89fCV/awHmqPNQBdseJTvdMZc5QoNJhlmtyi7ZDaZxXhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 14:35:07 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 14:35:07 +0000
Message-ID: <a3379b77-9cf5-dece-191e-60c4e9518b93@amd.com>
Date:   Fri, 28 Oct 2022 09:35:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 1/4] ccp: Name -1 return value as SEV_RET_NO_FW_CALL
Content-Language: en-US
To:     Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>
References: <20221024224657.2917482-1-dionnaglaze@google.com>
 <20221024224657.2917482-2-dionnaglaze@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20221024224657.2917482-2-dionnaglaze@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0048.namprd04.prod.outlook.com
 (2603:10b6:806:120::23) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: 905df47b-13ec-4e96-c9f4-08dab8f19c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wGah1tVLRZHSbCOeLUo2aMBLA94IeQueJly6j65a5nU1zwC0pPIQn+P+fVt3E9MHjlkFWVMIPcoLMM11E51FqBjRN2ux1+QkHgEG6OKFrrjIl55wITFEsja/LpKo7tx5WnyASu/xUMtfubfzD+vjdE1dwLr1pTsPdgAJYPjGl7hw3FirTd86YFx/DqzX9mvHuJnluz2/IeBWLTYDdAcuam18bHqRxpCFMR/NNClXhKoQOAARIfO/BZxubsjvFsIx0q2cRBQUKrljf/zGUW/HGSujU/vSqohn0iI2dXjPBm2cI86xvgTIK0HoN6rXMcbWpo4AGGde4BLmWIGc0TOSVTXhXWqZfpcI3Hh5ppq9v7CwLALdQ56PbZ9JjVrfvMSBnznJzcTp91LQ1kwUXAdAlKuHrXcDWQxMc86Q99c3gzlsIIGMmpy33AHxcXxss+P6L2BMvOtef9guz6vsTDgTcxYfJ9a77omxn8+4dANud3Jj8w9RAAeXzS6omFEET+TIkvp0dxMmjuc7k9ZX9KjC6uWu07qPhiqbo7Pu72Tqhhm8iRIU7sS5rOI0M/1Z/7KqubrYCPb0qDTPlay32Jn4cXxDnh2Qywz8obOECjhX1R3kG1IX4w+Cl8lWiSKusAcpxsVBGTs7hm4MK29uYs6oIRBMK5NHwF1uRtmnsisGBN2nshNw55bBGihSM9He1ZhwyKkauKJdLjSKzCvFSEizD5HGyJ5YFBVyL2j+X4JGB7PAOkkFwfG3I6+YBeIJJDQbaH3engIpRQiRtr4y9fTKtiA9/195PILWWGmnETG5y54=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(6486002)(36756003)(54906003)(186003)(478600001)(8676002)(31696002)(86362001)(2906002)(38100700002)(8936002)(26005)(6512007)(41300700001)(6506007)(53546011)(66556008)(66476007)(5660300002)(31686004)(2616005)(66946007)(83380400001)(4326008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVI2QzMwWlMySzB6NDM4ZHdDUE9XdkxLcTFmWG81dXdseHZuTkVwNGJlWHBE?=
 =?utf-8?B?eExpRWVnT1ZlMGJpMGV2WnhLQW1OS1BWS2hhTVpieVRPVVFRY1BqbVNSV05R?=
 =?utf-8?B?Sk9mVFR2V2Nkc21XRkREa05IWjNLdGtKTUNuRFl3cFdBZXBtSEt1TFhBSmp3?=
 =?utf-8?B?c05DQWlLZ0ZjNlZTNEdVaTRFUkFtNGh5OFhCZzNsYlc0L0VxZzVBaHliY2E5?=
 =?utf-8?B?MHd1TjFzdzdlWXNVK1JObkl5QVRad1JOeHNIY1JCNktoall0aC9jQU5sS3d4?=
 =?utf-8?B?bC9sS1ordWlwL2RHTDh4OThqNFRCdlVGcC8rMWdTTnlIRFhPRytSNXpVNURZ?=
 =?utf-8?B?bGlYdzdGK3JjaCtJWDJNajBTbkJENC9OMk5kMGpFY3ZxdWE3M09BSVdzWWpT?=
 =?utf-8?B?NEpKR3dkMXF3U2hMQlY1WVBkcXJRMkludGJlUkVwTWFSVjRBdE1oOW5WWi9H?=
 =?utf-8?B?SG1ZWCtuU2M1dnF6L0lITkViZmxGUW8ydHdZK2lxRXRJUFVnYmFydnArZ1p3?=
 =?utf-8?B?OWU1Wm10VmE3UlRHQ3EvU1FIM2NZSDJlUVF5VjB0MkdkVWxVbUNlbC9oKzZO?=
 =?utf-8?B?dTF6TC9KUnlZQjY5MU9RZ21PL25yTGNNVWIxdXp5eGJKVVFJdFFMSVZrdi9v?=
 =?utf-8?B?TGlQRE5TWXBzU2MvOGpyV1Zib1pJNzl1K3lSMkFPeGUwTHF0RmdqVitrTjBN?=
 =?utf-8?B?ek5lSFN4QktrWTRRZldZQVBaRWlWUWdQRnFVbTcweHBXeDVwTnVac1dZaGFM?=
 =?utf-8?B?OUJYOW1QMVVRL0hUaDdZbW55ZHdwUERkdks1WVFiMVRETmJGczYvQlFQTzNH?=
 =?utf-8?B?Y20rM0pYTjRnY0dqWTRKL05rS2FMRWFzcyt3b2RvZklFTWg4TDN3S3JjNjhs?=
 =?utf-8?B?ekZxS1hjWjR0WTIvQVIvQUR1QjZIY2N5QjBlYjl6cHZrSnh5TG1QVDltQWpU?=
 =?utf-8?B?dm9iUjl0Ulgxd1B6Tk5MZXRpbnhDOXFrZkUrWkVOdzNHOExlMUNoSmw4MkZr?=
 =?utf-8?B?VGFJMWhMdTBHbUNEc0ljVDY3c2ZKdnpKWUNRUTFCM3BFQ21XTHFkU2hoc0hn?=
 =?utf-8?B?THRiOG13VVpqTGh0RzA4Nkd1TnFMUWg2aGVmQXlEblZCTXBScDMwV0JkMUxD?=
 =?utf-8?B?bXFqUG5LVGdzNUlyd1gybm1BamxOcml5WlNhYVhBUEZQOHVUQzk2Z1NsaHdG?=
 =?utf-8?B?TysxQWRVNFlVTG1WODNkUjAxdFFoeWZScXZOY25NU3VjY056eFhlbXpBYW0w?=
 =?utf-8?B?WUhEVXBsWG5tL0JLYVV1M1k5QkRVUmZUaWdJUDB6TlViRjdpQ2FQV2VYdTB6?=
 =?utf-8?B?NmhGRVVOMlFVcm40eW9CbHIwRlZZN1hubHdZbjU2MW5FUFlXTEw5dW1Mc0ZJ?=
 =?utf-8?B?bWVmcDFDamtFa3R1OENhWDAzV1NJeS9GSVVVU3JRWnFPbFc1THpqQncvMFU2?=
 =?utf-8?B?M0l0VUluekVVeUdnWjJmUXVUVGxDVWJ6Nzk2bVBPQllVeDlENEI2TzRsVDhO?=
 =?utf-8?B?OFJydUtaVGV2NVRPbnpTQkFZRTlSdjU1d0k3aFRpTW9NTlBxdFluUEFpSnVT?=
 =?utf-8?B?eHI3d05VMzVmaWc1VzdkRG9ZNktGbGg4T2M5Wkx0QVhWbFgwamw3bFBOWkpR?=
 =?utf-8?B?M3Z4Z2ZnMFBBTUk2VDA3cldqbmFEYnZ1QytHMUtmbGFIVktoWm4vN1d4NjFl?=
 =?utf-8?B?Z0ZjVlhCL2wyQzJ2blZycUUwNnZKei9OYW5aRmZ4T0FVNDhNeUl5N0dHb0cz?=
 =?utf-8?B?cVRZeW9oMFVPbXNhc3FKRW9MbEorMVhiUlAxZkNLbkRCcjZVbEwydUJWVEsr?=
 =?utf-8?B?Nmh6cEhBbmp2a3creGkxV01ISWRtaUVIWDlvaXFXZXlzdnpJaUZKSEhTQmFS?=
 =?utf-8?B?TVRQS25NQyswM0NIZXJ0c2hIMUk5Nk5hdVdwTDZJRFNCYzNMTVphWG1uSWI2?=
 =?utf-8?B?eTFHRHV2WGJXWU5MYU1CRkw5VUp6RHZaTEExK3hrMTdYM29GZGc1dUdYU0Rr?=
 =?utf-8?B?MGdHT0piOE82NmlCbU1hbU5paTArTjBWV0FBb0VONVM0bE9XaXB4N0hGei8r?=
 =?utf-8?B?ZDhhbkZCYy8zVnhaNW13SUtQZDZadXN5VUwrcm1XSTRnQkU2c2ZtaGI1N3VT?=
 =?utf-8?Q?cg0Evj7usJRTAelQc8W1/Axv4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905df47b-13ec-4e96-c9f4-08dab8f19c4a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 14:35:07.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0Yq6oIqGhnMHbblfflsS5V4l+JTSCfkg2BmuHa5zxghoDzFiXFoUXFpy4mz20e+xZGsIpCKbsZs03999uFWcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 17:46, Dionna Glaze wrote:
> The PSP can return a "firmware error" code of -1 in circumstances where
> the PSP is not actually called. To make this protocol unambiguous, we
> add a constant naming the return value.
> 
> From: Peter Gonda <pgonda@google.com>
> Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Andy Lutomirsky <luto@kernel.org>
> 
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Just one minor comment below, otherwise...

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/crypto/ccp/sev-dev.c | 2 +-
>   include/uapi/linux/psp-sev.h | 7 +++++++
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 06fc7156c04f..97eb3544ab36 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -444,7 +444,7 @@ static int __sev_platform_init_locked(int *error)
>   {
>   	struct psp_device *psp = psp_master;
>   	struct sev_device *sev;
> -	int rc = 0, psp_ret = -1;
> +	int rc = 0, psp_ret = SEV_RET_NO_FW_CALL;
>   	int (*init_function)(int *error);
>   
>   	if (!psp || !psp->sev_data)
> diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
> index 91b4c63d5cbf..fb61e083d42e 100644
> --- a/include/uapi/linux/psp-sev.h
> +++ b/include/uapi/linux/psp-sev.h
> @@ -36,6 +36,13 @@ enum {
>    * SEV Firmware status code
>    */
>   typedef enum {
> +	/*
> +	 * This error code is not in the SEV spec but is added to convey that
> +	 * there was an error that prevented the SEV Firmware from being called.
> +	 * This is (u32)-1 since the firmware error code part of EXIT_INFO_2 is
> +	 * the lower 32 bits.

These codes are used for /dev/sev access on the HV side, too, where 
EXIT_INFO_2 doesn't exist. I would change this to something like:

This is (u32)-1 since the firwmare error code is represented as a 32-bit 
integer.

Thanks,
Tom

> +	 */
> +	SEV_RET_NO_FW_CALL = 0xffffffff,
>   	SEV_RET_SUCCESS = 0,
>   	SEV_RET_INVALID_PLATFORM_STATE,
>   	SEV_RET_INVALID_GUEST_STATE,
