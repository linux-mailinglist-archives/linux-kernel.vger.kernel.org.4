Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC4A6ACFAE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCFVAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCFVAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:00:06 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9393B4392E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:00:03 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a25so44435746edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 13:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678136402;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZKN2IAvn/W0itV5cN/krjEBOmvG6gUeQK8zrdi9C4NE=;
        b=H36F/k2ar0biFkJweyAOBEVLELT0+KVoCyu8tEcgy6ro4cAVIDS54i2T4CRJnyVwBU
         IsCMU8GqCxPbVxEL3wEDQE630FDLKANt00rQJ9yBhiArgBmXrmacHdMBDzSwek0GSi4n
         SViG2uvBxbhHmiFa7j1WwmKwWvVR1zD9sMBJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678136402;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKN2IAvn/W0itV5cN/krjEBOmvG6gUeQK8zrdi9C4NE=;
        b=6gijPniDHz18TiV/bR6VxceIHWiPin/+EHm7fAI9Q+wZUzPk6ctM07eZ74OaD6dKnh
         UYsN5+brxOj4qXKxdLQekLq4e3NXo2FShKZ5XTzDF6vtyy2fyTAZX6b5bKv/LAY+Vb+w
         418Mpmao1w25m52B0LR4UQlYTP95/L7HBrdtd0/mwZcQan/JCif7RGcqBs8ZYAETvB9U
         Q3+NIqBOWJNMa2orISoInMH/CGt5SzlbpJkN0hEdkG56ZEM897Oa2CcRtIi7w1XnN9Z6
         8bw222r0jm0XLEq0etWTNDjFvFIGCpphEnQE7ST7bMc/KPLO6QLo10+KCGJppkmywkkT
         qaWw==
X-Gm-Message-State: AO0yUKWUWFPvSk8YY0xbXxvJF3gZeJ4FFbboIAONesggtvbEmcAfjGyP
        xadCdVidmLmkZOlqz4mquTbgGz1pFhruRyjkx8uavalI
X-Google-Smtp-Source: AK7set9Y2SOYQm/WBtVDPP2+G6s/yJ6NAF4GRjhYT0l0rH0j3hRf2/SI7jOB5TE2EpcYrmt8UtUj1w==
X-Received: by 2002:aa7:c54b:0:b0:4ac:b760:f07a with SMTP id s11-20020aa7c54b000000b004acb760f07amr11915198edr.19.1678136401801;
        Mon, 06 Mar 2023 13:00:01 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id hy26-20020a1709068a7a00b008d92897cc29sm5028241ejc.37.2023.03.06.13.00.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 13:00:01 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id cy23so44066226edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 13:00:01 -0800 (PST)
X-Received: by 2002:a50:8711:0:b0:4bb:d098:2138 with SMTP id
 i17-20020a508711000000b004bbd0982138mr6547861edb.5.1678136400888; Mon, 06 Mar
 2023 13:00:00 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Mar 2023 12:59:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGA7WRzP9uDNwKjsgZ8B=ycnYaqOcEAPudfNfKtQP_vw@mail.gmail.com>
Message-ID: <CAHk-=wiGA7WRzP9uDNwKjsgZ8B=ycnYaqOcEAPudfNfKtQP_vw@mail.gmail.com>
Subject: cpumask emergency fixes pushed out
To:     Vernon Yang <vernon2gm@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a note to people involved in the multiple different threads that
I did a "quick fix" push of the verified fix for the random.c issue.

I still think that the lpfc driver in particular could be cleaned up,
and considering that the random.c use-case looks like it really wants
the same thing ("give me the next cpu, but wrap to the beginning if
that fails") I wonder if we should just have a generic helper for that
case.

The existing "cpumask_next_wrap()" function does do pretty much
exactly that, you just have to give it some unusual arguments. It *is*
used, but it's an odd enough interface that I'm not really sure that
I'm a huge fan of it.

Somewhat ironically, the native bitmap version
("find_next_bit_wrap()") does *not* have that ugly interface, and is
fairly straightforward. So it's really just the cpumask version that
has that extension that makes it so non-intuitive.

Anyway, I did that quick fix commit, but I do hope that people take a
look at those fixes for maybe doing things better. And if somebody
finds other not-quite-as obvious cases of that incorrect pattern of
checking a bit scanning function for 'nr_cpumask_bits', please holler.

                    Linus
