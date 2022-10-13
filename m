Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE64A5FE48F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJMVxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJMVxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:53:17 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78F844CF0;
        Thu, 13 Oct 2022 14:53:01 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DKgiBN016976;
        Thu, 13 Oct 2022 21:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=0k5LFhQ3QhqUpiK1cpPJexryUP4ZjBh3MgsvQ3hPNAg=;
 b=BUY1x+oE4j2RbnvWB8MttTXVm9XyJHH7HrWmWtPiOJWVDMl+Lh/1qPGSRdM2UJNb/sEB
 TYwYApRzuFnr2KcsvkipRNpQqttmuyHr1YR4WCe9aHXqcZ5UqFZZMeyhhvEbU6Kv5xBy
 hXjhNzEgFK8LIvs0RDXt9uJXw0OZPAKlcP7hWHi3xRecMj+1wvQiUDYfiHNjJvmwk2to
 2cBMSLYliN6M1BiF2zMMMAXWjl4nD6bl6LgWTcd9DzckPQZS56h8DcPp55pjRlFelmAG
 W8InLlIBVz60jT8xuPXSvlTuChUj99HZzv4+YySbIMfXVs3RvWnh+febXVITWj12x2jr EA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k6qhn1qx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 21:51:40 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 8ADE8804704;
        Thu, 13 Oct 2022 21:51:38 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 09:50:55 -1200
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 09:50:54 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 13 Oct 2022 09:50:54 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 09:50:54 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TI7MSS1WPSy7Tg73Sd2Hp8QbGMpapwLGtmAbhrZqKl/FWx1H8Q2geIweL6Dacf4wkAssSPCvp5lNVBIqvS8w+kJiBkFMToTksoiwveJ3uuOmik+fBWthT2rriUnENPWf/p0IOsD8c12FSwKK1gCLMMX/Yotz3+tOoS80vKNJnqajB5kOVR9GYCMsSH/vtjCUTZH7XKw6qeofj425VzZdz/6VlXn2DlAsHmT5nfRbe3Oymws7DZZDXt/zRiHdkeixE8rdV9plZYrjLjtbsNGUkn2hbnnb/mcYdx9IbRBpQNhq4nrnIqvpfF6tLsh+TiI6C06dsEN44sA3ZUC30Zj92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k5LFhQ3QhqUpiK1cpPJexryUP4ZjBh3MgsvQ3hPNAg=;
 b=SxbByEG4asLQP6NiLLctd8gwZnmXYAE9Oty8I30XrZ1PElLsw2H1cBXrOdWmyo5JpLa+HSXc5YaQYDQPySV3giGr9G9oS/MyCRq5rSvkKNyd38RLdiVU916lEm8jlr3O5Uh1dfgpGTExscOnAsGduRD+EQGn/G7glB9qvZ1Xwck9B7kepEbN9GmI3utfa7zIFWgCGTBmWe3xqyRY6w0RW5brLHq7MDtlrNpbaZBEz7RhFZPvi3ihpT8ky+KgzZNtUUsP4FxIZWs3v/tolf0zNWgn7rITq+i0DqZA/yw7yyTzK+o/PJNF2WtCZ7nsZaVbWlMqF6BW5ZplIRwuNkwXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW5PR84MB1355.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.30; Thu, 13 Oct
 2022 21:50:52 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 21:50:52 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 04/19] crypto: x86/sha - limit FPU preemption
