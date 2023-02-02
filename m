Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679826888AE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjBBVBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjBBVBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:01:42 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A20834B2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:01:41 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id me3so9682129ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 13:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oTODos+JhjSsHMBz5WWde+ZXEzF0nlSS0ENQxh5rzZM=;
        b=Wkc5GlD/FMKs5jzKPItNIB48d18Vt5fgOxWvYT6sO6WbX7UR5gcq8Temv+KOltBFcU
         UFd5KeCB2LK0vUvPqnpH+j6bfqKyOR/J9PnFMbgMpZgEM71rYA19/8B8pVNDAYa84JYo
         YyRF5TNqz/s/9lOOewI7FVv/Om4/CNsFznsBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTODos+JhjSsHMBz5WWde+ZXEzF0nlSS0ENQxh5rzZM=;
        b=jKWmZwY6BDJeCKFOpkVES+EJvxAxhPIeYKB8+NsZbJRZ48AsC3lTzVQyjubsRQvKDN
         S+T1/fy7N5MibDt6EqMKmVMJnXJN7H+b27sP+7tTUCCbf2nE8hrx6l+pEANE+tkUpY52
         xVB/ucqpJUHn7P/DtawN6oVSgiEiK51cPjLUW+E6IV4KvAIWIcMlJk2Ud2n5fbcGnZ71
         +81TXbVWwjoDzTly4iRUm5TiVVi/KQcgFjfKREWPZWML3GcXJMhrQJs3eACsaXPLYjlV
         B3Jy7+GQkVAepnrX4KhADTFa0FGicJtURnoQM6wlMfAHIIgCvgVJT5Ao7584q5W8ZeH0
         Fdwg==
X-Gm-Message-State: AO0yUKXt8tF5ajEb2UENucZ8zs2PasYzHLP9YXMr/7xUlDDinDP6E1Xs
        zSuXE9HBA5pXI46RvegF4cDsOJFa6ocVT2/dbIp7vg==
X-Google-Smtp-Source: AK7set9Sx9Pz4UXKrXGQOO+VM2+pGdFZjZzNipZ4w0YF225BLrGdW7tnR7iXNaw0AMjraZ6As0LJ9g==
X-Received: by 2002:a17:907:78d4:b0:878:7a0e:5730 with SMTP id kv20-20020a17090778d400b008787a0e5730mr7336487ejc.56.1675371699474;
        Thu, 02 Feb 2023 13:01:39 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id t24-20020a1709066bd800b0088452ca0666sm288836ejs.196.2023.02.02.13.01.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 13:01:38 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id me3so9681883ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 13:01:38 -0800 (PST)
X-Received: by 2002:a17:906:892:b0:87a:7098:ca09 with SMTP id
 n18-20020a170906089200b0087a7098ca09mr2044808eje.78.1675371698233; Thu, 02
 Feb 2023 13:01:38 -0800 (PST)
MIME-Version: 1.0
References: <Y9wYTnwXVwg/3Dv3@osiris>
In-Reply-To: <Y9wYTnwXVwg/3Dv3@osiris>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Feb 2023 13:01:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3u9fG-Oy_NV+w2H7pFUWmfyX5JXHGvxynxA9b1sNZGw@mail.gmail.com>
Message-ID: <CAHk-=wg3u9fG-Oy_NV+w2H7pFUWmfyX5JXHGvxynxA9b1sNZGw@mail.gmail.com>
Subject: Re: [GIT PULL] s390 fixes for 6.2-rc7
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 12:08 PM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> - With CONFIG_VMAP_STACK enabled it is not possible to load the s390
>   specific diag288_wdt watchdog module. Reason is that a pointer to a
>   string is passed to an inline assembly; this string however is located on
>   the stack, while the instruction within the inline assembly expects a
>   physicial address. Fix this by copying the string to a kmalloc'ed buffer.

Ugh. I have pulled this, but I think that fix is disgusting.

I think the kmalloc/kfree should have been done inside __diag288_vm()
itself, where it actually does that whole "virt_to_phys()" too.

Now there are three callers of __diag288_vm(), and they all do that
ugly kmalloc game with no comment about why it's needed.

If __diag288_vm() just did it itself, and had a comment right next to
the virt_to_phys() about why, that would look a lot better, I think.

That said, I don't know the code, and maybe there was some reason to
do it this way. As mentioned, I've pulled it, I just don't
particularly love the patch.

              Linus
