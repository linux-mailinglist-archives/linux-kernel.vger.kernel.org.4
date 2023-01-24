Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B04678DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjAXBvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAXBvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:51:20 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08F939B81
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:51:18 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id s4so11995359qtx.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc29y/67bAFoLlAsTJKkkXERX+cLita5Lt66CltgCnw=;
        b=fUQOd72L31bn4Cg+3sSq8xIhvzYLuw8BAyzrT9icuqeZv8T5xqW3e8gvWrac8CO8ar
         NTNS0HHmgakLe/W8CP11YsrsW6DraN29enGGsw//TIkney5EKec20GmmSDZsrRkQAiOM
         01rKPEd0C/PFJ1CkaN/qO7S0DA7pWsbA6tyHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hc29y/67bAFoLlAsTJKkkXERX+cLita5Lt66CltgCnw=;
        b=OzBimpDqaoa7q+YqnAI8EqqenbOuj629UZ6WvpA/7HHBTF5ezJjwsrOvWQ5V57vTlL
         xH0uNn2p1GA0zh01Q3+BwIeZIXEm2DaaR9JiEFXtT3/WWE54oNz9/S7SIlhMO45XnrWD
         zWRYZPpC3PQJI4CcY0VELDGRq7fkEEokrbypPQnmPLFufPx6QxcgWkeO5tpubIIZiLEh
         2LISBIVHYcBAenMdd837AC10FjvUEVyniWa3Y8eRZfGpkROIT1LdglipQCN7naTGSCUj
         aWFZsz+jEDJBS9WA9MeYscybg8ZDwfZhGa63w07JEJYysENDwlac4ZSC/wp7QlGI5TJv
         UGaA==
X-Gm-Message-State: AFqh2ko9yfHfyPs6qLyqzaxEI+aTHxakLeFVitl4kibNpMZteFje7eod
        PH/f5gV8+X599Oo+wPHTPLHEuTa3CF+DlNyV
X-Google-Smtp-Source: AMrXdXtlbDO6dMgn0eu5lLoNXDWPED5pp40mYBqwnFEQdQFGMuuEOGD3IK7J+eB3D8/axaPMTelv7Q==
X-Received: by 2002:a05:622a:1b25:b0:3b6:9d64:a3a5 with SMTP id bb37-20020a05622a1b2500b003b69d64a3a5mr22168199qtb.43.1674525077770;
        Mon, 23 Jan 2023 17:51:17 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id 3-20020a05620a070300b006ff8a122a1asm548354qkc.78.2023.01.23.17.51.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 17:51:16 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id h11so7401013qkm.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:51:16 -0800 (PST)
X-Received: by 2002:a05:620a:99d:b0:705:efa8:524c with SMTP id
 x29-20020a05620a099d00b00705efa8524cmr1319577qkx.594.1674525076628; Mon, 23
 Jan 2023 17:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20230118150703.4024-1-ubizjak@gmail.com> <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
 <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
 <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
 <913c01d41f824fa8b3400384437fa0d8@AcuMS.aculab.com> <CAFULd4aDORSrq7zf_LcAZRP8HOHcrq2-rGMaroKyG2zQDHNpOA@mail.gmail.com>
 <CAGudoHF6zbyzza6xysuCjcxjHAUgeAVvgW0sqxDAFQNwz9u7wg@mail.gmail.com>
 <CAHk-=whUSZk1dZrJuhxeb4qB3POstVRwOZCN8PXd3W7ztbqQBg@mail.gmail.com> <CAGudoHH+SmRoyXvppjBEoK=dvVdy1jvKNHDLEVf9mLnzsEds6Q@mail.gmail.com>
In-Reply-To: <CAGudoHH+SmRoyXvppjBEoK=dvVdy1jvKNHDLEVf9mLnzsEds6Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Jan 2023 17:51:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiRtgOweogzkky6phOSCySWRzWmDQ1S7J5xxQR2UCJ+dg@mail.gmail.com>
Message-ID: <CAHk-=wiRtgOweogzkky6phOSCySWRzWmDQ1S7J5xxQR2UCJ+dg@mail.gmail.com>
Subject: Re: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Uros Bizjak <ubizjak@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Jan 23, 2023 at 4:11 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> On another point how to end up dealing with lockref less, I have to
> note glibc switched fstat(fd, buf) to use newfstatat(fd, "", buf,
> AT_EMPTY_PATH) internally.

Yeah, that's just plain stupid.

I don't know what the thinking (or rather, lack-thereof) was inside
glibc for that one.

              Linus
