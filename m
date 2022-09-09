Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20F15B3DEE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiIIR1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIIR12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:27:28 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3933337F9E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:27:28 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id ay1-20020a056a00300100b0053e7e97696bso1392253pfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 10:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=4U0Cv792MiLLT3xqs4tLXzlENCdHaXq6QFZB5ccoybY=;
        b=sk4rX+o2kF0PpS+GapykbME7V/iKflBOVs5DX+no6UBgfZ0GCN+R1gzNqcy20y9TY6
         lk6gQA9BXhHQZZL+/+gtkgVU3TFNsJDcOykvHYigFcUOWqN3vbirbeZ1fUqT9TEuWzAq
         TXNCfaLVHN8jt6rqMwOMc3685zlnJkAT00C0eO6sfKHl4X30DJ8AdNs4fIF1kRsLp4Jp
         joiA7TjSYfdVOCMpAm2vQo1REHjVoVpaqACOBUiFeiqyCw/jgQAU0/22xJj95dpDgR52
         wGa9xhd84e3+8uooFqK2fMNGnpO/YcMtS3qVMjByFzfE2COMYHUwNldDVAkPXwpq8HZW
         151Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=4U0Cv792MiLLT3xqs4tLXzlENCdHaXq6QFZB5ccoybY=;
        b=3Nh8j2Py3lIRNAvZAxP6+3sMovsCVu4Yh31vnrMP7TdQHmLGfILHRfCEPEfGozTXkC
         Hgw/pvWv4WtDCQEyvNgAT2mAe4p3/hf8eYZpOQ8h0PBsjwRRl6/SHBzdJJmC8D05caEj
         RpHYBdPSsRh+FUybYnLM8dRYnywIqesECXr2h+5hNfjQca+OS+5PGmjaXwNT634R1rtu
         HlHmTKt/vl4ZQJuCQgRWQiPBhW1OdHYXGOTzFBpSH5mFrWe6l4Sdz/fbQ2HP4UPKnjj2
         HaDOtcrCF6yn8XYomgDK/OOayhhLL7wp2PKiaKbL2e8BBOacqAhuoRCQtNQev+F1aJ1/
         ZjWg==
X-Gm-Message-State: ACgBeo1iODxVjDAz0WvYh2tj+4c4JgkRWT+iIbGyrtY3shrKF1wngH+h
        kfXmZ6Rm46osh3DjRu+aIBbo1B0=
X-Google-Smtp-Source: AA6agR4/1v8k4P0tIGrMaKelSGXTF4hBGJOJrswI6GLsXRjbKUupDQjGRlD+EMWMrHFnGqLJszd59GI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90b:4b11:b0:202:998b:71b1 with SMTP id
 lx17-20020a17090b4b1100b00202998b71b1mr1706703pjb.208.1662744447776; Fri, 09
 Sep 2022 10:27:27 -0700 (PDT)
Date:   Fri, 9 Sep 2022 10:27:26 -0700
In-Reply-To: <1662721097-23793-1-git-send-email-wangyufen@huawei.com>
Mime-Version: 1.0
References: <1662721097-23793-1-git-send-email-wangyufen@huawei.com>
Message-ID: <Yxt3fnUdzDTJzUTt@google.com>
Subject: Re: [bpf-next] bpf: use kvmemdup_bpfptr helper
From:   sdf@google.com
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09, Wang Yufen wrote:
> Use kvmemdup_bpfptr helper instead of open-coding to
> simplify the code.

> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---
>   kernel/bpf/syscall.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 4e9d4622aef7..13ce28081982 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1413,20 +1413,14 @@ static int map_update_elem(union bpf_attr *attr,  
> bpfptr_t uattr)
>   	}

>   	value_size = bpf_map_value_size(map);
> -
> -	err = -ENOMEM;
> -	value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
> -	if (!value)
> +	value = kvmemdup_bpfptr(uvalue, value_size);
> +	if (IS_ERR(value)) {
> +		err = PTR_ERR(value);
>   		goto free_key;
> -
> -	err = -EFAULT;
> -	if (copy_from_bpfptr(value, uvalue, value_size) != 0)
> -		goto free_value;
> +	}

>   	err = bpf_map_update_value(map, f, key, value, attr->flags);


[..]

> -free_value:
> -	kvfree(value);

And here you leak the value. We need to free it after update regardless
of error/success. That's why it is coded like that.

>   free_key:
>   	kvfree(key);
>   err_put:
> --
> 2.25.1

