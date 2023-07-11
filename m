Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E14674F69B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjGKRKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGKRKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:10:06 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26252A1;
        Tue, 11 Jul 2023 10:10:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcpZAS2RyYzdicLBq3DORqxViGf3Bc8MRYDWEoO1RS9oAYoKCjk1vwcuRFZ9eFZol5Fam+zjq50dtCmR+OkYhY97+3LYfvxUUKHThbsgIusGClZzs0mZUjMQh95HWKkDSi2As4uDEM+luX+yxLEJMfXejfydZzy7Z7pL7gI3p1LQAV0mLwY+HKyxzcRnxzTqhDDdmIzhHw/m4QeoDBghXgNIKJR9pMKudqJGsdWHDSfFbhYzUCw3GbzUoEhQpXKWsikIlcE8hYDsJBWwhiUbM/1fviwcLtSM+60EuymiyY3FCm4RrUVMk22gVovq+KRLWiTOyaFbUd1Qc7FGH6sn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfZJwe8nBJx5hdZ7Xc1hAe7dt1IOk1Mmid55E7TnODE=;
 b=ks3N0SxiCYjVcHNR3aEzz4OfDoxYBB9c1E0OoYMFkyO3RF+V7mk13IXwGBRdY8AyntvwfnEUq8fSkvbMlQvyi++/9T08ZmxwBA6CJoYjhcn+vxr4Vm4SdcN4Em9DSxtzngtX569Jw9ZYjTGtyn0Hx9QLJS21lJa9JenwCvB7q7qFBrV7u/mqMd+T9hBaDUTJUnWOajc02Z749Z8yI2kYULtI+qn2Iacq74ieaQVnGk9AKa/9aoyhP+HkBx7Rnx2R2d4yugc82onWMthgXLm7ujDJLj8Wg5l4OLTPcMXMpP+Ibe9uvMsluqLkAw9hA9FyD236Nwxc2iuQFHohOe1HwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfZJwe8nBJx5hdZ7Xc1hAe7dt1IOk1Mmid55E7TnODE=;
 b=gvUw4arT0Q2IFnQfn6km5i72woSUj2BAOBnpi3MAqlw5BBr+Da9bk1nHJ2416dBATEVHmkH+P9H3lIQVES+vfa4oWD+9aGRfHEuy6NVGLPyOWZKz620VhCPgDJmEn77k5Z019+fX9O3RJoRbGetMa+EelNIVkCUKKMn5zWeqIaRN/nwzUIZ4L3Z+Z7fORM7BC0+u3liX2VpZpzxcDUIHP+DenfxK8AibJgf/3vGWE3vrHyI3mEmD7CLKUihf8uWo76npaC7YHs1axNieli5z8ySpRvQiesZjiXX6v9Ebi+PJ/3V6LSn8EFL4LlSCBif7QWyWlwRQiUa848/65mIxUQ==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Tue, 11 Jul
 2023 17:10:03 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ee7e:9411:ca2b:85e]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::ee7e:9411:ca2b:85e%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 17:10:02 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH v2 1/1] gpio: mmio: handle "ngpios" properly in
 bgpio_init()
Thread-Topic: [PATCH v2 1/1] gpio: mmio: handle "ngpios" properly in
 bgpio_init()
Thread-Index: AQHZtAoywWb5HJNqyUC9IpZWu2Qdu6+0vayAgAAPIlA=
Date:   Tue, 11 Jul 2023 17:10:02 +0000
Message-ID: <CH2PR12MB38955ED9FDE2BFE0EFFEA901D731A@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230711151248.4750-1-asmaa@nvidia.com>
 <CAHp75Vczih4F9G_UN7GNU8Th+OS=_GLbO51QxJJ+uFHTH_JbkA@mail.gmail.com>
