Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D56D61FAE1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiKGRLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiKGRLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:11:10 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86172140D5;
        Mon,  7 Nov 2022 09:11:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPfnv0X3iGTBU/kugiB9mjYXEBQSIKrUvow4Vq6sOTyTYc/MZhnt1lmqrq6jcLEuw/gWDLlUDXMEe/iKN5sE5KmIbTfd6ZFw9xOh7JOJTkpyhgXeMoNcV1jFdSxeGtzf8fzGPwgaXoibcLJSM207gTL+eVyYIgwJpdsuDam+a+UCVh60JIBCaaFyIpzN47h93exSpLIkjKpMQrWqifDs7LM4hjrpkBvWj4oyBR/p5SQyBeWAd7n3Zfo/r/1dUt4pVtFX3bOvJm0NVsJUlIPHH1CI3YC7hoMOTPU4F6I8ZqOe2VylK3DHgf8srDYGMfonKIqehrDzhWRaAo55F87c6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcSYL2RWUfESwXURc2V9nje4ZLAlZ6ONqi7c6TWDCUA=;
 b=gEoTrJsSWMMoUiAzXv+oD2XUzP2oDbDqTj0D3pAvrks/9XOliqSkp6maNINHJdMFqpGirS8RYRKzXgWeID1154nQXfWeXom/C3lHHolW8QiMppL+YvXRCTFxrkOOMRJr6tMF4rFJrwvWC6wOlT0gy6bRLy3IrvFpRRND+t67xjat80E0wQrtqr1MB3dSmPNam9iDnt5E69v6ckU3x0iij6UPgou2w5QkKy1NzOOzmTVRQsuL/bbK/f2DWpZiX29Qnv6BtYZxTTBJgpm5amC54sOhXycayvu5lFuOC5bmrI5bJnt++dKvyn/NfebehmmnFz2giMbSBMd329/XS/IxeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcSYL2RWUfESwXURc2V9nje4ZLAlZ6ONqi7c6TWDCUA=;
 b=TZxAFu6cRmJxBMePC2/Z6+OKzXzfUFa7IqiQ8Q0uRqP+Nouxp6KkmW2QduPJeuac2dgHuT2dhFPi/UeaapNQBEnu5lp6b+kREVpa5sXimpw6YeV4l7r05esfEO/7UORVe+dqPjtAW48fBFGPN/bZ/UyVcZ3B5AXLeUihne3R2mA0tdAUvNamY5q0u2Uad+zu+lAJyhJnzeaTKwLvkpUgJGXoThq5hHzGHnkFubDK9vYmgeqaRXTJRzVumqQToNmjyhV864Y0sw5AVmpc1wnQJtBO3omQOiITspzpUEKcI9TMeGTR3XFFhxZyXMugYUMdJlb0zAD8XMgrilZjcDRxrg==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 17:11:07 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::46c4:5346:c449:9bd4]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::46c4:5346:c449:9bd4%3]) with mapi id 15.20.5791.022; Mon, 7 Nov 2022
 17:11:07 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Will Deacon <will@kernel.org>
CC:     "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
Subject: RE: [PATCH v6 0/2] perf: ARM CoreSight PMU support
Thread-Topic: [PATCH v6 0/2] perf: ARM CoreSight PMU support
Thread-Index: AQHY1HVBF/GLNzqT20exjr0smAT30q4z2SkAgAARs8A=
Date:   Mon, 7 Nov 2022 17:11:07 +0000
Message-ID: <SJ0PR12MB567614CC049F93584631DFBAA03C9@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220930023443.9463-1-bwicaksono@nvidia.com>
 <20221107155311.GD21157@willie-the-truck>
