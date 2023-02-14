Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E05B69723C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjBNX5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjBNX5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:57:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FAE83F8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:57:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 572DFB81F66
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D5EC433D2;
        Tue, 14 Feb 2023 23:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676419038;
        bh=gdKZ09xKLjHQr/FAuehTh85/GlxPBc57jOlg8AkSmqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uGXRmJbAVkWj5SMV9lFZvXJq36008pqzwWPitdOdOnQyFaTpOvYHdIQf5pRHqoFpt
         YBgGc3DnftPa4AdBomKEJ2Tor/FKYaR8DvG6731F2KdV2wy7sW8Vb4nzhdncuohvCz
         A4Y9eI+9igug0rqL61+Ypnfo4mKgrleOunWgczvAzqsdwhcRlwe083It8865p8Otgj
         /wa27s0dAIHSF35cBSnpL8PEUtsj79zoVLh5oOfuukHrLTfVHg+rOOGi1IiqRwGsT3
         YBsaWvb5v4nmCQUKVycPdIg7y1cQnqnwJQVT3F3Y7ibzvnmi347lJIgcY4YJ0KZDJp
         4LSLYPg5LCPvQ==
Date:   Wed, 15 Feb 2023 08:57:14 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -tip] kprobes/x86: Remove unneeded casting from
 immediate value
Message-Id: <20230215085714.8d46b98ce787a6e0c962ebf5@kernel.org>
In-Reply-To: <b79052ee-07d2-a6b9-03cb-b33f61985fe2@gmail.com>
References: <167595699689.1303232.13460109151246012198.stgit@mhiramat.roam.corp.google.com>
        <b79052ee-07d2-a6b9-03cb-b33f61985fe2@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 02:01:54 +0200
Nadav Amit <nadav.amit@gmail.com> wrote:

> 
> On 2/9/23 5:36 PM, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Remove unneeded casting from immediate value assignments for relative
> > jump offset. Since the immediate values in the 'insn' data structure are
> > assigned from immediate bytes as a signed value to insn.immediate.value
> > by insn_field_set(). Thus, if we need to access that value as a signed
> > value (in this kprobe's case), we don't need to cast it.
> > This is a kind of clean up (should not change behavior) follows Nadav's
> > bugfix.
> >
> > Link: https://lore.kernel.org/all/20230208071708.4048-1-namit@vmware.com/
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >   arch/x86/kernel/kprobes/core.c |   16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > index 695873c0f50b..2440e736d0e4 100644
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -607,19 +607,19 @@ static int prepare_emulation(struct kprobe *p, struct insn *insn)
> >   	case 0xe8:	/* near call relative */
> >   		p->ainsn.emulate_op = kprobe_emulate_call;
> >   		if (insn->immediate.nbytes == 2)
> > -			p->ainsn.rel32 = *(s16 *)&insn->immediate.value;
> > +			p->ainsn.rel32 = insn->immediate.value;
> >   		else
> > -			p->ainsn.rel32 = *(s32 *)&insn->immediate.value;
> > +			p->ainsn.rel32 = insn->immediate.value;
> 
> Hmm.. I don't get it. What the purpose of keeping the duplicated code 
> (after your change)?
> 

Oops, good catch! I think p->ainsn.rel32 can be set without any check in general.
Let me update it.

Thank you!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
