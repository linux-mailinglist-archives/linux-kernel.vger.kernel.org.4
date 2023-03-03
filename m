Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752536AA089
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCCUXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjCCUXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:23:37 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2095.outbound.protection.outlook.com [40.107.244.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7211220D3D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:23:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ac7kjK+WLugcdTCnRp+CckERW8vQPnjBO2/AFn74VlUVdvUTo3rBntoAh51/deP2VqMalFRhzO75amwKcn8C/h7CUI0krJbnyn1ZvAxIftaJ8b3ASXfTB3DSctnLzeE9+nzIZIbxGNDYv0xNZrNTDBfu3HGNHnUQ3NIG5PTbt1SJirn/wm2TCSn7HgTsK4umf3wTNcQubw3bgGrX7BokFCA11UXWmguQoJVi5sXIrbm28V9aRDCO1n9Tl45LWUnz3joAy8ulpNlR1tX++ijw2NYrsXWyuijyg3qjj7y/P9i4U9PHJrIqgzRB3pPXCPCmTbZO9EelB5JNCVLwmkm5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQmYg5aiSRo1YB+f1D/kHWOPmeueV+3hBLAGMBc5Hsg=;
 b=AVPcL5efJbliLcWAM9ps+DXphapC2sFeKvfWMEq0zg0D08Byo1wTvFCDli90hTqHbNVU+6uyd+mMFgchRvmFg7h9T4AKVm6+TZj90TYupdfjcwMyaCoOuq06OoGr7LbpHGWNZCSTcvPtoNdO7c2DLmPUqzaqPPZEXqa1bJZtAfdB0+81bp6bXQbtRgwGsrSug5FQXrX3kD4vHTzw7Hz9XDJeUT5iKFvjizIJkUq3rABBssmkBhMn6nLysML4+1uigaQ1P49hQO5dap2OZZK0tItLhIuGf5kv9MjoUsNR2VHgMYoKOQfA23wDik967skJKY9pl3NI6mQS4ZDZEwTQ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQmYg5aiSRo1YB+f1D/kHWOPmeueV+3hBLAGMBc5Hsg=;
 b=LiOz7fy3BTH/zYj56GAkfDij8yI8oBY/PUoVBorwyG0kukdTX0xBAol7e2z+NE9QDio6CWL2h84+ufvzVy2qKCr3wmB7Qog7Z8BKL2r69Fl0sylXUYLUQCLe16ifUQzpFqBjMdWf2UhdB+Hi37C1PPyKT7zb8D4GyTcxLyQMBUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7432.prod.exchangelabs.com (2603:10b6:a03:3d3::16) by
 SA0PR01MB6316.prod.exchangelabs.com (2603:10b6:806:e8::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.10; Fri, 3 Mar 2023 20:23:31 +0000
Received: from SJ0PR01MB7432.prod.exchangelabs.com
 ([fe80::4c59:4ff7:289f:70bf]) by SJ0PR01MB7432.prod.exchangelabs.com
 ([fe80::4c59:4ff7:289f:70bf%4]) with mapi id 15.20.6178.007; Fri, 3 Mar 2023
 20:23:31 +0000
Date:   Fri, 3 Mar 2023 12:23:29 -0800
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Aristeu Rozanski <aris@redhat.com>, linux-kernel@vger.kernel.org,
        "D. Scott Phillips" <scott@os.amperecomputing.com>
Subject: Re: Error reports at boot time in Ampere Altra machines since
 c733ebb7c
Message-ID: <ZAJXQUY2nSiGMCX8@fedora>
References: <20230302201732.pwnhg46mum6st2bv@redhat.com>
 <865ybizqfi.wl-maz@kernel.org>
 <ZAJMwLMNizPMPzS3@fedora>
 <87mt4th9zq.wl-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt4th9zq.wl-maz@kernel.org>
X-ClientProxiedBy: MW4PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:303:8d::29) To SJ0PR01MB7432.prod.exchangelabs.com
 (2603:10b6:a03:3d3::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB7432:EE_|SA0PR01MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 1410b9aa-966b-4735-00c2-08db1c2527b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1uTp5SSJlk2xBLyg5IC0RalasA9n2rZXkza/R51k6SvEi3qFUp4CGlXvvksJl2SdUa5+AoEiXdko3KZIQaQLExpaAElu6w8Zoq57EvAE7oC0HZrSkKnm37n+TQtmo62hrZYm06jv2MahffzHOLLweNR4s/EF4vCJcrJynJGcic/yX7IiWhbopaMfRhBOVYoA49DXDMm3uqdfUP72aAAWDX7gToQbQ6u+anwOAp6c/4R8IBw9ntuxU0PWm8tSuDpzMU6+Gl+8FElQIHYFA6ryAryd2oEUh2CQkvIhMS5DLpuEMbMPTQ/vBERKBAZQ/9inG+OmoJmAeipZFe7E2d4ZSeAPeb6lik9rANut4sPoTHMsbVqO0kSTotBNf+Gg+FXZOxAg1vD94ISHFcge4AawH56JIdqwOJrnJt/+peq5qFgqiSIh53NlgZDpfgLsbjsqpindfy5U+Ooy00fZSTNizMf439WmKL7XaVTZT/2ZWCLJhgbhCpAsD/tGUF2y+RVatuwi2u07ayidnzVIN/YxmFxt9ONPRX7Ff+GXiOOmUJ0mE+gCbTWD8ghlXMhCUvuwwlCrTB4h8XeriFRfJqF7Q+wU74tV7WY7LN0xx5NbwpSnUY2thQN3vuDpehPThpORf30nZrVTmsgu1LF8MFe1LLEi73ezCOXDaa+9hpLU7oeEVGkgnsdLOPBV1omcov0K4xpAZqUJsLN4EgHUcyArA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7432.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(39850400004)(366004)(136003)(396003)(376002)(451199018)(83380400001)(478600001)(5660300002)(52116002)(6486002)(2906002)(6512007)(6506007)(186003)(26005)(9686003)(86362001)(107886003)(4326008)(8676002)(6916009)(41300700001)(33716001)(38100700002)(38350700002)(66556008)(66476007)(8936002)(316002)(54906003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q2umCu7/kSuq9iDXHPexgfnKpPmvIMCm0DMOASnhBsUBT+mOTh5OiVfBxIho?=
 =?us-ascii?Q?kh86FeuiLXeVSaZxWhsxex0HaidUHb+T/TmfirmfxKBGdHVA4wTh4ufq5HY4?=
 =?us-ascii?Q?1hfUtBjo8XcGV4IOfieXKOD28LcufV1A3/4d6mxzVRnxtvaD/gzKy5KCrYyU?=
 =?us-ascii?Q?stfhJQLQkjFVgHbo6KAZv3DSoWGXSsJo1bFGgC2awGj9HMtY57erFTIlwHg4?=
 =?us-ascii?Q?E/aFOFzoq+JOIf+SmFd+hjRpPjBbAcy36bHc36ydcuE1KaxQd6F3wHT7sMHT?=
 =?us-ascii?Q?F8cSk9slrbRpjaWLegG+tuqsPCTlZWRjRYCmXEA+slmUlKzAWTWOpYEdJq+A?=
 =?us-ascii?Q?gaE6YUtBjb5YDl6eDcSNoc85So1NoKVZG9qVdX68+5phTbadiyUlH7kcKnKn?=
 =?us-ascii?Q?3KQ1ohFkOusa1d7xGXZjPACUPq2ljVBkrcHcNeBJ9VJSubR5n68e9EfTRPvu?=
 =?us-ascii?Q?KNOaFwjnpwLkHV8CitAUvcox5SYrUUHwPtAo7OBM2MHijypal2Engr95TB0h?=
 =?us-ascii?Q?W1Pw1uXEFceK/vV0TMyQV7tRwZPGHLFMleE+pfyBtS4DhH/R52iy0gmVKFAJ?=
 =?us-ascii?Q?M4+Y1ekSfCrH8kdRBFmphyJ0ndiGaOFuyRiLf5BALqWjHVlYSBHDZPoepk/T?=
 =?us-ascii?Q?HAyFLqjWqCPcKWCW9Jra+90gB6rGsWYo12X9M3podfF9wjZcwijUo1y8SdBL?=
 =?us-ascii?Q?vXimTo8yGAuyREbUm4m/6KcErol9BOEaOiXjaN5RCNYr5j7dU3WLIrdV7hQJ?=
 =?us-ascii?Q?YDIzmhL7tN0P57WG/l6FchE/ZMWvacfKA/52VMVzBQAeORtEYXeJu798R+Mt?=
 =?us-ascii?Q?Bs9WpXXCmwEER4arauT57oEMifLBlSiY3bRue/rQjQPdjBHhXqO/mK3QFUEQ?=
 =?us-ascii?Q?uBgFHZ/VwU+rpNeoRoAxlxrUP2jTBuyqjs8yzN83ATG2MWhUZ+P5Q4LBMwf/?=
 =?us-ascii?Q?3hlBdpM44savy64o0DM5izvXHBzvJj8ZJaGl6nTFRR4hYWh9j9CG0XpzS3FK?=
 =?us-ascii?Q?hBUrZEv6JhvAFtPUCRqiGnBnxkshJF0YtxFmwirsYBz5VqkfdIeNtnHvLWTf?=
 =?us-ascii?Q?CJeuIIejpie8rf3PiMObxUEAS92XX67jChDeuIP5onkpJ8KwSUffr3dsShRG?=
 =?us-ascii?Q?+fO6tnIGVYfw7Trc1g02X5epVpaca3HCI3PCWXF/pKkU0TpzuexrM5MCfnz+?=
 =?us-ascii?Q?gEpXlICp6WrSLivaCKjAWMeGsyH9SN5T8ifPwUSZh6R89LE3e/pjwOxdk/V8?=
 =?us-ascii?Q?aXEmQhupgxnLACBIRkp1u0JTVA1L77iKjFfhZ6aR2AGfVsMDskHgmuAiDiFY?=
 =?us-ascii?Q?Clero8wNyinDNVSV0OHYY7aqvw5kO5NYWZXfSMRN1jB586mwBXwmHdBFD72C?=
 =?us-ascii?Q?hA6rz7IcJRuAx/U+C9k1syD5KeXfQWMMRXdOGIG0aZ6X4dY+iiBrZKVf8eew?=
 =?us-ascii?Q?WfIqKm5Ja7VedfUX79kI3kysI/Wu6ItZv2GlGfwny/hGArTBZQ653/8p2i7m?=
 =?us-ascii?Q?Xc2BOXGTxNrRolkEp2WTbmJAVEauMLbXnvR428dBEiW83XMNDQwMITj/UBii?=
 =?us-ascii?Q?m6BtnR8ruftM6ngHFBxbsJ8bzBf205dGrzSf2XM7dBi9Z5bFY+vCK8wQQOAG?=
 =?us-ascii?Q?YSTFcXeVaqZR/MtKIWFSVE8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1410b9aa-966b-4735-00c2-08db1c2527b3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7432.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 20:23:30.9573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctwFdPs2O1ShQPGc/04dCj1IVBZYzLG8wZFTYSYPGPg0/5KYHfIBhYHxOFhoEujGEWI6rcg5O1XLx9xlBO5BQYtIUf/UnnAnJbSTFT9gh77MqXQdMah7dSXHQDPZhJCL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6316
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 08:10:17PM +0000, Marc Zyngier wrote:
> On Fri, 03 Mar 2023 19:38:40 +0000,
> Darren Hart <darren@os.amperecomputing.com> wrote:
> > 
> > On Thu, Mar 02, 2023 at 11:25:37PM +0000, Marc Zyngier wrote:
> > > On Thu, 02 Mar 2023 20:17:32 +0000,
> > > Aristeu Rozanski <aris@redhat.com> wrote:
> > > > 
> > > > Hi Marc,
> > > > 
> > > > Since c733ebb7cb67d ("irqchip/gic-v3-its: Reset each ITS's BASERn
> > > > register before probe"), Ampere Altra machines are reporting corrected
> > > > errors during boot:
> > > > 
> > > > 	[    0.294334] HEST: Table parsing has been initialized.
> > > > 	[    0.294397] sdei: SDEIv1.0 (0x0) detected in firmware.
> > > > 	[    0.299622] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
> > > > 	[    0.299626] {1}[Hardware Error]: event severity: recoverable
> > > > 	[    0.299629] {1}[Hardware Error]:  Error 0, type: recoverable
> > > > 	[    0.299633] {1}[Hardware Error]:   section type: unknown, e8ed898d-df16-43cc-8ecc-54f060ef157f
> > > > 	[    0.299638] {1}[Hardware Error]:   section length: 0x30
> > > > 	[    0.299645] {1}[Hardware Error]:   00000000: 00000005 ec30000e 00080110 80001001  ......0.........
> > > > 	[    0.299648] {1}[Hardware Error]:   00000010: 00000300 00000000 00000000 00000000  ................
> > > > 	[    0.299650] {1}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
> > > > 	[    0.299714] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 3
> > > > 	[    0.299716] {2}[Hardware Error]: event severity: recoverable
> > > > 	[    0.299717] {2}[Hardware Error]:  Error 0, type: recoverable
> > > > 	[    0.299718] {2}[Hardware Error]:   section type: unknown, e8ed898d-df16-43cc-8ecc-54f060ef157f
> > > > 	[    0.299720] {2}[Hardware Error]:   section length: 0x30
> > > > 	[    0.299722] {2}[Hardware Error]:   00000000: 40000005 ec30000e 00080110 80005001  ...@..0......P..
> > > > 	[    0.299724] {2}[Hardware Error]:   00000010: 00000300 00000000 00000000 00000000  ................
> > > > 	[    0.299726] {2}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
> > > > 	[    0.299912] GHES: APEI firmware first mode is enabled by APEI bit.
> > > > 
> > > > Because the errors are being reported later in boot, it's hard to
> > > > pinpoint exactly what's causing it without decoding the error information,
> > > > which I currently don't know how to do it.
> > > 
> > > + Darren
> > > 
> > > Hopefully someone at Ampere can decode this and tell us what is happening.
> > 
> > Hi Marc,
> > 
> > + D Scott
> > 
> > Thanks for the connection.
> > 
> > This is reporting that something attempted to access GITS2_BASER2, the base
> > register for the gicv4 vcpu table. Altra doesn't support gicv4. Is c733ebb7c
> > assuming GITS_BASER2 should be accessible on gicv3?
> 
> All the GITS_BASERn registers should be RES0 if not implemented, as
> per the spec (12.19.1 GITS_BASER<n>, ITS Translation Table
> Descriptors, n = 0 - 7)
> 
> <quote>
> A maximum of 8 GITS_BASER<n> registers can be provided. Unimplemented
> registers are RES 0.
> </quote>
> 
> Returning an error on access is thus definitely a violation of the
> spec.
> 
> So either the GIC implementation you are using is buggy, or you have
> some sort of HW firewalling between the CPU and the GIC that is
> trigger happy. My hunch is that this is the latter, as buggy
> implementations tend to return an SError when missing this sort of
> detail.

Thanks for the detail Marc, let me see what I can learn and will follow up.

-- 
Darren Hart
Ampere Computing / OS and Kernel
