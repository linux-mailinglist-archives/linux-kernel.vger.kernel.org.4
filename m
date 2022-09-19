Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE7C5BD269
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiISQrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiISQrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:47:37 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2092.outbound.protection.outlook.com [40.107.215.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4053C25E91;
        Mon, 19 Sep 2022 09:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxMjV9U51GAHo032u+zDJjwF26vhkmzEx6NwJo0rKMznJeSqG8RZ7Qk7Cy+0YRYFC+MPAAzMmUMhYMA2/TuSvAaEXcj1rAyrqfa72C30yp0hUQ8kRxKRxPIbOwU649x4wmCGluECrdaByF14lTvyBiEPupA5mA8YoHpAIJNlUzN2yjQtFj7ulv9U4seAASWZxcLI/Pwpk4AUqYbUGOOhaPmv6YpDEuQiKNVR4JKTzwvqrEF4Rnba1CUKaQuWCeLaGsw4ijid3ylWCQmVm15tBBRdnJ1Y4iW5p8Ef6c5EKOOMaiWV0+ZdkZtjqCFqgBPhpQx/kNiL+dr2jZQ7unllsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+rQuAQ5wX4w7tzssQ2ELs0eofMba9FjlIRbUmCe2kE=;
 b=Rr6xZDVaqZzGUGtpUSMvKquxxjYy6Cy+PXPnycaax53/x2KnDdGNcynTf1J/P1Ws2/Fp8nQfQZGGPt5usAJr4ObENh+QlJsRLtcVvIbULwu4Js45CLNEkxWM37X2bgPpeLWPwB8m7eUF44VhAmvHrmeuG1Yd5viMFRyllM5gEMoLvDcz8gbEKwytxGNKj+/Q9fXvW68aPtk0Sx52+jMCODKl8WYU99TgKBj1Cg07PaJM02+TWsuQWS60UQfHDqWTnG4EUCmkotNNtULgJfmJ5E/iMzdl3rEjimMVmHX1TWIB6tdMbynu5+fAeqwtEm3ZwYmwZ8rLUUNxWxyTN1WDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+rQuAQ5wX4w7tzssQ2ELs0eofMba9FjlIRbUmCe2kE=;
 b=Gt8/FfH9y6VtZr4+IUtb+cZaxYG2fOaGAU/+UaQlfgBtc1l0+YrVTLZkuqF4FMJHtM4V5RNwFD8oo1Glw2NwHB2a8oFGrvY349qUcVs0ZXMwkZTb5UjHvFNSldhxZUREJWX4w201q+G0V0Acckz32BJ2QU+D/OAj8O1eKt4e4t8=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 SG2P153MB0362.APCP153.PROD.OUTLOOK.COM (2603:1096:0:3::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.2; Mon, 19 Sep 2022 16:47:27 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::9e53:1eec:d6f6:5934]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::9e53:1eec:d6f6:5934%5]) with mapi id 15.20.5676.004; Mon, 19 Sep 2022
 16:47:26 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "song@kernel.org" <song@kernel.org>, "shli@fb.com" <shli@fb.com>,
        "neilb@suse.com" <neilb@suse.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "guoqing.jiang@linux.dev" <guoqing.jiang@linux.dev>
