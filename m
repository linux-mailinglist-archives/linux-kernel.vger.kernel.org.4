Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140905FAAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJKCfr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Oct 2022 22:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJKCfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:35:44 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA47D83F1A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:35:41 -0700 (PDT)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id DD855AB72D;
        Tue, 11 Oct 2022 02:35:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 2948720025;
        Tue, 11 Oct 2022 02:35:03 +0000 (UTC)
Message-ID: <0a9453d94419991aa38d64b7a446eeba1f9c5a80.camel@perches.com>
Subject: Re: [PATCH] ftrace: Fix char print issue in print_ip_ins()
From:   Joe Perches <joe@perches.com>
To:     Zheng Yejian <zhengyejian1@huawei.com>, rostedt@goodmis.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Date:   Mon, 10 Oct 2022 19:35:38 -0700
In-Reply-To: <20221010191524.1626867-1-zhengyejian1@huawei.com>
References: <20221010191524.1626867-1-zhengyejian1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 2948720025
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: gpg9p3o1nsk1c5qs4gcrtj9fydhrnitm
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18CSZ+g118vqqIdgHlGRsJ9urPIdQuasbg=
X-HE-Tag: 1665455703-670618
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-10 at 19:15 +0000, Zheng Yejian wrote:
> When ftrace bug happened, following log shows every byte data in
> problem ip address:
>   actual:   ffffffe8:6b:ffffffd9:01:21
> 
> However that seems a little confusing, and it is because format
> '%x' being used to print signed chars in print_ip_ins().
> 
> After this patch, the log is like:
>   actual:   e8:6b:d9:01:21
> 
> Fixes: 6c14133d2d3f ("ftrace: Do not blindly read the ip address in ftrace_bug()")
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
[]
> @@ -2015,7 +2015,7 @@ static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
>  
>  static void print_ip_ins(const char *fmt, const unsigned char *p)
>  {
> -	char ins[MCOUNT_INSN_SIZE];
> +	unsigned char ins[MCOUNT_INSN_SIZE];
>  	int i;
>  
>  	if (copy_from_kernel_nofault(ins, p, MCOUNT_INSN_SIZE)) {

Perhaps nicer would be to change the for loop below this from

	for (i = 0; i < MCOUNT_INSN_SIZE; i++)
		printk(KERN_CONT "%s%02x", i ? ":" : "", ins[i]);

to

	pr_cont("%*phC", MCOUNT_INSN_SIZE, ins);

