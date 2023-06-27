Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7DA7403C3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjF0TEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjF0TEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:04:10 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2103.outbound.protection.outlook.com [40.107.113.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4405D1FC3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 12:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCRQxHMnDoLvJNHvTUfeCBZup2eZo3KlNN2ZkoQAwdL0fgDzmS/ZubBW0ERI7TpIua/2TtSkSjAS5vuCf1fDaTTHsnPiB/nVPVnShx9+hyM4XFhug8VsfE9pE+/M87ArhWcwiG7iX3x5VaE2aBnNA3zcaGE+WiGr5JXMtNuZl1PZZrgJzU65tpFwBD52JXeyXspTr0H3ZTFcSkACQzdv+JoSbG10yOU6XqxqVpXp293IUyLoakgCB66NUSubR3H5XiUhH49A3E7GDdT0ecIp2IoBXP6QEZyFWcKbMI7TTUlxL1DifkffKXMyJJ8qXofMBRk0nZCheZg3Sk3ncCTdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWLzb8ymI1XpiIC4jC60HepCFIyP9RRhpO3sH9SrIj0=;
 b=bF+ZlwmT3WAlB5SRXUdMlAu/2bMvHylONS7hISRzGtjfcm+EW/10UiaU0l6MH4l+ZUKuHG9xtoXmo8IPzyI7iRECpMAI9IvyaW93jw46OqDW9K/+7GME6Qdi3ZmqoH8E+8qQZyE7i+h/qTpmKMNx1PYf1s3BARuxvOGw8z6fyqYOXlM83bk+kvsmZka5SNjxkZiBLFjVkgRalRNJN3FGy0Bg00xyLzIu4wlxYG5/fhQrMJ9vUvp417Xo63nqluLDoN+yRe6VE6UA4KwlykzTzGoHKwpUaVrvOJwb9pXjiaEmZigLn/V43aRbKiNU0L06XH4tpKyStriPPqBhKYlRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWLzb8ymI1XpiIC4jC60HepCFIyP9RRhpO3sH9SrIj0=;
 b=hZtufxtecwP9VWhq3rcA64x+cKslpXAPkm9EbtULrGBwEWwysFdUTuUrPhCMIuRLcpc7g4fzF4Nk8hg8k43dQB2CmVe5EhqbYfw7ukOccjbOPIMXGXES6Iq4YLK7TNCYFXuqXxa0tvV2k/3y2q94qw4QXzXD5XSAIx1S3Y3migw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OS3P286MB2246.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:199::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Tue, 27 Jun 2023 19:04:06 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d5aa:e14:adea:f392]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d5aa:e14:adea:f392%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 19:04:05 +0000
Date:   Wed, 28 Jun 2023 03:03:58 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Conor Dooley <conor@kernel.org>
Cc:     Evan Green <evan@rivosinc.com>, Samuel Ortiz <sameo@rivosinc.com>,
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
Message-ID: <ZJsyntnQ/FDXgNPk@Sun>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
 <20230627143747.1599218-2-sameo@rivosinc.com>
 <CALs-HssMkVikspnEi-Ek2t=ABvFvgptAhsBjk1+aLuVjiP7P7w@mail.gmail.com>
 <20230627-debating-twelve-da2c1ed60948@spud>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230627-debating-twelve-da2c1ed60948@spud>
