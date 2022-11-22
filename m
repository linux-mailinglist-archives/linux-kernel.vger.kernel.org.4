Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCADE633A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiKVKlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiKVKk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:40:26 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2065.outbound.protection.outlook.com [40.107.103.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C879660E8;
        Tue, 22 Nov 2022 02:35:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEik6oL55oiUdgEIE4e1arP6cEh6A9Z4QR+YdL/x82ULpo/nUMH33hXyeB1hVmdENmkCh6ZvAIhw9GsT8ivm4mCPmcqhIkA4r6ljvwuxnUcrbiyP8UWxYXryFRChu6tvmYGUQzhD3vb3f8EnUbBhmmzKN+nTFL0LIe2TGZLuOIuhslnE1IQt8BbBTYpEAG1ubganko9UXOVnwSX/+PU0oH2umHp4hImRqtnj+hvxtpf21YLXRFCrFLsz4bt/E8+aTNzM2tQppjrEPQcDb89u9e05bw7y9SN6kHjoa7a7sFuzpTXnlE/G603LN/x3MoDTe/zRvRLKnLRKbJlGNWN8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KE5JeIW6PyTVoy5cf4D+je0VCt5FIyG4M8dX+vIzIU=;
 b=QNt6ZuX2Lhb3bspUsGtIa9Plh0MfZe1Nrdls4cBE6NyPED7BJMdvVQWe7jHhYx0/5Exm+n3zOLtiUenv/zIqk6vzWWRV063LmZHIptOabvHkDiWJKa7UHMaAMgRcb7xthZOG3ytlWg1wJYtaO+aNVM6lA2PQ+ZG7MonxWz8fHT1wSCmdZprvsKyqIyzyhiXvbkuOAw+FKlXuQRgaCMoldRb6rRpa5mdxVBULOYxlPnIBOtmK8UG7oe533en0T30G54SbbNFmb7Auvv1/kIaQMtEM2OXcRXo0u8hwdGWqd4qw96NjVTPVJqClDuK3j3n7NYqCy0YL2s9HYne9+j374g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KE5JeIW6PyTVoy5cf4D+je0VCt5FIyG4M8dX+vIzIU=;
 b=jOgwsuPExKGJD/zUIBzlh2OtoQUHgoF72etLbya8vL3QDKUbgLTbqeoMaf9t7uEUW1tb+OvCPL+s8PqrP0XciRW4T02Ros2Yqd5Jut4yxbN5d4g5mVSuZ+tksQCK7xE22SezEF7WcRyDZbdxkQ9bx4M9+VdeeprmrJGom5ohERI=
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by AM9PR04MB7506.eurprd04.prod.outlook.com (2603:10a6:20b:281::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Tue, 22 Nov
 2022 10:35:13 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de%8]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 10:35:13 +0000
From:   Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Rohit Fule <rohit.fule@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v1] Bluetooth: Add hci_nxp BT submodule with controller
 Power Save feature for NXP BT chipsets.
Thread-Topic: [PATCH v1] Bluetooth: Add hci_nxp BT submodule with controller
 Power Save feature for NXP BT chipsets.
Thread-Index: AQHY/l4aFePdsxxPG0iaDpknrXOyTQ==
Date:   Tue, 22 Nov 2022 10:35:13 +0000
Message-ID: <AM9PR04MB8603D47C2973EEBD1BDC5A3CE70D9@AM9PR04MB8603.eurprd04.prod.outlook.com>
References: <1668616931-21987-1-git-send-email-neeraj.sanjaykale@nxp.com>
 <aedc0972-1df9-6d65-f8a0-2f735469c27f@molgen.mpg.de>
