Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA1E609A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJXGfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJXGfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:35:40 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FEC10B44;
        Sun, 23 Oct 2022 23:35:39 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29O4uBSJ025662;
        Mon, 24 Oct 2022 02:35:18 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kcac8bjk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 02:35:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=be/hjEI8NLyKmYQqwO9L/nAEx2XvMcFFKy+3ZKh+RPY1RKIX5UHQUnrAjAAAT+ref4qRT3AX0Zywx2YnpAm8EFjkGDphwzZVP1QVwqCuJ/mCo1EtKOYzhlsaGiQE8v8/2WN7B2pfLQqkKpY0sRFXwX21C/s5tpEQ2dbx1QJmrsxSiVASDORwGaiD5W32mO+PcCMJk5IgrzfJK+54spc5i/7Xfy/gGom4+78OTPyVvo71koj9m6pZZOkr6R/0qSiA5MWaIheCy9F/RY4ih/I4RL7joy8MmFov/Y7pEr4U06/a7U+bMGIGKkzqhd7sDfCtvIQo7pBlff8OUyAVVheNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVjVU/gEtOV87lTN7PetW3Mhb5KurhNH2r4nWynl8L4=;
 b=Lnr8Yvy/a2BuVfZnwPb4GtdwKfxRBDmNiy162E4SgOv8OdRsOkTo+RGwVo4iaQJr73Vd2q4oavapeL1XAMgjD9VraBKFVtyGh9YJyqhGm06x4w19iRu4tZ8yl95lIqC2700brJtyosYcCHHZ35SbBdQsOBl6Qw+P2xtxi50+xPLPq/QobxTeKwff8kK9QOLWvppBMf6kkZWsh+oUIrTNnSJD6QAo0/AFK0AYMJ1uL5x7NEs/hFKL8m2ChkBBVXPu1sy6YIZUHBXlqbuP1uRsItPkozLmujppGU2bS9gspynTmyAlH99f9ZueDJS/l4jcrIhmIg6Yhy/VX3wjkVqhuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVjVU/gEtOV87lTN7PetW3Mhb5KurhNH2r4nWynl8L4=;
 b=YjuKTkPxqXVT3qQIdeKxOHC/0jXOBXRpe3VNbo55l2t4NeUBB3mPuR1BtVi9v0aw2AGhylDY9M8h4dyTTGKarq3/DECbvndgvM8oeq64SigrYaf4nyVV3r+8I2yjbF0EE5IrTYcjTowKjrIHdHAuddSFXL7QGEgpmY38HDsc6w8=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by BY5PR03MB5142.namprd03.prod.outlook.com (2603:10b6:a03:1ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 24 Oct
 2022 06:35:15 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 06:35:15 +0000
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
Subject: RE: [PATCH v2 2/5] iio: temperature: ltc2983: make bulk write buffer
 DMA-safe
Thread-Topic: [PATCH v2 2/5] iio: temperature: ltc2983: make bulk write buffer
 DMA-safe
Thread-Index: AQHY5GLM8zztWnyVdkiJEoSUdoRPya4b8RuAgAErY8A=
Date:   Mon, 24 Oct 2022 06:35:15 +0000
Message-ID: <SJ0PR03MB6778C8AD805504AFBED97E1B992E9@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221020090257.1717053-1-demonsingur@gmail.com>
        <20221020090257.1717053-3-demonsingur@gmail.com>
 <20221023134241.79c52280@jic23-huawei>
In-Reply-To: <20221023134241.79c52280@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMDMzZmMwMDctNTM2Ni0xMWVkLWI2YjgtYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XDAzM2ZjMDA5LTUzNjYtMTFlZC1iNmI4LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMTYwNCIgdD0iMTMzMTEwNjY5MT?=
 =?iso-8859-1?Q?M0ODI4MDQwIiBoPSJqckQ5anBSaXVFVVEzSzFOVnhoUTVmRVVrZEU9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUFJa3BqRmN1ZllBZnk3dTduNmhhRDYvTHU3dWZxRm9Qb0RBQUFB?=
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
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|BY5PR03MB5142:EE_
x-ms-office365-filtering-correlation-id: 2d0a84b0-0294-46cd-2011-08dab589e969
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wnb5pvll/jeQsEUlFI4gNevXmBRcfbqr5K4Dx6Q+RFrHnddlg0K5sWmtjhHQBU2ZmTWE+6cOtJJ8HLEOcMrzkqvxzJswhUaB+rrmd3Wlm2kvs8tA6KCbjRq2EN2MHGKbxU5kdLEeLGU5EL0iKnA2trGc70S/9srfUTvAPJWSl4SU6u+J6DyL33fn0QS7+bOU5hPwe/S1vJDSLmVtveC3CY4BcsuTs/T5C/IsfOHIErSzLo0gz0Q8orRTNy72Bcr4HUlJOnRPzM/aZLwRZmXHu8trkU1gXO0AJCxkh8Dtn/qQyDFCdDzRiHUFJtKpwESN0+I8qXtpFHEHmk7dhKlw+Gv34NuaXZ3H5BLDPAwrL6vW1BTa9uf4EHqBooSIhbkzqJT2d6e29PaUvFVMjXLoWB7hbdn3cGcpX31XlQ9ObYuYG+J/b3kDaPziwqaIEteuITN+wsdJVqDqrugLNVCha+eQbjp2D7fZ92CHbcttrp4K96xYGglVapGXQIucbyF8qn3mrHVswvMqTarXZm9GctYDd5Zui5A+0Xpsu1OTB+tO4oEx+m2f3GIhECfiNHOj5zuuCFL+MOT09X1pOEOdILwUguctByO4dyPfsChsvr3bBdHG2OONmNRsWoKTrRIysleWJSHJzRBVzufbbHJHGbW8Dw+O0tXLphIiKBIN1guZxlytbOb7w/J5/egh1QdmghC0hDqlux/4joO77GUXrheDWJDhugQsH/uu+ZTfyQjYJte2TpwYwks7XXYjA2ZfQSr98FxlIrEN58xTJVdGYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39850400004)(136003)(376002)(396003)(451199015)(26005)(64756008)(54906003)(110136005)(316002)(83380400001)(8936002)(5660300002)(66556008)(33656002)(2906002)(66446008)(86362001)(76116006)(66946007)(9686003)(186003)(122000001)(66476007)(41300700001)(53546011)(7696005)(55016003)(4326008)(107886003)(8676002)(38070700005)(6506007)(52536014)(38100700002)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V3xGI9YsudN45LmTJz9HIyOqmHq3n8pYXXQdHfSh+MgAGNc+KscQNJ1au/?=
 =?iso-8859-1?Q?VRPta4p65UsqaciNvAV+OQUrxJ8Q9SQcbMUIaEl3+/+Y5alUyFYG0XP34h?=
 =?iso-8859-1?Q?YRx5jQTOdei6alV3bVP2UhEYl9GYaK2WN6hMlGW2FublZLnKb7XXkV6XEq?=
 =?iso-8859-1?Q?1b0TDji5zOPxGOQYzen1Ilmy8R481h0QHIqVEOvMTp28dcj8R5ta2oDe7o?=
 =?iso-8859-1?Q?dnAmKno7MW3Q6yxvLsHM8LbCJnHJx4/yHq7XwR1Ot+vx9IwQjmDAY3/yZ3?=
 =?iso-8859-1?Q?d+cnI4I0qpdm4u/hI4FITAYJRUPp9k+uMDgYExu6bThDXM294M4P9CZmL1?=
 =?iso-8859-1?Q?83AVP+chw0Ydb1TyMhaLCMz0i0jigb74MMDazxlE+k3lhEQBu6T9XsQh/J?=
 =?iso-8859-1?Q?Jv8JvGmImk14klXk0FJ5F8riDQD0xg/MQQZJKP4Mg7gXaMGlcGxuDEkWux?=
 =?iso-8859-1?Q?K8Qc7vD9PtuahCBX4GprcBNNYTxXIMflAtATy6Uhapcdrzoe8GVnC1x3tW?=
 =?iso-8859-1?Q?pbgD6MbHjLcM7QL7pSgfdTQYVw/0P0/KDzxldlKJjpLHl8W3odOpOiBEZT?=
 =?iso-8859-1?Q?4c/Z40AOZTRCBL9Ct5iOlWqKi5nxMSzYkmR2Y0DN6FBJHHHkTjZ9R5s420?=
 =?iso-8859-1?Q?9AUYIHYzTXoBj08Yd01csTt8ZmHLSOKuAiq4cFUZtdwm6nqR6P8/ap9P0e?=
 =?iso-8859-1?Q?1U1R9Mna8Nm7vGUUCTOAc9a+lSacMrLL18+uLVNeurhiFGKyXrKGvkUhZr?=
 =?iso-8859-1?Q?/KbRhZUX6ub8U5ulJByVmWbXNNLqJ+v46+o7nmZt8pGDapJCwaciRR3JS1?=
 =?iso-8859-1?Q?uNfeHZjiItf1SWzybxTch28llCssaha4vH33E84thywjJrLm0pHS5Y47ZC?=
 =?iso-8859-1?Q?JI+bYuuO1cBhYWNdJJUrQk9BCqFDhF3XIGlHLslmjXSAdF0da7BvD90keE?=
 =?iso-8859-1?Q?2H+sDL+dC33n7gX9RidOXYo3HbQ5rlLLubwQHmQsNAHivXVR5g9R4nNwTN?=
 =?iso-8859-1?Q?3wZj8gzzcqGiBxYwUzp313NCGtayfGTIk4K7ItbQzqZmdTqf3W9fbU8ZfB?=
 =?iso-8859-1?Q?hmJ00YLbmfJ5ucTB6j+MjGAdpG0YDTj6bYKd+sPwamz0xJ3GcXQ+Gg2cbq?=
 =?iso-8859-1?Q?59f+rV9FaJdQa1iFNzto7e+ZrW+oR0Ks1eKUMP3LsBZyFm+oDTxewrtvhb?=
 =?iso-8859-1?Q?AwPkfowfhwSp45HY1MbDFQM+3GEgwA1ClmMCGbHkJdy8BjJszq5/bIq9zR?=
 =?iso-8859-1?Q?Ovo58OjAYYpr8W8TIKQLkbrr82KjuUo66zgCsPaYYKixKULS1+CaQ/9Dr6?=
 =?iso-8859-1?Q?qpchDEpURoPWkJmzmT0DQkEBIb2hO9x3T9kxxBPXk5MJWlIJ21uOJqc4I+?=
 =?iso-8859-1?Q?qkA0QS+kldviPosN9HIMhKBiGE49Hto5HeR93xYuQ+I8qL9HY7El/Xdg9P?=
 =?iso-8859-1?Q?YV9lBzJ8+mOXaIeKOI17o0AofjoZ3szTsIUrUvoqDhg0qMTmuQzAm8UJlt?=
 =?iso-8859-1?Q?SQaALamIfjHzsVPlmXckvo2WeRG65n9hNk0+298yvhBwvChht8qLzgVQcI?=
 =?iso-8859-1?Q?yTmaqXf7U0F6Kpq18MxrbsmEv6Vs53tjrH4EyULEO6/Kkze5eUv4Bl/Lwu?=
 =?iso-8859-1?Q?+odpNWLBoNNdddJ6+mb2upXzyp1OkdcLpe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0a84b0-0294-46cd-2011-08dab589e969
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 06:35:15.7005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWiZy9DsetYsdH9JQ5HB4OymPeeANGbubRQZlIwbYD9NfaxaqFOB9ECIpfrJ0ghiOPDdjgNko4DUoBKJk6lBIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5142
X-Proofpoint-ORIG-GUID: pTCrlDTwMMBJeqnr9r83Y4I5_XYhQbxK
X-Proofpoint-GUID: pTCrlDTwMMBJeqnr9r83Y4I5_XYhQbxK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-23_02,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=992 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1011
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
> Sent: Sunday, October 23, 2022 2:43 PM
> To: Cosmin Tanislav <demonsingur@gmail.com>
> Cc: Sa, Nuno <Nuno.Sa@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Tanislav, Cosmi=
n
> <Cosmin.Tanislav@analog.com>
> Subject: Re: [PATCH v2 2/5] iio: temperature: ltc2983: make bulk write bu=
ffer
> DMA-safe
>=20
> [External]
>=20
> On Thu, 20 Oct 2022 12:02:54 +0300
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
>=20
> > From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> >
> > regmap_bulk_write() does not guarantee implicit DMA-safety,
> > even though the current implementation duplicates the given
> > buffer. Do not rely on it.
> >
> > Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
> > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> LGTM.
>=20
> As you right observed this is only sort of a fix because right now we
> are fine anyway, so in the interests of getting the rest of the series
> upstream quicker I'll take this one for the next merge window along
> with the rest of the set.
>=20
> Thanks,
>=20
> Jonathan
>=20

Not sure if you already applied this... Anyways:

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

