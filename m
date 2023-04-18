Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9D46E5AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjDRHoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDRHoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB6FA8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681803825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=euJpXVUJj0Y0yWzvVRiSSBPuFslbSh4v93aRMU+SGt4=;
        b=G7/JhozejP9ujKHSvc+Xu7bXQdPXzdrDl0oTmgrYKL2FxUErakOiwa/YhVruUpvPLsHe5m
        hE8/hG+/I6O4KCFuRNLrnVGM/OYnhShBaajfKF4WO52YP2wFwnLPaDgKI4+LsXpYMjNcrk
        DPWr1CVa6N9dsd7DqdSti1TJskdkk5M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-dy4eHZnJPXaV7Vo3JA0OSA-1; Tue, 18 Apr 2023 03:43:42 -0400
X-MC-Unique: dy4eHZnJPXaV7Vo3JA0OSA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B177185530C;
        Tue, 18 Apr 2023 07:43:41 +0000 (UTC)
Received: from localhost (ovpn-12-57.pek2.redhat.com [10.72.12.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C3FA2166B26;
        Tue, 18 Apr 2023 07:43:38 +0000 (UTC)
Date:   Tue, 18 Apr 2023 15:43:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Daniil Dulov <d.dulov@aladdin.ru>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] x86/kaslr: Fix potential dereference of NULL pointer.
Message-ID: <ZD5KJWk+QFIKF8/s@bhe.users.ipa.redhat.com>
References: <20230418065308.452462-1-d.dulov@aladdin.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418065308.452462-1-d.dulov@aladdin.ru>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/23 at 11:53pm, Daniil Dulov wrote:
> Pointer val can have NULL value. Then its value is assigned to the pointer p.
> p is dereferenced by calling strcmp().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

It's true for strcmp from lib/string.c, while may not be so true for
strcmp in arch/x86/boot/string.c which I copy at below for reference.
Here, boot/compressed/kaslr.c is using the strcmp in
arch/x86/boot/string.c. So leaving it as is or fixing it, either looks
good to me, I even prefer the former.

int strcmp(const char *str1, const char *str2)
{
        const unsigned char *s1 = (const unsigned char *)str1;
        const unsigned char *s2 = (const unsigned char *)str2;
        int delta = 0;

        while (*s1 || *s2) {
                delta = *s1 - *s2;
                if (delta)
                        return delta;
                s1++;
                s2++;
        }
        return 0;
}

> 
> Fixes: 4cdba14f84c9 ("x86/KASLR: Handle the memory limit specified by the 'memmap=' and 'mem=' boot options")
> Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
> ---
>  arch/x86/boot/compressed/kaslr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index b92fffbe761f..51b3925d4d2d 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -291,7 +291,7 @@ static void handle_mem_options(void)
>  		} else if (!strcmp(param, "mem")) {
>  			char *p = val;
>  
> -			if (!strcmp(p, "nopentium"))
> +			if (!p || !strcmp(p, "nopentium"))
>  				continue;
>  			mem_size = memparse(p, &p);
>  			if (mem_size == 0)
> -- 
> 2.25.1
> 

