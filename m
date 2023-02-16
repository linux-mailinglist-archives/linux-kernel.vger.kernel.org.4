Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1E16993AD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjBPLyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBPLyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:54:03 -0500
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7BB53576;
        Thu, 16 Feb 2023 03:53:56 -0800 (PST)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GBACHO025042;
        Thu, 16 Feb 2023 03:53:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=0ecGzofcu+tSo+xBnyZbQYNAWnCjYaGJ5gJ0jTt1L6s=;
 b=XYTnypTiBBJgt1/GQbglHc61HWSmrBBe5ljWbdGNB3ttRLw1otwQhn4OKQ2tbSP6xp3z
 da/G+7SbJdgsllDxrvUsie7fUJM3cl19bR+3VhqIjFeFXUb8ANdV3oUbB2tTk+4aaWtn
 12XGovS9Vl7XAWBCfnQ0VNYdX0RzVmSSzylgJSIgOvkPws5A/p5OLWvmYAqbDtf2DDLj
 yn6BPmARnFIpSL6lBM8lWfju2NCb8ipIwpOQ3eldQMcWUm8eE81H2P9zMPBI4qQWDK8Q
 /CBbf68nW95vFmoibxpy0uDJWlHse+E1LaLseyyK3z7t+6dU5AnRyDQYMdsXKKjdq8Zd Qw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3np7g6ewyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 03:53:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ek8ARgIH2UkXPW7urfhSkLq2xLOKWWgPa8V+DoP8BSCABnrIu4Bm30P8KAiDNg48CF3N2lL0GL/kRHolbe30HwOblsq5M7JWis4ABJ2ugOWTRim6kChXvTguF8PThXOE1rWOSlzLxSoGqcH9jrUHieKIN/BZoyXEb2Z+NzFhv6ylTPIw60HKhD90+3XJREDgf1Ej0Ca335v7LnM0nq0qRKnplZBLmqINydyyD6ZENL5oiUpe2gWu8WF3+Ls4kB5T4+866T1AmVBHPsOIW4YPnCfb/CCh6h9ZHCY3rZ1yYqir6+S8PzH9hT+UABeFThVrJK6i43tO++FK5sNyX0knag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ecGzofcu+tSo+xBnyZbQYNAWnCjYaGJ5gJ0jTt1L6s=;
 b=l2RGd3bL3Aemb+r26ItojW6JOZEe4PsGfU11GM3AQtT8s6vHcmyt8Sj2TWoRFXaGWgGeLNWGNeXKM8qGN9Lesz0AwhhvE1qyZ+PaMZEIJrNdFO352483SDJy7LGfArWCrRK2QIbXwvsY5cz7S35x7X8mwiD4BNr0V2cZbSR5NGwjJxZL/+aePASFX/XHowD0D3aN+8NBNQ6J5rj8uwOFaGnx8HjYJUYsvUvt0mJ0nUAigFjyc6xLTXRZAhnwYsmBPFDo00t0uLz6KmrhUG5a/MEBQd+DDSziAWEIHJY271dwbA0c33ULzeC7nvUODETZCN5XVPHjMrmdmbQp9CSnCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ecGzofcu+tSo+xBnyZbQYNAWnCjYaGJ5gJ0jTt1L6s=;
 b=b6OjeGl1fTeM8zTzsb1n/Ryl/BulJiLwXQYXU4kak23vCGiwR8ytMwf336Kw4jnTLvKvLbwVW+kYdiJ4/G78yMLVCG27OgohugEpOxwy9Zz+lXufab0A1ztEOBdemgEhClpisOT9Gv3E5gvIjGJUN0lRsbR+/egakrD92QY/IT4=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by MWHPR07MB2783.namprd07.prod.outlook.com (2603:10b6:300:2b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 11:53:20 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::f9fa:4b58:4383:336b]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::f9fa:4b58:4383:336b%3]) with mapi id 15.20.6086.019; Thu, 16 Feb 2023
 11:53:20 +0000
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
Subject: RE: [PATCH 1/4] usb: cdns2: Device side header file for CDNS2 driver
Thread-Topic: [PATCH 1/4] usb: cdns2: Device side header file for CDNS2 driver
Thread-Index: AQHZQfUsInC9rM/c9Ee1hWGZtNZxhq7RbngAgAADZnA=
Date:   Thu, 16 Feb 2023 11:53:19 +0000
Message-ID: <BYAPR07MB53816694801FCEE0CA9C73F0DDA09@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20230216105411.364157-1-pawell@cadence.com>
 <20230216105411.364157-2-pawell@cadence.com> <Y+4SXE25Xl7Lv/K8@kroah.com>
