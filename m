Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4A5F3ABB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJDAim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiJDAhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:37:45 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A7529839
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:37:42 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id k11-20020a4ab28b000000b0047659ccfc28so7833375ooo.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 17:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CupQOeUKXJkWlXPxrTf4vCGbL6f1ZdOjDUJRm8zc9XY=;
        b=MH0NJOASqE96lQWbox702Ai05A2Fb+2DSRXfibN+MwLmlzpCquaztIbFKL0jw6LrdA
         K59NAN8n38yO0UJDR5O/d/2tVPFOUpAjAqi2JRBLeNk7v9W2U5L9pJ5kiTXOZTtzvk7u
         hIO/AVkCbnfKgoGAouXN4uiUn9p9sVKM+c+5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CupQOeUKXJkWlXPxrTf4vCGbL6f1ZdOjDUJRm8zc9XY=;
        b=UL+fp3zmO6kNgLofJEyo09Z1JwCWJSd27Y7ozkz19pIsEqbPGQXxQxXd3CoLZMYG5d
         E2Zi5RkaY3AzFkel72WuFOkYUKVqAtZs4VOM772tRp2QLJWoPFYOs2cjM23hhU9rbrie
         Zvjzxkbi8JXOr32QaC1V1zguVhnhMIiJD1p1bUecbfEFP10yu5nU25y96yBDxdcgkcjE
         lyxKb79jwuQTkmeV8teLtzQK4Um/jfDX5SY46GwPA5whVhjpeowpboSw59uJRdtzvz+l
         j0V33GgpPWCJhVnvFwJPSpysmZ7DoWD5brlokyCHy1RKi9lyQ+WcnPbQartFRyMKO2qZ
         XQoQ==
X-Gm-Message-State: ACrzQf35BZkS3vp+tV7kiBMB/sdWiaPBrdrrlHwnINz5fZlWQZXFqwe9
        vfa+2dijMjs2kHCxPP4ZgamCpl4k35RrnQ==
X-Google-Smtp-Source: AMsMyM5ll6dFiH2QfIAH3X6eTr6RGARCHEMGiCkHSwqwNv1ZphmeEj7JBib5yCndmulm40HcVRtEsw==
X-Received: by 2002:a05:6830:1b69:b0:65c:836:3cff with SMTP id d9-20020a0568301b6900b0065c08363cffmr8735995ote.58.1664843860929;
        Mon, 03 Oct 2022 17:37:40 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id k104-20020a9d19f1000000b00616d3ec6734sm2684540otk.53.2022.10.03.17.37.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 17:37:40 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id w13so12952046oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 17:37:40 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr5077414oif.126.1664843859992; Mon, 03
 Oct 2022 17:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <YzN+ZYLjK6HI1P1C@ZenIV> <YzSSl1ItVlARDvG3@ZenIV>
 <YzpcXU2WO8e22Cmi@iweiny-desk3> <7714.1664794108@jrobl> <Yzs4mL3zrrC0/vN+@iweiny-mobl>
 <YztfvaAFOe2kGvDz@ZenIV> <4011.1664837894@jrobl> <YztyLFZJKKTWcMdO@ZenIV>
 <CAHk-=whsOyuRhjmUQ5c1dBQYt1E4ANhObAbEspWtUyt+Pq=Kmw@mail.gmail.com> <Yzt+xvE88/OENka+@ZenIV>
In-Reply-To: <Yzt+xvE88/OENka+@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Oct 2022 17:37:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiL2=FfSQx0pHkWAQW29Rc-htDtCouOe6Yp3r5C0tHPwA@mail.gmail.com>
Message-ID: <CAHk-=wiL2=FfSQx0pHkWAQW29Rc-htDtCouOe6Yp3r5C0tHPwA@mail.gmail.com>
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on kmap_local_page()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "J. R. Okajima" <hooanon05g@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
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

On Mon, Oct 3, 2022 at 5:31 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> OK, incremental is in #fixes, pushed out.

I'm assuming I'll still get a proper pull request. No?

              Linus
