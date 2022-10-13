Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687FC5FE52F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJMWU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJMWU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:20:56 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD2F18983E;
        Thu, 13 Oct 2022 15:20:54 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DKrGWX016170;
        Thu, 13 Oct 2022 22:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=aQCMJ0MkaWGugb8WrKPNWBiCcvxPgoMM4skXzBaIpUY=;
 b=P6M973fTarR2MtYiuKvPfnwzTRamb72maJkEVHut2/3OS4m1TcCCAcsaL0h25Izd275D
 z1172Xi8mqHgTvLZlac3i0ugolCmgeepzcyCHrH/Lv5Q6W4uG9cIHBV7saHPqkneJm38
 18RaOEMe32QOBS4ItaXVhBb0BxZz6Nar/E23jV/1+5RkvZjHNsrqs6suS1icHv6RYxgD
 98GhU4O4Ei3Uhwo3S7Jg8Ix83xi0LPz0rNunGAb17TpRfnP+h4wvZ59bmTvhm82L1gou
 5qex3k+AuoFjUANBR0vEawqsEiyqPcLjk42dD8zA5C+t5sapZZKVKXIzm6pHDz2jfWfu pg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k6qhn1x0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 22:20:37 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id AD8E5D25E;
        Thu, 13 Oct 2022 22:20:35 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 10:20:33 -1200
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 10:20:33 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 13 Oct 2022 10:20:33 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 13 Oct 2022 22:20:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LX1QcS1gZ4iQKhkHbLc3iaBQJp/w2WYvO2eh826nel306po/FBF8A+patv6P1MH18QsRv4rzh6mCfM4JCSJTBM8E2Ews7S1cwgMdr5+F1J7mzqtvSfSkYEXyNiA38QKhYsj7IDJiVRtrQCZWhijTckKqwkkVOlB3C5hypTh7jTpRUc4suMYsmbrecoDXaBpRFWaVH8Fz133q5Q3lRcaDbo48AFwMPrAMJuwN5bLMqkTiJ5mqQVwTeFWEMzYvUaK5G6nMJIgsf/Ptn83SDPugSb0xTE4NJjndK/d3FhCPA6ymuRHdg3ecpFlKuAp33r8Rotn47PHRXLMoqpHYCLqa7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQCMJ0MkaWGugb8WrKPNWBiCcvxPgoMM4skXzBaIpUY=;
 b=TmhUyCMdSmRfdRpDMPLbXeJfZGKpZyyzdHy2NIgcT4sXD3kjn090xKDRADk5qrIOAT2VyybVqNJP+Jal8H8mfHF7Kli/vtolh/InwwjE9UxR0BN7LKKqqXulQcbyF5TnqjC9caNURueIDTRGUueQUirNsxYJcTZ3fG1tqSD09j5BA05tTSjF+5z3+KZUKuBjFc9sEXse6mnkyn0vxGMNdQ9YLU5+lMzmhua+PplHORabISEBhQIyecu9YKUUWj/xJPaYqTQUCdLVFk7I8kd+xqjG6TXRY9Itdlqo/TB6I29Phq2nqP3JawqhW+HRQlC2IC/EWhXteL5MXShF4/F2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH7PR84MB1535.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:152::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 22:20:30 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 22:20:31 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 18/19] crypto: x86 - standardize not loaded prints
Thread-Topic: [PATCH v2 18/19] crypto: x86 - standardize not loaded prints
Thread-Index: AQHY3oYbFARu/v/glky9dQBH5rlEfK4LfFEAgAFidKA=
Date:   Thu, 13 Oct 2022 22:20:31 +0000
Message-ID: <MW5PR84MB184287FFFD5AD3D897659396AB259@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221006223151.22159-1-elliott@hpe.com>
 <20221012215931.3896-1-elliott@hpe.com>
 <20221012215931.3896-19-elliott@hpe.com> <Y0de+gl0irG+eNpT@zx2c4.com>
