Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1B068C149
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjBFP0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBFP0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:26:22 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D7829432
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:26:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzIW/TQhlPalNiwmCjfb4ArcU80UI8jKAdAANCZ8hW0FmsRMJySClK2ahSJ/5tYGdsiO1NZNb12OpBo2Kb6DNe4qJJ3yD9FlB9wmAPV6kRmwn7Hxa1kBwRsWoXiL/390BmT8LCgdUXzJQfhdY1thjYoQkwHAgsWk/PWAehBYTaufWF3nE4Oy9qEaP3tG/ch2ARAw2q2FgQ4QaFNiW/NuVt/UfOyNm9PiEH/h2uTWjTdFtKMzWSMyhWjWctj1iQXwifZySlYDz8S1dQag8KUeXZbynOzVuasOMmizdCbvkd5VxMDDd4gX4h1gk+dZgwkIGyOza3AffkDlCZ/zDMHVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pp4vu6TLXJuVTqhpmnoZsG3vexc5M5v8yY6zzqZybhA=;
 b=U5ewv2livTCx04HmFVHSTjwwupxA/cdJ7RaOZqN9wXUKJeVnCRzz0n8nTYCslfNGbWvljNr4W4mzEX1wdUC5K/0TPj5MsjMJXEhKjNHZlAOj+DQuCkylB3DQxcZHPx5eJppnKGTa1ZJHLAGEvDBgqy2SEB3ZaQNSzIY0IAiWotJgj3njB+Zy/LOHhrvmv+ABVPZ266b8e1JOTQupYDJtMMBBM4JTRpQIqbDM7u8lWLMbWDZPOAbmS9rimNQlAKKusURn869x/vCsUZD6ehId/YtsEsJfNYWmuMeR9vKjJmO8RadMGzMqIZUoAnwYFCCkBuCWEHxSISy5+Cw3hU90zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pp4vu6TLXJuVTqhpmnoZsG3vexc5M5v8yY6zzqZybhA=;
 b=O4NHYoYv7qqPyuXb+6FziPsxiIUB/VYazY8dyvZF7bd7u8JilKFOaNfU6Yw+FG3cTO7u1jiII7o8BAJq9Gg45oZKrg3DSzFt2LU+R7IvINCwC3XCdWwYbPvbvvb1j+q5fvCt29wzpVNiGNDzy0MFtA9DdW6HJEPjMuucWssWeiItpGcWxk5mRfq3p6P+V6eWhuN8Imw1cdIIrjwat3EfeURgBUbYpK293RX8qajxEFZEusjEbee8f5X0tv/OXhdvMVo7lgMWXVWGEi9iUelwq1hRBeExm+xPoi36zTqCB2F7g3ceZGzajuP51gG8e1z03N+I8zaX1yhFKIqdOaJhYw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 15:26:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 15:26:17 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Tom Rix <trix@redhat.com>, "hare@suse.de" <hare@suse.de>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-auth: set nvme_auth_wq storage-class-specifier to
 static
Thread-Topic: [PATCH] nvme-auth: set nvme_auth_wq storage-class-specifier to
 static
