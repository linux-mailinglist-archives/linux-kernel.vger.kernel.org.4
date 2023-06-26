Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D5973D74B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 07:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjFZFsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 01:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:48:13 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DA9AB;
        Sun, 25 Jun 2023 22:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGALV/Bgjr9Zgr/jaXsWO667wUCIXnS00EhJbUAORrfQcoT800jr6YNULnserDwGYs7neQhVbR9BjgrdRrzjkMGWel8L/yestQU4LbT4gExU/4O7/T1+4BjJxwyVODjAq+myIaVsD8Uzs2Cf6V3HKlrO4URS5Eo18MLFhUgWTRaDlWAb/2vMkBwG+iQ+MaNpczUO7Yg3uKKppC/+RrfccMtBi+9JVIXMSaVMsHNzJCGLH7V5RF+BDbCiUyb2MxFpu4yRNFJ6Uwj7IV3UW6JceCloSFNaqmGdJRvze8sUl8Sf4eQbnw6xh2jgSv5zSFGOHeAJDcngWrGvPW/DGNojyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OIfhZel9OSIrMnwV9oqQHwKNabLshgbuxOifQmEuME=;
 b=n2nY33vbEHPNnUclYBujDTni5548h3VaKnjyC6VKHjmC4t4mx4qwtLWDyuYgTUOf9/ZocoAUTNw7LcT+L0FFxeeB862giB6xc4TkGB86gSvMuUmBoLCyrKYsGu5usUBRZOhGBDc9dzQ45eYtWpN3/ycMbZ8qGriTx9zL/G+crIAHeW+xAD+DHzZTO4FK/a/lDeQvzMdUVUeGhCsWvcZwvcEd8Vqw5NkoIbirUmgl+eP3ccEuRynsMs6Itdx2EPMAfq9jaL63fC/6enrX91hzKGhcGegvKa3j9YHY2sTcWVEJeaB4nwwNrs/LYXxVx4WKHmUoE2xNKOoGpagMPJoAsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OIfhZel9OSIrMnwV9oqQHwKNabLshgbuxOifQmEuME=;
 b=QbEQd3om9N8XlGHiXHkO7Lgegxtes1q2FZd59e+UiuTDx/qYIhqAjYBaZCdFdvJsXOc8wD3uvOEhq8xOhNgzwyF3poog0g+a0YPB8K5uP6v1hWdqMcMMxDqfaKKW1Lbqv7+yavYfZWhnXiEGfpH20vCB3xPXqmlNixcxXNLIL4FCSeHkFYowLC00TSZDKS+DXTUx48TboY1d3/HPRSCQJd3kV2AOrd4HVs32obAjXcpdUDzO3iHR2Bme3owrfk9P9ZDHUnBKxWuZFwJ14SHWMfYJbos1j2XjVwj9oeSh3u6IvY0SJG/ZLvWOvHvejFY6H1wEPWK0TX8Uc2vECKFEqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com (2603:10a6:10:2e1::23)
 by AM0PR04MB7028.eurprd04.prod.outlook.com (2603:10a6:208:19a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 05:48:08 +0000
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::9bd3:48c9:ff58:9880]) by DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::9bd3:48c9:ff58:9880%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 05:48:07 +0000
Message-ID: <1c8ff405-2bfe-37ff-42ba-aa4f81853475@suse.com>
Date:   Mon, 26 Jun 2023 07:48:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] xen: fix potential shift out-of-bounds in
 xenhcd_hub_control()
