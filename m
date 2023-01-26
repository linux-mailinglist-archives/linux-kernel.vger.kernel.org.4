Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E8B67D0EF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjAZQJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjAZQJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:09:04 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2131.outbound.protection.outlook.com [40.107.21.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442D15561;
        Thu, 26 Jan 2023 08:09:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxN3IM0Loo8zX612Y/Ea+8rpQY4OsGXtFXjTFrNxw2sbMdb2eKAFEZkVbtBdQed/8rKhQYPqCWY+kcUf3yxOLbdlcHnlRuNbkc3ckH4RhOAifxNNiROk+OuFpJE22y7M9geBIpSyFdANsxAqbPCQxhGXpnvMBlsGAoWOISmSpGwh6gphDNrRgUcFRWpVmu4pj4xcicEhxiqUmZES+MN0tho22WxRe9iL4dXVCUP5M30NTIh9XCMNOrvUD5+dd+kEIMzxCsksBfm871lQUKobXNVb/2mCiqaEnDZW9Xw655jgRTHHftZysvoNrkMp0zKR1LWiXJpkc2VYTxzOgSdeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLetrZWxW/xM1j5laQhmoV0O0ZkZkUaLoNVo4mxYTYQ=;
 b=dr4TlC+STjg365ue+cP/vSgWHXTk+WLvFKysUaTH9QemMeMpB+KfzYUYfrXKiBGN/S1Ogi7JLSjLU4yb7+T/ZKtq6HJHd9n+sViZ+51Pu9zKWMB61eG+fgdiHBFlOB0Dr6vu1eZNvCm8+X2l11XqChdyiZe6r56fYbwQvLRGMnEEFks3SCPg0YtkmFWjwRcyuidLhlRKOo83DOPDgZaULcLCwTSPuCCQbmMotrUAaDr+pFtbn/aN71UzVl9ajsKgBfsmVyO4V3K9mz80r8vumwDGFMw4G9oUShcCDbHCaIz/SMMh3a+Q16G01iHnZuLohzzuuN/515pLfivBgNxOQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLetrZWxW/xM1j5laQhmoV0O0ZkZkUaLoNVo4mxYTYQ=;
 b=xk7B+A+ztXqIpFCYoAEsLcXh+83h72y06TbkYtyH+ahuqiMM0LxKroB25DYnthXM0zy5e0KLRJ5kUnnFKj/de9PsGz4Uf42E3v1S26MNMTDoR+V2YZ7+1x/xepzDmNqMfl7APVWzunphknSBlfrhgazxxqv78PrkgIH/d3ll8Yo4iiZCXg+3n7ZDnr8uB/LZ4tBjpIVJYL8GEhqm3dzqt/h5o2J4dHrvYO1OZPQBkbI3mnX7Sm5b1qRUT/NwEkkE3XPCD0ADq0L6HYivlGrkHrj82pzmk+PM4Q6aMiFT/nCmdM3Dd9sxTehoHMJSkd9mKQQ8erjY7tm5yf7KxjlIEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by DU2PR03MB9886.eurprd03.prod.outlook.com (2603:10a6:10:494::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 16:09:00 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%9]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 16:09:00 +0000
Date:   Thu, 26 Jan 2023 17:08:57 +0100
From:   Manuel Traut <manuel.traut@mt.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 4/5] dt-bindings: input: pwm-beeper: add volume
Message-ID: <Y9KlmY49Zq17HIOI@mt.com>
References: <20230126091825.220646-1-manuel.traut@mt.com>
 <20230126091825.220646-5-manuel.traut@mt.com>
 <c519afe0-0a6f-e262-7a85-a3072a828e62@linaro.org>
 <Y9KYNSWwlJXPcw0L@mt.com>
 <b5aea934-4514-6b30-be95-f427d01f54bb@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5aea934-4514-6b30-be95-f427d01f54bb@linaro.org>
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|DU2PR03MB9886:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c61e96-ce9f-4eec-ff62-08daffb7a2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ER5MHdg6gEIy0ssTDrJ7aa1FylFasiTcXnjl7Y9CNM3+uFYD/s0nSyVatRA3QqbGS1m0cAuj80Lgnu+nHp0EUzUMKTbVTtu/zjPUmq7XwM5o4uiACH8eCTtr9/GO+uARozcRst21BUyutQkOFXtBtJq2p3mA6be8i5zNwrvcf28W9+RIxMwI9Wfr0QaG9ehejX/pEfo0xWEZfXqfjqKKXcKwpKSjnV/0pllDsKQNuC5eHjhr6ok8EkCiGc7ZHIjtdEvOkKq+yICIFSnvpR9PbJDAEeoEFr4QbJ1gJtoE11wN2nE0bbW6AZ+tNoCJz5W8nrcjTY9q/tlO+83nrp6wYp4f4XIPwVneishFnHCFXCnGePBsOuWKZ4JrGXp1lWz9H4OA9g8UkYVLkhP1OgdEHA7el6l9NS4+GzjEQu98s6ESI2vPdSlF7tnJ3n86mev2xzhMwdzUWemRjRVg5qYcl5zPXYPUGAFC72h4T8RuUndSK/sfyxWG98KYvVlMaHvy81RFvEizJT8Fxy1EPjejb6s51WfX5CVUZ+EnX5qCx9hnBfDGzgE6Gd0CmH/yyLVnfMwLY9gR/Zy7yk+V72FhaM8kGaxcwjaKGLbY3i8D40whCFcH2MVk6zziUDssYnXb/hw6CMha76qsR21aCptmIKJZSAvODezMjJlIBg0WEYyBQk1irGnsff9vOAoZyfbChhXQOPssnXMtAcgAxd1jFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199018)(4744005)(6506007)(36756003)(4326008)(44832011)(66556008)(66946007)(8936002)(478600001)(5660300002)(41300700001)(6512007)(186003)(54906003)(6486002)(316002)(86362001)(6916009)(26005)(2906002)(6666004)(66476007)(2616005)(52116002)(8676002)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekN2ZWh1SFVNUzZ4ZXdCS1NSd2NLNERlSUMveGFjamFCMGhoQUlJNGN3bksv?=
 =?utf-8?B?c3BTNHVPdThyb1FjTFhJZmtzbWk5VENwZll3K2E2Yk1ydmdFWW01ZERpbUk4?=
 =?utf-8?B?RVJ5MlRnLy82eDJONmtrNlNRUTcyc3Z1MnJsOEN4TDJLNkx6MDQzN3hMVmI2?=
 =?utf-8?B?bFNBK2xvb08wT0x1SEZ2a3BpVkg3M1I3NEpBZHVJQ3A3c1dMTTFka2M2NGJY?=
 =?utf-8?B?R1JkS1UzRjJHcUFMWE44YVhHWU1mWFZkOUU5N3d1ODFmRnIyTjBaYUdIaCtI?=
 =?utf-8?B?ZXpyUi92WkFoWE1KTEhjRHRaWHJIdkFOUDRDVkJvcmppdzJJMXBNK0VDSHd5?=
 =?utf-8?B?UGhnMDBRSVkrQnV4Z1F6LzNsSExXWDNkRzVGaDQxMjk3bXg0eitzS1QyQVdn?=
 =?utf-8?B?Qlk4dUkxMHp1Y0lUZTNtUzUvV054SEthMTVEMkVRYTVDWWUycDBscDhpdHdp?=
 =?utf-8?B?N0tIZHZyM0hWRmZwNTV4SEZWek5tY3BZdmpZbHpIYXBOTWYxei9hcEpWSG12?=
 =?utf-8?B?OTlwU2FVZ0lKT0ZwMyt4c0ZqWSt4UFZBV3ZEbHZDT21KbGZmUURpcnpNbXEx?=
 =?utf-8?B?SVhIU043cFdRL3ZJRzdOQ0xZaEpMSWxBU1JEdWFWSm5PM0VSVUdEbFdPaVZ3?=
 =?utf-8?B?Ky9lMUZVQld6bTlzUnRiTWxCbEpLWWFpaXl1UDlQblFDa0pJc1RzNmNCLzM3?=
 =?utf-8?B?Tmlha3NnYmdOTHUrQy81ZmxTWCt0bk9CdUtLbkhnSldLRHY3VU5SL0RxQ2Qz?=
 =?utf-8?B?T0JlcDRvZWRwdVFzTVZRWGx5ai9DdEJEaWNZdllLd21XOC82a3ZlQkcrcGNS?=
 =?utf-8?B?VVdxd3BaWDBQWlpibS85UE8vS09MbVVTUjc2cWxRZ0RkVnp2RmhRZEw1VlNa?=
 =?utf-8?B?UzRyY1dYTlJkdXIxOWFzelM5cXp0S1NjTEJ6Yi9XYUMraXpPTW5RNHMwaTRI?=
 =?utf-8?B?VmZjUVR0dmhYbE00dlQ5MjRCME56cG96U2NyeUxxMGlRb1NUbHF1MmRYc3JS?=
 =?utf-8?B?VHdnb3BkeEcwRWxCR2FEWXNLenYwdUcvQ09rNkVWL3U4SHN1RzRSczdwNm9T?=
 =?utf-8?B?dmd3RzFoM0V6czVteWxaS25QNEhWcU5PV1dTV2twUk5tRmtBSmpYM1JSTjhZ?=
 =?utf-8?B?MCs4Nmljcys5WTFxeGorOU11dzBHbXFwbGVTM0hCTzJpS3FYSDZxWnRPRi91?=
 =?utf-8?B?MGZoancwYnRqR05iUy9BSjhzMkVFMUNMWTVFcm5xVCs1c0o3UUgzdnZDbUd4?=
 =?utf-8?B?K3hVNTJuSkRqQ1ZKYU01cnpBa0ViUGU4MmlreFRVb05uZnBLMVNwOWp3YUhQ?=
 =?utf-8?B?LzdCd2srN2twUUF5bGh0OURhakNCL1VrSDBhbzZhcGJPeUQ1SDVXbmNBZWdu?=
 =?utf-8?B?cTB0YTBwdWJBZm1yZTZOaEwwb3N4N3RuNFVHU1F0aU9aUlZQc3FvcFpsczFN?=
 =?utf-8?B?NE53UlBzbmllVXlGWFRHRGcyR3JyU3JXak0yb0RyMC9UNmxieTVScEg0ODE5?=
 =?utf-8?B?aE95U1NzVGNFU3hxZUh0ejNaNlZuWW5kMzFCZFNSSzlSYXRydWt1aUg2UTZN?=
 =?utf-8?B?YmVZUzZ0T1FuQ3JjRVdvTzQzOTZWSGFvRGJSZngzVndIOWhIRndTYVJ1L05m?=
 =?utf-8?B?MjZJRTBEclBmOWtGZzNJMXowV1hEV0VqSUdRYzMyYmJyU2lTVWlsMG5IbS8v?=
 =?utf-8?B?YUtGeEZPWllWa0JJMUd2UHVYNlpBUjNMZnp3b1RjRC9zMXJHNmVDRUN4VEtW?=
 =?utf-8?B?RFlFdVF3N1BEa1JJWWJvSmV5bFNIQXNYNUlnQlNIK2phRFJPRzZVREUrdDZ2?=
 =?utf-8?B?Z05oUFlmaCtMTW42QzI5TitjemVBMitlY1NwZTNJeDNrL2MrY1hsSlFPMnZ6?=
 =?utf-8?B?Yk5JZlVXd2tHTjJIWWZ3QmxieER3RGd1a3VTSG15Q1ZlaHJ3aHBxWWpHL3pZ?=
 =?utf-8?B?QWlBS0k5VGlNelM1Y0lnUk5GZnVOVUdsWHg4VU0wSjg1SWxOSSt0MTVpNlo4?=
 =?utf-8?B?Qmd5dnNqSXlKeURienZZckdLOHg5eWlqY3NaRHhYVkFZb0tUeG5ZaC9CdzFR?=
 =?utf-8?B?a1lFZ3o3b2E1cnpEQTF1a1FFcXpNU3QxVXRpbnpuaDNVK09ra1Y0QzV3NXRx?=
 =?utf-8?Q?Cyu2ksi0wIm6K9uV8II8FYSG3?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c61e96-ce9f-4eec-ff62-08daffb7a2cb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 16:09:00.2660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STBljzIk8gjNVGad14DMlZTEp3b2bvHTFsT0ilwu9JlFlQqgjVBi1VBR9ra3y0oDg2rxoeqZTQ2uJujwB7Tnew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB9886
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>> +  default-volume-level:
> >>
> >> I propose to use just the value, not the index, so the name should
> >> finish with '-bp' and the $ref can be dropped.
> > 
> > I am not so happy with this suggestion. What shall be displayed in
> > sysfs as volume if a user specifies a value that is not defined in
> > the array.. So I tend to keep this as is.
> 
> sysfs is not related to bindings. To rephrase your question: what shall
> be shown in anywhere if the index is not correct? The same problem, the
> same solution.

got it, thanks for the hint. I will implement it in v9.

Regards
Manuel
