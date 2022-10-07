Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AD85F7649
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJGJbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJGJbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:31:44 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2063.outbound.protection.outlook.com [40.107.255.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A93CF840;
        Fri,  7 Oct 2022 02:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tk2PsVA7uz/lby4BnSnl/kYfTIKLdj/ci4nyIbQeddvAOaZUDEhjuFiJcgfbWtev5mqXbVwHk7st5ZocySGhImtp4NAmDEV6q/ihdcElt3WHtSlKFqYCnoYw7Jfsk0PPVjMt1aZ0qaKrQ2lmVt3iHq0D+fJUuiJb7S0TNQPKrqtWZqjGw+MpyVzCuUsq0inMrfPeGJga3Vlia0o65jEPA1NIgjuwKpeZK0dAmYH0oiRTq2cgpNQT7yZXlZpCg8iPfHywFkN3P88KNm3B0R92G6MsnbDuuIPD0ifmc+HWNiy/sJDvJ4dTxUJReGtxftvVWtCDWAGTM7ohq8G4UCfgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmB4OeQg1ImbqRQSX88ChtnVxextJNiAgbPFnZQXIk0=;
 b=k6umHoW/+RET595tyk2kbuHGjmJmvAw8z/HH62fLbHT66/MPaaZ7KYq//M93z22fQlOIXqJyh9rRrC+8uf3DcPmikMcWvQiRiiqaBWkkyDqs4b2nWYkm/Kd31mxao6KdhmrQWQ63YDJw2frroW2VIigtyP1pwAM83OtO0NQug0OoWc+58WDH9QkuN0o2k+EqjIlgWddiCuJu7bJvhNMH+WQXHgbiiXiE2v7dcOuHXzavryUGgI+NHw52IP8sJH+1qRVCShdwkEM8cNz844BLXz/K4VAwWrOkIvqMbmI/sg2lYknTTezvPYoaKwmEjqbuQJH8+W1MRgXDv3F40gud5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmB4OeQg1ImbqRQSX88ChtnVxextJNiAgbPFnZQXIk0=;
 b=fUVJnzUNHKRpMcjHvWAIFVPOZuGDBB0mM6i5lv6fwGuqgCxoucoOIBD3snXWz+8CbmW/sxR6f+kO5x7vCyrPfSf0lkM27pX+2aV0I0LB9N337CY/6YkyOBJ4UO0+Be28zMkQ4jruhiwFfVEfBHPXf9yTvMYfk9TcxVUsosXrKLvxzoQWzdsbCsjQt9tvm9CIfaExKZyyjhPSFkDOKb1z1CYhwEULr8EicZyHpZtNcMgyRrMtnquORTv/JDAb9e938npXwAuBEDSPgQDUMBDYbI7jxT+8GDRIi2g5PeoDgWxytkwddsvXs3/hHxDrjwfp3RiDPngGCo+ZYw4RneUDHQ==
Received: from HKAPR04MB4018.apcprd04.prod.outlook.com (2603:1096:203:c6::11)
 by SEYPR04MB6482.apcprd04.prod.outlook.com (2603:1096:101:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 09:31:39 +0000
Received: from HKAPR04MB4018.apcprd04.prod.outlook.com
 ([fe80::2ab7:4032:77f9:2d39]) by HKAPR04MB4018.apcprd04.prod.outlook.com
 ([fe80::2ab7:4032:77f9:2d39%5]) with mapi id 15.20.5676.038; Fri, 7 Oct 2022
 09:31:39 +0000
From:   Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>,
        "krzysztof.kozlowski@linaro.or" <krzysztof.kozlowski@linaro.or>
CC:     "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        "garnermic@fb.com" <garnermic@fb.com>,
        Bonnie Lo/WYHQ/Wiwynn <Bonnie_Lo@wiwynn.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
Thread-Topic: [PATCH v2] greatlakes: dts: Add Facebook greatlakes (AST2600)
 BMC
Thread-Index: AQHY2hCwZVB1aZVxPE65pMzhMF1p5K4Cgv4AgAAlIJA=
Date:   Fri, 7 Oct 2022 09:31:39 +0000
Message-ID: <HKAPR04MB40186502618E77D9B43FD740835F9@HKAPR04MB4018.apcprd04.prod.outlook.com>
References: <20221007055008.3468691-1-Delphine_CC_Chiu@Wiwynn.com>
 <398470cd-7f2c-28eb-fc13-54ae5d5bc256@linaro.org>
In-Reply-To: <398470cd-7f2c-28eb-fc13-54ae5d5bc256@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HKAPR04MB4018:EE_|SEYPR04MB6482:EE_
x-ms-office365-filtering-correlation-id: 2e8def25-b898-4457-874b-08daa846bcdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cPVi5NdLn3bVyQN3aXqpe/f2v2S8PWN234f5ve27UbM2q85bOKZA5Zt2M78fTHDXF6pAOqMYVfDmEYrkfqks1cLBF/exJ0hbfLi9OyPEIYJeGy+3EXplOaQtvifSq3Kx1pEkb2R22Tb+HfTR/dskdwuVX+T9F5LEf0bSgC2VKI27+nPuRPutkeIShUDu5Pr6zPIgZKC+Hsxc2tZsTZzvu01D4t1QjxIGqi18D/5eygEOjbA32jkbwIYw2WX/ANaZooXDD8CVaQ4zcltuqfcixQccyMZsFzLXXOqg9a+mkhNA0Xo6z1ttkXNjby4EPsSot8Zz4S3KRYlD2YgDd6OhMLknNkLFyWXfgLyuT/iQz/g2myFrUksB8wM3VD9QOWW4vl+i5Pm7b69EN5axaANq/Z9JH6ZMlPmMx7Nio7v+IbmSgkTjj8EFC3FYjr0lkLw4NO1fXIRURqsl3CcdGMpYURKYd6hZS8VcbIeB//k/uWsWgNyGXJpBw6fL7Dgtz9hNSKwuHVyJsNXQCyuYT/VRcV1I/Ge+xFXh9CkExxcRRvigVWqzuGZNH4OZezkNdSccQ0KN5je/BOjEi5yGRevvf7+9ExsiOVpHgZx+EghzgbA55jIaK0Pi032UiFQV1EOARq0e3W+fmaJdypkptLoQ4xKpo6WMZpX6uX6RQgldOTI1S+0bzT7rVvwEbg0oYoVIW4jr10pvCIAmzmiZi0A+Q2NA/ZjacpEZOHHxcmP9HftzryBPEizFUkjG2uDkrmdotO9/DaEzb50asTi2JZwAqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR04MB4018.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(47680400002)(451199015)(41300700001)(6506007)(478600001)(83380400001)(53546011)(2906002)(110136005)(186003)(7696005)(38070700005)(8676002)(52536014)(66556008)(86362001)(26005)(66946007)(122000001)(4744005)(4326008)(64756008)(66446008)(66476007)(76116006)(316002)(7416002)(8936002)(9686003)(71200400001)(54906003)(33656002)(5660300002)(55016003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUQyQVR2S05zM2YxRnlHV1lneWp5cDFyRkJIVElVMXorcjNmdk9kTUtpanZv?=
 =?utf-8?B?TkNFOTY0SXNmVjYxSlFsKzk0Z0w0Vm8zbmJZdmtZQ0FTeDU3RjlKUkk0RDRY?=
 =?utf-8?B?amFTSzYxYytDd2MwVlVuNjNvWk9uMnNqUFpiQjFGSS9sU2N6TGtYSWRKOU1t?=
 =?utf-8?B?RHp6clNsU2hmMEc4NmU2UWJqa081cmZjUEVJYkJWd0NNWUxoSDl4ZlJQUHh0?=
 =?utf-8?B?TXppNGs5L00rbEswQlk0eDdYWEZUckdNM25oei9wQnIrUU4wZzFCdHZSWnBB?=
 =?utf-8?B?UjhoMjUxeUtSTmU1NEJ3RTFoWitla2JicHBubWl3NW55ZktRK0tiOXdKM0xl?=
 =?utf-8?B?ZlU0N1hETmxBVGNqUWUwWVB6bDFlVEIzZDZxUFpNSVV5Y0Z1OGc0eVpsbHo1?=
 =?utf-8?B?d1l2Z0I5SHZXWFdaZTEyYUhpN1VYZWdFenBEV3V2ekEyZUg2KzFaNEJyZnJx?=
 =?utf-8?B?WWtOcmFacDN3Z2YvK014SzJzNE1iSGg0UWk5VkFNeUpML1ZFSGRnd1p5RWxH?=
 =?utf-8?B?TVVYTTJGYmlZa0dQVFhjUm9yZ2cwS2ZLZjRqWFJBdFVBTWE1aE1BcFMrdFhV?=
 =?utf-8?B?WlpEcGNsUXhuWE1TYWxRUjg4U3hHcDAzQjdLRDlvbEY5S2ltMWthTnFvOWM2?=
 =?utf-8?B?RTJlOGZrVHA2M3BOdU5hbFdqZUZ6S25lMVYxTVVYZWs3MUNOSXVCV01oN3Jh?=
 =?utf-8?B?RVZ2ZXNrakhCdDhGd0JVdk1MMlZYditqNEhsNFVnV05LR0JxNzlqTUF2dXhY?=
 =?utf-8?B?bFRRSjFEOUlhMGNxeURvYXZwRHpWMmNKYXAzZzVLa0xHd0FzMi85NndsNUZq?=
 =?utf-8?B?ODFPOU14a2ZrRzlRT3FXVFgzQ0FlMDF1YzFHa1pmQm8yTnFyVElFaG1OK2Z1?=
 =?utf-8?B?MkpjV1UzeEpGZWwyTFEvek5PbGRQanlEaU9VN1RlQ21JMzVNYnljK0RVbjFP?=
 =?utf-8?B?cG1PbzRQVU8rdjRrSWc4Nk1HR2dGT1dpanNBbHozYjFsUkxlVStVVEdjM25z?=
 =?utf-8?B?bThjU3dyMWNLWVdsTVpyamRydmZONS9ZV2V6czdyMjBremRaVUtCSkpYa0hN?=
 =?utf-8?B?cXlHVnUzSklBSmo1MHpScnJnbFJnZmNpbnI4SndpVVdyMEpmbDhhNVhwZUVh?=
 =?utf-8?B?OXdWWFJGMXUxNHM4cVRXSTB1TCtwVWRkMUVhUGNDTGl2MDRoMHRKMHB3M2No?=
 =?utf-8?B?TEsyOU5qZFBZYyttTkl3TU9MQThaQ1NRRnhCelVOb1gwNCthR0lHTEMrcFVZ?=
 =?utf-8?B?NFFkN1B0SThEM240VWh6a0t3MndOZWdFZ1g0N3pMRmI5M2QzVFRhakkzMnE3?=
 =?utf-8?B?YkJXUnptWE5ySFNrUy91OEtUbWVCUmMrbUcveERWRzJsNVVtSmV5KzJLQVlU?=
 =?utf-8?B?RVhKSXlFODF5YmYxS25qZi8vdHE2WlFuWEpDdEpvR2RJNUVGdTN4Zk95aWV6?=
 =?utf-8?B?RmMwODlRS3ZBaHhraVFVWXg3cU1zQUxUYTF3NFZUMkxLV21saFYzSCtPZmZn?=
 =?utf-8?B?dXI2VkdRNjB2WUFMMzZPZjM4dGEzQXBBUkI2b0xBdkV4cjEwZ2hPV0M4RUY1?=
 =?utf-8?B?OHBkK1lWN2hZY1NMZFpENXFKbU9GelRSV2dHR3YzblNvT0RzTTIzbldleXEy?=
 =?utf-8?B?dThrZU1HUjdQNjBDdDNSeGxWMHRMLzgzd0ttQ3N2VkhxV3hpRXgrekFJV3Fm?=
 =?utf-8?B?VWZScDlWTlpra2NPYWxmNmdvNFBCSE00WFgzV1M1SEJiRDlib01xVlBWZkhH?=
 =?utf-8?B?SjJFQmlnU3FZb01pU2pCdzVIcUN1Kzc1dW5rSy9uNk45OG4yV2F5MG1ETDVO?=
 =?utf-8?B?ZDdkMFp5OXhIVHdnL1NXMWh3VlFDWWpmcHhRdlBaSUVCVmxWY1JFay93enVv?=
 =?utf-8?B?enZCS3NtUWRKYnZDUUs2bWpxU1pFTWdPbVhvUGszOXdqWks4ZnVpRXJuZFpk?=
 =?utf-8?B?Q09xNjB4SXZ1WVRLelBiTWR6eXBqbXV4b0htckZnQ1lKaXRhNDdmaXdLVjBq?=
 =?utf-8?B?cTVNS2NsaWNLNGVHTVBPU2EzZ1BWYkpnWmZDTHRCSXErMEZidGlVQWpyS1lW?=
 =?utf-8?B?a0pIOTl5WFNaWklIMGQ3L0lJTHdXbW5vT2lDUEdIc1d1L3c3T1lYRXZrVVAy?=
 =?utf-8?Q?CyeUkluxxNOsrbSqcFc4r64Oh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HKAPR04MB4018.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8def25-b898-4457-874b-08daa846bcdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 09:31:39.5689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XT5xtN3yaanWCB43VpeihKVM9mdV4h5tC+nTtbTLZnLawNmzoDN80hPeYipQlvLv8leIa7LGty/HrH/so5LgHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6482
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBncmVhdGxha2VzOiBkdHM6IEFkZCBGYWNlYm9vayBn
cmVhdGxha2VzIChBU1QyNjAwKSBCTUMNCj4gDQo+ICAgU2VjdXJpdHkgUmVtaW5kZXI6IFBsZWFz
ZSBiZSBhd2FyZSB0aGF0IHRoaXMgZW1haWwgaXMgc2VudCBieSBhbiBleHRlcm5hbA0KPiBzZW5k
ZXIuDQo+IA0KPiBPbiAwNy8xMC8yMDIyIDA3OjUwLCBEZWxwaGluZSBDQyBDaGl1IHdyb3RlOg0K
PiA+IERvY3VtZW50IHRoZSBuZXcgY29tcGF0aWJsZXMgdXNlZCBvbiBGYWNlYm9vayBHcmVhdGxh
a2VzDQo+ID4NCj4gPiAtLS0NCj4gPiAtLS0gdjIgLSBBZGQgYmluZGluZyBkb2N1bWVudA0KPiA+
IC0tLQ0KPiA+IC0tLSB2MSAtIEluaXRpYWwgZHJhZnQNCj4gDQo+ID8/Pz8NCj4gDQo+IFRoYXQn
cyBub3QgaG93IHBhdGNoZXMgYXJlIHNlbnQuLi4gQWJvdXQgdGhpcyBJIGNvbW1lbnRlZCBhbmQg
eW91IGlnbm9yZWQuDQo+IA0KPiBUaGlzIHBhdGNoIHdhcyBhIHBhcnQgb2YgYSBwYXRjaHNldCwg
c28gZG9uJ3Qgc2VuZCBpdCBzZXBhcmF0ZWx5Lg0KPiANCj4gVGhlIHN1YmplY3QgaXMgbm93IGNv
cnJ1cHRlZCAtIGVudGlyZWx5IHdyb25nLg0KDQpDb3VsZCB5b3UgcGxlYXNlIGd1aWRlIHVzIHRv
IGNvbnRyaWJ1dGU/DQpbUEFUQ0ggdjQgMS8yXSBncmVhdGxha2VzOiBkdHM6IEFkZCBGYWNlYm9v
ayBncmVhdGxha2VzIChBU1QyNjAwKSBCTUMNCi0tPiBUaGlzIGlzIGZvciBiaW5kaW5nIGRvY3Vt
ZW50Lg0KW1BBVENIIHY0IDIvMl0gZ3JlYXRsYWtlczogZHRzOiBBZGQgRmFjZWJvb2sgZ3JlYXRs
YWtlcyAoQVNUMjYwMCkgQk1DDQotLT4gVGhpcyBpcyBmb3IgZ3JlYXRsYWtlcyBEVFMuDQpJcyB0
aGlzIGNvcnJlY3Q/DQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
