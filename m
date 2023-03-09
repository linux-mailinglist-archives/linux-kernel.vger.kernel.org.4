Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B34F6B2183
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjCIKeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCIKeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:34:21 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D5AA0B35;
        Thu,  9 Mar 2023 02:34:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhZeII90hrhr0htgTrcw3wRcU7fBi3HFUvOz4G1xpi31M3gjnCYw2GuO0HxyafeT/fZjI3Nv9iSCn76DVvGx2Z15KkfKt0xBcgGrMOcTUoaNnwgpIRegj7wfHnNsxY1HbHcYderw2Ab8pByBLZnRYUZr2Hw7BaUyw5tR4J91Y2I7R9sjaLnDvWcL6kv+UBwZ0Wt6REvtgxjLhCvkgK8vez0ImvPOCIXDoy0kGxybRYCWQBpX/YfYlnnkol9wfmRxWcHftng05jHGm2Ym1Ak9QqtW2/Rsoho7RiONq4bGC1BtPxeZWpkGrZBl+ixTyBn21PjoQGssOVBkhHMQ/05hOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHymPcx6mmdOTcpRvvekEYgPK4P1hpFJrcVhZbZR+RY=;
 b=h3fn4fo+Nc0j73/BV3vre5MR/w6gmyjgu48ifvy3pSvwOxcPvjyuS0LxxDH30zT/U8CtGidj1WjKsMQM4RWJrQG0HPN14r0Vv4tL7NYZMGRoFDtfdYVaZ6kggUv/Sf/Wj8BkkNDudw6lGa5SfQc4XN6n/Foc9ctY80FUkvj8D31dZP2TG7UkCiJfA8uLyfFXDT6ZfplGC29nqZokm0FV/X/kfAmrkkPthg8VxeNHzQdf3QCLL4VAHEKSK/bsvj6VpEFmjxwQqszOWAApSqr+lY1WfSzzn5632mFRnn0YSgZgx69PGebKyJaGDTEWGt68eNVUS58ix1u9G4l6rRIxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHymPcx6mmdOTcpRvvekEYgPK4P1hpFJrcVhZbZR+RY=;
 b=dNZw5YMSnOsCf9X5R5WQ3MJ6A5AmpHdlEyZaiWSVlpuTx1gcibPxxLw9XfGLJwk23xo09J0WqDGAf0KINa0GpKMgTuoeSqKTzN6mqhi3wEtDtTCUpEOB0X0mzd6ST0GGmqMnS0Jzsoo0T0OuQ+ANVoYloH0ykvI+Xqlst6JDiuD56gVwGvD2XioEAWAUAKOYtUi2oe1KIPeakSknMDHyLErIcyjiUroIMshvFkXzSPdBJ1FckJvVyFvdKfnle/0R2dX5xLUoKGymyiBZdJOn0qOvlmwgJk4S1nGTP/LJbXdNVhEG+fJhEyFzk79EBNYbdWYRMmTsHWbusAvuFvNT7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by AM9PR04MB8955.eurprd04.prod.outlook.com (2603:10a6:20b:40a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 10:34:16 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%3]) with
 mapi id 15.20.6178.019; Thu, 9 Mar 2023 10:34:15 +0000
