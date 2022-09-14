Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8C85B85EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiINKIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiINKH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:07:59 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2051.outbound.protection.outlook.com [40.107.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A595A2E9E5;
        Wed, 14 Sep 2022 03:07:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KB9yRRKLfkNz3Sub+KthAfEsYXMjqteGPohOV8LD1pzpHiwZDF0hjNPC76MTqcFdtHbO4kwkKlGlbwiqlh1tCIrzKCwDEOV9gxRpvcGNAj1dLybCoVZo7AP4rFgeWyG7t5Kn9nHafEEKOehY82AL+qfiVWDZQjbPTzKxVnYbSPDVHLeAsscSupbKDoCA1HKD4ewEnBW016tIlye9ZQs2pMf4EqKZLYwiBkuMX8vCripi/i1dNy8bptei0oo97tj1reXklZ4G89WK72iq7H1UvfSfs4RUPzoVaxk2pbs/XZfjoTaGFq8BA9pzl9xdx8Y2VbJYLRX4D5ImWduFE/TRVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfOxi/VO7KQE2TlPu2iersPhtohFbUyb8Tm218Aepio=;
 b=Z+s8Oo1A3A5j3051A1H8wwsNss//KWp3LRjb5Y/gvS/ybq51b58A8/OdCwwkOFTRSIxesZ5NYiN4X9bY2LgP+YJZ9O/ftEhRire14cwM0RER7lIDSYaCdr64ykKlaBUdE/9B/h65XjM6Z/CTfh6g6oecUezNAfPQBmAoUk3irRBBkYaFAOaLAH4CckLhWlVbjIyeh17JvyyGHgxuPuU4aKt1IHFdzNCyDtA74Qbh+MXib/3gQr+Yu7HIFHf2LzxkQECagXst56Zgri/fEbL+/gWpiidcM+sqMWsDeI5M15sDE5ZPVFVpGuUlnXL/wYNuk6xhVsVPkDWS59lz3JUrkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfOxi/VO7KQE2TlPu2iersPhtohFbUyb8Tm218Aepio=;
 b=DU9YfAlTuvZ/cSQqxztALNeKcjP/808cDEUT7xF5NY8K3kMrNFvWQ3TzLO/dp0wK9C0RaELZuMaL/mQoiUrpezaI1g6xXXP3YzZJSzFdXtdSleiBmgmD617dA2xvOAgL+mbi9mGgw1UPT3GQSnlNAlrV3FpkOfLNyzyjrC57tuWxCcKHaz9ifNYTHINaeCJz1nsFBztsj7yzhFQQHhUVycB5htT3+t2QeAiux/8U8Q/yf93btTLyuGGtC3CkXmO2Yz6ojQ5uatdP1YYowFIMKLzAP5qLrpTrj9cKdsSrzJbhhyaA205CeXzrxnv8WwNeydN24HigE1iaGLYVGtQP6A==
Received: from DM5PR12MB2406.namprd12.prod.outlook.com (2603:10b6:4:b7::23) by
 BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.19; Wed, 14 Sep 2022 10:07:56 +0000
Received: from DM5PR12MB2406.namprd12.prod.outlook.com
 ([fe80::393c:2a84:46aa:3177]) by DM5PR12MB2406.namprd12.prod.outlook.com
 ([fe80::393c:2a84:46aa:3177%4]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 10:07:56 +0000
From:   Prathamesh Shete <pshete@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Aniruddha Tvs Rao <anrao@nvidia.com>,
        Suresh Mangipudi <smangipudi@nvidia.com>
Subject: RE: [PATCH] mmc: sdhci-tegra: Issue CMD and DAT resets together
Thread-Topic: [PATCH] mmc: sdhci-tegra: Issue CMD and DAT resets together
Thread-Index: AQHYxqtwL1Xa8rIj5USzpEyJ7gxEPa3b4OeAgALVQsA=
Date:   Wed, 14 Sep 2022 10:07:56 +0000
Message-ID: <DM5PR12MB240627CC683C5C7A2F008A6EB7469@DM5PR12MB2406.namprd12.prod.outlook.com>
References: <20220912132728.18383-1-pshete@nvidia.com>
 <bb5d73ad-67de-6f73-c131-363178696736@nvidia.com>
In-Reply-To: <bb5d73ad-67de-6f73-c131-363178696736@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2406:EE_|BL1PR12MB5144:EE_
x-ms-office365-filtering-correlation-id: df4b7123-27fa-49f8-ae04-08da9638feed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ategrK5a/0kLHuZMdQx6L9zgie46IIged/mrY5Yrubodbx5yL/x+7Ojl1VPKGFeC/LMfXlHGFaAa8VgR1NO0RGSljwDGrKBnN0lcOyIF7xowJdYfksdkUlBTWgp1ksV7/IhNHornZ3pVrxhP81S4WZe1/z5Ir3wdqtni70TAtoKHdq2jJif7BEGEYJwcmg8AO75Tiot2WaHAJREbJjM8vWtTp+vtViFWkjX7xwAUKdgfsp9fIMMcXS2RoHfIAqv7SQHVZm4AvAeMBui9RMEQQTQ0jXJaGNHViNQQjl6PHw/EY7hC0cHpcBM4JE4gsdFNQGhrq0poNKFZJ/i14RTPD9fwboGyG1cMJGEV67PQdaIWVqJzxKisCoiwdkLPzAlQW69GLkhw65wOr7DzmOdGKfk6sKEUXrF/kKeAwlSugZavTuQvPGA+0n0rKxwHXmghBdKPryk6l3WjxFHMPklrLqHqF4N6P2BR2PaXBvqMvLsGltkt4WORGN2Yy0TPowP+21oU7xrRnqbt9L9r1ttPqI4F1viE4w7ecRw5DBN9ENgVw+F2tWXG5hNSbAbD9fXAYgqWLyS0kAPPkNfHGpYg4aJT/+c4DEt8vLBhYVHah31BHzDTW37EmZOlVHL4WabSmtQFlOzvfx+ppEVZUWIc4K05Ckx36fO8jVh7peT79+1CDTTg1TsrbGX03pxTgda4N/xrQzhyU+oqHL0PcsbknUjN+kfPGaW5atSrjn/VbdMBSUI9JCnVt122ruyloF/rAFAo+MfLPw2sAIJpOA2GwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2406.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(66476007)(8676002)(38070700005)(2906002)(55016003)(9686003)(86362001)(41300700001)(53546011)(316002)(107886003)(186003)(8936002)(110136005)(6506007)(26005)(64756008)(5660300002)(66946007)(54906003)(122000001)(83380400001)(478600001)(71200400001)(33656002)(7696005)(4326008)(66556008)(76116006)(66446008)(52536014)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2VDUzljS1JLdnJROGRudktIeGQ5dlEvQWFMaVFFRGZMdlphaUJ4Z25xOUI0?=
 =?utf-8?B?QmVuSmFxVWNsU0UxVDIzcjg4anpuK0h0Yloxa0xFWGZtRitMd011V2xwdzQx?=
 =?utf-8?B?WGs3TWJlcTVBYUdqN2Q3bWhNdTN5N1RFbnlPUURkaUQrZElLbWhNWjlZUkRV?=
 =?utf-8?B?ZmVKaE8xMEhFb3pmbzdvaUN4WnlmTHpnb2lJVUxmVTFKM09JSW5OYWVwOHYx?=
 =?utf-8?B?cFVsREFIakZsRzBwdmhHd0hMYU96RURpd2grSlFISkxlYm1IZk9hbFNyOE5p?=
 =?utf-8?B?N3ErMEZKSkxGRWR5YkRkeldzZnJKdE5RUm1Sd1l0THZPamdkN3VSbzlSaTVE?=
 =?utf-8?B?MnJtMnV1b09ZZUhvZ1RNOUtuV3FWdk55VDUzbk5zUzBCb2NWVlN2VHVucHRH?=
 =?utf-8?B?cHJMdDFaM1VOS0hvbWZIWFc4MCtHVE4vT1haWU1SZFZGMjEyVHhMRXNpbU9w?=
 =?utf-8?B?ZG5lUkVvM21YUDJXQ0xsQnpqMEh3ek5nUlo3UzlDQ2hoQjl5UnpZQm1Vc1hn?=
 =?utf-8?B?YlJYTzNRaUZoOVhoam00b2cyMlMvRmNJS1hkV2pxMzFTQlpZY08yczNnK1ox?=
 =?utf-8?B?UFVMdkIzM1gzSDcxcTV2dnhBU29La0dWdllYTTBYZFF6WEY0Zmt5M2J5bHBp?=
 =?utf-8?B?QnFtWUlhd2ZDM0FrYUVGY0szUGgyZkd1SHJCYkZsQ3RWVTR1UDh5d1FSUWZH?=
 =?utf-8?B?V0dwYnltWDdaYVFGaE5VWnpJYXhGQzlQeG1UOGFiU2dyQUNmb0RTaEpVM2Mz?=
 =?utf-8?B?ZFhtWXVvZndPUGljdFVMRDVjMmduMERTOENHbUxXYWI1UGNNMXlIRysxSjE0?=
 =?utf-8?B?dzhkTVI0TVN0SFdrUUdXeFAzYmo5R1E2bm5ZVGVYWE5aU1NRWWFiaHpUNVVG?=
 =?utf-8?B?VnJVU3M2N1E3OFFMVWt6aFVlbUxLUGJwSjZST3RVZjZ0K3oyRk9QRmlkeTB5?=
 =?utf-8?B?TUw2UlBlMjJZL2crRmlDM3NnQkpWaDBNQzB3d1lFcDNTZzJTT2xhT1dnT0Ja?=
 =?utf-8?B?Zld1WXNLNkVPNURGcHQvMVBkeU9RMFJ6ejFaNjFvaXFhOVVHdTc1ZVF0YnFq?=
 =?utf-8?B?ekZ0Z2RPMmcyemtROUNhNEtUck9XUkthMWFZWmVXNEVhd0pJblVtSG1RNmlx?=
 =?utf-8?B?T29DVE5IQ3hQdFZFeGZQU08rbDdzYkRMRGN5OWx0d3FCaTQ0MjRSOWNlVlBW?=
 =?utf-8?B?bGQ4MjR6Z0t3bEtGaGpDbCtxUDEvdWxFNGk4QXlJcFcyem5EbDlRM01rVTc1?=
 =?utf-8?B?NnFlRE51c2srb3NTR2RLODNnZngwUlN3T2NWVmhYSEx5QXliU2czWWpsWlBv?=
 =?utf-8?B?MWRHb1B4RWRwcUVvdnI1YXB0QUtCaWR0eUY1ekkvOUVhMy9PNlVZSFQ2cE1J?=
 =?utf-8?B?OEowWng5aXQxUktCY3YxU1d4M3c4U2R2ckVGdCt3QzBsdjdxVmpNVjlkY2R5?=
 =?utf-8?B?VENreUFWL2Zlam45SXdJL3BNRzI5cGVTUUQ1RFJ0YXRCaE8ydVBpSm8zSFRL?=
 =?utf-8?B?VGswSkJxRmtVSzNrcko1Y3pIQytGZERsQmdPZXdUV3NSWFVWSjBsNERiQkdX?=
 =?utf-8?B?SFZzME1iazhCL2ZYQ2VGNVMzRzdaR3lId2RGZjBYbDNxV2k3VVdJUUF5elFF?=
 =?utf-8?B?ckY5YXhFa0dYZThrOFZqZlBxTkpSdUlxR0czNSswS2dOWVpYdHh4aW5nUW0v?=
 =?utf-8?B?RkZsN1hPRUUvUU5sYnExeXl3cXlYSlh3V0NEZVNVTFM0UEJSK0loa0RPUTdQ?=
 =?utf-8?B?WTFtTHBqQy9IZWdhZitDU0dxMWh5Tnpubm9wRHVubTdCQjRGbGplVWxMSFkr?=
 =?utf-8?B?ckhZdnovNFBiL01wUTZQcm5qV2RJUTF4cGltRUdaKzZDY2JXY1V1aTU3d0s1?=
 =?utf-8?B?TE5aL3E5UDhaV1V6WUE3YnhpRFVaTWdjWXpmNHN0Sk5PdDRjeTVzcDVqMXEw?=
 =?utf-8?B?MG04YVpPZGRNMGNzK3NWaGZleHIrSm9XSGJHWm9NbDBRbk9uK2pFR3g3WVNL?=
 =?utf-8?B?ZzNsZGFoRGZqWmI4RWZvZzMvZURaNXZNYXFtaC9EdXVHYWk3a1U2SWZCVG9N?=
 =?utf-8?B?cngvR3d1bXlhNjFZNU4xVndJQ3gxaDRDTnI0QzZEaDhhZnB4eUZlL1h2NDZV?=
 =?utf-8?Q?QinI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2406.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4b7123-27fa-49f8-ae04-08da9638feed
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 10:07:56.5514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2CZjoQOQOy9tDD8O7snOCfbHz/kk8kyHfsr0HdXtYN6LPU4YdMwl6TKMbg1CIZ8KvLYG7a8hXmEdE+qOLsOOEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gSHVudGVy
IDxqb25hdGhhbmhAbnZpZGlhLmNvbT4NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMTIsIDIw
MjIgODoyMSBQTQ0KPiBUbzogUHJhdGhhbWVzaCBTaGV0ZSA8cHNoZXRlQG52aWRpYS5jb20+OyBh
ZHJpYW4uaHVudGVyQGludGVsLmNvbTsNCj4gdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgdGhpZXJy
eS5yZWRpbmdAZ21haWwuY29tOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOw0KPiBsaW51eC1tbWNA
dmdlci5rZXJuZWwub3JnOyBsaW51eC10ZWdyYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBBbmlydWRkaGEgVHZzIFJhbyA8YW5yYW9AbnZp
ZGlhLmNvbT47IFN1cmVzaCBNYW5naXB1ZGkNCj4gPHNtYW5naXB1ZGlAbnZpZGlhLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gbW1jOiBzZGhjaS10ZWdyYTogSXNzdWUgQ01EIGFuZCBEQVQg
cmVzZXRzIHRvZ2V0aGVyDQo+IA0KPiANCj4gT24gMTIvMDkvMjAyMiAxNDoyNywgUHJhdGhhbWVz
aCBTaGV0ZSB3cm90ZToNCj4gPiBJbiBjYXNlIG9mIGVycm9yIGNvbmRpdGlvbiB0byBhdm9pZCBz
eXN0ZW0gY3Jhc2ggVGVncmEgU0RNTUMNCj4gPiBjb250cm9sbGVyIHJlcXVpcmVzIENNRCBhbmQg
REFUIHJlc2V0cyBpc3N1ZWQgdG9nZXRoZXIuDQo+ID4NCj4gPiBUaGlzIGlzIGFwcGxpY2FibGUg
dG8gVGVnYXIxODYgYW5kIGxhdGVyIGNoaXBzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5p
cnVkZGhhIFRWUyBSYW8gPGFucmFvQG52aWRpYS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJh
dGhhbWVzaCBTaGV0ZSA8cHNoZXRlQG52aWRpYS5jb20+DQo+IA0KPiANCj4gVGhpcyBpcyBhIGJp
dCBjb25mdXNpbmcgLi4uIHRoZXJlIGlzIGEgc2VyaWVzIHdpdGggMiBwYXRjaGVzIGFuZCB0aGVu
IHRoaXMgb25lLiBUaGlzDQo+IG9uZSBkb2VzIG5vdCBhcHBseSBvbiB0b3Agb2YgdGhlIG90aGVy
IDIuIEhvd2V2ZXIsIGxvb2tzIHNvbWV3aGF0IHJlbGF0ZWQgdG8NCj4gcGF0Y2ggMS8yIGluIHRo
ZSBzZXJpZXMgYmVjYXVzZSBpdCBpcyBjaGFuZ2luZyB0aGUgc2FtZSBkYXRhIHN0cnVjdHVyZS4g
UHJvYmFibHkNCj4gYmVzdCB0byBzZW5kIGFsbCAzIGluIGEgc2luZ2xlIHNlcmllcy4NCkFncmVl
ZC4gQ29tYmluZWQgYW5kIHB1c2hlZCB2ZXJzaW9uMiANClRoYW5rcw0KUHJhdGhhbWVzaC4NCj4g
DQo+IEpvbg0KPiANCj4gLS0NCj4gbnZwdWJsaWMNCg==
