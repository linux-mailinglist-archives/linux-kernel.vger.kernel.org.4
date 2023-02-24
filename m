Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDAB6A1DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBXPDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBXPDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:03:45 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2125.outbound.protection.outlook.com [40.107.114.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8872DE6A;
        Fri, 24 Feb 2023 07:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLsQu7m2J+sYEmjxTd8Bml8RT6sL7PK/s3kO6kRHHpsQqK+DL8ujXo0Wv/idA/aRr20CALy/MeUl/wcv1oE6nkXRpKBK/7Au5OBUxmM5TWUloE4ZtaCGs6mXXWOoArYgOCXIY5a7DfNjL9WUuRjr7sInt+5kkzQl2KG1jgnusc+diPSnnm4xrv3Jr1CgFsSZvBUigeAFXiQtW+fi4IpkJy47mRlRr5Mq+DqG+0U4H8BErwFHb13pxMEr97EsKnkV2arAsnTyazw4hoM96pnfgee671le1LkSuE24ltQbMeC+hXjoZrIdemMH1zs0j2jTCyjMLvz1gxtUD10Mbfob3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnmBf11w1JXqpxVINrbMp/bbB6IGCULvmOS8aMZv/y0=;
 b=PY88OgLSZMj16jtTrn3HiId5bXvKEYVnvGqDTGuH1QuuCEYt1L8Jzu5erWgsW6O30xRVO9RRhlnSts0y4HVQPxXO6Msz3rKn6EowcCgo+fgP41oyy78/KDAl6bBCJgt6XikNC0gECJGRzTaABUI9Z5FKWC7uPjSbyWjnAdE2RTXs0v6g+QP1RE8IaE8yhYtc6Ow7/UahEA571x6bDn/0wmpR+qcLeeh9Bn9T2EzbqXJgplqhbhMtJd6/tJuobC33O/K71i2P3pLar55RZWidc7+xgkWO0epB5K6LZdkT8Ojrnq/+FtMOU+IqM3f+U0G21wm9rKbmvzbBvHSST1uDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnmBf11w1JXqpxVINrbMp/bbB6IGCULvmOS8aMZv/y0=;
 b=jWJa5vzLYIwb9IZmKiimN1BLmx6NsV9uWg54c8/2vQbyr/CSftJOIBkLXxToUK8njXUDRX2UYbZGu7eiaGSn4vzMP4TavHA5T/zqacPhRA4Lho34FiPsVbZWv9HDNseUd7NhCwULlNlXSz1z81WSsFFfRD4VNcO+XTYulB+3Cp8=
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com (2603:1096:604:197::13)
 by TYCPR01MB9433.jpnprd01.prod.outlook.com (2603:1096:400:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 15:03:37 +0000
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::e332:554a:7:7135]) by OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::e332:554a:7:7135%3]) with mapi id 15.20.6134.023; Fri, 24 Feb 2023
 15:03:35 +0000
From:   DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
To:     Nick Alcock <nick.alcock@oracle.com>, Lee Jones <lee@kernel.org>
CC:     DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: RE: [PATCH 18/27] kbuild, mfd: remove MODULE_LICENSE in non-modules
Thread-Topic: [PATCH 18/27] kbuild, mfd: remove MODULE_LICENSE in non-modules
Thread-Index: AQHZRreG6t0UP/1OKUiYOQvTbD/Rt67bi/BwgAEBwwCAAF3Zu4ABSKtw
Date:   Fri, 24 Feb 2023 15:03:35 +0000
Message-ID: <OS3PR01MB8460AA34CBDD0C2BBE6F2399C2A89@OS3PR01MB8460.jpnprd01.prod.outlook.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
        <20230222121453.91915-19-nick.alcock@oracle.com>
        <OS3PR01MB8460D00B7C988DCC13173CAAC2AA9@OS3PR01MB8460.jpnprd01.prod.outlook.com>
        <Y/duxo1aKFibuZtF@google.com> <87ttzcmbgu.fsf@esperi.org.uk>
