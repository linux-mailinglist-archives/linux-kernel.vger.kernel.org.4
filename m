Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605C6613E21
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJaTWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJaTWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:22:48 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AAB12AD4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:22:47 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id j6so8933489qvn.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sciERuMLNoW/sQvWoRQ/tsCXdcXQIXsZ9vYLgBntz0s=;
        b=PRwNE+r/CecIAk6SsdRE0zAYb5VIWHJOUdwJPZGYrHEikyM2x2cWKL19AfuzpMpYah
         tvlSiLkCpXdKtms6gHrNBQS3dYEs6kJ08xwGpB/o8ZOi2aV7agzVKttckPIAWWGIJsIt
         eMEEyEXkV3CMMjMCzuTbtiXbV2AAF8rr0FpW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sciERuMLNoW/sQvWoRQ/tsCXdcXQIXsZ9vYLgBntz0s=;
        b=cZ8r/7ki6/5gdGMByls/7eD83/K/+T/dKNNz4d/IBjW2JXI/yObkSvd6VB2DhHDK2X
         +mvLigEU/yZDKdIoH1KJFtPlgWnKasoFRIHnc7j5/ALzugzG6YBNINU1NtqBjlHFNACt
         sNbTPeVRdUx9iHY7btZjtAhrQReRkcLos3woHRG6W3TjgTYyWTDXqWnPu2R3ikADqj5e
         ZyKyO0QqLqGZImTecj7WjCu0QRhBn2RNFfKZE2fYj3QYufo0MTbPgWfi2e1VOvsIfpdB
         63HydX/1XgNnE2VyzX5/3rQkp0bSz6mrt6lIxtck68PkQQP+nPFvdkmb5SDRLymv8H2M
         QTgA==
X-Gm-Message-State: ACrzQf2eBnYWXb9LlLfs0y1CfyW6h/4lEcQG7e9j3EtL0J18IBGA64ul
        xLft0O/TY+yKkTav8pFKRnW4Zwyr0+66UA==
X-Google-Smtp-Source: AMsMyM6XonSiVo2FWP3ukBlPz+cVXVBk/U68RPvPRX7bSn60i8+0CWA6erD0ThKyoGFww+Fkv8VuKg==
X-Received: by 2002:a05:6214:20ee:b0:4bb:938a:a0ff with SMTP id 14-20020a05621420ee00b004bb938aa0ffmr12402443qvk.120.1667244166795;
        Mon, 31 Oct 2022 12:22:46 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id bs11-20020ac86f0b000000b0039cc82a319asm4053874qtb.76.2022.10.31.12.22.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 12:22:46 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3321c2a8d4cso117152357b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:22:46 -0700 (PDT)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr15021131ywr.58.1667244165839; Mon, 31
 Oct 2022 12:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhSSafrkW4VbTVoAUJmjFQdCwPTGDqTP8yBnLBqc7rW7iQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSSafrkW4VbTVoAUJmjFQdCwPTGDqTP8yBnLBqc7rW7iQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Oct 2022 12:22:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_6Df1NAMs14S0OOqX1Z=460j-mfwn_qm-7EK1eK76qw@mail.gmail.com>
Message-ID: <CAHk-=wj_6Df1NAMs14S0OOqX1Z=460j-mfwn_qm-7EK1eK76qw@mail.gmail.com>
Subject: Re: [GIT PULL] LSM fixes for v6.1 (#1)
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Oct 31, 2022 at 4:07 AM Paul Moore <paul@paul-moore.com> wrote:
>
> A single patch to the capabilities code to fix a potential memory leak
> in the xattr allocation error handling.  Please apply for v6.1-rcX.

Pulled.

However, I react to the strange test condition. Sure, it's
pre-existing, but does it really make sense?

It does

+       if (ret < 0 || !tmpbuf) {
+               size = ret;
+               goto out_free;
+       }

and how the heck can 'tmpbuf' be NULL if vfs_getxattr_alloc() succeeded?

I think that's not only impossible in the first place, but if it *was*
possible, then that

                size = ret;
               goto out_free;

would be wrong, because this function would return success even if it
wasn't successful.

That whole "cast to int, and then cast back to size_t" also smells of
some serious confusion in the return value handling. It looks to me
like vfs_getxattr_alloc() fundamentally returns an 'int', not a
'ssize_t', just by looking at the ->get function. But it just all
looks weird.

So this code has all kinds of oddities.

               Linus
