Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4556A563F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjB1KEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjB1KEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:04:40 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2129.outbound.protection.outlook.com [40.107.114.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8E61E5DE;
        Tue, 28 Feb 2023 02:04:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W50wo6SVjWqTRql8azTIBSp112yZFYUnwiqBmz5rt3zP+R0xx6i+9/zC8tcoJZVGDB2U49dPh4bb/5ScPza76Cy2UTzbyWRx9FHca2i4Ztg0m/TeFh1FKhSUhzfY/1NLXFkGvxzE217T6VcTGj04kddXO9CUKO9lbP45XKa3y3heEvz2GHmIUX56OtG2ULo2Ga4xJpZfgu/wdO4JrQUpM8p84Zz80eyF21VOpN0NZPGx/NRpY7sSedbm/pJhD01P1iqzSot1hyMVRLurc9CLyaKzMBj7O16s+xxJ9B9NnQGaQhxXR3ucLBNQUyKIiKx2qLWRpG6zRFl5qqhV9rno1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3i70xWXavYZQGl6p7G0iTHoiu3qJDlVbM5xvi5VUMk=;
 b=jffHO6hYc35dKQu/izCcqYa7n8XrTTfsmZWn+xEmDCushH3ufIDLRp8lzH+PctSrGgglasAEh0PfavcWVD2UdUUKezCSfzQRINtWUVF6kUSBeQ7pYh5J/PDDSGSrPryE7PfJwRZWdDO5Xo98OCWb5Tt/s7lxA7jNiIQQ8K0FXhe33iGUGTuZ0YDjD6OzlXx+MynGaW0IgR0z9nybzRAa9WgPrxcMUgeKe5y7Du7JPbdEbTU+Q4cgiftQTsNdcX5DLvm0OQKAqlJWAjqQPJS8mfyclvgFn6PhNtcLG+ZfjeX5xvn0WybQxNZKlfHdDS+S/9wuWSw8IB+nFIWtkWkKpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3i70xWXavYZQGl6p7G0iTHoiu3qJDlVbM5xvi5VUMk=;
 b=QXdh6mXgo3Wzw+n42vmC7O0dNubyDSN6hhALUFFWvfqJCElgq2ApH3XeQXXii+xwgezEOBWp/6gxPJ25+l/NwKAl+YI93lKSrSFvf6BLNdJgp/s+ChaLAdwk8kSjH4MTQZXKffKhgEKoQ7ATlWB+W7aFGteu3IPDG41iObqpBUA=
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com (2603:1096:604:197::13)
 by TYCPR01MB5599.jpnprd01.prod.outlook.com (2603:1096:400:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 10:04:35 +0000
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::e332:554a:7:7135]) by OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::e332:554a:7:7135%3]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 10:04:35 +0000
From:   DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Subject: RE: [PATCH v3 14/20] thermal/drivers/da9062: Don't access the thermal
 zone device fields
Thread-Topic: [PATCH v3 14/20] thermal/drivers/da9062: Don't access the
 thermal zone device fields
Thread-Index: AQHZSjVt1CNmStCwSEqbfFuNq8Ar967jGjGAgAEI5AA=
Date:   Tue, 28 Feb 2023 10:04:35 +0000
Message-ID: <OS3PR01MB8460E9E5C18126A0A0930E15C2AC9@OS3PR01MB8460.jpnprd01.prod.outlook.com>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
 <20230226225406.979703-15-daniel.lezcano@linaro.org>
 <ff124b19-4a21-f9f8-4249-d72e3b8dbd6a@linaro.org>
