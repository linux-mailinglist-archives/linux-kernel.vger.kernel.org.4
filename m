Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3F36246CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiKJQXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKJQXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:23:13 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEF61A052
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:23:12 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id u7so1679802qvn.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VmYHgNNHjqJwrUaNfxoZHrfd9p52EEgQvnBlNt6798g=;
        b=WZNvsr/cGlkZlQnZHQ7ukHpybhZOsma84ZERMF6eXoYPHWcNOE1yYMF6vqk/9/8G7P
         ACqJOrw0egzUJjfBO/Td93S13r5/PwpdfyqaobOGPwTR2AnWFgGJEGoTY7joHh8PkhE+
         zgAvlN1NWa2YaXMB6UXKtTUzRapGGrzictsJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmYHgNNHjqJwrUaNfxoZHrfd9p52EEgQvnBlNt6798g=;
        b=fHOre2jmrvNyz0go/FxQk4TPuw4pAfVdqZR0+4pIy9+hIjiATj6sBqIp+N7XtVkxSq
         qWNqKYDpX9hlGg1Gw7ecCWQeTGbugnXvnxLrB41aMiP1wnxTH3f7fT1JPD+VjigTDZVT
         e0lS4fZqvS7GbtWqS4N2Vmwsnuln3ZKhKV6a8xeaPT4fIu1+caA9V6QLpBYjdLhq2yjF
         8EiGQ6GomtP2oCvILiaqthdA8lx18ME54vegeWUhrg5+lJpFRU9m5ZxOJEPCCsyx9HdS
         E7eHwv+PPxfb+GyN39HqZ+726V5Wx46CaFOKsvc61nrb79CQL3XIDCA3FHPoxMGVWTkd
         4GcA==
X-Gm-Message-State: ACrzQf393STXi+IjQH/laMBBjuyDGtHbv3IhfAXukVckTlrPDIEjNrBA
        /INaC0nyXVzQD3MTDHLCLHrvtsWgDCTPHQ==
X-Google-Smtp-Source: AMsMyM6DRKrJIz+Uz5s8I/NwJR9On8MYHc7wZaJ+4Zl6aSyS1m4hCjO/0SNvooU58L7ofLc3XsamdA==
X-Received: by 2002:a05:6214:568e:b0:4aa:a354:4322 with SMTP id lm14-20020a056214568e00b004aaa3544322mr1391692qvb.43.1668097391144;
        Thu, 10 Nov 2022 08:23:11 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id h18-20020ac85852000000b003a57eb7f212sm10544953qth.10.2022.11.10.08.23.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 08:23:10 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3704852322fso19873847b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:23:10 -0800 (PST)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr64285233ywr.58.1668097390015; Thu, 10
 Nov 2022 08:23:10 -0800 (PST)
MIME-Version: 1.0
References: <20221110125253.240704966@infradead.org> <20221110125544.460677011@infradead.org>
In-Reply-To: <20221110125544.460677011@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Nov 2022 08:22:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg8UrshBBLioF0+FaJvAkSTRkH3-aqKT3eAWHtBp57hxw@mail.gmail.com>
Message-ID: <CAHk-=wg8UrshBBLioF0+FaJvAkSTRkH3-aqKT3eAWHtBp57hxw@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/mm: Add a few comments
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com
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

On Thu, Nov 10, 2022 at 4:58 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> It's a shame to hide useful comments in Changelogs, add some to the
> code.
>
> Shamelessly stolen from commit:

When the comment says how the image is mapped into two places,
wouldn't it be good to also have the reason *why* rather than just
what..

That said, my real commentary for this patch set is not that
particular instance, but the bigger picture - that this code is still
a bit opaque as to why these things are done.

Do we need any of those alias passes at all for pure protection bit
changes? I thought we only did these because things like cacheability
bits have to be in sync due to machine checks etc?

Or am I missing some case where writability matters too?

                   Linus
