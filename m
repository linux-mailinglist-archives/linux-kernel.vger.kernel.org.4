Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F10B74FCD7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 03:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjGLBsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 21:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGLBsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 21:48:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72433E77;
        Tue, 11 Jul 2023 18:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8PYIUfZC8ITVTHFH7oeFlD99nE7zC06k0zxoWBTmopqE5vsF4xm7gOnzr0nT8JQb9+r/Kfn0cjxF65mHUORI3jycDGpjqyBzLcDd+DnG/zIBRBMkPoAQVwSRvgmtzxDoiYDgoAimd7Y4Jgo13IsZm9hHDGsfWY0bRij7OJ8P1hAoa6IxDApyewL9rk8hQmbbsIhreOv+O/u8dLDM0ZhkjTYuuJkd8y2Ob9HOsRorggmo5ASqo6JPBfJiO0hKxcUaVXuQRaK5Q0+muqCd5bKyLPXbOHSftb3ot/KBpQf0+q464RgOqMnvbPuhaBXSmYrGPu37lG67uW3Lmoza1AQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ol04QS5I/DgeiyCGTySg6FtQ/d+nxMYTWfvNNCJIxfo=;
 b=L+89Z2XvapuEhU67HYSU3CJTxyHDB329HX5S8RIruCr2SKrYvf0zTrZhgIOBUFVowDBgEFomytCdAYh0RT3SivS56JglmEQOEFzKIVcn+tyoGm185BVZjYF8tpBWB6dck+iUu6oTqVJ0v5fNFm31qhO2smusXxS5fpcbzy9AdSsueoZz9dM46bdnvw6OeMW++LV93nlOwUwZY7RiIb6otMbKGj0G+gwFeVQ7TqWwTNmXWtzFNGjogfru7AMoYSAB1CKa1Be/u2D3ivaqpCbT2o+abaPM01/PBG6PME5Ny8/nDDSwMBMX4skppR5d2ctFWWQtnFPG2aVGHHSG4xAlPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=linux-watchdog.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol04QS5I/DgeiyCGTySg6FtQ/d+nxMYTWfvNNCJIxfo=;
 b=JJaOUWjtpbkNApMBKsm3Zm1cJpMTNLNnbdJ2+qVUjC06LQBRRABJHr6eXjXb+xWpMR2y5igvHmc5L5NEbkUJfUEeUGJLu709nXJ6NV+U7atNHDVZ312joI6MtZYA5D5UqyZ1OCHkwEp5JphtC+7wnWbH2JQw8n49TYCQmDsUsNPVUSGwnIOaJdiJL+exxrvpqLF406q9+NCEtlyX1U0o2Xrv9TUY3fc4Zr0FXFRc9Bq9D18mSr1r1fqwoXC9TFhzeal3ODuUGaNLZ33tDZ+2nIMzt4/QwlpeF7dfiDFYipgO9Q7P1WLF/TMiveM03vHNmuxSIO7XRr/FzhhX+v472A==
Received: from DBBPR09CA0028.eurprd09.prod.outlook.com (2603:10a6:10:d4::16)
 by DB8PR10MB3782.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 01:48:14 +0000