In-Reply-To: <20221107155311.GD21157@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|CY5PR12MB6130:EE_
x-ms-office365-filtering-correlation-id: a336fcb6-5ebb-4cff-84ba-08dac0e30f66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CvrO0pV7WCc5B6mYI7uecKhfs9EgosahyWQRH2WWuXxi0x1RBZjIPdRghSboMG4YBl5VHBTAkNCNTWV6P1mnuUdEDKZj38sSv2xc+X2MrO3gcw8AlFnKp4AzAfdbNcDhaW7Bl71skN+eWpFehZ5ijVuUDzEgIc10A8CI41IyHI4BIF7M92wmqXahS6PIVWQh0goGhPYRUu6po1usTrwqWuDvn1DlzCuWpJIvdUHXpsuAJh28+zrHGzEGcYKRAEZzUh6A/LSRYmKh+LgyU8IgrawAlPHmtk08CQaB51XmUR+HyYU2+px9USbTg/fSe4Lp0wWVK4RgeVJHSUyBrxhGklzAfdJ0dkSCQkEBRbj972IxMweIcBZiq008TNT/lajgz/46TkTjn5Ok3d+VrhoTPTCI2T92y+0+jXftL/g1L8WT1HR3UBCEEBfjTP4cVpxuZB89kPYSCeaotIf1pRgBvBudAhw3s3n3QAaO9YhxcooTcJm7L6xBytgi3fAf5Wb39eGSKRTy5CV+K8uVUZke1mCdszzQsSDfg9sJyDWM1xr3M4VKeT7AcFN6nt1x0Eud7aTHaTNBTMLNWU7sdTaFnhg++1uL4F0NdBBbzijgCRe92LtMWU4wgGRn+9OxHimSgb4MQiqjoxAUh49GS88DriAvEp6qRY7mC59hRIyYWY2PBohRzKnEz7pklkkaGytaRI4FiTN/mDNqquNVBtDLitCOjRlJ8L1uBJxC/vQ+PJEF7ttQumBQ1ai486/BrdqRN9jcNObhikEdVnjlE2V/uQ2d2OqdFCrV+xpTrTltG3A6qO7+jiHG6CMqyTWKsvm3jhpWR53xDMPse8ggxrJOEpRPspZTgaGAmqpjt0Zjb9c+G1lffrt8p40k+OXaRiFT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(41300700001)(4326008)(8676002)(8936002)(5660300002)(7416002)(52536014)(6916009)(54906003)(9686003)(316002)(7696005)(6506007)(478600001)(53546011)(26005)(38100700002)(186003)(2906002)(966005)(71200400001)(66556008)(66446008)(66476007)(66946007)(76116006)(64756008)(33656002)(122000001)(55016003)(38070700005)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Hez1GA/nQC0Kpnbe2TLSxMbt/LeRZV8E2MknxwUHMCU40Jt8x4inhcvfhlC?=
 =?us-ascii?Q?4yNSK4f4BNtvcL+s/0S9UFvqHvUDXA4EkGI5Hp5qFeHw76pWUVXvbSfH+l/0?=
 =?us-ascii?Q?lxCRlAlavoExqkpDwMGXgFaxZpUiQ3ytJxfhAd7lWzig+xq/bZCovMb/qSZ1?=
 =?us-ascii?Q?+5SISyn4lyUDepe40fFuo309nJNrBCpHo2gBx3UBgS8NYutNGv6/4iz3zE3x?=
 =?us-ascii?Q?+wfM2yw3O1KZNfdZKNBukZQoBQSh9lMeuXRzh5EfhFDEGTbzdlvVMM7jcA0M?=
 =?us-ascii?Q?vII9npgTJUiKFdlQPMav/O67D1jRm2fXDQPjWUypnq0veMIvptLeEQYK2GHz?=
 =?us-ascii?Q?cqwN2/7IQ1hvL10sLuYnEv5lt4mwFu6DX84Pu5KH37nwaGsEXXp0ScIhVxe4?=
 =?us-ascii?Q?LOWobf2o8p7ZuJ647K4I529iLljWjQFHPyINaYtnWIwuuAncucLVR8wRcAhF?=
 =?us-ascii?Q?dQazOkNq6Nj+cZ95yjCykkqw7t7wfq5uQKCLp16cLW0dZvmEHIYzg0vSTkPH?=
 =?us-ascii?Q?FKGb8Vfm8sSop0tWkmZlTWtxyYrqgQFuKWtQgABaT36/FeMwSQ3YpLSwfQie?=
 =?us-ascii?Q?5WoK453fZ2CteO6r7xbrlMSweJ10GrfZd1fT+AqFLi4Z/NUqVd3sq1aWJ/5X?=
 =?us-ascii?Q?We3a8AiPzmK7FoJvJxzo/i74mr9LzocPfV/4866dAHfyyKyao3Pbripc9og7?=
 =?us-ascii?Q?xfHZb0vc6X8r/1lS8mJs7lMdlQ6WRxVsn8Iwzcw3TsMO/NScWJtL5GVHLXEi?=
 =?us-ascii?Q?ej0sI36lOrUU8qNNvAByMZ+CixAOHnP0j7qvm/RErLV9bL3seSvSaiyNkfXb?=
 =?us-ascii?Q?3U48xTNceH0a9+GAtku1FuxQh9bmfUwDLcq+kP5WzuOJF/ct97MVDtl1vF2o?=
 =?us-ascii?Q?D9Blvj9Gu/QvxOoU3pWhhPHyAklk/Fby6gJNALB7Wv+bDIps7Ci3sraYD4b2?=
 =?us-ascii?Q?11lp56FmuPZ7bReXLiIGDWf1bZ1psDsvWVjqwlyPRT9xRTFUbMyUa2gKW6Jl?=
 =?us-ascii?Q?ifDWdy4nWW4++3DUEJZXiHZk+fEn7va3an9FjbZVQaw5NnaKn868Dr5TkF4Z?=
 =?us-ascii?Q?fxZo3XP74wMUcS44judFdTu8XP6OLrlTzMcsA+R7soBoJHi681g7lzvfiBIT?=
 =?us-ascii?Q?cd7NaJVHxN94iCPgivX1ZHnWVuCeokdpfUeLHo8PzhZe2NXkEgShPbycizeZ?=
 =?us-ascii?Q?w7T9LgDMHZlp58xkVoUjBBRIUucNdnLx2SQbmbPDj+9OnW1BbY34dwRPlTHi?=
 =?us-ascii?Q?cjGyUxN08jsDZfltnFHSjLz+V9RBv7irPrFUED3C5OMuhb1t/seFAkDzzVEs?=
 =?us-ascii?Q?mloMNeLBZ1u2xdAkSohbiNKOcZvd224LvW8X6GDuc4CbKjrZLTqAgrelBGy5?=
 =?us-ascii?Q?XDRZQ4lZ91IPU0CSP/BaM9kb8L4raigt2M3U6QLl3bmFy93t0a4eJyqFZ/PF?=
 =?us-ascii?Q?3ASGr3HJELGrgtehXYUaOFiYSUXRqFcLDreeCf7RTAPIAwbQ1mE0SnKsuyU9?=
 =?us-ascii?Q?h9kU4eR/3AuEqdWe+FW1/OTYvi1LEdzPWzVm0MNew2VwypuwvRMkk+DE54Ac?=
 =?us-ascii?Q?8kwKuPvpED77ig4QYIRhy0HGr03wY45ckAbjoyZV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a336fcb6-5ebb-4cff-84ba-08dac0e30f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 17:11:07.4363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dKBQ+JqLAqD33DQU1zRgf9GFCviOIRZUcNGyRK/parUdqjqJVqLfTEd9W6ifazQ3B4aEl7sE/wsFqrvpw4M+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: Monday, November 7, 2022 9:53 AM
