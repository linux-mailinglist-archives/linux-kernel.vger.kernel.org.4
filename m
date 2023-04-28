Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58F26F1DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346130AbjD1SR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346101AbjD1SR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:17:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8AC5275
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:17:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-506767f97f8so17760752a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682705841; x=1685297841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mk4K676QIYFqmlniBxZxPOQtmyUCM5alSz3kS3YiThA=;
        b=HP1Sl6HjltissUCCxv+gsGYp55TlpkV++7Ze4xH9G61fLCeqW+dQNvvpj99Yva83yJ
         DnltQ8+7uNdnUQGCSJF+kinuOFtyxwyC/5VWMavxmLl5jVCYt9foI9T9AIq8/Kpn7t8m
         yEHYAjLCsW6MivkupLo4CIxlny72waU6xUepA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682705841; x=1685297841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mk4K676QIYFqmlniBxZxPOQtmyUCM5alSz3kS3YiThA=;
        b=NwTwNwuLQasjQzZG3ZlCRfASaqNyGRcnTgIUNi+h+INc+rxO80aArMi/P/S25HJ/he
         FYC7s7Vq6a7bTjo7RZIojkVwN9UqA7/5OHDMk5PBILKVTaW2vylwoCm0ho4RJfaHVsE5
         2+S0L/A8slPpQfNzSnVK/r3utxm/HQZxDUIQVoieyU1Wq6MdXT5Z2sCHIVcM4MYWAyD1
         ze44UOT0AfvtSs0Hh9qvMpac1+wtTxB1C6LtWediDsi5n4pOvj7EbPGjxBptYa/6Q6ny
         tbfk67ahtVIKs8QOxp1q+CiBVjCvUSaGx3IniXIJhTs1nYZ3xpYkzoPdtkoRCqGRoU+5
         9mHQ==
X-Gm-Message-State: AC+VfDww4vo/mlpgwO5C9L80re+vM0JC3g9j32Vxt1f7tqzkCAMR6JAX
        afjxRQk5yzWQtuwAnBvZ96oRJfsNoJVeII4l5CgtJg==
X-Google-Smtp-Source: ACHHUZ5LK83Qw7O+XUN9RpgwcTnfiFsFgImerH+y/9fhOLvkovHuZ9E8o5rOO+GhML91vES5JU13Vw==
X-Received: by 2002:a17:907:8a01:b0:94f:4a87:7a77 with SMTP id sc1-20020a1709078a0100b0094f4a877a77mr5788228ejc.36.1682705840970;
        Fri, 28 Apr 2023 11:17:20 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id hg24-20020a1709072cd800b0094a9eb7598esm2707344ejc.120.2023.04.28.11.17.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 11:17:19 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5067736607fso8406a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:17:18 -0700 (PDT)
X-Received: by 2002:a05:6402:2029:b0:509:f31f:b570 with SMTP id
 ay9-20020a056402202900b00509f31fb570mr5873649edb.23.1682705838429; Fri, 28
 Apr 2023 11:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230424212130.590684-1-dave.hansen@linux.intel.com>
In-Reply-To: <20230424212130.590684-1-dave.hansen@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Apr 2023 11:17:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
Message-ID: <CAHk-=whn3F1k263SZNUVQK195tcCMAo5E_WbmjUE0qFC5rWg=w@mail.gmail.com>
Subject: Re: [GIT PULL] x86/shstk for 6.4
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 2:21=E2=80=AFPM Dave Hansen <dave.hansen@linux.inte=
l.com> wrote:
>
> Please pull x86/shstk for 6.4.  This is the long-awaited Shadow Stack
> support.  It is the most highly desired hardware security feature in a
> long time.  Both AMD and Intel have (compatible) implementations.  It
> has been present on the Intel side since the 11th-gen CPUs, but it had a
> few stumbles on the way and is a bit tardy.

Just letting you know that this is still in my queue, but every time I
look at it, I go "I need to spend more time on understanding this".

So this is one of those pull requests that will be done next week,
after I have gotten everything else off my plate, and I have time to
look more closely into it.

If it can be chopped up into smaller pieces ("this is just the
preliminary work part which is all obvious and clear") that might help
me, but I'll get around to it eventually regardless.

                 Linus
