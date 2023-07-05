Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D64E7484F3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjGENaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjGENaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:30:03 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2131.outbound.protection.outlook.com [40.107.23.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE80172B;
        Wed,  5 Jul 2023 06:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0SPDFXW9gAskqM3xBT6zq4oExo4cox1IwDqU/HcNCc=;
 b=wgjKLn+31o3BPI1jvDEvv2Vhsw7Hk0QmOJePV+LVX7jKZH7sPy9WHGF089yM1h6kcmmDZKLKeXv9AYtR+uMjjXjKNiBHaZtE0kuUUD8Bd8a01UGQNSzHFOU7Jsd2wgel4YmpNmkP7+w9L4jcWIXrs3nkAWXY9z+KFWB6e4dK4ps=
Received: from FR3P281CA0141.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:95::14)
 by ZRAP278MB0047.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:11::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:29:48 +0000
Received: from VE1EUR01FT019.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:95:cafe::3d) by FR3P281CA0141.outlook.office365.com
 (2603:10a6:d10:95::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 13:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 77.74.96.169)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 77.74.96.169 as permitted sender) receiver=protection.outlook.com;
 client-ip=77.74.96.169; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (77.74.96.169) by
 VE1EUR01FT019.mail.protection.outlook.com (10.152.2.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.18 via Frontend Transport; Wed, 5 Jul 2023 13:29:47 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4Qx0rW2Yl5zxpF;
        Wed,  5 Jul 2023 15:29:47 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Wed,  5 Jul 2023 15:29:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0SPDFXW9gAskqM3xBT6zq4oExo4cox1IwDqU/HcNCc=;
 b=wgjKLn+31o3BPI1jvDEvv2Vhsw7Hk0QmOJePV+LVX7jKZH7sPy9WHGF089yM1h6kcmmDZKLKeXv9AYtR+uMjjXjKNiBHaZtE0kuUUD8Bd8a01UGQNSzHFOU7Jsd2wgel4YmpNmkP7+w9L4jcWIXrs3nkAWXY9z+KFWB6e4dK4ps=
Received: from BE1P281CA0021.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:15::7) by
 GV0P278MB1143.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Wed, 5 Jul 2023 13:15:19 +0000
