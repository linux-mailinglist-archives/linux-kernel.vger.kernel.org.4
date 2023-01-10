Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25522664375
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjAJOln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjAJOlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:41:39 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F6E1707C;
        Tue, 10 Jan 2023 06:41:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGAIy2vDRuurpUPFzW4VLyWTGDa9nTFWP2ME5qi9bIPpl+lM42wi+/stzb1IPwMPKPSPQGXBH45+txoMBRHJNXDXYvuGMr0cniU0gXeUEqhahm3CaWNnXhoBvoWdWmjtHovWxQlWKzPI4E/cZ2WDoUIYBHoZFEQR1zzphCBKV9bd9E1sokrCig974MFwT84M5eRC+HyCj4AG4auIHNgJPOCaEjz3iWbohofRVtYe/GugrHHO47PsMKhNtF1Ld/8Y0Df5ZuLeRfyyQXOMQuP4OeL3DWMN6R6wOmd2dT00FzdamPMDFh3NIk1AHCCU3aPD+Kq92gcAFp+rKimVJ20+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MW6c0GsmPr08iSaowkmoUyOmDPg2SL9J5gf7fOV+7AY=;
 b=n2EzCHy8RBlk+fVYVnELsjYUKPaoKsrqajKpxF7UQwtHIeT/ovXexxrxLO/EP7KkDiU3cuEltKPacZOu93rGhrahtj/kXjEF0JzmxI7xnJJRPSCJmKSn5rcsYPhNgvId/xKQIwilsqB6yDQWZYYxRH7g2GcoJq2u694c8EpFwuuMig6I8M5LcTv+OYZBObOieI5x92JyVMczW2tjaTSMRFa1VBvdQQjgW7+MoIpswyLjxf06r4Y+cywFXGBC6MnoSe6XKhcR/w0y+LREWQt78USCYXwOlSBgYqwapcRmwfaqTbULrSEbA1Fv8II6P6P3jNGBr5RAPXbbjy/XgWKnlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MW6c0GsmPr08iSaowkmoUyOmDPg2SL9J5gf7fOV+7AY=;
 b=aIQBxrjcw2GnV0lA0+E4+yxLpHPLdkIKxKrY1GXcXpJ60FvSjgVfCeJOOZzLr8z1sbm6Qhp2lzV47EnDCyBvzQDUkhK/XR9kz/7XPWLUwH6+/bpbgb5ezp3X0nh8WuSiNT0iwDQyLd2tdblaGTFDYEJ9ch0Sf8WCXVcGaBXdoso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 14:41:36 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 14:41:36 +0000
