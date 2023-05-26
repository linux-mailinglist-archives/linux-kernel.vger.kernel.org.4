Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C56712EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbjEZVcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjEZVcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:32:47 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D30BC;
        Fri, 26 May 2023 14:32:45 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QAjghH023517;
        Fri, 26 May 2023 16:32:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=PODMain02222019;
 bh=VVP7S1WiMC+Xh95vArXR/QxuJQduLRK7S/DOHga1Drk=;
 b=DgdT0dG7iRlJsR+/1x8Rl3lLLOWCO/Q+sC4lonQqMT7z1YeKF83GQi1eWTcOvWmJRIyU
 vwMxgxjvEWH39EBDqtlJYHw8PNgbwVGHpfaGaqsU7UQ1fpODV75CXPfHSVedQqHMMrLY
 +ZOPQAqR2MhV/jm3plZqqrVYwEj34ZMymqmkzr1pMX4YABjGip5+4tBp7i66pvxDv3Hi
 cPKPNPmZxVZ+1+9CBkEuX1YHUANXxw8F5grKd1JrIkJu8clQ15acZWtW/gJghYLxfwcO
 7qMB8lMx4QFPFguyzVLgxfz+WqOpw6pLk2CQl+iOn5qizMpMprWTbLl+G4lGoWSaWfmp OQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm93rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 16:32:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYuZMLHduBBqJRJodLX8H/lCekNIMY+pCGV9Rc3891ZL7b21yb7krxq3OhCRHb46QuuFLDUaOak2br5WQacb9BU3DkLNjV0tC62PcRpTFEU45r54I7wSENpAhjhxJUMLIgxWmPqQid50UNbsqmJL8KsRKy9ZsxfQU7LoCAyLMjUNle0/F8X8NfsAxxUncHkDC3yFrWRMTzoVMH+EUV9C5qMalaYyE8dIGZ4Nhcp8vgi7mrLOuu0GY+a0uRoFGSpzUWrlODzLf92K8uDyYJwpKK9wgOiXhJR83M3ZYArMZRXOWit3nxguM3mTdET9V1LA6mqDaQitqGUsC7D21sXhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVP7S1WiMC+Xh95vArXR/QxuJQduLRK7S/DOHga1Drk=;
 b=W3NO4E9P/u8vfd1ft32eLCC9m/ug6THVyIE11LlO+FeNnI2dsUz+cf3NleljQR5PskwoP/cBQeisvvGtqe/Z3LYbqh9S++Hs2id7UeymHdpcG2tVz+UbCUpJED4+NzhtizBQkXWdoRqUEdllqX6Az4etOGQSYcWrWUiLPis/k3jkjA9/GeFZtkM2Iu4Bruo7IKLrNZ3JzMpgKDhJTPZypz6Py1hv4TiUwOI/qK6TpLZn+GCZ19RhoiRJ0h0Y7NrXONav2eJ/4viHCAv8GiowPcUZI++xJeirJCB5xENuIDqyfpuOZxb6wS8aySHP+luuEEjORxHXd+XSdcVb2bff3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVP7S1WiMC+Xh95vArXR/QxuJQduLRK7S/DOHga1Drk=;
 b=advCh0x4Vh6HoOfAnEaCmfxuxALHTSTgPC8uuPPiEbABXmBcC55n9D8nuGjVPflnQVbYvyy6ICdrq7PDHAIGDC7ODD+YpvEgw+zZ0sHm2E5MoT14/SGaadKo3+6jD8Qc14F2cJIWSL3IPlQMBKaWNU/EuhdFKBmDBJzJjdEbZ0U=
