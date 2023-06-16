Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6202473294F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242806AbjFPHx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbjFPHxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:53:51 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFBE295B;
        Fri, 16 Jun 2023 00:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGG6RyxLMJUAB1p16oNiPeQP+KvfL55pa7PRQTPfHz6PeXa2wwZjc688U9i/Lkxx6wBBoCyt14bN3vVDTxVXjB99u0v3qeKal1khztNRmXhWYBle+dXkUORQUKiyA/O9tpEwOd/RSF1spKHFs/Q6U03v3vUUohPT6YAp6Thg/VjTmcdAVqOrrFSN75wT15qDyeouLD94nFzql/sTlLSviLV/oBTidJQKOqYHLRMb2LLTMZ9bvTLUis+2BTXeHySNE9YUEa18napQb1PskYdmlSlaPIbzbaKivlfK6XopERUrEGIP13DJbGbORzGknAwLZ4sJYIQz/Js8SEDUuokzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGEXzEzxwdunMX4iGGcMtP0CsRNRSvky6h6S/UoGF8Y=;
 b=ReJWANz0jYFDbUMf9Bo/tJkLlkuRFdA8Sdp+180NJG+1/w7d6mBeNhSV+gax67LNdWuxXXnBK4nKRzzbaO6uXEGmRBIGlNYttoF2B1lYrny4rnGpACmiSGPQG7ZXwc4TcF4bvcf6al2zKh922qGv2BPfKxE/x3w5ru2NlnzCXUWsWuvIIToLyDbDxNolmbv1xZLdr82qrXmczXtA69oX46g+mq5EjwbENeWbgM5g8AHBORlJYJMWlVseQD5M6bdFf/hBc14AohlFYLq9UwpGT2JLlkzNWhIrBbIpN7/LFZy+yd5Cltp6KHYSm6lDaQXbgsg6qhP5bQ16GCo6x1qO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGEXzEzxwdunMX4iGGcMtP0CsRNRSvky6h6S/UoGF8Y=;
 b=RLOjtbT47ysV2P60zrv+5HVhvNQ+jJdKRz6vAqlVeg6y2+a+7hrTaFNZbRox59ZL1xihDfdwFbHzQJkAHEFanje0ILSvl26RRwafk6rr4KEqeHK60e14kUA4JLQhrZ83OiyGZJ5u3YJXsdl4gQ22PIXES20EV9RSG4vkUF4NHbmtpNZsfH1cl0tc90bXthXBfvq/BJ7QObeUlKT/lcDYHRHN23S4mfPT5zSC2Dnynw3MZ08gcwj53BbUhi7Zk4S9266liYZwcGJBb+ZZKEFfDRBLroBecF8R+k94veHysH7h51KtlApvZHCmEuJ9LqvnohIQQ1cs/Fu+3UMImXSUPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by VI1PR10MB7736.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 07:53:45 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 07:53:45 +0000
Date:   Fri, 16 Jun 2023 09:53:35 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     xingtong_wu@163.com, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, xingtong.wu@siemens.com
Subject: Re: [PATCH v2 1/1] gpio-f7188x: fix base values conflicts with
 other gpio pins
