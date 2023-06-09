Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02686729220
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbjFIIDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbjFIIDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:03:00 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::701])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABB849F1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4Hpw5av8kFTjC1YdChEFfCeZtPlVvL6q8rlPa0hiQf6vMgZ8m1K9u5G3xDjqYzKGSWWdGhVdg//c3/MtPHuFHjm4uYoUoqHjjGp5faW9m4mFs4BleTE1v8M9lS2Kl0gZQEjkVwz8l/8njcpFYMSHy3ds/LTuGTVqvWabCt2YFwXTmXV4tCCTHvHH4N1i3QJeoMn5MKyzuOkYgBtxV6GTUfkWnSDFw2Rlp49+u1I8RLLFggSK8YZ/Bn1tOjvhHF/B/a999Ge7YkR+wyNhMdzHQONO6/XK5qDNFqXT3oMNgX4HhCBIXtrEsq669MWDwuSyYX/BghJbu/lwv8Y7by/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXIhlwnh1Kj1AiJrFPrM2nYo3nJa53jqQwZLVlGvO4Y=;
 b=L64eOgvDMbfiYmJHaYruAH0Jwuro9V54CUcnsKVxMq/qtbkxQw2hzIE7MFegPLlu39IsXNkPOvwu8vXxwqMJvrzjfgP1ce1ET9ECblIvlWIiAarvw1NF8oGKvPSQ2+pS0T9x1q/+B3UUcpDXg892n5BKMEsovH35lGADXzmYt8J92jgKZ2rfVnfscoSuVIFVSiB8++bJBrKmOCVGN8mf1/KDYqOpX/sy7HyI/lmwkoTzJJMSLjTiUd1JO35xu/vimhIJK357TN25XcHX/9psHd3Z0vPDktXc73/LaflpMpT2OqdxMeb+K1fbKrumQELWgBFLTQ4nyK7tJudcsV9eZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXIhlwnh1Kj1AiJrFPrM2nYo3nJa53jqQwZLVlGvO4Y=;
 b=UAIjCVUo+1asTCmkhIq0BSIEZDfzb7uZR3oS+3apP/7PZVk62zChkpC8JyfbG0NNbqWmGg/5Fv+HESq6sPzwFpoiz9U6mAA0hMcnbB91S66omGSnHL12W9ZIQx/GM9x3l321FPbEHH+OLvs3+fR5JaM1UhxvbuziwvKkk2UqrMEFxMhHc5XhjvkA+V2umhCPyA12pu2CG9JWxoWsYrin71ortIfZOaon9LTYFMmVSkmPJlJuiZThSL0i+pz02YRJD+/2eO1hbFBR01huis8b/T/BosNJuI0/I7ulYQvLSNPZAinSepO0Vi4C35w25BK2AUrMHHZIWlVA2h2DbV/puA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com (2603:1096:990:9::6) by
 SEZPR03MB6514.apcprd03.prod.outlook.com (2603:1096:101:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.19; Fri, 9 Jun 2023 07:59:59 +0000
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::5e9e:bcd4:e9d8:548a]) by JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::5e9e:bcd4:e9d8:548a%6]) with mapi id 15.20.6455.028; Fri, 9 Jun 2023
 07:59:59 +0000