Content-Language: en-US
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     gregkh@linuxfoundation.org, xen-devel@lists.xenproject.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgross@suse.com
References: <tencent_15DD79B42AD8A0D64A7CDC24D4FE6C85800A@qq.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <tencent_15DD79B42AD8A0D64A7CDC24D4FE6C85800A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::18) To DU2PR04MB8790.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8790:EE_|AM0PR04MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f82fd14-42cc-436e-3c9d-08db7608eaff
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nF9SemVm3OVNylZqEv1SRMwbuul3RsgFO3cpD8IALrGWMYH3S9bUp09glPbP8rMSOJ9Pe108r8O3NhgjyjmkDjJoc7Wgh/qloQbCuJcAv5+YS2IZo1B+ObbVkamdJkYtnGGitKfxAyJf8xbq5V2BlOPkk/dah5yb1ADbajy2bqn4XYC35wQKuALDcYNKueQ6ZWYvf1rNuSEBTT7Bi9JK+Af14wmGtqf7XylAKCsEmXzcT/LYB1nbVEAxPILsUzCuPlHX+fkHoj5Fy8YHAMJunvwM+Qc01M47AF6OArPtNFI9x8bPquXlBnMPoEYWd16R+rcexJ6bAu2NO5C76F//M3t3EUPmQLFHYLlGmqgEvCS0KfPpFWA4vJPBTUbzWTACQKJ7z/kpu9zCRIY2FW2rT7td1AtnV1sl5VhKIpWUGybdUBstt744QHdHJgHBZ0OiX17szi6dPfemDtxTbBXvB8yERrJW9ZbChEAB6udPpw0jBa0tw8ehxmFEohq7UAaBY83YfHsg8WbIeuBaua2k7O5bTTMtPkvjyK7LxFfmWe8A0AKQlO3fbauoxuvLVVKG+W8YF1OOT8ictnUsMzceLKU63jU9j78BVjkn4hdnHe26ws4o4xouoMArjt3u+Nwds1UpiR/jPQQ9G/APzu6CBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199021)(31686004)(26005)(36756003)(5660300002)(6916009)(66476007)(8936002)(8676002)(316002)(86362001)(4326008)(41300700001)(66556008)(38100700002)(31696002)(66946007)(107886003)(6486002)(6506007)(2906002)(4744005)(6512007)(53546011)(186003)(478600001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVlpZU05cU40enFtSWlDVDZuSmdPMHo1Y1d0ZFhhVVR2eEM1TFM4OHVlSUZQ?=
 =?utf-8?B?bFRQZ2FscEZUaVZXcXlUSk02ek9ZZGpsdkpTM0JiQnhiYzB1UjMvVGFzQXl0?=
 =?utf-8?B?MzlaZW00QXR3ZUxHM2JKUXNCVkM2M3krUmhHWHhmamNmaEFFN21OT0ZLQ1B2?=
 =?utf-8?B?OSszdnIrY1hvaWlRRW8vYlVkVHdIZHFBZWxWbTk3QUhLTmpaQnBqOEdIMnU3?=
 =?utf-8?B?N2l4a0dHZ3FvN1I5VG9tVzNTTGpSeVF5ektOM3czRWhqaWVEVDV5bkRteUdV?=
 =?utf-8?B?ZWRtSjRIeXYyV1haYUI4WkhXY1pWQlc3ZkxrRmxDVXhkcHRrWjZFV2VKRlU5?=
 =?utf-8?B?bzJTYU1PQmdyYTNTclZWRS9tQ3N1YlU4ZGl5ZGhDSVZQbFdJWUpObk91ZDhM?=
 =?utf-8?B?bkxWeEdRM05BM2N0b1VtVGN1S3NHd2JMTERQcy9hODBqZUo3eWt5ZFc2Y0li?=
 =?utf-8?B?N2dhVy9vVXJOQzdPZDRBS0xRTEZUSEg3K3NBR1JEa2RjK1pRcGlGdjFXV2dr?=
 =?utf-8?B?Q3c5aDJxMzN5SWF3Q0lvcVZaZ0FWR0JpWDRMaWZ3RWVySzFUR3I4cWtvWDNR?=
 =?utf-8?B?NHd0bFpraHpJYUJNWmxrR1FZRml3cllwWHlLMGJ0bWVmWkdaSzNzNjROd05Y?=
 =?utf-8?B?RDlJWEMvV2d4U2swdmQrV09rZmdZMkhYdW9OeDVyZnlRckZNTHNDeVArcVNN?=
 =?utf-8?B?aGxnZ3ErRGxHUTRGb0pQY2FIVVZpek1zUElNZVNXUDVpTkpqQ2JkL3UzdjNI?=
 =?utf-8?B?c01wR3Vpa2hKUVNrV3FNdHQwRm0vSWRBeFAxay8zQWx0VE1kRjZTeVZVRldm?=
 =?utf-8?B?dkNiWlczc0IxMU01TEVnRlhFa1BaYnRQMkEzaHQvNlZVdmZZUmRuelBEZ0hW?=
 =?utf-8?B?TXFpL2lPUXNsSSttNkNXc1p1bmZvTDltV1h2UGJHbzlWRFB0eFM1TXdyam4z?=
 =?utf-8?B?dXFzdkd1OVB4eGxISmRZVmpnSEV2dnFzR2V6MGlKaHU0UlExYmVvQ1pkSWVi?=
 =?utf-8?B?ZXJVR2hqaTUrMkN2alpsVXFXc2VJNUJvL1Q2SExJRlA2WktreU1FZGJVT0Z1?=
 =?utf-8?B?bHV3UkxkdmdpYlFnVGNNR0NuZUY2bTdUdW5QY3VWd3k2d0NaWkFkTFNmaWtC?=
 =?utf-8?B?TVFyZVcrVHRNYnFTSWFxTWhmR1RZbGFRcXhoRUpjaDBqanhMMWFhZ1NSc0Nk?=
 =?utf-8?B?YXhaRDVVVUUzaEhBQUkwZGEyMjVId01MejM2b1NnVm9HWkxPRzhCbkx4L2px?=
 =?utf-8?B?OEZzN1BHMWNGU0JVT2NvNU5BQkw0SDV3VWxHczdvV2M2QkFMWmNxMDBCMmd2?=
 =?utf-8?B?TDhIUURRNVlQRC9TR0hGVnFEUEVvZGpqTHdCSUE3ck9JWUdocmhpVXU4VTVr?=
 =?utf-8?B?S2tPYnQ1bVZWRlBwZUVucDFkYVJMNk9KN05WRVNRWXdQbkx2c3AyUC8vajlh?=
 =?utf-8?B?emJyNjkrMXBEeUJ1ZXNvWmpxM3BlZEZ4ZlZEakx5WSszOUpEMEhQWjlKaUUr?=
 =?utf-8?B?RmMvcHExS253VTVIU3VaRW9heXE1dmt6QWMrWFN1ZnhzWVVOVEZOMEFnSDVM?=
 =?utf-8?B?bHF6T05uc0M1dmNlZFJYYmdPSFM0dHR0cFltMjN3TEhMOVJOSTNOMklvOUlU?=
 =?utf-8?B?THpncklhMm80SVFVem5pZVV1aDFRSEVTdVV5N2xPMkxkeTNHU0lYS1lJSVUv?=
 =?utf-8?B?N3lhL2IxUXRNa2pYMWljQ1dCUHZEaWlrMENCWTllMURHd3FYUzBkUDhQSW9D?=
 =?utf-8?B?ZS9aUEZtZllTYnJLOHMyaTZLK1pHS0FTUlRjdFk0K053K2paaUhQenZhb2Rw?=
 =?utf-8?B?T2lYQlZpeUpmNlZ5cnZSdkZiL0RJWWs5ZjVCTnBVSi9xRFZKY0xpVGNzNWVy?=
 =?utf-8?B?VllhclYyUTNPUFp6cXBEMjhUdTFNNVVjQzlhUXB4dzY5MEQvUDJ3YTRtS0dT?=
 =?utf-8?B?a00vdGFiUTRQZWxsaHBscFVnaHNPU3Rhak51S3RQL2ViN3Mra1JVdTUyOHJX?=
 =?utf-8?B?V3VxMmhNejFjYTZkeW1IQkx4SkZkV3luRFZyWWxtU3Q4aHE0Q3ZBUU1TMEMz?=
 =?utf-8?B?a1RSRXRZV01wS1h2N1NTZytqMmV5WnR0NkxycnR0T09qWGlYQkNsdDduWmZ5?=
 =?utf-8?Q?AgPy/d17cOBqTvxvGLuHkC2uk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f82fd14-42cc-436e-3c9d-08db7608eaff
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 05:48:07.8926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXOFLzBhORRexMX92nieAgueVNeErH35rI/2chGIpuf3PUAxqN/q6d2NyB74lJQrtFz0gUoUZ2O3nbVHDhFOhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7028
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.2023 18:42, Zhang Shurong wrote:
> --- a/drivers/usb/host/xen-hcd.c
> +++ b/drivers/usb/host/xen-hcd.c
> @@ -456,6 +456,8 @@ static int xenhcd_hub_control(struct usb_hcd *hcd, __u16 typeReq, __u16 wValue,
>  			info->ports[wIndex - 1].c_connection = false;
>  			fallthrough;
>  		default:
> +			if (wValue >= 32)
> +				goto error;
>  			info->ports[wIndex - 1].status &= ~(1 << wValue);

Even 31 is out of bounds (as in: UB) as long as it's 1 here rather
than 1u.

Jan
