Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F5D5FB906
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJKRPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJKRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:14:59 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C3A1CB04
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:14:58 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id g130so16524751oia.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=akSw3L4tXJn15h+rqf6OOe1YNGJBaeQhRdSOOStqs9c=;
        b=De/JBOnEdP1ufh7vDr8fXSZZDpjnBhebU79lL5iJtUsfycnzsgRAgat658iJWNu/jJ
         YBUrpRqGlHsgKk/gKviPxhpx3s9sHwsCXXku0cuCbRTEymswXTU/fIreLOMWO4zTmv5a
         KHojpeuuT97P27cCqMumooqZ1YVW4RfedNA0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akSw3L4tXJn15h+rqf6OOe1YNGJBaeQhRdSOOStqs9c=;
        b=z7VuCrivIv2fyfkR0enUYE7FBxax5kIPRYwalenil/0+9XFKisXu2BK/BFrssQhDKZ
         jMgCay8sis8OUg6AVRcdBr6cNWyhYe23/JkuK68MRkUsdy3PtbLNhnNrOsEIy+6e9igb
         h1JxeQVXgc8F7YkQQwoTxl0n8oKqUmozLesDfKcBXXM9+NU6pSEzq2V34PvR+QAvfsxa
         xXsWlAq6zVKl1ETNmnOlvIUwnvTCi4Gsm8UgrETs21O8ik5ZlsV+CLJAk77ECoNwf9gi
         0yLRtFuQRB/G7P/GDvT2gsevpAdLj0b5yo/GoN4nAoQPpcMP0WGefEh8VnpkKOs1X1ml
         w2Jg==
X-Gm-Message-State: ACrzQf15rWFdNopAB2AJ7ku1rE4hioT/v/Slk4O7mAoB7Zb7dahRovQv
        dKJx03zJlVoqe9+KOxFYemmNGT1YtT9MRQ==
X-Google-Smtp-Source: AMsMyM7C6F/Kh1cBi1gHHswowDljTD+BpQbf/GsmDtQ6FCzWQNZrbFspRp86sHJkFbxpYSNZ3pOWRQ==
X-Received: by 2002:a05:6808:2129:b0:354:9dac:295a with SMTP id r41-20020a056808212900b003549dac295amr65591oiw.109.1665508497502;
        Tue, 11 Oct 2022 10:14:57 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id b15-20020a056808010f00b00354932bae03sm2397023oie.10.2022.10.11.10.14.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 10:14:56 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id n130so337045oia.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:14:56 -0700 (PDT)
X-Received: by 2002:a54:4899:0:b0:354:add8:52ab with SMTP id
 r25-20020a544899000000b00354add852abmr57413oic.229.1665508496109; Tue, 11 Oct
 2022 10:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221011035910.39171-1-joel@jms.id.au>
In-Reply-To: <20221011035910.39171-1-joel@jms.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Oct 2022 10:14:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEGAQbp3jTN+BhutOJOV+3XZyfuDqQRw+Hj0Hk_Z-gvQ@mail.gmail.com>
Message-ID: <CAHk-=whEGAQbp3jTN+BhutOJOV+3XZyfuDqQRw+Hj0Hk_Z-gvQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix 85xx build
To:     Joel Stanley <joel@jms.id.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Mon, Oct 10, 2022 at 8:59 PM Joel Stanley <joel@jms.id.au> wrote:
>
> The merge of the kbuild tree dropped the renaming of the FSL_BOOKE
> kconfig option.

Thanks. Mea culpa. Applied,

            Linus
