Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEB36D16F3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 07:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCaFtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 01:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCaFtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 01:49:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63BFC167
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYzNoW0E65Dtbr7FJFbZVJ8soR1/ZupR9fvaj1xw2DX3iR13gGqcfFgB5sDqMx/H3Z39iLxa+q1WXGE0MDTSX+v5cAW7NUG/HGSEIk24D8NGj1nbe3JR5J0ZZBhbhsitlHKjfFceaX2t5w0t8xAzGFidrgBTfT5RfpsFbA0PRSJjlZ+RXs4eigyzfQwWUeaRTMtlO9EMeLC9rKR4SIlGUVld8Hy6Ufq2b5IOAvlUwt7XTz4U6KZHkth3IZiidmyt5ybuROQWfoUtO+cjc8DXWK4RfqXn59thx7gopqNSAWx5nYG/qDOevsbseJX/ct+/KmdOC8soeDBjTnT6RGTHzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBe2AY+O+jRt6M2u7QYPuQhaNFwNZQ7U8huMdaGedxc=;
 b=TX3UBDcHb1XxBUW23NgSlVW3TMzg0J+ctppgS/iZSNG21ViI4mt6iPoNSUvbn2XjWf4pL2PJgSMwncGMQ5GvJ5WIffvxdgw5VSAll1cGXgaXr11gZnPgIZvgIrXF+0dl2tE4PNtQ2YfSSJ35Er6pgdLx+UU+eM7KHpG7JbdN8HQMRHgANZiwahwBHiB2CjugnA3zWLvmvYEB30S6VHrVTcyp7gedrWgaGDmQRWRq+/je+DcN5ERw0O5c5hVlVnl+LCeVpCE/XIiyLYcNE4NpBpdRMvHZKcA9mERNyQDBaerg+lm06BTzGewLzTXEdBKLTjYJErRNa0jCUThpYpJs8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBe2AY+O+jRt6M2u7QYPuQhaNFwNZQ7U8huMdaGedxc=;
 b=rz89nFbz8StDpJwPwJ6H/pjFnlJj78NKr7pX/L9Nz0iiFKYgOpsC9WH8jCmBOY68pS5AXAoO7uRVTUJ+NsHExnKw5RpM99IxHA0NjnphVi8vdwDy7kIpxoH3y9A5G7FKexhqHeBzt4PK1K15vKeCz1k+ptLDGyguUmv2B5FfGJ8=
Received: from DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 05:49:40 +0000
Received: from DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af]) by DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af%3]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 05:49:39 +0000
From:   "Yang, WenYou" <WenYou.Yang@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Quan, Evan" <Evan.Quan@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Liang, Richard qi" <Richardqi.Liang@amd.com>,
        "Li, Ying" <YING.LI@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT changes
Thread-Topic: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT changes
Thread-Index: AQHZYeESu1Z/BgjKTUGFWIVG6kMXya8RV0EAgAAB2QCAABojgIAADcWggALiSjA=
Date:   Fri, 31 Mar 2023 05:49:39 +0000
Message-ID: <DM6PR12MB3531340547BE346D07E88BE3FD8F9@DM6PR12MB3531.namprd12.prod.outlook.com>
References: <20230329015149.870132-1-WenYou.Yang@amd.com>
 <20230329015149.870132-2-WenYou.Yang@amd.com>
 <20230329071014.GC7701@hirez.programming.kicks-ass.net>
 <BYAPR12MB352749E2864A87C3C32B7D0FFD899@BYAPR12MB3527.namprd12.prod.outlook.com>
 <20230329085023.GO4253@hirez.programming.kicks-ass.net>
 <DM6PR12MB3531933678779C5923989925FD899@DM6PR12MB3531.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3531933678779C5923989925FD899@DM6PR12MB3531.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-31T05:49:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=02dc1b6b-2112-4f8e-9325-e16b94f0766f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3531:EE_|BL1PR12MB5205:EE_