In-Reply-To: <CAHp75Vczih4F9G_UN7GNU8Th+OS=_GLbO51QxJJ+uFHTH_JbkA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|PH7PR12MB6788:EE_
x-ms-office365-filtering-correlation-id: e43531cf-50ef-472b-01f8-08db8231aa5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DoKvwCtOm+v87XEoRBQ/sEQgjLZ4Rm8JzBxLWkHeoOCa/jR62YLTTFBwPmlU3gpOfYLz7ZSK+4HpYcJnfVRg/I82ct0wziT//QrRbjkMsF6nJS/wPML2vKcT5X/S2R5Pe4bUITGQH2yZNMjTGoPHN5uKMuNLczaDfcqig1HpwronXlEYGOLw7ZpeCbBYGsC3YaKEXRD4kTVaYcxd79e93M58FxWJl9E+gTuLng6Ei+5dK9zxkTNRNZjUCBT+kUWoJ5AsRLTH4ASeynkh8UXo/LQh24ej+jYQ5I9RUMipaU9VAYmb+bmKPb6UKcTrvGwmxIaz/7hPpDpEkt3ceQm0Gsb14ogIURUdGcvHr8XAb12l1GAOVUNIfay/m92A+bCXvs3fjirztxBIIjDwYurkyg8LJa1YD8L8iYX7gn9f5v/F6WXoHqWkZxbKd9vtElUWQR3EBSGRFfyAC6fA1Ru/Vkr6x7tAO26R44OX6kABQYPTtbiGKXd3nIs1Bl8fs1ZmuN1ba+/Lm9ULtgn8z+jBM5bYSSpKOBQtyqrhykno3HfOZ+7f28NfcGYu7AwaQOQ1wawciFcPvZRRoEal9sXXXkcrNtu0fLWNPEdQh/s7ZMuQtUWcEOR78WCDYK9fgDLh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(8676002)(8936002)(478600001)(2906002)(52536014)(41300700001)(5660300002)(64756008)(6916009)(66476007)(316002)(76116006)(66446008)(66556008)(4326008)(66946007)(54906003)(71200400001)(7696005)(186003)(9686003)(26005)(107886003)(6506007)(4744005)(122000001)(33656002)(55016003)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk1OZTNSaStrNktPZ25CZmQ2TEhvelZkaE1SWnppZ0ZvYTFHc29CckRBeW5i?=
 =?utf-8?B?bTB2MkVScGx3YVZPQ1hsS3BnNmpHb2lvZC93Z20zb3Y1NWtHdmo2M0Y1U0lP?=
 =?utf-8?B?Tk5KQXlOZFFvSmlRMkg1WUNXaUxWa0NLbEZyZFpUU2l6S0t1QTUwdzF5OE9E?=
 =?utf-8?B?RGw0RVVYcWNhVWoyYWU4TktlV2F0bEUyZFh2b2tyM3ZDR25Oc3ZXNkw2TlBU?=
 =?utf-8?B?S0hoU2hiTm52ZDc2YVlUWXJpa1R2NnVldGlibTN1TVdRMklacGgxbFhVWktP?=
 =?utf-8?B?Vm9GSlByQ25aaEFGaTZMelFWdFBZNFdvTVFhQzd4OUduSnhXT25sZERxRW4y?=
 =?utf-8?B?ZTYvNjFIUVRESGVwQkRtYXllV2M0MEhNb1BUTFRVZFg0dWFOdEtrbVBIWkVt?=
 =?utf-8?B?SWp1MWw3N3RHdWxmTTc0OE84S3lGWXM4ZWJKcmM5dWNhdFdIeFhUQ1c1b2dh?=
 =?utf-8?B?YTJMTTdWcDFLa1pCWHlwQUdjSnZBRnhJMTlvOWlLMHIwemhKc083OGx0YWNJ?=
 =?utf-8?B?WGFUaWdGOVY5MjVDemZ3VzFSOElHVzhtRE5uTnFhSW9GaXR2Mjk2YU9URzNW?=
 =?utf-8?B?dXpDdEp2VWRkUHlNZURhVHc0T3JqQnV1Z2dJTFpxZDlWWFF3UmplaTZiMUt2?=
 =?utf-8?B?bmN4cUhMa0JoN2NRZHY4cWVORE4yQVJldStkNS9sQU16a0dzemcxdm9lbVRh?=
 =?utf-8?B?T0NLWUdkOWp5cVgrbDlRM3I1NEljZFZPOVlTbGt5SXRQNE9XMmxIZ0N2SWNV?=
 =?utf-8?B?emtjTXdWeHRJOStBd0dHSkJKOGdsemN6YlpZNU9TcExxUmNlTWNPUjJLc0hs?=
 =?utf-8?B?T3BhWVlLc1JmRVc4cEFLL0t0UTRHMzhWYXJtcXBsL3Jyc1NHWXJKZWJ5VUp4?=
 =?utf-8?B?NG9BVjNHdzA4K3RWL3pPL0FuS0JDYkl1SkJRTHpEQ2RLRnZ3TU5Hc2h2Tm16?=
 =?utf-8?B?NStWVDU1cjd5KzVoU0RBOHIzY0dlOHJvK1kvazZLbURrOU1OMlJneVdOZUo0?=
 =?utf-8?B?WHkxU3lSWWRXUkNWNjBEVmtzQXJuTGJMZCtmMFNxOXZrb29HUGhhdVF0RDdI?=
 =?utf-8?B?VFQ0c1FNSExleUpjdHV1QW9sVW9hcC95YXJaaDUwSmk2QzVXK3d0azZaSytx?=
 =?utf-8?B?ekFrZmxyU1VXYmFhdnhsdjBXSXdzelh4Y3RXUEltSWk3V3FNT2FRNUpvR3Jk?=
 =?utf-8?B?TGNIUlF0aWlvQW4zRVJ1blFkbGNJSVNjdjVHaGxoZ3pjaHJWc0JlTVVqZFlC?=
 =?utf-8?B?enRlV3gvQ01ZekFubTEvQmZ6TmZMTDZFOVQzSkU5WW5PVGJBaTVvbGN6Rkl5?=
 =?utf-8?B?b1V5Q3hudnF0Wm5WUXd2UjBUVmJqWkJBdjNXTWlqUlNtU2IreEdQU0drQ0JZ?=
 =?utf-8?B?bVhLWXJNTHRZZjIyK3pGZUwrZzVmVjkxUVpsMHFDL2VTMWRwNmUvUmZybksy?=
 =?utf-8?B?TFhvR3hnTkthZXRaYXlJMDJsOHI5V05GY3RsU0Fzc0hWc2ZDTk5oSUlrWExy?=
 =?utf-8?B?ZkRqVlg4MC8rZlpKQmlLbmlqa2k5anNKaE1kQ2NqOEJCbUtxbkFaOGdHcUwy?=
 =?utf-8?B?V3Vsb3hzM1lIOWNKa1BlVmxaNG1Gd002d1J2aG92VjZPR0FTQkhCR3dUMFlZ?=
 =?utf-8?B?NlU0WllscHF6dHFMTFZVU25kazdtaUY0K1ltaUVqaTFsV2VjS281UGl4WThr?=
 =?utf-8?B?SjRjQWRyZkxtZUEwL0I3VTVkZ1FES3RPT2l1cVdVQzhENkpNWU12RE5lSmda?=
 =?utf-8?B?TXBzTDQzN2ZyR0dkNk94b2tWbjg4TGgyOHZNU2ZIMUpZNUNOdFpGSDNRcDNI?=
 =?utf-8?B?Q1JPaWNkMzBRL1NGcVgvN0ZOd2RsTjYvR1BwTUtCRE5hL05UWFFia0ZEaDV5?=
 =?utf-8?B?Z05SODFlVjg4ektuTDZrcnRhcmx4L0c1S0krL1UyTGgvTnJ0OEpPbjNvZ1Ez?=
 =?utf-8?B?TXVHYXVUaXFuQUVseGJ2MnY5SlAvenRjMkRxcXJqOGpBOE81dzMyZ2t6blFP?=
 =?utf-8?B?eGFNTDVtOXpVQlp2N0JhZHRPM3ZTbm84R003RElxQW5QUXdlK2haZHRyQVIv?=
 =?utf-8?B?RGVybWF4bm9iUlhXY0tyUXowY2hoOE5nVnc1WW9WQnF3ajhkUTc1dEhFU1NY?=
 =?utf-8?Q?ZxaM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43531cf-50ef-472b-01f8-08db8231aa5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 17:10:02.5951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0WA2GXSl7dfC3+V8lsqmlUe0QpUbLPZJ8DhkRpWWRCmb60aa7fNMxhCpnZl8aUD8wNIKuYotJvhU++IEGXplA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFRoZXkgbmVlZGVkIGEgcmViYXNlIGFuZCB3ZXJlIGNvbWJpbmVkIGludG8gYSBzaW5nbGUg
cGF0Y2ggc2luY2UNCj4gPiAiZ3BpbzogbW1pbzogZml4IGNhbGN1bGF0aW9uIG9mIGJncGlvX2Jp
dHMiIGZpeGVzIGEgYnVnIGluDQo+ID4gImdwaW86IG1taW86IGhhbmRsZSAibmdwaW9zIiBwcm9w
ZXJseSBpbiBiZ3Bpb19pbml0KCkiDQo+IA0KPiBBbmQgaGVuY2UgTGludXMnIHRhZyBoYWQgYmVl
biBkcm9wcGVkLg0KPiANCj4gTEdUTSBub3csIHRoYW5rIHlvdSBmb3IgcHVyc3VpbmcgdGhpcyEN
Cj4gSSBob3BlIExpbnVzIGNhbiByZXZpZXcgaXQgYWdhaW4gYW5kIEJhcnQgd2lsbCBiZSBva2F5
IHdpdGggdGhlIHJlc3VsdCB0byBiZQ0KPiBhcHBsaWVkLg0KDQpUaGFuayB5b3UgQW5keSENCg==
