Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265EC699339
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjBPLgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBPLgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:36:50 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7048F3C7BC;
        Thu, 16 Feb 2023 03:36:44 -0800 (PST)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G9nbIl004877;
        Thu, 16 Feb 2023 03:36:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=ctapVngvvJKJ/TX4TBSKVcdoRcA/G/ldQiP2ldz5Yxw=;
 b=NN1vigc56wYm1nEUidMg9BIbMDGL732U5aDUbOfoy9IqjthKJ5CMXC1oaoJuoqQTY+Bw
 IwyZ9YTBvE7Vsae45L7vJgp5JtzJ2rpRcP0a3432umhAJvd7+I5mKB9vRbbA1DybQTzE
 EPrM8rxw1G5mY1iT8xPbqFfa4o4kESpGwRs+O5ijmCU4rTpXI4cI85C/13g7GT6IGxP1
 ljlld+xCDHcKNL1VtprKaBwjGb3xUiWrNlw7E1bd6SR4sPwBC65Usb6RXFnfLEqyb75W
 69JsGFdXSaGuITKrFW/RuWlgEqylP+rTtii8Cd321ZtKrEI7paLohK3K/PNNqeqRsow4 CQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3np7g6ev0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 03:36:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MueZxF2atmpfKNa8t3wREcer8auy/fTGSNtH0cuur8/zn15Kv6YyOvEmb2Qo9SL2lfbmIWENjyV5V/a0tkiRhVEhLttB+Ns8NMWiez1W82CCd3gkbdHzJADR5ycL3a0xg1zz/pgKwphuHgJyGcM5HifFvc+aKDeexzlenF/ISfZo9kvD3uUNBy5ZuhLncqylF66YySzYqbeIEFjFzPRuUkpSwW9agWQ2HF1zszghV4uJEqtazk0WHIXWmuDWAS/BHmmwEXXfhJO7z3Mlk7dzIhwUlwlS15VBRiGaF6rHMx0ewCLsMWmliVEVkgVDHm2UGSXSPxHM0VZ9xrGHwYWgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctapVngvvJKJ/TX4TBSKVcdoRcA/G/ldQiP2ldz5Yxw=;
 b=Fd02NnlKjhd26R1aK16kFpOVOc/JUPLojmEkr0X5qxiePQr2nfWQSmR4Qz0gQZq8NCF12W0RDdu2iiIlQdK5k4S48SMuYKd3x7qA5XBdV6lZ2xem6XxgeHK17WbiaFu8ezcPpw5eY1wxkQilRdw3mN0BYZ7VJJb1UnOtRJNgFW2ZYhJ17boMnJAbjA3u7Gz3JEU1F6d3ISx6+ipOmiK27lKrOABPldj9OUwEzK0UCvzhGNHTOwVp+8dR2+d+S/CorlhypK2LMfS7cqaYBp9Tl1Ketri56vrJjV7Lu8pJj+A8lJDba/dOBIRRsSAAXI2J0uJxojp+1iZ6fVil7fEi4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctapVngvvJKJ/TX4TBSKVcdoRcA/G/ldQiP2ldz5Yxw=;
 b=ex2IuWEoONDreqEuNF3i0HeRNMvgm9CnwbTIc46J4+gAeDHvteSz+MqGuCAuTdueDpRckWy5K48dbIjlF03ddidEhYYgZsGZd+5nIjOWU9gEbl1PFKx7SRqVQX7EHe8yVnHHrBxJdJNgTZkhabveMsgLhKEb9eG7kw0HXXos5qs=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BL0PR07MB5619.namprd07.prod.outlook.com (2603:10b6:208:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 11:36:15 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::f9fa:4b58:4383:336b]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::f9fa:4b58:4383:336b%3]) with mapi id 15.20.6086.019; Thu, 16 Feb 2023
 11:36:14 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Daisy.Barrera@siriusxm.com" <Daisy.Barrera@siriusxm.com>,
        "Cliff.Holden@siriusxm.com" <Cliff.Holden@siriusxm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tony@atomide.com" <tony@atomide.com>,
        "jdelvare@suse.de" <jdelvare@suse.de>,
        "neal_liu@aspeedtech.com" <neal_liu@aspeedtech.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "egtvedt@samfundet.no" <egtvedt@samfundet.no>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "herve.codina@bootlin.com" <herve.codina@bootlin.com>
