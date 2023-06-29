Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ECD7427D1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjF2N6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjF2N6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:58:34 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BF519B5;
        Thu, 29 Jun 2023 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688047113; x=1719583113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0fGpF6wGiXxt/k8c5rRxnF+7RxZph5TRzgxLVmYtx+w=;
  b=J6BTkV2ZxRdVNByPivXNDiaqgq0vkK+cnvHfRIH1AuH2nLxfSLYehZdt
   Ifj1ldLnYLjpxVTaME015wPwDx4AjVWB64RxYsynf3EVFFG/xIotVtOUj
   A6x9rh+0b94xYmLybt4atwTkYwC0c//R+kLC6cwCOLeay15xRvFDFLLD7
   Y+a/m1QZIITFSj8I8MPDDSdUiIzaI/yJw8D4NtXq22Ld9r22wdY2psJci
   u41gY3GOHOihpN10FYyfYUogeMzdNShVfLNTuZ45bojas5+Ih0b7feitt
   9oCNVUrssUUY/YPJ2feUqpjTIFbWnFJCTcMTtPnK4hPlaubYugYiKXW5E
   A==;
X-IronPort-AV: E=Sophos;i="6.01,168,1684771200"; 
   d="scan'208";a="241509334"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2023 21:58:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieIexEw2oo22Y/CdOvZuDWsCIwujR1uczXKsOMX70R/GLCbwciFH30kzTEjnwTzpiKWV14BoFBSMcCJ4+dcMtUZoe2iPhwhQmdhYRnJRdiyuA7I5rHjQgxd/XhUzwk0bBHuC+SE/T9U5etzLavibcwCbmbEcXELasD96Egbx6k3usqDGjyUMqprfHQVP2eIRfPNPC+BU/F8st/E+rwu05KDcKfFgH8VcjEnDk32IhSLWAPUpG3Fvzegvmr+G5ssnGr/8pxW1rHTNiwXPUtG2Z/uZVEvGxZmldw0bsAexXk9AjLMmFIkZcsKXS+OYjxE5CJM4BWcUNDCyAtXFMEi9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fGpF6wGiXxt/k8c5rRxnF+7RxZph5TRzgxLVmYtx+w=;
 b=i9RIjs0/98ehGbytYLKqnMSNnDZdrUSINeQwVTOrHMO8mjaEDZOMoj3j6+GxOk0bS8B2iGkAwKOWR7mqytpC8OqqCJ/SUOsvRIv0KmXidMdJ8UE+V1Z4jnOtCyf3ezVi2ldrUtQPEyfEN1N4CH5gczk2kiFkhstw2P8KjJwUffFyogXglcWxW5zuMMKF5gagn97FXHLsHRPZLumR5WkPpC9k/yd37fZCHT+vLfLprCoLSM4/MtSjKQ7z3DQQtHyRoWzlx7hXf7l+fz32mrpe3eX4TuEyCiCzqbF4BK11d6fo4wqmROkbH+XCAYQuR71LJAXNAM3WH5alds47A3p6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fGpF6wGiXxt/k8c5rRxnF+7RxZph5TRzgxLVmYtx+w=;
 b=jsxgLJUULW+IczZY5EsSuqDvnp0l335h+lNt2SAEEjsyFdzbHNoGTc6wnBBcF21du84ngWwIAOq6NFB1Jn/DyeA6S+j5TicxXeiFE11XCS3qum7h/WfoM6Qf+ZKB/Tx8q/SPHjIwGSBHHJaqDgAh/rLVtZqvKFeoqjTvCezsk9o=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by DM6PR04MB6874.namprd04.prod.outlook.com (2603:10b6:5:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 13:58:30 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::23d8:739:4578:cbc7]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::23d8:739:4578:cbc7%6]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 13:58:30 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND v2] ufs: core: Add support for qTimestamp attribute
