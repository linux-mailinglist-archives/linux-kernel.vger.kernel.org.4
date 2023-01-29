Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB6E6801C1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjA2Vns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjA2Vnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:43:46 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F341420D
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 13:43:45 -0800 (PST)
Date:   Sun, 29 Jan 2023 21:43:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675028622;
        bh=S/w7Cd8ZnH2/JT+ndz/P2lEfwmpwBVVa5brv/chn+SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oD5BP/nxsyTlf7vfb7NKQRq7ypb3/RVIHsgki1w6ajKkE4uCp8HJW33CU+BUB69a3
         NqyEbysMvyNeV7oRiMpzKDV1Ibpcu28LcMTjNZawsigIgvCZgrcrWPLlSa4C3iyeFe
         q+jVMclwKMV90d6XKR3bZ9ucMhB8n3ZfFJMF/iPo=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] objtool: reduce maximum memory usage
Message-ID: <20230129214339.76hyytrllggbvuat@t-8ch.de>
References: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221216-objtool-memory-v2-0-17968f85a464@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 04:00:57PM +0000, Thomas Weiﬂschuh wrote:
> The processing of vmlinux.o with objtool is the most memory-intensive step
> of a kernel build. By reducing the maximum memory usage here we can reduce
> the maximum memory usage of the whole kernel build.
> Therefore memory pressure on memory starved machines is relieved during
> kernel builds and the build is faster as less swapping has to occur.

Friendly ping.

These patches can also applied one by one, the only dependency is from
patch 5 to patch 4.

Thanks,
Thomas

> To: Josh Poimboeuf <jpoimboe@kernel.org>
> To: Peter Zijlstra <peterz@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> ---
> Changes in v2:
> - Warn on out of range values for reloc->type
> - Also reduce size of struct special_alt
> - Note: v1 did not make it to the lists, only to individual recipients
> 
> ---
> Thomas Weiﬂschuh (8):
>       objtool: make struct entries[] static and const
>       objtool: make struct check_options static
>       objtool: allocate multiple structures with calloc()
>       objtool: introduce function elf_reloc_set_type
>       objtool: reduce memory usage of struct reloc
>       objtool: optimize layout of struct symbol
>       objtool: optimize layout of struct special_alt
>       objtool: explicitly cleanup resources on success
> 
>  tools/objtool/builtin-check.c           |  4 ++-
>  tools/objtool/check.c                   |  6 ++--
>  tools/objtool/elf.c                     | 56 +++++++++++++++++++--------------
>  tools/objtool/include/objtool/builtin.h |  2 --
>  tools/objtool/include/objtool/elf.h     | 13 +++++---
>  tools/objtool/include/objtool/special.h |  2 +-
>  tools/objtool/special.c                 |  6 ++--
>  7 files changed, 51 insertions(+), 38 deletions(-)
> ---
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> change-id: 20221216-objtool-memory-06db3b8bf111
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
