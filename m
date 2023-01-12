Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091A2667CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbjALRtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjALRs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:48:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1981C2;
        Thu, 12 Jan 2023 09:07:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBEB5620DD;
        Thu, 12 Jan 2023 17:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF282C433F2;
        Thu, 12 Jan 2023 17:07:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Wk5g94HK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1673543237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bo+4o9ecRuWQAULzjRnTX36y4m2WZrU7x5GwaBNbhRo=;
        b=Wk5g94HK2InowF/YblDxQsxIy/HufC+exR9T0+P/9Rn7dND8O7GeBZbzJetr7hDjrh1WR8
        6Gow/v6LZVvxxqt0kdS0XbSQGgOwEHULYRDlGY6cVr+4QogSx0gmSr3tdGt7B4LnhK2Dlv
        2MTCWNDcab+lW9lJ6iU8FP9XCNb+Amg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b9abb93c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 12 Jan 2023 17:07:17 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-4bf16baa865so248040177b3.13;
        Thu, 12 Jan 2023 09:07:17 -0800 (PST)
X-Gm-Message-State: AFqh2kq4ocOpfDpSHg56tDkR7pJzH5FNfb14H6RSfcWFUfel7YssIj3q
        fWaaHmFhMWRcnks+0mV+yqO3XruQeoojwHvTspg=
X-Google-Smtp-Source: AMrXdXu8wGhElXrMWrgsFmaFlR7xkdlebsoi3KQxYHuYSx+BjzN5pdPg5gY35op7/ryV/ak/rl7R9TiMqS12Nj+4x68=
X-Received: by 2002:a0d:fc87:0:b0:4b8:1d2a:31 with SMTP id m129-20020a0dfc87000000b004b81d2a0031mr4005903ywf.79.1673543235792;
 Thu, 12 Jan 2023 09:07:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1673539719.git.ydroneaud@opteya.com>
In-Reply-To: <cover.1673539719.git.ydroneaud@opteya.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 12 Jan 2023 18:07:05 +0100
X-Gmail-Original-Message-ID: <CAHmME9oXB8=jUz98tv6k1xS+ELaRmgartoT6go_1axhH1L-HJg@mail.gmail.com>
Message-ID: <CAHmME9oXB8=jUz98tv6k1xS+ELaRmgartoT6go_1axhH1L-HJg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] random: a simple vDSO mechanism for reseeding
 userspace CSPRNGs
To:     ydroneaud@opteya.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry Yann, but I'm not interested in this approach, and I don't think
reviewing the details of it are a good allocation of time. I don't
want to lock the kernel into having specific reseeding semantics that
are a contract with userspace, which is what this approach does.
Please just let me iterate on my original patchset for a little bit,
without adding more junk to the already overly large conversation.
