Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D45F6219EF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiKHQ7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiKHQ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:59:40 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F94F2AFE;
        Tue,  8 Nov 2022 08:59:39 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8Gh2gU016855;
        Tue, 8 Nov 2022 16:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=AMKRNbPb+tWbpjnPj2d51yX5+6ybR2ZIPJO3SV3/UGE=;
 b=hj83wohnt5+gJ45uA7PN+iNb6Ld3ThOigf619ikZ1ANBnqn6h9yti8rzeQ9KUKrwMbPk
 QV8/6n96e894ZYSeAsg89OjCMrpJ2O4HnEoYu+N500AycJIaJyDcjRulS2o1a8ypZfWE
 BQWf1FbhFBKlvzeJqqoRKb9bT3EPwpOJmpHfRHf6sGPYVrXzEym5HR/fW5bIXWSI7i8l
 A+Zmwc8oXFn6vQJXNu9sdsu+kO5kVvmYIdChkFJ9rwlYaDn6w5i/ksCQfWl/QvbgPp6Y
 o5ddQM/stDgJkj85akhl5M4YazP3wuiy5ai4Y4r40QV0U3G3igzof9o8Zvjn6skM3o4C pA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kqtv9g4ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 16:59:10 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 9DE1A295B6;
        Tue,  8 Nov 2022 16:59:08 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Nov 2022 04:59:08 -1200
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Nov 2022 04:59:07 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 8 Nov 2022 04:59:07 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Nov 2022 04:59:06 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drWPESe0JdHrtU1OegcsFg+88jNEi3z0L2oEn15ImCn50O0k9B06aMyTgN0tYBgK3L8Hf/c/Tnn+p5GHxyMMThRhQHhhIMSH32l876ZDpPPRtXs+Nt+arpx0yHaj8+ufjqjhUj65fEdnuFNr6YGxfMpCjH6zwvRyCMUUul/m5cGQjNyXkHu2KULQ1wnU+PLC4qCt2wdHy3H1DIxUT6pUFyARZwio17sI5sskJmRpQoZg88QRzjFFO8L27974HlTe68mfMBkKR0kGbg03gYRaDWiq8PMJZQ54LkHoa+bJIAkntAOiryj98UutE+NwxwwHost3fb1Bcc1zqEBbVs57Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMKRNbPb+tWbpjnPj2d51yX5+6ybR2ZIPJO3SV3/UGE=;
 b=fpwWKih43zLjj3nJdc+ecbxtHUZv+z4OZ9lbhwmPGjLtEE8V5Tn4ehd3+6y+GpzJ6Jz7P2nGMP0Ln7YO25X0HjZXxFwBBDipGTCr4+po0S7zbrq/RZVD4KK2Ubz86X7PPukBSPbVhnbTgYwxlPTrswe3OX40IVEucI2iSKuKeXJD1gPYSny7pOw++PhBKEqy87jVQgcZXGsGlJDX6WTfCzEeOtSFG73powCIerj+4vIARoIND8HUoGmyC5huX/+lYTfkmpRta0iugsWALDB31/efYs2KlJpcz92RWhFAbbUs/VDkNHUd/VAbG/cr96uKoNof0wQkmmnxRHW5lFvy/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH7PR84MB1414.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:150::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 16:59:05 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7949:4505:4974:ad5f]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7949:4505:4974:ad5f%6]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 16:59:05 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 1/6] hwmon: (gxp-fan-ctrl) Add GXP fan controller
Thread-Topic: [PATCH v1 1/6] hwmon: (gxp-fan-ctrl) Add GXP fan controller
Thread-Index: AQHY8IUCr0UALtDyXEemicJgxN8JHq4vL1SAgAYIcpA=
Date:   Tue, 8 Nov 2022 16:59:05 +0000
Message-ID: <DM4PR84MB192759BA77DDC69C61E5923F883F9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221104193657.105130-1-nick.hawkins@hpe.com>
 <20221104193657.105130-2-nick.hawkins@hpe.com>
 <20221104200111.GA2562021@roeck-us.net>
