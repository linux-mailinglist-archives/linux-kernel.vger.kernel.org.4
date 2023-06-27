Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B79740388
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjF0Sow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjF0Soq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:44:46 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2127.outbound.protection.outlook.com [40.107.114.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4151A10FB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpBTk7U86h1K41a5edfGCkTC1bidNnk3jJvpPB80WgwhZpowuQbDMBRUSNLaHGL+Dtn5AdgrFYTpJHE/6wzpi4MLkCAeTMLz++GIlAWdLCTACimp0Ef2bS/73WbFJ7tJsjrn6RwM0yS6gT//44lagA+XPq+wHS2lNRpsWomHeIsuXdCopiv4Cp0yAdIixETUc4IcM0EjFo1pYgRIBBRNDaP9NaBKmULWKL8+v0B/gw3RFZmZKsjH5JquMVlU6YRTFiYXrf+f88/nlQU6DY8O0FnhLtIGuT89q150CVV2NmrB8m4X5vPosGpPOkBkCT/ISSjGDXyF5GgTracRGM/3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9FmIqYtIvGCkZmueve8r/atGa3N/4iXtGO2h0j58Dc=;
 b=B0NA0c0nHQ4gMnUxyKgyau34sLO2Kn47205rC2E95iFrDjqNNw+5J56kRrHYM/0ZLJ8xwKGw1F6UFvcGvGMwwlAaZ/MoPOPZCx+NZN2GMGKX2hdSxLkngt4BVnxzzaMg4COfgwTEF3VP+T/0sqMky0oYfMEUsChmjgT1i/dUPHtk88gnt3OV7YxNTOr+bCxvTaJ0B5rSF6CdQc+GZOd/N7Nbwmm42JsK4ScR/kk+dmScWv9k5kW5LqvCppD+vbcMpMytkE/wBHldOtedLKcb9dmE86r7WsAMfthBlUjLkPo+1e7XCeTcPhdUEgFdpcOI6BbGZMEoSC4m1XIQs+/KbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9FmIqYtIvGCkZmueve8r/atGa3N/4iXtGO2h0j58Dc=;
 b=rYr1UE2n6Lvl6aoxGfdmZBfNElv1yJYmaIFuO7aRrvaPyG6c0KBei/ghIFiUECt3ks+hu5rJbsG0znS291CUowEMig9Lxs+baEEq8XfqW+83l6f0vDEqITeBpImldXrr546yx0eeWkIbYiVwr158BPyjp5TKszAylMEhDwAgxsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OSZP286MB1984.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:181::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Tue, 27 Jun 2023 18:44:41 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d5aa:e14:adea:f392]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d5aa:e14:adea:f392%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 18:44:40 +0000
