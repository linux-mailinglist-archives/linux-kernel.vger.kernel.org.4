Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1D36A4ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjB0WnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjB0Wmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:42:54 -0500
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2102.outbound.protection.outlook.com [40.107.10.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BC12BED8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:41:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUolWnC0qLPkH4St/P+V6UjUOh4p/b7JYcH6DRyJlVXAabnwFu5QJtWQCPNZFOlTMCpYCoZdrWsKX1Ork/7geCMWYqDurm4HtD7EZ/Yr8QS0xudwelpAe3WsORn3WVPTaxE+8jTqJbvsIk0E8VNwOTcwzjxqlw8zxV18zB5TWKJ2OAFV1LGxLVuG6Yx7q5iS1Glv9OKe1lm7n/r6OtXDD3M/dXQ64bE98cDAgL+hh9fYIpGMyVW1JDEwBZCKi0XW3LZlxYLkVHEX/hGSsBOjCRfc39+VGtjFyEIJf2KRBpSVXR9dBRVrnfZ1Iko3ANJgK1nunaq6XW9Y6wRZworH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P37vhgEEM8o+g+z5xPR0wm413ERn7I7BXqxCq1wGFmw=;
 b=JlvVWIPJ8FOxnrbsAIC4QFMgrNdRRNozkiovVPexKq6Uuz/kf/NJnyQOTppQBg+5s7xYkmRBG7oGfU8Aqxy8F1hBUYcSEdmCPbiq9cdJgBR9ZvbLWOIqzt0HlwzRhsLf6QJOKV8aSvZzSX1/Lzicykg7rRj/H2A8dsUItmIAeTOqYQ/rVddbB/TxNFxpKq1ewQFjC1gdMLxdyOZC1CuAPseOhWVuZdCY+mCnJlnobAQA+Pfn1mL39cfnMGub25+VRQQTC8rXZszciAYlA6kX/5TrSZ/6mKv3KILHvdLo6a2/hATal/NGjTBStHVFJxOweB/URuJ8h9FV/vfdpvS1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P37vhgEEM8o+g+z5xPR0wm413ERn7I7BXqxCq1wGFmw=;
 b=sXRrH9sWnfdouhCwC65LkXbBj3O/NqCFQKx2ZJmW395+y+3/AoTfQm/TiJh4n5DEQXRSvAGsPtgEKMPOZ+Ir2nSn/D9ZONR/bvCDdbyQwAG/Bt+DENH8w5i8X8zLObKRs5I+aX7Fg7X8avEculP29VHEtjk7DA0EKFO25OYFH2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB2130.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 22:40:26 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f2a:55d4:ea1d:dece%3]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 22:40:26 +0000
Date:   Mon, 27 Feb 2023 22:40:24 +0000
From:   Gary Guo <gary@garyguo.net>
To:     Guo Ren <guoren@kernel.org>
Cc:     Sergey Matyukevich <geomatsi@gmail.com>,
        Zong Li <zongbox@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu, alex@ghiti.fr, hch@lst.de,
        ajones@ventanamicro.com, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH V3] riscv: asid: Fixup stale TLB entry cause application
 crash
Message-ID: <20230227224024.182c8cad.gary@garyguo.net>
In-Reply-To: <CAJF2gTRirf6woe_phDMM84Yy9TGyzhc+767qK0qvNQNaNLmUGA@mail.gmail.com>
References: <20221111075902.798571-1-guoren@kernel.org>
        <CA+V-a8tbFhefuYF0UrGNrKZn6CpHEUhOvsf4GNmdLza0gWvf=w@mail.gmail.com>
        <CA+ZOyah9dBzzkHyy6wxk+hok3K1YrR9h+VdA3aTW5+m9ne04SQ@mail.gmail.com>
        <Y/phgGFWMf/4WRSS@curiosity>
        <CAJF2gTRirf6woe_phDMM84Yy9TGyzhc+767qK0qvNQNaNLmUGA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0173.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::18) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB2130:EE_
