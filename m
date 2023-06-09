Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7EB729B08
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjFINGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjFINGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:06:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B0D30CB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:06:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qd1YJ2s0Tz4x3x;
        Fri,  9 Jun 2023 23:06:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1686315972;
        bh=ZwdtArgZhBZiJXxJG3SFap/Lyw4wRqeEqOCi/Ko2N+o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YeKUQ/BdMwGKCIH52MSQgeU3oixBIPV7DZy10o0jJ53/1rG/1MRuBgwM1Z44S+xBL
         Hpny86yM/+VKCjyhjRtoCvCN8XbKkh4woU+s1GrHJbVm8RNh9vmGFJVQUGSHVN6FkD
         TuV8uf5I5iZw/9dayZcbBc+d8P86iJ/Hlv5NAHgNYjjNBDbOeFBXvqEcr7JFmbtLmE
         uoGd0EkNuEf2kOJUlRKs5TA4N2LVvhf1W4rzSeLlFgC/fjRj/mBe8EApzxq/0KeHwo
         KGbJ5GvV3gFTf/74JWgMdw/C52Ke48rmrygu4J53JliPgsiEULWPDkvSgQ3nxg+up3
         sruFt3Z+AzBqg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/signal32: Force inlining of
 __unsafe_save_user_regs() and save_tm_user_regs_unsafe()
In-Reply-To: <CT5FZBY14ZM4.OYXBJNXQU9A2@wheely>
References: <7e469c8f01860a69c1ada3ca6a5e2aa65f0f74b2.1685955220.git.christophe.leroy@csgroup.eu>
 <CT5FZBY14ZM4.OYXBJNXQU9A2@wheely>
Date:   Fri, 09 Jun 2023 23:06:11 +1000
Message-ID: <874jnghjjw.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Nicholas Piggin" <npiggin@gmail.com> writes:
> On Mon Jun 5, 2023 at 6:58 PM AEST, Christophe Leroy wrote:
>> Looking at generated code for handle_signal32() shows calls to a
>> function called __unsafe_save_user_regs.constprop.0 while user access
>> is open.
>>
>> And that __unsafe_save_user_regs.constprop.0 function has two nops at
>> the begining, allowing it to be traced, which is unexpected during
>> user access open window.
>>
>> The solution could be to mark __unsafe_save_user_regs() no trace, but
>> to be on the safe side the most efficient is to flag it __always_inline
>> as already done for function __unsafe_restore_general_regs(). The
>> function is relatively small and only called twice, so the size
>> increase will remain in the noise.
>>
>> Do the same with save_tm_user_regs_unsafe() as it may suffer the
>> same issue.
>
> Could you put a comment so someone doesn't uninline it later?

I think the "unsafe" in the name is probably sufficient to warn people
off, but you never know. Still I'd happily take a patch to add comments :)

> Marking it notrace as well would be sufficient for a comment, if that works.

I nearly did that when applying, but I'm not sure it won't change the
code generation, so I left it as-is.

cheers
