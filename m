Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD796A5154
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjB1Cku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1Ckt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:40:49 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F1B29160
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:40:48 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id d30so34109488eda.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677552046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S33amPXBgEdvAj5aotTxFER/po/FAxTdpekQddcRdP0=;
        b=YxKbnUWTkfpWeNciGJkOdlwppOPzA7xvnBrKyFYmchwEuCkUceKSBjsY/taOKRFXAX
         ZPUXHDflYsjqOhyR7qlNe3t+PNFcdFVoHxqRDCYsxYvSJhx6pOzGIbnu2TsbiNhR8Jt0
         gyDFTIxOxiTe7XKoVjUFQ/Pow7zfF4xKSe6DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677552046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S33amPXBgEdvAj5aotTxFER/po/FAxTdpekQddcRdP0=;
        b=dzX6eXB0KF13u4eQz5lB37KMWmWepAI/kpifGuYI9JiGevMWjb4SqZ2//0puyRgi+L
         G5r/KNoEvEExl0eBUqJegq8fwrQjNJS0hxCfaH+BXk+oNl0ybvzBW/HfWv/Yc44XodaT
         5Z9A+2/2aX/bOM8mJr2yvxFFYgkfV0wCtX/zI0EwN7/95FNSB3z6fqnSpVD9Zfzq6AF5
         pTwjOIbFEaMicZxpNW/mWXPcSFXtNvine0Xg36gpTW+CAz9IxZ1QmCr9vnZlB5u+KDdR
         8KIaIYIvszCV72Yc4HOP+ucLchrnm6qr71GwczaSrS6wJ48WHiJZfpdCb/iGF9CD5s3o
         R0Gg==
X-Gm-Message-State: AO0yUKUgHRLoGfFC0yOh9FbTr37lCYfiII8r3z56ChW/DpQHTMA6hHb7
        ZS+8kVDE9oF53a8eSt5cwYU5KkIb3WSOWf9AmTM=
X-Google-Smtp-Source: AK7set9PVV4gRGd61yPESkhyOPDT1DYC7WN3bnj+AvUllLlnQiZTetK+54h2LVHVYUleI5fJv+bSUQ==
X-Received: by 2002:a17:906:4a08:b0:8b1:88aa:46da with SMTP id w8-20020a1709064a0800b008b188aa46damr764885eju.48.1677552046293;
        Mon, 27 Feb 2023 18:40:46 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id r30-20020a50d69e000000b004acc5077026sm3807177edi.79.2023.02.27.18.40.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 18:40:45 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id ec43so34057822edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:40:45 -0800 (PST)
X-Received: by 2002:a17:906:79a:b0:8b8:aef3:f2a9 with SMTP id
 l26-20020a170906079a00b008b8aef3f2a9mr413714ejc.0.1677552045260; Mon, 27 Feb
 2023 18:40:45 -0800 (PST)
MIME-Version: 1.0
References: <1677529301-19530-1-git-send-email-george.kennedy@oracle.com>
 <face2b1b-0f2e-4a79-a71b-79681fc56273@t-8ch.de> <CAHk-=whxC0ob3f--B-igBp34ujA5PZQMcTnDQ8Zh8HA7+ZbeWg@mail.gmail.com>
 <64981d94-d00c-4b31-9063-43ad0a384bde@t-8ch.de>
In-Reply-To: <64981d94-d00c-4b31-9063-43ad0a384bde@t-8ch.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 18:40:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi3KimdZnsU5j7fPgPCpDj3QaZvmu5CXRsAE=NiOjmAXw@mail.gmail.com>
Message-ID: <CAHk-=wi3KimdZnsU5j7fPgPCpDj3QaZvmu5CXRsAE=NiOjmAXw@mail.gmail.com>
Subject: Re: [PATCH v2] vc_screen: modify vcs_size() handling in vcs_read()
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     George Kennedy <george.kennedy@oracle.com>, jirislaby@kernel.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, regressions@lists.linux.dev
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

On Mon, Feb 27, 2023 at 6:18=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> Tested-By: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
> (Or feel free to use my patch from above and fixup the goto/break line)

Done.

              Linus
