Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35177480DA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjGEJaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEJaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:30:11 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2130.outbound.protection.outlook.com [40.107.117.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DEB12A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh2gpgIplHqTOygcQiKg+SK6GjMpvdJkvLaWmOJgXR4rPYmQnC+Z7l4myje9q1KGs26nhtsc3+USdDA0dtVxfs5DslOlNwwF7BN/o2MJrSIQoLgj7rhqFXyzV0qPWTAiYaZZQiR2GMUvy2SW+JeNMRSQDtuD0Usj4t7NMmoYJk/8gPOO//8coeMmffAoZlJ5DBDufM/z4u1kg9fTD+rlt7QyTJJv7eV8pVu2BGE3N8wRqP/nEGnY+1BzIoUinPnebr5sBAdkQDA53OFrl9vInufygbzebRMeP8xuJfaV88jbJoDxkze1zVzXeVBByM07rCrzUZiYDo+3+ZYQCLd3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1M8NGNZyeAytfy/Us4OP0BaUwYu24+dwfpezAeOTqrw=;
 b=PFl6/iZTwQdXkhPgfeqF9NfWQaTC52pHnfVEtZ16yz/+fgh6qFZYygWgXdUIu9Wb/DBvdbHWfNugjkN4kbkqwRu5/K5zGkfrAECEsIuLH9N17vYva4oZIh/uinYRZotI9haYw1iUcJB1qGW2fKAI05LeJaK83YncwXxhFGvOksnJW7nSUsiLo2IlEsCnY7Injo+XSo7Dfy+sV+eJYpi/Au5SeDPX6zhIhJPOmRKaGOkhhSOaiofgFpDW/raV3TdyigbkCqK9HKYT5C1UogEhZN2nZgvbA+XqwDMl9LfUMvkEug8ianeisf+B/7EuZ+GBAIiCVggdsAITpVsc4nS5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1M8NGNZyeAytfy/Us4OP0BaUwYu24+dwfpezAeOTqrw=;
 b=fzTkFGly9HSxJECB5lncSEUhIbFgCohVRD+la3wbaqmFAwpwFANu7bDdizbhKRjxYMQRU7v0DDNhz7WJ/XJEMsqF2AVthAk10eeR7isBMOOKo3V60XqrkZTXucitwSKQ+mzCCYB1RocUBzN/XkqEVYM866rlEPbxbcplJxLiNEAjO3XX+63MPy9jB5MUnabd85eZS4AHxoL1Ij8bCbtxlJp2iFtY+bsz5Wh8jhpWLLIzweDGv5PdgP2BmTXdjMH2RhF38djrSp29uK/6nlZylaHSvWoDPjuS19NMrs+NOhjEUYazX9IdaBblCAsfKvjmhtQ7ttA3fySF48bN3pn5hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4416.apcprd06.prod.outlook.com (2603:1096:400:67::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 09:30:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 09:30:06 +0000
Message-ID: <6a1bde36-fbf9-9ddd-e47f-f3c21a3528f7@vivo.com>
Date:   Wed, 5 Jul 2023 17:30:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/4] phy: mediatek: tphy: Convert to
 devm_platform_ioremap_resource()
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230705090126.26854-1-frank.li@vivo.com>
 <20230705090126.26854-4-frank.li@vivo.com>
 <ddc05f70-7075-97ab-1c94-cb3d5839ef2b@collabora.com>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <ddc05f70-7075-97ab-1c94-cb3d5839ef2b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 19500207-10d3-489a-96fa-08db7d3a6b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/+uSO6qaassbIidA5jU4EvDS9hm5C3XUHdYI1sul37+OKkjXDVY/MRy3OayQlyJoN7Fdd8xYNEE7HCAjYktVXlq5JqMDqVb/n9qkZZ4mKWCSd4sarCBNC1EGjj/8uFg+sUDM8dY7jWzWXvijPm2qsf3iTuMFV8VV0fzxcKG3qE8uqpp7AZGci3t6D+CHeRVlYPcm8wKxuyKifS78dymdp60sZu2evzC+RZLaAABL3x//IGaxCpU+aFInVvE88cBphwJofoy7f78H0F0nOlpqseIWM8V0T4rmChA4mxe4JkB8OjRirn7shKcno5ZlYaluAJuMpDcKShyGp3JxSvOJ0smw9CRp5H1Wm0exqs1bBzL4ZQQedN9mahGN3HzmcNRvF30zTVYuTwf6Myy0iwhhkYxiuUai4ae3inRV+hKTooeBbWei335uzMjHKJCc1yFOpHaVWfmLZLneWFl2uWwo72axgbfeUy79tJzw9d9Bu9Xs87vNDF5PQM432swtsbSv5zCqFQRvNOAUfSAzvBS3fAssPP1ACE4cjNltriUoB9Czrb8zTxZgruWbBADrTuBaIS+i7aPqY6KEw8rxNpoJGvrI1ZLKdbDqCBK9g8e6VraCVJ5Mag7j1EZ8ZeMG77gY7xX7MN6jYfcxrPvuxTuu8IHMMSAVn9D/3qFpRkl+fDFqwO552FfQp4pUHDtZXDB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39850400004)(136003)(376002)(396003)(451199021)(31696002)(41300700001)(86362001)(6486002)(38100700002)(38350700002)(6666004)(52116002)(83380400001)(53546011)(6506007)(2616005)(26005)(6512007)(110136005)(478600001)(316002)(36756003)(66476007)(4326008)(66556008)(66946007)(8676002)(8936002)(186003)(31686004)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnB6K0FSUWVJb2xWTjdwL0dkOTVXc0V5ZFR5TWs2cGplT1NOR0hFUW0wRmJN?=
 =?utf-8?B?WEZlZjlYZ0Z4QVlYOC9zVTk1NUQvVG1hcU9CYjQ1SGJyeldGa3RpVXMreDk1?=
 =?utf-8?B?TjhESU9pVXpaVXZoTDA4NDlOK1FCbTJVK3FPMUhHVXJ0aTNXQi9vZ3NHbE9Z?=
 =?utf-8?B?VzRQT25sa3hRaWhzemI3azZ0M3N0azF2UE1uUC9VdEptcU1CTGRmalc2NE96?=
 =?utf-8?B?NDJhMnA2K3pORDhhd1pvRFh3Q05JTkV1U25GQWpRdXN1Y294YTJWSVpJUHFG?=
 =?utf-8?B?R1g2RmR2VGIzU2tCbm9ieG1VakZ4ekNVait0NFNvQkVVdHBSdk1yZXBjM1hr?=
 =?utf-8?B?NGtEQXFIT1BvUG1XUHRXZnFRZlEvMVZ5Zlp5YVpyRkpHeklabjVoblprM1Fp?=
 =?utf-8?B?Z1pIS1dCT2dBQ2ZwbTZpaVV2amRtWVE4aXYyQUptbTJZdFI2VHl6cXV2bFZp?=
 =?utf-8?B?L3UvZ0J3MmZSY1dxc1dDVTVZeEp5V1orTGF6ckNWcHNxeE9VTU8reERHRnR1?=
 =?utf-8?B?bStWOTFEMjBZWE5sZFpUM1IxenZpa1VHN1ZGTUp3QzJmdlpFTXgrS3RYTTdN?=
 =?utf-8?B?Q3B5UGtOMjJjNUxsTXF1aTdkalYwNkJ5UlZMQXIyeS9Rb2twM2tXc01JSEJm?=
 =?utf-8?B?cEh2QkF4N2dIMkFSeDVPQkpvQS9jYjNXS3VFUklmMUNGcEpyQWxqb2lOc05s?=
 =?utf-8?B?cElIbTFkZ0ZyZnJoRDdlbGhiTTZiMTBORmQ5R1ZYYndBbVYzaGFkTldNcmlo?=
 =?utf-8?B?MVRRbkYyYUJ1L005UjJCamgxbmptMUFCS2hiZ2p5bVVHWk41RllVV2ZldlpQ?=
 =?utf-8?B?Um83amNCT3pQWUJiaWlHbGNTVWdBTGpFZFJNRHBRT3I2V09xVEpyNDhUaitJ?=
 =?utf-8?B?Tk1uV3k3N3VYRzJYdnpJdVVleUtrNml0WU91UkkxZVlxRUV6ZGhxNHRzNEgr?=
 =?utf-8?B?dnV6eElGcWU0Sk5VbEYrWjYwLzlQVGJGYjZERjY1OHdiZGlJak9heXFjMmZr?=
 =?utf-8?B?QmJVZ0s1YnVINEM1QUdRNTZEUCtjcTJzcTFPV0J1ak9HM3VRQ3NJTllZL1NT?=
 =?utf-8?B?c0J5UkgwVWFncS9ZMFFmd3Rkc25sL2xhejNpeFFXRkFFRjdFZFNlZ0NlQWhk?=
 =?utf-8?B?NTV0cVpYTlNlN0txN1dKMEhTNzRSdkFmMnhCMldoUUtuTGIxK0RaVFQ5YlFY?=
 =?utf-8?B?ZGVkMThCeVFxOE56cy9xVThZc21MbG10ZEtETXJjeUszd0E5b0pMYzlYTUNF?=
 =?utf-8?B?dllMaTZCZU1mbUVFb2dVNnExTHcwakVlUllBY3IyYW0wQS9HaG8yWlFsVUNm?=
 =?utf-8?B?R050ZGEySTN3b2dLeG8vZmVtZ2dJeWxpVEhYL2Nad2RKdU91aGsza21kcDF6?=
 =?utf-8?B?VE9LSFFYeVdwbm5hZ2d3WE1PUktsUTZ0S3R4WmdLY2tIVHBLc3dMeVhiZ1Zx?=
 =?utf-8?B?NnpaajFFKzdBeU9VSWV0N0s5cmE2aHh0MUs0TWFlNkFzVnJ3VVpMZVpDd2dR?=
 =?utf-8?B?UmFsSm52aGpCSEY1NmcwVlEwVDFRRlF1R25qeGdsdFMyQjZXYnRKL3lQZCsw?=
 =?utf-8?B?YWI5OXVMVEVuaXc0WkZNS2pnRjJEbFh0U0hrT2ZVYXFybWdJOW5PNDgvU25Z?=
 =?utf-8?B?L0R6Y2hmaUZIN09QaWlqSFRoVzA4K29XekhwaDRSUGszV3hlYmc1T2puZ1dp?=
 =?utf-8?B?NFRIOHVWZXlSamNzc0x2VXVKNjIxbksydFFyRzhnTzV3RHJNV2xPNUxCQk4v?=
 =?utf-8?B?dDVLQUpiaGZ3bjBUL3MxV1FqRWVxMG1vL0kzRnZ4dE1GaEk2NUFDeTZXZ0Ji?=
 =?utf-8?B?cVFKOE9uUEZFNktPbVV2OG90bVRNWHc1ZFFyczYyZ1l6RWE1OG5yMjQwaWpM?=
 =?utf-8?B?aStZcFhBMkZEaFNYMDRNSnd6clowemFEZG1QTmIwSDlaN0ZJSTFhV1F2RXZF?=
 =?utf-8?B?cmNmMUpYNXNmbTlsOUVENUdjdjVmZlF5N3BZY01YeFB6Y1lZMGYvbnk5cGZ2?=
 =?utf-8?B?M2V3MWY0eXdEZE1La3RNNVlsQnVoaCs2S3JtNTN6YkJzcW10ZGR5K0luNWc0?=
 =?utf-8?B?azdxWVNRZFZHQkEybEUzcisyc2V2ZEF5ZU1ScGsrQ3hMUEhGbmw3akZZNEZU?=
 =?utf-8?Q?iDH1xW8mE/h51qcYYcXTumTxd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19500207-10d3-489a-96fa-08db7d3a6b24
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 09:30:06.3932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qt3dpfOcKarp4uxx2THMqJZLrKAnMt+I+nt7DfvMYCzrBtxv9nrtBKrA8PBip+Xb1swHZKaISTbafXhBnYKfBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4416
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI AngeloGioacchino,

On 2023/7/5 17:22, AngeloGioacchino Del Regno wrote:
> Il 05/07/23 11:01, Yangtao Li ha scritto:
>> Use devm_platform_ioremap_resource() to simplify code.
>>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   drivers/phy/mediatek/phy-mtk-tphy.c | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c 
>> b/drivers/phy/mediatek/phy-mtk-tphy.c
>> index 0d110e50bbfd..cb7a4e6ea017 100644
>> --- a/drivers/phy/mediatek/phy-mtk-tphy.c
>> +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
>> @@ -1554,7 +1554,6 @@ static int mtk_tphy_probe(struct 
>> platform_device *pdev)
>>       struct device_node *np = dev->of_node;
>>       struct device_node *child_np;
>>       struct phy_provider *provider;
>> -    struct resource *sif_res;
>>       struct mtk_tphy *tphy;
>>       struct resource res;
>>       int port, retval;
>> @@ -1576,15 +1575,12 @@ static int mtk_tphy_probe(struct 
>> platform_device *pdev)
>>       tphy->dev = dev;
>>       platform_set_drvdata(pdev, tphy);
>>   -    sif_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>       /* SATA phy of V1 needn't it if not shared with PCIe or USB */
>> -    if (sif_res && tphy->pdata->version == MTK_PHY_V1) {
>> +    if (tphy->pdata->version == MTK_PHY_V1) {
>>           /* get banks shared by multiple phys */
>> -        tphy->sif_base = devm_ioremap_resource(dev, sif_res);
>> -        if (IS_ERR(tphy->sif_base)) {
>> -            dev_err(dev, "failed to remap sif regs\n");
>> +        tphy->sif_base = devm_platform_ioremap_resource(pdev, 0);
>> +        if (IS_ERR(tphy->sif_base) && PTR_ERR(tphy->sif_base) != 
>> -EINVAL)
>
> That's wrong. You want to return any error unconditionally, as the V1 
> PHY *needs*
> the sif iospace and there's nothing afterwards retrying this.


When sif_res is not configured, an IOMEM_ERR_PTR(-EINVAL) error will be 
returned in __devm_ioremap_resource.

This kind of error is ignored in the newly added code, and the driving 
probe process will not be interrupted at this time.

What did I miss?

Thx,

Yangtao


>
> Please fix.
>
> Regards,
> Angelo
>
>>               return PTR_ERR(tphy->sif_base);
>> -        }
>>       }
>>         if (tphy->pdata->version < MTK_PHY_V3) {
>
>
