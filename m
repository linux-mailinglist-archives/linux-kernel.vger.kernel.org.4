Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1F16CC220
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjC1OfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjC1OfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:35:06 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2096.outbound.protection.outlook.com [40.107.23.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EC7BB8B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hof74zC1GVg8Gkos85sHsxKwL4iqIJHW9nl5C3hIsSI=;
 b=mvlvSLG5KmqUowmpw2+KF9GEP5M38m/N0PdJ1Hd2mU7ZLBxUWvyvY5MBB/GkBwTgt1XGAam0mIZMxKZMKIEH6rf18N7icHa1KaEPItMqQ7Eskqg8fVj1KQy3T2Qlm8WairsKB7DYwCcYsmu5O41miJgKoXYQJWVTHjXN+S/7n0A=
Received: from DB8PR04CA0011.eurprd04.prod.outlook.com (2603:10a6:10:110::21)
 by GV0P278MB0098.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 14:35:01 +0000
Received: from DB5EUR01FT015.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:110:cafe::4a) by DB8PR04CA0011.outlook.office365.com
 (2603:10a6:10:110::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 14:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DB5EUR01FT015.mail.protection.outlook.com (10.152.5.0) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.23 via Frontend Transport; Tue, 28 Mar 2023 14:35:00 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.108) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 28 Mar 2023 14:34:59 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Hu5bvCCE/hEh+YW2bGUiIJ6RuRq1gvjkufkNnzRTFgMlAt9gho8DEKIvKgBlFUcXu5RZVdAJVTqSO+LYU/ovxreuO7d0pcUtsrwbesQriNfrSecW93rbJ0Xvx2595KLF1d/AZ9WTP2M9eCdrWbp01xWOG5xc/bxZqKazRIMt6QHviXFgbbsJoEeKp6yZk/F7ZUEOzcoMY0kPqGPNh5K7o443DmWJ4zRiJP92fy5eaqqep0sNdi/8lGr4H2+QQxsURgLtG0h93icLpv/SGcD2N7fBKWziLFrtKdlRui460Lf9KvjYktwl/bnVrsxXnb5wPkt85TS68hGEz3hH0w2jwg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hof74zC1GVg8Gkos85sHsxKwL4iqIJHW9nl5C3hIsSI=;
 b=M+lmnLR/B/pn6ACOfOWrzZm/OoK/ofQ5tEKwdi5Knuh4y+EZb0MxNlw4L1cxW9o/J0qq4Jy16IoQz2JBgdRKiGaDd0hHRwf7R0NkThJiKiji5pgkeBHk/vLiQMDk+7tg9idZDxFofZJT6fQpONm3mF3Aey5i7P07TuXDHXHvvHSiz/1pSOehZe5GmrC73kccUHzGvlpkeLcQeyCoODh+CMd/napgPxDi0OXWREsLr6DbDYhBWaACYE6ThJWPvOyj2cDQD2IYY7uwW/Fdod2p/tynPR8bIOXPNoPHZ2ok6ekACFFvSTFM43YDNNCE/2hdg09a0FA6DkLiqWM/T6FzUg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.22.106) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hof74zC1GVg8Gkos85sHsxKwL4iqIJHW9nl5C3hIsSI=;
 b=mvlvSLG5KmqUowmpw2+KF9GEP5M38m/N0PdJ1Hd2mU7ZLBxUWvyvY5MBB/GkBwTgt1XGAam0mIZMxKZMKIEH6rf18N7icHa1KaEPItMqQ7Eskqg8fVj1KQy3T2Qlm8WairsKB7DYwCcYsmu5O41miJgKoXYQJWVTHjXN+S/7n0A=
Received: from GV3P280CA0111.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::28) by
 ZR0P278MB0872.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Tue, 28 Mar 2023 14:34:58 +0000
Received: from HE1EUR01FT003.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::f9) by GV3P280CA0111.outlook.office365.com
 (2603:10a6:150:8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 14:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.22.106)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 104.47.22.106 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.22.106; helo=CHE01-ZR0-obe.outbound.protection.outlook.com;
 pr=C
