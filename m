Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682276B8FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCNKYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjCNKYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:24:30 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazlp170100000.outbound.protection.outlook.com [IPv6:2a01:111:f403:c400::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66D438031
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtJLv9cTjpAqbi9JaoWwPzRHRRi4PX1rCaEP58hEYdrktTGZjaHqIEkkrfI8u28sB589QP41yOhiKH3BWrB0xCs5TWr5meYwn0CdUmWkkwTBcXtLcEmQxDMXa7vGr/OLRQTMgJh3U/zDR9NCXTYxTA2Iihq/Ogb/h8CZ4qf4S5m0ZjfyGi9fJfZ5ViaACLqewGpgRnqyIUhuwzH9uH7bxN46bpptdkmjZioByHFuiy3BMlkV1jeQaVk+ovK6UZ1t0nhex+XPi1SB43tmwi/NjBW1E8ooGZRhtswobX73omkbyVLaFvY3iLFpEsm9qxElJuIv+Ns7jPfh7pgefDjELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkdktJDv4k5BKnyzbXkSECfcvy0RTPUo6s4E0gJA6I0=;
 b=b4+G/YcH2WaWWHEOyW7b001uOkly+WrPlQVfbHdC2GTGlFuxDVcwL3i0lOZPNeqDr93/oaVPwCYMslmuFT7VR/Xozu3/zAP7v3k+Vc5CVbGXDtzgL5otxxehGjnhmh3f3UENAdv29/yRFeDMZSfd9haJim5rod8PJc/+tOs2wZsrg0AaW3leS9Jonkq51/rdeMpt8aD/5cW/k1ESNBM2pg3ZR7n2y+alVw1szXCM/uwLcIkb7kE75G7cV+xW1yX0SNj5JFn5VGuMYJ/7QlDIMf0MsncZFQenhVK50CyXXl/dqpT2oZt8WDcV31ohMkWhD7cWwprbUdsYXPAo8izVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkdktJDv4k5BKnyzbXkSECfcvy0RTPUo6s4E0gJA6I0=;
 b=WlHYqYnfK6rDs0P44bH2zqWxrvC+gkGCTBZOYfgi5AOazQ7zCHuKq6mqLMNqFOcaxtB2pFIbluYKRmMhNsQa9OQD05MCH14r6t0MLRMbGo727A3NPGbCrQEbBmMxZC/NiBal2hE8ZW4RBEjSPwqiI7nOhWE2Ksu0RFW8DrQB4fo=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 SEZP153MB0664.APCP153.PROD.OUTLOOK.COM (2603:1096:101:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.3; Tue, 14 Mar 2023 10:23:40 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::efc9:b06b:c407:5b6]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::efc9:b06b:c407:5b6%5]) with mapi id 15.20.6222.005; Tue, 14 Mar 2023
 10:23:40 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
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
Thread-Index: AQHZVSLlnKDpznJzjEiFU+MpmtQn5a74BzVwgACIdYCAAX7uIA==
Date:   Tue, 14 Mar 2023 10:23:40 +0000
Message-ID: <PUZP153MB0749FE8554CACEAD2E43C5E2BEBE9@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1677785686-2152-1-git-send-email-ssengar@linux.microsoft.com>
 <20230312204019.GBZA44s28AOAfAcRuy@fat_crate.local>
 <PUZP153MB074987B356FCB28933B87CCBBEB99@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <20230313111425.GDZA8Fkar9Z9BzSImD@fat_crate.local>
