Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2986F00AE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242966AbjD0GMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbjD0GMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:12:34 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C56E2718;
        Wed, 26 Apr 2023 23:12:27 -0700 (PDT)
X-UUID: ba6ee2f163474272a7abca873f06b3df-20230427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:8504591b-8155-42a9-8669-fd081f2c4318,IP:10,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:1
X-CID-INFO: VERSION:1.1.22,REQID:8504591b-8155-42a9-8669-fd081f2c4318,IP:10,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-META: VersionHash:120426c,CLOUDID:998317bf-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:230427141208U49KSSQY,BulkQuantity:0,Recheck:0,SF:24|17|19|43|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: ba6ee2f163474272a7abca873f06b3df-20230427
X-User: lienze@kylinos.cn
Received: from fedora [(210.12.40.82)] by mailgw
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 942601865; Thu, 27 Apr 2023 14:12:06 +0800
From:   Enze Li <lienze@kylinos.cn>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn,
        Qing Zhang <zhangqing@loongson.cn>
Subject: Re: [PATCH v2 5/5] LoongArch: Abstract DYNAMIC_FTRACE_WITH_ARGS
 accesses
In-Reply-To: <1682561552-32324-6-git-send-email-tangyouling@loongson.cn>
        (Youling Tang's message of "Thu, 27 Apr 2023 10:12:32 +0800")
References: <1682561552-32324-1-git-send-email-tangyouling@loongson.cn>
        <1682561552-32324-6-git-send-email-tangyouling@loongson.cn>
Date:   Thu, 27 Apr 2023 14:16:06 +0800
Message-ID: <87h6t17sux.fsf@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27 2023 at 10:12:32 AM +0800, Youling Tang wrote:

> From: Qing Zhang <zhangqing@loongson.cn>
>
> 1. Adds new ftrace_regs_{get,set}_*() helpers which can be used to manipulate
> ftrace_regs. When CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y, these can always
> be used on any ftrace_regs, and when CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=n
> these can be used when regs are available. A new ftrace_regs_has_args(fregs)
> helper is added which code can use to check when these are usable.
>
> 2. Prepare ftrace_regs_set_instruction_pointer support in advance.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  arch/loongarch/include/asm/ftrace.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
> index f789e680f633..30ee01243416 100644
> --- a/arch/loongarch/include/asm/ftrace.h
> +++ b/arch/loongarch/include/asm/ftrace.h
> @@ -54,6 +54,31 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
>  	return &fregs->regs;
>  }
>  
> +static __always_inline void
> +ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
> +				    unsigned long ip)
> +{
> +	regs_set_return_value(&fregs->regs, ip);
> +}
> +
> +static __always_inline unsigned long
> +ftrace_regs_get_instruction_pointer(struct ftrace_regs *fregs)
> +{
> +	return instruction_pointer(&fregs->regs);
> +}
> +
> +#define ftrace_regs_get_argument(fregs, n) \
> +	regs_get_kernel_argument(&(fregs)->regs, n)
> +#define ftrace_regs_get_stack_pointer(fregs) \
> +	kernel_stack_pointer(&(fregs)->regs)
> +#define ftrace_regs_return_value(fregs) \
> +	regs_return_value(&(fregs)->regs)
> +#define ftrace_regs_set_return_value(fregs, ret) \

Hi Youling,

> +	regs_set_return_value(&(fregs)->regs, ret)
       ^^^^^^^^^^^^^^^^^^^^^^^^
I can not find the implementation of this function, am I missing
something?

> +#define ftrace_override_function_with_return(fregs) \
> +	override_function_with_return(&(fregs)->regs)
> +#define ftrace_regs_query_register_offset(name) \
                                                 ^^^^^^
There seems to be a missing function here.  Otherwise, the backslash
should be redundant.  Did I understand correctly?

Best Regards,
Enze

> +
>  #define ftrace_graph_func ftrace_graph_func
>  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>  		       struct ftrace_ops *op, struct ftrace_regs *fregs);
