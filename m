Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F714690B54
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjBIOHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjBIOHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:07:36 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E699A5D1F7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:07:34 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n13so1493122wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 06:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/fZEZ23GYCuEsYGekWai0lOlR8LMbc3z0Q5wLhY0DnY=;
        b=jkPObI5+N3I6WTrzoz8PySJW2OXbWE7M/TaX5gSBNfdEe2PKbUmzKHInXXTxQuv3no
         G6azc3jC2HqqwU409T31LoBrUiJdzxK29obgs14LShAz/g2+oRv9KXAeXjl7H2Nkapam
         PtK3N5gHfgf5ef1xXbQHDPaxs2yIXHpOy3uZ3iCgRFb+BFbtvsLfdJcXNcgsxYojQTnX
         i6d/F75LAN0ifHAa5TO1Wt5PQmMbhjcFamqOZlPH9DqHiuIQO+UEfKFGCds6mbMeoKqk
         Q2UgdcwhVWHgUHBQZ8bt9nSNxSR5kq6ZoVF8x2rNiDsRulyteh+oWIOF7iQLd6e3vLPP
         PZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fZEZ23GYCuEsYGekWai0lOlR8LMbc3z0Q5wLhY0DnY=;
        b=0idOacLXF1NIaPylkeF96vcsbgxwnOuqomNdf9YJpzie2xuKwSDYSRjKpVf5qW+o6x
         BlSyhYTZXUado9KxFAL+CbL7Wl9Gt68RyTzZ7KakHE1DWYh+g58mWjha65Y9gv0EwD7x
         NKgBgYRRQP+T43pNIOGM+mAeULgsuNL4Mjx4SP74UYuBFOCK38CgTVS6vtRZT0BZ7//q
         zKI/o8ghFXhIDOPLJOIqBPXEKfCYDhuii3tNtk/Q8YNjOUTSWwelzyygqEY9lpX4DtE8
         QF7+0DXNCgAHFgDnran2VlBa3hAuzl11YFEoYBpDx8oxKqn687O9NDbss6H13MNTaMzJ
         mF1w==
X-Gm-Message-State: AO0yUKWlpl916HUVjZ9sBfPXI7tCyvzU3SfpWhtHEzrkS6j9csOmjDJg
        sRLCtH+4vjo0yZ9c48qQJgNRYVQQo6dWmSsYNIUz8A==
X-Google-Smtp-Source: AK7set/URjElet4XCI6w57NojAjes/SdyT2eO9gZZEVC0ptDvfP2FrrjoKMVkjbQZ58kwzqB57ZB/jquHBcfJDWNlz0=
X-Received: by 2002:a05:600c:29ca:b0:3dd:67c6:8c58 with SMTP id
 s10-20020a05600c29ca00b003dd67c68c58mr701410wmd.51.1675951653421; Thu, 09 Feb
 2023 06:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20230123220500.21077-1-kirill.shutemov@linux.intel.com> <20230123220500.21077-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230123220500.21077-3-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 9 Feb 2023 15:06:56 +0100
Message-ID: <CAG_fn=Uozzi7xuA7KYYGg5qvKgnDOtdHrb7832XP2-3nky3_Cw@mail.gmail.com>
Subject: Re: [PATCHv15 02/17] x86: Allow atomic MM_CONTEXT flags setting
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 11:05 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> So far there's no need in atomic setting of MM context flags in
> mm_context_t::flags. The flags set early in exec and never change
> after that.
>
> LAM enabling requires atomic flag setting. The upcoming flag
> MM_CONTEXT_FORCE_TAGGED_SVA can be set much later in the process
> lifetime where multiple threads exist.
>
> Convert the field to unsigned long and do MM_CONTEXT_* accesses with
> __set_bit() and test_bit().
>
> No functional changes.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
