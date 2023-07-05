Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F017484F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjGENao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjGENal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:30:41 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2095.outbound.protection.outlook.com [40.107.24.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD1319A8;
        Wed,  5 Jul 2023 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzzhH/rqjiPS4yBcZ466ZUkjNRvT5dcUCstQhyeZxqM=;
 b=AyFm1QKdPDUnrYYJpR7veH4APjrwhvEJZN4p29NSoCgG/L/z1OWQY3zAFljq8mcaly5HFNQmgSW2jdaUl4vkgH1OFmIVFsSNwbXZekPe+/yjBupmzp+KB70e9yUJwrtoA6A1e5NlCMG6dLVBqPWWB0uvcpK5vTm960ngvlYsGV8=
Received: from DB7PR02CA0021.eurprd02.prod.outlook.com (2603:10a6:10:52::34)
 by ZR2P278MB1081.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:30:22 +0000
Received: from DB5EUR01FT054.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:52:cafe::d3) by DB7PR02CA0021.outlook.office365.com
 (2603:10a6:10:52::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 13:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 DB5EUR01FT054.mail.protection.outlook.com (10.152.5.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.24 via Frontend Transport; Wed, 5 Jul 2023 13:30:21 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4Qx0s91qfVzxpF;
        Wed,  5 Jul 2023 15:30:21 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2045.outbound.protection.outlook.com [104.47.22.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Wed,  5 Jul 2023 15:30:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzzhH/rqjiPS4yBcZ466ZUkjNRvT5dcUCstQhyeZxqM=;
 b=AyFm1QKdPDUnrYYJpR7veH4APjrwhvEJZN4p29NSoCgG/L/z1OWQY3zAFljq8mcaly5HFNQmgSW2jdaUl4vkgH1OFmIVFsSNwbXZekPe+/yjBupmzp+KB70e9yUJwrtoA6A1e5NlCMG6dLVBqPWWB0uvcpK5vTm960ngvlYsGV8=
Received: from DU2PR04CA0283.eurprd04.prod.outlook.com (2603:10a6:10:28c::18)
 by ZR0P278MB0041.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:17::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:15:16 +0000
Received: from DB5EUR01FT029.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:28c:cafe::12) by DU2PR04CA0283.outlook.office365.com
 (2603:10a6:10:28c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 13:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 DB5EUR01FT029.mail.protection.outlook.com (10.152.4.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.24 via Frontend Transport; Wed, 5 Jul 2023 13:15:16 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.113) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 05 Jul 2023 13:15:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg6OTZTSrgP+KAv4nI1UQQZkMD84ptsC+/B2maXLKgoJXqUw8AVopp4RJfmNh2Ld9fAjN6e6MygHIN+SMwUTLPB21qKCIgOArF3tPvsp7tessjAePr3VlWoeWQAHHqKbcoW1FDdEMrJ7DowtSGkNN/D0X7pkXV+E1IWGovetchFzbYcFmf8cfDu/RxGO3IC9bCEMeYSNvh2uI5PABsSb5JaBY+MV4RTriNgT/Ple7dnmyc4WH9RZp3VKAe5eqcPYktXCGD6x8AbOmflMLJCYZkP196eTOWEt9NOKxELIjWsQi1bckNzx3IxLedpVhfkdx+RneTc9+k6zJoGzBK/goA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzzhH/rqjiPS4yBcZ466ZUkjNRvT5dcUCstQhyeZxqM=;
 b=F4tc0hixQzaplcz6UDCTSdfMXYZSKcyWcHEyxpMxeWExRyyfajYFDkeo3COlMxZDZ5KVtB1QGmunR2X4wcOk29qsD+PtqNZByck8yvB80W6tKiZR7W9nBduLAFdmym6GE8YunWu900YkKsjdIhh7SYpv8V0+4Kh5hUfWW7MQc/guEinJdQNPeN6Ml/ft4PihgybmHVHGH+7ADzbk0TT/fJMJ9WEOLa4fcfbTSSNzxifWy1ho9DbWomdqGrpoJ8YWT9M81m+vSl6GRAdxI9XOlCG8ip7sjsAP1KK6JiBmHimcjUmAfdN0qGqcR6RXWggzGVSlOP3YWbso7JrZUIEhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzzhH/rqjiPS4yBcZ466ZUkjNRvT5dcUCstQhyeZxqM=;
 b=AyFm1QKdPDUnrYYJpR7veH4APjrwhvEJZN4p29NSoCgG/L/z1OWQY3zAFljq8mcaly5HFNQmgSW2jdaUl4vkgH1OFmIVFsSNwbXZekPe+/yjBupmzp+KB70e9yUJwrtoA6A1e5NlCMG6dLVBqPWWB0uvcpK5vTm960ngvlYsGV8=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZRAP278MB0875.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:15:12 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8c78:4a4d:bc93:c620]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8c78:4a4d:bc93:c620%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 13:15:12 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
CC:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>
Subject: [PATCH 2/3] 8250_men_mcb: Read num ports from register data.
Thread-Topic: [PATCH 2/3] 8250_men_mcb: Read num ports from register data.
Thread-Index: AQHZr0K629B3pWDifkyi2ePTTBFfaQ==
Date:   Wed, 5 Jul 2023 13:15:12 +0000
Message-ID: <20230705131423.30552-3-josejavier.rodriguez@duagon.com>
References: <20230705131423.30552-1-josejavier.rodriguez@duagon.com>
In-Reply-To: <20230705131423.30552-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZRAP278MB0875:EE_|DB5EUR01FT029:EE_|ZR0P278MB0041:EE_|DB5EUR01FT054:EE_|ZR2P278MB1081:EE_
X-MS-Office365-Filtering-Correlation-Id: 258f9141-1b8a-4818-2835-08db7d5bfba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lhYHM6Du2aVHf5ladjSBy50lbeyohmnXE/758/IVJMQONK0lMQYez69wO6APvTdQHPaqAM9XVFEzcyQS4hKLhApgr17KulygUB+jUEcJk/6N2Wcv2fztOZlyJksf0ijpZC3xM3JDvY8zfGA2+FJ0zowAA0SPjOJlE6n33ZdfCOiOn4BKR0ROTku7qN/tPpR9JLdCgy82vVa5RgpScsPVO1/CvE3V7Th4qZukjHeiTiU8kIkkfF1J3OxSMKH3AGzkAQkGxQ5NWE22mqNjQLGqJHBneNE6wYtl5bop7Idz34mi5Dk9AhOOkBrODClsB4wdHe/LPj7JMLLAtQP6bKWyA+AwnJsLqPtrs+240lnTpzcgb6MtiE6I05hsi3FZGEoNLfefG40TFN8/+lWVyg656Tgci0IDRMWKVNpzkZnvBehBcyPrqT/LVm74UG0MupeaxZ1+SbPDthUslGq5eAOXugt5PBMmllsPSdkGOmd+U9uv9peIq9ItaJLE4D4BDwiRCNDCZBmQwrdYIZ5aEGqkQw52y0x1vWcNQzLk/gqcEBWBRppF9tKvebPTkm+CzOj8tVZvD53Vkn96B1x/9qlM6hlguUDHE9fRvIETQ3vXKzGgvrTueYJ8DGk0yGYjgR1occDCw3CkzU91C3VWtY8RpA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(39850400004)(136003)(396003)(376002)(346002)(451199021)(76116006)(91956017)(66556008)(64756008)(4326008)(66476007)(66446008)(107886003)(122000001)(2616005)(38100700002)(38070700005)(86362001)(186003)(26005)(1076003)(66946007)(6506007)(83380400001)(478600001)(6512007)(6486002)(110136005)(36756003)(54906003)(41300700001)(8676002)(8936002)(2906002)(71200400001)(5660300002)(316002)(414714003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0875
X-CodeTwo-MessageID: c799f95c-d563-4b6e-9a59-2dff1778767b.20230705131513@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT029.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: da788636-1662-4c37-9146-08db7d59dd4a
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Ru4QdlEGXgh91IymW+xiLF9SrTrMewL3WbEgbAZiUfzGc6ncsC+Vx1NbLaX+XtWZKsL/1rZVI/NVOHg2Un+OBjxuguC7aqA0nv/CWNXVAZLnlDc/OYGwPH4m/yhloLpRodooC8mVvfSMNB697WJ9LdbGwE1eQrjEnxag5AB2ym41htmmhIpsnfmyAKIJZWflSlnt2CAKW92KvmYE3kEJXcUUR0vpyx1vhtUENC8oSQ7Nbbc3IHvEStdk+5v5WtV48YiI1M4Vgf23BVK2hJlZoMj6QsE7uSL04BMpJBtDuvDh+95eLORy9ZeLRYLKG5JwFNEbN7GjBxu30LQqTEf4Lcg1n8ZijlCgNe/uQVX/cHqLXcr/LFZ12oh8XSZNrCDk1Ltp3+209vNFU75y1y8c9qD0X/0ltCbWi7MRhBduhn3r4hMNffH0npVVeeQ8XAp3E01mknZ9cSukBGlhU0J6Lt4jA6L4a3KU5Q6hqduVCA5xa35iT9fYMxJD2cBXZC5P7acO0Yphf5eL+fc+UNcoz6lWstVVDxHq3u5HDxeWesKpZav9sGtZ/M03PKsXgGVfwk0HyoL4SBRegRj5UIiK2A7rU6iN4f2hvx9C6XG4ZesaVmbiCZJ0g2BBTQR94eKehfZ+p7hZQa4AfJKuDJA2ZeyGYIXtD/u6v9lXkbCKfZjn1PwkEf/E2SLMXgnKeP+1ZplVJ1ZXpHDnqIc/XIygdOwR+Ry9r4eV62yCagMm7Nw=
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(136003)(346002)(39850400004)(396003)(376002)(451199021)(36840700001)(46966006)(4326008)(316002)(2616005)(36860700001)(70586007)(83380400001)(8936002)(70206006)(336012)(2906002)(47076005)(86362001)(1076003)(5660300002)(356005)(8676002)(41300700001)(186003)(6486002)(6506007)(6512007)(478600001)(26005)(107886003)(110136005)(36756003)(54906003)(82740400003)(7636003)(40480700001)(7596003)(82310400005)(414714003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0041
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT054.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b1e3c0cd-bc6b-4be1-8f4f-08db7d59dfde
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zpUufDnF3SWBKVsvoBf2ouWMdzRwzUgj/JyS9KYatMkuOIVv9zqeg6UTO9453Kfa8G13WIXUGxP0YPPcQYTzg+a8xvUgc3kSXbK6R0qV3TDIezlomSKmQhHIbg20GRWja/fxe91MVpJsBhWFO7isTMbevxuvDwT3yca/ekC990WGFgkK/1mYN0F67cVRUYfQLkNfWgXHB0dhkT24AR7TnOwt50F4P9A9/Z8x9/aqlglSyayH6H/qG3OE1RDvl+UNopJkdPPNoLZjaQacBOLaK80HP+JcLT21419NfjHxnv/WhNxh0yQLYHcLk/OLwuk7cfA63UE7XrdmUVtMLT3rJx3jR6Q0cYEKnPLht1/tBoGKc0cpZGjqhvkCKHrgv5zkSLuiDV7Hv7qG57lw3Iq683uyfhtmpW1wcNWi2YGu1zP40O7cfboCeo5NOwCWfrOuHZmYf7XT34bCUDNbojk3XXppaG0cSLeYqXYGnXbH3QZfrJ6Ehwba/OD+7uV5zquZXo6OpFDfQzVJeaZXNTyedH25aGIkbfwGI/zTWBJ370P9qUV/7Ok/lf3XAgRIjbFODJyQGag6cxNr+TVl6ZcpM7WWMXRp9lJvcFFZC41nepsj3Dp72wxbIkR5kRTcnWNScop4r9PHgfq1JhVKCXXPzdLHNtk4hdnbg1qiV/UIwk5pJpalmk782/I25At9xWlgBoToobA9ZW6rUlOwIBCCdEbLxJBXqbwaDYcfBrdceNeGC/JORZoCCftXzKPA3qq6tZB+00RpoJiAFalY4efa9w==
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230028)(346002)(39850400004)(376002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(2906002)(6512007)(40480700001)(81166007)(47076005)(36860700001)(2616005)(83380400001)(336012)(40460700003)(6486002)(70586007)(70206006)(4326008)(110136005)(54906003)(86362001)(316002)(82310400005)(36756003)(82740400003)(478600001)(1076003)(6506007)(5660300002)(186003)(26005)(8676002)(8936002)(41300700001)(107886003)(414714003);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:30:21.7933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 258f9141-1b8a-4818-2835-08db7d5bfba7
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT054.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP Core Z025 and Z057 have a register where the amount of UART
ports is specified. Such register is located at offset 0x40.

This patch fixes the way the UART ports is calculated by reading
the actual register. Additionally a refactor was needed to achieve
this so we can keep track of the UART line and its offset which
also improves the remove callback.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 189 ++++++++++++++++++-------
 1 file changed, 139 insertions(+), 50 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/82=
50/8250_men_mcb.c
index a2cdaeb61e00..d6cfebb3ee8f 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -12,11 +12,42 @@
 #define MEN_UART_ID_Z057 0x39
 #define MEN_UART_ID_Z125 0x7d
=20
-#define MEN_UART_MEM_SIZE 0x10
+/*
+ * IP Cores Z025 and Z057 can have up to 4 UART
+ * The UARTs available are stored in a global
+ * register saved in physical address + 0x40
+ * Is saved as follows:
+ *
+ * 7                                                              0
+ * +------+-------+-------+-------+-------+-------+-------+-------+
+ * |UART4 | UART3 | UART2 | UART1 | U4irq | U3irq | U2irq | U1irq |
+ * +------+-------+-------+-------+-------+-------+-------+-------+
+ */
+#define MEN_UART1_MASK	0x01
+#define MEN_UART2_MASK	0x02
+#define MEN_UART3_MASK	0x04
+#define MEN_UART4_MASK	0x08
+
+#define MEN_Z125_UARTS_AVAILABLE	0x01
+
+#define MEN_Z025_MAX_UARTS		4
+#define MEN_UART_MEM_SIZE		0x10
+#define MEM_UART_REGISTER_SIZE		0x01
+#define MEN_Z025_REGISTER_OFFSET	0x40
+
+#define MEN_UART1_OFFSET	0
+#define MEN_UART2_OFFSET	(MEN_UART1_OFFSET + MEN_UART_MEM_SIZE)
+#define MEN_UART3_OFFSET	(MEN_UART2_OFFSET + MEN_UART_MEM_SIZE)
+#define MEN_UART4_OFFSET	(MEN_UART3_OFFSET + MEN_UART_MEM_SIZE)
+
+#define MEN_READ_REGISTER(addr)	readb((void *)addr)
+
+#define MAX_PORTS	4
=20
 struct serial_8250_men_mcb_data {
-	struct uart_8250_port uart;
-	int line;
+	int num_ports;
+	unsigned int line[MAX_PORTS];
+	unsigned int offset[MAX_PORTS];
 };
=20
 /*
@@ -50,16 +81,82 @@ static u32 men_lookup_uartclk(struct mcb_device *mdev)
 	return clkval;
 }
=20
-static int get_num_ports(struct mcb_device *mdev,
-				  void __iomem *membase)
+static int read_uarts_available_from_register(void __iomem *membase,
+					      u8 *uarts_available)
+{
+	void __iomem *mem;
+	int reg_value;
+
+	mem =3D membase + MEN_Z025_REGISTER_OFFSET;
+
+	reg_value =3D MEN_READ_REGISTER(membase);
+
+	*uarts_available =3D reg_value >> 4;
+
+	return 0;
+}
+
+static int read_serial_data(struct mcb_device *mdev,
+			    void __iomem *membase,
+			    struct serial_8250_men_mcb_data *serial_data)
+{
+	u8 uarts_available;
+	int count =3D 0;
+	int mask;
+	int res;
+	int i;
+
+	res =3D read_uarts_available_from_register(membase, &uarts_available);
+	if (res < 0)
+		return res;
+
+	for (i =3D 0; i < MAX_PORTS; i++) {
+		mask =3D 0x1 << i;
+		switch (uarts_available & mask) {
+		case MEN_UART1_MASK:
+			serial_data->offset[count] =3D MEN_UART1_OFFSET;
+			count++;
+			break;
+		case MEN_UART2_MASK:
+			serial_data->offset[count] =3D MEN_UART2_OFFSET;
+			count++;
+			break;
+		case MEN_UART3_MASK:
+			serial_data->offset[count] =3D MEN_UART3_OFFSET;
+			count++;
+			break;
+		case MEN_UART4_MASK:
+			serial_data->offset[count] =3D MEN_UART4_OFFSET;
+			count++;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (count <=3D 0 || count > MAX_PORTS) {
+		dev_err(&mdev->dev, "unexpected number of ports: %u\n",
+			count);
+		return -ENODEV;
+	}
+
+	serial_data->num_ports =3D count;
+
+	return 0;
+}
+
+static int init_serial_data(struct mcb_device *mdev,
+			    void __iomem *membase,
+			    struct serial_8250_men_mcb_data *serial_data)
 {
 	switch (mdev->id) {
 	case MEN_UART_ID_Z125:
-		return 1U;
+		serial_data->num_ports =3D 1;
+		serial_data->offset[0] =3D 0;
+		return 0;
 	case MEN_UART_ID_Z025:
-		return readb(membase) >> 4;
 	case MEN_UART_ID_Z057:
-		return 4U;
+		return read_serial_data(mdev, membase, serial_data);
 	default:
 		dev_err(&mdev->dev, "no supported device!\n");
 		return -ENODEV;
@@ -69,11 +166,12 @@ static int get_num_ports(struct mcb_device *mdev,
 static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
 				     const struct mcb_device_id *id)
 {
+	struct uart_8250_port uart;
 	struct serial_8250_men_mcb_data *data;
 	struct resource *mem;
-	int num_ports;
 	int i;
 	void __iomem *membase;
+	int res;
=20
 	mem =3D mcb_get_resource(mdev, IORESOURCE_MEM);
 	if (mem =3D=3D NULL)
@@ -82,49 +180,46 @@ static int serial_8250_men_mcb_probe(struct mcb_device=
 *mdev,
 	if (IS_ERR(membase))
 		return PTR_ERR_OR_ZERO(membase);
=20
-	num_ports =3D get_num_ports(mdev, membase);
-
-	dev_dbg(&mdev->dev, "found a 16z%03u with %u ports\n",
-		mdev->id, num_ports);
-
-	if (num_ports <=3D 0 || num_ports > 4) {
-		dev_err(&mdev->dev, "unexpected number of ports: %u\n",
-			num_ports);
-		return -ENODEV;
-	}
-
-	data =3D devm_kcalloc(&mdev->dev, num_ports,
+	data =3D devm_kzalloc(&mdev->dev,
 			    sizeof(struct serial_8250_men_mcb_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
=20
+	res =3D init_serial_data(mdev, membase, data);
+	if (res < 0)
+		return res;
+
+	dev_dbg(&mdev->dev, "found a 16z%03u with %u ports\n",
+		mdev->id, data->num_ports);
+
 	mcb_set_drvdata(mdev, data);
=20
-	for (i =3D 0; i < num_ports; i++) {
-		data[i].uart.port.dev =3D mdev->dma_dev;
-		spin_lock_init(&data[i].uart.port.lock);
-
-		data[i].uart.port.type =3D PORT_16550;
-		data[i].uart.port.flags =3D UPF_SKIP_TEST | UPF_SHARE_IRQ
-					  | UPF_FIXED_TYPE;
-		data[i].uart.port.iotype =3D UPIO_MEM;
-		data[i].uart.port.uartclk =3D men_lookup_uartclk(mdev);
-		data[i].uart.port.regshift =3D 0;
-		data[i].uart.port.irq =3D mcb_get_irq(mdev);
-		data[i].uart.port.membase =3D membase;
-		data[i].uart.port.fifosize =3D 60;
-		data[i].uart.port.mapbase =3D (unsigned long) mem->start
-					    + i * MEN_UART_MEM_SIZE;
-		data[i].uart.port.iobase =3D data[i].uart.port.mapbase;
+	for (i =3D 0; i < data->num_ports; i++) {
+		uart.port.dev =3D mdev->dma_dev;
+		spin_lock_init(&uart.port.lock);
+
+		uart.port.type =3D PORT_16550;
+		uart.port.flags =3D UPF_SKIP_TEST |
+				  UPF_SHARE_IRQ |
+				  UPF_FIXED_TYPE;
+		uart.port.iotype =3D UPIO_MEM;
+		uart.port.uartclk =3D men_lookup_uartclk(mdev);
+		uart.port.regshift =3D 0;
+		uart.port.irq =3D mcb_get_irq(mdev);
+		uart.port.membase =3D membase;
+		uart.port.fifosize =3D 60;
+		uart.port.mapbase =3D (unsigned long) mem->start
+					    + data->offset[i];
+		uart.port.iobase =3D uart.port.mapbase;
=20
 		/* ok, register the port */
-		data[i].line =3D serial8250_register_8250_port(&data[i].uart);
-		if (data[i].line < 0) {
+		data->line[i] =3D serial8250_register_8250_port(&uart);
+		if (data->line[i] < 0) {
 			dev_err(&mdev->dev, "unable to register UART port\n");
-			return data[i].line;
+			return data->line[i];
 		}
-		dev_info(&mdev->dev, "found MCB UART: ttyS%d\n", data[i].line);
+		dev_info(&mdev->dev, "found MCB UART: ttyS%d\n", data->line[i]);
 	}
=20
 	return 0;
@@ -132,20 +227,14 @@ static int serial_8250_men_mcb_probe(struct mcb_devic=
e *mdev,
=20
 static void serial_8250_men_mcb_remove(struct mcb_device *mdev)
 {
-	int num_ports, i;
+	int i;
 	struct serial_8250_men_mcb_data *data =3D mcb_get_drvdata(mdev);
=20
 	if (!data)
 		return;
=20
-	num_ports =3D get_num_ports(mdev, data[0].uart.port.membase);
-	if (num_ports <=3D 0 || num_ports > 4) {
-		dev_err(&mdev->dev, "error retrieving number of ports!\n");
-		return;
-	}
-
-	for (i =3D 0; i < num_ports; i++)
-		serial8250_unregister_port(data[i].line);
+	for (i =3D 0; i < data->num_ports; i++)
+		serial8250_unregister_port(data->line[i]);
 }
=20
 static const struct mcb_device_id serial_8250_men_mcb_ids[] =3D {
--=20
2.34.1
