Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373BE6F6543
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjEDGv0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 May 2023 02:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEDGvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:51:25 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616712122;
        Wed,  3 May 2023 23:51:24 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-55a64f0053fso326137b3.3;
        Wed, 03 May 2023 23:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683183083; x=1685775083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Nj97YY7b/CTteeKTlfDBS+ZuRuN+BV3rZ34zkwVtF4=;
        b=JsAD7LvXay1hi9dQbEU/F3972dDT8JGBaR4u9aNaDgXaiViaewT8pFumg4KfZaqKvo
         16oyc/Q9c5wwOtnUzqveZzl34tATUSef2sFFB5Jyq5KBF3E70tdPSsvd1ZLufjz0IwD3
         lFsgwp7grzVDPzviGR3LZitN437wXpIvia09XT09PTE5Zsce7rGGbVPKY2gzV6HLdwsn
         44Zo5+Ea4CL6jNaV4oRgpHEfQnu2d4UTJi+sh3BuLsJIaD5aivT2dFkYesurH17wFdHE
         FC5dFp7awtvws1JSpFQ5Zh7YrmCYr7z/GbBctA6Tw02yuENp3iun1O+p8sDrpiWM5h2C
         jTzg==
X-Gm-Message-State: AC+VfDyHvdiyrQs7u2wwwXks20thXZ+tz7qRB4lS+ly4OCqNGnQ11ofW
        BDbmIXZacornlLko/y75iJZhebcaTker0w==
X-Google-Smtp-Source: ACHHUZ4rnyLgmjHMXh2f7KtYDBFyUKYU0cvLbJH0edjKvgVLV9Peqju2vxmJ+1BR7/6VCjKNfFC1kg==
X-Received: by 2002:a81:8782:0:b0:541:8c8f:ec14 with SMTP id x124-20020a818782000000b005418c8fec14mr1195074ywf.14.1683183083397;
        Wed, 03 May 2023 23:51:23 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id d13-20020a81d34d000000b0055d7f00d4f7sm63632ywl.22.2023.05.03.23.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 23:51:23 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-55a64f0053fso326037b3.3;
        Wed, 03 May 2023 23:51:23 -0700 (PDT)
X-Received: by 2002:a0d:d754:0:b0:55a:792:8c20 with SMTP id
 z81-20020a0dd754000000b0055a07928c20mr1301034ywd.6.1683183082864; Wed, 03 May
 2023 23:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <ZFLI7T2qZTGJ1UUK@google.com>
In-Reply-To: <ZFLI7T2qZTGJ1UUK@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 4 May 2023 08:51:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWti0AheYvUYOVnQkgu38=zqsQbDEGj84s-ZgMn0nRXbg@mail.gmail.com>
Message-ID: <CAMuHMdWti0AheYvUYOVnQkgu38=zqsQbDEGj84s-ZgMn0nRXbg@mail.gmail.com>
Subject: Re: [PATCH] Input: tests - fix input_test_match_device_id test
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 10:49 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Properly initialize input_device_id structure in
> input_test_match_device_id test to make sure it contains no garbage
> causing the test to randomly fail.
>
> Fixes: fdefcbdd6f36 ("Input: Add KUnit tests for some of the input core helper functions")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
