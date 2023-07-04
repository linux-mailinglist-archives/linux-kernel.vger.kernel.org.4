Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7838746A6E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjGDHSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjGDHSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:18:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6142186;
        Tue,  4 Jul 2023 00:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKuRdPjGg04ThuEyJ6LugVuXS6qFlLnzA2fgp+iZm1ReY9t91trIlzZmHm3I2OfspZYBZyieyUIkqxnIDBEGHt7Tlmok8gjmK8WCJgHoj9tz1TF8GVh8IZJH4bJ3yNTdmRriS4NC3q8SVCfkH5ZNnz+2ley2J08H9T2NkKk5YSVnWSYthqUjyiNIi3siHNdF5IEr0RQW1iEzj4a9CQ6S8X27Ens6+u7IGEG9ly9EoxqDruf2rM1oI6rBhu7mgY9+2S9PuzN1sEJZI0SGHoVvsJxGIwxACfwfb+b2Ld8MR7gs7j2bZ0lyN+f5pBggGJcoELKu8J2gSn1TyNOItarhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4QUsUGNjfPIYrT7jaQx58mIX5EdSxdsYheLwy28BDg=;
 b=Lum3WLRqwNXZR8PVUwcIldNwq7LJFJjTUoKhAUbEK+n2yFC0NhhQP+VIqYaa2F1GsrgKettqK72ZOq9vxwFt5T+NipJ/E9uOuaJW1bZpg8CVNay+b8ANaoeeSuXEebN8fSCXb74T4ZV1H+uj74VPoOUjNhDxxf5/tRJ6/xa4n27hCZvNiO+P2yqIm1XnyhQNDWUQUAZCfbB9ffjKdi6sCZYhdSiDyKEZPeyxOyIpvNW9zry2fF9nEIF2jgZzKinZRf2Yc1xjcuWofueY5U5VyPwWZon00Ok0+GVcS17ZKxlZRpNfHbFBxcTNAHNHrBfsW4nCuuipPsfUeShzRDU6dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4QUsUGNjfPIYrT7jaQx58mIX5EdSxdsYheLwy28BDg=;
 b=pYtMZxE/S3YRp1UQEJosHzLYk2hxhWCxtK72orEJH+TzpYmBfKGzpk11jnvDeDB6/vtp86C/ltDNOZam95Ve4GDcx/N2Zg4wUlLxDFqjRb+rbX0/fxaJbL/ENhHaFMP8KeKrJjJTEHboJAefiRmjZbzZ/tcpmlS9gmrBWkT0kQciN6gCGLHsLrMGOy1PkC0v9snvE9naGCV9S0fobv8sLoGYsvGROkQPH1GO4a08FhXG5JMGISOizLNyjyAOx6t+uhMNQPwOAR83U6fDnUX21nSrV8odXc6fgQjLKa4GF7zLwFM4w97Qz1WHkvKf1ioU+YI5v8L760D9Lzlq9LPqtQ==
Received: from DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46::26)
 by AS5PR10MB8269.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:67e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Tue, 4 Jul
 2023 07:17:55 +0000