Message-ID: <20230616095335.3a35d1a5@md1za8fc.ad001.siemens.net>
In-Reply-To: <CACRpkdaLyEmdhutqsMUoV3ObW8bFePtNGHFqr5qiKV3w0ripug@mail.gmail.com>
References: <20230529025011.2806-1-xingtong_wu@163.com>
        <20230529025011.2806-2-xingtong_wu@163.com>
        <CACRpkdaLyEmdhutqsMUoV3ObW8bFePtNGHFqr5qiKV3w0ripug@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:610:b0::28) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|VI1PR10MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a32997-0f9b-40a7-67b3-08db6e3ecf4c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wVFRZ3SOMR1J/LrvsTiRbIy/3TtmnnLqW2pOnRtd9t4v5OQn/G+Nl/xvef3LscahRq/iapP7HWQWDRt5RBZmKMSFWxUubf/F545mzJosmvqApSWcyEKU/b0HiY7aSyDsL5QcEO6GM/NLGnsm8cn/M+BCO9XexgITBnUkrs2XWAXvqHWBt8c5564rprbnzVyLyEJdywVPg1TlQlVagD+FPUFepPfUBBXwA1j6wnwZmDy4ha7hSf9th5uM5u4lBnFQpFjDlKFMjqa3HN5w1CDW3jEWrsRfL1myuygqsGjOu/jKuRrPbld9UXRul+JaJDcwrU0YCYeMkjMn9mhBi5FaDPxydAWMdUeaAMnh9A4+z6AEYAXGqH9p9qAihz8pKjhJSRW8DqanoqSH3WLG/3rjVKCHGp8lhBZi99rWKT5p/119fjUD6EDYs8iAzlPaLH8ztkYscT4uMy9hLk4o6YBzl2iL2Fu1oBMDYn9sPn2BwwC1G4fVQhV9oOxiMeAvgAdqN+Bz/UXEyyn7ZEGq5z1xqR203IEAplo+OtApU6st3MNXPyquPUhkb2g1OnjbM2Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199021)(5660300002)(478600001)(8936002)(41300700001)(316002)(107886003)(8676002)(6486002)(1076003)(44832011)(186003)(6506007)(4326008)(6916009)(66946007)(66476007)(6666004)(66556008)(26005)(9686003)(6512007)(53546011)(4744005)(2906002)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmdrRmdveE1uVDRwdUtKcHNEeHpSM2RVTDFzVGU2cDV6R1lXL243TFplcW4x?=
 =?utf-8?B?MXlpcXE4UmZLS2tlRTBEdXN0Q1puM2NpOHBESlp0dC9hdCttckxqd0J3OUZy?=
 =?utf-8?B?L1I5b21yQU9XZExiVnRDalhheUxJdmFsQVNsTHQ3UTRmNlNwZ1R1TnAwNjNU?=
 =?utf-8?B?MWoxY0NES3RpRXgwdW9WRFI0SERlMmFhL0tEbG92RmlZa3NzODc2aFBGZ1pJ?=
 =?utf-8?B?VXNralZwNytQcW0yb0hpMm12dDIyV2lZclFUaWZMSk1wYUZGdE9kU0VYeW5x?=
 =?utf-8?B?S0YvaGJrc2xMY2xBd1pNc0FQdFhrdUl0WGVieWp2clhvVUp0RmtDZE5CWmts?=
 =?utf-8?B?Z1pBVEZOMnlPanZLckg3akd0QWl3aktxVTdRT1JaYXpZWFYxVFZiK3VoalJL?=
 =?utf-8?B?ZU9wc3RlVjVpUnhDNlJhRy9nRUo4VmcrZFdLOU1VaUFyTWxEZ0g2UUk0aFN1?=
 =?utf-8?B?aG14RktaMVBJMGZoL2ZyWEgwczI5blRIZDZwRFgrQjVjMS9SSThxZUhJSmU2?=
 =?utf-8?B?c08wZHphYk1OdEd3emp0dWRzYmlzSURQUksxV0EzRnlPa1pmS3dzMGxWQ2s4?=
 =?utf-8?B?dGZHRWIzSDIyVWFVclB5a0c3RkkrcEFtWGc0ZkkxcGR1M0Y5dUduVnVLRHh0?=
 =?utf-8?B?d3FOUU9DZEhrMDdnVXZDaldINExPa1g0ejBta3MrUVJQeWpwamZoNVNpZVJ2?=
 =?utf-8?B?NjJUZzh4K2tremlhUkxGZlpoczUydVpkcDJkb0JrbDdNbUZ4YVRqMmVsN0lE?=
 =?utf-8?B?Y0QxZStmcUN1cStmRi8yem1ZeDZaZ1d4SVBHN3VQaWxTOHk0MHRHVXRYNWtN?=
 =?utf-8?B?cW9QUHRualpJMVZHamdQc2FLbkhvR1NESlltT0VoVEZPUTdLU0Urb2xZYnRv?=
 =?utf-8?B?eTByZTBGOUhrTFVObGo0UUxiTVduVmZxaDQ3NTArVVpMNXRhWWplUHRKSElk?=
 =?utf-8?B?S3VLcVBVc0NKZHhxVHlGUlhrUWJwL21KZkQ1TUlMM1o4NlhEZGFYckZKcHBE?=
 =?utf-8?B?TG9OVzBOYktKZFhoSHpkbUFUcEVrZHdDOVlnZEM3dU9nQ1I1N2Z2azVJREF1?=
 =?utf-8?B?bEJleVFjVzJ4Zm0wN1RIUzN6RUJsLzFWcHRQUHlQeWlhaU41YXFnbkh1SU4r?=
 =?utf-8?B?UDZ4eVBwYndHR1k3cThxNE1mbkZ1UzZUenRXRm1CZ21sZTlsM1VKSnFJT3ln?=
 =?utf-8?B?MFVQODlaZ2t4bWZkRVRXVWVjRGNxZDA4VTlUK2ZNYk93dVU0QUVmdUV3NUtH?=
 =?utf-8?B?UVVFaE56VlZEOG81TUxVMzZxekpETUdtMlVKRWk1NzlBVmM0VDJmZ21SUWd6?=
 =?utf-8?B?U1N6UnFZTUpnVVM1L05JSWFFdlJvbmJtR1FUTzBhRDN2eHhyV21WZW9uMkpH?=
 =?utf-8?B?enZYTWtOaE1uQ2hBd0dBWWFPUExUYVRQUWtTNzhYbmQzZlp2MUlsZU9xVFZL?=
 =?utf-8?B?OGJOUWorWFp2K2Jsb2JIQ0dFNGFwcG9TeUFJREhlMkhwN2ExMlRMbnM4RFRl?=
 =?utf-8?B?a0hPMlVxU0t1S2oyODVoSU42aTc3V3BnblAvdlkvTHUyZ2IyL3AxNWM2SFlm?=
 =?utf-8?B?N2orWHNLMlZ5ZHJBNzZORnFFZ3pzc3h5NWRNMjBTdTJjdHFoV1ovTlZCbDRO?=
 =?utf-8?B?azYrN2lqTkwvMmpNdEptZlluWXR2YjlOSG1JZys0Njg4QTQrMkl1MEtBbnFU?=
 =?utf-8?B?dFVFa3FKMXdIeFBzSXlCQ01nb0xNYzE4T3FjZkRXemYzTGtpelRaWUEyRXlR?=
 =?utf-8?B?TEp5aFZlOExMeC91Y3ZUY3pteHkxb2RIM1RXMXN3Ukw3WDcybGhRNW5zcnBu?=
 =?utf-8?B?QVdmSmcxUjRsakp0YXNHVzBiVFkvWDZYYWhTc2dGR1dvUkNaTjFrK3p3d2lG?=
 =?utf-8?B?K1Vpd2tYTDVjS2hWeFNMV252bE92UFpiTXV6d2lsc3RKUkgrdXJxRXFJZVZ1?=
 =?utf-8?B?WGMrZ1NTYXdZcGFlL2FNYkNSa3c5KzBzait1Kzk4SFZuR2o3d1dDM1VzYzBC?=
 =?utf-8?B?L3NPL1h6aHlUV3VkMERRbDh3d1B3UUlZZllVbmp1UDBMcVhLN25adE1Gdlpw?=
 =?utf-8?B?R1FHeTBIWXF1NDgxMUtCaFJaUHVLNHR1STRMY09aRnVCVkhlVXcxYnNaY0RV?=
 =?utf-8?B?N3ByR2YySTlaVHlqbU9rYzloT3g1aTJhanpxYnp1R2xZNEpPd2lOWFNCYUlI?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a32997-0f9b-40a7-67b3-08db6e3ecf4c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:53:45.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCoStxAkStYhwOnHhLG5P/xQ1fBh/AVUPQ8nCg7NmUevmmp2M4m3EmfFTM99Z30gNsUia905KUXnA4jNHTx8xuJC8p4Xfi3vnHh0VIpimJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7736
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 29 May 2023 15:02:08 +0200
schrieb Linus Walleij <linus.walleij@linaro.org>:

> On Mon, May 29, 2023 at 4:55=E2=80=AFAM <xingtong_wu@163.com> wrote:
>=20
> > From: "xingtong.wu" <xingtong.wu@siemens.com>
> >
> > switch pin base from static to automatic allocation to
> > avoid conflicts and align with other gpio chip drivers
> >
> > Signed-off-by: xingtong.wu <xingtong.wu@siemens.com> =20
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> If this platform does not have a ton of userspace using the obsolete
> sysfs this should be fine to apply. I say let's apply and see what
> happens.

Seems after some discussion we concluded to merge this. I guess it
might already be a little late for 6.4.

Henning

> Yours,
> Linus Walleij