Received: from DB5EUR01FT074.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:d4:cafe::a2) by DBBPR09CA0028.outlook.office365.com
 (2603:10a6:10:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 01:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT074.mail.protection.outlook.com (10.152.5.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 01:48:14 +0000
Received: from CNPEK01M02MSX.ad011.siemens.net (139.24.237.215) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 03:48:12 +0200
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 CNPEK01M02MSX.ad011.siemens.net (139.24.237.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 09:48:09 +0800
Received: from CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) by
 CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) with mapi id
 15.01.2507.027; Wed, 12 Jul 2023 09:48:09 +0800
From:   "Li, Hua Qian" <HuaQian.Li@siemens.com>
To:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "kristo@kernel.org" <kristo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huaqianlee@gmail.com" <huaqianlee@gmail.com>,
        "nm@ti.com" <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Su, Bao Cheng" <baocheng.su@siemens.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] arm64: dts: ti: Add reserved memory for watchdog
Thread-Topic: [PATCH v2 2/3] arm64: dts: ti: Add reserved memory for watchdog
Thread-Index: AQHZs9iPA2cxfO52y0aLaB071csYuq+zxREAgAES7oA=
Date:   Wed, 12 Jul 2023 01:48:09 +0000
Message-ID: <02dfb5562da08fa95c8eba9c727dfc8bbaad07be.camel@siemens.com>
References: <20230711091713.1113010-1-huaqian.li@siemens.com>
         <20230711091713.1113010-3-huaqian.li@siemens.com>
         <7e1332bc-0757-bbe8-e087-7a0e52d6b97b@linaro.org>
In-Reply-To: <7e1332bc-0757-bbe8-e087-7a0e52d6b97b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.24.129.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B237B2345B08164389A0C9D9E62E4602@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT074:EE_|DB8PR10MB3782:EE_
X-MS-Office365-Filtering-Correlation-Id: 823ae9c7-3b0e-4e45-1166-08db827a0e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tiK+hFGjbcU0BDb9qY7tRffGvTU0WcJsEUIuw9Onw5J9dKfgAMFLc+2cIg1O0N8ArWYTir0ZUZ0qJvj5bEWnE6+ymMOh7LwiOPDJDwHElzOEfxDFlVosgPsXfOkisAddgVC8x+Y1o/T9vVjL2Zz8CXEjNdV04prnc+qP2bAkAxeb90z9tCxw6ISXJMgR6fUsQ/JJHytH6/HKXO4hmzLqWyuqDlpa6biu0G9c8C2NOgmjlyLwBUcyFmW2vuhr47nxzyZOMQTwc4tbD4H8fdnWzPSJsXcMMgarHxpipfFiB6UN6I2T/ESK+mW55D4QsGrQTzbAhUkHipEsL+lidKqmm1ibBgm4+XkF/BOMJs8KK5NZMHI+Nh9NmwBfP9+QzxWIMgwR8WMGuCzNdjwVgzg2/0HS1xtGUuyVEB5P3M/C5oYHiChITlm3yZEDy8i8OfeX+gIggcf/sYOUxtFqWZeJeCvUaLS0QWbFh8D4RyWc48xm4+F13UM85H+xkntk+wZfGzGGPAiIz11/ec3Cvl56x/wLNJWnfFX5meyi2Rh0+bp+M6TJluu3e1ENmy1E6vAQtOmBbqrWZnWWg/3wiUQaLNYcyAwJsYcf2yIEoIRnGyUEZLdzjoCPe0rsIqinv7PfsdCwAeQslueS7w90sN0BSAiuNbRdUhZMw82J/puFi9jduBV5Y5NCt5xz2cdQzQHVJjwHC8307KZYQladmwY2nUMJvN2Z09y2E7Jjqw7OP8l+FtSqMJctT/EnrKnGhJ6UBHMIxj+SNgo6POc/AF5DxA==
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(83380400001)(47076005)(36860700001)(2906002)(956004)(2616005)(336012)(36756003)(82310400005)(86362001)(82740400003)(7636003)(356005)(7596003)(82960400001)(40480700001)(41300700001)(4326008)(316002)(5660300002)(8936002)(8676002)(478600001)(70586007)(110136005)(54906003)(70206006)(186003)(26005)(7416002)(53546011)(171213001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 01:48:14.1598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 823ae9c7-3b0e-4e45-1166-08db827a0e68
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT074.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3782
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

T24gVHVlLCAyMDIzLTA3LTExIGF0IDExOjI0ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOgo+IE9uIDExLzA3LzIwMjMgMTE6MTcsIGh1YXFpYW4ubGlAc2llbWVucy5jb23CoHdyb3Rl
Ogo+ID4gRnJvbTogTGkgSHVhIFFpYW4gPGh1YXFpYW4ubGlAc2llbWVucy5jb20+Cj4gPiAKPiA+
IFRoaXMgcGF0Y2ggYWRkcyBhIHJlc2VydmVkIG1lbW9yeSBmb3IgdGhlIFRJIEFNNjVYIHBsYXRm
b3JtCj4gPiB3YXRjaGRvZyB0bwo+ID4gcmVzZXJ2ZSB0aGUgc3BlY2lmaWMgaW5mbywgdHJpZ2dl
cmluZyB0aGUgd2F0Y2hkb2cgcmVzZXQgaW4gbGFzdAo+ID4gYm9vdCwKPiA+IHRvIGtub3cgaWYg
dGhlIGJvYXJkIHJlYm9vdCBpcyBkdWUgdG8gYSB3YXRjaGRvZyByZXNldC4KPiA+IAo+ID4gU2ln
bmVkLW9mZi1ieTogTGkgSHVhIFFpYW4gPGh1YXFpYW4ubGlAc2llbWVucy5jb20+Cj4gPiAtLS0K
PiA+IMKgYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY1LWlvdDIwNTAtY29tbW9uLmR0c2kg
fCAxMQo+ID4gKysrKysrKysrKysKPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NS1p
b3QyMDUwLWNvbW1vbi5kdHNpCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NS1p
b3QyMDUwLWNvbW1vbi5kdHNpCj4gPiBpbmRleCBlMjZiZDk4OGU1MjIuLjc3MzgwZTUyYTMzNCAx
MDA2NDQKPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NS1pb3QyMDUwLWNv
bW1vbi5kdHNpCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjUtaW90MjA1
MC1jb21tb24uZHRzaQo+ID4gQEAgLTYzLDYgKzYzLDEyIEBAIHJ0b3NfaXBjX21lbW9yeV9yZWdp
b246IGlwYy1tZW1vcmllc0BhMjAwMDAwMCB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhbGlnbm1lbnQgPSA8MHgxMDAwPjsKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG5vLW1hcDsKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAvKiBUbyByZXNlcnZlIHRoZSBwb3dlci1vbihQT04pIHJlYXNvbiBmb3Ig
d2F0Y2hkb2cKPiA+IHJlc2V0ICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
d2R0X3Jlc2V0X21lbW9yeV9yZWdpb246IHdkdC1tZW1vcnlAYTIyMDAwMDAgewo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWcgPSA8MHgwMCAweGEy
MjAwMDAwIDB4MDAgMHgwMDAwMTAwMD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoG5vLW1hcDsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqB9Owo+ID4gwqDCoMKgwqDCoMKgwqDCoH07Cj4gPiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDC
oGxlZHMgewo+ID4gQEAgLTcxOCwzICs3MjQsOCBAQCAmbWN1X3I1ZnNzMF9jb3JlMSB7Cj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8Jm1jdV9yNWZz
czBfY29yZTFfbWVtb3J5X3JlZ2lvbj47Cj4gPiDCoMKgwqDCoMKgwqDCoMKgbWJveGVzID0gPCZt
YWlsYm94MF9jbHVzdGVyMT4sIDwmbWJveF9tY3VfcjVmc3MwX2NvcmUxPjsKPiA+IMKgfTsKPiA+
ICsKPiA+ICsmbWN1X3J0aTEgewo+ID4gK8KgwqDCoMKgwqDCoMKgcmVnID0gPDB4MCAweDQwNjEw
MDAwIDB4MCAweDEwMD4sCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDwweDAgMHhhMjIw
MDAwMCAweDAgMHgxMDAwPjsKPiAKPiBUaGF0J3MgYSB0b3RhbCBtZXNzLiByZXNlcnZlZCBtZW1v
cnkgYW5kIElPIGFkZHJlc3Mgc3BhY2UuIE5vcGUuCj4gCj4gCj4gCj4gQmVzdCByZWdhcmRzLAo+
IEtyenlzenRvZgo+IApZZXMsIEkgbWlzdW5kZXJzdG9vZCB0aGUgYWR2aWNlLiBJIGludGVuZCB0
byByb2xsIGJhY2sgYXMgSSBtZW50aW9uZWQKaW4gbXkgbGFzdCBlbWFpbC4gQW55IG5ldyBzdWdn
ZXN0aW9ucyBwbGVhc2UgbGV0IG1lIGtub3csIHRoYW5rIHlvdSEKCkJlc3QgcmVnYXJkcywKTGkg
SHVhIFFpYW4KCg==
