Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC3572434D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbjFFM4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbjFFM4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:56:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C489C1707
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:55:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9745ba45cd1so769077166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686056138; x=1688648138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+8gN3mys4shi44Ntk5Z6kfGgYi/MZwn+Sx3ui4XedQ=;
        b=OLAHYPmDOSe6if7yJwf04ybBcGlviwBtqBERr5r7W4MQ4N46P1fx3JBdDDChpEQdPi
         2XEyBQd7iU7bpaf9Vtg5TNLIPVQhys6rdoQgHDmnoQvWvriIXCHTp2HsMdYVJSMQxtjv
         ituIyTaWknNba6m3JAz5dZQ5KIgIYVzqg7368=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686056138; x=1688648138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+8gN3mys4shi44Ntk5Z6kfGgYi/MZwn+Sx3ui4XedQ=;
        b=cj9olqUAocrYMp16sfgtDMwx1NBCXaNb/oT4dZmG/HhctQuyby5saiDHNi00OzgwT9
         SdQtElagDmmNDFl+MggLfC2KXz8BLEKuqpz23GAw5DgIcY0w1hgFURkVrai6o1+//5/v
         7pAs1a/1b5s8lG3iTDdX1WwX+ngGn4P5k3YE4OxUWaKiLktjdiyH+GWCqytS/RJVTljG
         3ljs5mz2a5ZsdEOiKS9FTRBWaN2qdDXojmzOnxVTQK/1QiiFZlkL0XZOXyIwuYBrmhK3
         OwuqgbaGCGUPk6owU4zGxdeW7bUbaZjDLjqDVRG2+U5K5WS369mhtxv1e22iFDVKjGK0
         s4Qw==
X-Gm-Message-State: AC+VfDzXa6DofZYcbXGHcdrULetFdifk7lYGSGdRMFSwVCej6d8FT7bl
        YDcP+SlbivQftIo7KLkgEo8zBMBuCaml9vQeFE5XruR2
X-Google-Smtp-Source: ACHHUZ7WvZATJ19ZcTUg3PF4bn9mus5dKOINU0zWMsyXMUB6rX5aRaar1wEH/98mm8Xlk9GLZ1bHvw==
X-Received: by 2002:a17:906:6a0b:b0:970:1b2d:45bf with SMTP id qw11-20020a1709066a0b00b009701b2d45bfmr2555870ejc.61.1686056137807;
        Tue, 06 Jun 2023 05:55:37 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id d13-20020a05640208cd00b0051643d71ce9sm4506144edz.26.2023.06.06.05.55.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 05:55:37 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51492ae66a4so8510668a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:55:37 -0700 (PDT)
X-Received: by 2002:aa7:de9a:0:b0:510:ee0f:1eab with SMTP id
 j26-20020aa7de9a000000b00510ee0f1eabmr1797750edv.41.1686056136935; Tue, 06
 Jun 2023 05:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230606124800.1151665-1-agruenba@redhat.com>
In-Reply-To: <20230606124800.1151665-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 6 Jun 2023 05:55:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_P4tOWCbZYo11u5vbB+tTxCSGwKC9m71y-QdbZP8zKA@mail.gmail.com>
Message-ID: <CAHk-=wi_P4tOWCbZYo11u5vbB+tTxCSGwKC9m71y-QdbZP8zKA@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fix
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 5:48=E2=80=AFAM Andreas Gruenbacher <agruenba@redhat=
.com> wrote:
>
> - Don't get stuck writing page onto itself under direct I/O.

Btw, is there a test for this DIO case?

We've had the deadlock issue on t page lock (or for inode locks or
whatever) for normal IO when faulting in the same page that is written
to, and we have as pattern for solving that and I think there are
filesystem tests that trigger this.

But the DIO pattern is a bit different, with the whole "invalidate
page cache: issue, and the fact that you send this patch now (rather
than years ago) makes me wonder about test coverage for this all?

                Linus
