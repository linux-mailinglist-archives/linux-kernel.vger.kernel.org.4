Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C23745CB0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGCM6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjGCM6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:58:42 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6642CC7;
        Mon,  3 Jul 2023 05:58:40 -0700 (PDT)
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3639c83Z016362;
        Mon, 3 Jul 2023 12:58:22 GMT
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3rkuvegp7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 12:58:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nv+emZvX97yqxDIsEKIX6uwzeu31Q70dCjpummMKcB4qJ9pfeQers6O0JZJByo3voSKxVay2Bz5LDXyGB8iimf/1ZX67S7uPDx52A/1X6wc922XF170uxXxXsrcZpsL/DaGVj5CdOuAB5uMSxCcp2G+yHfLO3glMy3Ep57xda0V0fulG7Oa2Yq8zNjVxWszhTEfZhmvzUAhAoJAGk0l+Mtmf7w7QxdB4+RCaDnhT9k8h0fC6Ab8hdZGXQmzkyzrUeOj4Q0aAAZRHQRl1c8N2JTq0Jj2a2R1AkRWlhRP3sX8SYSG7aqqOPO1l/nNWIzJTrqdUvP9SSNGvVRPQxXAf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8lap7lEM9WPmALGnKwr4eWmUnGT2vi3VOnOhim9e8U=;
 b=k+MDK2mPnzkmLFg+KBaS+KUlpnKOOC0/69odDTszkXKwPslDp0YntJFQ6DRtL19KgubGKejmXRyspOQBGkAdCbtOZiTVqGpONWvNZ2E979ommzYPAvfJAGZq8PNoAi+JcpdSBODwktze23ZxitbBk++vd3iU3wmW249Rr0kYqjLgaZ5jX3+TkNPFl8AgGtJ9WGULoYe4M73OIyGs0wTx/+2OVCGBzAFxOYOu1/xBASBK170eD+uRtJXEX/16SHDsYVdv7fa0ySpQjyEi0ruekT10MQGM4xfB9XsxbOul1zK33jLy1by1zVA8F9wTsnsGx67IPm6Z0PbxPVbRY8N+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8lap7lEM9WPmALGnKwr4eWmUnGT2vi3VOnOhim9e8U=;
 b=dTHSPadAJXrgSHj8Kw2jAErrnko+wJt7papjl1FCi7mT4yBxiGOxiuwTyrVi4PiVzorHyftH9wEp1Xl1bE/1m+Twt+wuLywMOVWYO4FCxKjzH2/BBl6D0eNg0VcBcpQ6hMUwF/BZxhAzO7LSBk9ObG6s9WW3dyYZCOT6CLie9R1PDsHWNNryEFjI7w+xF1KsCrKgEWN4jOnhLolQOjXZWcqOvtn9awV0+2sNyiAVvibwezNsEDwMV8jtPmLaw+iw5cQz/SgLAQHEwGlSDeNkRVkIo1wXsF3sBSOJM4zBiQgO0cCReJzl4jgCvXe2zrwvT25JHeGUZIODDDBpN997Jg==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DU2PR03MB9942.eurprd03.prod.outlook.com (2603:10a6:10:46d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 12:58:17 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::528d:e0b6:ecc6:25e5%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 12:58:17 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v3 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHZmJMVbH1082dFzEWEKtwTiutfE6+jTPOAgATd9wA=
Date:   Mon, 3 Jul 2023 12:58:17 +0000
Message-ID: <20230703125816.GA373048@EPUAKYIW0A6A>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <ZJ6wtw7mz/FjBcx6@e120937-lin>
In-Reply-To: <ZJ6wtw7mz/FjBcx6@e120937-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|DU2PR03MB9942:EE_
x-ms-office365-filtering-correlation-id: 38e4df0f-f86a-472a-0405-08db7bc52b83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HX4TsYPoJESEjFv/QZxnkLhlDaKpHohKSGYQh0oYBOILK0SzOBA+kooCF2zQmmfjBUkflG0nlIoYudkHlgnTYdxogj9v3V0yYXeJZqD7o38k3Nfo6WXViWjq7MuVC7i0OfQyKNIxBbOxFT4zW8H479C8G+AbZV09YW4c8dxKQzIvlEHzew7qo4vX80GYDZGyXl4Pd6wzPJIkhsBn992WoLv5LVffJ9lFgMqZDI5lVtjdiTDCW5SsSf9T981r4c64pezP6Tw6NjeBbFnbV4WgSfTsqGZ/16XcNBTx/SQh4BupVrCehO6uDnZPDvONKxL5/zbUOiKXtaHa6ODCm6l0uSrIeWeuNXMXS3De9/HD7yxRZV/4ncPtdZTx4LsDMDP3l5DJwoobsi+VvMUFDBhNODB9XfTVJkxoxg7sZcN7Czlp32Va0FoQwnDXZpw8w5aKrPD56gZMQPd6Y/OIw12eIX3up4aBG04B8s1VQYI73ncEncBxMg+tx9lJ0sAJiV4CZOlvKN/un1BZYiAZJacdgGtZR7F91b+90VJ9fTQ0OvGbjBkp3LQxBAwWY9E2AtkHvIs0QICXulmMZ1uM/vETA4PDz5SS5p3PBBnliR/k/ejo43ZPQUX/n+kgpdEf4lHT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199021)(41300700001)(6486002)(33716001)(38100700002)(71200400001)(122000001)(83380400001)(186003)(6506007)(1076003)(26005)(9686003)(6512007)(38070700005)(86362001)(54906003)(478600001)(316002)(2906002)(66476007)(64756008)(66946007)(6916009)(4326008)(91956017)(33656002)(66446008)(76116006)(66556008)(8676002)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jhHBV6ZracnCR0Ek9zTvw2K+iPWZn0vDCuGWb8462QolvCNyQTCsL99Mm3JZ?=
 =?us-ascii?Q?TQH0qmu1y6VfdQtsYA+Bzo1i8Qbs5u9OFYIHIqouDCoXXIohv7QgAIZtmAXB?=
 =?us-ascii?Q?W5bBXH3dmd4VDTTyJCj2io59PWdGwxfpK3oyPimRv721Ylml7qe8hbVGOj3s?=
 =?us-ascii?Q?pu/qbdRwLIbQG9ZDXPX3x6L5MWjyYD9RqbjBBOceXVuJJkcGCGXX2jtohCxP?=
 =?us-ascii?Q?U0lWN3Br2BfRk3DwjOWW9bbDBPRMMS9Z/qkcDuS/jPAxTAI/0D4suhiNHbW8?=
 =?us-ascii?Q?146gWN+FXbFhLYt9UxSG17qTb+241qbTh/xyOTktqM1GGtQhgMmb2XEffqKA?=
 =?us-ascii?Q?iQlRq71fJqAGiqG1aF1RNOopzr1KRfOZl+1b6DBzpbOiSJR3VbFe++HYKHms?=
 =?us-ascii?Q?RNUmZH1+GHZS1saxTT9zS40nFe4Ev/X4nlQ/cVyc/FyqHlFjhwcznZGY6o23?=
 =?us-ascii?Q?G334L9nGkotsY9DzXx604qucT0MMpoZFMhHrInRdaSD9dBLHKHhW+YRlAqwi?=
 =?us-ascii?Q?038Rr1lYpVqRNHXG0kmD4lgaXDRGHCstef+sET+pq+SNGQr9bUb1A5LT7Mx5?=
 =?us-ascii?Q?TbJta7CWvCAiv6aH31p3Sg+zUBWuCsOvL6y4QpSEAzg4WeTsOquyqZ1Ah7SL?=
 =?us-ascii?Q?1zP/WJJYOoqs5IlXMsTgBbsMpU7w9KXTl4C/T/pgaGzGO0LITYOhhM/BxSvX?=
 =?us-ascii?Q?BJtaJD0mnB4zvccmUJjmVnHam0yRfHWuEhWAgx96bqAWZ59Jm0py7PVqpmIo?=
 =?us-ascii?Q?odcGxxnxtdB1m4YNeUm//p4lSNR34sRlNJYbY9i9LbBwdmQss5z7zr0pfCIR?=
 =?us-ascii?Q?LPkwq9SdY5qIrY99+VBVN4biQFsgofNgrVNMl9ftGU28HNNx7hwfK4qGk1A0?=
 =?us-ascii?Q?f54zqivh+w0WaZRceD5+t2hPa3iKvDSqx+S6nbDEvQCboKV1pWerj3EP+pgI?=
 =?us-ascii?Q?vSSv+rvs3r5XyRvJA+ZV8p8hq+ACaGxMDj/PYoSj0R66qnmJHrhs1YvciqrC?=
 =?us-ascii?Q?IrCrEbmYLVpjIg2MKJRNelkfevkWMSW/cIb+k2kQA+LdL5NHdDeuuDtllRUW?=
 =?us-ascii?Q?9MCaLmTTumQ3LnR4x4S10BD6a7W7tcnBVX77aT9is3G4k2iUT/hxk6H00/T2?=
 =?us-ascii?Q?8Rb7CpTA//OO9e+VGj5KrYBuA8a6LTPeg3+RiSbb4RGe+fYgWAaCG18kkMAc?=
 =?us-ascii?Q?qXGxdq8uZceVMIWl1llzpqklru84yQnOeeBSI2fiMA7E0HPCGl3TqutwV/xP?=
 =?us-ascii?Q?rOxpKM0xVtn9TSQFHWLZ7P8YkN1l8uJPUQdyTJIpMq8GIBaPCCmtac0BPf5O?=
 =?us-ascii?Q?s2nD2aBjMmNQJvUKPP2UdZahh6qHyW3erqwzUCmADb28UX4ZSDXyPGBJRCin?=
 =?us-ascii?Q?yEV+sLQlr2c8trPlmYKLmF/Y+upu6x/eVZThTs6OQpTIfN4rYk9xTl6wCh5U?=
 =?us-ascii?Q?aXpi6sNRlm0kmkKRqJM2eJU/ypLpYD4H8P5yJF1OrJFtgrgJJa+e+bAu3yYH?=
 =?us-ascii?Q?H0Ms4Cf83Hd3zjw6qTISdYHsiFdgzeRX/Bk9sVrNZSPY5ZYyG5kVBfhsZfz6?=
 =?us-ascii?Q?q4zFWvkywvqoi6mJRwUaE24kQtRXxG6nqPlsL6BfkFT7aTo3cJCFg+ej53bK?=
 =?us-ascii?Q?jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FF6A4A958317441A4DFA08248CABB5D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e4df0f-f86a-472a-0405-08db7bc52b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 12:58:17.1832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qabUFApVvsweI2WtKjtr32n/owZeYFufzjuHKGg7GJrxBaKTgfcdBTk58oBcvJEfxgt2oMileDpKRfoUMp6aD47Y9DiptXWEVH/hgNbqpyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB9942
