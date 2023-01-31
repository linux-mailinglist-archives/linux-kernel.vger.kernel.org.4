Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABC3682CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjAaMvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjAaMvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:51:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7E316321
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:51:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04DF0614DE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF1CC433EF;
        Tue, 31 Jan 2023 12:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675169495;
        bh=JxNQRX+QU5FxJ+pG19MtmDCcoMZNk1iYqK5l6r83z5k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PCisQxYq5GvV0wFoZ3cwFgIynkn5FKpuPsw+SRmm+NelGNF8kch1LhLBiLveaPCTv
         M6thttqPFnoDZa9yPxMKq7D16Hl8L3f7cq9ysu/20oCh4/b9y+jbLNAQijppMk/udo
         2BUQ/C1lzimFfRUGHO2PBSN31OUseRbpQa6gYL27mLqhIwybZtqE1NY9nDOO9Yx3lF
         0NQkceCWl/rIPem8LOCgi2yEPSP1NvlH1k8axmjq2e0qQsoUpWo+sXG4xeuVfnM8gW
         8VPuj6GzOZ+OpvtFF307LLf6jEl+LuabFr0lw8ttDwQF9cJSWDeudC1gkg/FbBW9zg
         5n30MQs5Uk4BQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com
Subject: Re: [PATCH v6 11/13] riscv/kprobe: Fix instruction simulation of JALR
In-Reply-To: <20230127130541.1250865-12-chenguokai17@mails.ucas.ac.cn>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
 <20230127130541.1250865-12-chenguokai17@mails.ucas.ac.cn>
Date:   Tue, 31 Jan 2023 13:51:32 +0100
Message-ID: <877cx26f57.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Guokai <chenguokai17@mails.ucas.ac.cn> writes:

> From: Liao Chang <liaochang1@huawei.com>
>
> Set kprobe at 'jalr 1140(ra)' of vfs_write results in the following
> crash:
>
> [   32.092235] Unable to handle kernel access to user memory without uacc=
ess routines at virtual address 00aaaaaad77b1170
> [   32.093115] Oops [#1]
> [   32.093251] Modules linked in:
> [   32.093626] CPU: 0 PID: 135 Comm: ftracetest Not tainted 6.2.0-rc2-000=
13-gb0aa5e5df0cb-dirty #16
> [   32.093985] Hardware name: riscv-virtio,qemu (DT)
> [   32.094280] epc : ksys_read+0x88/0xd6
> [   32.094855]  ra : ksys_read+0xc0/0xd6
> [   32.095016] epc : ffffffff801cda80 ra : ffffffff801cdab8 sp : ff200000=
00d7bdc0
> [   32.095227]  gp : ffffffff80f14000 tp : ff60000080f9cb40 t0 : ffffffff=
80f13e80
> [   32.095500]  t1 : ffffffff8000c29c t2 : ffffffff800dbc54 s0 : ff200000=
00d7be60
> [   32.095716]  s1 : 0000000000000000 a0 : ffffffff805a64ae a1 : ffffffff=
80a83708
> [   32.095921]  a2 : ffffffff80f160a0 a3 : 0000000000000000 a4 : f229b0af=
db165300
> [   32.096171]  a5 : f229b0afdb165300 a6 : ffffffff80eeebd0 a7 : 00000000=
000003ff
> [   32.096411]  s2 : ff6000007ff76800 s3 : fffffffffffffff7 s4 : 00aaaaaa=
d77b1170
> [   32.096638]  s5 : ffffffff80f160a0 s6 : ff6000007ff76800 s7 : 00000000=
00000030
> [   32.096865]  s8 : 00ffffffc3d97be0 s9 : 0000000000000007 s10: 00aaaaaa=
d77c9410
> [   32.097092]  s11: 0000000000000000 t3 : ffffffff80f13e48 t4 : ffffffff=
8000c29c
> [   32.097317]  t5 : ffffffff8000c29c t6 : ffffffff800dbc54
> [   32.097505] status: 0000000200000120 badaddr: 00aaaaaad77b1170 cause: =
000000000000000d
> [   32.098011] [<ffffffff801cdb72>] ksys_write+0x6c/0xd6
> [   32.098222] [<ffffffff801cdc06>] sys_write+0x2a/0x38
> [   32.098405] [<ffffffff80003c76>] ret_from_syscall+0x0/0x2
>
> Since the rs1 and rd might be the same one, such as 'jalr 1140(ra)',
> hence it requires obtaining the target address from rs1 followed by
> updating rd.
>
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Signed-off-by: Liao Chang <liaochang1@huawei.com>

This has already been picked up to riscv-fixes:
https://lore.kernel.org/linux-riscv/167462581691.3015.5045414056306333462.g=
it-patchwork-notify@kernel.org/

No need to have this patch in the series (and dito to
https://lore.kernel.org/linux-riscv/20230127130541.1250865-11-chenguokai17@=
mails.ucas.ac.cn/
that Guo submitted a fix for).


Bj=C3=B6rn