Date:   Wed, 28 Jun 2023 02:44:33 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Evan Green <evan@rivosinc.com>
Cc:     Samuel Ortiz <sameo@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Jiatai He <jiatai2021@iscas.ac.cn>
Subject: Re: [PATCH 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <ZJsuEZU0+Map3bxa@Sun>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
 <20230627143747.1599218-2-sameo@rivosinc.com>
 <CALs-HssMkVikspnEi-Ek2t=ABvFvgptAhsBjk1+aLuVjiP7P7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs-HssMkVikspnEi-Ek2t=ABvFvgptAhsBjk1+aLuVjiP7P7w@mail.gmail.com>
X-Operating-System: Linux Sun 5.15.67 
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: SJ0PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::14) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB1393:EE_|OSZP286MB1984:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2f2c53-0649-486e-9e43-08db773e90c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KV4BrVVLe7I/46b1eQ0WZGF6pcvP7I2HY3GY197qD6fcmU/PJg2IdXeB5IswqgeSh8+42x3SkA8AnC8ULhBR+BmweBrUROX6ALtkKbQE2vpM6m8SEO4HzahGe8uRK4okSnK1Wor7RvbqakDh6AzbW99yl7TpOr0ALdto25EmlgVPlnTBbJXDeUIiV4hVYDH9L+moSQassqDj+mSoc3KCb90rzg4kuhRrAOhd4koLp+kzKn6OzdvUdcWMwZsFMdLCEZZ3hyp8z2xd1hXdt6mDqFqY0Jc/aONpOrFrgepZc72+4NXXVzuLNzY17vniwRy9d2sa6lZwRjfbao0rU0VvF+xDEqOQjK9C+coMyolbR0Bdd8y1D2ANWkD2uYGlMW3TGKaI7rlUbbCHKSpjWveAv2zG+dmpzOSVh3PAUvtYAu2fnAiq6Ch42SSXF1ZVc5b8vt4O6HA+N9qomO01OYAjcweOw9UHYtmwbh86TxMJUn+fHu7Fb73uAKGAcgc8VnudVz4C4HAkDGQiiKxg4ItPpohfdLufJlRihtwzYngiQKjtLd0RB4scwLvS29SPxGpFVJPwElEFff2PlRxF2KtQDdUT3ibjelpBmAj+mt3BPvbDcMDk5aitsPu4NcwbtFrGcJ4lwVEdKRAvDej56oKBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39830400003)(396003)(366004)(346002)(136003)(376002)(451199021)(54906003)(2906002)(33716001)(6666004)(6486002)(38100700002)(83380400001)(53546011)(6506007)(186003)(9686003)(86362001)(41320700001)(41300700001)(478600001)(66556008)(786003)(6916009)(66476007)(316002)(4326008)(8936002)(66946007)(6512007)(7416002)(8676002)(5660300002)(49092004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlIyNmJZamtWOFVBOUQwclhaU2ozSVZ1eVRGTjdjaGhwbU5IUlVNeUtVenlp?=
 =?utf-8?B?amJna3VqNDU5cmFPczUzVC9CZVliWkRiUlVjV0lFTG4ydjJBM1ZDMmJkQUZO?=
 =?utf-8?B?cERmR2ZrTzh4VTVobnJEOGJGR09LTWxZWGpiakovT0RaUDlqWVY2MCttU0R5?=
 =?utf-8?B?Q0tVYTJKaURVQ0pJTjVjN3FUeGFOL2xONE5xR3NWN0orWVJZYXorV3lORGlE?=
 =?utf-8?B?SmMxQm90ZXRSMjAyYW9YVnFieDdvUXRDdFdkWW5iSTUydnhvU0ZSdDJ6OTdW?=
 =?utf-8?B?SnhCclBxcHQ0czRQcm56VXJFaWtjTE0rM1NoTSs1REprT0E4Vm1TOGNxYzJj?=
 =?utf-8?B?ZjFhNmtVYm03aXdEMHBKTGprcnRmZUV6N2RDOGpXZXpqTVAyU2wxbDYrcU9W?=
 =?utf-8?B?bGtzYzJFYXBmOVpHRnpWZjRlWG1QTGIxSUNBdUdWUmgwbWJpbzdTVjVMb2tn?=
 =?utf-8?B?alVjOCtnR0kyYjJvUXYrTFc2d2t4dTZCbjhCTHRGTXZQSzY5a0k3aWE5M1BY?=
 =?utf-8?B?RW9XMlB0cmxiSk1SZTU5RjBUUThKbmF4ZGJvSUVlWmlMYk11RDFraXgrbUNC?=
 =?utf-8?B?WUk3b0dNdit5bDdwVVgxdExBZTVBeHZlRDNxamg5ME9vM0dmSVBUYzU5emR1?=
 =?utf-8?B?d2lLcjlJd2FKNXdaN01BQ2tNUmJjZWE3M0I2VXozUkJ1cllRVEhGRTJyU21K?=
 =?utf-8?B?RW5NaEpaSlRLM1NsV0pMRm00TVlzZVRKNTZzZUR5cmdYQVBvdHhIY0o0NDYx?=
 =?utf-8?B?Y05EUHl4MEpNMFlGZ3dPVUt4L3FtQXpBaFVySU1hZ2NwT1YwbkFIL1EwZTdr?=
 =?utf-8?B?UXlDVkNFOEJ3c0M3T01pb1dZRGUzeG95V0hHUjdFNjE4aGY4MHdFMlR1YnJ0?=
 =?utf-8?B?MWJMSWFXMEV5OC9JNFJyZm1lSFlSMGdTbStvenVUNjFUUXdOOFpzR0ZJNlQy?=
 =?utf-8?B?dGRycE5XUHZQbnp1K0tQV3NZUkpCc1c3NTgxNzM0U0w2d0d6MGNBZXU2TnZC?=
 =?utf-8?B?ZXF3OEgzblB5ZjlmaUNpRWUxQmVoRndGUngza21zcHBqVE81bmxtOU1NL2Zy?=
 =?utf-8?B?M1pmTjdmR2ZSOTdJL0tLRENhQXl5UEtEVS9ERlUvbG1JaHFMdTJJWmVxWlZJ?=
 =?utf-8?B?VlM1b1haUCtjTGQ3MWFNUUJFZFRqN0ZGRnBkbG53S1BINzVqWHh0aUhBcmZV?=
 =?utf-8?B?SmVQSFZJWkFiV3RMNytMeTR0SGZsaWR2VGw0MDdBWHVYTW8vK05lTWQrcGJ1?=
 =?utf-8?B?akdSOGdnUnUydTY2VVFPZnFOUFc2M2gzMk1tSW1VWkxYUmhJVExjNkthOWFY?=
 =?utf-8?B?UmhWY1lFc1JHMGN5Q0EzMDNuNkR4bTBSUlBSS2cwZmNGSG9DRVEreFFnZTcr?=
 =?utf-8?B?WGkxL0laeGcrT1Rrc2pZM2hCdG9KaTlpMGRTV0hoM2tncFl4UlpFUVJ2a1RL?=
 =?utf-8?B?c3pXZmRvZVdJN1hKbEE0YWw5Q1A4WnYwc044QVhZbnM3akZtUGE4RTVxcTFB?=
 =?utf-8?B?S3pZbWtwTCtPV2ZMRU5RQWtRRGlOSGQ2TXVMQktsOHpLQ3h1WHJ3WlVVSDlU?=
 =?utf-8?B?UHBLZms2b0hFcldqODZ2QVlNRnFpQjV5ckJKMXZGQlRJRm9kRDlFZExwYXFs?=
 =?utf-8?B?YkxxM1pMbk05MmR4R3o1TlBqbDlhV2J4Wkx4WVdTcnVCVWxaRFFlc2laZ3dW?=
 =?utf-8?B?elVDcURVbk1JeW80NGtZM2hwVnJTc2lteEdlbStBYm9xTzFWc0RFNVJtWnNW?=
 =?utf-8?B?MTFUYmRoU0hqNHdRZ3ZzSlA3YTVNT1FoRnA5empyOFFVOHc0QXljNWlOVlZV?=
 =?utf-8?B?cTkzcHpXWFpSNEYwNjRONktPRk0yOGJqemZ5Rm4xMldPV3BUVUZLbWdyWU1Y?=
 =?utf-8?B?YWYvRXhyTy9JNysrWVczSFY5dHEramF1cU5vVnZhM1R2QXlWRHBka0JEZVlS?=
 =?utf-8?B?cWY1Q1hnQUkyRi82Q0Y1TUpmanVMZUY1TTFGc0hpVEdSc3hCVEtadTFQMXdw?=
 =?utf-8?B?aExJNDU5NFhHdmFlR2tFdmpoMnNxTHMrZVhZL3lybHhnOGlQbVB6Y3pHN0Jy?=
 =?utf-8?B?ZDBMNXZOd1V0MXFjREpxOGtkT21yTGxOQWF4QVdYL2tRVXloTGZscnVUY2dU?=
 =?utf-8?Q?3aAP0qLohHbSBp8r8uVcAejL3?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2f2c53-0649-486e-9e43-08db773e90c7
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 18:44:40.6769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlBty4xlVDL5RnEnEE/xRmlBmu4j8T07WUuIWe8kQe4XJWHF2xIqcrnLdTH6tAsf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1984
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 11:14:30AM -0700, Evan Green wrote:
> On Tue, Jun 27, 2023 at 7:38 AM Samuel Ortiz <sameo@rivosinc.com> wrote:
> >
> > From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
> >
> > This patch parses Zb/Zk related string from DT and
> > output them in cpuinfo
> >
> > One thing worth noting is that if DT provides zk,
> > all zbkb, zbkc, zbkx and zkn, zkr, zkt would be enabled.
> >
> > Note that zk is a valid extension name and the current
> > DT binding spec allows this.
> >
> > This patch also changes the logical id of
> > existing multi-letter extensions and adds a statement
> > that instead of logical id compatibility, the order
> > is needed.
> >
> > There currently lacks a mechanism to merge them when
> > producing cpuinfo. Namely if you provide a riscv,isa
> > "rv64imafdc_zk_zks", the cpuinfo output would be
> > "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed
> > _zksh_zkt"
> >
> > Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
> > Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>

I think an extra line of your own signed-off-by is needed

> > ---
> >  arch/riscv/include/asm/hwcap.h | 11 +++++++++++
> >  arch/riscv/kernel/cpu.c        | 11 +++++++++++
> >  arch/riscv/kernel/cpufeature.c | 30 ++++++++++++++++++++++++++++++
> >  3 files changed, 52 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index f041bfa7f6a0..b80ca6e77088 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -53,6 +53,17 @@
> >  #define RISCV_ISA_EXT_ZICSR            40
> >  #define RISCV_ISA_EXT_ZIFENCEI         41
> >  #define RISCV_ISA_EXT_ZIHPM            42
> > +#define RISCV_ISA_EXT_ZBC              43
> > +#define RISCV_ISA_EXT_ZBKB             44
> > +#define RISCV_ISA_EXT_ZBKC             45
> > +#define RISCV_ISA_EXT_ZBKX             46
> > +#define RISCV_ISA_EXT_ZKND             47
> > +#define RISCV_ISA_EXT_ZKNE             48
> > +#define RISCV_ISA_EXT_ZKNH             49
> > +#define RISCV_ISA_EXT_ZKR              50
> > +#define RISCV_ISA_EXT_ZKSED            51
> > +#define RISCV_ISA_EXT_ZKSH             52
> > +#define RISCV_ISA_EXT_ZKT              53
> >
> >  #define RISCV_ISA_EXT_MAX              64
> >  #define RISCV_ISA_EXT_NAME_LEN_MAX     32
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index a2fc952318e9..10524322a4c0 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -215,7 +215,18 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
> >         __RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> >         __RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> >         __RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> > +       __RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> > +       __RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
> > +       __RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
> > +       __RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
> >         __RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> > +       __RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
> > +       __RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
> > +       __RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
> > +       __RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
> > +       __RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> > +       __RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
> > +       __RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
> >         __RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> >         __RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> >         __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index bdcf460ea53d..447f853a5a4c 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -309,10 +309,40 @@ void __init riscv_fill_hwcap(void)
> >                                 SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> >                                 SET_ISA_EXT_MAP("zba", RISCV_ISA_EXT_ZBA);
> >                                 SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB);
> > +                               SET_ISA_EXT_MAP("zbc", RISCV_ISA_EXT_ZBC);
> >                                 SET_ISA_EXT_MAP("zbs", RISCV_ISA_EXT_ZBS);
> > +                               SET_ISA_EXT_MAP("zbkb", RISCV_ISA_EXT_ZBKB);
> > +                               SET_ISA_EXT_MAP("zbkc", RISCV_ISA_EXT_ZBKC);
> > +                               SET_ISA_EXT_MAP("zbks", RISCV_ISA_EXT_ZBKX);
> 
> Should "zbks" be "zbkx"?

