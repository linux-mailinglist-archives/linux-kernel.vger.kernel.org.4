Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CED7742822
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjF2OS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjF2OSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:18:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B0E358A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:18:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D81E61558
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF03C433C0;
        Thu, 29 Jun 2023 14:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688048301;
        bh=cBPe9u9KZDbd5csui0WGqBq35mFNRweRCSHEgHuupio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IeH88kCjF7clYHMc/gXG35iOIKXaXt9dNRMKWDcvWq67WplRlgpl5+mpSPrXG0Y3h
         MidfVBrgZF0qgjW7lZawaoy84q2UhhkOJdUBHIOy6wmF0B2V5r5gjM0PinG7Izkobw
         iI0eIMmSaSnV6fjQlCsyaP5e53WGy3xLwGr48SChdeyGZ4In/Km+WSogRkDshxiXKR
         qcPBnyPt8bZcYVPDQ4twWcltZSzY9+v9dw7l8fmpiPva05xAPu0upe4hUYneO3sq6z
         lSiFwuSXqsiX0u0cENpr09ZE2rKzauHxBU+M3JF7p2hUBzgA85Ll97Vmug0tSq14J7
         KCi6khFiRocpw==
Date:   Thu, 29 Jun 2023 07:18:19 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: initialize all of struct elf
Message-ID: <20230629141819.aopy23zi5wc6iqof@treble>
References: <20230629102051.42E8360467@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230629102051.42E8360467@lion.mk-sys.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 12:05:05PM +0200, Michal Kubecek wrote:
> Function elf_open_read() only zero initializes the initial part of
> allocated struct elf; num_relocs member was recently added outside the
> zeroed part so that it was left uninitialized, resulting in build failures
> on some systems.
> 
> The partial initialization is a relic of times when struct elf had large
> hash tables embedded. This is no longer the case so remove the trap and
> initialize the whole structure instead.
> 
> Fixes: eb0481bbc4ce ("objtool: Fix reloc_hash size")
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---
>  tools/objtool/elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index d420b5d2e2b6..081befa4674b 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -1005,7 +1005,7 @@ struct elf *elf_open_read(const char *name, int flags)
>  		perror("malloc");
>  		return NULL;
>  	}
> -	memset(elf, 0, offsetof(struct elf, sections));
> +	memset(elf, 0, sizeof(*elf));
>  
>  	INIT_LIST_HEAD(&elf->sections);

Thanks!

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
