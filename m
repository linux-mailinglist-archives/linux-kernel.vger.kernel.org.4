Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C639675B62
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjATRai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjATRaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:30:35 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7DFDBCC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:30:30 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id q125so6483896vsb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PwZXs6K2a6IO3sOCpDdgAJceFEm2RB4apdmb8kQpbx4=;
        b=UygCEQw1sNdw6KDAK8Wc8jwv9kTrpdaJXi1VB0GAYtAaOEdRXr7Ws25t3NUivaeRWR
         rOJLsa9Tl8Q5oZBeAoBNZUBFMuQR6xiX/AzGdzWBMqgadk3zhdxsOxtXW28u4jihafN1
         8oY/CwiNnCMHyUYN9cLIlZ6oVwjw6TFQYCdKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwZXs6K2a6IO3sOCpDdgAJceFEm2RB4apdmb8kQpbx4=;
        b=1bAwClDo0hohKQY09LfDddbrQNEXv0RC/LKruQLsIegskTd+cyG1Hu6lH6CV982fR8
         DieASqekMCTpTWgkBo/yJXw6lEHT/fNwg6+oS5WmfK7i98T3uPxhEb2yPFrp/snOUzGU
         K6evg8TAQsz1So7qBqZsLhHLUscxSSUJMnW+lpxKrv6jln+VhdSUlIx+B6BaMQwC4xm5
         Yfssr47NmloSM0RUBr7fvu/Ldk5ajhCm3OcORpSlOwNVtGuCj2BKePJjUjzTQqYC2KkV
         kYH4RaETYjbyhJz8n+9bCriG2KfDvwcDdLqgukA3RmjPZUNkY7jRBUe8WK7t8e6cYtNK
         Xubw==
X-Gm-Message-State: AFqh2ko8qbWCKpduIKwRN3B4bBec9YEjkEwGXsoZNFDkk7QQFG/16Ft+
        meSUeEn77/O7plxN4XI1U6ln/PmZsCQwdx45
X-Google-Smtp-Source: AMrXdXvk3zZoWrP4CIQIW2jnNczFBKzASLoOPX62s3IMdvyXxiIcO3h5+OUNfwGE57fyr88meg5U5w==
X-Received: by 2002:a05:6102:1497:b0:3c8:eae:37a1 with SMTP id d23-20020a056102149700b003c80eae37a1mr12583982vsv.24.1674235829720;
        Fri, 20 Jan 2023 09:30:29 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id n15-20020a05620a294f00b0070383f1b6f1sm26968695qkp.31.2023.01.20.09.30.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 09:30:29 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id s19so3253142qkg.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:30:29 -0800 (PST)
X-Received: by 2002:a37:45d3:0:b0:706:96dd:8d4a with SMTP id
 s202-20020a3745d3000000b0070696dd8d4amr761386qka.336.1674235828818; Fri, 20
 Jan 2023 09:30:28 -0800 (PST)
MIME-Version: 1.0
References: <20230119185300.517048-1-kuba@kernel.org> <20230120085114.6c30d514@kernel.org>
In-Reply-To: <20230120085114.6c30d514@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Jan 2023 09:30:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgsKaO7qxOso_PrmsBEfpN-Wot=V0fUAy3oKOSFuAQxVw@mail.gmail.com>
Message-ID: <CAHk-=wgsKaO7qxOso_PrmsBEfpN-Wot=V0fUAy3oKOSFuAQxVw@mail.gmail.com>
Subject: Re: [PULL] Networking for v6.2-rc5
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
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

On Fri, Jan 20, 2023 at 8:51 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> v2 coming, in case you haven't pulled yet. Extra stuff went into the
> tree overnight, insufficient communication between netdev maintainers,
> IDK..

I had actually pulled it yesterday, but apparently I then forgot to
push that out.

So I undid my pull and will do your v2,

               Linus
