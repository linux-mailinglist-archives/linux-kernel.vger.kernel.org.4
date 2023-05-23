Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0973E70DFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbjEWPCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbjEWPCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:02:00 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD5811F
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvP/IbYoguGA2WD+yneevQY64H6CLJebKUyFNTNeJ+s=;
 b=KAkikDiGWM9aO776bPf+95EW2/2M553e3r9XhxvuvT0ip06cDtACM3Y9bVdGkIvkQF1MKq4O3jUCEyoHPi8DKhVnnRSiRWsaDpTx31eBl08+jPo5S7E+4Jhw0nc5muUXmKP4DkzOmD5QN39o1L/ucakG+X21QiGWB7OVD9xUSf4=
Received: from AS9PR05CA0059.eurprd05.prod.outlook.com (2603:10a6:20b:489::22)
 by DU0PR08MB7764.eurprd08.prod.outlook.com (2603:10a6:10:3b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 15:01:53 +0000
Received: from AM7EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:489:cafe::4a) by AS9PR05CA0059.outlook.office365.com
 (2603:10a6:20b:489::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 15:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT029.mail.protection.outlook.com (100.127.140.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.14 via Frontend Transport; Tue, 23 May 2023 15:01:53 +0000
Received: ("Tessian outbound 5154e9d36775:v136"); Tue, 23 May 2023 15:01:53 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 17b16d243c613ad7
X-CR-MTA-TID: 64aa7808
Received: from 913ebf08819a.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C2F28EF2-D4F7-43E1-9323-C881F348D71F.1;
        Tue, 23 May 2023 15:01:42 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 913ebf08819a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 23 May 2023 15:01:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDBV1XPaAtULJZK14L3gOIUPi6TGtEgbL053mT+m8Kg851kjydmsJyLjmv24/gk1bIio7NV6Jci9U+Y3fALM0t4eOqtuorRj9MBA5c78J/wT1KSMyMu4NZz21aJdAyFAbbFuC8Y9i1ribEFTxcjnmoRAXrY63AcVyPqRR4zfW8GxXFfQse2tXrIuiid1rMYC9snwNqAl80BVIbU8XLL8RgWcax6ZIV2Kmfhvpy0h8fIJGNlU7bMpBD09m1HB2ZRV1uulBFXGLN63Rrb3AaT+nTX7SnKi++vI1ypCV2CdqeDvsan9+YAkZp4RHrisv8wQSle0E1RoiZFWeOoViW3+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvP/IbYoguGA2WD+yneevQY64H6CLJebKUyFNTNeJ+s=;
 b=A9ViV88AMGWbqHL2ECzXR9KCefs6sp6GSEMVoo3E35t4QnsfngNWeZdlpP5ZYJp7kWb2+w9nhKRx1aTeBcFamkFGEtZT2BWiMOPgSWrL6OZzcI7uLZv+tUr1XkRDgY7TVWZiqOFO5dVc9Arz+JzupJSJOBQFjpLx8BPxUbsS8i8RepRDaB0y/h5kzNOjL5GqAisxGTh6VJjBldWKmuObQj+/r/Ui9yIbEPHUhAqCDpzIsoAhxrmczBUAkjb4SGUdGDPFNXzjoCo+bgc2HX//oE/wAl552kobBjxjJWJISMYFuXzDdohOwOxbFbHEXfR9dT+zh46pgzWvZVSpqAZPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvP/IbYoguGA2WD+yneevQY64H6CLJebKUyFNTNeJ+s=;
 b=KAkikDiGWM9aO776bPf+95EW2/2M553e3r9XhxvuvT0ip06cDtACM3Y9bVdGkIvkQF1MKq4O3jUCEyoHPi8DKhVnnRSiRWsaDpTx31eBl08+jPo5S7E+4Jhw0nc5muUXmKP4DkzOmD5QN39o1L/ucakG+X21QiGWB7OVD9xUSf4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AM9PR08MB5873.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Tue, 23 May
 2023 15:01:39 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::242d:33fe:1c48:bd8]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::242d:33fe:1c48:bd8%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 15:01:39 +0000
Date:   Tue, 23 May 2023 16:01:24 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     David Hildenbrand <david@redhat.com>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        peterx@redhat.com, broonie@kernel.org, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v2 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
Message-ID: <ZGzVRO7eCsn7sOe1@arm.com>
References: <20230517150321.2890206-1-revest@chromium.org>
 <20230517150321.2890206-4-revest@chromium.org>
 <bb08b91c-6c7b-a7a0-d4a7-68ddea46277f@redhat.com>
 <884d131bbc28ebfa0b729176e6415269@ispras.ru>
 <d7e3749c-a718-df94-92af-1cb0fecab772@redhat.com>
 <3c2e210b75bd56909322e8a3e5086d91@ispras.ru>
 <c63053b0-5797-504d-7896-c86271b64162@redhat.com>
 <ZGy6q7v+7jsXb1bV@arm.com>
 <f47d587fe5a6285f88191fbb13f367c7@ispras.ru>
 <ZGzJNvKu8h5nDXsa@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZGzJNvKu8h5nDXsa@arm.com>
X-ClientProxiedBy: LO2P123CA0030.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::18)
 To DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AM9PR08MB5873:EE_|AM7EUR03FT029:EE_|DU0PR08MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aeda89c-9039-4363-b2b4-08db5b9ea516
