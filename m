Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F23072788F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjFHHTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbjFHHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:18:58 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20709.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::709])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ABE137
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gy9FiIFR7ZBFxO7sstJJ/wHdz313QUcSb5Y8LIupH1DkW3VmETxnOKW22aooj0VGbyxnmbE0OZRt4EVQtHBYWH9KRRL7nn7dpgj56ThRs/91GClUTRK1fHnIxKmlcfKfvplKClth8SvTfIIAV8guetyLK5yVdHKiF9RAcXRQeEtzCHin25+dnZwTspcEe+UyFLzQUrtwH+HjD8T00chzV03qM32GOKnjC2LA9WHlu/n+SPIiJCQYPUbgYVJnR5D3eSqnxoyaZqRxmKcUBX711xZt4PPoC0G2t51vbeHlUYM3UZWK7XBH3BDmsFgTr7AWPZi+yRgcxANzCosVXyLm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C619iUY2qgeP44Cun/GJ4rPEsog6x1kr/kOEwF7ijH8=;
 b=nddV3hwyZXwneONTCuY/8+6TsCrgqpQmH3XBnSw4VS+oeFdmhgO80ugnnuhJrg/vLlqZS4u49aq3JJP4LWnyImFrbDitcWAZtn5leCDuYrU8fqZewlOGvKfxjr7aDiFlNhMFX09dQoXyyD10rNP6rZUhRgh0fbjgCPK45qwu7IwFNEOsxEkFBuxCBVSqHPYAQ3XRkRjOhc1F3Ia/EM8iSDugGXdgO/+wl/fAS1/fIQAcBeMIy0rkW5DtWMrJgBsqKz7xuxMY2QIjBOHbvn6MLhlqwrul51c6jaIFSyoW/JKKdQMaFiB4c8lO8CC2R+3HIMVDtdF1leg5cUxfwWVkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C619iUY2qgeP44Cun/GJ4rPEsog6x1kr/kOEwF7ijH8=;
 b=Gk4OvmlZyhYKkkca6UX5XwwOxz4D5Ljv1mkHMdLfJXzRNAxIBrc8PgWFlg3EdnRtkfyHwTH13ih5pPCKy/NHPHYoMa6y0xzTt96P/UY77BFXn0Sdj0CbJ6W9lkLzTDaIfqVc5k7nOi19IGYEB2mcSgXo6V55urUc2XpEC5bMiwUT18trl9lmR3VcQTRXH5NACux11rB+CO0BaJ7r1Sug97YX5jl4qCIHwVVywMHKzCLlCGfcPoHt41EOld2gA7QKABmnQhKefF/B8oAFACFGs/VRSHFUn3Iws6eyFjbcizefb2EpG7gB+Ta2F5ePBpqN4LweHaBZnM16UrAY2zwy8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com (2603:1096:990:9::6) by
 SI2PR03MB6806.apcprd03.prod.outlook.com (2603:1096:4:1ed::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Thu, 8 Jun 2023 07:12:35 +0000
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::5e9e:bcd4:e9d8:548a]) by JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::5e9e:bcd4:e9d8:548a%6]) with mapi id 15.20.6455.028; Thu, 8 Jun 2023
 07:12:35 +0000
