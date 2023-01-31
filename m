Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B1C682C25
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjAaMD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjAaMDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:03:24 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB302E0F8;
        Tue, 31 Jan 2023 04:03:22 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VAANnM004014;
        Tue, 31 Jan 2023 07:03:00 -0500
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3nd1gb2npm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 07:03:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKwu5t8JwxlOzwR5vCgeBku9FT2RtTo8rzF6crOb/TnrCJKo+QW+gBuoQiMTeS33aZGbvRfl44wUrsFA6q/c0yS4fkJM6c5ll2TH4LENAn65eSx2QoGs6Ry3CWH5q8zXJ17qng3zjrFwY8YeZNuEzwOA8IkdxqbUWUGCsltg/R55e0OdljGU0XwNi1/VMgvmiuaL2YaGvKtkhq7L6kfdFLYqYw3oJC5mOs2Qm4uJNb3bEwwcANJTrm40t92kiMBm6/09rr5t6O0Z3aGKbhCMg9CFmYLOkDO2mKoyK4I0uJD7rWt5ueR6PWUkCL8XERBV1bGsacsks/dUwQJdv0iK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGyCmlJ1URPUisTNi5BljlzkMTBbIayjJx4sVqrNSnc=;
 b=oCOoWFz8Y75adpcdZCI3pnoCuu535VEPJPwCjO4K67bGNNVyezRHKXmRNCwfLiArOHl4OEU/wQsHMhgrSfSAbu5iz6oHnVziboxF4MP9lj1LEtmo6SLiyL07z06QOAi4SUoWc6uce7IMt/AuCcJtlj0MzFZB67hndp1DbsdkwvTghsVK44eb1VCxW0YDcKqROhlR4NR0cJ2nLQcynsGXBbOm7bMKjRnKPHG33gkdxPdzfgnZwNg5Y6moOd5PTlQxmGrLuV/kZh6FClawZ4WEZ/Gq7FTvep1ap/tG9iJNBpqohsDwyGYi7WQhgAuprlCY8SesPBk5AdTQOlLMnSe0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGyCmlJ1URPUisTNi5BljlzkMTBbIayjJx4sVqrNSnc=;
 b=X5E7FmC5VX9bXRiydOCbFvg0sPFy3VtTwyT7aaeD0mhxgjPKkEFe0NE4dFj64DByl0z+Qckfg89/Z2QbQZGICQNDW4DkubP9gUqh5GMyjnTzcWtRNS8YX/iNIFwD1WGxKk4JeTv07GjNI8EzcSo6M5mgrBd4JtNEUK6MlrcTkVI=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by PH0PR03MB6382.namprd03.prod.outlook.com (2603:10b6:510:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 12:02:57 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::2f8c:567f:c6cc:dbd9]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::2f8c:567f:c6cc:dbd9%6]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 12:02:57 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v3 2/5] dt-bindings: mfd: Add ADI MAX77541/MAX77540
Thread-Topic: [PATCH v3 2/5] dt-bindings: mfd: Add ADI MAX77541/MAX77540
Thread-Index: AQHZKwfBz6jjhX+QnE+qf5JlMAgoI66j1hOAgBSmw4A=
Date:   Tue, 31 Jan 2023 12:02:57 +0000
Message-ID: <MN2PR03MB51685B56D49CBB590BBE6B7EE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-3-okan.sahin@analog.com>
 <c4433cba-ce35-e5d3-f04b-ba8f9f501732@linaro.org>
