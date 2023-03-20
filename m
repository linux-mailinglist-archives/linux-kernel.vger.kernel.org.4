Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F4C6C24C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCTWbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCTWbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:31:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC8D28E6A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:31:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cy23so52685154edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679351491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAGlFJqYmzMpi4y5YSD63yoKu9/i/gsYoJLo98dDpYM=;
        b=H5TVtg/3LzAcq64snwXsy7VefCIII3gMvSBifldyIZdNKh2asrD7t6Nt4Qh9RAAIN4
         sM3WpgH6gUTn/4BK2w/IufDFw9EME4pIEE0VcJfLYvAv0MlBXAZzb0TB3MF9MQeTjmY0
         nRlFGAjPfsE0h0PANnuVAn9iu+9cVAhzryiuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679351491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAGlFJqYmzMpi4y5YSD63yoKu9/i/gsYoJLo98dDpYM=;
        b=peePGExr+szQYcHEFQHKTL0Yq/0ZWZFusllhi21kdmfV1viL9pndMes0XIuKICmvmV
         hqjkJHlOMArf/Fvt9bRh9RLrm5T/ZQDsVUdFgpOezjAog7A3OFRW1dTWJaEheP4dQ71P
         EvAsHoF4noJW5lT4Vodrnbz3aZDYKQ2K3kvsSSvWLlJu6boxKDvy3hNxF62ZgMc50208
         ZEO+FPF+jwYpr3ec7sF1q5C0zm90j4+4FKqGucs/UCjLEPFF9JWViH/877USgBbt1OjH
         Z5gZV7yUcq9BHhtYOx6BQciRiSTfUn8tjuaOjM5r0YpbA19qCJ/z8k3XjMIuwOgQmPag
         aeVA==
X-Gm-Message-State: AO0yUKU9GdKp7RYmbsKG3dj7bAxvUQE4NUHDLnWP3xw8a8HpIFgBjLY/
        JtvGBkoXL6fYGB02ahAQoV+BeukNHoi3lNO9rz9yHXFm
X-Google-Smtp-Source: AK7set/OxCAqxDFnrx3Zt3mXQeQubK0rymRGXUaTgc9sJvwCx4E34iKJxY2/B78pIX3t+KbvHkDlAg==
X-Received: by 2002:aa7:d990:0:b0:4fb:aa0a:5b72 with SMTP id u16-20020aa7d990000000b004fbaa0a5b72mr1201035eds.5.1679351491063;
        Mon, 20 Mar 2023 15:31:31 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id v25-20020a50d099000000b004ad61135698sm5460604edd.13.2023.03.20.15.31.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 15:31:30 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id w9so52841798edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:31:30 -0700 (PDT)
X-Received: by 2002:a17:906:34cd:b0:8e5:411d:4d09 with SMTP id
 h13-20020a17090634cd00b008e5411d4d09mr293646ejb.15.1679351489808; Mon, 20 Mar
 2023 15:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230320210724.GB1434@sol.localdomain>
In-Reply-To: <20230320210724.GB1434@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Mar 2023 15:31:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com>
Message-ID: <CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com>
Subject: Re: [GIT PULL] fsverity fixes for v6.3-rc4
To:     Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>
Cc:     fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Huckleberry <nhuck@google.com>,
        Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 2:07=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> Nathan Huckleberry (1):
>       fsverity: Remove WQ_UNBOUND from fsverity read workqueue

There's a *lot* of other WQ_UNBOUND users. If it performs that badly,
maybe there is something wrong with the workqueue code.

Should people be warned to not use WQ_UNBOUND - or is there something
very special about fsverity?

Added Tejun to the cc. With one of the main documented reasons for
WQ_UNBOUND being performance (both implicit "try to start execution of
work items as soon as possible") and explicit ("CPU intensive
workloads which can be better managed by the system scheduler"), maybe
it's time to reconsider?

WQ_UNBOUND adds a fair amount of complexity and special cases to the
workqueues, and this is now the second "let's remove it because it's
hurting things in a big way".

              Linus