Received: from SA0PR19MB4352.namprd19.prod.outlook.com (2603:10b6:806:8b::9)
 by MN0PR19MB5683.namprd19.prod.outlook.com (2603:10b6:208:372::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Fri, 26 May
 2023 21:32:36 +0000
Received: from SA0PR19MB4352.namprd19.prod.outlook.com
 ([fe80::ed08:afe9:48fe:6048]) by SA0PR19MB4352.namprd19.prod.outlook.com
 ([fe80::ed08:afe9:48fe:6048%6]) with mapi id 15.20.6455.012; Fri, 26 May 2023
 21:32:36 +0000
From:   Fred Treven <Fred.Treven@cirrus.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Ben Bright <Ben.Bright@cirrus.com>,
        James Ogletree <James.Ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: input: cirrus,cs40l26: Support for
 CS40L26
Thread-Topic: [PATCH v2 1/5] dt-bindings: input: cirrus,cs40l26: Support for
 CS40L26
Thread-Index: AQHZj2Wr57NT0J9dF0eyUcCSz6BeAK9s8WYAgAAi8AA=
Date:   Fri, 26 May 2023 21:32:36 +0000
Message-ID: <BBCD72CC-8312-4D57-9814-0E3A7F260F00@cirrus.com>
References: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
 <20230526-swapping-clay-d114144380a4@spud>
In-Reply-To: <20230526-swapping-clay-d114144380a4@spud>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR19MB4352:EE_|MN0PR19MB5683:EE_
x-ms-office365-filtering-correlation-id: 230f4298-8f3a-480f-75a2-08db5e30b980
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XN3f+b4Lu7yaI4RTi1JcQA+EVSnz1xSOaCpcSCNrqHQOl+lRG5gjwnPOfaowjiMQAsdeZuP0R9+uGIiaHFsdBPY+mnQOSqkvk/dNsx/4cewtx2jnc+P7HXarzg70AuiR+VrLPvowvbEPCM4WAS0TlMv1Mbl2u8y9DoRsD95nmIwZ/x4r4ipNN/5ZSMnxR78oDt9E/oGrTX90wQXWdi6d24YFIkpjIMgKGasnkh9rj2kzXxVN/AafC9/WLLK/FwfE8CdYfuUORGFU+yl1krCiNUvsNTt3O9FaY3gS4WhimmHZ5DhEs3PFJ1It50eI74iKZ7iZT8UJmZlnnAcIM9gQM3Ft7+Va3bak6ia8XoqmVRqq2eAF4wlkWE8FwvA7Mj4MQha/8RvNZrYKLWcTCKkEpKB309y86ve/ab+t7W73bJBmwUNqg9c7TalSvioCVy1nV4Tow/dNo+2G+tTXl74oTXCI09+D2yJ2Cfj2mpzcT3GKg4eA2zFvSZH0MgGaOs6HxKHt0qS1j1tfV5L1/LpEWW2b/Xk0cn/QgCHzJuB2qwPE5/zPmk8bj4OhyB6a/TUSctkDYW6CfpNjp7r3NC3wTUadURGDkThQMkE7WHmXkppazOsHEHpIt9p4d16CYeGYz6Y/SjwhwERqF6fhpjf46Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR19MB4352.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(376002)(39850400004)(451199021)(8936002)(5660300002)(122000001)(8676002)(36756003)(186003)(53546011)(33656002)(2616005)(2906002)(86362001)(83380400001)(38100700002)(38070700005)(6506007)(6512007)(84970400001)(54906003)(41300700001)(316002)(64756008)(66446008)(66946007)(66476007)(66556008)(71200400001)(6916009)(4326008)(76116006)(966005)(478600001)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEJwMEkrTjNvLzZKUXlieGxWSE5VUlRNTmNnOEd3M3RqMWNsVGVtTjJ4ejVz?=
 =?utf-8?B?LzhJSmkyN0drenhqK1ZrdGNLOGwxWDlid1oxRHFnSmppNnNHRTJTWG93NlF4?=
 =?utf-8?B?VFpTdVAxYVhTWlBKU3hwTGdGM1BsaUMzM2haQ3pxS21XcXQyK1JHR2xPK3FR?=
 =?utf-8?B?d2k4aVpDK05ydllzL29JdzNWK09aRytDdmhFYmFwT0ptMmJRR0NWNkxJaGpD?=
 =?utf-8?B?MVF5VzZpUFdqaE8veUFNZGJCT0UvR2RjTHBKWnYra25Od3ByQllIb3RsM3FR?=
 =?utf-8?B?ZWlKY3RYVkd4Q2FoNUEraVh4WTdVZy9XMWRkYkg1dWUvTTlNYStXdlpYOUo5?=
 =?utf-8?B?WjgxMHkycm5DTFNEUWtWWFNlWmNCQW5WSjJLeUwwZnRpNk9KcW4vaXAyaGM1?=
 =?utf-8?B?N2FteGwyUlY2WVArTDdwUTEzb2JuZlJTa3pLc2xtUjlmUW9ha2JVcnBvS2pP?=
 =?utf-8?B?Um1mQmFCeWM2Q2NqUE42ckpwSEh2bkJ0emxNeFA4cm11TXVuemhmVHV1cjV6?=
 =?utf-8?B?dGhnclY5UWFZRTZuaGJ6NzRmbU92QmU2L0RaRi9xS0dWRnVERitWN0ZuWjM0?=
 =?utf-8?B?dkE1Q21SeVJhTG5lN2hrVHUwNy9LN0k1ejlkSjhla2w5aFByY0hxOExMdlYr?=
 =?utf-8?B?b2N2b2FRT01qMUFKVkFXVm9GZGJJeXhndkg3d2N5ZEhmeVVMYURCQ0JTM0po?=
 =?utf-8?B?Wm5uZFlES1RPa3NHZEdERm9xTWFvQVV4SjUvZEtjRWlKWVBYaHBaS0FzYXBF?=
 =?utf-8?B?YnExbnVmRUowTk9VaTczL2RxcnkyYVU1S21rdnYweGFkeGhGdS9ULy8wV1Ry?=
 =?utf-8?B?V2RKZUtZdnZtMWtRKzl4aUhzN2NwVmRwdTEyL2dOMmtiVkYrZU5SWVBQbU5S?=
 =?utf-8?B?VGFkSHc4c1NIWWxDRUNJajc2ZVBwaFloZmRsZHJuZnNYcFcxY1p1MUViVzRP?=
 =?utf-8?B?dHFLWm9pQTJnYkNkUWlRRGk5aXBCWmZUV1UreERCVVVCQ1lLZURJTVpmYTBU?=
 =?utf-8?B?ZHEyZ29mcUZVbC9pOTR4YXZoUDRsS1NZUmRtQlQxYXY3VGZqakFmdzZTUmM4?=
 =?utf-8?B?SXVwYkdJSVhsdEZidElpby9qeEhZQ3FrZ1RuQXdtWXhocnhtV1ZudW00VGdm?=
 =?utf-8?B?MUh3YlQ2U3V3WUdxMWlJeUFmUGtpOEJuZjNRY1liWnExT2dGRWoxekYrWlk5?=
 =?utf-8?B?LzUyVVgrdTBpNVNPSTdsMml6UDhtRSt1eXNOZ29BcjVGalJUOUpid3gxcEtp?=
 =?utf-8?B?MStaa0NUK2FFOXlUOEw5ZVZaUFJZTTAwNmlReDVlcHpmSUY0ZnNjUTFWSlpR?=
 =?utf-8?B?ZDhGb0lzWG0zZTk3RFhtVjlNaFUzU1R6VU5pajljMEsvc1dCRG5DN3Z2SlNr?=
 =?utf-8?B?ZFNsMTFwUmlGdUNvTUZqK0xIdGxaVDN2Z3A5SnRCamN4TzhVZS93MStVTmFQ?=
 =?utf-8?B?TXRVbmRVcmRKRzZLVTgwKzVveFFTY2laejZIaDhVTjNJOHBYTFZtK2ZNNHRO?=
 =?utf-8?B?RXhWVUk3M3F5aitBV0pYakhPUldsMEcyZGFyNXFFekJNWitjelJ5WjltN1N6?=
 =?utf-8?B?Mnl5aHExcjdxZ2JmZWRCZzFMQ1J6dFMrN3NSb2JiLzl1NnQ4aEEyRm5Jbnk0?=
 =?utf-8?B?eHhueWtWZlJVMW93T3Njd1BQb0YwdzBmWlBpeC9HaFFCckN2TFJybW94ams0?=
 =?utf-8?B?VDA3ZEZvMWRuOHBzYVBGa3FVZ3FqNWpKeDY1M0p4VnlEemh4V0ZkMnpsQTd4?=
 =?utf-8?B?cDIvVEpZTFU4NS9EU2hEOUcrNXhaRWR2eGhQaHB1U3VQR09oVkpDMVMvdVV4?=
 =?utf-8?B?ekIyeldJSmdmbEx1bkwxQ2hHNFFHeXY1TmpRNWxtOC9hZUwxYmtVUldsV3gw?=
 =?utf-8?B?dHB2YTNpZGUrNzF4MWRvS1JDT1k5UkViQVdobTk2ckpSMmtndFNGRGFhWVB1?=
 =?utf-8?B?UFppeHhzYllGeU1IcFNMR3VrYmtkZFRSbjhvbkhta0lRcnBPZmFHSW45YVFR?=
 =?utf-8?B?dk1WaHlGZGNoN2V6QTVWS0hmbjZoazlkaUF4VlhwS2pCcWhQRnRROEJKakcv?=
 =?utf-8?B?ck1DTmE2RTlKOUNwSzNkeTZXVkljUkpNbVR1Mk9SRTVQWERhaVJNWS9xNVdi?=
 =?utf-8?B?ZkZBZXlVSFRqN0hYNDFQZjE1VFM1UnlneDA0VDVQTVBBN3RvdUQ3OHdvODJR?=
 =?utf-8?B?Um0xMnR5VUVnMUtmZzl6R2lGTmpRWHlqUU9sTUw3a3pyc0RqWUhBbGJRcW8v?=
 =?utf-8?B?UmxJNDJxWndmMkxUTlZZRDZxdEdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <379F8E2228E01E4BA8296BD9598E9960@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR19MB4352.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230f4298-8f3a-480f-75a2-08db5e30b980
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 21:32:36.6536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +EMPI2/dNsdtWd5HMIViiU2hXvOEVrJP+2/mT2bXUnLacrkmn4gftIWbEYYhjABokPGBqTtJz45BN4xYTefrdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5683
X-Proofpoint-ORIG-GUID: kaTFhkodBA4Pcpxh5PlMzrqkIT7EsOEN
X-Proofpoint-GUID: kaTFhkodBA4Pcpxh5PlMzrqkIT7EsOEN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBDb25vciwNCg0KPiBPbiBNYXkgMjYsIDIwMjMsIGF0IDI6MjcgUE0sIENvbm9yIERvb2xl
eSA8Y29ub3JAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBZbyBGcmVkLA0KPiANCj4gVG9vbGlu
ZyBkb2VzIG5vdCBsaWtlIHlvdXIgc2VyaWVzIHZlcnkgbXVjaCwgcHJvYiB0aGUgbWlzc2luZyB2
MidzIG9uDQo+IHNvbWUgcGF0Y2hlczoNCj4gR3JhYmJpbmcgdGhyZWFkIGZyb20gbG9yZS5rZXJu
ZWwub3JnL2FsbC8xNjg1MDU5NDcxLTk1OTgtMS1naXQtc2VuZC1lbWFpbC1mcmVkLnRyZXZlbiU0
MGNpcnJ1cy5jb20vdC5tYm94Lmd6DQo+IENoZWNraW5nIGZvciBuZXdlciByZXZpc2lvbnMNCj4g
R3JhYmJpbmcgc2VhcmNoIHJlc3VsdHMgZnJvbSBsb3JlLmtlcm5lbC5vcmcNCj4gQW5hbHl6aW5n
IDYgbWVzc2FnZXMgaW4gdGhlIHRocmVhZA0KPiBXaWxsIHVzZSB0aGUgbGF0ZXN0IHJldmlzaW9u
OiB2Mg0KPiBZb3UgY2FuIHBpY2sgb3RoZXIgcmV2aXNpb25zIHVzaW5nIHRoZSAtdk4gZmxhZw0K
PiBDaGVja2luZyBhdHRlc3RhdGlvbiBvbiBhbGwgbWVzc2FnZXMsIG1heSB0YWtlIGEgbW9tZW50
Li4uDQo+IC0tLQ0KPiAgIOKckyBbUEFUQ0ggdjIgMS81XSBkdC1iaW5kaW5nczogaW5wdXQ6IGNp
cnJ1cyxjczQwbDI2OiBTdXBwb3J0IGZvciBDUzQwTDI2DQo+ICAgICDinJMgU2lnbmVkOiBES0lN
L2NpcnJ1cy5jb20NCj4gICAgICsgU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5k
b29sZXlAbWljcm9jaGlwLmNvbT4NCj4gICDinJMgW1BBVENIIHYyIDIvNV0gSW5wdXQ6IGNzNDBs
MjYgLSBTdXBwb3J0IGZvciBDUzQwTDI2IEhhcHRpYyBEZXZpY2UNCj4gICAgIOKckyBTaWduZWQ6
IERLSU0vY2lycnVzLmNvbQ0KPiAgICAgKyBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNv
bm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiAgIEVSUk9SOiBtaXNzaW5nIFszLzVdIQ0KPiAg
IEVSUk9SOiBtaXNzaW5nIFs0LzVdIQ0KPiAgIEVSUk9SOiBtaXNzaW5nIFs1LzVdIQ0KDQpVbmRl
cnN0b29kLiBJIHdhcyB1bmNlcnRhaW4gaWYgdGhpcyB3YXMganVzdCBuZWVkZWQgZm9yIHBhdGNo
ZXMgdGhhdCBoYWQgYmVlbiBlZGl0ZWQgb3IgZm9yIGFsbCBuZXcgcGF0Y2hlcy4gSSB3aWxsIHJl
c3VibWl0IHdpdGggc29tZSBvdGhlciBjb2RlIGNoYW5nZXMgdG8gYWRkcmVzcyBvdGhlciBjb21t
ZW50cyBJ4oCZdmUgcmVjZWl2ZWQgYW5kIHdpbGwgbWFyayB0aGUgcGF0Y2hlcyB3aXRoIHRoZSBz
YW1lIHZlcnNpb24gbnVtYmVyLiANCg0KPiANCj4gT24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgMDc6
MDQ6MjdQTSAtMDUwMCwgRnJlZCBUcmV2ZW4gd3JvdGU6DQo+PiBJbnRyb2R1Y2UgcmVxdWlyZWQg
YmFzaWMgZGV2aWNldHJlZSBwYXJhbWV0ZXJzIGZvciB0aGUNCj4+IGluaXRpYWwgY29tbWl0IG9m
IENTNDBMMjYuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEZyZWQgVHJldmVuIDxmcmVkLnRyZXZl
bkBjaXJydXMuY29tPg0KPj4gLS0tDQo+PiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnB1dC9j
aXJydXMsY3M0MGwyNi55YW1sICB8IDEwMiArKysrKysrKysrKysrKysrKysrKysNCj4+IE1BSU5U
QUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEwICsrDQo+
PiAyIGZpbGVzIGNoYW5nZWQsIDExMiBpbnNlcnRpb25zKCspDQo+PiBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L2NpcnJ1cyxjczQwbDI2
LnlhbWwNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9pbnB1dC9jaXJydXMsY3M0MGwyNi55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2lucHV0L2NpcnJ1cyxjczQwbDI2LnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjljYmM5NjRlYmRlZA0KPj4gLS0tIC9kZXYvbnVs
bA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lucHV0L2NpcnJ1
cyxjczQwbDI2LnlhbWwNCj4+IEBAIC0wLDAgKzEsMTAyIEBADQo+PiArIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZQ0KPj4gKyVZQU1MIDEuMg0K
Pj4gKy0tLQ0KPj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaW5wdXQvY2ly
cnVzLGNzNDBsMjYueWFtbCMNCj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0
YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+ICsNCj4+ICt0aXRsZTogQ2lycnVzIExvZ2ljIENTNDBM
MjYgQm9vc3RlZCBIYXB0aWMgQW1wbGlmaWVyDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+PiAr
ICAtIEZyZWQgVHJldmVuIDxmcmVkLnRyZXZlbkBjaXJydXMuY29tPg0KPj4gKw0KPj4gK2Rlc2Ny
aXB0aW9uOg0KPj4gKyAgQ1M0MEwyNiBpcyBhIEJvb3N0ZWQgSGFwdGljIERyaXZlciB3aXRoIElu
dGVncmF0ZWQgRFNQIGFuZCBXYXZlZm9ybSBNZW1vcnkNCj4+ICsgIHdpdGggQWR2YW5jZWQgQ2xv
c2VkIExvb3AgQWxnb3JpdGhtcyBhbmQgTFJBIHByb3RlY3Rpb24NCj4+ICsNCj4+ICtwcm9wZXJ0
aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgZW51bToNCj4+ICsgICAgICAtIGNpcnJ1
cyxjczQwbDI2YQ0KPj4gKyAgICAgIC0gY2lycnVzLGNzNDBsMjZiDQo+PiArICAgICAgLSBjaXJy
dXMsY3M0MGwyN2ENCj4+ICsgICAgICAtIGNpcnJ1cyxjczQwbDI3Yg0KPiANCj4gSSBoYWQgYSBf
YnJpZWZfIGxvb2sgYXQgdGhlIGRyaXZlciAtIHlvdSBkb24ndCBzZWVtIHRvIGhhdmUgYW55IG1h
dGNoDQo+IGRhdGEsIHNvIGFyZSBhbGwgb2YgdGhlc2UgZGV2aWNlcyBhY3R1YWxseSBjb21wYXRp
YmxlIHdpdGggZWFjaG90aGVyPw0KPiANCj4gSU9XLCBzaG91bGQgdGhpcyBiZToNCj4gcHJvcGVy
dGllczoNCj4gIGNvbXBhdGlibGU6DQo+ICAgIG9uZU9mOg0KPiAgICAgIC0gaXRlbXM6DQo+ICAg
ICAgICAgIC0gZW51bToNCj4gICAgICAgICAgICAgIC0gY2lycnVzLGNzNDBsMjZiDQo+ICAgICAg
ICAgICAgICAtIGNpcnJ1cyxjczQwbDI3YQ0KPiAgICAgICAgICAgICAgLSBjaXJydXMsY3M0MGwy
N2INCj4gICAgICAgICAgLSBjb25zdDogY2lycnVzLGNzNDBsMjZhDQo+IA0KPiAgICAgIC0gY29u
c3Q6IGNpcnJ1cyxjczQwbDI2YQ0KPiANCj4gQW5kIHRoZW4gZHJvcCBhbGwgYnV0IHRoZSBjczQw
bDI2YSBpbiB0aGUgZHJpdmVyPyBBcG9sb2dpZXMgaWYgSSBtaXNzZWQNCj4gc29tZSBkaWZmZXJl
bmNlIGluIHRoZXJlLg0KDQpUaGV5IGFyZSBhbGwgY29tcGF0aWJsZSwgeWVzLiBUaGVyZSBpcyBt
YXRjaCBkYXRhIGluIGNzNDBsMjYtaTJjLmMgYW5kIGNzNDBsMjYtc3BpLmMgaWYgeW91IGFyZSBy
ZWZlcnJpbmcgdG8gdGhlIG9mX2RldmljZV9pZCBzdHJ1Y3QuIFBsZWFzZSBsZXQgbWUga25vdyBp
ZiBJ4oCZbSBtaXN1bmRlcnN0YW5kaW5nIHlvdXIgbWVhbmluZyBoZXJlLg0KDQo+IA0KPj4gKw0K
Pj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgaW50ZXJydXB0czoN
Cj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIHJlc2V0LWdwaW9zOg0KPj4gKyAgICBt
YXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgVkEtc3VwcGx5Og0KPj4gKyAgICBkZXNjcmlwdGlvbjog
UmVndWxhdG9yIGZvciBWQSBhbmFsb2cgdm9sdGFnZQ0KPj4gKw0KPj4gKyAgVlAtc3VwcGx5Og0K
Pj4gKyAgICBkZXNjcmlwdGlvbjogUmVndWxhdG9yIGZvciBWUCBwZWFrIHZvbHRhZ2UNCj4+ICsN
Cj4+ICsgIGNpcnJ1cyxic3QtaXBrLW1pY3JvYW1wOg0KPiANCj4gQXJlIHRoZXNlIG5hbWluZ3Mg
cmlwcGVkIGZyb20gYSBkYXRhc2hlZXQ/ICJic3QtaXBrIiBkb2Vzbid0IGltbWVkaWF0ZWx5DQo+
IG1lYW4gYW55dGhpbmcgdG8gbWUsIGJ1dCBJIGFtIG5vdCBmYW1pbGlhciB3aXRoIHRoZXNlIGRl
dmljZXMuDQoNClllcywgdGhleSBhcmUgdGFrZW4gZnJvbSB0aGUgZGF0YSBzaGVldCB3aXRoIOKA
nGJzdC1pcGvigJ0gcmVmZXJyaW5nIHRvIGJvb3N0IGluZHVjdG9yIHBlYWsgY3VycmVudCBjb25z
dW1wdGlvbi4gSSBkbyB0aGluayBpdCBtYWtlcyBzZW5zZSB0byBoYXZlIGNsZWFyZXIgbmFtaW5n
IGhlcmUgc28gSSBjYW4gZ28gYWhlYWQgYW5kIG1ha2UgdGhlc2UgY2hhbmdlcy4NCg0KPiANCj4+
ICsgICAgZGVzY3JpcHRpb246DQo+PiArICAgICAgTWF4aW11bSBhbW91bnQgb2YgY3VycmVudCB0
aGF0IGNhbiBiZSBkcmF3biBieSB0aGUgZGV2aWNlJ3MgYm9vc3QgY29udmVydGVyLg0KPj4gKyAg
ICBtdWx0aXBsZU9mOiA1MDAwMA0KPj4gKyAgICBtaW5pbXVtOiAxNjAwMDAwDQo+PiArICAgIG1h
eGltdW06IDQ4MDAwMDANCj4+ICsgICAgZGVmYXVsdDogNDUwMDAwMA0KPj4gKw0KPj4gKyAgY2ly
cnVzLGJzdC1jdGwtbWljcm92b2x0Og0KPiANCj4gRGl0dG8gaGVyZS4gSWYgdGhlcmUgYXJlbid0
IHJpcHMsIHRoZW4gbWF5YmUgaXQnZCBiZSBhIGdvb2QgaWRlYSB0byB1c2UNCj4gZnVsbCB3b3Jk
cy4NCg0KU2FtZSBhcyBhYm92ZS4gSXMgcmlwcGVkIGZyb20gRFMsIGJ1dCBkb2VzbuKAmXQgbmVl
ZCB0byBiZSBjYWxsZWQgdGhpcyBpZiBpdOKAmXMgbm90IGFwcHJvcHJpYXRlCQ0KDQo+IA0KPj4g
KyAgICBkZXNjcmlwdGlvbjoNCj4+ICsgICAgICBEaXNhYmxlIGJvb3N0IGV4cGxvcmF0b3J5IG1v
ZGUuDQo+PiArDQo+PiArICAgICAgSW4gZXhwbG9yYXRvcnkgbW9kZSB0aGUgYW5hbG9nIG1heGlt
dW0gcGVhayBjdXJyZW50IGxpbWl0IG9mIDQuNSBBDQo+PiArICAgICAgKHRvbGVyYW5jZSBvZiAr
IDE2MCBtQSkgd2lsbCBiZSBhcHBsaWVkLiBUaGlzIGlzIHJlcXVpcmVkIGZvciB0aGUNCj4+ICsg
ICAgICBkZXZpY2UgdG8gc3VjY2Vzc2Z1bGx5IGRldGVjdCBhIGJvb3N0IGluZHVjdG9yIHNob3J0
Lg0KPj4gKw0KPj4gKyAgICAgIEJvb3N0IGV4cGxvcmF0b3J5IG1vZGUgYWxsb3dzIHRoZSBkZXZp
Y2UgdG8gb3ZlcnNob290IHRoZSBzZXQgYm9vc3QgcGVhaw0KPj4gKyAgICAgIGN1cnJlbnQgbGlt
aXQgKGkuZS4gaWYgY3VycmVudCBwZWFrIGxpbWl0IGlzIHNldCB0byAyLjUgQSB0byBwcm90ZWN0
IHRoZQ0KPj4gKyAgICAgIGJhdHRlcnkgaW5kdWN0b3IsIHRoZSBjdXJyZW50IGxpbWl0IHdpbGwg
YmUgb3BlbmVkIHVwIHRvIDQuNSBBIGZvcg0KPj4gKyAgICAgIHNldmVyYWwgbWlsbGlzZWNvbmRz
IGF0IGJvb3N0IHN0YXJ0dXApLg0KPj4gKyAgICAgIFRoaXMgaGFzIHBvdGVudGlhbCB0byBkYW1h
Z2UgdGhlIGJvb3N0IGluZHVjdG9yLg0KPj4gKw0KPj4gKyAgICAgIERpc2FibGluZyB0aGlzIG1v
ZGUgd2lsbCBwcmV2ZW50IHRoaXMgZnJvbSBoYXBwZW5pbmc7IGl0IHdpbGwgYWxzbw0KPj4gKyAg
ICAgIHByZXZlbnQgdGhlIGRldmljZSBmcm9tIGRldGVjdGluZyBib29zdCBpbmR1Y3RvciBzaG9y
dCBlcnJvcnMuDQo+PiArICAgIHR5cGU6IGJvb2xlYW4NCj4+ICsNCj4+ICtyZXF1aXJlZDoNCj4+
ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSByZWcNCj4+ICsgIC0gaW50ZXJydXB0cw0KPj4gKyAg
LSByZXNldC1ncGlvcw0KPj4gKw0KPj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPj4g
Kw0KPj4gK2V4YW1wbGVzOg0KPj4gKyAgLSB8DQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9ncGlvL2dwaW8uaD4NCj4+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2lucHV0L2lucHV0
Lmg+DQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9p
cnEuaD4NCj4+ICsNCj4+ICsgICAgaTJjIHsNCj4+ICsgICAgICAjYWRkcmVzcy1jZWxscyA9IDwx
PjsNCj4+ICsgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4+ICsNCj4+ICsgICAgICBjczQwbDI2
QDU4IHsNCj4gDQo+IEdlbmVyYWxseSB1c2luZyBnZW5lcmljIG5vZGUgbmFtZXMgd2hhdCB3ZSB3
YW50LCBzbyBzb21ldGhpbmcgbWF0Y2hpbmcNCj4gdGhlIGNsYXNzIG9mIGRldmljZS4gU2VjdGlv
biAyLjIuMiAiR2VuZXJpYyBOYW1lcyBSZWNvbW1lbmRhdGlvbiIgb2YgdGhlDQo+IGR0IHNwZWMg
Y29udGFpbnMgYSBidW5jaCBvZiBvbmVzIHRvIHBpY2sgZnJvbSwgYnV0IEkgZG9uJ3QgcmVhbGx5
IGtub3cNCj4gd2hlcmUgImhhcHRpYyBhbXBsaWZpZXIiIGZpdHMgaW4hDQo+IA0KPiBDaGVlcnMs
DQo+IENvbm9yLg0KDQpVbmRlcnN0b29kLiBJ4oCZbGwgdHJ5IHRvIGZpbmQgYSBiZXR0ZXIgd2F5
IHRvIG5hbWUgdGhlIG5vZGUuDQoNCkJlc3QgcmVnYXJkcywNCkZyZWQNCg0KDQo=
