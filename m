Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBE270CAFA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjEVU3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjEVU3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:29:14 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2108.outbound.protection.outlook.com [40.107.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18203B6;
        Mon, 22 May 2023 13:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMtflOMFl/OPhzpPWzWxr1iHqBJg/Gbemt9xJGily3aUuAPAAoX8qOW2pxQ0I3NdLw/r1oMt8R0RoFQvjLQ3fY45wrhupreiSqOdFOFPeTDU+1ovavPEjxgXs3BUPGEQjaQTXs6foU0+Uko9NCi5CAnpZ3jtTs+fR3xK5FiPbljhBibxZnFCG/ksYlUp8rdNw0O9k0Lu3OLPUNgLoZzxE3DnTaolne+AbqvXRv8TQysmw55AFw2rNQeVv8r3La4yzVlcfFYp9tcfR7Wvo7QWh3qBdCsLX2uZ7907Ub62K7nEijU8Bpcgw8Yn3Y+KT9i9w/ERzPNxWk8CBHq43VG7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP/JFXetqW60nvzQPLboyxVa9s/QNBfXX+Yc7orU2lY=;
 b=Q3aaPQjzTZ7iBuQng+w9OQy8hwWsSrR8qehTEB89cDALSKqUE5aZjFNHRfw7tz5lMg71Al5P7VmomPaIQxwLohw1VrOSof6q+USlG2ccPmQzr6nsndCiIQ5oLmoz1czz/dEFuwoYZeaxfNOAkIux/xCLBB4h5eEsaXFJtJB1rT8souPfa5c6WtNI8dvWGNB/hX9ML2MFI3yk822gPJQvDl8+0+qGwQx/po0cL+Ewi3AzeiOmXsh0z3tHQXDcN4p3zRhoPOP44gehHkDRZO3TdbefXSx1VdSOOr9FV/td9Glv4czC9nYoYFRfheFHm90y/vXr/p0AKF59Et0RbGzrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP/JFXetqW60nvzQPLboyxVa9s/QNBfXX+Yc7orU2lY=;
 b=fJTkHJEtvDMC1k58TP1T8yx3g8fQK8VhcBQXo0hwnEoK+vWQzYZydAUBBo8SJTav60R8F85ii00vhV9emxr9Y4FHQWR0lfJNHcTFBLr224ph0CKVpbeIMqj1Zav/yluJfTQEI9FJEPkU3KfDdFh5QYq5v6EvDY+FfQMVY+Na/QM=
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com (2603:1096:604:43::11)
 by TYVPR01MB11128.jpnprd01.prod.outlook.com (2603:1096:400:364::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Mon, 22 May
 2023 20:29:08 +0000
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::edc3:42b8:8199:d907]) by OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::edc3:42b8:8199:d907%5]) with mapi id 15.20.6411.029; Mon, 22 May 2023
 20:29:05 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>
