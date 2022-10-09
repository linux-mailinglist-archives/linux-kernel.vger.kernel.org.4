Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D0E5F8C6B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJIQyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 12:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJIQyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:54:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0B8B2B
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 09:54:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvRuEyqNyGZDYuP83cpdzRMzhQxlNS3SE3Wu024u0MwbDjp/bAAYVgb9imeteAimI7QcfdTM7dP+HT+9NDRXPAJqOFyLNV/rCB7KMhQblylQbNSjHjdRqwugOWCnCf2nS/HeVGsF0EVplHWHVfz/0puwRkOihkSbV+TIgtcJO+pokynJ1uF4UyUU/0+6+GmZMYe/h+SITirfV8vd7iqOmN+JJvlG8T2vj+4ZrkMB+7oB4Gmp9IjrmCqvQpVlWDlJOtY8HRjqXNplu/i9a1biP10wHQWgpWRp03xGQQeziAfAmNNAuJ2E7Dnjsh2gYEFq0q02Xd1tznbvW7JG88wgXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARdoXaqF4/0+15SsBQIA7CIbmbaH53N7u8oG1+2/sQs=;
 b=nc34zue0imxQ9nWWG9RpMxT7NLpM8Ap29cf9RR3c0+aF9tPlIXekm2ffYFXbDC9tzTgy31oam0K2Ugw+Tb3i8biGBtM4o6bPbMIMKNXotcvSRcuGT7ckhwbtFM6R4RnRBiXz8lnkTabFnUcWMC3fbOD30AIf8KUCHWAw8TmMqoWSKZtXPFVVIZPSLFFySc+t1dcnmBQ5wdpKw1sEjvr3FPrqzehaRRCbtyif3tQgOAI7S0p6WgTfFFp/taT1KGu5S6mVU9prBeRSONDEERl5aBs5Fk1b/citSPISMIuNwbCoPl4W16ozTPSeoN9KIh0A0wy44oU3ZqZijj4miHVbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARdoXaqF4/0+15SsBQIA7CIbmbaH53N7u8oG1+2/sQs=;
 b=X5/aBqI+hT9CW9mTY36x7od9DBkMAsPfVAhuvsgd558IbOTklVkGnPUKG4oVSGWDFK5uK69J8UA5eBzxxSaczpYSKC58qznvwe/Ieztn0jlPdq+xEAsZ5fCRjyoge2VCLRQHrggHTx38Ew6cLXTuXQ1hVvW/EqdQmyIMWdu6kjE=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sun, 9 Oct
 2022 16:54:33 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::4f54:a52f:723c:1d67]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::4f54:a52f:723c:1d67%7]) with mapi id 15.20.5676.036; Sun, 9 Oct 2022
 16:54:32 +0000
