Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459546F92CA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjEFPji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjEFPjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:39:36 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01191A1EA
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3w8UUxvVm2y8OU24R4XpMOFCeWnYgtiAk0QvXAf9u/3Oj99VHdiXmdDKELEgRTqXEAZlm0ZRyfT7rXQSVCuKA94VeAHC8GJppTPz6SG4j4PrW9KwWr0Mvszha//EOFbTJ7K7V966FPx5P9uMJ8T07DEkLKkhlCftSHbE1YkWjfiBckUh26H75AHiw/0v2SYgIuBrJ5EA6+rOebujhAWHoCCnEeIZ9ovlOhW7JxZHUpAObNgqKe1fEs0ogHJQIBrLydqgSFOgcA+hpcpdhdotigLpt8exil/EbEQ0MvckFEpK6eOOcIsQ4rZmCs4micNM+wxCsAvCiduVygPtpHKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z15TR356poPjUqLDO9d0FUAZKLCViFCL6Et0LGePQXE=;
 b=H7jo8zkYFjysBMNP9z7FRVwMg4TXwCDYXASP17CQvnRB+Cgx5yUDuTFAVU1NIri4povFYZn1f8adMQFDIDTljGHRONpHMh6xR+VXogTRlo4APxZipsqU9d2+g3p113wKEKan9sk6QK80tJyM4WnQGLhXJ4sx3ewAZt+DLzdHTxI/Z7YWoWu6+haetui+5KANQJTOVrreC1mEc95dlvINHo4vgwQTvd7/iUTcd8ppBDl1SY24IVJckaM+r4TdQZslOauvdZn8mpnTLzC3NcrXwqVRMnXBbNt1tgLin6TrHS4aRjPcnSTzJx2pIYqERV2NNaGpWhdEh0FtAc4Rts/MWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z15TR356poPjUqLDO9d0FUAZKLCViFCL6Et0LGePQXE=;
 b=mEmduO3aMT/zx/TwoK5P8LiUxVzMg6xhIBYENXcj4EK9kwpLnjIKY48LdyhDM7SZ3BpGKIlKkkwLQjofhKTOWI+3IKuZwgk9+vGTCTEjZYjZ2c6udNsPBp8a9wcwgmhA5n5+LFlZgG1ed7WehhCl6ip01aBrT8bmlG9T7w7C2IwniD3wjJ6CXSPEwYUo14SEB67TMVFFPJNf1cqJnrYnenITSRBap4a56cv8BmVFSGf17YF5tbvsQIN17Z3MIjfYOM/wySDn2uM7kLIfdI/RVKyir/qaabZlXSZI1s3yJI4cI9iKFf12Ac1I5/UqbfXEfofVtGNxrpPEkds5jrbTPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4512.apcprd06.prod.outlook.com (2603:1096:400:8b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 15:39:31 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%7]) with mapi id 15.20.6363.029; Sat, 6 May 2023
 15:39:31 +0000
