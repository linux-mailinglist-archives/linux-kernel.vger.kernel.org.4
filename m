Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78D96FD7DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbjEJHJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbjEJHJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:09:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B3355B9;
        Wed, 10 May 2023 00:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A0D362D6E;
        Wed, 10 May 2023 07:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D514C433D2;
        Wed, 10 May 2023 07:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683702553;
        bh=+clB4KgowCdBV0mrjLZYn4tmrVpCL43g49dGwUiETu4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NHPuozW3dvsESE/msZt0irjjsu/dRADQ1xYQSJhylIncQnOybYMKXulAUagHRx9Ji
         ET5SSGdHhQYzxHr8YrjVSMzEoqIcOhLalVoNaz2SOf8FJ0IntrSZTwdQ7s/rJwMlw1
         jngEZWbe9zJAbezg/bFvX6IJAmIUC+J4iJI6CRHWBRI4Oci7P6Mo9MFniuIMsxcERZ
         tC9Kd4HZwZ/Yi3+VfdCKq6qJjelMpjrIc4uENdoX7XJHeuRgHU7y+InHSkuJnTnyOQ
         4JUyZvgfcq8Rv7BGR1emIpGw1xT0tYi3Q2K+1RF/D88jnO/5cZq2Gh/ePugcJ2n8u8
         gCc5Er1UP6EMQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Song Shuai <suagrfillet@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, guoren@kernel.org,
        e.shatokhin@yadro.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Song Shuai <suagrfillet@gmail.com>
Subject: Re: [PATCH V8 1/4] riscv: select
 FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
In-Reply-To: <20230324033342.3177979-2-suagrfillet@gmail.com>
References: <20230324033342.3177979-1-suagrfillet@gmail.com>
 <20230324033342.3177979-2-suagrfillet@gmail.com>
Date:   Wed, 10 May 2023 09:09:10 +0200
Message-ID: <87a5ycfysp.fsf@all.your.base.are.belong.to.us>
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

Song Shuai <suagrfillet@gmail.com> writes:

> In RISC-V, -fpatchable-function-entry option is used to support
> dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
> PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
> don't have to be called to create the __mcount_loc section before
> the vmlinux linking.
>
> Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
> Makefile not to run recordmcount.
>
> Link: https://lore.kernel.org/linux-riscv/CAAYs2=3Dj3Eak9vU6xbAw0zPuoh00r=
h8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
> Link: https://lore.kernel.org/linux-riscv/Y4jtfrJt+%2FQ5nMOz@spud/
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> Tested-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
