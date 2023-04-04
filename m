Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D016D65BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjDDOvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjDDOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:51:06 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2674E30C5;
        Tue,  4 Apr 2023 07:51:05 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334DddmA013755;
        Tue, 4 Apr 2023 10:50:37 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pqrh59m93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 10:50:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgpflzPlaGyMoYn7puNEde7PznA5OeD0o3MhQgGQXOuSX0EkL9i7L8rdHT3rYowpTo5Q+7TDNYpvutgF3KrF8Bi60Dool+zfQYnZK2DBCT4bBBccHxJiKMuzvG8ELHyMY6loYhchYpgvsIMxmQJPi1OqyA88/vbLIys3zo+1EodXp8rJQBQWRNxpeEDdYMO9bNM9dKs/QgADJtzu4w8JkN14280uVqYnCTgbakWk1ISvmMEa8RBfU+1o++puYd7WPu/5IL5uBLCebDPYTJuEyfosOavo1KvfKmvIQh3gv+OCHwSFHY75V3ceZQsvrnXfnWmxdX++D+lKcr2zJ0mzhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0n5ksVWrcxixJ+YLlbCmOjcIyPX6FQieNBPg6kiDmOo=;
 b=YF2IiTT7pE3qCwsDJaoKkNrKZXyLG4/TQkEd2fKPe5vi2ieRnctD31nSB+8QjrfFh8DjYBgHerdRrXKhNl+e7uzO/V+/BmoKIAEeaoEKnpd6lvMTlpvSwsiEUrrW8hLpqQYXAZZOvv/bJDVfrl4/fV57w535dv/E4njGW7iRhmWCvaJJTGwmsX2bxGwNhM84NsoV0UylC4cqmb9MsPr/S2gRcFnXwYhCKlG4VzQrV44JCZ6t+6E3RHZnaDa3OxzlPi47EXYoomhTcgCF/GjfrGNDjKE0jR2JPQlpVm6w6Xo+x+eV9PMfWfQbnd/tAaiBEzUjJbIAvkeI/IFU9ffCFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0n5ksVWrcxixJ+YLlbCmOjcIyPX6FQieNBPg6kiDmOo=;
 b=m5ruo7nlvHl3GLGK6DmWkc1Q2MJrrVPUmh+xn1mPIJ96olIo+0pDH8QMove/nTQnKKtl0KQqlOy98l5MA7Q6QHvsyDsUh3SmeJqvs5XZZ2obq7J14Auj+aDuqWTlm51RYAgrjKtuCg1mcl6hibb7vFDJLOIPJVdD6GUfOBcqFEo=
