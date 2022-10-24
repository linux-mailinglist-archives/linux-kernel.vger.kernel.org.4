Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80C9609AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiJXGiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJXGiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:38:08 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6DC54C80;
        Sun, 23 Oct 2022 23:38:06 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29O6KLej025725;
        Mon, 24 Oct 2022 02:37:50 -0400
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kcac8bk1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 02:37:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTTmLzs4zkyH0F47vXWM7kyp9ao8gat1ed6eH257bwKra3YlOBsWHE0aNf38g61gV5LScXLE/AabibJFZwMPEUmorgXQvpB+doSfgUoi5WPvQcayJJxF0dR1aB0lorp8PkNBUyB6XLMm24rte/1ztYH3D/2EKMMProhgVm+y1fJeIdgkejAESey38ofZ8aT7FBM6byijvmvLEkw6gvLF43UdWLTHyeSyNSndO7W6ekxckuB1NkuJMYJY1A3tr3aB2NZ/XBBCMnswcoPxqr2Ukp9p5C1UjNds8tMYO0gQxnssRXQnf932W3fWBndNlIZDeTXAp6YHnB2+ujYpGKE2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Pyafq6NVnd6/uIWZJ4T+3B8A0wyDdd122f+YiIPsu8=;
 b=nMXlupukcX7+CVDBb4NcQ6djz05GTemX7nNN0QM1YkWVw4D9v9JySOxhQ/gWMmtaruZIIuDOyB7isI67F+lqbA3NLtCx8YSj9kJWAVseJKSwLnIq4VxNHnNs76wGBPj4qBdtEmNGSeJpwfZYUlyf9diAD9qkr503n9opQ3FcWU2HmX8FXQ3+KrT0BnktJf4mA5yncHSIn5//Kasc9bp24up3EBTAA7DIkEmW2NlOBwPypmO14VtZUOXZgMVHSGOn5WDni1hAemtzBf9bfy/NyfjTrPwzOs8OeTh1bqDNqKlcysjA48O6lP6nb6/OHG3SY7x8XdTdOgkGLGp5qDGoEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Pyafq6NVnd6/uIWZJ4T+3B8A0wyDdd122f+YiIPsu8=;
 b=WYyPUzXAy6xLGD3FGJSo4fOcJUX2AiKA2i6sfEEN0e3tig22VFwkZFIXrcFCoS2HFSuwQlkufB8m982kWrWLGWqqzSrpUIaVBt5WvgRBuhXV4fEiLJr2yJOy/sKK+B8o2W9rNgl3AvM09PetmahCuoDP2D6VuVXF+J+QBQXAoyI=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by BL1PR03MB6167.namprd03.prod.outlook.com (2603:10b6:208:315::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 24 Oct
 2022 06:37:47 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 06:37:47 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>
Subject: RE: [PATCH v2 5/5] iio: temperature: ltc2983: support more parts
Thread-Topic: [PATCH v2 5/5] iio: temperature: ltc2983: support more parts
Thread-Index: AQHY5GLRGm+JvEXJGk2vN3w977jNDa4b9G6AgAEoadA=
Date:   Mon, 24 Oct 2022 06:37:47 +0000
Message-ID: <SJ0PR03MB67789E3D236E6AB8E3937F59992E9@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221020090257.1717053-1-demonsingur@gmail.com>
        <20221020090257.1717053-6-demonsingur@gmail.com>
 <20221023135435.17cf55e3@jic23-huawei>
In-Reply-To: <20221023135435.17cf55e3@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNWRmN2VmOGYtNTM2Ni0xMWVkLWI2YjgtYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XDVkZjdlZjkxLTUzNjYtMTFlZC1iNmI4LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMTQzMSIgdD0iMTMzMTEwNjcwNj?=
 =?iso-8859-1?Q?U2OTY3MDA3IiBoPSJza1ZqL2FnWEZVTnRLZWpsaTdMRFdYKzMwaTg9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJma1ZJZ2MrZllBVHJ0Zk84aGdtOXVPdTE4N3lHQ2IyNERBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVg1bDJLd0FBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|BL1PR03MB6167:EE_
x-ms-office365-filtering-correlation-id: 3f77e9a0-936e-43d5-209b-08dab58a43bb
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I3yfgIl4DdbKcmT5keExCrbMOicgcc9Sjy8N4dJellHl75lCON5HSDtcuy3k1qrO1cEPLMbs6DVUloq98pFi2qF035zehhdA5VsripCoBzIwCgge/sClaIT4U3MTy/41WZpXHFTjMMUDyXOmjnvGaxEf5jIx2b/bjvuq5E3Ll7GrKS2pYRosQCtZRDDTKvHibz8HzS/eRg/EQPAo0OWdHyzezwo5kX8GYMikkbB6p05ZqiHIK97kbCdXjJQSTNUBWsXx2TbwyhvI6pzaSAJ73gkAL4ZW82dR4N0pjtMfFhhQ+1XNODBVzKJBV/yK9FbyCMrE7WeQ7jCG4Hcw0TMZJACWXCcMJ582kXPIxfKk4/QaMk8Rvx4/H3/B1EZW3EdoCp6P7BUP68wCj4lqWTqRG8o2CSHIjHKTW/iiK/CppE2/uGDhKkvLu7D3nWULnRoV7rpQLNOpLfXznEIOjhS8szTke5j7Q5DO3K0JFuxdMkdyk2WlRycX1KMA99qroD5IIvEpYB2/QlUnTEC7dnrN9928LKfGXwk23Gnbdf4NOqQDw8qcdymJdA/AI7xlJPGK3MuCiU/GJkCfYXF+KyB4BKJIR9IS3uq5p6dB/j9eVUClQQIC17q6wiWtj9Mx4osjMAD3n/kqW8sj/z7ZOLgYV+0gjUC8XL/OmH/YA1uLN5zWicnz6qqyS2V/HiJ0eyHcLckG5oSHf1KpaW2y4wMuCLZsiuvgXLxh45QqqEb/919P/mxxVj1DoVfe30dkyEQuoX/OlmiUZF07yQQnDmjypQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199015)(53546011)(4326008)(76116006)(66476007)(66946007)(316002)(6506007)(66556008)(54906003)(8676002)(107886003)(186003)(66446008)(5660300002)(55016003)(2906002)(41300700001)(86362001)(7696005)(52536014)(64756008)(26005)(8936002)(33656002)(83380400001)(9686003)(4744005)(478600001)(38100700002)(110136005)(38070700005)(71200400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7M+Jcr6Lv2JkNE8ePpXhNnZBZ6uffecIawssthf4Js5nmA+Z6ZiF3RxSvU?=
 =?iso-8859-1?Q?4RZw20fgcm+FbyCBxYEpAsQpb/XqsPBVJsr3v0n3diXsg8yyooNyl7pGSF?=
 =?iso-8859-1?Q?dQoF2fJXeuz3zrecj9w+pC3n9oIk/3zl4mnplC+EcSfhFaX/koDPLD8Uiq?=
 =?iso-8859-1?Q?LDSmdMHkS2bT9yMhpGMK72VRqWcxh2ekks5xUZzSwaV8Z3FSfNeKcR2m2l?=
 =?iso-8859-1?Q?XwIybngEpB2LhIj0lNdaRRY6fQGBTdKVDFG4+Ds6QS10zGsdUYFKdqo1XY?=
 =?iso-8859-1?Q?XDEDKbanuuJLClSgBpFTvqpGG1Q0cYR6LOhTYkHBs+9eV90dk1P6kpamY8?=
 =?iso-8859-1?Q?0zlE7md/jxRwYhbgMD7r5hJg9wsOu1RRrdu+5Tyk2dJAEpZVQsepBGC27k?=
 =?iso-8859-1?Q?2159QShEX45v2hNctPGpwzhoBaLO74e6BuatGs+0eanPsjRmNy7uAMW6L1?=
 =?iso-8859-1?Q?vHnRrI6IzN7TPifCGvYuIFsZ/1AM/iWlDBSEzJUVaTpt5ZV0LUqzulShCk?=
 =?iso-8859-1?Q?Ey4e18YS5vmAp6uPk88h/ZIb875J2x73LdAOwOvZ4jELEbH8FL41wUnG0V?=
 =?iso-8859-1?Q?QKYR+K3GYjCequ0X/Q8XTgi9g4yJactPDaVRsXU0HNGI58LnOXQg50lCA7?=
 =?iso-8859-1?Q?S60SyeHZGrZgYlQD97QdfVz05qd99zAy50o6lLvvhoTVLTqqTZzbPoQ8vm?=
 =?iso-8859-1?Q?6o9HJRSeIEP7ZfMNQWLuaEyx7b3r6l2u1xBCo8QUAadfOGdOPauYv4WOtj?=
 =?iso-8859-1?Q?5XySZ/4rBYaPQuNZ4ZbqFjFFJAh7OgNO5lRVAiEasS/GHbOnPqb/OD+IjV?=
 =?iso-8859-1?Q?VZ/2/7AdSJwX1HAg3ANJLuBHb1rcqcuAAe6c7CSatV/LHOD47PvC39cK1V?=
 =?iso-8859-1?Q?0reYQi/nzWRg7sr3+VXOb6Z4D1Md38FTKiU8MaaKl0bVTMptuYQvSqkt0/?=
 =?iso-8859-1?Q?TxZ5paUGNghyjHg6YV5CNlweohfeX6fEeNMF83ziSY26OcFTOL3NmULyFu?=
 =?iso-8859-1?Q?QR7boWMBItzpNgWN3rT2ydcB2Izz4s71awRqlkYCjpKCA5vtXFTOlnNyu0?=
 =?iso-8859-1?Q?mDgEg1ylvar6pQ16FioxLmYeqNhghFe438wOPaQa7Hoh0jQ6YzKC9PPVMY?=
 =?iso-8859-1?Q?k/bVQHsKP6OQZX3la0NSWIzMyxP1GJmXoEPhOgffGJQWgdl9Iby5pIqpl9?=
 =?iso-8859-1?Q?TcyqzHdIo6f3fx06Z2zfhzPdbkv/bwl0yc3NWvMJx4BX41139CDHXhPk6K?=
 =?iso-8859-1?Q?L43XRLxH1JCPBovf3t0oJWAFRqDdrj22CmqBqRRHLeA4HvemRSox70idr/?=
 =?iso-8859-1?Q?eSMLGOLrSchH4BrG7kSNPDraUaPzx4DaUQO9oMJcqhaZXJyUxFw6hywpms?=
 =?iso-8859-1?Q?3CklWBJNFrYZnJv8oDmwpDVTzkHTsefmzUbGTbVq4HvSjUrVe1A1ubE9yr?=
 =?iso-8859-1?Q?gvxLTeTaZtebF2nMXYkcFlFGRlZKLshRec2u/HjZ1ahO5TcwqFvbJABW6G?=
 =?iso-8859-1?Q?QHrVPZPqTD+GeywbnjWKJ5TI0regrbqs1pFD8k0Kmj0UrdTgRoVMspfZ+Y?=
 =?iso-8859-1?Q?tqRRsQZQyTcGuR9r/RD113dLUDxQdV6WTBpPMOfYqnc3n3Hl139AzyN1uV?=
 =?iso-8859-1?Q?doJBuRqtPVvITBzrNqqRdvZ038miz3sctd?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f77e9a0-936e-43d5-209b-08dab58a43bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 06:37:47.2485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7fWKBe/M5qWjGtD3zlchZ4A8avfPfybl7YjaG0IiQcGsLN3XaEJhbj0QMByziczd55Tfwglh3dX6nDllE7PjhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6167
X-Proofpoint-ORIG-GUID: eEuNIsy_WapNTA-wNZAddLIcK0qSnQxv
X-Proofpoint-GUID: eEuNIsy_WapNTA-wNZAddLIcK0qSnQxv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-23_02,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=993 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240041
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, October 23, 2022 2:55 PM
> To: Cosmin Tanislav <demonsingur@gmail.com>
> Cc: Sa, Nuno <Nuno.Sa@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Tanislav, Cosmi=
n
> <Cosmin.Tanislav@analog.com>
> Subject: Re: [PATCH v2 5/5] iio: temperature: ltc2983: support more parts
>=20
> [External]
>=20
> On Thu, 20 Oct 2022 12:02:57 +0300
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
>=20
> > From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> >
> > Add support for the following parts:
> >  * LTC2984
> >  * LTC2986
> >  * LTM2985
> >
> > The LTC2984 is a variant of the LTC2983 with EEPROM.
> > The LTC2986 is a variant of the LTC2983 with only 10 channels,
> > EEPROM and support for active analog temperature sensors.
> > The LTM2985 is software-compatible with the LTC2986.
> >
> > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> LGTM. I'll pick this up once the DT binding part is resolved.
>=20
> Thanks,
>=20
> Jonathan

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
