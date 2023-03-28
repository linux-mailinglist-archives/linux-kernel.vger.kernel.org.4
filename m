Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D326CC226
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjC1Of2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjC1OfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:35:14 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2093.outbound.protection.outlook.com [40.107.23.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F33592
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3yFI4JrIbOyilu9il6zGi4rf6ku6BwqvD+q993/AJE=;
 b=orkYGFf4WjoxDjtoAROQhMsLAhOLWHj7FqM/qXth84O1+m72K7TZvs25fbLAikaYtyCfoYhhWnERcGLNyoaoJpvS1zjCy4+E1r+ksgLQhtFsd+tTYposjcOAKo+wSNHA3YlCHVctdrq64lrPedhaIQ0b6+8Ut9bnaTU8C/KdZf8=
Received: from DB8PR09CA0012.eurprd09.prod.outlook.com (2603:10a6:10:a0::25)
 by ZR1P278MB1069.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 14:35:09 +0000
Received: from DB5EUR01FT034.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:a0:cafe::55) by DB8PR09CA0012.outlook.office365.com
 (2603:10a6:10:a0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 14:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DB5EUR01FT034.mail.protection.outlook.com (10.152.4.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.9 via Frontend Transport; Tue, 28 Mar 2023 14:35:08 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.42) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 28 Mar 2023 14:35:06 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=d0St17BQ0v1yV6oaofHq6dWcB1Q3PdWLNcy+Q5XvqH+bnb0VKVFANPKEcObmZlc7R8BJORlK3YgXu3+3oIe49Y/bJfHvbpM6pcL/jli2mu4mX8M8bTAQveWN4tvo40BC4phSXTFW3DPo139aiMPuq7xmczaJP0a+SWIvKTBGBNfzIXmO2cDCPZZYZFERc0p3epC3HZ6dPX8++3/HVMxtzOi88wWKd1jKpDPbEdntOXj1uOMhFK1+G+9JstZBjqx66RPnxpmEJaXLhK91sbztGAnDZjjScK4tv/asV4Yzsa3xxi8qlvk21gfb8DUniHbW0VaqLVamoFcKDJ+5tjWnTw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3yFI4JrIbOyilu9il6zGi4rf6ku6BwqvD+q993/AJE=;
 b=nO7nJLi19t+c+zVk0dyZvCAaSP/dU/hWM9RzxHftxdOSYC3zmTjhMP78484KgzW6NSGIupXdbT9h/US87/XWbPFIW/Vef+odZDDFddT7vzFMill8GjFwXYbNOjPaSywIN4N4sBl+npbaEGPnaeo7+3y6Jj9ZJ9zwqSvmdQUIJUWYGPdXw/kQ/gPx1iaaD0X/g3zF8XIq+011W23ozgQv91kozMwDBgCS5k+dDrGzU56Xdy7bVD8qTigUBpUC76iyh83tqJRcTEoFQQnO9mx7AYfPcoTxSl/f9c4I5FtkaZf9AWJUmGHHaZnQ2L6v1FnZJ8cYF9qjpY59Ez1wWIYnCQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.22.107) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3yFI4JrIbOyilu9il6zGi4rf6ku6BwqvD+q993/AJE=;
 b=orkYGFf4WjoxDjtoAROQhMsLAhOLWHj7FqM/qXth84O1+m72K7TZvs25fbLAikaYtyCfoYhhWnERcGLNyoaoJpvS1zjCy4+E1r+ksgLQhtFsd+tTYposjcOAKo+wSNHA3YlCHVctdrq64lrPedhaIQ0b6+8Ut9bnaTU8C/KdZf8=
Received: from FR0P281CA0101.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a9::19)
 by GVAP278MB0954.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:56::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 14:35:04 +0000
Received: from VE1EUR01FT090.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a9:cafe::b8) by FR0P281CA0101.outlook.office365.com
 (2603:10a6:d10:a9::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Tue, 28 Mar 2023 14:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.22.107)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 104.47.22.107 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.22.107; helo=CHE01-ZR0-obe.outbound.protection.outlook.com;
 pr=C
