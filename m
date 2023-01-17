Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F5B66E73D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjAQTrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjAQTpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:45:32 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3D358985;
        Tue, 17 Jan 2023 10:45:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfzYy3QfX4wfRm3KrBDABAYMmK7quVBTn007eHuaY3Twd79gkqHV6duTfpeL+FNqF3zuQv4iZ0HYZgBsa8jfNaHKqI5sypmCERDECX+jLGEKpAj2btZx2UTrXRWb2FxP+IEyXIwgtlVnWhiM4Pdfv/gx+pnU+IYrb/0u99N2IZbl40kvq/barSI6IfRrDb3yw1TksnMgTlb38HJd+n7/TtUcpT2VxZS53oxeZOtZbpotvOgDN3Kao+qi1LlRyyzTa08gu5MDw/hBUBZ0BkmraOIh4cUcQz4zXzDYYDNVMiCZpQFvEhw8l6hI7k7bPxzxyUZVpCtKzs+sFHkiSUDvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJGSZ/cYdPCbkd8m4SPazuhz32zpZSDAxjmPcJMkgNw=;
 b=JV5l4YMs/xrdOL5+N8DsFEL80b8s2bBfIHeY2lqC8rKk9+izHGs8IR95oaGC6/SDoneBttmjLKzgGXTKYq9ia4olr972TxGBz0FRWa3EKWQT4IIH0N5GhW7WfXEgEP38Z+oUFlUyQPhSRDtAzu8LchpMxNdWLOYYckg2VzNle+2NOCeNWlM2q0+fRUMuyDYV+PkW3heMWTxp0ctIVpuW8yzqSwAs0KcEIkwfcBit2ztADkOWgfLoTD6Nem72FpDSdaaHNjp3JrXu5ipc2Z3jBqvosJP7hxQ+ssA+UVOFf8oarq+yWPuL7ePdBQevxorU1oaXIdILjMJTBeL1zXqmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJGSZ/cYdPCbkd8m4SPazuhz32zpZSDAxjmPcJMkgNw=;
 b=y3jdnUcVlQwHZL3Y6p7FCA8q+jRfZDnDBukzj5ncRB/JNJa8VKQgKmMHSu7P2fNg2vQtUP/ErKRvdhBj9YUn0aTzMEmLamsma+aBjuSh+duj+KSGh7cNE5IHvcZ1O7o+wwdfbURd1wZUI3jV+m+81FB5pRjYn59CDxtOFUw2yHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 18:45:00 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%3]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 18:45:00 +0000
