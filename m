Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F39E7331A9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344334AbjFPMzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjFPMzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:55:04 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78F6358E;
        Fri, 16 Jun 2023 05:55:02 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35G74a2Y009137;
        Fri, 16 Jun 2023 06:39:27 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3r7v8xgegd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 06:39:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=No2Lq1cD2+9M79rWZvltgpYk2VR4Z1io7lnLiXNDdVsOqT8QA/YnwAN/pYWt0qlj40e12HGwLvx5N4iWfLZhzrL1V6nES6umsfFz8bUmKl7ycufmd2/q5kfpLJ1fQ3M876RfNRhZspIZ9TBi7Oz9kYlHC0Ma7duANJiVG9OLP47rw0F9Ocm8Em8d5MX7YddKFa5ClGOiCz0Kb9s+RSe+Jv/nRdwm2CvM7iyHuJYFtnuHyMVk+L3KDJOt+JTuOlOdoZCrRqt9IMDP11NfOVl8/cild+vxOBGXdpDxH8k4nzfUu228gKsupfHynjGkb8Qhk+2AUwgeEI4+19a3Ey96sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2dlbrezlfaXJ8TF3so6Wz/RnFb7R6h9OWqsfUR1mC4=;
 b=DyVkr9sCiDF3q/8g6Se2FrPWRGYDd+wDofV6SApJNmd2v4lGgLVMhbQzVOa1w2RhkrB8rHsWZNFogMXY/1xxScacZ5WKSfU6qDXKEKe3M88V2HcZcWr32W46ZxRicrW1l8YElyN5KCcfRBIlh12rM3ynulKVQNSaAQFhWuo/cuSoeJlh9UOU8F6Z/ju3fq8Wkukbrw9EyF0u+hptVpaToUKviEvkZEGQfgX3y91s2ufsu5W/7lU4U5ZVgfTEbxoPFOMwRVZuPit5a9BX/5BHCVPt7X76a3qP1mkrdvLpZPzdKk2vnqfSEJbBLqh2ZpFdFu96jwSJZikM/QKerDb/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2dlbrezlfaXJ8TF3so6Wz/RnFb7R6h9OWqsfUR1mC4=;
 b=0eN6yyiF2ehkDMyj5Sm4inQuByatCYqkce8v5dYrf7l2Fqj+yq9DU4pFtpYEzhIm04HqbNYiLGSQiPP+R1KoaZ8Y2pPLjTZuFAxGLsPX1z94MEEOyqkicf8fAl2TGwiLzMYtuqLaA3TbWDwID7ovZ5l06usvlH/Y9pW5OSl0bQk=
