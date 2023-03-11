Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6606B5E40
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCKRBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCKRBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:01:45 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28B16FFF6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:01:43 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y4so3379243edo.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678554102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcBBeG/GDbaNyK6Z6mOsW8TdOcvbbaTtm0OR9JM78tc=;
        b=TruVEfCcNCj9tqbYMkbuWTQ4Su3dpCnlYBs5cOtEae7gv/6RTLuQSSzsOSPuWjQ7kA
         GpTzm5dyaRQnJ3pKwYv3ZI0bbyN3GiPKea99MVar57P+tBCEy1bIcnHKH17+GsL3X1Hr
         XCTgFFIHI44n7T2Flv/+rMa+LjfW6p9bUfP44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678554102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcBBeG/GDbaNyK6Z6mOsW8TdOcvbbaTtm0OR9JM78tc=;
        b=Wg1mwut170qSB6VhkfGcHVVJUNOvczgbaPhs3fO4ynt1pq2eCpgePmBCwJt+CfYj/8
         CtM99A/wfYMR4s712jzvi59j6Cy/1oeC6xBn3RFh2qljrbDD8GrgCce7TdQ5xKYF+k9a
         Y4JbgXPvwxBGG7T/D7sFZW9s82LYMPWA+Yo2kIWFrXfzgZsL8i9mHzrgg0HVvortAIDW
         2nN7JhxaIYrnIcDYDrf/L+q0v9klvX1AwgZHgW6QcPKBuhu3RTQJzm5UUvTmphsIv8+N
         kJ4Lcpet15oJhYJEOZ+eszhWiiRAhDPvCtG3+XgJlRn9AsKzNphlMV+abvbXXQFGSew6
         mqoQ==
X-Gm-Message-State: AO0yUKUa+mG/qPjJuNPQ6hPUi3ganKlUuw0AJCDrX9kv+Q3co7ZbUGlk
        gOrRijB+CDYQoTyuBtJixPlsOlAdgVdP1NTDdaSWxw==
X-Google-Smtp-Source: AK7set/InynlLwyWWF10OzNjpScJk5XrrZ0XWVrBPSbBhoz1UIKSx9564E4QKv8pIDxfRo7BDhwd1Q==
X-Received: by 2002:a17:906:6bc1:b0:8b1:304e:58a3 with SMTP id t1-20020a1709066bc100b008b1304e58a3mr32289427ejs.52.1678554101749;
        Sat, 11 Mar 2023 09:01:41 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id n24-20020a5099d8000000b004af73333d6esm212124edb.53.2023.03.11.09.01.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 09:01:41 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id cn21so2648234edb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:01:41 -0800 (PST)
X-Received: by 2002:a17:906:3d51:b0:8f1:4c6a:e72 with SMTP id
 q17-20020a1709063d5100b008f14c6a0e72mr14164994ejf.0.1678554100867; Sat, 11
 Mar 2023 09:01:40 -0800 (PST)
MIME-Version: 1.0
References: <20230311092929.2827-1-richard@nod.at>
In-Reply-To: <20230311092929.2827-1-richard@nod.at>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Mar 2023 09:01:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh7QzwMbkGC3yRhkqf=8BRk0KjS2pRwo3c5wTqqR4JKPA@mail.gmail.com>
Message-ID: <CAHk-=wh7QzwMbkGC3yRhkqf=8BRk0KjS2pRwo3c5wTqqR4JKPA@mail.gmail.com>
Subject: Re: [PATCH] ubi: block: Fix missing blk_mq_end_request
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 1:29=E2=80=AFAM Richard Weinberger <richard@nod.at>=
 wrote:
>
> Switching to BLK_MQ_F_BLOCKING wrongly removed the call to
> blk_mq_end_request(). Add it back to have our IOs finished

Applied,

                 Linus
