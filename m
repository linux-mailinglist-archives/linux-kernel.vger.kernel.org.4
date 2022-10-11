Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204995FAB72
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJKDxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJKDxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:53:47 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4D44F1B2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:53:46 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-132af5e5543so14547689fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gOCfVbhcmfemwDry8i3hJvK3Apv3toHgXqWLJkr3nNE=;
        b=DeN1JB/nmolLys/Yy/JmDaRoMglhhZ3TbR9eVxk4aCEtsK48S6sT94nPiaVhVoqQ/h
         +tV3Ko/3KHZTBeGjKdnhRc5+/9TxKK9+Zj+Kls1rJKDU8rIzz8sh8SuvEB0GTj308DIL
         pDq8XBO1OH+50wwV459S7kDAjk3O0a08z/v54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOCfVbhcmfemwDry8i3hJvK3Apv3toHgXqWLJkr3nNE=;
        b=h2Eos8tajl4+L54U3yS3aRs+VAWhtN2OWf+lkCdMMlfT2wWYFo5JEdwE1ioG50GFp2
         PiJP0RSkLJpn+ScJ4ZIpd+/Oahq/YiGfseL3LPEavcbqeJi6Ff+LkDNmjgHEC52dQyh0
         6E1um+BO6wV8BQCMezla2yXgViwcXD4u4qaM9ya1723TBXjicX8SmRCqfYF0Lw/kHRjo
         +MNxa47cQJCta3+UeXf7Bt0w4q0uptMPzYA6hWK1vJ2QXXLYZzpbWryn3Zs+3M6FvtHh
         lAAjIAFva3PDaj0lYZfnzwS1KNNlfVcHqFIsBIEfvITGwumuJOMWlU5ftd9jxxwESdeP
         e/Rg==
X-Gm-Message-State: ACrzQf2pwq5VSmd6sXPAc56J8YeCr8PAm7EMJfdbQlszByMoAiX+A4JF
        AnZ++IpIVAO7L0KbjTUXeAqlPorxMDc80w==
X-Google-Smtp-Source: AMsMyM4gpwL+CQEWYPKrQnVNOUDxz05GkWzkWnxPhQ5/D+i+WnDunF0mrm7BouUSwDvLJzlmok1AcQ==
X-Received: by 2002:a05:6870:538a:b0:132:756f:2c98 with SMTP id h10-20020a056870538a00b00132756f2c98mr17358392oan.134.1665460425877;
        Mon, 10 Oct 2022 20:53:45 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id u37-20020a05687100a500b00132741e966asm5973568oaa.51.2022.10.10.20.53.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 20:53:45 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id w196so8304933oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:53:45 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr11380013oad.126.1665459963186; Mon, 10
 Oct 2022 20:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221011031843.960217-1-masahiroy@kernel.org>
In-Reply-To: <20221011031843.960217-1-masahiroy@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Oct 2022 20:45:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjP4=XP6E30mRp3OP2swZOrML9Z78kJvKo8ejFi4WGZjw@mail.gmail.com>
Message-ID: <CAHk-=wjP4=XP6E30mRp3OP2swZOrML9Z78kJvKo8ejFi4WGZjw@mail.gmail.com>
Subject: Re: [RFC PATCH] Remove Intel compiler support
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Tom Rix <trix@redhat.com>, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Mon, Oct 10, 2022 at 8:19 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I am sending this to Linus and the x86 maintainers with RFC.
> If somebody is still using ICC, please speak up!

Ack. I don't think anybody ever really used icc.

I can't recall having heard a single peep about icc problems, and I
don't think it's because it was *so* good at emulating gcc that nobody
ever hit any issues.

               Linus
