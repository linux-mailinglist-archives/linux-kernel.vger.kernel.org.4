Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D35C5F5663
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJEO1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJEO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:27:45 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130134.outbound.protection.outlook.com [40.107.13.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868294F6B5;
        Wed,  5 Oct 2022 07:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yi/ENQDcnirulUStRA7MFTDQyxnBQcO4LE5HI/q6UAh3CWIS6BAxZWpAgv851up8L/AhtCF4u8o50E5mBNB7VTjEdiUL4JMCO4EfGd3+A081cwlJQz1Kwe06x5DDZuTKLbHJMzxIDFH3BmdUymkrernNpfgGbHJJxbaR0lG9JaOXTDt729wSSsmbGOf4HbCswUkhRr+PVN9QQtazDUMnBay9G5CMigwsc4czaGrhaW7EHfvGCBPrR/QK6Vv6aikmd1+/lxu0+iLBkzWd5egSNeLQUBD5wXNYdBPefjGl/2uBG1XpWJzCUMJ1SQ7fvy8QnRskRAHOs0HJbOCm3VXuiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGk4KaK+YcXbW+13Q5BstpCwao26PEdaWtI1tY8heA0=;
 b=nRABcLjKMquvnPm0ttUvUec2Rt3wIawnZTTpCrddnjiIu73+DQWNRg5c1ZCn7SdKzK7KlPmg+5CFtdEnkrMBra8zXOCVMu7iipXNWhfrIGQh6xdAx5GFTserVif2GBYQZC/TJeIJxxd1J3EsSSco7L42AYbWCMKqmrckrULC4ozO4ggZpi1gLoN3Zoqhr26IFrojfQLYe+y/C9BCU3TmALSHXwTzifUk3DBuFD4iuJ6DMUsHxt/R/i9bGDnUYTUIqAfohs+iPspfOgI1d3zZZrZ11z1ZJFROtV44+XKOHFmyhnSZrAXzK4Surd8MRtHP3E25XWXyRWApyai9HsR6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGk4KaK+YcXbW+13Q5BstpCwao26PEdaWtI1tY8heA0=;
 b=bCU+nhzOGtmJNMxXc2C63kmNeXo/amEWMyPapFw/vYt+HGgxq52YIpI7TFzI9ucWSCOpC8RobGDf47qGARh0kIyF0BLPqgH5u0tbUcyhRaZtfIJaIs38LXymY75zrTVWo/WYfpSYCi04dXYlNHBAf6vQr9cNhDVSBAocKV4Xz9w=
Received: from DB9PR03MB7794.eurprd03.prod.outlook.com (2603:10a6:10:2bf::13)
 by DBBPR03MB6700.eurprd03.prod.outlook.com (2603:10a6:10:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Wed, 5 Oct
 2022 14:27:39 +0000
Received: from DB9PR03MB7794.eurprd03.prod.outlook.com
 ([fe80::550a:e73d:6a17:4250]) by DB9PR03MB7794.eurprd03.prod.outlook.com
 ([fe80::550a:e73d:6a17:4250%9]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 14:27:39 +0000
From:   Claudio Cabral <CLCA@bang-olufsen.dk>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     Claudio Cabral <CLCA@bang-olufsen.dk>,
        =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: dt-bindings: add pin-switches to
 audio-graph-card2.yaml
Thread-Topic: [PATCH 1/2] ASoC: dt-bindings: add pin-switches to
 audio-graph-card2.yaml
Thread-Index: AQHY2Mafr+xemZDQ6USahrmQTIqiJg==
Date:   Wed, 5 Oct 2022 14:27:39 +0000
Message-ID: <20221005142734.2724537-1-clca@bang-olufsen.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR03MB7794:EE_|DBBPR03MB6700:EE_
x-ms-office365-filtering-correlation-id: 1c441676-5f70-4dce-a1b6-08daa6ddc1d9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aprWl0v7PnOLdV7aEGncu/l4o2iPgXobFLvquialVe4lUvvQUn4KLFJt5MK9cpJkEOGUI1tFa/uck2pRUD3t7pMFVUoiHVSRhluoG7iwEVEMXjHLiPXvJIXFUjAVU8cPI7oIVZk5VDZi7EqY/dW/qLeVTB7oSergaNyc5quwfVkas7Yy2mq31jNopiO4caxZEz9y5yr/a80RTRekCjufFSCIi5mjgC8evcD8ZDvaezApdsR3mjpsHtGO5i5BsvWznfkgf5nilZctFlOASy2Un6DdBqfZO/yxaJMoAZ2B2zqmzkwst0v48Zj9R4WTCZh/OUWLfjvKTXP6k+N/nY2lzakXkKpvQ3Nu/27H7VEO1zuAlC0p3dU7MlhWC9boEYzccdkR6d34cii0CcaA3IofXx5EH+uQhypLLrgOQa+qrcA3bEZiJ69+FwF5e1KGay87RScQrLJDQudQ3ObDRGL1L5F0xeQ+OWeWj0G9ahc0RZGJOnBNlT311gPW9RQ6cMNCw9L79j8YTKoupY+9GU0hbMCkQgkanutXkXEIUz0r5D65tc1pzX6Vnbd2XLLXKJFLEIHwru48/CoKKHgMODFrIp4WfThLL0ZbZg8/qGcsj87qqRe3D1L8DI7HIPEEr9HmavGW9UKrPMfrIej9Nv9OqnGA6esMy8FDVZmglPAr4kGIkaCbdUEIJkjSMY7Xj1Aks/nIEcH29abxD+7ldFmZB0Sw2uhn8rgOB+nPPfOh92JqierYea8XkIC2JtGJ8NudOURR8PQBZi5rgo7kmO/QiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB7794.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199015)(186003)(2906002)(38070700005)(36756003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(5660300002)(4326008)(7416002)(8936002)(86362001)(8976002)(41300700001)(6506007)(38100700002)(110136005)(122000001)(316002)(1076003)(478600001)(4744005)(26005)(6512007)(2616005)(8676002)(91956017)(71200400001)(6486002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXd3eC81OWhHUS9qSkdrb203dUJtWThjMEhmZkxrZmQvVWpOWTlwano5amJR?=
 =?utf-8?B?VytEcGRvRTZnNHh4dG96Y09uajNzZmN5MzV5NEwzeEZjTEhOd21DTDhBTnJN?=
 =?utf-8?B?dmI4SUNTN2pXczdkZ2Z5SG1McEExeXdVRmFvQ28ramZpNXJrYTNxWDdiblI0?=
 =?utf-8?B?dTJ4RHZTUzFVc0tzWUpVQTZWczlPWTgycDVZeHVBanEza2Fnd2hwS1AvTDF5?=
 =?utf-8?B?ZGVIdFNaVmFKQjV5Y1hoOTdZM0pzQVk1a0JnWkk4RUxqRW1WSyttdHVHQlJN?=
 =?utf-8?B?N010bUFjVlhWT2hzbkNHS1k5U0lPcEpoZEszbDM3ejF4ZHFpWVhQc3VtUWpG?=
 =?utf-8?B?VnBIcVJ4cUkvZzRsb2hrNHQ3N0FoMm5ueHpKQUtBaEdLSzZEN1padWtmSmIw?=
 =?utf-8?B?M2d3cnBGN1R3MnRPY2EySGEyRzIzZERzVWpLa3o4NVZJcXpCKzJTbmNkcVU2?=
 =?utf-8?B?azlMY1dFZkZuUlRnWmdYY2tZUlg2M3RyT2IzZG5WQUFGOGZnUkFCUDFSNGhW?=
 =?utf-8?B?TXNCNkw3ZXZnZlpTNmFuQUxydlRtWU53Rjg4TllRTzVod1RKODNJbWc1VGF0?=
 =?utf-8?B?VmNEUVVmU0JuNDFnanpkZ0lDWXpOeEl3NklvTkRDUDdkdjhwV3Zxa2M4QVM1?=
 =?utf-8?B?bC9xckhlOHpsbE5LNjZJOXJJTGd0SFdNSUltcW82RjQ5bklpd3BnVzdpb0Q3?=
 =?utf-8?B?ODJNaXpHblJJMmdCMXdqVXdSak1HU3Z0dk45QXA4TUREQzhjaXJ6cVB3VDg0?=
 =?utf-8?B?bzkvNnVhblk2MjJINWs4aHJtTmFscUp1Y0hKV2V5cmYzUGhKeE1GcTBjN05j?=
 =?utf-8?B?VllSNk1TczVidEN4Wm5qZ3hTQW1FampuTlNFS1VsSlpFeGxtZ0xiOXFWeUNB?=
 =?utf-8?B?YTZuejdzZEZJdmROdkgveE1IY1piMHpVK2QrYVZyVGFKZ2oySTdpSjM3Sk0z?=
 =?utf-8?B?dE1zZDVKK3ZmMFFXUVllTWlGNUJkNFRMZVJwaHE3WFFXSTlnaTJjbVI2V3BY?=
 =?utf-8?B?YmZXbm52S1QzYlVWVWpnSWpNZEJjRWcxSzM5M0QrdlpwQS9uaE9iQTZUMCtu?=
 =?utf-8?B?RXFNY2tOUytvSEo2TUcwdWp1eitrdUdQeXltWnUvY0ZqSmhLcFMyT0dWd1lu?=
 =?utf-8?B?ZSs3QWVBVlJlWjZXcTRlaWxTN09ROFQzOU1CYXpPSkVZTC9HMnJSSEU5VE9w?=
 =?utf-8?B?cE9abnFhbnNKdldQeCtNRmFwL0xMenhCZjZjWVZUV0xra3Ezcjk0MGJ1MWYx?=
 =?utf-8?B?ckxSc09nSkNxUDRmalh4V0JZK0doWFJuVWo4dWlNckM1bWFXTWR4eEdYZFFN?=
 =?utf-8?B?SjI5TU1HMSs0SFcwZnNraHUxZUoySmhhOGhQZHAxbGo4WHBPck1JVVRWdnZQ?=
 =?utf-8?B?YnFyU0Y1QUcxWDN3bGxDT1B6U0wwQ2tmT3hoaWhPYjVncGlyaTN0UzFaRmdk?=
 =?utf-8?B?NENCczM5ZHVOQlNRN3g4TEx0Y3E1aGNjNmJKNUlvWkZOM2hTSzRqR2dxcGtH?=
 =?utf-8?B?RUVFWDhsNytpTlNzWmQ2cHRDOUJNRk5aZ1ZIbFRnSFpldCtOeUI4MlEwNVJP?=
 =?utf-8?B?NEcyMUduVUhybzVUODNRVmIrdXF6TUZ0bGZxamtSbjdTM2pXNFZuNE0xODZ5?=
 =?utf-8?B?Y1JxMjlueVJhVHo4eXRWTkpidVMrR1NpWVJxSFhCUWcxbDloUVdPNEloRHM0?=
 =?utf-8?B?OTNFdVFqUHhJbmtUVUVKdWVRQk5WQmZnZ3QxeFR3OFNCUjdVcHQ3ODNNbG5O?=
 =?utf-8?B?OXlEbDhBRnIxcmxRNS94b09teEF1VlhtcmZuSVNZaU5tZER4ZW1VQk1vY1dY?=
 =?utf-8?B?MXJUeGc0YWsrOUtQcy81dDJBK2dmSUFOMVpiaXdxNzAzY3RGUHltaUpzNjlK?=
 =?utf-8?B?MGdFZmJnMEszc1dQcjBIRmd2RDBBdFhXNHRYNkZvZkJDYlpxeEpHbE50SjRX?=
 =?utf-8?B?OWowa1VxZDE1RGRraHUzOFBabzFLbnVOclp2MmNaTUgzczN3WU5pNUN5c21M?=
 =?utf-8?B?WTRMYVFhb1RIUWNSZS83UmR0dE84bjNmSXZsTndNbVN1eVRtTVVzYXorN3dO?=
 =?utf-8?B?eXFmNy9pQ0t5V0tNUkl1dldhUnFTK1A2anhDcUFtTjU5V240VWNoTVBVM3Mr?=
 =?utf-8?B?RUFTUCthdzAyZkZGUk9qQnZGci9GQitSZzlqMytlcERnRXdPUlFKclFoRWc3?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFD122883962854E80015C140F4D58D0@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7794.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c441676-5f70-4dce-a1b6-08daa6ddc1d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 14:27:39.6438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdmMT3H7Yif4NXjhmSQNMIoVLsuGoPbPlCzxuPHIXXOX7o3dJrWrCk2FlFCfCV6sCTFoPiHpjImPpVIsCaGRgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6700
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG9jdW1lbnQgc3VwcG9ydCBmb3IgcGluLXN3aXRjaGVzIGluIGF1ZGlvLWdyYXBoLWNhcmQyDQp0
aGlzIGRldmljZXRyZWUgcHJvcGVydHkgYmVoYXZlcyB0aGUgc2FtZSB3YXkgYXMgaXRzIGhvbW9u
eW0gaW4NCnNpbXBsZS1jYXJkDQoNClJldmlld2VkLWJ5OiBBbHZpbiDFoGlwcmFnYSA8YWxzaUBi
YW5nLW9sdWZzZW4uZGs+DQpTaWduZWQtb2ZmLWJ5OiBBbHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5n
LW9sdWZzZW4uZGs+DQpTaWduZWQtb2ZmLWJ5OiBDbGF1ZGlvIENhYnJhbCA8Y2xjYUBiYW5nLW9s
dWZzZW4uZGs+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQv
YXVkaW8tZ3JhcGgtY2FyZDIueWFtbCB8IDMgKysrDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvdW5kL2F1ZGlvLWdyYXBoLWNhcmQyLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc291bmQvYXVkaW8tZ3JhcGgtY2FyZDIueWFtbA0KaW5kZXggNzQxNjA2N2M5NDVl
Li5hYjJjYzgzZDZiNGIgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc291bmQvYXVkaW8tZ3JhcGgtY2FyZDIueWFtbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2F1ZGlvLWdyYXBoLWNhcmQyLnlhbWwNCkBAIC0zMiw2
ICszMiw5IEBAIHByb3BlcnRpZXM6DQogICBjb2RlYzJjb2RlYzoNCiAgICAgdHlwZTogb2JqZWN0
DQogICAgIGRlc2NyaXB0aW9uOiBDb2RlYyB0byBDb2RlYyBub2RlDQorICBwaW4tc3dpdGNoZXM6
DQorICAgIGRlc2NyaXB0aW9uOiB0aGUgd2lkZ2V0IG5hbWVzIGZvciB3aGljaCBwaW4gc3dpdGNo
ZXMgbXVzdCBiZSBjcmVhdGVkLg0KKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZp
bml0aW9ucy9zdHJpbmctYXJyYXkNCiANCiByZXF1aXJlZDoNCiAgIC0gY29tcGF0aWJsZQ0KLS0g
DQoyLjM3LjMNCg==