Message-ID: <aff39252-6a67-c8e9-47c5-84ed4910d62f@vivo.com>
Date:   Sat, 6 May 2023 23:39:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3] f2fs: add sanity compress level check for compressed
 file
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Nick Terrell <terrelln@fb.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230407183148.23231-1-frank.li@vivo.com>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20230407183148.23231-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:3:17::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4512:EE_
X-MS-Office365-Filtering-Correlation-Id: 5136accc-0bb0-4a98-1736-08db4e481573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2EOBLnoS5fddYA63g1jMWTRSZKmgS19Wxl0fjhDPU6+/LhoDepGWjvMQzxiuncyH7ry9B3HJbC4QrpKzGSoBCumCkgXHUdKc05o4T74VHDhUmdWBgp0l8vzZUy4Z3V/7oFYDzQ20wBSuhpJnFCS8zBMLhgZaaJZ553Gk595AZlQQMyZEvdXkZQStgZrpwHCRgOEW1pnUl2USrKLzw3LZkgJEYoIDn5gmZi53VnJWh2dwVxPxQFxZ5EKHt6PK/5i9Axw/lsNXqeKe/3o8CrtIvxO2V2a988jiUqvvp1ApoZFze/OEDkEaJrSZ30Fk3pwUAS9jclF4QqLxeGLPGZY2j4Zqq0k/gWhI0OkMgiVuWgcM30bEUPdygR9kqhF1LjG4CwPgKSHwHI6/sEMhbW3l+rYiGDYHlyqV1mRLsV9RD2RuY+/r8EE2fTZo6+bczuIypLhz/sJdk9Flb8GIPZNBtFb8SCdhj913uVU2kyxOrz26EaDg6mIkOVhHhow54mbZ9MIPpdTb+r0xxHqf+U2HYWB+39syp8AXIdSTyPpVHhNZRCUyZebbKRdDMPzvtm3O+8ZP3ne4mDhhwZtc1K2OjACqY5jSiaphYdrLvU5RAKFm6OaJPt8nluHDdArkCXeKJ7S3NWxf5wlKVaC/g/IMeinOh01MCzueL6xkruFVk2cNmhdhJ2iVB+RAnSJb+xs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39850400004)(376002)(396003)(346002)(451199021)(6666004)(52116002)(6486002)(36756003)(2616005)(186003)(38350700002)(38100700002)(31696002)(86362001)(558084003)(26005)(6506007)(6512007)(66476007)(66556008)(66946007)(4326008)(2906002)(110136005)(31686004)(41300700001)(5660300002)(316002)(8676002)(8936002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVBuU2RtUXlKa2tEbmNPRDM3dFRYeGluY3I0ZHhOdGEzYWlVNlZoT2syWlcv?=
 =?utf-8?B?QzlBdEMyaDhZZ2ZTdWl2d01GdnB6NjJhdko5ZFI1UXdCVDdDSnBzWHlkZG1H?=
 =?utf-8?B?aXYycnZVcmI3L3FqYytQY3VjSDU3YWJGRkIwS2IzeC94U2JSWWxoanpmYzI4?=
 =?utf-8?B?c2RIQ2czSHNPL05wZW1KMzRzcVpBUE9zNDlDQ1pBaXVndENlR1FEcHVwYlQ4?=
 =?utf-8?B?ZFZNSk5FU0JTWGVydmRnNDRnc3FVanZSZEp3Y3NlK1RCLzREYm40cW5oRGxB?=
 =?utf-8?B?LzFsZkJYZFZ3NG9SUEF3NElMa3V2N1ZqNEFnNU5ZRUNwcFRSZCszZjdGY3Fj?=
 =?utf-8?B?NElpODRKaW1mNkwwVTNQZERRTnhCWU9BNkZqNlh3OVplbFdjcjNHOXM0ZkhX?=
 =?utf-8?B?bGlVR2tFMkt6NFZrQm1TaWVROGlSUlBydUJHdVJ5WW5hSndiU0tlbHR0Z1Iy?=
 =?utf-8?B?aDFSVGlIQ2pnbEVuTVU5SlhCdmhjT3BNZmFhRnFFdk1lUm5LZEZsSEIwRlJO?=
 =?utf-8?B?ZmNhNUtNUDRQb1F0SjRLckN6ZTI5eUduUHVnZUE3dU5pWTd6NDg0UjVWSnBn?=
 =?utf-8?B?SkdKNTdSMnFJQW5OcXhIVmV1U0VHaVlTVHlDMmsvV3RpbG82elM0Zkl5c3FD?=
 =?utf-8?B?b3ArRjMyaUx3aTJndThDWWZNTW5QSkxTd3NuTmluanIzZzFEQlkyQURxL0tm?=
 =?utf-8?B?d0JuRFJsQUp2YTFlQmNoVXdDOG9GYWw4SVVXelNyVzg0eEtRQkk2djBaalIx?=
 =?utf-8?B?UjRvS2FxQjNKNExvNGlqWVl4RjRvSFpHOERMcUF3emUwYkxVdTR2MTQwMXpQ?=
 =?utf-8?B?L0Yzb1NDUHpLNnhXQ2d1a0dIazhxVkNGbnRvZWNXM29ISndlQW1kbWtVdlBk?=
 =?utf-8?B?cUExdUJpTHpSRExiTXFKN1QrRGRTNTVJR0hTNU4zVDNLMWcyVXZPbXBLTlcz?=
 =?utf-8?B?MVk0eXkyZkZycnlUNGZFWEcyVVlsWHc4TTVMOGtMRVJJOUFzL29UcFNrQWZR?=
 =?utf-8?B?dTNGK3JhbkFvaXFzQ3hRdFpFNm1NbGVuK3BIT1greVBCVlNyZGhMamlDUDUy?=
 =?utf-8?B?ZFFvOXhQTG1kaVV0YjJjOHM5T3hCODFjTXk4Vmk5K1o3c3pTbEp6Nm1GS2Fp?=
 =?utf-8?B?SU0wK2p5SVIwdmhPUnZ6VCtwNEZQWmkrdFZabkhoV0JVd1o2ek45Y3gwVjUw?=
 =?utf-8?B?ZDkvME1xbXRQVmV3a3lvbU9VOFNDaTV0azBTQXcrdVVsTWI1VGNjZnlZV1Nz?=
 =?utf-8?B?cVN0TGhyOW5OMmFnejZHVDlDTFVFcnV5RzBMM2hjK09STm1RcklHdnQ3Ullk?=
 =?utf-8?B?c2Y4aTJqcStrWnU3dGVmWW03eFcvbG9OTitpNTAyckJYQUVBUU84WSt3T211?=
 =?utf-8?B?U1VUcmJIUWxTQjZzQkNEa0ZhbGVpVzU2TkpFT0VqZEhNVUZ3OGxCVjRZSno3?=
 =?utf-8?B?S1FTVlR6T3BNUHovN254eWx5SElRL045ZmJCbzUvcklQNEdzc1g4M1FXRlJ2?=
 =?utf-8?B?ZGY3OFpJZjRRbVEzTkhhZ1JEcHJXWlRmNlNFY25OZ1p4d25JeHdJOGx6Mkor?=
 =?utf-8?B?TitxaXhMZDU2WUorWjd3anV3SmRnODBaWGllTWhVUWVTdE9nU0dxc1RxdjlK?=
 =?utf-8?B?dFBxUGpHbGJ5bE9XOHBsdTE4b3RYSG05bnhCT1lFMlc3bU9uUmtnREpUR3g0?=
 =?utf-8?B?RGozUFhEaU5zOUwwaStwWEV2Z21EVFFUU05BRXJxa0R0YW80clVubDlhUlNN?=
 =?utf-8?B?cHQ1U211cm5EdDIrdG9LM2RDcktyRVFTaUxkYzB3VW4vNnZkS3dYVlNtZzht?=
 =?utf-8?B?d21JL3JFWHBnVFN4djhKV2dFazhnUHROckhrRmlQSjF1TXZ0dmNWL09ZNE5n?=
 =?utf-8?B?Y3VjTThiUjJtbWZlQ09VL08zOCtMc1pKTE1ZbnJPdFdoZkg3TjdPMjA1NEJh?=
 =?utf-8?B?Y2lMZmljYjlpbm1WMVBCeDhSQmkwTUtlc09UN0N1VVRRMERHdXBzdHdkU0tr?=
 =?utf-8?B?Umg2YnVhUFFHNEFQSmpyaFFiakkyblNqaGJxbWJ0alZ1K2VMNXZVMFc1RVZk?=
 =?utf-8?B?bkcxVDVWNkQxVVhDRm1QbVQ5QldTSkJ2OTRLVWh6RVoyRWRWdzdlUmhuR3dt?=
 =?utf-8?Q?TZ+oWpSxVMVD0z0LIoEwdY1zz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5136accc-0bb0-4a98-1736-08db4e481573
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 15:39:31.0063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWmReL27/Hg3ajcLT3DGYrkPVfmCpQ64mMTcEYoScWgqAHbQE2ZjFx5VBydx3AUb9fZyEQrpl3vsm4LaN0J+uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4512
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping......

 > On 2023/4/8 2:31, Yangtao Li wrote:
