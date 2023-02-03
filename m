Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8330A689DE9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjBCPRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjBCPQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:16:04 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9633FAF0DE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 07:13:54 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ml19so16344834ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 07:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4gNT9v9wvK0aEmB6F4uZINVDMJ/+G9kVEywmGPNk78=;
        b=u+tyikGVZq2dblixZ2OhrzsVymoJs/te6CTw7RNRqAdzWtkJG5/Je1YW8qeEqApCjX
         PK/+0MmLQ2WndKKWCjLgm63zSClRKoWgPJm3cG/SZXbqDIs5a0KBbMrYWNNuPiPiKGYZ
         36ngwMnB5QLWM/kM/mY/9r2CFTn5YZA1FvUr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z4gNT9v9wvK0aEmB6F4uZINVDMJ/+G9kVEywmGPNk78=;
        b=5SIsrdQ0/9vbVjausz+RKRsCWaYHXkHrQot3k6LGlow1lzwXaLCGWLTwbZg9mobpK8
         dTomI0IztD8QrK6XReQXTxbtkCSmb5dzoT1XkVQ+VGT2m/XSIJINJB+MVQWibULNhREt
         R20GknEdnCjlOPtJCJ07ZMfMikjSQG7QwryUd456CasXVp7Sxph8y8mqPNQ1/Id3OKdN
         C5LC3tAbMzm3TKToJwxtVuPYNWKrdHBNhVniiStP/B+Kr0hVpfaygwqQEe20b7SRJ8Hu
         U0oPuZhg0cVr6HGitisK/CMykYhGqticBIRuxm9+suzIcf1z7BO6ZOWfnNUqwSPjNdyS
         VfVA==
X-Gm-Message-State: AO0yUKXfgm9JrmBGMBwsBJWLVNN4xzpaoWCFv6uyBiLNIb2GafWMMEqf
        0naN7jEl8SAqhkqKf4gkWl33XOcShMUJNoHzT1K1VA==
X-Google-Smtp-Source: AK7set+fIGyYrGAWc7/8wl0F7re+lFqHUPpfLdgqWaULgZZeM1ejQ/y9ibnxaGFY2MYwUzuLqtu60JTV6Pbsw5yRB/0=
X-Received: by 2002:a17:906:1ba9:b0:888:3594:6d58 with SMTP id
 r9-20020a1709061ba900b0088835946d58mr3419959ejg.55.1675437131386; Fri, 03 Feb
 2023 07:12:11 -0800 (PST)
MIME-Version: 1.0
References: <20230131-tuntap-sk-uid-v2-0-29ec15592813@diag.uniroma1.it>
 <20230131-tuntap-sk-uid-v2-1-29ec15592813@diag.uniroma1.it> <CANn89i+QMipmfOywjAX2jqZGs80zorE6yKFOsi9rXQbToZLbhQ@mail.gmail.com>
In-Reply-To: <CANn89i+QMipmfOywjAX2jqZGs80zorE6yKFOsi9rXQbToZLbhQ@mail.gmail.com>
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Fri, 3 Feb 2023 16:12:00 +0100
Message-ID: <CAEih1qXHkgHzqk1yXd=iX9fiMCkJW95eoytc1t5-VRMPhfTRNg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tun: tun_chr_open(): correctly initialize
 socket uid
To:     Eric Dumazet <edumazet@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2023 at 15:58, Eric Dumazet <edumazet@google.com> wrote:
>
> This seems very fragile...
> "struct inode" could be made bigger, and __randomize_layout could move i_uid
> at the end of it.
>
> KASAN could then detect an out-of-bound access in sock_init_data()
>
> I would rather add a wrapper like this [1], then change tun/tap to use
> sock_init_data_uid()
>

I agree this is a much cleaner solution.
I'll wait the usual 24h for further comments, and send a patch like this in v3.

Best regards,
Pietro
