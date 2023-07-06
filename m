Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081EF74A1E1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjGFQMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjGFQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:12:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A379D;
        Thu,  6 Jul 2023 09:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs7DEepFtYHw3dAYvpEjis7I+jommWUa9s4RfnNu1PuzgUvImn2iADlK/RWIf+hklIeQ9QjLTutRSSy6rJgTz8J51PqN+UvI6+9vtNdHI2muDMti5EXaTtxYUrwCRoW0SMWVMsYEBU9tc19iXgyFKv5pgnQ/RXzfVLxQkEg4aDjRo2PMSbgqqah9zmQsZNl+VBOvTDuZXssIWXdmOqTdp7Dg6hXTiv3lUYBKv+OWyU8Y3kIjdwpozeKoisLMC7czey1+2SR1Khh1SKGEb5rWuxw5Ks2fEjRdlkjhajAiKwCx6d3ZOqHbsIgsgUiA4unLaS9M4CFsKKnoUUvvdi/hUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbXbccT7AebmlfddUjhufB4vPice5pNHnB60jZ9uvQ8=;
 b=LA6C5uPBmBmT9FlKH1pnYYuofgBkOuQ25dxkaw7HYRRzY4Kq7jaFk2vUpG9Wp/OZguChsMhJQbKBXpIKqNqDdti9dPOwGFY93Q8tTIPy9XaaobOm7nDqk4hZQRYuDwXmwaU1IOudR82c7O4of7c+SLbniLlob0+vwWd5Zi/Hzr8G/KcTWrxly7H4Ms+3J8+YjovLNFYVezlULbS/yLlEZuEuzMRsJ8PDqf0p3XqeLlBADLprBobsOFgHqoa7rs6mbVlYKCesCQ+WJATLTjSORGLugxQKiUi9UXGtWZtCiKC3tOWojVdk7yG4bgPJ8qKxKWsPSxlGg8Vk2pTdGvwJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbXbccT7AebmlfddUjhufB4vPice5pNHnB60jZ9uvQ8=;
 b=WnPY7KUpisJrcaApowfmv0HSm7vcOknxnrps++kMnMZyUm5fQIlkOxYLiEvzn/YuphloHBu1MkKg2+At2bb9SRPxz3Nf5pdt8sKqnTMw+A39EktWx7lNpyAQNI5RoKsj0g3uxP43PUHBUTMSJN6SgxiNuu+TzFaEDH+muK9Q3guUbG4pHsPHFru9Lm05AkadSQC5iESeapqPbtiVXdNvTLw0b1gqEhPsVsPq8a3t4+O6o0bE7Jus0WvmNVP1k6E3HCt1TMf2tD9sUgg8UZZGqhZ21KJA3TxHrdaJdaBoTWBDUx51Aoa5bd4hAtJUkoo6eiDFHQOb7nYZUjR/Bbvjjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 16:12:06 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 16:12:06 +0000
