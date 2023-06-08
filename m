Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2217289B5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjFHUyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjFHUyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:54:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEACE61
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 13:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0D8264DE0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 20:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194E9C433EF;
        Thu,  8 Jun 2023 20:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686257658;
        bh=vAnKS04ZmoUmFeza/8dLtBRjhrlKFqWp+Hv8NpitkpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SehzdQdaAIjt3P0NJ57xH/fUvGV2x1XyuaHVu/URqzGSOj8VGVw0osg/PQht8Qj4D
         IRiXeJTb8KeNL6x15SPbGMfBjY7iIrKNGpEBqVxa8LEs+J++BfEt3uvxrmng0RF2Z1
         TVwLcT1Z/tIAaOx4Pnf3fcwSGMo8fVBMyV4xMzaFIhH2/H9S3AziQTdWoTLh2nWwWS
         NcQcKcr00D+PDecBCgwj8bKFQ149SsQXffiJt1lEEn+xkj1sQLgoroiU/Uu1QHrVyN
         ZKDhnPbBuAqOqArxHGHs+yNu14Bwhs1e/dPoW3waZiQM2MHWSf8ltMF2TKvh0gDuaE
         UaKP7ircZtQ2g==
Date:   Thu, 8 Jun 2023 13:54:16 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] objtool: Improve rate-limiting for missing __noreturn
 warnings
Message-ID: <20230608205416.4mezxtxoqxwebdk5@treble>
References: <185b1a78b42776467929ce9e7851e4dbcd0b55d4.1686241345.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <185b1a78b42776467929ce9e7851e4dbcd0b55d4.1686241345.git.jpoimboe@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 09:23:32AM -0700, Josh Poimboeuf wrote:
> If a function with a lot of call sites is missing __noreturn, it could
> result in a lot of duplicate warnings (one for each call site).
> 
> Each call site's function is already rate-limited to one warning per
> function via WARN_INSN().  Do the same for the callee (the "missing
> __noreturn" function itself).
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/check.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 8936a05f0e5a..bb2ed34cb90e 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -4507,9 +4507,13 @@ static int validate_reachable_instructions(struct objtool_file *file)
>  		if (prev_insn && prev_insn->dead_end) {
>  			call_dest = insn_call_dest(prev_insn);
>  			if (call_dest && !ignore_noreturn_call(prev_insn)) {
> -				WARN_INSN(insn, "%s() is missing a __noreturn annotation",
> -					  call_dest->name);
> -				warnings++;
> +				if (!call_dest->warned) {
> +					WARN_INSN(insn, "%s() is missing a __noreturn annotation",
> +						  call_dest->name);
> +					warnings++;
> +					call_dest->warned = 1;
> +				}
> +

NAK - this spits out a bunch of unreachables, will need to tweak it a
bit.

-- 
Josh
