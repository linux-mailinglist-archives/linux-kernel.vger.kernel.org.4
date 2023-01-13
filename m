Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF56669B44
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjAMPAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjAMO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:59:50 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A08D7EA73;
        Fri, 13 Jan 2023 06:50:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPjQpZEpUfOziOuCPbf6EO76njEnSiE1B2dEzCmMDAjVB/H0PBapK0j8z4tJLVPrz5amu0YrvUKRH+zvhTdzMJ8P+OXxLzcxgs20GHZ60ZLDfHRMGxeP5kBaKlKmqoyz6S67ElyP0bzAoHiBjxA8f2Si3QpaEiIXtlBgucRaI+T6g1eH8y1wwX3uGApx16s/mTujUNnHOP9cfT/oEewnNzx3vW6yfcS2iZIqJYYlxhmgb+H89JxZ/YT448rYXrt1DVsTlHYZXcrdpQHLQRobkzjTCq9R+5b+84cqbV7uqr6QAOFlwZWikXCewn6Z8KPy8+K08YkT28MDnDHMfTtcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nuq/U2Aw8XRri3+FgBqsKD4sgjHltpuqNt/uv3HIfRA=;
 b=HcdS02/SCmFKS7vJU+xtRPrxGPKsEFvuJuHxqYr0vzVwjctdRJw5wGUxMHAOUifU+v/f3QXHCCpgLuV8fzqypH/MjCt4ykLjXnSYIFzW/Ahe13Xjlkhe3nnW+EqoGVyD4+biGMePfBdO3U9OE4HSqMc+1xj1EZd97N9Qqw7nlU/p5qeEKN32DCQ6ZzYFR95LthaxOQgUa4VgV7g4N1EgQwEWnZz5UihOgreCHJjFE7guELJn/ii2lmtDvOQSGpq5nrMsULRFPAWxyz5ydFliVd2V7v/EXh5ZCpehsthzfHmtMNzR4Ha0thBpBfkzJ6Y6J3MTFPo4GlbSPJQL5Qh3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nuq/U2Aw8XRri3+FgBqsKD4sgjHltpuqNt/uv3HIfRA=;
 b=0QhXUoH09Fbjgfp6Iui2rPLbePJu3PqKOthU+fXKhlqv921nWcSVdinszxW8L+WTfiv5+9oBkFZmIrugC4MkubNqa6lCmCwHhxq1XxGtt1zgD/1FEdE00pFwz5Rc0X56lnggz4pnqb5xU3BPqTZis2FKVQWAeLupY/z7FaJH8Xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 14:50:47 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%3]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 14:50:47 +0000
