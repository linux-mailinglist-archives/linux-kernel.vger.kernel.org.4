Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5F8711B43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 02:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjEZAdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 20:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjEZAdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 20:33:41 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E6AEE
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 17:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7dp7zm6n/dqif6RjZeSnDj3wMDMzdRzuQgJhw9maApZRKUrMl5GFJ2mOrkGz/aT2WiFBgLkUNFhExcT8hYJzJi19UWaG6tXu+U7RNLp1AdCGwo6jecow/ybTsFLNLjMY0w5U4o9yZdYXVj5G0/TZe8KTqAiIh9iaYfY+7UhnqEHsQ0sv2Y97IoGd5mtJDANMOYOKO2bTagKwxU/h3/1qP5XEM4mqWkt514d/bhM5VvZCkfqW1fbJWunCnr4+IkjKRN4Fy6sEMpzSbc5r2s3WOwCgDJgB2j0hTWj3s2qUq8SxnSKL0QuNhHHueudPnce1QTkVfS1HfM5F1xfaFUQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nDsa4rGp93bYQ4nJQ1nlrKYUr/Q41wEifORTs5E/wA=;
 b=mMR4rAw4PB/dgDw3jmWJSDX8RU87pphE/IxH80xe/kWEDd6aVjUyINSOMbcF7lnSBMiYaXEPyzc1osublBNCOhhoUio5dro/f6xHGxsxCKk1lV6YscZk1QPBRReHD4wKtDFXofhKNVTufBsRyOJUAABGQ5+P5SGDgKJ5O1mwq6AylNdJhOldHkAWhA6JzK4tpBYeTBFHOcz02Y6MFR82GOdJdgre7TpEzOhrXSfoi4zpQUcpFUYZpLe9aD59SQRpqX469Bm7HRUUWylcqDkkZgu/d68YMpUbzE3gGTVDoUIdt+jQa7D22KwQrf014qZWwLzb5opv5yg7ropST1iG8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nDsa4rGp93bYQ4nJQ1nlrKYUr/Q41wEifORTs5E/wA=;
 b=CmiX9toSkEGhT2s/vHmvY2e3AZWJljHznqc6qq2K9tElRK7jl5KhnJnkdhPm084dFyP45r9WYF+Ksv8uoWDccM8l0Yw0R6LbfXTnOjTLswLXxxVBK1pWnldwocBGRMQArR+EKNqXCPPZGvU6ZqU25FAvcKF5Jlp5dHMsyG0hG3A=
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by AS8PR04MB9094.eurprd04.prod.outlook.com (2603:10a6:20b:445::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Fri, 26 May
 2023 00:33:37 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::ebb7:2418:4038:925d]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::ebb7:2418:4038:925d%5]) with mapi id 15.20.6433.016; Fri, 26 May 2023
 00:33:36 +0000
From:   "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Subject: RE: [RFC PATCH] dma: coherent: respect to device 'dma-coherent'
 property
Thread-Topic: [RFC PATCH] dma: coherent: respect to device 'dma-coherent'
 property
Thread-Index: AQHZbqX64aqH8/sqmEm+RldR8MQMVa8tfJIAgAFAtvCAALVkgIABXOxggDsl29A=
Date:   Fri, 26 May 2023 00:33:36 +0000
Message-ID: <DB9PR04MB92361C6DF63AB009FE57A46C84479@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20230414080307.35114-1-Zhiqiang.Hou@nxp.com>
 <20230416063028.GA6276@lst.de>
 <DB9PR04MB9236E1467316DFEE177D5E9E849C9@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <42d401e9-57d2-1178-eb94-68f975be73e8@arm.com>
 <DB9PR04MB9236D992207FD9AC47CC1385849D9@DB9PR04MB9236.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB9236D992207FD9AC47CC1385849D9@DB9PR04MB9236.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|AS8PR04MB9094:EE_
