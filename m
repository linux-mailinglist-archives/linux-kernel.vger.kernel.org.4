Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8132570D9BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjEWJ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbjEWJ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B05132
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684835910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LycqLutbVGXtzw5AEhsRYxd5JCdHFjpO4IqicwMpPiE=;
        b=Z5XnGdjqNWvnJMjb4gkjIfIU3kGgV2VWCcVlsPLikh71Jwd1F6x3H1Bq0xV3u9tsCmoYrY
        WOgCvFdsj0U7znbF1F/b7uwy8PsnQJFAwcZl6H329z4T0NrkMo6vThNtsyMAGhRNVG+Epm
        TIFk8pZG0vEMADosxWfLeNWpt1RiZac=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-3j4cdOzfMUCuLPnIrmfvFA-1; Tue, 23 May 2023 05:58:28 -0400
X-MC-Unique: 3j4cdOzfMUCuLPnIrmfvFA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f604687a23so8766565e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835907; x=1687427907;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LycqLutbVGXtzw5AEhsRYxd5JCdHFjpO4IqicwMpPiE=;
        b=kZahl/sfsBOgB8IXeQp1n8E4Xu+cH140ioAm/EOf8VBni5jSDPwlZkdp+qrCYC4hyn
         jkNiI0e5Q1k+HQKzSGDsAE51prvOj/4DbvUO9IPMwvG2jypdgm5LT5bUHAEjm3ohFXva
         b0UuaW5/ZkD43Bx1hOZiJguynF3P421ZL0dCqwy32oTTxrzDfx+Pux61AIK1MhR4UslK
         HoqBOfsFN4f6UYCuvNF3DRCi5kZ20oeBRouPi4gzt33cwg9u9nlEY7Hmt1Wu1lFjoCTA
         KU+VyD3lQKQCiEsoqe+Ol0E7PPgOXmYCtDUaQ4xmniTcW/Ymeykfb8NOe63Ep5mfebov
         b6BQ==
X-Gm-Message-State: AC+VfDzbukMPTjbUB2hCfOS/GAK9OUwQySGRlcfXLU35yo3hva5JlvFe
        KKL5aR240CV2rU3m/O/gtIM8qLikPyRKUKZpDfXuhN0V+p+UBTrd9GS5ncdMt5O9fLt8SmTrC5o
        ktK0Ie0Qtvp1GlUpeAYzliXx9
X-Received: by 2002:a7b:cd0c:0:b0:3f6:7e6:44ea with SMTP id f12-20020a7bcd0c000000b003f607e644eamr2709755wmj.18.1684835907591;
        Tue, 23 May 2023 02:58:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6hjKhVvi0v/UN/aZgYax0Co+JEyAE7nJ1dTzFPofNOgN9OvKla7Znm3Ia5nTZjnlstS94TIQ==
X-Received: by 2002:a7b:cd0c:0:b0:3f6:7e6:44ea with SMTP id f12-20020a7bcd0c000000b003f607e644eamr2709740wmj.18.1684835907260;
        Tue, 23 May 2023 02:58:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd? (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de. [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
        by smtp.gmail.com with ESMTPSA id y21-20020a1c4b15000000b003f60119ee08sm8876670wma.43.2023.05.23.02.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:58:26 -0700 (PDT)
Message-ID: <c5cc983f-5e28-6fd3-9ec7-5777a36f686c@redhat.com>
Date:   Tue, 23 May 2023 11:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 4/6] ksm: add documentation for ksm zero pages
Content-Language: en-US
To:     Yang Yang <yang.yang29@zte.com.cn>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202305221842587200002@zte.com.cn>
 <20230522105335.4176-1-yang.yang29@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230522105335.4176-1-yang.yang29@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.23 12:53, Yang Yang wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> Add the description of ksm_zero_pages.
> 
> When use_zero_pages is enabled, pages_sharing cannot represent how
> much memory saved actually by KSM, but the sum of ksm_zero_pages +
> pages_sharing does.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Jiang Xuexin <jiang.xuexin@zte.com.cn>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> ---
>   Documentation/admin-guide/mm/ksm.rst | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index 7626392fe82c..019dc40a0d3c 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -173,6 +173,14 @@ stable_node_chains
>           the number of KSM pages that hit the ``max_page_sharing`` limit
>   stable_node_dups
>           number of duplicated KSM pages
> +ksm_zero_pages
> +        how many empty pages are sharing the kernel zero page(s) instead
> +        of other user pages as it would happen normally. Only meaningful
> +        when ``use_zero_pages`` is/was enabled.

"empty pages" is misleading. You can probably drop the last comment, 
because you repeat that afterwards.

how many zero pages that are still mapped into processes were mapped by 
KSM when deduplicating.


I suggest squashing this patch into #3.

-- 
Thanks,

David / dhildenb

