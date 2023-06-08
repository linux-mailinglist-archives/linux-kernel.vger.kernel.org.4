Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50D7728031
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjFHMiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbjFHMiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:38:03 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3AA2D65
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:37:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cC1rXmgapwIVZOSEzW01DwoPng4j3pWbmC+OKDYk7PFKzhGOQyJeg/8tYKO6ggrbis6bAEmM1Bbs0hM1uMSOCHtrQJVx0ZDVSCwdMbyKI2BjX8ndEg4r+uqyQ8iG2Ar/a5RD2S8f8VO/z6iHG/I1lBU9R3aGhNf43FLeKMJtf7N8ZLMVPd+ouVuqjspgEAb3hqLrL20i+NkgmB6iDf1U8G9LaQjiZltXyCkiiy9xaiDUzeth76MkFtyutUmtFLEkYNFoq85utdhSFjcTUSmEhwE3tAPFwKCdAa5fRhj+v8oFO8JCmxUrVr7uaqbGSIEyiehu0jXQ1HdiqncAJZltSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60OfE/y1Y5llXFsGxhXJohNWdkdbNZKF6eK59ADDXI0=;
 b=ARAs7CG0S0F++thb2h7fnALCW/GgWfR/7TIfL0UDAhkApUhteVi4eee+FXq1DJ+UNlDclEBljPGhLEitAU92Urt9iPeVLRf9ddBLNfeFyQRdCRseLaUgxKuDjPswds50lFsX4Yi5jJv7FieS26u1XMheVNgnAHwzZ5/fw3i4N1lCmzg4oMIWRmVdqlHULACCq24CV+S2rpTnbW6ht9SKr0lzyCsh9UL7enjfbYi1txVvG+uXCPP3+rcvTQZzXgk2Ea612t1F0LtrxkvIjpZNw5vbPdqjgaR/lrNTiyv/1OnmC44cXZN7afb3Fh0dNNTrComW0Vk20wzbB68Gp8VgHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60OfE/y1Y5llXFsGxhXJohNWdkdbNZKF6eK59ADDXI0=;
 b=cZsD+P9xSeTYaj5dZw72W7habpiHi3Tbo6crqb8PyZG1JpfSinGocaCxpwMBcRVqyJPGhwskPl8mNenIZ+7UBhjUilseVQoNYiCDkdWnKmdd0lEKtKN5nTlMUzdUL7OD9iSwdALv9WrnN2g+yV9YU72yM8g7AtoWTTcxRdW+3OyRJEGM45nX4hvSF4tXYyKfhxguswZoa1Z1wrWjn/uK/MYOZZRLhM5zTFwB/58REIETift/LjFKzZzVY4/XW2vn1Qefe6hGyJzcOp9QtXJ5XpSLSD+0VyK9tvLR60WRDOB4J/2apcaL9x5iipSaF4WP9F9wvRTrCuUmipBdrtK4bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com (2603:1096:990:9::6) by
 SEZPR03MB7702.apcprd03.prod.outlook.com (2603:1096:101:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 12:37:46 +0000
Received: from JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::5e9e:bcd4:e9d8:548a]) by JH0PR03MB7495.apcprd03.prod.outlook.com
 ([fe80::5e9e:bcd4:e9d8:548a%6]) with mapi id 15.20.6455.028; Thu, 8 Jun 2023
 12:37:46 +0000
