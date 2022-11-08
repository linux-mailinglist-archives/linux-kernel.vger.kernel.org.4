Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C816621209
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiKHNMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiKHNMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:12:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAE21DDD7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 05:12:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CECE561568
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 13:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4FFC433C1;
        Tue,  8 Nov 2022 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667913137;
        bh=p3iKK8i/BkE9f32TxyOj+aZvkBrcSPGQ3okA10a8JP8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IeTEoNtt464NHNuxhiKEfZV77NHJAAtKfCtHe8KqtGJFVFpvEQ7Ob0b2H5VgVLy7n
         nMnfmwN/eeoguCvB0Zoc3Xjuo5vhaP5xitWrwI64RV36YwdQp/u8I2e9TLH5W+V0Jc
         mtmf8r8mvCwSnuu+1Aputs0GzWdUn2ajBwuex9TXqP+gGY5kRu6o8V2h2ZdOgh4h4A
         GaJd95OwRl2YXFsMzd59bHMcRUG99Y06RdWhgjO7ZNh2l7F26VzLNvEUipeCvDHiGI
         0nBD5hJWymVXGL5j2/26NkwySZnL+l1m5wWWsC98JQUmTxAWWRYUjcdHSDrO8rANPX
         Tljq0EPzoMZQQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     "liaochang (A)" <liaochang1@huawei.com>,
        Xim <chenguokai17@mails.ucas.ac.cn>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liao Chang <liaoclark@163.com>
Subject: Re: [PATCH v4 0/8] Add OPTPROBES feature on RISCV
In-Reply-To: <598bc40d-e826-f9cc-14fd-f4570051f4c6@huawei.com>
References: <20221106100316.2803176-1-chenguokai17@mails.ucas.ac.cn>
 <87y1sm1z8j.fsf@all.your.base.are.belong.to.us>
 <9A705974-A007-45E2-BC5D-A7E90821A258@mails.ucas.ac.cn>
 <598bc40d-e826-f9cc-14fd-f4570051f4c6@huawei.com>
Date:   Tue, 08 Nov 2022 14:12:14 +0100
Message-ID: <87bkphr3o1.fsf@all.your.base.are.belong.to.us>
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

>>>> +	*rd =3D ((kw | ow) =3D=3D 1UL) ? 0 : __builtin_ctzl((kw | ow) & ~1UL=
);
>>>> +	*ra =3D (kw =3D=3D 1UL) ? 0 : __builtin_ctzl(kw & ~1UL);
>>>
>>> Hmm, __builtin_ctzl is undefined for 0, right? Can that be triggered
>>> here?
>
> This corner case has been taken into account, look these condition parts,
> if kw =3D=3D 1UL this expression will return 0 directly, no chance to inv=
oke __builtin_ctzl.

Indeed! Thanks for making that clear! Looking forward to the next
revision!


Bj=C3=B6rn
