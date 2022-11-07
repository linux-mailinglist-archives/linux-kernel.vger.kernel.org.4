Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C979661FFA4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiKGUia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiKGUi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:38:27 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B6B21B4;
        Mon,  7 Nov 2022 12:38:25 -0800 (PST)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7KWFBY005263;
        Mon, 7 Nov 2022 20:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=fw7bK/Jyqd3qpUzcxqDmHZ8HYwnyiN8uW5STOTPwp3A=;
 b=nhTD0M+gQGuKA7s4ZGqWXvtEnDS/oKfZ6iiWUV2E1irbGx9Yho1RMdPXYZKmj6ls2MoP
 lsfBAVlVlmsKKWdqezewavlVvhfsR264FWrMfOfinqlIQGzTotOh5HDQH8aKY4S/TGBA
 sMhq6mK41nnwON2lDi0N9veV9aC8Zbay+TiizOR8/HpYeGV1ILfsnDIEflq/ABO8Phpw
 QvESEWbUEdRyWe212QTE1x838ZEZDg9c9O5iEUkv7Z559Sj4LHVvJ0mLwcAG+rKNH4ae
 mXstiinICmlBZkaZF6W+NHXru+ZhyPIZEk4olC+r+yazsE/quuZB08DJQt9W2plaZCHF PA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kq4hdaj06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 20:38:05 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 0B06C80471E;
        Mon,  7 Nov 2022 20:38:03 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Nov 2022 08:38:03 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Nov 2022 08:38:02 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 7 Nov 2022 08:38:02 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Nov 2022 08:38:02 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdnZpmm81n+WZmKVF2e01ZKSmw+rI0LyOvL9mWK7uU9hpaAC60/d8yPekvA+T4nZNlqH1W47YrMz7DYwH/8gfppU1t6YNZki4vxemPZ4Mm2hmZfbHGtbXl4OcuEl/iUzbaq52mKTk41i8vE8XM/HWgFYvK7YZS9GJMFz7SvPgb/PhXE+TThRJPoAvB+zQCk0UNbgTPg4oa8VF9pI+bEPHOAEKl0GoGZXp8dm4+bXy3Tkk59loyca5GsAVoX0JyWNlrEEe60fRTfL5KQNJNa6ZgkfvIw6Za5WaCsqFYmOPfRAISVei2EnBPn4CiOvh+6eczzA9EsFtKd+M8ygcD7/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw7bK/Jyqd3qpUzcxqDmHZ8HYwnyiN8uW5STOTPwp3A=;
 b=LGt5bjfg+UY/5PqIb+hEd8IfSGYoUzWC9AUik5f7+/ChS7iZ3A0+5EW5skjA8AJKfpg/kbv8zMvDfgIttwC2QxqfzLS3Vt0RI52/x0CCmqjdWgSEph6rl4+0R4mSdYGF8aXhTQ0OmRCK1xhd2Iv8JlGMEFZGqqJt7LHlMeKhJ/OlXU2SL64O2zq7tHqDiaJ2WklfDZRhoG5r9EfPIy6pVbLpOBgs33OVPy5vb931QBs8S381ht1beawN+eu8fOwAof3NpMRMuCq5A44spZORReyUD2flFPXjcFWbjJOD8SisOaXastEL2MIX8PkLfRYdtcappsBR1pmHtSUUlV30LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH7PR84MB1368.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:152::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 20:38:01 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22%7]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 20:38:01 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
Thread-Topic: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
Thread-Index: AQHY7/L6iCQl4en4NUitoR4cceQrK64vgODwgAFDcoCAAejvYIAAsLcAgACPb1A=
Date:   Mon, 7 Nov 2022 20:38:01 +0000
Message-ID: <MW5PR84MB18427CB2FF17CE0D91BE9944AB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221104021224.102-1-thunder.leizhen@huawei.com>
 <20221104021224.102-5-thunder.leizhen@huawei.com>
 <MW5PR84MB18425CBD1259317004F7771AAB3A9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <20221105200637.GC28461@paulmck-ThinkPad-P17-Gen-1>
 <MW5PR84MB1842933AB81EECFAF2ECCE7DAB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <5133bd4b-c17f-f5ed-eae2-fe2d199dc5db@huawei.com>
