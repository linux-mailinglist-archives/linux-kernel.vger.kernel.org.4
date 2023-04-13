Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C12E6E0FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDMOTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDMOTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:19:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1382D43
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:19:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D64E61FD63;
        Thu, 13 Apr 2023 14:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681395550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zVZLnS1EpbXZplSa6VV3xfGtTLtoH3BSWk8A4KkMbCA=;
        b=YBhbY/3vFNXi8j8bU1pNbYOhFS8prEw9r4a+SZAsPY3dcbCSIkOfIqz3VNWZmJVdawjoJj
        PnlRM+blX4/efBHAtwHqSygLYYEjw2h8fxAEOfKs1Hu53XuF5QIkV8ZMxz1X58O+G/fGBw
        nSwoiyS6Uww9QZmlV/00ce/9dzLXKnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681395550;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zVZLnS1EpbXZplSa6VV3xfGtTLtoH3BSWk8A4KkMbCA=;
        b=6kT95XokIuxAoLmmRLAXb0rO/iGLYr+iDmPDYC1ER9a9dPMI/WJ+5jHmAbHQJpf3vEawLS
        JKoClyrxbYdSovCg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BAC302C143;
        Thu, 13 Apr 2023 14:19:10 +0000 (UTC)
Date:   Thu, 13 Apr 2023 16:19:10 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 8/9] objtool: Detect missing __noreturn annotations
In-Reply-To: <0f630a0eb4585ab4114e4eecaa6f166a1fd81d49.1681325924.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2304131613490.27633@pobox.suse.cz>
References: <cover.1681325924.git.jpoimboe@kernel.org> <0f630a0eb4585ab4114e4eecaa6f166a1fd81d49.1681325924.git.jpoimboe@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -4485,7 +4485,8 @@ static int validate_sls(struct objtool_file *file)
>  
>  static int validate_reachable_instructions(struct objtool_file *file)
>  {
> -	struct instruction *insn;
> +	struct instruction *insn, *prev_insn;
> +	struct symbol *call_dest;
>  	int warnings = 0;
>  
>  	if (file->ignore_unreachables)
> @@ -4495,6 +4496,17 @@ static int validate_reachable_instructions(struct objtool_file *file)
>  		if (insn->visited || ignore_unreachable_insn(file, insn))
>  			continue;
>  
> +		prev_insn = prev_insn_same_sec(file, insn);
> +		if (prev_insn && prev_insn->dead_end) {
> +			call_dest = insn_call_dest(prev_insn);
> +			if (call_dest) {
> +				WARN_INSN(insn, "%s() is missing a __noreturn annotation",
> +					  call_dest->name);
> +				warnings++;
> +				continue;

A nit but this and

> +			}
> +		}
> +
>  		WARN_INSN(insn, "unreachable instruction");
>  		warnings++;

this makes me thinking. Wouldn't it be confusing to anyone that there is 
no correspondence between warnings and a number of actual reported 
warnings through WARN_INSN()? In the future when there would be a usage 
for warnings. It does not really matter now.

Miroslav
