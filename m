Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC596E112D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDMPcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDMPcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AAA106
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:32:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1186F60ACB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5BCC433D2;
        Thu, 13 Apr 2023 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681399963;
        bh=jvDJT0KYQoI4eIX6amiF0FcIWVm6lzaDbd1cH+1uAfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GeH7JhYVErt/5e1JvrmaC1z4t1vHFASQhZfV/VNm2IbyXl/CcFhmErtYhzbzZ54SM
         CBcrqY35tdtma8IDMjSGeFbIO2dzUK0PAGOL8dv05YMq6dUEqUT97HKbF8zJi5xzlV
         2LyrjFcogYMWLxmAEUJqsBvRQyKj4KR9smfaN06dbSZ7RQhB5NjTMM1WfdL1pB47VJ
         OOhwvDGBpnbkudBCJEKwMnqtRse4gJ1NdZGQbzSKBvF8o3zj9BgrYr51rtJU8Qpgr+
         lCRGgXn4X2GYQn+PFqgPd2oud2kY5cf81CdFvt1lNJAhQAbIZPVf5yWl0ieI3ZUcn0
         tPNGWVsKenq+g==
Date:   Thu, 13 Apr 2023 08:32:41 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 8/9] objtool: Detect missing __noreturn annotations
Message-ID: <20230413153241.7px5x2w6jvkpmes7@treble>
References: <cover.1681325924.git.jpoimboe@kernel.org>
 <0f630a0eb4585ab4114e4eecaa6f166a1fd81d49.1681325924.git.jpoimboe@kernel.org>
 <alpine.LSU.2.21.2304131613490.27633@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2304131613490.27633@pobox.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 04:19:10PM +0200, Miroslav Benes wrote:
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -4485,7 +4485,8 @@ static int validate_sls(struct objtool_file *file)
> >  
> >  static int validate_reachable_instructions(struct objtool_file *file)
> >  {
> > -	struct instruction *insn;
> > +	struct instruction *insn, *prev_insn;
> > +	struct symbol *call_dest;
> >  	int warnings = 0;
> >  
> >  	if (file->ignore_unreachables)
> > @@ -4495,6 +4496,17 @@ static int validate_reachable_instructions(struct objtool_file *file)
> >  		if (insn->visited || ignore_unreachable_insn(file, insn))
> >  			continue;
> >  
> > +		prev_insn = prev_insn_same_sec(file, insn);
> > +		if (prev_insn && prev_insn->dead_end) {
> > +			call_dest = insn_call_dest(prev_insn);
> > +			if (call_dest) {
> > +				WARN_INSN(insn, "%s() is missing a __noreturn annotation",
> > +					  call_dest->name);
> > +				warnings++;
> > +				continue;
> 
> A nit but this and
> 
> > +			}
> > +		}
> > +
> >  		WARN_INSN(insn, "unreachable instruction");
> >  		warnings++;
> 
> this makes me thinking. Wouldn't it be confusing to anyone that there is 
> no correspondence between warnings and a number of actual reported 
> warnings through WARN_INSN()? In the future when there would be a usage 
> for warnings. It does not really matter now.

True, maybe we need WARN_INSN_ONCE_PER_FUNC() or so ;-)

-- 
Josh
