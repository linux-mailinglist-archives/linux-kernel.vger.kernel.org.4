Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B4E5FBDF1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJKWtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJKWtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:49:14 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D258F97A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:49:14 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-134072c15c1so14436737fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Br1aOdu+0HvIKGR71tLPfM2hoANr+BgT3DPpmcCrU0=;
        b=QJenybZKtzWXRYI7zhSXlqbKHYaFpIo3Ip7jklH2D7OU6phpfAPRNV7sMlgQHnLMWT
         7Fth5BsJnV0dezNYthINb3VWqV7Inc1OFa0neLlJec+Phvcjs/HL2jJT9gsJ8ceJrRA4
         usze5nCYoBA0RYcpzcejAuUZKz0RXSSEbTgUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Br1aOdu+0HvIKGR71tLPfM2hoANr+BgT3DPpmcCrU0=;
        b=MMXcbPVImU1OtOF0g6Dcq0wV+b032DX9JdKeINKIyYnsSbTG/dc1Nv2asM9229MhKd
         VUbohimQqisU0tQYUSaxVZtnG8dDZ9Hx9Y62Djg/Sw1pVrfDBvWycpKw+RNMO+3W3gSi
         HSxA+j3oI8MLdIvUeBEk2fKxBi3YH+T+742UViOf/BnTTxP4NYuJCk8SSBetYjMdUJBX
         nULD46gtRAOQ94bISdhb97FCex+AxTiJIpd/1elmOYhtLPUAH0TLM3HolP2KeXcHhVSB
         x423XCuvfbRGsMSmYZy8Fw23HNOYOmGX3ZPbCqd79kiJMnSta+pSdJvmPHgAj4V5vDl7
         t/Xw==
X-Gm-Message-State: ACrzQf2LQjBpvm/Y1DSKMhjjE224Nn+rHezhs7j5SjuW4o8GulZFaRIm
        XIRXakWtAt816jJHk9Lzed1hOJ8a/DKkbg==
X-Google-Smtp-Source: AMsMyM5cnDayj9jBr7xiEXRkxtUr0YjZ9xBL5nvun6bzyk0V04ogaVkN+aofWF/QVLstf4M0kdT6jA==
X-Received: by 2002:a05:6871:7a7:b0:125:5c0d:de5d with SMTP id o39-20020a05687107a700b001255c0dde5dmr833666oap.297.1665528552815;
        Tue, 11 Oct 2022 15:49:12 -0700 (PDT)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id i26-20020a056808055a00b00350a8b0637asm4108170oig.47.2022.10.11.15.49.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 15:49:12 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id x6-20020a4ac586000000b0047f8cc6dbe4so11085391oop.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 15:49:11 -0700 (PDT)
X-Received: by 2002:a4a:4e41:0:b0:480:8a3c:a797 with SMTP id
 r62-20020a4a4e41000000b004808a3ca797mr1313796ooa.71.1665528551551; Tue, 11
 Oct 2022 15:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221011132256.333-1-dsterba@suse.com>
In-Reply-To: <20221011132256.333-1-dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Oct 2022 15:48:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB9sHzsNcCRRkgeyXLu09hV-FgRLwvFHoA_uCpZRJJwA@mail.gmail.com>
Message-ID: <CAHk-=wiB9sHzsNcCRRkgeyXLu09hV-FgRLwvFHoA_uCpZRJJwA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update btrfs website links and files
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Oct 11, 2022 at 6:23 AM David Sterba <dsterba@suse.com> wrote:
>
> We have the new documentation hosted on Read The Docs and content is
> migrated there from the wiki. Also update http to https and add the
> tracepoint definition header.

Hmm. Did you intend for me to apply this as a patch?

Since you normally just send pull requests, I'm a bit confused.

Is this a "it's outside the btrfs subdirectory, so I'm sending this as
a patch"? Except I've seen you send stuff that has changes to mm/ for
new exports etc, and in fact to MAINTAINERS too.

Or is this just an informational "let Linus know about this patch" email?

Anyway, if you actually want me to apply a patch directly because of
some "I'm not going to send this as a pull request because there is
nothing else pending" kind of issue or other reason, please do state
that explicitly in the email.

Because as it is now, as explained above, I'm not sure why this patch
was sent to me.

               Linus
