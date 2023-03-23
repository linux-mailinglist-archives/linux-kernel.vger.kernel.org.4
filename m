Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F616C742F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCWXl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWXlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:41:25 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8F2170F;
        Thu, 23 Mar 2023 16:41:24 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NLbopC018522;
        Thu, 23 Mar 2023 16:41:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=OAtGCglNJZ7qTJPn4rO+KmIlLUWlW8PZXBsUVmvidOw=;
 b=WxafgrdjEfyjGQFrv0aKrL6VczC8UFg5UQizY2UDFVFNzxdjPW8JO1AG6L2dxXuKwAjl
 npHQHmXvXiO6ll3gQLM3zpm87fRbHRSc7YklIWiDNxEPpBP8XgYrUKHFTnMRu2lpJWuA
 JA10BWZSnstZGKax/AKyQNJ9pcw8NIe4wsYxgfmZ8twBb/0a4E4ZMZN/dB6fq93FlXm1
 DIW20QzmxfaA5FP1/BOeHb4kGSXHN/pKwnwdpmQb1MZxYZxgflcBIAPTqtLX3r3HTFVy
 pkpat3k6QigVa0GJbEdBqasb23bOKqMshm6B6azavCWXdfMkGi/0KA8NhWA+LRQcl79f Sw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pgxunrg7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 16:41:14 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3F63AC0443;
        Thu, 23 Mar 2023 23:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679614873; bh=OAtGCglNJZ7qTJPn4rO+KmIlLUWlW8PZXBsUVmvidOw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XjSVj1+lyeVI/WGfsnCh/h5D5Dm1NHfKnCExDZgb/CEEHy23d5KPXDIAbg+8W5Xyb
         O4RbFlwBCNYfKFHlQfwiVzBbzMqZBH0SWHNPKnquXIWcTPgW6riPKVjRbFhTztHDtf
         3ynUDUrpedBvsWZbk9lxClaXdkVbTkvdjhUkEgYqkQ175cgwMpPAGcVrOpE6S5imMh
         9d4BzqcYb+hsWt17DSpShtIARX1L+bSqJpY3Mtml2Xu7yiRVXZBT89bY5DdxkObBL0
         zGEz3V1yoREzlDOj+W+3QPN1PkGgSX6j6Lnnd8UPskuneGESMP6q389eaP5OruGb24
         XeRjjd12fRzqw==
Received: from o365relayqa-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relayqa-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E257EA0073;
        Thu, 23 Mar 2023 23:41:10 +0000 (UTC)
Authentication-Results: o365relayqa-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=EURMf/IX;
        dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relayqa-in.synopsys.com (Postfix) with ESMTPS id 11C9C220934;
        Thu, 23 Mar 2023 23:41:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elNVtgrpYDevm/2JSA6nDW9M3dV5lZe5XvHDQ/JwdXDp2vfDKhZ4t2TCKwQP6txRauu74wT1SVO/bJ8XNyiBwV0jUO8E1YDLme36Iv7NiaHd3CvO3178DjaFkQm6wc4IEdlcV8qNYRBAIBtevZKxHe9/UZxFBghgY7KWuk/bgWRXzkp/Ww1737eVjFVztztDEMekdOtF0dhv6YN/4PVImZRuWdQTdCWM7Qzsoy1FfOTJux3vvMJeLEDw1OGXS8WfgNnqYsBRjAdErbb6cJA1CTdqLadrXRVFHU01CbRUWnNSfjwVzpzI3zT7BZzVkRA7kykzEWaq9tD6Bbu8l82aJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAtGCglNJZ7qTJPn4rO+KmIlLUWlW8PZXBsUVmvidOw=;
 b=WsVJgQI9iUTXl+tnthW6nw9IgDU8HzK1i+cpawrrMKSx6/tKEUguKG/e0DC8Z2Oxy90DanxXb6o9s5BdjRHJ6IkcJbYwMFlBmHLE0BfooCPJLCrnJsunH7/1LQ66yDooJDTZGEV2A+19zFNSt+i0pB55NZqUEfSH7oroJAegmGpPJxEcprIBhslVQUl68xaRaRG1Tin7yHolwBKy5U8BRzvZOSSoozmt4cCbaKsMlZLXiFpPFCgRItgRyTbcSe+Hmc6t0AiF699zYLu8ZD4N1naWOq8fetS2Wb8vBFLAIazR6RaVRSqVQVluvvUV51VqxJKJeDD46g6xIhIHtDzoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAtGCglNJZ7qTJPn4rO+KmIlLUWlW8PZXBsUVmvidOw=;
 b=EURMf/IX3ymFoTP6xG0GYcbP+p+pLhF6Mk9pdQEALwRb2AmKjNWA3lPBn/LqUTVG0AEF1pLiP0dO/qgjOJX01OO6xhaPgoN1WwFVTKKdt1J1Si8jKA2/B5DOziutZPvvj1Pfh29vkdRjTx/evxvAKtqhckDo1Qkx19MXIjzBN8Y=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 23:41:06 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 23:41:06 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH] usb: dwc3: gadget: lower informal user notifaction
 dequeue operation
