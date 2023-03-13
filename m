Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB826B7F91
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCMReX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCMReT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:34:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD052114
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:34:07 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x13so4540306edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678728846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIbaVotkbMkcwxISK+Gki0bm3/JChDv6I0UuodDYHc0=;
        b=T78v1EzfObjBvkEVYZ/GHQT7kUquMWkXwG5GptxqZbSvFpe7IJSKVm4uCX5MhYpULm
         CTbiXgppxV96ovBjyvr7UBmOEro7BsR0OGh2CMbplaElaPBs22qlmyV090sHgQ5QQ8tn
         JwkAchMGvLDiu7lzrZpCDic/wjzx4v6hN+6Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678728846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIbaVotkbMkcwxISK+Gki0bm3/JChDv6I0UuodDYHc0=;
        b=ygJhobuo1ZjEYfzCmmARU0SqK7eDcIhdVmgWxgEBB4dX2UQuvKdvSVuKn8mXl71Xb8
         xRyHvmJWLkqvskfk8eHsRnJ11YNdJN7Hm9EQM/dcxymeFKQCR53EHgtexT/djlHf6/RQ
         GgiXsZ4ZVe/uEUWnn9UqRcNQWsQ3t6L0sBoYGtpZjvbXt6En0XCf0fgw0dvb5Z3hvVzk
         TrHuwlwW7wnd/QyYpTNZPonjCJia80Wfq9OyRMs4j2hAfwXgYr4H0cZ7BLdBqDs1+HLJ
         1Kv5mZqviktSiZaZ7uBZevrjCbpURjc5/PP4C5pUc35e6ZBRR87L8Kh22Mrh9KJRnDJ8
         1b6g==
X-Gm-Message-State: AO0yUKU8kPHh7IJdkl64cVFR6uXXz1JR5pqfCeVdVojzS0JT/hs/IcAS
        2peRjzTP8XFgRY0xnfOo/+bGksWirpYTpboDI80Tug==
X-Google-Smtp-Source: AK7set/vB9iLL/Z0Va4th+s3g/4dERq3ncKVW/0JowocDl+Lmv5OJm8HjXIgo/OIfTlIEXyhuysuLQ==
X-Received: by 2002:a17:907:787:b0:8b1:3225:66f0 with SMTP id xd7-20020a170907078700b008b1322566f0mr47134030ejb.68.1678728845818;
        Mon, 13 Mar 2023 10:34:05 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id l1-20020a170906644100b0091f5e98abd5sm56671ejn.133.2023.03.13.10.34.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 10:34:05 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id x3so51787761edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:34:05 -0700 (PDT)
X-Received: by 2002:a50:bb44:0:b0:4fa:cef4:a27f with SMTP id
 y62-20020a50bb44000000b004facef4a27fmr3797657ede.2.1678728844911; Mon, 13 Mar
 2023 10:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230312200731.599706-1-masahiroy@kernel.org> <CAHk-=wgL-GspdmghwQ2kXJO1QCKFY+HieU0arYSFDHBLO0dZuA@mail.gmail.com>
 <CAK7LNATXqPy6F+gB8-1Zqh8hooXh3U_5+3xeMFZDZwYsUi=aeg@mail.gmail.com>
In-Reply-To: <CAK7LNATXqPy6F+gB8-1Zqh8hooXh3U_5+3xeMFZDZwYsUi=aeg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Mar 2023 10:33:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCZNRNL_2ftKoL9xWkUNgPb+0bAx_v_HVWW7bgW_YtBw@mail.gmail.com>
Message-ID: <CAHk-=wjCZNRNL_2ftKoL9xWkUNgPb+0bAx_v_HVWW7bgW_YtBw@mail.gmail.com>
Subject: Re: [PATCH 0/6] kbuild: fix some packaging issues, and use
 git-archive for source package
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>
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

On Sun, Mar 12, 2023 at 5:53=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> 6/6 did that.

Oh, I looked at that one, but only reacted to the removal of the
ignored-files script, not realizing that it also did that revert.

No complaints then,

              Linus
