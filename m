Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526B774190A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjF1Twq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjF1Twp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:52:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C611FD8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:52:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98934f000a5so23113166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687981962; x=1690573962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YkBvgE6FKBaRtID8FuxJ3ehb22oG6DMFKjLdz1CVX1E=;
        b=Fcn8JnPCLG/w+KsUn/lG3I4gAz86hv420AP0DHK0zCVxVTgX/ddbS6FIo7VfQr7JvE
         HvXw2M0nQEhm5tZ7XV0rTFWkS5Z7FItk/zwRwC36ByCC0wZW/EgnyL71dUICwSNVMz0v
         X1bnONfDv/EEM378FE4OLNDqgBu8XAzQR46t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687981962; x=1690573962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YkBvgE6FKBaRtID8FuxJ3ehb22oG6DMFKjLdz1CVX1E=;
        b=QgPcf9PxXs4WNxb9DJb31ugpD+2aUlV+mhVhUwDs6OFGZkj7IlL48gfHrhtlUtuw6h
         EGsZhKXzItxs23WbiDMwtR9ZQyogxViWqee7JG3DTaI7jZP8hNp9rxP535vw505kLJ/I
         LmOHvJWyKOEoVaVEWEd8iW823C/8Ne4oZbNuSzTp9GQZxGFtQ66BMsp+8HTC2GMJHIX8
         ueP7sjFxI35lZ6NnMnyDTb67vdNER4xi8s+mEeTJWqgGRgKp9mQTVHI5QaKcVAfROa4o
         unEMDxM0SJTHLUdtya9EEsJnqD051oHF2X+iQKKLhBndJTnjIl8MarRSFKJ3c3mWISxv
         xOFA==
X-Gm-Message-State: AC+VfDzN5B/gsyxJJV/mdz3aA+urI3f2b2Z3KmliHePqjOwp+WcKu370
        T7CFJQZPTjLRjNDNMJPBmL/Zs3ZBnULA6bktUsXk5/AD
X-Google-Smtp-Source: ACHHUZ7xON3k9bD2kZsu0qpwsobUZjxGS/dTKbkWOBQp7fVAjiYP5AdkMGAQR6sgVdiof9JK07GFHw==
X-Received: by 2002:a17:907:7294:b0:988:c97b:8973 with SMTP id dt20-20020a170907729400b00988c97b8973mr23768807ejc.6.1687981962194;
        Wed, 28 Jun 2023 12:52:42 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id gw26-20020a170906f15a00b009929d998abcsm416446ejb.209.2023.06.28.12.52.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 12:52:41 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51d9865b8a2so4525717a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:52:41 -0700 (PDT)
X-Received: by 2002:a05:6402:1353:b0:51d:a679:7555 with SMTP id
 y19-20020a056402135300b0051da6797555mr4623975edw.31.1687981961409; Wed, 28
 Jun 2023 12:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <ZJyECvfrOWhKJj4t@casper.infradead.org>
In-Reply-To: <ZJyECvfrOWhKJj4t@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jun 2023 12:52:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghER2OsCc+H2USU+nmh72QJ-kqTmaHq=YFd=0xaivubw@mail.gmail.com>
Message-ID: <CAHk-=wghER2OsCc+H2USU+nmh72QJ-kqTmaHq=YFd=0xaivubw@mail.gmail.com>
Subject: Re: Reunbreak the MEM_ENCRYPT build
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
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

On Wed, 28 Jun 2023 at 12:03, Matthew Wilcox <willy@infradead.org> wrote:
>
> Probably this is the wrong fix.

No, that looks like the obviously correct fix, I just don't see how we
all missed that stale declaration.

I guess we all had X86_MEM_ENCRYPT enabled, which hides the problem.
And other architectures wouldn't have had the issue.

                 Linus