From:   "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sarangi, Anirudha" <anirudha.sarangi@amd.com>
Subject: memtest (arm64) throws level 2/3 translation fault
Thread-Topic: memtest (arm64) throws level 2/3 translation fault
Thread-Index: Adjb/dLLYtB0d54ASy2SwiNc1FLmRw==
Date:   Sun, 9 Oct 2022 16:54:32 +0000
Message-ID: <MN0PR12MB5953FE5071BC81D87C585E08B7219@MN0PR12MB5953.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|BL1PR12MB5143:EE_
x-ms-office365-filtering-correlation-id: 45e28493-1f27-485c-4006-08daaa16f08d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b+h+QkGyYqfebunAJr5WzmqNwwXdBKnJY9sOj+7V4aCj+8Mlv/eay+1lYWMhJ4MnxwU8v+bcb6pV6snkxtF0Rjmym36QWyCPla4jAMrLR0/Nikju7VPGoDF21MMylYDfiMKVzdodyLN+9gVWS2/nxQ8Ffckr/rj+mJTxyw82VUCBIDLKxJB+AOEBFeji+4xv2g5fZtCGX0DugjyRatTP1Xm6XTn4hbIzRFCzSYF2dSagOUHSfncBq320dBnOqwSble3mpex9lWbRVqX4Q9t3zXlG82bDhlW422dF15MaCSBLUePrCbLhauE+6lZLTKfXKaGqkz+yCdOG93yzRCs6z0GxPj5IiwezvIKl/zYJEXRESIs1VPhNBz6pZDb++J11OWnLU5rEKIDvoqzpIXbIS8nL9L/Cn8Ph/Udu5u/R/tdlIERPgRsXcl/+QqOtSnj3Ad6RERelVnIGd5VJxONszmsPYc6sIt0msBeMcN7Smc10np5wAn4kPNffl+wzwcr95g6U6QN9R1ibArLus5Z2chEoZUL3UcHfTnNWI7F3Wj9hWaVCpWQhgIr71kUQMWxmTyG7u5sR4U4V3zfLQti6SBCpylORFgDmV61C+q/N4OmqSWUiaOlmX2Hss+p86mRPpjTvSdusp715qBhAmO5mo+6tgRMzAsXfWcx8Zd2oJZuAIZ2vj+b33f+wcfrwLa0legfFHwgGWmR+cM15H5hpSVPsYNpgYjRNFHdiud6K72xKe2V5rO6DOJmEoJt/NBxb8le/Xv28MKyw4hBPcXrwRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199015)(54906003)(110136005)(316002)(8936002)(52536014)(478600001)(76116006)(4326008)(66476007)(66556008)(64756008)(8676002)(66946007)(41300700001)(6506007)(7696005)(71200400001)(66446008)(9686003)(5660300002)(30864003)(38070700005)(83380400001)(2906002)(186003)(38100700002)(122000001)(55016003)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gF1u0jocyvsWpaKpRnV2RGDfmGSklmNPGCg0bib//qHJRMFdLg7SodC/pJj7?=
 =?us-ascii?Q?oTlLX9YEKRusvrbTuPaPVdtcXXVNMRXu4otJHeU4UXcDn9KUSEyYQ7OFNfqq?=
 =?us-ascii?Q?Ez+TBZ9h5di933nmqox+bNtDRVH7VWtygTmS2wKihSU4Xvf1GCn/c5KKG9kv?=
 =?us-ascii?Q?PM4NK5W4BpnIBtZEvFY5w8f3F7rlR7t8ekL3UzN0ituiczp0BPwqdzrkaP75?=
 =?us-ascii?Q?9EgKuNXbbNRWpO6zmkJ9EM5ttuxGkwEscsGa5o3+ojpijC1z76srxbuDN6Xz?=
 =?us-ascii?Q?tpk/EXDrstW42PxmxTtJxITYb2WvFVrYmUukuzpisaRXo7JUXatuJMPLucd/?=
 =?us-ascii?Q?fGdm7CalLNdNNXNNcG1PvQPJKkd8UDlylD0920MslJB4YNX2WJ9ItDF2wfg4?=
 =?us-ascii?Q?fZ7jIzx6bW8y8QFzOn139BJTLEMZGG0LPdpkqZOTo2j3K0TagNACXN5wZEBl?=
 =?us-ascii?Q?3bDzggt9PSRw0Gg72UTT+4JT2xSgmvodArKEAC5cp0nBKXoP24WQjgKJ0xYm?=
 =?us-ascii?Q?JDwPJjoe8MPh4aTsptEd+LSWtVWDCJKwzg0XFcmRe0c7plNacOPvXQIkCyVy?=
 =?us-ascii?Q?kV5qEP2ApCJ1hkFEbtcHiKxTJdv7kS+qStc6PCnh4bbPAw29h3/j5oBf0DDm?=
 =?us-ascii?Q?V/Vo0w0LWhLCTHfv1gmX5Ap1i23tIwkxfugCUNZOvWjrTuU4QT2Lcq1AzUtT?=
 =?us-ascii?Q?XRLVLzXYOYHyzmviy0GKfRhvrjdvWOgJ3RrSFHWuWoUa4xG7UXedt8zVCiKU?=
 =?us-ascii?Q?pXIMbh/56rtC+gXJTPhO/IaIcEEdOCZgDirrCo+Y1sVf/lbZBRNr/4SQ4RIf?=
 =?us-ascii?Q?zZEN6jzFEksGACxrGem6Y440ubeD3wVKWQwyf0I2tH+vuiHD9xG8tVx90HEh?=
 =?us-ascii?Q?KpRtXTiNssVuVkEPkMC6Z5f1J0x+D19SCLnl2gz3/RIFrQCNDFOKzjlCBIYs?=
 =?us-ascii?Q?xbLLh3ruyLNwFs/sW1Aas2IvoIhaqxSSWF338ePrC9oUNNYhHwfcZ9vxkEtE?=
 =?us-ascii?Q?ngS4vkWSs/IpFlQFnH7WwH5LWGp7NtuIpEMJC15p6x7yKFvoZhPa3ukTWlsu?=
 =?us-ascii?Q?fPFs2GjN4Ar++LIWOsWfvqj/edCiSwG8luTwMHXfv0GWjaajWhzwMEMg7wAG?=
 =?us-ascii?Q?csDi72oLPxW85d2QZHcBEb0Xpk/yMGVPLYXTqfiFvejuJMMSpP1En4LKNCvx?=
 =?us-ascii?Q?O+6LW3tcR0yJFuan+N5OIYZbKBpRgdqT0GbSEcSIxZQ2z7B8sHy2NN3Q7lZ5?=
 =?us-ascii?Q?X3b16rB/uHR5WgEnTExtTyqDttrF2LgWztYGWWhVIbJ8F6fR34Y3R3GzNXMn?=
 =?us-ascii?Q?lwgpfXVfVqE/gGGb1GfYgPpugG6MZqk7r7Cs/O5Sg905dfUONdIuHu+qy7/A?=
 =?us-ascii?Q?qbwR4IoRZ2lCBEM7KjmsYG0hsKab/FRCz32vDWSYPCcCIZFQTOHjN37uLTDD?=
 =?us-ascii?Q?4cq1HIoYPm6a1jL1LV4EJZ4XBYcPZF2FaWdF6F2kbVYjYFX41zpOgkrf3tHi?=
 =?us-ascii?Q?w8fUTHcaX9g9GYjOkGXvpf+5ILlbbWRGJ2P9pjrtoAkKtIB0Dq4MmgG9FzpY?=
 =?us-ascii?Q?VPs05wgRxMiqNa1t7TIqoZ6hZeStkuowaQKg2j91NE2kWhWRsqMNAC6cVf2s?=
 =?us-ascii?Q?+XTXe2ThAeT7Ohps/tTvDgQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e28493-1f27-485c-4006-08daaa16f08d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2022 16:54:32.7981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vDyQSoH1lVq/viMKKNbACVz0vGSjcxdLTxUGAQTzbQe6CbPLJZOjc2cfyu+9R8Ke
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I am seeing memtest(mm/memtest.c) reported failure "level 2/3 translation
fault " on a particular Xilinx-AMD Versal ACAP internal development board.=
=20