Subject: RE: [PATCH 3/4] usb: cdns2: Add tracepoints for CDNS2 driver
Thread-Topic: [PATCH 3/4] usb: cdns2: Add tracepoints for CDNS2 driver
Thread-Index: AQHZQfUqM/9qMSrzAEub/2fGw+LRhq7RbhaAgAABznA=
Date:   Thu, 16 Feb 2023 11:36:14 +0000
Message-ID: <BYAPR07MB53814D13CAF0AC674AD00317DDA09@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20230216105411.364157-1-pawell@cadence.com>
 <20230216105411.364157-4-pawell@cadence.com> <Y+4SCXeMUgQhpADE@kroah.com>
In-Reply-To: <Y+4SCXeMUgQhpADE@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMWNlMzJjZDAtYWRlZS0xMWVkLWE4NWMtNjBhNWUyNWI5NmEzXGFtZS10ZXN0XDFjZTMyY2QyLWFkZWUtMTFlZC1hODVjLTYwYTVlMjViOTZhM2JvZHkudHh0IiBzej0iMjYyNSIgdD0iMTMzMjEwMjA5NzI2OTEyNzg4IiBoPSJKaWhtNEZPTTM2RnBkeEpnNG8zVDA3QU5TTnc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|BL0PR07MB5619:EE_
x-ms-office365-filtering-correlation-id: 24e305f8-1f7b-4f37-4178-08db101202ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IBo6bJRDyjrHoqbkXExrYMGIXmb26/qnb6PfUDPdK2YaGnBCqjLLTWgz5ib3/ElHwBEq9EpFXZpRj/sB0g4JIhz1Oa+aRw28Qx/ZZqR/xWOhJGykS7uuq41XP13vGA1HfWc5cuPSe0l/1x6LrwlzEx5ph1CEixsdg4+Lrjy5dxQ/ZlngaxK5tNZ2Hosqwr0iJvgUPNdT3MOiaT5jJPNmxb1SPTyCkgaZwoMAtKjNmlD6NaFpUGRUiI2haJLg96ft39uWDab3rJQ/TFacLyoSzw2xl6iVkoTzzWTL1NWT0v+I4bBgjAH3acDpZOxABKlTsCAe6LDy2wYPTI5opQ0EZcvAcvz2ZwI3yXLzwLZ1Fecvh2WOFrQvf+g6FM/co3pgs578tDaE88AsJDUIHKCCvI70FL7iID4biLed6l2ZpQc+HwYJfeaQ1hzLU/nTwj1LTnRVHQc51HpjIBe/JSK5lV7BImThmDXsFKX7im/yrCqBZnegnpJ7xoMuF6480+9UjGfg3IZ9cEMxzaF88KcQKS8H9f4NEx4sl3rm95BliC4ZwpMcq+T7UtUnUjeUYAxPP2qp+F7Jyk+vuJiJEbCESWJTzKbFE97W62NaQCYn11SfwjRGiYhxqcW+GseHKwSFv+RKPEG4ue344cTAA5iMQ4RCoUoO7ILdOUC6ahl1bHwtrylwlvNT1giHvHcr1Tw7CP+SIhWOZLiIZt0F4EAtrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(36092001)(451199018)(38070700005)(55016003)(86362001)(33656002)(8676002)(6916009)(4326008)(64756008)(66476007)(66446008)(66946007)(66556008)(76116006)(8936002)(52536014)(41300700001)(7696005)(71200400001)(316002)(54906003)(7416002)(5660300002)(2906002)(38100700002)(122000001)(83380400001)(6506007)(26005)(9686003)(186003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jgnHxvgfwgWSo9Nj3SOuxpU431OC/CVio57Mx7F/qx9gZ/cNMV0SOyv+gcww?=
 =?us-ascii?Q?JWOyMEaA0BaBozKTlCgfNC52gLw81+J0rtNHP78EbbzQsqo/jeH5rJVhD6ql?=
 =?us-ascii?Q?hHx1sls4HPyWZR3dcspsI83Nv501ewIa2X/oaoPHV35zoQkNOf/snDNXxJlZ?=
 =?us-ascii?Q?Gt/WZK2tAGW7Kz+erTQNt8yRdo567h4dS+XpXfh1jhUuB2pg4sOIzcVFw4JG?=
 =?us-ascii?Q?gWllDbJsVA51AvuCC6Ew/TA9mncBg8i/sEmEY+qFSXW2F5LrtGx7bbu2uMpJ?=
 =?us-ascii?Q?AN/RqDHNLA5z8Xby+0V/aWcNlS/sKlcX1cevXYc3r87PATbNTakowJFAjyNV?=
 =?us-ascii?Q?BXnWyUb19L8gkTjsfspCJm7MFkIQQLat29v7//hV4e7/7VN1axzw7w+p6kSv?=
 =?us-ascii?Q?PasKMn2DAOgjZBYMheiUjx/Llueeww+kB2zoKLsKCTd8nfq+HJNPlK2ixmMG?=
 =?us-ascii?Q?z0IowuZXsoNqElSLm5WNaH7s9XPC+9FmU5ZoHZXVWt13V/scil8qmQfkqrKh?=
 =?us-ascii?Q?xm1yxwplISySUOaIm8uDgFwzwCg+sW5UeVTHb9jCnL9bndgMCAwEWTl7oLVH?=
 =?us-ascii?Q?gXs6mxaweN7iIeYHVXdb0F/eUnIMMB+OyrTySreE0fNQlsPhWQ3ZDqtcKdk/?=
 =?us-ascii?Q?JlU/tKTlgegiOukK+Tg959/qfP4GNPvZApLwivWexN898XwTSslpa3nqYrVP?=
 =?us-ascii?Q?uc+YcW4LNoyF8aCDsO/pvMbeVnj8ISOCFM6dzfk8Mm+DDHGj03WRUWjtYJ/J?=
 =?us-ascii?Q?tJt7wZ0naHpbiL2g3aIcSQ7hvJ4suvJQFFsgQFdTy9vuLrsWduBJrrYdpegD?=
 =?us-ascii?Q?3AKGhCXER++UuqO2U16IZNLLZdUOrtnP/xj1tYAN8jO4gAMWoDIz9O4B3Gyw?=
 =?us-ascii?Q?vbSMYJW8FYhJLQCvr8PUabOe8TSpegcz/4noK4wNxOfKGS5gEorafRgvtlFT?=
 =?us-ascii?Q?F2tODRdwjHh3cQLKMM0w54vZkr5In2G4XwJkyWfuHpIvIFpvrBZMu3VAp8n5?=
 =?us-ascii?Q?5dOa59IFVa2S9syYLR8ZSYSFGs+0fjVd4roSedhKF8eiiLX+bZBDCa8VHk5D?=
 =?us-ascii?Q?MZ+nSggN+k43xtqfh0VXsM/5J1yAcc/R/uOgVJ0RilIulgTkqKRpAyoub1dH?=
 =?us-ascii?Q?bjHA0Ac03XXRvQDfLQ5y3q4xavAiv0AQ7c8JA7zhOfaH0q0Ez9eFUYIj9cgi?=
 =?us-ascii?Q?HzF1uyfk30hw+Mw9M3/+FNTuDx1I01qcBlIl6dyYGGjjmhyQC4GEPbYRR7Rc?=
 =?us-ascii?Q?XLnB6CNl8FLE5KGpa60U+0ZGsSusZHc8glh2/sjUntNef3OuwBihEfzMCVcB?=
 =?us-ascii?Q?R3VX7R+jo1KGTjwGPRBdB9H7KIKHEMCcMxJVKUKTDawn3whppcmu3KMGdaIR?=
 =?us-ascii?Q?tebgAaaUfMv+3HqY3I1Abml0EuuZbrjqdnhQIbTAgPNw5qrtu84Dl+AlOb0F?=
 =?us-ascii?Q?0c0q6BdSPZpSP5JL89b8Y2nmBkXPcLnLi/GZS7RZv313h8fce0lMY8sMzpqv?=
 =?us-ascii?Q?UmCPmLERkw/JImhY9dOMvvNSVTfE2wogzIkAnuEwM6utbvhgd/wvgdTV/3ud?=
 =?us-ascii?Q?RrC7biVWK9FUB9BhKlPgxjF4f23Is4aiS+eWlMhy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e305f8-1f7b-4f37-4178-08db101202ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 11:36:14.7525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5O6f7+YjnSG725qCVDN4JZpv7JregdOSkB7U0MfOHZd5Gu+gb4GjyTL/g3Gw9uDj3k1+ohw5mcsdCTJQVeI5BkhzQ1xFs9DVBihqxWu7vms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5619
X-Proofpoint-GUID: Ovwt18vLNTQmeVtVWmaLi_Zm_PNWuLI5
X-Proofpoint-ORIG-GUID: Ovwt18vLNTQmeVtVWmaLi_Zm_PNWuLI5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_08,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=571 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160098
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Thu, Feb 16, 2023 at 05:54:10AM -0500, Pawel Laszczak wrote:
>> Patch adds the series of tracepoints that can be used for debugging
>> issues detected in driver.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/gadget/udc/cdns2/Makefile       |   2 +
>>  drivers/usb/gadget/udc/cdns2/cdns2-debug.h  | 200 +++++++
>>  drivers/usb/gadget/udc/cdns2/cdns2-ep0.c    |  26 +-
>>  drivers/usb/gadget/udc/cdns2/cdns2-gadget.c |  52 +-
>> drivers/usb/gadget/udc/cdns2/cdns2-trace.c  |  11 +
>> drivers/usb/gadget/udc/cdns2/cdns2-trace.h  | 609 ++++++++++++++++++++
>>  6 files changed, 897 insertions(+), 3 deletions(-)  create mode
>> 100644 drivers/usb/gadget/udc/cdns2/cdns2-debug.h
>>  create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-trace.c
>>  create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-trace.h
>>
>> diff --git a/drivers/usb/gadget/udc/cdns2/Makefile
>> b/drivers/usb/gadget/udc/cdns2/Makefile
>> index 7c746e6d53c2..a1ffbbe2e768 100644
>> --- a/drivers/usb/gadget/udc/cdns2/Makefile
>> +++ b/drivers/usb/gadget/udc/cdns2/Makefile
>> @@ -1,5 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  # define_trace.h needs to know how to find our header
>> +CFLAGS_cdns2-trace.o		:=3D -I$(src)
>>
>>  obj-$(CONFIG_USB_CDNS2_UDC)		+=3D cdns2-udc-pci.o
>>  cdns2-udc-pci-$(CONFIG_USB_CDNS2_UDC)	+=3D cdns2-pci.o cdns2-gadget.o
>cdns2-ep0.o
>> +cdns2-udc-pci-$(CONFIG_TRACING)	+=3D cdns2-trace.o
>> diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-debug.h
>> b/drivers/usb/gadget/udc/cdns2/cdns2-debug.h
>> new file mode 100644
>> index 000000000000..3a80f3fbdcd3
>> --- /dev/null
>> +++ b/drivers/usb/gadget/udc/cdns2/cdns2-debug.h
>> @@ -0,0 +1,200 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Cadence USBHS-DEV Driver.
>> + * Debug header file.
>> + *
>> + * Copyright (C) 2023 Cadence.
>> + *
>> + * Author: Pawel Laszczak <pawell@cadence.com>  */
>> +
>> +#ifndef __LINUX_CDNS2_DEBUG
>> +#define __LINUX_CDNS2_DEBUG
>> +
>> +static inline const char *cdns2_decode_usb_irq(char *str, size_t size,
>> +					       u8 usb_irq, u8 ext_irq)
>
><snip>
>
>Why are all of these big functions declared as inline?  Do they really wor=
k as
>inline functions if you only reference them in a trace callback?
>

Yes, driver reference them only in trace callback.
The big function are used only once in code, so it seems reasonable to use =
them as inline.
I don't know how they will be used by compiler.=20

Thanks,

Pawel Laszczak

