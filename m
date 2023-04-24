Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B52F6ED18B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjDXPjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjDXPjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:39:20 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20163E5E;
        Mon, 24 Apr 2023 08:39:19 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OCgqjk001729;
        Mon, 24 Apr 2023 11:39:08 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3q49e74qek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 11:39:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhAJ9bg9P2uunk+8iYYYDQwS5R4EZzrPcSzJzGwgRLVjlYduQ2ATmMTJ16gqSuJ8DbUBPbXHZeELOmRQ24Cxkq/b/+u68aBhwhmsMQ3H/IT2I/QpU0Gank7mWHyhGf9EHHWmeGzQ7h8hGk/Y05GJsfugmBMI6oG8gKDwP3dL7hgaIwM4UPC6JoxZzSj5m0bO1qFbyCoHaVczthC5d3GY6ZA85PISZ+YfeEn/XK+F5ABe5g4c0Q7UsgV3uQYxiN+jFcgdI+Ty0Ay7hpJMEKhWnEZtJ7+rZH6aTIgM7xf6v82lQajR0HrQ5TtfyPSif0iZjdLHKcLRV2khXANetM5I/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NikXMmZbZR8XhC2jJTaOz25YrnGmNZsRuD3G10Fl8dY=;
 b=BLlrogptZmrwQLxgONewetb208p+LzdtXeOXNrJ6bnYwTwNwVCkedHYy7ynN4cb73obJrXeK/TEF3yeSzLGvrgnQo07uzpNNgURBXU0MEHEkt3RsRsoNUqb9Dw1nrBvLGGEBnHSJ8FBxrlM9hQsiA1vZ2Yl8Qe5P4oEeceihPleJSyaBzpqha1Dxpysgox+a7Zj4vwXxjDxKz8J3RtVk6Z6SgZoGZcClnYEuQ3sHQwOyyFFvz9hx63xM8e9P7b7Mg+RCBS5kxBSmKvtl00rsokWxq0AOaO0romXhBpAWAF9NQZGM6xCO15lCRUl6j4AjATDQrlThTaM0AEYv/ki0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NikXMmZbZR8XhC2jJTaOz25YrnGmNZsRuD3G10Fl8dY=;
 b=w/mrm5IoweWJJKtI0DAXgdjPDU27cMYsLqsRnsbAn6zJEprhD47ChdjMkPKL1Sx/yFF1iYDn/r5sRTY7aM5emGtaZXx635dP4JCH6f2xTGOAMgjf1T9ir0+Mfa75scBnPYmFVZMPxQGV7HUHKe5pRa6V/5YK7DOzYjBPsKUPWxQ=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by SJ0PR03MB5584.namprd03.prod.outlook.com (2603:10b6:a03:278::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 15:39:05 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea%4]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 15:39:05 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Michael Walle <michael@walle.cc>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
Thread-Topic: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
Thread-Index: AQHZYKxFzu/viFi84UyZMktWpJEoz68UqJ8AgAaZoUCAAX9AgIAACimAgAMiPoCAAFCPgIACysWAgAMsY4CAFH9pMA==
Date:   Mon, 24 Apr 2023 15:39:05 +0000
Message-ID: <MN2PR03MB5168D7940E322DFC0A1A3148E7679@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230327130010.8342-1-okan.sahin@analog.com>
 <20230327130010.8342-3-okan.sahin@analog.com>
 <CACRpkda5G5b+At5s1WFudpQBQ6LDQxhE3fZj7eBhkZ=thvnQhg@mail.gmail.com>
 <MN2PR03MB51682210CADA6E33FB99052CE7939@MN2PR03MB5168.namprd03.prod.outlook.com>
 <CACRpkdZJA0DyzgLxm9HFeHO03rqNUff=avuV=VrGuJkkOg6wNQ@mail.gmail.com>
 <25e1fda4b6df2d10444d7eca3cd0e387@walle.cc>
 <CACRpkdYKEid8-0-7sBECNgSyW3kMRCsv3DeBVUzxo4z6p+Grnw@mail.gmail.com>
 <ZDBivYlwJ6zgaFTg@surfacebook>
 <MN2PR03MB516879DCD6600827AEE2BDC9E7949@MN2PR03MB5168.namprd03.prod.outlook.com>
 <a3ca3e705b5b8668cd511fc15681c75f@walle.cc>