Received: from securemail.duagon.com (91.135.65.126) by
 HE1EUR01FT003.mail.protection.outlook.com (10.152.0.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.9 via Frontend Transport; Tue, 28 Mar 2023 14:34:57 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2106.outbound.protection.outlook.com [104.47.22.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Tue, 28 Mar 2023 16:34:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj1fzCA4jmgMgKV9ilsLVwjSTZ8OZDXI/ipaX/r6VZkIKQiOfTPUbuw78AhrQb+AVU5zvlefSzXiS8u9eDjO+60fbi7YLcMsKPCdxQmvC7JKKmOHzJx40tzSSOQzhb9JOt9lOLzQwCF7dY+TBPbJdk58ToUQRB+dcEfJLgKaF48YaMdZCLUDbJlmXs4AtcPE3tYo9w0FHjhb0gcsL4WzRBBEZVO3cSVmq/tUcPGu5iXDy3SJZrqi3BRdLWlpT9lSQGvPHjNwuUhjrV2jXnAP9fjkUHBIOPAdZ6TNECX9KXug4ptoSeByFBTo0ZW0CTHnPdQ3Sxm/TF4J5AyF7DygxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hof74zC1GVg8Gkos85sHsxKwL4iqIJHW9nl5C3hIsSI=;
 b=XGR6zHen6R9sCwbgwsIQogo4EEJXINH0NW94SQ8ZjA5l+uFDl18bae+g9g7SMUoOzl0bYcG52dLjMtMBsTM/D38tBPVOrigyA+kd6uW3CwQaYXshJIJpHPJeIZVT9UUDQF0g6Ms3lHSgfjBiVv1aVWIsl7C/6qTHXr7KzlwA43oI41OGY1vdqZWMkx2aqVg7DTcEQstZBRx4Mhk4EPlFQRdzkX/PjBQrPqPHrdURo/F8bRByCMTXdfphKb791Gh09h1MXxbVJ2jTR8jlcMrvxJsD9hpvu7CAwXWNXJrgvq5jbBFWopwJjpfgSAdZOLNSmKNO6Y/zXksEoWXUR2qkNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hof74zC1GVg8Gkos85sHsxKwL4iqIJHW9nl5C3hIsSI=;
 b=mvlvSLG5KmqUowmpw2+KF9GEP5M38m/N0PdJ1Hd2mU7ZLBxUWvyvY5MBB/GkBwTgt1XGAam0mIZMxKZMKIEH6rf18N7icHa1KaEPItMqQ7Eskqg8fVj1KQy3T2Qlm8WairsKB7DYwCcYsmu5O41miJgKoXYQJWVTHjXN+S/7n0A=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB0800.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 14:34:52 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded%7]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 14:34:52 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH v2 0/3] mcb-pci: fix memory overlapping on MCB devices
