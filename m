Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D3B6B6E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 04:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCMDh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 23:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCMDhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 23:37:55 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020016.outbound.protection.outlook.com [52.101.128.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B453251D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 20:37:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vk0is64BEIUmv0Mk52Aj+y+zTly2F1nN4pm8gUd1IlCZrLOf6JGFX6Vl0nCwQ29LQY9DbSpXYQpoHn3KyWLLocz9DEw+akmgAc1zWdooRAKm3jRS7vI9wlVLYVsWTqC/z6FwJcYq4hYm63a4G0LFdF7puOb4G5icAJkVQf/sl+OVSYX8ufvNlCnsZrt8JLdnOYcFQWhUFSCSq6uz+V6IInB+XMFMUXAUM6POTuwh7Jf0dfiWZ3gqGnhs1A2nr7ZZNO2Ez+Dlic66K/sOivufCy4wV5tYg2bB3Iv6RMSbyW1sg8Ic2UUK2QU/55qJVAnJ2OGs7ep2rCXXidcb2ZMiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCf/gw+a8POVyoEC631H38YzxhT3mnBgn3foSQ/KX7Q=;
 b=FzKRGwTVo7KM2aecePP/jJMv4IztnAza1qs5UqAflFIG+BwWnAUY2fsIPB5sWFucGmk0tXhIch34T1zpLE2EwbnY3Z+YVXMHI8KCEt5TN5SMbg1YdYtZGfTwI8bUJDYu7Lw7u8u1bU81YP7fbtkxE5dmECeb5b99Delj9XeZDKpohgST1HenXHeswmywtu6xPjNKcDiSoUhMuCJFFrdpCGvYNFmThcaee38qW3m4e4sbdA99Vguo++FYOSbIyADn19ce+Bi142JlkXWZnTCr8ChE5XgfXc+P5oNpBZiI1ToXlsXAjswcXPBnRSeweR6KojyDoFC35e6Ka1Ti8rh1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCf/gw+a8POVyoEC631H38YzxhT3mnBgn3foSQ/KX7Q=;
 b=hZgNHBnIr6iILLYcLJPfLRfWwWdU6R5vi1UBfr6tiev5+cMZRD34vaZPqdLshz0bYhF2RpYRW92gM5uw9R+JLnfwkuIsu99HHu1axQvgPF5Z4CmUA83HMq6U1/+GU7BAI+SOFwnKDyH15osxnAr5JaKhu5jSbt1M7lD7gJvGMRc=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 TYZP153MB0430.APCP153.PROD.OUTLOOK.COM (2603:1096:400:2f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Mon, 13 Mar 2023 03:37:45 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::efc9:b06b:c407:5b6]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::efc9:b06b:c407:5b6%6]) with mapi id 15.20.6222.003; Mon, 13 Mar 2023
 03:37:45 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Borislav Petkov <bp@alien8.de>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "johan+linaro@kernel.org" <johan+linaro@kernel.org>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] x86/ioapic: Don't return 0 as valid virq
Thread-Topic: [PATCH] x86/ioapic: Don't return 0 as valid virq
Thread-Index: AQHZVV0s0K9sEwubBk+XEhV+nVia1Q==
Date:   Mon, 13 Mar 2023 03:37:44 +0000
Message-ID: <PUZP153MB0749DD5C9CE7B60DDC75ADACBEB99@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1677785686-2152-1-git-send-email-ssengar@linux.microsoft.com>
 <20230312204019.GBZA44s28AOAfAcRuy@fat_crate.local>
 <PUZP153MB074987B356FCB28933B87CCBBEB99@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PUZP153MB074987B356FCB28933B87CCBBEB99@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5a8939aa-a389-4c82-b8cb-7804940c2eae;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-13T03:06:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|TYZP153MB0430:EE_
