Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C76A7266DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjFGRMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjFGRMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:12:36 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2054.outbound.protection.outlook.com [40.107.14.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0187F1FE3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUB9uO2504ZuFAgEMbHYcFxLTE+vBq5D4Ra9vkVIwJDq0eC+JcbhylumJJUPTw8kfMu1uwh1HXHKjy8MH9oDIvg9H5XgvvhGFBHdbRcksvgekJXcLexU/wgQkgrvwL5gmnaPpbBpCOd6NhWeCs6fCD+kL8iJvZcz3ba709jki2L4myM33qaXxdDE3duYkgeuK2NapkIag24+3Bkvh+TxRV0DEjQRUihInh2FvaPpcQI12lPFrpEPZA56zi8HJ4sc8nipL0itfB8UtHMooFPnSrlx6mfdA2HgKk1BJfBZLLJNO3MyBMMVNsy12Di8rFzHRdPrifLLjXL+rFMTIdoUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+UDAByv9MpoW/WKgPdMJ7qiZlgfv6+07MthkLQtJS0=;
 b=SuPETJAni7SXKIiL03Wni7iUZBxDHNft2nTKebnoFIFibm5FkqBDD7tXY2Irey6nfBebNCgrM64V82a63xHZvNFiJjEJ9Ie7Sf6LuQ///McJ1l74TE0nUANzxXab6U5X1GhY4r7GL6NhtJGFSnSyEbZ4sdAo4vIo1dJE4lUv+DY/Vrf8TtrMVFx195DssQ9Qz3KoNy2NV7PfbgR6ofxuI898ceS9UdWme+54Zkg1spmTVHbQgP5WE027RTudDxxmtaiPi9JTyBivAC8l+44xssxQ/nxUtips3cDU2N4OIlWUCj6B9xjMtiUonWVH9iFtkgNpZ3wmt4Fk6/xB4XjEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+UDAByv9MpoW/WKgPdMJ7qiZlgfv6+07MthkLQtJS0=;
 b=Rs/VbrBJaoGksFRl63DTaomYrZD1K2v92SGNFmHcFTr4zZPUWNTW7jca+ChFy05A7LtI9brJWHCj+yMdZYWGQwmC4T9giJASnRhlw8sEOedw9e7SGR1kBv6oKiiyqMxOciGVHv+tFw9XTxQcvU1z9DGr7t8lI4vfO1QP99U/Vj9QrGythvOehwjtYAcNqEx1VdvSvYrn9a8QOUCKbJIsBBEf/4R4A+GjN/XNXVAH1Rbzj2kITzcnucCpDPS/VtUoZS70oqQ41cqGPWMaPPptUBVtOTBfmMcY8i7jPw3RPxUfAyuPAE4aUvD1/ak8YxnhSkNgh4yrOas1joFtunA3Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB8PR10MB3831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 17:12:28 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2d4a:d8d:d625:952c]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2d4a:d8d:d625:952c%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 17:12:28 +0000
Message-ID: <452472c5-ef30-ac30-6e4e-954f53b48315@siemens.com>
Date:   Wed, 7 Jun 2023 19:12:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tee: optee: Fix supplicant based device enumeration
Content-Language: en-US
To:     Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org
Cc:     jens.wiklander@linaro.org, arnd@linaro.org, ardb@kernel.org,
        jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
        masahisa.kojima@linaro.org, maxim.uvarov@linaro.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org
