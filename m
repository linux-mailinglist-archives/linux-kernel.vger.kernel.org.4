Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062B266A718
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjAMXbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjAMXbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:31:07 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0542560867;
        Fri, 13 Jan 2023 15:31:06 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id t15so24212208ybq.4;
        Fri, 13 Jan 2023 15:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8x+fgQ2I+pqMaMW/X5cHc/YMKvj8qdTDIS+NdFNCDfs=;
        b=UfJhXVJb1zWU33EOx/tQXgiCDEU01jCZSsPVbZIiPgBaKFDfZNX0lZLjS108G07PUG
         FMWkrMhxWibRRQo3QQHDsFAt1R1S8aYvXIoUu6KyT8bA5q3INPo9T/TYrZGvXlwr0b2i
         ysNr3Usj3/vBXtcxXgklg5QZgGqZyn5AYSbmBldrOYpatdZjtOp35qAtlFkclQrATi6T
         9MpCMO/Ze0RJ10tc8gTW8tnJrGrrSKyklsR9S8sNTSqF5wsFn/5flPsTiB8FmSesbYup
         u26YHzPZjXNw+A4AoMD1fJaW6xATtQrfHItSeX+iOFMKgp4I0wM9tMCrkptVeelW+xkJ
         F6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8x+fgQ2I+pqMaMW/X5cHc/YMKvj8qdTDIS+NdFNCDfs=;
        b=O9zw+iI5MZQQTutPSf6n9kPC7JJ0Kt8QLzoScmm0M+C4EwE2x0myMvZhzJQr2xiN7A
         QQ0vrjV+HZptOrNnaB8SLX238eVS4H2D8qx+3XEIIiYsT4xeSa2Z51+l/q0GXMnI+Von
         fpBYw7xRZ402EosQ+rkw5VSSajKc+SUQhfAWHspDoN7zd0TV5oawRG2x8XikcgOVZ8lY
         GlaVh1iZk+FAC93YX6/MKQ0Qmx2SVWAgymlxcDNsyfrxBegqLWmuQd6SlUeewE8IeVaM
         nXnBSuNrktZqoDa2nsbqv3cw7adLkuPr7sfhH0CLchLPkZ8a5f9qqPRlts/KbunlQGQP
         zuyg==
X-Gm-Message-State: AFqh2kqyqoJzrgLA1hfqT7GtTDXk6SSUVNACkNHE1zXk9h6x29hKAw6d
        muU/3FNZ77kwQvZzHtWTP9aN/bfTMay34mSqCy8=
X-Google-Smtp-Source: AMrXdXva20Xrfbl+zo3SLpX+v/KZPjReiMCBsty5G9qfiJpanHD4htIziE8YIoEbPoyqjtYrmzhByrDdsZ7Bq44udRs=
X-Received: by 2002:a25:e6c7:0:b0:7cb:dfbe:3996 with SMTP id
 d190-20020a25e6c7000000b007cbdfbe3996mr620654ybh.489.1673652665276; Fri, 13
 Jan 2023 15:31:05 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-5-ojeda@kernel.org>
In-Reply-To: <20230109204520.539080-5-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 14 Jan 2023 00:30:54 +0100
Message-ID: <CANiq72=FZB1_muUYq=ZGPvY5jfTgg8FqcKnG=E1BMQML5rVG=w@mail.gmail.com>
Subject: Re: [PATCH 5/6] kbuild: rust_is_available: fix confusion when a
 version appears in the path
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jordan Isaacs <mail@jdisaacs.com>
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

On Mon, Jan 9, 2023 at 9:46 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Reported-by: Jordan (@jordanisaacs)

Cc'ing Jordan who gave us the email address in GitHub and wants to
send a `Tested-by` tag.

Cheers,
Miguel
