Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3DB6CBA1E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjC1JHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1JHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:07:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4E159D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:07:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C46161FD6A;
        Tue, 28 Mar 2023 09:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679994464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QFXm9dUsvHxQ2fc/osJ+sXZSmg69/OPpP6gOT6zZ/VA=;
        b=Hgzv36HG6Bc4Nzw/1MHpESK8+4MnFtcfkXlhWFUrkS3URhOUT8hpoPDAR72Nnwu/va3WrI
        zKAcDkgGx9OUKuOu4VlqLjAibW8xnUr10KaJItdn7Y3ZZxggtd3WcFb/9QBcO/w7j0I/Q6
        CH/8LtD2DlQ+PgG7P14iN71t/blODzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679994464;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QFXm9dUsvHxQ2fc/osJ+sXZSmg69/OPpP6gOT6zZ/VA=;
        b=HfAF798M6MGL9xfyamkE0PONfwqgFOND2xUy3+e8Kh1oCibCxXTsdihjXfBlgfkE/3r+FD
        D2vulruLp30wa1Cg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8AEA82C141;
        Tue, 28 Mar 2023 09:07:44 +0000 (UTC)
Date:   Tue, 28 Mar 2023 11:07:44 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/5] objtool: Add per-function rate limiting for unreachable
 warnings
In-Reply-To: <b21f7791b30c54cf8c4d0f489decdc4a47a18963.1679932620.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2303281104010.14873@pobox.suse.cz>
References: <cover.1679932620.git.jpoimboe@kernel.org> <b21f7791b30c54cf8c4d0f489decdc4a47a18963.1679932620.git.jpoimboe@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023, Josh Poimboeuf wrote:

> Unreachable instruction warnings are rate limited to once per object
> file.  That no longer makes sense for vmlinux validation, which might
> have other unreachable instructions lurking in other places.  Change it
> to once per function.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/check.c               | 4 ++++
>  tools/objtool/include/objtool/elf.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 73dd091c0075..67a684225702 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -4557,6 +4557,10 @@ static int validate_reachable_instructions(struct objtool_file *file)
>  		if (insn->visited || ignore_unreachable_insn(file, insn))
>  			continue;
>  
> +		if (insn->sym->warned)
> +			continue;
> +		insn->sym->warned = 1;
> +

Ok

>  		WARN_FUNC("unreachable instruction", insn->sec, insn->offset);
>  		return 1;

But we still return here when an unreachable instruction is encountered 
and warned about. Or maybe I am just misunderstanding the purpose.

If not, would it be better to just collect the number of warnings per 
object as we do elsewhere?

  warnings++;

and then at the end

  return warnings;

Miroslav
