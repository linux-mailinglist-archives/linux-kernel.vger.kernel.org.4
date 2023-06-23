Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AB473BDBB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjFWRUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjFWRUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:20:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B821739
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:20:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56938733c13so12092817b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687540807; x=1690132807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BiBfjxCccTZov20BHaxSn4dvBGrOpxH5Zg2fttHLmAo=;
        b=vUzaOM/RwOe0xTyvCYmg4F3fM36X8xQ+vBoknwuOrceehnrO+IAoECNY3QF0zL15Pm
         wjBaOjnRslplk2hdm41mQGiaKx/c78xfFrG2eWwxSkiYlVNgvPmTCC9h1V0o+vHxSkBV
         QkSFBASDYPTHBjvH7P1cc6AUJa7EvzBoRqlhmloDYh6ogDcpwW4yJaNpI0xVT0MONGAx
         Ms+lSmz9khKYdLg0O/jY0VJqNChW8WEskqxcqnUBVZZ9vilOt6Pt71UfFtVDTzq/JmeJ
         9jJL1Aepkk4ls9rRE1FB/oSeMG6u9a2wpNzQF4LJ0g9/5igrxuIiQK46Z4FwmOts+2yr
         9A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687540807; x=1690132807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BiBfjxCccTZov20BHaxSn4dvBGrOpxH5Zg2fttHLmAo=;
        b=GKmTa0r+0LFhj4ggj0W6TwERZzCGsR7kjmFenKVGvXpkOiYEI8sQ5k6k7OSz8FJfW4
         wCN6M4DMc9gyAoxGf8vebA/dGwXTfR7MB0Mc5BGXpIYDoy556NwmelaCUP51ltI0b/C/
         ed6Hj2rFRMjCupxytXmO+RZ7pMDmA+HZCj0/EkEW1aRTFHSDd8X2GymbRIp96MxrXJaw
         O/7c/yHCJA84T+OQBd9H08X+yJHfCRVtjUYk/8UT/Cm3Wug1jzv5jtH6VOY+nKGWas7o
         ugjq7J9l8EbRsZuljem2Pp1H0i0Y7MhB7YRrheDB83tx/kReVVErKoxmOBUwqmUEm2+Y
         hPjA==
X-Gm-Message-State: AC+VfDzyq19Ikxc7CqFeuJ8gKj57lNMgBfnbMPtRA+/3HvrSoZJhgSDA
        uacxKlj+b+ZTffPqTsFXcKB73XbjKKm0dIdIlJQ=
X-Google-Smtp-Source: ACHHUZ6cx2qgz7NSb63VxtrtMtA+DX4GBzGLbc+XFKkQCOYrP1gWt/nU7fhRzAZr+PjlLvWSt+azGJTAyzUvIUmGB90=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a25:e78a:0:b0:bc4:ef98:681c with SMTP
 id e132-20020a25e78a000000b00bc4ef98681cmr3959400ybh.13.1687540806990; Fri,
 23 Jun 2023 10:20:06 -0700 (PDT)
Date:   Fri, 23 Jun 2023 17:20:05 +0000
In-Reply-To: <20230224-rust-xarray-v3-1-04305b1173a5@asahilina.net>
Mime-Version: 1.0
References: <20230224-rust-xarray-v3-1-04305b1173a5@asahilina.net>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230623172005.2432028-1-mattgilbride@google.com>
Subject: Re: [PATCH v3] rust: xarray: Add an abstraction for XArray
From:   Matt Gilbride <mattgilbride@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Asahi Lina <lina@asahilina.net>,
        Alex Gaynor <alex.gaynor@gmail.com>, asahi@lists.linux.dev,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        linux-kernel@vger.kernel.org, neal@gompa.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>, yakoyoku@gmail.com
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

Hello Matthew,

Could you please take a look at this patch? We also need `XArray` for ongoing work in Android's binder driver.

Thanks very much,

Matt
