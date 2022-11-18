Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E83362FAD7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiKRQwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242441AbiKRQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:52:04 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAEA73414
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:52:03 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIGIpnh025017;
        Fri, 18 Nov 2022 16:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=d9KcazEnGtOkHfW2NuiZdju6zUUCwg7HRRqQBNS6g4A=;
 b=VwBAngbU9IyS6uBrpJ+k1MS5tO3F0Dx/z3HgrxgHx7ETl3VPdMtQVWNoI0wXYiygHB6U
 hcGN0Dajo3+0O5SJuJ/ZFBkWgNWlqUOFsiyn3nCK1iCbALQFZ7RuLP0E2EQFUKgIk9kx
 noP/i2GjjLLxqNkwK6j0ktwauq1jXtZlb1bUOf3q1BCbz5zlWedwSl5zDekuRglqpYvb
 GbGZv5z9RrFEl7R7hRQy5/5kj8AtGD8qWXQirtnqtRzCba1XQWT0Yuy+r6YYM3HMNCfL
 qB/9HRKKA2sHgcEfMPOUlZHuVTpy451akRJo0RBkFy3U0C/ubBmovY6nexa7ujzZLU7C dA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kxdf388jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 16:51:38 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id CBEE4809F65;
        Fri, 18 Nov 2022 16:51:36 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Nov 2022 04:51:27 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Nov 2022 04:51:27 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 18 Nov 2022 04:51:27 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 18 Nov 2022 04:51:27 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iv+J+PsXvY3WAoL0KpwNjIcSBBeADMo5YFcPaR01z/MUQRgrRN9q2FirnsFxL7h4o4FF5DcK9i9H263ThndCTK/Y6LUJZTNITUVcVg+wbs3KiecFlJMm+Yma2ZwzfVcrc4uCxXGNh9bAEfxfxLP8dgFSp5fDw223Ua51Tl0tCYBSCOMNv/eldb/9Ri3vhB8walB9QTcti907/TMKqbuauED/Y9Bxwem8mhpl7OJsZLwwEtpINH56Yy4T1CIc5L+g5azrP1p5u/u6p74bCn1J8HiJc3RrigHfoZX/DU0ikW4f4fIJjtKTYJ/XKMBK1IvX8c15uiXI275nxepE9++v0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9KcazEnGtOkHfW2NuiZdju6zUUCwg7HRRqQBNS6g4A=;
 b=nSZNv7sx7084MknD2KJl5cTWOYAD9U6mB4oIFaw0WotlNCKi/LtFN4hczvSLhPCVVJyDIjQeEPan/79EBCXI6vP4BE/NvFRCp30uDee/6ghZpZz37zhVqsvm1lRhg6eFLnOtfYLPJ/rJTiIClsjRY20zH78E1/Nm/fYZlRhrSHDrLMTeoz7FtGKHNIL/PXJqiagST6/+kCDsrMuCOvdI6Fw/GbGRg858/MjlB2fkZ32A6+KHZaIdj/Yw1CzD8zUdnKa/etd2UIgJ4zdo5bGXo6zA2J2J9eO5R3Z8PTJ5ws99thH4Lq+GZpZ7Fi4AXOGbRCqbKcKrtNa3cvHEIWtsXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW5PR84MB1793.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 16:51:26 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816%9]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 16:51:26 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     "phillip.lougher@gmail.com" <phillip.lougher@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: RE: BUG: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
Thread-Topic: BUG: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
Thread-Index: AQHY+tkr8ItBIzfpFEKMmsa4dEVn265EM28AgACwCvA=
Date:   Fri, 18 Nov 2022 16:51:26 +0000
Message-ID: <MW5PR84MB1842F7A2DD9A9948A647AC5DAB099@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <9697fcf5-4213-3d5e-176a-e82d4bd07870@alu.unizg.hr>
 <eac8af79-8936-f845-c8dd-c63ebf0d5e81@alu.unizg.hr>
 <02877aee-8c05-6534-8a91-94ba366d0276@squashfs.org.uk>
