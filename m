Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FFF6B8763
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCNBFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCNBFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:05:13 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2062.outbound.protection.outlook.com [40.107.241.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2415C867F4;
        Mon, 13 Mar 2023 18:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNwBlY4nsqg6rS7QsP6rkQHvkvKhDf3j+iF3bT++A1sFtzQv0UMt+c7stNJT719ReXD0GU8V9l+UgZtvnQQJnvQOBUkXPQp0TwH6PAXVEZLhabvTvAJYkogC2IXMeCyF3/EL8xwnBSghGNlgVYRov1GgqwLjYJP8JIT/2Jx/tBZVoiCIUTKgcqKOdOKqrpp0zYSxTdf4oLbr7WYusg65GzNS5mvt3FLHJ3R0g3n23zrAgRCG4AregTXU7sYbDerMjmkTCSiXwRZYXhKhHdztfM4jBbngLu5oV2ZJtB39b4kbZ3FyOfd0yl4MQIuA/sUWP46gWPatgQITjJCBCZY5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwhTWT0vHcx/K6j+o1R82JRl5VYRcNWZxPYm4+gb0dc=;
 b=SEs9W8FDctcFFjifKchpM1+5Wibb6mIz3u9RJeSMPaYOxUv4c83XLiQ9WRzvgFBOFfLolWaAhqhxG+d9lwFfjSDmfBvM7k+8tLAHWE/zXSBHT6nZmfiKW2fmO7ljglNyn9KYeqHpDIM5kq7n6wNN/yYzKoqMOeA/2eQ0XcVgcBLvQ2iySB0RTOPQvqpE8LdprJ2ARBfzWig8q2+6F7PFhV+BYT28NQ4e/+BF8qdEKYBNKl5b+s6onBItSiJeFCtoo27pswM1iaqIoibrQuxlmMK8mIBnEB641LCVbeTmF/tFNNsRGwtg4FbkhPwFnx8dxsfWUSLngaoZbzHm+Gqaow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwhTWT0vHcx/K6j+o1R82JRl5VYRcNWZxPYm4+gb0dc=;
 b=J7qdGtQGIPe6ElXzoEBtOT6beiCn2IrBxbcmeOdotq9BTmJiQRTUrLQf4/Gk9oVHk1xHwwrDmzV7clWHiNWr7L4YqMvmgqO5eCzDERzt+KumuwF+rk8+lyCmsIFojHi3gwlIuU5Dh+yspdQyKIRG+teLK3HlTj/CHeTaWfU6l6Q=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 01:05:08 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 01:05:08 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-devicetree <devicetree@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] dt-bindings: media: amphion: use hyphen in node
 name of vpu core
Thread-Topic: [EXT] Re: [PATCH] dt-bindings: media: amphion: use hyphen in
 node name of vpu core
Thread-Index: AQHYTXi3PsR9gYj8G0mr+E/q0wT7Y65PKD0AgKubnICAAMLl8A==
Date:   Tue, 14 Mar 2023 01:05:07 +0000
Message-ID: <AM6PR04MB6341E19CC7CA62A42342F3D8E7BE9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20220411074855.25114-1-ming.qian@nxp.com>
 <7213be47-1746-b7c6-9807-21865adc190a@xs4all.nl>
 <04465497-306b-6e37-9dca-45d194d9d926@xs4all.nl>
