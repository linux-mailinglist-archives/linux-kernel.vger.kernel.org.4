Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87146F56AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjECLAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjECLAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:00:02 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F5549EC
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 04:00:00 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-9537db54c94so474702966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 04:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683111599; x=1685703599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2flrzqrP+i7aYqtQguBZoK/d1T9EPNvaJivqwFd9T0=;
        b=SynCK35TIyLV9RAsgu/wZep3yuWP9RqrRGi3a+dU+S6i2JQ9j/9wWWdYlxcfT7OJeA
         MPadvq86aNWnLmQA896/Sg7QmD/KotZIzs0LX3cCFPvGECrWJ3PxqgDEvWGt0Hcbmlre
         dol4G2AGK0nA/coq8WrfJSuibkYOzatiq8eykuNQORPPa7jF3WXmvVROhqTH4VW+qXPC
         KN1ckIrDHidr2Y1hYCsKdlX663h1T66qO3bxoAeXK3ZYNsRQxc9o/qpdWhE0Ae5LkEK/
         m2yWQbwewGKgvYNvzFkKrB1Ce/e90/jxnFjutFdvSqq+w9ZSckrnGGHEzshEsnbN+PVo
         psEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683111599; x=1685703599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2flrzqrP+i7aYqtQguBZoK/d1T9EPNvaJivqwFd9T0=;
        b=RU9+QYYan1nk2BKpjlu7NPgXYixXprc+a5QoxLANoARFcrgKqGOmG+NHVcw5apIgSn
         YkQxJKHI46VtAdszLjq7hatsi/fpk5s9aVNDr2iR6A777nRrJNVtVQwA2XFrfhaForfx
         IgaRtrzVEEFTw9YQvOXd3ph8bwSgwmGJ1QLbYp+zX1yb9B9NwtXSFDsbs8Jdn8+bLEtZ
         ThLgVEYMbOjPO/n7D+aGHerP+ftxK4/w1qkKMwKz5KK7CJ5WfPGqAFzVoG9QC1YLzPT8
         UJqNe76AYywFCeuI409ujpCY3tGZfh13MxWbr/1Y1lW143EptkEer8z15wIneyWbxHz+
         SXcQ==
X-Gm-Message-State: AC+VfDxOOvypVvnwNj7U6WCor83Er4jy9rpNB832qpFmf27s/+Zhwjdo
        11ARlBy/b+pzkuW29NTv9OCNg5U6FknhEDw=
X-Google-Smtp-Source: ACHHUZ6SacIL6tXwsdztLRNtTxrAY3AjLbfHWLlQjTdPFAlO71jHQIXs1LFwEkD76LO+wTYrNLxnd//3yA1+5A4=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:b13:b0:94e:f130:93f0 with SMTP
 id h19-20020a1709070b1300b0094ef13093f0mr1194892ejl.1.1683111598801; Wed, 03
 May 2023 03:59:58 -0700 (PDT)
Date:   Wed,  3 May 2023 10:59:35 +0000
In-Reply-To: <20230426224748.34056-1-materoy@proton.me>
Mime-Version: 1.0
References: <20230426224748.34056-1-materoy@proton.me>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230503105935.518315-1-aliceryhl@google.com>
Subject: Re: [PATCH v1] rust: error: add ERESTARTSYS error code
From:   Alice Ryhl <aliceryhl@google.com>
To:     materoy@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        yakoyoku@gmail.com
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

On 27.04.23 00:57, Roy Matero <materoy@proton.me> wrote:
> Fix sorting of rust/bindings/binding_helper.h's includes,
> to maintain consistency and rust idoms
> 
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1002
> 
> Signed-off-by: Roy Matero <materoy@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
