Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C763662675
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbjAINEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbjAINDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:03:08 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E89B167D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:02:26 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vm8so19894064ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 05:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LkzjllfIyWMzDeEVD7OKUMHITseBrUR0IuEgUUno/hw=;
        b=HVejhwClRNQ3MUtfWYs0WnCJRsAnIzlGhfP+OnefrHhLWhWhcDmk/dY2bj9CfU7+EE
         In84VnurTtcFTxUrxWjFoLx6E60B13rANMzMHJfvaMaeCAqqA/8VB0vv7CKNiPabcFeO
         xp007nViaZqnrqXDgI9XXZXKke4bqpEvGAP1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LkzjllfIyWMzDeEVD7OKUMHITseBrUR0IuEgUUno/hw=;
        b=lL1qY4OqGRAGx7EyMyjZtZX9AjB+7/4JsnoteXgLXafR9n9KH3EKV4sjkclrNI9AEy
         mBrVYgupVUY9GVTk4Qmf63x4yUxH8cQ2yf387ylHHuEQl5sdQMZfgADQjQ9/Rte9js1k
         pMGCH907jBIg6iZmxqFPT1BjvBWUSE2nGH4hu+TzDOD2402oihTY0vRuUo64P4omTpha
         6kCrye9gW2ZUKxmAMsqKo6rttFhHv/CgCajuKWjPSD4wlhTcmZrFOeNaM3fhWJ6GFOo0
         vKfvPyaylOki2k5ko0xjSD+tkPIJOguskGegWx0gCYmRMogH2RQi8Xa0l9cjSUncO6+C
         OhSw==
X-Gm-Message-State: AFqh2koZcTgjFwNrZ1+Eadsu8zoTk3bPJ15L1Q2S4x59+8zYWwJjPzCh
        00H6loyncbMZwtR66ncX3Cf8xqVfrSUYjdjQQTeKdg==
X-Google-Smtp-Source: AMrXdXuYd8ep0FE4rsIiKYO8EGoVrT8K6dwHvKpNV3yPBrN9VUSuX2TpZrcn2sMDaeDRWd6E4UufeUUjTqw6lUXPiPM=
X-Received: by 2002:a17:906:4e98:b0:82d:e2a6:b04 with SMTP id
 v24-20020a1709064e9800b0082de2a60b04mr8059816eju.748.1673269345065; Mon, 09
 Jan 2023 05:02:25 -0800 (PST)
MIME-Version: 1.0
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 9 Jan 2023 14:02:14 +0100
Message-ID: <CAOf5uwns3YZMY5xhM+o0rNvtTqEDwCbua5HuSy-LBwgZq_eWYg@mail.gmail.com>
Subject: NXP imx6ull nonalignment buffer question
To:     Bough Chen <haibo.chen@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haibo

Working on imx6ulz design and found that if I send a sdio packet using
the sdio_writesb the adma driver tries to handle it with two dma
descriptors. The first one filled with the bytes up to 3 to cover the
misalign and then another buffer descriptor

  offset = (SDHCI_ADMA2_ALIGN - (addr & SDHCI_ADMA2_MASK)) &
                         SDHCI_ADMA2_MASK;
                if (offset) {
                        if (data->flags & MMC_DATA_WRITE) {
                                buffer = sdhci_kmap_atomic(sg);
                                memcpy(align, buffer, offset);
                                sdhci_kunmap_atomic(buffer);
                        }

                        /* tran, valid */
                        __sdhci_adma_write_desc(host, &desc, align_addr,
                                                offset, ADMA2_TRAN_VALID);

                        BUG_ON(offset > 65536);

                        align += SDHCI_ADMA2_ALIGN;
                        align_addr += SDHCI_ADMA2_ALIGN;

                        addr += offset;
                        len -= offset;
                }

In 48.7.4 Data Length Setting
For either ADMA (ADMA1 or ADMA2) transfer, the data in the data buffer must be
word aligned, so the data length set in the descriptor must be a
multiple of 4. I have noticed that this code does not work as
expected.

Did you have any feedback?

Michael
