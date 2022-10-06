Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B9E5F6C79
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiJFRCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiJFRCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:02:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0FE2D77C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFt3YqoZf7aFau3N2z6Vk84KQDHkrvLcsF6wAVwUY7izvaJ0snrhS2Oqb3i/KjonJOkQOzIyyAJEQhhbe2CGLzgCjrPo15g7aw2BYKN4GYG18ijZTnZzC1C1ltqiOMTRW15wrimxbGfw2iG1sjZThjYH2yWBDn/Vd56Ur+WanYbIIT+EfY/zpkhhABQsuwXvovqbL0ExvcwPx4tncFDeLFG+pd8T3qoBP0BIRRdHTXXujnwNXV3Rw2JYruIDeqnuD70glVSgRDTTgr+kzXz5dB1ze/ja3OKqaxdujNgqoX1RfBWYYfirdosE4DPmK6kCHPe4c0L5lM0J2iNchOMz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A6A38UvKJos/7OatNutgVVGrCz+/fFtZfS4/680Dv4=;
 b=Ku1kWyDTWjmNQgrbzQ5qr4vv2sW/DwfdSi+Us3I8nhz3dPGk6IjO+ngQbGyLdLCMWb1ALVjZtQDmMcrx9bIVwe47IwHVW7oDaG2x7Arr8KHXjBAMsGIm98cDsDodhNMg8wjTJhODufzd3sfbwMeWlgG6/gM3mDN6zbhh7KOobZXOelTTRBmasc3Emswzks1Zf8Hr6z3x/gVpn7HUhapP8LJeDHUjKWRlhkXNDoKEMEdODw3OnrPSC50pyEjk+tYmyLF3Hspesdj45LXCTNBspQDkBd2MjeypvJXnCOCvUrygsQRU+a6R+VWv/JL32rmlhP0m7wTiujVeInDUZfl+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knights.ucf.edu; dmarc=pass action=none
 header.from=knights.ucf.edu; dkim=pass header.d=knights.ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=knightsucfedu39751.onmicrosoft.com;
 s=selector2-knightsucfedu39751-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A6A38UvKJos/7OatNutgVVGrCz+/fFtZfS4/680Dv4=;
 b=b82+oojeOea3Re1PWf+MLylorDKHgzaWeBzjdiLnPYKEtoSqjcCstY4vlpG9+hGZ4/bMerdEnf+wbaCmkaNQ8+gNH+fQd0w0YvmafEPPaMHfxiTHnMxFxHm71QpVTHUuO413x0THiOZmQt+eQ5ey1VjNxAAN5vZb93hys9AofDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=knights.ucf.edu;
