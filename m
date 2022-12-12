Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E3464A676
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiLLSF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiLLSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:05:26 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1998D1036
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:05:26 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-144b21f5e5fso9347132fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OFsIR2a+XBWM5qtZB2BAnv6S/IimnBTL+2i5YL4HSn4=;
        b=D1VjW0FlDtT5ez1E2byLGyGMcqmokAEUFt7QdwNUUTO0u5HqE9X9yRN1y3IlcLaWmT
         QYVUKk7dNh4zbGHy7vOemAmWiuxrclkYmO3HFERDd+fZTq83wy92DwWGCcmTM7fAMRuA
         nbRrTiz0BQbykdIlwykC5fJ7luQT3xnHKT5aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFsIR2a+XBWM5qtZB2BAnv6S/IimnBTL+2i5YL4HSn4=;
        b=oFtPmi/witKDYyB60bKDLjsBvvaEFyjdSnFZTL9qK429UlZWR4Kna2ejYOemorbnGE
         Z6KFlKL3AOiFwVZ4MVDNrICXMNNIU7/mfa3U/0WQ0xEO21ok8GNZ3AxUjpZIhadF0zp/
         ipmoecd5RrnlDnIh/x8z9Rx4PS9Xj1PLOeINPJ/D+EOjBlUCLyYNoHdBM1GRxZb8nQTI
         p1MgmSdBae4HpDG99PnE5/zR3JcErvf7/PtsTsqkXF6Rhy6jGqazAuTLDZDvV/z9DVkn
         9FQ50s1R6s7GDHE6Oejl/YPWFeCtF0rpL0G4WNVP1mtb4Bhaf7udSIbrzPVDACuMmO90
         Ee1A==
X-Gm-Message-State: ANoB5plyaOVI34wgd/8Ws9IzpJnzYIBbaHcdcW77ib3WwTKwLeCw1R/f
        d8JBCHTyqMNJxhf0P1oEajEq1GAZBWjBn6q9
X-Google-Smtp-Source: AA0mqf59N9qHFi1MBpA60AtGNTQaqBcpYhhy6R+pp3+P0reeEo6EhVk2hyFVMXmMSH5Fp0cEL+ruRg==
X-Received: by 2002:a05:6358:443:b0:df:6acc:b97b with SMTP id 3-20020a056358044300b000df6accb97bmr591093rwe.13.1670868324760;
        Mon, 12 Dec 2022 10:05:24 -0800 (PST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id dm20-20020a05620a1d5400b006fca1691425sm6123916qkb.63.2022.12.12.10.05.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 10:05:24 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id z12so6706735qtv.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:05:23 -0800 (PST)
X-Received: by 2002:a05:622a:1745:b0:3a6:8b84:47ce with SMTP id
 l5-20020a05622a174500b003a68b8447cemr33323876qtk.678.1670868323427; Mon, 12
 Dec 2022 10:05:23 -0800 (PST)
MIME-Version: 1.0
References: <20221209112500.GA3116@willie-the-truck>
In-Reply-To: <20221209112500.GA3116@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 10:05:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj-8gKB5SG0w_M2fK0KYyhZbNzDZ1W9H5pmisWzJ0XJEw@mail.gmail.com>
Message-ID: <CAHk-=wj-8gKB5SG0w_M2fK0KYyhZbNzDZ1W9H5pmisWzJ0XJEw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 updates for 6.2
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        maz@kernel.org
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

On Fri, Dec 9, 2022 at 3:25 AM Will Deacon <will@kernel.org> wrote:
>
> Dynamic SCS:
>         * Support for dynamic shadow call stacks to allow switching at
>           runtime between Clang's SCS implementation and the CPU's
>           pointer authentication feature when it is supported (complete
>           with scary DWARF parser!)

I've pulled this thing, but this part makes me nervous. There's some
bad history with debug information not being 100% reliable probably
simply because it gets very little correctness testing.

It might be worth thinking about at least verifying the information
using something like objtool, so that you at least catch problem cases
at *build* time rather than runtime.

For example, that whole

    default:
        pr_err("unhandled opcode: %02x in FDE frame %lx\n",
opcode[-1], (uintptr_t)frame);
        return -ENOEXEC;

really makes me go "this should have been verified at build time, it's
much too late to notice now that you don't understand the dwarf data".

Hmm?

                    Linus
