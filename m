Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1856A9543
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCCKbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCCKb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:31:27 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F285C139;
        Fri,  3 Mar 2023 02:31:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6WAFlZc/EEfUnsLRULf7S2wmIRKRyj4PIcxYw95Q7dnh8DPfDEaZuQMiQ3+AjM6DbcE3ClFRcd2lMOYh8urQyk66abMgzIk8Zo08JXeqCcmn6l1/8SUmdTiRGf9Gh+u49+j6tr5rf56KttVClfhp3z4lxHtoTfjtQYvz2HCKsgMuu3RQXET70gdrmFEmaVwBBKCU9oPOgXBzuxz+3CvHg97D1YLYmjby0WNTgf9j954pJyKji683DeehQXWKXbL2CTeK1/bItNczOumQqg/WiZlIMuEr983AUwBSH26wHPof9tkH7b04ow0FbMjoHz7iNaar15sN2e7vJc+U17qmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8X1RElYeYyz9Y4jswdli2BXbaEmLj4Z5Nlo4EDYd3o=;
 b=dEy3bzUzMuOUg6a8UFWU3AWyh48haE9TSb44M9k8MNtLw8TVAWhGqcGMMmVmEZfzvimnYQz2v5xI+AMBEvzMSvpYocQECG+GhDGOCKU51dILoP3hk59qgbPDNdmvlnFVoogQh0r++M889aT8lSuYzWrkjstARj/CCtphcHTfbp5NLWdk1cQFOYTLd/yeiBVwaAHJDZ+vQ1lWoMDOaMpujfneaKKtpx/X/uelrzYM+aalbyOR1/Zk6riYXEmwlRBLwHP2lNs6/QXNBNn6hp1PuDVHAJznDj/qWtWu1cuWK7VAnW6/IHhAxb0MrRGMnxsnYE95QN8SyDyzGX5vLcIZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8X1RElYeYyz9Y4jswdli2BXbaEmLj4Z5Nlo4EDYd3o=;
 b=2CnJwGKlr5wI/7zQHDC3forNFKQBuCFQRsPvMvN2OnLe3V/A0vTtdgorFoDxpQM0yOShDqiknByXPiH0k/SSjWl2TSXepqaV4NObuGDr6HRDNGFRwi6uwoYi8oNi8onzayctwAlyD9aa89S5QaY5Y9zIdgV/gGllaMUIaj9Pq38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Fri, 3 Mar
 2023 10:31:24 +0000
Received: from CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::e72f:6e68:bf24:6696]) by CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::e72f:6e68:bf24:6696%9]) with mapi id 15.20.6156.021; Fri, 3 Mar 2023
 10:31:24 +0000
Message-ID: <d7840a0c-b4d0-77e9-be85-d93bef6f32c8@amd.com>
Date:   Fri, 3 Mar 2023 16:01:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/9] crypto: ccp: Drop TEE support for IRQ handler
To:     Mario Limonciello <mario.limonciello@amd.com>,
        =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>, Thomas.Lendacky@amd.com,
        herbert@gondor.apana.org.au, John Allen <john.allen@amd.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230302194235.1724-1-mario.limonciello@amd.com>
 <20230302194235.1724-2-mario.limonciello@amd.com>