x-ms-office365-filtering-correlation-id: 55d323aa-b1a6-4768-7857-08db23744ee8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uMruA2FFWfTDIXnIAsUATYmytwt13oSZE3DBGJzwpfpn/fJOsveeNa8TbVwSONKnnUzSl/Mx1rTBw3W7NAr+Pbg+7kCx6QAV7XZIZ7I/i2uiV2uMfT/u5LoMU1hA1Ilm+86aLVOPI6LWcgBIzyaZLi88qxqX/fcy7ArfAWD2DUap/30ri4rqv8DSiyKOdSWSFHt2vb8Jghyi0Ls93gFIk1sdHK0GgzDP2bvKxSJx9DAivDa5mjOsb7KvQWrihjI7cT8xRp83drgVTvtbUcDga+7rVa8i4Dj++IdG+NMpDEcApi2lUmxBgOAAJaSCkLDztrH0pS5JwYiMgH7ywdZkAyk30wURC3abJQ8WdDT9T5qcWYYIXPZUt1Takpd2sasWYYDJz5AzG5cJp10TTwG6Mdb2744uOLZ94yoMaopq3OMJlLgl2n+AqQfm7QO0XFN3xLTsbZ+kjFuhTlHSGVSAnG0AsrJaQuJ7+yHIi5w84cN878vuK/DkLvpCwdO2NuL0WoVrd594mS9Tc37mlSiIoqb/FxQEtG3F0fsxtQnVe29zSlEHk6rMxCJl29LjGN23L/at/oQTNpOttN8mmIXtpMXIsQci1UK04B07fFc7+syUB7Oyzh2UlIhaRjorialtqVijRnwst5kbiqSZQBs0PHj5Y8zXhyu43S2i9E4XsTicHXJRV0ZFCx1LJn0I0m47e/34vlhxQqkt2pryy1xxX+TmlEwMTKounXewDAIjFxoFens6v0+/7DkkqM7I5Ylp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(122000001)(55016003)(33656002)(38070700005)(82960400001)(38100700002)(82950400001)(83380400001)(52536014)(478600001)(8936002)(5660300002)(86362001)(10290500003)(71200400001)(7696005)(7416002)(966005)(2906002)(64756008)(76116006)(2940100002)(66556008)(8676002)(66946007)(66446008)(110136005)(316002)(66476007)(54906003)(4326008)(9686003)(41300700001)(186003)(8990500004)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/ivJPEFjsczb/1t3cE2NgZBr98atxps1kZgVQVyjuqKDsYtppFqcMgG6CNX7?=
 =?us-ascii?Q?HE5U4xMcn8g8QY+tt3qhYDV/4evanarhAcW7lLf/T/ta9h08jOnwjQvkit+d?=
 =?us-ascii?Q?fH3zDXbNVh01tf14nnYzAmrP44/Um1OYQcTpHP1mMcCWSHrSRSaPTHKJIJL4?=
 =?us-ascii?Q?+2evOs30oiqty77zFfQEW7QFG44LfWbzLT3xanIDRa0jwBtaOoweF0dyBoJ5?=
 =?us-ascii?Q?MMQN/O6idH5VOMzCFU9eTVPi/C5LLhpllcOZNsCEMLU7xgPDLHb7I06y7pSL?=
 =?us-ascii?Q?5PJZ4S65f2MwXEHUGdN4Abi4GzYkANWizvdxsSm+ChFPWEZ1YLQxcZnLxQdX?=
 =?us-ascii?Q?qcM7oMcsZd2wWqo0M4TbsH1VzA5+vB/R3EeU9ueRyCJnrJVi18K+5pdERcf+?=
 =?us-ascii?Q?IU6khT1gvdtcEhFtKy47HcF5VmJT7ntIhO5c+8fLdew7Nnjdc0PyS4+x3kXk?=
 =?us-ascii?Q?KSJmTzpvflKPTQJTCYVgY+ffLZ2wMPTLsKcai9QlKD4HtIe7Hz1xdKHd0yEg?=
 =?us-ascii?Q?vs6WDFu+QyguRlrJG/i6s7sejmiBa/PR2RPeoNeJwhRuKJ9z13WBUnX1eo5T?=
 =?us-ascii?Q?bD1BEfzSSmJdRuSoGbj4dTxVSQL5gfw1Sr5T7jTPR4L0DBTV6NqqtCYxBZo6?=
 =?us-ascii?Q?fAnazLMkLvKksKT3D3QoeiKjtCkpZl8zZ4GmfHSKgJLgoq/TlhD2tvZe4TBC?=
 =?us-ascii?Q?XCLI95nVnGYTEuv0n9M3vLuYh3DEzD9nsFonPP9OPE1ZuFeqlAy9+e7foa16?=
 =?us-ascii?Q?2O7EF4JeY07HRes33+fBrpH0KgHddueOn5Kimxb/bCttaH+gOErN9dxWNqJd?=
 =?us-ascii?Q?pfY736aWG5wN5BgK6OJauRge46NJ+AahNQyGSR15L2Vk+i0FMUhIS5iFqWRs?=
 =?us-ascii?Q?+G6U4jV/7ZXFCG4o/ZZ8E6ugJaek2dOAqHx2HfqmgBSRguKjYjQzk8T32NyP?=
 =?us-ascii?Q?kr26em2fFnJhiqRk52NDwofKmC3Mzf0CNwgO2mSaQLBwsDdsrSt9f4PQ5hFm?=
 =?us-ascii?Q?omfMRVEXWAAYZRHPjAyNQ07RSqQe4gjqzWj27xVMelR7RjYmuG6m9X6luTor?=
 =?us-ascii?Q?v4LBM0bkjOjnwUhSG2n2Qvm8/uVYOwBGBG73/zw41l0d1zOO7JeP03TrMTzy?=
 =?us-ascii?Q?YLuaXAaKQDM73pGG/uBwv85wG5pqKiZUnNG92j2YiIZBBiriQ+fegl9CAMzt?=
 =?us-ascii?Q?ZGl4bul9VT49ik92133IwrLWbeniuin4AVvnMhErJSe1CrezMl7XBVRVD53f?=
 =?us-ascii?Q?EmVI1gJDHu098xm1By5/bSdiKUCdbtAXoY1DDs21pMfU9qeEOcZZmzE2CXVL?=
 =?us-ascii?Q?K8SXbQQPTMk1KFLsetXOmyu3QOy7Rfbcq6m/4VQIrKvTTLZ7uvEhgb63dlE/?=
 =?us-ascii?Q?b82MtUIMVRnQr197uuYzrMuUXZSDuQe7QcGpVSmzfSYLrb+W1bceSOZZOYSp?=
 =?us-ascii?Q?bRDRmpjnprBP/lO+LVY/vUOR8nT/Pt+/zuBX8Bn0glulMXTGZ6dptMhKBvOg?=
 =?us-ascii?Q?YRoYHVWt156RvedhIk4W4eFCPB0f5rK4BD4avmtkHj2l5XTrRpHUZrnc+6Jv?=
 =?us-ascii?Q?VzByo1mR7/qK/nz/1hYwMkvzv2/SljhkxLWFPEWC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d323aa-b1a6-4768-7857-08db23744ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 03:37:44.9582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GUGgH80WjGZ3NKPNtIcOMJg5fVwi/IRwTyFZOihQiqJTv0pqBuU7eau6DcWQ9PjbAO1Ogw+rya8c4KcCjKx1Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZP153MB0430
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just see mail to rahul.tanwar@linux.intel.com is undelivered, shall I sti=
ll add it in "Cc:" ?
Please let me know what we usually do in such cases.

