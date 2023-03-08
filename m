Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109076B0677
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCHL4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCHL4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:56:40 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669A11E9D0;
        Wed,  8 Mar 2023 03:56:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDRvvFkmvJecgJzrO2crTykWkh014nx8i4AD/h4ssYaDcFDbZ5s1iQPCzgQUf2K/XMQ3Sn8aW9mBGx/gNXEUQiRh9P3fnnO4NxhlbuST6siCojlqfx5uSr1kwzo1YF4QuDLYtRZP1eAyGXlqcRDX7vsh69gTiqHW71sFiRfz9afNhcToUcKbGfX3UZ3vNAM/qxPlaNCvqp19luo5MPhKr4C3ccGPEEZh9L0K1teOlDy9yIRxsJ/ZqzwgAXc1PwjXTG7xLtyIkdVyUXi5eMSUyDEgVjUt0BO2CTEyCfdAI4AsAG2tSE+si6S+TRchJAMAB0FuNkbgcZWmJ3fg+bR06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OUYZXpYc9RO8g8Ys2h+o0DQGK6XI8H5QfsgYWFNP6Y=;
 b=d/yrMP1ppzfMGH32Cz2/YV4xEcu4bLjq9M4OLrNLsbsAAAiICNsRkmeJFxI0HMjdpZU913N9kOqOLOUynRcUa/2hKgd4azJ+iFSAiydymybzm0wrQ5bsxaRQUPVXYp79Glcr/v2Z85Oeqi1jyrXKvFd0cgcmUZx9Y1CtiER5DHqkd5E6bSQ7QWSMO4pu7qS1uvud2FrTQIDUlIfpM5kDFt6850oEKvW/Vk4JnqezUCfG4mRpTFUtAYmtp1dJ354zxUQZKb7oJq8XwzLXH7iA0CDyPfOeqN8dkkQntDqkCutVMRG/Y7EkDHSkQPHPCZ6fS4Yh/VvbgTbIh3MAY2ZZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OUYZXpYc9RO8g8Ys2h+o0DQGK6XI8H5QfsgYWFNP6Y=;
 b=T2uj3GgmlOxCgNhw7BvyKKXEZIgtVTfMky5K3JB+u8wjx+Bn2n7V9R3Zl9jzN3U1PSBWMI0M75fBOIuLc445oueDPhyev70tSJwhbUohMsYhb6VC6WyTNDSzJR4tJxprCuyag3fnkRSWoHVOfuBmB0O4JQfb57OrcQhpDVEELxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 11:56:37 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603%5]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 11:56:37 +0000