Message-ID: <ddbb4b2f-3eb8-64da-bce9-3cfd66d7729a@amd.com>
Date:   Tue, 10 Jan 2023 08:41:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4] crypto: ccp: Sanitize sev_platform_init() error
 messages
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@profian.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SE..." 
        <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230110033520.66560-1-jarkko@profian.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230110033520.66560-1-jarkko@profian.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:610:b3::32) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c57380-7141-424c-aba9-08daf318c691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smu1aN5YelgVe+24Et5PyWUffVgqNZwm0BCqkiEE/eH5193uaxXnS/EoBxJFay9R6cFzlceJ6/3NafQi/vGCQqDf8TGOGxCsvPuYWLQe5qs9pvqVQwmQOreS2rGHv/SIWj1b7J5o7XB0IBklzgL1kuwhj9QP00yi4sGaocoHgLRiwHxuus/ogzsMpK+NmM98lvxtiNT5GxssautQGy2Yz7EnRkgKEJiDFFi75PGBYzlG4pF7yuCL9eNqzLqPbEp+Gc6kL8i7xfloHuTZsLstZQSWvu9jLbprB5NhvGGwZ/cl8Ak559QVAipQV7qTvGWUiXfkV4aiLtavFrlxvFmFJAV1GcGbkdRvDoNcINhQ78tvH2hMS412aBOLgh4ZHgrTvW81TCp6QaRYuqMovFhXWWrptTxtPp6fe28yq8uSp+i8IMw4XiDxZ1/q5oD0eNFNl4vdEJkmSW4L+6kDgjkSMHsmwMXXD53PbNnmLQhRSk7OSZ3D0KYWXXE4YcBzXH06kPjQzbsP0CaPIjGHNki8DcTUOPJKD2ppihPRn6q/r1BntwkbL24Ii4k1i3irFqj9ncldp7sV18f7qtanSFWGTF1FpbohR5ylLdVSpRge0K0j9WF/yJbJQpYnPbDsh+SFstts+mjIdl7pUJurBPGjDXFFU4MSOL0GhdabqZVd3b+sEtg+AGDF5UQyknHr+TqyxcCufvWTbACoyyBLK71GzijAyGxN953qoF0jZQjARj84dL4uhYn/r9m6/e3Lcal6yoLo2mpUDMESmxk0rDYkH+QVGb93HPFLcuRkraO/V5iZuzIVQGfLkbBVwqmBTACT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199015)(36756003)(186003)(26005)(6666004)(53546011)(8936002)(31686004)(6512007)(6506007)(2616005)(66946007)(5660300002)(66476007)(66556008)(316002)(4326008)(966005)(86362001)(31696002)(38100700002)(478600001)(6486002)(54906003)(41300700001)(8676002)(110136005)(15650500001)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWw5eVlMSUFMU1RBai9vSHVYNU5UeUhhdS8yN3BOTitPaXhUSlpydVpEcTdZ?=
 =?utf-8?B?UzVGTm1FSmNtYUhZditoSk5PZ2JuTDVxMlNXcVFtWXlFK1hqZkNxRmpoMjVG?=
 =?utf-8?B?ZWRFNTVHUjdpeldpL1NpZVRHNW82ZndvWHo2S0d0SklENk5OVGg1K0lrL2pn?=
 =?utf-8?B?Z0ZRYkg0OFJKbzdsKzRkc1ZEbjFTVUowYVFwSHNZeC96TEp4enRSaVVLZWJu?=
 =?utf-8?B?Ulpoa2xHYjFXWTZTak45bHd2M1JJUTM1RG9CNldFWGFKdlVWWWtxT1FhbG01?=
 =?utf-8?B?R09sWlBGZy82NVRUQ1VPMjBuMkdRVFBpT1FwQTJwcmdoU2Ywci9rbDN4cnh0?=
 =?utf-8?B?Z1VhR1NGL0djSitVL2J5VjArMy80alRRMVBXeDNCUDJxb0VnMjcxc015Uno4?=
 =?utf-8?B?a0ZwWnJaYkNWUnk3b1NWdWVvcFdCay9hOEUyeDJXd0RNVTFBRVlqc1Q2aVRP?=
 =?utf-8?B?dE9sUGV6VjR2REYwMEs5RlZMZjU2VVBtTERscDgzb0dRUXVLMGpBN2dZMTNB?=
 =?utf-8?B?TjNlbmpwMnp0Si91a1VTYmU5WUdaRlFOL0g1Z3ZqL0hXU284L0ppNGZsK1BP?=
 =?utf-8?B?MjM4akdGR3lUWlN3R2ZXVHZFOTRNaVBZcGlVNTFweGdEaDBjNit0cExkR1JU?=
 =?utf-8?B?dS8wRWtZMnpEUTRiWjFvZHQyOHBOOTloTUlSSGVqU1dycFZhWkZOZGFCNTIw?=
 =?utf-8?B?MnRnelRLNUFJVkJHMlNpc2hiYzU1MFYzYS9neDlZVHZQQngwYi9FYTduU0xM?=
 =?utf-8?B?Y3FoNkRqZnFBcHFMRUNGNjJtZkpMUFdYeWYwUVBPMTZYVStTTE5EV3pVTXQw?=
 =?utf-8?B?ZGNMZ0hUZkNNZmxWZVpmeU1JTUNqM0liRjRLQ0J3amZLdkduOVROdE5Hd3c2?=
 =?utf-8?B?NERDT0JYcm8vOW5GQmhFeFIxdm00eXAvWXNIK2dRM2pOOUhvTWg2TThPbHgy?=
 =?utf-8?B?b2Eyc0U2Y3prTjREdjZCSjhGSFVEMmJrQkp0YTMxRnhDdERUdkUxdWI3SmhB?=
 =?utf-8?B?bDhZK0dXWm4vU0tFeWRraWtnNlZqQlE0L3pCUHA4RFhyMkdrdGJkMWp4c3k0?=
 =?utf-8?B?RnFhd0VHTW5pcHN1WlB2YlRVR05GQTMxZy9MSjNkemIwbTBJTlFySkx0ZTJB?=
 =?utf-8?B?QkRPVjZ0WC9RRE9CUC9uSVdobUsyeHl5eHIyZWFkT2lBNUhyM2tZczY3SnB4?=
 =?utf-8?B?YXR4ZFZDQmN4ZkhmQ3lZWFJZR2Q3RXVzTlJtRFdDZ1ViU2d5dlF6ZTVIbW1S?=
 =?utf-8?B?YkxjQndUWVJDdmJSbXY2cDBzamo5UEdsQi93S0k4ZEYySkR0S2Y3RUpkM2g5?=
 =?utf-8?B?ME1nZEdjTmZBL1EwUEFQdGRJT2NRdndqdHVoU0RzY1BDejJSUU1PZjRkT1Q0?=
 =?utf-8?B?ZXZJY1hrQXNNYitjd3paTG9EM1dBWXBCRU1nb0ZkTEFLN3VZMXd1R3pZMEZ1?=
 =?utf-8?B?TVV0d1MraTloV1RnWjhHREZTNlBqYVZNMFJTZEhlY0prcnJHVllQcUkxOXAx?=
 =?utf-8?B?Y1pKWFNnd0kybGNsSnUvb09OSjl3S01halc0UmxNT25qM05pOVh3ODQzc1Vy?=
 =?utf-8?B?enlTNFh1a2VYTTNiTXIzR0U0MmlXUmI3ZmtnaVRzeXhwcm12eHNVaEsvVXg4?=
 =?utf-8?B?aEgyR0hSYVNCdCtrVVY4VE9zME1mekZEREZwNTI4cm00a2FJSHlVakYyYVRu?=
 =?utf-8?B?N25MKzBWQ1JMOS9kaFVvN2RHSll1VUVDRUkzS1BkUTRKb2JKRVNORkJYRFJw?=
 =?utf-8?B?bS9ndXNuR1ltaWhtTnppcndBaGx5Kys1Q291QU03MlYzSHVoVnljZXdRT0hv?=
 =?utf-8?B?dnNqTnlHQjV2MWEzSUd5L0pUZmdTdGFMVWhZZFZsWStjNjRGUmpYNkZSZkh2?=
 =?utf-8?B?ck9scmZvNTBJY3VHL0xDTWF4Wi83TzQ0bkFNNHBuMHFDNERUeDVXY3pBSGhI?=
 =?utf-8?B?eHVCeDU5eUVFek9LeDZrWXVlUFZ1K2Q3SE9IRCtiUFBiWEl5WnRuMWtveFZw?=
 =?utf-8?B?cnhpV0diK3YxR1p6Ykg4N08rSzAzVCszc0ovdTQrTjZNUDFCMk5vZU85eHh3?=
 =?utf-8?B?OS9ROE1MTmhYQkgzc0Q5bk9kMXJxM1hSYk9pYzB2ZkVtcVE2dmNRamRuZW5U?=
 =?utf-8?Q?Uw7Xs5pjVs1uDD+27JZT/dWB9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c57380-7141-424c-aba9-08daf318c691
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 14:41:36.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYRP7WrMdQn5amppypOeqOhph64wIJCOg8gT+sR0W2rJCa26XWw4GXWckOR+YMLqs5nBYXgZHH2jl94rhoxCXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 21:35, Jarkko Sakkinen wrote:
> The following functions end up calling sev_platform_init() or
> __sev_platform_init_locked():
> 
> * sev_guest_init()
> * sev_ioctl_do_pek_csr
> * sev_ioctl_do_pdh_export()
> * sev_ioctl_do_pek_import()
> * sev_ioctl_do_pek_pdh_gen()
> * sev_pci_init()
> 
> However, only sev_pci_init() prints out the failed command error code, and
> even there, the error message does not specify which SEV command failed.
> 
> Address this by printing out the SEV command errors inside
> __sev_platform_init_locked(), and differentiate between DF_FLUSH, INIT and
> INIT_EX commands.  As a side-effect, @error can be removed from the
> parameter list.
> 
> This extra information is particularly useful if firmware loading and/or
> initialization is going to be made more robust, e.g. by allowing firmware
> loading to be postponed.
> ---
> v4:
> * Sorry, v3 was malformed. Here's a proper patch.
> 
> v3:
> * Address Tom Lendacky's feedback:
>    https://lore.kernel.org/kvm/8bf6f179-eee7-fd86-7892-cdcd76e0762a@amd.com/
> 
> v2:
> * Address David Rientjes's feedback:
>    https://lore.kernel.org/all/6a16bbe4-4281-fb28-78c4-4ec44c8aa679@google.com/
> * Remove @error.
> * Remove "SEV_" prefix: it is obvious from context so no need to make klog
>    line longer.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
> ---
>   drivers/crypto/ccp/sev-dev.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 06fc7156c04f..bdc43e75c78b 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -476,19 +476,23 @@ static int __sev_platform_init_locked(int *error)
>   		dev_err(sev->dev, "SEV: retrying INIT command because of SECURE_DATA_INVALID error. Retrying once to reset PSP SEV state.");
>   		rc = init_function(&psp_ret);
>   	}
> -	if (error)
> +	if (rc) {
> +		dev_err(sev->dev, "SEV: %s failed error %#x",
> +			sev_init_ex_buffer ? "CMD_INIT_EX" : "CMD_INIT", psp_ret);
>   		*error = psp_ret;

If I'm not mistaken, error can be NULL, that's why the "if (error)" was 
present. So that should be kept and even filled in on success. So please 
leave it the way it was and just add the message to the "if (rc)" section.

> -
> -	if (rc)
>   		return rc;
> +	}
>   
>   	sev->state = SEV_STATE_INIT;
>   
>   	/* Prepare for first SEV guest launch after INIT */
>   	wbinvd_on_all_cpus();
> -	rc = __sev_do_cmd_locked(SEV_CMD_DF_FLUSH, NULL, error);
> -	if (rc)
> +	rc = __sev_do_cmd_locked(SEV_CMD_DF_FLUSH, NULL, &psp_ret);

Same here, add:

	if (error)
		*error = psp_ret;

Thanks,
Tom

> +	if (rc) {
> +		dev_err(sev->dev, "SEV: CMD_DF_FLUSH failed error %#x", psp_ret);
> +		*error = psp_ret;
>   		return rc;
> +	}
>   
>   	dev_dbg(sev->dev, "SEV firmware initialized\n");
>   
> @@ -1337,8 +1341,7 @@ void sev_pci_init(void)
>   	/* Initialize the platform */
>   	rc = sev_platform_init(&error);
>   	if (rc)
> -		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
> -			error, rc);
> +		dev_err(sev->dev, "SEV: failed to INIT rc %d\n", rc);
>   
>   	return;
>   