In-Reply-To: <ff124b19-4a21-f9f8-4249-d72e3b8dbd6a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8460:EE_|TYCPR01MB5599:EE_
x-ms-office365-filtering-correlation-id: debbf852-07fd-4343-a9d9-08db1973320a
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LqcgVrbuJebznkbTHpMYAoj9+XdkbPXsvQOTqbqjdbQU8sgp6CzcFzlDGK9vfsYgXB+3wUsGjB/7Xz52yTarrNNY0mCsj/febjKBYdlHLDKaD5iR0k42yDAL6FgTWcDl+SVUXkmctYC7MqFFZD7Q+2BRVgT/Yg/s6IEnC9F4oZ+WwuzzHIHzVnVfOdLDpJiQfUGxCD/GjDY1ZEHooldkgwg1cGOb5DxJEHWb5dAi9w9TJdQyYQzbJyAq6PaIbIf8FEKam1TtE9oFbNC7rYAguwVjWv22Vr7XYImuOfhGzYGXW+42LGR6RiG2Ok9bupvLJsKj77X86wuqndRgMRlKRB853JrsfjAYOHEk+1SbMs1dMJMl7SGo15lM9ZRf0OkhGkj54Lh2cbdpIxefaKfzsHcZl16obYffeyW3R2Xcx6ADfqrEn0kdABZOBzCLGuBdQ2H0jb6bICcBQ8lk5BxuMGIyuGEwa5Yc5gfmH6wyvSLUjJoWZeGfi2oxtIxB1JVWULF5iJY+WphUbwWyBTN9mA+m7bVnG37pBpHhWMxFZmQbxRszSr4UalelnSFMqhkm0mzlEB+Rvpey/A3dh4DG8j5zXeLBjevs2H3Y1TM9FnKnmjLulqZerL98MomJIsLW9GY4MO3FIjC1i2nUcFO/kYpj+lmR0QnMOcV3akNofRpedjmclitjLJ9ZwsUFKQgTwgJ9WRRtDdicCv9rn4o2aQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8460.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199018)(110136005)(478600001)(83380400001)(33656002)(122000001)(54906003)(316002)(38070700005)(7696005)(26005)(41300700001)(9686003)(186003)(71200400001)(55236004)(53546011)(6506007)(5660300002)(4744005)(38100700002)(76116006)(52536014)(86362001)(8936002)(2906002)(66946007)(8676002)(66476007)(66556008)(4326008)(66446008)(55016003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnF5b0RUbkFDMUNLWWRHVTlFb1d1UVk1ckZ0Yk53MGI0VHg3aXBVWDNvbU5N?=
 =?utf-8?B?Vm9ES3oxU0ptOHlFRHlBbW5yOFRZdlN0ZmFra3diK1ZEaVp5dm12U2JXTHhY?=
 =?utf-8?B?UlNrUzc3UU5Vb0RKVE1pemtkMTAvYVA2ZlhkcGYwZUgrUU5rd2tETnZXS0xW?=
 =?utf-8?B?SVNaODNZYXV0Mzg1TysyN1ZDVTZGOXFGVThIdjVVSXF2eHlJNlVGbnRidWJu?=
 =?utf-8?B?bDNHQTlVbWhDbU55SW8zTXR1U01mbU1LMitMd0J3NjU1ekdiYUFuaXJJc2Ji?=
 =?utf-8?B?dWY2TURMRmVPWVQ2VXlYbjVTQnRJL1hJZ3RiRTZ3S0NaT1lTSGw3UHcwVmI1?=
 =?utf-8?B?SkNNUzcwaGc4TUQ4MnM4K2hZOVM5SEdic2loQU1ZV1lCaHRkeUdrRWdKKzVJ?=
 =?utf-8?B?L3hQQUM2OEl6VU50aWpLZlF3bjU3YytueVlYcHJJVWtRTFF0VE9NZ2pTQWwy?=
 =?utf-8?B?a3dwT2dYS21wa1BJc3RMcW1xSDN0WkRqeEJVelBydmtIWXdpVE9ya1oxSG5P?=
 =?utf-8?B?TDladXhiUStUY1ltbFJoL1R0Um1BM1RvRWZxaGc1QTh4V0J0K2xnZ3NIMGVm?=
 =?utf-8?B?ZGtIdThsZkpsUVkzZGJ5TW8wYktjUC9MSk9rMUF5VlhhTC95N254SGlKcmZZ?=
 =?utf-8?B?a0U1MytlbTNMdGpJbmlRVjNQWXJYUHRFRldpMkdMU2crZVlaM3NwbUdXa1NU?=
 =?utf-8?B?VGtpSWlsUGxWZnlKK0o5S292YWpCbTZ3SWM1dms2eHY2RXB1eFlTcGo1Vld6?=
 =?utf-8?B?Qis3eUc4QzFiNnh1SENtWkQ4VEVuMUJ6Um9HVXF5YThSMUJoMDQza1FSS0pp?=
 =?utf-8?B?Rm8rRWhLcis0L0Y2VVRsbFpOMXpyeVF5U1lpUVFta1R5UGtKSlUwUWwvbkY1?=
 =?utf-8?B?aExmOEZoNytEY3lyY253MEREMlNGd21qdUVHNWYvRGR0UHFRcUVNSjBhN1F0?=
 =?utf-8?B?MVlpV3JOcURIejFwMXpuVFRjSmpsK0hmd3cyYmc5K1ducjlBcHgySDd3RnRz?=
 =?utf-8?B?anpZMi9LSUFqL09jR2xIWjkwR1NNR2l1eGJuZHJDc3ZaYXkydnJZUXNKbjF4?=
 =?utf-8?B?MUFidUxiN0s5cWl5TGVnczVQZmpRempGbWY1cjRpbzRxcW5NWm1mWVlrOEZw?=
 =?utf-8?B?OVdqQjY3blNNMG5aSXVvZHBhOEE1eFNvTGxDd0Z5aXYzL3gxUjlOaHN1QytG?=
 =?utf-8?B?blBNZWVlTkhVOTBKcTVhWnNmK05hRkh3amxPWERGNG9PNFVPaVdwT25EbGdr?=
 =?utf-8?B?N2lLYm4zK3FpU29uM1hHQk15eTU5Wk5NMEVtbkhab0Z5YzV6V0UxUTBiQkdL?=
 =?utf-8?B?YjFIaEVaY0JCc2psK1R1b0NDcEZxNFR4dmVKY0dOM3NjZlJJVnFwMDg1dkg2?=
 =?utf-8?B?TG9BZVNCM25Fem5VOUhabEhuU29JVzBOY0tJVFlvcWRhVTZ2Myt2Mzk3QWFX?=
 =?utf-8?B?ZUJaRzVHNUgwU0lsWUgxenRjQ0N4ODdkdUFrSHI3OXgxOFlqeFhGV2JmMHNq?=
 =?utf-8?B?WVFpbGVGN2JDSzNiWE1OVFNqNHVMdk9DU1NkV0RqWWtING5RYnQ0OE44L0tw?=
 =?utf-8?B?TjRUMExmMXc2TEpmSHJJVVErRlBJK0ZVdkRmS3FML1RXOTFpcU9jK2l1WjJ0?=
 =?utf-8?B?dzRiaFp2bmQyVGNWTDVFSzBkMXBHQXJESFByQlM1Q2locVBoa1FvaHBwcFFG?=
 =?utf-8?B?VDZmem5lRTkvWndNT0NwZ1hFaEZjOTM2djZOVHNLWlhMandMYVJ1M0hYd2Mx?=
 =?utf-8?B?QlhvUGhtUGU2MzJXS0J4R0E3elZqQUZsdGtmVUpwaklnbFNPMHVKQmR4WjNN?=
 =?utf-8?B?dmJzZDEwUXJPcnhNdGwrZW9Ma01OS3NKQVU1L3BDdXNrYVgxUFBwWXA1Rzk3?=
 =?utf-8?B?UFpTNU14TE9obzBjN2F2YkJzTTdOdnBrd2JZa3JqcFhOSW1pVjJJckVtZEha?=
 =?utf-8?B?THhDYk1RbXBIaFdEZ0x2Z2hkYmgrZXJrMnV5OXpNMzRWQ2lURVhmZGN6akVK?=
 =?utf-8?B?eS9MbnFJVnBEK3ovUlRzbWNGVkoyeUgrTU1ORk9EWk1JZTJCTnhDSE9URnUr?=
 =?utf-8?B?aGV2U09hS2RzdHlOeU4vbnN3ZGQxWTBOWTNNdnc5cWMyNHh1OFd0WWxMYUxY?=
 =?utf-8?Q?QDJNgDEa2M8mWlcuvZnAU5LTp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8460.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debbf852-07fd-4343-a9d9-08db1973320a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 10:04:35.4394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXpj7jBT0jj3+EXYzWPkucT1WxpdH9KtHUXa0QyclPqe6nM5MQR5rVrA4DeZ2+aJJSpxaRM9umYttdrMtUYQ0+p8O6E3LQ46VX/07obfPJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5599
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcvMDIvMjAyMyAxODoxNCwgRGFuaWVsIExlemNhbm8gd3JvdGU6DQo+SGkgQWRhbSwNCj4N
Cj5hcmUgeW91IG9rIHdpdGggdGhpcyBwYXRjaCA/DQoNCkhpIERhbmllbCwgDQpZZXAsIGxvb2tz
IGdvb2QgdG8gbWU6DQoNCk9uIDI2LzAyLzIwMjMgMjM6NTQsIERhbmllbCBMZXpjYW5vIHdyb3Rl
Og0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJv
Lm9yZz4NCj4gLS0tDQo+ICAgZHJpdmVycy90aGVybWFsL2RhOTA2Mi10aGVybWFsLmMgfCAxMSAr
KysrKysrLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQoNClJldmlld2VkLWJ5OiBBZGFtIFdhcmQgPERMRy1BZGFtLldhcmQub3BlbnNvdXJj
ZUBkbS5yZW5lc2FzLmNvbT4NCg0K
