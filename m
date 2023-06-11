Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4587172B3EC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 22:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjFKUXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 16:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKUXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 16:23:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7993AE46;
        Sun, 11 Jun 2023 13:23:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5148e4a2f17so6535830a12.1;
        Sun, 11 Jun 2023 13:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1686514996; x=1689106996;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+tFnAn28hiPk2ZM+sMsKYnGj/GCEN4oSZGqvN8a4mfg=;
        b=qW/pMZT/anLIyPT2bgUC6MQjAUvt5u6CwXLr6ZEmrqDBWgag2lbUeCKe5HFeR0B2Vs
         FX1aGwHopbfJcv5Nh9Ie8IbVnhn/eF9wa7X3FuUTGx5i/Dv9JsOEIvAoz7KA93L7VGO+
         ILI2CquqTiKEFUXWvNjEyMxeqpt/VLhFnCQ0Tbr6a0bo5zC9Af8dlNL/M1YWCnGtQx6I
         E2rT2emvfPS6HgeVtyUapZHj463GLBlEO8p5Gj02NyhpBPAWQOJnpzbYtzapCD1cU3zA
         SwB8n7VsD7d3EPcaT2GLFDzYKvYRBSnqfeaI717CFC9K6m6hRluKQPly/kYHkFQEHuRP
         Yl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686514996; x=1689106996;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+tFnAn28hiPk2ZM+sMsKYnGj/GCEN4oSZGqvN8a4mfg=;
        b=j9IAFcY3ENCySJoZ2MKKzEYaI1+6HcoNsfhm/c+TUqqyT9SI0ysE3BARzs7j7tO+ka
         kx9VyYmRkN389FJLRo5z32NAc+l0+8I67/icpX15GTzrgP2yHp8kIHmJGe4R3D2ZsUuF
         HBKGTj+mT9ioSRdRcuRHI0RJzIIaEtQ5DbWuSpcQ6aNAkOT/1+yCq71IdTbXjVrvECb3
         IKzP2AdMUFqgKR6sWFbMBDP4c1iozyiSWU3DiMcVLiZgcnSdTqIuudImjKjXY5e/Ti3d
         V+oLE+CXiPf10e96pzSHVocCGrPZ+ht3zvJI42hQvxbg9MNqw1nExLKBxKJsWQ0ng/wj
         Vsxw==
X-Gm-Message-State: AC+VfDxfzKfVAmD6JMdf6jyJB99JQANdbygjzOkaizZWYLsJYiiGyms9
        x8y4X6leCvL0GRnwqiUDodWy+tj8EGvQRNDvEnNg8gv6vSs=
X-Google-Smtp-Source: ACHHUZ6pXTRoO4yNU2J8Qkd3PO++uzrbAZqi7HhmK3+47ERwIYKNuO0CYsTawmlj5mD3SCzpzobUH6/K0NwY9qbPPqo=
X-Received: by 2002:a17:907:9306:b0:974:1e85:6a69 with SMTP id
 bu6-20020a170907930600b009741e856a69mr7731621ejc.16.1686514995636; Sun, 11
 Jun 2023 13:23:15 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 11 Jun 2023 22:23:04 +0200
Message-ID: <CAFBinCBaXtebixKbjkWKW_WXc5k=NdGNaGUjVE8NCPNxOhsb2g@mail.gmail.com>
Subject: wifi: rtw88: question about SDIO RX aggregation limiting
To:     linux-wireless@vger.kernel.org, pkshih@realtek.com
Cc:     "Lukas F. Hartmann" <lukas@mntre.com>,
        linux-kernel@vger.kernel.org, tony0620emma@gmail.com,
        jernej.skrabec@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ping-Ke,

certain Amlogic SDIO host controllers have a limit of
receiving/transmitting at most 1536 bytes at a time.
It turns out that rtw_sdio_enable_rx_aggregation() from rtw88/sdio.c
is not taking this into account currently.
For any RX buffer that is bigger than 1536 bytes (which can happen due
to RX aggregation) we're unable to do any processing on the host side
because all bytes beyond the 1536 bytes mark are lost.

Lukas found that limiting BIT_RXDMA_AGG_PG_TH to 0x6 makes his
RTL8822CS work on the affected Amlogic SoCs.

My question now is: how can we properly limit BIT_RXDMA_AGG_PG_TH
without hard-coding a one-fits-all value (which may reduce
performance)?

Initially I thought that we could just calculate it:
  host_max_pages = mmc_host->max_req_size / rtwdev->chip->page_size
max_req_size for the affected controller is 1536 and chip->page_size
is 128, so the result would be 12 (I thought it would be close to this
number, maybe +/-1).
Unfortunately this doesn't fix the issue and for his board
BIT_RXDMA_AGG_PG_TH the limit is 6 or 7.

If you could describe how BIT_RXDMA_AGG_PG_TH generally works I can
come up with the algorithm to calculate the limit on my own (at least
I hope so).
Lukas has been very patient with testing so far and I understood that
he's willing to test further patches if we think that it fixes the
rtw88 driver issue he's seeing.


Thank you and best regards,
Martin