Thread-Topic: [PATCH v2 0/3] mcb-pci: fix memory overlapping on MCB devices
Thread-Index: AQHZYYJ1AWK/g7OSukuj40eoAdT7PA==
Date:   Tue, 28 Mar 2023 14:34:52 +0000
Message-ID: <20230328143441.78932-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB0800:EE_|HE1EUR01FT003:EE_|ZR0P278MB0872:EE_|DB5EUR01FT015:EE_|GV0P278MB0098:EE_
X-MS-Office365-Filtering-Correlation-Id: a917c749-2872-4c61-f478-08db2f999cc6
x-seppmail-processed: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: kZJQjIp6MLq+nnBJVHyyk5VnIXMybcrsU9jTpyiLcmHCzQUbe48201qLZ/a3bdjsz/IeQp/Us3lU3QXl1UttO3WDm+PeL2ONxc+5KCQdgoIVEZnhkcXhsc0x+xDp4KsI9xIM+RYNkD4dlJ1P7n0xBBb/KZXxshQBHYYVp8lT4NWDX0bEIP4ayxkRqOu4qnJ+675i/0h1oYyt6IbsNqNe3IZ7upCvDexQr86C93iQrfpm06Jjf9C+dv/YTWo1LCiPj/sYFA+v5V16I087N9zK7HdKAuwPmgqd0BwiUZZo3OjRSwfJlvDO/tPQfg8MPdGjE69XPPgNYkX/yWixMohCZjjG+zz/wQNkNPOVw1Uzp5qWsDjxoXTuNZwXy2O/vMmuFDsouy8RRw2ra4dDB5T6ygfGu8JIMesfhQuEDzID/K+uAPM8W+xSgREJNAdOfgh3e4dEpNQJd7od64QWD79IO2NSc5jfWbvReyMoxjsZf5pB6+xgwBCYa/3dhMYj7md3hUst9WuY1p/uHiNieJGNadjqUsHCY4zAxEav3c3aPHdUQV0d7R6gCJwsoxRcLzXLDbajIyrfStDSwOHGlmVmjpfwTEVzY1dJ8WowlAEL0ecjzb/xpRP+sV4/JJ3VdKyi
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39850400004)(366004)(136003)(396003)(451199021)(107886003)(41300700001)(122000001)(91956017)(76116006)(66946007)(66476007)(4326008)(64756008)(66556008)(66446008)(86362001)(478600001)(316002)(71200400001)(54906003)(110136005)(36756003)(38100700002)(38070700005)(8676002)(6486002)(2906002)(186003)(26005)(83380400001)(5660300002)(6512007)(2616005)(6506007)(1076003)(8936002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0800
X-SM-outgoing: yes
X-EOPAttributedMessage: 1
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.22.106];domain=CHE01-ZR0-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT003.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5046b213-bf51-4001-0fc5-08db2f99979c
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vhWkCISVRYm0pMokEiCOKcncZnDZ/g3T2/qDPTEMTnHhHXYxjqRTMr3/KeD1W32DQNbqDGYxW0hTNwEx/OA+s/V/ZpFCMriJ+BYIOLV3Hr5bLEfhy6Mqd/7X/AirC30LvXLlHUJPKNS6DI0WGR+Rif49S/m2Un5rrYuWQvFCJv2/+YFaQ+1yIm5fJqPRKouREmMXLzAvwnUOoT7y/mZwagJQ76TIOpDqdH5MFgxo7AC+t5BgNeOiA/6coC9MhudHYv6Y8KCufxbdggqTX3yPfK2NEl+V0FP7sFaxkzSDco+LsvyDFnCy5s9l3eZ60pD+myFfwPWZzBdTBtlNjwxi7QX4yZlxLHsDiv1gwGv9kcAmftZzhYwJejY+HWT+A3Tdj5nio3KMdHK7fu7s020vWVE/BNMQo747gD6nA4ogW+mSow/D5+2JLRniqJ8UWrX9hPTPFaGK+YE7B7JL4P91yzWKTQ+RuIjHWnGybSIzO3ocdcb1ysH3EWkhzY4vggbvWb/4ne3qR8WmO5x7AZv2RjGQQOxoMsaZ/eD5KP3jB9b8OukDng6jngWDiB2Jvb2IN3LFAxWMhtuFw/ia5XG7v2bSU1KnnWU9r6z70OtcUo0/RDY45f0klusgjd98vtf5TId/7m+jIXPw11wce2FUKFrrHn8NAmUKNU0hsowAKfzWCd07r+T9RWKfz4t8w8Tyaj4lXzf7RHTNg4fe9a9RcCNX1y4ZxA3K9e0B4eU35HuTAIr7sVaC+GGQedFObXLiYxGI5Ya7WbX3AF2vsyjZcGRM5WGXPCiKvpNOrM0OCpBQV5MNf47/abFQH/WPveuv
X-Forefront-Antispam-Report-Untrusted: CIP:91.135.65.126;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHE01-ZR0-obe.outbound.protection.outlook.com;PTR:mail-zr0che01lp2106.outbound.protection.outlook.com;CAT:NONE;SFS:(13230028)(39850400004)(136003)(376002)(396003)(346002)(451199021)(46966006)(36840700001)(336012)(36756003)(82310400005)(6506007)(1076003)(26005)(6512007)(186003)(83380400001)(2616005)(8936002)(41300700001)(4326008)(5660300002)(70586007)(70206006)(478600001)(316002)(82740400003)(7636003)(8676002)(54906003)(110136005)(32850700003)(47076005)(40480700001)(156005)(36860700001)(2906002)(6486002)(107886003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0872
X-CodeTwo-MessageID: 5c6ceabc-1198-4445-8766-64fb693d4876.20230328143459@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT015.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 04c10edb-4c09-4fa3-fc11-08db2f999b09
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lRJHHlr0ak6phoYA95qlEOEAkOwCyodQhxrfdCYH6xyCxwVgUv5TDGvl9O9Bt8ZLWGPebsJnlV0r3YC6wS+5HQldpV6IsmGZbgwxDQPxEXY5M/z0GeIkZIAevlSSSfxCYxU4JkV7PxWfucwuOP3LCXbV1b60xzK0H16mMQtklzTT2bg6FOxvgDMyTufD3AV4HnMysy/PVX/ivWsDtk/JoL+YPg10LEVud6Yu1uaoAfSTdCPV7osRldOKj+zWGgdyz3osAQEFX3zHK8Jzsonae6eBA2XJObiVVcpvrUB1fnS1fjMASX5Q1sc/gBBCPRGtd6LGvWfN+uJ5km/YkceMxsOla8XtmF5tmYjvIiHGxQxgGkuTXfUafv7qjUFsIaKn+IwUIoVrhfdtL2sLN2nzEQiJMR7mUQhPzDgaT+Njhnn01/PCfJGt2umMYvhrqOvhwF3aDIfGKz2neGOcgOMemehenLaUtpzdaJAXL7hfdq4FghjzwOqkDna0jlFR/+bVlQQtuQExGzBqFBraCqrKI5g83m7S5/cRoOZ1BsRZqB2K/y5t4pKXbwIaIQ6AGYFTAl8kz86DDt8IBEbI2ET/33O7St+Hmx/37vbjWq0wGIiZXJcVd0jq2QgtxE1O5EE1uEmcwqqf1EDszWUXKESE9NqG72u20hoeV82U5WB42Xs=
X-Forefront-Antispam-Report: CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(39850400004)(136003)(376002)(346002)(396003)(451199021)(46966006)(36840700001)(336012)(83380400001)(2616005)(186003)(6506007)(26005)(6512007)(1076003)(107886003)(47076005)(6486002)(70586007)(316002)(70206006)(478600001)(110136005)(4326008)(36860700001)(8676002)(5660300002)(8936002)(86362001)(82740400003)(41300700001)(2906002)(7596003)(7636003)(36756003)(82310400005)(40480700001)(54906003);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 14:35:00.8905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a917c749-2872-4c61-f478-08db2f999cc6
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT015.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0098
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mcb-pci driver is allocating the memory region for the "chameleon table"
with a fixed size of 0x200. This region is only use to do a initial
parsing to discover the devices implemented as IP Cores.

If the "chameleon table" is actually smalled than 0x200 and the first
device offset happen to be within 0x200, a memory overlapping can ocurr.

Here an extract of the memory overlapping when registering a 16z125 IP Core=
:

[   31.016972] 8250_men_mcb mcb0-16z125-0:0:0: can't request region for res=
ource [mem 0xa8200100-0xa820010f]
[   31.016994] 8250_men_mcb: probe of mcb0-16z125-0:0:0 failed with error -=
16
[   31.017010] 8250_men_mcb mcb0-16z125-1:0:0: can't request region for res=
ource [mem 0xa8200110-0xa820011f]

And here, the memory allocated for the chameleon table parsing:

user@host:$ sudo /proc/iomem
...
a8200000-a82001ff : mcb_pci
...

This patch solves this problem by dropping/reallocating the memory region o=
f the
"chamelon table" with the actual size once it has been parsed.

This patch is based on linux-next (next-20230323)

Changes for V2:
 * make parsing function return the size of "chameleon table".
 * reallocate instead of not requesting the memory region.

Javier Rodriguez (3):
  mcb: Return actual parsed size when reading chameleon table
  mcb-pci: Reallocate memory region to avoid memory overlapping
  mcb-lpc: Reallocate memory region to avoid memory overlapping

 drivers/mcb/mcb-lpc.c   | 35 +++++++++++++++++++++++++++++++----
 drivers/mcb/mcb-parse.c | 10 +++++++---
 drivers/mcb/mcb-pci.c   | 27 +++++++++++++++++++++++++--
 3 files changed, 63 insertions(+), 9 deletions(-)

--=20
2.34.1
