Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D706E9B7E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjDTSVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjDTSVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:21:13 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552EB2736
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:21:12 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6a60460a23dso1072676a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1682014871; x=1684606871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8aVj5sgReWVnhyaJ2DUsoH6IQ6uZim3OtgpbE5sEkw=;
        b=BWwDVjWMd2BipQFjAhTnRYDBN6FvvvN8guK4EtPUMIOijijbNcRlW/2YAnFzhHRIx1
         dylrJi4rqfKLIY/8BlpTj/ch7gaWj32/Ah9q5j+mrKpc75cznRoPMqkEJBQe+LwpinPH
         ypN6BtUIPbXfS+n6+ctmzjh/5UXbhcvK8q5Ve3XDbqIjGPFIyPyXxQYwQWUdZcTkFdmS
         I2lPCqO1Gy3JLmPvRv79rn/3FOb6mUtb83g/80cZSFFvZhB+/Q3QBbY/eUhuWn7b0UfG
         kVzeTjy3fxX6fIaG6OvSKOQZ3vsn1Bx1IJBtA92DOIozsAPjGKNaSg7un/YRrd8XuSW9
         RLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682014871; x=1684606871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8aVj5sgReWVnhyaJ2DUsoH6IQ6uZim3OtgpbE5sEkw=;
        b=HHSwIHtPhQN3yYmDfUUxXLPo21Suha2NjfHMLvrq2yyEsegX/Ic9wpXKvEuL1mh+ux
         4kYKCj6MnRDPKoO51h7RDWtxzhiXvgE+3d2OxrzmkGh4mDgcKyJ36nqfBK6hIv9u8PFr
         XvehiMNgzhWpaRQeQXBCOUHRSljaJ5oLwfBUoDMsLfWKVL8VUG1XtbC3/MwbeUgP/Y4u
         V6HmfxYSlBLftWlYxQaqGZXs99ippzVAzzsD3NeGivr5nKyI3ZE7d47tYGzf35QYrzA+
         qJYeonK6M2KS2XzjTuXu8usqnJRpmI4iB3WyxVmp7tER5ucuj3vVGHFEN2lmuwkEvkxf
         l4pw==
X-Gm-Message-State: AAQBX9cH8TNqS0xW8SBeFIIBBZQaxBlNt88An3TPfxg6p1FDCC6rv0bp
        +aLpZLG+YdioVediL2fzxpp2tg==
X-Google-Smtp-Source: AKy350a4fxn4lwi7pJPT7kHlmDB/6gMxEkSsVX78x89Y3lGiQGmuWjbSnKwTDM0NLHsZSFOvm8E4fQ==
X-Received: by 2002:a9d:798a:0:b0:6a5:faad:b812 with SMTP id h10-20020a9d798a000000b006a5faadb812mr1299608otm.7.1682014871696;
        Thu, 20 Apr 2023 11:21:11 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:7668:3bb3:e9e3:6d75? ([2804:14d:5c5e:44fb:7668:3bb3:e9e3:6d75])
        by smtp.gmail.com with ESMTPSA id s7-20020a056830148700b006a44d90de05sm939837otq.69.2023.04.20.11.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 11:21:11 -0700 (PDT)
Message-ID: <77920a21-96ab-54e5-db3d-5083a11d5691@mojatatu.com>
Date:   Thu, 20 Apr 2023 15:21:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH net] net/sched: cls_api: Initialize miss_cookie_node when
 action miss is not used
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul Blakey <paulb@nvidia.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230420175952.1114302-1-ivecera@redhat.com>
From:   Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20230420175952.1114302-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 14:59, Ivan Vecera wrote:
> Function tcf_exts_init_ex() sets exts->miss_cookie_node ptr only
> when use_action_miss is true so it assumes in other case that
> the field is set to NULL by the caller. If not then the field
> contains garbage and subsequent tcf_exts_destroy() call results
> in a crash.
> Initialize .miss_cookie_node pointer to NULL when use_action_miss
> parameter is false to avoid this potential scenario.
> 
> Fixes: 80cd22c35c90 ("net/sched: cls_api: Support hardware miss to tc action")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   net/sched/cls_api.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 35785a36c80298..8bc5b9d6a2916e 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -3224,8 +3224,12 @@ int tcf_exts_init_ex(struct tcf_exts *exts, struct net *net, int action,
>   	exts->action = action;
>   	exts->police = police;
>   
> -	if (!use_action_miss)
> +	if (!use_action_miss) {
> +#ifdef CONFIG_NET_CLS_ACT
> +		exts->miss_cookie_node = NULL;
> +#endif
>   		return 0;
> +	}
>   
>   	err = tcf_exts_miss_cookie_base_alloc(exts, tp, handle);
>   	if (err)

The problem described here also happens in the case some error happens 
if the action array allocation fails and before the 'miss_cookie_node' 
assignment inside 'tcf_exts_miss_cookie_base_alloc()'.

Seems like a better way to solve this issue is to just:
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 35785a36c802..3c3629c9e7b6 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3211,6 +3211,7 @@ int tcf_exts_init_ex(struct tcf_exts *exts, struct 
net *net, int action,
  #ifdef CONFIG_NET_CLS_ACT
         exts->type = 0;
         exts->nr_actions = 0;
+       exts->miss_cookie_node = NULL;
         /* Note: we do not own yet a reference on net.
          * This reference might be taken later from tcf_exts_get_net().
          */