In-Reply-To: <5133bd4b-c17f-f5ed-eae2-fe2d199dc5db@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH7PR84MB1368:EE_
x-ms-office365-filtering-correlation-id: 404a403e-43a6-4850-f4fc-08dac0fff690
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dPSUYT0M7Nxhd2WUdgJQZPF7PSHibak/2ecKgHf+tLI4D81h/JnCh39SWVAQbuI1fQHbdQUVNYI6Q0GrJEdD/pYcuvCG03VhLA3kcAreU7I73qbzq/bfbcAgAwAHtHIKqudMeVY1wJkw9BMVQHccTM/cFbOstUFbxVBgufSebh7HrYjXgv8wmWX4zLWKEAtstBaljjPpozT8eSGAioUU6pcm7YDAosp8XGix5gxrnXlm8LITO3OGTeKypWMSHSeBvPYxKey7/I6VCPhSCDGyEcmlPC114i083Bv4HEpDodp4fATnPa9/MIVw+14cv+1r1HgI3hO/mfFd203rynaScf54Hnf/knPbtazcFARdhSTuZZ3jhYCreB3TCq6MP6M9/bwb2ck0sQLfvuERBvHVUZBc0dd2gKhpgvvgoITqVOPILk/qSEavJ+0XgkI7Azb5GnDTv8m93+uLwYFVO1hcx7yQRA/o67GN5icUTisd9m2lqx4f1rIheQdk1VPRDEP3+ncHeCVYIeXRSKFi9tgwW26xtgYRagP1bkWcHrBuy2kJyWQqQ7ZbXKukWbXKuKJPo7duZyX9JzB8+x+TsivHyCfomoqZnA3wIwwhcdoEDWoCyTM6goMmGrDRRLOE0KIVkM4hSWvGIfyw7XyT/wHLQcvlFi6gqKMwgJfnu43iGBnGZ7F4l3IWBreUQjoI/2i/0GWYo/B7llu7OVNQldHp9/fI3BwqXswnQpOzFgfKoHz6fq4mZuYP84czzr2Qh8/fjpWiEmw/9DM70j5TueDXcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199015)(33656002)(86362001)(82960400001)(38070700005)(2906002)(7416002)(55016003)(186003)(7696005)(6506007)(83380400001)(122000001)(26005)(9686003)(66446008)(66556008)(66946007)(64756008)(316002)(54906003)(8676002)(66476007)(478600001)(110136005)(4326008)(8936002)(76116006)(71200400001)(5660300002)(38100700002)(52536014)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlpkeE45R2liVS9wdWFsZyt4SVhQRkpiR29CV01PUTBnenlHbzZHNEFIZ00w?=
 =?utf-8?B?WHEvb3dHVlJEeStTUlVsTGJZb3dyblUrKzVwRmNLaXRMb2RhVjJONEQrUUlC?=
 =?utf-8?B?cWlMQmZvOWdHZ0JIV2s1eG5xaGdxaVY0S3JYZURwbnpTdUcvNjMxTnhwSWZn?=
 =?utf-8?B?YnJXOGRHeUltdnVDTi9rbmpySHUydnk4dGd1UGJYMFg4L1l3TERiNmVtUDhK?=
 =?utf-8?B?Q1VzcEttZFlMMUp4ZU1Bem5OQlFEUzNtUERRNmJieGNMaHR4Uy9JV1ZaTDlu?=
 =?utf-8?B?K2pObUJ0ZTFuRElRK2JmSWpVbmdhZXZPMmQyUXZjcWR2TEJFeTNiVjRSWmVv?=
 =?utf-8?B?MVRaRHlXL1VvK0FlYTJjZmhaK0ZGWXRqWGRZSUJ1Tkt0RjVpaWVERFY3bm04?=
 =?utf-8?B?K0lpME5lbkxXdmwzZWtrbVJtdVgrMVY2T2FIL1V1empBc0hoTFAzWThVNVRL?=
 =?utf-8?B?NEdtbEs4M2k4T293TEl0ZTFXYnhaMytFNE94T21qK2hHanR6cW1jSk9BR2JF?=
 =?utf-8?B?bFV4QU5QckJ6S09IRDhtZjZ0aS9UZ3c5SDN2YXRrbHZacjhFb3hUOTJkVHpk?=
 =?utf-8?B?eCtYaTM5dkVMN3p0d1FJL3ZZem43RDlLZXMyaVgvRlkzZTV6OFM4VllnYUpZ?=
 =?utf-8?B?cWxISTZ6d2JWUytJaXViQTZ0bmpTK2dCRG5WNk51U25QUjZYSHphMHFHMFov?=
 =?utf-8?B?eGhwWnhWUkpSdnA5aHBPSmEzM1p3TlphMm9ZWVNRZFBaTUgwVUVRTElFQWN1?=
 =?utf-8?B?Z2RTTEdkMFNYQWNXMW4yUkFucllUaS9ZSFhJSkdWd1Q0bHN6NTA1VjlDODdM?=
 =?utf-8?B?bFRnUWphYWIySWFYWXhwNTVEdXFkN2FXMkdXeW1TWVpUQVFqTVBCZjlNVDgz?=
 =?utf-8?B?ekVhSnlKWGx6VlJNZHBXZzBJRks5eVZSYU5kS0FEREp5VUJGZ0U1MklBaWor?=
 =?utf-8?B?TnhqNkU0dlZGTFpFVzZVUzdLSHBRbnFOSG9LS1lYczBKU1pvRFNpLzdQMUhE?=
 =?utf-8?B?V2daOXVSYVQySEJoMlUzRVhQeXRPMFJCRVhzV29HU2dwY21QQS8wZlcyVXVX?=
 =?utf-8?B?RjlUQnVNcGEwbnVZdFNQRDM2M2c0SWk5UXNNMVBWWXVMbDAxSTVma21IL1hv?=
 =?utf-8?B?dmQ5SHBxcXdWTllRc0paZmoxMWcxQjZFS3psa09MeUxJWng2Y0xvTEdHdURS?=
 =?utf-8?B?ZGM4WENDWnd5T2xDT0RnWW5IM1JRa2V5dHRhSWVKUWFGc1UyaGFOV2ZVYTVU?=
 =?utf-8?B?K3ZmUS94WHRaUGNXYW9YQjhTN3QycFkrSTZvaWEvbXJGOXN2WVhwKytBQ3BZ?=
 =?utf-8?B?TWMxbFkvQ1hmUkQxdmpaQmJqZWpIcjJMNDA1SEx4azZWbjE4bjVtQncxSFRu?=
 =?utf-8?B?VHdqbmZuKzhwTWhmcE9OUHhybXhXY1BpcDk2cTdNVndkbi9BSTlEbXlNS0w2?=
 =?utf-8?B?OE5WUUxrUDdhUDJHWVRnL1RZb2ErTFZmRmVIUCs4SnFla3laRy9jQjBmanZt?=
 =?utf-8?B?aWRoRnpEK215cThaN2pJLzBoSTVLb2VjdGU2c2lSaWhlUFRQdUpIRkk3anRy?=
 =?utf-8?B?Y2JkN05SaU9nMU5VZUMzbEhOLzZQKzFhclh0eWd0Z1kyWnFjQjZIaC9Ndm12?=
 =?utf-8?B?a09XaTZPK05CUjRBbEJPVHlOcFdyUDBoYUdpeXc5bXNtankxbDBJK3VWcThx?=
 =?utf-8?B?SktKankvYThnOXFpc092K1VCYlB0bnRJOG9sVW95YmhieVA2U3lkZE9IZHg4?=
 =?utf-8?B?RkphaVRuU2d0SU1Jc1VaL2Nxd2l3Y0pybWN1aEZhQW9Lc041YnpJSHpNNWRz?=
 =?utf-8?B?WFR4Z1RVa3BQR2s0L3BDQzBWbHM3cDNpWDNBSWxoNUEvVTl3UU9mSjRSZWx1?=
 =?utf-8?B?SkdBY2Q4ZFJQeFJVTjYxK0hlenNTUUNaRTdCRzJoRXA4blNtN2ZXWWJNRjRx?=
 =?utf-8?B?NUlxS083dmdDOXhCMDJaWW9BaE5DdS9vZkZBRTA4aS9WeWtnYjRWelRKR09n?=
 =?utf-8?B?aXhybkpVZ3FHVkpFTVdHbHVya2NvRW5UVFFIbURENDdWY0lBVXU1SjdTd2NP?=
 =?utf-8?B?V3l0L3hvMG0vamZuVzhpZEdpVkJxKzVlMFZ5WnVhWUgvTEo2VWhIcFkvbTVw?=
 =?utf-8?Q?5Ryk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 404a403e-43a6-4850-f4fc-08dac0fff690
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 20:38:01.1609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Si3mR2UvVHqDquKZM10OayaaZBrpZ9XjyrtZ6Z4mONQ8YjZng1v/a896uVrZFtQD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1368
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: D8p0vUeQL5mRy8CVCDMsAv4WtSxJ8U5d
X-Proofpoint-ORIG-GUID: D8p0vUeQL5mRy8CVCDMsAv4WtSxJ8U5d
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070161
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPiBNYXliZSB0aGlzIHNob3VsZG4ndCBiZSBhIHRhYmxlPyBNYWtlIGl0IGdyZXAtZnJp
ZW5kbHk6DQo+ID4gWyAxODE2LjcxOTkyMl0gcmN1OiBoYWxmLXRpbWVvdXQgY291bnRzOiBoYXJk
aXJxID01IHNvZnRpcnE9MTAgY3N3PTANCj4gPiBbIDE4MTYuNzI1NjQzXSByY3U6IGhhbGZfdGlt
ZW91dCBjcHV0aW1lcyAobXMpOiB0aW1lPTE1MDAgaGFyZGlycT0zDQo+IHNvZnRpcnE9MCBzeXN0
ZW09MTQ5Mg0KPiANCj4gSSBwcmVmZXIgdGhlIHRhYmxlLiBUYWJsZSBsb29rIGNsZWFyZXIgYW5k
IGVhc2llciB0byBjb21wYXJlLg0KDQpIZXJlJ3MgYW4gZXhhbXBsZSB3aGVyZSBpdCBhbHNvIHRy
aWdnZXJzIGV4cGVkaXRlZCBzdGFsbHMuIFRoZSANCnNlbGYtZGV0ZWN0ZWQgc3RhbGwgcHJpbnRz
IGluY2x1ZGluZyB0aGUgbmV3IHRhYmxlIGNhbiBlbmQgdXANCmludGVybGVhdmVkIHdpdGggdGhl
IGV4cGVkaXRlZCBzdGFsbCBwcmludHMuDQoNCih0aGUgdGFibGUgaXMgZXhwYW5kZWQgYSBiaXQg
aGVyZSB0byBleHBlcmltZW50IHdpdGggYWRkaW5nIG1vcmUgaW5mbywgDQphbmQgSSBpbmNsdWRl
ZCB0aGUgXHQgcHJlZml4ZXMpDQoNClsgIDkzMy43MjgwMzJdIHRjcnlwdDogcmN1IHRlc3Rpbmcg
LSBrZXJuZWxfZnB1X2Rpc2FibGUgZm9yIHJ1ZGUgNiBzDQpbICA5MzguMDM4Mjc4XSByY3U6IElO
Rk86IHJjdV9wcmVlbXB0IGRldGVjdGVkIGV4cGVkaXRlZCBzdGFsbHMgb24gQ1BVcy90YXNrczog
eyA0Ni0uLi4uIH0gNCBqaWZmaWVzIHM6IDUyMSByb290OiAweDgvLg0KWyAgOTM4LjA0OTE1MV0g
cmN1OiBibG9ja2luZyByY3Vfbm9kZSBzdHJ1Y3R1cmVzIChpbnRlcm5hbCBSQ1UgZGVidWcpOiBs
PTE6NDItNTU6MHgxMC8uDQpbICA5MzguMDU3MjM2XSBTZW5kaW5nIE5NSSBmcm9tIENQVSAzNSB0
byBDUFVzIDQ2Og0KWyAgOTM4LjA2MjA0OF0gTk1JIGJhY2t0cmFjZSBmb3IgY3B1IDQ2DQpbICA5
MzguMDYyMDUwXSBDUFU6IDQ2IFBJRDogNDQxODQgQ29tbTogbW9kcHJvYmUgTm90IHRhaW50ZWQg
Ni4wLjArICMxMQ0KWyAgOTM4LjA2MjA1Ml0gSGFyZHdhcmUgbmFtZTogSFBFIFByb0xpYW50IERM
MzYwIEdlbjEwL1Byb0xpYW50IERMMzYwIEdlbjEwLCBCSU9TIFUzMiAwMy8wOC8yMDIyDQpbICA5
MzguMDYyMDUzXSBSSVA6IDAwMTA6cnVkZV9zbGVlcF9jeWNsZXMrMHgxMy8weDI3IFt0Y3J5cHRd
DQouLi4NClsgIDkzOC4wNjIxNTFdICA8L1RBU0s+DQpbICA5MzguMDczMjc3XSByY3U6IElORk86
IHJjdV9wcmVlbXB0IGRldGVjdGVkIGV4cGVkaXRlZCBzdGFsbHMgb24gQ1BVcy90YXNrczogeyA0
Ni0uLi4uIH0gMjg5IGppZmZpZXMgczogNTIxIHJvb3Q6IDB4OC8uDQpbICA5MzguMzM0MjkyXSBy
Y3U6IGJsb2NraW5nIHJjdV9ub2RlIHN0cnVjdHVyZXMgKGludGVybmFsIFJDVSBkZWJ1Zyk6IGw9
MTo0Mi01NToweDEwLy4NClsgIDkzOC4zNDIyODldIFNlbmRpbmcgTk1JIGZyb20gQ1BVIDM1IHRv
IENQVXMgNDY6DQpbICA5MzguMzQ3MDQ5XSBOTUkgYmFja3RyYWNlIGZvciBjcHUgNDYNClsgIDkz
OC4zNDcwNTBdIENQVTogNDYgUElEOiA0NDE4NCBDb21tOiBtb2Rwcm9iZSBOb3QgdGFpbnRlZCA2
LjAuMCsgIzExDQpbICA5MzguMzQ3MDUxXSBIYXJkd2FyZSBuYW1lOiBIUEUgUHJvTGlhbnQgREwz
NjAgR2VuMTAvUHJvTGlhbnQgREwzNjAgR2VuMTAsIEJJT1MgVTMyIDAzLzA4LzIwMjINClsgIDkz
OC4zNDcwNTJdIFJJUDogMDAxMDpydWRlX3NsZWVwX2N5Y2xlcysweDEzLzB4MjcgW3RjcnlwdF0N
Ci4uLg0KWyAgOTM4LjM0NzEyMV0gIDwvVEFTSz4NClsgIDkzOC4zNTgyNzVdIHJjdTogSU5GTzog
cmN1X3ByZWVtcHQgZGV0ZWN0ZWQgZXhwZWRpdGVkIHN0YWxscyBvbiBDUFVzL3Rhc2tzOiB7IDQ2
LS4uLi4gfSA1NzMgamlmZmllcyBzOiA1MjEgcm9vdDogMHg4Ly4NClsgIDkzOC42MTkxODJdIHJj
dTogYmxvY2tpbmcgcmN1X25vZGUgc3RydWN0dXJlcyAoaW50ZXJuYWwgUkNVIGRlYnVnKTogbD0x
OjQyLTU1OjB4MTAvLg0KWyAgOTM4LjYyNzE3OV0gU2VuZGluZyBOTUkgZnJvbSBDUFUgMzUgdG8g
Q1BVcyA0NjoNClsgIDkzOC42MzE5MzldIE5NSSBiYWNrdHJhY2UgZm9yIGNwdSA0Ng0KWyAgOTM4
LjYzMTkzOV0gQ1BVOiA0NiBQSUQ6IDQ0MTg0IENvbW06IG1vZHByb2JlIE5vdCB0YWludGVkIDYu
MC4wKyAjMTENClsgIDkzOC42MzE5NDFdIEhhcmR3YXJlIG5hbWU6IEhQRSBQcm9MaWFudCBETDM2
MCBHZW4xMC9Qcm9MaWFudCBETDM2MCBHZW4xMCwgQklPUyBVMzIgMDMvMDgvMjAyMg0KWyAgOTM4
LjYzMTk0Ml0gUklQOiAwMDEwOnJ1ZGVfc2xlZXBfY3ljbGVzKzB4MTMvMHgyNyBbdGNyeXB0XQ0K
Li4uDQpbICA5MzguNjMxOTk3XSAgPC9UQVNLPg0KWyAgOTM4LjY0MzI3Ml0gcmN1OiBJTkZPOiBy
Y3VfcHJlZW1wdCBkZXRlY3RlZCBleHBlZGl0ZWQgc3RhbGxzIG9uIENQVXMvdGFza3M6IHsNClsg
IDkzOC43MzQyNjddIHJjdTogSU5GTzogcmN1X3ByZWVtcHQgc2VsZi1kZXRlY3RlZCBzdGFsbCBv
biBDUFUNClsgIDkzOC43NDAxMTFdICA0Ni0uLi4uDQpbICA5MzguNzQ3MjgyXSByY3U6ICAgICA0
Ni0uLi4uOiAoNDk0OCB0aWNrcyB0aGlzIEdQKSBpZGxlPWE5Y2MvMS8weDQwMDAwMDAwMDAwMDAw
MDAgc29mdGlycT03NTk4Lzc1OTggZnFzPTEyNTMNClsgIDkzOC43NDcyODVdIHJjdTogICAgICAg
ICAgICAgICBoYXJkaXJxcyAgIHNvZnRpcnFzICAgICAgICAgIGNzdyAgICAgc3lzdGVtIGNvbmRf
cmVzY2hlZA0KWyAgOTM4Ljc0NzI4Nl0gcmN1OiAgICAgIG51bWJlcjogICAgICAgIDAgICAgICAg
ICAgMCAgICAgICAgICAgIDAgICAgICAgICAgICAgICAgICAgICAgMA0KWyAgOTM4Ljc1NDQ2MV0g
IH0gNzIwIGppZmZpZXMgczogNTIxIHJvb3Q6IDB4OC8uDQpbICA5MzguNzU3MTc4XSByY3U6ICAg
ICBjcHV0aW1lOiAgICAgICA2MiAgICAgICAgICAwICAgICAgICAgICAgICAgICAgICAgMjQzNiAg
ICAgICAgICAgICAgPT0+IDI1MDAgKG1zKQ0KWyAgOTM4Ljc1NzE3OV0gcmN1OiAgICAgY3VycmVu
dDogaW5fa2VybmVsX2ZwdV9iZWdpbj0xIHRoaXNfY3B1X3ByZWVtcHRpYmxlPTANClsgIDkzOC43
NTcxODFdICAodD01MDIzIGppZmZpZXMgZz02MTA1MyBxPTcwNCBuY3B1cz01NikNClsgIDkzOC43
NTk2NDBdIHJjdTogYmxvY2tpbmcgcmN1X25vZGUgc3RydWN0dXJlcyAoaW50ZXJuYWwgUkNVIGRl
YnVnKToNCg0KVGhlIGZpcnN0ICI0Ni0iIGxpbmUgaXMgZnJvbSB0aGUgZXhwZWRpdGVkIHN0YWxs
Lg0KVGhlIHNlY29uZCAiNDYtIiBsaW5lIGlzIGZyb20gdGhlIHNlbGYtZGV0ZWN0ZWQgc3RhbGwu
DQpUaGUgdGFibGUgbGluZXMgYXJlIGZyb20gdGhlIHNlbGYtZGV0ZWN0ZWQgc3RhbGwuDQpUaGUg
In0gNzIwIiBsaW5lIGlzIGZyb20gdGhlIGV4cGVkaXRlZCBzdGFsbC4NClRoZSAiKHQ9NTAyMyIg
bGluZSBpcyBmcm9tIHRoZSBzZWxmLWRldGVjdGVkIHN0YWxsLg0KVGhlICJibG9ja2luZyIgbGlu
ZSBpcyBmcm9tIHRoZSBleHBlZGl0ZWQgc3RhbGwuDQoNClsgIDkzOC43NjE3NDVdIENQVTogNDYg
UElEOiA0NDE4NCBDb21tOiBtb2Rwcm9iZSBOb3QgdGFpbnRlZCA2LjAuMCsgIzExDQpbICA5Mzgu
NzYxNzQ3XSBIYXJkd2FyZSBuYW1lOiBIUEUgUHJvTGlhbnQgREwzNjAgR2VuMTAvUHJvTGlhbnQg
REwzNjAgR2VuMTAsIEJJT1MgVTMyIDAzLzA4LzIwMjINClsgIDkzOC45ODIxMThdIFJJUDogMDAx
MDpydWRlX3NsZWVwX2N5Y2xlcysweDEzLzB4MjcgW3RjcnlwdF0NCi4uLg0KWyAgOTM5LjIyMTgz
M10gIDwvVEFTSz4NClsgIDkzOS4yMjQyMzldICBsPTE6NDItNTU6MHgxMC8uDQpbICA5MzkuMjI3
NDQwXSBTZW5kaW5nIE5NSSBmcm9tIENQVSAzNSB0byBDUFVzIDQ2Og0KWyAgOTM5LjIzMjIwNF0g
Tk1JIGJhY2t0cmFjZSBmb3IgY3B1IDQ2DQpbICA5MzkuMjMyMjA1XSBDUFU6IDQ2IFBJRDogNDQx
ODQgQ29tbTogbW9kcHJvYmUgTm90IHRhaW50ZWQgNi4wLjArICMxMQ0KWyAgOTM5LjIzMjIwNl0g
SGFyZHdhcmUgbmFtZTogSFBFIFByb0xpYW50IERMMzYwIEdlbjEwL1Byb0xpYW50IERMMzYwIEdl
bjEwLCBCSU9TIFUzMiAwMy8wOC8yMDIyDQpbICA5MzkuMjMyMjA3XSBSSVA6IDAwMTA6cnVkZV9z
bGVlcF9jeWNsZXMrMHgxMy8weDI3IFt0Y3J5cHRdDQouLi4NClsgIDkzOS4yMzIyNjJdICA8L1RB
U0s+DQpbICA5MzkuMjQzMjY0XSByY3U6IElORk86IHJjdV9wcmVlbXB0IGRldGVjdGVkIGV4cGVk
aXRlZCBzdGFsbHMgb24gQ1BVcy90YXNrczogeyA0Ni0uLi4uIH0gMTQ1OCBqaWZmaWVzIHM6IDUy
MSByb290OiAweDgvLg0KWyAgOTM5LjUwMzkyNl0gcmN1OiBibG9ja2luZyByY3Vfbm9kZSBzdHJ1
Y3R1cmVzIChpbnRlcm5hbCBSQ1UgZGVidWcpOiBsPTE6NDItNTU6MHgxMC8uDQpbICA5MzkuNTEx
OTIwXSBTZW5kaW5nIE5NSSBmcm9tIENQVSAzNSB0byBDUFVzIDQ2Og0KWyAgOTM5LjUxNjY3OF0g
Tk1JIGJhY2t0cmFjZSBmb3IgY3B1IDQ2DQpbICA5MzkuNTE2Njc5XSBDUFU6IDQ2IFBJRDogNDQx
ODQgQ29tbTogbW9kcHJvYmUgTm90IHRhaW50ZWQgNi4wLjArICMxMQ0KWyAgOTM5LjUxNjY4MF0g
SGFyZHdhcmUgbmFtZTogSFBFIFByb0xpYW50IERMMzYwIEdlbjEwL1Byb0xpYW50IERMMzYwIEdl
bjEwLCBCSU9TIFUzMiAwMy8wOC8yMDIyDQpbICA5MzkuNTE2NjgwXSBSSVA6IDAwMTA6cnVkZV9z
bGVlcF9jeWNsZXMrMHgxMy8weDI3IFt0Y3J5cHRdDQouLi4NClsgIDkzOS41MTY3MzJdICA8L1RB
U0s+DQpbICA5MzkuNTI4MjYzXSByY3U6IElORk86IHJjdV9wcmVlbXB0IGRldGVjdGVkIGV4cGVk
aXRlZCBzdGFsbHMgb24gQ1BVcy90YXNrczogew0KWyAgOTM5Ljc0ODU4Nl0gaW5pdGNhbGwgdGNy
eXB0X21vZF9pbml0KzB4MC8weDEwMDAgW3RjcnlwdF0gcmV0dXJuZWQgLTExIGFmdGVyIDYwMjA2
MjMgdXNlY3MNClsgIDkzOS43NTMyMDBdICA0Ni0uLi4uIH0gMTcxOCBqaWZmaWVzIHM6IDUyMSBy
b290OiAweDgvLg0KWyAgOTM5Ljc5MTU4MF0gcmN1OiBibG9ja2luZyByY3Vfbm9kZSBzdHJ1Y3R1
cmVzIChpbnRlcm5hbCBSQ1UgZGVidWcpOg0KDQoNCg==