In-Reply-To: <Y0de+gl0irG+eNpT@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH7PR84MB1535:EE_
x-ms-office365-filtering-correlation-id: 63865cf7-d7d8-4eb6-6a53-08daad6923ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fLCehugxnoxe7qt6bGJDnVcHR3Gmbrq2wv26+XP3MLSJ67MJ9QWbT+VDHKrOicNe0B5OBBV6t0FZg0aUk35bDPnJHde6EB4qwV2DCAEt5nOObV6FrRgBTLLmRGHxVjtBRUBcDjbgnxcktZjwc5DoAfIpKJvAFj2w7esaMyVCc73tXrroSTl92Z2q47GnKyBgHDqmCMHtqx4zTpgYeiOoCHLNkOXtGg6iEF1ooEcW1wzuctXG5cKQ13otcOX0OvYd0Uki94G0FDMH8P0lh+R4kPfj0ZZM8EdGRca0rXsglJTUPbqPC7ABgz1xDGCIsuJD2FrUFM8qHoMLpxJcipKoe/vrgRm43xqeagoyci2iuJC9h5J/YPjDtso57O/dypOiaG19SwKvllfAud4oG5TBs82CX0Nj025JeP3MPTte5UgXERPLl3QXRWnjMZ+YbCW/Obr4HsbymvhQmtGaqEpqX7D4iFZnRj7rCKLbLNcoffNfIF3H8Owg9hm9U7yVe9jLv8TDBArpqnNrN9Jf9gpRX1NmvpzLl7cEH+sWZ4sOo0bFeSnM/Jkv4MoTO5LxlPGLKx5jZagBOalTmJjSqrrzubKIboUVRwO5VZBByc0wP9wBKwMcKJj+o5qOXn2X+JnJhbVOR6Q3clWqNsgddYY0rh4dJ6CZWLtwHN53MH0GdKq2JxCuZSIXz1eMNkJ26Fakl5Du6s+GIgLdGXLuMh1Vv9i5PKKFPSO9oSbo4FrKigIR4Qw9LjvwoQQozCMsZpWsjZ6+6ThQSr2zm0PKKGr+3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199015)(82960400001)(38070700005)(38100700002)(122000001)(71200400001)(6916009)(33656002)(86362001)(55016003)(8676002)(54906003)(66476007)(2906002)(8936002)(41300700001)(66946007)(4326008)(64756008)(76116006)(66446008)(83380400001)(7696005)(186003)(52536014)(478600001)(316002)(66556008)(53546011)(5660300002)(6506007)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTZsTlZwcmxMd3VGNnRuTit2bmdwaDY4STV0dU45QVByOG1SSTA2NXkwOVlT?=
 =?utf-8?B?MGU0cUU1Yk52eUpKSWk0NjZxK1hVc200aXU5R0FiYzlqVzN5Mnk0MlE3aHBp?=
 =?utf-8?B?bGU0RzY4VDFWMkh1L0xoaGV5cmFFYmRCc2pGSkFVZUJsa1ZwSUt2aCt3cThT?=
 =?utf-8?B?MVFkQWFGVm11UWFma0VCdFpqUnhkNVRzY1NuU2NTYU9TbTJ0L3RueTlQclA3?=
 =?utf-8?B?Ukszbk03ODRiRFNXaXdRQnYyek5ScUpoUnJDUHZPZi8vT2hrYlBWR21tOXdU?=
 =?utf-8?B?WVpsQlI2aHRPZVdjQ29jZmhLNWJhMXhmeXBvWHMwamk1MnNDbllnT2FMZkxl?=
 =?utf-8?B?QUMwZGFNb3FIK1F2ZEpOazFZWklhNEFVUXIvcisyTTJXbDloZ3VVeEhIZWxJ?=
 =?utf-8?B?aW9BT2RpYm1rK09jclNZSlZHM0ZKS08wUzc1Tzk1QXlVQ2FucXl0Z1BkbGM4?=
 =?utf-8?B?MTF5ck16bmdvaWlKT3o1OExlMm8zb3hzZ1NXdytUMTVIMjRTZDZQZUl1NjNl?=
 =?utf-8?B?YUROL29jSTc1Z01XTWZMUUdwbmRHMm1mSmRhNTFLdERPK2dkNWtOU0xWZUpy?=
 =?utf-8?B?YndraDFhRFRPRUpwWHgxRE1UVm93alIyZlVSR1RBTGFBK1IzQlcrdXErdlNP?=
 =?utf-8?B?ajdSOG9kam9ON3JiOGF1RktYZ1poeVlmUVZ6V2JXRUsvazhQQTJKbVJnT21j?=
 =?utf-8?B?WnROZm8zMDRJUHR0WVJ0YUhGZ0lzU2M1cXNKL0JRRDk1MXllaWozSGxxMW9L?=
 =?utf-8?B?azczY002czBkWkJUZGlRTURnU2Z0TmlLYXk1MytySWorVEVYQk8rUUtUYmVB?=
 =?utf-8?B?SzA2M3BzNUZIdGZJN0FxTlZhOC9OVnRvaFFIdldEdXBzRWZzREFZeUFTalAx?=
 =?utf-8?B?TG5KejJqL2l3UXNSY1czU1BSNVdHbGdGZ2FncStMZTFuT3Z1bnRTQVFidGV1?=
 =?utf-8?B?YTJndjFmNlFqbE5HelBCU1V6U0V2QkYxNlRJcHA2cFZRRVRSK1R1UnhDdkJY?=
 =?utf-8?B?UzlSS09GbTQ0YkxiYjJ1YkpIZHhURHRIOXFZaWpQU29qdU13NVVKSTVYSURE?=
 =?utf-8?B?cjJOU1VEckhKVmxzbjNjWVBzM2ZMdStSTFlDZ0l0UjNNbU1NdmIzM1Y4Q0Ex?=
 =?utf-8?B?RDR0UTUyWHlrSS8zV203MFp3czFvQ2RJc0dhYWdCNU9nUzN1emlwM1VKNTE3?=
 =?utf-8?B?L1NTQnFjTUlXRWV3dWpqWXQ0VXVVdG50QitHVjJJWGJLeTBIa2NwUFU1ZDA4?=
 =?utf-8?B?TjhBNndZU1k5OUl1TXB6SC92M0FtSzBCNys3eXQ5R2ZPV2d0cWQ4bE1INnRH?=
 =?utf-8?B?WW1zRk9HSnVQZGxmYVN3RUEyK0hTbnNRaW9ZMDdZY09JVXB0SEtKb1BEdmQ5?=
 =?utf-8?B?ZGdiY0tLRkU5VGk0WU9SMWJTRHVqVTZCV0ZHQnJkelI0eEVOSytxQkV5ME1k?=
 =?utf-8?B?T0x6REN6UElSaGNnMERGZDd1WlVFRElYVTBIN0V3QTliSWx1SVRUSENLSDRq?=
 =?utf-8?B?SzBzYkNrWFh2VE9hdzRBY05hZnZLcU5JZkpDa3JtdkZOWGxtdTR1YXZGaEZy?=
 =?utf-8?B?TkNtTjhCTnFLdHZBb09XVEpGNStwRW9Ga21kdkdKZm9oSlVzeWszemNrUU1p?=
 =?utf-8?B?RGtEcUMzcm1mNzVsSDBtei9xMHBiRkJmSlBTbG5hL3J2UUplVXBDem16cHIw?=
 =?utf-8?B?RHNsakNseUtBS0huZ21NKzAyQzBFUWFIZW1rWHBvNmQrUURWRVljRnRzYUVT?=
 =?utf-8?B?SWsveCtUQ0EwVVk2aDh3ZExleHIxOHRGVW9vbkRqRGpROGNBakE5ZjdGVU1N?=
 =?utf-8?B?aDNGQmxzNGN5VEdrT1hOMXVPZDUraHlwS2JNcEFaUGhJdHIvTjNaMkVDM0ZS?=
 =?utf-8?B?dUpydCtMZ2NjMlBsWjU1UnF4YUxxQXh6aHJlTDV2VHJxNlFjUGxGWVJjbGY3?=
 =?utf-8?B?SFhWYkE3UG93a29OUnErVmZlVmYwUk02bjg2L0xUdHpjeU51dmJrb3pNcDM3?=
 =?utf-8?B?bVZEQStNb01SK1VCZnVSV3VWSXlXMmNFS2ZhNVdlTUhhaEthUkNEaWZOaUVF?=
 =?utf-8?B?TUE4b0Y0RytSQWJ4MEF4QTdvdHE2WUp5aUZDWnRwYTB6aDU3TFV6cmlUV2JK?=
 =?utf-8?Q?MtW4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 63865cf7-d7d8-4eb6-6a53-08daad6923ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 22:20:31.2819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfnsEPvBlr+zb2qbuSmQcGYiB9VNp/pxcDDAeJOVROgUPctsJiDO4LQCn8HhXt0n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1535
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: c42qdZ9FG1S5vwDNXv57VPUHPfqZDH3H
X-Proofpoint-GUID: c42qdZ9FG1S5vwDNXv57VPUHPfqZDH3H
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130124
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gQS4gRG9uZW5m
ZWxkIDxKYXNvbkB6eDJjNC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAxMiwgMjAy
MiA3OjQzIFBNDQo+IFRvOiBFbGxpb3R0LCBSb2JlcnQgKFNlcnZlcnMpIDxlbGxpb3R0QGhwZS5j
b20+DQo+IENjOiBoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU7IGRhdmVtQGRhdmVtbG9mdC5u
ZXQ7DQo+IHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tOyBhcDQyMDA3M0BnbWFpbC5jb207IGFy
ZGJAa2VybmVsLm9yZzsgbGludXgtDQo+IGNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxOC8xOV0gY3J5
cHRvOiB4ODYgLSBzdGFuZGFyZGl6ZSBub3QgbG9hZGVkIHByaW50cw0KPiANCj4gT24gV2VkLCBP
Y3QgMTIsIDIwMjIgYXQgMDQ6NTk6MzBQTSAtMDUwMCwgUm9iZXJ0IEVsbGlvdHQgd3JvdGU6DQo+
ID4gU3RhbmRhcmRpemUgdGhlIHByaW50cyB0aGF0IGFkZGl0aW9uYWwgcmVxdWlyZWQgQ1BVIGZl
YXR1cmVzIGFyZSBub3QNCj4gPiBwcmVzZW50IGFsb25nIHdpdGggdGhlIG1haW4gQ1BVIGZlYXR1
cmVzIChlLmcuLCBPU1hTQVZFIGlzIG5vdA0KPiA+IHByZXNlbnQgYWxvbmcgd2l0aCBBVlgpLg0K
PiA+DQo+ID4gQWx0aG91Z2ggbW9kdWxlcyBhcmUgbm90IHN1cHBvc2VkIHRvIHByaW50IHVubGVz
cyBsb2FkZWQgYW5kDQo+ID4gYWN0aXZlLCB0aGVzZSBhcmUgZXhpc3RpbmcgZXhjZXB0aW9ucy4N
Cj4gDQo+IEFub3RoZXIgY29tbWEgc3BsaWNlLiBCdXQgYWxzbywgZG9uJ3QgZG8gdGhpcy4gTm8g
bmVlZCB0byBjbHV0dGVyIGRtZXNnLg0KPiBgbHNtb2RgIGlzIHRoZSBqb2IgZm9yIHRoaXMuDQoN
CklmIG1vZHVsZSBsb2FkaW5nIGZhaWxzLCBtb2Rwcm9iZSBnZXRzIGJhY2sgb25lIGVycm5vIHZh
bHVlDQphbmQgY29udmVydHMgdGhhdCB0byBhIHN0cmluZywgYnV0IGhhcyBubyBvdGhlciBjbHVl
IHdoYXQNCmlzIHdyb25nLg0KDQpUaGUgbW9kcHJvYmUgbWFuIHBhZ2UgcmVmZXJzIHRvIGRtZXNn
Og0KICAuLi4gbW9kcHJvYmUgZG9lcyBub3QgZG8gYW55dGhpbmcgdG8gdGhlIG1vZHVsZSBpdHNl
bGY6IHRoZSB3b3JrIG9mIA0KICByZXNvbHZpbmcgc3ltYm9scyBhbmQgdW5kZXJzdGFuZGluZyBw
YXJhbWV0ZXJzIGlzIGRvbmUgaW5zaWRlIHRoZQ0KICBrZXJuZWwuIFNvIG1vZHVsZSBmYWlsdXJl
IGlzIHNvbWV0aW1lcyBhY2NvbXBhbmllZCBieSBhIGtlcm5lbA0KICBtZXNzYWdlOiBzZWUgZG1l
c2coOCkuDQoNCklmIHRoZSBlcnJvciBoYXBwZW5zIHRvIGJlIC1FTk9FTlQsIG1vZHByb2JlIHNw
ZWNpZmljYWxseSByZWNvbW1lbmRzDQpsb29raW5nIGF0IGRtZXNnOg0KICBtb2Rwcm9iZTogRVJS
T1I6IGNvdWxkIG5vdCBpbnNlcnQgJ3RjcnlwdCc6IFVua25vd24gc3ltYm9sIGluIG1vZHVsZSwg
b3IgdW5rbm93biBwYXJhbWV0ZXIgKHNlZSBkbWVzZykNCg0KQSBkZXZpY2UgdGFibGUgbWlzbWF0
Y2ggY2FuIGJlIGRldGVybWluZWQgYnkgY29tcGFyaW5nIHRoZSBtb2RpbmZvDQphbGlhc2VzIGZv
ciB0aGUgbW9kdWxlIHRvIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L21vZGFsaWFzOg0KDQpjcHU6
dHlwZTp4ODYsdmVuMDAwMGZhbTAwMDZtb2QwMDU1OmZlYXR1cmU6LDAwMDAsMDAwMSwwMDAyLDAw
MDMsMDAwNCwwMDA1LDAwMDYsMDAwNywwMDA4LDAwMDksMDAwQiwwMDBDLDAwMEQsMDAwRSwwMDBG
LDAwMTAsMDAxMSwwMDEzLDAwMTUsMDAxNiwwMDE3LDAwMTgsMDAxOSwwMDFBLDAwMUIsMDAxQyww
MDFELDAwMUYsMDAyQiwwMDM0LDAwM0EsMDAzQiwwMDNELDAwNjgsMDA2QSwwMDZCLDAwNkMsMDA2
RCwwMDZGLDAwNzAsMDA3MiwwMDc0LDAwNzUsMDA3NiwwMDc4LDAwNzksMDA3QywwMDgwLDAwODEs
MDA4MiwwMDgzLDAwODQsMDA4NSwwMDg2LDAwODcsMDA4OCwwMDg5LDAwOEIsMDA4QywwMDhELDAw
OEUsMDA4RiwwMDkxLDAwOTIsMDA5MywwMDk0LDAwOTUsMDA5NiwwMDk3LDAwOTgsMDA5OSwwMDlB
LDAwOUIsMDA5QywwMDlELDAwOUUsMDBDMCwwMEM1LDAwQzgsMDBFMSwwMEUzLDAwRTQsMDBFNiww
MEU3LDAwRUEsMDBGMCwwMEYxLDAwRjIsMDBGMywwMEY1LDAwRjksMDBGQSwwMEZCLDAwRkUsMDBG
RiwwMTAwLDAxMDEsMDEwMiwwMTAzLDAxMDQsMDExMSwwMTIwLDAxMjEsMDEyMywwMTI1LDAxMjYs
MDEyNywwMTI4LDAxMjksMDEyQSwwMTJDLDAxMkQsMDEyRSwwMTJGLDAxMzAsMDEzMSwwMTMyLDAx
MzMsMDEzNCwwMTM3LDAxMzgsMDEzOSwwMTNDLDAxM0UsMDEzRiwwMTQwLDAxNDEsMDE0MiwwMTQz
LDAxNjAsMDE2MSwwMTYyLDAxNjMsMDE2NCwwMTY1LDAxNzEsMDFDMCwwMUMxLDAxQzIsMDFDNCww
MUM1LDAxQzYsMDFDNywwMUM5LDAxQ0IsMDIwMywwMjA0LDAyMEIsMDI0QSwwMjVBLDAyNUIsMDI1
QywwMjVELDAyNUYNCg0KbW9kaW5mbyBhZXNuaS1pbnRlbDoNCmFsaWFzOiAgICAgICAgICBjcHU6
dHlwZTp4ODYsdmVuKmZhbSptb2QqOmZlYXR1cmU6KjAwOTkqDQoNCnNvIEknbSBjb21mb3J0YWJs
ZSBub3QgcHJpbnRpbmcgdGhhdCBvbmUuDQoNClRoZSBjaGVja3MgZm9yIG90aGVyIGNvbWJpbmF0
aW9ucyBvZiBmZWF0dXJlcyAoZS5nLiwgc2hhNTEyDQphbHNvIHJlcXVpcmluZyBCTUkyKSBhbmQg
Zm9yIENQVSBleHRlbmRlZCBmZWF0dXJlcyBhcmUgbm90DQpzbyBvYnZpb3VzLiBOb3RoaW5nIGlu
IG1vZGluZm8gZXhwbGFpbnMgd2hhdCB0aGUgbW9kdWxlIGlzDQpsb29raW5nIGZvciwgYW5kIG5v
dGhpbmcgcmVjb3JkcyB3aGF0IGl0IGRpZG4ndCBsaWtlLiBUaGVyZQ0KYXJlIGN1cnJlbnRseSAz
MiBwcmludHMgaW4gdGhlIGRpcmVjdG9yeSwgZWl0aGVyIGV4cGxhaW5pbmcNCmVycm9ycyBvciBl
eHBsYWluaW5nIHdoaWNoIG9wdGlvbmFsIGZlYXR1cmVzIGhhdmUgYmVlbg0KZW5hYmxlZC4NCg0K
VGhlIG1vZHByb2JlIG1hbnBhZ2UgZG9lc24ndCBwcm9taXNlIHdoYXQgbG9nIGxldmVsIHdpbGwN
CmV4cGxhaW4gdGhlIHByb2JsZW0sIHNvIHdlIGNvdWxkIHByaW50IHRoZW0gd2l0aCBwcl9kZWJ1
Zw0Kc28gdGhleSdyZSBvbmx5IGF2YWlsYWJsZSBpZiB5b3UgZmlndXJlIG91dCBob3cgdG8gZW5h
YmxlDQpkeW5hbWljIGRlYnVnIGZvciB0aGUgbW9kdWxlLg0KDQpUaGUgcG9zaXRpdmUgbWVzc2Fn
ZXMgYWJvdXQgd2hpY2ggb3B0aW9uYWwgZmVhdHVyZXMgYXJlDQplbmdhZ2VkIGNvdWxkIGJlIHJl
cG9ydGVkIGFzIHJlYWQtb25seSBtb2R1bGUgcGFyYW1ldGVycy4NCg0KDQo=