Message-ID: <3cc9765c-f32a-fe8a-f7af-fb884ee63b48@amlogic.com>
Date:   Fri, 9 Jun 2023 15:59:26 +0800
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
 <4e6cd8a8-f618-4bc3-5fa9-eab2b501dd89@amlogic.com>
 <a6a20b50-02b0-53c0-1e65-75035bc59c87@amlogic.com>
 <20230608152114.3a1d82ac@xps-13>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20230608152114.3a1d82ac@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:405:1::26) To JH0PR03MB7495.apcprd03.prod.outlook.com
 (2603:1096:990:9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7495:EE_|SEZPR03MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 331946da-f834-4549-8f36-08db68bf8524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3zOBcIqUelVWRbIyEleDeK/eZQsOBOEmvtppirTuR9QIuHKOzcyZO4g/3ur1Cz4hzklzp8htvSpME6qB9Sx2aKYITiMmkFD8m+gYFHX1Xw4M1fpwy8CEa+4RbvJvx/T/K/Lc/VaY7iD6w3okJn3u4AtvLC7EHb0NM4RURglzngnBgPiYnwerX7s72pCSNsDCy8BZdFvyqLXIFPvOigL+d6RC6i1EqFbxq5jt2HO/Fd/oflKpXIa5K72uVe+ost3tZrO/KvAgbCX9+LAKRW5yYwhy+F2eStbFAhQtXUswCL8dkgfsHO72H890kO4KDrb/uiRfCRjee17rDv81FLMpsB4CRX0LWe7yKbjOS+dlNHyT1aQZsdZS/jeS136tZGFiBmMN8WBhEXK3wvHxLsUokR4M4MSQbYcIaxMNCYvbO07YKhle7xLTYOlPwrP6m+HWHDKbaEoUM7pjBhCmFeMWbro5i3B+KXef5fX7ovLD1XFjG8Ms3Uu6qJSsY42x9PM7jslo96Ahz1H1akwbo+8CuxEV+KXi/4EbPtqJYCOosCVcmagTWmANGFOJEINqj1TRexorBldKM75TMxHYosHJm0xxbwlCFDu8e/Sc1ZTyQdlhZ7Z75kVmxkMNjo/S5AwHx8fkQja5/+b4o+XYTd+8S3c1+iRmF7bQ4Kl+Wxw4B5Y1L5zTHA5aPSJiNrD751rIbWs01LogEM8ig/CuknLOwHIxz5xWwDL1yzH+sXuOrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7495.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(39850400004)(396003)(451199021)(83380400001)(7416002)(54906003)(316002)(5660300002)(8676002)(44832011)(8936002)(86362001)(4326008)(41300700001)(66946007)(66476007)(66556008)(6916009)(38350700002)(38100700002)(31696002)(66574015)(36756003)(6486002)(6666004)(2906002)(52116002)(478600001)(6512007)(53546011)(26005)(6506007)(2616005)(31686004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTdKYVdZd0s0a3pBczVuT0R0ZHVDenl5ems5VDZLWnlJK1RsWkZwR1NKTUxi?=
 =?utf-8?B?NWdGMElhWDBGRzRpSWdCWk1xZTBCMlNITG4xZ1AwTythY2lXaEhkVnNFcDBM?=
 =?utf-8?B?WW9RZDZyTVJqRGJrdUJ0SnZaWVBjVjJ1b3BhKzhtdnNKTkhUbUhSNzRKSzYr?=
 =?utf-8?B?Zkk2eWJ5ZkVlODZ4aHVZb2xZTFZ4TnVocWhGU3FxejZjMmlTYW5Eams4L0Vq?=
 =?utf-8?B?QXZTcUxkTHdSajFYaTBpR1RCSEpsMTJ1Nzc3NkxIL29OVjhtTXFpUisxLzlN?=
 =?utf-8?B?a0FnYTUxbmN3czZIZDJPZG1jSEY4S0oyVEErSnRITkxNb1dTbVg1aXdTS2hm?=
 =?utf-8?B?SVB6Mlo2dTBrbThnV3Z4cG16Y3FnWTRIcTBzNGUrQm1ib1FWVnZzOXVvajJJ?=
 =?utf-8?B?UmhDZUl4bGJlVFdlamRNOWFjaWM4TjE5YUIvbUtRcm5aQ0h4WFdXd1NLL1h4?=
 =?utf-8?B?LzF3SXgyc09EMFR2REFGUFVNZDE1QmFKaDRsZTMyR0gxUGpMcDlOZWFNZDdl?=
 =?utf-8?B?ZVFCRVdLSkY5K0pHVDdGN1NDRmtDRnB0Rm9Bd1lFQkUwZXZOdGk2UnJ2N3h0?=
 =?utf-8?B?a2x3OEd1Q1ZuRDRpK2lMZFVBSTAvaVdpK0xsbTVwdVRsN2EvS3p2cjJvdVFE?=
 =?utf-8?B?YkdLL3RGdzhSeEwwSVd0NDVFU3I0SzRjWUhSMEROeTkwclErZzJSV2FQczJ0?=
 =?utf-8?B?OVJaZXdvdUgvTmxiK1Q4SXNud1F4TG9CY1VNUVZGcXhVMWs0dWh2S2dJNk1T?=
 =?utf-8?B?S3pRQkRNU21yUG5sMlR1Qzlud3E5aWJNN3ZwcW9TVG81MU9GQmo5QUlIQWV2?=
 =?utf-8?B?eHh0bUpNVlpkc2l1YVE4cTliaytaR3dLemZ6YjVrQkxCM1RIWFlRN3dhYmY0?=
 =?utf-8?B?aVpMb2hJa1F6dktsUlVVV2N3L1J2TDBreHljVUNzVzAvekVpRy90eTlxMllF?=
 =?utf-8?B?Zk9KN2p2RXJEQ2tHYUNnUjVtTFFicUlhSDVwNlI2bEI3NmtuN2w2REtTUzUx?=
 =?utf-8?B?UlEyamJwVUo1MWRYS1dEWU5ndi9KZ2JvNkszMzBaRHRvU0NqTmw5U0lSaU42?=
 =?utf-8?B?RTZWSEZxYUJIZkkzUXEvTE1SQXNRRmxPN2VVejF0NnZTSHdodmo1NHRJc0RZ?=
 =?utf-8?B?TTFYa29jNmhxbEkzVmNxZTk2NHNGbzFXaDZ2aFAvUWpCa1FtbXlTOXNlTnlV?=
 =?utf-8?B?dkd3V3MxcGFCZVgrbWYxRTJ5cGMvbmhBNlQ5U1k5NmQ0cGU2WC9lbU9Tc3or?=
 =?utf-8?B?RmxnU0hmWTV3QnQzbHFkdlZyRFBxWlJDOTlmN2E5MGllL1QwNlBxeXMxQTZj?=
 =?utf-8?B?MEJLSDlHMUtVSVVvdUlZcUEreDZWdW5zYitIcVFTS2FOOTU4Q3JFSEtIMWpw?=
 =?utf-8?B?bm5LeFNOZjJLNmpNREZnektEaEhvbzQya3NmRHJoUDdoaWtBVXNYWkZPWjkv?=
 =?utf-8?B?bnk0WFV0b0FuMi9lRzNITklRWEduM2tUNVlBdnlzZDJVcXlHbXdSazdsSVBJ?=
 =?utf-8?B?V2xOUGl2ZExBVnZqODdQbG1OSm5LcHMvRmJwcnlFVlhnS0RieURaRnpiZ1FV?=
 =?utf-8?B?bm1pT2RGNm52YjdGVjNVZlFDbkF1NkdTMlVpU1BndHl5OXNWSUtEcElnNSt4?=
 =?utf-8?B?cTVQZU1nMEF2a0NZR2phLzlPdWxjVFl6d3g5ZHdjRnRlVUkveXJzQ2o4Qmgv?=
 =?utf-8?B?OFlLbGJ6Y0lKOUhwcEpvOEl2Q3NSLzJqYUN0RWNzeWFuTndvaHMxaXAwbVZo?=
 =?utf-8?B?T0ZDN3Q3djdZanhRNEVVbDIvQUNybityaWdaY2RSUFc0ZG1nalNsQldLdzNt?=
 =?utf-8?B?eWdmRXlxRGhLSE40ZlJhM1VKWXdUSzFhY1FNdWRPSXJuaXpiODd1MHFBZXR4?=
 =?utf-8?B?OEdtYmR2b2ZFaU9lcVVsL2R0ZFZDdXh4Qno0U01sWUdlb2JqYk9EUVl3NGJB?=
 =?utf-8?B?cDF1dGs1N2MrNVVYcjI1V2NWRWpoVXY0MHFhdFUwSlJMZ3greGZ0SUFTOGVj?=
 =?utf-8?B?eFIySmswUERqclZrd2NsbFlJR2dvYi9xOHYvaGhuS3ZSUGZ2bWNQSy9KMGY0?=
 =?utf-8?B?TG9KYWhvL0w5YVU5Qkg2L1ZycWhNY2FEZDFEQnUvRUxkRWlOQS9rQTFJdlJi?=
 =?utf-8?Q?mifbSAqSjBaF8/bqQunJZVfzR?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331946da-f834-4549-8f36-08db68bf8524
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7495.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 07:59:58.7053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQKo0v7d+Im847rbWaeusBRQQHdbqe2ikgsIMzow6jmcx90RYoJ8701T8K/6fAF4ktGbzO/3dDkThR/ZpWrn0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6514
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 2023/6/8 21:21, Miquel Raynal wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi Liang,
> 
> liang.yang@amlogic.com wrote on Thu, 8 Jun 2023 20:37:14 +0800:
> 
>> Hi Arseniy and Miquel,
>>
>> On 2023/6/8 15:12, Liang Yang wrote:
>>> Hi Miquel,
>>>
>>> On 2023/6/8 14:54, Miquel Raynal wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> Hi Liang,
>>>>
>>>> liang.yang@amlogic.com wrote on Thu, 8 Jun 2023 14:42:53 +0800:
>>>>
>>>>> Hi Arseniy,
>>>>>
>>>>> On 2023/6/8 5:17, Arseniy Krasnov wrote:
>>>>>> [ EXTERNAL EMAIL ]
>>>>>>
>>>>>> Hi again Miquel, Liang!
>>>>>>
>>>>>> What do You think about this patch?
>>>>>>
>>>>>> Thanks, Arseniy
>>>>>>
>>>>>> On 06.06.2023 19:29, Arseniy Krasnov wrote:
>>>>>>> Sorry, here is changelog:
>>>>>>> v1 -> v2:
>>>>>>> * Move checks from 'switch/case' which executes commands in >>>>> 'meson_nfc_exec_op()' to a special
>>>>>>>      separated function 'meson_nfc_check_op()' which is called >>>>> before commands processing.
>>>>>>>
>>>>>>> On 06.06.2023 13:16, Arseniy Krasnov wrote:
>>>>>>>> Meson NAND controller has limited buffer length, so check it before
>>>>>>>> command execution to avoid length trim. Also check MTD write size on
>>>>>>>> chip attach.
>>>>>>>>
>>>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>>>> ---
>>>>>>>>     drivers/mtd/nand/raw/meson_nand.c | 47 >>>>>> +++++++++++++++++++++++++++----
>>>>>>>>     1 file changed, 42 insertions(+), 5 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c >>>>>> b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> index 23a73268421b..db6b18753071 100644
>>>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>>>> @@ -111,6 +111,8 @@
>>>>>>>>
>>>>>>>>     #define PER_INFO_BYTE               8
>>>>>>>>
>>>>>>>> +#define NFC_CMD_RAW_LEN     GENMASK(13, 0)
>>>>>>>> +
>>>>>>>>     struct meson_nfc_nand_chip {
>>>>>>>>         struct list_head node;
>>>>>>>>         struct nand_chip nand;
>>>>>>>> @@ -284,7 +286,7 @@ static void meson_nfc_cmd_access(struct >>>>>> nand_chip *nand, int raw, bool dir,
>>>>>>>>
>>>>>>>>         if (raw) {
>>>>>>>>                 len = mtd->writesize + mtd->oobsize;
>>>>>>>> -            cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
>>>>>>>> +            cmd = len | scrambler | DMA_DIR(dir);
>>>>>>>>                 writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>
>>>>> I think we could keep "& GENMASK(13, 0)". it is better here to >>> indicate how many bits of length in this command and don't destory >>> the command once we don't check the "len" outside of this function. >>> or the code "if (len >  NFC_CMD_RAW_LEN)" is better to put inside >>> this function nearly. Thanks.
>>>>
>>>> It depends who calls this helper. If only used inside >> exec_op,write_page_raw() and read_page_raw() also call >> meson_nfc_cmd_access(), > but i don't find where constrain the "len".
>>
>> Is the helper "meson_nfc_check_op()" needed by exec_op() after the constraint in attach_chip()? the length passed in exec_op() seems smaller than "mtd->writesize + mtd->oobsize" now.
> 
> exec_op() is primarily dedicated to performing side commands than page
> accesses, typically the parameter page is X bytes, you might want to
> read it 3 times, depending on the capabilities of the controller, you
> might need to split the operation or not, so the core checks what are
> the controller capabilities before doing the operation. So yes, the
> check_op() thing is necessary.

ok, i get it. thanks

@Arseniy I have no other questions about this patch.
> 
>>
>> @Arseniy if it does need, I think the same constraint is needed by
>> "meson_nfc_cmd_access()"
>>
>>>
>>>> it's not useful. If used outside, then if you want to clarify
>>>> things you may want to use:
>>>>
>>>> #define NFC_CMD_OP_LEN(cmd) FIELD_PREP(GENMASK(13, 0), (cmd))
>>>>
>>>> This is by far my favorite construction. Could apply to many other
>>>> fields, like DMA_DIR, scrambler, etc.
>>
>> @Miquel, FIELD_PREP() is better, but i have no idea whether we should add FIELD_PREP() in this patch, or keep the previous code.
>>
>>>>
>>>>>>>>                 return;
>>>>>>>>         }
>>>>>>>> @@ -573,7 +575,7 @@ static int meson_nfc_read_buf(struct nand_chip >>>>>> *nand, u8 *buf, int len)
>>>>>>>>         if (ret)
>>>>>>>>                 goto out;
>>>>>>>>
>>>>>>>> -    cmd = NFC_CMD_N2M | (len & GENMASK(13, 0));
>>>>>>>> +    cmd = NFC_CMD_N2M | len;
>>>>>>>>         writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>
>>>>>>>>         meson_nfc_drain_cmd(nfc);
>>>>>>>> @@ -597,7 +599,7 @@ static int meson_nfc_write_buf(struct >>>>>> nand_chip *nand, u8 *buf, int len)
>>>>>>>>         if (ret)
>>>>>>>>                 return ret;
>>>>>>>>
>>>>>>>> -    cmd = NFC_CMD_M2N | (len & GENMASK(13, 0));
>>>>>>>> +    cmd = NFC_CMD_M2N | len;
>>>>>>>>         writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>>>
>>>>>>>>         meson_nfc_drain_cmd(nfc);
>>>>>>>> @@ -1007,6 +1009,31 @@ meson_nand_op_put_dma_safe_output_buf(const >>>>>> struct nand_op_instr *instr,
>>>>>>>>                 kfree(buf);
>>>>>>>>     }
>>>>>>>>
>>>>>>>> +static int meson_nfc_check_op(struct nand_chip *chip,
>>>>>>>> +                          const struct nand_operation *op)
>>>>>>>> +{
>>>>>>>> +    int op_id;
>>>>>>>> +
>>>>>>>> +    for (op_id = 0; op_id < op->ninstrs; op_id++) {
>>>>>>>> +            const struct nand_op_instr *instr;
>>>>>>>> +
>>>>>>>> +            instr = &op->instrs[op_id];
>>>>>>>> +
>>>>>>>> +            switch (instr->type) {
>>>>>>>> +            case NAND_OP_DATA_IN_INSTR:
>>>>>>>> +            case NAND_OP_DATA_OUT_INSTR:
>>>>>>>> +                    if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
>>>>>>>> +                            return -ENOTSUPP;
>>>>>>>> +
>>>>>>>> +                    break;
>>>>>>>> +            default:
>>>>>>>> +                    break;
>>>>>>>> +            }
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>     static int meson_nfc_exec_op(struct nand_chip *nand,
>>>>>>>>                              const struct nand_operation *op, bool >>>>>> check_only)
>>>>>>>>     {
>>>>>>>> @@ -1015,10 +1042,12 @@ static int meson_nfc_exec_op(struct >>>>>> nand_chip *nand,
>>>>>>>>         const struct nand_op_instr *instr = NULL;
>>>>>>>>         void *buf;
>>>>>>>>         u32 op_id, delay_idle, cmd;
>>>>>>>> +    int err;
>>>>>>>>         int i;
>>>>>>>>
>>>>>>>> -    if (check_only)
>>>>>>>> -            return 0;
>>>>>>>> +    err = meson_nfc_check_op(nand, op);
>>>>>>>> +    if (err || check_only)
>>>>>>>> +            return err;
>>>>>>>>
>>>>>>>>         meson_nfc_select_chip(nand, op->cs);
>>>>>>>>         for (op_id = 0; op_id < op->ninstrs; op_id++) {
>>>>>>>> @@ -1293,6 +1322,7 @@ static int meson_nand_attach_chip(struct >>>>>> nand_chip *nand)
>>>>>>>>         struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>>>>>>         struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>>>>         int nsectors = mtd->writesize / 1024;
>>>>>>>> +    int raw_writesize;
>>>>>>>>         int ret;
>>>>>>>>
>>>>>>>>         if (!mtd->name) {
>>>>>>>> @@ -1304,6 +1334,13 @@ static int meson_nand_attach_chip(struct >>>>>> nand_chip *nand)
>>>>>>>>                         return -ENOMEM;
>>>>>>>>         }
>>>>>>>>
>>>>>>>> +    raw_writesize = mtd->writesize + mtd->oobsize;
>>>>>>>> +    if (raw_writesize > NFC_CMD_RAW_LEN) {
>>>>>>>> +            dev_err(nfc->dev, "too big write size in raw mode: %d >>>>>> > %ld\n",
>>>>>>>> +                    raw_writesize, NFC_CMD_RAW_LEN);
>>>>>>>> +            return -EINVAL;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>>         if (nand->bbt_options & NAND_BBT_USE_FLASH)
>>>>>>>>                 nand->bbt_options |= NAND_BBT_NO_OOB;
>>>>>>>>
>>>>
>>>>
>>>> Thanks,
>>>> Miquèl
> 
> 
> Thanks,
> Miquèl
