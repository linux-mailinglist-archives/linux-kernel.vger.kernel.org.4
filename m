Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CE47484E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjGEN31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEN3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:29:25 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2139.outbound.protection.outlook.com [40.107.24.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5CE171D;
        Wed,  5 Jul 2023 06:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9DI82wGnxls7TC5l+pGIJWMj3oKikwjepQVkrEz8Yc=;
 b=vPmnaWHgVAGymX774fEfOteERYLgVdlY6Ce+BvDUXu0wjFpqZfbFnlMz3IgkJ8ILd3usBVAlSghcvFDEcZgoi04zW0xW6faJePRx1vOiQ3UWK/sGmczCbuQZ5fBmJZisCJbdMFbKllUF5lpDlKIwolAxLa/osAVreeTEeM9po2c=
Received: from ZR2P278CA0027.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:46::19)
 by ZR0P278MB0138.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:17::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:29:19 +0000
Received: from VE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:910:46:cafe::6e) by ZR2P278CA0027.outlook.office365.com
 (2603:10a6:910:46::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.30 via Frontend
 Transport; Wed, 5 Jul 2023 13:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 VE1EUR01FT034.mail.protection.outlook.com (10.152.2.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.22 via Frontend Transport; Wed, 5 Jul 2023 13:29:19 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4Qx0qy75DWzxpF;
        Wed,  5 Jul 2023 15:29:18 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2043.outbound.protection.outlook.com [104.47.22.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Wed,  5 Jul 2023 15:29:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9DI82wGnxls7TC5l+pGIJWMj3oKikwjepQVkrEz8Yc=;
 b=vPmnaWHgVAGymX774fEfOteERYLgVdlY6Ce+BvDUXu0wjFpqZfbFnlMz3IgkJ8ILd3usBVAlSghcvFDEcZgoi04zW0xW6faJePRx1vOiQ3UWK/sGmczCbuQZ5fBmJZisCJbdMFbKllUF5lpDlKIwolAxLa/osAVreeTEeM9po2c=
Received: from OS6P279CA0048.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:31::7) by
 ZR1P278MB1000.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Wed, 5 Jul 2023 13:14:58 +0000
Received: from HE1EUR01FT006.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:31:cafe::d) by OS6P279CA0048.outlook.office365.com
 (2603:10a6:e10:31::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.30 via Frontend
 Transport; Wed, 5 Jul 2023 13:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 HE1EUR01FT006.mail.protection.outlook.com (10.152.1.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.22 via Frontend Transport; Wed, 5 Jul 2023 13:14:57 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.47) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 05 Jul 2023 13:14:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i96DUkCAzh1wqIYpNdgi6uQQ8imXF5AdC6xP5a9bgpr7rDDL4oQf6JsY5+cE/dS0y5ppv83NAu7L67a7fFL2Zthnws31dsQwhGdEbT3SDejkDtwCPL2AK1BCcmog7R2SnuCjpgyGJxX16pBUjyHVwbLDqWzwbzt1NotIaZP+X20t1NsAmI+h9jmQybZ5K4semEI9Aud6AjijY8iutS+WjH9QnsYgvemJ2IofO6x2OqMPSuBJRrsWm4ot1+qRHPa2LbyFq4u6vQv1ptDNvsyEsX+7qUAdxLKZHQtVeKN8pMOF1VINhEd/BoSNqlnUestFY5h0RniP9YBMhOen/FsDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9DI82wGnxls7TC5l+pGIJWMj3oKikwjepQVkrEz8Yc=;
 b=XP2pDXjzXLtaEloxESvpWoYb2onfPFDIegscrbnNYYmay17ocH5cUGNMqW82vxVYilOeo5zQj0UIIrU0SSPwLh735/ARSS8kweJ68Efiq32S/lgUpRzu79Z5Ks/+VXcD4C6LzhETRVBMRHe9Q1i7fXK+ziaJYwoQXGW92ZzupFom9vcDyd6XImcNlg+sXfV2xXw3FB5SMBelx+VqUoJL57HDkUmW/pVXVXW0uW65cNWfPP0wNhHfEtbiPjwbfO+4DqUqY3Svt64dHtRhwA6yiSKDBjUS/1Fe+fNZRdOdMxaNrLnfPZzVfCDDF6dWKa6Is8a/WYZJDdW5CNmuLJK9hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9DI82wGnxls7TC5l+pGIJWMj3oKikwjepQVkrEz8Yc=;
 b=vPmnaWHgVAGymX774fEfOteERYLgVdlY6Ce+BvDUXu0wjFpqZfbFnlMz3IgkJ8ILd3usBVAlSghcvFDEcZgoi04zW0xW6faJePRx1vOiQ3UWK/sGmczCbuQZ5fBmJZisCJbdMFbKllUF5lpDlKIwolAxLa/osAVreeTEeM9po2c=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZRAP278MB0875.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:14:54 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8c78:4a4d:bc93:c620]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8c78:4a4d:bc93:c620%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 13:14:53 +0000
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
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH 0/3] 8250_men_mcb: Make UART port autoconfigurable
Thread-Topic: [PATCH 0/3] 8250_men_mcb: Make UART port autoconfigurable
Thread-Index: AQHZr0Ku15I+1JB+IUGnqkw+G1c/RQ==
Date:   Wed, 5 Jul 2023 13:14:51 +0000
Message-ID: <20230705131423.30552-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZRAP278MB0875:EE_|HE1EUR01FT006:EE_|ZR1P278MB1000:EE_|VE1EUR01FT034:EE_|ZR0P278MB0138:EE_
X-MS-Office365-Filtering-Correlation-Id: b2dcd35d-be2b-4780-67e2-08db7d5bd65f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: sZrTwqhLq8AzG6LC9jpFHFIfa1XPpkEdiH2vKuJsxRttd06U/z+cKbJBcaIsqGiYzWCJ6Ezjvd52Mr62O/PE6CSBpVeVkRXJQI7HMPuyBuk5rnLzp+9T4cVsvu4x9jXp9EYxbMhurrPFYgE6GwRbaTXVHY4aLqQps3iYBOYbauu/OK2nATNRnXLldPV1q9hEs/XH/pESY0pNdf+9RIR8s9fhuF7qfeda595sMBs1y89ULnSUNpkhA0aNYLBJLuh57QTLso+H5ufPmMkRs+8uO/s2xeURKyo8NmmhNBT3lDpmYTs/Uu4HURGsefUQST4nhmnzWokQk8l5RksgJENyl/aeQI5tDz4YFeJ/DwRKV05cKHl2W6+eowBdwTu8E959ZyXH7RbXvOeRkT7CRa5qa4q5yKs/ZeLD/c+uj6ZbTA6NOVbRsvFie25O7iSTvfFjgktC/Z99//WaIJIHFhfqt01c98GNKigco6/P/ikKnneC533xjef+LW54VCfKHSefj4fOOuqRfhhubF+8xao+mv+jl2oodqcMmND3pF8GLU4TCdhNeyGmdtN98GbtCAzrihiizmUwUCcb4+PHtaMrzkHvmscjUHqnZ8q31yqH77pj329tKPp+biMvNPgHWFHc
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(39850400004)(136003)(396003)(376002)(346002)(451199021)(76116006)(91956017)(66556008)(64756008)(4326008)(66476007)(66446008)(107886003)(122000001)(2616005)(38100700002)(38070700005)(86362001)(186003)(26005)(1076003)(66946007)(6506007)(83380400001)(478600001)(6512007)(6486002)(110136005)(36756003)(54906003)(4744005)(41300700001)(8676002)(8936002)(2906002)(71200400001)(5660300002)(316002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0875
X-CodeTwo-MessageID: ec520849-15a2-466f-b73f-55854b88ee56.20230705131455@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT006.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 738bfed6-2dc9-4142-d866-08db7d59d122
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4FHQ3ksjnP8PUZxQYp8aLx2aHksUKyWzZPOP4F9MAEJURH4tPNUPsrqUpPuPnsz/P/Kw1gxiKoG3B408mZh95pfjqDgWp1QTe9EYGyPp4rXUcTBAjRqbosSt1BkX8b0haflLz+Tp/4MGM0js3UHKcBUlIlry8MYyg0Qxqbr2i5/CQLZod+yDFqd0XdaO4YWY6qv/bqXbNBeU8Uz57xqZT46P1vWi4b0bi/ZY0EgqEHM//3uWYzYX+DtF/GxWjgyKV28+qnUvRWXzV0zQ6QUOyr0SX3Fo1ASAHUmLyUZws4MYmDn20uuKL5eh1gVzNtEaZHAkvS3FfK0Qd1aiBYqW4rMGX0jxxYrC2sKsMSihsrLktbSW7kWuvZg6C6HWbDTosT9ag6ezWEMbyKwlL/UXvfBwo/sw3LModSWS95QMRYS6PHsLaqvkwTZcxxpeDzmruRJcga2aQeVsT6lhJ52PKInQ6/8i/+p8SaGys1ZwGQQ62BhqYN8WYY2fRwwuTYp6OwHAx5RDz2AaSXvwz9RmH2vDDJLEucS9g4UIzXF8fkYO/jJCqlFKFYCpNxmCMIMeHv4e5PSBeB+KHKqNEU4cTVf6AZ8w8Tgm/oOrkz574fkUlCiLmNwi7XzKjL3rcALNqw/LiFLG7OX9m6MtDQEegDSCWoV9AOqaYO/0i7B/toyB5yuGok7hR8XpKnJbWoIyavPX+X2dIht6kP7XDN8ANA==
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(39850400004)(136003)(396003)(376002)(346002)(451199021)(36840700001)(46966006)(70586007)(4326008)(70206006)(107886003)(356005)(7636003)(7596003)(2616005)(86362001)(82310400005)(186003)(26005)(36860700001)(1076003)(6506007)(83380400001)(47076005)(82740400003)(336012)(478600001)(6512007)(6486002)(40480700001)(110136005)(36756003)(54906003)(4744005)(41300700001)(8676002)(8936002)(2906002)(5660300002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1000
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 357be1da-48ed-4154-8dd5-08db7d59d4d9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKkbBp6K9cqjNHVkSMbsvIxY482/G1m6d1JIm6NkG5i7RiwrRk7xfq7q+lv+/hmFq1bObbk9eKWNm/eMHo6ETtyHA5cGkeOhsY9aErn5fJDejFAsFzstS1jN+UE4EqfGmT6DV7tl9VMUHC82nXCXmzt1j5j1J+F7mS1mJTE6fugYkpNxWdWyh+6yegsIGD8KC9bjcE1UmlOFfwphdQa4vodS6Zgc6LLmXRbbsQ2iZlVVZ7w8gj91/0DnezSSiyr/2JvjD3fUxPIZI5sYhNZUGK/Lb/6pbMUH/E1KEhGt8bML0Z+TUZzn9en+dekLuywHrtGEeuI8p2vcWnH58lfG/pNCblSdDSt7isqSs5/G0t+R6RUZE+5hxqjvMJzQFu++Jhi7uhrZvFcE1erchVlILeQrGjRbngu9cVdngOMc1JyOEaoDL/+HFGU39McM7JFQNRytFRG9CdaznpWnHjWZZYI+NmFfbCT60yJn2JLneMYmQ+s+P26VUv+TezWRqn8ulAzqRbNJgCRRMVn6PI92peBjIsBJRh/+AMT9dF2svQCgvcmeMHPdI3KIpaHzocsj9Jyf8UD4LpbVKGkn0qhMTlz2DugxlwY272fZdzGWibuFrC1+QIivAjc5jJvtBXDBb9z8zhRKyQDsnecpPw9EyZI9IkKrm+edrGomiIlrqg1t9m30t1Up2UV8RV+voIgp/4vOaapvXhIQQVLsw2zxZA==
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39850400004)(376002)(451199021)(36840700001)(46966006)(8936002)(41300700001)(8676002)(36756003)(54906003)(6486002)(110136005)(40480700001)(4744005)(316002)(2906002)(5660300002)(4326008)(70586007)(70206006)(82740400003)(336012)(478600001)(6512007)(86362001)(107886003)(82310400005)(186003)(81166007)(2616005)(47076005)(26005)(83380400001)(6506007)(1076003)(36860700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:29:19.2634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dcd35d-be2b-4780-67e2-08db7d5bd65f
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT034.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0138
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make configuration be handled by the 8250 UART subsystem to avoid
weird behaviours and for better maintainability.

Also fix a couple configuration issues when using F215 duagon
boards and how the number of ports are calculated for IP Cores
Z025 and Z057.

Javier Rodriguez (3):
  8250_men_mcb: Add clockrate speed for G215/F215 boards
  8250_men_mcb: Read num ports from register data.
  8250_men_mcb: Make UART config auto configurable

 drivers/tty/serial/8250/8250_men_mcb.c | 206 ++++++++++++++++++-------
 1 file changed, 150 insertions(+), 56 deletions(-)

--=20
2.34.1