X-Operating-System: Linux Sun 5.15.67 
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: SJ0PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::12) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB1393:EE_|OS3P286MB2246:EE_
X-MS-Office365-Filtering-Correlation-Id: 2715dfc8-1f63-427f-78f3-08db77414739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXL37YLASBR8+hwqk85DqmZ5ewl42TojaDi5sQ2q+9bDPRbI0E41r/3iRbXZZgK308v/dE3KAWXhEYGdMAHRRW2o/9CM0R1o392m4FP0FnuKeTkEF5jfNAXnPa8pFnaA5lks6p7rkParXh6GlrA0P8MZsgMvf3eWuNTYImYDkee0ewRkuvvNRDibfqSiaGwCC+bMa8Q3f3B7Oh8h5KfOjbMmbdCK3vt42TW6nquPlBIN8QcC6xUmY0RIZiLMq23NjZov7HdDhd2DzCR5wQ0v7cOcaQK7AxnJxoB5Qkte1TSegO7+c/V/OZr0Qde6Aq9qaki+NSVFIZir0Ks3Y/Nj8BgPiPAUZuuynNAfZ4q1Jvx/qhOEGvchorvjsoJ7JH/ooctowKpbABd29cF2f7nuW7NIhIkoKJgpBWCbpl1Q+hit+CP4TqQXPO6xjLPOdfQXuL4Q5pvCtQGDWgSextSWg/YneTWCTBq9xBBHwcm40YPX7YbptNiwUCC5L6ZRZqWqGY07kInzX5/AJp8O/KdrtoipSBy2Rd6uNuwf0NJHOMqEqoACtf0BYFIrkRVFN9lfwz9b/a7OnQOECPLGs9/mZEzgkdRlwpG0qUcOCTllzJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(39830400003)(136003)(366004)(376002)(451199021)(66556008)(66476007)(6506007)(966005)(6666004)(41320700001)(54906003)(478600001)(83380400001)(9686003)(186003)(53546011)(2906002)(6486002)(5660300002)(33716001)(7416002)(6916009)(66946007)(786003)(38100700002)(8676002)(86362001)(316002)(4326008)(41300700001)(8936002)(6512007)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vmdqc0wvc3p6WXkxeWFQWENuRDJ4aWJ2ZTEyeVFxRXJUZkFYMVZyQm5yR0hz?=
 =?utf-8?B?WVM5RHhvWG9XdlRrbzRLWkdWSHk5NlJnVnhxOVdXb1ZwZHJwb3VnRVVycldJ?=
 =?utf-8?B?OW8wd0lYc3Q4aTRXWG9sK1pJQVk4aWV3a1ExdVdPNjM4ZkxDZ2hWS25rQzR6?=
 =?utf-8?B?OWNqM0IrMHpKUlROSnhlQ1V3Mmkwd01Zc0pCWm9uU0hNY00vbHVEcFdyTklB?=
 =?utf-8?B?NzVQUWdKMkJxRWlsL2x2MnJMU1gvWlkxS3VvOEdidG01RkNRQWlmeVJLK2Vr?=
 =?utf-8?B?M1lXTkJ3d0RZWDl1MWhDWFFBWkdwcDFGUnpHem1KWjkrUFN2Vlp1TDU3S2JT?=
 =?utf-8?B?dEFPSVN5enp0US9IQWVwaXhmNkZKaC9pNDJrbFhJQ0YyWkdNWDJIWnlUNXBS?=
 =?utf-8?B?dEhjV2FlcHNFVFZPYmRCeEV0NjhrWU1Pd1ZRb0lqb1dEeTZxT0V2Zi91NnY1?=
 =?utf-8?B?SXJUK2o5amYyZ1FRZXM3RHRDMCtlWmFqTnRhOVp2WUZsMjhCRjFQbXk5QTMw?=
 =?utf-8?B?dXl3R3pwVDhxS2t1WEFKd2dwYkI4N0N0MTlJK2dCUENwWlZkWjZiQUNxeUNB?=
 =?utf-8?B?WThuWXZSTXlNTDIzQUpvcmVWSXgwZGUrV0U1b2drTURVMzBFYkFKemtuRVAy?=
 =?utf-8?B?ZTF0by94cUlnSk9FSGlOWW9QVGlxVEkrL0MwUEhINUtxNHJJb3VvT05peW9T?=
 =?utf-8?B?VTV5K0phMWdrVmx6VEFvTzF5ZnY5WlNzUk1xVmVPdEtXaUVIRGFySUdyL1FS?=
 =?utf-8?B?R2FEUDB2dmVpa3NsTlRyKzkyWHllZVZxUDlKWWtOeXlUY1o3cVRreXhoWTVC?=
 =?utf-8?B?Sy9tdWtWSEJoVFpOalcwTGZzK3AwS1h5UFRVNUtoc2xuZUVqWjhxaFhPSnZu?=
 =?utf-8?B?UVVkdS9BUG9JT2FkaWtuT3JFWFVGQkEwSHFtWWkwRUQxZ0dsRDF6Tm4xSm9W?=
 =?utf-8?B?ak9ENzVYbzM4bnUwaGpwKzkwbE9tYXc0VlpDSldLSTFUamNNdGpqV1I4WWdD?=
 =?utf-8?B?QVZnT2x6T2QzcEhBUzlQUEtOamtZWGh5dmkwM1JKam5COFpieGhzbjVtZ0M4?=
 =?utf-8?B?MGRGWUlEcUU0MTNidGZ3Qjh5YURyT0NjVCt1Z2NVcC9nWlZxbnVrOVBEcHlm?=
 =?utf-8?B?bFRsaEMrV05UdktNY1IvZlp4K0tSRm1xcCtVZFNneDBROVpNRE54bDZyb3kz?=
 =?utf-8?B?YU9qV2JRR25GM1dYY1hXT2VSd1BVQ1A5L0hRRUNUTXBndW5UdzArdHBaWUlE?=
 =?utf-8?B?ZXl3MVZpVlhPeitrRDkweUxReE1zRmZQNTdJbjRNNThQeEN6cVhYaHZRVHZI?=
 =?utf-8?B?cnJVVVdlaC9ZcHJXZ084dk5CSnVCd09oOU9ibkhtcWNJWDFaUVJ6MWRJbyt4?=
 =?utf-8?B?N3QyZ2ZZZDQ5KzRHM21rR2FPd0NqS3FMSitDTml3TGtKWTdYVk80NytieHZV?=
 =?utf-8?B?OUg4VC9RVUw1RXVXN2Z1bnBMSlMyL0Z6U1RQeFdqWGlaU1czbUxoVWxTc3cr?=
 =?utf-8?B?L3RZS2tVQ0VVS2JlbXI3M0ZvOU03WVVVbVdLU3FNYUV4b1lEcjRxb2VvVlFV?=
 =?utf-8?B?MUtPNWthY0JZZVUvSWx3QThYby9aazlNWklXV09FK2pWeW82M0o1aVNVVC9Q?=
 =?utf-8?B?ZWVKSVlSZE5JQmZlSEJuSEdoN3Vaam84WnIxODNqdXZYODZuVWFZZTZSSVhP?=
 =?utf-8?B?Qzl1MUpFdWVKMDRZZys4alJTeENpZ2VRN3o3allra2RDdnR4dHp3WittQS9Q?=
 =?utf-8?B?dFVKSDJ5U21RTjVybmY1eDA1bVE2Q2JoVHhweGIvOGpwbnU1VmRGa2Q3RWdt?=
 =?utf-8?B?Uy9QSW1kbUZLdDVCUEJXa3U0emJhMjE2dkp1SjlvRThpdmxOK2toZW5rSTAv?=
 =?utf-8?B?Tnh0U2c2cksrVk9kdFcvbnNYWnFoWWtlbldJYU1KVlJQL3k3MThxWXZxMGxG?=
 =?utf-8?B?WHVsTWlaQk1Db05FMi9tamZhbllTd0dWcWJ1S2xSY08yZllVaWw2UG1UMWdN?=
 =?utf-8?B?VGVhNmlUUTY3N1lYZVBORzFTd2U1azZFU05KOFYwdENOdXgxVWZEY0pkT01j?=
 =?utf-8?B?bTFRQmp3YkM4L254aEtpTTEzVEVjdEhMSHRKck1LRmg3bkloczlTVURhTnFP?=
 =?utf-8?Q?gPBf2L9q8RC/y7ueS+OVrBWHA?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 2715dfc8-1f63-427f-78f3-08db77414739
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 19:04:05.5375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVFFTgUqFyVpisNEzkCAyp2AkGdZ1+5E/X3Dl41inTCmx7zqOk5mX7l3BoULH+mL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2246
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 07:48:15PM +0100, Conor Dooley wrote:
> On Tue, Jun 27, 2023 at 11:14:30AM -0700, Evan Green wrote:
> > On Tue, Jun 27, 2023 at 7:38 AM Samuel Ortiz <sameo@rivosinc.com> wrote:
> > >
> > > From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
> > >
> > > This patch parses Zb/Zk related string from DT and
> 
> %s/This patch//
> 
> > > output them in cpuinfo
> > >
> > > One thing worth noting is that if DT provides zk,
> > > all zbkb, zbkc, zbkx and zkn, zkr, zkt would be enabled.
> 
> Please explain why this is okay.