x-checkrecipientrouted: true
Content-Transfer-Encoding: quoted-printable
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qAOQ8huATL0npiv/Ygk4zTfqbJT/6gLEmFUK2El9f044Hqg1N9+mjyPvvcs6HcSTyhzIBqxWc7GnwLZwjrDDimGolSF9YkipKeGKq7da+jNaZ0A/g31lgTW9IXcDv5Mfj7i3ueBc+WVyZDhsE6k0K2dJHO8cScgMY/cOpOE/tBr3H5w187Sxa3dTSZ6/BqU6dff+4ls8Ifsb8Dnuse37lIywAo+CwdU/UpI5yFq7eR+i5M6aHrEUn7gj0ZCk1jkDSA0ZB9NhRNwWSKbD6SI6vD03y4Jdkr/eq+xHv5vMskRW+KRJw3SWSdgwf72xm2WNbLlMc8u1HYaFUOCgB7fbo9lOaZIcVfVVOhIh38W3rvy36gwBYssFkyiI+HgrOpMCmfsHGXMaSjDKUMUZM9Gs7E8VYUH4O9FpfB6p/o4gdKuxy/aOr06axWQXURgouA+RIc4Gc7geoG07jdSjegGNY1AWmiiJRopGJEvimX9idG3evqPrNj3gVZf1rnweYBCjW5+jAnTYhY+FuszxxxUV7kgI/pVnJeQhdFAXcnrp6g0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199021)(2906002)(7416002)(8676002)(83380400001)(5660300002)(44832011)(8936002)(41300700001)(66556008)(66476007)(4326008)(66946007)(110136005)(54906003)(316002)(478600001)(6666004)(6486002)(966005)(36756003)(86362001)(26005)(2616005)(186003)(6512007)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5873
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT029.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2692f812-b3d6-4942-74a8-08db5b9e9c77
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uF6rZh60+r6wvAdYdgcAn/Locx6srsUe/a2UsSuv5BthEu8a48vKJJl/XQYdxZqeB3uPjoWszTnc/U36TA9ygB3UKB+98XHmUxm4zlJOxVFkZAmsnbw7DuPhu/XKwOBoxp5OtGbM6c4uYBCZHCDHwZU+qfWiSYLROMIUdBZ0XpGekR599hGktHgjw2nGcm7U+dFp8Co3FuMfGwbR4w1QHCXKsL6+d4L43FZkCaI3JumLl/NyQypciEddKYXeMOrni3bnNsIm+o1A7uK3JHR4Z5BOat7n6YZ1ymYpVC38J+D1JKMcPfi1ln6GEXCwQADmZi0rwtAZuVfiifPnIrGKsQ42hKkdaBV6HsN8K5TGAQ+lKWalbWjzyV0GyisE9ylsD+caQSyV4A1aCLplegdyUzx++WNU8l1qajDP48kFLtjs6megoDwff2Un1HRsKxRdA9eQs9kZMNcbMNPRYqsHZVKvbdb1uNnGArdyaudbDqh7D9fb6gX0B9EYJyWV62o/d1Ux+GkMkv85IXIjFiKHcKAXoEd3NYOck2LS85UsyQLehI0OSI9VTsA0zfS9mOvZHrEu0B/CEGAjVM+FFPdXRh6DhBM3O3CDKDPhSSfhSNd9TjhKUZ1Exb91HPIoaNWubKIyoKwwvnbnqVHGASm4Z4mUTMir/qvF0Av96qOf9rmtqMbIGhRW0e+PT54IEGR9jTkoHBU1JIwEn4mdGsfusF6XQ8sR4EXCadO1JNrM4AM=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(54906003)(966005)(41300700001)(6486002)(82310400005)(478600001)(110136005)(316002)(4326008)(6666004)(70586007)(70206006)(86362001)(5660300002)(8936002)(8676002)(107886003)(44832011)(40460700003)(81166007)(356005)(26005)(6506007)(6512007)(82740400003)(186003)(2906002)(83380400001)(336012)(40480700001)(2616005)(36756003)(36860700001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:01:53.5120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aeda89c-9039-4363-b2b4-08db5b9ea516
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT029.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7764
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 05/23/2023 15:09, Catalin Marinas wrote:
> At least for glibc, it seems that there is a conversion to unsigned
> long:
>
> https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dsysdeps/unix/sysv/=
linux/prctl.c#l28
>
> unsigned long int arg2 =3D va_arg (arg, unsigned long int);
>
> (does va_arg expand to an actual cast?)

this is not a conversion.

at this point the argument is already corrupt since
an int was passed instead of unsigned long, usually
it's just wrong top 32bit, but in theory arg passing
for int and long could be completely different.

>
> If the libc passes a 32-bit to a kernel ABI that expects 64-bit, I think
> it's a user-space bug and not a kernel ABI issue.

this is point 3 in an earlier mail i wrote about varargs
(we ran into vararg issues during morello porting but it
affects all 64bit targets):

https://lkml.org/lkml/2022/10/31/386
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