Message-ID: <2ff43c4e-da17-bf76-720c-710af174834b@amd.com>
Date:   Wed, 8 Mar 2023 12:56:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 3/5] mailbox: zynqmp: fix typo in IPI documentation
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, jaswinder.singh@linaro.org,
        ben.levinsky@amd.com, shubhrajyoti.datta@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20230228210216.447373-1-tanmay.shah@amd.com>
 <20230228210216.447373-4-tanmay.shah@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230228210216.447373-4-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0048.eurprd03.prod.outlook.com
 (2603:10a6:803:118::37) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MW4PR12MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f66fb3-c03c-417f-0d14-08db1fcc2b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t1I8kOD4+ogtjm7Brin+zH2kyAAX9u3fQlAOL4A+MwYRrezlTxvB+qaUmF6VKXx/aUa0Y8WccYwZVU6ncNx9SMA0UnG0g2ngk/O9pvNRxKA6XgwoPR9NYS3an7S8qFoKKUfBLGC74ls7PKmVOpK45wxlyiNPTUym3gaBnnAX16dPfeL4IXLwuxzNwPMNH9MDDO1YDc7tEDuT34wuzphzOjUmmJYbIrTBa6Ss6Z/J7uhSdUYgqnjkiaTFw4q17ua80G8bfeEs7Sb6WmGBiqujGJfwocXXZrXsF1EBm2r1vKShIxiZUN0rABQNkyf4bj/4EZtaTIt0o6sL18DjmCrSM6T8ByLIUlhp2pDupgj16eFLWwYl1VuLlbRKXAPwR0mJeOXwwaBUVnAoSvEo+MayE8aKymDFMqWmOLpTzdlD7X0AND+TyPlWKkWZ4clIAnLtO8Y03vb1hD8jZdGhKacZqU1W5BfHqncfMH99ho2eECP9mZIpCA/IS8tqPKczHtDAOc/aPYrMxvQTd1G7ktaWn5rkTv1qNLcKzUML25qs6AGt8lYZPjvKOovI2/TxkLSNPs+zCzjEWfi54G9QzJUGGidwoOqKoG/l+QmOOQOTlQQ0di111ldLf/qNFn14i3oHRcv87tb+leQpzjAb3tWkFCjWetXI/EZrLZSZs9Sk0sYIF+M8wSgKcwNio9A6BirCsYH88tJaQytrrJsipHYgPYH3L35MHKxNHufpjE2Zndg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199018)(36756003)(26005)(83380400001)(6506007)(53546011)(2616005)(41300700001)(186003)(15650500001)(6512007)(5660300002)(6666004)(6486002)(8936002)(66946007)(31696002)(66556008)(4326008)(8676002)(86362001)(2906002)(4744005)(66476007)(44832011)(316002)(6636002)(478600001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGlYWis4ek1RMEFQbW0wdmRRV1VTVG45T3VRN1Y4eHhMK1hvRmxmdi9Ma2RV?=
 =?utf-8?B?c1VHWEhGS3E0d2h1RHkwbWZqSk5ZMzNoVlZ0REFmcnFnbFN0RXNkV2JRVTdz?=
 =?utf-8?B?ejhkOFd0ZXdtcCtYbmZQSTNic08rRzFvdkZZdEh5eWxUczhzWkNxYU0vc2JR?=
 =?utf-8?B?Q0hzdFZHUXRoeTA5aXBaSWhzLzBiYlNCaGpMTnMzYW5yU2NSM2tPckp2Z0kv?=
 =?utf-8?B?bTJxSm9WWUZxd1gvK2M4MnJiM2FZeUZEUHd1V21jcWQ1Y0FCR1ZJSmQ2bDdZ?=
 =?utf-8?B?ZmExb0o0Sk1sd3JpZGdTc0xCTkp6aDZJSVEzTDRYQjNWUVhENTVZVVpOZGRT?=
 =?utf-8?B?Vzk0Z0tLUElrOUdnYzFWU1JKaUlGcThWR1VML29XYmpROFBRZVJXNnYrSkNs?=
 =?utf-8?B?WVAvOFZwTUhycjUvbTJqTW5aMWFlVFFVM1ZoM011Mi9EcFdFT3I3L3g2SjZW?=
 =?utf-8?B?MGNrQXhyQ2gwNC9UK0o3bmhxTGZtQ2hkRTNNNEkvMks4Q1c1MHgzQW8yYnB2?=
 =?utf-8?B?RURvSVR1M3VPYWNtYXNKM3NyQ1crcjZkVXpkTk55NHBPMGdvL1RMOGNwTmV0?=
 =?utf-8?B?OU95TTN1Tnh6UXUwMDlMUUQ1MU51UHo5OTN5eVNobFpndFIwTFZVeXlDT3BG?=
 =?utf-8?B?TnJJSFFPbG50TlcvRWNtVkxPL0ZYalZyY09oc28wNmtmeEVWOEMyTjlNVTFv?=
 =?utf-8?B?aiszRFl2U0Y3OGtEeWhySjM0VDAzODVrU2xQc3hyaklqN1BDUnIyWjhYZ3JF?=
 =?utf-8?B?L09DaGQwUUhLNWwvMzlKNGRLeGdpUWVHS2VpbW0zcFNwWDhNeXh0cWdoVWlE?=
 =?utf-8?B?bWQwTEh1cjBKMEpNK1JrN3JVWndwSTdFTitmcEhzNjljRnppK1JjbUNpelho?=
 =?utf-8?B?UU1BTXp4TVkzTWhST3hWaXdPdEJtQzVIdjhkU2hTUlN5MDgwMnpjdkE2QVdw?=
 =?utf-8?B?RUdlZHJNbVVNejBpWmhYUlJxN21XaWc1TTFmUEVwdXJ6a041ZWpFYTV4TjVU?=
 =?utf-8?B?VXdBTzk2VEQ0TktFaXRLbmc2bFFNNkFlL2lZcWx0YkhhOEVqMUlNRStyMXRp?=
 =?utf-8?B?S2dNU1p0NEJHOFdTWFVORDN0M3FWMmtVenc4eGsvMU1uaHhtRDN3T1hLTVd5?=
 =?utf-8?B?Tk9yMWdvOE9YR3JUZWtFeEpuSzl2aUtVOExVKzZOMDFIT3ZUSmo1dGhvQXla?=
 =?utf-8?B?TXpRWmMrc1BUVTMzWEFUelVXbktDVHpqMDF6NmVibWhYcnFGR09iczdKRFJR?=
 =?utf-8?B?YTlIQXBjaE8rbTlJaFdOaTExMk1mSElzQ1lLU2lob2dSYm9PdWpQTElmZ0pP?=
 =?utf-8?B?VzBTWFYzWEU3UEs3SzRmMU9aS2h5bWxBWFkvY1hGQnNmVFBTSGdHNTNYSkQ2?=
 =?utf-8?B?cFc5c3RaemNpakxhRlRWZ1dqNDFMb290ZmlyZ01PT1BYNE51QWJBeGJYTEpr?=
 =?utf-8?B?SThXUStlUGFEZTJENkJEckhLOFEzbXE1V1Y1YjVJQU9VNWFRcDU5ekg4Rnlu?=
 =?utf-8?B?dGM5NndRMFVrUGd0dTVaRVBzcXpybkJaWDgwUytxUzY4RTBVcnY3T3daT1Y0?=
 =?utf-8?B?ZS9kU05KdTlEd3d6cENOMEhXbUdSQzhCbzVWempzV3Zxc215U2pLSmcwZHF4?=
 =?utf-8?B?NkZaa3FBYVNpZzJnempldUVvVVVuZWVKKytJRzBQRFhnK0xNSHAxUU10YzQ3?=
 =?utf-8?B?ZGdaUC9FK2RSRnBTcmlxRndkVWhQSjBkMmg4SG0vdlVsb01CNEdjaHFKQmJL?=
 =?utf-8?B?T1ZlMUVxd0YvcU0wY2x1YlhTTFJFMW1DRm5pWEtkZVpYZE9vb0E2dlZYRTRZ?=
 =?utf-8?B?R2tIWTl4MXBtbWg0V0pHSmhreWQ1Q0Q3TmNhN0ZBclE2NlMxTWtCUUlOZzlZ?=
 =?utf-8?B?UCs0RXlTblRwTGZ0TTMveWI4cTUrR1NMTkhORFRha3FkZ0htRTRFWnI4VkM1?=
 =?utf-8?B?Z0w0V2tVS00va1QrL2NlbjJTSWRCbW5UekNHdFVTc0VBMVNaM0xrT1pFSDhp?=
 =?utf-8?B?WWxPV0RvT0NtUGR0OFJ4cGJpTG5WdSszVGVLZEZvQ3JnOTZsWmZFUTFzWi9T?=
 =?utf-8?B?T3RiWEJmaGZ5TUNoemY2U3EvL0dSL0pxckxmeTNBNG1DaHNSb3o0Z0NmV2FX?=
 =?utf-8?Q?S0r7rDL6AFPe+0eNUDDBq/Wu1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f66fb3-c03c-417f-0d14-08db1fcc2b9b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 11:56:37.1084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOjhI0LQuteryopuajlV+NI30SPKDURrgxxx0yX/NcOwGCnoHWRUcT7A2lbKoUAb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6683
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/23 22:02, Tanmay Shah wrote:
> Xilinx IPI message buffers allows 32-byte data transfer.
> Fix documentation that says 12 bytes
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>   include/linux/mailbox/zynqmp-ipi-message.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mailbox/zynqmp-ipi-message.h b/include/linux/mailbox/zynqmp-ipi-message.h
> index 35ce84c8ca02..31d8046d945e 100644
> --- a/include/linux/mailbox/zynqmp-ipi-message.h
> +++ b/include/linux/mailbox/zynqmp-ipi-message.h
> @@ -9,7 +9,7 @@
>    * @data: message payload
>    *
>    * This is the structure for data used in mbox_send_message
> - * the maximum length of data buffer is fixed to 12 bytes.
> + * the maximum length of data buffer is fixed to 32 bytes.
>    * Client is supposed to be aware of this.
>    */
>   struct zynqmp_ipi_message {

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