Subject: RE: [PATCH v2] md : Replace snprintf with scnprintf
Thread-Topic: [PATCH v2] md : Replace snprintf with scnprintf
Thread-Index: AQHYtyFTr0+Sm0lcEECqqt2J9wa1/63nID6g
Date:   Mon, 19 Sep 2022 16:47:25 +0000
Message-ID: <PUZP153MB0749E4AA8A8039412DC87080BE4D9@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1661280664-10588-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1661280664-10588-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6027ce0b-ed8f-40c5-8c36-522f52d7714c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-19T16:45:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|SG2P153MB0362:EE_
x-ms-office365-filtering-correlation-id: d2360d9b-0783-4f5a-93a5-08da9a5ea1e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8TWDqy7QpL7QMir9+CxW/WdQB35TcrgmF4t/fni4OTZ0LDzqjS9aMvT3VGuBJmK/T5A1i8x0S95BfXHIrOUBeJfk2gb+sWSMaFOacjjYLwZrmBTPAPV9tO+9eiJBw2sWinpfj4tVVYioDUqqjT/WoXWSSaiIkxBEaC/QjioZrUwFBSbYv5j+xflXnPVezS/DYsPGBWBq/0rsbeqg16wiO0xpRFM1xhVaabnj5Y40HRmDN1dQ3gVqaU6QeiI62eLnDi0+LFPKKGpxjkM24mWgc8mllW0e7LW++Iv0E5Ih66D3V+nRR9ZToul/pEL+gcb1Vfa0PKLoY5lo7dLCLGEEQ83qRy7e7W1EOANI1/Jbhbc8r92cFr45pAtZDDek/CaK8MbJuUDILWVg5ZgIM/DPC0L/JZ3Rd6yF8Bq46s6gBRVe0xtZeN/hZpm1xo05ebviIiOCa2KkxJyOMKl9EJSklzyqiQfp3yZBGb/hfaHclztnYMR/nfKEmGbYwY2JkqdM5DXtmAtBWMza7MXYVBkiWhdfUdwlHBjTv71SRH85le3n9wHhTQfEXePFQFFPBK23c4wGr0ikKgO2GVskNJu+N0FFNZ4Uqau36NSdTQWl689QWmDXhncCdAWUc7Yk3eNF+PFMzV9/7skDrOlp5WVQAGr+Td3wzfqrCrCt8ecoo2KcOYx0gH9RWBaTgcFAue9FszU8FaS10j4nMnWd2Va9SBs15oLzFLSJUsHnXXsB7xVu1zIEVxwTZ2OCUI6N89yrxIv57kySqxh3LZ8GDQ6MH9kG9bxe1Wdz0jS+73FR7Lblk9OKBmAuZm7fFFThBCX0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(53546011)(26005)(9686003)(7696005)(6506007)(38070700005)(82950400001)(38100700002)(82960400001)(8990500004)(478600001)(10290500003)(2906002)(5660300002)(66476007)(122000001)(86362001)(33656002)(186003)(55016003)(41300700001)(83380400001)(71200400001)(66446008)(64756008)(66946007)(66556008)(8676002)(316002)(52536014)(110136005)(8936002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTAxa1lhaktrMVYxNWVGYVc2RCtydGR6SXRWV2E3VndVcHJnWnU2NzZEQ2dU?=
 =?utf-8?B?bFJKdzYzNWxiZFF0N3BmNTNDUklFeE9keGxXL3NqMlVnL1hxQVV5WEwzb3dt?=
 =?utf-8?B?S3RjVUNwY2U1a3BjUEdvMExJK2F2RjB0M1UrT2t6RUdGM3ptZWwwZVhUS1Zp?=
 =?utf-8?B?WDVVTmtQbFl5UHFwSmV4eW5DYmUrRWVFemlCTVo5NkdFM3hCZDZsd24zZnVS?=
 =?utf-8?B?Ry9YNTdQbVorcndLTms1cFhHQVNOZFMwUjRWQTNkWnlZZzVhRzZiN3p5azVG?=
 =?utf-8?B?bjdvMFJmV0ZjanpyOWU3dktrcGtzcjE3MWhUYzlKbjdLM1NBRUVGd0xoeFdj?=
 =?utf-8?B?S3E5UU1KVVpVTVQrL1lHTGtYR1c3T1Q1dGEwandBYmVXakVlZ1BXNU56aVlY?=
 =?utf-8?B?QUFhWXlwV0FRSHlyN0Nrc2hwLzA1WElpcDc1dXhVdi9QNC9teUdvQ0ROcjFs?=
 =?utf-8?B?Zm5XazJ5MzlHMzBNMnpUelcrQmxoYkxIMk85TFdJWk10M3VzUEVBbDRpVFo1?=
 =?utf-8?B?TlN0UDRBVGZHNlgzWDhsd0ttSFFtV3ZCR1NDQ3JyQWlxZXNwM3c1UmFtZHNH?=
 =?utf-8?B?WVFSNzdyenlLSnRBWmJWN1d0ZFYzVlh1dlJpQ2w3UEtvc01vRXJDbkxrQ0h2?=
 =?utf-8?B?ek95NDA0Y3h5SmtEdi9sN2RyaGFBUTA1WXM5SzMvRzVRNGRidWMxeDNoZDZJ?=
 =?utf-8?B?M2hxRlpORzV6Tlpud3FaZnpZNStyM2dzUEVtTnZvNk43WllhaUVXK1crdFZx?=
 =?utf-8?B?TUZYdmg1NTNta0hKYkpzb1JxOXVpcTNWcS9EM1RDTDdVWWMyWUhHS09yTjE5?=
 =?utf-8?B?QXVhb3JpMjZzeGR4MnY5NnZyQ0MrenNHUXlvdEladC9ZS3dkMkoxeloxQ0tn?=
 =?utf-8?B?cWMzZGV6YUxSWnVsVFhmdDMyYWg0QU9JaElNUzRhVXZqbHJtamRVYm1HdTdT?=
 =?utf-8?B?T0liQkMxYTkxMU9IS2tCc011bFB1N0xsMzZycWc1NGlqRlE2Z3B0YTE0WkF4?=
 =?utf-8?B?dWIrM0IrS2VBWHN5QTMyazNFbmMvM3Z0WGIrRkRoOUdHRmZhNlk1SG55QTZR?=
 =?utf-8?B?bitwS1A3eWNrK0szWmZmMGJIR1VFSE5hN2lZSVQ1c3JJbHNVLzVUT2c5Tkps?=
 =?utf-8?B?TytiOERvK1dCeVpIZlN0TEora2xvV2ZMOVZGRG9Yd3RwemJScDBMVmg5aFp4?=
 =?utf-8?B?dkNMRkZtMC9zeWdWUTlldUpzK1BpbEdCbEdUYlJIVnQwaERtMHZyY2paRkRX?=
 =?utf-8?B?clV3ZEJmam9OMG44SUZmQWl2UDV5VnIwSitrSDV1Rk9waEh5MkRzNzNFNGpB?=
 =?utf-8?B?MEFURTljUmRIQzJTUFBuZk5oVThCYW1BdGcybU5PK1ZsbE8zSkdFb2toK0NT?=
 =?utf-8?B?N3RHZUFhRTJ4RkRxSEoyanNEd1l3dXE1K1VhNHQ3SkdvYXo2Ny9aNnRWWlN0?=
 =?utf-8?B?eGhzNC9qS3hVYnRwOTcvQ3I0dHF6c29lL0VHU0tkSFJVQTMrS2ZmVjQweDRl?=
 =?utf-8?B?ZXlVZnh4SytGYlQvUDZiOUdsc0EzYWJZTTZJSGJXQVZQQTJmWWFZMDhSelJW?=
 =?utf-8?B?alliRW1tdFpoaGhKcWdFZHQxRVhlRkxJM2wrR2gxQkJCY2YrSjU4TkpGRDJ0?=
 =?utf-8?B?MU5jc0NLRXkzc2pGdERVTXdMK1ZBRncrcVJIMDdoUTBpcEptNWdZblE4R1F2?=
 =?utf-8?B?VFM1VDNZdk5ZN3ZuVGxiOUdWaFZsaC93L1RHQWRWMTlhUFR2Zm5tRFZwT21B?=
 =?utf-8?B?N0hocHYzVDFhdDQ1UFpDK1czZUhmc2V6YlhPZTRUeFNPMnB3TUdtY2dPUHFY?=
 =?utf-8?B?bUlqWmFaaDl2dXEwUVVUbnFvTVIzTVFETkhpaXNNanZ5Uzc1c1VTUDZ4dEFy?=
 =?utf-8?B?WEJQVnRQdmRNcDRseUlPUDhyV1JKckZkSFpTRm9pWEhESlVrNzFZd2xMV0lQ?=
 =?utf-8?B?T3NlNHJOb1pGYThnU2I1czJ0ZXlnZ2JmSDB1Y0dRUi9qWGsya1psTGhVY0dV?=
 =?utf-8?B?UWkwa1p1dlpiRWJud3g0QmRUazFXbFlZZXRQamRaZ3NnbWtFR2VtajMraWVw?=
 =?utf-8?Q?X8TgDt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0362
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SXMgdGhpcyBxdWV1ZWQgIGZvciA2LjAgPw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFNhdXJhYmggU2VuZ2FyIDxzc2VuZ2FyQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+
IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDI0LCAyMDIyIDEyOjIxIEFNDQo+IFRvOiBzb25nQGtl
cm5lbC5vcmc7IHNobGlAZmIuY29tOyBuZWlsYkBzdXNlLmNvbTsgbGludXgtDQo+IHJhaWRAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTYXVyYWJoIFNpbmdo
IFNlbmdhcg0KPiA8c3NlbmdhckBtaWNyb3NvZnQuY29tPjsgTWljaGFlbCBLZWxsZXkgKExJTlVY
KQ0KPiA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT47IGd1b3FpbmcuamlhbmdAbGludXguZGV2DQo+
IFN1YmplY3Q6IFtQQVRDSCB2Ml0gbWQgOiBSZXBsYWNlIHNucHJpbnRmIHdpdGggc2NucHJpbnRm
DQo+IA0KPiBDdXJyZW50IGNvZGUgcHJvZHVjZXMgYSB3YXJuaW5nIGFzIHNob3duIGJlbG93IHdo
ZW4gdG90YWwgY2hhcmFjdGVycyBpbg0KPiB0aGUgY29uc3RpdHVlbnQgYmxvY2sgZGV2aWNlIG5h
bWVzIHBsdXMgdGhlIHNsYXNoZXMgZXhjZWVkcyAyMDAuDQo+IHNucHJpbnRmKCkgcmV0dXJucyB0
aGUgbnVtYmVyIG9mIGNoYXJhY3RlcnMgZ2VuZXJhdGVkIGZyb20gdGhlIGdpdmVuIGlucHV0LA0K
PiB3aGljaCBjb3VsZCBjYXVzZSB0aGUgZXhwcmVzc2lvbiDigJwyMDAg4oCTIGxlbuKAnSB0byB3
cmFwIGFyb3VuZCB0byBhIGxhcmdlDQo+IHBvc2l0aXZlIG51bWJlci4gRml4IHRoaXMgYnkgdXNp
bmcgc2NucHJpbnRmKCkgaW5zdGVhZCwgd2hpY2ggcmV0dXJucyB0aGUNCj4gYWN0dWFsIG51bWJl
ciBvZiBjaGFyYWN0ZXJzIHdyaXR0ZW4gaW50byB0aGUgYnVmZmVyLg0KPiANCj4gWyAxNTEzLjI2
NzkzOF0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tIFsgMTUxMy4yNjc5NDNd
IFdBUk5JTkc6DQo+IENQVTogMTUgUElEOiAzNzI0NyBhdCA8c25pcD4vbGliL3ZzcHJpbnRmLmM6
MjUwOSB2c25wcmludGYrMHgyYzgvMHg1MTAgWw0KPiAxNTEzLjI2Nzk0NF0gTW9kdWxlcyBsaW5r
ZWQgaW46ICA8c25pcD4gWyAxNTEzLjI2Nzk2OV0gQ1BVOiAxNSBQSUQ6IDM3MjQ3DQo+IENvbW06
IG1kYWRtIE5vdCB0YWludGVkIDUuNC4wLTEwODUtYXp1cmUgIzkwfjE4LjA0LjEtVWJ1bnR1IFsN
Cj4gMTUxMy4yNjc5NjldIEhhcmR3YXJlIG5hbWU6IE1pY3Jvc29mdCBDb3Jwb3JhdGlvbiBWaXJ0
dWFsIE1hY2hpbmUvVmlydHVhbA0KPiBNYWNoaW5lLCBCSU9TIEh5cGVyLVYgVUVGSSBSZWxlYXNl
IHY0LjEgMDUvMDkvMjAyMiBbIDE1MTMuMjY3OTcxXSBSSVA6DQo+IDAwMTA6dnNucHJpbnRmKzB4
MmM4LzB4NTEwIDwtc25pcC0+IFsgMTUxMy4yNjc5ODJdIENhbGwgVHJhY2U6DQo+IFsgMTUxMy4y
Njc5ODZdICBzbnByaW50ZisweDQ1LzB4NzANCj4gWyAxNTEzLjI2Nzk5MF0gID8gZGlza19uYW1l
KzB4NzEvMHhhMA0KPiBbIDE1MTMuMjY3OTkzXSAgZHVtcF96b25lcysweDExNC8weDI0MCBbcmFp
ZDBdIFsgMTUxMy4yNjc5OTZdICA/DQo+IF9jb25kX3Jlc2NoZWQrMHgxOS8weDQwIFsgMTUxMy4y
Njc5OThdICByYWlkMF9ydW4rMHgxOWUvMHgyNzAgW3JhaWQwXSBbDQo+IDE1MTMuMjY4MDAwXSAg
bWRfcnVuKzB4NWUwLzB4YzUwIFsgMTUxMy4yNjgwMDNdICA/DQo+IHNlY3VyaXR5X2NhcGFibGUr
MHgzZi8weDYwIFsgMTUxMy4yNjgwMDVdICBkb19tZF9ydW4rMHgxOS8weDExMCBbDQo+IDE1MTMu
MjY4MDA2XSAgbWRfaW9jdGwrMHgxOTVlLzB4MWY5MCBbIDE1MTMuMjY4MDA3XQ0KPiBibGtkZXZf
aW9jdGwrMHg5MWYvMHg5ZjAgWyAxNTEzLjI2ODAxMF0gIGJsb2NrX2lvY3RsKzB4M2QvMHg1MCBb
DQo+IDE1MTMuMjY4MDEyXSAgZG9fdmZzX2lvY3RsKzB4YTkvMHg2NDAgWyAxNTEzLjI2ODAxNF0g
ID8gX19mcHV0KzB4MTYyLzB4MjYwDQo+IFsgMTUxMy4yNjgwMTZdICBrc3lzX2lvY3RsKzB4NzUv
MHg4MCBbIDE1MTMuMjY4MDE3XQ0KPiBfX3g2NF9zeXNfaW9jdGwrMHgxYS8weDIwIFsgMTUxMy4y
NjgwMTldICBkb19zeXNjYWxsXzY0KzB4NWUvMHgyMDAgWw0KPiAxNTEzLjI2ODAyMV0gIGVudHJ5
X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4YTkNCj4gDQo+IEZpeGVzOiA3NjYwMzg4
NDZlODc1ICgibWQvcmFpZDA6IHJlcGxhY2UgcHJpbnRrKCkgd2l0aCBwcl8qKCkiKQ0KPiBSZXZp
ZXdlZC1ieTogTWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+DQo+IEFja2Vk
LWJ5OiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxpbnV4LmRldj4NCj4gU2lnbmVkLW9m
Zi1ieTogU2F1cmFiaCBTZW5nYXIgPHNzZW5nYXJAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gLS0t
DQo+IFYyIDoNCj4gCS0gUmViYXNlDQo+IA0KPiAgZHJpdmVycy9tZC9yYWlkMC5jIHwgMiArLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tZC9yYWlkMC5jIGIvZHJpdmVycy9tZC9yYWlkMC5jIGluZGV4
IDc4YWRkZmUuLjg1N2M0OTMNCj4gMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWQvcmFpZDAuYw0K
PiArKysgYi9kcml2ZXJzL21kL3JhaWQwLmMNCj4gQEAgLTQ3LDcgKzQ3LDcgQEAgc3RhdGljIHZv
aWQgZHVtcF96b25lcyhzdHJ1Y3QgbWRkZXYgKm1kZGV2KQ0KPiAgCQlpbnQgbGVuID0gMDsNCj4g
DQo+ICAJCWZvciAoayA9IDA7IGsgPCBjb25mLT5zdHJpcF96b25lW2pdLm5iX2RldjsgaysrKQ0K
PiAtCQkJbGVuICs9IHNucHJpbnRmKGxpbmUrbGVuLCAyMDAtbGVuLCAiJXMlcGciLCBrPyIvIjoi
IiwNCj4gKwkJCWxlbiArPSBzY25wcmludGYobGluZStsZW4sIDIwMC1sZW4sICIlcyVwZyIsIGs/
Ii8iOiIiLA0KPiAgCQkJCWNvbmYtPmRldmxpc3RbaiAqIHJhaWRfZGlza3MgKyBrXS0+YmRldik7
DQo+ICAJCXByX2RlYnVnKCJtZDogem9uZSVkPVslc11cbiIsIGosIGxpbmUpOw0KPiANCj4gLS0N
Cj4gMS44LjMuMQ0KDQo=
