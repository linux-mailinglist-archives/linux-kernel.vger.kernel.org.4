Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5D372916C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbjFIHmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbjFIHmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:42:03 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2137.outbound.protection.outlook.com [40.107.113.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B8A30D8;
        Fri,  9 Jun 2023 00:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNub/q1XmV4u25kkL1GaeT3OhUOwq+qzSQdM6TDbdMzOlWQa2HCtxHKhhZGxkHZZcCStERUq79lEsFvvyTuPXhL6YXbMkWtZkV8IYHwCR5v63aEtlnwORrYUufxi7GtSU15sDAbZrH2JJVKN+NaBbqW1yXvbWnE5y58irwBMaqP71AbOFhX5RIESSK9zA5kBjN79RavlqdwXLu87Laligc0UxRlXyUx9KSHoByE0PUXvIZcjFN2PSXQiNVRwcvRB6bKJEMOMSFX8NSOuVexN+f5EsY2FNtkQ8puUe6y4zWLLahWjUytageE59ax3FaYaNsljyHFgBzehi52zzL3Dog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5H2IjYBA1cbax8HEaIKIg6im3HAgI8JDWckP1uA5h0=;
 b=QCsL710f9lPuNpFJ/NXXlebzUi3gyi/BfHGbOfVC9oW+qIepCdVCgLNllJ5m9r0I4D3bE2Q+jNZQcI+uL7EaUSVcBnlVpac8XHB70csmlQPKQa9SnbKDyZ5bPjVZ8YnBuxQzx6QpgxvG0qAwHffWSsS3efuUWzj83aAiER22QtVTGoBtqyfYg5YSLrNCLtnxa8Dlilqou8MVzobu/7IigyXsWmcplJ6jPuFvCtzA8cyu4HSlC4+q5IjaaSTA9LNWnaxxe3ZidWruiCPmBee+HgZrL8kXVemx3aQ4172/zHnNSHnWjmFc45WVjHYbSXLqCGP3JA7ljOY5cf+cCVPKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5H2IjYBA1cbax8HEaIKIg6im3HAgI8JDWckP1uA5h0=;
 b=ZivexxDY0kfVMdzyg4GkpPWp8PgtTSs0E03zhbk144bE0QoxKSM3r0p+JguKzknwe4DRQDSImufvhCo+WIZiUqPDO0fbcFdikjet9ZlzMfUpv7UY+AB7pQzvQJ53PBn5G6j6KNIjUJzyJADsOfXksVEwS5FZYIYaamCcWeoziQo=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYBPR01MB5549.jpnprd01.prod.outlook.com (2603:1096:404:8020::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 07:41:53 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 07:41:53 +0000
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
Subject: RE: [PATCH 6.1 000/224] 6.1.33-rc2 review
Thread-Topic: [PATCH 6.1 000/224] 6.1.33-rc2 review
Thread-Index: AQHZmjMtataiy52yJUm68/SCKeJZ1q+CFx0A
Date:   Fri, 9 Jun 2023 07:41:53 +0000
Message-ID: <TY2PR01MB3788B26D81C7C3CD0349DF96B751A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230608175726.909746266@linuxfoundation.org>
In-Reply-To: <20230608175726.909746266@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYBPR01MB5549:EE_
x-ms-office365-filtering-correlation-id: 1661cc55-0a99-4c0d-4a44-08db68bcfe68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z/nHb4sZilDkJhDhGy9APjFUImHi9ztCwtO5IB9gSlbwCclV0+ygDjRPvA4sevSnplGRs5nZWiyztrBNCAIc6SlQa81ncTuarYH7tIh7SWyqD0+u4+JGQwPi/OVOUIoqcb/Kk8O3tnTlFshrmYtLWqKOEBl/tNrE2Eqk+Bv1XtMkvWRzsI66covlDqf4il+9WtC6cdtC1MNzFVtQCHOhcA5FaNSCHtFBXHEMyiY32n+iXa0iJMcUXig1MxBRrTUUcn62SH12O+zmn5MhRRN+dPeunyxtLf5ctOmYi3nX3a+tpHHirh4oIoX35h9GVf5o8Bvbnf8586s/tFEhx+0eIoSj1mEF8AhTyqKoXEY1u3GMeCiAQckItEOEb+nj6/kdzB82g/7mbcWl1d0IRXfEPZGxCvGngweWPFuJHm8TPGINPsKbHd/jGH0fHHB8cmmNVFHk8kbu7NZ3s11k0LOyaP8H1yd7XmmIdt+RNHtRSdhvR5+Cfb4Ob0IQEfv9NMzvw/yHsXtB07NAK5x/k5khsxM9ZQg//tABhz+sUuATAnspx08rCNtw0n5meIwZUq1DZ4NuIrAOYdm3CMXuP0lE/gFQWVp9ttP2oC8VyJoAldOB0sgJWJMiy+ei557XjiITsmXVE3yUArDHd4ixY8khNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199021)(41300700001)(8676002)(66446008)(4326008)(66556008)(66476007)(76116006)(8936002)(66946007)(64756008)(110136005)(5660300002)(7416002)(316002)(52536014)(54906003)(55016003)(2906002)(4744005)(38100700002)(122000001)(26005)(9686003)(86362001)(186003)(6506007)(71200400001)(478600001)(7696005)(966005)(33656002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?d8MvQ5ipUBqTJ6dF+y2toxdrJvNIXheu/RsTKO8T7uPHCmlYlc62f3Kk6G?=
 =?iso-8859-2?Q?JJoWnwUiCOXwL6v72LUjbTrzNWOGJkkGOFiGAahsBy17k9xo/XUS2Xd10v?=
 =?iso-8859-2?Q?EWLqIeFK46BVCFIcoImaMVWeHE+iImCcBnZSZW8cY6jQzvkQ5SBD78Qugd?=
 =?iso-8859-2?Q?YxzD56wZ68UI22safCVcKme04Yt1+VqFgVrM/fPHVsprJG0qNpoGFJPVVE?=
 =?iso-8859-2?Q?yNn/goISI6F3AcQdBrL0rnnvqOqU/OX5bt5mKK1EwAy5ziCNUd3EsZuMIx?=
 =?iso-8859-2?Q?5H/qk20X4y4OdbDPiuo0lDe7f72KmOKybE7dP45LMFd6KrBNL7Q9yPaNSc?=
 =?iso-8859-2?Q?2b5hhYxfeJrhx7xWV2l3359WhdpaifRldLfdYr2Tntwr+mEEBSMpzmcdHc?=
 =?iso-8859-2?Q?5FwyP5idHC6fjGwOmB3sWm+SWGc3sC4Id2EiCbv14VYKl2LAupGVdfH+3A?=
 =?iso-8859-2?Q?R4KR1Q2l8PT5GoCI5WN/c6IcvdSVrsk+JcRnASLeSvrfU1+DTzAOUG0ZJX?=
 =?iso-8859-2?Q?AZSWv9MFZz/o5RlGkgy5ZqljqBAkhX/zEXQnQNmPQZ111zDPatstAgVX2b?=
 =?iso-8859-2?Q?y7Fxb6RewLIyMFeJkCxkFI5342mikgaC17c6AhzCcu12920dv+RZwhH+Ov?=
 =?iso-8859-2?Q?u/oS2G6hMDuXmfsgPzj/8n8WiNFupX58pFFawz5aP3foxM2SzpMcFVTff/?=
 =?iso-8859-2?Q?ARisQ8HRoqOhO8TDggZa7Lrsa5a2frH2gz0WqFEtH/6NUzpaetgKe8F6NF?=
 =?iso-8859-2?Q?xjgU8CGfbxJn7jEsFIy2/kYbcA/pEYWhioTLyso7qsVwAH2RJJwsD54qpi?=
 =?iso-8859-2?Q?EPlveJP5JeU3Vj0Y1cHbbUdea50E56C2tbKIcx8G7NecivX8HkV1NbuNMO?=
 =?iso-8859-2?Q?GHRTFGuSQNGTcK8m5F3Kpwv3TG+X/qKIUk99upNJtX8rJ5X04FpoW7mTRw?=
 =?iso-8859-2?Q?uAN4kzjhWFGFZwLCzgvS+w0vavgAMubkuiHPBEl2ufSGjr8IK7pDeGxazz?=
 =?iso-8859-2?Q?3yDsFWiYH5YqGHVupsKgpey4vk1eV/IObL/QXldjhdst7SQuIwKij5Eb69?=
 =?iso-8859-2?Q?VC8vOr9JfHt2+tN4xm1HZHlS13XLl8YZ5vR3+ykVnlTtq54qkEbEJCkvX4?=
 =?iso-8859-2?Q?Jg+7eCQeoRzVHJijBm56GPoXWPKubdScCkNDSuC9COXLf8Lv75MN99BpZ2?=
 =?iso-8859-2?Q?FjfPJwMcG4YwfrXMPUjuh11a8Jq7fcnRqWa+Rf6qtOg+15X3eP/4tXkX+Q?=
 =?iso-8859-2?Q?A4Jozoyhn7K8iHWL8CnnsUZqwbrfBjQHpqfdk4hydgA3eMOVX1i15GhSf7?=
 =?iso-8859-2?Q?yoOeTabZUAAJ6wZ/vYKxq0FwpIbFtVwWUP5vojsf2CAPZkMjjfqIJMP+3E?=
 =?iso-8859-2?Q?BMkZIbs0kL/kGazlvr7aLX7oLYuFFvymBH0/TRcy1x3xEHKru9wGuiNMUd?=
 =?iso-8859-2?Q?bIbcUEByGKkInOd/EYkqS00hqoBiwT/E0Vgrs+58BgYwiQVKMujYNr198V?=
 =?iso-8859-2?Q?UtL3Np2LqpuUJEtA7yZr4RVgDq3mpROk5bbq3baOkA7DA5vSPIh6cTuvIG?=
 =?iso-8859-2?Q?gzdh8+CzJ4h1Vp1csYuPaQZNtumPj1mSPiE26GTnltAEm4MvVaW+X3Luxl?=
 =?iso-8859-2?Q?6CemEG16lhqACihRJdcIDPdN9mICwDlpQ/NhpDf0B5eUkjaMvxWEGMUA?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1661cc55-0a99-4c0d-4a44-08db68bcfe68
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 07:41:53.4393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RluzreY3kB/NP53CNg2mi8gtrL3Ng9InCNkpTq1EAQcomA7k/bGcza++xvEcfT2i4aLoQ+DkUX1QHqYcmciJ5a1FVTnhdgZkAn/cyHmtLHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5549
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Thursday, June 8, 2023 7:01 PM
>=20
> This is the start of the stable review cycle for the 6.1.33 release.
> There are 224 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sat, 10 Jun 2023 17:56:43 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 6.1.33-rc2 (621717027be=
e):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
94212513
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.1.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
