Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C708069463C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBMMrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjBMMrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:47:16 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65C819694;
        Mon, 13 Feb 2023 04:47:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLyEnYyO0NFwd8lBxhbT4eS6X808N8z4iAzAKW07nfXgUoMQobULmD/OVOns1J97AtP7sI7w7I7kd9fIW/mSq3XToEN+lJgtbUsYA9ZqA+0av4j3xjBII/OSpJVEQlxBCGSOGoElM0eo/tP+KBgCz01PoaU1f1QqnwF91ROAR8V36Ow9Qo8z5YRgk9j3WLjCVipLSEYhNIbmzCT7SCEWEECwuzPRqF4qhnnyk55FBa4Y9Kpi0XYBRFGRc/IdSwEFcPO8HX5Y8QcdW8OEBMa1RhgDv2ulMPHj+2LpV76Y/qWTYtj9KRqdAFBWYVpHSU3QEXbDNgOdY0FQH0Y7ew30Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGLAf8iJMoQE67TAqFNgpab5P60ExU+ESL/3P3+kgJc=;
 b=Z3f+TkcqmrJeP/qEF2Mziy1VwaNZV3ba7zT+lokR2ISsqVBXMr5Xc3PNt43QOWhBDYVZdohKCYdtPtjodLIj4vA/NUAOkYh6/XPIitz3i6+kOKdZF6kLirvVFAJNnti+S1IIHr3RiqySx8Aa/AmLtz6xvFG7JU6hXu9cU0bKPsO0BeJKyuVdgHZZwkrLeqeEveegbhi4r5GiPzF+daON7ZcRSuI+5f1WLIHRG3chkIWChlSrCWC3LE1vHaOAAI6KfaR5f3ugb7U1Nf9YNHkVrMi5lExlpPRBkOwIpIADKQUvn/WSKfwNgOj00193tbjjMg8w9ChigJsu3oakB9OTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGLAf8iJMoQE67TAqFNgpab5P60ExU+ESL/3P3+kgJc=;
 b=R3F8r/H+s/Utw+hh3Mrv0u7VtxjliUWzWChFsn5S349CNFnY/iR27tbFlGdJ0Cg8QjXBgGQ1Z+uJw7mMaytOdtiLQrNUIsneihh7pkSo2R1mNwV5U6FbWrM0dDP729dp55ZmGt2m0XvRLwMXZhgyck0PGRU0DBfHIRcUvo3DKeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 12:47:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6086.022; Mon, 13 Feb 2023
 12:47:01 +0000