x-ms-office365-filtering-correlation-id: 45705dd0-7107-47e0-f167-08db31abb7dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xm9lc6ZrPBvfd4lgjUSnk+7X/QCcVADoYfFXo6QbSBOI37+BEAKfg5vX/TgRuilnqZuqFnf+uBvoE3DspQawfPTWTP4RCtBleN2mHCEY0FS4v6lCNkJKFFllBoCfR0tXe06uESsNlt4JA661ngMZ7cRiwc4HMRWoci6v2mExOZZxyXZwKmFKtoiy878TQrHYUuil/SBliXEoa2fCJso8eH+QkRK8ZdBhxweVDhSAqFFPT492TSnn7xOlxqt0BRVDqbndub8AWOCf5qJZngJ7OrQHXMsfrLWCxESvw83mGXQkiU8FrokKAWuiyuR67AxtaIfniduhNO+sUtFlzKmtn+qX2HQ9Ph1n77MBC+/YPKUiPUQYIc4m5GF4vzFrqZumX7HrO3F8Le7hzig5/zEbsK9Rp8e+4DZbNk7I9yyBxbE9Kmc9t+iNYtj5hDVXLcAkugI3rpMH4lPNMIcgoJgaVlIbnB4oNpYDkSAkMEJXDKEI8qTL9GbQLwCoI+FWkb/cLJWLezlvhkutRWRRHGWtK3HgTc4uHcIlE5KkUzPlJyws1Ho3ToyifUKjlAhDsI5CMAldQMSl38iZtQ82d0L75PaNYLCujnp6WK/jtqiSs2q8FRw7IuemxXPQAFOn+ngz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3531.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(83380400001)(33656002)(26005)(7696005)(71200400001)(53546011)(6506007)(9686003)(54906003)(478600001)(66476007)(316002)(186003)(66556008)(66946007)(76116006)(66446008)(4326008)(64756008)(6916009)(122000001)(8676002)(8936002)(5660300002)(41300700001)(52536014)(38100700002)(86362001)(2906002)(55016003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YWK5ihhjfhJz7gGP2Ysmgss2S4e2BweojUqOV27D5sYYiN+fAKuSE0uo289a?=
 =?us-ascii?Q?vp7IvV7KLz3xnSNn9Ghm/DcDd5TYFC2ZXvfiY9rc2Z1koKOeLJVMw192bsKA?=
 =?us-ascii?Q?BGdQSjj2w2Dhx51ugGiqAjXBR5uPTbvJcAysUOvh5y5a19x+6OuACHFsKQnm?=
 =?us-ascii?Q?/Nw6V8O3fTVYKhM6NuExtTY8Krn9GVrCi7NJbC/6agc1D9ec4U9hBI1jTTkn?=
 =?us-ascii?Q?BSASYuu69DO9HVSOvXa2LFeHavC+HXd0sMygh10xHKuhoim92oxSS7ahs/Fi?=
 =?us-ascii?Q?XqzGGk35OEZSyEjsoWYBj2ujPrFruqRHQRakI82lngdc5oftrPBUdrBe06bK?=
 =?us-ascii?Q?xHVWRwN0cq2jJJzKsl1cCH0X0kFLQL2BtVGXyBD8iwFOzkzXb1JZUFh7u8ol?=
 =?us-ascii?Q?4nnWs6kGPL0xwkmKzgspjqRe1XiarcyFt9MDQsKq8UkL97IfcjmgopJMPsIs?=
 =?us-ascii?Q?MqIYoaiugEN1iIL00Es27PThgimuAMRQ9IIkjDUMrtSQ654IFn9XUuLy6RBo?=
 =?us-ascii?Q?wXbl/b41HOKp3++0Gl+pYGWbMr6iFklnUcoEXUcXO2WDIUxrY6cwoGRzPCKP?=
 =?us-ascii?Q?i10CPND+HVh3ij9+3lOvlWQB0kxhjHyo9OW8zL/S2tP3Bl/R5iapcatpjdlv?=
 =?us-ascii?Q?UhSrMXJ+hdSQEOBYnDWn9RPnOYHYurtWN8mfrIjKgpg0LXReuCPdtvnJYc67?=
 =?us-ascii?Q?PhuzBtbfiQ59rKuVTw2GlKnmqVw7UoYpCZJ6ArHSx2DMkrHVQ976BBMNCemZ?=
 =?us-ascii?Q?1w9s4qi5pkMnHjg0/HQdJlsnnLWHVsry5MNB4nMYVEVhjAvg63nerFEaEzg3?=
 =?us-ascii?Q?J2XpTTMxCpBsj5T6dFVe11Ad1YAlA0b3gqUQAaiUsyfgF0Rb8CzPVAtMIhpl?=
 =?us-ascii?Q?yjd/gtPqc9tnneznoCBPF7T7XJLf5rIGmt3gdysygOp9K26Kz7anVc1U9fVo?=
 =?us-ascii?Q?Ka1exgICarEd5IfeTDZD9Dmt1oc/AK0eNhnp6hOz/VG5LnB5qP2e00LoyHCq?=
 =?us-ascii?Q?jRPCLOUDDGND5DObULSjV8Nq2Hm4UEUT3iilDJSp7Wii0tGvwF0r8XA+6exA?=
 =?us-ascii?Q?MGT0QoJVvKfdiIHZNHQE1cFz7UEuzzPhPdQpT1gQ5OW50EAWbnZ5C1p6hjZU?=
 =?us-ascii?Q?/97Y67C1MQ33XpbmH3m1KpksuLIw6Ataq+uNo76y/idyjKNePaCxRf6ko7ei?=
 =?us-ascii?Q?KVr4lE4OE3acjs2ra4cLQDdBvFeelKXkRUkZ7xIEkjYGI8g1x+brH0xL8abP?=
 =?us-ascii?Q?Yo0jJGuVXAB33f8O0eYR5gRWBt1bmQqV+bsw6L+7aJwayBjxgDCgjjMq4lDJ?=
 =?us-ascii?Q?2G9HhkHaKl65iRe8u01r4kdIlSRwFz/O8Ff5gv/k7qiWPefJZhF0oqubeJ++?=
 =?us-ascii?Q?JcQOVnzVRzc39JXNiDZjqvIIIJApxQ6+U3HXDYQ4iDSJj/awHSINoEvVQ1e0?=
 =?us-ascii?Q?EZYWprEsIhZs1UDJsuiFTZT7Gj/o77p4o9ytGTvQcVttAHo9ryLWu7MvdmOs?=
 =?us-ascii?Q?sN3H9FeJHI7kcQ/Us+UoFJpYiz56v+STBkHv6/QTI46ZaBNhACPJOv67VPbm?=
 =?us-ascii?Q?X97zLFpSVj7zIsEvB2U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45705dd0-7107-47e0-f167-08db31abb7dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 05:49:39.6569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOi7tvb5a+jKUnJ/BRfBvHLj8nXMey6Ww0R1a+P/3OqCTsd07Bod521GS2ahc38K3YLL3rY2TeIr+QFT7Ty4fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Yang, WenYou
> Sent: Wednesday, March 29, 2023 5:43 PM
> To: Peter Zijlstra <peterz@infradead.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>;
> bp@alien8.de; jpoimboe@kernel.org; Phillips, Kim <kim.phillips@amd.com>;
> tglx@linutronix.de; Yuan, Perry <Perry.Yuan@amd.com>; Liang, Richard qi
> <Richardqi.Liang@amd.com>; Li, Ying <YING.LI@amd.com>; Liu, Kun
> <Kun.Liu2@amd.com>; gpiccoli@igalia.com; amd-gfx@lists.freedesktop.org;
> linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT cha=
nges
>=20
> [AMD Official Use Only - General]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Peter Zijlstra <peterz@infradead.org>
> > Sent: Wednesday, March 29, 2023 4:50 PM
> > To: Yang, WenYou <WenYou.Yang@amd.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Quan,
> > Evan <Evan.Quan@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; bp@alien8.de; jpoimboe@kernel.org;
> > Phillips, Kim <kim.phillips@amd.com>; tglx@linutronix.de; Yuan, Perry
> > <Perry.Yuan@amd.com>; Liang, Richard qi <Richardqi.Liang@amd.com>; Li,
> > Ying <YING.LI@amd.com>; Liu, Kun <Kun.Liu2@amd.com>;
> > gpiccoli@igalia.com; amd-gfx@lists.freedesktop.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT
> > changes
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Wed, Mar 29, 2023 at 07:23:29AM +0000, Yang, WenYou wrote:
> > > [AMD Official Use Only - General]
> >
> > ^^^ that has no business being in a public email.
> >
> > > Hi Peter,
> > >
> > > Thank you for your review.
> > >
> > > The purpose of the patch set is to improve the performance when
> > > playing
> > game for some AMD APUs with SMT enabled/disabled.
> > >
> > > When change the SMT state on the fly through " echo on/off >
> > /sys/devices/system/cpu/smt/control", the kernel needs to send a
> > message to notify PMFW to adjust a variable's value, which impacts the
> performance.
> >
> > When top posting I normally ignore the email. When not wrapping email
> > I typically get cranky. You 'win' *3* 'I cannot use email' trophies in =
a singly try.
> > Surely AMD has a HOWTO somewhere you can read?
>=20
> Yes. It is my fault. Sorry.
>=20
> >
> > So what do you want to have happen when someone goes and manually
> > offlines all the SMT siblings using
> > /sys/devices/system/cpu/cpu*/online
> > ?
>=20
> I don't consider this situation.  Any suggestions will be deeply apprecia=
ted.

Hi Peter,

I don't find a good method to handle this situation.
Yes, manually offlining all the SMT sibling will get the same result of SMT=
 disabling on the fly.

Actually, the normal way to enable/disable SMT on the fly is to echo on/off=
 > /sys/device/system/cpu/smt/control

What are your opinions?

Best Regards,
Wenyou

>=20
> >
> > I'm thinking that wants the same PMFW (whatever the heck that is)
> > notification change done, right?
> >
> > If the answer is "yes", then your patch does not meet the goals and is
> > inadequate.
>=20
> Yes.  Need to improve.
>=20
> Thank you.
> Wenyou
