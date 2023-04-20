Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E6A6E9A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjDTRXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDTRXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:23:22 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4992219AA;
        Thu, 20 Apr 2023 10:23:20 -0700 (PDT)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 33KFsHOA031484;
        Thu, 20 Apr 2023 17:23:09 GMT
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02lp2047.outbound.protection.outlook.com [104.47.11.47])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3q34wrhmsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 17:23:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYbIx/7BanmwQRRYEMydQkJ6EdWYPAF6FbjxPnXj5kpLFPFE2YXZd/qE2ztJLT2rBWaGQehyq0SPtBCFqT+hmJ+RDdgEhSHv16/KZX/MvyU/UIRmDRjUXEkikFZgSU/eH5GBPbZkX9xPw/UX/2loffLvxF8Se+Ar0qWNs3rMPwbymItSxH713jBRsPOwaHTaLHyQiO/mcQ7lvJsPuiCs/c/I8G/eXtj0nXZyc+vO+0brMtON8NPz8hwV1Akr6Iwko5ZCoQJ2TRkRpZKA5sykbxLIgdgQaIB+yNUf+Tx2EmAg07GBhI5AUSxLfyyOtT+Dq0pWWuPz+vvc51HGJuIciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxbILEzwtKtD4JT2CsmG7puHsa1eDIuYTrmEdyvx8Pk=;
 b=F9VOAwfrucsMQ+jonxbbYrHG+WaXqIRjTjA+SnXbPFUUH50sbHtrRp+V4sFjqLBtIMHgm/l9knTPpbb1Gz3rhAI+jRZTMdXTQVCH1bGx2m/Kf6yMV/uBYoVhuGqE0PBCfUbAFKjW4lYg/D2AjcbM4cUDUJx3JY7ZVGefEJNQfaihJIDBKn9gFd9yu4cD5h7bcpAc260iADeYDnhoCp73mziWvKV4whXzwgozvYp4ku4iluJMIw+y7raU3N4Fw9sBbV0wJ4urgUDD3fn5Ec0i2sTVW1hGkkCnc6qPvrzRy+RWsLEdjp/pQjNkiQIvoNZGhp1jn53R6ks37wgmY0sb0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxbILEzwtKtD4JT2CsmG7puHsa1eDIuYTrmEdyvx8Pk=;
 b=TU2546WsBVi0vsOK15p9OEs/V+DBkn1eCBADALoxdu78J6lBLErrsf9yPRmRrb57UmZa3/XyXvkHbmGKqQfHbaiNrAgO6L1AsjqI7EikCrEbDGRR/0YpQH6wgsiUlAqg399MSf04hSyrooOTO4v/fRpVzS1xmYn+SFjashG29Gdmy39VoCBxvwSBA1Z//tSEncPJTfTHcTaytC/GyNkNbpHtR6HHwPoBKVPJSUY4wL3p19yYMzDf+Ik+z8mclUiTOSsZ/VWY1qH5JEJZPVFe9DFSHqvhxzkpATVZVVlwiYnKByQ673bjNREAVfvCBWTdXag9WB2gI584DZQyZcI2xA==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AS8PR03MB10175.eurprd03.prod.outlook.com (2603:10a6:20b:5c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 17:23:05 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300%9]) with mapi id 15.20.6298.045; Thu, 20 Apr 2023
 17:23:05 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: Re: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
Thread-Topic: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
Thread-Index: AQHZaTpLwL07BD9460y7/F64OnMs/q8oQvCAgAw/L4CAAATzAA==
Date:   Thu, 20 Apr 2023 17:23:05 +0000
Message-ID: <e2c3eae9-4c99-43fe-abcf-4f1840c58c64@epam.com>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
 <54119b2cb43e29f69c5858a5320d3a58f23fed21.1680793130.git.oleksii_moisieiev@epam.com>
 <ZDcqx9JVMvqr2WYu@e120937-lin> <ZEFw0TYs3TEHuM1D@pluto>