However, i can access same memory range (ported memtest) properly in
a standalone(baremetal software stack/ no-OS).

I copied below linux boot log for reference. Please let me know any=20
suggestion/experiments to rootcause this issue further.=20


Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 6.0.0-rc6-01408-gedce21691e3e (-)=20
(aarch64-xilinx-linux-gcc.real (GCC) 10.2.0, GNU ld (GNU Binutils) 2.35.0.2=
0200730)
 #58 SMP PREEMPT Sun Oct 9 21:49:47 IST 2022
[    0.000000] Machine model: Xilinx Versal internal Eval board revA
[    0.000000] earlycon: pl11 at MMIO32 0x00000000ff000000 (options '115200=
n8')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] early_memtest: # of tests: 1
[    0.000000]   0x0000000000000000 - 0x0000000000210000 pattern 0000000000=
000000
[    0.000000]   0x00000000025de000 - 0x00000000025e3000 pattern 0000000000=
000000
[    0.000000]   0x00000000025f0000 - 0x0000000074b79000 pattern 0000000000=
000000
[    0.000000]   0x0000000074b7f080 - 0x0000000074b82000 pattern 0000000000=
000000
[    0.000000]   0x000000007deca000 - 0x0000000080000000 pattern 0000000000=
000000
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff00007fc10000
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000047
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x07: level 3 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000047
[    0.000000]   CM =3D 0, WnR =3D 1
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff00007fc10000] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8008
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8008] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Unable to handle kernel paging request at virtual address ff=
ff0008ffff8118
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x0000000096000006
[    0.000000]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000]   FSC =3D 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000006
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000001aca0=
00
[    0.000000] [ffff0008ffff8118] pgd=3D18000008ffff8003, p4d=3D18000008fff=
f8003
[    0.000000] Insufficient stack space to handle exception!
[    0.000000] ESR: 0x0000000096000006 -- DABT (current EL)
[    0.000000] FAR: 0xffff0008ffff8118
[    0.000000] Task stack:     [0xffff800009fd0000..0xffff800009fd4000]
[    0.000000] IRQ stack:      [0x0000000000000000..0x0000000000004000]
[    0.000000] Overflow stack: [0xffff800009a38300..0xffff800009a39300]
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc6-01408-gedc=
e21691e3e #58
[    0.000000] Hardware name: Xilinx Versal internal180 Eval board revA (DT=
)
[    0.000000] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    0.000000] pc : die_kernel_fault+0x2b0/0x358
[    0.000000] lr : die_kernel_fault+0x244/0x358
[    0.000000] sp : ffff800009fd0110
[    0.000000] x29: ffff800009fd0110 x28: ffff800009fe3c40 x27: ffff80000a0=
6ed50
[    0.000000] x26: ffff80000a06e000 x25: ffff800009818000 x24: ffff8000098=
ca000
[    0.000000] x23: 0000000000000118 x22: ffff0008ffff8000 x21: ffff800009f=
d0220
[    0.000000] x20: ffff0008ffff8118 x19: 0000000096000006 x18: 00000000000=
00030
[    0.000000] x17: 3030666666662073 x16: 736572646461206c x15: ffff800009f=
e40f8
[    0.000000] x14: ffff800009ff2f50 x13: 00000000000003a5 x12: 00000000000=
00137
[    0.000000] x11: fffffffffffe3cb8 x10: fffffffffffe3c70 x9 : 00000000fff=
ff137
[    0.000000] x8 : ffff800009ff2f50 x7 : ffff80000a04af50 x6 : 00000000000=
00e94
[    0.000000] x5 : 000000000000bff4 x4 : 00000000fffff137 x3 : 00000000fff=
fefff
[    0.000000] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff8000096=
83a80
[    0.000000] Kernel panic - not syncing: kernel stack overflow

Thanks,
Radhey