References: <20230607151435.92654-1-sumit.garg@linaro.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230607151435.92654-1-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::11) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB8PR10MB3831:EE_
X-MS-Office365-Filtering-Correlation-Id: c52288ae-eafb-4bd8-6999-08db677a5f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rh3jhhk3Xqu28Bnee+VRoDtFJSgsZbltfLgSRYyQS9acV0ohVWAkvTuKcyuKzF1uI6ppfC1qVIwMXH7Q7oggX/+M3KHPPGD8QglNArB51iGYNslDHKNjmTx1EXD5LvzaXkCINtviFC87m6FRhnV70GWo2OuMmWocEX/ZSy1hpKCEX795qbnDD5VrU5epckCdkgvletz7GSvQbTTZRX+GWEmnoqDZXmtQsPuPDiZgFvACzb3RXqFoOvMXmb2QPDqRevB5aR7EPklCFwx9XxgzhNS+NfwU2+agitNQSR5ZZtL/H2Zx07mggvJ4eSfXmMko+Bpe/dMzOLi7ECEJAAGhoSi3NCcBpr3CiCnmwczjzFeizFomFXmIFqbpoXehCsMhzzWTnVdAHWQU+23TiD0ORdNzMoZszAhT8BBlM9T6mo6EL65SFYzjUOuQ6rO5tLcNO/aVI+x74OFGcHvC30eK6osSBjBv9d3pPAnAhjzhUV8lDtqqx3ieuf5gdCcnEI4NwEeFxnDGVHS/nm2jcypj9oafcHjGW22tHl9I6ctD9rlSJQLR+gwxyimrvxgn65xd/cW/j374gRF0azQ0z0tpDpFMYsaG2Q4Bm6dEJ7EZRLfaoZM4Uf1LrzSowqWivtmYoojJ94PVaiyarekmBw96PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(53546011)(26005)(6512007)(6506007)(31686004)(2616005)(966005)(83380400001)(186003)(6666004)(2906002)(82960400001)(66946007)(66476007)(66556008)(6486002)(38100700002)(5660300002)(7416002)(8936002)(86362001)(8676002)(44832011)(36756003)(478600001)(31696002)(41300700001)(316002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDdCQmY3M3VkL3dmaUhrS3Z5SmI2c0oxVkFMYVJrUGJLV0pkN1hQTXFuV0ZM?=
 =?utf-8?B?M0QzOFM5SnRudFdsN1VnZWFPSWxJVFJjZkptOXpMMkE1eXYyaUtENWhxTjBS?=
 =?utf-8?B?cXNyK2E1T2pqODlPZDhBY0tKbjBuMTFEVUoyREhBb3pNKzk2K0l1cG54Szhs?=
 =?utf-8?B?OWFOZE5Gd1VNTTdCZGxqNndPaEU2MXlxQzFDVk5GRUx1em5kdWVhNDRlWjYv?=
 =?utf-8?B?ck0wVlljSHlUZk15SmFROU9nSTVpekpuZXdHVmY4dWFLQ0t1cjhzdDRSSS9q?=
 =?utf-8?B?UXJqR0hLMU0vdlBmRURpdjJlVDYyb1MxMmlYTXQxN1ZyYzIzRS9NYVJIbnRs?=
 =?utf-8?B?UXdpOGxkZG1qa2RWT3Z2SjJyckhoUlpNR25WL1RPNXdTb3hkVlAvUkxqaklj?=
 =?utf-8?B?RERQQnBaNG1Kc04zellCb0orcEJOUEZJWUxQakVJYndCZTczRmNuNXp6a0dL?=
 =?utf-8?B?K3Y1MmhaQ1F1bjBPOGhvektnd2VHQUMxOTJ0cm53NVZLNEdNMElpNWg3b3R5?=
 =?utf-8?B?OGovSWV1NG9RUURva0lhaENHQlRzQkw1YkhiSmY4SXByUyttRkU2UkYyU3dq?=
 =?utf-8?B?SmkvbDJKZFhZWHRsd3FtMENJMzE0R0JCL2VBam1QYmxPZ0NQcW5vbHFvQVJY?=
 =?utf-8?B?YnlNOHp5S005Y3Awd3N5QUtCdTJEUUJGc0gxS1JpSkNReXhoaE9uVVhteHJh?=
 =?utf-8?B?NWV5Qis2YWNhRW1Lelg3bkQzeWRabGc0N2NNOTVDcWQxL1VsZDBYSVM2NDRF?=
 =?utf-8?B?c0hvV2E2NFE1WmgyRFk4Slc1ditncEJsVzY5cDFjdWU4ckFaQ1FCaXFTMy8z?=
 =?utf-8?B?WDY4T0hTd1QvdlFZOXVzSGt1M3FUaDdIcTh4MEkxSHZmOWxNM0doZE5VeUxp?=
 =?utf-8?B?UFc5ZXFsNVRsaTR0K1Nlc2h0d0lybUdJV2g4Tld3dHdUc1VKVWhxVFBtR0U3?=
 =?utf-8?B?eWpXRm5heG0rejNublpBYzE0eFJMKzgrYjBnQjZRMUR6TUpoQ1g2QmZyQUty?=
 =?utf-8?B?SHY0NTkzQTJsV1lJc2ZmdFhFV3lMdDQ0eGZBTHJ3VS9obU0ySURVeE5jQXF3?=
 =?utf-8?B?SnIvZjJEZTVuZmp2eEZwWHA2bktRWFI3RXlPWThhYTRGdWZ3R3NhckhOMDVF?=
 =?utf-8?B?NjFyclRiSFJlM1U3Qit5NW5VVzMzN0JnOEhlUHdiWUk2UEI3SC9mSEJzeGJt?=
 =?utf-8?B?b0JZbVZUdU16L29DUEJtMldFZUExTWsrajE4WGNYMkFjSGMrOFpZOFBRc2Nv?=
 =?utf-8?B?elhsditkYitXUHA3d0ZmOHI1a3RGMDhETWZteUg0UEh3ZGhYaEtzUjZiZnlG?=
 =?utf-8?B?T00xNUhwRWhzdDlEK2JuclNLdWRzMUdYcFZzVjdQTkFLWEpNaWo3Y0VMRENS?=
 =?utf-8?B?aHowMWtlZmxhWWpoVVJveHlxbThtdXZMbkhGUXpZSzYwdld4UkoyaWw5QXNZ?=
 =?utf-8?B?anpTWmNkRlBVOEpyZnkwYWdMVnlrc0IzVDhyUlZWT0ZMT0V6Y3pzK2tpeVpn?=
 =?utf-8?B?Nk94RlBGdkc0SUFyK29IUzhYU0ZjL0M1Y1VFV3VlWXF0c3kzOEFaVW1yV0tv?=
 =?utf-8?B?WHozdkNQR2NwdFp0RktqcXQ2UEZOVzJrMjNJMm56eEk0aXZXd0pRS0dQSGF5?=
 =?utf-8?B?MVVrMytFYVJUcEo0cGxJOS9rbGNIUjQ2R1l0S0c4cmRPRFNHeEJYZzVsMW1B?=
 =?utf-8?B?TmZSWEJCVGF5R2l2WW84YlVKVnp2YWlFQ0EwTWw0MldwMHJFSmppeFhSNFpW?=
 =?utf-8?B?MVNsK0lkd3NDN0d2UGN4em9zMmdBdUxvelJBRk5aL3FTcXBLWG5OWlhocVZk?=
 =?utf-8?B?RmhuSzBMSFBMOXJTVjR6UU9ZREpzOGpGMHpFY05oZDRieWtDUEVRT3JyT1g1?=
 =?utf-8?B?cjJ5WEYzMVdnczROTU1yWlB3QUY3czMwbXU0U0E4SVU5bFU3dGNWOGNFSnYv?=
 =?utf-8?B?SWtsNG9tcUMvSDdoWWVvVUw4OGY1RUtScWZWOWJuTVNucUM1RWQyV3ZsdVJX?=
 =?utf-8?B?TkN5WFMrdUx3aHZweVUzaVozOTV3VFdQSlBpZTB4cURIVEErZ3lSV1U2ckR2?=
 =?utf-8?B?TjZTOWVRUTl3a2tHQmdoRjhweUJtSVhqTDZ1NVA0d1pkN0xxRmVvUUNOWW40?=
 =?utf-8?B?MXlrN0hTWHBuYzVnNmtQVmROM2hyWjNXU2gwRjE2T0RXa0RWZ1dTRUpWZmNW?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52288ae-eafb-4bd8-6999-08db677a5f5d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 17:12:28.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87tvyrC+g4eq49waptryZLeKy5ZTyJt22BssxbP4enlT2glJiFFL2tK60ajSV7O9AhC7ub51Rd3a6rx3boduVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3831
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.23 17:14, Sumit Garg wrote:
> Currently supplicant dependent optee device enumeration only registers
> devices whenever tee-supplicant is invoked for the first time. But it
> forgets to remove devices when tee-supplicant daemon stops running and
> closes its context gracefully. This leads to following splats for fTPM
> driver during reboot/shutdown:
> 
> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
> [   73.474497] ------------[ cut here ]------------
> [   73.479119] WARNING: CPU: 1 PID: 1 at drivers/char/tpm/tpm_ftpm_tee.c:135 ftpm_tee_tpm_op_send+0x200/0x25c
> <snip>
> [   73.539952] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> [   73.545946] pc : ftpm_tee_tpm_op_send+0x200/0x25c
> [   73.550640] lr : ftpm_tee_tpm_op_send+0x200/0x25c
> [   73.555331] sp : ffff80001129baa0
> [   73.558635] x29: ffff80001129baa0 x28: ffff00000646f000
> [   73.563938] x27: ffff8000110f7000 x26: 0000000000000016
> [   73.569241] x25: 0000000000000145 x24: ffff000005395000
> [   73.574544] x23: ffff0000065a7280 x22: ffff00000646f000
> [   73.579847] x21: ffff000006422080 x20: 000000000000000c
> [   73.585149] x19: 0000000000000000 x18: 0000000000000000
> [   73.590450] x17: 0000000000000000 x16: 0000000000000000
> [   73.595753] x15: 0000000000000030 x14: ffffffffffffffff
> [   73.601055] x13: ffff80001110e838 x12: 00000000000006d2
> [   73.606357] x11: 0000000000000246 x10: ffff800011166838
> [   73.611659] x9 : 00000000fffff000 x8 : ffff80001110e838
> [   73.616962] x7 : ffff800011166838 x6 : 0000000000000000
> [   73.622263] x5 : 0000000000000000 x4 : 0000000000000000
> [   73.627565] x3 : 0000000000000000 x2 : 0000000000000000
> [   73.632867] x1 : 0000000000000000 x0 : ffff0000000e8000
> [   73.638170] Call trace:
> [   73.640610]  ftpm_tee_tpm_op_send+0x200/0x25c
> [   73.644960]  tpm_transmit+0xc8/0x33c
> [   73.648528]  tpm_transmit_cmd+0x30/0xc0
> [   73.652353]  tpm2_shutdown+0xa4/0x100
> [   73.656007]  tpm_class_shutdown+0x60/0x90
> [   73.660009]  device_shutdown+0x138/0x330
> [   73.663926]  __do_sys_reboot+0x218/0x2a0
> [   73.667839]  __arm64_sys_reboot+0x24/0x30
> [   73.671842]  el0_svc_common.constprop.0+0x78/0x1c4
> [   73.676622]  do_el0_svc+0x24/0x8c
> [   73.679932]  el0_svc+0x14/0x20
> [   73.682978]  el0_sync_handler+0xb0/0xb4
> [   73.686806]  el0_sync+0x180/0x1c0
> 
> Fix this properly by removing supplicant dependent devices when the
> supplicant closes gracefully. While at it use the global system
> workqueue for OP-TEE bus scanning work rather than our own custom one.
> 
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Link: https://github.com/OP-TEE/optee_os/issues/6094
> Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/optee/core.c          | 26 +++++++++++---------------
>  drivers/tee/optee/device.c        | 27 ++++++++++++++++++++++++---
>  drivers/tee/optee/optee_private.h |  7 ++-----
>  3 files changed, 37 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index d01ca47f7bde..e0f2c9cb0073 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -15,7 +15,6 @@
>  #include <linux/string.h>
>  #include <linux/tee_drv.h>
>  #include <linux/types.h>
> -#include <linux/workqueue.h>
>  #include "optee_private.h"
>  
>  int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
> @@ -84,6 +83,11 @@ static void optee_bus_scan(struct work_struct *work)
>  	WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP));
>  }
>  
> +static void optee_bus_remove(struct work_struct *work)
> +{
> +	optee_unregister_supp_devices();
> +}
> +
>  int optee_open(struct tee_context *ctx, bool cap_memref_null)
>  {
>  	struct optee_context_data *ctxdata;
> @@ -108,16 +112,8 @@ int optee_open(struct tee_context *ctx, bool cap_memref_null)
>  			return -EBUSY;
>  		}
>  
> -		if (!optee->scan_bus_done) {
> -			INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
> -			optee->scan_bus_wq = create_workqueue("optee_bus_scan");
> -			if (!optee->scan_bus_wq) {
> -				kfree(ctxdata);
> -				return -ECHILD;
> -			}
> -			queue_work(optee->scan_bus_wq, &optee->scan_bus_work);
> -			optee->scan_bus_done = true;
> -		}
> +		INIT_WORK(&optee->scan_bus_work, optee_bus_scan);
> +		schedule_work(&optee->scan_bus_work);
>  	}
>  	mutex_init(&ctxdata->mutex);
>  	INIT_LIST_HEAD(&ctxdata->sess_list);
> @@ -159,10 +155,10 @@ void optee_release_supp(struct tee_context *ctx)
>  	struct optee *optee = tee_get_drvdata(ctx->teedev);
>  
>  	optee_release_helper(ctx, optee_close_session_helper);
> -	if (optee->scan_bus_wq) {
> -		destroy_workqueue(optee->scan_bus_wq);
> -		optee->scan_bus_wq = NULL;
> -	}
> +
> +	INIT_WORK(&optee->scan_bus_work, optee_bus_remove);
> +	schedule_work(&optee->scan_bus_work);
> +
>  	optee_supp_release(&optee->supp);
>  }
>  
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 64f0e047c23d..88e1c3feb15d 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -60,9 +60,10 @@ static void optee_release_device(struct device *dev)
>  	kfree(optee_device);
>  }
>  
> -static int optee_register_device(const uuid_t *device_uuid)
> +static int optee_register_device(const uuid_t *device_uuid, u32 func)
>  {
>  	struct tee_client_device *optee_device = NULL;
> +	const char *dev_name_fmt = NULL;
>  	int rc;
>  
>  	optee_device = kzalloc(sizeof(*optee_device), GFP_KERNEL);
> @@ -71,7 +72,13 @@ static int optee_register_device(const uuid_t *device_uuid)
>  
>  	optee_device->dev.bus = &tee_bus_type;
>  	optee_device->dev.release = optee_release_device;
> -	if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
> +
> +	if (func == PTA_CMD_GET_DEVICES_SUPP)
> +		dev_name_fmt = "optee-ta-supp-%pUb";
> +	else
> +		dev_name_fmt = "optee-ta-%pUb";
> +
> +	if (dev_set_name(&optee_device->dev, dev_name_fmt, device_uuid)) {
>  		kfree(optee_device);
>  		return -ENOMEM;
>  	}
> @@ -142,7 +149,7 @@ static int __optee_enumerate_devices(u32 func)
>  	num_devices = shm_size / sizeof(uuid_t);
>  
>  	for (idx = 0; idx < num_devices; idx++) {
> -		rc = optee_register_device(&device_uuid[idx]);
> +		rc = optee_register_device(&device_uuid[idx], func);
>  		if (rc)
>  			goto out_shm;
>  	}
> @@ -175,3 +182,17 @@ void optee_unregister_devices(void)
>  	bus_for_each_dev(&tee_bus_type, NULL, NULL,
>  			 __optee_unregister_device);
>  }
> +
> +static int __optee_unregister_supp_device(struct device *dev, void *data)
> +{
> +	if (!strncmp(dev_name(dev), "optee-ta-supp", strlen("optee-ta-supp")))
> +		device_unregister(dev);
> +
> +	return 0;
> +}
> +
> +void optee_unregister_supp_devices(void)
> +{
> +	bus_for_each_dev(&tee_bus_type, NULL, NULL,
> +			 __optee_unregister_supp_device);
> +}
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 6dcecb83c893..cb5eae6f797d 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -192,9 +192,7 @@ struct optee_ops {
>   * @supp:		supplicant synchronization struct for RPC to supplicant
>   * @pool:		shared memory pool
>   * @rpc_param_count:	If > 0 number of RPC parameters to make room for
> - * @scan_bus_done	flag if device registation was already done.
> - * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
> - * @scan_bus_work	workq to scan optee bus and register optee drivers
> + * @scan_bus_work	work to scan optee bus and register optee drivers
>   */
>  struct optee {
>  	struct tee_device *supp_teedev;
> @@ -211,8 +209,6 @@ struct optee {
>  	struct optee_supp supp;
>  	struct tee_shm_pool *pool;
>  	unsigned int rpc_param_count;
> -	bool   scan_bus_done;
> -	struct workqueue_struct *scan_bus_wq;
>  	struct work_struct scan_bus_work;
>  };
>  
> @@ -280,6 +276,7 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session);
>  #define PTA_CMD_GET_DEVICES_SUPP	0x1
>  int optee_enumerate_devices(u32 func);
>  void optee_unregister_devices(void);
> +void optee_unregister_supp_devices(void);
>  
>  int optee_pool_op_alloc_helper(struct tee_shm_pool *pool, struct tee_shm *shm,
>  			       size_t size, size_t align,

I had to backport to 5.10 to use this, but maybe this is still generic:

[  201.223833] Unregistered efivars operations
[  201.228081] Registered efivars operations
[  OK  ] Stopped TEE Supplicant.
E/TC:? 0 get_rpc_alloc_res:645 RPC allocation failed. Non-secure world result: ret=0xffff000c ret_origin=0x2
E/TC:? 0 get_rpc_alloc_res:645 RPC allocation failed. Non-secure world result: ret=0xffff000c ret_origin=0x2
E/TC:? 0 
E/TC:? 0 TA panicked with code 0xffff000c
E/LD:  Status of TA bc50d971-d4c9-42c4-82cb-343fb7f37896
E/LD:   arch: aarch64
E/LD:  region  0: va 0x40004000 pa 0x9ee1a000 size 0x002000 flags rw-s (ldelf)
E/LD:  region  1: va 0x40006000 pa 0x9ee1c000 size 0x008000 flags r-xs (ldelf)
E/LD:  region  2: va 0x4000e000 pa 0x9ee24000 size 0x001000 flags rw-s (ldelf)
E/LD:  region  3: va 0x4000f000 pa 0x9ee25000 size 0x004000 flags rw-s (ldelf)
[  OK  ] Stopped Modem Manager.
E/LD:  region  4: va 0x40013000 pa 0x9ee29000 size 0x001000 flags r--s
E/LD:  region  5: va 0x40014000 pa 0x9eeb0000 size 0x011000 flags rw-s (stack)
E/LD:  region  6: va 0x40025000 pa 0x8592e000 size 0x002000 flags rw-- (param)
E/LD:  region  7: va 0x4004d000 pa 0x00001000 size 0x067000 flags r-xs [0]
E/LD:  region  8: va 0x400b4000 pa 0x00068000 size 0x01f000 flags rw-s [0]
E/LD:   [0] bc50d971-d4c9-42c4-82cb-343fb7f37896 @ 0x4004d000
E/LD:  Call stack:
E/LD:   0x4008af50
E/LD:   0x4004dbb4
E/LD:   0x4004e238
E/LD:   0x4006cd5c
E/LD:   0x40086014
E/LD:   0x4004eae4
E/LD:   0x4009109c
E/LD:   0x400861c4
[  201.359311] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
[  201.367031] tpm tpm0: tpm_try_transmit: send(): error -53212

tpm_ftpm_tee was built into the kernel, I dropped the rmmod workaround.

If you suspect backporting issues, I need to look into getting upstream 
running again (it does on our board but it's not commonly tested yet due 
to some missing feature called Ethernet).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