Message-ID: <ead43312-fb0b-5964-ab1b-b07af7c93dd9@amd.com>
Date:   Fri, 13 Jan 2023 08:50:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5] crypto: ccp: Sanitize sev_platform_init() error
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
References: <20230110191201.29666-1-jarkko@profian.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230110191201.29666-1-jarkko@profian.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:5:174::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BL1PR12MB5269:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cad9f3-b5ca-42f5-0576-08daf5758de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bOK0iXmyS6iupybgqP/AnlXezDGZODRNwaakkJX+IKqN7PyCz+h7FePbUBOEcD0v4zjXwroFFo8EujT8iqU4xm33QTKaQJCpneCCS4tgNBxLy30h7Fi9PsoqVDGL8y5hp2++gUNxLOnVKCyfOtFBZKUKR2hSqUtEif6TLrQVkHx6vlN7oU5mJBZplAOX0L08St3TCXCDTH16jLZdUz1cT5ptA5Ihhshs3Oe3kFMZmG/QWtZrpT0psFNUPMGlFuXNX4+EMeopA+80DpzaXASOWHTHK1oPKQfPBkroSRh7P/1HhDL6uttl0ZyPdGHrq3xmQMek3Bc8OXIOwOxa30bXQHdDKJlAO3RBh5BQ4iZB7R0HyTPivJGfAwXZpR/L81dptULXnGDappxCFcdU3BZa8e6tOQJ11P/k/0Du7S9OC9eBXTt0L9XDo7gq0q+Hq3LfgKQFr7TrzRr8jdbNE5nVzEw5xnC+dr01fePZUt2zVTJ0jooTYKdI4qAAI8qyyOUqbwS9NELORCgijpaOilIrcmhmNHlwsdL9YaHfNQOixGhGIxNTrB60rCrDK9zTt8Gel39jMLckPbkwys7mA5+CjzBGTCsnMYicEmrsIyzDtaUYPwpPs57gzWW6GbWTZsSNOtmz6HEtmQkeWOfcGBs08Ik4UfFl24MeaAQpcjR8bi2NA1ARajtOCVDjyff4DRom6aCa8Sio8e97mP6ExJVgRt6V9ycREViomsf3KK2gnGwnNkENEFsZjGamHIpQJaaFuSYKkd1zqtA9x5rqh2tv8NnNBADV9tMbkhwMTi0syk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(2906002)(5660300002)(110136005)(54906003)(316002)(15650500001)(36756003)(2616005)(38100700002)(83380400001)(26005)(86362001)(186003)(6486002)(966005)(31696002)(53546011)(6506007)(6512007)(478600001)(6666004)(8676002)(8936002)(31686004)(66946007)(4326008)(66476007)(66556008)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0JRRlc0WDljejVjeTJSM05jZ1N1OWw4NFZ4SGlGejRyOGwybjVmUTI3emx5?=
 =?utf-8?B?NzZYNkgzcmdrMDFuSXQ4WTBQSjhHNHpPNDlRWUV3MFpEVHk1TEhoWnlVb1JD?=
 =?utf-8?B?bG50V1d4blYvbnlsRUQ5RE15elRHOEdPdHNuMVhxVmhEcytvQndGN0N2Yml5?=
 =?utf-8?B?T1lrcVVFcDdUM3pqWFVyMDRWK3lJU2hkV0pNTjF4TmpmbDBzb3gvTUVLanVt?=
 =?utf-8?B?aDFBUzFpaW9lbHpHbldLa2FiSVFldHFCWklLa092WUtERExONkV6cTFMVzVi?=
 =?utf-8?B?VXo0Z0JRT1RMWVRKa3BIZENMaFJJTGNxczRMbUpsdU9uMTkrL3kwVHdrV29C?=
 =?utf-8?B?dlkxRVhMZ1NxVjVhWkdXTjlGZnlpcFhXL3FSNUxtUm84ei8xa0dUbWdia2Z6?=
 =?utf-8?B?ZVFsUnlkWjdTWnNBdllLdlRqc3J4d1RKZUdGOU5STVY3aHlZeGtKUlAyWmU3?=
 =?utf-8?B?czhKekJRNFFCMXgvdkVINGhHeFpPa013bjMxb2FvdlNPTUI3Z0Q3dnBLUjY0?=
 =?utf-8?B?VVVTNE03Q1RNTmdOQitHSkQ3L3M5WFY1SzJDUi9aMHJURFJGbERqb0JJZUR5?=
 =?utf-8?B?L0pKMWFlR2k3TU1YMWdMQUx5Q1ZXbExYZEo3aHBqaS84Y2hGWlJnVmt2REcx?=
 =?utf-8?B?MWpSNDFWUERHUm9xcSs4bk4xaEM0ZG0wM3BNQlJLZTBFdjd4TUVXdGllc2p4?=
 =?utf-8?B?K1U1ZU1LRFlXS20wKzN0d0dweldyNjhqbHhGY3krWDkzUDNzeGw0T0RRc0ZM?=
 =?utf-8?B?S3QyenpkQUM1aXdxRW1VcXVRMTZodTNzSEZpRUFqMHdHK09sVndLU1RzTVM4?=
 =?utf-8?B?Y0NYUUtHWThVUHFUb0FJeE9Sd1JWbmgxZFphcVo0cmFuV3d2RWRWUTRxby8r?=
 =?utf-8?B?c3NNcGVDYVlxWi8rN215VlE2czJhSVJxQ0R6RllZQnBIR1o2blAxMEJWdFp5?=
 =?utf-8?B?V3N1djE5NjBVQ1RyNG5RRmVjN3FndGNTOUlKVmM0T1E5OHBZZHpmdmgwbHB3?=
 =?utf-8?B?dEgrZlZudGw4dkNCeXJGZW1wclcwVGRCWU82eEVORStCM2JtZ0pNQ2o4SFBV?=
 =?utf-8?B?WmdPWkcxM0JvaGl2cjd5c1FQK0Zxb1Rna3BwcVV0MXAwYmppL1ZkZHlzNWRZ?=
 =?utf-8?B?OVJ5OVNOVXEzekxlMnNrNHBQTlFsUUJmUFV6cWZhendTWFVtTk90K1d4TXpi?=
 =?utf-8?B?VXZFWTIvZ25FWkNoOE1BUUZkbUtoM1FBNDdxR1o4Mkc1RENSdUt1Zk02d3RY?=
 =?utf-8?B?VXo3QWpmRTBZdUVEZ2x6ZFovZTU5a0VZakNSL0tjYy82KzB4Y0JPMTR0clly?=
 =?utf-8?B?ZWQ5YVY4NXF0MkFrY2hwMnJXaEdRMEFYMEJlRVRUNDJUQ3YyVTNocEg2ME5r?=
 =?utf-8?B?Rkx1NjRuVFpENXUzQWpwL2laY0J1NC94M3hhWVZxRW4weGNVZHJRdWpqRGdG?=
 =?utf-8?B?d2NXSXc0elBNbm1pdFpYT0dRZFZ0QWdmUWVXdnZUQWdVelkwTDljZ2lqNENm?=
 =?utf-8?B?MU0wd2VPK3UzTXpldUtxNUl6R1p2MlBnWXhKaUZJeVpjeVI1cUkzQmhOVTN4?=
 =?utf-8?B?eFZSWklTT0MwYUlNajBkV2RTVDYxZFhwUyt3TFQvS3U0N1grdDNNQ0JxMmVn?=
 =?utf-8?B?TExrbFJKWDdIMVV2Um14N0pLOFV5S3cwR1M0Y043WW1tK3hVRHo3WmJLalQy?=
 =?utf-8?B?bWhiSFRXNS9nUWZPSllPWW5JTG9sTTdqcXpqTGlxOWYzR25rZDg4ZTRFdGF6?=
 =?utf-8?B?cXdJWDh6ZlVQcmpiTEtyUDkxVXdUblI4WEpUVkJEK3NIb3F2TEU0elZBaTcz?=
 =?utf-8?B?b2dqdFljRHNxOEJadjFVZWViZkNRQXhMdkdyRGdvVGRQMkxqNkpYWkw3R01n?=
 =?utf-8?B?UFJ0bmFYemc0UTdMNjNSdmtJdk42MEVPcnU3dHNaSWNIS21Renk3cWhxQnh3?=
 =?utf-8?B?L0NwV0xIcnFDcmNFaDQxNGtHV2o3UDJRMm5FOWtkYUdjUjdEcThVaTdvdTBx?=
 =?utf-8?B?RXdrQm1LOTI2cEJFU1dIbFl1UitqN0xDV0tqbVhldlJiUlFoRUlyVWEwb05X?=
 =?utf-8?B?QmpKeW5RVU9xYVBjZE9KL0dndkpUVWRpWStjb2g2YVQxbzVuZjZ2bnMxbGxo?=
 =?utf-8?Q?HjLcyNx8fchSV217WWhNQ824Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cad9f3-b5ca-42f5-0576-08daf5758de7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 14:50:46.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OefA8oof9FyFt9bt4PtFAdhvJzi3ec2CKHUbH8gPQ5pqzcthY9TmDKupYKeImWNMiT9J9tAOpvrdPUvnjuCJpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 13:12, Jarkko Sakkinen wrote:
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
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> v5:
> * Address Tom's feedback:
>    https://lore.kernel.org/all/ddbb4b2f-3eb8-64da-bce9-3cfd66d7729a@amd.com/
> * "failed error" -> "error"
> * "SEV_CMD_" -> ""
> 
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
> ---
>   drivers/crypto/ccp/sev-dev.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 06fc7156c04f..3f80cd39cbdf 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -478,17 +478,23 @@ static int __sev_platform_init_locked(int *error)
>   	}
>   	if (error)
>   		*error = psp_ret;
> -
> -	if (rc)
> +	if (rc) {
> +		dev_err(sev->dev, "SEV: %s error %#x",
> +			sev_init_ex_buffer ? "INIT_EX" : "INIT", psp_ret);
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
> +	if (error)
> +		*error = psp_ret;
> +	if (rc) {
> +		dev_err(sev->dev, "SEV: DF_FLUSH error %#x", psp_ret);
>   		return rc;
> +	}
>   
>   	dev_dbg(sev->dev, "SEV firmware initialized\n");
>   
> @@ -1337,8 +1343,7 @@ void sev_pci_init(void)
>   	/* Initialize the platform */
>   	rc = sev_platform_init(&error);
>   	if (rc)
> -		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
> -			error, rc);
> +		dev_err(sev->dev, "SEV: failed to INIT rc %d\n", rc);
>   
>   	return;
>   