In-Reply-To: <c4433cba-ce35-e5d3-f04b-ba8f9f501732@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYjJ0aGJpNXpZV2hwYmx4aGNIQmtZWFJoWEhKdllXMXBibWRjTURsa09E?=
 =?utf-8?B?UTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdKaE1qbGxNelZpWEcx?=
 =?utf-8?B?elozTmNiWE5uTFRNd05UWXhZVFEzTFdFeE5XWXRNVEZsWkMxaVpUazJMVFU0?=
 =?utf-8?B?Tm1NeU5XUXpZek5sTkZ4aGJXVXRkR1Z6ZEZ3ek1EVTJNV0UwT1MxaE1UVm1M?=
 =?utf-8?B?VEV4WldRdFltVTVOaTAxT0Raak1qVmtNMk16WlRSaWIyUjVMblI0ZENJZ2Mz?=
 =?utf-8?B?bzlJak0yTURNaUlIUTlJakV6TXpFNU5qUXdNVGN6TXpVMU9UWXpOU0lnYUQw?=
 =?utf-8?B?aWIybDNjMFZITDBnMUsyWkNWSFJQYnpNNGFGWmtiRTVLTnpaelBTSWdhV1E5?=
 =?utf-8?B?SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJRVUZGVWtoVk1WSlRV?=
 =?utf-8?B?bFZHVGtOblZVRkJSVzlEUVVGQ1ZGcGlSSGxoZWxoYVFXSlJTbFpTZWxWdVNX?=
 =?utf-8?B?ZEVkRUZzVmtoT1UyTnBRVTFFUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVWhCUVVGQlJHRkJVVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVVkJRVkZCUWtGQlFVRlNjekZuUmxGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZLTkVGQlFVSm9RVWRSUVdGUlFtWkJTRTFCV2xGQ2FrRklWVUZqWjBKc1FV?=
 =?utf-8?B?WTRRV05CUW5sQlJ6aEJZV2RDYkVGSFRVRmtRVUo2UVVZNFFWcG5RbWhCUjNk?=
 =?utf-8?B?QlkzZENiRUZHT0VGYVowSjJRVWhOUVdGUlFqQkJSMnRCWkdkQ2JFRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRm5RVUZCUVVGQmJtZEJRVUZIUlVGYVFVSndRVVk0UVdOM1FteEJSMDFC?=
 =?utf-8?B?WkZGQ2VVRkhWVUZZZDBKM1FVaEpRV0ozUW5GQlIxVkJXWGRDTUVGSVRVRllk?=
 =?utf-8?B?MEl3UVVkclFWcFJRbmxCUkVWQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VkZCUVVGQlFVRkJRVUZEUVVGQlFVRkJRMlZCUVVGQldWRkNhMEZIYTBGWWQw?=
 =?utf-8?B?SjZRVWRWUVZsM1FqRkJTRWxCV2xGQ1prRklRVUZqWjBKMlFVZHZRVnBSUW1w?=
 =?utf-8?B?QlNGRkJZM2RDWmtGSVVVRmhVVUpzUVVoSlFVMW5RVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVKQlFVRkJRVUZCUVVGQlNVRkJRVUZCUVVFOVBTSXZQand2?=
 =?utf-8?Q?bWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|PH0PR03MB6382:EE_
