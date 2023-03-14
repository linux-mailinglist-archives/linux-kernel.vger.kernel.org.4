Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269C66B93AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjCNMXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjCNMXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:23:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B039594A50;
        Tue, 14 Mar 2023 05:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3WDBv07MJwEPIPj5e1H/6dIyeGnO/kDetGCEewrmiaI9QuWS1YOTmgDYuhETpc6KwAWJZf7mIulVdaaeW0f9PVc2kE3qAvdS2s9GMSflApLaA2kpxK1LvJn5ph2Z6Osy4+pMrIh8UHTDQSg2jJbEqacXTi8HnruDkIhg6p0wDDr5P1cmb8otRlsCzVGEytingkUEWs6gg/djWC+3n9x6gm3ilsf6VL0HByfcu+f4vcK10b4OwxU/yuoSw6zrpa1HfbJnAA4rF3+Q1kKAAXgNZo6RJso5vDg7YYuvONLa+nRuZG6l/sx7oLEF0FgvEsIFQbt35scziNwIMIyQEQwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSwzhKFPYeA9ZYWordZ/2WtBeLQd/uECwPCK4IbTyxg=;
 b=FdjZqdh51uinotLSMhS/kqKA/JOvRF7p2xAhi2aRKQ3cYOxSqOs/Dil2pVE7Nb15qIzBIBSSETX3Wzg3buoTTmB7Bk+HkJefWdGdK3UwavbnQgxfwAuGUSo1eCMC0y6UHumrAmQhhsBZ1zYynbizStdvtRAzOk/qg1+fmgtUSoe040x0YenOTf4wLhJ9Hq+5XMAYyMJvVf8fOo5Xl9uzx2pUOW7+ejT5uZk6RPDtFNsnz6lMuCxk5FKR5CuJ6kJPMp5v8huUv6f6u5TlAEABl2+tYtM7GMaU7f26242M6dMPG1xH49NkmUpHGOoD7fxJUFKXKshSj77B0p40Rbbf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSwzhKFPYeA9ZYWordZ/2WtBeLQd/uECwPCK4IbTyxg=;
 b=UJiSclOYUOrSf2NhQYAe1CvEqVyE7JO225OAMUpRqTloGTOpeoiSnlNdTVLI5NZNfCzwtxwzvzCcVmwAgwpRSIcLlS/Odd54DOZ4IzqfF3xmmAA837s2KYJmSc+dKMyAtoliA+HLQ9XmHh/nwKlJ+ML0UoZOobXmeX816IYf6I7NhNssq7K2GMuiry80uMl1CPcesk36ITKSKc8vpxVMEkUQ4Pqnjtn64wwZ8m3G3kxsku82gf8gbVfxTWdMThG6MgI3sTVpz2/1DDAuSadegqu1uHxnl3MpdgaOP00FbKVst+SXzaVOZjflkKEZmw7D1Wl5bL28VDzfjpT6YFDpdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.26; Tue, 14 Mar 2023 12:18:19 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%9]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 12:18:19 +0000
Message-ID: <636816e1-522c-d1a1-a7d5-3a1b5608216c@nvidia.com>
Date:   Tue, 14 Mar 2023 12:17:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 4/6] hte: Add Tegra234 provider
Content-Language: en-US
To:     Dipen Patel <dipenp@nvidia.com>, thierry.reding@gmail.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org, timestamp@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org, brgl@bgdev.pl, corbet@lwn.net,
        gregkh@linuxfoundation.org
