Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503016A6614
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCADAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCADAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:00:39 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9445123326;
        Tue, 28 Feb 2023 19:00:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPLDJcMUwOkXSA+gX36zHZSDQ+RjaBTNZBTMKuyMaZZ8wUhInjgqiHcLjVn8q1RPYO70vRKedy44jACZNpIl4cQvJMakUVAXJBhJoUtz4htFdxNIQcKPJmwJ3z5JHMurEqPVgMzVegK9vFbZMQ/ycFL5uAYMflaa+VzzSPhMcZMZmAFpNr5dibH1tzbpN7YjHJ90OwCrXM5E5sjt6pxkLWqD6t38tFlBWHosIa79xPRymPlC/UGKMWUsWm+0HL2dCzjpXBwLgFgAw3piD3OJnzRpl5qoTtP4B3V9cZTXY6Ri5HifAmlBPrnPob/OXdDL9VxPb7kiH9GLTqFoQt1jcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4aLVYPBkb1XrJbBIj8R0FBgPkSkdlfTIXRH4Uryfps=;
 b=fA5HKw3jChBe9ReW5RG4U16u6Mw0CZXqNfByN426yqPd3oRCW6fd6hMISeFOi8bqGBIRw4s6B143i8JK4gqa2Nq2A81BmHtYTY24CvI6sCQxiETBSoXLz35YmhAF3IA2J1wMawVT1yBlVCe2MjYjXI/6vz65PhczGMvf1yBL9bO1KA0Wlp9bdJLz0n+7DPqqL22HPYA4jgAwgDLk8nLopr3JGb5fvxAf+7Zg84WtQAEFm24flFIQSiV4mSbbsZhMGbD4FQvPY9nG8cJaRggBCN76tPL0BHkr0iPSaBQYdpviK0vRD4zRvCMR7dP9i8oG3oduB+0lLH4R4B9o6hNCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4aLVYPBkb1XrJbBIj8R0FBgPkSkdlfTIXRH4Uryfps=;
 b=iXj1XIZaZmo+AERwocRGI7Xd+xYGd0FRJyQqggozvBFUHD0+kwKqkjqDeMSRJZZF+WELKBPymxOWylFPqnnNrmdAkVntT8EFEEY2Ft86MuEFNQqRu8SeaKGbTNCdAd15K6syFYBv6uT6qloavuWw8gAjlUavm1zWiKxv/URaCQ4=
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by DBAPR04MB7335.eurprd04.prod.outlook.com (2603:10a6:10:1b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 03:00:23 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 03:00:23 +0000
From:   "J.D. Yue" <jindong.yue@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 4/6] PM: domains: Export
 genpd_dev_pm_attach_by_name()
Thread-Topic: [EXT] Re: [PATCH 4/6] PM: domains: Export
 genpd_dev_pm_attach_by_name()
Thread-Index: AQHZS0qZ6YhnN46vo0qycvMFZqhYoa7kKCGAgAEUAVA=
Date:   Wed, 1 Mar 2023 03:00:22 +0000
Message-ID: <GV1PR04MB91839451082E48FA8C3BD48AFBAD9@GV1PR04MB9183.eurprd04.prod.outlook.com>
References: <20230228080619.412820-1-jindong.yue@nxp.com>
 <CAPDyKFqR=Agf77bpgUvVKRw0V4p2-1c0bKYjjDCgr3VP3ij64w@mail.gmail.com>
