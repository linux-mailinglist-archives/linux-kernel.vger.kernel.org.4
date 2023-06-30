Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2748B743DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjF3Oxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjF3Oxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:53:47 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3482419B5;
        Fri, 30 Jun 2023 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=HmgFAntZ82v5P8cl9xrxIHdMfpvylXkji0oyaxknWgs=; b=J+hN8n/ke5/i5Eao95HcFnzTz8
        jmSuzPddWTl37d2SbKMVb169ozrhThONleW733C3sUmhelOSvcIYyP2UWgdogPwUKFIWDjn5800BJ
        GoYAQsOejaTpOiXfD+rFBpGzRMZUXvmdjGSK67b+u9hiMc6EhsO0oaRW2hM6DXYAt6YHxY7Rhyiic
        TcpLB9Sa+anx6B7rVURDXEcDZUIfghUUqIgKSIsZx5OCoZg8IPoELRxXtT9VYWIwv7hL6ceMdojXF
        w5XK45aijv7al53vh3Knq7TSUFTnmnD/t7v7lynPFK8iSWX+75tEYqIGjyG0uPnj2woVMfDBKuuJj
        W/KnEVqg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qFFVD-000BfR-EV; Fri, 30 Jun 2023 16:53:39 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qFFVD-0009lg-0O; Fri, 30 Jun 2023 16:53:39 +0200
Subject: Re: [PATCH v2] btf: warn but return no error for NULL btf from
 __register_btf_kfunc_id_set()
To:     SeongJae Park <sj@kernel.org>, martin.lau@linux.dev
Cc:     Alexander.Egorenkov@ibm.com, ast@kernel.org, memxor@gmail.com,
        olsajiri@gmail.com, bpf@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
References: <20230628164611.83038-1-sj@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bae7e6d7-d7f4-a507-ee80-44e45aa4f2b4@iogearbox.net>
Date:   Fri, 30 Jun 2023 16:53:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230628164611.83038-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26955/Fri Jun 30 09:29:09 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/23 6:46 PM, SeongJae Park wrote:
> __register_btf_kfunc_id_set() assumes .BTF to be part of the module's
> .ko file if CONFIG_DEBUG_INFO_BTF is enabled.  If that's not the case,
> the function prints an error message and return an error.  As a result,
> such modules cannot be loaded.
> 
> However, the section could be stripped out during a build process.  It
> would be better to let the modules loaded, because their basic
> functionalities have no problem[1], though the BTF functionalities will
> not be supported.  Make the function to lower the level of the message
> from error to warn, and return no error.
> 
> [1] https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> 
> Reported-by: Alexander Egorenkov <Alexander.Egorenkov@ibm.com>
> Link: https://lore.kernel.org/bpf/87y228q66f.fsf@oc8242746057.ibm.com/
> Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Link: https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> Fixes: c446fdacb10d ("bpf: fix register_btf_kfunc_id_set for !CONFIG_DEBUG_INFO_BTF")
> Cc: <stable@vger.kernel.org> # 5.18.x
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

I presume this one is targeted at bpf (rather than bpf-next) tree, right?

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 6b682b8e4b50..d683f034996f 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7848,14 +7848,10 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
>   
>   	btf = btf_get_module_btf(kset->owner);
>   	if (!btf) {
> -		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> -			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
> -			return -ENOENT;
> -		}

Why the above one needs to be changed? Do you also run into this case? vmlinux BTF
should be built-in in this case. I understand it's rather the one below for BTF +
modules instead, no?

> -		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
> -			pr_err("missing module BTF, cannot register kfuncs\n");
> -			return -ENOENT;
> -		}
> +		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> +			pr_warn("missing vmlinux BTF, cannot register kfuncs\n");
> +		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
> +			pr_warn("missing module BTF, cannot register kfuncs\n");
>   		return 0;
>   	}
>   	if (IS_ERR(btf))
> 