Thread-Index: AQHZOjt9c0u58u7t+0O4csGb4Luk4a7CCj+A
Date:   Mon, 6 Feb 2023 15:26:17 +0000
Message-ID: <bdbd3492-6ad6-2dba-70a9-f170e29dc70b@nvidia.com>
References: <20230206145700.1798073-1-trix@redhat.com>
In-Reply-To: <20230206145700.1798073-1-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB6809:EE_
x-ms-office365-filtering-correlation-id: c89a8cef-2292-4a7d-3286-08db08567e1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kLtMN3EOftZ2/UBbkjmPSohgDziu6QH8q9oBx/AdTsg8A+YTOBq40OdUWqEcoer16dm4BNjXpebvRKGB+zvU6pqhAzS4a05zhw/fa/x/tnqksJNCIOI/t7HUNLqxu+ed63rhcSp8KCSQ6PuOS3CRClx4JKuzhQBJzSTCR77qZ43QGikf5nZpGRylz5sD9evbxcxLJSp34VOedQT1NS5Qzk7+FnoXl2XRdWAdbCoWMQIkFU6xFP05AxTPcpSPDev7+SvymvWDxyspwYTDI6Fr7G0hEK5G0o/HhJtpWSfhIXbQgFi2Uf0ofRyDoCptzLc5w9VHAP/fNITPo7+bFj79UrUaD1XUjG1m5lngmPyKpSs6xLDCxy/gnz7m19xOAsiOlja5SdRfLmRw25Gl+pFLn9kz0axnT8ZjIIUnmcPTd1s42+OLEqXdmONw2xu+Mh/pbvYpznbP8Dsi3fARC9l4kySQjksjwDv90BmKjatRtE7XD8dyOcP2qGPICcxMSDUkISVRSZYKHi+NZYq5XeV0B8MWAfELDPzAAbc/mUJg/U+1nOBFQdEv/Bq4cJaiypr+6l+Pn+YBRvMR++Ixj9uO6IAZsdEDjoZ0VilFpE3Bs87m00OLcvhHcOkvV7kJA3n7HuWwM8wP3fHovVKPzm8f6BNd3lGaeHJmrLGWAHvU/Wqn30yPedfKPCfcTzA0rxvnDUeqzwmNrkZoHI09begv8k7DW4YozYvqQK466KxlL5Eu7xzBQpWYpjhsLeGJm/RVYnVkG/GpWI/xMGhlU8V+5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199018)(31686004)(4744005)(76116006)(91956017)(54906003)(110136005)(66556008)(66946007)(41300700001)(316002)(4326008)(66446008)(66476007)(8676002)(8936002)(64756008)(5660300002)(38070700005)(36756003)(86362001)(38100700002)(122000001)(31696002)(71200400001)(6512007)(53546011)(6506007)(186003)(478600001)(2906002)(6486002)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2xwTG0rK21SRHJYTDNDZzFyY2FIWWdhbUJyVDY5M0xzQXZ6cjV3OFUxZXNq?=
 =?utf-8?B?Y2hSMzVnL3ZmK3hKdWJlaHdwSEFxbzRoTmgwZmxJOEp5LzFhTHZiUHowTVJo?=
 =?utf-8?B?cVBGU3l6RWc2V2k0K0dPTlloWG9QRWhyTVlDQVZCd0RTNWRhczgrMWNrUGlC?=
 =?utf-8?B?cG5zNCtYUTNjSUZwaFV0VmhUcWN4anl2SCtYWDhyOXN2Y2RVUnBHTTR3MXdi?=
 =?utf-8?B?UG8xNGtPa0Z5WHFvbVRHYXJNVVBmOVQzQVZjcnNGR2VqcFd1K3VQc3VsQ1gr?=
 =?utf-8?B?dVZWVFdEdG5pODBWajIrQWtIZUtkSHZmc1I3K2M0a0tucjhpa3dJY243YWFw?=
 =?utf-8?B?M1lsakRhYVZVMXlQcUdjaW9SeVZiVXVnbFF1dkhscGRjS0dmNkhPSXNYdHAy?=
 =?utf-8?B?NC93bkEyc2pCTzNwZjFlVXgyOFNUVGY4d3ZndFg3ZTNEL0dIaDBWY2wzd0hp?=
 =?utf-8?B?cGZnNFcxQzlSOFZkVHErRFhhbnFPV0liNEcya28vdjJpNEMwdmdCdGpzd0hP?=
 =?utf-8?B?TTRLMjdTRVJ6RjlsNzRTcWV0cDZZaEYxMU11c1lxT3lvUGxJL21xdHFVRGtX?=
 =?utf-8?B?TlUzaWowbCt2R2J0U2ZTOEgwRFd2a0hFbmV2VlAwa0MxS3ZaYUxRSWlEYWRv?=
 =?utf-8?B?RmJxSE9Dd1pvaFRYNWRUVFREMVFIamVLaCtneFcxTmVUREFxWXdHR2NuVzVZ?=
 =?utf-8?B?QXg5Q0VhV0ZMZGhjU3kyNTBUVGxvZCs0eTQ0V2VpNTkzMG5yUmVYQThuRStE?=
 =?utf-8?B?bkI2RmxKMmFwNHVCWTIyVTZmZDRud0hmdXE5RHgwSXZVeGtXbVdsZzBUMUcz?=
 =?utf-8?B?NTBwM2xpUE4yclc4SVFKZEhzOTdZejcwODFmdWpyZUd2aklwZExmQ3hLbzhm?=
 =?utf-8?B?Mk9lMW0ycnZhL2lwdzZFOUFIN0FNT21RQmVsOVgvY1owd2pQZXFUd1BjWE1T?=
 =?utf-8?B?dFN1K091Q0k5U2JlekhTc09pMExMTGtGbXYyWWZnVThEdFUvVUdQQUt5QjVr?=
 =?utf-8?B?b3RjNkl3d3pDQXlPeHY5Ylp2MUxtc3RtcU55TkYzSG0xcGdxQXpWS0FzVjE1?=
 =?utf-8?B?WDQwV0FQclJnaS9aQ3dHNmhvR2V6S3lzancrZWxHL29KSDhnY3piZ3YrMHhr?=
 =?utf-8?B?ZGxIYlJqUG0ydElWMW9BV3Jjc1oxUzVqUnVMak1uVSt4ays2RHVQZmhJZ0hG?=
 =?utf-8?B?ZndOVjk2N1FITm5MWEUrQ3VTTkRBbEo0d1FRWU5KL0M3d1dBRVZrOUdZOUdi?=
 =?utf-8?B?VVVreENKZHZZK2gwSE1IMzRvaUMvY05qUjZPT0NWRTNTaXAxY3F5aWNyWnlY?=
 =?utf-8?B?RXU5TzVZclMxU2dhWmNqUjNtaHV1R1ZjYllFWWNUYkpPWFdTSEdwZ2ZhRkZ1?=
 =?utf-8?B?bHhJWGhYbnVpdGN1b1ZTTzZBbWplZ1RMV0htVmJvUGhmNGkxbXE2c3VyZVpi?=
 =?utf-8?B?M0hTZVFFNTBISFppSDJVSHVBM3ZTQTFkMllPbmlIbUZaRS9yNDJKK3NheC9o?=
 =?utf-8?B?MkowdFhlL0NqYkVsWjBEL0VFTXFXaTMzdW1kVDVqODlDY05yVnFKN1BtK2sx?=
 =?utf-8?B?K3JUNGFwNmo3WUUwTXBoUFhLTVNkekFsdlpWZmhTYzB4ZS9NOXlET3lXbEJZ?=
 =?utf-8?B?eGlBMnVGTzBzN2REaFlacG1rQ0RQdmdSOGlXQktDMEorVnl1aFZhTC9aSGV3?=
 =?utf-8?B?QklvREtFNk1VRjVxTVlFaG1WVDhvalJRdXpCZGFRVm5TQmRUQjhYWEVCR3BL?=
 =?utf-8?B?YllDOENHMmZzWXNhNVdYMjBCbm56WXI0U3k5b3VZb0IxM1FkcGhnbVBvd2Mx?=
 =?utf-8?B?aTYxcElucGtUZGdsR3czanFoUDhGME42Mm0vcXFBWXJKb0plYVpXZjIxSExs?=
 =?utf-8?B?VlV5N2tOaEZNT1p3dWRrMzVTZkpjdGFNUzZ1RHEwcU1xV1l2NDcreS9TbnQ1?=
 =?utf-8?B?MENXTlhoanFsajVMTFNkdExmcFhYV0p5WDVmS3B2NlRXeTJBTUV3OC83U25I?=
 =?utf-8?B?MEZBUk5JdGdPdGF0RTAvcm1KT0xCblF1Q2tEVUh2T0wzN2xBKzIxR0N3Nk5s?=
 =?utf-8?B?SlhTVjhqUVIrbi9hUjI2SzVkNnV6dFBidFZPVUdsQVA3bnpCVFFIUUFqb01L?=
 =?utf-8?B?ZTV5MmNvaHE2REdheTlsZTZFajBqd2tlWWc2M3BYRXI0TjEwblphWkNZUXpz?=
 =?utf-8?Q?gIpezuG2nHKLVwsYni8zaMcT6lquNanvO55YeJmh5pOD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0804C47C49B524C96829E29159E9083@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89a8cef-2292-4a7d-3286-08db08567e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 15:26:17.8953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+eJ4mYdB1qMwrxNQQrtfEjXFD/sYV9bR2+JJt4ZFumIlNXCeoaHk2iUkrMAQqK5iLDwfHZexNAWXkOCgJkS/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi82LzIzIDA2OjU3LCBUb20gUml4IHdyb3RlOg0KPiBzbWF0Y2ggcmVwb3J0cw0KPiBkcml2