References: <20230310190634.5053-1-dipenp@nvidia.com>
 <20230310190634.5053-5-dipenp@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230310190634.5053-5-dipenp@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 1daa99d7-faeb-4ecc-334c-08db2486321f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mzm1R+czblmEB5mMVyYp2BOhMP8BxJmOPhuBzPglpNQc292xcSKCaJ6iZoTqfPBbB+PTy8U/9jNP2r7lP9J7wmnXmW6ng1bTnwPz7D/tGEssrPU+1HQk+HXhY0Q2Tmqto2C2/knL8VAsPeDheTaZeZQk1sHzsd9DNQTnbMWgBbibBtPVtEmWHOCNI/XFWqwwV+mhI+4xqUFZHfMCTi58PVq+/aJzT+7gGej+1CMXFQwHZb3q7xe18XD4jqTcD36aeMRZnqKHsE4tfbaH5qIpGoUBKm2JwiHw0jEBMXm2hgwkml6ZUT0o9ZOYu5xJK6QFWrvZ2syBhsGJjTI/Sr+Y0AkSNgr2I9/IATp8ascDzMc2zVxQvYIFdN7CgYeQNHK0sJdBIXPGc6iY3V1ZjmDKCU66apUHyvwjiZuWqRyaJWGNQ1HAgENtzdJ7b8kNcq8WoYUoeaZea4+gLuBsMEjvaj13oZcX0Uwh93W9EvwMXAmLiyuG/L5q1v6wSDhYYUhdbaJmOKy3oHuABCPI9Lvgrf1Q7cZADwETe49eLF9BGhXIJXXORm++fMGJbnz2oFfk8mZb824nWVSKJMvOFX0jUZ+Mamkq2tZGsZSoMEi9eO6pS7SSx0ODUyMuGIqy2LoIIPdgqJN27Zo4gVBaO+MdnHEn3IsshrHUigI9xxCgJrVbhmfgDrKrpFq4mznNCM1quEvMOcV6MU4AyRszx3LOmSdmHf7Y1dIEzyVlQ/wyrom5toOcuBk1w8LiKz4dysXd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199018)(31696002)(921005)(86362001)(38100700002)(36756003)(41300700001)(2906002)(7416002)(4744005)(8936002)(5660300002)(6512007)(6506007)(186003)(26005)(2616005)(55236004)(53546011)(316002)(8676002)(66556008)(66476007)(66946007)(6666004)(6486002)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlkwTmFZWnl3eUducHRDblZKaVdLTW9LTXk3NFVoSmsxUkE2ZjFxWC84Mkhl?=
 =?utf-8?B?RVl6ZU1ESG5TdHc4U04yYVAxUDltMU43eHV0R1dHT081Q3YydThLWHRzWmh0?=
 =?utf-8?B?TFY0MWVtNitwVUVFY1liL0JZaUptdkpYUzNKNDA0T001WkRzLzNSM01zODRZ?=
 =?utf-8?B?bHQya0FnSURaby9yZFhvVlh3MEhJYTcyVVdwNW4xTE9hY0syY1JoQ3ZtZk9l?=
 =?utf-8?B?Y05oclF2cXpTTnRGOGtSeVFGcnJ5RXhwTXNueUlHWXNVMDgvSjRwcjhEU0lU?=
 =?utf-8?B?SXhHdEVxR1NpcHpVbUJCeC9RaUYrNkxOdkozK0NaM25oeWJWVlB1SVo3dkRG?=
 =?utf-8?B?ZUtBZmFrWjJmKzRndDlmVGl6Z1Nkc0lDWENGUU90Ym0vUTh1bzZYa3EwZVRR?=
 =?utf-8?B?Q055OHJ2b0V6UjhBaCsyZDBRazQ3SGh1WGNoN1Q0aFM4UUhpR3prbnQ1RDQ0?=
 =?utf-8?B?bnNYak9DaXFIZG5SUms5Yk9vLzV5WTlJRjRxdkV3NjhFUk9scVl3ZThzblho?=
 =?utf-8?B?VkJ6Zll4TjNkbE1LY3dFWkxFSUM2cWRVZjV2TTlqTzlpNmliYzA3NzdaNXpy?=
 =?utf-8?B?UFRDV1dQMXBIQ2I1OHdpMXJjQVM0RVR5RnEwQTlIWjBid2JGR2FVRTFVdXdq?=
 =?utf-8?B?RnU0cDFaZitRb1RBODQ4OUx0amtDMkNSRm5qTjh5WVVkTWo3alZobk5ZTTYx?=
 =?utf-8?B?K3UxbnA2M2RuNm9pdmxSWitxS2pxUDZMelVZSTZXVmdZTU9GdldqOVJSWExL?=
 =?utf-8?B?UlAxQ212djR2OHNhQktJVm8wT3VqQ2p5ekNJK1Y4OHJpdEF3R2QvUHZVYmh4?=
 =?utf-8?B?RitFTGRvVlovNFF6WGFuWEwreTNuaFNTZXJoNjc3K21nVGp0TENrckNaTi9Y?=
 =?utf-8?B?SG0zK2JwRmI3YXlQdS9FUVdud3BzaklCS3l2YWVibjBONzFEQlZVMWxROTBB?=
 =?utf-8?B?bkF3M1BKcE10QU9RTXlvK3lLaHJlVW0xWmNlS1F1aGpoeFRjaUZTdmczMFFM?=
 =?utf-8?B?Ylh5SHpBZG1wNngreTFDQlB3dkJaNitoWm1wazVweC91TitlRDY0SDFTTDlj?=
 =?utf-8?B?RDFyaktkdHRKSURZa0trOXN6cjBoU1JTUFJhaE4xZ21XYlN5N2xRVzJNVEla?=
 =?utf-8?B?SExEeFVxQklFL0FXcmlaZ3MwTHBlUytMekFBcDQvYmZCemg3NnlxQThzdFBB?=
 =?utf-8?B?NDQ4RXdqOThVQ2JtQUJNTnlZODBpUnBMMmJ4aHlWSzNqOXcrMWtvNEVmMVJi?=
 =?utf-8?B?Q2JKR3JKT3N4cnoyZEQ3TXk4RldWZkZCZjNTd2VtSytxZ1J6THFuamlmb0xB?=
 =?utf-8?B?cnNYb0tqMk45Q2xlR1RLdmJTMlRFMW9YNXF4a1Y3b1p4Rm9UL09IaXJwYmVu?=
 =?utf-8?B?RkdnbXQ1Y0lGM1dFVnl4Q1gyaGg3K1h3UlY4eTFMMitjSmVnWTFzS0h3SUJZ?=
 =?utf-8?B?d1Zha0VsSzBpZ3lFNmZBK0lVcE1TbDNCWG9uTzQ4T3p4Yy9hTWhWVmxCeWF6?=
 =?utf-8?B?ZGhsU3k0RVNWRk53NUhnUllnVW00cTlmQXJKUGtXd0ZNSFptQUE2MVQzQ3Vh?=
 =?utf-8?B?Z2c4SGVxNVFwVG5LaW5PUkoyK25BR2tBWFo4N0RkY3ZObnNwZ3dFbFB5Q3h2?=
 =?utf-8?B?bW10eVpVc0xDYWREMG8rQU00YWFvV2hQaGFtWUN0amhVdmwwKy9wYjJ3VmVs?=
 =?utf-8?B?eUVHTzNReFQzVVNZS1ljbWdIK2JVc3JQbTV2eGFOVW1lUk9iUW5XbnBpb3A3?=
 =?utf-8?B?Y0JXRTY1Ui9MYkJHR2JreXBwNWNVWVVxNWxvUC9EWkNzNTh5aFB3WVAyS2tB?=
 =?utf-8?B?NzlBYTJIYmUvbVZVSDF6MGlPWHkxLzR5Q0dhYjUrQW5qNi9qeXBoaE5xMnZX?=
 =?utf-8?B?MXo5enhMMTJOU2x1T1RudFRUMzRtQ0gwWmtMMW1oYjFBQXJXcWw4ZFR0dGNt?=
 =?utf-8?B?YWNKM202b1dRSDJjakt4Q1lUeGRxVzdpelJ2dUJ3SWRkSzlkMHZFMmFkVFdC?=
 =?utf-8?B?RExNellsNlFsM2FjUytlTVZrcUlHemlnb05mM1hGZTBBM2JVZlJYanRzdTdY?=
 =?utf-8?B?SzRsOGlqVjJhRmtLYmpnWUg4aDRKbWF3cktvZjIzMExLWWw1RzNQeExZOE5j?=
 =?utf-8?B?NW9hQ2pMVTZ4NkZOWTFUU01PbkcxVDh3SWdleHpvZ3g2dGY2TThMcldGQm5z?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1daa99d7-faeb-4ecc-334c-08db2486321f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 12:18:19.1773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9TMoV7Woq5ZjVf9NPOsBpnw0TH/Kd+BfFLjfqp6nb4WEiAhGIIfYsB38gHdEvzjvFK2edFz1o3Kw+3bfKiyEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 19:06, Dipen Patel wrote:
> This patch adds HTE provider support for the Tegra234 and reflects the
> changes made in the device tree as follow.
> - Add slices field in the SoC specific structure
> - Remove gpio chip find by name function instead make use of the phandle
> parsed from the DT node


This patch appears to be 3 things. So this should be 3 patches.

Thanks!
Jon

-- 
nvpublic
