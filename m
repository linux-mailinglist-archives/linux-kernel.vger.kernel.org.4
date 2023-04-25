Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD46EE630
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjDYQ5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjDYQ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5873213C3B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682441790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QgrFF00z2wCMViqatkmG+CLp0kBJ37AT7atyuO0HEqU=;
        b=M4uOXzTO+2yf2CI3o0TufyLu+ARkDR/XvGdWYiWmXXFTg4IANV6eKgEXYt1hHv1y9RDZ5u
        ZvfdcCeVwyIiBPOiyu1dFrqv0XiGG6gQENkogFhYPhxKgkPGrJ7eaJndbG66rSEBYWzuTf
        jBOmGiVfzpIIs1Htgj85c7LUzVMKQLg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-aFb5hHzmOAKsyVlqMk3w3Q-1; Tue, 25 Apr 2023 12:56:29 -0400
X-MC-Unique: aFb5hHzmOAKsyVlqMk3w3Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-2fa5d643cd8so1837481f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682441788; x=1685033788;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgrFF00z2wCMViqatkmG+CLp0kBJ37AT7atyuO0HEqU=;
        b=hSV4o13bLU8y+bBKiZ6z2QBGgaVOuknj451jE9cxlPIQlqeet7bBvOlc1PKKwGrol/
         fpBrM4kL9cd9/zxMl36ZxAKHmfypQfmP254atwZgviNlVRZYSqnKRdom6PGwGf6p0fsE
         SJFun0cmuWzmi+Ld8o5WpWQxIoO2MkX0UscBa4gccZnpYqmsa+zBld2FQxLtSGLRc9F8
         trzKa2Ve42pqFn2VpUk3yJ7WDjA5+QEL8AU7la1dkFhAss25zKs5a/kRa2LPk5Mb//Ag
         wfnH7axZEp7/qvPDbJOyGubtha4lgE1QGIBMfFb+LAOJdNDN7+UYD4kj0hh2N3R+P8Oi
         ThSA==
X-Gm-Message-State: AC+VfDyewrLDYUqk4f1A8wcnXL2OzJ3HsJ6YfW4Cy27XwRxDPv1XbBH/
        CHIcdUA5LfCPmXOGQPMyTHcLfbfLvjicAdYQPVOqRI8ITb9C3ZW+BHgNix9G33ApDgA6jAWpTiq
        bZEIRNddy4OihTj2xh89mHubK69AFNB45
X-Received: by 2002:a5d:48ca:0:b0:304:7ff3:9b2 with SMTP id p10-20020a5d48ca000000b003047ff309b2mr3900200wrs.39.1682441787968;
        Tue, 25 Apr 2023 09:56:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7MeNC8cJ9OH2Zuh38sAFoM69kuwhsPNczCEv8GrTcsCUMsmycijC69SXBl8Qf/CgPBx366KQ==
X-Received: by 2002:a5d:48ca:0:b0:304:7ff3:9b2 with SMTP id p10-20020a5d48ca000000b003047ff309b2mr3900186wrs.39.1682441787586;
        Tue, 25 Apr 2023 09:56:27 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k5-20020adff5c5000000b002f103ca90cdsm13473182wrp.101.2023.04.25.09.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:56:27 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, deller@gmx.de, arnd@arndb.de,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] arch/x86: Include <asm/fb.h> in fbdev source file
In-Reply-To: <20230424084751.14641-1-tzimmermann@suse.de>
References: <20230424084751.14641-1-tzimmermann@suse.de>
Date:   Tue, 25 Apr 2023 18:56:26 +0200
Message-ID: <87v8hjhpdx.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Move the implementation of fb_pgprotect() to fbdev.c and include
> <asm/fb.h>. Fixes the following warning:
>
>   ../arch/x86/video/fbdev.c:14:5: warning: no previous prototype for 'fb_is_primary_device' [-Wmissing-prototypes]
>      14 | int fb_is_primary_device(struct fb_info *info)
>         |     ^~~~~~~~~~~~~~~~~~~~
>
> Just including <asm/fb.h> results in a number of built-in errors
> about undefined function. Moving fb_pgprotect() to the source file
> avoids the required include statements in the header. The function
> is only called occasionally from fb_mmap(), so having it as static
> inline had no benefit.
>
> While at it, fix the codying style in fbdev.c.
>
> Link: https://elixir.bootlin.com/linux/v6.3-rc7/source/drivers/video/fbdev/core/fbmem.c#L1404
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

[...]

> base-commit: d2639bb054c42db5ff15c56902d1113303f5b655
> prerequisite-patch-id: 0aa359f6144c4015c140c8a6750be19099c676fb
> prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
> prerequisite-patch-id: cbc453ee02fae02af22fbfdce56ab732c7a88c36
> -- 

This is a disadvantage of format.useAutoBase = true. I find that have to
do `git branch --set-upstream-to=$foo` more often than I would like...

At least it seems that patchwork ignores these so that's OK.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

