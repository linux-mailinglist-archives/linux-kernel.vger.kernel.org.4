Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A0B5FCAF1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJLSsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJLSsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:48:32 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E6FC4C12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:48:31 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id j188so13041367oih.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ESROyxdmNaMCuLAvwDxLztz/p3doaWu/k516wwQHrw=;
        b=TxUslp/5MFOT246DWlq1s20VNKGGSSTTxByLdcsEMJmdAKLTiDSE0c2Hq5L+HVw4JY
         W5kDSqOsorAPAC0AWFewpZG+wc6mkemgAROu3M43P7g+Nr+xOV2FWfEaSoXlwIz/0n0U
         SxfcCTSnFEGvvBl9RwIWsBnbuy5EkfYyyf6ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ESROyxdmNaMCuLAvwDxLztz/p3doaWu/k516wwQHrw=;
        b=HBUGcA9zWN6QzBIzZhDe47n/ljAChDdLlWCfVrX/eZ+88vtrERdf+oAgeOVZ88+8gV
         IglLutm0uLFnlQ/EgzH1K/nSSr31rEO5mfVdzox9DhOPdqRsC0oe+4h6TwR5bu5HYyoV
         G4JkoEVKUISp9yNR25YZNAmkKbp7ky3sJXnVPP4UfrjxGbA2WBUtj8/c1dtLhbAgy8S1
         ChOCoYCKx+q6ah74xQfm4FvZFqBaAIc0gs0+ELPIxZuMT1L5YtulfTLhBsoNzoS9k46r
         sDXTW6oN86h0Rn+usxIVXXUzgTloGrKe5bFxjkLoSJIpc2byc642ca0GE6Wt6TyvpT6r
         mbqw==
X-Gm-Message-State: ACrzQf3v7Sb/R8TnK/Ve7d4+iVLOZCNyseoCLDBq8BkiYmn1sEYTGktR
        XMXKrbFAZr4Ebd+C0Susii1RnXhEMESm/Q==
X-Google-Smtp-Source: AMsMyM7Meb1e9mDw4XmnmUzGLAdZVqeHzpUxA6/IaEP2PbDgWStr4JpWAvDyluxCcSWZtTbbu/3DZw==
X-Received: by 2002:a05:6808:158e:b0:354:b227:90e2 with SMTP id t14-20020a056808158e00b00354b22790e2mr2810241oiw.169.1665600510276;
        Wed, 12 Oct 2022 11:48:30 -0700 (PDT)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id cm21-20020a056830651500b00660d73c8bdesm7770382otb.50.2022.10.12.11.48.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 11:48:27 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id k11-20020a4ab28b000000b0047659ccfc28so12725168ooo.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:48:27 -0700 (PDT)
X-Received: by 2002:a4a:4e41:0:b0:480:8a3c:a797 with SMTP id
 r62-20020a4a4e41000000b004808a3ca797mr2985303ooa.71.1665600507237; Wed, 12
 Oct 2022 11:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221012181841.333325-1-masahiroy@kernel.org>
In-Reply-To: <20221012181841.333325-1-masahiroy@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Oct 2022 11:48:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTCVWhFz1MK22hq9WNEmhKy2kpNerA3fyyBYzP7z8XWg@mail.gmail.com>
Message-ID: <CAHk-=whTCVWhFz1MK22hq9WNEmhKy2kpNerA3fyyBYzP7z8XWg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: raise minimum supported version of
 binutils to 2.25
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
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

On Wed, Oct 12, 2022 at 11:19 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Bump the binutils version to 2.25, which was released one year before
> GCC 5.1.

Ack, sounds sane.

               Linus