Received: from CY4PR03MB2488.namprd03.prod.outlook.com (2603:10b6:903:39::12)
 by PH0PR03MB7113.namprd03.prod.outlook.com (2603:10b6:510:298::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 14:50:33 +0000
Received: from CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::3ebb:ede8:1ce9:2528]) by CY4PR03MB2488.namprd03.prod.outlook.com
 ([fe80::3ebb:ede8:1ce9:2528%6]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 14:50:33 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: RE: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Topic: [PATCH v5 2/2] dt-bindings: rtc: add max313xx RTCs
Thread-Index: AQHZZkM1/0NcmmhHVE+7c9BLHmZIxK8arcoAgAAOpACAACNY0IAADnQAgAAGjDCAACABAIAAI8ag
Date:   Tue, 4 Apr 2023 14:50:33 +0000
Message-ID: <CY4PR03MB248854B4B6E61323EB16895196939@CY4PR03MB2488.namprd03.prod.outlook.com>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <20230403154342.3108-3-Ibrahim.Tilki@analog.com>
 <dd6f0842-519f-1bc9-f7f5-459863dc3dcd@linaro.org>
 <202304040710049c9cc01a@mail.local>
 <CY4PR03MB2488DFC99C23ADE16FF40E2F96939@CY4PR03MB2488.namprd03.prod.outlook.com>
 <1efdb870-cac2-f6ed-72b5-d0550dbb5257@linaro.org>
 <CY4PR03MB24883E0406C2A16E566DB39196939@CY4PR03MB2488.namprd03.prod.outlook.com>
 <202304041226162e231e78@mail.local>
In-Reply-To: <202304041226162e231e78@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaWJyYWhpbS50?=
 =?us-ascii?Q?aWxraVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?us-ascii?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLTBiNTlmYmUwLWQyZjgtMTFlZC04ZTgw?=
 =?us-ascii?Q?LTdjYjI3ZDcyMzFhYlxhbWUtdGVzdFwwYjU5ZmJlMS1kMmY4LTExZWQtOGU4?=
 =?us-ascii?Q?MC03Y2IyN2Q3MjMxYWJib2R5LnR4dCIgc3o9IjIzNjkiIHQ9IjEzMzI1MDkz?=
 =?us-ascii?Q?NDMxNDQ0MDU3NyIgaD0icjM2cXVHSHMwcTMwMWxCdGp5TFR4a1lQaGZrPSIg?=
 =?us-ascii?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFB?=
 =?us-ascii?Q?RW9DQUFDQkY4M05CR2ZaQVk3U25xVmMxdG1YanRLZXBWelcyWmNEQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQVFBQkFBQUFRZGlrNVFBQUFBQUFBQUFBQUFBQUFKNEFBQUJo?=
 =?us-ascii?Q?QUdRQWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFk?=
 =?us-ascii?Q?QUJ6QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxB?=
 =?us-ascii?Q?R01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpR?=
 =?us-ascii?Q?QnlBREVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFI?=
 =?us-ascii?Q?QUFjZ0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIv?=
 =?us-ascii?Q?PjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB2488:EE_|PH0PR03MB7113:EE_
x-ms-office365-filtering-correlation-id: e4d8ca37-b221-4311-69d7-08db351bf161
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 86f8PJb/7iHrswBvgDlG2n5QCSoJvrGZS84vX1hC82XNMs1w9vS59rSKRcWKiLvafCtVNL/C+9R40N7475noLA1ZLKY3c/Zge8z1XR7YVpkMwlOn3x6BVgER1qI+CW1a69O9WalYrXLbTRBu8FQS35Raq8HpLDQRIj0SKIYJ/zYpiuH6X0t8s4eEcsbbltPh5fl6AZ+ypdDUnFHSsD3hq9Kxh9QQMnM/+5OYWyoF+rstlZpfG6R+A60+fVMMqFVk8hdcljMTbCorf64o7d+lLEgdNsoOT1dBdiYgQlOjFiXtlEM279lGYEo98wNX6CoHvX8MEBX4PWaz4zqj1F1yWgxRwfUqbOhVZx8vYppbzvGVi9yop5V29xnxji5yt5CtiWKlox++XBERTlNsLzwvQiM2qBbYNNMW20uhu0cb5I/q3QnwZBcwfhQPJVwzQfThFj+M4X+8/w/u9MjusNkvbJGgtcdKyBKX5vUdKoGaYe81xrGx1C68scO4BtOCD/wbD5G4DIEzvW2KAjrYhHHNcdQs9t0Bz/TV4z+pmZh6TNXeY9IEG2pKVcrd2qYNmw0HtTTyC1wXDtDWX9M1h2aLmExySJ4mQa1nTDbnufM9GOw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB2488.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(55016003)(107886003)(83380400001)(186003)(26005)(6506007)(9686003)(76116006)(4326008)(86362001)(66556008)(66476007)(66946007)(8676002)(6916009)(52536014)(38100700002)(64756008)(66446008)(2906002)(38070700005)(122000001)(41300700001)(316002)(71200400001)(54906003)(33656002)(478600001)(7696005)(5660300002)(7416002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ehk/AsM9N0D1GwMXzWeFVGYQIUBri/nAMYvIu8I68B8cSxTkAnIfLKsVOFSm?=
 =?us-ascii?Q?TwamB5nx7rSVrY6x68UiCEUcSPNDAKT2x5WgUTq3U8Wr4czX2zAV2aniAy+W?=
 =?us-ascii?Q?FiZJ8iWuLOCx1Ru50I+qCq/xfh1TgwRioihTb3x05QQydZMWzhseP6+c8Rf8?=
 =?us-ascii?Q?32GbCa2FQQW0dd+kLGoBcksvyTj5o1RdHV3cAo1ScjzhpkN/DFbzJF4EWIID?=
 =?us-ascii?Q?kZkxvjBxr0A1CPjcFKABIOGjOAbjrNkEDkSPupCaxwPCDp/TjgWGOKDviPjo?=
 =?us-ascii?Q?AnuletKr/v9sXUS10x4IlcCU/lrKM83h1LqSBCVHKJITaxVIgbt0HYzBNWzl?=
 =?us-ascii?Q?Q0SUvS4IlzAuYyy2WX4DUaVA8kIbEuxqdq1AuaGIoDoxZffq9q3ii+UDXQ0z?=
 =?us-ascii?Q?1rX2V2NSO8e3rlTXavk8lBBP1DcaKaU5KaR8sUkvx/Y2ud/+4hWi1I1G1Dov?=
 =?us-ascii?Q?loL7xFzeHdvh28k28fwS/fMsqz9HXXfVsGEorbJTdjlb3wKJj9yV0/3ZRYEf?=
 =?us-ascii?Q?Bk38wN0WI3kSKYG+jbF07GctKZ31Z+5nSgxQG+0z9+ODX1RwWWIRrwKmBw7W?=
 =?us-ascii?Q?UiGyFxpmOGnXvqSGx871HonUbOZfdcBkGKvj2umbbKvvtkFTE/3qwqNtjxaf?=
 =?us-ascii?Q?vuCHOZ0XbbKVHHOHB0+UvSr+JCQ3sOqLw+7GR+/bX+zdKMzvU0MLNZrPAeLJ?=
 =?us-ascii?Q?uOhAwXbXZyNZEZ/LzPfpsiQaPaRUY6HAKurXpurZ2vF33Aq2AjPgTmODKtNK?=
 =?us-ascii?Q?qOlzizPSmmSA0iJC2neHXAdaJgQCs7jG+HiTuqTSlKw0O653s+nH/gyOL4WQ?=
 =?us-ascii?Q?ujoAJ+I23niEYEcZ+wAhk0PY/yCBNvUDFkjlB0AGTD60I3BUcliIXK8q/vap?=
 =?us-ascii?Q?Qj5WgJ94hZX03M0CQjdD2aDfV4vqB9YukLOVoe7m/6rmm++S9WtZXN5WHdit?=
 =?us-ascii?Q?ADGEHGVoe2jl46b7ABUIpNiRao+SsFy6DfYKP3L70sxJpc3pUxA5YOoQbJGU?=
 =?us-ascii?Q?KXkFvT2pc26M9yY1kZWuFbm+iRVAH6eKB1gTVzKVnzQlSs2Bz3CPgygkArO7?=
 =?us-ascii?Q?cSchqlx79Mhf63S1+nwafj4j6GMDq1kYgIVBmYYG9gE5os968Z9j8tDFbafJ?=
 =?us-ascii?Q?UnJQPj9gdNvUk97us7Ggul3FkgV0pbSlDBfk0Rs/qJzDlt/KoFVSC0y4ePFt?=
 =?us-ascii?Q?sX0HxLUJIwxcic9sGA6jFUziSM/QH/CXsEdKeBYtivrrKtvTHggf38nFu1Ko?=
 =?us-ascii?Q?5a+Vrs83NRQ55UB8ocOHmamaj1TlZYNasMHgMVXQxGMTDwYMCLlDP0yAHG0O?=
 =?us-ascii?Q?yBILUKe7YTGmWBbOt1YGtZ7fe5c1tu69YKLGBtGr3JCVJSQdcrh7JH3ghv+Z?=
 =?us-ascii?Q?23bGmwum0Ec3YdmqSRcH1LArFvcmhQNzT5V96/yGsodo2pEmbHPmLl30KAJ5?=
 =?us-ascii?Q?ZQgHZTg45GxDz+g+NxXNxGZrUqyH6jXIu2W4V2apzuT2hoKFs9D5CKqDrupW?=
 =?us-ascii?Q?WjmMZ6Ty8Y+gKTAM+gZz2sZd49SCNHBcS7QIFkKlXLFW8PNs4du/jvRxryEp?=
 =?us-ascii?Q?7lk0d+6/44fArM07q1KpToyX07tglHDmdmVss3yE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB2488.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d8ca37-b221-4311-69d7-08db351bf161
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 14:50:33.2965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wVaLx99VDpKu9jfrz/hBe4KdBIobOcsDhTt6rUFDttKn7VBaJ2yMIGVT1GDOfL9Wugrcj5mFoa3BKUhizcC5sfRGksFs/lkxA9ggdeqETs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7113
X-Proofpoint-ORIG-GUID: ED5QqXxe1H9m73hLEaKFJN0PKrHDv4al
X-Proofpoint-GUID: ED5QqXxe1H9m73hLEaKFJN0PKrHDv4al
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_06,2023-04-04_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304040137
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >>>>>> +  aux-voltage-chargeable:
> >>>>>> +    enum: [0, 1, 2]
> >>>>>> +    description: |
> >>>>>> +      Enables trickle charger.
> >>>>>> +      0: Charger is disabled (default)
> >>>>>> +      1: Charger is enabled
> >>>>>> +      2: Charger is enabled with a diode
> >>>>>
> >>>>> 2 is not an allowed value. I asked to drop this property. It is com=
ing
> >>>>> from rtc.yaml. I also do not understand "with a diode". So otherwis=
e it
> >>>>> is charging with, I don't know, FET?
> >>>>
> >>>> No, what is not explained here (and maybe not unsterstood by the
> >>>> submitter) is that the RTC has an extra diode so, charging will alwa=
ys
> >>>> enable a diode, select a resistor and then have or not an extra diod=
e.
> >>>> Figure2 of the MAX31329 datasheet is great.
> >>>>
> >>>=20
> >>> That is exactly why I had "adi,trickle-diode-enable" property in prev=
ious patch.
> >>> So if I can't have "adi,trickle-diode-enable" and can't add an additi=
onal value
> >>> to "aux-voltage-chargeable", I am not sure how to add support for the=
 extra
> >>> diode at this point.
> >>
> >> Ask the person who asked you to remove adi,trickle-diode-enable...
> >=20
> > That was the purpose.
> >=20
>=20
> If the earlier submission was clearer my answer would have been
> different but note how I had to dig up the datasheet to understand there
> were two diodes. All the trickle chargers have a schottky diode so
> "adi,trickle-diode-enable" nor the commit log were explicit about the
> second diode (which is a regular diode).
>=20
> aux-voltage-chargeable is enabling a diode on all the existing RTC
> drivers so instead of trying to make me look like the bad guy you should
> rather thank for taking the time trying to get better DT bindings.

With all due respect, I am not trying to make you look like the bad guy.
It wouldn't help me in any way. It is just that this is a non-verbal
communication channel, if anything. I didn't think "That was the purpose"
would sound rude here and my apoligies if it does.

I am just trying to understand your expectations and this was my interpreta=
tion
of your comment on v4. So, "adi,trickle-diode-enable" it is or should I cha=
nge
the name? The datasheet doesn't say anything but "diode".

Best regards,
Ibrahim