In-Reply-To: <20221104200111.GA2562021@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|PH7PR84MB1414:EE_
x-ms-office365-filtering-correlation-id: e71349d7-fef3-4313-0823-08dac1aa8b50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WYiihYYsez3nDxabj9qCgZUoWaTIrucq9DAD3rMQxLSuAOxSGd0/cJCz3qeNp4fYs0RF88PsNBm2UYIuPHL/WAKRjgAUIZLe3VZ/I9I/csopQPQtZ9gqGvY8BelxK2oiAKqT/Qeb8VLvdf9b8wn38Kmk7NBYE9Nb/tGNA3P67tAbZI7etglifn7L/o79L5JBbQHuiHeFGd3R6T1OLViN1DUVzobaL9inW4MjtcPLlPY5W5uvtEBf6KlDLipueruOK3H19kYvabsDevCXGJMOjWVZhIqW1nN1AOkeKhX3MU+pcHyTtrzU4DFjYlz+U669bHg8+/6Uk0kNNQuKefW4a8GHzqq9fPHXclNMf6D8fmyWhcIY/Yzyd3NwiCMQeWHOL3+O+0bzzoWqodDje6XZhutHSO3cdkKwHNpcps/Nys/oD4kQZrsmP7S4pgNUQ6UTZk37JUE06XuuNtmfxV5yd8GdY+Zg/FCi2pLIQ8WlOTdRu98rrjLyAh3GUFvxkwkrnpQeT9vesbgxR2GpzZDzOnZA+vvIujZ1xre41QHk4Y76HqIh2yvITOu6DBeC4etTJ3Gd+OF4zRQ/Yd/V3Rh3L7rTa/J80a9aRlWz0Vufre6ino4WEAN9DrkXOmK9wnJ8gQbpQxhMWwkJzMo6gULUT0+9TPSbS7MLGAM46qZxM8zgTI07FSu75UDEvOn/797RnoTwqQ2SBHtlplpwXH/KfiRdd9B6gYmrzfcjJKGt3AqnSmPFUeGdVOA4OMa/fnstMhEb0nboSN4hk8DxKCUrMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199015)(26005)(9686003)(7696005)(83380400001)(55236004)(6506007)(122000001)(186003)(82960400001)(38100700002)(5660300002)(7416002)(2906002)(55016003)(71200400001)(54906003)(6916009)(8676002)(41300700001)(478600001)(8936002)(4326008)(66476007)(66556008)(64756008)(76116006)(316002)(66946007)(66446008)(52536014)(33656002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RqTQeAhRJSeJlvbOYtrEkzES9VcavnB7J0PLeymVZsMMWvoe4srdkR8KQdIG?=
 =?us-ascii?Q?qmkGWto4Yqalrva0jcoMXc9LysE+0JtR2xXTRzSaxU2VLB2SRrbKZtLndp1V?=
 =?us-ascii?Q?4nWtMF6jwIFbFq2Xkheo2G8FFF/KQ9k/YOrpWXeFOqS1ZX20Yrobp7EZqYU1?=
 =?us-ascii?Q?CEbp3qLNDEhfC1EdI3DGTkASnT+CDYiqCg4pFBYBgP/2AbcewZINcFlIeLF5?=
 =?us-ascii?Q?8jaHz7cU7PB9aIQqYJ54YP8020ZXsVWBbNvdQSuC5hfZpkvrlyTlG3yt0UWC?=
 =?us-ascii?Q?LCjZjteYMqzsZ2VZDEw2UV55RLLrnW8sWKF+yMBY+0dr8CySa0d2iQYxdq4e?=
 =?us-ascii?Q?Vo/J7BC0lP2Mz5IZfXH0cJxyjAo3Pi7EPQ5/t4rtCWiAvF9U+uPj80pQWXJx?=
 =?us-ascii?Q?CmvalbxN47fdUQVq+NfPAI0xFEUOyQBCQrG+xI5qZ84r0omO+Vm5NtzP3AHG?=
 =?us-ascii?Q?YZzdHZ2OY47e8H3v59FXdtzeo8wdBcbPl+orR7gZE/Zh3D65eECq2kSVm3IH?=
 =?us-ascii?Q?qTPLf376lNQG3Hkeqbbv0TUBAJOQj6zPmUCfKLNSzR0t8bmbSNJWaGq18mDf?=
 =?us-ascii?Q?SfYfMsUhZji0l8aUhbNuqIL2taZ2JOIDBqZdgDSQ0Y5dgpbUaO386jllRiuj?=
 =?us-ascii?Q?urWuE8qKrWATpsj2vMX9PSNasWy5bI2u4UmPHPBbIF4I0eGrVjmyewvGa1U1?=
 =?us-ascii?Q?iCutuaYQ2Li/RSt8Zo2Hk8MbjSfqj672UzSje4F6yxUx1H5qLkAAPo/+MpL0?=
 =?us-ascii?Q?BE81aXHMao4wMstOISkl35lwJpmkUJiURwjzYQJT2g1GiQjz1LJllQZI04Ze?=
 =?us-ascii?Q?u8Iw8va7iXOZJgLHgm8erjx5R6NPs5kUVSDFeeJor1ohd2jggfB+0mxALY4R?=
 =?us-ascii?Q?OJOIUsdu3PmtxvnxMm4s2/KrW0ETYj1dQIcKqMqfrbZmm6e/kkGs7Zt5M2+t?=
 =?us-ascii?Q?Sy/U0WaGlZz5urd9dzSGkhX4iwOWulSHSmJonThb1kcc4AOht1aXm+ajICse?=
 =?us-ascii?Q?YSGI1XPPOYuW6uFyjm/l6jZPYrOBlDDo0xlKUD77HHH1lvJV4w+nP75icCkY?=
 =?us-ascii?Q?xs8QTimPQTChKUqOWnRrjj3yC2lgZeraBFAirk//kLPdcs7DXqBUi1fU9oJ0?=
 =?us-ascii?Q?0KV7yZzCFOkrvEDq3sQm2SQ6bPaKymi3TvjdAH1a3rwZYJKwxmJCZBNv5DZg?=
 =?us-ascii?Q?YB5JXpiQ8FvXbobfMTPt0Vamb8IwF3pJ4PtURtdet5AKJLTfk3bae7CLBugb?=
 =?us-ascii?Q?hnkUx6CxIwsrTFjMTjdVo3llbFM3a89BwqI5azF3eVVnEznGFxhtScQPIFqq?=
 =?us-ascii?Q?P8aiAb+1P4sx5R4J7KETdJ+2WH9lB2d9CoZNESiGNbzLn2e0EYLrLTXXId5K?=
 =?us-ascii?Q?Metzz2FrWOW3RyrH03ArsKfA3oiRXpfhAJnJHN4OGRtYw2EipBcfw2qNAetL?=
 =?us-ascii?Q?5ibxiBaiFhqAlvJBWbKB39YKH6qCcL8/B3cUt0v5vHHCK/llMPVM2yj6piQ2?=
 =?us-ascii?Q?ZuEXq5QHSPdLjBpkQc+7yPmzvOx1j7drQZcdT7D5Jg2MwttVFYO9YLon4Ul9?=
 =?us-ascii?Q?SV68SfscdLhKnz+bpYVIvnkcEjjcYG8SDL4F81vv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e71349d7-fef3-4313-0823-08dac1aa8b50
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 16:59:05.1757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zztdv9spJLl2FB5mmIj1d1Mz1LKpZJ4mX+2tfPoJzJTVCJxebPbZQZoDwSZdsP33dRQv5tmIhuf6HfzJd9a25w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1414
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 2E9ghYYaNGCAoJvxnJXstmIXax19H7Gs
X-Proofpoint-ORIG-GUID: 2E9ghYYaNGCAoJvxnJXstmIXax19H7Gs
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080105
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Guenter,

> > +static bool fan_installed(struct device *dev, int fan) {
> > +	struct gxp_fan_ctrl_drvdata *drvdata =3D dev_get_drvdata(dev);
> > +	u32 trans_offset;
> > +	u32 trans_shift;
> > +	u32 val;
> > +
> > +	address_translation(drvdata->data->fan[fan].inst,
> > +			    &trans_offset,
> > +			    &trans_shift);
> > +
> > +	regmap_read(drvdata->plreg_map, trans_offset, &val);
> > +	val =3D (val >> trans_shift) & drvdata->data->fan[fan].bit;
> > +	if (val =3D=3D drvdata->data->fan[fan].bit)
> > +		return 1;
> > +	else
> > +		return 0;

>	return val =3D=3D drvdata->data->fan[fan].bit;

> Those calculations look quite complex. Is there a public datasheet that w=
ould enable me to understand how registers are actually assigned ?

There is no public datasheet as of yet but there is work ongoing to
create one. I will however document exactly how it is setup in hwmon.
There is so much I/O on our board that most of the inputs and outputs
go through an external CPLD we are interfaced with to save pins. A
memory area in our SoC reflects some of the I/O from CPLD in bytes
ranging from 0 to 0xff. Each byte represents information such as
byte 0x27, which on this particular platform represents the fan
installation status of fans 0 to 7 respectively with bit 0 to 7. The
byte 0x28 represents something else. Regmap_read/write does a word
instead of a single byte which we are interested in so we use
address_translation to keep offsets easier to read.


> > +	} else {
> > +		/* Power Off */
> > +		val =3D 0;
> > +	}

> What determines power to a fan ? Should the power state be reported with =
fanX_enable ? Or possibly the installed state ?

This actually is the power state of the system, not the fan. When the
system is off we will see a PWM value of 0xFF on the fan. The idea
here was to report a value of 0 if the system was off.

Would you like me to use fanX_enable (read only) to show it as
disabled while the system is off ? From a hardware standpoint
that would be accurate.

> > +static const struct fan_ctrl_data g10_data =3D {
> > +	.fan[0] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x01 },
> > +	.fan[1] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x02 },
> > +	.fan[2] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x04 },
> > +	.fan[3] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x08 },
> > +	.fan[4] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x10 },
> > +	.fan[5] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x20 },
> > +	.fan[6] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x40 },
> > +	.fan[7] =3D { .inst =3D 0x00, .fail =3D 0x02, .id =3D 0x04, .bit =3D =
0x80 },
> > +	.fan[8] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D =
0x01 },
> > +	.fan[9] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D =
0x02 },
> > +	.fan[10] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D=
 0x04 },
> > +	.fan[11] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D=
 0x08 },
> > +	.fan[12] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D=
 0x10 },
> > +	.fan[13] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D=
 0x20 },
> > +	.fan[14] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D=
 0x40 },
> > +	.fan[15] =3D { .inst =3D 0x01, .fail =3D 0x03, .id =3D 0x05, .bit =3D=
 0x80 },
> > +	.power_bit =3D 24,
> > +};
> > +
> > +static const struct of_device_id gxp_fan_ctrl_of_match[] =3D {
> > +	{ .compatible =3D "hpe,gxp-fan-ctrl", .data =3D &g10_data },

> I don't understand the point of attaching g10_data here.
> Why not just access it directly ? There is just one table.

The reason for having this data with the of_device_id binding is that
each platform has different byte offsets as mentioned above. We
would like to be able to reuse the driver if possible for this. We will
soon need g11_data that will be added here.
Would a description in Documentation, comments and commit message
allow us to keep this ?

Thank you for your assistance and feedback with this code,

-Nick Hawkins