In-Reply-To: <02877aee-8c05-6534-8a91-94ba366d0276@squashfs.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW5PR84MB1793:EE_
x-ms-office365-filtering-correlation-id: 4764ecbb-3b6b-4883-123b-08dac98521eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: //aq5IZEFOZLb6uWScQOlcQY9NUGsA6pPGm10GKzhmhB8TcWZcSjpqYgSYJoonyJbClCoZGb0BK/w1BXLtRLwXmUSP4/VnFO1qBC/s0SiiETqWotRdv3Lxz9GCUp0sI4JT9vv07+ABn6So2xZDZJlaxOhpPiIi1KBC9UOV1I7oDE7ezEMOEA8s2D8d+Nq93aNOqmNmoqMVQu3R96p0DUIJeFuLu8hQ01AB15HhzqA6HmltsvzwWtLFiAFs1fjb9CaKB/HzFQu71pcpGQ5vvCydW7sozFBFeszMRfa/zjbAx7qhUQV0wcIe/Dq98Tnwu4J3PjQyIIq61sn/Bj+CsPuesdCoHvScoX/IhMarYQvDldxH1Ngfa/vau5CgKaDeJs8RRaI2dPozo/Y1lEvCz8oj5BPrfZKDNiKvrDHn+EnouYV/+KvHaBEXc5lw+UsN+7QNRDMsV+CnFdNbAMMkN87uYhPNWtFfRPW54hgvN7YjDy4x1P7q2HfGGEtbkkegTTG4gP3jb91baiv/reXBZyaBGOpR820geiTha/XnSL089uKsraXWHmMAoSeNml1CJucfcraXl1wg/uG9obo+0ofNXsu3PMf6KLBIJ4YP7+GRnu+TkLq/fEermDXbx31e3oPpYsfPc0meCdk8u7D4RzBHTyyHY35yRFwI7m7+WbVW0mRWslfAT/pe13Qy9nJhZZ+VxPf9KIuMqcshf0PKDwHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(33656002)(86362001)(38070700005)(2906002)(8936002)(5660300002)(52536014)(83380400001)(186003)(38100700002)(82960400001)(122000001)(110136005)(54906003)(316002)(478600001)(55016003)(76116006)(66946007)(66446008)(66476007)(66556008)(8676002)(4326008)(41300700001)(64756008)(6506007)(7696005)(9686003)(71200400001)(53546011)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFFPYkRqTURtT1o4NnFPR2FrZDAzOFJma0FSSktsZFY1UGd1cWxJQlh5UU1O?=
 =?utf-8?B?cE1NSlNxcmRDL2tiZGxUZEZxbHdTbmQ3b0REVWU0NlpzNENRd3NvVnh2SklB?=
 =?utf-8?B?NXI4QjZHNkRHdmo2eTZBVU5VM1FybGhxbnMyYnV3VXowU3JweUo4UXZaZDd3?=
 =?utf-8?B?azZiNUY3TUhyMGgvVmJmT1c1UytZRnN1VjBUK3JsRlZoN1BxSXhwTnRlTEZT?=
 =?utf-8?B?dktuM2w2Nlk2MXlZRTJTUHd2SG1zUVI5WFFOMDlMOVcvMjhvaktQTHdhdnMz?=
 =?utf-8?B?SHo3YTQrQ0FvUTYyTEFkTDVWeEVkM2hrS3BTbGgxalV1djE4elVoa0EraE1P?=
 =?utf-8?B?SjZwRmIwVEFEVWVSL2wxK29BMVBnYU1YcG9FV2xEUHcwcHFnMkFXcEk5aGFt?=
 =?utf-8?B?VS81eFFWSjNiTFpBV1I3QkowT0tjbU5NNHljMDFJUUdzV1FySWdvSzFVSXV1?=
 =?utf-8?B?SzRDMjNIL1h5UTRscUUyR29ZREd5eFFlbGhBNmgwQk40TjF3Tzl4Ry9Jemxj?=
 =?utf-8?B?bEpicEdTQUUxcS9xWGdhSWg0RDJHcGtaeGtaaGtoOXZ5alVlbTR3S0RSeVJw?=
 =?utf-8?B?TGkranFNZjFqYXdMNUxLNnovYUFtT2Z6ZXhxRVoyY0J0QlJTbDRlOFpRMnRv?=
 =?utf-8?B?OUVGeTlScHFOZGprOHY4SFpNaG1nVE9uTThpYXFidElRRHhWcGFNcmZrc1o5?=
 =?utf-8?B?dUNXcmJxVHRNeXhnMS8vamZQdHY4blNzN2VZQ0tFa050bGd1QXdEVXc2aE5K?=
 =?utf-8?B?UkM2clZnMzY4MDRyVjQ4aTNRM2xEdUFscFJGUDIzdVFWeEEveTNVZXlkWU4w?=
 =?utf-8?B?c3VnNStXWnAxRFc0L2hLUTNWaUFpd3cvR3liaUIwbFJBNVBEeE1PeFZFYS94?=
 =?utf-8?B?akozeXFmOUU4LzBJaXJxUUpkZ05sSXBQYlBwM3RtZ20rRk9YK0JmZmZNVjV5?=
 =?utf-8?B?WjZsUkNOOEZtcExlVnowc1lZYjZEN1VJdHFLMU03bTY5TE53WkdNdmZYTXA0?=
 =?utf-8?B?NDFZOVpoV0NkelBVMnhjUkNhb2d2d01kcTRMZ1ZGK0JSM0JveVcvKzlsUEFH?=
 =?utf-8?B?NExFdjkxZU4xZEpaWGx5aTRrTVZjMGZFQmZtTWRpR1laQXhaQldMQWdjY0Fk?=
 =?utf-8?B?bTk4eDVCSmJUenREbWNxY0ZWeDU0UlpWeUF1SHdZSHRxZlRXeUM0MnZaZnox?=
 =?utf-8?B?dG80RXRueG1LV0lHdzJ3R3NmdktQY1VucGdhaFh2OWxzY1BkNWYxbm1oOXV2?=
 =?utf-8?B?TkRrazlLaGIrQmpCdVExS1Q1NU5iVlJyMWkzUDcxZHJ3anRQamFtb3U5OFE2?=
 =?utf-8?B?NDh1cFJMSlJPelBCYzlOdzkwZDRKamhKSUdUQnZucld0SlBHcm9EK3EzQ2g1?=
 =?utf-8?B?VVQrNVlRR3IvMndkcUZJT2pIUkVFTVNvUTg0SWpNQXdmWWtrbDljcWp3MnZ4?=
 =?utf-8?B?bFNRU29WSGdxOFU2Vi8wcy9UbmYrV1UzanhpdENvL1NwVXNjK2E5Q3BnNEhN?=
 =?utf-8?B?V0R4ait3MnFrSGpSSzNHRFphWitjQ1RQcDRUVmMrTWQrQU01bTliUlp5TlVj?=
 =?utf-8?B?eC9CQU9XQnBERUJ5VDNnbkZJU0RyTlh6alVyNkpOTnFFbGxOUWZyN3R1TGs2?=
 =?utf-8?B?WmJSUkwyRFJ3Rm1qUm9JWVI2UG9JT2JXcGZ3OGdZSDZHRzN5WjJRdkN1dmkz?=
 =?utf-8?B?eDNHV2kxSGRuRjAzaThsekg1VlRta3hpdW1sdUFYOXNUYlhFSURrTUcwQTd3?=
 =?utf-8?B?M0dySWEvcTlrQ3BFY2ZqdmdQUUlGUTBuYUQ4dGEwM2cvQjl2SjVxNWp0V2dL?=
 =?utf-8?B?R0dYT0FNSE9aNmJNNitoK3ZPczZueFlKSjdzQmdvMGJ2MTBja0NkOXJMOHhP?=
 =?utf-8?B?SldveHdJaDI5LzBqamVtVUtmWS95K212QzA1OGVXVWR2YnhMUGsxczVldHZF?=
 =?utf-8?B?RWsyaWV3aUhKbG1xdUgxVmQ1cm1COWNzSnRFOWlBRHJFdWlKYit0aHVQMzlL?=
 =?utf-8?B?a09OSzR3ZGlCOHIrOUliQ2FPbXJLN1pud2xTMkRWWm54NVNCZFRremFIK1NM?=
 =?utf-8?B?M01KVjl6TDBQWkVRUk1LQkxvUTdmbys0L3VVR3RSZFVieXlsNVVKQzVTSHdW?=
 =?utf-8?Q?ys9A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4764ecbb-3b6b-4883-123b-08dac98521eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 16:51:26.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1L08VahqL6+K5ZKo2ozDYAY7PpQbOGCI6F3mglS7AKFQwZPYlgZDH+KiHtt63gT2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1793
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: aax9bz4U3OlvtT76kz9hCQIuK2fvvhpW
X-Proofpoint-ORIG-GUID: aax9bz4U3OlvtT76kz9hCQIuK2fvvhpW
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_04,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1011 spamscore=0 impostorscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=539 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGxpcCBMb3VnaGVy
IDxwaGlsbGlwQHNxdWFzaGZzLm9yZy51az4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxOCwg
MjAyMiAxMjoxMSBBTQ0KPiBUbzogTWlyc2FkIEdvcmFuIFRvZG9yb3ZhYyA8bWlyc2FkLnRvZG9y
b3ZhY0BhbHUudW5pemcuaHI+OyBMS01MIDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9y
Zz47IFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4NCj4gQ2M6IHBoaWxsaXAu
bG91Z2hlckBnbWFpbC5jb207IFRob3JzdGVuIExlZW1odWlzDQo+IDxyZWdyZXNzaW9uc0BsZWVt
aHVpcy5pbmZvPg0KPiBTdWJqZWN0OiBSZTogQlVHOiBpbiBzcXVhc2hmc194el91bmNvbXByZXNz
KCkgKFdhczogUkNVIHN0YWxscyBpbg0KPiBzcXVhc2hmc19yZWFkYWhlYWQoKSkNCj4gDQo+IE9u
IDE3LzExLzIwMjIgMjM6MDUsIE1pcnNhZCBHb3JhbiBUb2Rvcm92YWMgd3JvdGU6DQo+ID4gSGks
DQo+ID4NCj4gPiBXaGlsZSB0cnlpbmcgdG8gYmlzZWN0LCBJJ3ZlIGZvdW5kIGFub3RoZXIgYnVn
IHRoYXQgcHJlZGF0ZWQgdGhlDQo+ID4gaW50cm9kdWN0aW9uIG9mIHNxdWFzaGZzX3JlYWRhaGVh
ZCgpLCBidXQgaXQgaGFzDQo+ID4gYSBjb21tb24gZGVub21pbmF0b3IgaW4gc3F1YXNoZnNfZGVj
b21wcmVzcygpIGFuZA0KPiBzcXVhc2hmc194el91bmNvbXByZXNzKCkuDQo+IA0KPiBXcm9uZywg
dGhlIHN0YWxsIGlzIGhhcHBlbmluZyBpbiB0aGUgWFogZGVjb21wcmVzc29yIGxpYnJhcnksIHdo
aWNoDQo+IGlzICpub3QqIGluIFNxdWFzaGZzLg0KPiANCj4gVGhpcyByZXBvcnRlZCBzdGFsbCBp
biB0aGUgZGVjb21wcmVzc29yIGNvZGUgaXMgbGlrZWx5IGEgc3ltcHRvbSBvZiB5b3UNCj4gZGVs
aWJlcmF0ZWx5IHRocmFzaGluZyB5b3VyIHN5c3RlbS4gIFdoZW4gdGhlIHN5c3RlbSB0aHJhc2hl
cyBldmVyeXRoaW5nDQo+IHN0YXJ0cyB0byBoYXBwZW4gdmVyeSBzbG93bHksIGFuZCB0aGUgc3lz
dGVtIHdpbGwgc3BlbmQgYSBsb3Qgb2YNCj4gaXRzIHRpbWUgZG9pbmcgcGFnZSBJL08sIGFuZCB0
aGUgQ1BVIHdpbGwgc3BlbmQgYSBsb3Qgb2YgdGltZSBpbg0KPiBhbnkgQ1BVIGludGVuc2l2ZSBj
b2RlIGxpa2UgdGhlIFhaIGRlY29tcHJlc3NvciBsaWJyYXJ5Lg0KPiANCj4gU28gdGhlIGZhY3Qg
dGhlIHN0YWxsIGlzIGJlaW5nIGhpdCBoZXJlIGlzIGEgc3ltcHRvbSBhbmQgbm90DQo+IGEgY2F1
c2UuICBUaGUgZGVjb21wcmVzc29yIGNvZGUgaXMgbGlrZWx5IHJ1bm5pbmcgc2xvd2x5IGR1ZSB0
bw0KPiB0aHJhc2hpbmcgYW5kIHdhaXRpbmcgb24gcGFnZWQtb3V0IGJ1ZmZlcnMuICBUaGlzIGlz
IG5vdCBpbmRpY2F0aXZlDQo+IG9mIGFueSBidWcsIG1lcmVseSBhIHN5c3RlbSBydW5uaW5nIHNs
b3dseSBkdWUgdG8gb3ZlcmxvYWQuDQo+IA0KPiBBcyBJIHNhaWQsIHRoaXMgaXMgbm90IGEgU3F1
YXNoZnMgaXNzdWUsIGJlY2F1c2UgdGhlIGNvZGUgd2hlbiB0aGUNCj4gc3RhbGwgdGFrZXMgcGxh
Y2UgaXNuJ3QgaW4gU3F1YXNoZnMuDQo+IA0KPiBUaGUgcGVvcGxlIHJlc3BvbnNpYmxlIGZvciB0
aGUgcmN1IGNvZGUgc2hvdWxkIGhhdmUgYSBsb3QgbW9yZSBpbnNpZ2h0DQo+IGFib3V0IHdoYXQg
aGFwcGVucyB3aGVuIHRoZSBzeXN0ZW0gaXMgdGhyYXNoaW5nLCBhbmQgaG93IHRoaXMgd2lsbA0K
PiB0aHJvdyB1cCBmYWxzZSBwb3NpdGl2ZXMuICBJbiB0aGlzIEkgYmVsaWV2ZSB0aGlzIGlzIGFu
IGluc3RhbmNlIG9mDQo+IHBlcmZlY3RseSBjb3JyZWN0IGNvZGUgcnVubmluZyBzbG93bHkgZHVl
IHRvIHRocmFzaGluZyBpbmNvcnJlY3RseQ0KPiBiZWluZyBmbGFnZ2VkIGFzIGxvb3BpbmcuDQo+
IA0KPiBDQydpbmcgUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BrZXJuZWwub3JnPg0KPiANCj4g
UGhpbGxpcA0KDQpIb3cgYmlnIGNhbiB0aGVzZSByZWFkYWhlYWQgc2l6ZXMgYmU/IFNob3VsZCBv
bmUgb2YgdGhlIGxvb3BzIGluY2x1ZGUNCmNvbmRfcmVzY2hlZCgpIGNhbGxzPw0KDQo=