X-MS-Office365-Filtering-Correlation-Id: b67c99f6-ae0b-41cf-4f44-08db19139eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dENOSuhPkBK64j8K/bQdpbJy4f192R0vEaTaFE+OsElkkBxhTmbI3RtU/3w8zr6yOzuZVGwikdj1UAXgQUE5MrlCLM2udHwky8CTcd0mLzr1dd/mVBj6WAhYvrRX7jKZeEyQKMe2bd217hZ7oY/XNYgoyzzkDO7SsRRPwvbEbjQP7FBFy0oXnECYzVkr7J1nbceQTUiVXTw+9RCg9GcLCKMcPjnWCOMlsHfyW5Tv83WYxSq0HVOFEkVFKWm8ty+moGaFYrWtZbYPKQGVFYFYKwEMMdmKhGXcTKIh77T7sinBsaZL4Lr2Zf9eGDNLV0Cf0GIcvJgqG1Zz7Q3f/CXSNJbamnbnbylXoeMm3ZxOVBCifOl5lfv7pgxMyWizBR+717ApZoVJYaMasY4QQkkq/XXSzjWtNJdpogx+EfktVDxIDqpp0kwp9ZqPBCLbk1pVv3aiFx+pzbD+/cfBB9kHkh0Vwv/HQdP0NPRJ02MIeYT5loXUMnC1mCSKNRrl7X8r0GuF+5/76SOm25Q/4YInigQnU5la3m2QvcCB7BHvB3oVHD8ugPRlOFXydMRFBCPku1YEb5fDiY/4Drq3VMDxJ89pW4JLHA4vRazyhiuPvq7UrwbUhOzTBAZ9PV+ZdmIa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(366004)(39830400003)(451199018)(7416002)(5660300002)(36756003)(86362001)(8936002)(83380400001)(478600001)(26005)(2616005)(6486002)(966005)(6506007)(6512007)(186003)(8676002)(66946007)(66556008)(38100700002)(53546011)(41300700001)(1076003)(66476007)(4326008)(6916009)(54906003)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGZCZVQxR3pXMVlBTzlYekcwMGNEbHg5eU1lT2pzZG4ycWViY0RDenprMmY4?=
 =?utf-8?B?V2l2K3QxVWFpSk1jemtpREwvU0pZNGZkRlg3ejMvZ1ZDbksrVVo2NjdrK3NM?=
 =?utf-8?B?UVBxVTFoNTRWY2NFWXdzcHJtcGlRUjE1WW9NVGdyZEc4MHZVVHJRTDg1L3Fz?=
 =?utf-8?B?QlVLSkUzcllRZm5uYkhMSnVxc0tkWnl2NUE2czBvZHJwWUZ5dUwrTTYxUkJC?=
 =?utf-8?B?NkRUakJDaHhwTmZ1QUd0djN5T2lOa0tvU3VUcEV2SVdYcVBsdDFrUDR6bXhK?=
 =?utf-8?B?L2pVLzdaR2tzUFMraE5EYXhvRXNWcXZvcTdBUXdQS0MrZzU3T2dzTjVRc1JV?=
 =?utf-8?B?OEtBanZwTTgySGg0Sm4vQ0RCemkvdGJQb2YwL2cra3hqbGNNTC9TcTQ5dVJB?=
 =?utf-8?B?UmFwK3U1RHlyKzFncnJ4SEpVbjZjK2djQmxPTVc0ditSQVd0WVJLMVBuMzhG?=
 =?utf-8?B?cjdaRTBuUXE5eWNSSTU1WXl2TXV6dTQ2QStpbzJZdmo1bDNRZ0MrTnlZTGlu?=
 =?utf-8?B?cGxZUHd4bUJRVlA1OW05RVNDL0ZOM3loZ3JGM3laMExHUmd5MnZPVnVjdm5m?=
 =?utf-8?B?ZkVwT0xEVTRibDJyYUZiZGh3bm1mV2NQNU9NR3BXbEpWK3RoQ1NNNU9Rc0pq?=
 =?utf-8?B?VDZiL2VSTytkblhvUGhXNmNrVXBMRVVuanJIRUJtUEpucEZCQktTRVEvOHow?=
 =?utf-8?B?YXlzNjh3M1QrR1laUGhNdCtOQm0wcVM3dGFBL21JTmhvaUJ3VVZpdzhoanNo?=
 =?utf-8?B?YU5oMzNoVjduRWlVQ0I3M1ZRR2VDOVRtVVlmMkJnWkR0MEpJNWovQnpUby8w?=
 =?utf-8?B?N0hVL0xxL3BBMjlrSEsybm9WT2p5K1JieVV2UG85SE1QSG54MUNxYTdtOFBk?=
 =?utf-8?B?V1crMk80QjVvM3ZuZStma0ZJc1Q3R3N5Q3FyUURmL1BoeTlmUk1mQmdhQnpP?=
 =?utf-8?B?RGdlR3c0V2FGcDVCMlVSRlZkNU5WQkdRQ0VWRVBiREJyRkYwbXRYaWh4RVds?=
 =?utf-8?B?YStoS1FSN3BZS1E5TnFGbWZXcGtMamk5TXdkVjMxbk1xcDMyRVRyVTFtd3NH?=
 =?utf-8?B?eThUbjdYaXRjdG1hME90c1RZR3pYdy9FOGhWV04yWWxGb3gwbS9rVCtzcFRa?=
 =?utf-8?B?Z1Fxb3RPQ3IvVzhqRXo3d0pXV0lweXc4TDVLWUpUbytaU2l5ZitFV0c5ajZG?=
 =?utf-8?B?WjhLdDY2SUhwbmJ3bEFrSFBQYml3ejZKaW9xZ3RFdkNLanRJVGExbWoreDU2?=
 =?utf-8?B?VUxaTlVPM2Q1RGk4eE81TnV4M2lPb3VUeWRNanA2L3QwNCtISnpObjl1QzAz?=
 =?utf-8?B?OXoycTdlWGViMm5lbkpJampjV2tFUGpQZUFMbWY3KzhGMG9mazg3WWdLYzAv?=
 =?utf-8?B?bmNXWmtNUzdjY3MrNXU2SkFVdDc3RnA4VXFlNStwZDhPUVF6RVRHYUx3Sk8w?=
 =?utf-8?B?bEVuRFp0VzRWM2t2ZHRxWkpLVGlXYk0xaVFYWmJiRGFqSnJFbVBRQWRNVmRh?=
 =?utf-8?B?MXE0Rzl0Nkd3M0ZpZldtRUNkNEtHQ2Zzc09scmpqVGJnbVRjazFHajhTQlJt?=
 =?utf-8?B?MllvWDlQZDFMVnI5emNCMnQ4cm9RbTM0ZUpBWUtYWm1PM3FRU2d1ak5DZ2F1?=
 =?utf-8?B?V29pZTdEdUl1MlpLd0RXY2tDMkhYSjJTWThiUENMK21CckVRSWhsWjltTnlw?=
 =?utf-8?B?ek1ESjFBZUhQaXVvaDc4bWFDQXJZUjI5cTlMV2ZpZmpXZVU4Q3V3QnVtR2R3?=
 =?utf-8?B?RUJQUldJN0tWTDUvNXNickN0emtaL1FSTjlyMDRzZXRtcnl4RlJCaStWQVRI?=
 =?utf-8?B?SzlWTW1iY09aS2pIYmxoOGRPR1Jkc3JtM0toY3M5RUN5Tk5hU3ZUZm1hVXVU?=
 =?utf-8?B?VTlYQ1AvY2lEdTRmbFhnN1FpYWZXWnBhanJYWnJnbEZwT3NmUnptT1pKK2tm?=
 =?utf-8?B?aDlFMWV4RXdIbUdpMDlrbHhqem5wQUNtTFAxck54eTBlRlpvZHY1eldWRkZ2?=
 =?utf-8?B?Rnl2MHQ0SExybk9XRzMyVEZBVjJ1Qy95ZktHL3hycVNnZURLMHVrMmwxdG5G?=
 =?utf-8?B?RmJRa2NmWFo1cTByTkFsR0xLQ1ZnaHkrK04ya2R5NDFpWDdXNTN3UFFnYW1H?=
 =?utf-8?Q?8WQBcSAWbC/v299OSiCtwMdaw?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b67c99f6-ae0b-41cf-4f44-08db19139eb4
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 22:40:26.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+QVe2acWIjYJU0elDh4o7CyYU14lejYLSTFdRMJ0nIulGK/moGbhuqCH5UI9lo3bWWcp/cQHm2FzDp7QJIugw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023 23:24:40 -0500
Guo Ren <guoren@kernel.org> wrote:

