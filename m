Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAF1745BC6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGCL6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjGCL6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:58:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56573E62
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 04:58:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c38a4d22b39so4926107276.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 04:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688385499; x=1690977499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=waeGDoVgGDH94No5qzti6s6z1JdLzgejSmKbt77NSm4=;
        b=n4DSn/SR8jW6zJisAJudqF9kgG9Pqv7i8vnxTpRtFOtxvSaZj15fVx+EtgG1vTFbGd
         UbJ/ehSb1pcQwECTOdfVFUhtgAaIdXN2JvtJ6/S9iP7uOHqxWF/Hl7MtVTDRxTHkmMBz
         JN1h8sHm/n0fP3d6khiTMAY3w5DF1C6pG2fIFb0/hXValDWqJB+ZuZu80gddy/gJqIBN
         zcXZ9hQytHsS4UAmWXkKlYYZYmZyMHBpRjAC/xF9w5Jj379G5gl651yTSdjiSPuu5XZX
         r4tCuWozs8XfHLNvcBcT30GwP5F025LxGCo3YuFm6r4/azx/r/rbdQG9OIfG0FgxDLx4
         EKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688385499; x=1690977499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=waeGDoVgGDH94No5qzti6s6z1JdLzgejSmKbt77NSm4=;
        b=Kc9SqhVeMFj1xqCHk4MgXvBpWvo1kCX4w5888o/3nE3bK/4tocmUZad6KNR1BS3gy+
         yTanOlSJKgo0rTfSVvfrPdke+HoWF8IyguqhnKx6vNUDwi1KvRkhx43aiXa5m19KhG8F
         IlJlgw5JErYVuoAF6PMyZnHPS8bujklleVtmA7IXwiNZevgVTcDJdNazIQt9tmF6bx44
         ea9xjals4s8GrgY7AarZHQkon/IeLNjOfHNHant9JUnayAb1e+sx+khw0jD3TRQL647L
         nCKT/IHiHRAMxKGVeV01z/vdz9DmTwTG8smKS33YosVukA7tMneTfCwbBZf6n6hn3vlv
         36Xg==
X-Gm-Message-State: ABy/qLYT56T6ZuKpkyUHQbw8JnxMdGIfD7lYJ+kL+xHk2m0SjbOsbYFZ
        aOp/b3p0z+dAyXkW+NjDcW2H5dr3uGB+Kfo=
X-Google-Smtp-Source: APBJJlHCsEa6ZqPl05Kk8kCJRBjFUQKdWC53i0Nx85xGnPc/NmX5y0re3ZTmg8qKPxbtdgNrcbil/bu/BsKvBU8=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:4eb:b0:c10:e586:4c7f with SMTP
 id w11-20020a05690204eb00b00c10e5864c7fmr76067ybs.12.1688385499497; Mon, 03
 Jul 2023 04:58:19 -0700 (PDT)
Date:   Mon,  3 Jul 2023 11:58:14 +0000
In-Reply-To: <20230624092330.157338-5-benno.lossin@proton.me>
Mime-Version: 1.0
References: <20230624092330.157338-5-benno.lossin@proton.me>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230703115814.2294010-1-aliceryhl@google.com>
Subject: [PATCH 5/7] rust: init: add `..Zeroable::zeroed()` syntax for zeroing
 all missing fields
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        lina@asahilina.net, linux-kernel@vger.kernel.org, nmi@metaspace.dk,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
> Add the struct update syntax to the init macros, but only for
> `..Zeroable::zeroed()`. Adding this at the end of the struct initializer
> allows one to omit fields from the initializer, these fields will be
> initialized with 0x00 set to every byte. Only types that implement the
> `Zeroable` trait can utilize this.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

I'm a bit surprised by how large this change is, but it looks ok.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