From riscv scalar crypto spec, zk is a shorthand
for zkn, zkr and zkt and zkn also includes zbkb, zbkc
and zbkx.

> 
> > > Note that zk is a valid extension name and the current
> > > DT binding spec allows this.
> > >
> > > This patch also changes the logical id of
> > > existing multi-letter extensions and adds a statement
> > > that instead of logical id compatibility, the order
> > > is needed.
> 
> Does it?

That is in the old version of this patch,
should be removed now
see https://lore.kernel.org/linux-riscv/YqY0aSngjI0Hc5d4@Sun/

> 
> > > There currently lacks a mechanism to merge them when
> > > producing cpuinfo. Namely if you provide a riscv,isa
> > > "rv64imafdc_zk_zks", the cpuinfo output would be
> > > "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed
> > > _zksh_zkt"
> 
> I think this is fine.
> 
> Please re-wrap this all to 72 characters.
> 
> > >
> > > Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
> > > Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
> 
> This is missing your SoB Samuel.
> 
> > > ---
> > >  arch/riscv/include/asm/hwcap.h | 11 +++++++++++
> > >  arch/riscv/kernel/cpu.c        | 11 +++++++++++
> > >  arch/riscv/kernel/cpufeature.c | 30 ++++++++++++++++++++++++++++++
> > >  3 files changed, 52 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > > index f041bfa7f6a0..b80ca6e77088 100644
> > > --- a/arch/riscv/include/asm/hwcap.h
> > > +++ b/arch/riscv/include/asm/hwcap.h
> > > @@ -53,6 +53,17 @@
> > >  #define RISCV_ISA_EXT_ZICSR            40
> > >  #define RISCV_ISA_EXT_ZIFENCEI         41
> > >  #define RISCV_ISA_EXT_ZIHPM            42
> > > +#define RISCV_ISA_EXT_ZBC              43
> > > +#define RISCV_ISA_EXT_ZBKB             44
> > > +#define RISCV_ISA_EXT_ZBKC             45
> > > +#define RISCV_ISA_EXT_ZBKX             46
> > > +#define RISCV_ISA_EXT_ZKND             47
> > > +#define RISCV_ISA_EXT_ZKNE             48
> > > +#define RISCV_ISA_EXT_ZKNH             49
> > > +#define RISCV_ISA_EXT_ZKR              50
> > > +#define RISCV_ISA_EXT_ZKSED            51
> > > +#define RISCV_ISA_EXT_ZKSH             52
> > > +#define RISCV_ISA_EXT_ZKT              53
> > >
> > >  #define RISCV_ISA_EXT_MAX              64
> > >  #define RISCV_ISA_EXT_NAME_LEN_MAX     32
> > > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > > index a2fc952318e9..10524322a4c0 100644
> > > --- a/arch/riscv/kernel/cpu.c
> > > +++ b/arch/riscv/kernel/cpu.c
> > > @@ -215,7 +215,18 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
> > >         __RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> > >         __RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> > >         __RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> > > +       __RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> > > +       __RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
> > > +       __RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
> > > +       __RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
> > >         __RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> > > +       __RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
> > > +       __RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
> > > +       __RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
> > > +       __RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
> > > +       __RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> > > +       __RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
> > > +       __RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
> > >         __RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> > >         __RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> > >         __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > index bdcf460ea53d..447f853a5a4c 100644
> > > --- a/arch/riscv/kernel/cpufeature.c
> > > +++ b/arch/riscv/kernel/cpufeature.c
> > > @@ -309,10 +309,40 @@ void __init riscv_fill_hwcap(void)
> > >                                 SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
> > >                                 SET_ISA_EXT_MAP("zba", RISCV_ISA_EXT_ZBA);
> > >                                 SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB);
> > > +                               SET_ISA_EXT_MAP("zbc", RISCV_ISA_EXT_ZBC);
> > >                                 SET_ISA_EXT_MAP("zbs", RISCV_ISA_EXT_ZBS);
> > > +                               SET_ISA_EXT_MAP("zbkb", RISCV_ISA_EXT_ZBKB);
> 
> This order does not look correct, please add them in alphanumerical
> order as the comment these SET_ISA_EXT_MAP()s requests. Ditto below.

