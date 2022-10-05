Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5C75F4DA6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJECVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiJECU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:20:59 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2051.outbound.protection.outlook.com [40.107.215.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CB270E66
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 19:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X75i1G4aLN8qtXNZrwVonmi3j6TiVVOD/UV/cmUqGBGf13Jz3UQmQwYy1wWiGOT1lfpKInAQfgz/EIL5P1LUF743PRHFXgZhL3G3vgZ2jYd6nNRMzMxMjH6AvxBs6wQ6CkN49RcGL2hHH+1W07LibOVSdo7IQ0be44wjeJlYn7OIxF5Qv4z1tWnjo9NcpcmorR+LoIddMMDlhJDmiXOrP+ggJCYtO5nQL+MJk7Vm2M4xpKptAdmR1+veF3kg9kjzEK+dNq6hxRKNNb0HyfGZhQg5IhLAmlqLV95StYxFOAmbkMdBBQ8PXFPf8sJ+wXPq92/u5f29kRRRhrsgMDLhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28Mp1zXpvYVUndkUwOG52NUhMowkMkCaa/LjC5a+iyU=;
 b=JBgyeD63zox5jb2R+B8mbZk2jvvfeZsenK4a3wS8brGyqeJq+teO4iury3NIUE+VRDy7DB0Kah7IRcRotfxWK7pQzYKVXgWL3fSK8RQPYT4fpi3JuF5ynVZaXtBoPh6+T103f9cz71GLF9ZQlEduw6d0Uz2pGexaUXmTLoEt7xVbaeOYdVU5d3mPphkOjhq8RkjSGlZKraCcZZmq+npeBkOuNocODPdYINcrkR8wqs8juP7zAxly1S7Wgt6KYjGUEyneYHFXd/u8RayfAcGlnn5VjTThFeWg87mLUtea4cTVZua5j6jT3NH/KdF8knGl3+lFmrukH3jULQZ6bZNatQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28Mp1zXpvYVUndkUwOG52NUhMowkMkCaa/LjC5a+iyU=;
 b=CIS6ndioQP3822nVd2iGJtm0SNxP9klAdwWzMb8ptHzdj8m0KK2QjbeWSzaAdlL+SA/pWe4KcBi2Sc9x2qEJGVDeSHseiVpvKERXo7JOpog5et5O21UYM03vuDlXjvBKocbF9gqYv/R6fvYikB9AGZRgLadorZZGNaTe1JVB+HQCl2reUq/eqkG2euWbeH8IR9WsrqKowqAD7zrkFrzoK0JQB2iQSumsKTVIAIk0KDv/PFVYrDQUk/jzRv3vjRtFtOYL3LrnDSyiFmk86doEMssLfrN/WS+94w3FpOJxl1Ysfj7PsfzHe4B4EJwkymlkjizhxPrweEwaDym566OKIA==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by PUZPR06MB5500.apcprd06.prod.outlook.com (2603:1096:301:ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Wed, 5 Oct
 2022 02:20:51 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d%6]) with mapi id 15.20.5676.028; Wed, 5 Oct 2022
 02:20:51 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] virtio_pci: avoid to request intx irq if pin is zero
Thread-Topic: [PATCH v3] virtio_pci: avoid to request intx irq if pin is zero
Thread-Index: AQHY0yebkLnVnpUrcE6HW0uIsHnQ0K31sJaAgACTNjA=
Date:   Wed, 5 Oct 2022 02:20:50 +0000
Message-ID: <TY2PR06MB3424577F435AF6EBFBDB6260855D9@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20220928104628.521-1-angus.chen@jaguarmicro.com>
 <CACGkMEtaMRifeDDDk3kb7QY-1mO1V2t6PFjgRXwRoN8NbRaD=A@mail.gmail.com>
