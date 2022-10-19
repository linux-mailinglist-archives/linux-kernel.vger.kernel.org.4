Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951A4603AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJSHyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJSHyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:54:49 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED551CFE6;
        Wed, 19 Oct 2022 00:54:47 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29J7JqCD023937;
        Wed, 19 Oct 2022 03:54:31 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3k7pq7dbxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 03:54:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfZOaS2w5K/UBsQFPDuisp2lz2iV9yP80AXX1nfVjDqPi00OO6jcph2rUQ+6/07Yb9OPab3a3hAjHG0hOvfM+u+X4ZTOzI2+GCnbBJv3D42xX+wPHSR80iEvglrTPZgrLkPImGkUiW1gj4/V3EIlC1xImaOJsmmn/Wmhq5an+A5pCYTvMDDGgg6Fem3Boow207chJ2oKQ9YPIcQPxbPDugB24To4HTqanUhKd5Gha580L8j7m/4lZ/MTGrkQYPHzqKfWmk0CJVtU0z4ByNCGKTcAAH1zZJ/kGujMdUtyUtbjipvbPrzJLSSehF8VDSwFLb/iELDHwXT5tO9t/A3Sbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLycn63TKJ+8zJd6vmA04+fuycEJbdkQfAQO8dK7XtQ=;
 b=AaMsHtj6hAoBeHxGLUzS6E/RPlELbyVjGYc/TKtGYGRqz5VLHuTw9ySaOfc9A9czMGOaVlGjR92Tyalw6wN0LU2re6zXweE6xeTsajw5fsyI1Leu9Gp+6UWKhsFjexckZy5LewhCqS4tsojKsySe1mqicgwkgNxj6/YcYsHixX+fd00aBTQz2Fyf3jM8r/5Obg5maGkJxUx15cjWLoQaeLuylkoHk/zkjwUepuwnXrCR6Ltddnc2nlkkPxIfxX1lhqUL6FW9wvMWbirmuoMjg0MyNCHsnARMBCJWLLrgNhxXL051nlIRKOTP3+iGYxqz3GtRNtwONpnYKgsSxrqrUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLycn63TKJ+8zJd6vmA04+fuycEJbdkQfAQO8dK7XtQ=;
 b=VPxKPAGoaqD3PBNTY4Fv6lH0KwIaAzqnTgnCofvCWguMaM4BXLJu4T5Lnybjkwk374KsTl60ISgDhLLJnECTunIHAVng3PpuhHUWQPGd4uU3UH6HcGOdJkcFiwi2BD+iPrtt0Cp5PG2KT+1nELjGNs9Y0c0tSDMUk4iRx6nFPr8=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by BLAPR03MB5585.namprd03.prod.outlook.com (2603:10b6:208:29a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 07:54:28 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9%7]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 07:54:28 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Stephen Warren <swarren@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: RE: [PATCH v3] dt-binding: gpio: publish binding IDs under dual
 license
Thread-Topic: [PATCH v3] dt-binding: gpio: publish binding IDs under dual
 license
Thread-Index: AQHYwTfOGacnviyOEUy3ywl2eomdQq4VjQ2w
Date:   Wed, 19 Oct 2022 07:54:28 +0000
Message-ID: <SJ0PR03MB67782BA91E0350C472F29464992B9@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20220905145555.674800-1-etienne.carriere@linaro.org>
In-Reply-To: <20220905145555.674800-1-etienne.carriere@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5EQXhNMlJtWkRBdE5HWTRNeTB4TVdWa0xXSTJZamN0WW1ObU1UY3hZelEx?=
 =?utf-8?B?T0RneVhHRnRaUzEwWlhOMFhEUXdNVE5rWm1ReExUUm1PRE10TVRGbFpDMWlO?=
 =?utf-8?B?bUkzTFdKalpqRTNNV00wTlRnNE1tSnZaSGt1ZEhoMElpQnplajBpTVRnMU55?=
 =?utf-8?B?SWdkRDBpTVRNek1UQTJNemsyTmpZME1UZ3dNRE16SWlCb1BTSjViMHRETWpj?=
 =?utf-8?B?eVl6Slphemd6Y21ORlExcEJhMHd5T0dSTVNtTTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVSkNURmxCUTJ0UFVGbEJWbVJQUWtSU05XdDFOa1JXTURSRlRr?=
 =?utf-8?B?aHRVemR2VFVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVmcxYkRKTGQwRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|BLAPR03MB5585:EE_