ZXJzL252bWUvaG9zdC9hdXRoLmM6NDg6MjU6IHdhcm5pbmc6IHN5bWJvbCAnbnZtZV9hdXRoX3dx
JyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQgYmUgc3RhdGljPw0KPiANCj4gbnZtZV9hdXRo
X3dxIGlzIG9ubHkgdXNlZCBpbiBhdXRoLmMsIHNvIGl0IHNob3VsZCBiZSBzdGF0aWMuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBUb20gUml4IDx0cml4QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIGRy
aXZlcnMvbnZtZS9ob3N0L2F1dGguYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUv
aG9zdC9hdXRoLmMgYi9kcml2ZXJzL252bWUvaG9zdC9hdXRoLmMNCj4gaW5kZXggYjU3NjMwZDFk
M2I4Li5iZGI5NzQ5NmJhMmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2F1dGgu
Yw0KPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9hdXRoLmMNCj4gQEAgLTQ1LDcgKzQ1LDcgQEAg
c3RydWN0IG52bWVfZGhjaGFwX3F1ZXVlX2NvbnRleHQgew0KPiAgIAlpbnQgc2Vzc19rZXlfbGVu
Ow0KPiAgIH07DQo+ICAgDQo+IC1zdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqbnZtZV9hdXRoX3dx
Ow0KPiArc3RhdGljIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpudm1lX2F1dGhfd3E7DQo+ICAg
DQo+ICAgI2RlZmluZSBudm1lX2F1dGhfZmxhZ3NfZnJvbV9xaWQocWlkKSBcDQo+ICAgCShxaWQg
PT0gMCkgPyAwIDogQkxLX01RX1JFUV9OT1dBSVQgfCBCTEtfTVFfUkVRX1JFU0VSVkVEDQoNCkxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQotY2sNCg0K