Thread-Topic: [PATCH v2 04/19] crypto: x86/sha - limit FPU preemption
Thread-Index: AQHY3oYBXsDUQQFB3kuWMnaA6CWxOK4LfBeAgAFiBlA=
Date:   Thu, 13 Oct 2022 21:50:52 +0000
Message-ID: <MW5PR84MB1842141A89926F7E28E4F752AB259@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-5-elliott@hpe.com> <Y0deya7WnwS0HMwl@zx2c4.com>
In-Reply-To: <Y0deya7WnwS0HMwl@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW5PR84MB1355:EE_
x-ms-office365-filtering-correlation-id: 6e67609d-faad-4153-589d-08daad64ffd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ROtmaC6TgoHdzKt6LrU7lU87i7m7S58FM7jvks84qIAuOzyGz+10gLg4ADVL8EVnDcSjDg+KzPYhT2gcUwmtD5rWDror58HX2OPbFjjKdJqmd49Z+g/69vPnTFsClbPNP5AFD+P9tmW1sZcEEoA1XuqWB8V3L2bhsMLTqFVTc+PhmLngCo4LVx8HD2NQwY4IeN3m9BVgXha6EAzsE3I3gonbSxOvssxaUPTkaiSd+gXJv7vskxyMArNfw9Ys4okq6IQ3pya3cmnvHZUHKLAH3N+TbTTflKWGRpt2+nWDcRo2g296w1ARbMIMa/2cUZGHrMwRL3hx6LSIG68Tl5LREUJ+rscBTtZ8ZF3EPCkh3lGTW5i5+HGJkW0POJvLk+qfAtWnaFSEDuDsIw7UDvA/uU9+7DgApQpL17wP3Y04dVSIC6oBci7RUNQjGHpjuazSuFyTxB0AfJ1cNB8iXYH9qbZZLN+rBL8amFxJSz/L56OPyOuXxSShR9pGKBTGbZ3mLRHrFX4cd3Yp4hs5+ZbO6jvZgT+9u5IgPnKu2kq9g3jSMiTbiw327UNyWvXMtBF0Hwm6E3boxKhHSuVM2DZ82PoDWPGKPIyWf2Y2oJaIMi1YQlA0eCz7hxMViFM+zeuhqypDMfSF94E/BJ9pxTXVUbnUu2x2M1jJK8Saxl11tCPu1Xi7HNY0P13ZpGgdWBpyj0TU9nbHZ/Tg7lQbbllqnorVNSszpdYzscU4rlslkEHiyq4EYdUgi0sal1ZyosHDEla6/7RDiH8ppR00Y1dB9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199015)(316002)(41300700001)(64756008)(66946007)(66446008)(52536014)(66476007)(54906003)(8676002)(76116006)(4326008)(86362001)(8936002)(478600001)(55016003)(26005)(66556008)(6916009)(9686003)(33656002)(5660300002)(4744005)(7696005)(6506007)(2906002)(186003)(71200400001)(82960400001)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUZOY3FOalBKNDkxNFYyZisvYWo0c1M5WnRaTk5remFUWlB5aWx4L0l5M01L?=
 =?utf-8?B?UUtyTXhZRmJ1dUsyekIxbTEybE1WRk5qUEVTZkxnZWVVVFE1dG8ycmhORFNu?=
 =?utf-8?B?NUJSSE9GMkgvOUhUdCsxWklERG9jZXRmWHgwMDNEbEd0UnpTaGZJTlg2S25l?=
 =?utf-8?B?OGhFMEF4WWJuSTc3UUtpZ08yRFYySno3dThCL0swenE1NTlBdnREN25LcFRV?=
 =?utf-8?B?SWkwejRBaDExbU5UdVoxSmwzWjNpR0Z5OWRnV2o3N3RreExWdTV1c3FXVGNM?=
 =?utf-8?B?bTdEdlRBVitrdmdVMFplR3MwUmIrdTlHUi9IdC9UMFFpVzRucUd2L0hEaWU3?=
 =?utf-8?B?UHB1VSt5WSszdHZWQXdTQ2R4cXF0U3UvR0NVMFpzQlZJamx1aHEzby8zSGhx?=
 =?utf-8?B?MGZGenlERElCUml2QTN2SFVqVlpPWFdoNVFwTlo1bzlkYktnbThOM0IxQ0I3?=
 =?utf-8?B?alBrcGlUeUtxcHZpdUJraFI1TEhPUXMvZ1kwczVGQXZNQ0t2enQzZnlMR2lJ?=
 =?utf-8?B?TWUrMmVuNSt4QU1IM1VqZ3MrRW9iTmVUUy9CVk90eEZTM0pwVHdEVEMzdzN3?=
 =?utf-8?B?SHJCTkNFNjV1ZjdGOTR3L0FnbDZxRkowNDRLY3VQekdCK2o5eWZMOTZiR2xS?=
 =?utf-8?B?aU1KdkE3NisvWkN4NDlFOWp5NzRXMyt1SXJyd1dLNW1xdy9EVC9qSHh3dFRR?=
 =?utf-8?B?S2J3STF0VXNDdisxOWU3bWFJd0VSNUNoN2QyWjlEVHk4UXRteEZJMWpVVkcz?=
 =?utf-8?B?YVRzRWU0WDhWL0xiQjNCZ0c3bDRvbUEweEk0Q1RiaER0ZGJEQ20yVW8rSHl2?=
 =?utf-8?B?aWJCMFY1YmU4RTN6OXNCMjBqNXJNWUlPejRxaEVPa3M3ZTI1SUFJVFNOdnRa?=
 =?utf-8?B?dWJETUxHWGdPM2RZTURQVzhrTWxzMlgwcHJvYmNpVHR1MkR6V3M4NUk3OUVL?=
 =?utf-8?B?NTIvbmlPN0xQT0hjT0t6TkRzSFVGL0pSK1J3REZqYzJBWnc2dWN2UzBTT0xu?=
 =?utf-8?B?aXpHeDhWUjE4WVNLUDBDczRDN081VnJRdzlDa0lBZE9Oa01KdU5JR0tDZ3cy?=
 =?utf-8?B?bTNYUkM5ZVFJQ3ZTbzZCSU1LUDYxWlZZc2kyM3pCZFIzNC9PRi9Ga05JQTQ1?=
 =?utf-8?B?c1Zsa2hiYnhadENoellxOVlwcjZSb0cyOHR2c1c2UHMrL05iZDQ0NDlKL1Bj?=
 =?utf-8?B?Z09kellKc3RDUkVjWXRENzdZa2pyQ0xMWFdudkU0RmVUNXQ5VTdMakJNb3Na?=
 =?utf-8?B?aUEyMG0wR1pxWVdsa2UyKzlMM3lVVjYvcGpPcUk4UmRweUNjQlBQZWhmU2JW?=
 =?utf-8?B?R2NRMEgxblJaVjhyQW5UZjhCRXJpc0ZZQm05SFRFRlFwR0pYWjQzUWp0SUV4?=
 =?utf-8?B?ci9JaTJianc4dDduaGQvQmh4b1ZMN1FMaFBhZDN2WW1kL1EvdmNDZzVXWDdO?=
 =?utf-8?B?U2t6SEdtSzlvdVlkejI2dXM0U09jRWQvUGk2YlhTazQvRUVmR2xaRWxFY3R0?=
 =?utf-8?B?ZnYyanI4Znp4MXArOVZUOStBVVVkTFlqaGc5KzVOTWx2KzhLOE5yblkwTkRi?=
 =?utf-8?B?Ri9FQi9OazEycGR6NGtHM01PSStsSDg5c1JxbGlMNVlJUE5rQ2MxekUzcGNW?=
 =?utf-8?B?NURmN29uUURPNVJVUHIwMFFvV3lRWXdwbklqdWNobFNxdkc1aHcyZFFGaDNP?=
 =?utf-8?B?QnA5d2RTMHF5SEVsaWlDLytYWHN0TjBFOTNjejE0OGdxN0xrNFRHN2dVS010?=
 =?utf-8?B?M3RpRmc5U0I5SFk0RmVJUVVHQzdCdmNQSnpvNThHODV0M1hqNk40S2VlRHAv?=
 =?utf-8?B?NU1YVldQUWRwL1d5bkYrNFQvdzRvOVYvRDc2Y0tUSklmZ1J5UmVGYXd2L2ds?=
 =?utf-8?B?NkdtbEJnV1BaUVppYWdUdjQ0ZUl3WGZ1bW9La2FEQUd0MWRla3k1OU9FYXhi?=
 =?utf-8?B?M1llYmw2c2l0YUh4dDNXVVAyWi8ybTFwVlZXNmc5bGY4ckRFeGFTOUxpOWVP?=
 =?utf-8?B?VXNOLzg3MEltV1pxRGVCOERLYVJYMU5PN1Z2NERRM01WTVhyMEFXRWpnNnZy?=
 =?utf-8?B?cURzcXVkd1dVU0ZGcDZodzlGTmI4R1J5WmdKUUlRK0dtNU9ORnUycEd1VFpY?=
 =?utf-8?Q?Pk38=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e67609d-faad-4153-589d-08daad64ffd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 21:50:52.6449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APuG4yZ7r2JvKcjHm8pPaa9WC0K/lcsk8n7r9xjlp65lm+piUldLcXsZ2g8Yzrtm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1355
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: odFhXIgp9hh-cK2zGXFm9dyn1VHWbAmk
X-Proofpoint-GUID: odFhXIgp9hh-cK2zGXFm9dyn1VHWbAmk
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=861 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130121
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gKyNkZWZpbmUgRlBVX0JZVEVTIDQwOTZVIC8qIGF2b2lkIGtlcm5lbF9mcHVfYmVnaW4v
ZW5kIHNjaGVkdWxlci9yY3Ugc3RhbGxzDQo+ICovDQo+IA0KPiBEZWNsYXJlIHRoaXMgaW5zaWRl
IHRoZSBmdW5jdGlvbiBpdCdzIHVzZWQgYXMgYW4gdW50eXBlZCBlbnVtLCBhbmQgZ2l2ZQ0KPiBp
dCBhIGJldHRlciBuYW1lLCBsaWtlIEJZVEVTX1BFUl9GUFUuDQoNCkkgYWdyZWUgdGhhdCdzIGEg
YmV0dGVyIG5hbWUsIGFuZCB3aWxsIHVzZSBzb21ldGhpbmcgbGlrZSB0aGF0IGRlcGVuZGluZw0K
b24gaG93IG90aGVyIGRpc2N1c3Npb25zIGdvLiBJIHdhcyB0cnlpbmcgdG8ga2VlcCBpdCBhcyBh
IG9uZS1saW5lIGNoYW5nZQ0Kd2l0aGluIDgwIGNoYXJhY3RlcnMsIGV4cGVjdGluZyBzb21lIGNo
dXJuIGJlZm9yZSBpdCdzIGZpbmFsaXplZC4NCg0K