Thread-Topic: [PATCH] usb: dwc3: gadget: lower informal user notifaction
 dequeue operation
Thread-Index: AQHZXaupiPw/2dpwu0W+BQUYZ9zkua8JBoSA
Date:   Thu, 23 Mar 2023 23:41:06 +0000
Message-ID: <20230323234103.mx7f3pzvbrrguzqe@synopsys.com>
References: <20230323171931.4085496-1-m.felsch@pengutronix.de>
In-Reply-To: <20230323171931.4085496-1-m.felsch@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB7282:EE_
x-ms-office365-filtering-correlation-id: b5befdc5-63de-4b6b-0ea4-08db2bf81252
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r4HALV+dYMLdM0mUDt/XdQ5gO2n5O27pjXDM8/AeLn1hS8JoS0pqfhCcdap3fYqlzEN0DM6cxN9yrpnd65Ny+8AXBiZYMZgaN0Kgkn/qTLTZj15DGu5GX1aaGSyxgzwbpSI74ADBPE/RnMtrqXU6vjrswh9ZUqnFVViwWjS7ZCbCiH09Axgl/eAZms4C0sdC7BGQ51lDOooD8KCr3HSCf4Na1VTe4AjHsTINYEaKlrSuVMBHXLTaFTC2fCK1t+4+muVYqvZtPZn79whTqJ8HgxL0inhdiXPULnGr4xSYa+Lj4MXRksuEx1j+BCyGQTizAIbC1++MrNExndSXFmr3DIq3XymLcAxX1tEH14rayZtUaufjchzFwsVmuXeGl6R3Ef7+DDx1D4ER3h8w14hOcS2cWecCbOvlBWr0fF1POjMC6pMoSZZla/wlx1PYA4qgGG4UwZceOUfrx8/C7Ut8y842ypN2QxzSKLrR8CxesfHR1gkzDQV8ckD5H2BveXPDIaVk9/pI1k7H2OjuiaNHJaHxr6gTJKdp6jhV9EM6lH0WeZoUg7Op3UX/yHfniSx7tuUaQZxmoxRNm+sodVwC/w6RMbcX66YP4WGjG2va0ARglbQJ4LV54D3g8KyzHNoPz/nqOl8Bk6OgRntzfTiPJtwQZ+f+W1TCSOZEYW+D27HL+BvG7a3wr+yaiqKv1IbeXsL2KT42858aThVHqAJ5Kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199018)(36756003)(38100700002)(6916009)(86362001)(8676002)(4326008)(66476007)(64756008)(66446008)(66946007)(66556008)(8936002)(41300700001)(76116006)(71200400001)(6486002)(316002)(478600001)(54906003)(2906002)(5660300002)(38070700005)(26005)(122000001)(6512007)(6506007)(1076003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVRkVUx6SGxFQ0hzb0JtZ21GYUpaWkVvSmV4RXFTSWJlRE1keVZhcEZmaXdL?=
 =?utf-8?B?b252NU53SjlVeHJ3TjlZU2pOcnlCWXBGazNsZnFoL3dqZ1k4cmNCT0oxei80?=
 =?utf-8?B?ZzdNdHM3NVdVVEg1dFZMT0VpT3NqbkRxSzVyZFBaQzl6L0o4a3Q3MnJzRDZM?=
 =?utf-8?B?UE00dVBxTWFsWnlYRWU3c2F3UWUvMkhhYkVXVms2bXdyYkhBWmc2ODg5K0J2?=
 =?utf-8?B?TlhPWGppVWpSQUhPZUl6Ri9oMWNrb25uU0JYeU1ROFNHME5RbmRmZ0hOb05u?=
 =?utf-8?B?REUzT01MaWpkMFFiRWZPS3lRNHh3dzJHTjdHby9MT2w3enpMTmZ6Z3RuNUJ0?=
 =?utf-8?B?eHU5VHdFbU5tUlVGcVl0WkJ2S25GWktKWEIzdnRsSUFXalZ2SnBKVys1Um1H?=
 =?utf-8?B?RTB5TWNES1NDMTRhQUNvdzhnaXRqSmlRQ0hrNDBMTnpueFdtbXZ2Q0xUN0ZM?=
 =?utf-8?B?Z3pMVmdKVXVTOUZudTR0czJJL0t2eWZFc2tpYnRVaCtaalFNOUNvUnNRbGNF?=
 =?utf-8?B?QVZxZGNHM3NIQlNTeVY2NUhHVDNnTjZ2T3ZqY2VoYzlpYmV4eWt6VEI3dXdV?=
 =?utf-8?B?S0pzME9KREJoMUNUSjVidDRDcUxjQVZiRkJpNEJpbzFPMTllUU16RkJYMS9M?=
 =?utf-8?B?SWMwWi9OSWhyN0hzWHpLMHl0L0Y1MmVXRWtOMzg1MSt0WENsd2l2MEZiaWgv?=
 =?utf-8?B?K0JhNEJMNjNNbVdnSmc1MWlIZ3Q0Y1p5Ymw1QXhQdFJJZjZxOGJUOHl5cTFI?=
 =?utf-8?B?cktQc0tKYS9SaDdlc2s3bm8zYTNpVldQQ3J5UDZkbnkrUkRyWVNOdzF0YlVQ?=
 =?utf-8?B?TXQrWUN3Y1FLWEdLRVdOajU5R01TWVV0dTRqeXhJSW5Wc0dzZXpGdWgvMjVu?=
 =?utf-8?B?MDN2N2JlQUpXTGZodlZzeU53TkhNSy9rcS91Z3h3M01zS25tRWFxZjlyRFdC?=
 =?utf-8?B?SmNpSk1TaEFidEpxalJwV0dCWlNVOVJUOTM3Q0VnTHNsVUw4Z0J6Z1Z2NmtL?=
 =?utf-8?B?eXRpTjJMTVVMaGlFOEdITVJzbmQ0VXNRaFp2MFlDWVNiUUsrSUxlMnlTRlNm?=
 =?utf-8?B?blBJNG1ia0VIVHg0czVmKzVaY1dVZUM1S0czNWtLajdSVDROUU05SEVJaXBx?=
 =?utf-8?B?NzdEM3dwc25uZHVzUkljeGR4aXVBczdYRFhucWF2RDg2SnQvNWF5cHljbTlN?=
 =?utf-8?B?YTVOZngyYVBFVHl0R3NaYllWTjRQaEtiVUp5Mmp4a1JDdDN0eFFhdWdhUDhC?=
 =?utf-8?B?Qzk3QlErMVlBYytqL3Rsdy93bU13QTg3QVZWalg2akNrd09jZUl4SEpKczNI?=
 =?utf-8?B?bmRvVG42YXNQd0QrelI0VER2cHkxbE5wMjZINlhxMlFqcGlpRlVDS3NnUHNE?=
 =?utf-8?B?eGt6T2ZaOUFWcXRCZkhrU3lKd3M2MTA3SE5jZXhOYzJaYUl1aGNzSjdSUlB1?=
 =?utf-8?B?KytEK2dZU0ZQN1BvRW1hS0pvcFBhN0k4aEljekJJUnR6WWxycXlrUVM1ZXhk?=
 =?utf-8?B?eDZPdW5hbm03OENMWEEzL2V5dmJrV2V5OGlQdFdGWWJSYjgxZVRVOTlsbTVy?=
 =?utf-8?B?YklxR3RaM01GRGljUkNJckd3Z0tLR0Nuc1lMN1NYTStULy8zR2dRK2FLYmdt?=
 =?utf-8?B?U1A1ZEJ6K253RTJObmRjbGp6ek1uKzdXR0FZZVA2S24yYXNrb2ZCNFJYdGJh?=
 =?utf-8?B?YnVocUd4Q3Y4UHF1eklsMitORkkrZWVGZ2Z1ZCsxOXJSYzVPMy9XaklTeEh2?=
 =?utf-8?B?NVFkdy9TR3haRTZSTkZqa1dLSDB5RkQxRmdSZzNreE5xOHR5UVhWTHpOZ2wy?=
 =?utf-8?B?Uk5YZGI4YzdURGdlamw2VGUwU216cXh2YkpRQWtxM0xXd1hqSGx0d1FzOGJy?=
 =?utf-8?B?b1FCNVNkQ0VMaGNKMDBrWmw5ZG1wVmo0aWorWVdMZTlRbGVjTjFQTXh4Nmt0?=
 =?utf-8?B?RnNLVEswUkZTZHZuUjIzQno2MlVxUVhQdW9KTHpaOGlqdjBxYWpNYUFxZ3Fm?=
 =?utf-8?B?b1JkdWh1RUdDbS9lR1ZjRC9MMHE1NE9RQXVZSjFVcFRMRTJ6UEFHdVdSY0Vl?=
 =?utf-8?B?S3dRK1R0RjRYbnVtMWRmTXRqamp1SndRd3NIaHRzbU8zdlloQ2ViY1E2Y1NV?=
 =?utf-8?B?Z1VpMVBZM1RWWmllTWViVU9TYnVtOHBxaGNTUVlmeHhnZnk2aWtUNVMzWjBr?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <787DFEBCA08B6E4F99CB0283E0BF9810@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fikIphpHeB4FUymVBD/+fae6SY3VcEBK6Aauco7ERQdweHtbgA7GmCJeR3FrxkfvMJJ7DcOLQBlOxBROS6FNhhU4Lyn2/fChOW/a04U2JlBCprG6AKZVeQAl7plXeKPp5O2ckJhZJ66ztewGT7qC+7/suYE3rp2nnACoAwAGF6dIoHvkMkK7rNlCj8qa+DSRXdVeKONnU0hOAehn2PXwW1AVmM0l6yRzeJEiY7QgoLi7BeBz4RJzHgadQEhm4/vo7lAvq8t8CBC58Y4lw8cNGY3pgjSmSqFp6QzV9IZDMBCpfE75LldiQ97/TXG4xN08BhiiE/yT9YP8zMoR0gw0bjLHqR5TOD1K2ED3CQeKficGf3NeRS+uDBVwVHN9OjhthCNYNVmbo7RXmc+TWJj4y6upVJN99BX+NHRPnR5c4ijp/mymW4N3oSI/znaTJ+l70uogA4lmCtVYlIksdCBwN6c2QMU+l4kntEuF7+ITf9EM8kmdzqz18m3G9Qdrk7wTonMo+inkPsdLcMUjor9lhR5qg/TGEGSamry7ONDE2ZYjTbCpQdhzWZaNcPKMKvhg0CuFZPzWkl6tKa+uwN8flcR7hQMU2FrpdMQwCidMRKCAWyO+Aau2mrI/8YTgLB/1qh3id9yLUB4QNePrGETbyqyl5sb/YZFNZJBgV/9Tvvfk1Kj83ZS42lEzAfNaSmrzkoGoY3L3ZtrA1aKovPJycSKBf8ec+RpikSiATaYgYyO8iB5PtHhY8/ZIfkttwNmHWT1GnjVnYH0SoVZ6JVBpnJjmqfmJbSUhdcZfDFdtT60JLEtVkOUIMFgcoMDMQ0bnwdaRhyTTi0WVc7fSEkeyGp2yjG5Xs2XVuyF2/uFiEigPvcK1q9ilFZEKfoQ0Hcrnv/Fk7nx5AnckyF/wWV2ull1S051FpeBt7Kk8+/frJgg=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5befdc5-63de-4b6b-0ea4-08db2bf81252
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 23:41:06.1839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UHk8wei4RCahik88ViIUuDTRbHKhkY46nD5I5mGo4BykUexpFdvYxhBddLVLpF3HqbYulZGkBLBQqstUwsqmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
X-Proofpoint-GUID: adikHI8Uo7xktjIMeC4B3G4tZsm49iHI
X-Proofpoint-ORIG-GUID: adikHI8Uo7xktjIMeC4B3G4tZsm49iHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-23_13,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 adultscore=0 clxscore=1011 bulkscore=0 phishscore=0 mlxlogscore=428
 malwarescore=0 impostorscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303230171
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFRodSwgTWFyIDIzLCAyMDIzLCBNYXJjbyBGZWxzY2ggd3JvdGU6DQo+IFByaW50
aW5nIGFuIGVycm9yIG1lc3NhZ2UgZHVyaW5nIHVzYl9lcF9kZXF1ZXVlKCkgaXMgbW9yZSBjb25m
dXNpbmcgdGhhbg0KPiBoZWxwZnVsIHNpbmNlIHRoZSB1c2JfZXBfZGVxdWV1ZSgpIGNvdWxkIGJl
IGNhbGwgZHVyaW5nIHVuYmluZCgpIGp1c3QNCj4gaW4gY2FzZSB0aGF0IGV2ZXJ5dGhpbmcgaXMg
Y2FuY2VsZCBiZWZvcmUgdW5iaW5kaW5nIHRoZSBkcml2ZXIuIExvd2VyDQo+IHRoZSBkZXZfZXJy
KCkgbWVzc2FnZSB0byBkZXZfZGJnKCkgdG8ga2VlcCB0aGUgbWVzc2FnZSBmb3IgZGV2ZWxvcGVy
cy4NCj4gDQo+IEZpeGVzOiBmY2QyZGVmNjYzOTIgKCJ1c2I6IGR3YzM6IGdhZGdldDogUmVmYWN0
b3IgZHdjM19nYWRnZXRfZXBfZGVxdWV1ZSIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmNvIEZlbHNj
aCA8bS5mZWxzY2hAcGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDg5ZGNmYWMwMTIzNWYuLjY2OTlkYjI2
Y2M3YjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMjEwNiw3ICsyMTA2LDcgQEAgc3RhdGlj
IGludCBkd2MzX2dhZGdldF9lcF9kZXF1ZXVlKHN0cnVjdCB1c2JfZXAgKmVwLA0KPiAgCQl9DQo+
ICAJfQ0KPiAgDQo+IC0JZGV2X2Vycihkd2MtPmRldiwgInJlcXVlc3QgJXBLIHdhcyBub3QgcXVl
dWVkIHRvICVzXG4iLA0KPiArCWRldl9kYmcoZHdjLT5kZXYsICJyZXF1ZXN0ICVwSyB3YXMgbm90
IHF1ZXVlZCB0byAlc1xuIiwNCj4gIAkJcmVxdWVzdCwgZXAtPm5hbWUpOw0KPiAgCXJldCA9IC1F
SU5WQUw7DQo+ICBvdXQ6DQo+IC0tIA0KPiAyLjMwLjINCj4gDQoNCkhvdyB3ZXJlIHlvdSBhYmxl
IHRvIHJlcHJvZHVjZSB0aGlzIGVycm9yIG1lc3NhZ2U/DQoNCkR1cmluZyB1bmJpbmQoKSwgdGhl
IGZ1bmN0aW9uIGRyaXZlciB3b3VsZCB0eXBpY2FsbHkgY2FsbCB0bw0KdXNiX2VwX2Rpc2FibGUo
KS4gQmVmb3JlIHRoZSBjYWxsIHVzYl9lcF9kaXNhYmxlKCkgY29tcGxldGVzLCBhbGwgcXVldWVk
DQphbmQgaW5jb21wbGV0ZWQgcmVxdWVzdHMgYXJlIGV4cGVjdGVkIHRvIGJlIHJldHVybmVkIHdp
dGggLUVTSFVURE9XTi4NCkZvciB5b3UgdG8gc2VlIHRoaXMgZXJyb3IsIHRoaXMgbWVhbnMgdGhh
dCB0aGUgZnVuY3Rpb24gZHJpdmVyIGlzc3VlZA0KdXNiX2VwX2RlcXVldWUoKSB0byBhbiBhbHJl
YWR5IGRpc2FibGVkIGVuZHBvaW50LCBhbmQgdGhlIHJlcXVlc3Qgd2FzDQpwcm9iYWJseSBhbHJl
YWR5IGdpdmVuIGJhY2suDQoNCkV2ZW4gdGhvdWdoIHRoaXMgZXJyb3IgbWVzc2FnZSBpcyBub3Qg
Y3JpdGljYWwgYW5kIHNob3VsZG4ndCBhZmZlY3QgdGhlDQpkcml2ZXIncyBiZWhhdmlvciwgaXQn
cyBiZXR0ZXIgdG8gZml4IHRoZSBmdW5jdGlvbiBkcml2ZXIgdG8gaGFuZGxlIHRoaXMNCnJhY2Uu
DQoNClRoYW5rcywNClRoaW5o