Received: from securemail.duagon.com (91.135.65.126) by
 VE1EUR01FT090.mail.protection.outlook.com (10.152.3.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Tue, 28 Mar 2023 14:35:04 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2107.outbound.protection.outlook.com [104.47.22.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Tue, 28 Mar 2023 16:35:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHduHMU0PJFno/UA6iPRg9MLLUu5NKEMhVVHJ2KkSsvC6xrqkx4dMlKyHK8K+oAK1YZFu1+gcEMgzn0Dr0UlRMOxdOnD1+N7FnmGtcJw7tEdoCWJXpwqSfVECWdkxZTJ7GFSogeFu+KDLSitcdW/GaDPujxqtNWUaPMQDXpBFrPLjldG0fQSRgklVM9xuV8VqrAJ1Z8upMweqhKaglu8NlyiDb9dHOtYwnglF86j74e8pAmvIdOhu4scg+2YYGJpChN5fORWuLJ2L92t6j8Bn1vm53kT1lQh78HgA9GHLTd0T5KmnYMZuXZKhFuxgoW475WQkobBBf4ReGr4AG2vtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3yFI4JrIbOyilu9il6zGi4rf6ku6BwqvD+q993/AJE=;
 b=XFa7siHVsCkYls+7F7X8JLceR790QbCAs5cf6ccAvtI/2Q6pihokwQTP0sWmMGYqPNL3OquZ4gXCFl7QCk5uo8c2CvnqK/Nwp8l0UzgMNYaqIehHaD9bUgSomvSnkRYt7A0Ovx9s+nt4mQ72xhcOsfxjs+MSguoO8qUQ2sRkmlddeQ+jSnUApJ9fEYveC+H1u6jrh1jjlfu3NHM/QVbjDYJs8jqrLQzy8Z34AnDByvPGxUHZV/ybbytA3iJEApQYbnuux9trYY6A5CiWJV9Pf1Q0s4skUPXsuY3oWOLRzBkUFVbVS9YGDvvos6m58ZK+eQOUiVzplQtxQNE+WcCr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3yFI4JrIbOyilu9il6zGi4rf6ku6BwqvD+q993/AJE=;
 b=orkYGFf4WjoxDjtoAROQhMsLAhOLWHj7FqM/qXth84O1+m72K7TZvs25fbLAikaYtyCfoYhhWnERcGLNyoaoJpvS1zjCy4+E1r+ksgLQhtFsd+tTYposjcOAKo+wSNHA3YlCHVctdrq64lrPedhaIQ0b6+8Ut9bnaTU8C/KdZf8=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB0800.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 14:35:02 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded%7]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 14:35:02 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH v2 3/3] mcb-lpc: Reallocate memory region to avoid memory
 overlapping
Thread-Topic: [PATCH v2 3/3] mcb-lpc: Reallocate memory region to avoid memory
 overlapping