Message-ID: <9c07e4f6-2cf5-b53b-6b48-bd4df8798ee9@nvidia.com>
Date:   Thu, 6 Jul 2023 19:11:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230620132703.20648-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: dad02193-913f-464a-70b7-08db7e3bbe5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lSMwCiBGqENp5cIbkff4txsxMaJwqAg7y6LvT+s5Ne91sURtUTLpSA9FZYzdNbM3oxweSKWjsKvdwB8a+EiXlYuBuxfCuB8exb/EUnLxFyGEM5ElDXAfcP48jObN4BLHjqvMMIBBRvz8XFl3ukt5L8YUtS4J63DUoZ5WGKMVwZNyLhhIwOboRD/Adnm/oRhyhNto3zS0KWBrJKwSpcIN40gYF4gNxxlrOwIfagmiAwLlNI53+dEAMBOB7H3XFMssUae33vjCJtj4zpJUCHuD4pdvGyENTIZ3XcKLrGPqkJPM0NHdvJGyZdFd5grs0n/cKmcZz4fUJUs8PdL8PZqY+a4AVE0SnxUsMffUhBRxueYVEQuCqfv1pmKOVV4TXagRZ6T92ySIiv2IXIY37gOm9/xwCmGu4m1EQyrJiCxVX+n+fys7kFHVBOVOy2ydz+aIx3vCZbR5ycCyayqhGfanqj0Wb05t16sx7Fhmu6sE9xTZ5+ntJvhQOGJPZ2M7oRw+8OVcEPcJmWuJRU/4ECzUQMNmya1a1uq88sznbGD75YY1GAD89AgJp5u3bQ3C7XgrYofoFVtIS3v6AchmERzKvVTYp2k7kjvKgyrsJo/VNrIEQ7+dzlLxDLM/N6WNckR8cQlht9jPNqQgaOhUD1KMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(54906003)(6666004)(6486002)(478600001)(6506007)(6512007)(2906002)(66946007)(41300700001)(53546011)(8676002)(66476007)(4326008)(66556008)(8936002)(5660300002)(38100700002)(316002)(83380400001)(2616005)(86362001)(36756003)(31696002)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDhWQXFqclYvV2ZKMThnWVNGNDc2dGNIc215N2RSNWN6ZEIwZnp6OEl1YlNp?=
 =?utf-8?B?Z1VzSTRiZmp1TzlKOEVncFZoNTRrbHdXVlFmT3RFVXRYSzM2TUQ2ckY0WkZs?=
 =?utf-8?B?dUhHRnUwbFMvM3NxbFVqQitNWi9GZnNrRm9OaGR6S2JWc0VCY1VaUXRnZWpN?=
 =?utf-8?B?MkpZUldaM1BkYWdQS1R0aHRSOXFUeUh4djNQdzNpNjdtWG01YlhNSHhtV0Ey?=
 =?utf-8?B?cVAzdEdwYTRXWDVHcHMzVU5neWVGM1ZUalR1Rnh0M3hrQ2x0M1NNS1ZOOHJU?=
 =?utf-8?B?RnNwSGwva2xQRlNneUJFcWFza1MxSSs3QzNaTW9pOFZSUk1PaWdzZ3Z0Nndo?=
 =?utf-8?B?T1gzUXNwR0JzTzc2ZmdrS3hBUWs5UkRkbHloNVFFV2xVeDBpZk96eG1qY08r?=
 =?utf-8?B?WWxqaXUwZ0lYRWJrY2VkVGxzNTZDVGZzeHdkbFpma1R0cXROWmRmbXFpc3dT?=
 =?utf-8?B?K1F1eGFnQkl3MGJGanJ2K3l5cHlPWWRMaEx2WC9OeXRKUEg0TmY5c0c0N2FK?=
 =?utf-8?B?NTZkTlFJNVV0dEJQK2pMQWVyaXpQaE1SU24xdjVuQXAySm13UDBuNTUxVk9O?=
 =?utf-8?B?WW90L0lwQWJ1MDVuLzdkRGRycU5kbkZjSGs2TzNER3pRdURxVEpLT25Lbktt?=
 =?utf-8?B?azRWcG4yOVozang2MlNwZjN3UEd3SW5wdlJUWGhjOUxOQm4xUm9PSU9yOHBq?=
 =?utf-8?B?YXFHN1pjcTB3VEtDNzVWZU1iY0dQbTFwNVMxR2ZIbTZhQkpzdS9YUUtUVE5o?=
 =?utf-8?B?NkI0NVJrNDV4UDExMUNuNlZ0ejY5WTdUVWV6LzFlc055NmovSzNUUVgxVnpT?=
 =?utf-8?B?VGRxOXZpRDlUY1J3aXFKY2FXYUtCTEdXYUFBNnQ0dnRPL3lBNWFLTTFCc010?=
 =?utf-8?B?K0QrclR5ajNLQ2U2UWFBZE9TN2ZkY3g2aHBxSVZ3YkRRb2t5Z3RjL3FOSFFm?=
 =?utf-8?B?WTVOVFBRVlFaLzhHcEhBbVl2R2FjVkZGL2pnbkJEaHpoS2Z1NkJHSjIxYjVP?=
 =?utf-8?B?bTdTYXFtNmVScnpvb3k0Zk54cGJ4bytBLzM4MjNzN2tDeGdXbk5MMENNU2Ir?=
 =?utf-8?B?ZHlURVNPdUFKdHRuT3lnanQ2VlhzM2pzMnZDL0VpM1R6aXpWR1hrWlVOYWUz?=
 =?utf-8?B?cVovMmVST2NCVll0aWU1QmNETTI5QkQzSm5naGkzVlRFK1I1Q0ltTzh0OXh2?=
 =?utf-8?B?Rm54eVA1V3oxZFhmR1pCRXZiQzdNQjZzU3lQV2hWdGtpckVQdGV3TTFERU95?=
 =?utf-8?B?T01lLzRlYTFQRzFldWI1U2pzZGdUalhCQnZoZ3kydXZ5amdKMEhxZHRSbm8r?=
 =?utf-8?B?RERvTVRiM282VERnUVZubnllcVVvNFNORHNFbUtSOTI4ODJGZ1hpVHVuV0Rl?=
 =?utf-8?B?Y3ovWEl4RkI0SURzZ0JzTFVhaHpnbEl6WDlTOHlVM0tUS1lWRFVrZyszTDA4?=
 =?utf-8?B?dHFTWmtDVkRGN2FjMFhBTjRRZU5KWnBaeUdVNUhjaEZmVE9xRFl0SzgrajlZ?=
 =?utf-8?B?a1JsL0E3SjMzZTVhejZUa0V0MXY0dGJCSnY4cEVLVk1VYk1pTW84NmZUVm9w?=
 =?utf-8?B?ODk0dUp1T29VS0xFN1NITjhNQmFJWDlkRHJ6bmtnWlhKcTVQMGE1MEJyVG55?=
 =?utf-8?B?VlExdE5NMS9JY2E4ZGZoUFlhL3VKSHpEcFpJQ3JsdERLMnE3eDU3OWhEN1ps?=
 =?utf-8?B?VUF0bmNoUWZvSE5TNjdEYjZMNk85TzhiZUVjVjVqQlZRYlRjWFMvNjJsQ1E3?=
 =?utf-8?B?QXdZOXoxTFBtSU1KaFpPSW1TR0IrZmk1cDdsaW9jVjBHS09ER1J6MFR2ZVNO?=
 =?utf-8?B?NGVkSi9uUWtPTWxMeHdtYzdqZ1FrMTV2ZUZFdFdFYWc3Ry8xWE0rRzhuTkVX?=
 =?utf-8?B?Wm9LczIxdjNCZURqMElwbUx3cHRNcjRieWJzS3Uzcml1NS9vTlZwUVB1bnc5?=
 =?utf-8?B?UldWVVp1Y2N0Rlh6R3R5L3dNd05PNmZ4V2U4UGt1TmxJblJaWXh0bmVuS212?=
 =?utf-8?B?L29nZXgwVVF5aWlza0sycHM4dDU4ZjVyRENsRmtDVmlOK25QeTdrTG5oV3VX?=
 =?utf-8?B?Tjc2V1duZ1hvTXRWRlVjb2c4MERTNGJOVk14ck1RRC83ODliR2FCeXp4ZlJL?=
 =?utf-8?B?dHVHajk3c1ZXSTVsSXl1aHdYYTRkSGtvbGxSNHJmbm9HTDJKcWpvOGNRZ2Nm?=
 =?utf-8?Q?SN5+U7MudwEo1pYEjShBWphWKCaTVxKP8PaPc2x0oeEy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad02193-913f-464a-70b7-08db7e3bbe5a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 16:12:06.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrk9cibM13VmyAzxumqSsVXVLmDtHEwUAFraiTh3nZV8d87T8f10ZGozgFMqoykHyW1y9PNk7zER0Hv1i0CrNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/06/2023 16:27, Daniel Wagner wrote:
