Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6C7725257
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 05:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjFGDP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 23:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjFGDPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 23:15:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2092.outbound.protection.outlook.com [40.107.117.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFDC10EA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 20:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HehXqP5eUfO0BmyfJrv409aaGvKacbGhtYYdKtn+VmRGejiU4iFNMGxGzKhI4DDPUquYOkxGf4Jczk44gQmZHZjrZ+6wk8skDYvHiql83s8TjMNEKSbuPjYM9nfmfS1MSBJ8+avNLG//rNjU5zNxilqMoz4eh/68PEhIba0+tGfE7TZm8EC7b1jwlIGfH0D+Ed28XN5cR+d1xG973ODHah8+DykHPoylJVdqOLD9xvVlwcGftt/R4q+m7AmI0e10A678ErmxyYmP/ZNRhN16Com91ZQDEJ+fh0DDgA8V1nd2vTrEIQpikygye2u6noUQWrrXdS4W52pBHpP7jb8yvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLbeOhWSGwBN99fXTs3Ji/F8ultwWcEjWUPWyeCsmhA=;
 b=cw2/qcHneIP2JzMhiULOZBYTxZbConzFdcEQCDhAw7ilMCJYGDeoZP8GVS4nD8BuJYcPaRmXw74RTphTfjv15AMc+bM0kAYEpP0cZHGeCiAVjluD2cybMzMKv44BnBOiu1a2AhQmoX/3zbz4lsol7PTb1lx/Sg2Wn5OD4w5vxhN2CTMqYIskexCgIA5BBpMcJ2MoISEQFZQkGTFZs8A0qHa+l3XQ8UsUjXo3IZiCHyLayH44Sl5u3BfB5vr3YyZibDu2L3/pXqFfqIs5MTUfxDAz7TsSdNK3NWaSjgHskgZvGk0QDKpYvssztTfKjCjoWIJT7256q/ogn2Mom+NoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLbeOhWSGwBN99fXTs3Ji/F8ultwWcEjWUPWyeCsmhA=;
 b=FicsbnBEXkq1CPSRyICpmGgt7lbqBMtMQKGQD54vh70wKIYcqJDno1zkkt6ntWgfTE0ralIQ+CAza9uRyPBk+XS4/CNezuu16Da2dQIHY7v92R317S7v0WV7OtGbn9dtXOhen0/j75CltgTH4iLxRZoExuuLBYB5oh2PmkX4XZ4nBQ1s2MeT5/Ycm6OnAISLoJm8XLFNS75lMEd28tCCzYAN6lQhbpxdnw2XxMY2KlTh/cTsBrnnCXNESzwZpb4di3h3quV3gM0StV0vMSp2Y5bhVZsI9i/vGKDKTqxlAhBzI+xnssdISlnrGadF7ar2j5cpNOdRQZqHSwAk9MJGoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SEYPR03MB7479.apcprd03.prod.outlook.com (2603:1096:101:146::13)
 by SI2PR03MB6566.apcprd03.prod.outlook.com (2603:1096:4:1e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Wed, 7 Jun
 2023 03:15:02 +0000
Received: from SEYPR03MB7479.apcprd03.prod.outlook.com
 ([fe80::45d7:8926:3640:a9a3]) by SEYPR03MB7479.apcprd03.prod.outlook.com
 ([fe80::45d7:8926:3640:a9a3%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 03:15:01 +0000
Message-ID: <688909b3-fb0a-1001-d38e-57dba23d3bae@amlogic.com>
Date:   Wed, 7 Jun 2023 11:14:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] mtd: rawnand: meson: waiting w/o wired ready/busy pin
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
References: <20230606195128.83432-1-AVKrasnov@sberdevices.ru>
 <2ed06841-6c9f-46c9-2d2d-2daffb0a9010@sberdevices.ru>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <2ed06841-6c9f-46c9-2d2d-2daffb0a9010@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::19) To SEYPR03MB7479.apcprd03.prod.outlook.com
 (2603:1096:101:146::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR03MB7479:EE_|SI2PR03MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f728363-11e5-484d-3d00-08db67056122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbrKAAo9UUqtPhYlJ7KFBQ0M0jFQwyCB0C22bwv1FXusgMEdDZAWMRNltY49t+O5l9S5dFYdtbhGUCOJY1jiXfYzBuAdJIaRRWGKV5iq54RzANB3QTg4iaRKFyhyMzv95HvmB7DORvDmVgrgxI93VF4DHqD22ngzrSGLvwUchYKOC6/YqO5xJQhJ+WDcFcl8R+EvP7S/3djo1WTs9LnG6ZkU3sBEEZucS7pePCj7ArKEBvqUxv6oiYL0jkvavTsef3hJY62GzWJJTzpIddQBMoKFbSt3HKoUhFYrA4sYudeBL+bQ646MOpV7VkNZD5yABE1OMGFfWcypdm8HxfC/GbklcEQL+dqUPk9SsscLCPAhpiZfBzNj4Sw7gNNceHpR5lDTBIpCdFHEu9BrId/s4b1uBhZIPROIWIUEdyXybdl8Qzw4kqyJvznVT14KxCsXzPgR8+4q+d/Jy6pxXHfHh5qeMd8fVvxr1bmyjJMoynqmYlniRWmGJX9GnVrC4JCSPWAVDJq3demWjRE6BIFR0S2FDv2iJ2hvS3KWFfaXzDduwdVFvPKfmjbhK9vEzyn/oYVl0B4prsEVupinKRb8NrUvO2yuKHKJUVG5RGNHz++3apL6I88Lz8NCJgag6tVMBqix/teAYssuT0oDGjmJN9+0qmxWyn18K16f6m0X3tBddP08iKUXxUlb1fl9hKJO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7479.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39850400004)(136003)(366004)(346002)(451199021)(36756003)(31696002)(86362001)(6512007)(41300700001)(6486002)(52116002)(38100700002)(38350700002)(478600001)(110136005)(66946007)(2616005)(66476007)(4326008)(316002)(6666004)(83380400001)(26005)(31686004)(53546011)(7416002)(44832011)(186003)(6506007)(2906002)(66556008)(8936002)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmxPbVZzVlRSSitwNUNRZGdHTzNJZ3RoRmZ2bEFzUkJQV3dJSGVnT2xPVk9s?=
 =?utf-8?B?MCswM0ZIRklhZUZJQUEwQy85TkdvN3ZTb1E0YnVMSUJYcFB5bXlySlpXb0RJ?=
 =?utf-8?B?a0N3T2JiZHZNSUZwS3lmVzI5enZRMGR2ZkJLMUpyVXh4RHlOQ0hpZHBSRldN?=
 =?utf-8?B?SXJSalNMMWZDKzBReWNmYVkwOUZhcDIvVmRpbWVRM0ZWNEVoQS9Bekp2N1Fq?=
 =?utf-8?B?TC9Ic1hEL0ZvNkdyc3crSFA1RG14TXZIRkVZYW9yQ0JvNmJwV25iczNHM09X?=
 =?utf-8?B?RE4yY1pYMEtzSCtXNHlpWFV3eGwwSkZUR1ZCU1FQaDhyQmN2cXJSZHQ2aEMr?=
 =?utf-8?B?clg2S25iVFlDUHNnV3AzVGExNXNRRmtQYkZkZC81WmkzWkxBOWNwNXNPZ2t0?=
 =?utf-8?B?NThFSXF3d3htK3Y1OURDSmI3L2gzcVZaOEU0UFNldHdCNEJzZ3lxRnpRMVhr?=
 =?utf-8?B?S1ZvR01aOGE2bDhsalhmbEttT2RnNzkxWHN1L0Q1RmJ4eS9wSUlhdjlOU1I5?=
 =?utf-8?B?Zng0eVVSdi9PZHNnK0FEdmRmK2JZTVl2WEwyQmhMdURUd0NKNG9uNnErd3A0?=
 =?utf-8?B?VTkrMzNmRnVId0dpRFhZK3d2MzR3WWE2bEIvaC9KY01tdHFuRTd2dkMyYjdu?=
 =?utf-8?B?d0MzNGNzOGxJWDNjV0VkM1FlKzVVWFdPTEczaWFJaW1uRW1OS1ZGdGFiajBF?=
 =?utf-8?B?K1lCUmw2MjhQNTFTQlhyWGkzZkZRUFRnQldaTXRiTURQS2hoamZxVlNvQitC?=
 =?utf-8?B?S09UQklsY29KTWhkM1YrUXV4NllyWGJwd1ZXeHNub0x6UUhIZGd3TXJ6YWxF?=
 =?utf-8?B?bWFIMms2dDFiYWN4U2JlZ3RISEs3MEdwQ1F6L3NJRHFBUzZtSFcwSUp6WkxT?=
 =?utf-8?B?RWIxRUlMRXNFbWl4NGg4RGttbk44dm43M1BMb1ZOeDJuNFJFVkxTOXJoTFBV?=
 =?utf-8?B?cmhhbWVlQXJRbzVGVFE1c1A2c0NCQ2VBQzdkeHB2NG5uNFMwUzZVNEZCTFBO?=
 =?utf-8?B?T0Vzc0hRd0Zma0NaUjBmV0d3eGJDNERWemM1bzQwRWVabG1XTHdjeDFqNjRE?=
 =?utf-8?B?RjFZekpML3Q2MWR3ckpVRXJHTVl1L1ZVZ1BxVHpReXg0UFAxQ1cydGEvQnE2?=
 =?utf-8?B?RklEN0RMd3pJTlIrN1RKaENzODF6UUw2c2RwTGl1cldTaXcrNzMrU0l1bU5R?=
 =?utf-8?B?N0UvcDh3UVJGZkZzeEc2blJ4cG9VT21QNDZiNGx1SlEyY21Hb09RcEF6RFJv?=
 =?utf-8?B?SWowMHczMEQ1dW54QlRFNG9FYzhHWU5HUmZkNzNBMmJISE5GSlR4bU1abXla?=
 =?utf-8?B?RHZKWDloMkIyZ1JacGVMMEJVMVZVTmxLTE5lQjl2RXdLQlRsdzBiNlFwcXFN?=
 =?utf-8?B?cEpyZVdEN2hqTjQ5NjdVb1VBeUg0SFZpMm1mdXczNHQxaG1WUmlWa3BWZHV6?=
 =?utf-8?B?dVV6OWFOMkdEQk9PSHhublRaMzNyOURTYjFHRWdNMkJSSWV1UElML1I2bDlL?=
 =?utf-8?B?S2xZQWQ4TGppSE9acndpNHc3dlh3cE9UWTd5bXpxTmtSNERWa1AxT1kwcm9u?=
 =?utf-8?B?Y1c4VW5HNHVUREhyK1I2NkNJenBvNW5jK0ZnSXFSSHBKRlRrUDhWbEN5QWhO?=
 =?utf-8?B?Y1ZQbGxNWnFnMS8wY3JlTEwyQit6U2E1WXRxTHRQOHp1WU8xZHRFV21PVnEz?=
 =?utf-8?B?V0FOMHRkRll2dkRsL1NDMEtYSENhZ2NWdnljUk9NcS84NDhGaFdsY0s0Yml4?=
 =?utf-8?B?QUkvSjRlZU4vaHo4TVZ0V3lqUW4wUGx3NFE4Rit0RThIejR4ZGQwSUhWR2ox?=
 =?utf-8?B?d3FISE9JaThxK0tJNldFMEhwV1pVZXNRR084WFVmd0d4djh2anBKSUZuNXcv?=
 =?utf-8?B?NjdlckxHLytKM1RCMEYyTnVnVUZpdmF4a0JQTUF5aFpudlFSUmlyd3lhTjdK?=
 =?utf-8?B?dHBUdlVUU0hPcW1RMDRhUmo3OStKQlpEODR2VjJsQkpmYzF6a1pYRzRXSFRL?=
 =?utf-8?B?STl3WTVMTFhJWjJ6SHloL1pORzR0OForanlwc2NrTk5Ja3dWcjYwMWF4OEpx?=
 =?utf-8?B?YTV2M2dBSXUvOVcvOXZkd0svOHduRXFybDBqeUFRS24rTlpyT0RyV0VEa2Za?=
 =?utf-8?Q?71FG9iq27gXrPpVVoSvVrXWxt?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f728363-11e5-484d-3d00-08db67056122
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7479.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 03:15:00.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXk70/9B/A9uMvPPQB0uGxloCj1YI8+0YSNVWxzjemFXisSUY69nPErHr7v2pDMe9ze+jn2kcTj68STggS//Lw==
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

On 2023/6/7 3:54, Arseniy Krasnov wrote:
> [ EXTERNAL EMAIL ]
> 
> On 06.06.2023 22:51, Arseniy Krasnov wrote:
>> If there is no wired ready/busy pin, classic way to wait for command
>> completion is to use function 'nand_soft_waitrdy()'. Meson NAND has
>> special command which allows to wait for NAND_STATUS_READY bit without
>> reading status in a software loop (as 'nand_soft_waitrdy()' does). To
>> use it send this command along with NAND_CMD_STATUS, then wait for an
>> interrupt, and after interrupt send NAND_CMD_READ0. So this feature
>> allows to use interrupt driven waiting without wired ready/busy pin.
>>
>> Suggested-by: Liang Yang <liang.yang@amlogic.com>
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>>   drivers/mtd/nand/raw/meson_nand.c | 58 ++++++++++++++++++++++++++++++-
>>   1 file changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> index 074e14225c06..f4c5309a9527 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -38,6 +38,7 @@
>>   #define NFC_CMD_SCRAMBLER_DISABLE    0
>>   #define NFC_CMD_SHORTMODE_DISABLE    0
>>   #define NFC_CMD_RB_INT               BIT(14)
>> +#define NFC_CMD_RB_INT_NO_PIN        ((0xb << 10) | BIT(18) | BIT(16))
>>
>>   #define NFC_CMD_GET_SIZE(x)  (((x) >> 22) & GENMASK(4, 0))
>>
>> @@ -94,6 +95,7 @@
>>
>>   /* nand flash controller delay 3 ns */
>>   #define NFC_DEFAULT_DELAY    3000
>> +#define NFC_NO_RB_PIN_DELAY  5
>>
>>   #define ROW_ADDER(page, index)       (((page) >> (8 * (index))) & 0xff)
>>   #define MAX_CYCLE_ADDRS              5
>> @@ -179,6 +181,7 @@ struct meson_nfc {
>>        u32 info_bytes;
>>
>>        unsigned long assigned_cs;
>> +     bool no_rb_pin;
>>   };
>>
>>   enum {
>> @@ -392,7 +395,41 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
>>        }
>>   }
>>
>> -static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>> +static int meson_nfc_wait_no_rb_pin(struct meson_nfc *nfc, int timeout_ms)
>> +{
>> +     u32 cmd, cfg;
>> +
>> +     meson_nfc_cmd_idle(nfc, nfc->timing.twb);
>> +     meson_nfc_drain_cmd(nfc);
>> +     meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>> +
>> +     cfg = readl(nfc->reg_base + NFC_REG_CFG);
>> +     cfg |= NFC_RB_IRQ_EN;
>> +     writel(cfg, nfc->reg_base + NFC_REG_CFG);
>> +
>> +     reinit_completion(&nfc->completion);
>> +     cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_STATUS;
>> +     writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +     meson_nfc_cmd_idle(nfc, NFC_NO_RB_PIN_DELAY);
> 
> ^^^
> 
>> +
>> +     /* use the max erase time as the maximum clock for waiting R/B */
>> +     cmd = NFC_CMD_RB | NFC_CMD_RB_INT_NO_PIN | nfc->timing.tbers_max;
>> +     writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +     meson_nfc_cmd_idle(nfc, NFC_NO_RB_PIN_DELAY);
> 
> ^^^
> Liang, I've implemented "new RB_INT" way instead of 'nand_soft_waitrdy()'. There were two numbers
> 2 and 5 in 'meson_nfc_cmd_idle()' as time argument (here and above). I've replaced both with
> define of 5 == NFC_NO_RB_PIN_DELAY. Is it correct? 2 and 5 were from doc?

You can do like that. as i know, bigger has no impact.
yes, them come from the example code of the controller datasheet; but i 
think we can delete them also.

> 
> Thanks, Arseniy
> 
>> +
>> +     if (!wait_for_completion_timeout(&nfc->completion,
>> +                                      msecs_to_jiffies(timeout_ms)))
>> +             return -ETIMEDOUT;
>> +
>> +     cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_READ0;
>> +     writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +     meson_nfc_drain_cmd(nfc);
>> +     meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
>> +
>> +     return 0;
>> +}
>> +
>> +static int meson_nfc_wait_rb_pin(struct meson_nfc *nfc, int timeout_ms)
>>   {
>>        u32 cmd, cfg;
>>        int ret = 0;
>> @@ -420,6 +457,23 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>>        return ret;
>>   }
>>
>> +static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>> +{
>> +     if (nfc->no_rb_pin) {
>> +             /* This mode is used when there is no wired R/B pin.
>> +              * It works like 'nand_soft_waitrdy()', but instead of
>> +              * polling NAND_CMD_STATUS bit in the software loop,
>> +              * it will wait for interrupt - controllers checks IO
>> +              * bus and when it detects NAND_CMD_STATUS on it, it
>> +              * raises interrupt. After interrupt, NAND_CMD_READ0 is
>> +              * sent as terminator of the ready waiting procedure.
>> +              */
>> +             return meson_nfc_wait_no_rb_pin(nfc, timeout_ms);
>> +     } else {
>> +             return meson_nfc_wait_rb_pin(nfc, timeout_ms);
>> +     }
>> +}
>> +
>>   static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
>>   {
>>        struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>> @@ -1412,6 +1466,8 @@ static int meson_nfc_probe(struct platform_device *pdev)
>>                return ret;
>>        }
>>
>> +     nfc->no_rb_pin = !of_property_read_bool(dev->of_node, "nand-rb");
>> +
>>        writel(0, nfc->reg_base + NFC_REG_CFG);
>>        ret = devm_request_irq(dev, irq, meson_nfc_irq, 0, dev_name(dev), nfc);
>>        if (ret) {
