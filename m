Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EC66639A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjAJHAv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Jan 2023 02:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjAJHAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:00:43 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941BE39F9F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:00:40 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1A6B724E235;
        Tue, 10 Jan 2023 15:00:39 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan
 2023 15:00:39 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan
 2023 15:00:38 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 10 Jan 2023 15:00:38 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH v2 3/3] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Topic: [PATCH v2 3/3] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Index: AQHZI/MH11WdbApPuUeV8qMdKhtSOK6V9U4AgAACswCAAT6ZMA==
Date:   Tue, 10 Jan 2023 07:00:38 +0000
Message-ID: <d03e4bf7832f48d7aabd07dfd13a3e92@EXMBX066.cuchost.com>
References: <20230109062407.3235-1-jeeheng.sia@starfivetech.com>
 <20230109062407.3235-4-jeeheng.sia@starfivetech.com>
 <20230109193624.iiuguwgimpn7zbyw@orel> <Y7xu/Oj07F7/e8F1@spud>
In-Reply-To: <Y7xu/Oj07F7/e8F1@spud>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [60.49.128.133]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Tuesday, 10 January, 2023 3:46 AM
> To: Andrew Jones <ajones@ventanamicro.com>
> Cc: JeeHeng Sia <jeeheng.sia@starfivetech.com>; paul.walmsley@sifive.com;
> palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Leyfoon Tan
> <leyfoon.tan@starfivetech.com>; Mason Huo
> <mason.huo@starfivetech.com>
> Subject: Re: [PATCH v2 3/3] RISC-V: Add arch functions to support
> hibernation/suspend-to-disk
> 
> On Mon, Jan 09, 2023 at 08:36:24PM +0100, Andrew Jones wrote:
> > On Mon, Jan 09, 2023 at 02:24:07PM +0800, Sia Jee Heng wrote:
> 
> > > To enable hibernation/suspend to disk into RISCV, the below config
> > > need to be enabled:
> > > - CONFIG_ARCH_HIBERNATION_HEADER
> > > - CONFIG_ARCH_HIBERNATION_POSSIBLE
> > > - CONFIG_ARCH_RV64I
> > > - CONFIG_64BIT
> 
> > What's blocking this for being for both 32-bit and 64-bit?
> 
> Just from checking with b4 diff, it's because I told them they broke the
> rv32 build with their v1 implementation.
> 
> I'd rather they fixed whatever the issue was with rv32 than ignored it.
The main reason is because I don't have a rv32 system to verify the rv32 hibernation. I can submit another patch to support rv32 hibernation once I have the system or someone who has the rv32 system can submit the patch ontop. 
> 
> Thanks,
> Conor.

