Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB3E5B318A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiIIIUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiIIIT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:19:57 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CE94D154
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:19:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so3892283wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=M80nuH0as/dyuPHdT1nX8UsUUmqoa+KIEZcH7oWzmKc=;
        b=dMC9Cl2UatNEGchSPLYQrxGB2PGv4NvywsDD3724PHbU/3oVL2aNcU8+xSWplpjvc4
         neJcokyoHrO3vUSbIvx0+1+2VtjUGH73P+zfgHD4BqOmErVnf4CtdoGNCnH5zm0o9vPp
         Ka6Ah02a91aoNAf5SmayHSVsqtkKlvoyawaUKvbAFFFxlh9Z21k6rl4khDfHPcKVWyJK
         +BvAzQSljhxVojUxdj/RJDONhnlPdearj0kdbCEyZSlSZ+QApC28ByJ1k8HgxUdnnZ9h
         UVPT52bUnR6zPH24+su1/TYHfG5wXSBrAqCI6Tb2/Jbi0lGXgxXNY7MBJWDaBax88kqC
         RZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M80nuH0as/dyuPHdT1nX8UsUUmqoa+KIEZcH7oWzmKc=;
        b=gIZqc9IWYsFGMQ1AQgzSf//LoXpM+WvXlbkhTX/KYgu3OYiLKP1dC8BdDh/0SgryCZ
         Uwk+iMH0MZIkOAQiY8zqSA6XYPGcaWDdS3Fn0xRAwjm4Ch8uH6m5IDJjpfe4Ut9YEIlF
         fwFC2i9wVUwWCYI6JppL9T32FVo9XdfBBCi0e4Hfj6rC06uXG/qq56BZ8e3kycdNAd9z
         QwWqYs1oDpjr0VkQ65U1FUn8HWdDb2zUp2jHtVv5uPlL5JRD++Xi1qmqtONEPVY96QPD
         vXG3WTMueCJ/HzNkfxoLdo22fsbU4ttEA8aSn2dKIipqL5EiLg1ISq65tTvgUmVxMj/5
         qJhQ==
X-Gm-Message-State: ACgBeo2EWKYaSLCjMyU6kFeMeUgyX03iKYJcPMN15zJau+wg8xqsnbqW
        6B5VeQNM6h8JeyWZZy5ZFDfosA==
X-Google-Smtp-Source: AA6agR7gJw/MYcMBE4WBJCYjAtalYkIhggEBXED0qnUmijJhSc7OaCgGWT9NwnsXwoUQs+n8htTAWQ==
X-Received: by 2002:a05:600c:1c16:b0:3a6:b11:79be with SMTP id j22-20020a05600c1c1600b003a60b1179bemr4491777wms.203.1662711594959;
        Fri, 09 Sep 2022 01:19:54 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:1d1e:ddcd:2020:36c2])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d68cc000000b00228a6ce17b4sm1265073wrw.37.2022.09.09.01.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 01:19:54 -0700 (PDT)
Date:   Fri, 9 Sep 2022 10:19:47 +0200
From:   Marco Elver <elver@google.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm: kfence: convert to DEFINE_SEQ_ATTRIBUTE
Message-ID: <Yxr3I6Ru2WUGzEWn@elver.google.com>
References: <20220909083140.3592919-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909083140.3592919-1-liushixin2@huawei.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:31PM +0800, 'Liu Shixin' via kasan-dev wrote:
> Use DEFINE_SEQ_ATTRIBUTE helper macro to simplify the code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Reviewed-by: Marco Elver <elver@google.com>
Tested-by: Marco Elver <elver@google.com>

> ---
>  mm/kfence/core.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 8c08ae2101d7..26de62a51665 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -719,24 +719,13 @@ static int show_object(struct seq_file *seq, void *v)
>  	return 0;
>  }
>  
> -static const struct seq_operations object_seqops = {
> +static const struct seq_operations objects_sops = {
>  	.start = start_object,
>  	.next = next_object,
>  	.stop = stop_object,
>  	.show = show_object,
>  };
> -
> -static int open_objects(struct inode *inode, struct file *file)
> -{
> -	return seq_open(file, &object_seqops);
> -}
> -
> -static const struct file_operations objects_fops = {
> -	.open = open_objects,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = seq_release,
> -};
> +DEFINE_SEQ_ATTRIBUTE(objects);
>  
>  static int __init kfence_debugfs_init(void)
>  {
> -- 
> 2.25.1
