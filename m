Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2388468F245
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjBHPmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjBHPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:42:41 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC6F1B313
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:42:37 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id fi26so21017751edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 07:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBpdGA6mtrbnlLXhrldNvYUwXI0WI+DySVv9XI8e+Vk=;
        b=RyEecQn5YMAw7Ae8YRSta8sKtN6epFcC9vsjG+EygrSU60JiKWNCI5WadCowwvZKc+
         f6Y9/prFa9Rfg6/JkjlrR1bn/3htTI3P+IjHKi9b9YMncsOQhDHY4NOAxHaxk/Wa3Hin
         HSBMJ0EThB4SXjbXitRrTfLruxCAbFpbZ/W8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBpdGA6mtrbnlLXhrldNvYUwXI0WI+DySVv9XI8e+Vk=;
        b=zLPbZAZPNAEY2AtFqtsLAU3SzhFg9AKE/xel6NIZ63/JU+ODWqYsbnSiPZd/cp9a2g
         ofph0+7tZfrWb/TK2AykQXTWhMls2LVC43N3ZI+lc72yEGaH99OqZw1kVpJGePcZdwSn
         TnknsvBwmViU4HT4VMk9oFQKDrEnv5UUXg30Oxb0gfHMWlfwV51Vo89srpPNFEb2fyrH
         Z9+U+Y/BxGGhj4ud19XQNXCq+3AQSFt7oyVhoQ5rA62iqogl5ZoaY+EvBfljhzaiU3Np
         dlQFuU9El6pjM4EdZrRVMvU/86WpvvPzM9NODSgCdBHFQgRybsBQJW5ap+DTu3P8tsm9
         x+FQ==
X-Gm-Message-State: AO0yUKUzK2GPtGVqJfPyiwwb1R9cokGB6U8/hNCZxRQSZDrbxE6sCLKC
        wZDz02RAhEgZvylIaoPPz9ccYAuitdl3OF5YSglGlg==
X-Google-Smtp-Source: AK7set+XI3UwwolKkrkk3BfkfAuRtmrLdVlxbEWLjTTh/i8yr2lHDs4Yk5A7YXvCv+sTfj8JVASRfw==
X-Received: by 2002:a50:ccc6:0:b0:4aa:c4bb:2372 with SMTP id b6-20020a50ccc6000000b004aac4bb2372mr8430746edj.32.1675870955942;
        Wed, 08 Feb 2023 07:42:35 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id es26-20020a056402381a00b00488117821ffsm8031006edb.31.2023.02.08.07.42.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 07:42:31 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id hx15so52079324ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 07:42:30 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr1655453ejw.78.1675870950517; Wed, 08 Feb
 2023 07:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20230207072902.5528-1-jgross@suse.com> <20230207072902.5528-5-jgross@suse.com>
 <CAHk-=wi53OX86-yLBp4rCHOH67XhVbzV78qa63mh4-rOhxQSLw@mail.gmail.com> <59a24334-35c7-8afa-f35d-d654dd2823ba@suse.com>
In-Reply-To: <59a24334-35c7-8afa-f35d-d654dd2823ba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Feb 2023 07:42:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWAv7gQewr=i=oOD+89CFjAzaXiotUb2wS+oWGUP6z+g@mail.gmail.com>
Message-ID: <CAHk-=wiWAv7gQewr=i=oOD+89CFjAzaXiotUb2wS+oWGUP6z+g@mail.gmail.com>
Subject: Re: [PATCH 4/6] x86/mtrr: don't let mtrr_type_lookup() return MTRR_TYPE_INVALID
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 10:20 PM Juergen Gross <jgross@suse.com> wrote:
>
> Are you sure? In the SDM I'm reading:
>
> * E (MTRRs enabled) flag, bit 11 =E2=80=94 MTRRs are enabled when set; al=
l MTRRs are
>    disabled when clear, and the UC memory type is applied to all of physi=
cal
>    memory.
>
> So UC it should be IMHO.

Right you are. I clearly misread that section when I did my original patch.

                Linus