Thread-Index: AQHZYYJ6p9hb8U+vD0iYh6Gg3dPKfQ==
Date:   Tue, 28 Mar 2023 14:35:02 +0000
Message-ID: <20230328143441.78932-4-josejavier.rodriguez@duagon.com>
References: <20230328143441.78932-1-josejavier.rodriguez@duagon.com>
In-Reply-To: <20230328143441.78932-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB0800:EE_|VE1EUR01FT090:EE_|GVAP278MB0954:EE_|DB5EUR01FT034:EE_|ZR1P278MB1069:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b7c508-d4f4-4767-b414-08db2f99a151
x-seppmail-processed: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: hZAttmDTH5/Csxmx6Jzif/z+iJQNPIMS5J+sqaTyWVeJP7uM0ymS3SWN9YqfcCEt58lCLhzhRPJ81y00AhW4FBdSTFthfDkxzxoNxDiKoSvzEO8Z9zG0HAIRIw25ZBCh5YB2izNvNmMxHPe2DMy4WYa4B83K8BYcaEBXqp4MJapZkQH0WSD3O7gC82yCqqvI016oZrXN5tNplA7l1lq9Mu/t2UqvFzf2GCR2Ulb+OwL1DFyPCnHH7nWJyj3cDv1DHMIbu0w/Mj4UzeXe/0Vswbklrzs2WejNXFufsIywnYP5Q6UBww96cKbF31ISaflsXi1rRaqnqaHiNxLvgEgNQMm+NiWM2JuWWW+/evjRAJZ8bWsK32sCj2gl3YfS6cvlaGBe43v6xOED0QHZXpNM86whb/IjQX49rUeC+jVgfY2tAIW1qLuBQjN1/PpOpZUU25LpiMEpCo3aISe1s2NvhJAUxXJhdZ+uveDhyqUprbPzirySw0f9Hxr+3i0ZGoUnE2wbAvLDk4GP/ZbOI55zNhEDCIsKZZpt2hu1RvaK9DcJqZ1MdZAWfihj9/+Q4Sz23s/Sg6+NvdeAXneKTmp1X/N7JuofyRIct6m7XW2JYHQ/KABBbANUOymBaRJXdzNf
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39850400004)(366004)(136003)(396003)(451199021)(107886003)(41300700001)(122000001)(91956017)(76116006)(66946007)(66476007)(4326008)(64756008)(66556008)(66446008)(86362001)(478600001)(316002)(71200400001)(54906003)(110136005)(36756003)(38100700002)(38070700005)(8676002)(6486002)(2906002)(186003)(26005)(83380400001)(5660300002)(6512007)(2616005)(6506007)(1076003)(8936002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0800
X-SM-outgoing: yes
X-EOPAttributedMessage: 1
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.22.107];domain=CHE01-ZR0-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT090.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 21190604-fbe8-49de-5d4b-08db2f999d7c
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: wknAp4HjLR6uPnkrndQMjVQW3gSmCy8aqdPa2fuZsGYHgCANm95EzayLg59FmzeLiq6TDY5jArJjQw+1oELH/hBj3lSJXVaWgdjs2Fhb3o44KhqLjwTOuKnCZ8HGH35PT8wrGFuSKJtt02Mj3dps2bATa2nK7+sv+UmaEwyxamyKTzUUC5RyfuhySDhRrRA5XuiGuHCkJ5LDChlE/qdcma6J89S0M0QQTq48wBst80zgy3PUMJJgYqBHH/+RJNjAxNSasx8D1p3ABZb5RF/rc+KeFOCqyT75ii2YTUbhwgcy9K2QfEzdrzzGDZF9spiuQaakkC9KE1MVq+j6Hxwj7hD91LlT+G5nuzlUGLxUwj7UrBLK157786EJiiBHVZVpfjyWS6rFOwG+PrBkFPIODljwQMxF1oqOcSqzkG4SdVurenOCEIMJ7dh9sCgJRChE1cWPaD9b3cfZzh0rEiia86mX3M1cZN1lh9D4JLNZi09gjL7di1l93CjpmP2FYtk+jOtvHzxKSC7rDsq7Rwmi/P2ssw2ecSFJf8IqnlcD03OJSn412EzvB/YtyWLQdHNHDJr/IuN6pTyhrR1oU02f9Km+MxaZxjmn4Kfb5UvWCDRB9hw7SDiTFn3voTe/q8pCepJK315/3vK7asW6WppbVuUakI9fIos7dj5LDd1hgl9bDPhl4XiX0gvZyNbG49U1W1Qq2oy6NabXEX9+oiMDIKwDmILjyARE7x7dtbJ9xB/q/L+Mx8e2eelLiLmBs+KY7qZ5ZaIlsXZV5js1zM9owCfZAW/l7N91ZTZfxZn1u0vcurfcr6KCLDvWsD+c8+5Yv6SOzhd5jyekk8cug0jm/Q==
X-Forefront-Antispam-Report-Untrusted: CIP:91.135.65.126;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHE01-ZR0-obe.outbound.protection.outlook.com;PTR:mail-zr0che01lp2107.outbound.protection.outlook.com;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39850400004)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(86362001)(40460700003)(36756003)(82310400005)(70206006)(70586007)(8676002)(4326008)(186003)(5660300002)(336012)(83380400001)(8936002)(41300700001)(2616005)(107886003)(478600001)(6486002)(6506007)(6512007)(110136005)(54906003)(1076003)(26005)(316002)(36860700001)(82740400003)(7636003)(156005)(32850700003)(47076005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0954
X-CodeTwo-MessageID: 757f8d52-d342-4d6e-b995-6f7a0acc2f97.20230328143506@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a588931d-d0f8-4ef4-d8f6-08db2f999ef2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90z5lCcHgo1Wqo7puFhT1HI315N9O0Y6YwfmA/5bjoJ3lUh1SRCGrX4/px4G+6It1tuSmQcBSmMF9Bj7f7qc6WXKqttpmznldxflR0sADmLgaMBZ2O8czWvRY67c5Yi/SVJsu5cPZXfEohtdmqMl32U152IZ7gRVElYNTJ32Y9WwaJ4qfGLlDD3lO/+b86EICs0HYHj6CUq41fNfK41lE5gBIr76UjJuUHn8am+AN0Dapy0awzC/XaA3bUuj2Z5PqLZjKpWqTcjg1qeRybG7baDR2DViypbzK0oMXL+gXzHRiM1a1t3KBpy8aae7+VNXlKWmCrkZLwxSNu/yT+IVnb+vqEjJzwsk3PFLgivhQAPIRVTnOq1/pKTu1Wt67bju6kwM9jl+liqkhdSQwgc8oNj2IcIVj73V+dkbJ6CtPOVtmzJO8Tpg3DoWyyBHZH18EN1nSucpbk+yBedru8F8xoiXYDiRkLhPdsrNelvI6NbDiuZukso2gIV7xebasqKLjAtI/H4pqP7FFEixtLylbcF3tpdzhs3zq/bk5LKX1htZcg5DEAt+ShefNoh6AdRMELFogSJ44PlKOAezFmcc0ZE5Gvz/TYWlSPpv4824KhmAZaS4iZ/GNX3Eh69u40dRL918pJopj74/qHtzClNQ39dQRkGjywMAj4ZzKuVG0uc=
X-Forefront-Antispam-Report: CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(39850400004)(451199021)(36840700001)(46966006)(2906002)(478600001)(86362001)(107886003)(6486002)(36860700001)(7596003)(54906003)(316002)(110136005)(82740400003)(7636003)(5660300002)(8676002)(4326008)(70206006)(70586007)(8936002)(40480700001)(47076005)(186003)(36756003)(6506007)(41300700001)(6512007)(82310400005)(26005)(1076003)(336012)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 14:35:08.4951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b7c508-d4f4-4767-b414-08db2f99a151
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1069
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mcb-lpc requests a fixed-size memory region to parse the chameleon
table, however, if the chameleon table is smaller that the allocated
region, it could overlap with the IP Cores' memory regions.

After parsing the chameleon table, drop/reallocate the memory region
with the actual chameleon table size.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
---
 drivers/mcb/mcb-lpc.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
index 53decd89876e..a851e0236464 100644
--- a/drivers/mcb/mcb-lpc.c
+++ b/drivers/mcb/mcb-lpc.c
@@ -23,7 +23,7 @@ static int mcb_lpc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct priv *priv;
-	int ret =3D 0;
+	int ret =3D 0, table_size;
=20
 	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -58,16 +58,43 @@ static int mcb_lpc_probe(struct platform_device *pdev)
=20
 	ret =3D chameleon_parse_cells(priv->bus, priv->mem->start, priv->base);
 	if (ret < 0) {
-		mcb_release_bus(priv->bus);
-		return ret;
+		goto out_mcb_bus;
 	}
=20
-	dev_dbg(&pdev->dev, "Found %d cells\n", ret);
+	table_size =3D ret;
+
+	if (table_size < CHAM_HEADER_SIZE) {
+		/* Release the previous resources */
+		devm_iounmap(&pdev->dev, priv->base);
+		devm_release_mem_region(&pdev->dev, priv->mem->start, resource_size(priv=
->mem));
+
+		/* Then, allocate it again with the actual chameleon table size */
+		res =3D devm_request_mem_region(&pdev->dev, priv->mem->start,
+					      table_size,
+					      KBUILD_MODNAME);
+		if (!res) {
+			dev_err(&pdev->dev, "Failed to request PCI memory\n");
+			ret =3D -EBUSY;
+			goto out_mcb_bus;
+		}
+
+		priv->base =3D devm_ioremap(&pdev->dev, priv->mem->start, table_size);
+		if (!priv->base) {
+			dev_err(&pdev->dev, "Cannot ioremap\n");
+			ret =3D -ENOMEM;
+			goto out_mcb_bus;
+		}
+
+		platform_set_drvdata(pdev, priv);
+	}
=20
 	mcb_bus_add_devices(priv->bus);
=20
 	return 0;
=20
+out_mcb_bus:
+	mcb_release_bus(priv->bus);
+	return ret;
 }
=20
 static int mcb_lpc_remove(struct platform_device *pdev)
--=20
2.34.1
