Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4630E6B6DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 04:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCMD3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 23:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMD3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 23:29:48 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F9E30B2F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 20:29:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuPobJ/Nd86YL4x0cglhMKk3+fh48+ldkcimJLvPpKCLTLphiTpdIVSAVnic/9MkThL3yiyNtcPvBO/blCMTqM60UsvCgH6vBP+g+reIsEDRoANywAOjqutdusvMt3qQbVBjVx7drvh0SEjJNe1iAu6GCe733T/n+sRt7odX5v1R6ixcBphYhlRjJ54OFw1X9rUxtboFfJE4qiphSaEWFOVFIGraWdYRdryWpt2ZkTvMvC32i74qGnKdf2SXJd/VdbJ9kLpPuLnbIhueA8uqB1AXCoE8qYOvQUiRgB7LjcQztE1S/DK08UGgfTmrwsLwQ01zZ+KXxN8/WBuClXewoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zceNPwGU7RnxqXXEDSRMMik1Q0IH22FGEmOKWVsqyUY=;
 b=Jv9pBxlctr7kr21qjGn58eii7x9Z0Ox//+DFp4lJJxhf7EqDLaND9d7ay/+T5K0OBCFb8xRD2Fdz+6Tj+A5XKEh5sytLJkx3JUS3vxisSOco8A699RsZW+mhzn72mtwq337UT2s024Xmbw1lZry4iSqYOHw8mhR4i4GitmnWjEH3vWv72lERg0OUqjkJjQFCnTaYLmfpj76MbsIhR6htB1519zH56GSxUzUg9JQMoevW2zxpo/dX1kbN5T80//D6BIsoqkhi/X71sj18GYsedg70gEbHsdn9g+Fo5hYbW4AJCsxCfTVRo/QalRafS2IYfQHaLJEcwQkrX+SREqsxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zceNPwGU7RnxqXXEDSRMMik1Q0IH22FGEmOKWVsqyUY=;
 b=HahnGEQyYYTORUVCl7ac7V7V6y/pYiHz2F5dC5EeqJT/rthOTjJU2ygpCJPhsx6GelP61V4wLl4VSOLfjjDKZTxmOxyQ/WLs/wYMUhi/cybQOshQ6lGsgprRAes1B1NGUodNnMOJigVAwjZyPsBi6DGNxC2trW90WAchDE4KrD0=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 TYZP153MB0430.APCP153.PROD.OUTLOOK.COM (2603:1096:400:2f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Mon, 13 Mar 2023 03:29:32 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::efc9:b06b:c407:5b6]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::efc9:b06b:c407:5b6%6]) with mapi id 15.20.6222.003; Mon, 13 Mar 2023
 03:29:32 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Borislav Petkov <bp@alien8.de>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "johan+linaro@kernel.org" <johan+linaro@kernel.org>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rahul.tanwar@linux.intel.com" <rahul.tanwar@linux.intel.com>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
Subject: RE: [EXTERNAL] Re: [PATCH] x86/ioapic: Don't return 0 as valid virq
Thread-Topic: [EXTERNAL] Re: [PATCH] x86/ioapic: Don't return 0 as valid virq
Thread-Index: AQHZVSLlnKDpznJzjEiFU+MpmtQn5a74BzVw
Date:   Mon, 13 Mar 2023 03:29:32 +0000
Message-ID: <PUZP153MB074987B356FCB28933B87CCBBEB99@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1677785686-2152-1-git-send-email-ssengar@linux.microsoft.com>
 <20230312204019.GBZA44s28AOAfAcRuy@fat_crate.local>