> When the host has enabled the udev/systemd autoconnect services for the
> fc transport it interacts with blktests and make tests break.
> 
> nvme-cli learned to ignore connects attemps when using the
> --context command line option paired with a volatile configuration. Thus
> we can mark all the resources created by blktests and avoid any
> interaction with the systemd autoconnect scripts.

why would we like to ignore connect attempts during blktests ?
We define unique nqn/ids/etc. So we never should disturb other running 
services, unless it uses the same parameters, which shouldn't happen.

Agree on setting the hard coded values for hostnqn and hostid instead of 
reading the /etc/nvme/* files. This should do the work IMO, isn't it ?

> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/rc | 73 ++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 63 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 191f3e2e0c43..00117d314a38 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -14,8 +14,8 @@ def_remote_wwnn="0x10001100aa000001"
>   def_remote_wwpn="0x20001100aa000001"
>   def_local_wwnn="0x10001100aa000002"
>   def_local_wwpn="0x20001100aa000002"
> -def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
> -def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
> +def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8"
> +def_hostid="242d4a24-2484-4a80-8234-d0169409c5e8"
>   nvme_trtype=${nvme_trtype:-"loop"}
>   nvme_img_size=${nvme_img_size:-"1G"}
>   nvme_num_iter=${nvme_num_iter:-"1000"}
> @@ -161,6 +161,50 @@ _nvme_calc_rand_io_size() {
>   	echo "${io_size_kb}k"
>   }
>   
> +_nvme_cli_supports_context() {
> +	if ! nvme connect --help 2>&1 | grep -q context > /dev/null; then
> +		    return 1
> +	fi
> +	return 0
> +}
> +
> +_setup_nvme_cli() {
> +	if ! _nvme_cli_supports_context; then
> +		return
> +	fi
> +
> +	mkdir -p /run/nvme
> +	cat >> /run/nvme/blktests.json <<-EOF
> +	[
> +	  {
> +	    "hostnqn": "${def_hostnqn}",
> +	    "hostid": "${def_hostid}",
> +	    "subsystems": [
> +	      {
> +	        "application": "blktests",
> +	        "nqn": "blktests-subsystem-1",
> +	        "ports": [
> +	          {
> +	            "transport": "fc",
> +	            "traddr": "nn-${def_remote_wwnn}:pn-${def_remote_wwpn}",
> +	            "host_traddr": "nn-${def_local_wwnn}:pn-${def_local_wwpn}"
> +	          }
> +	        ]
> +	      }
> +	    ]
> +	  }
> +	]
> +	EOF
> +}
> +
> +_cleanup_nvme_cli() {
> +	if ! _nvme_cli_supports_context; then
> +		return
> +	fi
> +
> +	rm -f /run/nvme/blktests.json
> +}
> +
>   _nvme_fcloop_add_rport() {
>   	local local_wwnn="$1"
>   	local local_wwpn="$2"
> @@ -235,6 +279,8 @@ _cleanup_fcloop() {
>   	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
>   	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
>   			       "${remote_wwnn}" "${remote_wwpn}"
> +
> +	_cleanup_nvme_cli
>   }
>   
>   _cleanup_nvmet() {
> @@ -337,6 +383,8 @@ _setup_nvmet() {
>   		def_host_traddr=$(printf "nn-%s:pn-%s" \
>   					 "${def_local_wwnn}" \
>   					 "${def_local_wwpn}")
> +
> +		_setup_nvme_cli
>   	fi
>   }
>   
> @@ -436,18 +484,18 @@ _nvme_connect_subsys() {
>   	trtype="$1"
>   	subsysnqn="$2"
>   
> -	ARGS=(-t "${trtype}" -n "${subsysnqn}")
> +	ARGS=(-t "${trtype}"
> +	      -n "${subsysnqn}"
> +	      --hostnqn="${hostnqn}"
> +	      --hostid="${hostid}")
> +	if _nvme_cli_supports_context; then
> +		ARGS+=(--context="blktests")
> +	fi
>   	if [[ "${trtype}" == "fc" ]] ; then
>   		ARGS+=(-a "${traddr}" -w "${host_traddr}")
>   	elif [[ "${trtype}" != "loop" ]]; then
>   		ARGS+=(-a "${traddr}" -s "${trsvcid}")
>   	fi
> -	if [[ "${hostnqn}" != "$def_hostnqn" ]]; then
> -		ARGS+=(--hostnqn="${hostnqn}")
> -	fi
> -	if [[ "${hostid}" != "$def_hostid" ]]; then
> -		ARGS+=(--hostid="${hostid}")
> -	fi
>   	if [[ -n "${hostkey}" ]]; then
>   		ARGS+=(--dhchap-secret="${hostkey}")
>   	fi
> @@ -482,7 +530,12 @@ _nvme_discover() {
>   	local host_traddr="${3:-$def_host_traddr}"
>   	local trsvcid="${3:-$def_trsvcid}"
>   
> -	ARGS=(-t "${trtype}")
> +	ARGS=(-t "${trtype}"
> +	      --hostnqn="${def_hostnqn}"
> +	      --hostid="${def_hostid}")
> +	if _nvme_cli_supports_context; then
> +		ARGS+=(--context="blktests")
> +	fi
>   	if [[ "${trtype}" = "fc" ]]; then
>   		ARGS+=(-a "${traddr}" -w "${host_traddr}")
>   	elif [[ "${trtype}" != "loop" ]]; then
