Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78CD65BE32
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbjACKdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbjACKco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:32:44 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3549E10059;
        Tue,  3 Jan 2023 02:32:20 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u18so41795410eda.9;
        Tue, 03 Jan 2023 02:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v68bOoCkR5Tf7INS4xaBH/vNbNABqgbVmisl8n1c8os=;
        b=APp/boIlEzVSZyYU1Gyb8hYMdMSDN7Vy2kh43Ip09ilk29PnlWASTAQCVFadgXSV7a
         Dx1d0tk/DrrwR9Fk8ccyzI48+1raEPU/heOf24L7Sq00C662Vp9BXdNWgdyDKNAEZQ4h
         1AtpgN5lWLAxkPTaps3rxH7goKyE9orSf6DHYEfxesR101lsGLf9NPOr4SBUJ00kJKYH
         EfK3xAwbP0SgBYgBZluMpJ2+tlMPLpurCTHruBA3UwEsXeQ0LQJjPNxHuSv9LjGfpHqW
         sVrqJ9fyI/2BpC117/KVGgooZFMFT15xytKbe7utLTgI4BXCo5dI950ReI6pcTe3Rt/j
         2fGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v68bOoCkR5Tf7INS4xaBH/vNbNABqgbVmisl8n1c8os=;
        b=zqUIzYMbumfFByc4SS4VrAjH/v1ek3jY/6UIbH/6n7WlPMh2h0Q+91PoNQgJgFi9Nh
         /s7rDIFDg0Kbi8TFvcioqA1jL3VXUB7HT74D0jlvYAtBXLciHUF6gWiNrA0+2NAr0wLv
         m+/iSSA+zdtFCoiQT0Sxz9bIZ8u6+I+lVQ9NEGOuuBZI3E+vJ3DrKq9ioV3bw+tS5NHG
         9Ks6gT5bqsmpAqkCJerltSXJoTaDQFcERmuPigfT5RBWc93ZeJOP8PvkHmDevNiP52Y3
         OrgilEnDkGnmg8O34EIBYpWbU4lXbanEjFAahxt/8ZUN13PTz2YrxyQiFGV53mutCIrN
         YkNg==
X-Gm-Message-State: AFqh2kqLWRiV4Pd7PCCeJEduV4OQgymT3nPPyPs+wO7Tk47iXhqLRCBJ
        jM5wYnmFjZVyxyRBuhVv6kxvqWclo6g=
X-Google-Smtp-Source: AMrXdXu28DjVmzTZWJ65IPFE5UzkCMj3obws/ToJ6HzK7ruWFBn/tXvuDNKK93bFiOhX1lvTVmMaLw==
X-Received: by 2002:a05:6402:12d4:b0:45c:835c:c6d3 with SMTP id k20-20020a05640212d400b0045c835cc6d3mr36173805edx.4.1672741938632;
        Tue, 03 Jan 2023 02:32:18 -0800 (PST)
Received: from gmail.com (1F2EF380.nat.pool.telekom.hu. [31.46.243.128])
        by smtp.gmail.com with ESMTPSA id n20-20020aa7db54000000b0047e6fdbf81csm13616526edt.82.2023.01.03.02.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 02:32:17 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Jan 2023 11:32:14 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v14 1/7] x86: lib: Separate instruction decoder MMIO type
 from MMIO trace
Message-ID: <Y7QELo9etPM8Tpx5@gmail.com>
References: <20230101162910.710293-1-Jason@zx2c4.com>
 <20230101162910.710293-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230101162910.710293-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> Both mmiotrace.h and insn-eval.h define various MMIO_ enum constants.
> Rename the insn ones to have a INSN_ prefix, so that the headers can be
> used from the same source file.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/x86/coco/tdx/tdx.c          | 26 +++++++++++++-------------
>  arch/x86/include/asm/insn-eval.h | 18 +++++++++---------
>  arch/x86/kernel/sev.c            | 18 +++++++++---------
>  arch/x86/lib/insn-eval.c         | 20 ++++++++++----------
>  4 files changed, 41 insertions(+), 41 deletions(-)

FYI, I've applied this fix to tip:x86/asm, as the fix for the namespace 
clash makes sense independently of the vDSO getrandom feature.

Thanks,

	Ingo
