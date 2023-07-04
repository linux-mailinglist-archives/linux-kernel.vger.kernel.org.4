Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C277746961
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjGDGLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGDGLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:11:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF61A6;
        Mon,  3 Jul 2023 23:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ3NcLOclAhFqlmynb0ErAGovnEz5nhTR3bhl0jajWJgdPkK+MGI98og0xgIkK+3oP8rJG4ID0sszZ8vONn56E3NpcOS2gWHDUHgrl6VvR8TvPAt/pH1ZZX665E5J/12PhdL8OqniQTCApTeIalGCAto0R1Txk3DMBMCM2qGBKrPC3JGiL23pAlatLsX4kb43tHBqGpf9ar4rnQDNjcrPNOzm/75TTGNAqf5e0eWbx5QSAVrfbbGkZlZgaxcYegTC5wiVuqumnHtc16Iuij9LOCZ3efQGingCY2V1G3hdrTNHwHbdEaNlflBdJwhMeXbjNf3uYNYkp49vPbd1+kcFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgSayfIi0XOpL/tp/fviZqw2Vm65G7L35SQcWy//K0Q=;
 b=nxLBzhwHRhKfI31i2JE1AugevlaXdJsRnFoJoCDWwVoV0VPHzuJ/7FWt+iDixprl1RLFRwdFGWFhCchaDmKEYdZw4dzSmXo0G3mkt8fGeimXD4hqCc6RxAPjjv5N/iRuAUFKBOSOk4vza8zNU6cw6ma4WMRRcD1PAckI6HWFf2HqhFCNmndPuLaLAeTZ1OktLyeHQeYAsnLNDFvReRo+xvJlR04jZ0zT/+Gih0Z919M825lC1ICKwjpsdzcqwhgfcAtSxfqSRWJkWMNiAbwQcAXlxeMm1edLqotxBTzvfc9/v1vg221Xf/tC9mEBA6KuMhCNsB80PkqOi4ImRlgNKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgSayfIi0XOpL/tp/fviZqw2Vm65G7L35SQcWy//K0Q=;
 b=ihVYZA4DmmPRaqSctlWb3RYwFLuP7a3P/LMBpEK8amAhT7xSqTUZ5xsJ3Jhur1hyHa50cRjJjT3SBqKRNxHCuv4cAGO7iEUhefyIcinAJSJx2iECIp3NGie6RsDJ/un86OBhqHn9kGfyjeBjKjjlLX0o0BChSpjWCEoDsF3WSHTiSpOcuoyu52e5S0Qlx1chCaJQydhb+LlAtMJN07D+KDNKprkfbscmKjshtxx+n2ltVesLKyErBRixd+K77iQ8qSVkJOn98WmIBjsnAmCdOjlH893PbGk5/of9e9shkJDodLDkRxDWGptNNCrhA+kZgjb98ywPDYY4JFZN6pxFRQ==
Received: from DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46::26)
 by GV2PR10MB6720.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 06:11:26 +0000
Received: from DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a270:2154:bf88:4c9e]) by DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a270:2154:bf88:4c9e%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 06:11:26 +0000
From:   "Haener, Michael" <michael.haener@siemens.com>
To:     "andrew@lunn.ch" <andrew@lunn.ch>
CC:     "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>
Subject: Re: [PATCH 0/3] net: dsa: SERDES support for mv88e632x family
Thread-Topic: [PATCH 0/3] net: dsa: SERDES support for mv88e632x family
Thread-Index: AQHZrcK5o5p4yOCGu06Um/M2KTNRoa+oLUeAgADz7IA=
Date:   Tue, 4 Jul 2023 06:11:26 +0000
Message-ID: <3322f0995be4b49bcc349d7a58ec9114fca6c3f9.camel@siemens.com>
References: <20230703152611.420381-1-michael.haener@siemens.com>
         <3664909e-a259-4bca-be53-5bab43e23dbc@lunn.ch>