x-ms-office365-filtering-correlation-id: 246da30f-ddc5-40d4-a9e2-08dab1a72641
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5TiN1YwdkTtpapzhohqS4U86Gl9qNyHH6f5G1xHyQ56p3nv8GtV3kIz6Q7sTjEtLw+A2UlE18zPFfmQngWmEwhPLOSb/6Jw2+Vvcu5ljPegd9f2YKfLfODe0HzDYx+SA4z4VgqdhFnztDYUY87sowueiPKMnzxjPUcUHNjPoqbQcbOS0JhUaBtNMPZ7ioMTBojnir1JMF9EKyofCob9Y4WlMdjf/PBgs8hEpE3c+/i9qqzkLH577n8CwfObmKg8IX4S/vPvxmlchrQIgEwWvVrWVJAfZoqLnvC9b2YMSCU9K4XteSmikLV9xObX9zMduX3yinYm0zctIIofBhfJBFvUDUxD0LSY1cwtIy5CcVv8FQIgRc4L2epvdFBpKwaLflggVfX04Y05uj0HaZPiYvUCs+WB6K7bCitJW4dAlH/2NpkAEFgxVnWS3iFBzjeqdZ/L0NF5/ibIRU1L1zAMy4WTKOy2EuPcc+a4e4f0AL3HC5U4nrx1BolwwuGV450wza5yF8aBBkoay6ruLaZEO8+DSQiKAq3SHxIRGh91GA616muAUNF3TJ9PEtFa0Y5rm8HjFpH/VpmxYlyNoIcAMuKcOVK0WZAgykZhEGuLeTwJhXbNLlSARdMLl9cU3L2TZJ/5XhhTjinpRGIbctPilF9znnePhjZ0rw+f7Ps0HD/P/V9nkkNxVsfnjmgWc8BJIdfd5Uv0zcYvm6cTDt0MgLBo2YT8yUU6vlIvBztaF6bAIJz11pquavKka2l9CiUS4NuPAgp9ObI+hOr5Ozn3fA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(110136005)(38070700005)(86362001)(33656002)(26005)(41300700001)(64756008)(4326008)(53546011)(8676002)(7696005)(6506007)(66446008)(76116006)(316002)(52536014)(7416002)(55016003)(9686003)(5660300002)(8936002)(71200400001)(66476007)(478600001)(54906003)(66946007)(38100700002)(122000001)(66556008)(186003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUFhZnFGWEI1WUlMdXY5YnpsSG5sSEFGcTdVanM5WXlsMDd1NEVuWkVmdFdQ?=
 =?utf-8?B?eXViclFya2VzeVZ6Rit5YmduK0RBSDNKN09GS3hrZUI2cyswSzhwbHhnMVlQ?=
 =?utf-8?B?YW9UZ20rdEV3dmV2OTlNWGRERDNueEY5TFVzZ3BCMWZQbXhJenJHbEdhb3ls?=
 =?utf-8?B?MkRBamZqQVJyUjR3VkllcUJQVXhoMGdENmVMNkIvcXBVSUtobHVib3R3V1NB?=
 =?utf-8?B?ZlZPK2d2MEdqQWJEUGpsUm8vOHl1UUc1QlNUM1Z6VHd0Zks4c2FZVWZiSHd3?=
 =?utf-8?B?Q2QvRjVQL2V6VFR3Ym9wOENxZXAySUkxUFZzbldCNGd4dGVWNmFPRitrdGxE?=
 =?utf-8?B?aXB6cE9URVFpUDJ3SjVlVHJIbWdKcDgzcEVYWUdzMUQyazVaRTVWZGRSQmdk?=
 =?utf-8?B?L2xoMVcrVW8rQndwVWtEZitTdlZPRk1LdXVpMXduZzRCSnZOVEM1aURNWGM5?=
 =?utf-8?B?Y3dCdXJiN2k2MjN5Zm0wNmU2SktFUG1oT2tkWEIwVUl0V3JjZWQrc1d0L0th?=
 =?utf-8?B?clFjODBnMjk3VVIzMTc3aVBFaWs2RzhRVjVWRjdqb25ReWJIdnRzak1jOE81?=
 =?utf-8?B?TjdZNlRoMXY2UDdGQmtRTGRKTS9LQnJiZUdlbk1Va1lkWVBobU5XSXNMbzRB?=
 =?utf-8?B?RWRuc294RmZNbUxMQXdwcG1jdmduVk1LVGxiNE5aMHJtSVljOUdmdmV1aEdD?=
 =?utf-8?B?RDNVR0xuNnVuakN1Znl0bGVtN0xmTUE3eWM1OE9HTjNtWVFxREpQYVI3RHh1?=
 =?utf-8?B?c0MyUVVtMTF2czlGMERpRHF6MjJpc0RBbWVjTEYvVnJIMmlQSTlmOFAxWC9V?=
 =?utf-8?B?ODNwWnhIWE1HNENkQXVteFJRNHE5L3Brdk1NTmlwdDM3anMrZ3RnZ0lucCtI?=
 =?utf-8?B?TWptczhYR0ljR2d4MStRbHk0M3plK212bzNyZnVFS3Z0dTBDMnZoWkwrWVY0?=
 =?utf-8?B?YjYvemhLeWhkSlRPeFpFRHFFWStKbDdDZmJhZy9vcEdkWGZiaVZmcHNZWkkz?=
 =?utf-8?B?RThlMTRUdWwvaDB1L0pvM1hvQmJPTE0rZmZ4T1ZJeDkzVmx6ZDYxZ1VxZDM2?=
 =?utf-8?B?VWhlNEhmakdMWlVsN1dkUzlmWTBjdEQ3b2hjL25mWXVHVXdZWXU5dmQrWmVB?=
 =?utf-8?B?b2Ftc2dxNEhtUHBwQ004Y29xaDFpTGNCWERFSUdrQzBLUk5TOTg5MlF1TnFR?=
 =?utf-8?B?MW9NMkM3ZnA2a20vZ2U3M3pOVCtobnBoakM5a0pqMFE5eWZUc1VxMEh5WTlC?=
 =?utf-8?B?T050eFVFTVAzSlA4V0VDREZrQnRVU0NodGZQblBidE5rcU1kUjQwYkJlbUgr?=
 =?utf-8?B?VEVWM3hxbmU0bFpCQ0sxWGNHdlhZYlNsZkxRV1IzK3EyQmRpUTEzSXFLdENJ?=
 =?utf-8?B?UUZuRWFVRjEzUGFIRDMxNG9jNWswaWhrQUpoRitsTklLc2VzSDFsNFBJMklM?=
 =?utf-8?B?MTM1UjAzZ0pRZndFVmYxTnU1NkFpNTk3Y1J4Ym1kL2hiWm93cUxZdUxjVnZ5?=
 =?utf-8?B?ellFdXJVMUN3RjNSc2RWdnpTUHFBNG9KMnF4dDkzU2ZlSlo5d1c3Z1hXbkt0?=
 =?utf-8?B?N0RvRmpVZ3FieG9oYmpVRFM2anA5S080dUY3SzJwOVdMT1UvemEwc0dBOFp1?=
 =?utf-8?B?czRocTUwWENnMm1kd3dLeXUvaVUwU3lwc2NmSTltSHQwY3phM2puaUtkRGxw?=
 =?utf-8?B?a3hvd0xTMDFtQmJ2SjBiWFRrMUo1d0QzNEIyZXUva043UlN2YzlFdTA0Wm13?=
 =?utf-8?B?MEVrQ3hvWlMxS1NZQUFqSldYNjBIV1dwVmZKRzRDRFRxWlNuR1Y3WGpEZThR?=
 =?utf-8?B?T0NST1p5UzhQeTRXSTJiWFBaYTVWT1FIeTI5UEV0a0dqRkVaNmNRZzRubU5n?=
 =?utf-8?B?MnEzTjZRdmZCaGFQWlU3cWliQlM1RmtFVElCaW1yU0NKZFdMdVdQUUQ3U212?=
 =?utf-8?B?b2VUQkUza2tkRVl6V2NxbHBSWWZlZ0I5VnRwZTc4SlNsT0R5MFVEL1dGNVA3?=
 =?utf-8?B?NGNHK2pRRWFBOWVYdEZ5ZlVhbi9UZnNWYytWSGNOUzJKWjVkQkxaMTRnSTU1?=
 =?utf-8?B?MjByYkJxL1ZmL1M0cjkzWXlSREtKSVlxY2NyVXJrc0VxclNqVWp1dnpGVHhV?=
 =?utf-8?Q?Zg8LWe9TBNYddNO693AeWKKbC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246da30f-ddc5-40d4-a9e2-08dab1a72641
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 07:54:28.5682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Im9n9tBD4nKMv6F7aJfLN4kV3ExTIM/6IMNHVrKQxu+XlHCRMi3Lt1dO2VD75fgIG1JAazfbTkF+ugz9SgeGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5585
X-Proofpoint-ORIG-GUID: eiI-bMgtEECXdl4GPsyKv2XCIDuy9Rkb
X-Proofpoint-GUID: eiI-bMgtEECXdl4GPsyKv2XCIDuy9Rkb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_04,2022-10-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 clxscore=1011 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190044
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBFdGllbm5lIENhcnJpZXJlIDxldGllbm5lLmNhcnJpZXJlQGxpbmFyby5vcmc+DQo+
IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDUsIDIwMjIgNDo1NiBQTQ0KPiBUbzogbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWdwaW9Admdlci5rZXJuZWwub3JnOyBFdGllbm5lDQo+IENhcnJpZXJlIDxldGllbm5lLmNh
cnJpZXJlQGxpbmFyby5vcmc+OyBTdGVwaGVuIFdhcnJlbg0KPiA8c3dhcnJlbkBudmlkaWEuY29t
PjsgTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPjsgTGF4bWFuDQo+IERl
d2FuZ2FuIDxsZGV3YW5nYW5AbnZpZGlhLmNvbT47IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAYWou
aWQuYXU+Ow0KPiBUaG9tYXMgUGV0YXp6b25pIDx0aG9tYXMucGV0YXp6b25pQGJvb3RsaW4uY29t
PjsgU2EsIE51bm8NCj4gPE51bm8uU2FAYW5hbG9nLmNvbT47IEJhcnRvc3ogR29sYXN6ZXdza2kg
PGJyZ2xAYmdkZXYucGw+OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6
eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPg0K
PiBTdWJqZWN0OiBbUEFUQ0ggdjNdIGR0LWJpbmRpbmc6IGdwaW86IHB1Ymxpc2ggYmluZGluZyBJ
RHMgdW5kZXIgZHVhbCBsaWNlbnNlDQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0KPiBDaGFuZ2VzIGdw
aW8uaCBEVCBiaW5kaW5nIGhlYWRlciBmaWxlIHRvIGJlIHB1Ymxpc2hlZCB1bmRlciBHUEx2MiBv
cg0KPiBCU0QtMi1DbGF1c2UgbGljZW5zZSB0ZXJtcy4gVGhpcyBjaGFuZ2UgYWxsb3dzIHRoaXMg
R1BJTyBnZW5lcmljDQo+IGJpbmRpbmdzIGhlYWRlciBmaWxlIHRvIGJlIHVzZWQgaW4gc29mdHdh
cmUgY29tcG9uZW50cyBhcyBib290bG9hZGVycw0KPiBhbmQgT1NlcyB0aGF0IGFyZSBub3QgcHVi
bGlzaGVkIHVuZGVyIEdQTHYyIHRlcm1zLg0KPiANCj4gQWxsIGNvbnRyaWJ1dG9ycyB0byBncGlv
LmggZmlsZSBpbiBjb3B5Lg0KPiANCj4gQ2M6IFN0ZXBoZW4gV2FycmVuIDxzd2FycmVuQG52aWRp
YS5jb20+DQo+IENjOiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+
IENjOiBMYXhtYW4gRGV3YW5nYW4gPGxkZXdhbmdhbkBudmlkaWEuY29tPg0KPiBDYzogQW5kcmV3
IEplZmZlcnkgPGFuZHJld0Bhai5pZC5hdT4NCj4gQ2M6IFRob21hcyBQZXRhenpvbmkgPHRob21h
cy5wZXRhenpvbmlAYm9vdGxpbi5jb20+DQo+IENjOiBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cu
Y29tPg0KPiBDYzogQmFydG9zeiBHb2xhc3pld3NraSA8YnJnbEBiZ2Rldi5wbD4NCj4gQ2M6IFJv
YiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+DQo+IENjOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+DQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBFdGllbm5lIENhcnJpZXJlIDxldGllbm5lLmNhcnJpZXJlQGxpbmFyby5vcmc+DQo+IC0tLQ0K
PiBDaGFuZ2VzIHNpbmNlIHYyOg0KPiAtIEZpeCBjb21taXQgbG9nLg0KPiANCj4gQ2hhbmdlcyBz
aW5jZSB2MToNCj4gLSBQdWJsaXNoIHVuZGVyIEJTRC0yLUNsYXVzZSBpbnN0ZWFkIG9mIEJTRC0z
LUNsYXVzZS4NCj4gLSBSZW1vdmUgQ2hhcmxlcyBLZWVwYXggZnJvbSBDQyBsaXN0Lg0KPiANCj4g
LS0tDQoNCkFja2VkLWJ5OiBOdW5vIFPDoSA8bnVuby5zYUBhbmFsb2cuY29tPg0K
