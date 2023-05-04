Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3536F71A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjEDR7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDR7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:59:14 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020018.outbound.protection.outlook.com [52.101.61.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD2740F3
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOUXaq0XCOU4c5ivzeE5+Vqzv/ypHiilGdCwx9I6UzrCrPfyIkIoDNLZ7rfPiizBvJzqYewdMaxb21b6mg2ZQ8Kb2tDo+EE9wUJEP+L4q5ggbvtRmnKGREBf8qnoyep/hNovWY7gJiOccVSDpN7TODAlqc0JRP7tH3gHLqylMG1SZGIWskiaI0L9FPPuZtFzJw1cBjLGmFDM8wPxvHo3fFBhSeNPXEN0ZggFGGz3s0SyAbZg81jZbDyKQppY2MzNq7bH0aQ70Q6k0yi2O8nDyT8p504A6uJo5Eg1d5ONmz1FCr/ucxn4xw5TmKe9tOVhKBF3vfJtT36Gqqmk496R7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52Dsg9lAp3NBVU5s0m5ydx9gc0kbcE2+yvNXSbvQz30=;
 b=AJ8W5AyEbMR2ICzwA//b5ltlc1hNdcanc84wUFohpGrgRuz/GOLsgyJ28zwMj5ipEdn5KLYcxkYGaMsE2q8tUGX93YO2mA3Umivu/uyPDYOETbN8aq3FNDmt17sg1uujy3bbjHOhIZRuLM1ZPw6yGTi0bKYGerKoykGVxZW8uD3hdxEIlS67Bb2XetqYRbLn6NB+A9UNEKfPOvVbUxfXOBd0hcctAp3iQrk66nTqGw+DEtdwxr4XVFwEb41ndVHJXNFucoK4EDPXJEAPfy4OPB1NVx/KWdoUGChE15/s9z7uK/F+ZLMbG9d02ie4tu8Hp9X2G6xBZUaAJ9T3Rw7LMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52Dsg9lAp3NBVU5s0m5ydx9gc0kbcE2+yvNXSbvQz30=;
 b=EzQ5/6H3PoH//mGZQo6vfwDcCy5C/hx4mo63M80iE5zw2DL+JPqzoNaTixcYZfRLsambm+cwK4PKnl0Kzt75ZhgGyxSjpFmwpvsLwwyaGVgiNf+I8Mv0LJ0nVMeqZG1qGj+7uu2IcgaXvHHKLPEmAwyClbiew7whJnCWiP+aYrw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3271.namprd21.prod.outlook.com (2603:10b6:8:7f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20; Thu, 4 May 2023 17:59:10 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a0f:a04d:69bd:e622]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a0f:a04d:69bd:e622%4]) with mapi id 15.20.6387.011; Thu, 4 May 2023
 17:59:10 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Ben Greear <greearb@candelatech.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Hang loading initrd since last Friday.
Thread-Topic: Hang loading initrd since last Friday.
Thread-Index: AQHZfTr2qR4xve2R+0yhSMLHlSGWLq9H1EyAgAAlpYCAAT9/AIABJi8AgAAJFvA=
Date:   Thu, 4 May 2023 17:59:10 +0000
Message-ID: <BYAPR21MB168889708435D073352C4A46D76D9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <9d87defc-5376-d690-b483-bc314e4f568b@candelatech.com>
 <ZFHHh/m0pkOYIzo7@debian.me>
 <ebb280e4-d381-0bf8-d134-0318c5cfdf83@leemhuis.info>
 <f12a8f23-5aac-b615-300c-38001b9583c2@candelatech.com>
 <a227583c-ef41-e954-fd4c-0cdb23c77222@candelatech.com>
In-Reply-To: <a227583c-ef41-e954-fd4c-0cdb23c77222@candelatech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2c49936a-e739-49b1-ab47-49f69cbe1795;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-04T17:55:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3271:EE_
x-ms-office365-filtering-correlation-id: 0303cc94-87b2-46c6-ad5f-08db4cc94383
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bPdY7u/kt9KJGZO11ekZoAwECN5b8mFwwEh121EaoV3vCrNEqfLNtbtz94KThrEOWQZeuCmSBmE5RMYy/20Pm9NE8VsfF3RakY5Kl4gxlWRrbXFltqziyNaHx4xQD3n1Tn1eOC4JsY9FzaH4NBNo8KMCIDSf9bF/mpq47KB68JXfNi2o9hFf6F87bBXKhxAvgQDHut6qZo6Qf7JJMF83DxrrSYLkSUk7xHHfJQ3S/jNPQuFN02gTdM91WzAaL65O3+UJh/t4ZRdeqkYPCarGmWqvXJ+mUHaSgq/tsXHmhdgzDsLyxjW+0H8f3ZO/JQ+SFHEOCnxI+OgdFRzkcmXWeRYhmv1p8kwpZO/XdoXzSWSApq8gLCZWPx+n3Ek4qzJ3Vz5I4OFCs8ad74As8nre9Ki4lUuKiQa5X5rLG2ZTjmGajRBLL8ejCvo5Mb24SQKr3c+egkbW3zQ4ib2OTUutPshcOJSIe3xA6+Flwo8GmrhwxNXf8rI+jGUgd4DWvm0C2BAmaQP7oN2SQ5sLG9o0yIzMYqNi3Ii/elsWqU1Vt+2Ya0aKw4iqzLpF+gvS8lNjE+D3mSnHDlxtuv3kDK2ELKPwaY6ZYwi223tOJG1NZSEbArvQ6ru2ysaTHUAITtkUGh7GzCGA3m40YR8ZVgl3uTZuTJqzB0dW6Je/CLY6HGc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199021)(478600001)(82950400001)(55016003)(64756008)(66556008)(66476007)(5660300002)(110136005)(316002)(66446008)(8936002)(26005)(82960400001)(8676002)(76116006)(786003)(38100700002)(66946007)(122000001)(41300700001)(52536014)(71200400001)(53546011)(9686003)(6506007)(7696005)(10290500003)(186003)(38070700005)(86362001)(2906002)(8990500004)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWhSU2lPck1MZmVGekNzdEl2Z2trTXZhY1Arci9RdlNsdVVhSUV4b0tHOEZS?=
 =?utf-8?B?R1VOdkEwaU96SW90V1ZCN1E0eUgrd21Ca2NCa1JhOUVQZVhqSEM1bnhQR25D?=
 =?utf-8?B?ZUlxYUtQL0pJMFM1TWhzRTRNbUgwc1NNUkxBUTNPbWI3VzErOFZpRTQ5cURp?=
 =?utf-8?B?YnhtRG5kL0wvNkJJTTd2MmFmK08rNHY5dmdtb08zWVdoS3JIVlhmb2lLL2I4?=
 =?utf-8?B?MjRka2tRWWtZdEExQTFjTTQrVEdqQm9EQm10blQ3MEEvTzF0eFFaZEdUb0k0?=
 =?utf-8?B?Sy9rWldCd3BFZEdWUG9ybE10MG04d0pEWGlCdWpCKzVxODJVZ0E3Z21LK3ZO?=
 =?utf-8?B?U3ZyVWEwWVlGYVVwakwxbEVKd1BCRVVrbFQ4UDhIczlBb2oySjdTbEVXQWVa?=
 =?utf-8?B?UTRiNExTdkh5VldVT3lPTU5vOFlyUVJpbUduZm9TaGc4Qjc4WTZnUVl0d0V2?=
 =?utf-8?B?eDlCVHlEeEtZWGpiSUl4WnBqdTlhU0pMZTFGVzFDRW5uOXB0a3ozcitPQTJ5?=
 =?utf-8?B?bzAvUks5YTFPZ2xwSnd2QzJsSExxeDBaeXo3NnhaT1RhbVVINjJFeFEwRVUx?=
 =?utf-8?B?T1pidmdaVWJzT0piRlZCN2RLOW9WSER0VXBkQlZJMjc5TGdsdVJYeGJTcmJR?=
 =?utf-8?B?V2JXcWFZTEFpMFNuV21UQkZHZkpPazl3VFcwc3h0NUUxQ0dabjBxWGxzQ1ZE?=
 =?utf-8?B?S0tIYklTcXFQRUhxaC8wcHYvWUlCMVVlREZWVGVzcU40VTFDRlV3M3NiVGYv?=
 =?utf-8?B?U3M4b0YzSVdTcDVETGJ6V09BSlpLUHhISFVUeFFOd0FVV3kxN3FabVBkMmE4?=
 =?utf-8?B?MmM3Y3lYazVnWGNJMkNOME13UUkvQkpabWc4YTVSVEQ2Y1hRSXRQWk5vc3VL?=
 =?utf-8?B?azBXckliN214U2I5QWVIdGJ0KzJ0dXB2TDRoeUhWNEJURHIzY3F5Wkl0ZlI2?=
 =?utf-8?B?MmprTlBWVlZCK3VhZHhSWmJTektOTDhGbytNWDcyR2V1OEhHOGc3dE1seDNh?=
 =?utf-8?B?LzRvMmFjNkhKU281NGJjYjlSOE41SHBNNGFiWENLQkdrbGFnSUp5NFUxZ2d3?=
 =?utf-8?B?cnR1UHVEZmRoQytsd2Z5TldWVklocTMxWmt1eGtML0Vob2g3OXMwaDZWazZS?=
 =?utf-8?B?Vkh0Qi9URXM0TnREMVVoSlVlQS94eWh5RjNwb0cvL3c2Zi9jSjV4dEtIcjJn?=
 =?utf-8?B?Q2lOS1B0dDNJcGxxR05VRW43MVRoZjBkV00yUXkrSzFnRUN1S2lkWW9uOVVO?=
 =?utf-8?B?RS82ZHd5dGZsc3VvMGU5bVJNd1pkZ29ZcEQ3TDUzWDFWS1NnNHVZTDVyeVlW?=
 =?utf-8?B?Tk5Ma1pnVGRPMEsydXJ6V25JTmt3MXRIaFhLTGpiMmx0T3Zjam5ic1QxTmxT?=
 =?utf-8?B?Mm1Rbm5qbThEY2l4TXg1Q0MwSzMydkJFVTdaVDZOM1Q4Q014WU50REE4ZzRP?=
 =?utf-8?B?RXJUeDl4TDN2TWRLTmdRc28xQWxLeXl2Ri8yaFpocmFtbDd6ZG8rK0hjOElH?=
 =?utf-8?B?ZkRRRjhVb2xjRHZKa3dWOUc5eXFFS1BVcC82NFRWRU5xMU9ZWVlXb3JDckt6?=
 =?utf-8?B?L0x0MDljL0FJUWExNzZtYlJPcnpIME9lUDhMbEEyWkZaUFpHVXJpUGtDYzMw?=
 =?utf-8?B?RVpsWkwyZktSVVdsRWhNT3M3MThBRFFZdmxpZm9RaEp3ZHVRN2hGNlFqdHVS?=
 =?utf-8?B?ZXVPVXdMNzVYWVhuMVZibGsremloU24vb1U2SEY5MkFvSjBzeGtBeittaEZ0?=
 =?utf-8?B?THlkWTRQVzYrbkMvZW9KaGwrNEU5VGJPN1NLZDRzZjZWek1oSVVIYzVXd0pz?=
 =?utf-8?B?SjZ3NTU0LzRXdHM0SCtURlg5RlVORVRwdmxtM1hLamtwaktWK1d3NVBhdlNy?=
 =?utf-8?B?azNObE1qOGZtUnZSejZoakMrbjZkdWQ0RktRN25VME5sTFV3YXpyRThKVFVS?=
 =?utf-8?B?MUhBM0F6Rlo5RTQyRVgvNzZYckp0YkN2WXQ3MEN6OG1XRkZuZ0tOdHl0cit5?=
 =?utf-8?B?NjEzQ1c0bGthYkdWblZxVTZpbldJaGdxUFJ0UWRHNDRuVVBMdGhONDVPRlJp?=
 =?utf-8?B?aXJUZHB4NXkwYVhuY3J4NE9ycm9FVXIxbldPKzJZT1lrSml3eUxmL0daZVdz?=
 =?utf-8?B?TlF5YmNrdThyemVSVUZuNXljUTF3TjhYTHQySVRFajNCTkdGaXJ5OFRWcHYw?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0303cc94-87b2-46c6-ad5f-08db4cc94383
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 17:59:10.7451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SC8FFuB6Rc6Xu1c8YMoFFUCrVJgy/X8QZQyAtQWGukiysz8p+JrGOa5MSTtl28Lgcr5hZL/zUvu+GAZ/AJknGePiZWlI197B5yQWrIEReSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3271
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQmVuIEdyZWVhciA8Z3JlZWFyYkBjYW5kZWxhdGVjaC5jb20+IFNlbnQ6IFRodXJzZGF5
LCBNYXkgNCwgMjAyMyAxMDoyMyBBTQ0KPiANCj4gT24gNS8zLzIzIDE2OjQ5LCBCZW4gR3JlZWFy
IHdyb3RlOg0KPiA+IE9uIDUvMi8yMyAyMTo0NiwgTGludXggcmVncmVzc2lvbiB0cmFja2luZyAo
VGhvcnN0ZW4gTGVlbWh1aXMpIHdyb3RlOg0KPiA+PiBPbiAwMy4wNS4yMyAwNDozMSwgQmFnYXMg
U2FuamF5YSB3cm90ZToNCj4gPj4+IE9uIFR1ZSwgTWF5IDAyLCAyMDIzIGF0IDAyOjAzOjMzUE0g
LTA3MDAsIEJlbiBHcmVlYXIgd3JvdGU6DQo+ID4+Pj4NCj4gPj4+PiBQdWxsaW5nIHRvZGF5J3Mg
dXBzdHJlYW0gNi4zKyB0cmVlLCBteSBzeXN0ZW0gbm93IGhhbmdzIGxvYWRpbmcgaW5pdHJkLg0K
PiA+Pg0KPiA+PiBKdXN0IHRvIHVuZGVyc3RhbmQgdGhpcyBwcm9wZXJseTogeW91IG1lYW4gYWZ0
ZXIgdGhlIGJvb3QgbG9hZGVyIHNhaWQgaXQNCj4gPj4gbG9hZGVkIHRoZSBpbml0cmFtZnMsIG5v
dCB3aGVuIHRoZSBrZXJuZWwgc3RhcnRzIHVzaW5nIGl0Pw0KPiA+DQo+ID4gSSBhbSBiaXNlY3Rp
bmcuLi5pdCBhcHBlYXJzIHRvIGJlIC5jb25maWcgcmVsYXRlZC7CoCBJZiBJIHNraXAgZW5hYmxp
bmcgdGhpbmdzDQo+ID4gZHVyaW5nIGJpc2VjdCwgdGhlbiBJIGRvIG5vdCBzZWUgdGhlIHByb2Js
ZW0uwqAgQnV0IEkgY29waWVkIG15IG9yaWdpbmFsIGJ1Z2d5IC5jb25maWcNCj4gPiBpbnRvIGFu
IG90aGVyd2lzZSBnb29kIGtlcm5lbCBjb21taXQsIGFuZCBub3cgaXQgZmFpbHMuwqAgSSdtIG1h
bnVhbGx5IGJpc2VjdGluZw0KPiA+IHRoZSAuY29uZmlnIHNldHRpbmdzLi4uLg0KPiANCj4gSSBo
YWQgZW5hYmxlZCB0aGlzIG9wdGlvbjogIENPTkZJR19IWVBFUlZfVlRMX01PREUNCj4gDQo+IEFu
ZCB0aGF0IG1ha2VzIGl0IG5vdCBib290LiAgTm90IHN1cmUgdGhhdCBpcyBleHBlY3RlZCBvciBu
b3QsIGJ1dA0KPiBJIHdpbGwgc2ltcGx5IHVuLXNlbGVjdCBpdCBhbmQgY29udGludWUgb24sIGFz
IEkgZG8gbm90IGFjdHVhbGx5IG5lZWQgdGhhdCBmZWF0dXJlLg0KPiANCg0KV2hhdCB5b3Ugb2Jz
ZXJ2ZWQgaXMgZXhwZWN0ZWQgd2hlbiBDT05GSUdfSFlQRVJWX1ZUTF9NT0RFIGlzIHNlbGVjdGVk
LA0Kd2hpY2ggaXMgd2h5IGl0IGRlZmF1bHRzIHRvIE4uICBUaGUgY29tbWVudCBmb3IgdGhhdCBv
cHRpb24gaW4gdGhlIEtjb25maWcgZmlsZSBzYXlzOg0KDQoJICBTZWxlY3QgdGhpcyBvcHRpb24g
dG8gYnVpbGQgYSBMaW51eCBrZXJuZWwgdG8gcnVuIGF0IGEgVlRMIG90aGVyIHRoYW4NCgkgIHRo
ZSBub3JtYWwgVlRMMCwgd2hpY2ggY3VycmVudGx5IGlzIG9ubHkgVlRMMi4gIFRoaXMgb3B0aW9u
DQoJICBpbml0aWFsaXplcyB0aGUgeDg2IHBsYXRmb3JtIGZvciBWVEwyLCBhbmQgYWRkcyB0aGUg
YWJpbGl0eSB0byBib290DQoJICBzZWNvbmRhcnkgQ1BVcyBkaXJlY3RseSBpbnRvIDY0LWJpdCBj
b250ZXh0IGFzIHJlcXVpcmVkIGZvciBWVExzIG90aGVyDQoJICB0aGFuIDAuICBBIGtlcm5lbCBi
dWlsdCB3aXRoIHRoaXMgb3B0aW9uIG11c3QgcnVuIGF0IFZUTDIsIGFuZCB3aWxsDQoJICBub3Qg
cnVuIGFzIGEgbm9ybWFsIGd1ZXN0Lg0KDQpOb3RlIHRoZSBsYXN0IHNlbnRlbmNlLg0KDQpNaWNo
YWVsDQo=