In-Reply-To: <Y+4SXE25Xl7Lv/K8@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctODAzM2ExOTItYWRmMC0xMWVkLWE4NWMtNjBhNWUyNWI5NmEzXGFtZS10ZXN0XDgwMzNhMTk0LWFkZjAtMTFlZC1hODVjLTYwYTVlMjViOTZhM2JvZHkudHh0IiBzej0iMzEzMiIgdD0iMTMzMjEwMjE5OTgzMDUwNzg1IiBoPSJ3b1FTbEZHUUZ5S0dERVFhVER4eFdWMGd6MTg9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|MWHPR07MB2783:EE_
x-ms-office365-filtering-correlation-id: efdb0d64-1859-4fc3-50ed-08db101465e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BVK0ulBPUmgzM+Bbv1nNsq99MYsKmd1JN7sJJbwn+1pAsdU+Q5gMZQMXzNeXLhvYP6nySkcHjaB5yDza+deYKMDN0TBVCkm4ImxBRXNDUUML7ItOUClGbI5guPsShULM17Mn1hwMcda90eZ8J27Wpxldwm79Q/+Nr0w5/4q5h3USC2eGvL7Fsu00hVmzVrDfHygViN1ixFlUUBf65L74KqTZL7eAfbGGvOf+Oa9Z/gYuZeE53i9ZS8pWTDXRmwdo4lMQ9UU5hvd2bIudG+AlgdyqIBPsZqoj9QJQDiKE0UQ/0/w3CbZFX8VM2I1OWr72a61AgkCrNsMHm+1rb+D3HCMcp8ESHjhtdjvoYwZGfeNR6XYEeQabnhQ08GkikldjIxRD0SZeBrq9rseYDqQKNvn2YDhyv5R+7p6PzYMokxAGezVtVCjtlK6V87k340yV391zwi6PZRWlGcRldb9T+A0SPoc3Oe/ZvK1KkpfhRFOPQ9yIPfbWl2ZdFJVXvYbcqRdHHiuq5XNiXOFgXxba/1PmtAzF+0iFK5QxcuVZweZUwIy2EcfWlfM8DtwDBhiV+FNmk6kZJGOsqO4FN+laldBGMdYdUS9RU2UGs9+CkSErZF3GiGidW6qH9YoBM1x0xE6teh/upooT0Oba6ahqH2I2Q2nOa0kykBGZnvNOzTOu6ayNAWMNOn42074ke5oW9YFVi/KJ6yHldPTreFWVqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(36092001)(451199018)(2906002)(316002)(54906003)(52536014)(8936002)(7416002)(5660300002)(38070700005)(66476007)(66446008)(64756008)(76116006)(66946007)(66556008)(6916009)(41300700001)(8676002)(4326008)(86362001)(33656002)(83380400001)(122000001)(7696005)(478600001)(55016003)(38100700002)(186003)(26005)(6506007)(9686003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lAqbsXxrkg7PZS7nXSE5GCnwJfMgiQ+HSSplJfOySkZVuQj+aMCDY7ZAdlFY?=
 =?us-ascii?Q?ipWHPrrd8dTcCZmL/0HgPLdQw1LeP70B0phRIBmf1IWtMg+YC3Kj1Qa2BgiT?=
 =?us-ascii?Q?/UE5JMe8+R8B/J7Jak6KVTGltzzoEAMp6OSXuHoUNQEDoPHmW5at/EDLGDt8?=
 =?us-ascii?Q?0kZqf8sryGBd/QEDD4Ppdq4IRSCROaVjgsbKA4ogUqeKEoPGDx+TG5OYDkRM?=
 =?us-ascii?Q?jf2qkR9Q6TvUq+WEwxnUC+2wdbrd02qQRINqR2iXjT7KrTubwI7WDYd6JNd8?=
 =?us-ascii?Q?Ydo9j2G+sHnYTaJ9r+iRUXpRJLyrPR+pzmAAWiPVxkW4d+1LMPlEsGYDZlPM?=
 =?us-ascii?Q?JXVQPIXzwMehCbgScI/x5813NoXZ2IOpM9Rzs+6cK1uImwJn9KPQ69r3ZZX5?=
 =?us-ascii?Q?dA+EMySynjQgAkHRpeMk+7Ogr1PJPqsSBPQMaswvbXLx6axOANA4ZPYn13p7?=
 =?us-ascii?Q?6bRaprxRqzV0MF10s3qeEJB6mXnGkiUN95pXdy52oZertoOqbbYDGnp9HLqu?=
 =?us-ascii?Q?18Ocaah7BaMwg79niE+HB/u0Ap8le1w4g7+jMIW7ob3F7ayyAWCYAQ5Kbwae?=
 =?us-ascii?Q?sEgW0ISRngh4ks5bI9mB20mUwsu6jnoQebVzw6z95PKvIvqVEDl+quyJ8xsa?=
 =?us-ascii?Q?LMu4ysM9v4KS7Xi0nJQWbUgnUsAoUu1XYS7iPqGBNRU1/mOT5kI3kmjctaeP?=
 =?us-ascii?Q?cLcJ15UUs27nftqLfZQ5JH04XFSIZDQLfV73g4unTMkVvNYBq1FyAvEBdSwF?=
 =?us-ascii?Q?oCQsfxlS4c/sBgE5IlQwjPK4se85obquMGatZfLM4q+T3DUAdWc2tvq8q1aE?=
 =?us-ascii?Q?BeBfYKR1vZpezFmw2dIzumXXIObmDZmDw6Xx8RcxrmxsXHscOoqBHMsagnI5?=
 =?us-ascii?Q?9jq4GvOMTudGjrS4cVcAmYT6LvM9GQ3Gh2PmnQ0SfzIDsGWH2vH4GdJR0aey?=
 =?us-ascii?Q?YYxPikDuB1wtevTXa6y/Nl7UDSrYbGQn/XtgvdPoES59//0UKFMx4GE7tt0W?=
 =?us-ascii?Q?p8Ba2X8elS3/liegprbm5SAfIy7BIMzdAYn6Nid8tJfoXTX5n0HSop39Nn8h?=
 =?us-ascii?Q?8++/1aZICnlK9q/3cPKw3IwQezwUlK1/vl/ns60Uykj7gIx2unAaxsx4wsCP?=
 =?us-ascii?Q?qG8CmMSzuzCBaNY+j1CrCG2IRKrteqxNpuDMg5VAI2AE6bPpqheXbr6BZlxu?=
 =?us-ascii?Q?u1lcCyZpS+2DZTZ0LQxPHEZGdj7WFmu4m5WIV6RNWrcBnfeKsQqLAX1XaNP8?=
 =?us-ascii?Q?RSRQmCwBJxhZbZUGOQ+9JoUhOwO2T+T6aatPFzk6nOBYnOw30yu3nAd7qkfw?=
 =?us-ascii?Q?Kqq7Bl7Zk2SNfAC/Fe+XsSzNx3e1WQmB/LPnDIdWyFoSU+gA/ct/jkZWzqAT?=
 =?us-ascii?Q?6FBvdmVIrxj9G6dQtHC9r+9Q4Wgr211hgT0E80n0AHOyi0qIZq1Ot0v0a9sh?=
 =?us-ascii?Q?2tXfHY4fXYVUOMz88iBV3VysCbD8BqumkcKMP5mBHc9cgytKWbD4uC6gHGUz?=
 =?us-ascii?Q?AAkPcImvZjs7g1v/rT18sFZOp1LyXTqfQNzqwYPXneKbnDMVVgQyZ/CVh9ip?=
 =?us-ascii?Q?eRUVlIVt20Wymi9OxrNP6hs4VQ80vKzg4XEpWOwZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdb0d64-1859-4fc3-50ed-08db101465e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 11:53:19.8080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fA/8dOkgYmaZ0N03S6x+yCl6ugYekkGlTACht3YqfF4XidFlKOG7cxsWXLyaB8i4lCM3in/0AJpQW0Cpx9AMNYiZFnNmncqG3dTVxDKNeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2783
X-Proofpoint-GUID: aWMNlgAgbWJLW0Yg74rxzhYev_ovVdWg
X-Proofpoint-ORIG-GUID: aWMNlgAgbWJLW0Yg74rxzhYev_ovVdWg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_09,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=495 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160102
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Greg KH <gregkh@linuxfoundation.org>
>Sent: Thursday, February 16, 2023 12:24 PM
>To: Pawel Laszczak <pawell@cadence.com>
>Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
>Daisy.Barrera@siriusxm.com; Cliff.Holden@siriusxm.com; arnd@arndb.de;
>tony@atomide.com; jdelvare@suse.de; neal_liu@aspeedtech.com;
>linus.walleij@linaro.org; egtvedt@samfundet.no; biju.das.jz@bp.renesas.com=
;
>herve.codina@bootlin.com
>Subject: Re: [PATCH 1/4] usb: cdns2: Device side header file for CDNS2 dri=
ver
>
>EXTERNAL MAIL
>
>
>On Thu, Feb 16, 2023 at 05:54:08AM -0500, Pawel Laszczak wrote:
>> Patch defines macros, registers and structures used by Device side
>> driver.
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/gadget/udc/cdns2/cdns2-gadget.h | 670
>> ++++++++++++++++++++
>>  1 file changed, 670 insertions(+)
>>  create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h
>>
>> diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-gadget.h
>> b/drivers/usb/gadget/udc/cdns2/cdns2-gadget.h
>> new file mode 100644
>> index 000000000000..66cdb902163c
>> --- /dev/null
>> +++ b/drivers/usb/gadget/udc/cdns2/cdns2-gadget.h
>> @@ -0,0 +1,670 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * USBHS-DEV device controller driver header file
>> + *
>> + * Copyright (C) 2023 Cadence.
>> + *
>> + * Author: Pawel Laszczak <pawell@cadence.com>  */
>> +
>> +#ifndef __LINUX_CDNS2_GADGET
>> +#define __LINUX_CDNS2_GADGET
>> +
>> +#include <linux/usb/gadget.h>
>> +#include <linux/dma-direction.h>
>> +
>> +/*
>> + * USBHS register interface.
>> + * This corresponds to the USBHS Device Controller Interface.
>> + */
>> +
>> +/**
>> + * struct cdns2_ep0_regs - endpoint 0 related registers.
>> + * @rxbc: receive (OUT) 0 endpoint byte count register.
>> + * @txbc: transmit (IN) 0 endpoint byte count register.
>> + * @cs: 0 endpoint control and status register.
>> + * @fifo: 0 endpoint fifo register.
>> + * @setupdat: SETUP data register.
>> + * @maxpack: 0 endpoint max packet size.
>
>You didn't describe the "reserved" fields in here, so you will get a kerne=
ldoc
>warning :(
>
>> + */
>> +struct cdns2_ep0_regs {
>> +	__u8 rxbc;
>> +	__u8 txbc;
>> +	__u8 cs;
>> +	__u8 reserved1[4];
>> +	__u8 fifo;
>> +	__le32 reserved2[94];
>> +	__u8 setupdat[8];
>> +	__u8 reserved4[88];
>
>Why are these all reserved?  Should they be set to 0?  Something else?
>
>Same with the other reserved fields in this file, you need to fix up the
>kerneldoc for them too.
>

Structure describes the part of register map related with ep0 endpoint.
In the reserved space there can be other registers related with another con=
troller=20
logic.  Not all reserved field are set to 0.=20
The registers map is quite big and confusing, and I tried to split them int=
o some group
to make driver more readable.

I will add some descriptions for all reserved* field in this file.

Thanks,

Pawel Laszczak