Received: from BN7PR07MB4195.namprd07.prod.outlook.com (2603:10b6:406:b1::33)
 by DM6PR07MB5019.namprd07.prod.outlook.com (2603:10b6:5:20::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 17:02:37 +0000
Received: from BN7PR07MB4195.namprd07.prod.outlook.com
 ([fe80::9a4c:e558:6a54:fc2c]) by BN7PR07MB4195.namprd07.prod.outlook.com
 ([fe80::9a4c:e558:6a54:fc2c%6]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 17:02:37 +0000
Date:   Thu, 6 Oct 2022 13:02:34 -0400
From:   Brent Pappas <pappasbrent@knights.ucf.edu>
To:     Nam Cao <namcaov@gmail.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] staging: most: net: Replace macros HB and LB with static
 inline functions
Message-ID: <Yz8KKkZ18svZdeec@knights.ucf.edu>
References: <BN7PR07MB419563C5B405ED4082D7841DF65D9@BN7PR07MB4195.namprd07.prod.outlook.com>
 <20221005235728.GA118549@nam-dell>
 <Yz7WVCzAviUYstX9@knights.ucf.edu>
 <20221006134230.GA14040@nam-dell>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221006134230.GA14040@nam-dell>
X-ClientProxiedBy: BN0PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:408:e9::6) To BN7PR07MB4195.namprd07.prod.outlook.com
 (2603:10b6:406:b1::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR07MB4195:EE_|DM6PR07MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: 4783d766-5f93-4165-5cc3-08daa7bc91d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqMSJkyHk4P5GCFHttLEYbArNfpe5RnP0a3Z7W2FkfXaZHDR6hb7BJUXYavv8ElCz7Vu5ZaryMwDdhkH9spnUYQBjEqCydEVmgGvtVOrxQQHzr/yUl0SJlY82Dcb4d94eGzJ6qqEPFDVuvzeP4ItS0n9yNA64ivagZJbVLoncKKixwh/rVcFZY2lucX2BH415uszn5GIy7bzQl0YnUQRG4XCBPRv3VIr7tpUKsSvdO0fnsrUy4PvXXU3P1dlGDfxeZGLdQkrlYOo8VejQSK6T1YyOhbKHHqvyQM12fcc6Qc3SW9ypPf+C/ozxQGDUBwbunfqplLBfK3+Kc2X9kV1vqUbT7VehOMt7SfBzUif/zK1zKVHVay3K4+NttgGMCghA73oX0YaTfR5QRu0lTvVekL1AkhR4WOGZA0uc2t8ooZI51E3cIqtWeFkylh49dEWbWtNOOsy+Uuc/soJ9fkiuBfHxaY+CQaEbKChyJlBm9Waf2/z5Sp8efS4FtIJwpzRy2NMnIFJemUCIDUyLAsP/k8yA9oz2N/UU+ODW5OGrkH/KTKgzGIdqPw8kwcJu1O+y4pxeHgjiaWS7uzLhpoQ+LbFzTThygDiOscU6KCETn4IRvZhRk1elicEDkqtAlTbEpBvb8um5e8PEcom5DD7KzHyM7EvSwjiO4a4GpN/m4s0xeKVEpo/me5MHccJ5+HqwTuiqS4Cs0Kmtuhz29DdpT1PyH/WxTZhcnbLKn+Fuy4AtpGKxxgErsrI0rvodC5M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR07MB4195.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199015)(8676002)(2906002)(66946007)(66556008)(786003)(4326008)(4744005)(5660300002)(54906003)(66476007)(6486002)(478600001)(41300700001)(8936002)(6916009)(6506007)(6512007)(26005)(86362001)(186003)(52116002)(316002)(75432002)(6666004)(2616005)(41320700001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUZMcGVyM1VESUEzaW9NV0M0S21mR0RlS3ljZEVrNG16R3ZwbVlHNjBpaUhh?=
 =?utf-8?B?dVB6RkxKd0pod0RGSVRVK1JaLzRZeW1QOGJYSUhVRUh3TXRLS3I1Nkd6ZEE3?=
 =?utf-8?B?WUNjUmhURCtpTWNobzYyUTVUd2RqKzJRaFBUb3lCR1JTUnBQb2FwU3lTSjdW?=
 =?utf-8?B?MnUrU3J5M2JhMW1BclpVb2VXaEU3MXV4YnNjcWxHWEtvNGIrMTFCdHUwbmtq?=
 =?utf-8?B?NW9CMVl4L08vdm42V3Z5MkZjNVRFdkhxTGNseVdKbkZ5UjduNUZ3SzBGWU1l?=
 =?utf-8?B?VHplZUtSb0tPWDdZZmhzbTU5bzluQUhaczErek83U3B1MGVMRFdnOWE5UG5D?=
 =?utf-8?B?anpoTkoxQ1N5QnNXNlc5QVlCUFFNZ2RlR1F4cWRLeVpxVnN6S3hhZzFKVnhy?=
 =?utf-8?B?R1hTZjlLcWltNGlwYnJJL2VidHRsV1hDdXZyNnQ0QXhvdnRnVDlHZklvaVAz?=
 =?utf-8?B?MFNOVkVjeGVMVG1BNmNKYVpmREJVTVlqVVZ1SWQwMUdKTXVGbmx0SkRvNnFY?=
 =?utf-8?B?WHp2UnRrVVRxV0pRM0VGT0V1V3BpYnlUOGphZXo0T0ZlRkR6b3llWm9pR1VU?=
 =?utf-8?B?WUUvc3JBOG40MG1KZUxqcENtVTF0TDZPSVcyRC9MUG0xNFhaNFJzRjZjTzRE?=
 =?utf-8?B?T2RYeUNJTEVmaUxUTW9ReURCWkVuNWRHTmJ1Y3ZId2gwdXBiMm5jODdZZUV4?=
 =?utf-8?B?SFh6VWJDQXFzQVcrK0E1TFNCQ1YzOXczeWV5dHhoa1ZDSjhMTHVWU2xrTWJ4?=
 =?utf-8?B?STNyMkNnSXh1Y3BCbzR0b0s3cnlnWVhKeXZNcElGRXlVdzg0d0R5UEM3M1Zs?=
 =?utf-8?B?emtUYWJqZm9CTWM4U004ZHFhUmNwcDlhOG5UK1puZGhOajRUMUp0UVpLQlZi?=
 =?utf-8?B?aS9tOFhNSXBJaGIxT1VqQ3haeVRFc1JySVd4VFp0NFVaa1VaeUk1TWNaUWh6?=
 =?utf-8?B?SkhvaFF5UDk3SmJKT2RKemtvN0x3R1BMNHNEK3pSb1BON1piQURlK3YyV1FY?=
 =?utf-8?B?QUJYTnlBTEJjWTJtWWdIYXIwa2lJMktyZUxvc3pyUy85R1phV0VQRDVPb3ky?=
 =?utf-8?B?a05XOTl3ZFgzTy9LTDVPTXpIMFZPdUZ5SjJzdVlPSHk4TVlNUFV1SVVDUEdC?=
 =?utf-8?B?T2dPcUdXSFBoU1JYTHYzeHJXREFhSUs4U0tFZHNGTDg2ZW8yZ290OFBSeHNw?=
 =?utf-8?B?bEc4YUhTMmdKSW5kZHBRQ29rV3AvOFNoeWxTMkwzM0hLbzQxMEd5cU4rRld2?=
 =?utf-8?B?SnZ6UWNBSkpJTHpvYTdNUkV3YWRELzhoQWdieDdYVitTR0RmdXR5OW1IZUlK?=
 =?utf-8?B?NGdpWDl5N2pETW5qQS9HZytUbC83Uy84T1JtRGVCdkU5eW5XakwwV3l5MmZS?=
 =?utf-8?B?MHkwZXpvRTg1RmtTdzJ3bkFjb1NkUmF3d2lvSEZXZHZDMXZzWGphN1pjMGo0?=
 =?utf-8?B?SW1ITjVkL1VUYnlLcEx2L0dhVHB6azcwdjgzRW1CZUhublVpZ2paQitmcTJr?=
 =?utf-8?B?bDJyaDE5bjZKbU1vRk1GZmw5ZzRrVzNtRmRFVDJEaXEwa1ZFWnV0SzdjQ1pS?=
 =?utf-8?B?MTh3cWdCbkFBRzBrZUdHSGJzejRZSU9adzlSbHRTMHlHYzJzSUdMTWlZWk9i?=
 =?utf-8?B?M0U0TVkxU21uMSsyNVBXVlV5Q3h1b3puazloTU5BQURncmJRMTlsKytEUENr?=
 =?utf-8?B?cU53SkxhQzVoR3kyTDhwQ1ppeDAyZ2RjL2k4cFg4a1hQSDR5SklLZmVFWmJj?=
 =?utf-8?B?OEFRU254dFVWR3FrR0NaN3VrMXlXOGZrT1FvcHhtUVdpK2tZM0Iwd2JkY3N3?=
 =?utf-8?B?T0Zwc3NMTEswTytxWHY4bzFub2RNalAvSmoxeDRXWXI3UVlkakp6Z3dGcmpU?=
 =?utf-8?B?cG52bEtQQ0N5c1I5eFFRK3ArbWRqZ0loRlhhQS9FcGtRS3hpU2J4Ny85ZUdG?=
 =?utf-8?B?WGo4ZjllOXpEWGZ4RHdDMFp1dWRSOTZVQzZFbktRNlNVNG1UUzZsNVM5OEVP?=
 =?utf-8?B?c0Q0V2JDVlNRSU5GZnRWczVHUlJ3SWcwZ0RxZk5DMkh6Q204SVNEanRaZXpW?=
 =?utf-8?B?bG5Qb2dwTGhoL2pCMVRGRUdZclFMVWdYc1J2VmJGUXpqWFRNL2VyZ0QvRG1q?=
 =?utf-8?B?cGJaa0JqN0RKT2xGVkM1d0xaMmZ0UXdhazVGaXZaZURHZlBCSG1mR1M1QVQ1?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: knights.ucf.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4783d766-5f93-4165-5cc3-08daa7bc91d2
X-MS-Exchange-CrossTenant-AuthSource: BN7PR07MB4195.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 17:02:37.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5b16e182-78b3-412c-9196-68342689eeb7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSGqGoKwDVJih3UUmy9dIi0GE9aydn56OsWS67AL2UG3Z4Kzf6FTVmzc3us3Z2ryg/qPaaaFnWw/jwPEpkNzEwDYJxKjAaYXZct98zOs9gA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5019
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace function-like macros "HB" and "LB" with static inline functions
to comply with preferred Linux coding style standards.

Signed-off-by: Brent Pappas <pappasbrent@knights.ucf.edu>
---
Changelog:
V1 -> V2: Resent diff from a mail client that would not replace tabs
          with spaces so that patch can be successfully applied.

diff --git a/drivers/staging/most/net/net.c b/drivers/staging/most/net/net.c
index 1d1fe8bff7ee..8a8fbc274b73 100644
--- a/drivers/staging/most/net/net.c
+++ b/drivers/staging/most/net/net.c
@@ -36,8 +36,8 @@
 #define PMS_TELID_MASK		0x0F
 #define PMS_TELID_SHIFT		4
 
-#define HB(value)		((u8)((u16)(value) >> 8))
-#define LB(value)		((u8)(value))
+static inline u8 HB(unsigned int value)		{ return ((u8)((u16)(value) >> 8)); }
+static inline u8 LB(unsigned int value)		{ return ((u8)(value)); }
 
 #define EXTRACT_BIT_SET(bitset_name, value) \
 	(((value) >> bitset_name##_SHIFT) & bitset_name##_MASK) 