In-Reply-To: <a3ca3e705b5b8668cd511fc15681c75f@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYjJ0aGJpNXpZV2hwYmx4aGNIQmtZWFJoWEhKdllXMXBibWRjTURsa09E?=
 =?utf-8?B?UTVZall0TXpKa015MDBZVFF3TFRnMVpXVXRObUk0TkdKaE1qbGxNelZpWEcx?=
 =?utf-8?B?elozTmNiWE5uTFRJeE4ySXhOakF5TFdVeVlqWXRNVEZsWkMxaVpXTmpMVFU0?=
 =?utf-8?B?Tm1NeU5XUXpZek5sTkZ4aGJXVXRkR1Z6ZEZ3eU1UZGlNVFl3TkMxbE1tSTJM?=
 =?utf-8?B?VEV4WldRdFltVmpZeTAxT0Raak1qVmtNMk16WlRSaWIyUjVMblI0ZENJZ2Mz?=
 =?utf-8?B?bzlJall6TlRnaUlIUTlJakV6TXpJMk9ESTBNelF3TWpNeU5qSXlOaUlnYUQw?=
 =?utf-8?B?aWFGSmFRalZ0WVRZNGQySTJhMjV0ZWtSTWVsUlBSMjQzV0c5clBTSWdhV1E5?=
 =?utf-8?B?SWlJZ1ltdzlJakFpSUdKdlBTSXhJaUJqYVQwaVkwRkJRVUZGVWtoVk1WSlRV?=
 =?utf-8?B?bFZHVGtOblZVRkJSVzlEUVVGRVUwRk9ZbXAzYm1KYVFWTlVTRmhhTUhGRWFs?=
 =?utf-8?B?aG1TazFrWkc1VGIwOU9aRGhFUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVWhCUVVGQlJHRkJVVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVVkJRVkZCUWtGQlFVRlRha1ZZZUhkQlFVRkJRVUZCUVVGQlFVRkJR?=
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
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|SJ0PR03MB5584:EE_
x-ms-office365-filtering-correlation-id: 60a0454f-3e5b-4561-ba12-08db44da0941
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 49QRS/qZG2lsKIrKdEIstAWbAWHnme8BOZHcfzbizbb9zsup0ECbMoMKDFFi9aLaza1vve7jiz/1sS1ZmEp/6VPfUCQVr4J+5Zms9ZOyaDOJ4+fhbANC2SU3uDxabVXp6oB7/rnCVb9vAxdP1z7Me8HuOqNutN94+reSzxnSIY2zW5xjiyHd6/7T3MnpSQj7ndw0ar7J/Ammcx0CP6EzBwb+wAMk24PPAvpSoDVoVGMMu5GlnMlHoJAREhIDa7aSAW3WBMFIjk5UQ4Q0+6PJbGX6Pz/Nz9YeVKS94TVlGK/3sISyM7KaERLJF4q2AgpnF6PiCKNcY+Juto9chQETDr7GNp3BEOVnbs4F8vVzr4fEAmfwrr8U0ywADUCDA+nzpeuIqSnTyi/tjtzKM2ckllslw3BfIrDAARKCO3YjlTg88asPQJazGgVJcmWQAP5YtrERw6VmhbqQMqLbB6dcuOJ76Z9X1UVQ3rEpFhogmWFCB5wC6aPEgM1MsM1dTimye0PFyCB/HhZl9mjGewxkZKcQolRu0ea/SPXnTbjpsJCgbA11NztQt7TRBCHNq/Hnr2lvKJiCVWOnU3/r5jIcKQJs/0yQe5LO96NZUfm4E1U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(966005)(9686003)(53546011)(6506007)(26005)(38070700005)(55016003)(83380400001)(186003)(38100700002)(122000001)(66946007)(478600001)(76116006)(86362001)(6916009)(64756008)(66556008)(66476007)(66446008)(8936002)(8676002)(54906003)(52536014)(5660300002)(71200400001)(7696005)(41300700001)(2906002)(4326008)(33656002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzhyM2svYS90TlgrTmtuUHZXVHdqWldGOTZBdzlMLzJqMElYUGlhQkRNbTZz?=
 =?utf-8?B?aUgwSDB0MytRcjBIUWIvb0lleWQ5TGY3QnpxMGQ4c2gra1dVSXBJWjdGYi9G?=
 =?utf-8?B?WEpDK2cxSVNQa2pZRi83VTJBbW5nUEpOM1VqaTQ2VmFwZEljSS9sTW9IU3o3?=
 =?utf-8?B?QUxzK29XQk9qVkZXTFhoUmdjSSt3NkpLWElOTCt6emNaZGdVcUFodEVrUmov?=
 =?utf-8?B?b2UySGpDTTNEYUJseWFTN0JJMXZRcHVwL1hiaDVWU3pyRS9LRExmb0pZRUIv?=
 =?utf-8?B?UGdWbTZJNXlyeERtbVdKMlE5cGxNWGQzN2ZzQUZwS0JQdkpCdFoxT3ZjanlI?=
 =?utf-8?B?YzJxMkU1TVlKZE5OT0dESmFwVVBvT2QvY2UvQnhmZEdndC9TUnVnSm50bTJs?=
 =?utf-8?B?VXVmMDJnSitkdW96ZVRzKytsU1doK013anZxOFdVVW5mb2lnUlIvSXZPek84?=
 =?utf-8?B?ZGxUNmpFTUZzemljSTE0NnVGRjFjQ3ZRczQ1QnVsa2lZTXB4KzhzZldyTGNs?=
 =?utf-8?B?enA5UzVkMDlocGFTWHJtcnJnQXFaYzArbG5jODdEeG96WENNY0xCL2UwQnY0?=
 =?utf-8?B?RjlhTE56N21MNUhCTkg1UlIxRk5TRnZlNDJMZFVPVmJYbXdjQzk2aHpUVlhB?=
 =?utf-8?B?cDFvZk1LelU3V0JsMENXNTl3dDVJR3NhU0FLWE1wS2RXRVpDckRORVBnaDdv?=
 =?utf-8?B?OW5MMTlDdXp2ZEdDM0FFS2xNM0o5aEZIK2s4OEFLWlFVTDZFckxsR09GNVBR?=
 =?utf-8?B?aXJuRUZZS1d0YS8raEsrUndvVUczaTJ0VlJjSTZoMFpKb3JmU0lqK0tQYlJQ?=
 =?utf-8?B?RStud2RJQjRGako3MjBUR3hORkcrdDBkbUVWbnoyYWRrYUhaSkdzbmJMZURE?=
 =?utf-8?B?eHhxUEN1UmsvYW9WeTZiNjFDUVl0MWtRLzFmbEJ0UC8wRHBlU1ZOc2FQR1Rk?=
 =?utf-8?B?czVDNmpGcWdYTmJRNlNOemtra0daRFI4YTJZSzVoSUs5NDBTa0JzZFhQalV3?=
 =?utf-8?B?eTlOOUNYWnRlT1gzZ3NJQWk1TkFlKzFRdlFVMUNCYWxWS2F5amJkK2d5U1U2?=
 =?utf-8?B?SEhNSTJJNFZHYzRDVndmdnpoeHFYUkFIUHNvY3F6S20wOTAyeS96aVppVjJK?=
 =?utf-8?B?YWRtSjc0TFBnZDdxdzlqRnNxKythVi9yUkt0YXROL04zNHljT3JXVHFDczEv?=
 =?utf-8?B?Vzk4bVVZNXNXOSs0RDRtZlpnRzYremo0UGlQWkM2ZkZEWFJoY1pESHhUS2Zr?=
 =?utf-8?B?K3ZIRTA4UWNiMm1IYkJHYitNdit1S2dKTFVtQUF4cUZaamVmVkJENmpRYkRu?=
 =?utf-8?B?VDA1OElRc084MUZ4S3pxVU8vMkFYbkg5KzZ1ZnlrcktuMlFZaXQ2Z0JRVjhn?=
 =?utf-8?B?ZXIwTjhIL210WWlrb3pFSTR6aXp2TnlZb3BpTFlYM2t6bGREUnJtaE9rL2I0?=
 =?utf-8?B?T0V3enVmcU50WXdFME1BbTVjZStxMHd2dHd6OENkdERjYnlOcmFlS3dHaVpo?=
 =?utf-8?B?MUREMmdlZnUxOHdhb0lIOGlQOFpCd2R4a0ViaU5vU1dCcmRLUXJXa1ZMMGds?=
 =?utf-8?B?cTIzUU8rVEp2WnRDb0s5WFQ2eE1vcUJxeHlIN2J3ZWYrdDhBSUpJNnRocnBE?=
 =?utf-8?B?ajU2bVF3N0I5WlZNOGNhc29nZ1FSdEY1L1hiWXhSZ2EzaWNJY0V5Ry9pRmNL?=
 =?utf-8?B?K0tDeWlIeUNiMWw3UmlrU25NS1RvdmM0VG9YQ3YzU0tvcmdFUitwdXNxZUty?=
 =?utf-8?B?TlkzK1l4dHgrOVdpbllqanFSc3dRemNwVjdSYTV4OTFvc05EUktxTGRDVFJE?=
 =?utf-8?B?T1ZzOVpCVzE1dlJwYnZsZGVJNUJUSG9JMUZFU2lmakdFcVlnT2JOaUgrYXVV?=
 =?utf-8?B?Qm4xcmt3UG5YOTRJQzkvd2ZyRGUvNUNiY0tuSDUyUUM0bjByUy92MTN2RkNk?=
 =?utf-8?B?b1FFaUxKZk1ES2xJN21mM1VKaE5YV0pZQ1pTZlhFZVdIWjYxQXBDOVdsZllO?=
 =?utf-8?B?UlpYa3FxbnUzUzJqamVWWkhPLzFwR3BUZ1pXOE9YSTRCam9ybmE5M2d5YzRi?=
 =?utf-8?B?bXYxL1pmRVhQbUV6TTJSUDNkeDAxNWZUZlRyU09qdmVWVGdFYmlMZ3ZiTTg4?=
 =?utf-8?Q?jJ8yK3eS2QXOKOcE92yxW+QXY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a0454f-3e5b-4561-ba12-08db44da0941
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 15:39:05.1798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gadoPaZzxK3HuBqJbk5aUkRdOgpXJ0PIKkulrvbMmTRjcOhv/Ubeelbq4uVbqjHJ1gm/thwB88Jz88ff1ogNPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5584
X-Proofpoint-ORIG-GUID: jPj5cKhoLX1fXr2Z-fuIMOgaMFaiKF0B
X-Proofpoint-GUID: jPj5cKhoLX1fXr2Z-fuIMOgaMFaiKF0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_09,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1011 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240141
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkFtIDIwMjMtMDQtMDkgMTY6MjUsIHNjaHJpZWIgU2FoaW4sIE9rYW46DQo+Pj4gRnJpLCBBcHIg
MDcsIDIwMjMgYXQgMDM6NDg6MjVQTSArMDIwMCwgTGludXMgV2FsbGVpaiBraXJqb2l0dGk6DQo+
Pj4+IE9uIFdlZCwgQXByIDUsIDIwMjMgYXQgMzo1N+KAr1BNIE1pY2hhZWwgV2FsbGUgPG1pY2hh
ZWxAd2FsbGUuY2M+DQo+Pj4+IHdyb3RlOg0KPj4+Pg0KPj4+PiA+IE9UT0ggSSdtIG5vdCBzdXJl
IHRoZSBkcml2ZXIgaXMgZG9pbmcgaXQgY29ycmVjdGx5LCBiZWNhdXNlIGl0IGFsc28NCj4+Pj4g
PiBzZWVtcyB0byBzd2l0Y2ggdGhlIHB1bGx1cCByZXNpc3RlcnMgdG9nZXRoZXIgd2l0aCB0aGUg
ZGlyZWN0aW9uLg0KPj4+PiA+IEknbSBub3Qgc3VyZSB0aGF0IGlzIGNvcnJlY3QuIFNvIHRoZXJl
IG1pZ2h0IGJlIGp1c3Qgb25lIHJlZ2lzdGVyDQo+Pj4+ID4gaW52b2x2ZWQgYWZ0ZXIgYWxsIGFu
ZCB0aGUgR1BJT19SRUdNQVAgc2hvdWxkIHdvcmsgYWdhaW4uDQo+Pj4+DQo+Pj4+IEknbSBwcmV0
dHkgc3VyZSB0aGF0IHNob3VsZCBiZSBpbiB0aGUgLnNldF9jb25maWcoKSBjYWxsYmFjay4NCj4+
Pj4NCj4+Pj4gPiBBbHNvLCBhY2NvcmRpbmcgdG8gdGhlIGRhdGFzaGVldCB0aGlzIGhhcyBzb21l
IG52IG1lbW9yeSAodG8gc2V0IHRoZQ0KPj4+PiA+IGluaXRpYWwgc3RhdGUgb2YgdGhlIEdQSU9z
IFs/XSkuIFNvIGl0IHNob3VsZCByZWFsbHkgYmUgYQ0KPj4+PiA+IG11bHRpLWZ1bmN0aW9uIGRl
dmljZS4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgaGFzIHRvIGJlIGNvbnNpZGVyZWQNCj4+Pj4gPiBy
aWdodCBmcm9tIHRoZSBiZWdpbm5pbmcgb3IgaWYgdGhlIGRldmljZSBzdXBwb3J0IGNhbiBzdGFy
dCB3aXRoDQo+Pj4+ID4gR1BJTyBvbmx5IGFuZCBsYXRlciBiZSB0cmFuc2l0aW9uZWQgdG8gYSBm
dWxsIGZlYXR1cmVkIE1GRCAocHJvYmFibHkgd2l0aA0KPm52bWVtDQo+Pj4gc3VwcG9ydCkuDQo+
Pj4+DQo+Pj4+IFRoYXQncyBhIGJpdCBvZiBhIHNvZnQgZGVmaW5pdGlvbi4NCj4+Pj4NCj4+Pj4g
SWYgdGhlIGNoaXAgaXMgKm9ubHkqIGRvaW5nIEdQSU8gYW5kIG52cmFtIGl0IGNhbiBiZSBhIEdQ
SU8tb25seQ0KPj4+PiBkZXZpY2UgSSB0aGluay4NCj4+Pj4NCj4+Pj4gVGhlIHByZWNlZGVudCBp
cyBhIHRvbiBvZiBldGhlcm5ldCBkcml2ZXJzIHdpdGggbnZyYW0gZm9yIHN0b3JpbmcNCj4+Pj4g
ZS5nLg0KPj4+PiB0aGUgTUFDIGFkZHJlc3MuIFdlIGRvbid0IG1ha2UgYWxsIG9mIHRob3NlIGlu
dG8gTUZEcywgYXMgdGhlIG52cmFtDQo+Pj4+IGlzDQo+Pj4+IGNsb3NlbHkgdGllZCB0byB0aGUg
b25lIGFuZCBvbmx5IGZ1bmN0aW9uIG9mIHRoZSBibG9jay4NCj4+Pg0KPj4+IEkgYWdyZWUgd2l0
aCBMaW51cy4gVGhpcyBzaG91bGQgYmUgcGFydCBvZiB0aGUgYWN0dWFsIChtYWluKSBkcml2ZXIN
Cj4+PiBmb3IgdGhlIGNoaXAgYXMgbWFueQ0KPj4+IGRvIChsaWtlIFVTQiB0byBzZXJpYWwgYWRh
cHRlcnMgdGhhdCBoYXZlIEdQSU8gY2FwYWJpbGl0eSkuDQo+DQo+WW91IG1lYW4gdGhlIGdwaW8g
ZHJpdmVyIGlzIGNhbGxpbmcgbnZtZW1fcmVnaXN0ZXIoKT8gWWVhaCBJIGFncmVlLCB0aGF0DQo+
c2hvdWxkIHdvcmsuDQo+DQo+PiBJIHRoaW5rIGdwaW9fcmVnbWFwIGlzIG5vdCBzdWl0YWJsZSBm
b3IgdGhpcyBkcml2ZXIgYXMgTWljaGFlbCBzdGF0ZWQuDQo+PiBodHRwczovL3d3dy5hbmFsb2cu
Y29tL21lZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVudGF0aW9uL2RhdGEtDQo+c2hlZXRzL2RzNDUy
MC5wZGYNCj4+IFBsZWFzZSBjaGVjayBibG9jayBkaWFncmFtLiBUaGVyZSBhcmUgdHdvIGlucHV0
IHJlZ2lzdGVycyB0aGF0IGNvbnRyb2wNCj4+IGdwaW8gc3RhdGUNCj4+IHNvIGdwaW9fcmVnbWFw
IGRvZXMgbm90IGxvb2sgb2sgZm9yIHRoaXMuIEFtIEkgbWlzc2luZyBzb21ldGhpbmc/DQo+DQo+
WW91IG1lYW4gRjgvRjk/IFRoYXQgd2lsbCB3b3JrIGFzIHRoZXkgYXJlIGZvciBkaWZmZXJlbnQg
R1BJT3MuIFdoYXQNCj5kb2Vzbid0IHdvcmsgd2l0aCBncGlvLXJlZ21hcCBpcyB3aGVuIHlvdSBu
ZWVkIHRvIG1vZGlmeSB0d28gZGlmZmVyZW50DQo+cmVnaXN0ZXJzIGZvciBvbmUgR1BJTy4gSGF2
ZSBhIGxvb2sgYXQgZ3Bpb19yZWdtYXBfZ2V0KCkgYW5kDQo+Z3Bpb19yZWdtYXBfc2V0KCkuIElm
IHRoZSBkZWZhdWx0IGdwaW9fcmVnbWFwX3NpbXBsZV94bGF0ZSgpIGRvZXNuJ3QNCj53b3JrDQo+
eW91IGNhbiB1c2UgeW91ciBvd24gLnhsYXRlKCkgb3AuDQo+DQoNCkFjdHVhbGx5LCBJIGNoZWNr
ZWQgdGhlIGZ1bmN0aW9ucyB0aGF0IHlvdSBzdWdnZXN0ZWQsIGJ1dCBhcyBmYXIgYXMgSSB1bmRl
cnN0YW5kDQp0aGV5IG1pZ2h0IHdvcmsgaWYgdGhlcmUgd291bGQgYmUgb25lIGJpdCB0byBzZXQg
ZGlyZWN0aW9uIG9yIHZhbHVlLiBIb3dldmVyLA0KdGhpcyBpcyBub3QgdGhlIGNhc2UgZm9yIGRz
NDUyMC4gSW4gb3RoZXIgd29yZHMsIGlmIEkgd2FudCB0byBzZXQgdGhlIGdwaW8gZGlyZWN0aW9u
DQphcyBvdXRwdXQsIEkgbmVlZCB0byBzZXQgYSBjb3JyZXNwb25kaW5nIGJpdCBmb3IgYm90aCBG
MCBhbmQgRjEgcmVnaXN0ZXJzLg0KSW4gdGhlIGRvY3VtZW50LCB5b3UgY2FuIHNlZSBibG9jayBk
aWFncmFtLiBJIGRvIG5vdCBrbm93IHdoeSwgYnV0IGRlc2lnbiBpcw0Kbm90IHN0YW5kYXJkIHRo
YXTigJlzIHdoeSBJIHRoaW5rIEkgY2FuIG5vdCB1c2UgZ3Bpby1yZWdtYXAuDQoNCj4+IEFsc28s
IGF0IHRoaXMgcG9pbnQgSSBhbSBub3QgcGxhbm5pbmcgdG8gYWRkIG52bWVtIHN1cHBvcnQuDQo+
DQo+VGhhdCBpcyBhIHBpdHksIGJlY2F1c2UgdGhhdCBpcyB0aGUgd2hvbGUgdXNlIGNhc2UgZm9y
IHRoaXMgZ3Bpbw0KPmV4cGFuZGVyLA0KPm5vPyAiUHJvZ3JhbW1hYmxlIFJlcGxhY2VtZW50IGZv
ciBNZWNoYW5pY2FsIEp1bXBlcnMgYW5kIFN3aXRjaGVzIg0KDQpJIGNhbiBzZXQgIlNFRSIgYml0
IGFzICIwIiBpbiB0aGUgQ29uZmlndXJhdGlvbiBSZWdpc3RlciB0byB3cml0ZSBFRVBST00gc28g
aXQgbWlnaHQgc29sdmUNCmlzc3VlLg0KDQo+DQo+LW1pY2hhZWwNCg0KUmVnYXJkcywNCk9rYW4g
U2FoaW4NCg==
