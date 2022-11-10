Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4686246E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiKJQ2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiKJQ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:28:08 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A86205DA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:28:07 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id a27so1191138qtw.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kuMsrbLUmog/QAtVIJZSMyqz+FTsZ2TyFos+cIoeQ3k=;
        b=VrqiBhVxlcX7KWpRrX8nGVzkC+YvMcgEiuckH1Ek0EjReuw/rieIzH772CS6Ow3GGY
         Q50A3D385IrbukPZsR6rHW9kVNm1IwXkjiayR3wJNreVHTbo3d/4sPBc1usdvmn+fREJ
         gALeRfrNRllJ5vPRN7jK6S0oOlaGWgv/tAxm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kuMsrbLUmog/QAtVIJZSMyqz+FTsZ2TyFos+cIoeQ3k=;
        b=AT114RYqVrqjNoTpKv8SQs4cO0KA3mzQGd6p/opDZ+Z9oCSzv70A+iY0XhSofvCBYM
         ng7HGfaYVlPWilWXKZNvsLICJhgGBOkxXMYgDdGa365RWTeJubCR0oo2gFAdKP0gsmCT
         lVnadDMof8+84QxkX6A3aSEwzYf18Gzvf/kbwruMGSdiVVzEhmdlvdCvvFwxQyxSIeSK
         4q71Cj9evkKwWViSb7F58hk1lHDuddhCqEKvPHst7AVLhVs9h6RkE25qtrHtBb79UwuO
         lEq23xLt0iPxYMUnq685T0N2eCHpHZCd/e2FFyA/bWd8/RdjkDbydzzExV5tbGD0y4Fl
         K8Cg==
X-Gm-Message-State: ACrzQf35Zkx2l++oDhszrYk+yAcPs5NQo5KiSEq0w6G4gSGT37hFK4uh
        zbk2MX+NStAQ8lsl4/Afk7dUWIjA7Ql4YA==
X-Google-Smtp-Source: AMsMyM4AwaZzA8kRSPn5kinccTpVHGSriR2KxEMee7ic1CzMoLVWKNZRvZjlFizUf1j5Sklv7aZewQ==
X-Received: by 2002:a05:622a:1647:b0:3a5:f2:6b2 with SMTP id y7-20020a05622a164700b003a500f206b2mr52034220qtj.40.1668097686098;
        Thu, 10 Nov 2022 08:28:06 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id c22-20020ac84e16000000b003a5092ed8cdsm11362271qtw.9.2022.11.10.08.28.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 08:28:04 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id r3so2905485yba.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:28:04 -0800 (PST)
X-Received: by 2002:a25:b09:0:b0:6dd:5a9b:8062 with SMTP id
 9-20020a250b09000000b006dd5a9b8062mr1712198ybl.362.1668097684120; Thu, 10 Nov
 2022 08:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20221110183352.08cc2303@canb.auug.org.au>
In-Reply-To: <20221110183352.08cc2303@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Nov 2022 08:27:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiyYSrBiOKJEV3phOBDT7EMgdXCnDUrp57E8HGNT4SFdA@mail.gmail.com>
Message-ID: <CAHk-=wiyYSrBiOKJEV3phOBDT7EMgdXCnDUrp57E8HGNT4SFdA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the mm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Wed, Nov 9, 2022 at 11:33 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> After merging the mm tree, today's linux-next build (htmldocs) produced
> this warning:
>
> include/linux/mm_types.h:268: error: Cannot parse struct or union!

Good on you. You check the docs warnings, I've given up on them
because there's so many and it takes so long.

I tried to document the 'struct encoded_page' the same way 'struct
folio' was documented, but clearly the docs parsing hates it. Let's
remove the '/**' marker and just make it a regular comment.

The same goes for the 'release_pages()' thing,

                   Linus