Received: from VE1EUR01FT026.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:b10:15:cafe::13) by BE1P281CA0021.outlook.office365.com
 (2603:10a6:b10:15::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 13:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 VE1EUR01FT026.mail.protection.outlook.com (10.152.2.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.18 via Frontend Transport; Wed, 5 Jul 2023 13:15:19 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.113) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 05 Jul 2023 13:15:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ValJuxGp/DSiMN1xHdnzUkQzstd6AfuBdpEa9o45jL7+FA8XPAjIOfLPXLm5eOCsP0goTnTAz3CxScEgP+rDxU1I3ecmUnAGm2GCceKoA6I5wANZ6FioBA7Pbju2EfbvyBrWAz6aJc2dWUuy4pELmfcn4Kbx5Wpw5GcZTg2cbYVpp9JvD8JyR95DQWqhn3/V/klhSQdI28pGBWoGngyrn0qvfZsgznk5rcJUzcfc96sJzH69kugkC87hoNrDy5HsszTaXxFHdEF8Pt590d1v3lXGOW/wCmLqKk9JypOhGS9DjlnzjYJu4W84V9jCPQTto1F1Sz0yHhbT89bvUUmZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0SPDFXW9gAskqM3xBT6zq4oExo4cox1IwDqU/HcNCc=;
 b=X+5/9k1fvHphVt62RDIwcLbWQjf8zsHc4a566eJeg5Zo9IYJoBAs2axsgim7lbS/LOeU8QB3AmXdW5lIq5r7sLk/Bb4RE0DwASkKs4rWDV+At5T6icdMA3BWO64rBhfDxha+VgiyoBz8P1YzIEsUnBweYWQdueqLgpep4KqZQnuQeRqH2F8rVVogNruasqdrEGbroCs4iuAJSfaPBRAhtYcs9XVYDAx4eGDLYjKspDw0Rml1Gj/MfCwKeQI8UPeXYTz+XBhupfqSfVplfy8KF0eTbCoXV6hW+7hVq2HhqfQFvLEg+57WBEK0Oz+ombzgxFITZKcjp6XeJPgYVYIU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0SPDFXW9gAskqM3xBT6zq4oExo4cox1IwDqU/HcNCc=;
 b=wgjKLn+31o3BPI1jvDEvv2Vhsw7Hk0QmOJePV+LVX7jKZH7sPy9WHGF089yM1h6kcmmDZKLKeXv9AYtR+uMjjXjKNiBHaZtE0kuUUD8Bd8a01UGQNSzHFOU7Jsd2wgel4YmpNmkP7+w9L4jcWIXrs3nkAWXY9z+KFWB6e4dK4ps=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZRAP278MB0875.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:15:15 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8c78:4a4d:bc93:c620]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8c78:4a4d:bc93:c620%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 13:15:15 +0000
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
Subject: [PATCH 3/3] 8250_men_mcb: Make UART config auto configurable
Thread-Topic: [PATCH 3/3] 8250_men_mcb: Make UART config auto configurable
Thread-Index: AQHZr0K8fcTuFeeK1UG0aZ2WCr9cvg==
Date:   Wed, 5 Jul 2023 13:15:14 +0000
Message-ID: <20230705131423.30552-4-josejavier.rodriguez@duagon.com>
References: <20230705131423.30552-1-josejavier.rodriguez@duagon.com>
In-Reply-To: <20230705131423.30552-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZRAP278MB0875:EE_|VE1EUR01FT026:EE_|GV0P278MB1143:EE_|VE1EUR01FT019:EE_|ZRAP278MB0047:EE_
X-MS-Office365-Filtering-Correlation-Id: 15983490-9cba-4174-8caa-08db7d5be74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: yY+6sxmOeqL9MDy1N2irpguXlz9oIECGi5rXaxzBsE2rWrZT/+F2Bc94qIuvJmXLgsAp40oplHi1SEHq1W1QxI7oLCaKXDKIfvyvzgQYz2PePLk/f0jgJEDynVxU8hRRUXHpK5Z7tYyOFY10nhsSiuHVWkM4BY6xP6YKx08dz2pDi4BPIUVoxRA3sI7bEPmq9yLKX9Ekfv7Qaz7yvMiHvRKHLosjjUIYza3GO3N37fa6AXFTWGsPtAXwH27FBHSlD5JoXTGcUb6bu/F9gvFpuHaKwUv1Iq+E+PmGZK3KfBvzlLZYnKKud18rZaEm5D+jaUfVqyCLyPeAA6Qd6c8Chp9I6kstJw69k2xaTkUVYgH/yVHc3csxafd3iSqJmkKvwoskN6PEXnE748aXsZPSPyT0PR8pv2ZDtGhmCprLFde9NCH778mWiNo7PftEW+xwJe2dWJdF4Gzd62brUC0kIefya7cFjYXQ3nn+HJVSd4DmMHX+fFF+WXnVfu/pbDnbB7jpDenmgVhqhLrmxMRRTK0suWOCKhHsYsMFy1VySg2K7tJdseDNGZKeM+jcNcHSHazLHLlu70gpspfCmzhTF4slTbYRz1805Dahgzy7kvlN1iRSX+jWSwtdiBrKuTvG
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(39850400004)(136003)(396003)(376002)(346002)(451199021)(76116006)(91956017)(66556008)(64756008)(4326008)(66476007)(66446008)(107886003)(122000001)(2616005)(38100700002)(38070700005)(86362001)(186003)(26005)(1076003)(66946007)(6506007)(83380400001)(478600001)(6512007)(6486002)(110136005)(36756003)(54906003)(41300700001)(8676002)(8936002)(2906002)(71200400001)(5660300002)(316002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0875
X-CodeTwo-MessageID: a68b4dec-18bc-49a4-9442-9e90e5355dd3.20230705131516@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT026.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9f388168-5750-4cef-c559-08db7d59def7
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: rRP6giMqTzfVd4EEHE9BKFQPRA44cdUnE0r+36vNedJUEfyso1BB7BT/0VGv/LTT91CRHURdG0w2DN9mSRKnyKAaUXjSVrTWSJn3dPe2lpMz+1V4xkiDUHq3K8sRECxSwqFK8zDsimka6+4+IYilhhwGkLWwxc6+j/rWNoC9alXLkseLG4ATP1HsWmeW2dNK+jWijxO9aGqtIcAHpFQj2sDMFLmUhKON+E7UwbjIsIdpAMwH6bWsQCuYzfG1iJVBp/h4iJIWOehpEsBx9xSuyER1EO3RtZVSDY53kJYf3J45Pxi3/DpMrdXh6MtX89xbXZmtNPC+RLrJFFqgRLUD9w1ssMN8J4tSt7/dr+Gv3cfLWKSkJ+gNE7zU4t0kiL3gZoI+SlHUfTUvhLrCYe87ZghP0NpPGkELd16qKDMTF0ewLZq5PiCwow7MvSG42YySaRG6X7EhqiI2/6VbO5cYaEE0pXik5/NatVRN3cE1U0KK4VYmdvtI1DnPYpIo9HGL0ajdIR8xyBE68fkT+0O8ug/I4mQscEAvfjLLWlxNqdJr7bk0n5eUsQGlXW1zX2tsHMEQM2YRBGE1TAYcpXKFEjEBgV0AJ99aJzp9L9L2fygvctLCl+uZUyWKcp/cq5Fqu9555EDEScaVa9FNRVkIPuZzycw1pXzkQR2SHwPwyOIukhgiCGUHS/7mNL5oxx+adBVKCHwPMf+NY7X6sQR+zw==
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39850400004)(451199021)(36840700001)(46966006)(36756003)(86362001)(82310400005)(2906002)(5660300002)(40480700001)(47076005)(6512007)(186003)(336012)(36860700001)(83380400001)(6506007)(1076003)(26005)(107886003)(82740400003)(7596003)(7636003)(356005)(6486002)(54906003)(110136005)(70206006)(4326008)(2616005)(316002)(70586007)(8676002)(478600001)(8936002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1143
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT019.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d7b282c6-47a3-4c41-f5ce-08db7d59e186
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Av/sZNBvqulMREBWFY2ro33pddPwPHHC1T+L1cnzjLcC8NK6arP4+jUbMWPfHXZG2qhwUEogt4Q2v+ASRoCgDj2SQU7sSA0DIVrpjnmhasirGF2KsQq7+dCDfkRbf68L7ZAf5iSvSS9IePCO0Qtex39sV+VZPgkIFghwR1GMW7ljVNB9/9qL+z/CyPqM1YQzaF/r7oURK/DChbdQptbQ2Rw3P954VD2SFWFWVWMU8WTTv7xuCzLN2eA4JHOtHiJ1chCoehgW0McUzC8wORYMt0KkusuDtmjZDY0FLPjIiHq27E5CXM6GEqTeJvznR8fvqwGS3NgLw6hqPtddU/9/Ibzj643zkdodZ9ZBdOLKxO5IXVjterUZZ3Hc8mUc7bZI79eEO8jXNpTGXMF3EG5xmfKOvIojCT77X5bjeCYZe5hiUX00jYSNWsIgYxVJBphsMHVMyz7xhjqhKqspJALQdgAkMXIl0Cwv9nhQNA8iH3FJIGf+XZUdE2xwrVqTve+8oj0oSWFH5795XGLCDHEyWuEQvqoXEwcFgJBCGzNyGT61qCqz4fcHk+IYwXtaDgMKxzwhQlWxOGFXAIWNYwfngw+yV1VueHJCUjZYNjZhiTPp0OMenlEKKiX88+uQvrTjGTPZY8xX1MQsHeHCNeK27wQg0/CVCX8x3tEb/RUMHRO2WNAggGYwJxwkEo7W80YWyHxsmjJ660sPe0sNo2IwNTIIeIHZvTtiLEcEvETh0/Pu+o34N3brwqGae43oaUj7
X-Forefront-Antispam-Report: CIP:77.74.96.169;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:securemail.duagon.com;PTR:169.96.74.77.ftth.as8758.net;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39850400004)(136003)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(6512007)(316002)(6486002)(86362001)(2906002)(40480700001)(4326008)(478600001)(70586007)(70206006)(40460700003)(5660300002)(36756003)(110136005)(54906003)(81166007)(336012)(2616005)(83380400001)(8676002)(82310400005)(8936002)(47076005)(36860700001)(186003)(1076003)(6506007)(107886003)(26005)(41300700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:29:47.6672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15983490-9cba-4174-8caa-08db7d5be74d
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[77.74.96.169];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT019.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0047
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UART ports created by this driver were not usable out of
the box, so let the configuration be handled by the 8250 UART
subsystem. This makes the implementation simpler and the UART
port more usable.

The 8250 UART subsystem will take care of requesting the memory
resources, but the driver needs to first read the register where
the num ports is set, so a request of the resource is needed
before registering the UART port.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 43 ++++++++++++++------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/82=
50/8250_men_mcb.c
index d6cfebb3ee8f..c3143ffddea0 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -81,15 +81,28 @@ static u32 men_lookup_uartclk(struct mcb_device *mdev)
 	return clkval;
 }