> To: Besar Wicaksono <bwicaksono@nvidia.com>
> Cc: suzuki.poulose@arm.com; robin.murphy@arm.com;
> catalin.marinas@arm.com; mark.rutland@arm.com; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> tegra@vger.kernel.org; sudeep.holla@arm.com;
> thanu.rangarajan@arm.com; Michael.Williams@arm.com; Thierry Reding
> <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Vikram
> Sethi <vsethi@nvidia.com>; mathieu.poirier@linaro.org;
> mike.leach@linaro.org; leo.yan@linaro.org
> Subject: Re: [PATCH v6 0/2] perf: ARM CoreSight PMU support
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, Sep 29, 2022 at 09:34:41PM -0500, Besar Wicaksono wrote:
> > Add driver support for ARM CoreSight PMU device and event attributes fo=
r
> NVIDIA
> > implementation. The code is based on ARM Coresight PMU architecture
> and ACPI ARM
> > Performance Monitoring Unit table (APMT) specification below:
> >  * ARM Coresight PMU:
> >         https://developer.arm.com/documentation/ihi0091/latest
> >  * APMT: https://developer.arm.com/documentation/den0117/latest
> >
> > The patchset applies on top of
> >   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >   master next-20220524
> >
> > For APMT support, please see patchset:
> https://lkml.org/lkml/2022/4/19/1395
> >
> > Changes from v5:
> >  * Default get_event/format_attrs callback now returns copy of default
> array.
> > Thanks to suzuki.poulose@arm.com for the review comments.
> > v5: https://lore.kernel.org/linux-arm-kernel/20220928201830.45637-1-
> bwicaksono@nvidia.com/
>=20
> These patches no longer apply. Please can you rebase onto -rc4 and drop t=
he
> defconfig change from the first patch?

Why does the defconfig change need to be dropped ?
And sure, I will rebase to 6.1 rc4.

Thanks,
Besar

>=20
> Thanks,
>=20
> Will