Received: from PH0PR03MB6654.namprd03.prod.outlook.com (2603:10b6:510:b5::8)
 by PH0PR03MB6494.namprd03.prod.outlook.com (2603:10b6:510:bb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 10:39:24 +0000
Received: from PH0PR03MB6654.namprd03.prod.outlook.com
 ([fe80::9650:7d39:6078:b7ec]) by PH0PR03MB6654.namprd03.prod.outlook.com
 ([fe80::9650:7d39:6078:b7ec%7]) with mapi id 15.20.6500.026; Fri, 16 Jun 2023
 10:39:24 +0000
From:   "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v3 3/7] power: supply: max77658: Add ADI MAX77654/58/59
 Charger Support
Thread-Topic: [PATCH v3 3/7] power: supply: max77658: Add ADI MAX77654/58/59
 Charger Support
Thread-Index: AQHZga9p9UZXJVYqfEWpFH/7jjNtOq9Q0kEAgDx/a3A=
Date:   Fri, 16 Jun 2023 10:39:24 +0000
Message-ID: <PH0PR03MB66542D94637F1B2C153D2ECB8B58A@PH0PR03MB6654.namprd03.prod.outlook.com>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
 <20230508131045.9399-4-Zeynep.Arslanbenzer@analog.com>
 <f0915bf5-992e-c6eb-e9f5-21980aa3cec0@linaro.org>
In-Reply-To: <f0915bf5-992e-c6eb-e9f5-21980aa3cec0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jZW1WNWJtVndMbUZ5YzJ4aGJtSmxibnBsY2x4aGNIQmtZWFJoWEhKdllX?=
 =?utf-8?B?MXBibWRjTURsa09EUTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdK?=
 =?utf-8?B?aE1qbGxNelZpWEcxelozTmNiWE5uTFRCalkyRXhPV05pTFRCak16SXRNVEZs?=
 =?utf-8?B?WlMxaVpqYzJMVEEwTjJKallqVmhZekU1WTF4aGJXVXRkR1Z6ZEZ3d1kyTmhN?=
 =?utf-8?B?VGxqWkMwd1l6TXlMVEV4WldVdFltWTNOaTB3TkRkaVkySTFZV014T1dOaWIy?=
 =?utf-8?B?UjVMblI0ZENJZ2MzbzlJalUxTlRJaUlIUTlJakV6TXpNeE16ZzFOVFl3T0RB?=
 =?utf-8?B?ek1qQTJOQ0lnYUQwaVptMU1VRVZoZVhGbFNucGlXVXhsWjJGUlZuZG5LMUI1?=
 =?utf-8?B?WTFOblBTSWdhV1E5SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJR?=
 =?utf-8?B?VUZGVWtoVk1WSlRVbFZHVGtOblZVRkJSVzlEUVVGQ1FXbDVabEJRY1VSYVFW?=
 =?utf-8?B?cHBVR3BOZFdjMlZXbEJiVWtyVFhrMlJIQlRTVUZFUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVWhCUVVGQlJHRkJVVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVVkJRVkZCUWtGQlFVRlNObXhVVEVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZLTkVGQlFVSm9RVWRSUVdGUlFtWkJTRTFCV2xGQ2Fr?=
 =?utf-8?B?RklWVUZqWjBKc1FVWTRRV05CUW5sQlJ6aEJZV2RDYkVGSFRVRmtRVUo2UVVZ?=
 =?utf-8?B?NFFWcG5RbWhCUjNkQlkzZENiRUZHT0VGYVowSjJRVWhOUVdGUlFqQkJSMnRC?=
 =?utf-8?B?WkdkQ2JFRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQmJtZEJRVUZIUlVGYVFVSndRVVk0?=
 =?utf-8?B?UVdOM1FteEJSMDFCWkZGQ2VVRkhWVUZZZDBKM1FVaEpRV0ozUW5GQlIxVkJX?=
 =?utf-8?B?WGRDTUVGSVRVRllkMEl3UVVkclFWcFJRbmxCUkVWQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVGQldW?=
 =?utf-8?B?RkNhMEZIYTBGWWQwSjZRVWRWUVZsM1FqRkJTRWxCV2xGQ1prRklRVUZqWjBK?=
 =?utf-8?B?MlFVZHZRVnBSUW1wQlNGRkJZM2RDWmtGSVVVRmhVVUpzUVVoSlFVMW5RVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJRVUZC?=
 =?utf-8?Q?QUE9PSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6654:EE_|PH0PR03MB6494:EE_
x-ms-office365-filtering-correlation-id: 2c1ab3cf-40e3-4027-2197-08db6e55f3a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GiSNUQvU7bz50d9Wlm6MnP82ff7OhhBOmLhY4hD2WSVaRZzlu95RBssmq/lO84OWSsqrtJf4e9Jh8jhCwVUjMzb9p141W90/+F41YWPgpe/rLIAu6vRFP5Fo21IT7C26XhbbVoQUP8G+sR4PU195eZvzeOM3e5aK50o5u2OkCQnkBhkIYPuGmptXDgsBVqnjD4XBfx2diApWibPRswVpl57huDV5pPuzqNmMxSIfqELtB9aCFGeBD9kb+lKjooJrXS/EV/vORfpQX4nL9sqyyzC1OszMs+eXhhF6/7aySGw+k27YsRTnW3Ukavgzyro1aIKVFWe9M0bHzSlKbJY0V7DmOP8AFPO5ht7+MJCrOj7pJo3PrW5xQWce1+LWWtnB9gHlXvT7Amuevk6yESyr6M6XTpDgbctELaqHYmNhK0ZYTr78KqkajG3snscxV0xNo0/s3C13yhuRWm3KEBZ8EA1RUcYx9KvIlmv9KobhINgrDz286OVtZJOVskWhed4T8kfKnEHQcxyrc0yVwh2QkHZlb1nz/YUGSdPwyj0sKrLqAs1Q+rY5t/VqSt2+MW6acpEKIAy+2u9pjm+idRfpkDmFsMBFeh2BHE9CJ75ltTtOZrGIo+EjDMzpPFdz0Uqt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6654.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199021)(38070700005)(33656002)(86362001)(54906003)(110136005)(66556008)(64756008)(66446008)(66476007)(316002)(4326008)(76116006)(66946007)(71200400001)(478600001)(7696005)(55016003)(52536014)(41300700001)(8676002)(8936002)(5660300002)(2906002)(7416002)(122000001)(38100700002)(9686003)(26005)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTNZTjgwY3BINGlBc3pLNDVOUEN6WE42UG1tdmx0aDdEeU5BVXI2eUViVVpW?=
 =?utf-8?B?cVNKZ21XM0dnK0pIZEtoTWpRcU1tN1ozZTBqbHp5SEFXUXQrU3NtUFh0S21X?=
 =?utf-8?B?T2xoYmNINEZtVU5WaUw1OURBQmZoRTQ0Q2dlS2VhQndQeEMwTDVRRGFxZzk4?=
 =?utf-8?B?ME5Zd1F3R3FzWVBhNmR3REpIOHJkRldXNzZxaUVQc2trT0N6eCtSMTNmZVBL?=
 =?utf-8?B?UU81KzFVY2lZK29yYTkweXRmcExOUmtxYjVCVTM1YlhpSVZlR0tKQllEZ3JP?=
 =?utf-8?B?a3REMjhaUGZMT21JRmZoWkFJZGJrRFA0OUZZVlowK3llRFZ1eFNhUXl0RXZt?=
 =?utf-8?B?QWJCWDVOdkhJbURxanR2VFFvdlpZVEgxSFdEQ3V6ci8xN210dzJvM1EvcEtJ?=
 =?utf-8?B?dTFFL3NrYUNnVmxISEpTM3I4anRqQTJJY2tlNGtTVzJJdTdvaTArb0ZLN3ZV?=
 =?utf-8?B?TmF5aTYrbVNidWNGQVdmQVZmRkp5c09wMzRZQ3hwOEgwSjdOVTVKc25hTDZU?=
 =?utf-8?B?UEp3ZUtoUHpscWU3QmpRbWlmM1lvRSswQmtNTHRGSmxRV1V3R29uaW9mY3lR?=
 =?utf-8?B?NjRrU3BOYUpUbDYzcjFwTmJ6SWU0RTQ5VTFkSjVuRXFCQjEyUzF6NGdJVmxF?=
 =?utf-8?B?aFM3dU5pVEl2QmRKWlE2dnpZSTMrWWRDak9YT1J1RDJMQXJ6dHMwU2RadFpx?=
 =?utf-8?B?QWtCVXFiQ1ZISmg3WmRrUUd1em1INExNL3d4NytRRHdleGRqdkcvaDJUTmhV?=
 =?utf-8?B?NWFkZTMwVmtWUTlEdWpWSk41dlhHU3VhMzNlZlljd04ydFgvaU5LRDhNRGl5?=
 =?utf-8?B?T284NkxIaHhSNEZqYVhxV0YzSWhpRTNmRVBybVZjMlludDFubW00YzRFT0Uv?=
 =?utf-8?B?WGlVNFNiUVZtZ1g4VDFrOG1WRE9Ua0hxc2lkcnh1bVgxTW4yaElhZ29mRkpS?=
 =?utf-8?B?cHZqWkE2WURNZVkrVmM1NG1CQmRDYVdGL1hGdDByUGVzRWdZNnZkcXZ6c2Vv?=
 =?utf-8?B?VExtYkVrbjJNcDdrRUtjYTBJVksrYUlpVE41ZnA1SkdrNzBISXg5TVJpbE5u?=
 =?utf-8?B?c3ZXQUxldWM1ZUFRa2xLeVBWaUk2OXpTNE5FMEJtMlBqanl6UStiS2pMamE4?=
 =?utf-8?B?bXNoZUNFaXFWb2NyUXRhY0xEcG5DTTBxcmg1aWd6NGJtSXc3bUl2dzFsTlpk?=
 =?utf-8?B?bEpnMVY1SzZ4SFpNQTFoOFNXak1HOFpRSitwTFNkQ2NLckN1WkZGc2FlVUls?=
 =?utf-8?B?NHpkalRzbUlVcTJhQ3huT0FGWjVRUXp0NkxEcWNFcmtjRDlmcUVxQkN2cUJr?=
 =?utf-8?B?SDZTZVlSSThyZWhJRktZTHlpTnNyZ3dXUUZRNXE0cU1qd0lVYmVMZWc4WjFi?=
 =?utf-8?B?Y2RhdWhZa2RscnIvcllCeFVFNzFqaGJqRktZb2VOUWZPbUIxd2todjNTcWhH?=
 =?utf-8?B?UmtLblcwc3dJcWdRSEE0WnliQnlYWTgyalJZbjBDakRmNFBNR1Zvc2ljd0E0?=
 =?utf-8?B?bjMrVHBGaGhXNkJibHkxZ3Y3VUMyU0xkejVXYmc0ZzhsRk9oYTVsQTkzTjNm?=
 =?utf-8?B?VkJHQi9ST1laUHZveXNBSTZrSGY0dnFJNGxpY0ZSRTIwSTlHaWlkaUlQb3pS?=
 =?utf-8?B?Vktld08wSG9aTlFocGMzbEpnNXVZZFFVc1pXdE5xR2RRWFBQUHoxdHdLS2lN?=
 =?utf-8?B?Q3NjRkpQYWhtTmZYaUQySUxkTkF6R2lUUldzbGNyR0RERkdWeVE4Qk1HdkE1?=
 =?utf-8?B?K2NEck1vajAyamdTZlJnbFUxRVN0eHlRdUk0dk12alUxQW5VNE1UbUlrSHJU?=
 =?utf-8?B?a29jTjE2TGtWN1JEak1kTlpTQ0lnaHVuTUJCTnozYWRibFQvWFk4QTVzWTl5?=
 =?utf-8?B?NitUSnFvQml1dEEyamEvaC9PUzhiVzRtcFBXclhjQ1hFMkVTSXZNTjl1YnFK?=
 =?utf-8?B?dmhyd2RaM2ZCN3hKeHZPUWx5NUExNmRRQmw4R2diRkdUUUdieWlBbFdiR21z?=
 =?utf-8?B?V2w4bUtnb3JjMFlQYkQvVEhwMXJCVFhWNUZiWHNpN2lSbjdNSjdLMDloazRE?=
 =?utf-8?B?SjIwejZGTFM3UkV3eXJ4dUd5TTdmNjBqd2U1SjdWckdBOWdkOXhQWitlNGI3?=
 =?utf-8?B?R1BVcGVvR0pGRlllU0hyMXdsN2Z4UjZ0K2JvWllxWXV0cnczcnBoQzliTjln?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6654.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1ab3cf-40e3-4027-2197-08db6e55f3a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 10:39:24.1793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9oMYA5Sl88S9ewmvWkQYfAGwN3puG7bkdNa1WOYSJmdEj6nVDs0qJt8X8CXF66H9kGohxr9s1i3xWjkBYe1WXG6EAjbPrBgT173lntWZc9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6494