In-Reply-To: <CACGkMEtaMRifeDDDk3kb7QY-1mO1V2t6PFjgRXwRoN8NbRaD=A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|PUZPR06MB5500:EE_
x-ms-office365-filtering-correlation-id: 4d8e6507-e7d4-4104-cf6f-08daa678390e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 83iu9j7+0B6WC1u8tZMMs8XtMvQZ5Obswdm+1gbS2+YR7xXCIDaag8oWMz1QT6Tx2UYVWY48wiht88355RzuV17lyUm2wghWj47zhU1CCO6RDL6kgJnCDKxrFsTa8UWrLeXOT6ibXHMjhzLaymfPEvuFpfULJ6gpOdEqDC42IfkToGixphfXqZKGRzxx7Qk2Il8kMIgR1BB1bLaEUscp5pKlMPhwFEXz1XOFPP8HNdnkRv6tfQNFCe6iLoqPz/RArEAFRmesIaPohDLCPc2kxNvPIpI4MTryipWTSabuwciJHF1J4FGfgIfVg9Qsa7Uj7jpTvDnkUi4YwhKrH0huDz3tvS32ObHM909KIuExnmQ2TWRPy3ypQ10hduDzLBBPI3JT73ydMMzxWTs3eKGLPn7sb7Eh43oBv3s+0ii53Y4bVAfS0WAETOyW0RlehnxIuKGpnWS6+GZsAk0rpHXKrOD7HyqqkQbXQtYCGb+jetEmX0iZiO8kVPuZoanBpSv0FK04LRHyARJYyqjNpJy9UBDuabeJSoVj8jQCf0cIaVNUBQqnONJAMQiyOXBTYgwqIC6S2RptL83UCt77Pagu4kac4e7uVFrnZX3AShcuWPzPwpU5LKqpm+yRYsUc9ffx3g03NausUAw87mVGi1YgIWn43k1p86waxWiTEyDdG9iG9cjNRIKHoshFSIjkxRzQq/csUdVhpWZqrSo/Gz6xYhKL5sjhyeLdKgbj0XbgKvbV+HAuwiKiqh7w1ZH63Pwn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39830400003)(451199015)(186003)(83380400001)(9686003)(6506007)(53546011)(122000001)(26005)(33656002)(7696005)(54906003)(38100700002)(2906002)(316002)(86362001)(66946007)(5660300002)(44832011)(478600001)(8676002)(4744005)(55016003)(41300700001)(38070700005)(66476007)(66556008)(6916009)(66446008)(64756008)(8936002)(76116006)(71200400001)(52536014)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkR6U0VjT05lY0RoMFNuRE5OeVZlbE40NzJFcmJYRzZWbGxzMGlSd3FtMk5o?=
 =?utf-8?B?UjQzRGtkaHdHZzRkQllzaGxKaWx4L0kvOXFsOTlQY3A4ZzBvb0o1aHZXUXht?=
 =?utf-8?B?YjZ4VDdKWndLMnViN1hGQzlYaUN6RnBpYlZwb3ZNcXozQnYzTmd2WThUL24v?=
 =?utf-8?B?QncxZjdlYjZzMFg0WTlaQlM2NGczM21DTWRZK2VJSU9zTnA0TndOQTZtRmFv?=
 =?utf-8?B?c293WnR3K0Z0UXVLVzVaTjV4dVhTa3NoSVJJQkdna3c2VFhxM3hMRGdRN0I2?=
 =?utf-8?B?RWVHUkJacDhzdTdGdjFKWDJHbkhJaVI1Vm80ZDZkTXFhUEFuWS9vUjlLR0Rs?=
 =?utf-8?B?KzdNNjFRNWlVTlgxVjROZVRJYXNMc24xTGkzU2g0YXhwekNyR2hxZWpkYlg3?=
 =?utf-8?B?V3RTbXp5a203bUxqd2loMk9JQmJIMUo5ME4vOWxzaFc2eVMrU0NodklPVXJk?=
 =?utf-8?B?Uk1uajVEeUxRMThUTnRLRmtaRUpqd0cyakFmek5icTZ3cTNhS3hUZXowZXY1?=
 =?utf-8?B?OGdEU2MyRWVyd0wzOUF1aUw2V1NvWFR4aGEwN2EwQVBBc0J5Nlc1Z3dBbjJB?=
 =?utf-8?B?aHRKcEthcHh3ZDZIMTZwSFFOY01hOUhXcmt5Qk1sUEFNL1pGekFpYkI1MEdC?=
 =?utf-8?B?SHNxWWZSOE9uVmw1eCtqSmZKTzRIWVkrSDFRSkRBVy84anhXbW4xeGJVaDJR?=
 =?utf-8?B?d3ZVajNvZWJKK2J0OExJcy9MSDNsTjhYSjhaZHh5VUtFVU41TytydFgrbEV6?=
 =?utf-8?B?clpCNldRbU5ydHVyQjI0OS9WWkowd01ldFFjZXFrdlBmVHNJZ0VxdjhzOWxJ?=
 =?utf-8?B?RVdtbE8yajQyYlpvS2pRZTFHdFY1Wi90c2hET1pocTQ2OTdwQ1FZY3JiOXl4?=
 =?utf-8?B?Ull4T0NOWTI3c1QxUG9mZnhLSFpkZDRQMERNdWp5blRzOWpUUG1JZmNCdmg1?=
 =?utf-8?B?OHpnazBodG9Td1lrTXRHVDlwMHVtOXQvN2ZsUG5FSTJaeHBPT1o2U0JEeDcv?=
 =?utf-8?B?L3RoRi9VVllWV0ZGdTRLRU94OFhwS2hJcEJHT3RMYWR0bG13VUJzWjRta3Fi?=
 =?utf-8?B?UkU1cllJRXlyUDdVYzNLdmxpaGpyVFlsQnNYOE9odFgzbmdrTnVnTnMrUWho?=
 =?utf-8?B?UUdLVHR3WjZHRUs5WW42RjBMOGxaUERtcTVuazQvR2Nqem9vQ1hCdlYvUElz?=
 =?utf-8?B?d3o4NnA2UTR6Si8xL1RUTjg4V2dHci90dXhHZ3VFMkMweVE4dFpnL0VKT2ln?=
 =?utf-8?B?TnRCSnowSURFTWEyUG42aHdWc20zaExEOW1uQlJXRkU0cHZtYWc5Qzllak5Q?=
 =?utf-8?B?SlIzeGl5bkptT1YwM1R6eFhKWnNvaE1IOUppcmsrVGRqZVNHYnVrSVdOdHk1?=
 =?utf-8?B?cFdYdXN2WmtZZDlZdW5MNHdSdnhtc1BOV3VJWXVIQUoyTDlXYXdlODRVaFRk?=
 =?utf-8?B?bU5HK3lITjRPS3RyTUlTL2lYam5RRUF4cFZuZEV5TkE2azNIK3Rja3owMk9l?=
 =?utf-8?B?dDJmdjVLTHZJMFVLckRjTjlQcy9xY2RWQTRkRDFSMnpTaGEweUdlOVUzdmk3?=
 =?utf-8?B?Sm83WHloL0szTzBVSGVLUGlDa0xZME1mMjhncXk2Mk1YK0JsWFYweVoxeW1r?=
 =?utf-8?B?cUhtdUlGMktnbFpmQmlFUUxTSkNvY2gvU0duUkJxYXJMcDVzQnptWUZ2V1Ez?=
 =?utf-8?B?U2hnZEhKZlZIMFZ6ZTNuczRxRW5KUnFlWVc2TkwvcHlnR001SHEzTkVPSG5H?=
 =?utf-8?B?V1ArZTRQZkFIUUNXRmVmQUxtLzhKeW9qTVZVLzI1alhiYXNaaTVhL0dveC9C?=
 =?utf-8?B?cmZvTHJya1ZIa2p0TzVhSzNpSnFrWHdOek1EbGZLUmdqdk1sSnV5ZlpTUHFi?=
 =?utf-8?B?bE15OFpQS0pTL3pWSmtTZ3QzLzltdVhvbnBsWXZkRk81UXFlN1owU2R3K3ZW?=
 =?utf-8?B?b2dycmNWWUFyKzgxUkdqYjJkVjUxRTIvdkZ4Z1ZUenRXMkc4RHgwMlBhQjVC?=
 =?utf-8?B?UjhWUXhnWUhFSFlUR2hORkFjaTVOc2ZlMEV5bERoQXNURTVSN25uMlBCSlpI?=
 =?utf-8?B?TzNhSFB0V0lJYnpKQmtJS0lzRHMweFpaeG51eDZrUUxNT0NTMWdyd2RSOXBL?=
 =?utf-8?Q?tuZvuJwpNfJ3Bb3GxZhMLEgwt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8e6507-e7d4-4104-cf6f-08daa678390e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 02:20:50.9748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2RFT41DtzXqT6e8aR4CU+1BwtSo2m44VfJDRC4zyE2iZn+jL0s17S8lvUHteDCjcTkg8wyv/QRfiNu9lgyc6WZDpMikoP9+LcHr8FZgPZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gV2VkLCBTZXAgMjgsIDIwMjIgYXQgNjo0NyBQTSBBbmd1cyBDaGVuIDxhbmd1cy5j
aGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgYmFja2dyb3VuZCBp
cyB0aGF0IHdlIHVzZSBkcHUgaW4gY2xvdWQgY29tcHV0aW5nLHRoZSBhcmNoIGlzIHg4Niw4MA0K
PiA+IGNvcmVzLldlIHdpbGwgaGF2ZSBhIGxvdHMgb2YgdmlydGlvIGRldmljZXMsbGlrZSA1MTIg
b3IgbW9yZS4NCj4gPiBXaGVuIHdlIHByb2JlIGFib3V0IDIwMCB2aXJ0aW9fYmxrIGRldmljZXMs
aXQgd2lsbCBmYWlsIGFuZA0KPiA+IHRoZSBzdGFjayBpcyBwcmludCBhcyBmb2xsb3dzOg0KPiAN
Cj4gTm90IGZvciB0aGlzIHBhdGNoLCBidXQgSSB3b25kZXIgaWYgaXQncyB0aW1lIHRvIGludHJv
ZHVjZSBwZXIgY3B1DQo+IHZpcnRpbyBpbnRlcnJ1cHRzIGluc3RlYWQgb2YgcGVyIGRldmljZSBv
bmVzPyBUaGlzIG1heSBoZWxwIGluIHRoaXMNCj4gY2FzZS4NClRoaXMgcGF0Y2ggaXMganVzdCBw
cmV2ZW50IHRoZSBkZXZpY2UNCndoaWNoIGhhdmUgbm8gaW50eCBzdXBwb3J0IHRvIHJlcXVlc3Qg
SU5UWC4NCkl0IGNhbiBiZSBvY2N1ciB3aGVuIG1zaXggaXMgb3V0IG9mIG1lbW9yeSBvciBvdXQg
b2YgaXJxIA0KQ2FwYWJpbGl0eSBldGMuDQpTbyBjb3VsZCB5b3UgcGxzIGhlbHAgdG8gcmV2aWV3
IHRoaXMgcGF0Y2ggZmlyc3Q/DQoNClRoYW5rIHlvdS4NCj4gDQo+IFRoYW5rcw0KPiANCj4gPg0K
DQo=