In-Reply-To: <20230313111425.GDZA8Fkar9Z9BzSImD@fat_crate.local>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2e4d893d-9b46-44a2-a3f9-fc4d88717cc6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-14T10:04:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|SEZP153MB0664:EE_
x-ms-office365-filtering-correlation-id: 6a2962a1-0c28-4089-6740-08db24762e32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 122TJKwccYQBlX+NtZYHkEsPGvheCeTTjsgt/zq49hQupgILwFg9ybF2mUwwR2e8affz5PJ38JOwoLHjXkXkCX6WxQuSs6yMTFze8VyzoAlCZOAEtNbXH1MiiiVhXcdOzbxVkdsY+f4/E6RmVBhzReSHPUEETK1mbBMlE53xsKsgOxlHSNK7gdBMJcJbqTppYrfFNer0t71U2XKDQN7Wax2rtCkisQI/oHYlBHN6wlyJAKiUcHtqlvHVOo/tDtyrsFOi57ibYAAiY22mKPkawvHboliOQzJ6Z4T+UyQa+lLGxPujqWjKHunKo4Y+tkMbeWq3afLPMVQX8PggGqzoSJjjjYR+Thx0raKd6875kXsK9opxcYyvHI/5c+a0i50cZTF4k0BkfQ/xQrkJiuzXcyTsivHOy+gzJD9GB35gNdf4f7nAY3RuZWTYEk04H6Hf+C3cAcwuIBdLLR2tY9E3HkzkoYxrvYhSbpr/6d2b/aBSwQjvYgviLaln2FV+iJu4i/VGeSUaCyfnNB0ig6IxcYsgfu5beIH9SDBqRNgtsczJzm2Y9cPH6Es/HDiscZ29HrpI+ugjBaD8ws4jaV6z2wYo1kqwFERcAa/VDL5emeQsL6JgCMvKUluiBIbuqF53gI9XhC6r+9/k9ZM2pq/tdPkk8fEyYZG3ozI7XoVEyKoPIPpVq1wVoOhj5bsc/OtD2tHEV/jlkZQXYxZ8FVM5nhu1OS1WKisjqNe7QbuFjw6PnyNj7Ovs9hLy32bW+lvv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199018)(7696005)(71200400001)(966005)(53546011)(8990500004)(9686003)(6506007)(478600001)(83380400001)(10290500003)(54906003)(76116006)(4326008)(66556008)(64756008)(66476007)(66446008)(6916009)(8676002)(316002)(66946007)(186003)(8936002)(52536014)(5660300002)(7416002)(41300700001)(122000001)(82960400001)(2906002)(82950400001)(38100700002)(55016003)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IQRYbCk8+3TWUHiAV2mM1pcYbUHTrLrEgCuPFC0Sx6TZN6S9GPns2LAv7UMk?=
 =?us-ascii?Q?N3P3sAKdwg4NF8Yky3J1SZIEG4QHO8/whi55Z4KRLuGFXMnF+RIWJ0QEZlNc?=
 =?us-ascii?Q?sUWaioNj1ud4MURPEk/XuX4ecPZvQERqp9uxFTvyzNGOgS6zFJ2PFn7mgxyp?=
 =?us-ascii?Q?M5hTG8g0FewXPbK6y8XUPwKTyTfek9/O07zQ1BW6/P/YgfVI24o9uEN0PVrj?=
 =?us-ascii?Q?qNHk/gPBToSqTY10WcywR+rsu2fvEjoihXc5OTLJ71vPdoYiNHzqcIHN24wF?=
 =?us-ascii?Q?LTw3H+kxYLuS+lL7mT7KMAyCr2YexKZB3X9gAqtdaumQzCeTDxaKRMG/lANj?=
 =?us-ascii?Q?GVXEdL7Wsh5N5KhU7HCyuT+SXBuMBZ+i6QvPmuJyU4G9p5Tu7V4+4L/iaBe9?=
 =?us-ascii?Q?ZgMPsUXZHoUzj835bFY532x8TbzQDwIKjuntC3hNPojCc5DBlyQ1npXVcSIs?=
 =?us-ascii?Q?jbyWANWqbDzIaqCbsU/ynlRakq4RbjJhATV2x+3+rdir6ERKQ2fq8mIBTYa1?=
 =?us-ascii?Q?USzTuTHY0BEyaY9J8soqSU6VHGGWGwWrUdA1GxDgzHAXiCq8Ptq2K28LAr6O?=
 =?us-ascii?Q?f/GumadE1X2RZ29pPzfNxI+sFqYibzNpW7++F8b2vTTq+7ijZfKCNTymYLTL?=
 =?us-ascii?Q?duiA0CTIPu2VdO+yVUe5sQsujb9nYghUrLFsohQfl7DDCJEwtRTi7BLLfHfM?=
 =?us-ascii?Q?n7dFMytBTk1emLk/ST8d0zuZ4/yZ1C9hGLHHE8/XlxjL7de/tQ9FWtJstylA?=
 =?us-ascii?Q?wVuZM3wR7VULuSk9jKMj7uDgMuGijJRD41sxckBWIv7kXn6ozO1HPyepAaYc?=
 =?us-ascii?Q?sS6Ytx9PeySdg7PSWRI5oNX84rb7vQK1WDQdL+hHBVEWhGQ9espD8cGFvpXo?=
 =?us-ascii?Q?cR5d3qrovAlr9ZMK3e38+uWnakBFaDSrlug/UTGANEFXSRuYp3dxeQuyAVBa?=
 =?us-ascii?Q?MEW5yF6x/Ol+u/p2aDN3emk20KQc2vQt3xfW/EIlPyss2YOABmf5aSlqcDWy?=
 =?us-ascii?Q?KZz/wrkdpLjZeNQGY5mxqnrJTJ9npjiNySn2/TLIcAqg8TFGV8owakkvnSZt?=
 =?us-ascii?Q?9fBYtiTsgs+vZ1GHO1061iDWCB0STWwuJnlw2njy+vhiGW9X1YoV6XkOf05o?=
 =?us-ascii?Q?ugzK7tg73wGlHJYtUzHosSerKn82sXFPxq1iL9SsHt7bFn+v7ofOV1vqUQi/?=
 =?us-ascii?Q?r5Rpe+iY362WOkJM0+g4Ys7LIQ0ySzFiOl7IyiaMw/1V9DTXBjwpQC+W31mb?=
 =?us-ascii?Q?gBwXwTKvSMbf2reOh+ji4p3Iub3bWq6Ig7ESlHUSy2JUQGuePQQzNckQ0Kdr?=
 =?us-ascii?Q?D3LukwfRIeSvfg4anl1dF12zC3BAqDsf2WqugrSy05wG1fPiL3PKqNGmxCgW?=
 =?us-ascii?Q?Y5YPoJoE5KntHYZ60nKBRHjaVfjx9IYkS29LTjTgbfpsgzmO84EzuKBJW/0q?=
 =?us-ascii?Q?X/cF4LQtVM/ukjqv6Ik7M0cvNCOkqWOL4GAXHaKPsQdyEIsj2mBaZ56GeaPP?=
 =?us-ascii?Q?QOECJIl8Ovn/NRSoxS5J4C5U/cGA68g7z712f99eY0LECgW6ML8vT+obnAlr?=
 =?us-ascii?Q?OH6u/yDmUz/0uzqfEH8mrSblCzjzsX+8YHFuDYiJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2962a1-0c28-4089-6740-08db24762e32
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 10:23:40.2310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Bn6TQ1k0/lW5CBb3qDwixkJp+S9ShcMEJL8o4dfgx6kRFsEtStJZUyDwVWWOCbQmNXwUg3Ri64w/M+AKO1FSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZP153MB0664
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Monday, March 13, 2023 4:44 PM
> To: Saurabh Singh Sengar <ssengar@microsoft.com>
> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>; tglx@linutronix.de;
> mingo@redhat.com; dave.hansen@linux.intel.com; x86@kernel.org;
> hpa@zytor.com; johan+linaro@kernel.org; isaku.yamahata@intel.com;
> Michael Kelley (LINUX) <mikelley@microsoft.com>; linux-
> kernel@vger.kernel.org; rahul.tanwar@linux.intel.com;
> andriy.shevchenko@intel.com
> Subject: Re: [EXTERNAL] Re: [PATCH] x86/ioapic: Don't return 0 as valid v=
irq
>=20
> On Mon, Mar 13, 2023 at 03:29:32AM +0000, Saurabh Singh Sengar wrote:
> > To be specific in our system which is a guest VM we don't need IO-APIC
> > and hence there is no device tree node for it. It is observed that we g=
et irq 0
> assigned to PCI-MSI.
>=20
> This should be added to your commit message: what guest VM is that and
> why should the kernel support it.