X-Proofpoint-GUID: xd9dal4jvUY39BjZy1lwhB75DKqH6Ejw
X-Proofpoint-ORIG-GUID: xd9dal4jvUY39BjZy1lwhB75DKqH6Ejw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_07,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160095
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCA4IE1heSAyMDIzICwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj5PbiAwOC8w
NS8yMDIzIDE1OjEwLCBaZXluZXAgQXJzbGFuYmVuemVyIHdyb3RlOg0KPj4gQ2hhcmdlciBkcml2
ZXIgZm9yIEFESSBNQVg3NzY1NC81OC81OS4NCj4+IA0KPj4gVGhlIE1BWDc3NjU0LzU4LzU5IGNo
YXJnZXIgaXMgU21hcnQgUG93ZXIgU2VsZWN0b3IgTGkrL0xpLVBvbHkgQ2hhcmdlci4NCj4+IA0K
Pj4gU2lnbmVkLW9mZi1ieTogTnVyZXR0aW4gQm9sdWN1IDxOdXJldHRpbi5Cb2x1Y3VAYW5hbG9n
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpleW5lcCBBcnNsYW5iZW56ZXIgPFpleW5lcC5BcnNs
YW5iZW56ZXJAYW5hbG9nLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvcG93ZXIvc3VwcGx5L0tj
b25maWcgICAgICAgICAgICB8ICAgNyArDQo+PiAgZHJpdmVycy9wb3dlci9zdXBwbHkvTWFrZWZp
bGUgICAgICAgICAgIHwgICAxICsNCj4+ICBkcml2ZXJzL3Bvd2VyL3N1cHBseS9tYXg3NzY1OC1j
aGFyZ2VyLmMgfCA4NDQgDQo+PiArKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAzIGZpbGVz
IGNoYW5nZWQsIDg1MiBpbnNlcnRpb25zKCspDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvcG93ZXIvc3VwcGx5L21heDc3NjU4LWNoYXJnZXIuYw0KPj4gDQo+DQo+QWN0dWFsbHksIHdp
dGggc21hbGwgZGlmZmVyZW5jZXMgKHJlZ2lzdGVyIG1hcCBkaWZmZXJzIGJ5IGZldyBvZmZzZXRz
KSB0aGlzIGlzIG1heDc3NjUwIGNoYXJnZXIuIFNldmVyYWwgZmllbGRzIGFyZSBleGFjdGx5IHRo
ZSBzYW1lLg0KPg0KPlBsZWFzZSBtZXJnZSBpdCB3aXRoIGV4aXN0aW5nIGRyaXZlcnMuDQo+DQo+
QmVzdCByZWdhcmRzLA0KPktyenlzenRvZg0KDQpTaW5jZSBtYXg3NzY1MCBpcyBzaW1pbGFyIHRv
IGRldmljZXMgc3VwcG9ydGVkIGJ5IHRoaXMgcGF0Y2ggc2V0LA0KSSBndWVzcyBJIHNob3VsZCBt
ZXJnZSB0aGUgcmVndWxhdG9yIGFuZCBtZmQgZHJpdmVycyB0b28gd2l0aCB0aGUgZXhpc3Rpbmcg
bWF4Nzc2NTAgZHJpdmVycy4NCg0KQXMgSSBvYnNlcnZlZCBmcm9tIG90aGVyIGRldmljZSBkcml2
ZXJzLCBhZGRpbmcgYSBuZXcgZGV2aWNlIGRyaXZlciBzdXBwb3J0IHRvIGFuIGV4aXN0aW5nIGRy
aXZlciANCnNob3VsZCBub3QgY2hhbmdlIHRoZSBleGlzdGluZyBkcml2ZXIgY29kZSB0b28gbXVj
aC4gQnV0IGFzIEkgd2FudCB0byBhZGQgc3VwcG9ydCBmb3IgNCBleHRyYSBkZXZpY2VzIHRvIG1h
eDc3NjUwIGRyaXZlcnMsDQpJdCBjYW4gY2F1c2UgY2hhbmdlcyB0byB0aGUgYWxyZWFkeSBleGlz
dGluZyBkcml2ZXIgY29kZS4gSSBqdXN0IHdhbnQgdG8gYmUgc3VyZSBiZWZvcmUgc2VuZGluZyBh
IG5ldyBwYXRjaCwgc29ycnkgZm9yIHRoZSBsb25nIGV4cGxhbmF0aW9uLg0KDQpXb3VsZCBpdCBi
ZSBva2F5IHRvIGNoYW5nZSB0aGUgZXhpc3RpbmcgY29kZSBhbmQgbWFrZSB0aGUgY29kZSBtb3Jl
IGdlbmVyaWMgdG8gYWRkIG5ldyBkZXZpY2VzPw0KDQpGb3IgZXhhbXBsZSwgdGhlIHJlZ3VsYXRv
ciBtYXg3NzY1MCBkcml2ZXIgd2FzIHdyaXR0ZW4gZm9yIGEgc2luZ2xlIGRldmljZSBhbmQNCnRo
ZSBkZXZlbG9wZXIgbWFkZSB0aGUgcmVndWxhdG9yIGRlZmluaXRpb25zIHNlcGFyYXRlbHkgYXMg
Zm9sbG93cy4NCg0Kc3RhdGljIHN0cnVjdCBtYXg3NzY1MF9yZWd1bGF0b3JfZGVzYyBtYXg3NzY1
MF9MRE9fZGVzYyA9IHsNCgkuZGVzYyA9IHsNCgkJLm5hbWUgPSAibGRvIiwNCg0Kc3RhdGljIHN0
cnVjdCBtYXg3NzY1MF9yZWd1bGF0b3JfZGVzYyBtYXg3NzY1MF9TQkIwX2Rlc2MgPSB7DQoJLmRl
c2MgPSB7DQoJCS5uYW1lID0gInNiYjAiLA0KDQpzdGF0aWMgc3RydWN0IG1heDc3NjUwX3JlZ3Vs
YXRvcl9kZXNjIG1heDc3NjUwX1NCQjFfZGVzYyA9IHsNCgkuZGVzYyA9IHsNCgkJLm5hbWUgInNi
YjEiLA0KDQpJIHdhbnQgdG8gYWRkIHN1cHBvcnQgZm9yIDQgcmVndWxhdG9ycyBkZXZpY2VzLiBF
YWNoIG9mIHRoZW0gaGFzIG11bHRpcGxlIExET3MgYW5kIFNCQnMuIFRoaXMgbWVhbnMgSSBuZWVk
IHRvIA0KYWRkIGFsbW9zdCAyMCByZWd1bGF0b3JfZGVzYyBzZXBhcmF0ZWx5IGlmIEkgd2FudCB0
byBhZGQgc3VwcG9ydCBhY2NvcmRpbmcgdG8gdGhlIGV4aXN0aW5nIGRyaXZlciBjb2RlLiBJbnN0
ZWFkIG9mIHRoaXMsIEkgY2FuDQp1c2UgbWFjcm9zIGFzIGJlbG93IGJ1dCBpdCBjYXVzZXMgY2hh
bmdlcyBpbiB0aGUgZXhpc3RpbmcgZHJpdmVyIChpZiBJIG1ha2UgbWF4Nzc2NTAgcmVndWxhdG9y
IGRlc2NyaXB0aW9ucyB0b28gdXNpbmcgbWFjcm9zKS4NCg0KI2RlZmluZSBSRUdVTEFUT1JfREVT
Q19MRE8oKSB7DQojZGVmaW5lIFJFR1VMQVRPUl9ERVNDX1NCQigpIHsNCg0Kc3RhdGljIGNvbnN0
IHN0cnVjdCByZWd1bGF0b3JfZGVzYyBtYXg3NzY1MF9yZWd1bGF0b3JfZGVzY1tdID0gew0KCVJF
R1VMQVRPUl9ERVNDX0xETyhMRE8pLA0KCVJFR1VMQVRPUl9ERVNDX1NCQihTQkIwKSwNCglSRUdV
TEFUT1JfREVTQ19TQkIoU0JCMSksDQoJUkVHVUxBVE9SX0RFU0NfU0JCKFNCQjIpLA0KKQ0KDQpT
aW1pbGFyIHByb2JsZW1zIG9jY3VyIG9uIHRoZSBtZmQgZHJpdmVyIGFzIHdlbGwgKGlycXMgYW5k
IG1mZF9jZWxscykuDQoNCkJlc3QgcmVnYXJkcywNClpleW5lcA0K