Message-ID: <4e6cd8a8-f618-4bc3-5fa9-eab2b501dd89@amlogic.com>
Date:   Thu, 8 Jun 2023 15:12:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] mtd: rawnand: meson: check buffer length
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230606101644.3297859-1-AVKrasnov@sberdevices.ru>
 <9adef6da-5930-dcaa-f148-e4a398d39f2d@sberdevices.ru>
 <3a9470ed-d7ad-6cae-0d58-732399590272@sberdevices.ru>
 <7903580d-685c-14e6-5572-81a4cb31cced@amlogic.com>
 <20230608085458.449a24c0@xps-13>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20230608085458.449a24c0@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::6) To JH0PR03MB7495.apcprd03.prod.outlook.com
 (2603:1096:990:9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7495:EE_|SI2PR03MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: b9819c12-b9f2-4950-73cc-08db67efbc04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GL4hGLLoBryJlAyiYzwBFDkzaBoMuuqRc+d8G5TdAUtc/c0bN0c8k/XE5m0TJfNf1B9oCWiQ1dIThYcTYMGG6j1u4pH9UCDWoA8wKwF4czlfdqwiBmzyaeLBfck5+DXWSQwpz4/oKIr2Pu8uLxVYEQUeuNILd1X0yciLk7iPko/GeFoKYPk7UkMUs9MLqX+F5IION2rKwOsRrbC/YrPq67aYaB7vRRyEOI6t2azU2JDJUuyB3NOSiaDm646xxILpFADomTyrJ268iEuPQVWKcpGm+YR0FPhKci3N9ZIQWvmXb9O7ymieEIiFiY6T2NYn+6fFADsyRGL0Gq2ne80OiIfrtWjYx4IgNqwlKu8u3Io/yvQwYznRGWqanmz2HN3ybkp2Nf8DzzTTRsAXXH5FAdGlOn2u4JWqRbMfeIRbn3mWAD73rQ/zGp351avij8FskiRXM6ESZhgY/Lovmw8/FD7glEW41IvVa0mRQnpSKgop0EmHZh2GyzjBYLteLcyJGIkLobzrvNZRZ9kQSlaRIhgCwFmrqBOHmwK9SQ3O1/czX/fcuXT0XgiaqAaUBI80H9cXOEAJCZOXb80Xb+T+xrvP+cZwm8cNPHD3MLhZwjG0kjPcoTCPYCDWbE2jfU8VrIb+j5llvPmo8v0ni3Xpfnzasr+U1KzmPa3wAqDKHy++TczBtdv2zakPduICIDjA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7495.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(376002)(136003)(366004)(346002)(451199021)(2906002)(44832011)(36756003)(38350700002)(38100700002)(31696002)(54906003)(6486002)(66476007)(478600001)(6666004)(8936002)(7416002)(316002)(4326008)(52116002)(41300700001)(66946007)(83380400001)(6916009)(66574015)(2616005)(66556008)(8676002)(6512007)(86362001)(26005)(6506007)(53546011)(186003)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVd1aTd6V211NkRRa2ExcnJVV3YzaGVNcU1HMFVwTWNjenMrd2Y1RFoyT290?=
 =?utf-8?B?TXlmenoxWWUyeWpUcmZteEhDNkxFc0lmMFlpeXp3Sk5TZ3dFUjhndkR3aVAy?=
 =?utf-8?B?V2JyNnlaVy9meUQvMEVBbTVUSVNuT25aL2NCZjNkSTkyQk9VdkFWdm5kdThH?=
 =?utf-8?B?MUU2VTMrSnNLMVYwbkozR2h1aHlkRU03R3RucDl2YkpaTTVhd2VwclNyMllj?=
 =?utf-8?B?TENCaVJWZFNpYng0Z2hvVEovdDhrZ1ovSHZNRFlMOFRRS29md1FNNWR3ck5Z?=
 =?utf-8?B?dHZBQy94TG5MRzRDUDYrTVkwd2VyRUxEQnhScXRlb3ozaFprZ2ZnbkIwM0Nw?=
 =?utf-8?B?NXBHU3RtMkdyMk5Udkp2Z05lNml6VXMzYWVMTHg0clZzQ2g2NS91Qjd3Z3NB?=
 =?utf-8?B?aS9aTGQzYnpVd2pXOEFjUWEycCs2UnpjUFFwSVVXYnRxV0k0YnRjTFhaUm9a?=
 =?utf-8?B?OVZSYmZrbVRydm5YSkRaQUZZK2krWWxNOWZhTE1mZDFrdXdZcHV6SXdyN3BG?=
 =?utf-8?B?WWplY0J3REg1MnZ0YVVtVUZtSjZCM1hoVFVKR1JYRGJxMXFTUFNKOHQvOTVC?=
 =?utf-8?B?bklwZzBqOHMzMmZpNW5YMkxpbVhGeTA1RVdmR2hOWm83emh6YTF0SnBubXdN?=
 =?utf-8?B?QWJuYi9JOVJ0RGtVb1BDMEZSa1ljSVVCL2cxSFZnUFFpSE5GWUIwTHJKNFIz?=
 =?utf-8?B?czAzQ0NqYjBBNHNuUmVxN2dtWUN5QU9udTYyWXE4c1BoOGY0MzJvSUFSb2Yv?=
 =?utf-8?B?SHNFUUVHWTB6SHZWZGpIeDZBK3VYcmNrUVIycEhMbkZRSDhiY3FjZm5oWXB0?=
 =?utf-8?B?dkV6enRZQzRaeG1LaXc0K1RhaTBJKzBCVk9NbHhzUytmc1Rnck51RFl5YlRy?=
 =?utf-8?B?WTVIRTZaRmREdjEvanRyaWJTa1B2M3Q4djQvZktsWG1wMFJHUTk4cjFvTTFo?=
 =?utf-8?B?dTc2dXZyNFRaRFlxWmsrallMVjVrQmxyT0hPbGhPOXlMSm1MS0FRWkRac2dD?=
 =?utf-8?B?MTloWW53NGx4NVRQdmxlOTdxM2JVQ0ZhUlNZdzh6Mkc4cHE4QktQeEV2eWox?=
 =?utf-8?B?cXUwSnM2TDJ4dGJhWlAxK01IWTVEeGZETFBqeXRXZU1jSXlmMkFrbnFPam90?=
 =?utf-8?B?MFUxN1J4NWxNU2phZ2o0OHlOMTBPVExhTmhVU1NnbWhOQXhNQ2REOUw5YnJ1?=
 =?utf-8?B?UlpyN0V2bnl4ejdXeHJIUUJTcnFTTEZYd3VLZzhJU1Y4bVYxUU5hTllUU2xv?=
 =?utf-8?B?aHp0eDRhRFdlNHF0d3I5VzhOajdkUDFBUVJrTkpkMEEwZ0tIWmw1TmVCTXFo?=
 =?utf-8?B?dmc0V1U1NDhDUll0ZDM5NTVTVXpJVEpQc3FBbDFIYlNiSUoxWWVlS2NFdnVu?=
 =?utf-8?B?ZDllOHc4ZEN4cWRZaUFlS28xb0pHNkErdlBSMXB5NitqUmVUNThVS3p2SDNT?=
 =?utf-8?B?VnNqSEJuRytOU0graEl4ZStxT3F1YnlPbDUyTkFtK0ppS2FtZ2pSck9MNHVW?=
 =?utf-8?B?QSsvaFlGbUd5QnZQclJ4N0w5dzlaZTNPRHZ2Y1Vxb0VnNGJ5aTB4SzJnS1hC?=
 =?utf-8?B?alZGMTZzRnJOTm02cHViRHpoRUxJSmFZRXFtMzgwSUhWTGRoRDZRalcrTHM1?=
 =?utf-8?B?cWhoeE5kK3pGMDZ1V3B2aG0vSm5yM05tYjlvMXlsYmdnVWZWSzF6aUxGMjk4?=
 =?utf-8?B?MlRmYnNKd3JvTWNUTkNaWDc4Ri9XbW05NGU3MWdnN1dvN2U0R0xHcHZSZDZa?=
 =?utf-8?B?SDlvdlZmYkdLeno1UTJhKy80dTJCbzhXckRac25pM2h1VGtMMnRWWjl4WWt5?=
 =?utf-8?B?S0hKMnZPQXJNMWt3akhpQVk5OERaNUFZOUJ2ZzUxVHJ4OFhBVDg3UUlhKzh6?=
 =?utf-8?B?N3dGdmVGN0E3bTFLK3AyRFQ5cnhUS3lFeUMyaTBiR21TQkJEZ2tLUDlYRlkr?=
 =?utf-8?B?TE9UdkVwTnQwWUFnZnJqNmY1WndxWGVKNndYcSs1a1dqa2dCMnoyczUzSHBv?=
 =?utf-8?B?SnVlTnNWWUg4bFFaREQ3aDBrR1JmenJYY3BNc3JScHlUTHUwelBYVjdReHZN?=
 =?utf-8?B?QTBLc2NpZUhnYWJTQmtVT0NsRkVkWkMyNmlhZGs4QXNsZ3NvRC8xcG5LYWE1?=
 =?utf-8?Q?vPGivmLVCdDIz/K1U8B4yYHwQ?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9819c12-b9f2-4950-73cc-08db67efbc04
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7495.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 07:12:35.4370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8FENwHFER1y/ttPolZzPFE1dHc54DPx7U0OYqjk85jRKSPscb0g0kXhiVCflTgtu/TyE88oWT3tgf7xlh2pNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6806
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 2023/6/8 14:54, Miquel Raynal wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi Liang,
> 
> liang.yang@amlogic.com wrote on Thu, 8 Jun 2023 14:42:53 +0800:
> 
>> Hi Arseniy,
>>
>> On 2023/6/8 5:17, Arseniy Krasnov wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hi again Miquel, Liang!
>>>
>>> What do You think about this patch?
>>>
>>> Thanks, Arseniy
>>>
>>> On 06.06.2023 19:29, Arseniy Krasnov wrote:
>>>> Sorry, here is changelog:
>>>> v1 -> v2:
>>>> * Move checks from 'switch/case' which executes commands in 'meson_nfc_exec_op()' to a special
>>>>     separated function 'meson_nfc_check_op()' which is called before commands processing.
>>>>
>>>> On 06.06.2023 13:16, Arseniy Krasnov wrote:
>>>>> Meson NAND controller has limited buffer length, so check it before
>>>>> command execution to avoid length trim. Also check MTD write size on
>>>>> chip attach.
>>>>>
>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>> ---
>>>>>    drivers/mtd/nand/raw/meson_nand.c | 47 +++++++++++++++++++++++++++----
>>>>>    1 file changed, 42 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>>>> index 23a73268421b..db6b18753071 100644
>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>> @@ -111,6 +111,8 @@
>>>>>
>>>>>    #define PER_INFO_BYTE               8
>>>>>
>>>>> +#define NFC_CMD_RAW_LEN     GENMASK(13, 0)
>>>>> +
>>>>>    struct meson_nfc_nand_chip {
>>>>>        struct list_head node;
>>>>>        struct nand_chip nand;
>>>>> @@ -284,7 +286,7 @@ static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool dir,
>>>>>
>>>>>        if (raw) {
>>>>>                len = mtd->writesize + mtd->oobsize;
>>>>> -            cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
>>>>> +            cmd = len | scrambler | DMA_DIR(dir);
>>>>>                writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>
>> I think we could keep "& GENMASK(13, 0)". it is better here to indicate how many bits of length in this command and don't destory the command once we don't check the "len" outside of this function. or the code "if (len >  NFC_CMD_RAW_LEN)" is better to put inside this function nearly. Thanks.
> 
> It depends who calls this helper. If only used inside exec_op,write_page_raw() and read_page_raw() also call meson_nfc_cmd_access(), 
but i don't find where constrain the "len".

> it's not useful. If used outside, then if you want to clarify
> things you may want to use:
> 
> #define NFC_CMD_OP_LEN(cmd) FIELD_PREP(GENMASK(13, 0), (cmd))
> 
> This is by far my favorite construction. Could apply to many other
> fields, like DMA_DIR, scrambler, etc.
> 
>>>>>                return;
>>>>>        }
>>>>> @@ -573,7 +575,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
>>>>>        if (ret)
>>>>>                goto out;
>>>>>
>>>>> -    cmd = NFC_CMD_N2M | (len & GENMASK(13, 0));
>>>>> +    cmd = NFC_CMD_N2M | len;
>>>>>        writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>
>>>>>        meson_nfc_drain_cmd(nfc);
>>>>> @@ -597,7 +599,7 @@ static int meson_nfc_write_buf(struct nand_chip *nand, u8 *buf, int len)
>>>>>        if (ret)
>>>>>                return ret;
>>>>>
>>>>> -    cmd = NFC_CMD_M2N | (len & GENMASK(13, 0));
>>>>> +    cmd = NFC_CMD_M2N | len;
>>>>>        writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>
>>>>>        meson_nfc_drain_cmd(nfc);
>>>>> @@ -1007,6 +1009,31 @@ meson_nand_op_put_dma_safe_output_buf(const struct nand_op_instr *instr,
>>>>>                kfree(buf);
>>>>>    }
>>>>>
>>>>> +static int meson_nfc_check_op(struct nand_chip *chip,
>>>>> +                          const struct nand_operation *op)
>>>>> +{
>>>>> +    int op_id;
>>>>> +
>>>>> +    for (op_id = 0; op_id < op->ninstrs; op_id++) {
>>>>> +            const struct nand_op_instr *instr;
>>>>> +
>>>>> +            instr = &op->instrs[op_id];
>>>>> +
>>>>> +            switch (instr->type) {
>>>>> +            case NAND_OP_DATA_IN_INSTR:
>>>>> +            case NAND_OP_DATA_OUT_INSTR:
>>>>> +                    if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
>>>>> +                            return -ENOTSUPP;
>>>>> +
>>>>> +                    break;
>>>>> +            default:
>>>>> +                    break;
>>>>> +            }
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>    static int meson_nfc_exec_op(struct nand_chip *nand,
>>>>>                             const struct nand_operation *op, bool check_only)
>>>>>    {
>>>>> @@ -1015,10 +1042,12 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
>>>>>        const struct nand_op_instr *instr = NULL;
>>>>>        void *buf;
>>>>>        u32 op_id, delay_idle, cmd;
>>>>> +    int err;
>>>>>        int i;
>>>>>
>>>>> -    if (check_only)
>>>>> -            return 0;
>>>>> +    err = meson_nfc_check_op(nand, op);
>>>>> +    if (err || check_only)
>>>>> +            return err;
>>>>>
>>>>>        meson_nfc_select_chip(nand, op->cs);
>>>>>        for (op_id = 0; op_id < op->ninstrs; op_id++) {
>>>>> @@ -1293,6 +1322,7 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
>>>>>        struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>>>        struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>        int nsectors = mtd->writesize / 1024;
>>>>> +    int raw_writesize;
>>>>>        int ret;
>>>>>
>>>>>        if (!mtd->name) {
>>>>> @@ -1304,6 +1334,13 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
>>>>>                        return -ENOMEM;
>>>>>        }
>>>>>
>>>>> +    raw_writesize = mtd->writesize + mtd->oobsize;
>>>>> +    if (raw_writesize > NFC_CMD_RAW_LEN) {
>>>>> +            dev_err(nfc->dev, "too big write size in raw mode: %d > %ld\n",
>>>>> +                    raw_writesize, NFC_CMD_RAW_LEN);
>>>>> +            return -EINVAL;
>>>>> +    }
>>>>> +
>>>>>        if (nand->bbt_options & NAND_BBT_USE_FLASH)
>>>>>                nand->bbt_options |= NAND_BBT_NO_OOB;
>>>>>
> 
> 
> Thanks,
> Miquèl