Regards,
Saurabh


> -----Original Message-----
> From: Saurabh Singh Sengar <ssengar@microsoft.com>
> Sent: Monday, March 13, 2023 9:00 AM
> To: Borislav Petkov <bp@alien8.de>; Saurabh Sengar
> <ssengar@linux.microsoft.com>
> Cc: tglx@linutronix.de; mingo@redhat.com; dave.hansen@linux.intel.com;
> x86@kernel.org; hpa@zytor.com; johan+linaro@kernel.org;
> isaku.yamahata@intel.com; Michael Kelley (LINUX)
> <mikelley@microsoft.com>; linux-kernel@vger.kernel.org;
> rahul.tanwar@linux.intel.com; andriy.shevchenko@intel.com
> Subject: RE: [EXTERNAL] Re: [PATCH] x86/ioapic: Don't return 0 as valid v=
irq
>=20
> Cc: rahul.tanwar@linux.intel.com, andriy.shevchenko@intel.com
>=20
> Thanks for you comments, please see my responses below.
>=20
> > -----Original Message-----
> > From: Borislav Petkov <bp@alien8.de>
> > Sent: Monday, March 13, 2023 2:10 AM
> > To: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Cc: tglx@linutronix.de; mingo@redhat.com; dave.hansen@linux.intel.com;
> > x86@kernel.org; hpa@zytor.com; johan+linaro@kernel.org;
> > isaku.yamahata@intel.com; Michael Kelley (LINUX)
> > <mikelley@microsoft.com>; linux-kernel@vger.kernel.org
> > Subject: [EXTERNAL] Re: [PATCH] x86/ioapic: Don't return 0 as valid
> > virq
> >
> > On Thu, Mar 02, 2023 at 11:34:46AM -0800, Saurabh Sengar wrote:
> > > Zero is invalid virq and should't be returned as a valid value for
> > > lower irq bound. If IO-APIC and gsi_top are not initialized return
> >
> > Why isn't gsi_top initialized?
> >
> > What is this fixing?
>=20
> In the absence of a device tree node for IO-APIC,  IO-APIC is not registe=
red,
> resulting in uninitialized gsi_top. And in such cases arch_dynirq_lower_b=
ound
> will return 0. Returning 0 from this function will allow interrupts to ha=
ve 0
> assigned as valid irq, which is wrong. In case gsi_top is 0, lower bound =
of irq
> should be derived from 'hint' value passed to function as 'from'.
>=20
> I can add above info in commit message,  please let me know if anything
> more to be added.
>=20
> To be specific in our system which is a guest VM we don't need IO-APIC an=
d
> hence there is no device tree node for it. It is observed that we get irq=
 0