In-Reply-To: <04465497-306b-6e37-9dca-45d194d9d926@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|DB9PR04MB9234:EE_
x-ms-office365-filtering-correlation-id: 30208fdf-af8d-47da-07f3-08db24282730
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +xb/JOYp1L1wvU87TA9vOw5qjwLuEjIk9dPVW685FufiEA6VJpaWjZev+hLGjYGm3OEivbGFOi0eojNfuu3kYsHdkBFepsQ9BwSfTElq9v9o7+aF3BCtUXJ8Ni9hnQXOSbDeLE8qA+rAQqKD9aDDP4SByIfMuQbC8F40kqALCVssSBpn0epvexq5hXNDWzgjT4MmiDTcZcPHx+q/SKTTJHAA1ahTQ1mGyBO+jt71ZFbXyXmp8FDGBfsvWMzFhCcV9tL4X6/GGVhZ7ipaIpgnCIpSNKXrwS7op4YEeYAwnIOXJFkrnJGCAc1v9Bk/NQfCMJPfq0A4OStJS41V7tJloIgNE1hLy8AVKBY8Zex1WKi6NaVIkuWeRJ+LyA1qOMVBc4fNI60cngexU9NX/c/yDLsIQh4yfwYkXYKhYjj5lyMq1b0Dc/oUCBWQWNQmJeIlJwhKmf7eZvM4UdsA0dAPMRyVq0RSaJotgplhhlmqW1BwX/H15/M+UdC2R9EvSAGnN+/SAGjhjEyLe0l8FM8gk9w7k2qwEC2iOAZmTxOJMfq74cLQTsrZiUkKfWe9YGMpFIuQRZslRFDwww3ihRUWcESW8s5upSx2GtBI2LlxO9EFm+P69PmTfkDL8DvAvOylKeqolLRfpRsq3pAn4Y+EzV33FqH3xz7/u6VAzo4oPBsIW0RjPyCzvfVf1PGygDXDppMgFhRcCe2YameDLRnRGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199018)(86362001)(38070700005)(33656002)(122000001)(38100700002)(55016003)(66556008)(66446008)(4326008)(66476007)(76116006)(64756008)(8676002)(66946007)(52536014)(41300700001)(8936002)(110136005)(54906003)(478600001)(6506007)(5660300002)(316002)(44832011)(7416002)(2906002)(83380400001)(71200400001)(186003)(9686003)(7696005)(53546011)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFRyN2RuYURDQ1ZJN1pWY2dQcjBlRHF0MXEzdC9obU5PbHFwbGZRK3lQZXBB?=
 =?utf-8?B?M0d2Znk5OTR6S3FjL1hVdWtoL1lMekE3WkJpTVhrWkZveXA3UVJFYzU4NlRt?=
 =?utf-8?B?U3F3Zjd6VlpSV0FvK3NEc2x6QUQ3RXYvcFRzTzh5cE5hWk53OEJiaG1CV2xX?=
 =?utf-8?B?VitBWXhHS1RhK1FaSmRnb2JZWERESUhmR1F6TldXWjdmc2JlV3cvd21Ydm5H?=
 =?utf-8?B?bG5GSFk3bkZzRENWWFhTK0M5SDFVbWJ0bzdnVEtSL3Ruc2pxWFcxTVJBK1JX?=
 =?utf-8?B?bGtBNkp2T2d5Z3NldWs3TUxhMUNzWnkyNytJczhvZHBDU0lveXlVdWh1QTJ4?=
 =?utf-8?B?cUtRS2ZzWXBRS0NTM2Y2bllXa3hWc3Uyc0NzZzZPUzkreFVFRXBMVnNKeXI5?=
 =?utf-8?B?cEduVzZ2Z1ZmTU9UdGphV0ZZNG03Wk44ZGY2bEtqS1Iwc2hUZkV1OXd3eG00?=
 =?utf-8?B?QlhwMFRVM0NITXdKbGc0blE2SXhzaVc3UngzMElpT3JhTlcwM01HNFBZWVFH?=
 =?utf-8?B?dG9MQ0xRQ3RTeTNPOVpjSUNtRnBjTzFoOWR1ZTIrckhkSXZxRm9Ld01PbFpV?=
 =?utf-8?B?VXNYR2pLNU14djZVRlo4YjBnb2R3VWNCQ05WaEl6czVJUlV3aXlDTy9zWVpn?=
 =?utf-8?B?Z3o4Tm1SeHZDRHpuak52UE9vNlpaVDhjWXg5bTVqaWR0US9seWJsYmhWeDhS?=
 =?utf-8?B?SGljZnAxaVhSTGdsK3ZPWmhvdy8wM3ErMG03TDNJcnNJSytSNHF6RUV6NUhi?=
 =?utf-8?B?YkxBZ1NaaEprOTdaQlYvTUprSTBHbWJIaFJkaTBqSDlZQjZOeWdtNmpDN2Vs?=
 =?utf-8?B?SVBXREhtZHgrZW1JVHp1bEhNc09Hemc5Mk0vYmp1NFRBYWhoS3ZjRE1hNmdE?=
 =?utf-8?B?SktDR01IdGxMUDZxNUsvZkpsYVEza2MxaTZ1V0RhQ1l5anpWOWFvT0swcHhX?=
 =?utf-8?B?cGhCcDl5elpET2RPS0ZzVlF5L083V0RYbjNDa0RPQ1R4RForcEpUR1BjSFpj?=
 =?utf-8?B?TWIwNVg3T1NUSVRXeHJYekZWUVhNRlAvNXZkdVJBajlURW1UM3h4NXRVMS9i?=
 =?utf-8?B?dkl3MkpMRDRjVk5UU05sMElsRHcxOEVILzdtMmEwQlI4VVc1TmF2ajBBU3FZ?=
 =?utf-8?B?eUgrWDQ5YlpIMUczOTY2dm5TMEpOYjRpSTFnd2N6eUt3MzBTMEhDNVp4OVZR?=
 =?utf-8?B?ZzhZRU5HN2F5TUJwZ0wvSmJydHc5anZNUkMvYmRqb1daODlGMGJ4amcwRXAz?=
 =?utf-8?B?cXJxQ2NWcEh2SGxLQy9COVBnaUMrVlV2c0loTlZvZTUwaUVZaDVyNFBuV3dT?=
 =?utf-8?B?UFppdnNyZGNabnFra1lnUVFNM0JlRjJYN3Q3cXBIeXZpWmdVU0R6ZWNGdi94?=
 =?utf-8?B?dTU1ZWtpWFZGWGdRUCtHNmcxZUpOa1A1a3p5M1liNWdraVN3NGg2cXpwRDVr?=
 =?utf-8?B?dkRJNzV6TXNoV21JOGdhbkJOWUdnYXBoOWExaDRkV2Q5TEs0R1lDNnRDTUU2?=
 =?utf-8?B?RjJ6L1UxTDZKTElEeFBOK2xZMjhqZFN2VFBrVjEwd1ZuYUFZTkFGZWdjNTNn?=
 =?utf-8?B?bHF2eUppbEtBbXRpUmd6QlVKRVZSY0JMZmV2QWNyRTlTYTdMMFRxcGpGbUJE?=
 =?utf-8?B?UGEyc01oK2U5RFExa3g4YlRxNFZnZU95bXYwTVgyL3M3Y2RrajNiKy9JYm01?=
 =?utf-8?B?a2kvTUZFYWRySjV4emxpdkdlVjgrV1drNWFNTFl1U0VqeGZHcW50RUhuc2F3?=
 =?utf-8?B?Zk5VeFpyYjlyYVRIRXZYUk5hV3QrTWNPdlRyTUp5UERCSit3NUNWam9qeEFF?=
 =?utf-8?B?UW8xL0Q0ZmdlWm55RkdlZWhFbGVnVkdZRW1NY2VDT3RsZ3o3RkU0Mml1NWpa?=
 =?utf-8?B?d0lLUWpZd3lGVENtYkVPT2xLb3RqZUhNa3l3WTFGbGlvQUhWd1JUaHRLTUFy?=
 =?utf-8?B?RFA1ODZ2SHBiRm1ZZTFVZW5JbmljdGNlYWJ0cmdoNzJoZXBMdWRoQ1ZJM1BC?=
 =?utf-8?B?TEdOTElYUWZzUzNrWVozenlKaWNleDR4ZUhKU3UwbEFEenY4VXovdGhiNXhy?=
 =?utf-8?B?eGovb0xzeUZKWGhJWXIzbm9YTUtNcXA3ajNzQ1VZc04wc0RQdUNCK3RIVmZn?=
 =?utf-8?Q?mxGk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30208fdf-af8d-47da-07f3-08db24282730
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 01:05:07.7183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXgtImhzJ42CaXOB2EPCuO9eozCYWOs5Xe/pXLFrL3BLntD49eqntcUbxoZJbBvxHUoFYE00urAX5XPkdPtNhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCiAgICBUaGFuayB5b3UgZm9yIHJlbWluZGluZyBtZSwgSSB0aGluayBpdCdzIE9L
IHRvIGRyb3AgaXQuDQpNaW5nDQoNCj5NaW5nLA0KPg0KPkkgcmVjb21tZW5kIHJlcG9zdGluZyB0
aGlzIHBhdGNoIGlmIHlvdSBzdGlsbCB3YW50IGl0Lg0KPg0KPlJlZ2FyZHMsDQo+DQo+ICAgICAg
ICBIYW5zDQo+DQo+T24gMjQvMTEvMjAyMiAwOTo0OCwgSGFucyBWZXJrdWlsIHdyb3RlOg0KPj4g
Um9iLCBjYW4geW91IEFjayAob3IgbmFjaykgdGhpcyBvbGQgcGF0Y2g/IEl0IGxvb2tzIGxpa2Ug
aXQgd2FzDQo+PiBtaXNzZWQsIG1vc3QgbGlrZWx5IGJlY2F1c2UgdGhlIGRldmljZXRyZWUgTUwg
d2Fzbid0IENDZWQuDQo+Pg0KPj4gUmVnYXJkcywNCj4+DQo+PiAgICAgICBIYW5zDQo+Pg0KPj4g
T24gMTEvMDQvMjAyMiAwOTo0OCwgTWluZyBRaWFuIHdyb3RlOg0KPj4+IEh5cGhlbiBpcyByZWNv
bW1lbmRlZCBpbiBub2RlIG5hbWUgdGhhbiB1bmRlcnNjb3JlLg0KPj4+IFNvIGNoYW5nZSB0aGUg
bm9kZSBuYW1lIGZyb20gInZwdV9jb3JlIiB0byAidnB1LWNvcmUiDQo+Pj4NCj4+PiBTaWduZWQt
b2ZmLWJ5OiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPg0KPj4+IC0tLQ0KPj4+ICBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvYW1waGlvbix2cHUueWFtbCB8IDgN
Cj4+PiArKysrLS0tLQ0KPj4+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZWRpYS9hbXBoaW9uLHZwdS55YW1sDQo+Pj4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWVkaWEvYW1waGlvbix2cHUueWFtbA0KPj4+IGluZGV4IGE5ZDgw
ZWFlZWViNi4uYzBkODNkNzU1MjM5IDEwMDY0NA0KPj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9hbXBoaW9uLHZwdS55YW1sDQo+Pj4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL2FtcGhpb24sdnB1LnlhbWwNCj4+PiBA
QCAtNDcsNyArNDcsNyBAQCBwYXR0ZXJuUHJvcGVydGllczoNCj4+PiAgICAgICRyZWY6IC4uL21h
aWxib3gvZnNsLG11LnlhbWwjDQo+Pj4NCj4+Pg0KPj4+IC0gICJednB1X2NvcmVAWzAtOWEtZl0r
JCI6DQo+Pj4gKyAgIl52cHUtY29yZUBbMC05YS1mXSskIjoNCj4+PiAgICAgIGRlc2NyaXB0aW9u
Og0KPj4+ICAgICAgICBFYWNoIGNvcmUgY29ycmVzcG9uZCBhIGRlY29kZXIgb3IgZW5jb2Rlciwg
bmVlZCB0byBjb25maWd1cmUgdGhlbQ0KPj4+ICAgICAgICBzZXBhcmF0ZWx5LiBOWFAgaS5NWDhR
TSBTb0MgaGFzIG9uZSBkZWNvZGVyIGFuZCB0d28gZW5jb2RlciwNCj4+PiBpLk1YOFFYUCBTb0Mg
QEAgLTE0Myw3ICsxNDMsNyBAQCBleGFtcGxlczoNCj4+PiAgICAgICAgICBwb3dlci1kb21haW5z
ID0gPCZwZCBJTVhfU0NfUl9WUFVfTVVfMj47DQo+Pj4gICAgICAgIH07DQo+Pj4NCj4+PiAtICAg
ICAgdnB1X2NvcmUwOiB2cHVfY29yZUAyZDA4MDAwMCB7DQo+Pj4gKyAgICAgIHZwdV9jb3JlMDog
dnB1LWNvcmVAMmQwODAwMDAgew0KPj4+ICAgICAgICAgIGNvbXBhdGlibGUgPSAibnhwLGlteDhx
LXZwdS1kZWNvZGVyIjsNCj4+PiAgICAgICAgICByZWcgPSA8MHgyZDA4MDAwMCAweDEwMDAwPjsN
Cj4+PiAgICAgICAgICBwb3dlci1kb21haW5zID0gPCZwZCBJTVhfU0NfUl9WUFVfREVDXzA+OyBA
QCAtMTU0LDcgKzE1NCw3DQo+Pj4gQEAgZXhhbXBsZXM6DQo+Pj4gICAgICAgICAgbWVtb3J5LXJl
Z2lvbiA9IDwmZGVjb2Rlcl9ib290PiwgPCZkZWNvZGVyX3JwYz47DQo+Pj4gICAgICAgIH07DQo+
Pj4NCj4+PiAtICAgICAgdnB1X2NvcmUxOiB2cHVfY29yZUAyZDA5MDAwMCB7DQo+Pj4gKyAgICAg
IHZwdV9jb3JlMTogdnB1LWNvcmVAMmQwOTAwMDAgew0KPj4+ICAgICAgICAgIGNvbXBhdGlibGUg
PSAibnhwLGlteDhxLXZwdS1lbmNvZGVyIjsNCj4+PiAgICAgICAgICByZWcgPSA8MHgyZDA5MDAw
MCAweDEwMDAwPjsNCj4+PiAgICAgICAgICBwb3dlci1kb21haW5zID0gPCZwZCBJTVhfU0NfUl9W
UFVfRU5DXzA+OyBAQCAtMTY1LDcgKzE2NSw3DQo+Pj4gQEAgZXhhbXBsZXM6DQo+Pj4gICAgICAg
ICAgbWVtb3J5LXJlZ2lvbiA9IDwmZW5jb2RlcjFfYm9vdD4sIDwmZW5jb2RlcjFfcnBjPjsNCj4+
PiAgICAgICAgfTsNCj4+Pg0KPj4+IC0gICAgICB2cHVfY29yZTI6IHZwdV9jb3JlQDJkMGEwMDAw
IHsNCj4+PiArICAgICAgdnB1X2NvcmUyOiB2cHUtY29yZUAyZDBhMDAwMCB7DQo+Pj4gICAgICAg
ICAgcmVnID0gPDB4MmQwYTAwMDAgMHgxMDAwMD47DQo+Pj4gICAgICAgICAgY29tcGF0aWJsZSA9
ICJueHAsaW14OHEtdnB1LWVuY29kZXIiOw0KPj4+ICAgICAgICAgIHBvd2VyLWRvbWFpbnMgPSA8
JnBkIElNWF9TQ19SX1ZQVV9FTkNfMT47DQo+Pg0KDQo=