x-ms-office365-filtering-correlation-id: b35f9112-6b9d-4e96-3c54-08db5d80d83a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RN859/KaRsqCGQMX0HudW01HDEY3YXvmKEdzKm+AQ1UhvTF2Oes7tLJbcY5P5CCuuU66OkY4d881TYRvb7Vc7/XfpaUuVcaF9LqhqohUFW5LTuCr0Texy/lH+Tf77nrtiVyNJ/kUyNnZwSXLsvpxi051W5CInzLh6WqOns7jkEDYgo7+LyCVRSQb/geAgn4wNPoXJsZjei8xseTIzKPm66xLGBP3rWUNmdiTySJdakty++kNI85nVAS1nnsIqaQ81WwRb5K5FpZav56hFAa8856/BKIlv6eQnQLYqAv5CRNofEq9EURCupHim8hhSBiUm0iKMAHmh3TFjg7hc31ISL/lK3yDMZZiR8om4FCID150r4DW/HkJMDAt54bbtJZmzphIKWPiwIZJW8MsCbYY3YbUN84XbTUQYCwlksiezKkiAkaMaXc7qfekHpP7GYqVD0fmjDe1Yt1U3mKgo7paU8/J7sV9mb4hwf7dpN+nnzNF9oUWgeXFDkfW+yAt9yoSr/GVFv1rJnMhpQDDcsLsbVLmSZhCPBsTL7136Z48wwd05qWbjLW2c5YbELbxiIh0CkoSWHweVJ5ft4TaiZeTNMnWm96/RbkgMnmrr4b1E+G4ZNoe0tIdI3f8xX3fUq1b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9236.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(4326008)(33656002)(55016003)(86362001)(53546011)(8676002)(8936002)(6506007)(9686003)(41300700001)(186003)(26005)(83380400001)(52536014)(76116006)(54906003)(316002)(66476007)(64756008)(66556008)(66446008)(66946007)(5660300002)(478600001)(71200400001)(7696005)(122000001)(38070700005)(38100700002)(2906002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2lGQW1jd3orRXlKZDVqN1haTFliN3BzdFBrTHFUWWZydWpaRnlzbkFlNU11?=
 =?utf-8?B?WVJJQ2xuK2IzRFlVQ2lYZG92U0V4cGNvVHFYY0t3b1gzZ29IWVNLMFdWZUFt?=
 =?utf-8?B?OUQwVGJOcnkvQWRHc1lRMm1YQkd1VU5GRHFxdFYzVWQ2U1FjTEtJa1h4MnVw?=
 =?utf-8?B?WDBaT3hYT1FKZ0hBU2J1eTFnRGhMYktkbTA1Q1U4VFZMVm5HUExvNkZPdTI1?=
 =?utf-8?B?czFIUmw3YytYUktvZTErQW1hbWU3VlZaaU53SWcvMWx5Rnh4RFR4VHlQeXdz?=
 =?utf-8?B?Sk55SWkzWEJKendaMWs5T2RXZjk4cCtUaG9XQkdvWUVMNktnZkthektrM0dj?=
 =?utf-8?B?MzhkTjdUMFBNUDY3TmQ4a1pITWxpWXd4ZjZweVZsU05tMkFWWkFXYlRtM2Vo?=
 =?utf-8?B?OHNjdTMxQ2RrQkJNWUZNMEx3enI1V2MrN0NsT1UvQzhXZWFwNldPcjEzUE5T?=
 =?utf-8?B?RUNOWVB5SGZFc2JGSE5DV3JNZmYydDlJQmVPU3g0aHkrWXdMM0gvZVd5NXRM?=
 =?utf-8?B?MTN2QjRHVHZpZUo2Ump0Zi9jcXd4bFBIbjIvVnpCdHByQ2M3L2k4cFhETWlu?=
 =?utf-8?B?MStRRStHd2RZa3RjNENoYnNxdkczdEVDcjB3WkRKZExYcVQvL3pTOHR5UHpG?=
 =?utf-8?B?K3pEYmVPRzRPd0xRN2h4RzY4TVoxQ0dWb2tRVkhEd1JFWXpGZDFwTmZuMEVi?=
 =?utf-8?B?Sy9GdVhSekk4c01PS04wSGgyd21Gam1WbXBjN0hNM0Z6b1VtaWJSSFFud3N3?=
 =?utf-8?B?OW0wbXIwWG5Peit0blE4N0dzQmJhTjZFY0ZRNXBwT2VJU1NzbnBJZ0U4T2sv?=
 =?utf-8?B?dHBXVG5rSE5SbUF3OFhHbSt2bDVnTFpMVHN5V0s3Z2hpOXZscUxmaldrZmlo?=
 =?utf-8?B?WkhuNkYzVXhUSGoyTSs4eFRnbGhjTnhYSlF4YXIydFI4WkJDektuUXBkRkxo?=
 =?utf-8?B?Nis1bEFFSUVOTlQ1MUlOREpCejNjbHJuMWQyYm9idnE0eDNySXJ6M3lnMDE3?=
 =?utf-8?B?N0pUS0ozWHZ2ays0TEpNMVZIdTRpbkNoWVhSbnNtKzgzRHJOUU5rMTNLT1ps?=
 =?utf-8?B?U0xHL1U3c0kvYUh6ZThrQmlwWDNZMEJGN21QeEhLaXdocmxxMExZUTMrcFQ4?=
 =?utf-8?B?MlVCUkFYUkhQUnlSZ1hJZWRKc0wwWVFUVzV0cHhqRGQxdUI3V0lRVERPODA5?=
 =?utf-8?B?QXo2WGp6eXltWnp0KzIwMUdOWHd1M0xxVGZtRXBqNkFNU0REQXgzdGpXanZn?=
 =?utf-8?B?THNZelRCdGc1TitmSmUrNWQ1Wm5Nd0FobkpLYlV2VlRFREpBU1I2eDBIOWJ0?=
 =?utf-8?B?Y2hOSWhma0FpZ21pWGdYVURxc2NRVnRZTmN6M0ZEV3lTS01UTDhVaG1ic1hS?=
 =?utf-8?B?ZGVCamNKOEl5Q3lmYmxpNWxxYklidzA3RkdFbVBOTmxQWG9rbHA4dzdQc2Ny?=
 =?utf-8?B?Wk1rbWRLc2JLWXFCa3h4cnNCQUtLNU1pT0dVdjFNMW52ekhSbkpLUG9xWllR?=
 =?utf-8?B?aWVJL2d4ZVFWWldGS3hjSjdmTnl4YS92UEZQdTJKRXBVbElwK09xYXQ3c2Ur?=
 =?utf-8?B?Sk9DY0ZWSElDL0ZKRHg5dXBQUFp0S3RoLzlEc1RhWmtiVDhldGJ0N1RrZ3ZU?=
 =?utf-8?B?bGltZzF2UnZVMWlNdytGOHFWbkxCS0did01ic3VmNmVDV01XQUNxNk8rWExv?=
 =?utf-8?B?V3dGS3QyY2hHVFVYN1VXdy91ODVqSUNDcDJ6eUNiRFo4TEFWVmJOT2c4Vjkx?=
 =?utf-8?B?UlFnQVp2bEVES2x6c0xMT3JLNVhucTVSSU5LM293R0gxVW4wMEV0ZUhqOW4v?=
 =?utf-8?B?c2Rja2Z3RkZaQk1VT25OUE1Ea2VvNzIvZEQ1QUlMVkRGMWs1Unlzang0QjBP?=
 =?utf-8?B?R3dFczJlRGNPa2QyVGVtZ1F1MlpYeDVpQSsvV29GVUdnRmdEeDB6YkZWTVdv?=
 =?utf-8?B?UkxneVRIbmdlYzA5eUV2L3E3Y1BZbkdtV0JubEVzbWpYK1dTSGd4cS9PSEVn?=
 =?utf-8?B?d205STVlYXpsajRnZ0QvQ3Y2amhUYkZPbExpMDhQTkJ0WS9iNFpObjRrMzNr?=
 =?utf-8?B?aEZDbTF5WUkwaDlYQWpQU0dUc1F0R2xSTE9MSWFMSEljcXRVdXlJMU9POU9P?=
 =?utf-8?Q?H8Obo4Uvi+SOu0/pZDHtQttNa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35f9112-6b9d-4e96-3c54-08db5d80d83a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 00:33:36.7468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcGfynUAF1iOMfpdoN9CimCK5lzzDb8e7pyVh6+fGd9bq+HXP54ezYOjaEG62DwZRO2sWlOwHk4prjbWemai2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWi5RLiBIb3UNCj4gU2Vu
dDogVHVlc2RheSwgQXByaWwgMTgsIDIwMjMgNTo1NiBQTQ0KPiBUbzogUm9iaW4gTXVycGh5IDxy
b2Jpbi5tdXJwaHlAYXJtLmNvbT47IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBD
YzogaW9tbXVAbGlzdHMubGludXguZGV2OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiBtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20NCj4gU3ViamVjdDogUkU6IFtSRkMgUEFUQ0hdIGRt
YTogY29oZXJlbnQ6IHJlc3BlY3QgdG8gZGV2aWNlICdkbWEtY29oZXJlbnQnDQo+IHByb3BlcnR5
DQo+IA0KPiBIaSBSb2JpbiwNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiA+IFNlbnQ6IE1v
bmRheSwgQXByaWwgMTcsIDIwMjMgODoyOCBQTQ0KPiA+IFRvOiBaLlEuIEhvdSA8emhpcWlhbmcu
aG91QG54cC5jb20+OyBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gPiBDYzogaW9t
bXVAbGlzdHMubGludXguZGV2OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+IG0u
c3p5cHJvd3NraUBzYW1zdW5nLmNvbQ0KPiA+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIXSBkbWE6
IGNvaGVyZW50OiByZXNwZWN0IHRvIGRldmljZSAnZG1hLWNvaGVyZW50Jw0KPiA+IHByb3BlcnR5
DQo+ID4NCj4gPiBPbiAyMDIzLTA0LTE3IDAzOjA2LCBaLlEuIEhvdSB3cm90ZToNCj4gPiA+IEhp
IENocmlzdG9waCwNCj4gPiA+DQo+ID4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiA+PiBGcm9tOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gPiA+PiBTZW50OiBT
dW5kYXksIEFwcmlsIDE2LCAyMDIzIDI6MzAgUE0NCj4gPiA+PiBUbzogWi5RLiBIb3UgPHpoaXFp
YW5nLmhvdUBueHAuY29tPg0KPiA+ID4+IENjOiBpb21tdUBsaXN0cy5saW51eC5kZXY7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPj4gaGNoQGxzdC5kZTsgbS5zenlwcm93c2tp
QHNhbXN1bmcuY29tOyByb2Jpbi5tdXJwaHlAYXJtLmNvbQ0KPiA+ID4+IFN1YmplY3Q6IFJlOiBb
UkZDIFBBVENIXSBkbWE6IGNvaGVyZW50OiByZXNwZWN0IHRvIGRldmljZSAnZG1hLWNvaGVyZW50
Jw0KPiA+ID4+IHByb3BlcnR5DQo+ID4gPj4NCj4gPiA+PiBPbiBGcmksIEFwciAxNCwgMjAyMyBh
dCAwNDowMzowN1BNICswODAwLCBaaGlxaWFuZyBIb3Ugd3JvdGU6DQo+ID4gPj4+IEZyb206IEhv
dSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gPj4+DQo+ID4gPj4+IEN1cnJl
bnRseSwgdGhlIGNvaGVyZW50IERNQSBtZW1vcnkgaXMgYWx3YXlzIG1hcHBlZCBhcw0KPiA+ID4+
PiB3cml0ZWNvbWJpbmUgYW5kIHVuY2FjaGVkLCBpZ25vcmVkIHRoZSAnZG1hLWNvaGVyZW50JyBw
cm9wZXJ0eSBpbg0KPiA+ID4+PiBkZXZpY2Ugbm9kZSwgdGhpcyBwYXRjaCBpcyB0byBtYXAgdGhl
IG1lbW9yeSBhcyB3cml0ZWJhY2sgYW5kDQo+ID4gPj4+IGNhY2hlZCB3aGVuIHRoZSBkZXZpY2Ug
aGFzICdkbWEtY29oZXJlbnQnIHByb3BlcnR5Lg0KPiA+ID4+DQo+ID4gPj4gV2hhdCBpcyB0aGUg
dXNlIGNhc2UgaGVyZT8gVGhlIHNvbWV3aGF0IG1pc25hbWVkIHBlci1kZXZpY2UNCj4gPiA+PiBj
b2hlcmVudCBtZW1vcnkgaXMgaW50ZW5kZWQgZm9yIHNtYWxsIHBlci1kZXZpY2UgcG9vbHMgb2Yg
c3JhbSBvcg0KPiA+ID4+IHN1Y2ggdXNlZCBmb3Igc3RhZ2luZyBtZW1vcnkuDQo+ID4gPg0KPiA+
ID4gSW4gbXkgY2FzZSwgdGhlcmUgYXJlIG11bHRpcGxlIENvcnRleC1BIGNvcmVzIHdpdGhpbiB0
aGUgY2x1c3RlciwgaW4NCj4gPiA+IHdoaWNoIGl0IGlzIGNhY2hlIGNvaGVyZW50LCB0aGV5IGFy
ZSBzcGxpdCBpbnRvIDIgaXNsYW5kIGZvciBydW5uaW5nDQo+ID4gPiBMaW51eCBhbmQNCj4gPiBS
VE9TIHJlc3BlY3RpdmVseS4NCj4gPiA+IEkgY3JlYXRlZCBhIHZpcnR1YWwgZGV2aWNlIGZvciBM
aW51eCBhbmQgUlRPUyBjb21tdW5pY2F0aW9uIHVzaW5nDQo+ID4gPiBzaGFyZWQNCj4gPiBtZW1v
cnkuDQo+ID4gPiBJbiBMaW51eCBzaWRlLCBJIGNyZWF0ZWQgYSBwZXItZGV2aWNlIGRtYSBtZW1v
cnkgcG9vbCBhbmQgYWRkZWQNCj4gPiAnZG1hLWNvaGVyZW50Jw0KPiA+ID4gZm9yIHRoZSB2aXJ0
dWFsIGRldmljZSwgYnV0IHRoZSBkYXRhIGluIHNoYXJlZCBtZW1vcnkgY2FuJ3QgYmUgc3luYw0K
PiA+ID4gdXAsIGZpbmFsbHkgZm91bmQgdGhlIHBlci1kZXZpY2UgZG1hIHBvb2wgaXMgYWx3YXlz
IG1hcHBlZCBhcw0KPiA+ID4gdW5jYWNoZWQsIHNvDQo+ID4gc3VibWl0dGVkIHRoaXMgZml4IHBh
dGNoLg0KPiA+DQo+ID4gWWVzLCBpbiBwcmluY2lwbGUgdGhpcyBzaG91bGQgYXBwbHkgc2ltaWxh
cmx5IHRvIHJlc3RyaWN0ZWQgRE1BIG9yDQo+ID4gY29uZmlkZW50aWFsIGNvbXB1dGUgVk1zIHdo
ZXJlIERNQSBidWZmZXJzIGFyZSB0byBiZSBhbGxvY2F0ZWQgZnJvbSBhDQo+ID4gcHJlZGV0ZXJt
aW5lZCBzaGFyZWQgbWVtb3J5IGFyZWEsIGFuZCBhIERUIHJlc2VydmVkLW1lbW9yeSByZWdpb24g
aXMNCj4gPiB1c2VkIGFzIGEgY29oZXJlbnQgcG9vbCB0byBhY2hpZXZlIHRoYXQuIFF1aXRlIGxp
a2VseSB0aGF0IHNvIGZhciB0aGlzDQo+ID4gaGFzIG9ubHkgYmVlbiBkb25lIHdpdGggbm9uLWNv
aGVyZW50IGhhcmR3YXJlIG9yIGluIHNvZnR3YXJlIG1vZGVscw0KPiA+IHdoZXJlIGEgbWlzbWF0
Y2ggaW4gbm9taW5hbCBjYWNoZWFiaWxpdHkgd2Fzbid0IG5vdGljZWFibGUuDQo+ID4NCj4gPiBJ
dCdzIGEgYml0IG5pY2hlLCBidXQgbm90IGVudGlyZWx5IHVucmVhc29uYWJsZS4NCj4gPg0KPiAN
Cj4gVW5kZXJzdGFuZCwgdGhpcyBjaGFuZ2UgZG9lc24ndCBhZmZlY3QgdGhlIG9uZXMgd2l0aG91
dCAnZG1hLWNvaGVyZW50JywgYW5kIGl0DQo+IGNhbiBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZSBs
ZXZlcmFnaW5nIHRoZSBoYXJkd2FyZSBjYWNoZSBjb2hlcmVudCBmZWF0dXJlLg0KPiBBbmQgaW4g
dGhlIENNQSwgaXQgbWFwcyB0aGUgbWVtb3J5IGFzIGNhY2hlYWJsZSB3aGVuIHRoZSBkZXZpY2Ug
bm9kZSBoYXMNCj4gJ2RtYS1jb2hlcmVudCcsIG90aGVyd2lzZSBub24tY2FjaGVhYmxlLg0KPiBT
byB0aGlzIGNoYW5nZSBhbGlnbnMgdGhlIGJlaGF2aW9yIG9mIHRoZSBwZXItZGV2aWNlIGRtYSBw
b29sIHRvIHRoZSBDTUEuDQoNCkFueSBjb21tZW50cywgaXMgaXQgYWNjZXB0YWJsZT8NCg0KVGhh
bmtzLA0KWmhpcWlhbmcNCg==
