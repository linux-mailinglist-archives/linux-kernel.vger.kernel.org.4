Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A14E73E3D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjFZPrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjFZPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA93F12C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 705AE60EDD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597B4C433C0;
        Mon, 26 Jun 2023 15:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687794420;
        bh=Q60Kt5vlLtP8NFJ/7bDseV+2BBSppFzAzKnhgFt9Has=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nJYpTvPowv2grZcTH4v+Ljy1s52QpDQy2kgsioY81I9mMXSjRYFgq1B8KFPIjAYhm
         OvJcY+Q/9H8De5I/om0K+nUkh6J81V3JbNhJnD0aj1TjQjgD+tKwgTq/Z41Rh4J3WI
         Dt7S7GnJzpKELkmKmpXFRaS/VwFw5xygR8N0+0KFXtl5wSlOgReWRTcLAsMDU6sPWh
         7QFEYDjvlK1bX0yYzlzaBRzgxY/PPMI271wTJawZ2kASTzdQ6ikQ8vht/spYKv7rez
         RwJ5OL4Ji7bjOo4xsFTEnrkMI1tFgUuvOG8ylAHm5ZE0SJqclD9LLty7NS1uu8fK8E
         cp62z+Nvkw8jw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Vineet Gupta <vineetg@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux@rivosinc.com,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?utf-8?Q?R?= =?utf-8?Q?=C3=A9mi?= Denis-Courmont 
        <remi@remlab.net>, Darius Rad <darius@bluespec.com>,
        Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH] riscv: Discard vector state on syscalls
In-Reply-To: <b990638b-a86a-ee43-f8b1-18a0a0651ad0@rivosinc.com>
References: <20230622173613.30722-1-bjorn@kernel.org>
 <b990638b-a86a-ee43-f8b1-18a0a0651ad0@rivosinc.com>
Date:   Mon, 26 Jun 2023 17:46:57 +0200
Message-ID: <874jmuns3y.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vineet Gupta <vineetg@rivosinc.com> writes:

> On 6/22/23 10:36, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>
>> The RISC-V vector specification states:
>>    Executing a system call causes all caller-saved vector registers
>>    (v0-v31, vl, vtype) and vstart to become unspecified.
>
> So the only use case of saving/restoring V regs in __switch_to is an=20
> interrupt induced task switch ?

Yes!
