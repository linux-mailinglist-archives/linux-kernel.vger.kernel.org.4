Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BA366D33C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 00:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbjAPXgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 18:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbjAPXgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:36:13 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C4322A15;
        Mon, 16 Jan 2023 15:35:50 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4c131bede4bso400245437b3.5;
        Mon, 16 Jan 2023 15:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VYNmtX4azwAKTTUMwpvjnaBuUMcH5MIveEe0DLHOIPE=;
        b=pCgDnb4O2N7vuYuZO0mjE15/XR1bujf9K/A8e9YAZJDyYoQiAu07W60TgurF1eOP3A
         GOSQoG58mX7qUn8YuoliGj+XfsuZ6IcUa9TX635w2hvBczwJ7PxHnxLrK7cBC3owljKD
         l5xW1YDssHJu3n1KMvnYur8HT7XchSU9ZI+TDPCYFdPbJtsDNIp35ITS9jz6bfDAV8wg
         t2HU/wa0ZcgSq2a+sBMZZe+NIGWTpZU1krA3LLuQszR2OMEuye7WYyRTsSBd0vTo8ujM
         BD82tkQEh2y0EEBCpqmFNZznvUIRYEi06Wb4E9ahF4JEARccyMx877Sh8k0SHqY2tEb5
         +7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYNmtX4azwAKTTUMwpvjnaBuUMcH5MIveEe0DLHOIPE=;
        b=W+ihKXUi9a2ffm+1d5QqI4HnD8PZaO0/Tc6LiUbzU3EBxHD1eGD9Bp1gHg0gcBXXox
         0eUX+kzik2OrhnvsdXrHvKULvQRDpO9eh992XHCXrQN4dryJCdy0lwfmkh6Kv2C7T6RH
         455DsDAOABE5Zt4Glr8uIYTUj3pBTKjfFUfa+KlhA19no04Q8IFY7w8JfQO+Ku8NGrrG
         9pkbxgpn5y8guL4letRYgewUHwtvFMG56vkYNnvPpYNldVJo9sxEGMRmxndqCOh8ETBV
         2aBik3eAFDEZd27T2pFbRbbUF9kU9MKh5O0iRPf6sIQH/S+qxgBNZ3uBxctj9TRfr373
         1WDg==
X-Gm-Message-State: AFqh2krJqM3+P4e6RC12qUScvfKyt3csmtqY4Mw/oOhEvr/jl1kBfjRj
        GhhYn32Vsw0O69h/4peCbkTd9AP7W7Qkl2M7lww=
X-Google-Smtp-Source: AMrXdXs00Nhyckfn9ZEhPQkqTyttOZOCcHV6qurBaGtB/aKPrcgDuwtgjRgbWgA51ajcI3FqM8eEmOwAhJWynA9RM20=
X-Received: by 2002:a0d:fc86:0:b0:4db:3ac0:78a3 with SMTP id
 m128-20020a0dfc86000000b004db3ac078a3mr129399ywf.266.1673912149301; Mon, 16
 Jan 2023 15:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20221214093451.zdyhmdyxwz73n6pe@imap.mailbox.org>
In-Reply-To: <20221214093451.zdyhmdyxwz73n6pe@imap.mailbox.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 17 Jan 2023 00:35:38 +0100
Message-ID: <CANiq72kB6=hYUhgEv03zORAN9-aAi6UNwD5jcbh5vM6nUknL2A@mail.gmail.com>
Subject: Re: [PATCH] rust: prelude: prevent doc inline of external imports
To:     Finn Behrens <fin@nyantec.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 10:35 AM Finn Behrens <fin@nyantec.com> wrote:
>
> This shows exactly where the items are from, previously the items from
> macros, alloc and core where shown as a decleration from the kernel crate,
> this shows the correct path.

Applied to rust-next, thanks all! (as discussed, I added the Link on
my side, plus fixed a couple typos and the comment style).

Cheers,
Miguel