Message-ID: <a6a20b50-02b0-53c0-1e65-75035bc59c87@amlogic.com>
Date:   Thu, 8 Jun 2023 20:37:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] mtd: rawnand: meson: check buffer length
From:   Liang Yang <liang.yang@amlogic.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Richard Weinberger <richard@nod.at>,
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
In-Reply-To: <4e6cd8a8-f618-4bc3-5fa9-eab2b501dd89@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0038.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::9) To JH0PR03MB7495.apcprd03.prod.outlook.com
 (2603:1096:990:9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7495:EE_|SEZPR03MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e5e945-eb8a-490b-caf3-08db681d28ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYQi+2zPAYqzjruX1slpvi6EyJkWOoemsuyG4WSU5KqNtCEPfLHpUIRlyGPLQdYv6RXqGLtulswY1BVYaMDLfSR32E2yY97jDCmfWjsrt0pwDsLaOOMfpWlQjk7BJDHaLiQz3UwKW9GQZoidYZvzWjY6rOJdYOfHj+gdOnsckN9xDWx0K3M1Gpjishgvk4mSJbaimUOjCTmDIdxjx1SUGcxOfnnA4fzVf2H7AtC8zsMSTZfETT2dDRedcS9eifcVlUuO8IZhJZRcxQ0S92NGsE1MVg/w0mnXDE74aPYq695SjLYTKO1Lo7lAKofC9Pd3wtnE0O8pdj9DHB2IPDUq62xqPcTgRy43cnV38NYLInQ1kMuKuZyWPGJCTHFs1iC1Y7WRtgyH/0/IhjNP9uKU/ib0zHvWs0tQNusMBDIDc4hd2PAmy7RCf+mUDAGTWpkFVDON8vqIjTWBdx5FXA4wYj+18xLVN/EFe3Ow2CvS3sDmtldIUU+tIBhdU/JCKQAlQ4BP0B46/BNcqzpHiCO9EePTiQY4heipSAg65FeZtjPd4UzoPzTUE/9ByypCakFjEpLEYnSXcX4ngBWBtfSyg5i0vRBmx1n/nqfYeybjteobF5s0wX4E5ABUZaJnH24YVhhrz84n+DIv1B7FQ/+lxPPw7YeHt7wFUadtw1o41Dr5tpotIq5TSxbENw6MPNFQx8563B2AEZeV+VwRsA0CBWv0bWe5/DKXtKhaAE3EmUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7495.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(376002)(136003)(366004)(346002)(451199021)(2906002)(44832011)(36756003)(38350700002)(38100700002)(66556008)(31696002)(54906003)(110136005)(52116002)(6666004)(478600001)(6486002)(66946007)(6512007)(8936002)(8676002)(4326008)(66476007)(41300700001)(316002)(66574015)(83380400001)(2616005)(7416002)(53546011)(6506007)(186003)(26005)(86362001)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y01aSDNYNTEzWTNCd1IrK1VlT3JRM2FMTzlneENiL1crRHBETmJVNnZmNVkr?=
 =?utf-8?B?T1lITHQ4Uk9WK0xUL1gzLy80Tm9XZkdaejJnREZFdmlyUWF0YTdXZkx2NnVQ?=
 =?utf-8?B?czQvQ2hGVCs3UHhjMDVoWE1QV0d3L05TOW1iNVJaZW9Nc2NuVkFzRCtwWFZx?=
 =?utf-8?B?bVBlN1ZTSk9rb2thYlBHSDVPenphN0o2R2w2b3hUMEJYdWczUThFSGJQRElz?=
 =?utf-8?B?TlJScUpUZURQMWRSa2dHRE9yNFlzQlJONkszQ0phaHlvbCt5OHVTRDRsdVc3?=
 =?utf-8?B?bFJ3MDdhZGZmQXhIVit5d25PNFFCVFV3OVVIMkdoRjRCZkpkUnM5SzZQNjI1?=
 =?utf-8?B?U1dTNWg4VDQyQURLOWtzLzFMQzFTWVVQYnIrYkUwYVYxVDJ1MHdCTlhabnhM?=
 =?utf-8?B?ZjcyR28zS2Z5MmV3ODlWUXBSYVdrUU9NUHpoMEZBcVVYeHBvcHFLd29OWWts?=
 =?utf-8?B?V2ZxNFl1S2Q0SVNNbGZoMTZNTWVqR3NJSjhMVm9vd2NyaGV6M09CU05uRkJw?=
 =?utf-8?B?cDJMa2t0aDNUZ3d1czVpcTluMzhva0lsR0FaVGM4LzFjQi9qNUx2Zzlza3VO?=
 =?utf-8?B?V3dqMTVZeFEvL0tKbDJMc3pkbVdQc3lyYVdjR1lYMU0rVUNkbDJtR25KYlM2?=
 =?utf-8?B?bnFzV0ppYUwrYU15WUdjQzAyMi9mOG11MVNaODJxTHpkMXB1Mms5TDdGRmdG?=
 =?utf-8?B?VFgyaDZzOWU5N0QwakRYVlRiWTdGQnlMeUtuS2J4TE1rb2x2QTdkemVLVW5F?=
 =?utf-8?B?WndueVNqYmJCNnU4UE1RaVNQWFBKYU81VDhvMlZmZDVOckl1dUF5bEFEMzN2?=
 =?utf-8?B?dCszd1RGTEtaalVOTmMvZEFOZUdrTVNKNzEyQ0RIeFUrSm13YTVpd2ZhaWZ6?=
 =?utf-8?B?YzFySXdPL3p4eVFMa0o3WFRzeWdWRGlQc25scHkvS3pyM2R3TzkwS1p0ZWpw?=
 =?utf-8?B?eHNhWEJodHlodFo4VnN1N0RJL1B5ZEZXV2FRaE44OFUrc3F0MFJJbHhCdFRE?=
 =?utf-8?B?ckp1Q2VubTdjMVBjN1FQU0FRUDRUREpQRXcvMmF6dVNFMkY2OXNDTzlQbGZF?=
 =?utf-8?B?S2QxaEVoSjFYZk51VGliZm96TXhVTUo5RUwvUXRXQStUSHdSNHhXZXdkVG83?=
 =?utf-8?B?a2ZneGJ4ZFR5ck94cXJ5T0VXSVhpaU5UaW5ZU3luUkZjTmR4MTZzOHFlaFJK?=
 =?utf-8?B?Tkd4bHhSa1pSd2NTdUw5Z2ZDTk8xVHRWb0c0dWRydWMyNWlhWHcrNCtXVk1E?=
 =?utf-8?B?QVErTUh5d29JOWVnVng4RHIzVCtRSCt1YmhPcWU2SFoyZE40eGtES1ZyNTRm?=
 =?utf-8?B?VDNYODE5NmUxaVhxN1puMXVWbjZRODkweVUzSnhtZVZzZnVleHM4QVdDeTdp?=
 =?utf-8?B?a2JPU0N1a3h6SFhVN2JHeWhSU3dUQ29pZi9lVGZyeGNHSDFndmpaMDlKSDg4?=
 =?utf-8?B?djUyQUR6R1UyZTBEa2VCWGNzMGJUQ2V1S0tiUFhYMzJVZENLQW9VZkkwakdm?=
 =?utf-8?B?RFg4TlJyN3hzVUNqUWdqZ2dlRE5jeVg5M0FIRnZ2M1lNVzZ3L2hBTDY5YTlt?=
 =?utf-8?B?dmlwODBUSVJUQzJ1b3o3eWdPbi85NTBuNHdkdmJUTVIzbVdYaWcxUFl3aUZI?=
 =?utf-8?B?bndwd3pLdXpGNEMySmVYMTUwWGZLZFkrdkNDS1RtdVRJTHNEa0VjaXVoMU1E?=
 =?utf-8?B?a3plcEY4YTdGdnVpZ1hRZU5ydVRRbkZETCttTkVnWkh3SFJHdmlmZDBqb21p?=
 =?utf-8?B?cTRQc01hczVocVdWMks2UEpSZTY1cVAzSlJFUlZqS2M1eXFQYXdtNHBVc0hZ?=
 =?utf-8?B?cGtaL1l3MFFBMjJkd3cvY0JhZEs5YVhzcEozZCtIRDF3a3BZcDV3MkZHWTdZ?=
 =?utf-8?B?VmRSN2srMldTQjU2RlN4ZXJRQzJJNGY3TGhPZHN3OUw1ek05bWl1ZlVaNDNi?=
 =?utf-8?B?N1dQdkF1SlhycXNRQVZGRlF3TmxPbXpvTzBvSEt0WHB5eEhZamIyTCtRVkkr?=
 =?utf-8?B?S3lXUng4dTREbW1Sc25vVGozWlV6bnZJWGQ1ZHN2cjU4NjN3KzY4NFB3VDIy?=
 =?utf-8?B?aCtnNmMxRzJzNnU3empPSG5xZ1F3WXo0K2ZFWnQzcDZ6aVl6M2F2cXVaeXl2?=
 =?utf-8?Q?zHANzZP/39uNxcosiKA5HWmYo?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e5e945-eb8a-490b-caf3-08db681d28ed
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7495.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 12:37:45.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDXDOiO3uFx5SNWdSrdBWYdbSaax/dRmvmQPmXsRxYHRxlAWDjo9qOJx1NiUTEACf1RY+cP9deCLAyd+uGqJEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7702
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy and Miquel,

On 2023/6/8 15:12, Liang Yang wrote:
> Hi Miquel,
> 
> On 2023/6/8 14:54, Miquel Raynal wrote:
>> [ EXTERNAL EMAIL ]
>>
>> Hi Liang,
>>
>> liang.yang@amlogic.com wrote on Thu, 8 Jun 2023 14:42:53 +0800:
>>
>>> Hi Arseniy,
>>>
>>> On 2023/6/8 5:17, Arseniy Krasnov wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> Hi again Miquel, Liang!
>>>>
>>>> What do You think about this patch?
>>>>
>>>> Thanks, Arseniy
>>>>
>>>> On 06.06.2023 19:29, Arseniy Krasnov wrote:
>>>>> Sorry, here is changelog:
>>>>> v1 -> v2:
>>>>> * Move checks from 'switch/case' which executes commands in 
>>>>> 'meson_nfc_exec_op()' to a special
>>>>>     separated function 'meson_nfc_check_op()' which is called 
>>>>> before commands processing.
>>>>>
>>>>> On 06.06.2023 13:16, Arseniy Krasnov wrote:
>>>>>> Meson NAND controller has limited buffer length, so check it before
>>>>>> command execution to avoid length trim. Also check MTD write size on
>>>>>> chip attach.
>>>>>>
>>>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>>>> ---
>>>>>>    drivers/mtd/nand/raw/meson_nand.c | 47 
>>>>>> +++++++++++++++++++++++++++----
>>>>>>    1 file changed, 42 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c 
>>>>>> b/drivers/mtd/nand/raw/meson_nand.c
>>>>>> index 23a73268421b..db6b18753071 100644
>>>>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>>>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>>>>> @@ -111,6 +111,8 @@
>>>>>>
>>>>>>    #define PER_INFO_BYTE               8
>>>>>>
>>>>>> +#define NFC_CMD_RAW_LEN     GENMASK(13, 0)
>>>>>> +
>>>>>>    struct meson_nfc_nand_chip {
>>>>>>        struct list_head node;
>>>>>>        struct nand_chip nand;
>>>>>> @@ -284,7 +286,7 @@ static void meson_nfc_cmd_access(struct 
>>>>>> nand_chip *nand, int raw, bool dir,
>>>>>>
>>>>>>        if (raw) {
>>>>>>                len = mtd->writesize + mtd->oobsize;
>>>>>> -            cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
>>>>>> +            cmd = len | scrambler | DMA_DIR(dir);
>>>>>>                writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>
>>> I think we could keep "& GENMASK(13, 0)". it is better here to 
>>> indicate how many bits of length in this command and don't destory 
>>> the command once we don't check the "len" outside of this function. 
>>> or the code "if (len >  NFC_CMD_RAW_LEN)" is better to put inside 
>>> this function nearly. Thanks.
>>
>> It depends who calls this helper. If only used inside 
>> exec_op,write_page_raw() and read_page_raw() also call 
>> meson_nfc_cmd_access(), 
> but i don't find where constrain the "len".

Is the helper "meson_nfc_check_op()" needed by exec_op() after the 
constraint in attach_chip()? the length passed in exec_op() seems 
smaller than "mtd->writesize + mtd->oobsize" now.

@Arseniy if it does need, I think the same constraint is needed by
"meson_nfc_cmd_access()"

> 
>> it's not useful. If used outside, then if you want to clarify
>> things you may want to use:
>>
>> #define NFC_CMD_OP_LEN(cmd) FIELD_PREP(GENMASK(13, 0), (cmd))
>>
>> This is by far my favorite construction. Could apply to many other
>> fields, like DMA_DIR, scrambler, etc.

@Miquel, FIELD_PREP() is better, but i have no idea whether we should 
add FIELD_PREP() in this patch, or keep the previous code.

>>
>>>>>>                return;
>>>>>>        }
>>>>>> @@ -573,7 +575,7 @@ static int meson_nfc_read_buf(struct nand_chip 
>>>>>> *nand, u8 *buf, int len)
>>>>>>        if (ret)
>>>>>>                goto out;
>>>>>>
>>>>>> -    cmd = NFC_CMD_N2M | (len & GENMASK(13, 0));
>>>>>> +    cmd = NFC_CMD_N2M | len;
>>>>>>        writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>
>>>>>>        meson_nfc_drain_cmd(nfc);
>>>>>> @@ -597,7 +599,7 @@ static int meson_nfc_write_buf(struct 
>>>>>> nand_chip *nand, u8 *buf, int len)
>>>>>>        if (ret)
>>>>>>                return ret;
>>>>>>
>>>>>> -    cmd = NFC_CMD_M2N | (len & GENMASK(13, 0));
>>>>>> +    cmd = NFC_CMD_M2N | len;
>>>>>>        writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>>>>
>>>>>>        meson_nfc_drain_cmd(nfc);
>>>>>> @@ -1007,6 +1009,31 @@ meson_nand_op_put_dma_safe_output_buf(const 
>>>>>> struct nand_op_instr *instr,
>>>>>>                kfree(buf);
>>>>>>    }
>>>>>>
>>>>>> +static int meson_nfc_check_op(struct nand_chip *chip,
>>>>>> +                          const struct nand_operation *op)
>>>>>> +{
>>>>>> +    int op_id;
>>>>>> +
>>>>>> +    for (op_id = 0; op_id < op->ninstrs; op_id++) {
>>>>>> +            const struct nand_op_instr *instr;
>>>>>> +
>>>>>> +            instr = &op->instrs[op_id];
>>>>>> +
>>>>>> +            switch (instr->type) {
>>>>>> +            case NAND_OP_DATA_IN_INSTR:
>>>>>> +            case NAND_OP_DATA_OUT_INSTR:
>>>>>> +                    if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
>>>>>> +                            return -ENOTSUPP;
>>>>>> +
>>>>>> +                    break;
>>>>>> +            default:
>>>>>> +                    break;
>>>>>> +            }
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>>    static int meson_nfc_exec_op(struct nand_chip *nand,
>>>>>>                             const struct nand_operation *op, bool 
>>>>>> check_only)
>>>>>>    {
>>>>>> @@ -1015,10 +1042,12 @@ static int meson_nfc_exec_op(struct 
>>>>>> nand_chip *nand,
>>>>>>        const struct nand_op_instr *instr = NULL;
>>>>>>        void *buf;
>>>>>>        u32 op_id, delay_idle, cmd;
>>>>>> +    int err;
>>>>>>        int i;
>>>>>>
>>>>>> -    if (check_only)
>>>>>> -            return 0;
>>>>>> +    err = meson_nfc_check_op(nand, op);
>>>>>> +    if (err || check_only)
>>>>>> +            return err;
>>>>>>
>>>>>>        meson_nfc_select_chip(nand, op->cs);
>>>>>>        for (op_id = 0; op_id < op->ninstrs; op_id++) {
>>>>>> @@ -1293,6 +1322,7 @@ static int meson_nand_attach_chip(struct 
>>>>>> nand_chip *nand)
>>>>>>        struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
>>>>>>        struct mtd_info *mtd = nand_to_mtd(nand);
>>>>>>        int nsectors = mtd->writesize / 1024;
>>>>>> +    int raw_writesize;
>>>>>>        int ret;
>>>>>>
>>>>>>        if (!mtd->name) {
>>>>>> @@ -1304,6 +1334,13 @@ static int meson_nand_attach_chip(struct 
>>>>>> nand_chip *nand)
>>>>>>                        return -ENOMEM;
>>>>>>        }
>>>>>>
>>>>>> +    raw_writesize = mtd->writesize + mtd->oobsize;
>>>>>> +    if (raw_writesize > NFC_CMD_RAW_LEN) {
>>>>>> +            dev_err(nfc->dev, "too big write size in raw mode: %d 
>>>>>> > %ld\n",
>>>>>> +                    raw_writesize, NFC_CMD_RAW_LEN);
>>>>>> +            return -EINVAL;
>>>>>> +    }
>>>>>> +
>>>>>>        if (nand->bbt_options & NAND_BBT_USE_FLASH)
>>>>>>                nand->bbt_options |= NAND_BBT_NO_OOB;
>>>>>>
>>
>>
>> Thanks,
>> Miquèl