In-Reply-To: <aedc0972-1df9-6d65-f8a0-2f735469c27f@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8603:EE_|AM9PR04MB7506:EE_
x-ms-office365-filtering-correlation-id: 0581cdbe-1680-447c-b458-08dacc753d05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DGJU+lBmhkExIfx4mRsSMIJodrf2XsBpjQ+a/S7z4z5iyObrtCqoDGDPn06RzgBSkSV0JkGru6pjeji7H4g03mM2NGN1/K6FunXuLldgKiE4A5ZO6rVohKhxZ5sJywLIxfgHV+pz8hugR/0+v+3RPZtNj3t2PopuxD3OteVo4fCTk9KTTJeNwHPlMZTcT8/b6hYYl9GqX9/zFZb6j+/hRvWPHdgi8ULsBlWW7UUkw5F4kSGUzqxKQnsJRPDT6RlvLHl2/AP8bWh0DJaZS1993qaWgQc3XppJmsTvCXLHwdVVwEi3aXWYLlBZcX0VWAGbzyGz8tUmlTOlV969H5bGYogQjwDW8Vg8ia0E5usHEn2FwFd7EINT7GEt4sCpLSqh7xFRwVF1KZTXAWEj74/WLPF7afQ8+mY9z7cKdMRTDY++mP/iOhuIpLvnpl8TzHiTE69u4z93tQ83Y1YllRFHokASJHDkne8sB5H2QGH9p+AxwOVECcHhSJr9r+FVp9CqTpsoTaPTJYwl3TrKOjlaCFxnPG27pF2saIgpBCXYJeuZCBMZAWwgMvsidfl7XDyQoIYxMeE6JUBl2Vax3bZMsOTi37FtfjFpNKFl7oITX2FV7oLUCy3gruibfan4NCwhPGIpwHa39JxqBJgLKIOhhKUPvRIldoZBxp88kqS48vGXHnF7Ukj6GFOYlkh8u4n+ONP79iHQq5zgUi/ZhI65yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199015)(33656002)(86362001)(38070700005)(64756008)(7696005)(76116006)(55016003)(5660300002)(55236004)(26005)(38100700002)(2906002)(186003)(9686003)(83380400001)(122000001)(54906003)(66556008)(6916009)(71200400001)(6506007)(52536014)(8936002)(4326008)(41300700001)(66476007)(66446008)(478600001)(8676002)(66946007)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjVEZlBJS1V3bnkxOFlwQndOV3lDRGdqVGo0TTZRL3F0WTYwQW1LdUNHM0dm?=
 =?utf-8?B?ZTFScWdNOUVDNUNrekREQ2Jtc1Q2WUhmVHhQdTdQQTFsd3ZEWjRvRytYUHM3?=
 =?utf-8?B?WGdJbDBnWUwyYUxUR3pneG1pbm8wRmtaVndYaGpCTXk1N3FYWGRrbElzMVZO?=
 =?utf-8?B?WjdRck9peEs2cytHYWZkOFZXOUplRG9naGxTSDhzcWxVV1FFNEduYjdYSXl6?=
 =?utf-8?B?Ums0TVNSK08xc0w1dzhkWldvcEdjckhDMjJKN0tSK3pGV0JSZFlDaHB0M0Fp?=
 =?utf-8?B?YVREV0w1MTVKQ2o1VTc0SC9CTHZCMUJEcVB2TTJZYm1WQlRNSzByYnVwdTJZ?=
 =?utf-8?B?djh5bURhUnl1ekFwN1phZUh1bnpJT0YxMkFSYjcxUWQzaDZER0t1RWZlc2lk?=
 =?utf-8?B?YVZtUUYxU0pxRG1wRURucUFJQkdMVmVQTzIzd0s4ZDBlTlB0Rmd5QTUySWlp?=
 =?utf-8?B?anRuTWpoaXN6amszRjZoYTQzSFRqUHpBUE14cHJHK0VUOWU3cHhZWkVtakFH?=
 =?utf-8?B?NWd3NGw0b055WlBYeEJZZUw3eTlWTzB6WkRocWk0RUZYNE9qQ0pnMEtJU3Nl?=
 =?utf-8?B?Rk9UaWNIakhueGxkdEUvUHRKenphU0gxQkVQcFh0cGR0d0FmRlI0dkVoZjdH?=
 =?utf-8?B?NU0ySzdwQi9UaEJ2Q20wRzZhRFViTHVENXpKeU9HTVlacFJ1WFhRbGEvQTg5?=
 =?utf-8?B?K1NOalVPZkpQNDZ5NFN1dXNsNitXRDhiQlZ6OG42UVhtM3NGbG1PckNyMnR3?=
 =?utf-8?B?VS9lc1BRVmlqaWNucThPL2JybWhkWlcvUlZYVTVpbGU4Z2doZHBpYjEzR2hW?=
 =?utf-8?B?eDZlSkg2ZU43dlJSVVFnaW1YRkVBelQ0R0orVWJsTUIxaFg5MFQ4VVdZOVpP?=
 =?utf-8?B?TU9PckNkMFp0RThEakZDUU5udCttM0VEOXNuS1F5c0pMc2VNeVhia0ZiU3dx?=
 =?utf-8?B?VXpGU1hEZzlCTjE5Vkc3emt0a0RUZHFaOGcydGtIQUZPM2FrZFQzYnQ1Yjkr?=
 =?utf-8?B?c25WNGhwRWc3ZjM5SXFhZ0pYTDZnLyt3OWcxR05kd3lSYWY2MGNBTFAxWUZU?=
 =?utf-8?B?bEVQU3RUUStsOEh4QXhnQmIzck5jQTk1dVVMckxqZ2N1YURWWVRGT2ErNXdH?=
 =?utf-8?B?UFZCL3BCa0ZkUlMxbUUxUm8wcE9lb3ZBcmRCNjRWeThjbW55Z2c4OXFYV21t?=
 =?utf-8?B?SVRsSm9pRndOUmRmK1k5aE8zdXZzOVFjb3RwTVdKWGVXUHlqcjh3bmFzd3p1?=
 =?utf-8?B?Z3I3R1VjMkpEOW9ucXRSeFlyQUk5STBPRmlzaFZDOUpJVmFlNDQ3blVTTDBE?=
 =?utf-8?B?WStrVTBPRlBiVisvdGxEU0RFZ3o1RVpFQjJQNjd0OWpkNCtaN0U0TmZHc0pZ?=
 =?utf-8?B?cFhPNVZ3ZHBiL1Jvdk13V0xXdFVsd2lRbGdNdEl5VVdHYXZ3RXlWazQ3NElz?=
 =?utf-8?B?Mk93cHRFQnNEZUZ3TStxZzh3NVFHenRjdnBWWFVoQlhpWURNUTFEdnJsaXRt?=
 =?utf-8?B?TjFGaWdPTmlQeExldm1Jajd4QVVCdzAxYVFkSVJFaVEvdFlaOG96UFFZU3l6?=
 =?utf-8?B?V0RNMWU2Y2VBbFh5RTZUZndINytMbWsyeENVYTIwUVRxWjgyOEZyd3o2UTlp?=
 =?utf-8?B?WjRQVHZNdVhocHZWMUVsVFZvTkJ2Tjd6VUlVUEFGdmxRcVBKb0VFcXBNRFVt?=
 =?utf-8?B?TS9RMzA5QnpyRENXSmEzNUtWQVlnallNdGxmYnhseXFVYXE1S0NmMjRCQ3RZ?=
 =?utf-8?B?VXVCTGttM0s3UERCQnFsQThsdjB1Z0J6dFdpOG1iVWExZVJwbEFlaUR1dU9v?=
 =?utf-8?B?YnNWYWRzaUtpOU96Snd1bHpjVGZlbkhUQWZ2c1FUYTJSTWQra09wOUhuV2hM?=
 =?utf-8?B?OUJSbHFBaW91d1ZpQ25mWHR2Q2I4TDhrenNPRWx3Ym8xU056aVJaR1YzRWNv?=
 =?utf-8?B?dlV6d1ovUnBrMnBjeXhYUFczTTcxV05rYldlWVlINWhHTVg1YXJweC9PdkhX?=
 =?utf-8?B?a1FTVWwvVWN3WWc5czZxRFFoZXpaQ3NLbjV0d3RiNXk1SWVhYy9VbTBlRHJF?=
 =?utf-8?B?cVZtZmRhMmVUcVl1UTJCMmV1di9ReXdHZnJuMTJ4cWhKbkhTSm5QcS8xamhD?=
 =?utf-8?Q?8f9TOXo4dYnbMlfly99ScCGmd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0581cdbe-1680-447c-b458-08dacc753d05
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 10:35:13.2745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2BXVLQRDHyOGxFzJmO/Qd+NTvMn5ygFx1vHfUX6wiyLuJiaYhnrw9SaIbqBIwW7nnFkhYNNUK3p1cZZJB5Grd8I+ULdzn961o0MAMhfnbFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7506
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGF1bCwNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlldy4gSSBoYXZlIGFkZHJlc3NlZCB0
aGUgY29tbWVudHMgaW4gVjIuDQpQbGVhc2UgY2hlY2sgbXkgcmVzcG9uc2UgaW4tbGluZSBiZWxv
dy4NCg0KVGhhbmtzLA0KTmVlcmFqDQoNCj4gRnJvbTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9s
Z2VuLm1wZy5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxNiwgMjAyMiA3OjU3IFBN
DQo+IA0KPiBEZWFyIE5lZXJhaiwNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2gu
DQo+IA0KPiANCj4gQW0gMTYuMTEuMjIgdW0gMTc6NDIgc2NocmllYiBOZWVyYWogU2FuamF5IEth
bGU6DQpDb3JyZWN0ZWQgdGltZSBvbiBob3N0IG1hY2hpbmUuDQo+IA0KPiBQbGVhc2UgcmVtb3Zl
IHRoZSBkb3QvcGVyaW9kIGF0IHRoZSBlbmQgb2YgdGhlIHN1bW1hcnkvc3ViamVjdCBsaW5lLg0K
PiANCj4gPiBBZGRlZCBwcm9wcmlldGFyeSBoY2lfdWFydCBkcml2ZXIgY29kZSB0byB0aGUgbGlu
dXggaGNpIHVhcnQNCj4gPiBzdWItc3lzdGVtIGFzDQo+IA0KPiBQbGVhc2UgdXNlIHByZXNlbnQg
dGVuc2U6IEFkZA0KQ29ycmVjdGVkIHRoZSBzdW1tYXJ5L3N1YmplY3QgbGluZSwgYW5kIGFkZGVk
IGZldyBtb3JlIGRldGFpbHMgdG8gdGhlIGRlc2NyaXB0aW9uLg0KPiANCj4g4oCccHJvcHJpZXRh
cnkg4oCmIGNvZGXigJ0gc291bmRzIHN0cmFuZ2UsIGFzIExpbnV4IGlzIEZMT1NTLiBQbGVhc2Ug
Y2xhcmlmeS4NCj4gDQo+ID4gaGNpX254cC4gVGhpcyBkcml2ZXIgaGFzIFBvd2VyIFNhdmUgZmVh
dHVyZSB0aGF0IHdpbGwgcHV0IHRoZSBOWFANCj4gPiBibHVldG9vdGggY2hpcCBpbnRvIHNsZWVw
IHN0YXRlLCB3aGVuZXZlciB0aGVyZSBpcyBubyBhY3Rpdml0eSBmb3INCj4gPiBjZXJ0YWluIGR1
cmF0aW9uIG9mIHRpbWUgKDIwMDBtcyksIGFuZCB3aWxsIGJlIHdva2VuIHVwIHdoZW4gYW55DQo+
ID4gYWN0aXZpdHkgaXMgdG8gYmUgaW5pdGlhdGVkLg0KPiA+DQo+ID4gVGhpcyBQb3dlciBTYXZl
IGZlYXR1cmUgd2lsbCBiZSBlbmFibGVkIGJ5IGRlZmF1bHQgYW5kIGNhbiBiZSBkaXNhYmxlZA0K
PiA+IGFuZCByZS1lbmFibGVkIGJ5IHRoZSBmb2xsb3dpbmcgc2V0IG9mIGNvbW1hbmRzOg0KPiA+
IGhjaXRvb2wgLWkgaGNpMCBjbWQgM0YgMjMgMDIgMDAgMDAgICAgKGRpc2FibGUgUG93ZXIgU2F2
ZSkNCj4gPiBoY2l0b29sIC1pIGhjaTAgY21kIDNGIDIzIDAzIDAwIDAwICAgIChlbmFibGUgUG93
ZXIgU2F2ZSkNCj4gPg0KPiA+IFRoZSBQb3dlciBTYXZlIGZlYXR1cmUgdXNlcyBVQVJUIGJyZWFr
IHNpZ25hbCBieSBkZWZhdWx0IGFzIGNoaXAgc2xlZXANCj4gPiBhbmQgd2FrZS11cCBzb3VyY2Us
IGFuZCBjYW4gYmUgc2V0IHdpdGggdGhlIGZvbGxvd2luZyBzZXQgb2YgY29tbWFuZHM6DQo+ID4g
aGNpdG9vbCAtaSBoY2kwIGNtZCAzRiA1MyAwMyAxNCAwMSBGRiAgICAoc2V0IFVBUlQgYnJlYWsg
bWV0aG9kKQ0KPiA+IGhjaXRvb2wgLWkgaGNpMCBjbWQgM0YgNTMgMDMgMTQgMDIgMTUgICAgKHNl
dCBjaGlwJ3MgR1BJT1syMF0gbWV0aG9kKQ0KPiANCj4gUGxlYXNlIG1lbnRpb24gdGhlIGRhdGFz
aGVldCwgYW5kIGhvdyB5b3UgdGVzdGVkIHRoZSBkcml2ZXIuDQpBZGRlZCBleHBsYW5hdGlvbiBv
ZiB0aGUgdmVuZG9yIHNwZWNpZmljIGhjaXRvb2wgY29tbWFuZHMgMHg1MyBhbmQgMHgyMyAgdG8g
dGhlIHYyICBkZXNjcmlwdGlvbi4NCkhvd2V2ZXIsIHBsZWFzZSBub3RlIHRoYXQgdGhlc2UgdmVu
ZG9yIHNwZWNpZmljIGNvbW1hbmRzIGFyZSBzZW50IGJ5IHRoZSBkcml2ZXIgdG8gdGhlIGNoaXAg
ZHVyaW5nIGluaXRpYWxpemF0aW9uLCB0byBlbmFibGUgdGhlIHBvd2VyIHNhdmUgZmVhdHVyZS4g
VGhlIHVzZXIgbmVlZCBub3QgaXNzdWUgdGhlc2UgY29tbWFuZHMsIG9yIGJlIGF3YXJlIG9mIGl0
LCBpZiBoZSBpbnRlbmRzIHRvIHVzZSB0aGUgZHJpdmVyIGFsb25nIHdpdGggTlhQIGNoaXAgaW4g
ZGVmYXVsdCBtb2RlLg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOZWVyYWogU2FuamF5IEthbGUg
PG5lZXJhai5zYW5qYXlrYWxlQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gICBNQUlOVEFJTkVSUyAg
ICAgICAgICAgICAgICAgICB8ICAgNiArDQo+ID4gICBkcml2ZXJzL2JsdWV0b290aC9LY29uZmln
ICAgICB8ICAxMCArDQo+ID4gICBkcml2ZXJzL2JsdWV0b290aC9NYWtlZmlsZSAgICB8ICAgMSAr
DQo+ID4gICBkcml2ZXJzL2JsdWV0b290aC9oY2lfbGRpc2MuYyB8ICAgNiArDQo+ID4gICBkcml2
ZXJzL2JsdWV0b290aC9oY2lfbnhwLmMgICB8IDc2Mw0KPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gPiAgIGRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9ueHAuaCAg
IHwgMTE4ICsrKysrKysNCj4gPiAgIGRyaXZlcnMvYmx1ZXRvb3RoL2hjaV91YXJ0LmggIHwgICA4
ICstDQo+ID4gICA3IGZpbGVzIGNoYW5nZWQsIDkxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ibHVldG9vdGgvaGNpX254cC5j
DQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ibHVldG9vdGgvaGNpX254cC5oDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUyBpbmRleCBlNTVh
NGQ0Li42YjJjMjY0IDEwMDY0NA0KPiA+IC0tLSBhL01BSU5UQUlORVJTDQo+ID4gKysrIGIvTUFJ
TlRBSU5FUlMNCj4gPiBAQCAtMjI1OTEsNiArMjI1OTEsMTIgQEAgTDogICBsaW51eC1tbUBrdmFj
ay5vcmcNCj4gPiAgIFM6ICBNYWludGFpbmVkDQo+ID4gICBGOiAgbW0venN3YXAuYw0KPiA+DQo+
ID4gK05YUCBCTFVFVE9PVEggV0lSRUxFU1MgRFJJVkVSUw0KPiA+ICtNOiAgIGFtaXRrdW1hci5r
YXJ3YXJAbnhwLmNvbQ0KPiA+ICtNOiAgIG5lZXJhai5zYW5qYXlrYWxlQG54cC5jb20NCj4gDQo+
IE1lbnRpb25pbmcgYSBtYWlsaW5nIGxpc3QsIGFuZCBtYXliZSBzZXR0aW5nIHVwIGEgZnVuY3Rp
b25hbCBhZGRyZXNzLCB3b3VsZA0KPiBiZSBuaWNlIChueHAtYmx1ZXRvb3RoLXdpcmVsZXNzLWxp
bnV4LWRyaXZlckBueHAuY29tKS4NCkkgd2lsbCBjaGVjayBpZiB3ZSBjYW4gaGF2ZSBzdWNoIG1h
aWxpbmcgbGlzdC4NCj4gDQo+ID4gK1M6ICAgTWFpbnRhaW5lZA0KPiA+ICtGOiAgIGRyaXZlcnMv
Ymx1ZXRvb3RoL2hjaV9ueHAqDQo+ID4gKw0KPiA+ICAgVEhFIFJFU1QNCj4gPiAgIE06ICBMaW51
cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+ID4gICBMOiAgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiANCj4gW+KApl0NCj4gDQo+IA0KPiBLaW5kIHJl
Z2FyZHMsDQo+IA0KPiBQYXVsDQo=