Content-Language: en-US
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
In-Reply-To: <20230302194235.1724-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::6) To CH0PR12MB5346.namprd12.prod.outlook.com
 (2603:10b6:610:d5::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6cfa49-52c8-441d-4f3e-08db1bd26f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrt50LiYXoh/BkQzZgQ1r2v04lb4FUjpbC7rLyQsa0T9T2btYm/vmUVDo4Oi/GJ6f6rG/ULszIt+omnWsoe8LmRgZq/YRg53W63WSlFCXduBloNu7Pj08x7e1MfCRviVnnvTA66QHeMhBswCIZgg1NFxPIyh8lYcL4eo6xsR2GaNR0yMGX9hu8IWvtPW6eoeXjAXLKgZylIiKC0yWYMbinXfLXfjAvWkmXUI+h+T4B1nE+2XpiR3JmBtSlnSw2oeCpF3zgIovbPCuKhqf0RGJ8sAo2NwBXQZOYdNi/D0e1snSYF4dBb2uaUeSsP4hyMClqqEy2xagsEUShsbWZPhCGR2HzHA2RHtLMRHJrvB5wNYGCYWY2U9O+4s4ZFouBpjXI/YWtDnNjMxHsHZ2vVfiPw+K92Q6VcL2GSADEFfbKMKpsFrxeHqE7iBiv19tWvrqFalorGrDXo4I/uyPefV1Z3SQbb0lS0aT2G6NtVpr3ajdRGf1Lbgh/DJ/Ybemi9K9p+oeJv1rCFfj+c5RXU21omzs2bnML6XF0ggwJzHG096CZOXFBwX0stUI0OjtzzYliK0GBPyN3vK/89CAUzCUhQgvriMHo6YVT+uOwJvYyhg60GH2r4ia0e1qcyNCuXiWiBMK24ckPc/AN2uUhJtkM55jdlXjtXkYW7NxQi1IJSGdGkGcl39ZFrc+8gkDhVosqDyStoru9xaV+hJYEplR/RjlYzeHpMGxPuR5N8HDns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199018)(31686004)(66946007)(83380400001)(6666004)(36756003)(53546011)(38100700002)(478600001)(8936002)(5660300002)(86362001)(31696002)(2616005)(6486002)(6512007)(6506007)(186003)(66476007)(8676002)(66556008)(2906002)(41300700001)(26005)(4326008)(316002)(110136005)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVh3UkVlVVRBa29NOTVoaTFJQngwOTZKRnh6TzZFd1dLd1pBb1VvZUtoNnhR?=
 =?utf-8?B?VDA2S2xCUHJvaWQwOVpRMU1GbUN2M1diaUhRV01sREFTL0JCUnJJOGpMSVZW?=
 =?utf-8?B?MWNlSjRROFlFZ0sraTJJSGNEd2JWNjZ3dkVYSDRpSzFFa0ZqVDNIbkhZWUhM?=
 =?utf-8?B?UHhYYlBXbVRNTGpOaVlZS3Z5clVJekZHUTQvM0J4RVRvL0M1WTdoK2ZQai93?=
 =?utf-8?B?bDVPamNNRWJlYjlHd1ZzK1VzWFZ0MzVIVzF2dXlCVWVBUEp0M0pKU1hYZWtu?=
 =?utf-8?B?b0tDd2xlNWVucUxDbWlIMElnM2xneDZyby9hVDY3a0crUkNHNXVGMUhoZXRy?=
 =?utf-8?B?c0J6UHlUYXNHckI5cGRMTXpLd083Y2V1blVSeWlQbEpENVlDaWVITDBRU09v?=
 =?utf-8?B?TEJ6Z3JSMDIwT0crK3VGb0hjb1dRTmh6dFUyU1lUU3E3czZkVWFvMWxjb0o3?=
 =?utf-8?B?dVpkOUVOWWJXeGJLZUU5VXd0TUlaOWlCelhPNnM1WGdhbWd1RzlaN3dSTlha?=
 =?utf-8?B?b3lwMTVUQmpVdVlDeDJyc1VWVDRJQVNERDNndjZXQmIvQW1sOW9wZjM5UnpJ?=
 =?utf-8?B?Um8wMTNVOTZRMm9NT3VkVnlGT3NOVDB2dFJ4b2NqN1JpZXdZeHdsdTMxNkhU?=
 =?utf-8?B?dlBxMEJOZGRBM0F3R3ArZ0lxS3UyNFU2UjNXWVpDUUh2bnlCbEFySlNRdkUy?=
 =?utf-8?B?bytWb1NaWGlpRE0yK0hCWHdaTkJPRGk4T0ZQZktFMlh2TitlYUtjK1NnRTZn?=
 =?utf-8?B?Y3d4Q0piSFpJMHBMUU9xMUpMSmhMR1N3VWpXR0h0MFl5eC84dzlqazZOMzFP?=
 =?utf-8?B?TU0za1dBWFhxU1hmY2lsdE1kbkJCK3JSN3psekJaT25QSEY2QjRKK3FhMitB?=
 =?utf-8?B?cFg1azNkK29wSmJFajB6bVl6NVM1TGFPc0Q3eFlFTXN4K3liUnY3YUZpbnlF?=
 =?utf-8?B?d2hxT2hKOFF6UU9DWk5vU2JqaUc1WGxnOFV6WmtmMFMvWUY0anpYdXBuRDNS?=
 =?utf-8?B?bmdCSVZjUXdCaktvenUxUXRoOWtSRE9EcHAycndoMkgxOFZXc3l3TEZVM1Bx?=
 =?utf-8?B?Tld4L0FKcCsrS2phd0hzazdjS2ZTdnJRdllKZFMwSHdLeHJVQU1vRFVWNDVY?=
 =?utf-8?B?eU5SOUVOd0FsZXJINkk2M0diTGp5N2RwZFhCeU9DRkpzZ1J6UFQ5V0VZVXk0?=
 =?utf-8?B?UGdnTEUxK3NRVUF4T2tYNndRbU1BbHRnZGRnWTh2RXZtNlZSTkdsS1pCNFBL?=
 =?utf-8?B?SUJWaEFpcHAxdTZHalFvTWk4ODA4NWZuSUhMd2s3RnhLc1FYeStCVTlsNkFU?=
 =?utf-8?B?TkJKYVRWVC9YL2ZqQUxVamt5OTBjV1dPcVpPcDIyVFJDbm15UERNV2JOb2pP?=
 =?utf-8?B?K0xHVEg2L1VSOVFjNHpMUUllVExxL3pBTmVER3o3UkgyMlhFYkJ0MmttL2tF?=
 =?utf-8?B?blRFdHMrbXJIQXBmUmtnMktMOEpwdGVEM1p1UVRtNlFUQXlFMWs3NXdHWVJq?=
 =?utf-8?B?YWtFWFNvWmFRY25ZQjdVdEdPd2gvVXArQ1YrcExhcEhwblhaRVFpakhOekRu?=
 =?utf-8?B?MWY1aEJ5N2wwdENOYVM4azVMUXFBdUcyOW1FYjFrY29VUWZMblA5Z2JTbDNK?=
 =?utf-8?B?UGFjK1BoNHlDY1phZFJ5WXBYUzVhRmhjbUgzYUROaEExcloxeC92cFlBQzF3?=
 =?utf-8?B?SWZPcEpMODQ3Y0NVRG4zOVFMWjhPNGJlL0pONnNVQjF0bHlxeTdlZU1ZVzVU?=
 =?utf-8?B?bjZiYkhhRGY3NUdLMjNuQ1RZWWtBaGkrOWpQTENqbHVvT002SEVnL2dUZDRP?=
 =?utf-8?B?cW9iT2R3RU9NYWxNSUdUaXpIRzNOcVQxWS9RUEpZZWJLSStpTDAvM3l1ZTVY?=
 =?utf-8?B?V1hrc3BQUFBoN0ozbksrRUtGejNwY3pjdkFsSlE0UHVMa2dBWEJNbFc5VXVQ?=
 =?utf-8?B?YXlxTnljWmk2eHFLU1FOcUlkYzZxdkZURUpRS1RqNFRXbjlDYzRsUVhEa0lh?=
 =?utf-8?B?UjFqZVpCYTFyaGc0VmtENHQ4SUV3K2FpdG80UFJ4bGpsai92dlN5WW5sRmFi?=
 =?utf-8?B?YUNucjNpZ3I5UWlieitwNUgzRi9Eb2pYMS8xWUVRTGtZMDF0RTg5UkNKRWs1?=
 =?utf-8?Q?KJEgnnOZ0GSWeAePX5Gsi2NkV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6cfa49-52c8-441d-4f3e-08db1bd26f75
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 10:31:23.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8A7XfezL3Z67IkdFW5bfXWF2OUMmM2Y2gYdIjQNziTT739sNh5apwT4E/MCpnpbIswowv6EdluH1tNQWS1dJvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/2023 1:12 AM, Mario Limonciello wrote:
> The only PSP mailbox that currently supports interrupt on completion
> is the SEV mailbox.  Drop the dead code for the TEE subdriver to
> potentially call it.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Looks good.