=20
-static int read_uarts_available_from_register(void __iomem *membase,
+static int read_uarts_available_from_register(struct resource *mem_res,
 					      u8 *uarts_available)
 {
 	void __iomem *mem;
 	int reg_value;
=20
-	mem =3D membase + MEN_Z025_REGISTER_OFFSET;
+	if (!request_mem_region(mem_res->start + MEN_Z025_REGISTER_OFFSET,
+				MEM_UART_REGISTER_SIZE,  KBUILD_MODNAME)) {
+		return -EBUSY;
+	}
+
+	mem =3D ioremap(mem_res->start + MEN_Z025_REGISTER_OFFSET,
+		      MEM_UART_REGISTER_SIZE);
+	if (IS_ERR(mem))
+		return -ENOMEM;
+
+	reg_value =3D MEN_READ_REGISTER(mem);
+
+	iounmap(mem);
=20
-	reg_value =3D MEN_READ_REGISTER(membase);
+	release_mem_region(mem_res->start + MEN_Z025_REGISTER_OFFSET,
+			   MEM_UART_REGISTER_SIZE);
=20
 	*uarts_available =3D reg_value >> 4;
=20
@@ -97,7 +110,7 @@ static int read_uarts_available_from_register(void __iom=
em *membase,
 }
=20
 static int read_serial_data(struct mcb_device *mdev,
-			    void __iomem *membase,
+			    struct resource *mem_res,
 			    struct serial_8250_men_mcb_data *serial_data)
 {
 	u8 uarts_available;
@@ -106,7 +119,7 @@ static int read_serial_data(struct mcb_device *mdev,
 	int res;
 	int i;
=20
-	res =3D read_uarts_available_from_register(membase, &uarts_available);
+	res =3D read_uarts_available_from_register(mem_res, &uarts_available);
 	if (res < 0)
 		return res;
=20
@@ -146,7 +159,7 @@ static int read_serial_data(struct mcb_device *mdev,
 }
=20
 static int init_serial_data(struct mcb_device *mdev,
-			    void __iomem *membase,
+			    struct resource *mem_res,
 			    struct serial_8250_men_mcb_data *serial_data)
 {
 	switch (mdev->id) {
@@ -156,7 +169,7 @@ static int init_serial_data(struct mcb_device *mdev,
 		return 0;
 	case MEN_UART_ID_Z025:
 	case MEN_UART_ID_Z057:
-		return read_serial_data(mdev, membase, serial_data);
+		return read_serial_data(mdev, mem_res, serial_data);
 	default:
 		dev_err(&mdev->dev, "no supported device!\n");
 		return -ENODEV;
@@ -170,15 +183,11 @@ static int serial_8250_men_mcb_probe(struct mcb_devic=
e *mdev,
 	struct serial_8250_men_mcb_data *data;
 	struct resource *mem;
 	int i;
-	void __iomem *membase;
 	int res;
=20
 	mem =3D mcb_get_resource(mdev, IORESOURCE_MEM);
 	if (mem =3D=3D NULL)
 		return -ENXIO;
-	membase =3D devm_ioremap_resource(&mdev->dev, mem);
-	if (IS_ERR(membase))
-		return PTR_ERR_OR_ZERO(membase);
=20
 	data =3D devm_kzalloc(&mdev->dev,
 			    sizeof(struct serial_8250_men_mcb_data),
@@ -186,7 +195,7 @@ static int serial_8250_men_mcb_probe(struct mcb_device =
*mdev,
 	if (!data)
 		return -ENOMEM;
=20
-	res =3D init_serial_data(mdev, membase, data);
+	res =3D init_serial_data(mdev, mem, data);
 	if (res < 0)
 		return res;
=20
@@ -196,22 +205,18 @@ static int serial_8250_men_mcb_probe(struct mcb_devic=
e *mdev,
 	mcb_set_drvdata(mdev, data);
=20
 	for (i =3D 0; i < data->num_ports; i++) {
-		uart.port.dev =3D mdev->dma_dev;
+		memset(&uart, 0, sizeof(struct uart_8250_port));
 		spin_lock_init(&uart.port.lock);
=20
-		uart.port.type =3D PORT_16550;
 		uart.port.flags =3D UPF_SKIP_TEST |
 				  UPF_SHARE_IRQ |
-				  UPF_FIXED_TYPE;
+				  UPF_BOOT_AUTOCONF |
+				  UPF_IOREMAP;
 		uart.port.iotype =3D UPIO_MEM;
 		uart.port.uartclk =3D men_lookup_uartclk(mdev);
-		uart.port.regshift =3D 0;
 		uart.port.irq =3D mcb_get_irq(mdev);
-		uart.port.membase =3D membase;
-		uart.port.fifosize =3D 60;
 		uart.port.mapbase =3D (unsigned long) mem->start
 					    + data->offset[i];
-		uart.port.iobase =3D uart.port.mapbase;
=20
 		/* ok, register the port */
 		data->line[i] =3D serial8250_register_8250_port(&uart);
--=20
2.34.1
