Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387717484F0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjGEN3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGEN3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:29:46 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2129.outbound.protection.outlook.com [40.107.23.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A858172D;
        Wed,  5 Jul 2023 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZRlIbKPBHzFrx7gBMAj60nh9ou4ga3sflcdrVgzvyg=;
 b=MU6ltNd8QhioKc1YZ/ZSAm/w3loJOjQlFCS16bCgO8Esu5IJRRyrfM9/sryclde4yTCyp2g48xuUBEJxWgeSfRXCOqF/FPB1nCD32056Z29KePrnhXaYOiVu9MFThxOq5BE/50hUy3PGYHi6QJWaPFgu+VVC4XB2tDDeaonT3vM=
Received: from DU2PR04CA0193.eurprd04.prod.outlook.com (2603:10a6:10:28d::18)
 by ZR0P278MB1124.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:51::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:29:37 +0000
Received: from DB5EUR01FT006.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:28d:cafe::fd) by DU2PR04CA0193.outlook.office365.com
 (2603:10a6:10:28d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 13:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 DB5EUR01FT006.mail.protection.outlook.com (10.152.4.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.24 via Frontend Transport; Wed, 5 Jul 2023 13:29:34 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4Qx0rG4MvqzxpF;
        Wed,  5 Jul 2023 15:29:34 +0200 (CEST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Wed,  5 Jul 2023 15:29:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZRlIbKPBHzFrx7gBMAj60nh9ou4ga3sflcdrVgzvyg=;
 b=MU6ltNd8QhioKc1YZ/ZSAm/w3loJOjQlFCS16bCgO8Esu5IJRRyrfM9/sryclde4yTCyp2g48xuUBEJxWgeSfRXCOqF/FPB1nCD32056Z29KePrnhXaYOiVu9MFThxOq5BE/50hUy3PGYHi6QJWaPFgu+VVC4XB2tDDeaonT3vM=
Received: from DUZPR01CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::13) by GVAP278MB0120.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:22::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:15:15 +0000
Received: from DB5EUR01FT097.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:469:cafe::c1) by DUZPR01CA0059.outlook.office365.com
 (2603:10a6:10:469::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.31 via Frontend
 Transport; Wed, 5 Jul 2023 13:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 DB5EUR01FT097.mail.protection.outlook.com (10.152.5.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.24 via Frontend Transport; Wed, 5 Jul 2023 13:15:15 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.49) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 05 Jul 2023 13:15:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHfPDJRldO/1xQWpeO30cOrOYHAp7tMRGI5xpf8EXDhG9gpuUdtjig0kfbEdxRw8xlIEfCGgA/hcjiMWnv7UewoSvbzsRlJRhV87IiiHOyFvYwM5FEsME5ZMu5Dsqp2uWEyrPScnZAALSd4/+Fas6M9CQzoDv8QGxiqSPEd9A1d7VxSZj8tQDCb5EBexHWSww94Favo9nm3Oyu1fZyppCuW2bSIAGJa/0UBZ7oqhSDc6z2yMdUkPPp9AIJlb7sw6SDQyefUoDVJFJ7lPl57wF8Z1pClQufXDbGxohjVLgeysFJ0nDFem8aHHZxkcyGdsHgDI9Dc34wEkA5/QYCHOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZRlIbKPBHzFrx7gBMAj60nh9ou4ga3sflcdrVgzvyg=;
 b=CxPieoYSSrV9pR35QyEDacV3uOZ8k4MxAVvaqZQDww188xvxHfzYNkN4gbC5OoizxlzKuMK27LmQtNatHZqRRQ626GKrjzgvtcTTd3olqDYOLtofsh+rurMLqtdxGI8UznLY+K+P2wJ82WdSf4gneOAYYOJ7eH2kKJtjfPboaIz4qL9kSEjSyaM46t7fbpSMc13tBRV8kQBBY8TJwX7dTwkMq7WT7seufQEBnvwKQR5gCfrU85h+CZOlPIaRIbsII5exXb6lT3f0jbvvca5Xthq+XC7bVW8HKACnYCuaudrSng/V+Ov3zvIsnSGhwKCbjacbBbObgImiPOl7TiZLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZRlIbKPBHzFrx7gBMAj60nh9ou4ga3sflcdrVgzvyg=;
 b=MU6ltNd8QhioKc1YZ/ZSAm/w3loJOjQlFCS16bCgO8Esu5IJRRyrfM9/sryclde4yTCyp2g48xuUBEJxWgeSfRXCOqF/FPB1nCD32056Z29KePrnhXaYOiVu9MFThxOq5BE/50hUy3PGYHi6QJWaPFgu+VVC4XB2tDDeaonT3vM=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZRAP278MB0875.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:15:11 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8c78:4a4d:bc93:c620]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8c78:4a4d:bc93:c620%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 13:15:10 +0000
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
Subject: [PATCH 1/3] 8250_men_mcb: Add clockrate speed for G215/F215 boards
Thread-Topic: [PATCH 1/3] 8250_men_mcb: Add clockrate speed for G215/F215
 boards
Thread-Index: AQHZr0K5klI/G48NSESVER1GvVjuRQ==
Date:   Wed, 5 Jul 2023 13:15:10 +0000
Message-ID: <20230705131423.30552-2-josejavier.rodriguez@duagon.com>
References: <20230705131423.30552-1-josejavier.rodriguez@duagon.com>
In-Reply-To: <20230705131423.30552-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZRAP278MB0875:EE_|DB5EUR01FT097:EE_|GVAP278MB0120:EE_|DB5EUR01FT006:EE_|ZR0P278MB1124:EE_
X-MS-Office365-Filtering-Correlation-Id: b22644b8-3ec2-4e86-3245-08db7d5bdfc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: T4MGTF3FTAhrficKFu1l2ofFZL2rX+1FV7wVAcSCWMy4iI86wtbZ7LQ4LiKlwgqFr3QWrzYVY1q3hwjXlEeKBOvu9umoMW1WuxrijMNgNDmqPBKkK2rujCLA/X0dbAv0hP3ZYjp9aWvwx+Yc8DqdIz9GB0UC01MxedDINpBXkTVPcJFX8S6hZhnS3Z36xlMZ4jbzmi5yE1RtfsxIEdodoJB7/X9szB8mCoaJ3OPoo0GVkqDLVows/Rip0j3umucaL8fPYuQOK9Zne9ge+x3aNDD6cgeinhstCAVg5CkXAA2CsBqJ9Yc/Jfv8kX/SNGHqM7OfphTRhCdspRmtQ4lZq/eFDumABwjy5fkilbGPlV+d0vFk/DoJZltk0L4URF7LeZF7WD3Vxdumrc6wK63re8z1sQ8Nti96piC33jo6uNc9AVTBGFI3buGBMWDbOeyO6BvtIF+doSybxGv0glyZK/9OBzfISbhA70vAHjNPKumKPGYtrkftYBGtV3znpHkKv7Jfz5MkIjqboT8iALtWBD0edFAMVSR57ywU1xYAo7nnazvkW8HRiPxiZ7u3MfB5E+UgjlODZj/pX+ZTLVPivuyBZpc9fhC7vXRijBW5TZbfIv/j6jsOgwpLihbFEyhJ
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(39850400004)(136003)(396003)(376002)(346002)(451199021)(76116006)(91956017)(66556008)(64756008)(4326008)(66476007)(66446008)(107886003)(122000001)(2616005)(38100700002)(38070700005)(86362001)(186003)(26005)(1076003)(66946007)(6506007)(83380400001)(478600001)(6512007)(6486002)(110136005)(36756003)(54906003)(41300700001)(8676002)(8936002)(2906002)(71200400001)(5660300002)(316002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0875
X-CodeTwo-MessageID: b5d17346-b4e4-42cd-a570-13ae77858080.20230705131512@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT097.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 21c30629-8700-43f0-bc36-08db7d59dc78
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 599IbhdMirDzyyYrK2rNGu5vi6yFnpCJrjwmMNaJno/rcOjt1c4D04kRaHUNeIG+aYI8BV/V0WIpx1Vo5jfcz8KagKLl07yUWzMdyk8PVyHbzAwtzDaPgEGywo2ZI602RB8xAIUqOl0wad6AESE2VsE760YD97ZEE+AtD5+UNHOSXBJkqL/GUNDm+5ihPRcw0N6N6ZoXbELv4tZpbwDVo805s7++3D/lD9RVGQs2TzovF4HbSNBzZnebjLM0UhabOOQyeHMKxWLwaBLPdiSlOyJvex79L6WMTDNvXyaO1W2H7Q+sR9U2mkl0Cq6r3Su0GuiG2f4FG+lNO+3xf+wLcIYPTkUJDkDdTYkBzVInkRa2UZMIy//FXat4QRyCR7Jzb31QszYljZMqmhE3obn39LQqrRRCRcLSuM9ZoD//YmAdEk0klQS8ygUgwNmhQWRWoKtK0APukYBl4LzKtObsaDiqqS0d51prcHZie/3a3mhDqzb1T2rbGjy2M5OQNzIGkbcgthDtYKjs5H150mfaOA77zmUATGEKzfA6DynX3nybIIiKU3Uw/Ey4bWcUusC0YEvDb8utmLtPGRH5mEthssmbXmjCw4u1aU3VH/KMtpoddQzkWev/Dy1HMO2tCS6ftMuSj6u+8WpC3c4wdqkB1cfuaJ1odBfySxZ4JLm7tGxwjvHwQTWzu7eEEXt/IUZtxdBZx2ZY2muMGdJFAVNTPw==
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(39850400004)(376002)(136003)(346002)(396003)(451199021)(36840700001)(46966006)(41300700001)(6486002)(82310400005)(82740400003)(7596003)(356005)(2616005)(107886003)(83380400001)(7636003)(186003)(336012)(6506007)(1076003)(26005)(6512007)(86362001)(47076005)(36860700001)(40480700001)(54906003)(110136005)(316002)(478600001)(2906002)(36756003)(4326008)(70586007)(70206006)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0120
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT006.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a7c2b813-3233-4dbc-d8f9-08db7d59df3f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DO/hOCIJ7lRCOgq/EVuIESV6lLKSLpHqK6yhFfNSxf3TQS0268S3jvWDJVLse++r5Z4xRuRT7ikgNB5RydAKJjEkG5S76sFxleOI5jOhck2C779tUTZQklCTRBFGPmbRJG/UCux1S2rRa9v0au3y0+ymiK+cu1ipymb2QsW00Vi4voHlkqNFlygMBLh/znw13PNBsXOpaQITpLdGWGvPwOM3EeccKOkZt5hjQggEwqP4OCXrA4q6iHK6yEX+lNB2VowF2Qn10KOUrryDIG1S60HAahhAKUdg+d9ge1oFAZtmpS0RyNGnAYT9eD89RKW9ehr8kna2sKujjQnUhXiRBs+kytW0l5AyIUzA7JOju97Nl/PSooak9Cj5evZcJTgee/DH6iE21a1uo30pTDFqWoBt4Mx8krAwyCDVezHIzE27UmM0hv3XSpbmzZTpAlLJ7vD9krdqYParXF2nDpn/rB4ZqU+V9wmaQOIQh2cAOe3gGsbe1ZIQU13YZssCpsTMKFTEvYTyz+p1sKpdcc7vsJEzy9YaKbTPDdDgyrRs8B+6MTv8o7yazxMpe/8jprCYNoCwj/DYHqkheIR0IwSzer45XZN/SLHO/b1i5/zWJJYqHwJAjl2o/KzWf4d+qSAndLsUpshY/VeKZCt5wZAcI0C9/xiGIYE39AlzWVzWF2w7a4YMtxG433AYs3NHdC2EqoXO9Hf/zaNU5fcXzga1jg==
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230028)(136003)(376002)(39850400004)(396003)(346002)(451199021)(46966006)(36840700001)(4326008)(70206006)(70586007)(81166007)(2616005)(82310400005)(107886003)(86362001)(186003)(6506007)(26005)(1076003)(36860700001)(47076005)(82740400003)(83380400001)(336012)(478600001)(6512007)(36756003)(6486002)(40480700001)(110136005)(41300700001)(54906003)(8936002)(8676002)(5660300002)(2906002)(316002);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:29:34.9761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b22644b8-3ec2-4e86-3245-08db7d5bdfc4
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT006.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some F215 FPGA multifunction boards announce themselves as 215.
This leads to a misconfigured clockrate. The F215 is the same board
as G215 but with different cPCI interface so make them get the same
configuration

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/82=
50/8250_men_mcb.c
index f46ca13ff4aa..a2cdaeb61e00 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -37,10 +37,10 @@ static u32 men_lookup_uartclk(struct mcb_device *mdev)
 		clkval =3D 1041666;
 	else if (strncmp(mdev->bus->name, "F216", 4) =3D=3D 0)
 		clkval =3D 1843200;
-	else if (strncmp(mdev->bus->name, "G215", 4) =3D=3D 0)
-		clkval =3D 1843200;
 	else if (strncmp(mdev->bus->name, "F210", 4) =3D=3D 0)
 		clkval =3D 115200;
+	else if (strstr(mdev->bus->name, "215"))
+		clkval =3D 1843200;
 	else
 		dev_info(&mdev->dev,
 			 "board not detected, using default uartclk\n");
--=20
2.34.1
