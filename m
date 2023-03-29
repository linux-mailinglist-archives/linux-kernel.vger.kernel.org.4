Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACB66CEC56
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjC2PFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjC2PFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:05:08 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C393AB4;
        Wed, 29 Mar 2023 08:05:02 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id b18so19721478ybp.1;
        Wed, 29 Mar 2023 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680102301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbthZAg2EI6S7hVKN4zQsrXR4eiiYbr1ymfLGy5VzFk=;
        b=O5b3QarlhM2wVotMDKJUIS9Ke9T+0xCUt+Firm4XuSeUk+ujnTGb8urU0KFo8uZmBM
         i2AJTxnng7A+PGuSX8Ie/c1+e13XP/7vwk6ggHZh4iWh6Zxo5r/m+eo06fvF1ihMfHf9
         eSiz6oVNMU8aboEpamh6FZ1vip17ca6B5bDUUlKuINTJ7HL9+JGDT5Ws9SQ1LA57zyLI
         RvK7NxzJ1fR2gca5un2xJYkhBUmesWtP+RMuJW9R21aVXOhV4olFh6KMyyW01NiYvjNF
         kc6DiySPtYSASr44CsUvHPhW6pqdc3BYm64nW9fHf+OxZ2seO6ZBclngdyL2pf2nkQP4
         MdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680102301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbthZAg2EI6S7hVKN4zQsrXR4eiiYbr1ymfLGy5VzFk=;
        b=Y74PINxgQ4TjgqJ3bWtqq5tKoElRtt/XvnNBZv3XW4H8lk0WfUHJF4tGrPMfK8NDAU
         XWDuFnuaySmxM43rHcIyMmtiGRYCdWllSLY9aUyOmRKRyVgK54eliorjBMGWUo5zEZ2y
         zLDQduXeBNpbs5+xVezQC+OIbdMXF3VJXNDJ1X/jMtOutRaefe7gEKByh/Mnap+7hw1h
         yKr7zLxEyj8ePo3nRTb8RPHAW3ocBHjaAnJG1HmllWqSftYdrmcWrBfoJmZ8KusNDB4L
         cRe4QeVMbRAF6KjxvQedeorhgcXSb9yysFHRX+ecPQQDd89mGpaNDYF0GSZ6HD3C0pyk
         u2vw==
X-Gm-Message-State: AAQBX9cQwQrEQxK9CVmygj4sO3mo/RzqxFd106l7iyvPVMhZByGBMlgc
        /owJYBFK9tEydmVBTnFPzfap1feM4AZ2HAR+ydQ=
X-Google-Smtp-Source: AKy350bX9861FLdgC2783Ji32zVywDnx4KhoXmIAZH6o1cbNCCb8RVfB1pT+qcgCDnwsz6YsabM/NughBZ3ZsnXR2kU=
X-Received: by 2002:a05:6902:1004:b0:b75:968e:f282 with SMTP id
 w4-20020a056902100400b00b75968ef282mr12771867ybt.11.1680102301286; Wed, 29
 Mar 2023 08:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
 <20230224-rust-error-v2-1-3900319812da@asahilina.net> <0849f870-2d95-8c3a-c7dc-2b18dcee4c65@gmail.com>
In-Reply-To: <0849f870-2d95-8c3a-c7dc-2b18dcee4c65@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 29 Mar 2023 17:04:50 +0200
Message-ID: <CANiq72ko9tY4dsK9Srte2oYQp8G=PMyLDTOR33-yNTVXmfyzeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] rust: error: Rename to_kernel_errno() -> to_errno()
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 4:47=E2=80=AFPM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> Reviewed-by: Martin Rodriguez Reboredo

These (in the different patches) are supposed to have
<yakoyoku@gmail.com> email when I take them, right? (no need to resend
them)

Cheers,
Miguel
