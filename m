Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23AB66BD21
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjAPLrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjAPLq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:46:58 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E299F1CAF7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:46:55 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bf43so42342498lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LeQntdTA5Ugurin8mDm/P6vcnLBcFASvg8588uk6TaE=;
        b=MsgjWYfpigMizqsn8k+uHz+dowcgwReaEaESYSvWJ7LKYJkwmCoypzJw2xZ/KPaaig
         32LeqRCiB4qtsVKEI3x/fa5KpkEOVt03gt6jDfgSLI9yprttbSIxKqqPYyZ+bXxIr5e6
         P2iWpb5KGmj0iKBkQ/kEK/0+88hCgq8SK/mRxDq6WAvmoSvSoG7GzTQnbXXErs2ok7ji
         mwn4vopcWwRgrbKbDFaaUR6VKxIEQxMn2NyIlk/Mu69dYfMd+v9kezKQlm0DMT5hWDrc
         GKYE8HjK3DgMpeiFYzR8Jtpg6emDrhgEoP/oc8Rg3Qg5XclzzSyIAfssSWP6sorBoKTq
         sfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeQntdTA5Ugurin8mDm/P6vcnLBcFASvg8588uk6TaE=;
        b=kU0DsA30IBQQWS1h0oWftAqtd4HEpBqJ4MX10P8zwsGPvPUH6XZWQu0qxHeoTaQ6kQ
         YBmQQ8OlUiXhhgvLVTc8/Kq/1CWjJhMy/jlZTaWBOo66gtB5I5BiZ0S3sg9RFLtu1hmf
         7AxftpkxTcoHzPoJYJASOuAlvwDxa/2wk6cX4FiqnfWYc4biDvnEuiAuBCzGDKuJvABR
         a6xNWUItsS5XQYzYTRxvdK5l0zxGH2ASpxy2uarUyOcG9wvKQQ/C+0s4y+q/Pcump8mO
         dm7oKuy/RcluoDffUmkPhv0LIJxlc23klBK0XiYb4z+YLPl+SejMUrfXyNRz/J+OeRI2
         wtug==
X-Gm-Message-State: AFqh2kpd/ljDfYL91zUNUCs6vqMlrLAdviHY3uxqxR4ktiPgSpJ/Yn+3
        x+68nHIHVQBhQCLJYL8jwJo=
X-Google-Smtp-Source: AMrXdXvwEWPg+wQ4w94mYobpLgfgculyyzXmkJrIONdQeP4x2/Y8STqbSRiZwvXyDsqCQnN2pSGO1w==
X-Received: by 2002:a05:6512:2085:b0:4d4:ea0f:a784 with SMTP id t5-20020a056512208500b004d4ea0fa784mr1883553lfr.19.1673869614244;
        Mon, 16 Jan 2023 03:46:54 -0800 (PST)
Received: from pc636 (host-90-235-24-7.mobileonline.telia.com. [90.235.24.7])
        by smtp.gmail.com with ESMTPSA id q21-20020a0565123a9500b004d272bf56b5sm1213598lfu.223.2023.01.16.03.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:46:53 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 16 Jan 2023 12:46:51 +0100
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, urezki@gmail.com,
        lstoakes@gmail.com, stephen.s.brennan@oracle.com,
        willy@infradead.org, akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v3 7/7] sh: mm: set VM_IOREMAP flag to the vmalloc area
Message-ID: <Y8U5K2/YaGa1A1pZ@pc636>
References: <20230113031921.64716-1-bhe@redhat.com>
 <20230113031921.64716-8-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113031921.64716-8-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:19:21AM +0800, Baoquan He wrote:
> Currently, for vmalloc areas with flag VM_IOREMAP set, except of the
> specific alignment clamping in __get_vm_area_node(), they will be
> 1) Shown as ioremap in /proc/vmallocinfo;
> 2) Ignored by /proc/kcore reading via vread()
> 
> So for the ioremap in __sq_remap() of sh, we should set VM_IOREMAP
> in flag to make it handled correctly as above.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/sh/kernel/cpu/sh4/sq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
> index a76b94e41e91..27f2e3da5aa2 100644
> --- a/arch/sh/kernel/cpu/sh4/sq.c
> +++ b/arch/sh/kernel/cpu/sh4/sq.c
> @@ -103,7 +103,7 @@ static int __sq_remap(struct sq_mapping *map, pgprot_t prot)
>  #if defined(CONFIG_MMU)
>  	struct vm_struct *vma;
>  
> -	vma = __get_vm_area_caller(map->size, VM_ALLOC, map->sq_addr,
> +	vma = __get_vm_area_caller(map->size, VM_IOREMAP, map->sq_addr,
>  			SQ_ADDRMAX, __builtin_return_address(0));
>  	if (!vma)
>  		return -ENOMEM;
> -- 
> 2.34.1
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
