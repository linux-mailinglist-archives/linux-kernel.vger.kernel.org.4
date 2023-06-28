Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CEA7417E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjF1SUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjF1SUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:20:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A4B1BC3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:20:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98d34f1e54fso11140566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687976415; x=1690568415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M7aFeBqA+iPIGCr/uPGvnmE94Z3FPGe+Ni0JLr6Li2k=;
        b=SYYkYomDQiTGTtBuwvaxYcVhZX52v2zwLtDVDcOQBMjgYf6btLfUNXbvSvX/+R2o6B
         AjjgONNxzozJ1TXcmYniDN9dBFItlBS/YkEXyapFPRFp7BLLmlMSvAFcPt4eAJycVJOT
         iwE753QBiga65LhckzZg6EttP3QQvH8bCF3qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687976415; x=1690568415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7aFeBqA+iPIGCr/uPGvnmE94Z3FPGe+Ni0JLr6Li2k=;
        b=BM3NNWwI16k9e4uQsmtV1BPBX5iTW+GHQyHZGheW2Ua1L60wHhC1aQ78fpEO0dcDqK
         oqw5ntmtFUV7AttuVQSKD7D5fNBOiG3B6tsVZ+MHIGabwuOJfMBVyM63jY0K7ynnrtmV
         vhMnmxWkOaJLWEvjvtCAySLqtstJWlGpwNND4MazA3WGyr0z11HOMfcLPRC0yQYY0yMA
         ltBmT/CZVEmT37/clMFS5xPjr7sYsuloFo+FdMF/she99/+X7vrR/vLUuMNlcaYyVmry
         J/CzofjREMmLez4/sIwPtsdNRSmxy02fRiV1AJFDtjr3sJAKEvxFSrU2PIilVGt6k5bH
         mwXw==
X-Gm-Message-State: AC+VfDz6iZ/SUyHVcmoOP0HFuagkLnRoZz3Nohl96wq2k3F7ufwdglad
        RwZtUaADQLgQDqB76ZGRv9eGqHszHYXV9fCoNlBrDkJe
X-Google-Smtp-Source: ACHHUZ7/2b0m+s+z3hGTepKWVoIIvTwNq7RAsLIuXNQdgE7bDbky9HdFwkNYeICCV/bhb3mnk/YBmg==
X-Received: by 2002:a17:907:5c7:b0:973:e4c2:2bcd with SMTP id wg7-20020a17090705c700b00973e4c22bcdmr28377089ejb.18.1687976415034;
        Wed, 28 Jun 2023 11:20:15 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id m5-20020a170906258500b009928b4e3b9fsm659852ejb.114.2023.06.28.11.20.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 11:20:14 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51d9695ec29so4265146a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:20:14 -0700 (PDT)
X-Received: by 2002:a05:6402:31f3:b0:51d:a263:ef0a with SMTP id
 dy19-20020a05640231f300b0051da263ef0amr6175439edb.24.1687976413997; Wed, 28
 Jun 2023 11:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230626085035.e66992e96b4c6d37dad54bd9@linux-foundation.org> <CAHk-=wjyJyV=Kyb8XJcLjFEPP-RMF0J6CQfT2OXLmJdM2yEv8w@mail.gmail.com>
In-Reply-To: <CAHk-=wjyJyV=Kyb8XJcLjFEPP-RMF0J6CQfT2OXLmJdM2yEv8w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jun 2023 11:19:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wie=MvQzmjhKGCCbRapK3Zz-b8GFUchEDJi7SkeLAX6Pw@mail.gmail.com>
Message-ID: <CAHk-=wie=MvQzmjhKGCCbRapK3Zz-b8GFUchEDJi7SkeLAX6Pw@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.5-rc1
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 at 10:27, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I think it needs to match the comment (and the try_grab_page()
> logic), and just basically
>
>         if (flags & FOLL_GET)
>                 return try_get_folio(page, refs);
>
>         if (is_zero_page(page))
>                 return page_folio(page);
>
>         folio = try_get_folio(page, refs);
>         if (!folio)
>                 return NULL;
>
> instead.

Side note: I think we should just do the "FOLL_GET" doesn't touch the
refcount either, which would make this all become just

          if (is_zero_page(page))
                  return page_folio(page);

          folio = try_get_folio(page, refs);
          if (!folio)
                  return NULL;

but then we would need to fix try_grab_page() and gup_put_folio() and
friends to match. And any other cases I haven't thought of.

Long long ago we used to have the logic that PG_reserved meant that no
refcounting was done, and that automatically handled the zero page(s).
But that was removed back in 2005... That old commit even talks about
this issue:

    A last caveat: the ZERO_PAGE is now refcounted and managed with rmap (and
    thus mapcounted and count towards shared rss).  These writes to the struct
    page could cause excessive cacheline bouncing on big systems.  There are a
    number of ways this could be addressed if it is an issue.

It's commit b5810039a54e ("[PATCH] core remove PageReserved") in case
anybody wants to do some historical archaeology.

               Linus
