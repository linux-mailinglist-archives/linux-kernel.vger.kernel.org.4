Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322B85F44FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJDOAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJDOA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:00:28 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283A65C9D3;
        Tue,  4 Oct 2022 07:00:26 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294CT2if024545;
        Tue, 4 Oct 2022 10:00:08 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jxjf735c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 10:00:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1G+8i6GrF4PAScUpxYf5wZzIHXPn5mTGDIi+x0IszMIxsQqbb+PPpHhIDg3qGqKQ4CkpIevCNamshaq0PIVRHWHTuw6PGw5GJlcsj0mVHD/+PPWTZGeF/VMctLadPs5HqS5zuD/8a6mV+xBIVsIamjagh30Ld+xp85aUBRsw+uY1Ww7oxuBTVygqrOOPreh2nV9/u64t21L0hyP8uPPK2yM9aWiiXezmPB6Gp30kv+PmBMGh0aeR9RdI6sJvFZPXIVBsgTw97wAQZJLGPTpcs9BK6SvhF9GoL40hBvGQgp3Ej6ClVQjJOS021czXL6AfNcmgexYrbMwRND4qT81mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaoHmlbzToQ/7qReHBQIU3AiKYOEzc5in6ou7Rp3aww=;
 b=GzYgXW+p/xo+Mz9cKFRGJX7d8ZWtqbFn74Cd5fbiFXEEi1AANN+5mo7NotGmnq3nxH4wCE1Krfjc5yRG/qVvy3nBGuZriPjW1rrJBE19kwc6e358z5aHeJLmAkHzVwk1P1e+DvB9ynSHEEXqN0OUdyC/RmmLQhlXppPxqRJQLpcRgXRUPI18XKpLauI8RGeWtPfVEEKId2DsXB1rRJtkIB+tRtGmHB4Z/f7Trh3mJG3neG6vtl9zem3GADRfiHWSK/QSufmi7Hv1rEYK0VY4c+lhdBDdGDTsh6HMPeOt1zS0zMLG/j2rUTL90ORA2ccyEyYGwxcDd+GNz8IeQl+xlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaoHmlbzToQ/7qReHBQIU3AiKYOEzc5in6ou7Rp3aww=;
 b=Exp3HGRhIYsa4ljqn7dGtq8JI7ukIVzNJLVs77NEnbq4YllsHG7KJqIolFaQgkY6VOC1HEZznUm4WK86NrvDhD6B517OOwF/IO+lKDYiF821eLVg3fuydFmPrBJV8+pFlans3daArVxLXircVh846WCQjX/oz+ze+xF4gxUa8/I=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by BL1PR03MB6024.namprd03.prod.outlook.com (2603:10b6:208:316::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 4 Oct
 2022 14:00:05 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9%7]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 14:00:05 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Cristian Pop <cristian.pop@analog.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/8] dt-bindings: iio: imu: adi,adis16475: use
 spi-peripheral-props.yaml
Thread-Topic: [PATCH 5/8] dt-bindings: iio: imu: adi,adis16475: use
 spi-peripheral-props.yaml
