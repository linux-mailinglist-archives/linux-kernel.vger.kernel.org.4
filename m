Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625F86FFAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbjEKToJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239333AbjEKTns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:43:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBBDE72B;
        Thu, 11 May 2023 12:43:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 008C26515C;
        Thu, 11 May 2023 19:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D80C433EF;
        Thu, 11 May 2023 19:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683834126;
        bh=QpVinai7JL1pP3rlbbUdOOyw1HmQ+Nd16p9jSiVEw10=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bwcXVRwxBue8gU9VyMRjLJ8rs6LCJhDK0kQ2Ju9IpqIOHGLQVIJ3J05dZPj8j7w9a
         buxnKBKltkT8RTR5qxgDcACuogbG2AtMvMDBIhjzI6ofeDtRYEN3m0xR19e8hu3D1P
         rxaD66Wmlvz9lZojNlRbBIyDdzL+vA7uNZWUH+XcFxT53luDEqvnDIqUgGVsFa4/N0
         bjN8PKO8K3VBsJjtRI7gZ/+urSSHoPMS0dNjWPkBmqV7ZbDO69Tdz5OXBg9VL0/eua
         NsF6cwVfOb1g/A6ZgmzWJo/RIcE/RsB7LQSX5qe4FV3NU/inG9qNGhBFXvrTOeqHAR
         ltCoUnfR6sPqA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Song Shuai <suagrfillet@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, guoren@kernel.org,
        suagrfillet@gmail.com, jszhang@kernel.org, e.shatokhin@yadro.com,
        bjorn@rivosinc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH V10 3/4] riscv: ftrace: Add
 DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
In-Reply-To: <20230511093234.3123181-4-suagrfillet@gmail.com>
References: <20230511093234.3123181-1-suagrfillet@gmail.com>
 <20230511093234.3123181-4-suagrfillet@gmail.com>
Date:   Thu, 11 May 2023 21:42:03 +0200
Message-ID: <87zg6ad59w.fsf@all.your.base.are.belong.to.us>
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

> This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
>
> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
> register_ftrace_direct[_multi] interfaces allowing users to register
> the customed trampoline (direct_caller) as the mcount for one or
> more target functions. And modify_ftrace_direct[_multi] are also
> provided for modifying direct_caller.
>
> To make the direct_caller and the other ftrace hooks (eg. function/fgraph
> tracer, k[ret]probes) co-exist, a temporary register is nominated to
> store the address of direct_caller in ftrace_regs_caller. After the
> setting of the address direct_caller by direct_ops->func and the
> RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
> by the `jr` inst.
>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> Tested-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>

Thank you for addressing my comments, and for your work on
WITH_DIRECT_CALLS!

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
