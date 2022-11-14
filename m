Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB446283CF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiKNPZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:25:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EFC1A22E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:25:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B5166123C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 15:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B57C433D6;
        Mon, 14 Nov 2022 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668439553;
        bh=GZIeodh/tKHzRw2Ib47HyuuEsEyl1mclfUnUp+6XOS4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=V+kyaMbou7xF+5gq6vmScT40d3HqUhdgg84H871WsQ03EnASOqmsZkqAK1nmpCw1p
         OGjt5tAo7E9cQFakoqXmHS6zvo34YdYwQeFAR/672DJP2miPxep1YoG5827M4/6Mhc
         CocoZltQ+KvESRI8sUqCMnr7eCrZaA+WAEzkwCjQ6auu4h81XDoHpQkvWTVJIiVuED
         7mDX7t4PaaKtYEgMA7SBjFkHn6T3N2ZH+cwiK4FxkaRbprEmtHyyEYHe5zdgmB2Y4J
         DEsCHDAMaoIPjg5PHZpGY+dnjP3ptSY62mebT7gfvd7xqCgnGB7cHEYBpReyTIgVdm
         1lhRewu4yuveA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: mm: Proper page permissions after initmem free
In-Reply-To: <b82f4580-76a0-e02b-05c8-4a89e576da0c@ghiti.fr>
References: <20221112113543.3165646-1-bjorn@kernel.org>
 <b82f4580-76a0-e02b-05c8-4a89e576da0c@ghiti.fr>
Date:   Mon, 14 Nov 2022 16:25:49 +0100
Message-ID: <871qq5tv5u.fsf@all.your.base.are.belong.to.us>
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

Alexandre Ghiti <alex@ghiti.fr> writes:

>> +		set_kernel_memory(__init_begin, __init_end, set_memory_rw_nx);
>
>
> That's nits but for 64-bit kernels, do we really want to make the kernel=
=20
> mapping writable? I think catching a write access here would be better=20
> because IMO that should not happen.

Thanks for having a look!

Hmm, so what you're suggesting is a "set_memory_r_nx" for CONFIG_64BIT?
What do other archs do? Is it worth the extra ifdef clutter?


Bj=C3=B6rn
