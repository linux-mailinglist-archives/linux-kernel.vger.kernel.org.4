Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19F365E2A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 02:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjAEBqP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Jan 2023 20:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjAEBqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 20:46:12 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D846363
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 17:46:10 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3ED0124E0FC;
        Thu,  5 Jan 2023 09:45:58 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 5 Jan
 2023 09:45:58 +0800
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 5 Jan
 2023 09:45:57 +0800
Received: from EXMBX161.cuchost.com ([fe80::f152:b9a3:2243:db3c]) by
 EXMBX161.cuchost.com ([fe80::f152:b9a3:2243:db3c%15]) with mapi id
 15.00.1497.044; Thu, 5 Jan 2023 09:45:57 +0800
From:   Leyfoon Tan <leyfoon.tan@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>
Subject: RE: [PATCH] riscv: Move call to init_cpu_topology() to later
 initialization stage
Thread-Topic: [PATCH] riscv: Move call to init_cpu_topology() to later
 initialization stage
Thread-Index: AQHZIDyGA1ZpH2MfF0y2uzSNVn9yRK6PDhHQ
Date:   Thu, 5 Jan 2023 01:45:57 +0000
Message-ID: <bfd9b5ad438d43c5b44efe5c2ebf5d2e@EXMBX161.cuchost.com>
References: <20230103035316.3841303-1-leyfoon.tan@starfivetech.com>
 <Y7V4byskevAWKM3G@spud>
In-Reply-To: <Y7V4byskevAWKM3G@spud>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
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



> On Tue, Jan 03, 2023 at 11:53:16AM +0800, Ley Foon Tan wrote:
> > topology_parse_cpu_capacity() is failed to allocate memory with
> > kcalloc() after read "capacity-dmips-mhz" DT parameter in CPU DT
> > nodes. This
> > topology_parse_cpu_capacity() is called from init_cpu_topology(), move
> > call to init_cpu_topology() to later initialization  stage (after
> > memory allocation is available).
> >
> > Note, this refers to ARM64 implementation, call init_cpu_topology() in
> > smp_prepare_cpus().
> >
> > Tested on Qemu platform.
> 
> I'd like to suggest a change to the commit message:
> ```
> If "capacity-dmips-mhz" is present in a CPU DT node,
> topology_parse_cpu_capacity() will fail to allocate memory.
> arm64, with which this code path is shared, does not call
> topology_parse_cpu_capacity() until later in boot where memory allocation
> is available.
> While "capacity-dmips-mhz" is not yet a valid property on RISC-V, invalid
> properties should be ignored rather than cause issues.
> Move init_cpu_topology(), which calls topology_parse_cpu_capacity(), to a
> later initialization stage, to match arm64.
> 
> As a side effect of this change, RISC-V is "protected" from changes to core
> topology code that would work on arm64 where memory allocation is safe
> but on RISC-V isn't.
> ```
> 
> You don't need to use exactly that, but with something along those
> lines:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Thanks,
> Conor.
Hi Conor

Thanks for your suggestions. Will send the v2 and update the commit message.

Regards
Ley Foon