Message-ID: <05058013-0e9d-5422-2e1b-184fffe96503@suse.com>
Date:   Thu, 9 Mar 2023 11:34:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 01/28] xhci: Add support to allocate several
 interrupters
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com,
        Mathias Nyman <mathias.nyman@linux.intel.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <20230308235751.495-2-quic_wcheng@quicinc.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20230308235751.495-2-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|AM9PR04MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 43547d43-5fd1-44cc-b853-08db2089d4cb
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fx8KE0RC6oLkqKHgaUCyQDZ+LVLPtJkCq7+Yj8ElTlrjkH7eV07Oz5VdVTz79IXzHkRUXw2wTWN34j/NnSsA8eVM1gaT6ocL8iM1oPRqNEFBtvhxvzSd0nPjHt6k3WGOLX6TEB++cJjQbbi1zW65gRjDyryjhjJR5l3ZugTYBqGkiOBjaUtmEEmVVc/ZXGNBf8n/wx3D/ubFy0hY0AR6tntBYRsDbE0MmiG/MtVgKyaL17G9yNbtsTU1z7xF6AfnaqthW12nnoLt0MsUV+eF6JxjQpnp9NSbRkMuXxtCm5Fh2tAZWsF0JJTHRrKKDXdYJ+yAVjkahdfQ5W2IioThJKV7bqJ5Y0WZyPzpKLZz8a/7GsVHkOef+s2x1g47CFifnavshKWdQsxGa1IiEzFy8MQpEjRPXtTEbjsTzNm9fwuiICeemUjDymxN1sSdCWILycxptO2HojDVmOMzCoMBeNYD4RXYF228tX4++seGu64c+CiH88ECkyA227rk5T0SdL+FtXT2jcNMzCuilcgqm8iQJLeFl+AbfVjg3PClcuIlN65Hd3nsmEqg2la+JnfNRW85kwWXQuzcIDBX5RYldLzAYNYnnXcb6gLyetoQC/VaW/YzE5CZZ2snwBCkq7leBgn2YWsnq9F/x2+wC8ohVfP+hJGu/qJqjY7SMeylmYkxazry5auWwZhDQaynkNSScc5FKW+OL0ZbhlfoE35nrOmz1RR/y82UT+1xs0xtkTjc7i0sIj0xwfWhULT+7zwD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199018)(86362001)(38100700002)(8676002)(921005)(31696002)(66946007)(36756003)(8936002)(2906002)(66476007)(7416002)(4744005)(41300700001)(66556008)(4326008)(5660300002)(316002)(2616005)(83380400001)(186003)(53546011)(478600001)(6636002)(6512007)(6506007)(31686004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUh3MldPWS9EakZHTHl1eCszdFdicmdXVGltVmpiM1VhMFVteDFCc1J2SEhI?=
 =?utf-8?B?TkVNNDljN0k3dUJoWHkxa210TWlWNXB4UTBWVGFHcFU0WlRCQW1PZmVacXF5?=
 =?utf-8?B?RUcyU3dnajJDb3RTdzdxQ1BsRnV3d0FLN1ZHSHA5OFYxUHpQdE1Ldk5FbkdC?=
 =?utf-8?B?eGp0WFFEQk1OQjY5YjJvUE50d2FmNmNjWXlHREYycnRWa05QN0dSTFBQT1Fl?=
 =?utf-8?B?S0JJL1YzckRJeTAxUng2cFNPSXNuNjd5aXJvRHUxMlQzcUtxZytqaERUWDBo?=
 =?utf-8?B?RUFUR01qMitJSWVpZFhNOEhidzhaR1ozRCs4SGowTlA1TjYwbG56dnE2R3Vh?=
 =?utf-8?B?RU9KbnpQTjF4ZVpkU1VWNWhCMGJGMkFRQkNyL1BtblNXN0YwYThVemRxY3Zi?=
 =?utf-8?B?Q0dzYkw1a1N5Y29FaXJxMmJYVVpneGRjczdrZXNqblA5Y0xnWHI2YWZPSERR?=
 =?utf-8?B?c1BSQTZMUkJGODltSE9ob2NSS1Z4dDR6NzVMRjhjSVVNR29mN0hMNXNVU3dW?=
 =?utf-8?B?ejRTTFRldmhsRzh6dit2c2RLenErQlkzRmp2TVB6TVlVNjQwSG53OW9EckI4?=
 =?utf-8?B?czlGcWdsdCs2dDl6TFNOeFMxazBoQkdPNDloRUg1Tlc3aDBFbmJHWUFUbi9v?=
 =?utf-8?B?TENrVUgvcWJJRXkwa0E1cW83WXA1Qm9MRHZaa3Z1V2JMeWJocGptTnc3eWVH?=
 =?utf-8?B?UHJSZ0tzNGNMSU5mMlZRMlFNUUNlbUp1aWxvUmt2V0RaMmIyaytMWmJodFVV?=
 =?utf-8?B?VnRQcTFFT1JVMDlBOW9haUNpOFIzKzQ1RTNIemM0UU9iMVlLMnFndWVGSVY2?=
 =?utf-8?B?TzYybzVnbmZpRFZWZ3NWU3lxYjYxekc5VnlBWHl3VEJrK0F1TktMais5Y1U2?=
 =?utf-8?B?SW5IK21LemRseE4xR0FkSXNvSnNBVllLZWxsSktVbFQxcXpOOExiODI4ZXpU?=
 =?utf-8?B?dUZ0MlZVUkY0dm0wR1FKbmVxTVc0RzJLdzNLMGdvYUMvejZJMTBIS2JPdWcr?=
 =?utf-8?B?NDZRemxiUkVTQU1ib2QxSDJWYVl1bjRNaUtlbzRDQ1dEK05kR2d3N0lpRW1P?=
 =?utf-8?B?MWxwNTdoQ0FHVXB1UzFiOGE2Nk5LY2pub1BYK3YrcFdVbWdhckNSOUNvZzlq?=
 =?utf-8?B?TERYV1FONXF4aE9neUlDZTFtVDFlaUV3TVhRSEsydnRzajNzc2xsRHhDNlV4?=
 =?utf-8?B?dHpKTHhWbDZjZ3ZXTm4yUjhSWmRLd3pNY2RlV1BGbmpteFUvdStoTGpMamZk?=
 =?utf-8?B?N0hBUk9FTWFhaW1ZUWNvdzRUeWZZVk5ZckR4OGI3ZXo2NlNWNDFmVy9pWmZu?=
 =?utf-8?B?alZtN2V1Z0MwblJneHVoME4yK09qd29RT2tXNHB1U2taM3pNamxqYzdhdGdJ?=
 =?utf-8?B?a2NFblRPbHB5ZXNydU9XL2NTZ0sxQXpGL0FxOHkvTlhFdTg3NzJVbEU0elli?=
 =?utf-8?B?Vkcrbyt1bXNEcEtuRU92WlRiWmVncXZRVkdYdkt4OWp3YVYrNFdHZjZPaW5a?=
 =?utf-8?B?d21qY2FIQThaNVdVcjFTMUlQY3k0T29OOEdxcmRzZmdod0VjU0plUkFSbFg0?=
 =?utf-8?B?MlplM2VBa0MwRW9rSE15RS9BdnpDa1F0R2UwVlFXYnl6UWY2elhKVG1tUllm?=
 =?utf-8?B?UTRacUtmNnJpaFU1MTFhR0RaMndPSjBOdlZnWkxWcElPNFhpdVNkM2NOZGd0?=
 =?utf-8?B?bk5salZ3K2grd0J1QkZGT3FIdHVENkI3dVpZN1RMcVA4ZDdxcjc1SkR3Ynp6?=
 =?utf-8?B?c09tcENoOWN5NDhoYzMxT2IrSm9SSGtid2d0NTRwVWVjZ3BJRWZORlBJK3ZJ?=
 =?utf-8?B?eXVVZzVIbDh6SHpMQlpSNGVabDRqSWJvcm1lRjN0MkNwS2xnRHo1cmp2R2pG?=
 =?utf-8?B?K0tlZkNyaWFHMDE4eDZvL3ZCMlF5bklORGhqTW5MOHE0MUUzaG5zRnhFUUp6?=
 =?utf-8?B?WmdlL0Q0akNWOW01ZFNjNVNWSGxlQnZseXhoS1hHTXZ1UUxIdWo4SzU3R21I?=
 =?utf-8?B?dTU4UjlHbzRFWmZSVXRiWkpET0R6SnFEM1NHandPa09DSDFQMmUrY3ZhUDM0?=
 =?utf-8?B?djBpOFFDL3hJMk9udXVoR0xjZk1VSmRVOWJQUnJ1QXhuemlKa2pqUmRBcFE3?=
 =?utf-8?B?WTJ3bityZkNXYUoxR3RHdXJGTW5pYTlCc0k1Q0NCYkFOdFRrcWZvc3dyZUFF?=
 =?utf-8?Q?OFZ0IJ+yQ4ZmlVIpLhcvSJK6a3YiYsVlxjMgaM/AAQnE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43547d43-5fd1-44cc-b853-08db2089d4cb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 10:34:15.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmQxwwGoilmeVo9M1YqHPy3BfXmfdZ+84eCsmKJTi946VEnZ24JKGM6LfzxuO7YxRpikmkKNjFlzc2SCIyJd8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8955
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.23 00:57, Wesley Cheng wrote:

> @@ -1865,8 +1889,15 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
>   
>   	cancel_delayed_work_sync(&xhci->cmd_timer);
>   
> -	xhci_free_interrupter(xhci, xhci->interrupter);
> -	xhci->interrupter = NULL;
> +	for (i = 1; i < xhci->max_interrupters; i++) {
> +		if (xhci->interrupters[i])
> +			xhci_remove_secondary_interrupter(xhci_to_hcd(xhci),
> +							  xhci->interrupters[i]);
> +	}
> +
> +	/* free the primary interrupter, interrupter number 0 */
> +	xhci_free_interrupter(xhci, xhci->interrupters[0]);
> +	xhci->interrupters[0] = NULL;
>   	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Freed primary event ring");

Any reason you are not just counting down to zero?

> +	if (idx > 0) {
> +		ir = xhci_alloc_interrupter(xhci, idx, GFP_KERNEL);
> +		if (!ir) {
> +			spin_unlock_irqrestore(&xhci->lock, flags);

Why use _irqrestore?

	Regards
		Oliver
