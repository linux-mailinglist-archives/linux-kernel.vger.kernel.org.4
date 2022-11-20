Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952FB6314FF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 16:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKTPmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 10:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKTPmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 10:42:15 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9CE13E1F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 07:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e5V74uO+lPGfLCVFC2OTvdyO/WcjexhhijVYs6KZ/ac=; b=YbE1m9+HYuxGK6UZiyQSXJmrLi
        bQz83Gb3RcS7uKmB69PXmPfhW616XS0jWppEgsMk6MG0+nO941NkKZZ891mr1G789zmSwLB3/DfE7
        fOa33qk7AOKuC4Azj53lwAlGwCsevTq36i20RIFCfuesn39Pjvv/vTkLtRfU9xJVgqD5W1ahSakqS
        MFSfnlBppi0pzfm7GH1WTiLMcYWMJSCCOJKdpbHbE+R75TOBt20d5GQV++0/wcqeic2JiZ1ELER3f
        Wqffh5HurP405r59qlmZQ7Xn/IcqFNIPRf5mSM3loCnGh2ddBZYUNGclf6iMd5HleslsSt7oB71RD
        1qpjXHbw==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1owmRn-005Gz5-HU; Sun, 20 Nov 2022 16:41:31 +0100
Message-ID: <08ea8a0f-f7b2-911f-1efa-2aa8fa04256d@igalia.com>
Date:   Sun, 20 Nov 2022 12:41:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH RESEND] panic: Add register_panic_notifier and
 unregister_panic_notifier
Content-Language: en-US
To:     Xu Qiang <xuqiang36@huawei.com>
Cc:     daniel.vetter@ffwll.ch, andriy.shevchenko@linux.intel.com,
        elver@google.com, tangmeng@uniontech.com, bigeasy@linutronix.de,
        pmladek@suse.com, mcgrof@kernel.org, akpm@linux-foundation.org,
        john.ogness@linutronix.de, yangtiezhu@loongson.cn,
        linux-kernel@vger.kernel.org, weiyongjun1@huawei.com
References: <20221119080305.111863-1-xuqiang36@huawei.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221119080305.111863-1-xuqiang36@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/2022 05:03, Xu Qiang wrote:
> Add two methods to manipulate panic_notifier_list and export them.
> Subsequently, panic_notifier_list is changed to static variable.
> 
> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
> ---
>  include/linux/panic_notifier.h |  3 +++
>  kernel/panic.c                 | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
>

Hi Xu Qiang,  thanks for your patch!

Did you manage to change all users in the kernel? I only received this
email that introduces the helpers, but I don't see them getting used in
code...

Also, did you follow [0]? I stopped a bit this work since the main
reviewers got busy in other stuff (so did I), but I intend to resume
that and submit a new version. With that said, these helpers you're
adding now will eventually require to be all replaced if my work reach a
consensus and gets merged..so, personally I don't think it's a necessary
addition for now [but don't oppose as well =)]

Cheers,


Guilherme


[0]
https://lore.kernel.org/linux-kernel/20220427224924.592546-1-gpiccoli@igalia.com/

> diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> index 41e32483d7a7..9543d498b90b 100644
> --- a/include/linux/panic_notifier.h
> +++ b/include/linux/panic_notifier.h
> @@ -5,6 +5,9 @@
>  #include <linux/notifier.h>
>  #include <linux/types.h>
>  
> +int register_panic_notifier(struct notifier_block *nb);
> +int unregister_panic_notifier(struct notifier_block *nb);
> +
>  extern struct atomic_notifier_head panic_notifier_list;
>  
>  extern bool crash_kexec_post_notifiers;
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 75fe389e8814..8f34dbd389cf 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -200,6 +200,18 @@ static void panic_print_sys_info(bool console_flush)
>  		ftrace_dump(DUMP_ALL);
>  }
>  
> +int register_panic_notifier(struct notifier_block *nb)
> +{
> +	return atomic_notifier_chain_register(&panic_notifier_list, nb);
> +}
> +EXPORT_SYMBOL(register_panic_notifier);
> +
> +int unregister_panic_notifier(struct notifier_block *nb)
> +{
> +	return atomic_notifier_chain_unregister(&panic_notifier_list, nb);
> +}
> +EXPORT_SYMBOL(unregister_panic_notifier);
> +
>  /**
>   *	panic - halt the system
>   *	@fmt: The text string to print