Message-ID: <0a51100b-f10c-04ac-bce4-1a943ffa39d3@amd.com>
Date:   Tue, 17 Jan 2023 12:44:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] crypto: ccp: initialize 'error' variable to zero
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, brijesh.singh@amd.com,
        john.allen@amd.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20230110170848.3022682-1-trix@redhat.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230110170848.3022682-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:610:20::40) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff05bba-1d7c-46d8-2a37-08daf8baf014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8s9ag3hiUa930qvA6nfFl9dj7bECtWZJuzii7yw4boFVLZtjIsaUdx79EBKtgBIyzffGCEdQ3BpW43hKe7m6ihidPaCvAi6pvy84tumziIj3BI6fm2SHWOj8IGQmGtiRcktpIVrJStMUVvq2bHwA0lIQqr77i+EmOAmUj043GqgcQ2IZ0TBPDGzA4v83Pn+5rRZIq1IDCoLTcz3DhnLLQFFdU8KHki5CTLHBF8Xjaea/i5vmxBOm1XQ32GuSgZD6VGmq/IJDulcLjT8q2Lkr2AfbhKlQ8QTAFJ8cMyCiayIBInnIVzC+UdU5v8+Piq9FIT/bGm6OzvfthUr9zBKqK+HSbDUcnrX+16k6ZhUfIE24390JJaMoVXThDk7MecNlQdvg/2P1dNdT51sAneO6eatAOQ72ZRPUtgXCuN30pkI5Q/09JFENqr5MWJr9B5Tr3QQkMQuNzact7/dc9b0M8w4vTxW3Z+8DKYnX64lZnZA+conpPPMe8d5+tpL1TTYNELCv93Ozj4ZaJ5H5ixCAJJzgCxULRYDmOxNP0m+x5Gv+ZNurp68wbrRtSt4WvkRdcQ5ES9dRSWopbYWAX4L6oyvlfofUrL6VfZSYu7Kr/OgelSwgjaCU8uXhkexCN7gBcSJzwLxXs+yMGt1eAE7r2oUFOOhCI3/6jnzsa/ChypsHVCMwk/c/5i+4sUwwCnE7rwh9qICphpmMyxcj1vA2ztTh4/rTeZDD1jxI128GLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(31686004)(36756003)(38100700002)(86362001)(8936002)(66556008)(66476007)(31696002)(66946007)(5660300002)(4326008)(2906002)(8676002)(83380400001)(6486002)(316002)(478600001)(41300700001)(2616005)(53546011)(26005)(6506007)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVl3YXZCS0xsdmpDdjVzZ3ZRSnovdWx6dXY4TnlJbzZ5WTNSRUNNbHppTDJP?=
 =?utf-8?B?K3lSNHZmYmR1NmZTanR4MVA3djBDZHJlKzdzbHpSUVBvWTFQYkNuKy9UM3Fm?=
 =?utf-8?B?emhNYklVUkljQUZ2eDBjdTB6TWdSRDhpd0hHeFg2N0tVS2p6OUNTRUszbFVI?=
 =?utf-8?B?dklELy9UK3EyRW5OaStzeVp3SUkxQVJKcWVrYWZaelhCRk9obVhEMkNlSklN?=
 =?utf-8?B?cUtPN2VXclMySTMwTUNCMVZycFNLVVVQYjZMbUdvVXpZTXFWTmY4Njd5NjBa?=
 =?utf-8?B?N0NBUUlXdDh1SXI4RUlBbEpKcW9zVHUweTFSbVhKUGluV0FUVmM2Y0dzUHBz?=
 =?utf-8?B?bXdOKzJndy9ZWjQyN1hzZmxIamk4Q252azNwNmNTcFU5NXZZZnRxcFBIZThP?=
 =?utf-8?B?bXVDY2plNGVuL09mN0ZMN0Y0OHI2WG5uSEptSkJyZ2dXc1l3MFpaMU1IbzJI?=
 =?utf-8?B?UHU2UG51Z21iRzQ2RExQTFV1OHJKRVU5a3pRTFVwVWo5a2RBcVpMTnR3WDl0?=
 =?utf-8?B?dFkwU0FxUmZkTkhjQlJ6SHZlaG8yMDRiMG81czlJMm9WUmtRNzR0d0s0VXo3?=
 =?utf-8?B?Z2IxZTVKUnc2LzlleVQ3TnpXZjRCWGczYlRnTHRzTkVHOWk3d2VFeDBPa2lB?=
 =?utf-8?B?MExJK3Q0akxMY1ZaYUZxQktuYkJKNHBRS0tLWW1xa0hRQ09McllxbVhScVVk?=
 =?utf-8?B?ZDE5bXZmMzhhbG1qWnQ1L3Vad1lDK3VzSVlJdXR0UWt1U3U0Nk9mTGppWFdo?=
 =?utf-8?B?SGRYYXE5dU9DcDhRVHBJNStlOVorOEFlQko2VVkxak1kNWthQkdQSk1XY1Bx?=
 =?utf-8?B?SDFFQS9YdGkzSXZCdXdxcHNuM0ZMczczM2tHSVBubk5QSFd2RDdVaHp2aERP?=
 =?utf-8?B?WGQ4dkk2dmcwY3VLZGx3QnBTRU0remZYRjNWbDVBS2ZzSE9WYndmQnA3Sjdy?=
 =?utf-8?B?UEVSL3JPZGl5bVZoMi9JV1YvNDM4M2N5dEZLRm8xVWcwR1dYZm1nT3oyOFpM?=
 =?utf-8?B?MlRRblpmMnNDMzFYOWw1by9EUW5QRWNua2JmY0tmdDRkRlg0andHQWdwN3hK?=
 =?utf-8?B?Zy9mZFp0N0hQZTZZRnd3OGlpdEM4TkVZdU9SN1BrYm1jMkJpMVQwWXlKazRr?=
 =?utf-8?B?L2Z1OVdqR01pZUV2QU01UkR4Y3FDRXM0L01McG5EQk9BRzBxcnRtb1Z2SHZz?=
 =?utf-8?B?WGlkbGkxYk5FVG1Md1FHWUUzSUZpdmVoU0QrVjVCa01LdjhWSkg0eTMxQ3RQ?=
 =?utf-8?B?UTdMZFRLYXVhU0g2L1ExaGlWenAwbFFCY2hKL2lvSzBkTnp0VC8yWEhNdHZM?=
 =?utf-8?B?WDlaOS9EK2VJQXJ4ZFhWS0NQUUpDcFd1T3p4QVBqSGJEQXNkUk11NmJlMGZo?=
 =?utf-8?B?MVN3YVNXWFJtbmxiV0lRU2c3bEZrUkc2WkVkRTNzNU02dzIrSU9BU09DK1F0?=
 =?utf-8?B?MnhKQVlHTlVzc1RlUGhzc1lXTUF1ZHoydVQrdDhERTZ0ZlFBcDM1d0NrV1ZN?=
 =?utf-8?B?bkowZ3VnWXI4NDdVVUMycXNaSTVxWVRjeWVuVnJGemhkbWtydUdsQUo0L2hx?=
 =?utf-8?B?VDFPQ3N1Y3lmSWVGYnUralFjZ1lBOEZNNklDZHhEOWZmZG9NN3VEUVVpODN4?=
 =?utf-8?B?cnlwcVRZYlBCU3FGcXFjMzB6RWRaUjRMR1BkOUt3alpVOERFSGV3bVlMUFd5?=
 =?utf-8?B?M3Z5ZjZrZndLdENHZG1FVEI1dzVBZ2V6dldBV3h0SFpFTzRpa0VyQ2srNjN1?=
 =?utf-8?B?UWRwMFByaFUvYzdBVGxNRkI4Uk9oUmJ5RlZDZDNRQjVIMzJRd0lIZVpiZWdX?=
 =?utf-8?B?UkZwZVB4RlhNaTdraFVHcHZDN0psV0kyUFIrRTFkVjFjaS93NTdYaWJQbjRs?=
 =?utf-8?B?M3NVdjhSV0cyZkE5d3QwOGcrZytLWk5NVjdjbUQxR3BMREhkY2RqOTljM3hE?=
 =?utf-8?B?N2FDYndOK3BKTDdMczkrM2I0NUVHeHdvT05uUEc0KzExcVZtNTZBZnhLYm5t?=
 =?utf-8?B?K3dFbjl0NWF3bHU0Y0h4NDBvYzEvR1lLUHZFM3d3bXlPYUpKRHB0ZEM1cTE2?=
 =?utf-8?B?UForQ3ZBR0Z3a3lLR1EzQ1FZclp3dzY5Rkp5b3lPeUo2YWo2Qnk0Ym9sYnph?=
 =?utf-8?Q?ewEU9nOkCO7Z7/WR6XzdDxSDT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff05bba-1d7c-46d8-2a37-08daf8baf014
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 18:45:00.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmiyxUc3rwY/WycX13LAtMZHAkGXWHhlnq5hieXA8RKZIoaYqppnIYi1huqO8zSvHt42IHY7d2xSm7tIiWSRnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 11:08, Tom Rix wrote:
> Clang static analysis reports this problem
> drivers/crypto/ccp/sev-dev.c:1347:3: warning: 3rd function call
>    argument is an uninitialized value [core.CallAndMessage]
>      dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> __sev_platform_init_locked() can return without setting the
> error parameter, causing the dev_err() to report a garbage
> value.
> 
> Fixes: 200664d5237f ("crypto: ccp: Add Secure Encrypted Virtualization (SEV) command support")
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> v2 cleanup commit log
> v3 cleanup commit log
> ---
>   drivers/crypto/ccp/sev-dev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 56998bc579d6..643cccc06a0b 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1307,7 +1307,7 @@ EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
>   void sev_pci_init(void)
>   {
>   	struct sev_device *sev = psp_master->sev_data;
> -	int error, rc;
> +	int error = 0, rc;
>   
>   	if (!sev)
>   		return;
