Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB32768FE2A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjBIEAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjBID7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:59:52 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEE02E819
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:59:50 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3190ENvf006143;
        Thu, 9 Feb 2023 03:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=rOKREE5rxGMtDjw0nOgGZtb5L4iqSMTSfxWBVUoZGro=;
 b=AQ0QR1QW7hV76cTy4g3ekhcHId0f3D3/B3nuZzTjJqjNoVDnSNSc7hlqXAJvGt+9fQ18
 tMp5kM60JU4pF7jl9Wlc2Ird55GwVRsC8s+gwuMlYXAzxqQ5NqyruHIbb1dtz7BN0Hvz
 jWNjRKxub2MUHsuTRFgEpIAfPrdiPxx/fzYiucFiGBmGoKGxmo7zIMdHaMtd9oisLKBA
 yzIBfeYCug2zemYoun1eXHTt1O6lP7K6eHE0aEwi4jK7we345f6aYv4FNR5tGOLFxofz
 N+/ev8dJMi5WMLhZ3/i88B6TaWFWUIjen87j7tJ0oseFf+ROVQ3Y76iwbCrgyXsngD45 vg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3nmp421aqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 03:59:35 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id E86ED805E55;
        Thu,  9 Feb 2023 03:59:34 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 8 Feb 2023 15:59:06 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 8 Feb 2023 15:59:06 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36
 via Frontend Transport; Wed, 8 Feb 2023 15:59:06 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 8 Feb 2023 15:59:05 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMEg5R4QbosJb0MqKoE85apsOWWymxKEvlTKns9I48IkjYINvVr2LVLl9mNPeRJtHBvn9cPI1P3Q1fVY+r07e8OkvIdQUEcPXMstXYjUi0zesnJt6On7eI59aSnoS5KRipVyzq+stK8DM4ACEvVnr587bO2Nah1sOPXIS/41lprG7rKNLngPtCEv4zTlw1GpUYjZ68jW1sp/MkMG2tr5vdGpIXJJFQS7HUliRLfoBEDFMZpC9D+eHPnl5MyAMeIRrqq8TUB1bDerWQ1Ulvy8C5tf2C04EBRGA2pcRkvvyjJXhd/EfjGQEP3UHqEzzjZkWE3HGf9lsMHnKHPchzqHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOKREE5rxGMtDjw0nOgGZtb5L4iqSMTSfxWBVUoZGro=;
 b=PygyvaVREHsDGVASO06sgq2otCZ/f1QZ7tFFdIbPy4kX7wmgW39FoLm96UCM6RXAn+6n2+/j2oVkmcRVTeAQeamnVJHO2PDFTRZoV9J4S2hU2bAZg/yoDTgblBEW40Q6kGc/kMXbyinpRLh4AtzQqtFgBOGtfE86Fq8TzgJ17Za7C2Gz30pN2R8H6w1Fr+WwVjAnzBqd30BThOYxMZn7D0BwUI/S4ixkQijbleBnLFwWKvQt8Y1ljahCenFOgjWc7sTMM5ExkneCj9QIZ7eJsGiBqIKyrthyWoMowUu1PFtQeKJs2BPF5fb8NwTmDsaJOFMwQ1/etlISyiHU4FntlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB1539.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a6::17)
 by SJ0PR84MB1577.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:381::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 03:59:04 +0000
Received: from MW4PR84MB1539.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dc3e:55b1:e680:e1ea]) by MW4PR84MB1539.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::dc3e:55b1:e680:e1ea%5]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 03:59:04 +0000
From:   "Gaba, Aahit" <aahit.gaba@hpe.com>
To:     "Hsiao, Matt (CBG Linux Enablement)" <matt.hsiao@hpe.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "nishadkamdar@gmail.com" <nishadkamdar@gmail.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "dhaval.experiance@gmail.com" <dhaval.experiance@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "arvind.yadav.cs@gmail.com" <arvind.yadav.cs@gmail.com>,
        "standby24x7@gmail.com" <standby24x7@gmail.com>,
        "wfp5p@virginia.edu" <wfp5p@virginia.edu>,
        "jslaby@suse.cz" <jslaby@suse.cz>,
        "prarit@redhat.com" <prarit@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>
Subject: RE: [PATCH v2] misc: hpilo: relicense HPE iLO driver as Dual MIT/GPL
Thread-Topic: [PATCH v2] misc: hpilo: relicense HPE iLO driver as Dual MIT/GPL
Thread-Index: AQHZPDgD+zqCA8XE+0KJ40CgzpMJRa7F9/3w
Date:   Thu, 9 Feb 2023 03:59:04 +0000
Message-ID: <MW4PR84MB1539887EFAA00D60D777C75696D99@MW4PR84MB1539.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221116103457.27486-1-matt.hsiao@hpe.com>
 <Y3TLSON/7XRG5BiN@kroah.com>
 <20230209033812.GA17928@blofly.tw.rdlabs.hpecorp.net>
