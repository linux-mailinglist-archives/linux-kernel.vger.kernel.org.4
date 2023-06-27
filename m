Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A71573F620
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjF0HxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjF0Hw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:52:58 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519861FCD;
        Tue, 27 Jun 2023 00:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgJgWnaJ9qsix7GGirh4iwCPXqVtpkfdoulEGxTOSV0VY0aGn1qBd0NojNbfIUvb33iP2aprLSa5GNNKtfA8CO270Lw/hxdOVXn7HqdJ+he47rg+yjkWUGG68W0PEUNhrXGgrbaSBzDL6XAyMHC9j2amPXKHlb5PDH17xLo77G4MXB13Se4/2y5gk6BUyZP0fhgVTuRvqRceHm78ilZOPGZXUY5lAkeZWYNAUUFu36F0amd2qqQ0bQ8B4msZuf25LRHazXShVglQaEBY6wGGC4HCvC0A8NU7wmVjaqdEoJEBhKj0ionMoQi/ij6vHWNKsTr+aU/NYzAocSmc53qvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vh7M8S/t2MfQ+qVDArQxsCwOdKmOR16yRUEsnIBgUXY=;
 b=jcPCPs/DikNfbi9DXIQ7NkBouEttFjbxCWdHSLP4cUELfTfwoNLB2EZpFPGvFon1kJ5MnYXCOO2JH6UVme7vMPcGYfCRKrjD6qQ9YBX8fUNq3Cn4O7f/gtUXRsb9BeQIENMDkox+xF1WaGY7W97kJmirhzTmcouArv/lNsX3EzZlhe6WTqjFqT63WGCPNNrVJjS6akNwVlmCyZbAP0wWnDQjtKlgBiqgMyhxTfq6Ha6mFrYa0V30V/LDI5V8twciMVSjhBbJ6d4n4w2Mx3HAykqY8IMNa5Rii9uJLBweDtUYCRGqG/xkuoD5dQ1NhMLukKbGj7wqAx6ohv6j4xkjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vh7M8S/t2MfQ+qVDArQxsCwOdKmOR16yRUEsnIBgUXY=;
 b=sXAsHUQPGg/KSRgBurdr9Aw+wGGMe5EahVL4kbIGnbeDg9iXe5fdE6uU026LY2uONYekqqSDtc23PBk3vfZFvnNoXMDh48tRkGlyZ4ZmvH1zUtW08P5P8yhmGapHXECqH7LhNUZPmDVyvqpEuc55bduRWmSCKKLj4gYVgpmw//EmKO4cJwY5lOPfh+hQ+zNHdFhYmPRlTcafRgVrqVjRwwTW77jahFoDsvLVJ6guFRcaANGGqfgHtE+f95/KOzz0y21IoPgiP8mnE5zoID90s8Cnw9TJXmv1Y3EOoaw9vdC4Gy8DpxlxtaCoANOIWhc9NymR252l32ePfEhH6+gjvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SI2PR03MB5370.apcprd03.prod.outlook.com (2603:1096:4:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 07:52:00 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::e659:543b:2ac9:8fd7%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 07:51:59 +0000