Received: from DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a270:2154:bf88:4c9e]) by DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a270:2154:bf88:4c9e%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 07:17:55 +0000
From:   "Haener, Michael" <michael.haener@siemens.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Thread-Topic: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Thread-Index: AQHZrkUWBZBED1bC10u9HajfJFJci6+pMsAA
Date:   Tue, 4 Jul 2023 07:17:55 +0000
Message-ID: <20a135919ac7d54699d1eca5486fd640d667ad05.camel@siemens.com>
References: <20230704065916.132486-1-michael.haener@siemens.com>
In-Reply-To: <20230704065916.132486-1-michael.haener@siemens.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR10MB2506:EE_|AS5PR10MB8269:EE_
x-ms-office365-filtering-correlation-id: d7b10780-838e-4210-64cb-08db7c5ec985
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XYw/Oz6S+A4SyLrN0nQBZ2/UMTAe5WX+LvRaAmipe36WocwSbhi65amnVpSzON2geVQFBE32C1BSp6JmC8KqEvATVC3rhrSANNZ3HYwZAVKyk/M4lfeD5TQodFjMwvCnUdWPn92FkpzbEVjDRTqiHGkdbBQtur6/Trn08r58Us2sulNhdgmNZJ8M7IAGGaWiaJwFI8HRjmGkO/aqXBkAsIAelad57ELVvGAxBUIffQRJ8ENEce/trToty10aWYxtISKEERNK4R9062GTUfCr4LLvKJtGy88zV4/LqhAh9xZc8asypGIiYu8WfHwXFXyE6tuoPXz6bq+UgxqVi06PO/tMfh47ZMTpn4kQt98AP9Mk7WH4IW19BU+eM2SNqvQPQKzMr32PlLEn0k5iMnlOBmDxzKFxNP/zmFY+YfSdVWVuhvF11ZHUFx+owYq/IAEOTxZPmTVTyeBQQ5mi2QMngmdXz7vsvtIuQXQCTZTCP2RmP5JH/78AJ0z0Euo6/iEwrH3cAlerIkxa+6jCXYXwz4vXU+3o1dPwhEiFvFRcv04BJr7ZvCyNgotGZXSAY0rJl385v+Okay9ee01LPiPepKa67rsCpgSoXYn4mzXRSbR5P/0Ah/1qRI47H5eRRkQXIH2EphkqXYMc76mP0ZIq3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(1590799018)(66946007)(91956017)(107886003)(85182001)(5660300002)(36756003)(8936002)(8676002)(54906003)(71200400001)(76116006)(478600001)(1580799015)(6486002)(64756008)(66446008)(66556008)(66476007)(4326008)(6916009)(85202003)(6512007)(41300700001)(83380400001)(82960400001)(122000001)(38100700002)(316002)(26005)(6506007)(4744005)(2906002)(2616005)(7416002)(186003)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzFjQnB4aEJtUi9DSFlYMFBSTS9uelkzTEFsSEdSbkQrRWxjM25kc2ZhU3N2?=
 =?utf-8?B?eEVDZVZteWxXQUEzN3ZXelV0ZTRZbGJEbTBKWVlVaDRGeis0SE5KNFlTU1pp?=
 =?utf-8?B?bEtndVlVZFRhOVZPMUprUmJrR2J2YTNXRzhuYlVBa3Y5QXd5WkEwMDRYVTNI?=
 =?utf-8?B?Z1lPNzFkMStwTWF0RnUySnlCaDNBYkcvUmtYMHpTNTM0bkJ1bENzNFYxY1hR?=
 =?utf-8?B?MWJ5WGNqcVkyMkJzNEJLdlY1ZXZuendzeVYvRUhyNUtUa0RvRTV3cXc4dVpW?=
 =?utf-8?B?dzhzaFBwNlpuSEQveDdObUdrSGhUY3c0R1JwdGFSMDJMNzRPWXYrdEFSZlFp?=
 =?utf-8?B?bzdZMys5SEYzeE1WT0pVZXFLSXFtTlNZeSs2aUdDZm93K1JPdkY2UmVCSU9u?=
 =?utf-8?B?bW9QSjNJNlRvajQzRHNlL0ptTFFZVW9KbjlUaFpxZmZPZGdJVk1zQVhxSXFv?=
 =?utf-8?B?RWFDaTlwQ1JBZ3VRSm9iQVFFZDFXQVAwamhYNHRVTW80TU1tMUZiVWtrUzVU?=
 =?utf-8?B?blZidlc1d2FjMWQ2RDBUbTBVM09peFZUeGdMQmQvMlJtS29zQXlSRHp1ZFRx?=
 =?utf-8?B?eTM5Q0dzMWg1NWltb2VhTTYvMFIrMDYzaU5EK2Ftb3NRaUIxclJJWjRnN281?=
 =?utf-8?B?U25RcVVpKy9oOStiUGttUksxanFGSENUVE80V2loUmRhb01DWk9hLzJ4MmJB?=
 =?utf-8?B?M2VQWFBzQlVSTHhuMXVHM0ZKTkVBRlBUdFJlcFFOeGxFN05RNnNKcG9BK2My?=
 =?utf-8?B?dndOWUdzVFFRVFFsWDBmMlJXRXZnVElWZGpxVkxlUkZlZVdMVG5TMjZ5Y3Y5?=
 =?utf-8?B?YVpJS0ZPczBnUmM3WDY5V29QWG5hRXhUZnZGOTl2NTVNR09YclpjWjdiVTBO?=
 =?utf-8?B?QW9BZkVQcjZWSU9JWVgzbGE0WTdEckdGamM5YkZvVDVzbDcrTHBYWXJVOWpM?=
 =?utf-8?B?aEZkOFpmdHlVc1RCZStEQmN5a3EwOG9scmtLaHp6YTJEUWhQKzNVK3Iya25h?=
 =?utf-8?B?QzlTRndkKzV6akdBTWloQWU4NUcwRUJ0aEE3dmZ0QlRjeXhCR3dYQkhyNUNF?=
 =?utf-8?B?M0dkYW1nNEZFQStBVkRMOFJJWER0czdyb2RBS010Nnl6ZnZzKzNnNmZwamEx?=
 =?utf-8?B?MXpkaTlaTFZYM3huMERoUS9HRU5oWm14R1dRTFZQemFCL3BCcXg4L3NuQzJq?=
 =?utf-8?B?Y0NjeHlJRXRtYXdjOWhXbFIrMEtXc1Y1TGZPa3gxYnJVa2xwYUdNbG9pMVBI?=
 =?utf-8?B?MWU1eGpydkZGcExQaTZxdWR4Wk9XL0VJZjNTNW9tUTNXTDlHMTRjYkhGWU50?=
 =?utf-8?B?clIxNWdZU0RXbkFaemlXc0R4QkxmMkxjNHcvQzAyMnI3RWZtZVBONzNsMEFz?=
 =?utf-8?B?U3FjSGR1RmsydXJscDBRYUNUZmdpa1dMdkNoRmV4eE0xWm9HUkJoMWdlc2ZC?=
 =?utf-8?B?ZEJDVVlxS2pWUFpsMG44cTF0cUpyZkFHSk5TMmduOFV6cW12MmdKVlpMcGhh?=
 =?utf-8?B?Z3pWWk9adTdKNkVydkF5UXZOczQvRzdXS3NRMG13U0tiY0dzaUh4cHlESnhW?=
 =?utf-8?B?Um4rNHlSdit6TEZnRGpmejYzczVMZzBBZDJ6SzVCbmozendta0RZSjluaElt?=
 =?utf-8?B?cmJUcGVYK0svU2lLR0U4QnA3QWNDc294TCtqaXFMZUtEaFB3b3F3M3M2RkQz?=
 =?utf-8?B?RVdvUjRPdjRoRWNVdUpoVmZjL2k3OTBXNVpmNUlXcXVMeVBxVzVqNzR4OUxY?=
 =?utf-8?B?VlNveW5FZys1R2tJZVl6TmpvcHF1MU9IcnoxWVdSNVFuVmtEM2ZyYVRmUkVq?=
 =?utf-8?B?Wms1akZXSFBIQ1kxVmw3RWd6Q3JqN2tOV1dSdmZCQnlPSmRwSDQ0LzQyR3Z5?=
 =?utf-8?B?VXB1eUtrRnpiVEdpSURDaGRPNVM5NG5wMWhZUnlQZnBaUW5LQ0piTGdTOUF5?=
 =?utf-8?B?ZU8rYmJ6VWpGbFlBTG1ndWU4RWRObytIc3ZjSUZ6TWhJNjRWbTZiRGRUTHA1?=
 =?utf-8?B?YmtuNWhlMlVrL3VRNjJkcndKeVRQYjUwOWpYbzRMMXNvc2FwMjN1aHluM3ZI?=
 =?utf-8?B?cmpEaTRIVWRTSXdPUVpKWDJsTDdQUndKOWtudytrL1NpRjZLSTV0T0o1Q2xN?=
 =?utf-8?B?ZHJNaklpZjhxU3M4RXo1UnhoWWhhcm9yM1BCVWd1TGxHZElZS0VBV3hGczEy?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <082126E8EA3F4D4ABE491A310AE4B9FC@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b10780-838e-4210-64cb-08db7c5ec985
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 07:17:55.2542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HL6r7X+INK3dP/U85zHoSYChGGIqiH4d9D/ZMCLnSDoNwsSmryTyTyhC350DVhOTUeE/UXHRQuzf2UHO0tnilDUTAQZxHQX9hiKgV2GljSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8269
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