> On Sat, Feb 25, 2023 at 2:29=E2=80=AFPM Sergey Matyukevich <geomatsi@gmai=
l.com> wrote:
> >
> > On Fri, Feb 24, 2023 at 01:57:55AM +0800, Zong Li wrote: =20
> > > Lad, Prabhakar <prabhakar.csengg@gmail.com> =E6=96=BC 2022=E5=B9=B412=
=E6=9C=8823=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:54=E5=AF=AB=E9=
=81=93=EF=BC=9A =20
> > > >
> > > > Hi Guo,
> > > >
> > > > Thank you for the patch.
> > > >
> > > > On Fri, Nov 11, 2022 at 8:00 AM <guoren@kernel.org> wrote: =20
> > > > >
> > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > >
> > > > > After use_asid_allocator is enabled, the userspace application wi=
ll
> > > > > crash by stale TLB entries. Because only using cpumask_clear_cpu =
without
> > > > > local_flush_tlb_all couldn't guarantee CPU's TLB entries were fre=
sh.
> > > > > Then set_mm_asid would cause the user space application to get a =
stale
> > > > > value by stale TLB entry, but set_mm_noasid is okay.
> > > > >
> > > > > Here is the symptom of the bug:
> > > > > unhandled signal 11 code 0x1 (coredump)
> > > > >    0x0000003fd6d22524 <+4>:     auipc   s0,0x70
> > > > >    0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d9249=
0 =20
> > > > > =3D> 0x0000003fd6d2252c <+12>:    ld      a5,0(s0) =20
> > > > > (gdb) i r s0
> > > > > s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
> > > > > (gdb) x /2x 0x3fd6d92490
> > > > > 0x3fd6d92490:   0xd80ac8a8      0x0000003f
> > > > > The core dump file shows that register s0 is wrong, but the value=
 in