Thread-Topic: [RESEND v2] ufs: core: Add support for qTimestamp attribute
Thread-Index: AQHZqBmraa5SJIbjX0SShq6Lycf7Lq+g1b0AgAD7knA=
Date:   Thu, 29 Jun 2023 13:58:30 +0000
Message-ID: <BY5PR04MB6327520D05FDC13A6BA3894CED25A@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <20230626103320.8737-1-arthur.simchaev@wdc.com>
 <896abe03-4fcd-003f-1273-209daafc5635@acm.org>
In-Reply-To: <896abe03-4fcd-003f-1273-209daafc5635@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|DM6PR04MB6874:EE_
x-ms-office365-filtering-correlation-id: a9e739b2-1c2d-432b-d1ef-08db78a8eba1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pq80eVEsZ1XeN/PXpMGKmEAKBAFu1tCuQ40WD+SY8zSfnoJ8L9F73ZjnX7AwiWyZYLhrvt5+NO7StBYgpoSYQfl9+oKrB4sNlsdkqeowszjtlHLB6luyhatn7iD93qR+Z1ydTmH76byqBiKfGon9rO+ZMzqz4AAsLhym5IG51K/Yko7qJzY8QogWfG26/7iyDVMNHvLV6Bl9Cw3aHEeen8f67D2Cb+gHa0Rfm1CTPcrfavMNzwFNQjE3rjXIck4zqOKBpbYZOotQ4jE4u8Nb0SmUwV5tnKDMIuW2MBqRFO6ZmUkosy9jlIRBnYywOsl8mLXQGD3aB+/N++I3gF5IkQQXfo0n6j/u6hRhLP9q3s2QfEiGHa7cxlwyXZvfQXugzTxqtN6MquxmBQ0DA+u40mXnA/5WyNzvNZwykf/4+W6gvTTcykSAmSf7XH+jFypHr3GaDeUUAuQdGjhIXJFT4BchPd0x7qcV6Hkee2XT4qykRsdbccUfHAjOiX9Lfg8z08UqLA3dGz/jAENzWD9Hl5sY2km3Ruoi62WBJLuiJHvg0IIqFeI2Tf+iM0t6v8XbW6m9jYRH7QmkrPO8zCmFzs5iI/Je5/9SnnOqpqo+rwZr7jbvckay8HUVdXWKN/Wi5lNtH0gb5+3TKTfyIlwL2FFM7KWdMrGDL/4C1qUdNyQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(41300700001)(316002)(86362001)(38070700005)(186003)(52536014)(9686003)(6506007)(26005)(2906002)(558084003)(33656002)(82960400001)(122000001)(38100700002)(55016003)(5660300002)(8676002)(8936002)(478600001)(71200400001)(110136005)(54906003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXNrb0UyUmdtRnVHNng2YW5PY1BRSnNZUkpvNDZEUUZtbVJkZzZ4VC9qVHIr?=
 =?utf-8?B?bUpFbGFwcUE4cHh1SVlSZEVsSkdZL2tQTUdnN1gwNVU4Uyt0NURqSXowTEU0?=
 =?utf-8?B?NWlBRzBTZTNjbFlKQWl6MGI2cm9MeEU1YW5NSEFvaHZ6NzhmOEVTUkRtd0Vl?=
 =?utf-8?B?VFlpcW54WlN3cjRZMGxRVmJXK1RIbHFLLzUzMUVoSTRwR0Y0WFhUT2FWTmRy?=
 =?utf-8?B?eWxyNDdYSXhadVIydzBsVUhCUTZCNnNzSzlPaWlHNjArWGZRZnU1MEpMV2RG?=
 =?utf-8?B?S21rVUl5ODRTNDI2akJTTllaNWY5eFJ4TGR0Z2s3b0MrRFpMOUJzc0M0Wk1Z?=
 =?utf-8?B?WUVuTk8xWjBTY3JZeTRhNGhUdVd5N0JFRGUzSG5uZjdyTkZJTlpDbjErVTcv?=
 =?utf-8?B?bHlJMWRpamQ3V2lqWEZ3VENtclFuUDhwYkpxTDlRL2xTeEk1dXdyNWhHRG4y?=
 =?utf-8?B?TU5qZEYzOUx5djBJTmxIOFBkZW5lNXRvQkVJaUxFZjYzY0lhY2dHQW9FZUNR?=
 =?utf-8?B?elJ6aUR5MWpMcWMzLzZ0VUloVUVXY2s1dnUwWG5jUVphWjVodUwzT25ZNnZn?=
 =?utf-8?B?dlNLQ1lqUWlpSFRld0c3aHg3cjhsN2FUWXB1eld4K3MxWFpEa3B2T3VpUW1S?=
 =?utf-8?B?bEZIS0J5TXd6eUNoRnFvZEdVeVlXdmJBZTlnT3pkcGRtZzcrdXVtemtJLzhn?=
 =?utf-8?B?MStCcm9lbUIvdHFQSmxPbHJzdUR2M3ZkbWZLM2pMRitxSy94MWJ0YUthZ1cx?=
 =?utf-8?B?b2pxc21kT3Uxa1RmTG5tcGxkdjNRbWZwbzJjTmV6WmRVNStHUHFRUnpkbXpH?=
 =?utf-8?B?ZUNoZ2IyUzB4ZmxhZ21RSGE5YlRtK3F3bFRMbnZsL1cvVGxxOGZ6bVlocnBi?=
 =?utf-8?B?dW1qT0plSWh5RWlhMFBzVkJIUjJJVVA0N0RuVnpPNmxkRzViREp3bnlrUXAr?=
 =?utf-8?B?REcxVU9GOWxrUnovNmo2bS9uV2x1Q0M1aFB6VDBJam9VR3I3azFQKzAveUlP?=
 =?utf-8?B?TEdBb2c0UUVzSWhDek54bGdXbWh3VDBZRmJWTk10dngzUHZMUW00QTFieFFQ?=
 =?utf-8?B?dENKdTIrdk1FZmNpVWZCR2lEVzM2WnpGOTE1bDdGd1BMT29VWS94cVBwTXEv?=
 =?utf-8?B?VnhLK3Btbi9zUXRLZVdmZXcvQzZqZjhlS3dqOUhpVGQxMkNwNUEzVUlzeW5D?=
 =?utf-8?B?SVlKSHZOVUNpMi90d1Z2eGo5MkVXUzFsZWk3TEVnWDdDS3h2empWWTh3a1ZV?=
 =?utf-8?B?RTRZcjdNWnE3cDRsVDhIdi8wZUtKUTlFME5Jc0oxNURTdVIwMDBCVVhxQk4w?=
 =?utf-8?B?OEtHUWZRYVlEQXlNdHRuU0lWeE54UCtGMEJCRXBEd0wyMjNnd2ZjbDFOTHY2?=
 =?utf-8?B?T1dtYmlXRTZTOVRMcVpkdnltWEcvNkFzUzlNdlVTV0k5TXlHT0xsY0Y0NmZN?=
 =?utf-8?B?U0FDTXBIU0VyVkVqdWVHTUFXVW51MExuUHBZT2lXb3RuSktKaXgzQzZoM3Fu?=
 =?utf-8?B?NnpybEFqT25rT0RwU2hjNmlxZWFPSWVHUTY5QmNRYlhxTElUaTFFaDR0NkF5?=
 =?utf-8?B?VEhPU2daNFZCcHgrRzBtVUdLZ01keXVqbDR2aVFZbGVobGEzVS85WWtMM2FU?=
 =?utf-8?B?Q2xFcnVGNXlZS01HRjl6dVZxcERYVHJwUTNPalNPZUpWMFBlc0UzUFI3SkdG?=
 =?utf-8?B?aWVUNGRVVmtYVkVrMXZIVkFRekJBMlBrb09JUXhyV3dUdk9EeXhqSXVuZkd2?=
 =?utf-8?B?V1NGZFNLbzRES01OYW5kb2VDaFJJVFB4T2owdUhXbisvcmxVL1NSNzFjVWpX?=
 =?utf-8?B?YnRKenhzTnVQdjJLVkJSaDcvVEFodzVEOW9Hc0xjUVlIbkM0Mm9kaE9uNE03?=
 =?utf-8?B?RFdqeFVUQmlZVzJENHh2QWNQZFRWU2Z5aVNnZ0UxL08yUWlQVVBnYk9LMWI3?=
 =?utf-8?B?U1RoNmFIeVJLODYzL0tBZmlvMUlDaks1T0xvNzJ2TnJlMW9VbUVnMElZT3Ux?=
 =?utf-8?B?bWZlUXZ0WDFuemRCWHpGQzNoSTFQbVpNQTZDSFdsblp3dUVCQVYybFZrdjlB?=
 =?utf-8?B?TXlGWGVBWnZUVzZHYnloTUVqZlhXTUFQVlhFenpYWTBocmZsYjNpMDBKRGVm?=
 =?utf-8?Q?WNQpTy1V1bYpeyVUJdhUpWrXD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G2V27xErQCiw1Dg8MKSojl8wp2+Sa2eU99N1swqRmjXjmlU/+gs9ED1K7bJvqo+j7WLy1J1sGPBxOhCKNmqDkP51v+J3Rbxlgy7BsUTbyv6q6+JH+4Ancl3clzr/JG//J9bBV+foyemmOT8B4itRW6PGGGubOXC7BOr0I20CYa6US6/+WfUb8irLAOgMAlVQMHeXuJgMjiZC1+bjXjOEqt2UlgSmg0N7lid0GwC44kxs5JJu1Y1coCwlmGXGCt4Z/OAJ0TFWgJ+d5qEhPFpV/hCVRj12isx3yc4H8dESNpItcq4tvd/eqsvGUGy7HDEV9tcIZ0A72gfC6jJdLwIBTw5OCUHCzOECCYHWlXUsOopNL/LigHF+R/f7c2NlqS1iSimmNaq3AJQvMVVPV+5kBBfbPHLm6CL0i2DPJXvmUWflvoYK9rOo4LIN4jMMQfcUkIxvqzf8uyvGjxW9YsxzNAOtRhmQfHVqPmObdnAogrtmFkGiasbvrlKewDOEYHoOkfVjMUPRuPPCY30MhL69QlmVU3NfoBdxGqpBGiaOhvF4hEQo1ciKLrG1aOKodYg9CGH1qeMd47t9Iso45ZnxWwyd81E7Ty2+JuWfpF53nJorzfIcZcAMyonubN8gThjzDiq9xgCJJD5oJrdD7v/aRnGoqnbBBDSLyekIehYChmV4p96pRjisaNYoHM3gLaS66Nw5fAzzM509dJKRtzjGyPeNzAwuC0pNhs9ZNWVO6j6MEgTFVA5mDb1Jkoq73v1ixJVvaT+uQCRguNlbbDPtBWeynzrL+n1CJpKOGrp4ihfMZOA1tB6gApeyN+PGyhBS1UmSFLGc7bi49Q4ytHqzKmBFFsesaKtUyD4yfBfg6K8=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e739b2-1c2d-432b-d1ef-08db78a8eba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 13:58:30.5855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rx65AWdROAM6/qhtLQf1K/4tAjr9duawEn8BNIxfm+DSZ112eoBvy3NIcHXxE7dPwjxirEXp/f5uQ1VkV73leQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6874
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJcyB0aGlzIHN0cnVjdHVyZSB1c2VmdWwgZm9yIHVzZXIgc3BhY2Ugc29mdHdhcmU/IElmIG5v
dCwgcGxlYXNlIG1vdmUgaXQNCj4gaW50byBhbm90aGVyIGhlYWRlciBmaWxlLg0KSGkgQmFydA0K
DQpUaGUgc3RydWN0IGlzIHVzZWZ1bCBmb3IgdXNlciBzcGFjZSBzb2Z0d2FyZS4NCkZvciBleGFt
cGxlLCB0aGUgc3BlY2lmaWMgdGltZXN0YW1wIGNhbiBiZSBzZW50IGJ5IHVmcy11dGlscyB1dGls
aXR5IHRvIHRoZSBkZXZpY2UuDQoNClJlZ2FyZHMNCkFydGh1cg0KDQo=
