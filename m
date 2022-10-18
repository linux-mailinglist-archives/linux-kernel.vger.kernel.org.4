Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967646031EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiJRSCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJRSCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:02:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4323AB3F;
        Tue, 18 Oct 2022 11:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkqRPa43pcmfeFMJRQqgf3/GUNJKllX8FGUVIVNeFUNCXK2dcBU/ZAO7EQVMeZViYpyARiu23Jh0p3vEC+F9o/eCkZD+FUVAThqZQJmSyhEsyBotLeeVZKAPu4I7GIQmgVlAFdicmK/KZQVbK1YnxBI6u0EWj+LajJ9qY+HAYFIf0pRpZgcZzgdfA0SLjfWlHWIcojTongfemqqFpy7qvPd9SLYWkhKG7dFL044GXeaOpY58zgTUKeS4quIEAZQCDTtwTZgOtX0uKJB0EBXaSCLwc+KlBo3RwZ6o357JDLLZwyrbt+YB0Waa7duwbax2lpRcVcoMEmfgXRcSpmXqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLvJO76hJg6E76sfKN3go88yXXJgdrHxBI2EWbAZ6Bg=;
 b=IBdQLLJekNN5WiB3rBJIjBmuq46FJvkg3NtIftRn/uMISS0cq66sowKt58N4Ri7WYs5xAT+muPJjT7fTeHFY8FJNf6LgKy1GHaYKrfvc6vvUQN321AqEPssf5H95dbZSdJ7Tp33uFFbyb4eKoUA4WpniXf/EYKoiY1ObGIiR63qtSNS5jsgDrAfMN2v5bVhbGWXA+06lEmyhCOA2/x56TEPRFG9kKSHsryf90+f+4xcH1NfDmZfMqla816kXJRb+PppSsolDJF7H4DQ4L/2DfpCEo7kUYeIOw+pEnOLbdKzqsOnIjGy7dYAvlK7ZA6m1gPYkCTqcrhB54ApRn9BOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLvJO76hJg6E76sfKN3go88yXXJgdrHxBI2EWbAZ6Bg=;
 b=ZOLUGM/F2lYO62fO3GH23Y5TPxiHdn3UGkaN/k9jZX+nWkqfW9rNtBg6xpBRt6UQIOavmlUYCmDXNGWcPQ89kG9eImma1jrN44Z/c+Sf1VJSe62qbFr8HC9qBVba1xXdx2bGVRuf6LVshbAj3qYqmQz5Oi1xLmoK9167P89d2/6QyjvrsnKd7s5n6yyoX75R3Vpkuypv2NTrHn8U3fFw1ymmde2pJj2s7Ne9XHB4pFcuRKcrqKpyFQY2tKwdg4gsZVKjOR64FLCDqfb71dx40h3sozL3OtvkBBeDxJTnsuTfv0ZQqHUWtPOvq6Ytia4F9FMQVwLvCtMvcEfOTRpKWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by GV2PR03MB9428.eurprd03.prod.outlook.com (2603:10a6:150:e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 18 Oct
 2022 18:02:00 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::204a:de22:b651:f86d%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 18:02:00 +0000
Subject: Re: [PATCH] doc: phy: Document typical order of API calls
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221018175841.1906611-1-sean.anderson@seco.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <e002248f-7070-3f89-04f2-e7f694fad5cc@seco.com>
Date:   Tue, 18 Oct 2022 14:01:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20221018175841.1906611-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:208:a8::32) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB4972:EE_|GV2PR03MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: dd87c345-2209-456a-481a-08dab132dad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JZHCOHiDFhffnQhPqUgPkj/n95abikCU0/AJJSdjS/wv0ETLdCwFmCp0a1JKSZnp2qH5gTnNeM9jnyaZuLQEz/0cYcoyFeXCc/NkXwHQg2InM12G7LcrxxTYvS5q/xOrUav0vBbvYS7WL4t9du+C/VBUKgn6Ke3xXnPCNhqsBtp6AZfni8ic/KZEP4Qw+iPhLaUC7Y7QVpIQpiQTaOVGU8WidiMxR0U6uDYtoqaTK+W8N4GTAvT6aOmVDCKdNTsdLFmVIK69c/UcT1sK6Xygml1XfGc/wq3RFhVs130WeSRt912wz2DgRDjRWQPYxEBgkK02+DK0S6GHHoiZ2B7/fJpTEkxCCf08lIIWuS0VwbnsODrq2cAmnvWsQTwaSqIRUb8eqpMKejxJKUNNt5nkqTV4DQgl/hbpXq/908GqiUt5t/JCwqRUBi8+4KEysrhNs7CcqiWu1GbkmmZY/fDY4piiFjKvPNyKq47dcErI2M9BLr23cipoi8dby8iPA/PZhRGbzKtAGOPNPC2SBVyXSqQNxszVj9Uw1bzOor+928B+wmqSxLVQwcLeAR5jEksGwZUzmGDV8eiY2oP2UtOKu08amxROUcfGrX5gsOTo8MYyWP3CHSxxHVjkAdRNPRKdkId81/7uMl7gSxudELwvLI8/siVUSbZSqOihrd6xYpVmSgUpUs96u2zfHNw0MzW8WhAZsxkNLU2c0ek4tPJaoyiUX0G4hvsZTQ5NuOa9MylENoZG5RO2s4Zvja3KJOtvNNtMuOnig7kLpu0IhZ/5XsQ7n88MOwaqn4saF2l5izJb4hfhuMPd8BYpSsn9Q6rnDKhcVWdAE4ijOvEK+qdeLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(39850400004)(346002)(136003)(451199015)(4326008)(8936002)(31686004)(5660300002)(2906002)(41300700001)(38350700002)(83380400001)(110136005)(316002)(38100700002)(6506007)(6666004)(66476007)(53546011)(66946007)(186003)(52116002)(36756003)(6486002)(478600001)(31696002)(26005)(8676002)(86362001)(2616005)(66556008)(44832011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVZTTjRNeEgvWlEvaEVUSzhCQkVoOE91MVNxZ0dFUGsybVdRbjFlY0tMbkp6?=
 =?utf-8?B?NEdPdUVqRW9ScFhaWWxWS0tvNDdQS3FmczNDS2tCSHlqd1lQNWpSSm1IOWNV?=
 =?utf-8?B?azIrazBIOWZiWEFub3RZTjJMZ1UyVE9JYys5bFdGdU5NVmxJaHpvT3RyNDZJ?=
 =?utf-8?B?aEdhR2F4bVNRMzRHdkVjeGVCZXpCRElmY2t6YWx6SFhEcFpVcFhwc2RHTnJz?=
 =?utf-8?B?eThvbmpyYU1oc3lOUjNKdVdTcE5GMVkyRkhXejNPSHBsZ055eGpFQUFLSHBr?=
 =?utf-8?B?RENjak5MRzNWMnM4YXE3ekp6am1zL3A5UEhFblk0am56RjVHQkE2WmNiWGx5?=
 =?utf-8?B?NURBeWlraHFOQm41eWY1WDQ5TlZvcXpxVWpWVkhRSERyVHZTUGNpdWcvRWlE?=
 =?utf-8?B?eWRaVEpHV0NUeUpJTWhDTEFiK25rSWdXSFlYYStBVXFIUERLZEFBWEdpLzhl?=
 =?utf-8?B?dlMyR2pxcXNXNUlBLysvVmJOeWpXNzdQRFU0NHJwakQzemFiVGhPSm5QR3J2?=
 =?utf-8?B?WXU1ektZenl0Wnl4NmhXZHd0OEpHaUZPV3pUZzB0a0xjSnNacCtmQXdvMGhB?=
 =?utf-8?B?azBKWXJwNE5OYnVIeTdFVEpORjRTa0w5aUhieFBGcUVyT3BweWg5b2M0cGZI?=
 =?utf-8?B?RmRKTWMxTnFXOFY4cDBoYk9QWnJnVGJQOFpST1dwL2luOFA1SVRQTUk1MDlC?=
 =?utf-8?B?b2JScUowR1liMmRYYjI2RkNQMGI5YnVBMzVtNHhDd3RsdnBFdUdkQkF6Qk9J?=
 =?utf-8?B?bU44QzM2aFBTR25VVWxBOCtFVDNXTXNncFNRUzhVbEc5MXVuRGhyZ3pvOVMr?=
 =?utf-8?B?bkRIU3lxN01KQkhpbHRnTnBiU0RhMVhHUUF1VCttaWZ4UmFiTmxXN3poZGNS?=
 =?utf-8?B?RGg3WXUyNStVOGlxdWp4YVJKQnB5YmtFVUlDc1NuODJBVDNFcFJ5NlBpbHRa?=
 =?utf-8?B?clZvWVZBWkNJZTlydnp1dExRdGVyNW95QzBZTkwyUng2eXFTTm03NnFwRktN?=
 =?utf-8?B?WVJVVWwxemI2bDNYRUU2V3hTdmp1SDdYOWNNdnZ4THdWLy9ZakVzK0dXUlZW?=
 =?utf-8?B?dS9CZ0hWT1RlbW91Nzg3ejFDbCtiWmwvOVJKRi9yUXJDMjliYmJNY3JoSDVm?=
 =?utf-8?B?SjdvNGNOTXJvcC80RlhaTzVweUpYWnl5OVIzYjRIcFZHYmRqQ2JQaUY5NFlv?=
 =?utf-8?B?bSs1LzQ4bkdsL0pyZ0FSNEZtRHR2RlpLY3V5VFY4aGZtVzcrU2txMHA0MjVM?=
 =?utf-8?B?aGRiaVdRTjdPNlM3Tnc3QVp6WFNySXRpU1BUdTllOUh6OC9UbCs4cnZDbjRu?=
 =?utf-8?B?MjNmcnZoeGZiSEtmSERsQmNwa0QyeVlZVVVPaVRyOWJYUkUrNmdOeDZTRDBJ?=
 =?utf-8?B?djJjZjRpWVlIcDdwdUtpNldrOUlpNE1MRkU4UHhSandzVkViUWd3cTlPcXlD?=
 =?utf-8?B?UGthckR0T1FQZmpLT1RRWFV2azVXZTI3dStFK00zM0JKYVBhWEhhSU5wbGR2?=
 =?utf-8?B?dUxRb2pJK2JhM3JWZFNlQU5TR095dlM0dWpEK3BoZVkyNC9Ec0pjQWF4R3Ra?=
 =?utf-8?B?eDhCZERRNVprdjhxanBMajF2TDgzT05BWlVteUhWdkwzZWhKMWdlSmYwQlBN?=
 =?utf-8?B?eEM1YUg1cnVWQi81WWp3enRnY2JuNHFQV2FNTDczWlVLVEtmUkJwMHhQYXlU?=
 =?utf-8?B?YzZkandRaXp2THlyL1Y3dnNqWmpSbWpDeHlBYlVCRkYrakxPWmVmcTE4ZTRj?=
 =?utf-8?B?ODFZUzcxRWdHd01KdVJ4YW4wSjMvR1ZRNWYwUDN1TmpWMkpaU1ZVaWR3M25D?=
 =?utf-8?B?emV4NEpqMDJzcHlNclI2ZzJDRmhWQk5WUUdwNEsyNTY4UmRZdzUzclpvUmtz?=
 =?utf-8?B?dlNhT0ltVXZTQWoxZ2p3LzVyNEQ3ZHdvNUM3a1hiSUpBY3lBUDlRTnZqb1V3?=
 =?utf-8?B?QkJMcjVPeXJUeENXUWNoTWRlNnBuQmFzbDNLeENEa2szUWtvMnVUS0dXbitK?=
 =?utf-8?B?dDhaMWtzb1B1VzRQQzM3bnpqRmJhQ3lYYU8xSUxoZjRBbUlvWlh3VEFoYXJD?=
 =?utf-8?B?OG5jTEh3eGg5SVRaWUZENFpzVVhlNVNJc2xEU3FQN3dLUEs2R1FTbEhhS0l1?=
 =?utf-8?B?cUtoR2NJbG9hdjdyM2tDM0hLUmhkL3hwQVgydmVEZ0dKNnBKMDg2TGlJd2dO?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd87c345-2209-456a-481a-08dab132dad8
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 18:02:00.5684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8dijnLdZAYpuy3be0nbLThLudFsnoJllh+/vCAmsehSFnb/RyKDMng1+EJwVvK4iKHoSiY/3CLz2QyfLMmK3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9428
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

When sending this patch, I noticed that Kishon's email bounced. Is he
still maintaining this subsystem? He hasn't been very active for the
past year.

--Sean

On 10/18/22 1:58 PM, Sean Anderson wrote:
> Document the typical order of API calls to used by new drivers and
> controllers. Many existing controllers follow this order, but some do
> not. This is especially true for controllers designed to work with one
> particular PHY driver, which may not need a call to (for example)
> phy_init.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>  Documentation/driver-api/phy/phy.rst | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/phy/phy.rst b/Documentation/driver-api/phy/phy.rst
> index 8fc1ce0bb905..8e8b3e8f9523 100644
> --- a/Documentation/driver-api/phy/phy.rst
> +++ b/Documentation/driver-api/phy/phy.rst
> @@ -94,7 +94,8 @@ Inorder to dereference the private data (in phy_ops), the phy provider driver
>  can use phy_set_drvdata() after creating the PHY and use phy_get_drvdata() in
>  phy_ops to get back the private data.
>  
> -4. Getting a reference to the PHY
> +Getting a reference to the PHY
> +==============================
>  
>  Before the controller can make use of the PHY, it has to get a reference to
>  it. This framework provides the following APIs to get a reference to the PHY.
> @@ -130,6 +131,28 @@ the phy_init() and phy_exit() calls, and phy_power_on() and
>  phy_power_off() calls are all NOP when applied to a NULL phy. The NULL
>  phy is useful in devices for handling optional phy devices.
>  
> +Order of API calls
> +==================
> +
> +The general order of calls should be::
> +
> +    [devm_][of_]phy_get()
> +    phy_init()
> +    phy_power_on()
> +    [phy_set_mode[_ext]()]
> +    ...
> +    phy_power_off()
> +    phy_exit()
> +    [[of_]phy_put()]
> +
> +Some PHY drivers may not implement :c:func:`phy_init` or :c:func:`phy_power_on`,
> +but controllers should always call these functions to be compatible with other
> +PHYs. Some PHYs may require :c:func:`phy_set_mode <phy_set_mode_ext>`, while
> +others may use a default mode (typically configured via devicetree or other
> +firmware). For compatibility, you should always call this function if you know
> +what mode you will be using. Generally, this function should be called after
> +:c:func:`phy_power_on`, although some PHY drivers may allow it at any time.
> +
>  Releasing a reference to the PHY
>  ================================
>  
> 
