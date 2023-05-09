Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33836FBD17
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjEICXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjEICXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:23:05 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05DCE35A5
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=S5IyO
        NWTmO0xvL6UmZk6zW+EVi1q52PaUMUXaKqlOvw=; b=fLsTQQa2Z3gGdW+wNMqdO
        XNWRVEWW1vu0BREP5sUwYT9sS9ztcM45mOOnJ0pKp+rGKHcUks4J4vOQwwaGKAQW
        QBSDUJHsnpNZ6zm5h3eO8BhtKEPRke4+uMDx/4wkyMwZnMgYFNnTwdgtl8QM79Qi
        9F7kT89guxPysfdsLz3ptI=
Received: from zhangf-virtual-machine.localdomain (unknown [180.111.102.183])
        by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wBXf4dSrllkqHhsBQ--.30265S4;
        Tue, 09 May 2023 10:22:15 +0800 (CST)
From:   zhangfei <zhang_fei_0403@163.com>
To:     ajones@ventanamicro.com
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zhangfei@nj.iscas.ac.cn
Subject: Re: Re: [PATCH] riscv: Optimize memset 
Date:   Tue,  9 May 2023 10:22:07 +0800
Message-Id: <20230509022207.3700-3-zhang_fei_0403@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230509022207.3700-1-zhang_fei_0403@163.com>
References: <20230505-9ec599a36801972451e8b17f@orel>
 <20230509022207.3700-1-zhang_fei_0403@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXf4dSrllkqHhsBQ--.30265S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4xAFykJw1fJry5CF1rWFg_yoW8ZrWDpr
        yfKrnxKrn0qrZ2y3WxJa1DKrn0qw1rtr47Jayrta48Crn8Ca17Zw4fCa4FgFyxJrW8Arn5
        Xw1avw1xZF98C37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9_-PUUUUU=
X-Originating-IP: [180.111.102.183]
X-CM-SenderInfo: x2kd0w5bihxsiquqjqqrwthudrp/1tbiWxZql2I0Z8wmqwABsB
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangfei <zhangfei@nj.iscas.ac.cn>

> >  5:
> > -	sb a1, 0(t0)
> > -	addi t0, t0, 1
> > -	bltu t0, a3, 5b
> > +        sb a1, 0(t0)
> > +        sb a1, -1(a3)
> > +        li a4, 2
> > +        bgeu a4, a2, 6f
> > +
> > +        sb a1, 1(t0)
> > +        sb a1, 2(t0)
> > +        sb a1, -2(a3)
> > +        sb a1, -3(a3)
> > +        li a4, 6
> > +        bgeu a4, a2, 6f
> > +
> > +        sb a1, 3(t0)
> > +        sb a1, -4(a3)
> > +        li a4, 8
> > +        bgeu a4, a2, 6f
> 
> Why is this check here?

Hi,

I filled head and tail with minimal branching. Each conditional ensures that 
all the subsequently used offsets are well-defined and in the dest region.

Although this approach may result in redundant storage, compared to byte by 
byte storage, it allows storage instructions to be executed in parallel and 
reduces the number of jumps.

I used the code linked below for performance testing and commented on the memset 
that calls the arm architecture in the code to ensure it runs properly on the 
risc-v platform.

[1] https://github.com/ARM-software/optimized-routines/blob/master/string/bench/memset.c#L53

The testing platform selected RISC-V SiFive U74.The test data is as follows:

Before optimization
---------------------
Random memset (bytes/ns):
           memset_call 32K:0.45 64K:0.35 128K:0.30 256K:0.28 512K:0.27 1024K:0.25 avg 0.30

Medium memset (bytes/ns):
           memset_call 8B:0.18 16B:0.48 32B:0.91 64B:1.63 128B:2.71 256B:4.40 512B:5.67
Large memset (bytes/ns):
           memset_call 1K:6.62 2K:7.02 4K:7.46 8K:7.70 16K:7.82 32K:7.63 64K:1.40

After optimization
---------------------
Random memset bytes/ns):
           memset_call 32K:0.46 64K:0.35 128K:0.30 256K:0.28 512K:0.27 1024K:0.25 avg 0.31
Medium memset (bytes/ns )
           memset_call 8B:0.27 16B:0.48 32B:0.91 64B:1.64 128B:2.71 256B:4.40 512B:5.67
Large memset (bytes/ns):
           memset_call 1K:6.62 2K:7.02 4K:7.47 8K:7.71 16K:7.83 32K:7.63 64K:1.40

From the results, it can be seen that memset has significantly improved its performance with 
a data volume of around 8B, from 0.18 bytes/ns to 0.27 bytes/ns.

Thanks,
Fei Zhang