Message-ID: <061bb829-fb75-d154-0c15-9f0f982fec41@amlogic.com>
Date:   Tue, 27 Jun 2023 15:51:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] Baisc devicetree support for Amlogic T7
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Tanure <tanure@linux.com>
References: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
 <20230626-viewless-marrow-17838c2172f6@wendy>
 <676db602-54d8-d6b0-274f-365e65a2102c@amlogic.com>
 <20230627-unsure-uniformly-079cad2c26e6@wendy>
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20230627-unsure-uniformly-079cad2c26e6@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SI2PR03MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ac4b64-d4ca-439f-a46c-08db76e362fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMMCpaSQE9x0MWU1nk/1wMNUuBwz2A1xMz9ZOkCZUkH9CjQ2syccnxzL3NADDaJrY1OajllETifviIcCSNH6PUN7ZtFnJBO77IwzL8XQzILwH1txiX0rEuiANOyZW2DVIZHgvxVc41/cCEgf6RVbhA0KPHwNG9D0AZxQiTEvXim8XAImkCHLp1xS1LVULOXq0tT/Lkj0ZxSI7SYghVGbDUHyBkuPp9uGKcIBmAdqvTu1nrIydXWKj7K8lt4Zk7aHlBXZJN58AkSzfG7Fxu84dbfgsr6t4UBIONrr0oTWeDVK02XU9Lmo43duYuJVhDxLhsf1wKdpbuQK/4JFP7rco54H1vIWmthnfWLC6dEJ1WaNuQvOniswHYJgIKhNhFM7clx08u3b7chzbekofyJCz9wlMbPL5dbNxkti6EXaK6aWyCHE5VcM1LWP3yhrbs1an8QysweBVaGvB95I2n0FSzZ54ypNkgfwZ8RPzkZ+A379aieqLwolsFPkaAcY99Qk7NGh7Q6N5iFWbvDkwW+VZGZFB6zNFk/5vICJVj1ekIIpgsK1FztP5wt2bEcG5XT82zO8rl2GUONY3fR0c4HaMlJNDmUXzg89B4/n3sWqbQ2NASUwWIwpB/PnNITvkq6p+IjQ+EP+fLkLEMod/kZee8eOQEBQUkeA+90EulNCkVKhoutqrGVz6ca17I7YtB+i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(376002)(366004)(136003)(396003)(451199021)(31686004)(6666004)(6486002)(966005)(54906003)(478600001)(2616005)(86362001)(31696002)(66476007)(66556008)(53546011)(2906002)(186003)(26005)(6512007)(6506007)(4326008)(36756003)(66946007)(44832011)(316002)(6916009)(5660300002)(38100700002)(41300700001)(8936002)(8676002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlcyYzAxYUxtQWpJRU1VQWdKVmYxOVZXOTRGS3BYWWhwc2kwMGxwUVBLM051?=
 =?utf-8?B?cUxCbjRKQjd4Y2VycjkxNFpRT1RSZWRRcmxHN2lpclpMb09PRUZuU3Q5MkZP?=
 =?utf-8?B?TDYvL1M5eFgvdFlodVpZdmU0UEU5REhmTGxaOUhybU5sMytTYlU4eW15clcw?=
 =?utf-8?B?NWdTUGliZWlPUW1XNGFMU0ozaUxTNnRKb2JCbkRKOGlESkVCcFI3SXQwTStq?=
 =?utf-8?B?QUk2U1JFRDdTeE1KeW1yaWZ2MC9HSzJXSUZCM3JyMGlXeTZNbXV0SDIwUHhl?=
 =?utf-8?B?UWV5M2VuUzFNVFZmbGNKTjlsZ0N2WEp4L1NIbHAyTFJtelJlUEJ1NG1PSFNJ?=
 =?utf-8?B?SDJPUCtWLzlDNVVrenpXaEdvTGRLbXl3VjBiRVdxYlVPa1dDL2dnaGUvV29m?=
 =?utf-8?B?Wk9Zd1hZV2FzZVBTUFBQTmFScTFxdVd4alNIeDl6VlhqOHcrVnV0TkpUcFNG?=
 =?utf-8?B?V1dHVVlsSU9wZ01MSUJYOEphNWtLdHlTMnZMTzYrbE4yUnpIWUZza1lucFdZ?=
 =?utf-8?B?Qk4vSEU5TGFXTCtDQ2JteStwMUtzV2xMdTUvOHd5d1RlM0ZINVB5aVNSU2g3?=
 =?utf-8?B?L0cvWnVCcTZ0bXBHZVdMVmh1a3NTbkI4eFhSV0Q1dkVBQVhmSm80N0xmZ1p0?=
 =?utf-8?B?Sk9DSjdxbUEwa2xjQVlLbWNiTFZyN3Ewc3JNZmNxVHQvamFlUVd2RmoxSmpF?=
 =?utf-8?B?RzY0T1B1a2xSMThGamJlZGU0a0JDbk9OazluQzVtOXliTVNWYWFwMmFGRHpm?=
 =?utf-8?B?cGI2cDNQUWE0MHpUbmN6TUNyMXdLTFlkcll1M29CbXpyR3NjMkJyWmFzUmF3?=
 =?utf-8?B?bzQzNGtieXRBYUdURDdnSkpUZGxDRXVhQXN6WGVycXBpQm54RFFHNHh6MXFM?=
 =?utf-8?B?Rm51OUx3WkFVN0pNRDJocXh0RjZXaXpUUWZFUzljMnhjclhtZTlGeGdoNEht?=
 =?utf-8?B?dEtTZm5UUzU2VmdtSmhiSjlHSzdTRC9lUWtlYXhEd0thLzc5ZXByYnVacjM3?=
 =?utf-8?B?WlUySkhaUGx1alp3eE5FZjB4U3hVWTF5RjFlVkk1RnhmdytzczVDNXFMTThH?=
 =?utf-8?B?enZuYlZJUHNWWTdkaVFyaDA4b1ZEdU1zdDZ4bm42NnNFdFBkR2NDN3hvcUJT?=
 =?utf-8?B?YTVpVnBxOGY5Z2RVQzh4VGx3UXdlMWZyd2NEQit1SDVSdk14N1hvQzNMUFpO?=
 =?utf-8?B?NnlTY3JjamNxSlVZUzRsaTNQN05ReGlhQXR2bnJpY2xRb1JDZnRodElRamFX?=
 =?utf-8?B?T1ErY0I4TGpKZzU0VmpaUytONis5Sk9lOER4M1FIRXNpRTB6QmtpZjBaYjBB?=
 =?utf-8?B?ajI0WVlkc2VEUTFYS0RtUFFSTExGcWxicmxaaDM3UldkUk55aEVlSE9nWVB1?=
 =?utf-8?B?a3l4U2Q2dEEwU3V2akowQlFWR3E5UVFWWjFsQzcrMUNFQUwxOUtSdStLcW90?=
 =?utf-8?B?YkxTTHNEbDZDclJjZTR0TFhwUldNYkZkWnprRnVWU25xRTkzcVpmWTBrTURV?=
 =?utf-8?B?WW9nY0V1R3pMenlDWUkzeDVjMzdUUEhhemttRGF5dHlPWUI0WTlybENCQjJR?=
 =?utf-8?B?Z0dPOGxDSzFGZlZCQnA3YW1lOWV0Z3dDTHZGaFRTblpMR0N5UzVZdFU0UkM2?=
 =?utf-8?B?Qk1jeGt4dHhSVXJ5b3orY1MxRnpWTUVQOUxYNUs5TGl6czUwSFFyQU1OWXhz?=
 =?utf-8?B?QXNvaEJqVitGcFBSV2RWK3pBamVOVGpsaVZyQmJoRlc5cWlydXQ3K01NR3Rw?=
 =?utf-8?B?dWFIQlhPUjVLS0JYR1E5WlJiWVg0ODdBaXlKVVEzVXhqcDFFZlhJOEZEc2JN?=
 =?utf-8?B?emptd0lYcU1BZkFKajdCcnFmWnpjKzhORzU5NzUzMzJjTEZXTS9pNkF6QlRl?=
 =?utf-8?B?OC9WZFpLMjVqek9ONW5FQWF2NmZFR1g4SUNuOWdjczM1a0pSMkUyOGFlVEl5?=
 =?utf-8?B?TXd3ZVZubmZYWFRjc2lBUmpJS2tELzRkZldJV2dwN1F5dXlMRDA4L0l2eW1r?=
 =?utf-8?B?dHlONWpzT0R4OER2aXVKRnJEaU9FMXJzQXo0VEl2d1VLRjMxbzg0L2hzT1FS?=
 =?utf-8?B?bEJaSHZQd1AxME45SkF5aHV0YlFoVmtHL01jSFViVDBFK0JodXJNQTRtNFB6?=
 =?utf-8?B?RXNJNUUwaWhIUFc4YStjM0NKV0NsbllmRTBGb1lmOU5kVE1xZW5QVzhFelg5?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ac4b64-d4ca-439f-a46c-08db76e362fb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 07:51:59.5160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5T6fWQCkNxSb7UOnnsDiSP9v+KqL8nSZMtXEfONKiutaY50AcbWBSpT+qjtAiaNOABQPGIyOq+EBr4tjwfYnQ0nSZrvgaCwT25SWdzPUwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5370
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/27 15:23, Conor Dooley wrote:


 > [ EXTERNAL EMAIL ]
 >
 > On Tue, Jun 27, 2023 at 02:13:34PM +0800, Xianwei Zhao wrote:
 >> Hi Conor,
 >>      Thanks for you reply.
 >> On 2023/6/26 18:02, Conor Dooley wrote:
 >>
 >>
 >>> [ EXTERNAL EMAIL ]
 >>>
 >>> Hey,
 >>>
 >>> On Mon, Jun 26, 2023 at 05:52:21PM +0800, Xianwei Zhao wrote:
 >>>> T7 is an advanced application processor designed for smart display.
 >>>>
 >>>> Add the new T7 SoC/board device tree bindings.
 >>>>
 >>>> Add basic support for the T7 based Amlogic AN400 board, which
 >>>> describesthe following components: CPU, GIC, IRQ, Timer, UART. It's
 >>>> capable of booting up into the serial console.
 >>>
 >>> Lucas has already sent patches for the T7 SoC & is at v5:
 >>> https://lore.kernel.org/linux-devicetree/20230623081242.109131-1-
 >>> tanure@linux.com/
 >>> There's been a bit of discussion there, and there serial stuff in
 >>> particular is different in his series (it doesn't use always-on for
 >>> examples).
 >>> Could you please go and take a look at his series?
 >>>
 >>> Cheers,
 >>> Conor.
 >>>
 >> AN400 is the reference board designed by Amlogic, which is different
 >> from Khadas VIM4.
 >
 > Yet you share the same dtsi, which he has got through several
 > iterations of before you arrived.
 >
Hi Lucas,
Are you going to continue with the dtsi part?

 >> And T7 serial is the same as S4, so I follow S4 serial.
 >
 > Yeah, no. SoC specific compatible please.
 >
 >
 > _______________________________________________
 > linux-amlogic mailing list
 > linux-amlogic@lists.infradead.org
 > http://lists.infradead.org/mailman/listinfo/linux-amlogic
