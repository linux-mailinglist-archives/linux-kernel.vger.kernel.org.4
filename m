Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC3773E728
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjFZSEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjFZSES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:04:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF64E130
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:04:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50CD760F1B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 18:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CD7C433C8;
        Mon, 26 Jun 2023 18:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687802656;
        bh=WsiKkTM73mtAmQ00ugazGG4W0HkOJmDHHpGv9mYa+/E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AounBPoyrIYC8tj7GGEruylVt9XIaWqGJ/RxL5wRls1pWn/s/8is3nNnLf7ugNk6e
         NUReI1leY2p9+1wp2L1WcPq9dO7QpRIFKkoi2DDaxPIah1LWHp0Bie2/8Moc86g+pm
         CEdCgj1na0IsDDyuvc5ixeNqr/lnM0fNpPByNAKBotkFprb4HuKt2tus/jCJnakzNA
         A8ZzIHCVZqBxuESs/zX8uTXdSCwOGZvFyh1pP+sGol9EO+RGX6NBShA7Frp17/XEdi
         p6tDQvHcpUvwXIR9Kswn5YlJAPSBe/LdATxMZwVqYiQA7khrmHdczws9DWYs+xcWiq
         CWpCGJTzGJlqA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?utf-8?Q?R?= =?utf-8?Q?=C3=A9mi?= Denis-Courmont 
        <remi@remlab.net>, Darius Rad <darius@bluespec.com>,
        Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v2] riscv: Discard vector state on syscalls
In-Reply-To: <87y1k6m827.fsf@all.your.base.are.belong.to.us>
References: <20230626165736.65927-1-bjorn@kernel.org>
 <87y1k6m827.fsf@all.your.base.are.belong.to.us>
Date:   Mon, 26 Jun 2023 20:04:13 +0200
Message-ID: <87sfaem76q.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> The RISC-V vector specification states:
>>   Executing a system call causes all caller-saved vector registers
>>   (v0-v31, vl, vtype) and vstart to become unspecified.
>
> A bit of a corner case, but this will make sigreturn syscalls discard
> the vector state as well.
>
> Is that an issue? E.g. a user cannot build userspace context switching
> application. Does arm64 SVE handle sigreturn in a special way?

NVM; My bad. The vector state is cleared on *entry*, but then the
registers passed on signal stack is restored as usual.

Sorry for the noise! We're all good!
Bj=C3=B6rn