Agreed. Seems that I did not worked carefully for this part.

> 
> > > +                               SET_ISA_EXT_MAP("zbkc", RISCV_ISA_EXT_ZBKC);
> > > +                               SET_ISA_EXT_MAP("zbks", RISCV_ISA_EXT_ZBKX);
> > 
> > Should "zbks" be "zbkx"?
> > 
> > >                                 SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
> > >                                 SET_ISA_EXT_MAP("zicboz", RISCV_ISA_EXT_ZICBOZ);
> > >                                 SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
> > > +                               SET_ISA_EXT_MAP("zksed", RISCV_ISA_EXT_ZKSED);
> > > +                               SET_ISA_EXT_MAP("zksh", RISCV_ISA_EXT_ZKSH);
> > > +                               SET_ISA_EXT_MAP("zkr", RISCV_ISA_EXT_ZKR);
> > > +                               SET_ISA_EXT_MAP("zkt", RISCV_ISA_EXT_ZKT);
> > > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKB);
> > > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKC);
> > > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKX);
> > > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKND);
> > > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKNE);
> > > +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKNH);
> > > +                               SET_ISA_EXT_MAP("zknd", RISCV_ISA_EXT_ZKND);
> > > +                               SET_ISA_EXT_MAP("zkne", RISCV_ISA_EXT_ZKNE);
> > > +                               SET_ISA_EXT_MAP("zknh", RISCV_ISA_EXT_ZKNH);
> > > +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKB);
> > > +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKC);
> > > +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKX);
> > > +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZKSED);
> > > +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZKSH);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKB);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKC);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKX);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKND);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKNE);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKNH);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKR);
> > > +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKT);
> > 
> > It would be nice to consolidate the ones together that search for a
> > single string and set multiple bits, though I don't have any super
> > elegant ideas for how off the top of my head.
> 
> I've got a refactor of this code in progress, dropping all of these
> copy-paste in place of a loop. It certainly looks more elegant than
> this, but it will fall over a bit for these "one string matches many
> extensions" cases. See here:
> https://patchwork.kernel.org/project/linux-riscv/patch/20230626-thieving-jockstrap-d35d20b535c5@wendy/
> My immediate thought is to add another element to riscv_isa_ext_data,
> that contains "parent" extensions to check for. Should be fairly doable,
> I'll whip something up on top of that...
> 
> Cheers,
> Conor.