In-Reply-To: <20230312204019.GBZA44s28AOAfAcRuy@fat_crate.local>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5a8939aa-a389-4c82-b8cb-7804940c2eae;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-13T03:06:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|TYZP153MB0430:EE_
x-ms-office365-filtering-correlation-id: cd10a678-a416-4c51-3b15-08db23732955
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JptSIFZen8RY+4O5/P/nEGz6UvamI4nBvkHEgVupuxAJMhV1IRn0GpWI4c1JNkYu17F/eBGt9JsRle0wIQ1Yfq+02s2Vu6EJMjmjKBYch+EhartBU7NytJ4FmqHm6dqQ3MSAdtsZ4GDCsdpWhZIXMlZIY4IHukU5La0LTbPJVXWOKXLG8JU0pf5W2J9ARk7glYkgIE8AvJyF0FYHIgmrZdENI+JG+F+vvnpK28AOH/1QNR3KoeTNmhHQ2d/ZEjsmkfm/fIyV01evXrq7+7eJQFlDEhvYqRUx33u3S4Rhqx/EOYSJlmFgmjrDXqSb8UY2860JQFTZnoeIy2FJcxvP0ZJ4WGZRRGe56vEeFq6kWddw/shboh+U8f2gfteR1d6Te0XS1v365LkZTZv8KVwY0M5dmoZU9gugw8dPz7OqX07nyfAD4EAmKkWOzzA0TGMqPaVL7F4NPo2JXNe4FNkDcj6YQY4VARgRkZ9fcznjVbXnQHWcg63w3o4TYfCEGLMCtlHvT+S55tyeU62dpU2HmoVpMHbJFUIGE4Uhj0JM6TmN5dEHaYj9e0dF+W1tJf1th13C5KidnEtZBqD8cMmP/kmgnDe2C0aQ7CDQTzft4NgSSaubjLjK4UJ1ih0daLHAj+rOt/4Fi8rzwL3OG8nz5+mGM5R6DJIpM+0DBFL41uFfjmbgts01QvbRDzCByS40fVbIUHx5VKVmCPfspbdc6FumycvzFYQj9b3nrTQZmrf938vwo7ofDj9FFEO3R4YM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(122000001)(55016003)(33656002)(38070700005)(82960400001)(38100700002)(82950400001)(83380400001)(52536014)(478600001)(8936002)(5660300002)(86362001)(10290500003)(71200400001)(7696005)(7416002)(966005)(2906002)(64756008)(76116006)(66556008)(8676002)(66946007)(66446008)(110136005)(316002)(66476007)(54906003)(4326008)(9686003)(41300700001)(186003)(8990500004)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S5t/Ul94pWWIVOVHp4fOHEE+l88KouG1xZ76H6yQTWpOVetwBNDMQPwVnzXt?=
 =?us-ascii?Q?gOmf/dXM2Uq2gnvCZiGYn83TTqELHw8Qu4a1Ni3KX2J++go6sfDB6EiH0bIR?=
 =?us-ascii?Q?kbfK4nanqCi1Kmki0uRn2jp1JPPPTsZAjRDlyggoMrTN6YoQFnjwGCHcUyQo?=
 =?us-ascii?Q?Z6K5GgSlxG5QPthEAQzDj2tg/cJb/vrO4oXR1AnJMl2zuYuT6GfUOld7qNL5?=
 =?us-ascii?Q?6f8dWM8sFs89R4fxjvXfrZqRcLTO2VJuwbgrVccSnk3qgaj7drhsAHOCrCvJ?=
 =?us-ascii?Q?B0ukqLSK6ZDGFBGWFxGhqInRr28q6AyO8L9z7YuVSonMtZvvz4n///jPnbbs?=
 =?us-ascii?Q?Pp/f+xzRFTz/IlyrHFYuHXfYEEb1VGXnffp7katL/8pueEeLLRhkt3kuWB9H?=
 =?us-ascii?Q?Z8bQ58h2yutOJaGCNrzNytNTq9yqnxS41HaxURN+Rg+de+s8od93Q2YnonmE?=
 =?us-ascii?Q?Lyn3/+nEkabVYKt4DWECL4ZWzGKjIEfQyUrVNrUsvuXYlaS47CWruxQywuvh?=
 =?us-ascii?Q?KaznbSM9Gvo/ZRoSvQibcMviixnoyY2YUKr/FCScv3E7gDt4QHB8UrbEQCr2?=
 =?us-ascii?Q?W+J/8+H+qF7gdwACRwBMAz8XxStpnmrd3MAmmZTmRtLEXlFYMj6pL+uqm5n1?=
 =?us-ascii?Q?V3kREMvxjQ7COmhsFvYCtpHtrdS9ExT1vjW33diyNkhv/QpEPrlFdph3GSjZ?=
 =?us-ascii?Q?2hyud4Ad5ryYeYlnS3w88TtdN3vw3cr7RfBlT9oaoX9o8NLAGaBbP/i4iSw2?=
 =?us-ascii?Q?9vmVC3yRp8b/gT+fkwrGZ0SjpjKXep9xdEJy5tegKLisrYD90ptKmGS5rByp?=
 =?us-ascii?Q?eFZoyB0NiCJxyvFlyhWrADDiFI94w02ZMj+r8zWxcR1lFTV6veIqvo0iACmg?=
 =?us-ascii?Q?9s0gDeBBQ5GXLd/ulr5xqGmL75VdwC78GSgK597FtoMtASO0o4oB78xFs2M1?=
 =?us-ascii?Q?0U8kBs09RWhUPoh79bnH5heL2uRC6DgLTsA7CunNsvb2A0HKfxCidomhGcX7?=
 =?us-ascii?Q?ssSjQ1Su62XOu/hSBHCTJojNDR0PQJDMvQqZx2auVKdURG1WYciReXqyF0iy?=
 =?us-ascii?Q?rmdiSKgimO6FIoZ7sHlEwvqKWO1ju2JV+cazSPyjwSye/I3nxzxLm3z0J057?=
 =?us-ascii?Q?QmcsJT9yCSRsPvENx8YnJQMx6fZsHdmMIPNS3CE8Dxga5kOgWSQh8otrJap6?=
 =?us-ascii?Q?/pALOLN0AW5l6btf+505V5qS2PUnvDvzAvTmklxLsp/D4IIT0zJIZNZM4bAs?=
 =?us-ascii?Q?LxwCupCK+9Yicv2CqkSrFEWeDYi14NZhDYlU8fB+0GCfPQwDu6GqI9DdZKTQ?=
 =?us-ascii?Q?lEnR7FWlQPa/rmAPJTtn/FjBesAF7cwd2yuT+nRfwtlAEj5uupOVM1+FpeC0?=
 =?us-ascii?Q?YHAPPMYlPkiqZbdAX1fpJ7JZZ77DzHcnUQDI3LtCWLmSRj4ch7FD+KDD4GCn?=
 =?us-ascii?Q?g+BTYxtlRayO+M/JSKYUN9ZJJ9HCA8OZxDQEuskEV0ibQ38zzKphOGEAz7op?=
 =?us-ascii?Q?PXLDtzCSvgS5NeZBTqSlGz71dezLJnWvUiJB0H+wrvMfZWfApJ7gq9SakOST?=
 =?us-ascii?Q?0GG1b12ePyPho/GPH8iy2eV8aTgr0csX+f5e/WVv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cd10a678-a416-4c51-3b15-08db23732955
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 03:29:32.4527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTD3a6XrlTkcl5ZIW1i5x1AjCW1piI5o57aYhQxOAtgwZBliNMr2LqK6vlutKqt76CDrV47nhPxdcW1bh8rXGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZP153MB0430
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: rahul.tanwar@linux.intel.com, andriy.shevchenko@intel.com

