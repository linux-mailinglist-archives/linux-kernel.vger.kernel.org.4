Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5880868996E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjBCNFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjBCNFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:05:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F61126C4;
        Fri,  3 Feb 2023 05:05:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5800A60D32;
        Fri,  3 Feb 2023 13:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B59C433EF;
        Fri,  3 Feb 2023 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675429539;
        bh=dAqKwqyaSg81uu4TRuaPmSZKJbLwuxzTKLhPUTRidoM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lbuy8hLJNXf5FJG5Bqg9sSTfw5OrOrA8Ix+LyvptV7CrhxaC9O0+gn13Xv1qtbKBx
         clNmh0OS4+xdAb6zRxecBtj6IhuM1LlQdI+QCtb3qxMBZgO2Zzb8+dobYqvGwVBq5w
         Zf1P++PxQBskJUBEGHz5f/vimuiwA4AfZJlDeSte51RUY+FoesHzNOeVy2RXnO7BaQ
         KdvGU2DryhNu2pgl/3dOf16nnIOyH6HkV0aPN6ycISODVKy57Qx9sjyhu2l2jq3jbV
         yd933sN2FTmmMfSLAAItJNTWqTp5/d5v+O0jjIwlV7lTWojTt8NWRtKyU3fnkdywjI
         ES6YDPdpD4FXQ==
Date:   Fri, 3 Feb 2023 22:05:36 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Steven Rostedt <rostedt@goodmis.org>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Replace memcpy() with direct assignment
Message-Id: <20230203220536.ae8b91c4f0c92ac2640694b6@kernel.org>
In-Reply-To: <1675166510-7798-1-git-send-email-yangtiezhu@loongson.cn>
References: <1675166510-7798-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 20:01:50 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> Just do a direct assignment, then give a chance to probe memcpy()
> for some archs or kernel versions which do not blacklist memcpy().
> 

NACK, because this is not invoked from kprobe int3 handling code.

Thank you,

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  kernel/kprobes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 1c18ecf..5a3cf9f 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -407,8 +407,8 @@ static inline bool kprobe_unused(struct kprobe *p)
>  /* Keep all fields in the kprobe consistent. */
>  static inline void copy_kprobe(struct kprobe *ap, struct kprobe *p)
>  {
> -	memcpy(&p->opcode, &ap->opcode, sizeof(kprobe_opcode_t));
> -	memcpy(&p->ainsn, &ap->ainsn, sizeof(struct arch_specific_insn));
> +	p->opcode = ap->opcode;
> +	p->ainsn = ap->ainsn;
>  }
>  
>  #ifdef CONFIG_OPTPROBES
> -- 
> 2.1.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
