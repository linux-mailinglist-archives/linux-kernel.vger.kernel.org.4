Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1687275B0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjFHDZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjFHDZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:25:08 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2129.outbound.protection.outlook.com [40.107.117.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C551BF7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 20:24:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTknaFa7HYlHGIb+EedA1FKgWq0iYn6aRFtWCpA8H3QnpXx2/zSBqpWOXRdqWGK20W/qCBqytkc2u48NdWcV2BlJ2bxQ3Gr3j+YvX4Ami1ogL1ka/+3RXAM4ef056mzQGs9k5bOgsmwYW13vbUM4y2r8uSvf+0rX/0M74ZciuF0F2Dv8brSQ6hVloP6HRx+2E6DeN/GbwcCX7WDUut4dE+46hZ9hDilByqF0ib9XrcBqR5/Z7OndA26ZlfGGFFeqUW1GcFs4yU6+gvhLT6O3qHEKnyTaHTm6jv7EFRiScPXfOHGP1G5HsDX76JUmh3G5FKincKJO4Xd4Upj9Nt2TeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bdt/dKhqWJQAgn5qm38Uj7ugmYkk3SqFSiUH+lHl/bI=;
 b=jt/V/Kny0vZhmXo64QCSqH6m9CMRKyFw4kA7JfT6/Jizmc9LknrKviu4EzkvWGoN/yeKrltF/k6/Dv9FjpR6UcoheKeSIY1Mmz3+DZFmgQ6wKOCrnoFXA+Ys+dXx6I0iMKxXJ0xeLgrC6F8O9+N53QwqPHO4O1ZRc9VHkpXHqhxufjq1hXHhcx1td5EvQWfweg2gQ5UF4J0zV2UI5o0BRMUtqcuXYxHfiXq3udU1p+4v6Ju0rT5yIgIXSZXh9BaYFG6plgOxDB/euRnLLSz70DKQEGqWtk1gtWYfT6vVSJs2Fo5d9x30rYtZ1ki3NZRe4iyOKqVaWPrjlE2kEaBzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bdt/dKhqWJQAgn5qm38Uj7ugmYkk3SqFSiUH+lHl/bI=;
 b=oORVS5nvhJ1yB1NIyDUBQMS3BHgehOiYh19F5BEBjft/zpx1fLmDn0ed3diF+fM9CxumwMS5M50YyR9IuzRL0uxBAMc32q9jjf8EchejV91neGRGkgAN/GOrt1SUXIUc5SSa9B2/oYS1pxtIKdzMqn9shJG22DfZrku+LTzFvHyvBv8L7B05ooUNdN/bT5XU49gsDo25D9vnBkwj6Qc+xcIwP/DXIFTUtKnnuoG1XFqEPEGVblQk53YfGDKTRrvm/wpln82+2SAKKbzs2PksCEqro7+7pPg8M7b2NIGVMZMyCjGskTy7EAzZf70nh05rcn2H64Rq+uwtnie4dQrUYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com (2603:1096:990:9::6) by
 TY0PR03MB6451.apcprd03.prod.outlook.com (2603:1096:400:1ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 03:24:19 +0000
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::5e9e:bcd4:e9d8:548a]) by JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::5e9e:bcd4:e9d8:548a%6]) with mapi id 15.20.6455.028; Thu, 8 Jun 2023
 03:24:19 +0000