In-Reply-To: <3664909e-a259-4bca-be53-5bab43e23dbc@lunn.ch>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR10MB2506:EE_|GV2PR10MB6720:EE_
x-ms-office365-filtering-correlation-id: c9c7072a-04a9-4622-be03-08db7c557ff3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uOSoOM1ThMNuKJvgj2wEUqna7sVHJv7djzlUI2Tx5X0BbWaL3TVl9Kphj+I3XfWzDHsWaNLb9jbVAJW+KsXwilLiGZhFlNHJKuKZZOsrfYmaZgmXuPxXSTzQDRJZmAbYJjWiI/LSn3qA0wZHJO/UXALDwJ4qeidxZM5MNYhR/ENy039COP7pWliSY4oeYTvfdkk2029qlWXOhZ9JAuHuSD5on6McsmpGmZypcepPz5CinpWc48TekSZmb8Ay3OLF9C5tBiBKWSEPXc7hx+CMPnHyxijiMYV1hmfxqETz1hAm2obROk9t73T0G+iK43iKs3yepQcQYkvZ1QFRJOxxbSNsRThRnxiI4H47ng5otG0VR7O/0uRAoVIpHff9SgIcrPXqkx5Ma4+BJFetKZ62svfjXdQvVMdlubd8bjTcmEByNi2RiEnxll2HmStWEZHwg4ZSu6piu/owAcouXxJh6Kdrpfsp0tMzExOshxyl6Z+HZ96jio1JOQXQbu9DwGHAngTsSi6arkandZRwLY8issoKadXmr7T5j4RWc+aeQhH3MUhnlCoKOAfCcOfk6TBMRot+VFnz3Wt/17sC4d9zCyIVYKrEPpt3rZ/+t/5j6JSdppD1yw2KpxuWR/ze577+jReISXQdJMxE/bgaqmKtaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(1590799018)(451199021)(4744005)(2906002)(41300700001)(5660300002)(7416002)(38070700005)(1580799015)(8676002)(36756003)(85202003)(85182001)(8936002)(86362001)(6512007)(966005)(6486002)(45080400002)(478600001)(71200400001)(83380400001)(186003)(26005)(2616005)(66476007)(64756008)(91956017)(66446008)(76116006)(66556008)(6506007)(4326008)(54906003)(6916009)(122000001)(82960400001)(66946007)(316002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3pOVk1TZ3U2OHZDc2dJVzF3eWMreHFCa0dobXdqMGlPM3lXbzhpM1hPYTJB?=
 =?utf-8?B?NzNySGVCMEQzQ2Z1ZVU1bk02WFYvRThjYktVQTA4TEtnMUkwQ1IvRU1mOFhM?=
 =?utf-8?B?dGpNNVNRZWJlOUlBZFh1NUJyR1lWaHhUTFQvQ0FvWnp6VXV6UmtMOGNmNjRK?=
 =?utf-8?B?SWoyMzd1QnlLaTU3Nm9FYVBFd1NBa2c1TTZJNzEwQ3VZamYrU3RKTEZmYlEr?=
 =?utf-8?B?bVlpQVN0VktYa3FOSkEyZXpQc3FhZURHaDUxY2VZMmdzNDhhc3k3cCs0cU5a?=
 =?utf-8?B?RVFER29ybnpwWUltN2Z3cTFpSk5McFVyMTMrMHlVeFMzWFBYTFJTV3JmOWt3?=
 =?utf-8?B?bVJ2T2kvMTE4RC9EUE9qV2NwN1NJN243ditkWjJtK1ArRVB5U1prV0YvUnhI?=
 =?utf-8?B?TFJEbU9pMGJvTEo3MTZzR01UMTFxRCtlWm5aNjZhTFhzTnNsR05ZY3FSV2w2?=
 =?utf-8?B?WDJIR01tdlpkUlE5a0xycFhZaWdSdGxNK3RPdWRVTThqYUZnTzdNUXpkall2?=
 =?utf-8?B?bTNpYXZKczloeHZuUytrWU42RUVCSEdFVDZYVTRKU1BMcndSTDRUTDlmcVE0?=
 =?utf-8?B?c2xLTVF3cDhNTGpBVGVucnJWbU4zVTQvQWJSNkJqRjdNSTZjZDdpeXdZK1VH?=
 =?utf-8?B?aXpFNVo3RkRYeWdLMkdVaFVRMjVZTVdneTFkWU5INVcwR2haM0l2NXB0MmZV?=
 =?utf-8?B?MzBoeDN4Uk9wQkVDN243NFdPanBoWGltWGErRE5BcnhLczBQQVUzL0Q3MWE1?=
 =?utf-8?B?VHQ2eHlPWVBmdzlLTUVOenoyS3pUVER3U1FLWm5SOTd0Uy9OaWgxZDVHaDJ3?=
 =?utf-8?B?dkdLL0xHR0tGMnR1d1l4L05Bd2RST2dhUXFwbmJGWHJQbmVzc1BkY2dpSVFJ?=
 =?utf-8?B?QWlXdkVTb3hTSlkySmwvcWZRK2RsYis0ZE4vbzdxaHFrU0lZSytMS0MxSE14?=
 =?utf-8?B?VUFBNWRLYjFOUUZKeXpjSnM1QUY5bENnYXpCOERjdWhOYzh2TTh0WW9oUlRB?=
 =?utf-8?B?Snd6Z2tIbEdkRzhKQXloVmVwK1V4aEtQRjlEazJuMHNKQ2t1S2xPK29Rc0Jt?=
 =?utf-8?B?VDYxZHhXVGRhZ2NqV29mUDhhWno0cjRycHUxNjZ3bVlRVnM5bWp2VmhudEJ2?=
 =?utf-8?B?Mk94cXJOV0l5RisycXozS0VMS2dIWnRNYVZ5YWExT1g0TGs0TjlqY0h3NUpt?=
 =?utf-8?B?Y3ZFTUxVY2Zxa0xuMHV1SVMrL2p3ZkRPcldCNEZ2M1M0RWZnc2Zkb2NKdnlP?=
 =?utf-8?B?OW9vdmxFVjJBUmsrOFE0Q3dYdWY2bWk2QytqQjN1OWNHNDBVV0QxNzVBSGRH?=
 =?utf-8?B?dzVjczdIbjZMcnNmNGRYdHJSV0JzVTl6ZEVua0pwb3lzaUVhYzZRUkRlV2NY?=
 =?utf-8?B?Rk5LV3RQckVLMmVoUVcycEI0dGd4U2hNQ0dCZnNUSkkxNDJ4TWhoRUZsNGJt?=
 =?utf-8?B?VXoxTVptQ2NZNXFpS1YrR0k1ekM4Z1BMRUl5cWt3TXlpTURWenNKc3lOT3hO?=
 =?utf-8?B?NjdPUDZoK0I4QVBRZlNmbGFNeXdpb0hwVGVsMWdIR0liY2ZlTWZEYnNmN3pz?=
 =?utf-8?B?Yng0V2h3VjhPN1NhUU4wMUx2Nmc2R21jVDJMRmpteXJKSW9aZGNCbll2OXdx?=
 =?utf-8?B?MHhodEQ0alR2eGhJY3ZIYkZlWlVENWVHNFpsT3ROdFFwdnBrMlJLTDF1azA4?=
 =?utf-8?B?MVdNQWt3ZW5CbkFrcTBqS0owRjFpNmUwWHZ1TElyalZHcVl2dndqK2NpY2Vs?=
 =?utf-8?B?VTE5d1VhZkQzWmtrbVVKTXFpS1ZPTk9QQ21NVVpNTEJoTFJFbUxQS0pGVHdq?=
 =?utf-8?B?L2lROTlaOVZ0MlZqekxwYWlyNTdyN09ORFpldVhiZHNHcmRzRVAzdlpzN1VH?=
 =?utf-8?B?N3UyR00xeXpDVUpBS3NzMS9GUGZwclpLVjNCRHdTZ2FxbmloU2VWUU1OZVgy?=
 =?utf-8?B?NmM3UDRXR0JWcGVHNThQZmlzTmRzUGdZNkU4STRjQTM5dkhTWGlyVENRZUR5?=
 =?utf-8?B?Y1BjWnhXK01DcmJ0S0pnODV1aURNaHF4M2pVSmlaVXZaOUNZSDZPZ29FQ083?=
 =?utf-8?B?c1pGaGk5RGN0WG9sQnNZWEVLR3pjNjd2UGZuWUFPc09ERFBnQlppNmU3ODZv?=
 =?utf-8?B?NWJSMk5PTnF5NExZWmZMaDFtRFEreUxrRUxxdTdEaFpibzlqQTREZjA4dnNO?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63154F607B46F240AA1A744CC48E1CE2@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2506.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c7072a-04a9-4622-be03-08db7c557ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 06:11:26.3406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /QtqTHu4uMBKRaXM6bcqDxgtb3LmfD6BKpp6jcUX9ljjgaJpt5BQ10AJISeShqJk0mPkW+eqedIE9Pozrn5lVWKiBoLlGmM3W6QGzEg0sO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6720
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

VGhhbmtzIGZvciB5b3VyIG1lc3NhZ2UuIEkgd2lsbCBhZGp1c3QgdGhlIHBhdGNoIGFjY29yZGlu
Z2x5Lg0KDQpNaWNoYWVsDQoNCk9uIE1vbiwgMjAyMy0wNy0wMyBhdCAxNzozOCArMDIwMCwgQW5k
cmV3IEx1bm4gd3JvdGU6DQo+IE9uIE1vbiwgSnVsIDAzLCAyMDIzIGF0IDA1OjI2OjA2UE0gKzAy
MDAsIE0uIEhhZW5lciB3cm90ZToNCj4gPiBGcm9tOiBNaWNoYWVsIEhhZW5lciA8bWljaGFlbC5o
YWVuZXJAc2llbWVucy5jb20+DQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBicmluZ3MgU0VS
REVTIHN1cHBvcnQgZm9yIHRoZSBtdjg4ZTYzMnggZmFtaWx5Lg0KPg0KPiBQbGVhc2UgdGFrZSBh
IGxvb2sgYXQgUnVzc2VsbCBLaW5ncyBzZXJpZXM6DQo+DQo+IGh0dHBzOi8vd3d3LnNwaW5pY3Mu
bmV0L2xpc3RzL25ldGRldi9tc2c5MTQ5MDguaHRtbA0KPg0KPiBJdCB3b3VsZCBiZSBnb29kIGlm
IHlvdSBjb3VsZCBidWlsZCBvbiB0b3Agb2YgdGhhdCwgd2hpY2ggd2Ugc2hvdWxkDQo+IGJlDQo+
IG1lcmdpbmcgc29vbi4NCj4NCj4gICAgQW5kcmV3DQoNCg==