In-Reply-To: <20230209033812.GA17928@blofly.tw.rdlabs.hpecorp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR84MB1539:EE_|SJ0PR84MB1577:EE_
x-ms-office365-filtering-correlation-id: 954fc036-f720-473c-1bb3-08db0a51fc67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SY3mDC5xwAhFChWpXwqTj3mNknOLfXtQ9QPWFdllNCHkb2LxOgdT53Jc4sj4wqq/td84V3I7tKM0l862mQqEzBRg6LDq+Z5NWu5P8n+FX9lBNPep4+eE0z7fH5Oj3P1nhMdp7l2vtgNHixjiFy2/LtzdpvJ3x1aHsXMm2BbVSSjsT5mzV9CUbYt9u0GXPfoSyb7Cn2IDZBznoqt/ZaIN2AlkybYuI47IrGlfkvP2HDoVHhwuRLUhPOHK5ZfjbkK4KlbnwWeObbU5rr5MxnBFx5bnCdQu6ymuTDcOH3vt/r8CbCxyDFL19LQP7s0yCwIRPQGgjjv/1BveI3ToY4zJALCxilYwoOuFXVSjiFP1dZREmygAGZoYN/a0CcaBFzLb/FqAAQJWQ1h8GpPtx6h+tKbfkXaYIHZNHgsZQ7ekhqxEIzZCzrEQpFrbQ01qsf7usQg0LxjRedWLZ0b/yMtfKT/rnKUWw1PRE6y6z6Cf3CLWwFRSIGx5iMf7pDD2kRd0TNryG3Z+4weDbb+JVibCyRRBbmop9MVveG9VXr7I56pf+hzO2oQn59T283tcDAHssl7k0zsEu7OehYCRMobcrLjbyW/l3YJmfhWKFZ+oDePnMFcExPJJsgEpddNXIEuKAOuG25nCGAQV6OvSPG5VwYSKTFzAuHW4ftu+3eLT0xXoIYH0+WQkJeJJ4zlfaMiXvkOtZHd1e564CeKerALjng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB1539.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199018)(76116006)(66556008)(54906003)(83380400001)(316002)(66446008)(64756008)(5660300002)(66476007)(8936002)(52536014)(4326008)(110136005)(41300700001)(478600001)(8676002)(9686003)(7416002)(186003)(7696005)(71200400001)(38070700005)(66946007)(55016003)(33656002)(6506007)(38100700002)(86362001)(2906002)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6TkhsptMXwBICFXxcyMynl5xAqzS2sCDSjAS1nJBeCSz9JEykxVjkQb5lSKM?=
 =?us-ascii?Q?AoCTbrJ1cMujKcBrx/AxrI1XOM3U/NQoNZN3Xgmkt4MbtHWd0AiPmpt6WoSp?=
 =?us-ascii?Q?PD51z/OysQw0S+1d5ebthd94XwVk/Nz8owCRf3DIKi3QNGpquQjIL/mtRiKB?=
 =?us-ascii?Q?j94g2tpvNw/AlgCKSTYBbAiqWlUWm1Lyp3JDlS/2Yqm1JfstAaHExkBfT8Sb?=
 =?us-ascii?Q?IkVovjlrmZje4L4tQm68FeH+on1pUjjOduz46kqHxaXl/0M5Ym4tyi1ru2x/?=
 =?us-ascii?Q?r7yiTmHTtkctgwZRbOOih5PHCh6PB+nyquLX5/DLo891jODtI/oJblYe7rAr?=
 =?us-ascii?Q?TmLIFc6Xzoi0BtwzNCXGHpIDf3fN2ruRGMppqW1f/cinTessHUBqbo7GxVKx?=
 =?us-ascii?Q?uLAKtL7mkOnnzk7169Ayf8jMdzgceeV9AHm+SEeKDHPBNx3pFR7aoDPHWbaP?=
 =?us-ascii?Q?ofOlqDs8+qWbUZ7/YeehjCxcMwCegEEjLo/WNkzJodswedweMv+AGIBDxg/D?=
 =?us-ascii?Q?cznrynncY9rmloDL+zaAYr6rd5ukHn3TAciu5pKirMebdgnru+trWEZKxaJG?=
 =?us-ascii?Q?GMVe8DYBnCsRXbe2Ax0PCh4NW/Gm948YcmcvkzQLuSATBl7FJ8alQScqhIFO?=
 =?us-ascii?Q?MmMzcy0KBgKPrqNhAxHKDWKbIHGXDU8ztSZbTL7fD7iz0451LcgPKdJ6xVMn?=
 =?us-ascii?Q?BbNLOvwo2gDB7bFQiqPnx78mioh0w4Th7cPSPCG1nCMZPiJln7u4rTRqxjGW?=
 =?us-ascii?Q?kaa7lG1ndLAfzurOyYpQB4VDHvlJch/3l0/euNPoNLJv7vN200cwSUcKlKKy?=
 =?us-ascii?Q?gPBju7WfbEjQmZplXlOHSu+mmwfzyMVLryvCo0P5sg+CGAgg09GWXqa4AivI?=
 =?us-ascii?Q?V/+U0d1Ha81zi439QXsXWQiKCoHvvz88wzwOM9Qn7yUkkKvN0wY13HJcs3G8?=
 =?us-ascii?Q?18qOgYkMeYPfXvDE3b7YYWYO2UlU9Db+RHb88TBIF6GRRxXM2pR1SvFd4mqN?=
 =?us-ascii?Q?Ati/LqOslQ/xfyTy/BEK/WCS3PiIfNVkTSLM3aXZpJMN3XB/ktTP+iYpC/3M?=
 =?us-ascii?Q?+rVLoNYINngg9P30Txfc0k66zOcKENbY6cEmonXez7J+ABvcY0Gsv/p0I2s3?=
 =?us-ascii?Q?wjKQD8ruLDrEKXo56fY5yAXSbLI7PLzuR+TVnD4e09AGGRVq/tvRB2kzV1JR?=
 =?us-ascii?Q?Z7TLFpB7aB7XHwc0C9MCMlk1VwsnXMvgjMoOEwlhHKlljBjHArNjJP2nEkcj?=
 =?us-ascii?Q?IiVN5zhEUB+7SUpqQO5Z7aLbtG07RaUcYPHf2QAjsAPtIJ6cr/nrXiCrdcdD?=
 =?us-ascii?Q?QYlW4IjAKe4jUUWEny1j5rNCzlmTlzLtpUCRPc7LMGehYZbh+D7mKFpWCsA7?=
 =?us-ascii?Q?EMzv8Y9spXO2vPklWeWDSaR3zoTAq3VePQ25Zp4YSqOFyCFC4slmIBMh2pS1?=
 =?us-ascii?Q?st+lqb8ljRcSuywu2jVCa+q+E4VLXPaZbPb9SY1JxyYX55Zcy4aruZcZO/Dc?=
 =?us-ascii?Q?7bsOBOCESPX+qJh1IneEb6gVkTCudwSU8TtM9SGazUZ1z4rJc72AfoSlAaYt?=
 =?us-ascii?Q?iZLEuv0UZAMVtat2AMS9/O/gU5mCP/oJ5a5fHbjzMxgm8gw6++HuWgikVEGF?=
 =?us-ascii?Q?B1BRH1rw9WY37p/wX3CVOnII7yU8dfRW5Y1AXwJW8+8g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB1539.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 954fc036-f720-473c-1bb3-08db0a51fc67
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 03:59:04.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RF4L1bDBUsdpNq4FzZkkxuui7Fx7sCattZNNmSHeXcQ7ku8/ihfck3HPDJwkKHMzLjYcWWfnLFh0XQpScb7qow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1577
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: uesqhcaCrHStjwF5PSYtqtxkEapKyT1f
X-Proofpoint-ORIG-GUID: uesqhcaCrHStjwF5PSYtqtxkEapKyT1f
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-09_01,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxlogscore=647 phishscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 adultscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090034
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 09:29:00AM +0530, Aahit Gaba wrote:
> On Wed, Nov 16, 2022 at 12:36:40PM +0100, Greg KH wrote:
> > On Wed, Nov 16, 2022 at 06:34:57PM +0800, matt.hsiao@hpe.com wrote:
> > > From: Matt Hsiao <matt.hsiao@hpe.com>
> > >
> > > Currently, the hpilo driver is licensed as GPL. To run OpenBSD on
> > > HPE servers with BMC (HPE iLO) functionality, a dual MIT/GPL license
> > > is needed for porting the hpilo driver to OpenBSD.
> > >
> > > Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
> > > ---
> > >
> > > Hello contributors in the CC list,
> > >
> > > Thanks for your contributions to the hpilo driver. Please kindly
> > > review the license change and hopefully you would agree and approve i=
t.
> Thanks!
> > >
> > > Patch v2:
> > > ---------
> > > - Change MODULE_LICENSE to Dual MIT/GPL too
> >
> > As I asked for on the v1 version (delayed email on my side), I need a
> > lawyer from HPE to sign off on this change as well.
> >
> > thanks,
> >
> > greg k-h
>=20
> Add HPE attorney Aahit Gaba to sign off.

Signed-off-by: Aahit Gaba <aahit.gaba@hpe.com>

The reasons we want to dual license Linux hpilo driver are:
- There are required bug fixes that are not copyrighted by HPE in the curre=
nt Linux hpilo driver.
- We want to maintain one hpilo driver between Linux and OpenBSD, and dual-=
licensing of hpilo driver's existing codebase and all the future bug fixes =
are the requirements for it. Therefore, we requested all other copyright ow=
ners of Linux hpilo driver to accept dual-licensing (MIT/GPL-2.0) for their=
 respective contributions.
