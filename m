Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFB173E6C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjFZRpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjFZRp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:45:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69AC10EF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DFA260F11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 17:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AFAC433C0;
        Mon, 26 Jun 2023 17:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687801523;
        bh=+kUmBnlJJH57De2VxGhsUAjHC+GxcuB0Jy6ACQhtu1I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lVnF0ewmjn07l1/Loc4mw3nbnex0dnqjCAH6ay9NGIeCFqI6eAEQcQT0yqwvvpb5d
         74Qj97QphTcXEAmP1zsB1si8XaFTYH6PcFX55gJmXBAV6U5NewvZJaSJ17hmncmbYN
         27ztGL82x54Q8aqOLtzaGJrSC+tNLLsawHmwEHgAmPmwlHuRf30mRtGMh4KH1GXyhE
         czy9Jo1ffJYjy97NKWlT5Kq98q0awO/sgGdDsBLcJwwtgiIuY/OqW5mD/0VffGy63q
         D02/IQGnFHxLBBTLhDqc+ZpfhSZuw8iz4WUJUAjmEY/oWJnmT025q5ZCl4qF7tkIhc
         /na2/2kWtYuDg==
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
In-Reply-To: <20230626165736.65927-1-bjorn@kernel.org>
References: <20230626165736.65927-1-bjorn@kernel.org>
Date:   Mon, 26 Jun 2023 19:45:20 +0200
Message-ID: <87y1k6m827.fsf@all.your.base.are.belong.to.us>
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

> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> The RISC-V vector specification states:
>   Executing a system call causes all caller-saved vector registers
>   (v0-v31, vl, vtype) and vstart to become unspecified.

A bit of a corner case, but this will make sigreturn syscalls discard
the vector state as well.

Is that an issue? E.g. a user cannot build userspace context switching
application. Does arm64 SVE handle sigreturn in a special way?


Bj=C3=B6rn