Thanks for you comments, please see my responses below.

> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Monday, March 13, 2023 2:10 AM
> To: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: tglx@linutronix.de; mingo@redhat.com; dave.hansen@linux.intel.com;
> x86@kernel.org; hpa@zytor.com; johan+linaro@kernel.org;
> isaku.yamahata@intel.com; Michael Kelley (LINUX)
> <mikelley@microsoft.com>; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH] x86/ioapic: Don't return 0 as valid virq
>=20
> On Thu, Mar 02, 2023 at 11:34:46AM -0800, Saurabh Sengar wrote:
> > Zero is invalid virq and should't be returned as a valid value for
> > lower irq bound. If IO-APIC and gsi_top are not initialized return
>=20
> Why isn't gsi_top initialized?
>=20
> What is this fixing?

In the absence of a device tree node for IO-APIC,  IO-APIC is not registere=
d,
resulting in uninitialized gsi_top. And in such cases arch_dynirq_lower_bou=
nd
will return 0. Returning 0 from this function will allow interrupts to have=
 0
assigned as valid irq, which is wrong. In case gsi_top is 0, lower bound of=
 irq
should be derived from 'hint' value passed to function as 'from'.

I can add above info in commit message,  please let me know if anything
more to be added.

To be specific in our system which is a guest VM we don't need IO-APIC and =
hence
there is no device tree node for it. It is observed that we get irq 0 assig=
ned to PCI-MSI.

>=20
> Don't be afraid to do
>=20
> git annotate arch/x86/kernel/apic/io_apic.c
>=20
> and see which commit added this. This one:
>=20
> 3e5bedc2c258 ("x86/apic: Fix arch_dynirq_lower_bound() bug for DT enabled
> machines")
>=20
> Now add the folks from this commit to Cc and tell them why in your case
> gsi_top is not initialized and what they're breaking by doing that.

Thanks. I will add "Fixes:" and "Cc:" tag in next version.

>=20
> The more your commit message explains *why* you're fixing something, the
> better it is for the maintainers/reviewers to actually know what to do.
>=20
> Right now I'm reading this and I'm thinking, random, unjustified change.
> Ignore.
>=20
> Ok?
>=20
> Thx.
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl
> e.kernel.org%2Ftglx%2Fnotes-about-
> netiquette&data=3D05%7C01%7Cssengar%40microsoft.com%7C6e1e0e21051c4
> 9c1cfe008db233a0376%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%
> 7C638142504360574969%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
> %7C&sdata=3DOLdgb1AuLbLvlzucgNFBQEEK6G%2FsFV%2BO2TqT%2FNCujJU%3
> D&reserved=3D0