In-Reply-To: <87ttzcmbgu.fsf@esperi.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8460:EE_|TYCPR01MB9433:EE_
x-ms-office365-filtering-correlation-id: 6e9aae38-cb94-4f58-7e54-08db16784db7
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +txS+gTu2CA4d+tCDMD12NQ7Eic/rn/x4/GT+zEuK8v+aCZI8Oeb7l4XAUXLJUffiR+v0KoCoXejrN5zuQEVtXqJmpIoqwMvj/JrtwPZowjndYbfbOaKdMoxViKV06GSda+TTnchm62pODOTwJ6PKZblMVFI1s4WqwaWT2BAolfYUxjRdD3EJ5OfWy1I0RmJcIARo/aHE+Jrb1PTSmLCgYXL+bohd1XT6Z7rdjddm5HfHoJnC4z8lJr7h9lnThoNBsR6uiCnv1o+gQXU4EysbNh+3zRgWKYjKgvNBKlOMyI8+iGBuqUucSNDVY42v2hX5fZ0g46zYbL4LrwYRdDunk1y1PiFGJOVpngZM3rsJpOP/4rM2v9h6wZZ+E7rULlEbx9Lne6FBR+CHRhb9PAW8gcaexTqKUhQd3TnQnPySnFDiy/d1WozpT0EMT7sziPK5YiZR+SuAjtr+7OanHYpgJ9ZMmUBMCbPlaqyTTaJVe+F1hc06sdz1d7eRJUwTI5fV1oN6djq2NHFgcXd575mkllnAM94ZIMZjIsFI4FnYVKSsxLfrHIez1QMIyCVAXdDzi0CpXr+JnIaW9CAAS2/+84Q5l+ve1Sm3/JVVba85wsj+OYutX4yNfRiur03Q0gNyqHIo6HFb6P7Ywf0LA3WphjhLUz2zZHonCgL/ABtB4r0eJRn+0NfGdYCs2aR8RZW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8460.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199018)(5660300002)(52536014)(4744005)(8936002)(54906003)(110136005)(966005)(7696005)(71200400001)(41300700001)(478600001)(66946007)(66556008)(66446008)(66476007)(316002)(8676002)(64756008)(76116006)(55016003)(4326008)(33656002)(86362001)(122000001)(38100700002)(2906002)(38070700005)(186003)(26005)(9686003)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1tRP10NgKzOZgS/6TjCCrqmxlKfqf8u6Pr9NNU5fgtm/p49KeJLKI6tW+n9q?=
 =?us-ascii?Q?1rLn1xzxEo3uS/UYzgOgA3ZafaVDNIcoT5PwUWV99shoAszxdmwG4H846cu0?=
 =?us-ascii?Q?/9sBTGGHrrPzsloGlyLLqhJfIeRcVrtRubzSqwhUPr4FLfcmgtQ4B8zEjxYu?=
 =?us-ascii?Q?bsoyrEvXlO8BRFyTr/Fjz9kVCZclQR19PzZCr3VEcw0OaYn2Vj4raWRItbv0?=
 =?us-ascii?Q?zupvSr1ZgVatKEcaf2jwKoRnAgakXmr1j9/+jUrBJb719J3z5rgNqIpju8VP?=
 =?us-ascii?Q?r5GclQ9v3lFbVi6qf2v/6TcxUY16HRujSddlOhF3rFNkFSopGAOo0nMyIhs3?=
 =?us-ascii?Q?ffQP0P5NmawQmLStH16ctD3Cf3jG3BaVqXYEIK4JM7FUQw7XjGCyRNw+6zGq?=
 =?us-ascii?Q?YFi0/pKsIKgF4o9tR7Ap8abbORdeTOPtNdwih3ldY4uhIVJjRkegbLkwaGbj?=
 =?us-ascii?Q?Zsg5uDvuZ9EctKLHnn5EdcU4Fn4mpMm4m9+KpW+A+O+eU6kWtf3COcGKYGcM?=
 =?us-ascii?Q?2BqoKmd0BzQ0mNN8iPNZW9XWuBDb5ioTnR2ZXBHJGuZrD+XHa7pTC9rXXzbX?=
 =?us-ascii?Q?4mJHbTh2zsQu/9xAKtwojgK1apo1E1Xt7lKc8TNgA4XaqrVk1IxmF9pXGfyM?=
 =?us-ascii?Q?afnQNSgU/ra6x3a+k/xCXsaQsdJUpjfJcvj3S+QffC20g+BbpPhXNtx8auOd?=
 =?us-ascii?Q?78G2d/pJv1vxJ1K/yqQL7Jaoez2te2A89CfQVRHrVFXnwvPgk4D57T7TcVzd?=
 =?us-ascii?Q?HyNvAdkO/H7ThrCTcIjjNwjqSLfe2qWZ8gH55BDIoIMvgd4ywOb+IHDfmb16?=
 =?us-ascii?Q?TeLYe7pxCBTDivjD6AC+pEke2o44rkRJ8CKiazuFEpTSZxg50lne0E39Hmav?=
 =?us-ascii?Q?Rd1XKmHMlwvGFcUjNer9VMW/FdYEXdevL7MgaMCuuDgOM0NcWIgaEevWO4q7?=
 =?us-ascii?Q?6jUFgCu3MVmPZiMruqqltJpU8D8wtSY4FbUT7oElwuw8OwUocm6uzLIFvB73?=
 =?us-ascii?Q?hldmhsHxGHurPqlwFYwhXS/c43u1ks1JKYv7mTgTjtwDIR+tbiVXLiKv54ec?=
 =?us-ascii?Q?YmqSrWxrP+Vap5lozTvOtKQeTJJAJFDO4zifbOOok9Uk4wSA3djXN+fai+HW?=
 =?us-ascii?Q?GRws+Wf8DYz31uhdF/2Xop1cwxrwX92JMDA4nsIt8Ax9FtuYancZK+h4ao1j?=
 =?us-ascii?Q?pBfsHHwXhHoWPxfwTkjsxjGTR1Qdu0NLJhCZO3yCaO9zECuyaIWR9zJQzgDz?=
 =?us-ascii?Q?Ty1j6sOC/MivnkayJ9IhUOgLVUMMB5RiOvmxwBxFXDsYFgOqUp42xV7U8suY?=
 =?us-ascii?Q?6RKndJePp/5zlJtWuUlWHKqWBK/CAivzwoD4IhOT6TNMz9o++J25kObEb+wH?=
 =?us-ascii?Q?ngkWGHyj39//Km6ZKWKMWrBFmBtwRJFl50e2D2K9Bl+FNppdMUbCeC1LJdVJ?=
 =?us-ascii?Q?y3eya+Gzw8Xbbjydre3hCQHsmvCbaGbtdTia7z81mUWo9MLTBszJ3eeYlNvj?=
 =?us-ascii?Q?OZbxmjWUsLMQKeD3Rqye5p+VftWdlBBL0s0vkwd5IaQnmSqi+9a/Hkm327rd?=
 =?us-ascii?Q?q7Eg35lV+B89s0fyVhMFxE90veuSbGXo+zEn/rEFjGS5xsKwiCwe/5dhnMrb?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8460.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9aae38-cb94-4f58-7e54-08db16784db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 15:03:35.8346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FIcUyh95TQbmreGRjL9OtvK5+jhlRXhtguMnKCHA+cB2eYU0j3b0hhXgA1zDLPo6nCSSchJenhBc1hDndUyFUEh8WqSXJWOfvodHDtM/HSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9433
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 19:25, Nick Alcock wrote:

>> Makes sense - but if you need to do a V2, would you mind removing the er=
roneous claim on DA9055 at the same time?

>I don't know what this means. There are two references to DA9055 in this p=
atch, both in context (not in modified lines), one in drivers/mfd/da9055-co=
re.c, the other in rivers/mfd/da9055-i2c.c. To me these both seem likely to=
 be DA9055-related. Are you saying that one of them isn't?

The comment was followed by this link - https://elixir.bootlin.com/linux/la=
test/source/drivers/mfd/Kconfig#L36
This files talks about the driver being a module, but, as you correctly poi=
nt out, it is not.
And never has been.
So it is worth removing.