Thread-Index: AQHY1+hmE4X9r+78okmFdPDTnRtjWa3+QzLA
Date:   Tue, 4 Oct 2022 14:00:05 +0000
Message-ID: <SJ0PR03MB677852B8F725CE9C23CDAA0B995A9@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
 <20221004115642.63749-5-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221004115642.63749-5-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZDcwYTQ5NDItNDNlYy0xMWVkLWI2YjUtYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XGQ3MGE0OTQ0LTQzZWMtMTFlZC1iNmI1LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMTQ2OCIgdD0iMTMzMDkzNjU2MD?=
 =?iso-8859-1?Q?I3Nzg0MDg5IiBoPSJsS21lcW4vVFRObU1YcEtkSzFqazFhZW1PTmM9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUNaNDJTWitkZllBUXpyUEpZcFFScytET3M4bGlsQkd6NERBQUFB?=
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
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|BL1PR03MB6024:EE_
x-ms-office365-filtering-correlation-id: 9b55a903-1d4f-4de0-669f-08daa610bd6c
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tlCncV2NiAJ8T6AWyjYnvanAwmpKizffNybtG7iEnP0buI7Uj+QWsB/f1ZgsjiVg87ghgwwXo6sU7UkcYQtXPK4gY1aj2AnDx2z1uV2b8p89RpO+sWewSnSoXgqlKnUGPGYvVeJp5slI8ysA4BDc+SJNUXC0kIP0fN6YvRrf/iWUjxODIeqFEKdd3nuFJIi8+NvGqQPCh1enTbhub+A69zm+eGo7lFTbv7wLE2qqEymZem422xYHlk5699bPwicL+qFuGJAbyYCccJ5qUm+c4zz5+GlOmYPBtpqSSZXYoFhm09oivDBTwLk3+J/jGWOsZnW5yMFqSB7fQeVMVrnuwN9IAItaNYrdPb7mZanTXxxYc97EiUkMfzHOlSn+sMbcjGNHjUk+ve+FBMdzEi3Sr49VV07S5ySgiKrNlgzIl4+9SO/vHk5XbWkzd/ona1ERtxirVwbMrq1X/EFgRQvgPl91IUDPScyfNmbN5MlPlOyOr8Ay6F212ceEXbhk4t1yf8gGp3ZWRhLmPZqDVRPWdTGsLyIRRMlU2yZ7Oc7muSL5m0RacZEgTO0hy+rXN4NvsUDo3NBtYwL7pgO0/946sI737RIbtXjd4PKzoTKu+DHbswAtKYQlIKWP/4cIwkOWYG0heLR3FoHVbmsMP7Rb9AyjB9KUQmDh6eo8Tfw6iEkQn1j8Fl/bmq1DTuw4G4cGThgBi2ut19TSQakzgBCbIOvC1p7/6eOCtZFt8flxj0AimeO0Gxtwcs0pT0ILPLIIXwzAmG5FMBVO96KYRLmpltaF9JKJHrlGsceLa+941S8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(186003)(921005)(2906002)(71200400001)(316002)(33656002)(122000001)(66446008)(110136005)(478600001)(41300700001)(66946007)(8676002)(66476007)(76116006)(66556008)(64756008)(55016003)(53546011)(7416002)(9686003)(38070700005)(4744005)(86362001)(7696005)(6506007)(8936002)(52536014)(26005)(5660300002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vpd3f07mNnVauz3cE5CHrhYDxMx9UqbO771BVz/Ct2Qo25cy3zQhHlyjoa?=
 =?iso-8859-1?Q?eGlyytATIgkXPFbQq5sQQDBvni8Ew+Pg0NQLOe4vTPGAVOIqC2lF1VKgT2?=
 =?iso-8859-1?Q?owsdP02FD2tggf/n8tsCW6qmJtHQhNTzc7uvpSufSbklrfrWmLyK1x6Rdk?=
 =?iso-8859-1?Q?WSKSGh59z+qdE0fyg2V3frEwP01BptVwxkmwb2nvO9MSHCRabniIFAJc3t?=
 =?iso-8859-1?Q?wI/r5oeBwXnPQJ19tivtejMsSmbIoTcr2UbPBJPIPERFyZC+kzSxaVmiKg?=
 =?iso-8859-1?Q?3uoK+huUbqpuSVVSHSbxNDXa/MK4O+tDMoD9qQCA9pkUESugHW5ZBtjChs?=
 =?iso-8859-1?Q?F9z2AjcbHbBuhu/3ZZlpMxdLxKS1jkatRZFx5p2R0JEu7oYn3f7I38qv68?=
 =?iso-8859-1?Q?nHhPhQeNqnpc/arR+6YpSauByIAl2f59YangX/iJJWb9ID62DlRGwuh4tJ?=
 =?iso-8859-1?Q?6u0avrn7PwxGYEldqhR/IvYDqNEHCt0WwGkcHZqnFoOgjAgNDDSiDPRSJ3?=
 =?iso-8859-1?Q?nby/l/G3ZnKhZ7d58AhXNH17ZsqxQO8s0yiPbkJreApaoGhBPu6UCtXb5U?=
 =?iso-8859-1?Q?qihWgAKo1C/SLdAnq2kyKpbmCAbcIymJ5aLIkBsWv0BXKknBig8ykHkqsX?=
 =?iso-8859-1?Q?bdeQnyxGU5jWcP7cRmTCz+6CFP6r5Q96poOzj17ndN29+STTqz+QOpcKt1?=
 =?iso-8859-1?Q?4AQ8Wqq+y+xHUdStoyDNN9M2m0bSqHlzOLEoJSY0Cfbv1M4RfyIK10j42I?=
 =?iso-8859-1?Q?U6nFgyrEjAz2i+Zkiv90XBq3DSXxFmeUhE5mlTfFVfgQBQTKh2FPsikNxt?=
 =?iso-8859-1?Q?QUslcJzC9mrJzZslwEZeANYjqywD1u/YRqfCXRBHlw3OPAeaVZ04xvgURo?=
 =?iso-8859-1?Q?1sQ2ydgIIpHAQMhDMZLeLWB/ycRJTwF9JbZr4tgNtB0XKHq6vxYN3WTyR4?=
 =?iso-8859-1?Q?HfiDxHX+5q3/7SoBKF7nRHE+4ernxhpg1Mz3DAh3G3EaNFhFt6qgf3l1d5?=
 =?iso-8859-1?Q?71d2i30oeGLf0pjYos6CeMP5YT9L1FQMA3C6mplO0B30s3Khm3L7+GWtk1?=
 =?iso-8859-1?Q?Ac359vA5WSFsM+B9DeYMTUxGjHKM6nf2p0WuiycfofJsFCbpKN8RnVDn8r?=
 =?iso-8859-1?Q?F9+8lYeP0/PnkPbk5n71inMCZO/RsOpsxsuMe5utQmV/lFQmt9qFeCZWwF?=
 =?iso-8859-1?Q?E2bK2QJThT/ytX4baswhE9jgfQvdXqVYQif4XvOqPy8Ls1OQ2v6/Xd1arr?=
 =?iso-8859-1?Q?/Ze/k90FN/a3q9C3UkKsg9uKNZJsydGZ2ujMkf0bjjQVxkPkoeIiCljDVM?=
 =?iso-8859-1?Q?faYOlNErFCc/EGr35lHQcDntiAPucu23u0i8YIKvFd68CNQgu0iRMRHoyU?=
 =?iso-8859-1?Q?j+xEhgfJKZgTxAOYSCAY3VKPH36ggBEXjcGBCS4SwzOeMy9UH4elijFqg4?=
 =?iso-8859-1?Q?0OqI89AZGWm7IAdfdd917/JvNcJY6cNUTJdp/8h9ANJFQOjrLFVpmxno6x?=
 =?iso-8859-1?Q?5lg4rN6pgA4F3gjiTuSxKHAvJ68agexxOgtmIHaseQpUAUOQX9ZsrWxbUw?=
 =?iso-8859-1?Q?JdLa+/shYkuLd+c3WDgSzZHZjRK7EIY5nCtLCLr7HmMrmvTWdWOdP6vNSq?=
 =?iso-8859-1?Q?5G6K+Ny3+dQ/XtP/FIixunEd0rRlekQqJA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b55a903-1d4f-4de0-669f-08daa610bd6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 14:00:05.3875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eF3MPO7OmMbGwWMmPIeYN6mNFZoXvR1OQ7Idy3hZi/HvhmyXTPbPffYR1GRYK/6yZlVQBfmnNxfIctwA21HD0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6024
X-Proofpoint-GUID: PN8LoxsI6wp2H5ZJBMuLanC9Itqyquim
X-Proofpoint-ORIG-GUID: PN8LoxsI6wp2H5ZJBMuLanC9Itqyquim
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 mlxlogscore=987 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040090
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Tuesday, October 4, 2022 1:57 PM
> To: Tanislav, Cosmin <Cosmin.Tanislav@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Jonathan Cameron <jic23@kernel.org>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Miclaus, Antoniu
> <Antoniu.Miclaus@analog.com>; Nishant Malpani
> <nish.malpani25@gmail.com>; Rui Miguel Silva <rmfrfs@gmail.com>; Sa,
> Nuno <Nuno.Sa@analog.com>; Cristian Pop <cristian.pop@analog.com>;
> Tomasz Duszynski <tduszyns@gmail.com>; Matt Ranostay
> <matt.ranostay@konsulko.com>; Matheus Tavares
> <matheus.bernardino@usp.br>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH 5/8] dt-bindings: iio: imu: adi,adis16475: use spi-periph=
eral-
> props.yaml
>=20
>=20
> For devices connectable by SPI bus (e.g. already using
> "spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
> schema to allow using all SPI device properties, even these which device
> bindings author did not tried yet.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
