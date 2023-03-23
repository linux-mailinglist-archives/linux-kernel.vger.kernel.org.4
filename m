Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86736C67A7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjCWMHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjCWMHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:07:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F053EF75F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:06:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so984979wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679573187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJmH0tbrplX0qv721RuMP2KjLRQ5o8Lk2BVGq3s7CDU=;
        b=XG2LwzICxCaRM9ycw1fWtNQG6P3+zhAwsxST5yW5/VnrcJZjWOxyDmH64jCUkTwRn2
         /EHy5vDoXRD/+4N4odlGGH/wpVRaDtB0b00kXoOpmYWcuVzXeg9BGevNP0gzImOsNjcT
         FqUfBCl/+Rtd3osQrnyntSmx6+FvS7V9zMDZRZCPWHXe/VUdB+ZlBfs6KuaNLUUQbZO1
         kOHozu0D3xaclaOFJXwiq2GsXZx+3FCZ8XBBSeWZzahDqhvLeMBFSEMxpIDB+r7fZ1wi
         uUsd/8TjtAKPebY4zPr1PwnALRAK+bjC3mkmicfJDOPwxe2xpDDiIfckKx6A99Rf8E3h
         pXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJmH0tbrplX0qv721RuMP2KjLRQ5o8Lk2BVGq3s7CDU=;
        b=sICxFT8UBxJg0qRl+lUe+/l7KxSEtT7uYSM+5RSan4+7Cx00wa4ycBjWVM2N6YsJRh
         9JFBlvo7tSxo9Kv6TTE1Hi4F+NzowBPA1MlqE9hStdZ2Y9pjW7kHe/Zeeo+54g/GPccn
         uWVGvchsK2eAtVDIbVDzryohUegPov1Asnl8ey/nOqS0j74DHYCRA69kGhV7RJeyz7ai
         GmsA4s1ozmpIbHKb8hT7BeMNmM8hbGOibl77aPYFVWZdJWxfUBKQie655paiybXsVKRp
         S0LOzLmfxbCBgVcm/eK6+ZwiDvtwK2rL9htP7w8K3dxF5ixTrfwVD3K+fZ2+DUPd8H9n
         fX9g==
X-Gm-Message-State: AO0yUKWdAWLkBx4NiFt/drfNJNBdjgSTTA9K0ZEOzmlkkyOnnAO0BEnt
        GZe04xPcOmvjON+OI7u8aW4=
X-Google-Smtp-Source: AK7set9omZEy6gYLfwYJZygbluVZwjWh333f+xm0NpI7MllGA2uLGa/nuHnnoFto0M3/bvmNT/KkgA==
X-Received: by 2002:a7b:c448:0:b0:3ee:814b:9c39 with SMTP id l8-20020a7bc448000000b003ee814b9c39mr1656924wmi.18.1679573187039;
        Thu, 23 Mar 2023 05:06:27 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id a10-20020a056000050a00b002d78a96cf5fsm8909979wrf.70.2023.03.23.05.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:06:26 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:06:25 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: vmalloc: mark zero_iter() static
Message-ID: <7c5275c3-ec6e-4489-abd8-fba6e03fa2a3@lucifer.local>
References: <20230323115903.1483668-1-arnd@kernel.org>
 <20230323115903.1483668-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323115903.1483668-3-arnd@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:58:36PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The zero_iter() function was put into the global namespace,
> apparently by accident:
>
> mm/vmalloc.c:3448:8: error: no previous prototype for function 'zero_iter' [-Werror,-Wmissing-prototypes]
> size_t zero_iter(struct iov_iter *iter, size_t count)
>        ^
> mm/vmalloc.c:3448:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> size_t zero_iter(struct iov_iter *iter, size_t count)
> ^
>
> Fixes: d9cab54f7737 ("mm: vmalloc: convert vread() to vread_iter()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index fb216495fe5a..55f5d6fc8629 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3445,7 +3445,7 @@ EXPORT_SYMBOL(vmalloc_32_user);
>   *
>   * Returns the number of zeroed bytes.
>   */
> -size_t zero_iter(struct iov_iter *iter, size_t count)
> +static size_t zero_iter(struct iov_iter *iter, size_t count)
>  {
>  	size_t remains = count;
>
> --
> 2.39.2
>
>

And finally, this was also fixed in the latest version (v8) see
https://lore.kernel.org/all/cover.1679566220.git.lstoakes@gmail.com

Again do forgive the noise! :)