Message-ID: <292dfc99-b625-9ae1-408d-b38448552341@oss.nxp.com>
Date:   Mon, 13 Feb 2023 20:46:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] clk: imx: set imx_clk_gpr_mux_ops storage-class-specifier
 to static
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, abelvesa@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230205030138.1723614-1-trix@redhat.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230205030138.1723614-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: f91bcf4d-68a4-468d-088c-08db0dc066bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTGoZwqNj6ruMEyOo0Uu9XnhzXxWNUh2OPiZD+5RfxVX6nJUMhru1HJJr8KNh7+FkTWGJ77omN+wXCH5eVVCMYOW4wfajbEOILVKCwFs2F+i1AAzfjNeaW+U3C0urROuamA8ED5xP1jZlMPBK2ympX4CG+kXpLBKnfUlkedTeAEGiQpM/i7hbQ6bMhVvbb5DfimX7tbVSKoEdhHE1hr3wX4Qp1vB1naEWCRLJ98LJuCDA/nG5xnosmghf5bAWcYEL70T+0CH8ShGF3CUUqpiuwHEQkkctQ2PvWbHcfsRVJluow64NSN1V0986dhX7RdB1HAqLxVK88Y6DarAfu36ME0genTKdtVwbFyiQeNN0XIVJjqQP2g0AXn4BqDRG99bNqH3TdID65RgfaVI3KYmD7S+RJ/FskJWP8/QXZVmHFHwoHWU9uNoC6xryOgXNdZfArygWlmAR31HHbUu4VDBGGJ9NIudrr53YxNh+RKtQoxVJXIYzNifJyFdiAzP2IWXrVTRmqEqCs7D4jUU2sP6mWJJavM7J7ldi3XhL+Qj5oGTeUfAGBsqQDp7+1t+FkeDNh81f22x/g23hVQ19uq8tT9kU5EaC5kJfx6h1roHSWCTpbveDlTsNYK+VA1kVEmgd8+ymB9zAzy9qhC2NfF1mhZMSIjNm+kyG5MSI+h/f8LyXSW7E3DyF1IrC+aJGHx8DjIcEdMGpZqsdY0UVdx9daO+y7g0iUfpF5Zk0epoYkE6rnN0ATvApEcFvp8IsvbLajS/4HP00rWWXRVyp8OC3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199018)(31686004)(86362001)(31696002)(2906002)(7416002)(5660300002)(8936002)(44832011)(41300700001)(38350700002)(38100700002)(83380400001)(52116002)(6486002)(478600001)(8676002)(6512007)(26005)(186003)(4326008)(316002)(66476007)(66556008)(2616005)(6506007)(53546011)(6666004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlU5TVpacEM3M1l2aDRERnRIRzdiNlU2a1pzTHZrOGhmZ0JQRmVaWXlobmw2?=
 =?utf-8?B?ei9JdHB1dFpuM0NURlRHVDk3b0xBZmJBeVRUeU1peXFFRWEySmVuc1pXbEhX?=
 =?utf-8?B?aFFoVURxZ2w1RXowekZLeXFSN0RxT0xaaVNJTUVCYnVheE0vUlJ6NEVSTHBH?=
 =?utf-8?B?RHQyWUVSd0lSeGJEakZDM0p1Y1MrazlBSG1SR1BnL3VnTFF2RUwxR1FKd3oy?=
 =?utf-8?B?WDB5Tllkd21jVVVRT2VIL2RGdE8vWC9zOEJ5NStESEFKYjIzZGhiOXVpeS9O?=
 =?utf-8?B?a3JMQm1INENwaGxRWkNDaVgwMnJuOG1YZXlLUVg2UHY1cGtvV1hQUmwxZnZq?=
 =?utf-8?B?Vmp6UStQUkV2YzFBL3BMd2t2QnBZemU2OXBUeWpRZzJPaHllRW15ZWFXTFBp?=
 =?utf-8?B?V3BQQnhVeWdlZmtzSWpvd1lwcFI3anJEWGIrK0lMYXhJWFpsRGNyRi9OcVNa?=
 =?utf-8?B?eVNNcUZjOFFDSTJMK09JM2J4c0N1SVViemw1MUdvVjJtVTlFaFpIUm5HWWY0?=
 =?utf-8?B?bUVjdGhkTnFvOEtTN01OS2hvTFFrRjNTNmRoRzhyWHMveUFHRWRWdGovNGlB?=
 =?utf-8?B?Y3hSWHhxYWJHZy96TG84QjR2S1lsaFVSdVE0UnlzSEZrVlFtNlAyUDAwcXJU?=
 =?utf-8?B?UHgrbHY0ZmNwY21IbjV4T1BGTXpib1hLdmVGaWUxbkFnVUMyUS81Z0dYcDFw?=
 =?utf-8?B?Z0ZYdW83K3pUbElSeFpVZ2RVaE1hN3RLSy9Tei8zUVBVRzB5Y0FBWm93OFJj?=
 =?utf-8?B?YmYyRTNXTnZLMTRzVkEvelhFcFZzSXhIVldvZEZXd2RDcDluRnNYWkNwOXdM?=
 =?utf-8?B?RXhHMXJtVmpLamlEQTRsZmpGN1lvd2dPNWJJSy9sVURGTEdmbFRXUnczd0Ry?=
 =?utf-8?B?UUlOS25qSVcwcGJMTTBlQ3BGQ0JzT2lOV2dud2JNdGwrbmFqdzMxbkp2U1Rp?=
 =?utf-8?B?Vyt1VG1vVVZDQzNLZkVsSG5EdExlWUY3Mm5GQ3A3cHMzM3BnOStYTlE2alRT?=
 =?utf-8?B?ZElXL1Z3QWJhbk44QmJRSmdvalhaZHFaWi9YOWxjbFZDbGRVV1lUWEl6U2Qv?=
 =?utf-8?B?b3E3MExUSlBlZWtHaE5MR0lHZy9kSE5MUFp6ZVZwZGtjR1J4TTV3NHF5MEpM?=
 =?utf-8?B?UUJQY01TdVdSUGgzV0pYNkRoZzZySTd0bWUvd3pyWmpxQkVUb0hHV1hkQWd2?=
 =?utf-8?B?SUh3aldNb29IMlV5WC9CMms0REFXSDZwUjkrd1lEZ0Via0RKYWR1aktEUlRS?=
 =?utf-8?B?M2ptejhiT0xRSERzVUZEZkpmL3V3QVcwTzJ2bmd5TEVtQk1UTFYzR1Q5dHdk?=
 =?utf-8?B?ck04UCsxaWJQNWNZWVNjV0lvSEQrT00yR3RxQThOd1FKZlREMTExQTdtbUIy?=
 =?utf-8?B?YkthN25TQnJtZ3NKaXlGUUhNc0N5d1VXTGljODVtSnNEZDVLMkxheGs4UkIr?=
 =?utf-8?B?L1haUjRLQ0hLNWpHaFBMalV3Z2ppYlJXOXNEVmdrWHQxUG1SQ3RHSzlINkZK?=
 =?utf-8?B?QkRLdDR1VWk0UmdrWTh3bkM2eFN2VEx5V0FWT2V3Sk53eDVxSmErTC9JSlI5?=
 =?utf-8?B?QTJiMzlTd2QyS1JKRUo0TElDb2xwN0s1NVkrQTBZRXorRWd2YldrS1ZTZXFi?=
 =?utf-8?B?Ti93VnJvYkVHZS9leGpUbkNRaDJKV3RZbnZBcmp6UDZuaHlxNExqR3NsVEpp?=
 =?utf-8?B?VXF6S3lycDNhNU1XZUVJNk14N200eXhkN2k2WU9CZVh6WUFibytlTnN3S29R?=
 =?utf-8?B?TW9VMTR1ZUJRM2N5L0EyVDdSMnRVSGtyTmR2SnRzRjFFN3cvalRNSTAvdW85?=
 =?utf-8?B?NmJha1ZCR3VBaUxETk1ucjRZZi9PTk9vZTBhU2VseUtTZC80TXdzaUhsS2Nt?=
 =?utf-8?B?LzhsY283a3dYV212WDR0V0tiVm1hZ3ZzSkVkRUttSWhrV1pVN3Aza0VzSzBM?=
 =?utf-8?B?S1B4aFg5VEZybHlOVFc4RDhFR1REMm5xQjJLVEtaQnlwTkNJUm43Y1N4SEZL?=
 =?utf-8?B?dmpJQXNhQTU3NGlncjZDR0RSemtVZllCRDhyMXNnd3RtaGY0ZDU1SHVYYTk4?=
 =?utf-8?B?L1FPSDBBWWhQSVlZWFFSYTkydUZyT0FzQ2VrV3U2OG51MTV3S016bmQrSXpl?=
 =?utf-8?Q?pATkiZn/v5+KgbuD09YUooOH/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91bcf4d-68a4-468d-088c-08db0dc066bf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 12:47:01.4859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0o0ObjRfICUgYNy83X9fqQpxMZh8zJSlRZO4mfSIieZ77M0i2J17mqwRSJi8CL+igTrzNuKsb0HHtzLpSI6Omg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7245
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/2023 11:01 AM, Tom Rix wrote:
> smatch reports
> drivers/clk/imx/clk-gpr-mux.c:73:22: warning: symbol 'imx_clk_gpr_mux_ops' was not declared. Should it be static?
> 
> imx_clk_gpr_mux_ops is only used in clk-gpr-mux.c, so it should be static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>   drivers/clk/imx/clk-gpr-mux.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-gpr-mux.c b/drivers/clk/imx/clk-gpr-mux.c
> index 47a3e3cdcc82..c8d6090f15d6 100644
> --- a/drivers/clk/imx/clk-gpr-mux.c
> +++ b/drivers/clk/imx/clk-gpr-mux.c
> @@ -70,7 +70,7 @@ static int imx_clk_gpr_mux_determine_rate(struct clk_hw *hw,
>   	return clk_mux_determine_rate_flags(hw, req, 0);
>   }
>   
> -const struct clk_ops imx_clk_gpr_mux_ops = {
> +static const struct clk_ops imx_clk_gpr_mux_ops = {
>   	.get_parent = imx_clk_gpr_mux_get_parent,
>   	.set_parent = imx_clk_gpr_mux_set_parent,
>   	.determine_rate = imx_clk_gpr_mux_determine_rate,