Guest VM is a linux VM running as child partition on Hyper-V. Hyper-v Linux
documentation is in Documentation/virt/hyperv/.

In commit I wanted to mention that any system which is not registering IO-A=
PIC
will have this issue. But I am fine to mention specifically about the issue=
 I am facing.
As part of your next comment, I have explained the issue in detail if that =
is good, I
can put that as commit message.

>=20
> Why doesn't it need an IO-APIC and why does the current code need to be
> changed just for your guest VM?

For Hyper-V Virtual Machines, few platforms don't have any devices to be
hooked to IO-APIC. Although it has Hyper-V based MSI over VMBus which
assigns interrupts to PCIe devices. In such platforms IO-APIC is not
registered which causes gsi_top value to remain at 0 and not get properly
assigned. Moreover, due to the inability to disable CONFIG_X86_IO_APIC
flag, the io-apic code still gets compiled. Thus, arch_dynirq_lower_bound
function in io_apic.c decides the lower bound of irq numbers based on gsi_t=
op.

Later when PCIe-MSI attempts to allocate interrupts, it gets 0 as the first
virq number because gsi_top is still 0. 0 being invalid virq is ignored by
MSI irq domain and results allocation of the same PCIe MSI twice.

		CPU0		CPU1
0:		2			0		Hyper-V PCIe MSI 1073741824-edge
1:		69			0		Hyper-V PCIe MSI 1073741824-edge      nvme0q0

To avoid this issue, if IO-APIC and gsi_top are not initialized, return the
hint value passed as 'from' value to arch_dynirq_lower_bound instead of 0.
This will also be identical to the behaviour of weak arch_dynirq_lower_boun=
d
function defined in kernel/softirq.c.

>=20
> What else needs to be changed so that your VM works?

This is the only change required.

>=20
> Where is that VM's documentation and why can't that VM be fixed *not* to
> need kernel changes? IOW, why can't that VM emulate an IO-APIC like the
> others do...

Documentation is mentioned above. As there is no need of IO-APIC there is
no need emulating it.

Please let me know if there is any further clarification required.

>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl
> e.kernel.org%2Ftglx%2Fnotes-about-
> netiquette&data=3D05%7C01%7Cssengar%40microsoft.com%7C817c78e7bb324
> 8cd73b708db23b41c2a%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%
> 7C638143028755917117%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
> %7C&sdata=3D3N5Mkl2gjMPHKOJGykZ3LvM6h%2FfD86dXLTQo3VH0Svc%3D&re
> served=3D0
