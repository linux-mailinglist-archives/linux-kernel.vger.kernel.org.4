Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195C87076D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjERARV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjERART (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:17:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2701A3AA1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:17:16 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-965a68abfd4so256663666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684369034; x=1686961034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SghvpISWOr2Xb/wbBKmrX8f/G7elt4qY32AMimXheQA=;
        b=IBG+nTw6a9S41RaiATt9FaOTVAM8BW0SsRpKBG70mIJk1VQkCVz9FI5ORG0C0yMpoY
         KxRGxWy2rKXekTI0rpU+i2MyGHQo/IkfC9eD0Jsi34Kun68q4BGKjK7GrclveLWn2h+L
         T3nYGmA4/giGGqGgCrg54sbdj8a7PPdD5Htz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684369034; x=1686961034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SghvpISWOr2Xb/wbBKmrX8f/G7elt4qY32AMimXheQA=;
        b=Q3mUz7Gqc74sPJFpLzPgurrUkDtXuECkOGmpaVyadHTJWFSTxQVKHu0E6JccINx2+z
         0I498pATqKxrhA0vBW6/nbpqWLwEvnCcThrK22GpM1ELICDxwdP17dPwZJ/OSJ90s3EL
         LUyIkqUdebAhYsf0DurrWL1OY2fyduuAWUxXv3yPcq1tg6JPdj5cf7hFD4Gs5fWlWkRm
         QzZmX3KQjF97ZJu6LocJ1BMfJEzHHjN5OIuWgUaV6DGzWtpn9HAfpe/vikKFiWPJJ74n
         E3DmWYLHw9Uv8MFpow9dp/NqO8UrhfM9TPwgdDxkwax8zCPDWcabyfDMJJjYaBlRbkEr
         fqbg==
X-Gm-Message-State: AC+VfDy4mlyUiR7UWc/T7htn7RGsldQGs1VMOEmbElm71thUwfLAQ112
        NOGeRJ976aUTG2KenMPxuQFkjDQEXye8YQPqDwU3LN8/
X-Google-Smtp-Source: ACHHUZ4za43Ku46LkkTdqTx2ggKoEnLHBHXvRvEGYEynO9Xb3Z2Hzfu/a1NyCe2DJNZgMlWWdtjfPw==
X-Received: by 2002:a17:907:1c19:b0:94a:3ff1:53ad with SMTP id nc25-20020a1709071c1900b0094a3ff153admr40005965ejc.75.1684369034431;
        Wed, 17 May 2023 17:17:14 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id ke25-20020a17090798f900b00965f31ff894sm207384ejc.137.2023.05.17.17.17.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 17:17:13 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-965e4be7541so256907566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:17:13 -0700 (PDT)
X-Received: by 2002:a17:907:97c8:b0:961:b0:3dfd with SMTP id
 js8-20020a17090797c800b0096100b03dfdmr42523477ejc.7.1684369033423; Wed, 17
 May 2023 17:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230518000920.191583-1-michael.christie@oracle.com> <20230518000920.191583-3-michael.christie@oracle.com>
In-Reply-To: <20230518000920.191583-3-michael.christie@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 17:16:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wga+96PqV4x8EwFAMfi--m9essdX+3uPE-AoOSAQR1ddA@mail.gmail.com>
Message-ID: <CAHk-=wga+96PqV4x8EwFAMfi--m9essdX+3uPE-AoOSAQR1ddA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/8] vhost/vhost_task: Hook vhost layer into signal handler
To:     Mike Christie <michael.christie@oracle.com>
Cc:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
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

On Wed, May 17, 2023 at 5:09=E2=80=AFPM Mike Christie
<michael.christie@oracle.com> wrote:
>
> +       __set_current_state(TASK_RUNNING);
> +       rc =3D get_signal(&ksig);
> +       set_current_state(TASK_INTERRUPTIBLE);
> +       return rc;

The games with current_state seem nonsensical.

What are they all about? get_signal() shouldn't care, and no other
caller does this thing. This just seems completely random.

      Linus
