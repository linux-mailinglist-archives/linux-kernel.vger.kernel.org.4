Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2E55BCDAE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiISNxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiISNw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:52:59 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2134.outbound.protection.outlook.com [40.107.114.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C190126121;
        Mon, 19 Sep 2022 06:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch3qs/DUNl1Mm/GKeU89wF4g1Djziu0d5NgMjmndVBtgS2OXYS6cjjITIMhoJQvTAhiSxdjVZcmSM6xYgmh38n7iUinTCj2UtAg15VEdiBrGmcdsx5/p97DQDzh00sznDYBWtvdporkNJtjoie/wjcTg/GNK1Z1SUY6gl6/uX6ym2S1uvi8d42egmPmtLFCrm4dCAfyimRqOJhfCEGm5RFvHRxhPeJS4BCwRvty+ERX91WKuYsJq/OYA0JZxHqCHhZTfzvzSLLRJFQsvTdMrqQwXHom1MuIoS3epxMcB+lV/G2yRBNjkD+6BmRZzRtnoSkpIVs87BfbNIVHN/dgaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEnTRxim1hhVGAKPM7qrbcUf04DYjeBTB8LO8bbqSQA=;
 b=QJ51Z2WNnYP9q88U8JKHEmxDg1Sz2TMBVVbC+6xtFt0HvDk/nhgLYaC1dImUQz4A/W9ZHjL2IaSsGWf1thnh5cI5KWJi7Y0tJJM6Ak9YNpb2sdG5LIf+U0YFwBUIU0L0uNeEuWiVaa+Od6CAlr/7Fn5bf0MwstzjdvPjFqe82hv7b4eK1X2Hu9EqViUU3DSajqPqrr6hFEQ7FdLIm1P4GOdXiE+Es1SNjDqg1doKnBs7+G5MZx9goFR3b8TBRlUOiC9SA26KTEGKT4BpOU5Wx+WtjMh+8ji9eNncS/ypsCV6vFDxLs49Kj2/z/ge4bLHJrVkuvdY1vyyGtG9NZxhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEnTRxim1hhVGAKPM7qrbcUf04DYjeBTB8LO8bbqSQA=;
 b=jhOSiSGOtg+H7AVJU7vSjG0o/+SOL1WvCfJQm8WGGo0RE+cE/+kb6xzgZyUX2L75OvHXcWX+72c/84lIqp5h+0g8vLKUp+7OBA+609nTA3RKUfSAtkDiLJMPxugOrnusI/sT6z/ofUXcIefow74o3CUnMuGB5JHytd7yqWWGgrE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB9279.jpnprd01.prod.outlook.com (2603:1096:400:1a2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Mon, 19 Sep
 2022 13:52:52 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 13:52:52 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to critical list
Thread-Topic: [PATCH] clk: renesas: r9a07g044: Add WDT2 clocks to critical
 list
Thread-Index: AQHYzCwlVjlhhutYXUubI25P/bpXfa3mwNiQgAAA1QCAAADfEA==
Date:   Mon, 19 Sep 2022 13:52:52 +0000
Message-ID: <OS0PR01MB59227B5F87C7FC3CEC271B0A864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220919133122.167794-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922E64DD745E4F8A5FEFCD5864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8vAjO9H9BdgNOVXkjWR9zpD+73P_KLo0683xp1nBgVViQ@mail.gmail.com>
In-Reply-To: <CA+V-a8vAjO9H9BdgNOVXkjWR9zpD+73P_KLo0683xp1nBgVViQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB9279:EE_
x-ms-office365-filtering-correlation-id: baf115d0-d672-4b2e-2408-08da9a463f67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DkKMVKnvMOB3FRVYoa4JQb4/N9yjokTdIoH0bY3accyKAPWwOD00mcwmrH9DGahgHdGjLjHpz63hI1HWlI43pyWyENdBJvzLGSyXDNHo95bhMaUJhf9Mt+pb+1Yf6jcPDhfpYYNpfshmqNxp9R0NXWiU1EY2WUCSPRZj8raRCkmOR64/E5alwqzrDIuFkZyaU51acvVgZUfWT1HEiZe07UUiYS3Hl1pYf37esBY8JLs5prQZhaYKMJSwu4oDN2niQDQZIn7VIst9pifG6heDopxLDSJawscEegQMGKyuTrXnLUPPzB4xgppniSWUNgTTHTmmg+ra6kyT4W9lhyjHAUOPmjtTKTgxrAXso7sLyOL3CCQEiKcyw4rb4vpZzS4zvdMvMcEZ+nMsi4u6zwi5yrrjOKIdNnJhRAEohQdLwiVyX0KNRP+yPOf0kK4PmbeCBoh19o8IsH1nIbySDKiU0g9ApdpyrKtIY5wusmRtdZ4qBZv8SbSELjqXQD4VZtZMaXzi+89qMkmz06J0yMZOgycbrBcJuRP2FXijMLF+fDbteRQ4qmKehpf2qYc9VCBAfpuDtjB4ufY1I42akpIQIMFyK0GGhxxU+uyRPp9acWYV0Vd/3sD/KimNOSyQUYBIb7R3Y3OoJ6fWweMCdx4BEkzaKuKTCPBeo+/jbQVOYZ0oG5HB2kbi5RGVjki1Yc5LUOJnqhnFvjA4OqsRyDLvGGgGakJWepowm1ZLTGngGMTkv2+6tyeBQ3joqb8c9Xyr2JR/21r7JFmmYzDu1e0EXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199015)(52536014)(66946007)(66556008)(8676002)(4326008)(5660300002)(66476007)(64756008)(66446008)(54906003)(8936002)(86362001)(6916009)(76116006)(316002)(83380400001)(122000001)(38100700002)(55016003)(33656002)(7696005)(53546011)(41300700001)(107886003)(6506007)(71200400001)(478600001)(186003)(9686003)(26005)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkZvYzRqc3crODZvYXB6bE8vbmhLQVVNSExNTTRvK0txVnBsUjRuK0xUSWQy?=
 =?utf-8?B?aldiUnlUd1p4ek1mRUhLZ0g5YllvZXVFdEpTNEI2LzEyKzVadDA3RWxNS3Zj?=
 =?utf-8?B?WTdIb2pWOHFUbjJJS1FpN2d5Q1YvcGRaVUZ4TjlxSjZobWlhQnZrUFA1YUJl?=
 =?utf-8?B?U1UwVDlMNHFNZjJnNFFJQzBnRDFJdHRnSEVtYzRzaWJiU1BtQkF0VjFPdWZR?=
 =?utf-8?B?Ylo1cjVpRDNaUC9RQm02b2MwSnUxdHIyQjJUdUNuSFRWcEtrZ3ZwVXlicGZL?=
 =?utf-8?B?amRLWHFPdHpqNG5oYnpOYTYva1ROdVFqVVI4bk5jTzVRMS9DZ3FlS0k2Wk83?=
 =?utf-8?B?c01hNWRHWnNrcHA5VlhaYk9QNFY5dXRXT25sWC90aTBTSHEvbUFxTXR3d0lm?=
 =?utf-8?B?TTVZZlpicTA4bHpUZk50QlpNY1NOWW5lZ1Z0U2VCaGpPV2ZvaGtEQlg4N1lv?=
 =?utf-8?B?ZnBXam1lUmRGalozMkFoS1F3WUtTYy96ZFljRmgvc3RnVDU4RzllS2hpZWI3?=
 =?utf-8?B?RVpqWkh1VFBMQlZFajhqbnB2dSsvdkp4TWkwSnhFaWFRSnV0eGQwZ1VhUHRu?=
 =?utf-8?B?cG4zQk0wa0NLT3NHTlRVWmVSRE9tYlIrT1BOWkJnOGdLVTNqUDFabHNvM0Fw?=
 =?utf-8?B?bmdROGpDMFVhYkJkc3BNVXdIbDRxS2QvYVN5MFlGWElSVXhqN1l6WXZHd0RB?=
 =?utf-8?B?Y3YxUzg1emJacUlFNW5peEFjaUtPc0gyclFPeDJDakRURG12MFREeExuQXJ5?=
 =?utf-8?B?bWNwWEpVNGZTK1pFQTJESWRqdld5VVpYM2tJMUliTmdOY0ttTHJCUmxNR3Bm?=
 =?utf-8?B?NVM1YWE1WU1kMXE1Q0hJUW9XbVlQZTJMSmVUWGZ0TVVsY0VBU2tNNWZ1Ky9t?=
 =?utf-8?B?b0c0aG9PWDlZZ3ltNXhhcURKL0V3QkoyNDdLL1BPUUZkbXljdUExTGxHekNt?=
 =?utf-8?B?cFhJdDdSaWRjVEt2c3BPdXBodURXekpocUdQZ3EwbE9uVXVEdGFaN2xHQmFK?=
 =?utf-8?B?cVhETW1TU1pqSFBpMm9zRXd5Rk1YQXhCZmJFT3Z6N3JwYzN1ZWtybU5RcG5i?=
 =?utf-8?B?R0RGSU1VMnRrVUpJMFNpd3Q5YUZjRDYzTlNZMSt3QXdVbC8xeHlpZ3k1K0JN?=
 =?utf-8?B?WEk3S1RYWUZ4V1IvbmVaWlllZmZCaU5VR3JidTJKYUFXZ0U3cERjR1ZDeXU4?=
 =?utf-8?B?Tm5MTEhjdkhpWmt6MkI3VjVtb2VxRm5RK3J5aDg0Y0FUaWN1SEFnNHZ6VE0z?=
 =?utf-8?B?S3BFT05jcFN6ZTlLc2t3ZTJXelN2ckFoS0NSTjlFSzBGUDdwaEgxTTVNY0dO?=
 =?utf-8?B?YTBLU1pXN2xDYjNaT09LeGlRcmFXVzVjY0NIMFN3dHgzV0xHdE1QQnduZDRn?=
 =?utf-8?B?dHMzdjNWbUJIaHhUZkptc2xrOVdVRDdFeTY1YStwR0RZc3d3S0k2czloRU94?=
 =?utf-8?B?YXlVWFZuWHNHYVZkcEtPUFZqeHBHUEQ1elZUVEszR1NqRUZlcjJFOG9VZm5o?=
 =?utf-8?B?UHVQNHkyK1Jrc2p0cS8zaWJrbk1EZ1pmZ05UVmV6Z2lQaUFESTRyQUc4b09V?=
 =?utf-8?B?V3k5ODB3b1BSbktqM1lEOFoySFhVMysvR0MxbHdoTFB0Wk50NmFJcG9uZGhF?=
 =?utf-8?B?dCtBVDBWMW5tYjZPTXpFeXhTb0JVOWo1S3NuT2RjS25ONUdNenJJMWkwWlky?=
 =?utf-8?B?S0cyejlLZ3lJUEY3VjVPNStwNTl0VXdWSzZHNUZUVUNZU2VLT3V4S093eldp?=
 =?utf-8?B?SFI0TG55V1p3ZnlEMmpkKy9ZT1hadFZtbktVSlJBeGU5b2Rzd0kwSjQzZnhY?=
 =?utf-8?B?Nmt5Q2JhZFFrbjJlZTN4SWdXNFZkODJvN0l2eEQrZkpwQk12YUd6bnlGK016?=
 =?utf-8?B?WSs5a29tcU91ZFN3ZHR0NlVoeTNJamxzQUZqL0pCNEYxUHB5QnUxZXRsY1hx?=
 =?utf-8?B?L3Qrb0l4VTNaNUxDNzNtS3FrUHoyOGNYc3N2WkpVUDRNY3FEMnMvb3lleEtG?=
 =?utf-8?B?WUpldk9lMFVRakJuNytWSHFlZEE5bTh1MXZIcVJ1T3VROUQrek1wTlExKzlS?=
 =?utf-8?B?UVVpMUd0RXJuVG01NDBSL3c3VW1qSGpkWUZSSjJFRW5TNyt6R3BBTGdoVjVL?=
 =?utf-8?B?Sm80bjlHcmt6STFJNVVQOUUzdUxEUE5tTkpDaHBuMzJwZkZIWmIzVjJDL2do?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf115d0-d672-4b2e-2408-08da9a463f67
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 13:52:52.7989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4+DcSPtbeuPPgG7H4eIjfdzgpFlgMY3rRtIGG97at3gp3Z2aHOuoJCerxC9jDXXqcEiQmUymQ/AonKSa18adq+VqEX2lNDognfKW1PNp3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9279
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhYmhha2FyLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNsazogcmVuZXNhczogcjlh
MDdnMDQ0OiBBZGQgV0RUMiBjbG9ja3MgdG8NCj4gY3JpdGljYWwgbGlzdA0KPiANCj4gSGkgQmlq
dSwNCj4gDQo+IE9uIE1vbiwgU2VwIDE5LCAyMDIyIGF0IDI6MzUgUE0gQmlqdSBEYXMgPGJpanUu
ZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEhpIFByYWJoYWthciwN
Cj4gPg0KPiA+ID4gU3ViamVjdDogW1BBVENIXSBjbGs6IHJlbmVzYXM6IHI5YTA3ZzA0NDogQWRk
IFdEVDIgY2xvY2tzIHRvDQo+ID4gPiBjcml0aWNhbCBsaXN0DQo+ID4gPg0KPiA+ID4gRnJvbTog
TGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0K
PiA+ID4NCj4gPiA+IEFkZCB0aGUgV0RUMiBjbG9ja3MgdG8gcjlhMDdnMDQ0X2NyaXRfbW9kX2Ns
a3NbXSBsaXN0IGFzIFdEVCBDSDINCj4gaXMNCj4gPiA+IHNwZWNpZmljYWxseSB0byBjaGVjayB0
aGUgb3BlcmF0aW9uIG9mIENvcnRleC1NMzMgQ1BVIG9uIHRoZQ0KPiA+ID4gUlove0cyTCwgRzJM
QywgVjJMfSBTb0NzIGFuZCB3ZSBkb250IHdhbnQgdG8gdHVybiBvZmYgdGhlIGNsb2Nrcw0KPiBv
Zg0KPiA+ID4gV0RUMiBpZiBpdCBpc24ndCBlbmFibGVkIGJ5IENvcnRleC1BNTUuDQo+ID4gPg0K
PiA+ID4gVGhpcyBwYXRjaCBpcyBpbiBwcmVwYXJhdGlvbiB0byBkaXNhYmxlIFdEVCBDSDIgZnJv
bSB0aGUgUlovRzJMDQo+ID4gPiAoYWxpa2UNCj4gPiA+IFNvQ3MpIERUUy9JIGJ5IGRlZmF1bHQu
DQo+ID4gPg0KPiA+ID4gUmVwb3J0ZWQtYnk6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5l
c2FzLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IExhZCBQcmFiaGFrYXINCj4gPiA+IDxwcmFi
aGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBk
cml2ZXJzL2Nsay9yZW5lc2FzL3I5YTA3ZzA0NC1jcGcuYyB8IDIgKysNCj4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2xrL3JlbmVzYXMvcjlhMDdnMDQ0LWNwZy5jDQo+ID4gPiBiL2RyaXZlcnMvY2xrL3JlbmVz
YXMvcjlhMDdnMDQ0LWNwZy5jDQo+ID4gPiBpbmRleCAwMmE0ZmM0MWJiNmUuLmNmOWIxYmQ3Mzc5
MiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvY2xrL3JlbmVzYXMvcjlhMDdnMDQ0LWNwZy5j
DQo+ID4gPiArKysgYi9kcml2ZXJzL2Nsay9yZW5lc2FzL3I5YTA3ZzA0NC1jcGcuYw0KPiA+ID4g
QEAgLTQxMiw2ICs0MTIsOCBAQCBzdGF0aWMgY29uc3QgdW5zaWduZWQgaW50DQo+ID4gPiByOWEw
N2cwNDRfY3JpdF9tb2RfY2xrc1tdIF9faW5pdGNvbnN0ID0gew0KPiA+ID4gICAgICAgTU9EX0NM
S19CQVNFICsgUjlBMDdHMDQ0X0dJQzYwMF9HSUNDTEssDQo+ID4gPiAgICAgICBNT0RfQ0xLX0JB
U0UgKyBSOUEwN0cwNDRfSUE1NV9DTEssDQo+ID4gPiAgICAgICBNT0RfQ0xLX0JBU0UgKyBSOUEw
N0cwNDRfRE1BQ19BQ0xLLA0KPiA+ID4gKyAgICAgTU9EX0NMS19CQVNFICsgUjlBMDdHMDQ0X1dE
VDJfUENMSywNCj4gPiA+ICsgICAgIE1PRF9DTEtfQkFTRSArIFI5QTA3RzA0NF9XRFQyX0NMSywN
Cj4gPg0KPiA+IERvIHdlIG5lZWQgdG8gdHVybiBvbiB0aGlzIGNsb2NrIHVubmVjZXNzYXJpbHk/
DQo+ID4NCj4gTm8sIHRoaXMgaXMgaW4gcHJlcGFyYXRpb24gdG8gZGlzYWJsZSBXRFQyIGJ5IGRl
ZmF1bHQgZnJvbSBSWi9HMkx7Q30NCj4gRFRTL0kuDQoNCkJ1dCB0aGF0IHdpbGwgbWFrZSBXRFQy
IGRldmljZSBpcyBub3QgZW5hYmxlZCwgYnV0IHVubmVjZXNzYXJpbHkgdGhlIGNsayBpcyBvbi4N
Cg0KTm90IHN1cmUsIElmIHdlIGhhdmUgYW55IHVzZSBjYXNlIGZvciB3ZHQyIGNvbnRyb2xsaW5n
IGZyb20gQ0EtNTU/PyANCklmIHRoZXJlIGlzIG5vIHVzZSBjYXNlLCB3aHkgY2FuJ3Qgd2UgcmVt
b3ZlIGl0IGZyb20gU29DIGR0c2kgYW5kIGNsb2NrIHRhYmxlcywNCnRoYXQgd2h5IHdlIGRvbid0
IHVubmVjZXNzYXJpbHkgdXNlIHRoaXMgY2xvY2sgYW55bW9yZT8/DQoNCkNoZWVycywNCkJpanUN
Cg0KDQo=
