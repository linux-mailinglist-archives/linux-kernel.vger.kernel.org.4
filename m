Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFEA72778C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjFHGoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbjFHGoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:44:18 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87212129
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 23:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFQj1Yz81dAKFUu78+kIMUIlhFXUaYgYmYe6KBlTbltM/UPOvMcaQOWnQyT3U1xwJEAA1AEUlhsnSDI14RRk9fkOXYeBOvQPP7HFeDUxNysPc0b8oKEpmDDYLvaETV7TD45ac3SSWrjQT9KHBe8y6tr1SaPi5eXaRKPU2z2xsRHZNTKHcmcLEhGnwmtEfFWCEt5QxcQ2TVvZZeTzaRvy557bQtLiEmTceYSQDTZCFfDn+lZl1dWQuwrgG9J80VcadxpISvcXCpb4i6QqLEOisEQEW/U+bl71xmlTrY3zIq5Sm45ljVPM1uH0yPBFicgUsFDNChh1vH+JxsxFTnuUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFwOEKaA/SLfc2Yix3v4w1VzWbBRbLdRXjvx6iOLHuw=;
 b=bn8YCFY2MEd+jnC436MlrVbLw5xiieSBE5qQKLY/XCo0FUkAW385mW5fWOPt0XNxcGMlRUVi3K9EBF3Qug1qE5QE5aqM/CvqoqIpKZtEHgH+AceaRXgssXgERmRc/Yiedur+9n5b3oZKVYquRjaDi7tEjzQ42/D0XAwqjHAJCRIJAakyJ6f+zKFlYBlEe81FZh1hR4ynH5NzdIKGPRCERiEO1m2FATR2PXmG3V5fh2CC8joJqwZoBZCEF5hzysnPbnHZvS7c/INcs8NXl1SuITPmj3UgVTC4mcLvVn9C3H4tzsosNS1v7BqTLZVpUYDVYdeGkETQ2NEzb0fP3r0cHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFwOEKaA/SLfc2Yix3v4w1VzWbBRbLdRXjvx6iOLHuw=;
 b=Vs5bI793XGD4UPkrDIIuRDeA3sqRPV4VVNyWpvl7wmHChTOee2poFkbfZsN9pnBzkmN+gDZ17S2+UNXPqkNWlosX6C8wt+xPeqKpn0RKK60kJd7j8cFcxqSgvkVaeYourDiXJ4OB2ePTXmDGHzPdN3uRJTxMJ/T4r0EH8eFZi1kNBhX2YAs8A4leuZwxg9a2F+1TTFforfaDhviHcj7Ds7pAgS3YhCi3Fcac6VnNpqIzoLxpkmRPgnLKEs4NoGDrrSAMFYc9GF1whmbMY/CjfBlb5eHbw5eXu6wB1HxFT9IzcBDj/q3WqjvYWuAQKDgpMWs1tjy2FwhPpnI5mFJINg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com (2603:1096:990:9::6) by
 TYZPR03MB5485.apcprd03.prod.outlook.com (2603:1096:400:5c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Thu, 8 Jun 2023 06:43:25 +0000
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::5e9e:bcd4:e9d8:548a]) by JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::5e9e:bcd4:e9d8:548a%6]) with mapi id 15.20.6455.028; Thu, 8 Jun 2023
 06:43:25 +0000