X-Proofpoint-ORIG-GUID: ylSoMGu81qsK9N9uB6PFTYjHkd1KC6J8
X-Proofpoint-GUID: ylSoMGu81qsK9N9uB6PFTYjHkd1KC6J8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_10,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307030116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

Thanks for the testing and for the review.
I will address all comments and v4 will be with v3.2 BETA changes.

Best regards,
Oleksii.

On Fri, Jun 30, 2023 at 11:38:47AM +0100, Cristian Marussi wrote:
> On Tue, Jun 06, 2023 at 04:22:26PM +0000, Oleksii Moisieiev wrote:
> > This Patch series is intended to introduce the potential generic driver=
 for
> > pin controls over SCMI protocol, provided in the latest beta version of=
 DEN0056 [0].
> >=20
> > On ARM-based systems, a separate Cortex-M based System Control Processo=
r (SCP)
> > provides control on pins, as well as with power, clocks, reset controll=
ers. In this case,
> > kernel should use one of the possible transports, described in [0] to a=
ccess SCP and
> > control clocks/power-domains etc. This driver is using SMC transport to=
 communicate with SCP via
> > SCMI protocol and access to the Pin Control Subsystem.
> >=20
>=20
> Hi Oleksii,
>=20
> sorry this review has been a bit delayed, I tested V3 in my setup and fou=
nd no
> practical issue. I'll post a few comments/remarks along the series.
>=20
> Beside addressing pending comments, I suppose that the next step will be =
anyway
> to address the upcoming changes in the new v3.2 BETA regarding support fo=
r
> multiple type/value set/get operations as requested by Peng.
>=20
> Thanks,
> Cristian=
