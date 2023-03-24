Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A62A6C787B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCXHKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCXHJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:09:46 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020026.outbound.protection.outlook.com [52.101.128.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA6126CCC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLDUQehtU0sjfb2mUF4W0iHefV+Kn0qlcyQrT9IwBWdtxSMb5snav6toNSVVhNiZNn93qP3mQw+uSvvBeELlv9H+qWxZypf/KBtG8PGGobNksa6Plv4FuJdTYsjLq8vXp8xXztjr/gQeMDiCBObxokAnhnvR78+cRWzNvCbp7Kre7jEcFlIJ2Z4uAVEX9aaBZF80xsVKZNnVrH52vNfWQeI9Wa96TBAVUyy+9hMhKeFBv2mQl6h8RzhMQjdq3cS6Xs/LJGWiCQ6cy5KalKZRUEcIGoo0HGCGVH1llbtKnr2hAk3FQ1OdHoUKuqnClkBq+NHVwCSwZ3r7ZK+MtBxX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ayp7FcfxLiD/MViDmqq2PSlk9g4JV0BW6PlCnZhJ4M=;
 b=E/v6mGBd6VDDjwQp/z97+UPi9b+ZVIUKMJysXrWUu7z/GerVgFiEcVBsE+WLlV8TzoQIvLkSOR5IPgc2N5RIAl81KEoIqI99RKDgfyakfqxvJUAJ2z9kJrWDVL3bgrC3krpga5lnIxpmbf7zz3hbjIwOlwpq4NPufbQahgfeISwvXwTU1MpRgPz5kMTT+SPOOUI8dqAXQerpSf24R2msIoY1fs8vYCB0OVhMnXayKwO9BNa8GqWIO9b5i+KDdbiOlzHa+3Jb2mR0npXeYBgizcvOJirPmmml3Nx/1d2brBIqJ6t9D8RLKSCZMRB2nt1WPokj8eeYIuAl7IZKxJ4d5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ayp7FcfxLiD/MViDmqq2PSlk9g4JV0BW6PlCnZhJ4M=;
 b=Q9DUW9QKdDO2bgFv9YCtsLALxIsWP9/zhZAOMf86ElsT+jpyNwSu3GVtWA6oodjTg9OQ9593U6yn8XuCw6b9/k9nYT/ZBAcEkkPubNlyzErWh0NEQXfzwaafXn+t8jcBI0rj9zan8JRzgZ7SxxVxJY07qIqq9k8RNjbRJk7QwB8=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 PSAP153MB0421.APCP153.PROD.OUTLOOK.COM (2603:1096:301:39::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.9; Fri, 24 Mar 2023 07:09:03 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::ce12:9abe:af7f:5097]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::ce12:9abe:af7f:5097%8]) with mapi id 15.20.6254.009; Fri, 24 Mar 2023
 07:09:03 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Borislav Petkov <bp@alien8.de>
CC:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
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
Thread-Index: AQHZXh+DG81+LXL5SEuNsFsm+tcfSg==
Date:   Fri, 24 Mar 2023 07:09:02 +0000
Message-ID: <PUZP153MB07499E18BADCB1E40B785576BE849@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1677785686-2152-1-git-send-email-ssengar@linux.microsoft.com>
 <20230312204019.GBZA44s28AOAfAcRuy@fat_crate.local>
 <PUZP153MB074987B356FCB28933B87CCBBEB99@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <20230313111425.GDZA8Fkar9Z9BzSImD@fat_crate.local>
 <PUZP153MB0749FE8554CACEAD2E43C5E2BEBE9@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PUZP153MB0749FE8554CACEAD2E43C5E2BEBE9@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2e4d893d-9b46-44a2-a3f9-fc4d88717cc6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-14T10:04:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|PSAP153MB0421:EE_