Acked-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

Thanks,
Rijo

> ---
>  drivers/crypto/ccp/psp-dev.c | 15 ---------------
>  drivers/crypto/ccp/psp-dev.h |  7 -------
>  2 files changed, 22 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
> index c9c741ac8442..cd8d1974726a 100644
> --- a/drivers/crypto/ccp/psp-dev.c
> +++ b/drivers/crypto/ccp/psp-dev.c
> @@ -46,9 +46,6 @@ static irqreturn_t psp_irq_handler(int irq, void *data)
>  	if (status) {
>  		if (psp->sev_irq_handler)
>  			psp->sev_irq_handler(irq, psp->sev_irq_data, status);
> -
> -		if (psp->tee_irq_handler)
> -			psp->tee_irq_handler(irq, psp->tee_irq_data, status);
>  	}
>  
>  	/* Clear the interrupt status by writing the same value we read. */
> @@ -219,18 +216,6 @@ void psp_clear_sev_irq_handler(struct psp_device *psp)
>  	psp_set_sev_irq_handler(psp, NULL, NULL);
>  }
>  
> -void psp_set_tee_irq_handler(struct psp_device *psp, psp_irq_handler_t handler,
> -			     void *data)
> -{
> -	psp->tee_irq_data = data;
> -	psp->tee_irq_handler = handler;
> -}
> -
> -void psp_clear_tee_irq_handler(struct psp_device *psp)
> -{
> -	psp_set_tee_irq_handler(psp, NULL, NULL);
> -}
> -
>  struct psp_device *psp_get_master_device(void)
>  {
>  	struct sp_device *sp = sp_get_psp_master_device();
> diff --git a/drivers/crypto/ccp/psp-dev.h b/drivers/crypto/ccp/psp-dev.h
> index d528eb04c3ef..06e1f317216d 100644
> --- a/drivers/crypto/ccp/psp-dev.h
> +++ b/drivers/crypto/ccp/psp-dev.h
> @@ -40,9 +40,6 @@ struct psp_device {
>  	psp_irq_handler_t sev_irq_handler;
>  	void *sev_irq_data;
>  
> -	psp_irq_handler_t tee_irq_handler;
> -	void *tee_irq_data;
> -
>  	void *sev_data;
>  	void *tee_data;
>  
> @@ -53,10 +50,6 @@ void psp_set_sev_irq_handler(struct psp_device *psp, psp_irq_handler_t handler,
>  			     void *data);
>  void psp_clear_sev_irq_handler(struct psp_device *psp);
>  
> -void psp_set_tee_irq_handler(struct psp_device *psp, psp_irq_handler_t handler,
> -			     void *data);
> -void psp_clear_tee_irq_handler(struct psp_device *psp);
> -
>  struct psp_device *psp_get_master_device(void);
>  
>  #define PSP_CAPABILITY_SEV			BIT(0)