Message-ID: <429589f6-d946-9bc9-d54e-e892d513a91b@amlogic.com>
Date:   Thu, 8 Jun 2023 11:23:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] mtd: rawnand: meson: remove unneeded bitwise OR with
 zeroes
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
References: <20230605191508.1826853-1-AVKrasnov@sberdevices.ru>
 <9319a8f6-3774-0dc8-2262-8033f8016a50@sberdevices.ru>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <9319a8f6-3774-0dc8-2262-8033f8016a50@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0144.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::36) To JH0PR03MB7495.apcprd03.prod.outlook.com
 (2603:1096:990:9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7495:EE_|TY0PR03MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 441669c6-aa3e-4536-37eb-08db67cfd823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XondJik08RRrWiHvVgArCPYzp3ouDchXifhiRwjSFXxWfaNcd0u6CqvpRc1YRH2NrFTkAINO+cPa+lgv4EruuzNLGpVdyoINF6UHa69CntVGX61Qg8QTUtZG0QK1Pum4ThfxXcRHfg4zS5KC717YlF+xfL4FSLNpFpOQjnzhow14Np41qGQwfgXclQzhlZBXUXFfYpqD/FStpKHFSY3bYv9o+hM0K7OGg+zE7yepJJC2RXhL91OZ2AOHdZTZIo264w3CZgHll6RIbwAvkasB00ucCuB2H1qp2ybw/YrcG/R3GkCn11cmdXjw/uuJQlwy9Z1sw30P4EY18hD+CudBSpRtNPFqyGzlXX7O0RzRFwNanOkcru6CVPSlUXfUXaQtX8BnbXuSvA/gceZCUJu1MkrDtKMox91IBJn6Dzi3wCupnJeRjiHrVMhA5UC3Jtc7qorv5Li1LY0xDFOE+ICcfBYRyfAxxn18FxORa4d+gMsME2xSJHc1W/N2ryrhvjK6DE7oiDmRwUWvbFFQEYK8nrqL3BqVoYy3X62NDEnOlkoTUEf23rEfSSNfgy3iZ50usxcUI907oQgB54UENywcmGOOjxNQ0n/eDN/VDxJuweRLglKUfBP6HNRfoJU6qbAYlQW8zvVD9nwl8SfhNTwaQOgSYmiUakO7v83XxQDUNN6lmp6NYhxWonA6GpxPdyPUq+mrr+8zEGGcc7Y9x0hyVyfio8demhDT/HtgCIBXNnI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7495.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(346002)(39850400004)(451199021)(2906002)(478600001)(6486002)(52116002)(36756003)(2616005)(6666004)(86362001)(31696002)(26005)(53546011)(6512007)(38100700002)(38350700002)(186003)(6506007)(5660300002)(316002)(31686004)(7416002)(8936002)(8676002)(83380400001)(66946007)(4326008)(66556008)(66476007)(44832011)(41300700001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmNET2YvQjczUHJ2TWczbGFkallnZmlIU1ZKamdKM1VyWThKVlJpRG43aU1K?=
 =?utf-8?B?UURhWnFRMkYyRlk5RTdyUk5zRUZ2eHFUT29uQ0VDdjEySHM4RmRGN2VuMnBv?=
 =?utf-8?B?TkMzSU1xUjRXL2NqZm1jZjErTnVWUVoxMnJ5TW9Ha1cvSmhPL3dBY3NRMS8x?=
 =?utf-8?B?SUh0M0oyRHhWSzFJdG5YSHpsNkJTVnN2ZURmWVVJR2hydGtaeTRDcnI0SzFT?=
 =?utf-8?B?eW84eXJiMyttZzBXQWdoR0J6QXhwaTB6bWFBczU3dzZkaS9VNmNiZHErWjRC?=
 =?utf-8?B?ZzNGMnFJY1RxREJFUy91alZuemZKZ3haMkFCUXc3S3U4Wkhacjc5dEwrMUlD?=
 =?utf-8?B?aHdwOEwrQUJUa0VveG1OQXlBU3VWdnVvRmhaejBaOVM3TGxJZ1FNYStoMmpt?=
 =?utf-8?B?eGxlbG13ZnpMelZOUXRxVGNOQnB1TlpRLzZlMFU5dE5jbnZ6cDJpN002Y0I3?=
 =?utf-8?B?YXNaQTBJaDJ3K3lYalI5TUdGM05OVmRVZWZHUStWM1hXTmFjR2NRdnhIV3RG?=
 =?utf-8?B?QjdXSXJGeTlDN0JPS2NmaTA4Yk5qQWlTYi9yYU9DQTRLWWxhcTFKbGNMOE0r?=
 =?utf-8?B?ZU1aem9LOVRpRW1YcURpcHNWVGxwSm5JVmNoeDBGc3l6T2xkWE1kd2JpQWVO?=
 =?utf-8?B?Qm80YnNOWFphb3RHdGlONlZmMUVWR1VPa1hPRUpUdFgrTFV3RjlxOEZ5bzBW?=
 =?utf-8?B?NHNrMlR2L3dwQ1ZGWUl2S25oeDZ3bkRYRm8rcFFiYVpYSHhDeVE4Wlo0Ukti?=
 =?utf-8?B?ZDF3a3UzYk12TU12Q1gzV1NydzVFYitYZUthQXlWVjc1MmJtMTdubmFvcUt5?=
 =?utf-8?B?RTEwMFh6MUIwUVQ5UVdWei8veWpta2I4UDFBSXpiM1RIa1Q4TnlZcnlFZFR6?=
 =?utf-8?B?VklVQUV5aTgyMmNoUE1oZTlSZXlPVWE4c1h4Q3JJbWZ2SERtMlFvL3JGc2Vo?=
 =?utf-8?B?dDhZVVdNVG03NW5aTTl6SUMxUDUxSDZQeVRpeUduSWpuT1dCRUFNd3BtL2cy?=
 =?utf-8?B?dWR5MjJZM2N5cHhXc1dqRWlhN2t3UEdVNDZ6MldlTzM1RExtK3ZuZ2hnZ0NK?=
 =?utf-8?B?VEh5eDV4OXY0MllFY3RobDNYOTFhY0IrY25vYm8wbzVCUnEwMG5JMWZiRTdB?=
 =?utf-8?B?eTE3eU9QOGNuc3NENnM2a0ttYlV5RVNwNDhFVlBqRjcrd1hIdWtSZG5ldzBx?=
 =?utf-8?B?RXNheFpmZmxibWhKYVE0dUJxWGFlMDV5azlFZVpXblQ3RjBoTUdQWFQ0ckhE?=
 =?utf-8?B?bXQ4Tk5LRythaUpwNlV1R0pWa1ZXaFh1MU9nSFJVMVVnRW01K2FIYkNHeWJF?=
 =?utf-8?B?aENjSEJMRXBsNHdiMTYxOEhvYW9hNHVPSWpvblIxUW1SdHRORDMwT25TYXR0?=
 =?utf-8?B?cnQwSjVYMDdzUlBhRmRJcnArSnJXY1lqRkp6MjBIREJNVE9TVDJYdXR2ZHZE?=
 =?utf-8?B?Q3d6Znpxa2tVM3pjejRxaWt4ZXFWL3F2RGt3TzhxNHlHaFpWRWdSbmdHVUw5?=
 =?utf-8?B?TWJ6NEUxWUcwaEhqVFVrUm1PY0huVWErUXRqYVhyUzI0ZGR2bkxLM2ZLQ2Jh?=
 =?utf-8?B?cDZCNGFSN3A3MGdxQjRJMlhQOWJLRUxZSldYWWJFM2l5RXg1Nnp1aDdyS2JB?=
 =?utf-8?B?SWtsUExJci9wcnZDQmpJSVpKVFNzV1RwUklraFFack5uMjhvNWlxODdSbWtS?=
 =?utf-8?B?V1NSNkhUMVBuK2ZYYTFvTUxJWlVaZjhUSHkvSThWdFJBTXpKc2NVLzZhMUM0?=
 =?utf-8?B?NWFGeFVhUjVOcWUvRGlOeEZNU2JCRnVZZnhhVHIvYnVhdmRTU1d3WXRGVGx2?=
 =?utf-8?B?UnNWY1NBQXByLzF1VkJ6VFJ6WGdkODR3enROalhPMDMxNjVHRDJLR21zVkhk?=
 =?utf-8?B?SVZ3ZDZ1SjliN0R2R0FRa040dmNacVRsTXc2dFE4TVZNUXhHSnc0b0g4Slgy?=
 =?utf-8?B?QndLUGdVOFBQK1ZqcXY1NWViZmttVjkzSTc3a0luMEg2dHM4VjBHRnMwM1Fa?=
 =?utf-8?B?WVdNcFIxUS8wVlRhTm1JL2lJRXEyWVVDS1AxT2M2SXhrUXg4ZW5LTGNqaDNQ?=
 =?utf-8?B?WlQxUENYaFdONEI3UkVrU0hGczZaN245WWV6Y1E3WmZncVBQNWZkMkFHV29J?=
 =?utf-8?Q?sdO46fdDNdXt+5968Z0RqaVl1?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441669c6-aa3e-4536-37eb-08db67cfd823
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7495.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 03:24:18.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQPVrSFOeWzra7SVwxgFKLXxtcgmJKyno4fKiuBBeoPQXBrkZvweXVeUAPVCI917sRdPPGxEdst+bMqVPEJElw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6451
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/8 5:18, Arseniy Krasnov wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi again Miquel, Liang!
> 
> What do You think about this patch?
> 
> Thanks, Arseniy
> 
> On 05.06.2023 22:15, Arseniy Krasnov wrote:
>> Both operations have no effect.
>>
>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> ---
>>   drivers/mtd/nand/raw/meson_nand.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>> index 074e14225c06..50d3110ad321 100644
>> --- a/drivers/mtd/nand/raw/meson_nand.c
>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>> @@ -595,12 +595,12 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
>>        cmd0 = in ? NAND_CMD_READ0 : NAND_CMD_SEQIN;
>>        nfc->cmdfifo.rw.cmd0 = cs | NFC_CMD_CLE | cmd0;
>>
>> -     addrs[0] = cs | NFC_CMD_ALE | 0;
>> +     addrs[0] = cs | NFC_CMD_ALE;
>>        if (mtd->writesize <= 512) {
>>                cmd_num--;
>>                row_start = 1;
>>        } else {
>> -             addrs[1] = cs | NFC_CMD_ALE | 0;
>> +             addrs[1] = cs | NFC_CMD_ALE;
>>                row_start = 2;
>>        }
Hi Arseniy and Miquel,

The two zeros indcates two column address. maybe we could use the micro 
"COLUMN_ADDR_0" and "COLUMN_ADDR_1" to keep the nfc command format "CE | 
ALE | addr" consistency and also let function 
"meson_nfc_rw_cmd_prepare_and_execute" be more readable.

Thanks,
Liang

>>