> > > > > memory is correct. Because 'ld s0, -148(s0)' used a stale mapping=
 entry
> > > > > in TLB and got a wrong result from an incorrect physical address.
> > > > >
> > > > > When the task ran on CPU0, which loaded/speculative-loaded the va=
lue of
> > > > > address(0x3fd6d92490), then the first version of the mapping entr=
y was
> > > > > PTWed into CPU0's TLB.
> > > > > When the task switched from CPU0 to CPU1 (No local_tlb_flush_all =
here by
> > > > > asid), it happened to write a value on the address (0x3fd6d92490)=
. It
> > > > > caused do_page_fault -> wp_page_copy -> ptep_clear_flush ->
> > > > > ptep_get_and_clear & flush_tlb_page.
> > > > > The flush_tlb_page used mm_cpumask(mm) to determine which CPUs ne=
ed TLB
> > > > > flush, but CPU0 had cleared the CPU0's mm_cpumask in the previous
> > > > > switch_mm. So we only flushed the CPU1 TLB and set the second ver=
sion
> > > > > mapping of the PTE. When the task switched from CPU1 to CPU0 agai=
n, CPU0
> > > > > still used a stale TLB mapping entry which contained a wrong targ=
et
> > > > > physical address. It raised a bug when the task happened to read =
that
> > > > > value.
> > > > >
> > > > >    CPU0                               CPU1
> > > > >    - switch 'task' in
> > > > >    - read addr (Fill stale mapping
> > > > >      entry into TLB)
> > > > >    - switch 'task' out (no tlb_flush)
> > > > >                                       - switch 'task' in (no tlb_=
flush)
> > > > >                                       - write addr cause pagefaul=
t
> > > > >                                         do_page_fault() (change t=
o
> > > > >                                         new addr mapping)
> > > > >                                           wp_page_copy()
> > > > >                                             ptep_clear_flush()
> > > > >                                               ptep_get_and_clear(=
)
> > > > >                                               & flush_tlb_page()
> > > > >                                         write new value into addr
> > > > >                                       - switch 'task' out (no tlb=
_flush)
> > > > >    - switch 'task' in (no tlb_flush)
> > > > >    - read addr again (Use stale
> > > > >      mapping entry in TLB)
> > > > >      get wrong value from old phyical
> > > > >      addr, BUG!
> > > > >
> > > > > The solution is to keep all CPUs' footmarks of cpumask(mm) in swi=
tch_mm,
> > > > > which could guarantee to invalidate all stale TLB entries during =
TLB
> > > > > flush.
> > > > >
> > > > > Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
> > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > Cc: Anup Patel <apatel@ventanamicro.com>
> > > > > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > > > > ---
> > > > > Changes in v3:
> > > > >  - Move set/clear cpumask(mm) into set_mm (Make code more pretty
> > > > >    with Andrew's advice)
> > > > >  - Optimize comment description
> > > > >
> > > > > Changes in v2:
> > > > >  - Fixup nommu compile problem (Thx Conor, Also Reported-by: kern=
el
> > > > >    test robot <lkp@intel.com>)
> > > > >  - Keep cpumask_clear_cpu for noasid
> > > > > ---
> > > > >  arch/riscv/mm/context.c | 30 ++++++++++++++++++++----------
> > > > >  1 file changed, 20 insertions(+), 10 deletions(-)
> > > > > =20
> > > > As reported on the patch [0] I was seeing consistent failures on th=
e
> > > > RZ/Five SoC while running bonnie++ utility. After applying this pat=
ch
> > > > on top of Palmer's for-next branch (eb67d239f3aa) I am no longer
> > > > seeing this issue.
> > > >
> > > > Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > [0] https://patchwork.kernel.org/project/linux-riscv/patch/20220829=
205219.283543-1-geomatsi@gmail.com/
> > > > =20
> > >
> > > Hi all,
> > > I got the same situation (i.e. unhandle signal 11) on our internal
> > > multi-core system, I tried the patch[0] & [1], but it still doesn't
> > > work, I guess there are still some potential problems. After applying
> > > this patch, the situation disappeared, I took some time to look at
> > > other arches' implementations, such as arc, they don't clear the
> > > mm_cpumask due to the similar issue. I can't say which approach might
> > > be better, but I'd like to point out that this patch works to me.
> > > Thanks.
> > >
> > > Tested-by: Zong Li <zong.li@sifive.com>
> > >
> > > [0] https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geoma=
tsi@gmail.com/
> > > [1] https://lore.kernel.org/linux-riscv/20230129211818.686557-1-geoma=
tsi@gmail.com/ =20
> >
> > Thanks for the report! By the way, could you please share some
> > information about the reproducing workload ?
> >
> > Initial idea was to reduce the number of TLB flushes by deferring (and
> > possibly avoiding) some of them. But we have already bug reports from
> > two different vendors, so apparently something is overlooked here.
> > Lets switch to 'aggrregating' mm_cpumask approach suggested by Guo Ren.
> >
> > @Guo Ren, do you mind if I re-send your v3 patch together with the
> > remaining reverts of my changes ? =20
> Okay, thx for taking care. Let's make it work around first and then impro=
ve it.
>=20
> Actually, the current riscv asid is from arm64 with hardware broadcast
> requirements. Maybe we need to consider x86 per-cpu asid pool way.

It should be noted that the spec expects supervisor software to
use a consistent meaning of non-zero ASIDs across different harts.

Also, a vendor could implement efficient hardware broadcasting ASID
invalidation with a custom instruction and expose it via SBI.

Best,
Gary