T24gVHVlLCAyMDIzLTA3LTA0IGF0IDA4OjU5ICswMjAwLCBNLiBIYWVuZXIgd3JvdGU6DQo+IEZy
b206IE1pY2hhZWwgSGFlbmVyIDxtaWNoYWVsLmhhZW5lckBzaWVtZW5zLmNvbT4NCj4gDQo+IFRo
aXMgcGF0Y2ggc2VyaWVzIGJyaW5ncyBTRVJERVMgc3VwcG9ydCBmb3IgdGhlIG12ODhlNjMyeCBm
YW1pbHkuDQoNCkNoYW5nZWxvZzoNCnYyOiByZWJhc2VkIG9udG8gUnVzc2VsbCBLaW5ncyBzZXJp
ZXMgZHNhLzg4ZTZ4eHgvcGh5bGluaw0KDQo+IA0KPiBNaWNoYWVsIEhhZW5lciAoMyk6DQo+IMKg
IG5ldDogZHNhOiBtdjg4ZTYzMng6IFJlZmFjdG9yIHNlcmRlcyByZWFkDQo+IMKgIG5ldDogZHNh
OiBtdjg4ZTYzMng6IFJlZmFjdG9yIHNlcmRlcyB3cml0ZQ0KPiDCoCBuZXQ6IGRzYTogbXY4OGU2
MzJ4OiBBZGQgU0VSREVTIG9wcw0KPiANCj4gwqBkcml2ZXJzL25ldC9kc2EvbXY4OGU2eHh4L2No
aXAuY8KgwqAgfCAzNSArKysrKysrKysrKysrKw0KPiDCoGRyaXZlcnMvbmV0L2RzYS9tdjg4ZTZ4
eHgvY2hpcC5owqDCoCB8wqAgNSArKw0KPiDCoGRyaXZlcnMvbmV0L2RzYS9tdjg4ZTZ4eHgvc2Vy
ZGVzLmMgfCA3NiArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+IC0tDQo+IMKgZHJpdmVy
cy9uZXQvZHNhL212ODhlNnh4eC9zZXJkZXMuaCB8IDMzICsrKysrKysrKysrKysNCj4gwqA0IGZp
bGVzIGNoYW5nZWQsIDEzMyBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gDQoNCg0K
