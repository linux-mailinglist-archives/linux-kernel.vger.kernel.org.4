Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4415F64DF99
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiLOR0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLOR0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:26:39 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F982B182
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:26:38 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3b48b139b46so50974547b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=chEyUbAV7J4xGz2q2/RrhhIdXsvx3jyKlM9Y12RhEQQ=;
        b=SVDiBUEpMdS9AHo2WKRmzcy/X5582YT6x8fxwsLn/EfAk0SyaxgEqHSuH/LbSTXkli
         9vJZe8PuaTkk6MCmTbsTOWapT22VFrPOI5nt9657FzqwzmFbfc56V0ywsmF4aD4A1gry
         mbXQn9RxrW578L+sqCY0JjkEn7haVfg23DSa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chEyUbAV7J4xGz2q2/RrhhIdXsvx3jyKlM9Y12RhEQQ=;
        b=zEAGPufI0TPUZ3xQwFz5ANwhst99weg/u0FoSQpGXwhebaHkRDfOE/X/i/BTI68EXt
         VhIZXYeZZS0rvFkL/LtWWxk/73kX2pa/9M0hOv3Re50ncE4TXViREgJcrbUpAhKdvLjG
         Nq59PhILfhAYmlrWfpnahmnEv6ngoLbKeyyj9CCTMtZMUgThB4Q348oUlE5wz2Ey4ewp
         C1xTddOvkcBaXBI4x7QZlTfbb5qlaeVX+7eyfSsnPx8cJ1Sr8peuMuTOoXMUr6voNRD7
         7R2Ckn7JPS0fbu/M0U075Rv62/D18CaSanpTrqWtq0nSemhOc/ALE6JiLSd3tGcUhusc
         5NZg==
X-Gm-Message-State: ANoB5pl/v7PCtC+KX9lpemEQqcuoBvD+ItZOKlMDSAeO6DAPBNryVrs2
        bAmqWTX6DollRXtcipy2jBWRnFI/gsOLIw9T
X-Google-Smtp-Source: AA0mqf4wpgQ6fBFKRDQSK3wLIeNvN5aSASEKXqPwM/rO5QNIa3H5vsI7xy7LleKREXamYfQBo4mGnA==
X-Received: by 2002:a05:690c:a94:b0:389:b7c1:c725 with SMTP id ci20-20020a05690c0a9400b00389b7c1c725mr25500461ywb.19.1671125196672;
        Thu, 15 Dec 2022 09:26:36 -0800 (PST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id t11-20020a05620a450b00b006eea4b5abcesm12721091qkp.89.2022.12.15.09.26.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 09:26:35 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id d2so2245145qvp.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:26:35 -0800 (PST)
X-Received: by 2002:a0c:c690:0:b0:4f0:656b:c275 with SMTP id
 d16-20020a0cc690000000b004f0656bc275mr370160qvj.129.1671125195150; Thu, 15
 Dec 2022 09:26:35 -0800 (PST)
MIME-Version: 1.0
References: <20221213174234.688534-1-dave.hansen@linux.intel.com>
 <CAHk-=wi=TY3Kte5Z1_nvfcsEh+rcz86pYnzeASw=pbG9QtpJEQ@mail.gmail.com>
 <20221215123007.cagd7qiidehqd77k@box.shutemov.name> <CAHk-=whC_ixb3FDdMhW_wiKw7-bB700kvUyqN+_cPUNp=1hNsQ@mail.gmail.com>
In-Reply-To: <CAHk-=whC_ixb3FDdMhW_wiKw7-bB700kvUyqN+_cPUNp=1hNsQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Dec 2022 09:26:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjyy3iKS0B=A-yAPqjE3xiUU_5AiXApCasuYKTNu842dQ@mail.gmail.com>
Message-ID: <CAHk-=wjyy3iKS0B=A-yAPqjE3xiUU_5AiXApCasuYKTNu842dQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.2
To:     kirill.shutemov@linux.intel.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
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

On Thu, Dec 15, 2022 at 9:17 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Here's *one* suggested solution:

Note again: this is not a "you need to do it this way" suggestion.
This is just a "at least this way doesn't have the issues I object
to". There are bound to be other ways to do it.

But if you feel like all threads have to share the same LAM state, it
does seem a lot simpler if you just say "you need to set that state
before you start any threads". No?

> And yes, I would actually suggest that _any_ thread creation locks it,
> so that you never *EVER* have any issues with "oh, now I need to
> synchronize with other threads". A process can set its LAM state at
> startup, not in the middle of running!

Note that this "no serialization needed" is just about the SW side.

The *hardware* side may still need the IPI just to make sure that it
forces a TLB flush - even if we are single-threaded, that single
thread may have run on other CPU's before.

But I think at that point it's just a regular TLB flush, and doesn't
need that LAM-specific IPI.

But maybe there's some bigger HW serialization that is needed for the
LAM bit, I have not looked at that enough to know.

              Linus