In-Reply-To: <CAPDyKFqR=Agf77bpgUvVKRw0V4p2-1c0bKYjjDCgr3VP3ij64w@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB9183:EE_|DBAPR04MB7335:EE_
x-ms-office365-filtering-correlation-id: f666fe22-831b-4f9c-0231-08db1a011983
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: anrCgqDAUYPV9Krpb6icYxTI4SaLYANibhsVNOQuKSm8VBlv+ON+a7pyNrBgPS4GZZWXQuWZp1rwS5ioeWn6sBc7eaNYG9XTOOPrAB8jRil0DfDvw8g1LdIm8N3cnd4qYHZuP7fQKj9buWWN4+sELfD2MgKeJixmkTZE4XK3WV8jbxBFjLMSTFcoqy2AyDzEwCEyIFKyuI+gAUUCum9pEEtlEpZux0sInHsxCcTjoJajnhSXxV/dc85tD9e1BnWOfBzw6XUhMVu2nYD029mTUePTw6WlY8oBRkw/FR5m1U0WQ+efIEynYUvQjzUC8hfkuAHAve1aCXJeaMlej6I9Fia11Wh4yLxAfRpjGcS4JTe+6MknFFgZCu/3K/cssPKuUEM2zMj58UBSG1li2J5dbqKPWePfm2OvuipV7F6M0OwdBN1Yj0bGHxxMYkgahh0rVHswoZRSQSu0llarX7x63TVQKhRm7Idkyn1F+n43c7eGG5DwpYlMSoCXrOeVgastxAEh5njy+RomC1gPFH+nyS6duvsK0cJTgCM82QllSHK+f0pI6zDTuxZe2bS5wagZTIlaqO9GkiqEQ0V8QKYkgop9UvlUOguat5GMmunexASOcQQYMAXsmulxSmSG3kMmsjTfXgUp4HmaYKDWFzVG0D2niKABmh7bpM9rE1RxesBfzDH8ynrsf6D8tceVFuT4qdSeAqakpvqmBWbaB0fGMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199018)(8676002)(4326008)(33656002)(86362001)(66946007)(66556008)(66446008)(64756008)(5660300002)(66476007)(8936002)(7416002)(6916009)(55016003)(2906002)(38100700002)(38070700005)(41300700001)(122000001)(71200400001)(52536014)(54906003)(478600001)(316002)(7696005)(76116006)(83380400001)(26005)(186003)(9686003)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjhxV0trWnVEUU1ZMW5VMFY5UUFnem03SkRJUHQ3dnlNOWJoTW9zU3JUanRi?=
 =?utf-8?B?SHArRGxMSkQva21mcHdlUW9pVmJPSWZZMzNSb1l0UFJIc3d6R3MweE1vSzVP?=
 =?utf-8?B?NFI2c1lFVGR2Sk53THhCb29ZaGpGbjVzLzBJYVNEWEFvQ3kvbG45OTRLZjNP?=
 =?utf-8?B?N21qbW5obXdvNTFpYmxJZTVLTWpkenJFK2pPdzJxZ1F2LzB4Ly8zTkVrWC9l?=
 =?utf-8?B?Z0ZOb1llM0VWbjYxaEJ4a29nVXhLbTN2SjlrZ0JKN1hqWXREWldIWjFkNDAx?=
 =?utf-8?B?S2lwakhNaVpzTTNwL2RadGxrUzR3OVlxenBqckxocEk3ZlUyUUtxM2o5cUZm?=
 =?utf-8?B?ZmM1d2Nwd0J0MFJoWWxjN0xZNkhFd3hQS0dvNERFanFHRmtHTlcyNVI5ejcy?=
 =?utf-8?B?aFdhbVovNExZTVVrcloxUVNTS2ZBN2ZBalVHN3h1Qmd2dGlTZ09TaFMvaHA2?=
 =?utf-8?B?UDhrRSszL2V6eWRFZjR1d2FGbnpGcHNhcjArR2NXVUZCaVNRSWszdnlPWmNI?=
 =?utf-8?B?SUo3RmJGMEszNjgvTkh2K3BJWm5zQzNhd2I4WnVJZlVSTlRvVUE2UkNsck9G?=
 =?utf-8?B?cEk4c1piK2lIeWhNaVZ5VkE2eGpKRGk3OTVHcjkzaVMyL3VwWWZJZnhtQlNO?=
 =?utf-8?B?OGJCYXIvTzBkWnd5T2dhc3haMUtUVjdCSmpFZTdSTHhtY1NnWUNmbS9udXdp?=
 =?utf-8?B?TGVUKzkycGxYaFM1cnQ3VmRid3lWQURTdmVrdlBQWVYwdXRtZDdPQzRjYUFw?=
 =?utf-8?B?a0FpUlRNT0JJUlhzTEwzNmwvQ1d2aW9MTzVrN2FFeDJycVJGTU9xSUtFZEZJ?=
 =?utf-8?B?ZmQzcVZiclFZVER4enUwaGFjdmJzNWw0cklsZCtKU1krRFJwcXpqZnJvcUNQ?=
 =?utf-8?B?bTJEa1RtblBPZVRaVmxCbFJ4cFFGSGdxZ202WkhqZWdnMzNtcVRveFZKSmdJ?=
 =?utf-8?B?VlNiWCtCeFdNMTUrWStUY1VlbFg0QUZRb0MxdTY1T1o4RjN2dVFzRGhFdmQr?=
 =?utf-8?B?YlovK0cyUm1oYXpJdWszbTAxQ0o0QldCL2RNYnEwUFozYW13ZS9RcytPRzhF?=
 =?utf-8?B?ZXBLQlRhM3RmQ0ZKQ2FWL3YvR0xpL3QwZzdWQm1kZ3lBeHFWTDRqaUpsanpG?=
 =?utf-8?B?aUhjbDJSZWNyMmxPU3FRdDh1RGhtcG5lZU9lVCsvdDMzZE1SQ0d2MmJ1ZkFx?=
 =?utf-8?B?WDludUJTWEd3b3J4Y1B4cmExZWRtZmx0N2ErazdHZXQyOWdBNTJpSlEyVUVR?=
 =?utf-8?B?Z2wwRnY0VFZhdSs2SlRnTG92aTFob1gvUnpyUHh1WVNQVndkQ0xmbUdTUkp5?=
 =?utf-8?B?aVlLZkh5ZjN4cFdIekV6K1JiZm5NVVA5TUp3Ri9KNGgwQ2F2eTNtNEY1VGtt?=
 =?utf-8?B?NzF3UDI2b2RTRm90WDVOd1hLaWFqVlg2Rkd4Y1ZwVnhpL251VEdBdGttd2dq?=
 =?utf-8?B?RHI3cHc3UkVmQjZvQ0hmNHlyVUZGa2ZkMnpZZGRQa0RlRUpKN0dDYnpVcUhU?=
 =?utf-8?B?cng1SXgydmhWdlZ1b2w2QWh6ZkZCdGsyZFJZYTFhMjZCdVFaYTdRcjFRcG0x?=
 =?utf-8?B?dXB4L0owZ2lOWUpPS3BRYTVtMDRyYnBzSEdVdEdkdWY5QUMwK2Y2dmlnVjJl?=
 =?utf-8?B?aTBYV0pzbmZ1NmZRRUtKZlVadjgyU0VGeklPMEZLdlVOcE1vVjVZOXdvYWtn?=
 =?utf-8?B?UUM4cW5rNkltYXZHMHN6WEFzcENWL3YzaVBKSlhyTitXWFZUQ3FKOWtmWDVm?=
 =?utf-8?B?UGJtbkw3dkdBbWRZUUNFOEN1cFBhVUpMVzFqQTdGbWJSK2pJM2hmMjZQYmcy?=
 =?utf-8?B?YTIrRUVDQ1JlTGZSVi85cGR0UEE0RUF4Tkt4NlhuN0lqMjhsMllaZ2U5V0R0?=
 =?utf-8?B?c2Zzd1UzMkhEZ09SZmhOVG96YWJMVW9WbDNnZmlicTJ4TE1mdGpNL25xc3Yw?=
 =?utf-8?B?ZWw0NHd5RllDL1FPdXdGMy9pV0VnS3RoMnVDUEdjcy9abjNkaXhBS2FzZjNT?=
 =?utf-8?B?K3FDeG80T205eit4cVdRU2RFVGpiajhYV1VOVVk2andxa2srUTdnNXFvYVYz?=
 =?utf-8?B?NVhwZysxelA0dGFwT1NkcGMwR1VjRUROcmNDS2wvWG5qVEVyZmNsdEx1d0hO?=
 =?utf-8?Q?z/bqpeZTfETRUGUM/LBef4n7b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f666fe22-831b-4f9c-0231-08db1a011983
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 03:00:22.8051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xk9Hvjv3rECfMiMDXj7yh3AkQtU5fW6kstRYmtchDtOdFFrcMNlec2GiHenIJSJ7Na4Qc45P4d16+QuXPCMr5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7335
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFVsZiBIYW5zc29uIDx1bGYu
aGFuc3NvbkBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyOCwgMjAyMyA2
OjI4IFBNDQo+IFRvOiBKLkQuIFl1ZSA8amluZG9uZy55dWVAbnhwLmNvbT4NCj4gQ2M6IHJhZmFl
bEBrZXJuZWwub3JnOyBraGlsbWFuQGtlcm5lbC5vcmc7IHBhdmVsQHVjdy5jejsNCj4gbGVuLmJy
b3duQGludGVsLmNvbTsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IHNoYXduZ3VvQGtlcm5l
bC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPjsNCj4gbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggNC82XSBQTTogZG9tYWluczogRXhw
b3J0DQo+IGdlbnBkX2Rldl9wbV9hdHRhY2hfYnlfbmFtZSgpDQo+IA0KPiBDYXV0aW9uOiBFWFQg
RW1haWwNCj4gDQo+IE9uIFR1ZSwgMjggRmViIDIwMjMgYXQgMDg6NTksIEppbmRvbmcgWXVlIDxq
aW5kb25nLnl1ZUBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBnZW5wZF9kZXZfcG1fYXR0
YWNoX2J5X25hbWUoKSBhbGxvd3MgYSBkZXZpY2UgdG8gYmUgYXNzb2NpYXRlZA0KPiA+IHdpdGgg
aXRzIFBNIGRvbWFpbiBieSBuYW1lLg0KPiA+DQo+ID4gRXhwb3J0IGl0IGZvciB1c2UgYnkga2Vy
bmVsIG1vZHVsZXMsIHN1Y2ggYXMgdGhlIGkuTVg4TSBibGstY3RybCBkcml2ZXJzOg0KPiA+IGlt
eDhtLWJsay1jdHJsIGFuZCBpbXg4bXAtYmxrLWN0cmwuDQo+IA0KPiBUaGUgZ2VucGRfZGV2X3Bt
X2F0dGFjaF9ieV8qKCkgYXJlIG5vdCBpbnRlbmRlZCB0byBiZSB1c2VkIGJ5IGFueQ0KPiBjb25z
dW1lciBkcml2ZXJzIGF0IGFsbC4gSW5zdGVhZCwgcGxlYXNlIHVzZQ0KPiBkZXZfcG1fZG9tYWlu
X2F0dGFjaF9ieV8qKCkgaW5zdGVhZC4NCg0KVGhhbmtzLCBJIGp1c3QgdGVzdGVkIGRldl9wbV9k
b21haW5fYXR0YWNoX2J5XyooKSB3b3JrcyBmb3IgbWUuIEkgd2lsbCBkcm9wIHRoaXMgcGF0Y2gg
YW5kIGZpeCBpdCBpbiBkcml2ZXIuDQoNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaW5k
b25nIFl1ZSA8amluZG9uZy55dWVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9iYXNl
L3Bvd2VyL2RvbWFpbi5jIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9wb3dlci9kb21haW4uYyBiL2Ry
aXZlcnMvYmFzZS9wb3dlci9kb21haW4uYw0KPiA+IGluZGV4IDMyMDg0ZTM4YjczZC4uNmQ2NmI2
YjE0ODYzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmFzZS9wb3dlci9kb21haW4uYw0KPiA+
ICsrKyBiL2RyaXZlcnMvYmFzZS9wb3dlci9kb21haW4uYw0KPiA+IEBAIC0yOTA4LDYgKzI5MDgs
NyBAQCBzdHJ1Y3QgZGV2aWNlDQo+ID4gKmdlbnBkX2Rldl9wbV9hdHRhY2hfYnlfbmFtZShzdHJ1
Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKm5hbWUpDQo+ID4NCj4gPiAgICAgICAgIHJldHVy
biBnZW5wZF9kZXZfcG1fYXR0YWNoX2J5X2lkKGRldiwgaW5kZXgpOyAgfQ0KPiA+ICtFWFBPUlRf
U1lNQk9MX0dQTChnZW5wZF9kZXZfcG1fYXR0YWNoX2J5X25hbWUpOw0KPiA+DQo+ID4gIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlkbGVfc3RhdGVfbWF0Y2hbXSA9IHsNCj4gPiAg
ICAgICAgIHsgLmNvbXBhdGlibGUgPSAiZG9tYWluLWlkbGUtc3RhdGUiLCB9LA0KPiA+IC0tDQo+
ID4gMi4zNi4wDQo+ID4NCj4gDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQoNCkJScywNCkppbmRv
bmcNCg==