Message-ID: <7903580d-685c-14e6-5572-81a4cb31cced@amlogic.com>
Date:   Thu, 8 Jun 2023 14:42:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] mtd: rawnand: meson: check buffer length
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
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
References: <20230606101644.3297859-1-AVKrasnov@sberdevices.ru>
 <9adef6da-5930-dcaa-f148-e4a398d39f2d@sberdevices.ru>
 <3a9470ed-d7ad-6cae-0d58-732399590272@sberdevices.ru>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <3a9470ed-d7ad-6cae-0d58-732399590272@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0014.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::8) To JH0PR03MB7495.apcprd03.prod.outlook.com
 (2603:1096:990:9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7495:EE_|TYZPR03MB5485:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa2be64-2065-4a1b-d5ce-08db67eba8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8hhp/KNj6wG+fitXkkoNV7jNIDl9LsAxniAexMJfeHgF/hs/NfqEJANOwuU50GrlszVax4nLoP+HimqlgNLaqeJ1k3JzrQxdt+PO4JUMjI1eQf5WTldrn9r6VtcuzIwPy2pPmBPcUDo85sncDFr1+0ay21lwHj6LxrMUJ5JGZs5Cy+ZD/j1WtrjvFNo3xfKC2ajkg+HhPCLegMAPpEIWkk834I9XPUqgxNYB46JmiMVTnZ7diNp70nRgjI32BXr/L6bY38bP6AV6E9eOKyocsys0Rh9/YQ8LIl4tWzoT0JEDHf4w/4s5P/Yv/CCMIRYzOKpRwbH70a9+M1BgUK056RdSDgBQs5U3r5iNuo5B9BKFCS2dx/BuDmqnKlJhGs1jgCi/AhLjllt+qcI+3CLk+JZhpILC7x4X5njzQEQ0J1RyFwiZI/XEAILwzBQVopWPeXg/TWs0t98bDwTGW3AaAPAB+/W32qJ27ub2LdoqxFQEn8EWp2P+lN8rM7E6if5rLz6QVEKNptq25wXSAZKc2Bu/ZeQK/iVvZyA88d0gdM+WKO241yxtXV1wtz/KQHRsQeYvQixW6ugLxFuXb7pptA3hbX6oOJkPKpqr2RlYGcdQ8fe4QASD2seFMQ+7IVii7U7mxfzMPGroq1GtqNqBi834hs3CrxhqryjX4CWWcODr52lSFZOh6IiKJkE0GgynTm1LvCOkA2s0goH1KtM8LzM31ZxKp1sYNZOlAitEFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7495.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39850400004)(451199021)(478600001)(2906002)(36756003)(52116002)(6486002)(6666004)(2616005)(83380400001)(31696002)(6506007)(86362001)(186003)(38100700002)(6512007)(53546011)(26005)(38350700002)(31686004)(316002)(8936002)(7416002)(8676002)(66946007)(66556008)(66476007)(4326008)(5660300002)(44832011)(110136005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S08weWFEWEJ0TjZVQ3IzT0xmTDdkQk5iTTR3KzBUUjJ1N1NaWnc1WGsyNmRx?=
 =?utf-8?B?YTRnQm82eEczaStkQVVWbTc2OXRXOVNVblFLS3dyVFg4RHNOajlSSTh4S0Ri?=
 =?utf-8?B?RW45eDU2K09ieWdMUjZCMm5Yb04rVEl2QlZubHVMK1FvdlM5WUtqNjFsOVN6?=
 =?utf-8?B?Nm9VRGsvSWdnLzdGNThLOUE2RG51NUNCZ05YVDdxMGQxNVMwSU11QUpVVnoy?=
 =?utf-8?B?QzNjeDVRNy91ZFhrWnhYdGxKVy9FR3ZYZFVoMFVsb21hZE41RmJBUEhGdDZt?=
 =?utf-8?B?MjZnRm5aK2xQZVlhSjFWNU9aMnQyeUttK0llQldUc2ZlTkZqU0JmaDVyTWpm?=
 =?utf-8?B?cjVKVmdHa29BTXNMOWF5WG53dnF3Ukp3OHA0RWZBWUVoWUVSUzEyL3B3bzcy?=
 =?utf-8?B?cEpyYWlnT1YzQnh0Y0dXUk1OTDlsdWF6eCtNMjk0S3FLdTNKbHRDeTl4ZGFO?=
 =?utf-8?B?eGZkV0ZlRWVZS1NJbVZvbzg3YXJaN0pFd1Fyb2w4Kys4dmFhdW5lLzM1S2N2?=
 =?utf-8?B?ZGIzSlppMXBTaklLcW5kZ1VDc2cra3FCdDJadVJmeEtOOE5iM1pBcEpmajZ6?=
 =?utf-8?B?NUVXVDc4M0ZqempVZnZGNzVvTXNVQjRCZlNQQW8zSGlWZnB5WVRSR3BlYWtp?=
 =?utf-8?B?NVp6ays2NnR1RXh4elE0dGtqQ3dGd3VQNnFZZTJjNC9UbU5odWFqM012WDN2?=
 =?utf-8?B?RmVDb2VjYlh1S1kxRGtuN25NVG9NWUNBUFVJb3p0dDlndFl0QnhNY0RoL2Mv?=
 =?utf-8?B?dm5oeUppR3RuREtlTUU5Z3RTaCtqczF4b3loblVwTkdEck82TlV2VXVFWnk0?=
 =?utf-8?B?UHp0ZVVDM1dHNkh1YU9SbmJZTkpjWTJmazJEeGFUNEFTRFRqZXE4SWYzUStD?=
 =?utf-8?B?S3BXeDlJSVhsZVZ6SmJ0dkp2VlB3NjhZV3gwRUFYRUg2ZHVRVEs0N1llM3Jt?=
 =?utf-8?B?VGxGejBHNUtKUDZQNVF5QytKRVFmM2o0bWpwU1MrT0tHUGtBUVlFZUV6MzVz?=
 =?utf-8?B?ZnBRZEpNZGU3ZkRrWUFHV0o4eXp1V2Y4allMQzBFTm9vWVRoU21tbW92eC9L?=
 =?utf-8?B?bzY2cXVqc2VGcnM4ZjQ4VFpOa1FqejJWRjdnWTU1KzUvWmZhaDRIaVRGeGF0?=
 =?utf-8?B?S09zc3Z3UkFzUHVuMGQvSWRRMmNxSStVUFI2VENGNXluUTRmSjlpeElwc3VH?=
 =?utf-8?B?TU1hRTd3dTFDOHJkWVliQ1dNWHRKRlRZaEorbFM3L2VKWitvZnE4UVBURmdi?=
 =?utf-8?B?R0swT01MclVTSlRJaFVYQUxKWHptVi9ueHZsbEc0RSszbVljVzJTY3c4Tksx?=
 =?utf-8?B?akFwY1c5Wm5mcVpvUmVkNHFLMVdYWnVIWWhZMkhMbTk1c25EdlQvaWlGTUdD?=
 =?utf-8?B?WGdua2N4WUI5WUxLd25mRUVZZm04OXMxQURMbDl1OE5kb2h6WVpMaGEwTkRs?=
 =?utf-8?B?aHVWNFNsL3VINmZzZENObDYwcnJwdHNxM0ZITHN2djI4ZE5RZ3dtZUI5S1F5?=
 =?utf-8?B?S3dRTlpUSUdla2MzNXZ2dEZ2NXpReVd0bll4TW12WnVJcFZ6QS9YRk1hS3VI?=
 =?utf-8?B?UW4ya3VtaHQ3TkFEbFhSRnRraEQyNm5sTHdFZmkyVTFkeGZrT0V6RkJveWpu?=
 =?utf-8?B?cXdNaVFWNGpoU1lBYWIvLzJCZ1JOWDBPWGhEanNDeWVBQTBCbHphTEphWGxB?=
 =?utf-8?B?MCs5UlFud1d1akNtM2NOZVp4aG5aRjBwemJZSDVBZG14bkoxVit5NEN1amMv?=
 =?utf-8?B?SHZSclJhcWY2TU10bzFJQzJQMzdwYWJSNjFxUGVEdUV3YnE0d09LWmFkUTZj?=
 =?utf-8?B?eHhVZGZ4b2l5eDAwZnlaOXpiVm1KaEg3MjJjL2Nwd2ZsVFB1ZTd3V0JEaGVx?=
 =?utf-8?B?eDNNVTliWVlDUHhyaHkxUk9TYi9LSEpwQVhUNXJCUUN3SDZFblIwOVArRmty?=
 =?utf-8?B?QUIzTDNyTDlWTGZPcjRPWHpTZW1qNFIvaTVaN2U1YWpaVllKVVVMVXZHQnRu?=
 =?utf-8?B?OSs0VXEwd3dhWGhJczRwSHZaa2x4SnVqUWc3WkpkeFE2QnNoTEVSYXRKWXFN?=
 =?utf-8?B?ZFZXNkRQOUVpVk9HZU5vYXNmZmtKRlg5aVpmTzI0UjdvSnhuUmNURXREbXg0?=
 =?utf-8?Q?uP9EBq3q/SrhAs8omghiwe9RA?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa2be64-2065-4a1b-d5ce-08db67eba8c0
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7495.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 06:43:25.1339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZF0x5lKUfKkdm8A0mjjbA2px0nwY9HuCBSJmJGa2vu1rObYWAPzHn7XuOwAzhWMT5sT4IktUGFnnpN7qErviw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5485
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

On 2023/6/8 5:17, Arseniy Krasnov wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi again Miquel, Liang!
> 
> What do You think about this patch?
> 
> Thanks, Arseniy
> 
> On 06.06.2023 19:29, Arseniy Krasnov wrote:
>> Sorry, here is changelog:
>> v1 -> v2:
>> * Move checks from 'switch/case' which executes commands in 'meson_nfc_exec_op()' to a special
>>    separated function 'meson_nfc_check_op()' which is called before commands processing.
>>
>> On 06.06.2023 13:16, Arseniy Krasnov wrote:
>>> Meson NAND controller has limited buffer length, so check it before
>>> command execution to avoid length trim. Also check MTD write size on
>>> chip attach.
>>>
>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>> ---
>>>   drivers/mtd/nand/raw/meson_nand.c | 47 +++++++++++++++++++++++++++----
>>>   1 file changed, 42 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>> index 23a73268421b..db6b18753071 100644
>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>> @@ -111,6 +111,8 @@
>>>
>>>   #define PER_INFO_BYTE               8
>>>
>>> +#define NFC_CMD_RAW_LEN     GENMASK(13, 0)
>>> +
>>>   struct meson_nfc_nand_chip {
>>>       struct list_head node;
>>>       struct nand_chip nand;
>>> @@ -284,7 +286,7 @@ static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool dir,
>>>
>>>       if (raw) {
>>>               len = mtd->writesize + mtd->oobsize;
>>> -            cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
>>> +            cmd = len | scrambler | DMA_DIR(dir);
>>>               writel(cmd, nfc->reg_base + NFC_REG_CMD);

I think we could keep "& GENMASK(13, 0)". it is better here to indicate 
how many bits of length in this command and don't destory the command 
once we don't check the "len" outside of this function. or the code "if 
(len >  NFC_CMD_RAW_LEN)" is better to put inside this function nearly. 
Thanks.

>>>               return;
>>>       }
>>> @@ -573,7 +575,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
>>>       if (ret)
>>>               goto out;
>>>
>>> -    cmd = NFC_CMD_N2M | (len & GENMASK(13, 0));
>>> +    cmd = NFC_CMD_N2M | len;
>>>       writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>
>>>       meson_nfc_drain_cmd(nfc);
>>> @@ -597,7 +599,7 @@ static int meson_nfc_write_buf(struct nand_chip *nand, u8 *buf, int len)
>>>       if (ret)
>>>               return ret;
>>>
>>> -    cmd = NFC_CMD_M2N | (len & GENMASK(13, 0));
>>> +    cmd = NFC_CMD_M2N | len;
>>>       writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>
>>>       meson_nfc_drain_cmd(nfc);
>>> @@ -1007,6 +1009,31 @@ meson_nand_op_put_dma_safe_output_buf(const struct nand_op_instr *instr,
>>>               kfree(buf);
>>>   }
>>>
>>> +static int meson_nfc_check_op(struct nand_chip *chip,
>>> +                          const struct nand_operation *op)
>>> +{
>>> +    int op_id;
>>> +
>>> +    for (op_id = 0; op_id < op->ninstrs; op_id++) {
>>> +            const struct nand_op_instr *instr;
>>> +
>>> +            instr = &op->instrs[op_id];
>>> +
>>> +            switch (instr->type) {
>>> +            case NAND_OP_DATA_IN_INSTR:
>>> +            case NAND_OP_DATA_OUT_INSTR:
>>> +                    if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
>>> +                            return -ENOTSUPP;
>>> +
>>> +                    break;
>>> +            default:
>>> +                    break;
>>> +            }
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int meson_nfc_exec_op(struct nand_chip *nand,
>>>                            const struct nand_operation *op, bool check_only)
>>>   {
>>> @@ -1015,10 +1042,12 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
>>>       const struct nand_op_instr *instr = NULL;
>>>       void *buf;
>>>       u32 op_id, delay_idle, cmd;
>>> +    int err;
>>>       int i;
>>>
>>> -    if (check_only)
>>> -            return 0;
>>> +    err = meson_nfc_check_op(nand, op);
>>> +    if (err || check_only)
>>> +            return err;
>>>
>>>       meson_nfc_select_chip(nand, op->cs);
>>>       for (op_id = 0; op_id < op->ninstrs; op_id++) {
>>> @@ -1293,6 +1322,7 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
>>>       struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>       struct mtd_info *mtd = nand_to_mtd(nand);
>>>       int nsectors = mtd->writesize / 1024;
>>> +    int raw_writesize;
>>>       int ret;
>>>
>>>       if (!mtd->name) {
>>> @@ -1304,6 +1334,13 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
>>>                       return -ENOMEM;
>>>       }
>>>
>>> +    raw_writesize = mtd->writesize + mtd->oobsize;
>>> +    if (raw_writesize > NFC_CMD_RAW_LEN) {
>>> +            dev_err(nfc->dev, "too big write size in raw mode: %d > %ld\n",
>>> +                    raw_writesize, NFC_CMD_RAW_LEN);
>>> +            return -EINVAL;
>>> +    }
>>> +
>>>       if (nand->bbt_options & NAND_BBT_USE_FLASH)
>>>               nand->bbt_options |= NAND_BBT_NO_OOB;
>>>