x-ms-office365-filtering-correlation-id: e504243d-0941-405f-6992-08db2c36a622
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hqsJhK9WXcAMVA/VpQ2gp6e8WhFJpyvZr0MT0zEsRjGj6l4gK5rBchfty8+DBN5V9GcUoPVzpi2u8ci10kA5NDJPIRtt3KgXADiUgDBZwuYhu2R/lAthcd/wFsL7X86dmcUxxzuwstt64rUYK2gCX5Pe97HWlMVPwo8Rx/ySx7FumAz+/igp6lUVMEGAilg9ZvsPcnapENUYIPhpdqjQnBtjDIrQ6X0orgAqvqZtk+VaDQDWfHG1aytS0heDUderPGSdsAnp32MRieHmWk9XD/D8PUC40P1c6pJLhogY+zF26zD64mEqrRWQwUO/rb8zF291WsX8HCsRiGShYiMqTuGmoJiMkpt5dkWAYiPsR7wgWXZEffwse4sYBnm3kqOzG6pYW/flL2sLPlNtO9cDoef/YHX5DXDPjEn7d+8Tqmfkr0SQVxqxQe/O30Eku1meyNf7ELp1KOcr/Yn5vZ1Nx1hxTszDddoXJbt/591LVCn0suXphrFnmLCq7/e0Xm6qZCLrSALTk2RDkUNt3kQHx3VqHTXzwUrLSPJzlCbBu/SX5K/jgj4MCOZicx03lBbrSD58gqBz+LjHggt0m+pi80q3JthLskvKjkmd+v0iVHwzk+ShwrIiREpPmSGVi1DwZt8TMiQpdCMiUITKikEr7aJzQf0b2LxDMuY55TQ9dXE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199018)(10290500003)(53546011)(478600001)(9686003)(6506007)(186003)(83380400001)(41300700001)(8936002)(55016003)(66446008)(8676002)(86362001)(64756008)(66946007)(76116006)(66556008)(66476007)(4326008)(5660300002)(52536014)(38100700002)(2906002)(122000001)(82950400001)(82960400001)(38070700005)(7416002)(110136005)(316002)(8990500004)(33656002)(966005)(7696005)(54906003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mqCKtVJGwxci+ry7SCTyiUEhaTMk78gL+SOnyLCJcp9kMgDSa8fxICd7A0tZ?=
 =?us-ascii?Q?y2O6IxkKbWv0w6O3tJ71C4ShUDHRa/4eQgg7M5PVN11SjrKq0K/7UmwbnKkJ?=
 =?us-ascii?Q?FlIwB8WMsmw5gBTgf4ayGX9vSn+G2ZnDxNnumJEeUBxDd7lEUmb3CCDS5+Lq?=
 =?us-ascii?Q?NdzHC5A0fZDq6hVEpGRII1hMiR9Nodtpg9jB3Jiv5ZGnOvOsSQugABNk77WH?=
 =?us-ascii?Q?Av1Mmh+yYjNEXU7CGIrIGJ19QEcLJcuIVOmmHFARy1/Z4koiRX6KAPA7WVA8?=
 =?us-ascii?Q?QhkRjlrNC2MMDkjlIlLrYAUYhjTk7FXMPQe1oON20bDUKRnQx+E6TY4CLSAJ?=
 =?us-ascii?Q?bb8UDNgwRn7tW+xAGMY6TID7dhp9rvuiqrwihIpuRRXpAoK4l1K9s/eMGtfe?=
 =?us-ascii?Q?dSIDwwiC8dJsD+4GFiaLIKp7z7pPfPWdhKFqjAboxtSlqqBFATPERKyOJN2n?=
 =?us-ascii?Q?zYj+rEGLwHQ2gVSaMwjWFfx29ByrbMmY4C/zT5GLRbXl9o6qyRAPvIab5gbo?=
 =?us-ascii?Q?58GXrI9a4auDk2FdQzgvt8MptCikc2BW/FPoYNXJbg7FuPAyGekb9m/sGO8H?=
 =?us-ascii?Q?ofhkLCJJfatrhMd6iTfoo5dgEdnsVsumIRSx+p4VwQO56om3iQJAUAaiObj0?=
 =?us-ascii?Q?PhFgGb4C8gFHlazWaPZS/zZ7s2f0G8+43Xt/sPo378p+BPHjkI5PstO8HTMI?=
 =?us-ascii?Q?uo3msKWyZHkcTQWJ4KmfYP3I6HM/h507IBeLnDX7ho1kzZ2aYNpkkrTivSXe?=
 =?us-ascii?Q?nqZTIgnFmvhpfpa6AKPnmEisuutjdoo45jiWp0dZRDvlx64qPCgBSn4ObdXr?=
 =?us-ascii?Q?rZUpArF1+w5VBjtL+avhHfMvOMkZsr+RlYe61k0InPZH4byVfMeDKocheNhf?=
 =?us-ascii?Q?oYiQdaMhy+3M5EwCp7+FbnzmWncPUoAQY1S2cgHMuHvc/rxX+634XwHTkflx?=
 =?us-ascii?Q?q8RZF4p0gxTN+T84YOwQ2CBSQ+HspXpDk3fq8kFb4G4fK1Sly4nJtpjtLLYR?=
 =?us-ascii?Q?7SVHR/nD8V/R/61SSv3hWNJTpHvfYz1P982og2sgG/HG3O6vJ4G8MbW5CgL6?=
 =?us-ascii?Q?kZgpgdznKpHxa8QivjTOtJnG/RGtkDiX4dpb3hnTpIE6NF3wpif9TJVnAGPb?=
 =?us-ascii?Q?idOgOqRp1xeyEJWfyNUjllJSPVwfiAkVd8cBhKpvE94lf+rgPaaQ2XbbVt93?=
 =?us-ascii?Q?YMQf3S+NnBuAgEKicFUUCI2LXxJYXWeT/RgtnRNe/tQfvHwAn5ZfiQUPstNc?=
 =?us-ascii?Q?vjwP9sZHzDOuKGVP1a9wLECoSA/JR3baOLpcnwfjUFZ0z7P0x9+qA/RcpfOp?=
 =?us-ascii?Q?dVEBxcPIqE2iRYjaBYG0olDTqD9pX/ejhFGjLnjaBX19AX3XcY84dkavArdi?=
 =?us-ascii?Q?aOK3FBEVI4ZTqIXmRSMhcuH0AuKwWTSwzsfZmNr4B69CBOdvlVgvuypG/3kb?=
 =?us-ascii?Q?vMok7JlwaRdZQCrioIx4lcrAh/aJaojnFiqtoSWa/Q4mhOHam4GKIzxhSzMP?=
 =?us-ascii?Q?AlZrZ9qGDJrZJvKPxqbX2eZ1If/Q+JX/dBptSgPhZ8KlDf+OGJs0tr5BgLGh?=
 =?us-ascii?Q?rF7JnzgIFASywe/h968K2a6A1cwm2MRH1OjG8vYD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e504243d-0941-405f-6992-08db2c36a622
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 07:09:03.0014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kn8fjFFNYmYg1i+c84oT3STMCRdNh3qJ8J/tadX3/XhQUfCBCX2Vyg7q1EKeUIYKFt7jFFaKA9NsLOyOaQ3bTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAP153MB0421
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Saurabh Singh Sengar <ssengar@microsoft.com>
> Sent: Tuesday, March 14, 2023 3:54 PM
> To: Borislav Petkov <bp@alien8.de>
> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>; tglx@linutronix.de;
> mingo@redhat.com; dave.hansen@linux.intel.com; x86@kernel.org;
> hpa@zytor.com; johan+linaro@kernel.org; isaku.yamahata@intel.com;
> Michael Kelley (LINUX) <mikelley@microsoft.com>; linux-
> kernel@vger.kernel.org; rahul.tanwar@linux.intel.com;
> andriy.shevchenko@intel.com
> Subject: RE: [EXTERNAL] Re: [PATCH] x86/ioapic: Don't return 0 as valid v=
irq
>=20
>=20
>=20
> > -----Original Message-----
> > From: Borislav Petkov <bp@alien8.de>
> > Sent: Monday, March 13, 2023 4:44 PM
> > To: Saurabh Singh Sengar <ssengar@microsoft.com>
> > Cc: Saurabh Sengar <ssengar@linux.microsoft.com>; tglx@linutronix.de;
> > mingo@redhat.com; dave.hansen@linux.intel.com; x86@kernel.org;
> > hpa@zytor.com; johan+linaro@kernel.org; isaku.yamahata@intel.com;
> > Michael Kelley (LINUX) <mikelley@microsoft.com>; linux-
> > kernel@vger.kernel.org; rahul.tanwar@linux.intel.com;
> > andriy.shevchenko@intel.com
> > Subject: Re: [EXTERNAL] Re: [PATCH] x86/ioapic: Don't return 0 as valid=
 virq
> >
> > On Mon, Mar 13, 2023 at 03:29:32AM +0000, Saurabh Singh Sengar wrote:
> > > To be specific in our system which is a guest VM we don't need IO-API=
C
> > > and hence there is no device tree node for it. It is observed that we=
 get irq
> 0
> > assigned to PCI-MSI.
> >
> > This should be added to your commit message: what guest VM is that and
> > why should the kernel support it.
>=20
> Guest VM is a linux VM running as child partition on Hyper-V. Hyper-v Lin=
ux
> documentation is in Documentation/virt/hyperv/.
>=20
> In commit I wanted to mention that any system which is not registering IO=
-
> APIC
> will have this issue. But I am fine to mention specifically about the iss=
ue I am
> facing.
> As part of your next comment, I have explained the issue in detail if tha=
t is
> good, I
> can put that as commit message.
>=20
> >
> > Why doesn't it need an IO-APIC and why does the current code need to be
> > changed just for your guest VM?
>=20
> For Hyper-V Virtual Machines, few platforms don't have any devices to be
> hooked to IO-APIC. Although it has Hyper-V based MSI over VMBus which
> assigns interrupts to PCIe devices. In such platforms IO-APIC is not
> registered which causes gsi_top value to remain at 0 and not get properly
> assigned. Moreover, due to the inability to disable CONFIG_X86_IO_APIC
> flag, the io-apic code still gets compiled. Thus, arch_dynirq_lower_bound
> function in io_apic.c decides the lower bound of irq numbers based on
> gsi_top.
>=20
> Later when PCIe-MSI attempts to allocate interrupts, it gets 0 as the fir=
st
> virq number because gsi_top is still 0. 0 being invalid virq is ignored b=
y
> MSI irq domain and results allocation of the same PCIe MSI twice.
>=20
> 		CPU0		CPU1
> 0:		2			0		Hyper-V PCIe MSI
> 1073741824-edge
> 1:		69			0		Hyper-V PCIe MSI
> 1073741824-edge      nvme0q0
>=20
> To avoid this issue, if IO-APIC and gsi_top are not initialized, return t=
he
> hint value passed as 'from' value to arch_dynirq_lower_bound instead of 0=
.
> This will also be identical to the behaviour of weak arch_dynirq_lower_bo=
und
> function defined in kernel/softirq.c.

Hi Borislav,

Have you had an opportunity to review the above commit message ?
Kindly provide me with your opinion on whether it meets your expectations.

Regards,
Saurabh

>=20
> >
> > What else needs to be changed so that your VM works?
>=20
> This is the only change required.
>=20
> >
> > Where is that VM's documentation and why can't that VM be fixed *not* t=
o
> > need kernel changes? IOW, why can't that VM emulate an IO-APIC like the
> > others do...
>=20
> Documentation is mentioned above. As there is no need of IO-APIC there is
> no need emulating it.
>=20
> Please let me know if there is any further clarification required.
>=20
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl
> %2F&data=3D05%7C01%7Cssengar%40microsoft.com%7C84362c605bf04e6d56
> 6a08db247630d0%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63
> 8143862345546032%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> &sdata=3D7iCmUXeDyD%2Fqv%2BO63N6HG%2FPrS9HWP3yaGClT7X2RB0c%3D
> &reserved=3D0
> > e.kernel.org%2Ftglx%2Fnotes-about-
> >
> netiquette&data=3D05%7C01%7Cssengar%40microsoft.com%7C817c78e7bb324
> >
> 8cd73b708db23b41c2a%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%
> >
> 7C638143028755917117%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> >
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
> >
> %7C&sdata=3D3N5Mkl2gjMPHKOJGykZ3LvM6h%2FfD86dXLTQo3VH0Svc%3D&re
> > served=3D0
