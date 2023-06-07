Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF72A72525C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 05:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbjFGDUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 23:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjFGDUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 23:20:12 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CBD1715
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 20:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGw3mfcsK5fLFrgD/32IVz1/eszVxTBCFxdJ6TZHiaiwdOva6XYCOvBdA4eWD2UzjcTYxJMj9letMDS4dbGdJr2vhFZJb9mqVZbxkBbE+bhBTdwOaLIDjo5DvVJzGSGbOgL0UA9A27iXiCgJDZDyyiiCpskzoHw6biLrFMhVkjYJ7yFP+7pbUrrhgM4hsHYofGk0zK5Ia3fQj2JqRMvYTPVgL8fv8OeHrxVp5uWNrHdqjWsm6vNCnYqHQ6N5kzMZwqmEY5rq13muDp2uwvTyvzFa0JYfzwxjnoXPaqi32SRkvNKGWR0TT9sJvNix5VOPT/UEXyXpU7IHIhhsKjRucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxwXggWhPh5S9PIHlj/Dr6Fd0/XrbLevkZp4zHBoTTw=;
 b=MFNgrdeMSHRFCfnQ39A8r97IQlgrWRseTJRskH1RSr7GwC8LjqwWhOel5o7g9t0CgY3a2kE+Y1+Adl8G00/SBP1kuHluwXzgXg+Yab8qAV46jPZkV5asL6i5Z60zhaLtG7+Ldl6IZD67WWupOsjWglrwJ4Z7mrAvrcGzIRPNZeQNB4pfwOCKAzLrXP9mMJUgk/cT1PKKaOX2GINj+WzkXizxnZclYAol6pjQpEQUrtyZoM3s5f0R+5gn5XrfdGME9J2lJWDX80TDmpUqS09fFyK8ul1x2nx0NNJpE/P51g6SxHM+ZYko7FcVZIaSq56wLh+Imk7b6HOf3bOH/HNvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxwXggWhPh5S9PIHlj/Dr6Fd0/XrbLevkZp4zHBoTTw=;
 b=zjywv+G2tDARDwxFMSTZ9nWPrzxDpjYPrU2dGQKPXI2M8jw9wB3RLCRRKTP+7UUGoJPOWwEFNMTxNh7Xhi63FPq2EnUHkUCQ61M3cxWiwe5kxCMdXYRaGZxf5CcEm6h01nHf15jzYx1SDl6g36kSYwQ+JbecFIw2HI0mTslcDdKWHjZoPbZ4ujyQhlKh1nJyHmBdkwuN+L8nlxiNmyfoXxMFjKHaLTsiyKUI1ziUVamo3LqZ2auTllvEAFT5cp+SjD0+PjfSMjRFfgnQXa3k6iBts96HQDzR9nsTdqNiFiiA8SE9Ac7NFt4r60PkLTjvMT08QggsaVbmcc0g+vU/hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SEYPR03MB7479.apcprd03.prod.outlook.com (2603:1096:101:146::13)
 by SI2PR03MB6566.apcprd03.prod.outlook.com (2603:1096:4:1e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Wed, 7 Jun
 2023 03:19:16 +0000
Received: from SEYPR03MB7479.apcprd03.prod.outlook.com
 ([fe80::45d7:8926:3640:a9a3]) by SEYPR03MB7479.apcprd03.prod.outlook.com
 ([fe80::45d7:8926:3640:a9a3%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 03:19:16 +0000
Message-ID: <da140679-4a4b-4f90-b0b0-6397f8b1d450@amlogic.com>
Date:   Wed, 7 Jun 2023 11:18:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] mtd: rawnand: meson: waiting w/o wired ready/busy pin
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230606195128.83432-1-AVKrasnov@sberdevices.ru>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20230606195128.83432-1-AVKrasnov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0002.jpnprd01.prod.outlook.com (2603:1096:405::14)
 To SEYPR03MB7479.apcprd03.prod.outlook.com (2603:1096:101:146::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR03MB7479:EE_|SI2PR03MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 5157191e-4cc8-478f-433b-08db6705f9a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oC/vrNL9i35l2FId4g7ZRW18tTr6dzmxjv1W75v5hMPbV57JBM/7axLbj5VTpKIJ5+znAFIkt0e/0E1lszzfZn7hi3waLrjnSPyufwXMQPbxHrh7pFU89m9kH3HSu7htq2tlJ7X93zMPic5mYBTll2ekMu6yvjh7ErQhFzR5+UoTOI7ieE/VTItWdjW0vWdJ4x8lXXyTPXy4sq4De+AlVEjXUqjeFg6zbQ1byUhpDDPHDZv0eNDC2/vIo9Q71j8cequhvdP3JofZKzxSiwxV3dCAGeQnzak+WscmDLWLJ0EPRgvUqaxayHYvrcuqavF916i0Ode5nUNc1TJ8vEEqrWORBkLr32Y03aTon1VOEiRF2Zclgc+EOhDxKGKgATfih1vucQNvfXvdKimTwyPpNkirGwpzXd8ijvfGQ1rI/jnB009uyXeVcU62Ds6JX0LTrivhEZutaVVRFsblYSo388gOMshHL+20AmL5Eu/cUnO3ovU0TRSm/BafYnTFE+abUMLF6A99ZmGneRIm3Ymvt2zncz4GsJ9BkMm0ssi8lIaQPIVa42VWe0zs7ZDmCqJTifoYRahK1J7vyLpZFGXB0+8OX3kRrA6srThQr0jintOZ5V4E1AO4wdFxM8ikwss+a/AXmvdI91Hc82/gamB2Jv65eYuRQUPZsPPcZxuWHrcKW4w2C1GzwtaOOk2dH6fO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7479.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39850400004)(136003)(366004)(346002)(451199021)(36756003)(31696002)(86362001)(6512007)(41300700001)(6486002)(52116002)(38100700002)(38350700002)(478600001)(110136005)(66946007)(2616005)(66476007)(4326008)(316002)(6666004)(83380400001)(26005)(31686004)(53546011)(7416002)(44832011)(186003)(6506007)(2906002)(66556008)(8936002)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUJNUWZqWmZVSTRWbWZXUmVneTNKQmNWREhaaFlTU1Z6Z3VBSUpMN2VQMk94?=
 =?utf-8?B?amI5U2lFZVMvdUh2SysvQkxTWWI3N1JiRjRTb1FEcC9DdW5NRzlNckRUZURK?=
 =?utf-8?B?UlUwUjV5ZkhMLzZ0UlRJMWJyWk9CQ0syN2NMNWM5YnhPQlFYazVVejZnOGV1?=
 =?utf-8?B?UTBlZkRtMlhOL3haVmw2QTlzNlFOdExJL0x6SXdENjlGSHk3bUJQckV6MGZ0?=
 =?utf-8?B?MlZqTUpWRkYvNXJwVGpVUmVVNUpZaW9HTk1zY01oZmI4ajJSNHZiclBSNUd2?=
 =?utf-8?B?UE50THo2S21lNXRGelVjNWs2N0J1dEZxS3F3VjFwbXZkdVZlVTI0aTVoVXBy?=
 =?utf-8?B?K21Wd0liVE1xUTZxMWVqd2hsVXk0RmREVlpwSDZ4VFAxNXFYQjVKNHJ4VWcv?=
 =?utf-8?B?VllqUWd0WThYeUNRWFZJU293bTRrSEhpWlhSYUhWVy9xdmFoN09EQ1FKanlC?=
 =?utf-8?B?Y3pVTW5NZFM4UDRDcEF4REcwSHM5YWIweE1ENk82NC9USzExNjRnWjVhRHRD?=
 =?utf-8?B?WDY2SXkxMTdrSnVSZ1BrbVVWRTNtaERjVjliL3UvclZjVDE3T1NnaTA3Sk05?=
 =?utf-8?B?RWZNbDNsUHlrSDQ4ckhlZHJ4UVkyb1Z1dXR3bFVMVUNyR0J1Z1UwSGJxcTRj?=
 =?utf-8?B?S0szWVVNVitrRXdHTHpKaVR5SU52Y1AxNWJxbE00b2JuRk9oaUdqd0xhdndl?=
 =?utf-8?B?QjB0N20wYkZPYmk1c0tDcTNLREV1clVwcXB5MlhFMUhmRjdVU3djeGZERVBs?=
 =?utf-8?B?S1ZTR3oxckthUFFEUjJLMk1FbFhBMy9ycHlnZ3EwVjh4L002RXNFbU1pTFlr?=
 =?utf-8?B?UXk5SExYUmdKU3pyRHlYSlpsMEpBaFZVZ2RsN3hKRkpPTyttdmx1UkY3SlNE?=
 =?utf-8?B?aXRTeW9wbkdLdGl2VUR5UUEzek5mMzdnSU5qTXdWczNQNXB0WmpyRFNDdjBv?=
 =?utf-8?B?M2IxMUpsS3lIcWdKS2NpRGhVZHI3dW9PcWJzQVQ4VHdJMnZaVHdLanZCYjJN?=
 =?utf-8?B?WXRBRXFacVBVYlByaWNOMkpjVFZRMHNFQXRPV1BoeDVWQWNuQmpqeWd0cFUy?=
 =?utf-8?B?MXVIUzVTMGcveU90Sm9zdHVIVXY3Z3duRjM5cERJakZ5a292TUlSbDdDRVl5?=
 =?utf-8?B?L1ZNcUdYb0gzeFhqR3ROTzBVWlVETHNTRlBKTUVKUG8rUHczM1g3WVd5S2Ju?=
 =?utf-8?B?Y3dRWUlCaXFTY3RNZHVoS2dWK0lQVVhBVEhUa2FZbkdpUDNuaTJ5TXBaVHcy?=
 =?utf-8?B?RlRQUzN3QXZrSnNraVJ3Mk9ENjdpcm41Y0JMNUpweUs5cG85NlMvRmVmMXlw?=
 =?utf-8?B?YUlSSjVadnFWa01FeXJPZCtFMWh4TmNlNm5qczlhNHdFejF6NzFHUWlJSGcr?=
 =?utf-8?B?bU8xWC8rVmxqTmF2dkVaVCtHUHg1WlJpNDhqcXFtRk9RUXNuOWNlZ2dKTXla?=
 =?utf-8?B?L0RHck5SWnpSek1VQXNISzEzQ05jeERpc1pWNzJQYmlFZEMwSFBXdnNKNVNQ?=
 =?utf-8?B?dGtmNkhoT2pWRlZwSExUZzdzelpaSnJrODRLZ1l6d0E1cThDUGlTTE90NWxS?=
 =?utf-8?B?T08zMWZDcnpZalIzdFR4NzhKZTE5ZEZVM0tQeVNZUjN2S3lKNGFvWklIeUwy?=
 =?utf-8?B?WlVrUmZoRWZOd1NUUnpqMEwzTXcwNGkzU0V5ZmM3c1pOaE1VZkR5OC9qamN1?=
 =?utf-8?B?c0ZmaitYeE9OcEFBOXpWVWNWUm91ZHVKcjZLcHI0cGpFbnJGM3R4UVlJbXdL?=
 =?utf-8?B?OWpNNHBnNHlOR3V6RWsvaG1uVXR5cGpqTGs4aVArcFhBRVdhOThkdHpOQWs3?=
 =?utf-8?B?a3hncjYvdWttMFdEcHFUS3VtM2FFaTI0NVJvMFV1enVwS2ZEMDU3MFRmSTdx?=
 =?utf-8?B?c0h5bE94MWcyeENSOFRhMVdkMXA5cms4VFFnVGFIOTZuYVFzbXg2aGF3SEt0?=
 =?utf-8?B?WFNLZWM5NnNzQUluTXdzRnpZM0VRcStEOFFaQlRIMFlvcGpiaWt0YXlnSUNP?=
 =?utf-8?B?MHZaTHZPZ1dOQmp6N1QrTE9MOTJEZTV4c3VvUlNyTmc2USthUjBjYkRUR1FO?=
 =?utf-8?B?ZVE5RjNuWHhZWnRvV0dLVGxlVzJUb2hIQ3A4UVNEWGlHMVJIRUVoWjkxVjJV?=
 =?utf-8?Q?6+RYvDJeGnchvmo6fckTdfMfR?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5157191e-4cc8-478f-433b-08db6705f9a3
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7479.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 03:19:16.5250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCrVjcLyiF28RdPkNNZvAJorIstmVMeqqMyblhvVgpzy/HbPIYGFzFAh4sCjfapZ1nHTyWiBRYXAeoq0rWO6jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6566
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

On 2023/6/7 3:51, Arseniy Krasnov wrote:
> [ EXTERNAL EMAIL ]
> 
> If there is no wired ready/busy pin, classic way to wait for command
> completion is to use function 'nand_soft_waitrdy()'. Meson NAND has
> special command which allows to wait for NAND_STATUS_READY bit without
> reading status in a software loop (as 'nand_soft_waitrdy()' does). To
> use it send this command along with NAND_CMD_STATUS, then wait for an
> interrupt, and after interrupt send NAND_CMD_READ0. So this feature
> allows to use interrupt driven waiting without wired ready/busy pin.
> 
> Suggested-by: Liang Yang <liang.yang@amlogic.com>
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>   drivers/mtd/nand/raw/meson_nand.c | 58 ++++++++++++++++++++++++++++++-
>   1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index 074e14225c06..f4c5309a9527 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -38,6 +38,7 @@
>   #define NFC_CMD_SCRAMBLER_DISABLE      0
>   #define NFC_CMD_SHORTMODE_DISABLE      0
>   #define NFC_CMD_RB_INT         BIT(14)
> +#define NFC_CMD_RB_INT_NO_PIN  ((0xb << 10) | BIT(18) | BIT(16))
> 
>   #define NFC_CMD_GET_SIZE(x)    (((x) >> 22) & GENMASK(4, 0))
> 
> @@ -94,6 +95,7 @@
> 
>   /* nand flash controller delay 3 ns */
>   #define NFC_DEFAULT_DELAY      3000
> +#define NFC_NO_RB_PIN_DELAY    5
> 
>   #define ROW_ADDER(page, index) (((page) >> (8 * (index))) & 0xff)
>   #define MAX_CYCLE_ADDRS                5
> @@ -179,6 +181,7 @@ struct meson_nfc {
>          u32 info_bytes;
> 
>          unsigned long assigned_cs;
> +       bool no_rb_pin;
>   };
> 
>   enum {
> @@ -392,7 +395,41 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
>          }
>   }
> 
> -static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
> +static int meson_nfc_wait_no_rb_pin(struct meson_nfc *nfc, int timeout_ms)
> +{
> +       u32 cmd, cfg;
> +
> +       meson_nfc_cmd_idle(nfc, nfc->timing.twb);
> +       meson_nfc_drain_cmd(nfc);
> +       meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
> +
> +       cfg = readl(nfc->reg_base + NFC_REG_CFG);
> +       cfg |= NFC_RB_IRQ_EN;
> +       writel(cfg, nfc->reg_base + NFC_REG_CFG);
> +
> +       reinit_completion(&nfc->completion);
> +       cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
> +       writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +       meson_nfc_cmd_idle(nfc, NFC_NO_RB_PIN_DELAY);
> +
> +       /* use the max erase time as the maximum clock for waiting R/B */
> +       cmd = NFC_CMD_RB | NFC_CMD_RB_INT_NO_PIN | nfc->timing.tbers_max;
> +       writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +       meson_nfc_cmd_idle(nfc, NFC_NO_RB_PIN_DELAY);
> +
> +       if (!wait_for_completion_timeout(&nfc->completion,
> +                                        msecs_to_jiffies(timeout_ms)))
> +               return -ETIMEDOUT;
> +
> +       cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_READ0;

NAND_CMD_READ0 should only be needed for reading operation, so we need 
skip the other operations here, such as programming and erase.

> +       writel(cmd, nfc->reg_base + NFC_REG_CMD);
> +       meson_nfc_drain_cmd(nfc);
> +       meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
> +
> +       return 0;
> +}
> +
> +static int meson_nfc_wait_rb_pin(struct meson_nfc *nfc, int timeout_ms)
>   {
>          u32 cmd, cfg;
>          int ret = 0;
> @@ -420,6 +457,23 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>          return ret;
>   }
> 
> +static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
> +{
> +       if (nfc->no_rb_pin) {
> +               /* This mode is used when there is no wired R/B pin.
> +                * It works like 'nand_soft_waitrdy()', but instead of
> +                * polling NAND_CMD_STATUS bit in the software loop,
> +                * it will wait for interrupt - controllers checks IO
> +                * bus and when it detects NAND_CMD_STATUS on it, it
> +                * raises interrupt. After interrupt, NAND_CMD_READ0 is
> +                * sent as terminator of the ready waiting procedure.
> +                */
> +               return meson_nfc_wait_no_rb_pin(nfc, timeout_ms);
> +       } else {
> +               return meson_nfc_wait_rb_pin(nfc, timeout_ms);
> +       }
> +}
> +
>   static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
>   {
>          struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
> @@ -1412,6 +1466,8 @@ static int meson_nfc_probe(struct platform_device *pdev)
>                  return ret;
>          }
> 
> +       nfc->no_rb_pin = !of_property_read_bool(dev->of_node, "nand-rb");
> +
>          writel(0, nfc->reg_base + NFC_REG_CFG);
>          ret = devm_request_irq(dev, irq, meson_nfc_irq, 0, dev_name(dev), nfc);
>          if (ret) {
> --
> 2.35.0
> 