> assigned to PCI-MSI.
>=20
> >
> > Don't be afraid to do
> >
> > git annotate arch/x86/kernel/apic/io_apic.c
> >
> > and see which commit added this. This one:
> >
> > 3e5bedc2c258 ("x86/apic: Fix arch_dynirq_lower_bound() bug for DT
> > enabled
> > machines")
> >
> > Now add the folks from this commit to Cc and tell them why in your
> > case gsi_top is not initialized and what they're breaking by doing that=
.
>=20
> Thanks. I will add "Fixes:" and "Cc:" tag in next version.
>=20
> >
> > The more your commit message explains *why* you're fixing something,
> > the better it is for the maintainers/reviewers to actually know what to=
 do.
> >
> > Right now I'm reading this and I'm thinking, random, unjustified change=
.
> > Ignore.
> >
> > Ok?
> >
> > Thx.
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeop
> >
> l%2F&data=3D05%7C01%7Cssengar%40microsoft.com%7C0595a41023f849c5ee
> b308db
> >
> 23732cd0%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638142749
> 8888650
> >
> 08%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI
> iLCJBTiI
> >
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DqpOM5MMYpUof
> VOaNsp8HxTmv
> > %2B80iVn5rFfzNQTlTwLw%3D&reserved=3D0
> > e.kernel.org%2Ftglx%2Fnotes-about-
> >
> netiquette&data=3D05%7C01%7Cssengar%40microsoft.com%7C6e1e0e21051c4
> >
> 9c1cfe008db233a0376%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%
> >
> 7C638142504360574969%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> >
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
> >
> %7C&sdata=3DOLdgb1AuLbLvlzucgNFBQEEK6G%2FsFV%2BO2TqT%2FNCujJU%3
> > D&reserved=3D0
