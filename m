Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB76C65CEDC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjADI5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjADI5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:57:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2210A1B9FD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:57:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1E1CB815C6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E23BC433D2;
        Wed,  4 Jan 2023 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672822634;
        bh=Jj05/IYvXvNdjB6MaDfn5BYk3BLXM/xtTSHhm5j1AwI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sQzmBVGlMhrznPIyI4B6Vc7l39vqBTGjiKCIrR35BQwIkdj4ThgtFuZm60wjH8RBB
         G5ErEA+tbKHLNBwj9itnNJ0DcAbOs/rbVvC5XH3FFsny0RcI8Flrkva3Mz7KlHnFcw
         F0Ytqx07xsT3gmi/pxV2ZhR2m1ZqvNSuctA1l1UXrb5a4MFoSjDHLe8a5NwErX8QKF
         fTVWFOhd6bnEc/elT6Ymsmb7V4isRJepIjG+IaBPkolMyfFq8wm9LslcgtjYR+f3kE
         LIfEXlTFl2Q0H3peefHIQ/oWcOZSRj4RXzWXS6Mx10pIZ2v44n3nUskQhxVJvMqu0X
         /0OzXo0bZq6uw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     "liaochang (A)" <liaochang1@huawei.com>,
        Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/9] riscv/kprobe: Add common RVI and RVC instruction
 decoder code
In-Reply-To: <ab66152d-0ae1-3edb-4f1d-01ab49edc25d@huawei.com>
References: <20221224114315.850130-1-chenguokai17@mails.ucas.ac.cn>
 <20221224114315.850130-5-chenguokai17@mails.ucas.ac.cn>
 <87tu18vmnx.fsf@all.your.base.are.belong.to.us>
 <ab66152d-0ae1-3edb-4f1d-01ab49edc25d@huawei.com>
Date:   Wed, 04 Jan 2023 09:57:11 +0100
Message-ID: <871qoasmmw.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"liaochang (A)" <liaochang1@huawei.com> writes:

>> Shouldn't the mask be 0xf003?
>
> Actually, the mask should be 0xf003 indeedly, but it also bring another p=
roblem that
> it can't tell C.MV and C.JR via the mask and value parts. Look opcodes be=
low:
>
>       15 14 13 12 | 11 10  9  8 | 7 6 5 4 | 3 2  1 0
> C.JR:  1  0  0  0 |             rs1           0  1 0
> C.MV:  1  0  0  0 |              rd         rs2  1 0
>
> The only differece between C.MV and C.JR is the bits[2~6], these bitfield=
 of C.JR is zero,
> the ones of C.MV is rs2 which never be zero. In order to tell C.MV and C.=
JR correclty, it
> is better to adjust the mask of C.JR to be 0xf07f as your patch(riscv, kp=
robe: Stricter c.jr/c.jalr decoding)
>
> Looking forward to your feedback.

Yup, that was the reason I submitted the fix! Let's wait for the fix to
be applied, and not include that fix in your feature series.


Bj=C3=B6rn
