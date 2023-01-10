Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC146637CC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 04:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjAJDQu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Jan 2023 22:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjAJDQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:16:47 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E0311159
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:16:45 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id BED8424DCA6;
        Tue, 10 Jan 2023 11:16:37 +0800 (CST)
Received: from EXMBX063.cuchost.com (172.16.7.63) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan
 2023 11:16:37 +0800
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX063.cuchost.com
 (172.16.6.63) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan
 2023 11:16:37 +0800
Received: from EXMBX161.cuchost.com ([fe80::f152:b9a3:2243:db3c]) by
 EXMBX161.cuchost.com ([fe80::f152:b9a3:2243:db3c%15]) with mapi id
 15.00.1497.044; Tue, 10 Jan 2023 11:16:37 +0800
From:   Leyfoon Tan <leyfoon.tan@starfivetech.com>
To:     Andrew Jones <ajones@ventanamicro.com>,
        JeeHeng Sia <jeeheng.sia@starfivetech.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH v2 3/3] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Topic: [PATCH v2 3/3] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Index: AQHZI/MH55+1R+tLE0CpUrjhzVBfuq6V9U4AgAEFXdA=
Date:   Tue, 10 Jan 2023 03:16:37 +0000
Message-ID: <964def29d1e146fc8ac17ab2fe813425@EXMBX161.cuchost.com>
References: <20230109062407.3235-1-jeeheng.sia@starfivetech.com>
 <20230109062407.3235-4-jeeheng.sia@starfivetech.com>
 <20230109193624.iiuguwgimpn7zbyw@orel>
In-Reply-To: <20230109193624.iiuguwgimpn7zbyw@orel>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [60.49.44.179]
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

[...]
> 
> > +{
> > +	hibernate_cpu_context = kcalloc(1, sizeof(struct suspend_context),
> GFP_KERNEL);
> > +
> > +	if (WARN_ON(!hibernate_cpu_context))
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +
> > +early_initcall(riscv_hibernate__init);
> > --
> > 2.34.1
> >
> >
> 
> Besides some nits and a couple questions, this looks to me. I'll try to
> find some time to experiment with it as well.
FYI, you need use the latest OpenSBI tree. We also submitted these 2 patches below to fix the boot hartid. Resume from hibernation needs to be same hartid.


https://github.com/riscv-software-src/opensbi/commit/cb7e7c3325e68a9b4d5ea210b97cac693cf5814f
https://github.com/riscv-software-src/opensbi/commit/8020df8733b060f01e35b0b2bcb2b41e6b992e9b
