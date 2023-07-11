Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD11174F03B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjGKNeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjGKNeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:34:12 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D43C10CB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:34:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f96d680399so8373006e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689082441; x=1691674441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qN8Q+JhIAZh1V0mpeTmIC5QOKGMEQ2W1clMbASVjbLM=;
        b=BbpzShutPyBrqeIoJORso+sXdXknsiz2pVP48UM95hQnRySnaZpOOjBKcBIoocSIu4
         Algif1HyS54jAHNKOFHD6kXB39V27U6QiFz/cwn3qaHH6ngGfnMKxgdlk+YF1ezmj95J
         8mUagbbofTzHYE4yMkLzeKAg12ifkJRk741ndAsFUa9VvpdJK9m/CfsSUxc/Mqw/OxWx
         IheEfQqAeD7MWLkT2UibIdU07+mi6Hj4vHUhukbnkugAnlmRJgR4Ydo+e4j/3e5wE+1E
         +1AD53D4uZULQ0hX7nG/qDRgqj/+TVkBSB4KUEsVbRycACh7Y2BPY3kfD7Kak8pimxGo
         eZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689082441; x=1691674441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qN8Q+JhIAZh1V0mpeTmIC5QOKGMEQ2W1clMbASVjbLM=;
        b=Sm1FMMf8yxF3m4LrhWuBG8Io5rgSmLhDBsySfEYY/B5lWMP1/J9kuhEuf7IOwoEE56
         xenBKW+nzNq72O+4nswXKxBwJIqWezXK294+j3hEV5LNSlbwEiHLvE655z5WMfLEuwYb
         S3WoQZ5SdcbgI+h9d0lp7i9GR4PdZAHMhBGSDR62ye1SIo6K9FpdhyUBc/bovvJ+E+0u
         BSf3cyaNltMTUNvlBr8i8EUk3xs4SsXQUa/8GMznqkSwVlc5WdZ20cFqIsh68pI8YPFf
         GF6WwL4QwqKFeM481xMUiRmaPgDscY/qVPFaBGCV0GCyS9vkVbVELxtn50qmaLHgAmLe
         GKUg==
X-Gm-Message-State: ABy/qLbp1VFjCg84jlNDJ15ix60L7FaYc8WpipfXaExUHmdTjPkbJWE3
        8fE/ALgPaZSUiNRx5i1HWQuDwlv5bDY=
X-Google-Smtp-Source: APBJJlGRVZBwQlFNC+2pI9O1NHH7DgBE5TQjOppzT0vddtCbubmYb+hEMte4IF3+mR+Wt/SMdksv1w==
X-Received: by 2002:a05:6512:33ce:b0:4f9:596d:c803 with SMTP id d14-20020a05651233ce00b004f9596dc803mr17001670lfg.53.1689082440726;
        Tue, 11 Jul 2023 06:34:00 -0700 (PDT)
Received: from andrea.ba.rivosinc.com ([2.199.74.220])
        by smtp.gmail.com with ESMTPSA id v15-20020a056402184f00b0051df6c2bb7asm1276862edy.38.2023.07.11.06.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:34:00 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 0/2] riscv,mmio: I/O barriers fixes and cleanups
Date:   Tue, 11 Jul 2023 15:33:46 +0200
Message-Id: <20230711133348.151383-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Parri (2):
  riscv,mmio: Fix readX()-to-delay() ordering
  riscv,mmio: Use the generic implementation for the I/O accesses

 arch/riscv/include/asm/mmio.h | 72 ++++-------------------------------
 1 file changed, 8 insertions(+), 64 deletions(-)

-- 
2.34.1