Yes that is a nice catch!

> 
> >                                 SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
> >                                 SET_ISA_EXT_MAP("zicboz", RISCV_ISA_EXT_ZICBOZ);
> >                                 SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
> > +                               SET_ISA_EXT_MAP("zksed", RISCV_ISA_EXT_ZKSED);
> > +                               SET_ISA_EXT_MAP("zksh", RISCV_ISA_EXT_ZKSH);
> > +                               SET_ISA_EXT_MAP("zkr", RISCV_ISA_EXT_ZKR);
> > +                               SET_ISA_EXT_MAP("zkt", RISCV_ISA_EXT_ZKT);
> > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKB);
> > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKC);
> > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKX);
> > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKND);
> > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKNE);
> > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKNH);
> > +                               SET_ISA_EXT_MAP("zknd", RISCV_ISA_EXT_ZKND);
> > +                               SET_ISA_EXT_MAP("zkne", RISCV_ISA_EXT_ZKNE);
> > +                               SET_ISA_EXT_MAP("zknh", RISCV_ISA_EXT_ZKNH);
> > +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKB);
> > +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKC);
> > +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKX);
> > +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZKSED);
> > +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZKSH);
> > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKB);
> > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKC);
> > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKX);
> > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKND);
> > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKNE);
> > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKNH);
> > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKR);
> > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKT);
> 
> It would be nice to consolidate the ones together that search for a
> single string and set multiple bits, though I don't have any super
> elegant ideas for how off the top of my head.
