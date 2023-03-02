Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714506A8706
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCBQl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjCBQlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:41:55 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECBC35A5;
        Thu,  2 Mar 2023 08:41:51 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u9so20529750edd.2;
        Thu, 02 Mar 2023 08:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677775309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hqmFHLIVVDxhvIU62EN6xy9b21kgStvoRKH93Ih6aGQ=;
        b=HwQreqnneKxXLaTd2xJAKwNUgmlwCevSjqH/kB8v6BR1S1knns+tHGbYB2r7WFrB6J
         uMeafiljJ/oIxTi4uZ6pK38ePYn6WnmrWGPTaUVaVBn09gVpMFjeQoC8myGrcNn6o9p5
         hqq468OKeKQvClMjJSEyLhCJqt1MlrZ/7hbifiembOdkAqcAlXr6lztTxvYWf7dL8R1r
         xlFfWkJZM+CiXI7sZp7D9BMJFyPoCGDCZcZc+gt4c0y8CJCLes3iZtUVBruFgsqv23Cu
         HsrooyVIT4pzuhpupjC90WCRwFYpiYOvzdTT5M2PUMzeF3EktehV7qhr3oqry+mtLVz9
         hyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677775309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqmFHLIVVDxhvIU62EN6xy9b21kgStvoRKH93Ih6aGQ=;
        b=JMM+bXJSxFckXzrVSCCbMZFBA5R8xNtR8h4ejyEcfAfIo+hB57KK/tHIyeis1AC3WD
         Uo3Yx1IqrraVuD0UKxsi9tTzzXrz64OkxdxE9bhQWft77ChmLChanw1OeK3wl0XCLjf8
         Cx+r+nCn+FugckcRAXv/MLAsHtm5F4WhfcqbCDVPiU1dIEAOxDrmzZrNUdXp38pOLOuq
         cT7txY0UOfQfAsAUDuwYBhq6wfq2DMfpRM7bKEwC7BKvuT0TZEClB01XEkMFKiXk4Byb
         JyLmESAiF9aCHNrgGEBX+XWxIAfnaBsqqrtcV/Uyx8EVFQUTK4SzRdpKegMr9f0Pfja7
         feSg==
X-Gm-Message-State: AO0yUKV69Jr9xkOqUcrgpCOxVvMn2VnWiuwncEYGG614S7vKm5xtW8VO
        DGLiQr6hek5EcXfI8tOfI/fQdjWDbvg6Rg==
X-Google-Smtp-Source: AK7set82cIQghQTqqSG7Br6ZTSrLyKD1lxGEnvfpMkPkhwpghuZzWWHbVjBFT6MaiFta9JRuIRFxFw==
X-Received: by 2002:aa7:de8c:0:b0:4ab:4b85:a69f with SMTP id j12-20020aa7de8c000000b004ab4b85a69fmr10866390edv.1.1677775309236;
        Thu, 02 Mar 2023 08:41:49 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a22-20020a170906191600b008c327bef167sm7230998eje.7.2023.03.02.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 08:41:48 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH v2 0/3] Improve trace/ring_buffer.c
Date:   Thu,  2 Mar 2023 17:41:26 +0100
Message-Id: <20230302164129.4862-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
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

*** BLURB HERE ***

Uros Bizjak (3):
  ring_buffer: Change some static functions to void
  ring_buffer: Change some static functions to bool
  ring_buffer: Use try_cmpxchg instead of cmpxchg

 kernel/trace/ring_buffer.c | 77 ++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 44 deletions(-)

-- 
2.39.2

