Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922EF72BC4D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjFLJ2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbjFLJ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732F43C1B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686561693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hnu3/QPSGt0lKd7FefZ8+rPfK1k++XFGKwyXW2/fFXY=;
        b=OWD1HHyWObeOouyX8eBjVY7XDOByvtQAwtgfHG66WFU2QgQM9nm9lZwfULZ6EQ73e3AsYQ
        E/3dCIdXoRoRL40gAp3d5L6l8Hx+Kl/6iZvReTdjoNKCtiMDDk2g5El2cJl+2mjIz8cfVH
        np1ZcrsSgidYuGhcylBBJohCMRJ34zw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-aapA-waqNiSFZCEP9CtWqg-1; Mon, 12 Jun 2023 05:21:27 -0400
X-MC-Unique: aapA-waqNiSFZCEP9CtWqg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f7ecfccf2eso17440435e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561686; x=1689153686;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnu3/QPSGt0lKd7FefZ8+rPfK1k++XFGKwyXW2/fFXY=;
        b=XApdZ7VyXw+0Ivc1gy3+O/tenjZGl4LV2iQIC8nHLyl0SIwLyYhJ7gou+yrr4v1IIQ
         YdDe56uRDNFVcKo8iO50xfYJvj0FK882QW8TdssiFcg8KRuiLmxFWg8Eaukyx0oKmIk8
         I4YVWpOYzm2LmF0jsyoKUi5NktuUc4rBCY9vhJ//AeIodBOaOLT3IBX+4jWhiI3TXKkq
         DrPgSv+exRBSJaHQyOJr8u+qN8AZ2nKvVp9eqz2m9rzhXnGxttW9ZAKD5hPEM2sXLyfJ
         KV7MbRYBnBjJyRfT49ncv28sLzxQYSgY2yvvrHtYnUd7FNdFWJr250WuiAd37OfvOr1X
         AdFQ==
X-Gm-Message-State: AC+VfDy8RLxYSh4kT37O6d9vGg9RxDMckEQpx4yHWIHaQcfc1UPg/H3f
        6XDJgIfpE2atCPa38p4FP7CcAqll6pdo6/Z49FBWJ2JVDZqC6jIP+utNvgXwpC7eFv9jgfd5m34
        Ou0EEs3wkmKu8Se2xZ5DC0z/k
X-Received: by 2002:a7b:cb9a:0:b0:3f7:38e2:d87a with SMTP id m26-20020a7bcb9a000000b003f738e2d87amr5754229wmi.37.1686561685954;
        Mon, 12 Jun 2023 02:21:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78K8Ar/PLApSM4ycn+pKomHOo10eegYWWatJnTfNr/yJHP6s5qeBwxqrUaw1tO9E2QWCJuQg==
X-Received: by 2002:a7b:cb9a:0:b0:3f7:38e2:d87a with SMTP id m26-20020a7bcb9a000000b003f738e2d87amr5754216wmi.37.1686561685579;
        Mon, 12 Jun 2023 02:21:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e? (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de. [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c058b00b003f8146ac7f7sm5522622wmd.28.2023.06.12.02.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:21:25 -0700 (PDT)
Message-ID: <d63da17e-78cf-22ec-a134-a2a2b4bf52e4@redhat.com>
Date:   Mon, 12 Jun 2023 11:21:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] scripts: fix the gfp flags header path in gfp-translate
Content-Language: en-US
To:     Prathu Baronia <prathubaronia2011@gmail.com>,
        akpm@linux-foundation.org, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu
References: <20230608154450.21758-1-prathubaronia2011@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230608154450.21758-1-prathubaronia2011@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.06.23 17:44, Prathu Baronia wrote:
> Since gfp flags have been shifted to gfp_types.h so update the path in
> the gfp-translate script.
> 
> Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
> ---
>   scripts/gfp-translate | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/gfp-translate b/scripts/gfp-translate
> index b2ce416d944b..6c9aed17cf56 100755
> --- a/scripts/gfp-translate
> +++ b/scripts/gfp-translate
> @@ -63,11 +63,11 @@ fi
>   
>   # Extract GFP flags from the kernel source
>   TMPFILE=`mktemp -t gfptranslate-XXXXXX` || exit 1
> -grep -q ___GFP $SOURCE/include/linux/gfp.h
> +grep -q ___GFP $SOURCE/include/linux/gfp_types.h
>   if [ $? -eq 0 ]; then
> -	grep "^#define ___GFP" $SOURCE/include/linux/gfp.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
> +	grep "^#define ___GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
>   else
> -	grep "^#define __GFP" $SOURCE/include/linux/gfp.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
> +	grep "^#define __GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
>   fi
>   
>   # Parse the flags
> 
> base-commit: 44c026a73be8038f03dbdeef028b642880cf1511

Yes, works for me then

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