In-Reply-To: <ZEFw0TYs3TEHuM1D@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AS8PR03MB10175:EE_
x-ms-office365-filtering-correlation-id: 5b36bb61-b8af-456a-a8d8-08db41c3e6e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QSZLaGvGhUuST09BVJPUnpPdrqYrSAUCChyS++LS+/T3Dvepf7Xo/WwXALOuYmwxmUafcz30Amq/rslEOhKstEHtbBKJdHrxpZ67KdIx4HgIYJdECE0/+N0BOeBoNNPsVjxAlFrJ80V0AvuzhsuxNvsJaEc2IeT2n00CQJRjGwCbGOB6ne0neQhv4ayxeGrAUSwXaOcKJvBn+vVbQ7pIINcbEBDhjO1hheA+z0aEhhoqvW9COH+knDRQkL5O7FQwJRkpjHa3VmBFaG4yf/mhJKXYyrAo11ONNsau4tVjK+fMXU0KGvwwaqkBU8A7xpdo82eqaL4U2EengiVr1bZbfmfqJrDSWThCuDWOPcG+je6Ly91DvLdJinPYlJXEuMTcAL/6/QOz2Ak9lZ7ZJehw+aOHYd7VJpZLLIb+yPQHthIZYHA3jddUFVnzvUrGqo6eTZvNtK5CO7O0DmjOU8bGzuWO0mMgcpeS5zHIcoxhIWBiY9LOrWjnjAaZTpVWD2qz6rr+J2C8qkvhNCpa5JIUX8gLHOTW5c+OBlRrfeVpSps6LyV4/DlLPKQ3f2zyJSw4YRfxufDzBvkUjTyw+pc09C6XUN/epFiz93P0/JSUm21bk6np1tkH+AHIC4jcgRp/EUsQGHK8DG/YSMJ6rimZlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(966005)(53546011)(31696002)(186003)(86362001)(31686004)(6512007)(6506007)(26005)(6916009)(4326008)(41300700001)(64756008)(316002)(122000001)(2616005)(83380400001)(6486002)(71200400001)(478600001)(36756003)(38070700005)(8676002)(5660300002)(91956017)(8936002)(2906002)(66946007)(76116006)(66446008)(66476007)(66556008)(38100700002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTA5MFRWWnBHblBrL2Q2SE5zT2hObmFSdjdwV0NLcjhmRzhPM09ncjAzZXp3?=
 =?utf-8?B?SjF3OVM2TmZ4aWIxM1ltbW94QXZSY0Rjd3ZINm00S3hGbXVwSjFYSzhuU1dm?=
 =?utf-8?B?MWxPZlJHVEJ4VHAzUEhoZTBuN05NVEFIRVVxODZJRUwxV1k5WTdqdnlVNHVv?=
 =?utf-8?B?NWNXcnRjdHlRVmZseTBzWU9NWHhkNkl2YkpIQnkxYnRMTndVek5ETG5STEFF?=
 =?utf-8?B?S2ZxWDRtbzRHaWxja3F5Qlk5QzVySjBFM1FhZ0Y0eTErQkxtdVBSOVpNMjRq?=
 =?utf-8?B?Nk1vMFRxRUk3My90SnBITTBlckNrRGpXb0h6dlZkZUNjMEFycGVaeFVOY0s1?=
 =?utf-8?B?WkRHdUp5bGR0NVp2TUtrRnVyMU1XTVZsZUFBdmxUNkpBa29lSG1mQ0Q3c1px?=
 =?utf-8?B?QnRxYmNZaXpmdXNaOGlaems1Um9nMG5ZWHY3cGQrZDVTUDlpSGEweEgwL3Az?=
 =?utf-8?B?a0t1a0JmNFppaVNOWkluckp5M0tJTlpkWlJtMGkrRnJCTXVjbHJUNVlzd2o1?=
 =?utf-8?B?ZXp4TXBoZ0hmNUd5RDhndkxvaXBGRjNQTHEzK2lOK0V0NDBza3FKUmlMbjI4?=
 =?utf-8?B?cEVVMWlzNFRmQW4vVnhWVHZJbGhpM1R6b00zREVzTkc1czRhRGNqREY4Y3Jy?=
 =?utf-8?B?b081QkZ4UTZmWXVGT2IvTmtrcHlUakNnQWpvejJ5M2IzVmNyaE0yOUhTNTJW?=
 =?utf-8?B?UEFSaGtXaDQ3bHE2bk1NV0RMbjFEN2pHVGxhQVNhN1ZkTHg4eitHbEg4U0JJ?=
 =?utf-8?B?V2dwWWpuREV2SW1TSXZVQTRDRnpHUFp4R0drY3BRb3lpMGtDbXBKUHE2VnFr?=
 =?utf-8?B?YTFXSEZwOXlCYXJHczBUdVp1Q3lXR2NYdVJtbHdGVTBKd0JaT3owY0M3azlC?=
 =?utf-8?B?YWpvcjZXenNFSjF6L3ZkUjlRdWN4ZVpBU3ZsMVF6cU8ybjdIcGVvbmlpbWpn?=
 =?utf-8?B?WDQ2d1VZQldqd2tROVMvWW9ETlZjaWw4YTlCZVZta0ljdElORUdyYUJFK1JU?=
 =?utf-8?B?OXhzTzJ6YTQ1L0JLNXF1UXRHZVJSN0czTnltQURxbTVRd3ZNcUpBZzh5T3Za?=
 =?utf-8?B?K0oyNzV4YTJUK3VvYlQ0L01vaTl3eW1FeVpZSE03RnhKdHdFNTUybEZYbDZQ?=
 =?utf-8?B?RGs3WmZxamtuVVdmM2FZbXg1OUlzMitGVkpJK25SYm1xNmVBR0NYVFNTNFN3?=
 =?utf-8?B?ekVnQS9qOFJMNGQ4SXN4TGM3S05CQmw0ZmdmWWJ5cUdOZm1NU3B2RHJqY2E3?=
 =?utf-8?B?c2lvb1hUTGd0MGNUdFYvOUNXb29KUnR1NGFYTFYwQks5VmxOT05IdEJWUnQz?=
 =?utf-8?B?K3hQVXNXK0N4M1NTNEs4SDhhTFRLOEJqNFFXbE81R1M0TUwvdks0V0hXS0g4?=
 =?utf-8?B?RkZybXJGbnZ2dmRUSWFmd3c2Q212NVYvK3dabUNxWWNzSWlxNlpzRkRGa2J3?=
 =?utf-8?B?ZTJnTmRyWjh5M0l6OGNoVUtBWlNFVk9aei9DbzFxVGR5NWp6ZTI3aWdSYUVY?=
 =?utf-8?B?NGRFTU5jdkVrUjgwR2R3ZFQrRHc4S2NudlVXY1NsTm94MnE5dkFxM1NFbi9s?=
 =?utf-8?B?cms3cS83YXZwU21vdE5GTk41b3E5eXBSa3JHRUkzRWpZSzZMd2p0NWJDWXJr?=
 =?utf-8?B?ZW50d1VRMHBDSE52TGtGQXJ0MXlqNjd5NUpQWkJ5aGVjTXVvcFN1NEZkVS92?=
 =?utf-8?B?dmF2SzBwajVtSGxEMFViQ21CVkUwckJsa1FZdnFyTmFaOVR2NDNIdGxLSGps?=
 =?utf-8?B?ZmYrdTFXd0lzZFNvekRwS1h3c3dzWnZrbzErUU8zT20rMFZRYktWWElPRk42?=
 =?utf-8?B?UEViak00Z0poRHhoZXIvQmJCSnR3MGlYRHNma082M3lpYUZEQlE4b25BejdP?=
 =?utf-8?B?OGRjRXdYUDRubnRXNEw1akUycXdlY3FuMTFzaldnaWtGbkJXakVLSjNQZzZK?=
 =?utf-8?B?RUR6elRoY3NmM2NzMFVtQUxEMkRQV25tbTN2eDNoWjU0UC9WSUJCQmkzR0hV?=
 =?utf-8?B?VnpsZ1BLaWJGV3NGNkRvaC8yamVCN0hOM3ZWbWoxS2ZZOGFSSW95aHpaOGcz?=
 =?utf-8?B?Z0lDMlhTTDNRYnhGRmx1RWIwQUNITmcwRndzRVFwTFJzT0VOWWNZRVlNeGdo?=
 =?utf-8?B?Sm5saEZqNDJmNURldGlUWFlDcll0N2hyY0JhMkNCdmpIY3ZIZC93ZHZJV05u?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C5DA82FB87FA74B993DF305C4D523A0@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b36bb61-b8af-456a-a8d8-08db41c3e6e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 17:23:05.0939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DyCisxmxsadEROHacFRNdslI7Z8acDTEYlWkhcLGzcYqLMQa8qKqnyKPafvZs3TM0whuLC0EZvfNfD+guBbuBtcFwAYNFzXxbWRELtiHxK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB10175
X-Proofpoint-ORIG-GUID: 9RC5_3UplKz1OnGNh4R0TtWtxyQXLCnw
X-Proofpoint-GUID: 9RC5_3UplKz1OnGNh4R0TtWtxyQXLCnw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_12,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=818 priorityscore=1501 clxscore=1011
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ3Jpc3RpYW4sDQoNCk9uIDIwLjA0LjIzIDIwOjA1LCBDcmlzdGlhbiBNYXJ1c3NpIHdyb3Rl
Og0KPiBPbiBXZWQsIEFwciAxMiwgMjAyMyBhdCAxMTowNDowNVBNICswMTAwLCBDcmlzdGlhbiBN
YXJ1c3NpIHdyb3RlOg0KPj4gT24gRnJpLCBBcHIgMDcsIDIwMjMgYXQgMTA6MTg6MjdBTSArMDAw
MCwgT2xla3NpaSBNb2lzaWVpZXYgd3JvdGU6DQo+Pj4gSW1wbGVtZW50YXRpb24gb2YgdGhlIFND
TUkgY2xpZW50IGRyaXZlciwgd2hpY2ggaW1wbGVtZW50cw0KPj4+IFBJTkNUUkxfUFJPVE9DT0wu
IFRoaXMgcHJvdG9jb2wgaGFzIElEIDE5IGFuZCBpcyBkZXNjcmliZWQNCj4+PiBpbiB0aGUgbGF0
ZXN0IERFTjAwNTYgZG9jdW1lbnQuDQo+PiBIaSwNCj4+DQo+IEhpIE9sZWtzaWksDQo+DQo+IG9u
ZSBtb3JlIHRoaW5nIHRoYXQgSSBtaXNzZWQgaW4gbXkgcHJldmlvdXMgcmV2aWV3IGRvd24gYmVs
b3cuDQo+DQo+Pj4gVGhpcyBwcm90b2NvbCBpcyBwYXJ0IG9mIHRoZSBmZWF0dXJlIHRoYXQgd2Fz
IGRlc2lnbmVkIHRvDQo+Pj4gc2VwYXJhdGUgdGhlIHBpbmN0cmwgc3Vic3lzdGVtIGZyb20gdGhl
IFNDUCBmaXJtd2FyZS4NCj4+PiBUaGUgaWRlYSBpcyB0byBzZXBhcmF0ZSBjb21tdW5pY2F0aW9u
IG9mIHRoZSBwaW4gY29udHJvbA0KPj4+IHN1YnN5c3RlbSB3aXRoIHRoZSBoYXJkd2FyZSB0byBT
Q1AgZmlybXdhcmUNCj4+PiAob3IgYSBzaW1pbGFyIHN5c3RlbSwgc3VjaCBhcyBBVEYpLCB3aGlj
aCBwcm92aWRlcyBhbiBpbnRlcmZhY2UNCj4+PiB0byBnaXZlIHRoZSBPUyBhYmlsaXR5IHRvIGNv
bnRyb2wgdGhlIGhhcmR3YXJlIHRocm91Z2ggU0NNSSBwcm90b2NvbC4NCj4+PiBUaGlzIGlzIGEg
Z2VuZXJpYyBkcml2ZXIgdGhhdCBpbXBsZW1lbnRzIFNDTUkgcHJvdG9jb2wsDQo+Pj4gaW5kZXBl
bmRlbnQgb2YgdGhlIHBsYXRmb3JtIHR5cGUuDQo+Pj4NCj4+PiBERU4wMDU2IGRvY3VtZW50Og0K
Pj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2RldmVsb3Blci5hcm0uY29t
L2RvY3VtZW50YXRpb24vZGVuMDA1Ni9sYXRlc3RfXzshIUdGXzI5ZGJjUUlVQlBBITBrTUxRNWMz
dEtzTWZXQ3FUS0hwNmVvbFkzc1RabHlLbUFEN0I3cGJpU0VTQUJVVW9Cem1oZ3JZZERnV0dDX2cw
dmdMRTR6d3JTNHBwZVRPRDhLaXpQOWZJZUprcGckIFtkZXZlbG9wZXJbLl1hcm1bLl1jb21dDQo+
Pj4NCj4gW3NuaXBdDQo+DQo+Pj4gK3N0YXRpYyBpbnQgc2NtaV9waW5jdHJsX3JlcXVlc3RfY29u
ZmlnKGNvbnN0IHN0cnVjdCBzY21pX2hhbmRsZSAqaGFuZGxlLA0KPj4+ICsJCQkJICAgICAgIHUz
MiBzZWxlY3RvciwNCj4+PiArCQkJCSAgICAgICBlbnVtIHNjbWlfcGluY3RybF9zZWxlY3Rvcl90
eXBlIHR5cGUsDQo+Pj4gKwkJCQkgICAgICAgdTMyICpjb25maWcpDQo+Pj4gK3sNCj4+PiArCXN0
cnVjdCBzY21pX3hmZXIgKnQ7DQo+Pj4gKwlzdHJ1Y3Qgc2NtaV9jb25mX3R4ICp0eDsNCj4+PiAr
CV9fbGUzMiAqcGFja2VkX2NvbmZpZzsNCj4+PiArCXUzMiBhdHRyaWJ1dGVzID0gMDsNCj4+PiAr
CWludCByZXQ7DQo+Pj4gKw0KPj4+ICsJaWYgKCFoYW5kbGUgfHwgIWNvbmZpZyB8fCB0eXBlID09
IEZVTkNUSU9OX1RZUEUpDQo+Pj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+Pj4gKw0KPj4+ICsJcmV0
ID0gc2NtaV9waW5jdHJsX3ZhbGlkYXRlX2lkKGhhbmRsZSwgc2VsZWN0b3IsIHR5cGUpOw0KPj4+
ICsJaWYgKHJldCkNCj4+PiArCQlyZXR1cm4gcmV0Ow0KPj4+ICsNCj4+PiArCXJldCA9IHNjbWlf
eGZlcl9nZXRfaW5pdChoYW5kbGUsIFBJTkNUUkxfQ09ORklHX0dFVCwNCj4+PiArCQkJCSBTQ01J
X1BST1RPQ09MX1BJTkNUUkwsDQo+Pj4gKwkJCQkgc2l6ZW9mKCp0eCksIHNpemVvZigqcGFja2Vk
X2NvbmZpZyksICZ0KTsNCj4+PiArCWlmIChyZXQpDQo+Pj4gKwkJcmV0dXJuIHJldDsNCj4+PiAr
DQo+Pj4gKwl0eCA9IHQtPnR4LmJ1ZjsNCj4+PiArCXBhY2tlZF9jb25maWcgPSB0LT5yeC5idWY7
DQo+Pj4gKwl0eC0+aWRlbnRpZmllciA9IGNwdV90b19sZTMyKHNlbGVjdG9yKTsNCj4+PiArCWF0
dHJpYnV0ZXMgPSBTRVRfVFlQRV9CSVRTKGF0dHJpYnV0ZXMsIHR5cGUpOw0KPj4+ICsJYXR0cmli
dXRlcyA9IFNFVF9DT05GSUcoYXR0cmlidXRlcywgKmNvbmZpZyk7DQo+Pj4gKw0KPiBMb29raW5n
IGF0IHNjbWlfY29uZl90eCBhbmQgdGhlc2UgcGluY3RybCBnZXQvc2V0IGZ1bmN0aW9ucywgeW91
IGRvIG5vdA0KPiBzZWVtIHRvIGNvbnNpZGVyIHRoZSBDb25maWdUeXBlIGZpZWxkIGluIHRoZSBT
Q01JIHJlbGF0ZWQgbWVzc2FnZXMsIHNvDQo+IGJhc2ljYWxseSB1c2luZyBhbHdheXMgdGhlIERl
ZmF1bHQgMCBUeXBlLCBhbmQgYXMgYSBjb25zZXF1ZW5jZSB5b3UgZG9udA0KPiBlaXRoZXIgZXhw
b3NlIGFueSB3YXkgdG8gY2hvb3NlIGEgRGlmZmVyZW50IHR5cGUgaW4gdGhlIHJlbGF0ZWQgU0NN
SQ0KPiBwcm90b2NvbCBvcHM7IEkgaW1hZ2luZSB0aGlzIGlzIGJlY2F1c2UgdGhlIHBpbmN0cmwg
ZHJpdmVyIGN1cnJlbnRseSB1c2luZw0KPiB0aGlzIHByb3RvY29sLCBhdCB0aGUgZW5kLCBkb2Vz
IG5vdCBuZWVkIGFueSBvZiB0aGUgb3RoZXIgYXZhaWxhYmxlIHR5cGVzDQo+IChhcyBpbiBUYWJs
ZSAyMyBvZiB0aGUgc3BlYykuDQo+DQpJJ20gbm90IHN1cmUgSSd2ZSB1bmRlcnN0b29kIHlvdXIg
cG9pbnQuIFBpbmN0cmwgc3Vic3lzdGVtIHBhc3MgY29uZmlnIA0KaW4gc28tY2FsbGVkIFBhY2tl
ZCBmb3JtYXQuIFNvIHRoaXMgbWVhbnMgdGhhdCBjb25maWcgaXMgYm90aCBpbnB1dCBhbmQgDQpv
dXRwdXQgcGFyYW1ldGVyLiBQYWNrZWQgZm9ybWF0IG1lYW5zIHRoYXQgdTMyIGNvbmZpZyBoYXMg
Ym90aCBjb25maWcgaWQgDQphbmQgY29uZmlnIHZhbHVlIHBhY2tlZCBpbnNpZGUuDQoNClNvIEkg
cmVjZWl2ZSBwYWNrZWQgY29uZmlnIHdpdGggYm90aCBpZCBhbmQgdmFsdWUgb24gY29uZmlnX3Nl
dCBjYWxsIGFuZCANCnRoZW4ganVzdCBzZW5kIGl0IG92ZXIgU0NNSSwgZXhwZWN0aW5nIGVycm9y
IGZyb20gc2VydmVyIGlmIGNvbmZpZyBpcyANCmludmFsaWQuIE9uIGNvbmZpZ19nZXQgY2FsbCBJ
IHJlY2VpdmUgY29uZmlnIHBhcmFtZXRlciB3aXRoIG9ubHkgaWQgDQpwYWNrZWQgaW5zaWRlLCB0
aGVtIHBhc3MgaXQgdG8gdGhlIHNlcnZlciBhbmQgcmVjZWl2ZSBwYWNrZWRfY29uZmlnIHdpdGgg
DQpib3RoIGlkIGFuZCB2YWx1ZSwgd2hpY2ggaXMgcmVhZHkgdG8gYmUgcmV0dXJuZWQgdG8gdGhl
IHN1YnN5c3RlbS4NCg0KPiBUaGlzIGlzIGZpbmUgZm9yIHBpbmN0cmwgZHJpdmVyIGFzIGl0IGlz
IG5vdywgQlVUIHRoZSBTQ01JIHBpbmN0cmwNCj4gcHJvdG9jb2wgaW1wbGVtZW50YXRpb24gaW4g
dGhlIGNvcmUgU0NNSSBzdGFjayBhbmQgaXRzIHJlbGF0ZWQNCj4gcHJvdG9jb2xfb3BlcmF0aW9u
cyBhcyBleHBvc2VkIGluIHNjbWlfcHJvdG9jb2wuaCBzaG91bGQgYmUgZ2VuZXJpYw0KPiBlbm91
Z2ggdG8gc2VydmUgYW55IHBvc3NpYmxlIHVzZXIgb2YgdGhlIFNDTUkgcGluY3RybCBwcm90b2Nv
bCAoYW5kIHRoZXJlDQo+IGlzIGFscmVhZHkgYSByZXF1ZXN0IHRvIGV4dGVuZC9hbWVuZCB0aGUg
c3BlYyBzb21laG93IHRvIHNlbmQgbXVsdGlwbGUgcGluDQo+IHNldHVwIG9mIGRpZmZlcmVudCB0
eXBlcyBpbiBvbmUgZ28gYXMgeW91IG1heSBoYXZlIHNlZW4pLCBzbyBJJ2Qgc2F5IGl0J3MNCj4g
YmV0dGVyIGlmIHlvdSBhZGQgYWxzbyBhIENvbmZpZ1R5cGUgcGFyYW0gdG8gdGhlIGdldC9zZXRf
Y29uZmlnIHNjbWlfcGluY3RybF9vcHMNCj4gYW5kIGV4cG9zZSB0aGUgd2hvbGUgQ29uZmlnVHlw
ZSBlbnVtcyAoVGFibGUyMykgaW4gc2NtaV9wcm90b2NvbC5oIChsaWtlIHdlIGRvIGZvcg0KPiBz
ZW5zb3IgY2xhc3NlcyBvbiBzY21pX3Byb3RvY29sLmgpIHRvIGFkZHJlc3MgdGhpczsgdGhlIHBp
bmN0cmwgZHJpdmVyDQo+IGNhbiB0aGVuIGFueXdheSBjYWxsIHN1Y2ggbmV3IHByb3RvY29sX29w
cyB3aXRoIGEgRGVmYXVsdCB0eXBlLCBidXQgYXQNCj4gbGVhc3QgdGhlIFNDTUkgcHJvdG9jb2xf
b3BzIGludGVyZmFjZSB3aWxsIHJlbWFpbiBnZW5lcmljIGFuZCBjb3VsZCBiZQ0KPiByZXVzZWQg
aWluIG90aGVyIHNjZW5hcmlvcy4NCj4NCj4gVGhpcyBpcyBlcXVhbGx5IHRydWUgZm9yIGFsbCB0
aGUgb3RoZXIgcHJvdG9jb2wgbWVzc2FnZXMgKHNob3VsZCBJIGhhdmUNCj4gbWlzcyBzb21ldGhp
bmcgZWxzZSBmb3Igbm93Li4uSSdsbCByZXZpZXcgYWdhaW4geW91IG5leHQgVjIgYW55d2F5KS4N
Cj4NCj4gVGhhbmtzLA0KPiBDcmlzdGlhbg0KPg==
