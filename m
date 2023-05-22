Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612D370C588
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjEVStR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEVStO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:49:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D654E9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:49:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso11705160a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684781351; x=1687373351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIX3WciKKidNEVKBDs18WRYhhkFswjfJ00rKzcMfnjk=;
        b=MnilCBa7xeuhcKS7mYGU/3u6/NGekzdYV0pCSwjOYa18XNZWpYniJb2zPndhyh4wGz
         11XZoQPi0sV7ZWeKpGX4JGhdsVdrG02UkmywjDpo5IiiGmrPaR/P0voeVrPGwH/zMiOS
         bRYC2mNWa4k+2bqjMPx+Xq/YhpnAsCLbhqwOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684781351; x=1687373351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIX3WciKKidNEVKBDs18WRYhhkFswjfJ00rKzcMfnjk=;
        b=Y0xIaMkR9JHf2nocqIra+InW08QYOMItsAd1ttdS4/aGMCHCw9RGOPHFHWQqCgVV95
         ND+B0uSTSzJfrKPV/TdVjo5vpPMiaenApncifdAf3RbubZC6rOQCp1v2JgH6zO44ughw
         u4uUfdWVmGw7OXetWj3YtkuU+cph7rmWe7kCHussMdHZBlg8vdGb2Cs1t0451GWay6+I
         4qtT9PZYHuz3oC5eHPdiZKOCfh8VG0U+/AF0lTL4o//zGd78z2kIwS5pITKtEdcrYz5M
         GbQidcaSNpwiIQrsrzc4QeJWYrGJgXsTc/mMfgp+iInqaD7fhrf2RSKff7mmkQu2+DaB
         9+Qw==
X-Gm-Message-State: AC+VfDw2bAXKromQ0AKtUatUVKYAg/VWPl5yGnn2laxJjmFMBqTEeOxe
        kHLqMZmRHz1fIPuW8t+9mYFbk/OAFRtUX5dvCIWjwj8D
X-Google-Smtp-Source: ACHHUZ7MUaFi32Z8bkARdjYie2We1o3tRJjDfvWtMyAW3PmlZxzc+2e4b5xrd0QfxzLL6vc+oiHhIw==
X-Received: by 2002:aa7:c915:0:b0:50b:f654:8846 with SMTP id b21-20020aa7c915000000b0050bf6548846mr9392430edt.19.1684781350913;
        Mon, 22 May 2023 11:49:10 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id k3-20020a05640212c300b0050d8b5757d1sm3296423edx.54.2023.05.22.11.49.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 11:49:10 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso11705110a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:49:10 -0700 (PDT)
X-Received: by 2002:a05:6402:31e7:b0:50d:a1ef:2ef6 with SMTP id
 dy7-20020a05640231e700b0050da1ef2ef6mr9112821edb.23.1684781349837; Mon, 22
 May 2023 11:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <c9abf109-80f2-88f5-4aae-d6fd4a30bcd3@google.com>
 <b4dce681-e53c-a6fd-2dab-62a82ebc6dff@redhat.com> <53dd9df8-e88f-f466-89f9-3fa141a10267@google.com>
In-Reply-To: <53dd9df8-e88f-f466-89f9-3fa141a10267@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 May 2023 11:48:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+PHQ9PhTeQOb7Fh5Qf3zkzG5J1h3D=eOY-2AsYXhU4Q@mail.gmail.com>
Message-ID: <CAHk-=wg+PHQ9PhTeQOb7Fh5Qf3zkzG5J1h3D=eOY-2AsYXhU4Q@mail.gmail.com>
Subject: Re: [patch] mm, debug: allow suppressing panic on CONFIG_DEBUG_VM checks
To:     David Rientjes <rientjes@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Alex Shi <alexs@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 11:39=E2=80=AFAM David Rientjes <rientjes@google.co=
m> wrote:
>
> I think VM_BUG_ON*() and friends are used to crash the kernel for
> debugging so that we get a crash dump and because some variants don't
> exist for VM_WARN_ON().

I do think that from a VM developer standpoint, I think it should be
fine to just effectively turn VM_BUG_ON() into WARN_ON_ONCE() together
with panic_on_warn.

Maybe we could even extend 'panic_on_warn' to be a bitmap and
effectively have a "don't panic on non-VM warnings" option.

                Linus