Subject: RE: [PATCH 6.3 000/364] 6.3.4-rc1 review
Thread-Topic: [PATCH 6.3 000/364] 6.3.4-rc1 review
Thread-Index: AQHZjOUKmjF8pgLDVEmQr5ERjywh/K9mvVcA
Date:   Mon, 22 May 2023 20:29:05 +0000
Message-ID: <OSBPR01MB3783F0D4C6006FFF6DF9AA28B7439@OSBPR01MB3783.jpnprd01.prod.outlook.com>
References: <20230522190412.801391872@linuxfoundation.org>
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB3783:EE_|TYVPR01MB11128:EE_
x-ms-office365-filtering-correlation-id: 349c065b-97dc-4ee9-c1dd-08db5b03305b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V6wBQKh9wp2T2yzHAQ3i0CoVlS+nIkVEEHt+mJsNS4hmpJBILX5jnZBAdlPQsWzIvsZXGl+QtYeWfjkjBDzkYcLvN8ZM/NopjTAdI+wKcTdlVa4aNyIftAe32nHM3JDKf925RCXSRpRu5gPxhC50GHyo7e3+OfPb00mQ+S307vMs7olIIwdoAO8UBNgDSnGuJob7F6Rf8g7GqUWfnMr9JV8a+QGKlBmE5hTYEMbKVB3MV1ZQ9Xj0NhyUERsyg4otAhLEmiwh2g/U6sxrniddxLSVm3JKBVOXQE501gCPmMvSWrzo67BYobQB0oOEsVFXawgb4Ep1ioAAuiTUK0dXLPVa9IVNpM/sqnq4yq3y3foUZM0v7SKd+9lINsQLHJNGcfLtkv6lzH37nA7v7NBmg2M6LVREXAl9BJZKCG9KuxIZGB7P8YtVmuoaWEGuMcBfU16u4okxsIg4Ubf6ToCasAQ8gfImM8DqIYVtq+XeXzZG9pu2q2shKRZtviBTqSx9V5GwEXg2/+Su6x0H2MJGIQXLtBX9WBfRrcJZhfI1GZra99WyzhGIPDe1nZWtaQtGzhjkQb7ol9JuhA/u3M2sDn3ExTq9YMom0UtjrHTQc6xa3xQlk5Yb98XWUX93EZk4cfLAdxXVZIcttUPRI71FeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB3783.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199021)(86362001)(52536014)(5660300002)(8936002)(8676002)(122000001)(966005)(9686003)(6506007)(2906002)(186003)(7416002)(55016003)(83380400001)(64756008)(4326008)(66446008)(76116006)(66946007)(66556008)(66476007)(71200400001)(316002)(110136005)(54906003)(478600001)(7696005)(33656002)(41300700001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?dAyvlCFWO3zMLPcTCo2HCHHEL1scy8CdUx0CECNdlnjmbPzQ9uyJR7Iv?=
 =?Windows-1252?Q?2trCB14HJeziB5oztbyBQRhBGNKRgOsbxm/rT7+cnUdNpNgnBPF/qSQk?=
 =?Windows-1252?Q?joGSFuPCT9RhtOADjCrpstUyTQkXt6v7wd6CSokX0VswFbjMyenctwkQ?=
 =?Windows-1252?Q?bvtRzQb8p+tZwOsjImYUqgCh7uagogo6Gazs2piIxywi6k3YTyERAxsi?=
 =?Windows-1252?Q?5ghjkvTqHxK3686IoT9Y3YSu6BfK9cbzZBKdi64fROQCROB1WRBKyc53?=
 =?Windows-1252?Q?gmhFPStgl+/qG4Lj3FWlM/7kLGfnd4yqm8A8mBwSe2vFx1RuB2ApEW3W?=
 =?Windows-1252?Q?IIAKcOiAhmnzdCsvWEB+xe1xTUj5WUFwDSofHuXe7rSUiS0OfQgYOP5E?=
 =?Windows-1252?Q?xi+TLgo+F/rQZnNZT5ekKvRLj6kgRYL3m7TzRXVrKPkWuPNg0XKeyhp/?=
 =?Windows-1252?Q?QqR+ZFRQcaqn1rid/kSATI5SJat9szXD+VZnnIwXkj4eKviv38X/c6O4?=
 =?Windows-1252?Q?jiCJHdlDBvsYDIHHT2oQZSCObMsYw47rADXnw2HQz0ChFtytsYYs5Tmw?=
 =?Windows-1252?Q?JMuCZ1n8hYOFVzNGDXPplmUDi5U2XXrsTRK1Du6Z0oIxnvVcTYomKFTG?=
 =?Windows-1252?Q?bXWnwAf1lM2LgfODDGv/XjYsLcTF4TvxO9pHfLszjbTx5xvZYo7vTjWd?=
 =?Windows-1252?Q?pXrxYvN15H0VWDVHibGz1q46CCrZsFHlxRJfOgr669qVF0wmBsofu12l?=
 =?Windows-1252?Q?V8tCEm+97GOrfntUDhdHjY0pCygsAcc/UEVLavoX38TYxj6NXbeIvUWx?=
 =?Windows-1252?Q?PC6tfthE2lMy26v6rBdRMaZUTI5YTvmdg8hCuqGlLHjq+kqRs/BPo6AW?=
 =?Windows-1252?Q?UWLoD5GpDy6D/MC3jvb1cYHTMziWKny+Xh9bKWwisZ1n7kULXjRyT4B4?=
 =?Windows-1252?Q?bej21JayYUMmGrCtS+/JEpY9LW+gIs+reh8rbsFs8dF64xt4oUg73LAm?=
 =?Windows-1252?Q?5smBDYJErZwwaoylNb7nqpD7wduQ0oeUh5DUB/rbpncTwAw7qtpyxaev?=
 =?Windows-1252?Q?NZAgv8mdgan64jH7eSdpTZSn3OXjBPOyVq3OUmS/Zb0Ra6kdmjPlOnrI?=
 =?Windows-1252?Q?Y/8HW9YLPZspJa3W1H+4RkJuPAsBB0utGzlMHKNuMHTMrN0m0JqjSRFL?=
 =?Windows-1252?Q?GyqtqzJfWD04iW0eNNzhwkcX1htAsaT5GNg1Yrnzc+0nmFoZgpTaVVHa?=
 =?Windows-1252?Q?o2rBjuCC+FSBaLAZkljaAB7NlGbjSqVi/pOIFk2njm6jCucb/8YKmeAe?=
 =?Windows-1252?Q?Da90BKDVwuVxp9BC22uYW1dplPshW6gi377hGcFPKZe//hgsVR2gTSpv?=
 =?Windows-1252?Q?S38wN3iCrbRWGBOgjuHjv1OzUep0+nrVXVLhZLkBbnL5GEXpCaCi4o0g?=
 =?Windows-1252?Q?Ax4NsTqTTZTSfYxFRPfU+zeelKsjXyBvKxDQPesNK/Osoe51XuYTDjh7?=
 =?Windows-1252?Q?F7qAacAYEJ9Wrn2NyuK8tHvoKwW1vzqWBveGKR4f9waND2qo0CqSu8hD?=
 =?Windows-1252?Q?2uhOwwRCC5yYXp3H0uDVPMgJAn6Ap4wM5K69VVpXtb0gamv4MgrHaM/K?=
 =?Windows-1252?Q?iiFr5jp1Z3D+KApqwyU3Qbx8Qs8Y/hwGb9fjI2lPulXkrugyTfgcGLJd?=
 =?Windows-1252?Q?TjY2srW9A0U=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB3783.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349c065b-97dc-4ee9-c1dd-08db5b03305b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 20:29:05.7013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+MEYwElJXK4emW0ZTneuQ/cMVngOFbZIJ1q9AxhDf9UJhHCwvrSkMFA+m/CHXPk3doaNs0nneZn3a5ezo7dbdp/Dn8xFKkWsxeTHuGjKPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11128
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Monday, May 22, 2023 8:05 PM
>=20
> This is the start of the stable review cycle for the 6.3.4 release.
> There are 364 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.

I'm seeing a few build failures with Linux 6.3.4-rc1 (20efcce0526d) due to =
the drivers/usb/host/xhci.c driver:

drivers/usb/host/xhci.c:497:19: error: static declaration of 'xhci_try_enab=
le_msi' follows non-static declaration
  497 | static inline int xhci_try_enable_msi(struct usb_hcd *hcd)
      |                   ^~~~~~~~~~~~~~~~~~~
In file included from drivers/usb/host/xhci.c:22:
drivers/usb/host/xhci.h:2146:5: note: previous declaration of 'xhci_try_ena=
ble_msi' was here
 2146 | int xhci_try_enable_msi(struct usb_hcd *hcd);
      |     ^~~~~~~~~~~~~~~~~~~

Example build failure: https://gitlab.com/cip-project/cip-testing/linux-sta=
ble-rc-ci/-/jobs/4328533790#L2178
Pipeline: https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/p=
ipelines/875108293

Commit 78887e3e5f00 ("xhci: Avoid PCI MSI/MSIX interrupt reinitialization a=
t resume") adds the offending code.
I'm only seeing this for the 6.3 rc.

Kind regards, Chris

