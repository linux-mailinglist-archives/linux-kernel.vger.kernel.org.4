Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B40604F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiJSRqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiJSRqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:46:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA591BE42C;
        Wed, 19 Oct 2022 10:45:57 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t16so7133345edd.2;
        Wed, 19 Oct 2022 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b3qQsYa/7ZweA0u9kpHAV4Ioh1PIQ7YV+2Zy1Ir6xbc=;
        b=EF+8GxOqjD7tz5bBqhQA4A8MVrYO9BfsHFXvcqliLTVztgNGNy46gTL+cw8it3RwDk
         I/yhw3zBTCKhOcz/MgyqQTstezO7xTAkqm0DgFYQ4Tx83dsic6vwctukoJj3QKIMWym0
         x75Ep7MCrpFRgXJuifRFM79uan1zhrm/Yy7bXUf/HDFQ3dP3EMZUYM6SGW5RNUd6aL5u
         EUc/wtxvAwVC0n+0OSEmsqktGpgf6+SMfQdJgBK7Jxr4LzxOhQpW+d2LaXnc+cpxZdmp
         xqyfYl5yO4B1HRkjPdhh33z4p7MAPeFrW3wRXwICAgaTIPIVpFTcNF0U9GRU0JWpsX/e
         LRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3qQsYa/7ZweA0u9kpHAV4Ioh1PIQ7YV+2Zy1Ir6xbc=;
        b=A2eSfIp33uM0iDRftUr2q0xcAKSZv8rU6ZBZ+W4N+EzH6MG5GaVpAb+yGgqaRJWDW6
         9bEYwy8jPDyT8B5/hRNLTQ2Pe+erT0JaGcrtKuwBiaBGnoKTf1PAi5Yfsi3UOuTnt8P7
         6B9xTfqmPPaI1Zr3FTWZNAtzIVGju7X9/Pv4O0lXUm0MI+tFs66E8lIk0WGkciwHvbLb
         ndTj3VM/emFq4YwMeRv/pnjAflY+RYkspkIwNO0MnR0Z48OQeBlJy6QqG238JoJm9xUF
         uq6R9TF+zf8h1qXtC+VAZFzJpv1rf+Xa5EEmYfE+hWtz5pnTTSkdsOoA4rT0sf3WnSIo
         vSSQ==
X-Gm-Message-State: ACrzQf0iS0h87dMiwx0dak8HPWJaYetAxSjzBXReR29pP679w9RS2EZ1
        RhvKxqUSJNg0v+nKx9ELBpA=
X-Google-Smtp-Source: AMsMyM7+C12t1o8higEU9r6SRH5hrJEdLyfeE4a3rQuBGmahnVZeQqTgOz5AVJmtx85oAd+c0bbn/g==
X-Received: by 2002:aa7:ca45:0:b0:458:d9a2:6164 with SMTP id j5-20020aa7ca45000000b00458d9a26164mr8734873edt.340.1666201555073;
        Wed, 19 Oct 2022 10:45:55 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id qn24-20020a170907211800b0073c10031dc9sm9218382ejb.80.2022.10.19.10.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 10:45:54 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/2] media: cedrus: h264/h265: Improve aux buffer management
Date:   Wed, 19 Oct 2022 19:45:49 +0200
Message-Id: <20221019174551.2695149-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current handling of mv col aux buffers in h264 and h265 code is not
optimal. In h264 case, it allocates pool for worst case possible which
basically never happens with typical videos. This also prevents it from
working well on very memory constrained devices, where CMA pool is very
small. In h265 case, number of buffers in a pool is equal to number of
capture buffers allocated before streaming is started. If any capture
buffer is allocated afterwards, Cedrus gets bogus pointers. This might
cause memory corruption.

Solution is the same in both cases. Instead of using memory pool, do
individual allocations later, right before aux buffer is first used.
Such approach allocates just right amount of buffers of optimal size.

Proposed solution frees aux buffers in streaming off callback, which
is first possible occasion. I can move this to .buf_cleanup too, if you
think that it's more appropriate.

Finally, h265 patch can be considered as a fix (prevents overwriting
random memory). If deemed appropriate, fixes tag can be added.

Let me know what you think.

Best regards,
Jernej

Jernej Skrabec (2):
  media: cedrus: h265: Associate mv col buffers with buffer
  media: cedrus: h264: Optimize mv col buffer allocation

 drivers/staging/media/sunxi/cedrus/cedrus.h   |  16 +--
 .../staging/media/sunxi/cedrus/cedrus_h264.c  | 118 +++++++++---------
 .../staging/media/sunxi/cedrus/cedrus_h265.c  |  63 +++++-----
 3 files changed, 99 insertions(+), 98 deletions(-)

--
2.38.0