x-ms-office365-filtering-correlation-id: 47e3a377-3be7-46e6-2474-08db03831772
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bGVL2WdgGik/yxPCX6/JnUErwsLw+WxTFP3Yvi4EPuF8m/fu+cseQrxSdnr/VMuCnjmE+A/oXTUB7a70VUt4s3kgsB0cvpr/pqEYo+UlIN7a3ciUqPaDWJlWIzhENUP0iDjhW8EnUMQ3iGlZDHJHu/0cRGUiqBorn3uBb2+B7Cwl/F5s/Go6T7GYvuNLrxVuQJxUblVsMZbfhLi8H3GJRKSuusfg759OnsXfovSag3n7U9QCOwN/IiYfIVq4aERsHEElXy7eYcZ+OO/aYe+8xI1P87YKnGSDdLEFOMtJ8GtAbeXPhAFNUYtp5+65Lk4AGAbqSF7vvmyIAxvb4b+CgfJ3YmrSn9YvyWkXwOHZ/MAExN1eDr5b0VTb0jQUgldB5bz8/18jnGuI0slw+syVX/C7mjGgo0zb4GOAILKZMYs7gISVcmUE8SvydqDPbSXiizLsuhfevlLm8R2oAP+KpyEh4SfPAk+FsbLFYNuQrHAgXlX8XTKhXuQy8MPUIKJUyIh0pGUOygJwbtmBKSgU1t43tH+HOwOfy8ri/YsYPJuJq6i5eH85VYMHBpxAwWBAvuf1TgY3KPqlv7svNPCWN38WkZo9Vs+iovmcQ1vvQ50lbNAd0OcSjFHkgCe6x0EwsPReEHTrO5JNdOh/6p1Sz6BGP8f5y964UdBq61FZextCBChdNniRMw1BDBhbiRJJHrxzSbhCEi5xX6WMDtPdSPXI10QiaWFMj4fAo7f1NEZ/HhPOHl8FcfpPulw6yUpw+N5yz62MuT7vvwse2KYzuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199018)(66556008)(66446008)(66476007)(64756008)(66946007)(76116006)(41300700001)(83380400001)(4326008)(6916009)(8676002)(52536014)(316002)(8936002)(71200400001)(122000001)(9686003)(7416002)(2906002)(33656002)(55016003)(5660300002)(54906003)(6506007)(7696005)(478600001)(86362001)(186003)(26005)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHJtKzZLUUt6Q2FzRzVjL0dHcWNDN1hBOWhTY0t2cXN2NFprdExDeGg5ZmNU?=
 =?utf-8?B?ZWlzU1FGdlF6V3VLb1N3T0dXZHlWYnZLTjlDa2FWS00wOHU1ZXlWUW93ZlZU?=
 =?utf-8?B?c2JXbHY2S0pudVJkQUhOQTJFOHNQWHh1MGtKbnhIV2xKekk0ZlZDdXNCK3pN?=
 =?utf-8?B?TUlHOGRrVjQ1cUlYS1NrT2RPNitQY1NzaXlYR0thQW9jTG9kY1k4Y3dJd29E?=
 =?utf-8?B?Ni9ZTmdFbEFWUXZPKzVuR3d3OVZLZU5USUFUTTRsUTMzY1JLcHhKQXdydHRq?=
 =?utf-8?B?dHRtVms0WFdGUmY2NE9KdnQvbHlqbmZkVVlHd2NhaUlDQVhGSlgxN1pwby9w?=
 =?utf-8?B?R1lXUm92NWM5eEFlbHpJV0wwcHNPQTQwZCtIb1NQczFjZ25QakljZ2NZbThD?=
 =?utf-8?B?KzM3bjlzQk5HRzJ5M1BMdEx6b09RcTR4VlB0K2RhbHl3Y1RhWmswdFQ1ZjRa?=
 =?utf-8?B?RXB4Z3FwTkVQOHdBUDY1UlhXam4yS2VWWHdiVGk3ZWRxblVPTUN4eHRDQ2M0?=
 =?utf-8?B?dXNEaDVWT1B2QnU4bDY5YjdBY0w1b0xLb3JYRVdacWVaV0dXTWs2eE9NaHRR?=
 =?utf-8?B?WUdJeGYvU1VEZk5CTkVoaW85VDBWQ2ZJaXplSEEwR1NTNlUzRUdMbVRRaVda?=
 =?utf-8?B?MlhLelNXZW5hdVlwamRlRGgva05FbmFXUnRjQno4UGFWOTRxemppY3pqU3Z1?=
 =?utf-8?B?VWQza2pYMGt4Z3lNWENiZDR5L2d1WW1jWTBFNERSUVpXQXludEpvei9Rbjdu?=
 =?utf-8?B?M05sVFFmNTVDQ2NRQnA5d3Q2Y25td0JjejNWOGs3eHRKczRpV0VEQ2FTTXBy?=
 =?utf-8?B?aGNrTU5walNSRWtYRFdSVTZMUVpRMTJ5c1B2YmcxZURML1NLcFlvSzloNVV2?=
 =?utf-8?B?YzZqU29BYXJMVGRNd2t5ZkVtWk00RzFUVnY3K1NNZkplNFhCbVhlSlJuWmF1?=
 =?utf-8?B?K2h0bDRWcDgrRmVvRXRmRHFxNTRqQ2xxVS83ZDZ1SGdLdS9vQUJ5b0R4RFY3?=
 =?utf-8?B?NXBIN0xEYnNFR2tjUHpvNVM3M2xkOHUrVSswUm1pSUpOZDcyQUNDZlg1VldB?=
 =?utf-8?B?aS9ZelMwcWV0WkdnN0FpdG5ESCsrNFRVWFdpM0FpUHdTRUtvYUdZc3pqaFBx?=
 =?utf-8?B?VUVQZ0FHeTRoSlJSUU1CSkF1V1JpRXVYRTY3eXpUNStobkpTMFI5NTVqQzI0?=
 =?utf-8?B?cm1wWlBodjhvMk53c0N1K3ZzL01ETWkyMXI5RW5qeHhPUW92ejZ1bjloN1lC?=
 =?utf-8?B?V1RGdGdvck56RFVQaGtXV1owMCtTVzNPbmoyWDhHT0FNSDZjYkJZL1FqemdV?=
 =?utf-8?B?WHhKOFlwa05BVThPRjJDbVdyRWhHU0x1bGZNc0x4VHNKYXRiNjUxQ3FFTU5p?=
 =?utf-8?B?am1vcnZBVDlNWGdKL3h0QUk2ejVmUjBNOGZyM2xaVXhScnZBb0Z3cUk2b05I?=
 =?utf-8?B?ZnBjM2t0YWpUVnFiekl3bldBNUJ4cjd4YlM5SDZDaGYvNko0WlNneWhMd1hp?=
 =?utf-8?B?K3gvSzJiUG01OS9UVHZIeWVrYVRmb2VOZXFvbWxSU3pGM0dVaXJmek9lMWRa?=
 =?utf-8?B?bHhWUUkvSWlkTVkzSUhpOGdzdVppYnNzVzhDbDVsY0kreUlhLzk4V3YrSUdn?=
 =?utf-8?B?dGxDMXJ5NmU3cFhub0dGOXNiZDlaODNPMDVCMEZiNDFMaFczeXdjZ053K2pE?=
 =?utf-8?B?bmFvSkhNYUhSVnJmWUY2Ym1wSkRsNGZjc052Ykh1ektPeU0yaGwzY24yNlFy?=
 =?utf-8?B?RmE4QnJRUzJjY3NSeExGQzFSRkgraFV5cGovNmtpNnB5VVFkQTdwVWpaYS9P?=
 =?utf-8?B?WExoMTE3WFgva1JuTmJCSWZJMi9QQlRSSWZ0Q0padnlPZDAxYnB5MUlsckls?=
 =?utf-8?B?Z3VCOUNFanVmRUlKNzNSdENSK1J0cHRxanBDR0tCS2VrdFpKNUNPVmpTUTZZ?=
 =?utf-8?B?dlBFYkVYTHM0SXAvZWFVNjFhYnRDbTV5eGdYbTNhZTIxUkpER2ZVdmdTMjhL?=
 =?utf-8?B?eTlCQ3lBZzlmd2s0dDVDTmt0dlR3V3BWczBKaVdzRW1tN2orVnJlWGZGN1I4?=
 =?utf-8?B?S2VIekRBQWdick1oeFp5L0lwUE5HOU5NTXYvWmlLNHNjVGNXdzQvcmQwZ2Zs?=
 =?utf-8?Q?qE+rUvDXtDmjNeOa5IRj1nBwe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e3a377-3be7-46e6-2474-08db03831772
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 12:02:57.1700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amRolyXPJ1JZ1zmFVsyuZm71Lyqrx9uNWwuvo+fPAxSgOeO37N0eWGQFX0p0bkt6qGM3XechcepC8TjMbH1CMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6382
X-Proofpoint-GUID: ngacLJ85OlLoLviOpVix4ZjxijUYbIxP
X-Proofpoint-ORIG-GUID: ngacLJ85OlLoLviOpVix4ZjxijUYbIxP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_07,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301310106
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2sgYW5kIGVmZm9ydHMu
IFRoZXJlIGlzIHNvbWV0aGluZyB0aGF0IGNvbmZ1c2VzIG1lIHNvIEkgd291bGQgbGlrZSB0byBh
c2sgYmVsb3cNCg0KT24gV2VkLCAxOCBKYW4gMjAyMyAxMToyMyBBTQ0KS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPiB3cm90ZToNCg0KPk9uIDE4LzAx
LzIwMjMgMDc6MzgsIE9rYW4gU2FoaW4gd3JvdGU6DQo+PiBBZGQgQURJIE1BWDc3NTQxL01BWDc3
NTQwIGRldmljZXRyZWUgZG9jdW1lbnQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogT2thbiBTYWhp
biA8b2thbi5zYWhpbkBhbmFsb2cuY29tPg0KPj4gLS0tDQo+PiAgLi4uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWZkL2FkaSxtYXg3NzU0MS55YW1sIHwgODcgKysrKysrKysrKysrKysrKysrKw0KPj4g
IE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4+
ICAyIGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlvbnMoKykNCj4+ICBjcmVhdGUgbW9kZSAxMDA2
NDQNCj4+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYWRpLG1heDc3NTQx
LnlhbWwNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21mZC9hZGksbWF4Nzc1NDEueWFtbA0KPj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWZkL2FkaSxtYXg3NzU0MS55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi45MWQxNWU5Y2EyZTMNCj4+IC0tLSAvZGV2L251bGwNCj4+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYWRpLG1heDc3NTQx
LnlhbWwNCj4+IEBAIC0wLDAgKzEsODcgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlICVZQU1MIDEuMg0KPj4gKy0tLQ0KPj4gKyRp
ZDoNCj4+ICtodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3Jn
L3NjaGVtYXMvbWZkL2FkaSxtYXgNCj4+DQo+Kzc3NTQxLnlhbWwqX187SXchIUEzTmk4Q1MweTJZ
ITg5OTZqZE04azF2Wk5IQ1RVbWFfclBaSmdKRnA1WXNwbmZIbjkNCj5Beg0KPj4gKzFpUlpFUjJX
b25fTnQtZWd0RDZYbmFGeTJJMllUQUhoQ1RKQTBEY1A2eENiWVNfU1BlOGl5JA0KPj4gKyRzY2hl
bWE6DQo+PiAraHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55DQo+Pg0KPithbWwqX187SXchIUEzTmk4Q1MweTJZITg5OTZq
ZE04azF2Wk5IQ1RVbWFfclBaSmdKRnA1WXNwbmZIbjlBejFpUlpFDQo+UjINCj4+ICtXb25fTnQt
ZWd0RDZYbmFGeTJJMllUQUhoQ1RKQTBEY1A2eENiWVMtd3I5SWNaJA0KPj4gKw0KPj4gK3RpdGxl
OiBNQVg3NzU0MC9NQVg3NzU0MSBQTUlDIGZyb20gQURJDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6
DQo+PiArICAtIE9rYW4gU2FoaW4gPG9rYW4uc2FoaW5AYW5hbG9nLmNvbT4NCj4+ICsNCj4+ICtk
ZXNjcmlwdGlvbjogfA0KPj4gKyAgTUFYNzc1NDAgaXMgYSBQb3dlciBNYW5hZ2VtZW50IElDIHdp
dGggMiBidWNrIHJlZ3VsYXRvcnMuDQo+PiArDQo+PiArICBNQVg3NzU0MSBpcyBhIFBvd2VyIE1h
bmFnZW1lbnQgSUMgd2l0aCAyIGJ1Y2sgcmVndWxhdG9ycyBhbmQgMSBBREMuDQo+PiArDQo+PiAr
cHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGlibGU6DQo+PiArICAgIGVudW06DQo+PiArICAgICAg
LSBhZGksbWF4Nzc1NDANCj4+ICsgICAgICAtIGFkaSxtYXg3NzU0MQ0KPj4gKw0KPj4gKyAgcmVn
Og0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgaW50ZXJydXB0czoNCj4+ICsgICAg
bWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIHJlZ3VsYXRvcnM6DQo+PiArICAgICRyZWY6IC9zY2hl
bWFzL3JlZ3VsYXRvci9hZGksbWF4Nzc1NDEtcmVndWxhdG9yLnlhbWwjDQo+DQo+Tm8gaW1wcm92
ZW1lbnRzIHJlZ2FyZGluZyBiaXNlY3RhYmlsaXR5IC0gdGhpcyBwYXRjaCBmYWlscy4gSWYgeW91
IHRlc3RlZCB0aGlzIHBhdGNoLA0KPnlvdSB3b3VsZCBzZWUgaXQuDQo+DQo+SW5zdGVhZCBvZiBp
Z25vcmluZyBjb21tZW50cywgZWl0aGVyIGltcGxlbWVudCB0aGVtIG9yIGFzayBmb3IgY2xhcmlm
aWNhdGlvbi4NCj4NCj4NClNvcnJ5IGZvciBtaXN1bmRlcnN0YW5kaW5nLCBJIGNoZWNrZWQgcGF0
Y2hzZXQgYXMgYSB3aG9sZSBub3Qgb25lIGJ5IG9uZSB0aGlzIGlzIHdoeSBJIGRpZCBub3QgZ2V0
IGZhaWx1cmUgYWZ0ZXIgIm1ha2UgZHRfYmluZGluZ19jaGVjayAiIC4gUmlnaHQgbm93LCBJIHVu
ZGVyc3RhbmQgd2h5IHlvdSBhcmUgc2F5aW5nIHRoaXMgcGF0Y2ggZmFpbHMsIGJ1dCB3aGF0IGlz
IHlvdXIgc3VnZ2VzdGlvbj8gIHdoYXQgaXMgdGhlIGNvcnJlY3Qgb3JkZXIgZm9yIHRoaXMgcGF0
Y2hzZXQ/IEkgc2VudCBhZGksbWF4Nzc1NDEtcmVndWxhdG9yLnlhbWwgaW4gcGF0aCA0LzUuIElu
IHRoZSBsaWdodCBvZiBkaXNjdXNzaW9uLCBzaG91bGQgSSByZW1vdmUgYWxsIHRoZSBwYXJ0cyBy
ZWxhdGVkIHRvIHJlZ3VsYXRvciBpbiBwYXRjaCAyLzUsIHRoZW4gYWRkIGFkaSxtYXg3NzU0MS1y
ZWd1bGF0b3IueWFtbCBhbmQgdXBkYXRlIGFkaSxtYXg3NzU0MS55YW1sIGluIHBhdGNoIDQvNT8g
b3Igc2hvdWxkIEkgYWRkIG5ldyBwYXRjaCB0byB1cGRhdGUgYWRpLG1heDc3NTQxLnlhbWw/DQoN
Cj4+ICsNCj4+ICtyZXF1aXJlZDoNCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSByZWcNCj4+
ICsgIC0gaW50ZXJydXB0cw0KPj4gKw0KPj4gK2FsbE9mOg0KPj4gKyAgLSBpZjoNCj4+ICsgICAg
ICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICAgY29tcGF0aWJsZToNCj4+ICsgICAgICAgICAgY29u
dGFpbnM6DQo+PiArICAgICAgICAgICAgY29uc3Q6IGFkaSxtYXg3NzU0MA0KPj4gKyAgICB0aGVu
Og0KPj4gKyAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICByZWd1bGF0b3I6DQo+DQo+WW91
IGRvIG5vdCBoYXZlICdyZWd1bGF0b3InIHByb3BlcnR5Lg0KPg0KPj4gKyAgICAgICAgICBwcm9w
ZXJ0aWVzOg0KPj4gKyAgICAgICAgICAgIGNvbXBhdGlibGU6DQo+PiArICAgICAgICAgICAgICBj
b25zdDogYWRpLG1heDc3NTQwLXJlZ3VsYXRvcg0KPj4gKyAgICBlbHNlOg0KPj4gKyAgICAgIHBy
b3BlcnRpZXM6DQo+PiArICAgICAgICByZWd1bGF0b3I6DQo+DQo+U2FtZSBwcm9ibGVtLg0KPg0K
Pj4gKyAgICAgICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICAgICAgIGNvbXBhdGlibGU6DQo+
PiArICAgICAgICAgICAgICBjb25zdDogYWRpLG1heDc3NTQxLXJlZ3VsYXRvcg0KPj4gKw0KPj4g
K2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPj4gKw0KPg0KPkJlc3QgcmVnYXJkcywNCj5L
cnp5c3p0b2YNCg0KUmVnYXJkcywNCk9rYW4gU2FoaW4NCg==
