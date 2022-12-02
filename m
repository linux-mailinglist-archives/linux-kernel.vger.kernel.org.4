Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E87640291
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiLBI4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiLBI4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:56:00 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C5DBDCD7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:55:58 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w15so6756164wrl.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 00:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qzZuugwCL8elJjd0iI5Ef2C4fvgW7dfeF1TuQRXtXLE=;
        b=yUBWTrtAlhDaWitQiZj4D/Fm6S0OWpMrVPfz26FO792LkjuUs/fBuArlWRI/HI3h/T
         YwJusY4oq2sfslJbrwDuUQr47VKfvWjedHTqFUVYRVDSfb9Uep1b26H4Ei72xHhoZmHR
         OYed6avLHrKSFLdUULrnvor/ekaHZ2rnk4x/wwhpco8r/Y3f+SEOjJVoShFT5er97CN8
         Is8ZPKl3H9fpsALRsg+U7+LB7LQ4b7uczYH9fRauApX9P+9cZ7gHbJ/R1dex/V9hRNV3
         RX0LRgm9TIXa0UeZgVUN2gW2/IONH1eWmveHEmJd1b1gEbP+p76m6LteedX6h9C3Qt52
         LCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzZuugwCL8elJjd0iI5Ef2C4fvgW7dfeF1TuQRXtXLE=;
        b=fRQVQtdZhn/BfnqtYkOKwgETpmA4QsZrCnww0VVD2wANAa+E1iZnj0S7y8obYRwpt6
         bdKgEQMd9KFKHSVmOsOAYZHJYYstej33dSlZxynzyVCVMIMOt2ZWFFvHtqeInQxPu9YS
         dWoBz5f49Hsw8JHiEieN+fVsk3yVTF52IoC+m6bHCNByW6ROtZSuV+6MXtFzdlbsV2lf
         /qLUFa/E1wFlf3GPB0VNEJv/xxAamYDRYgj+ZVaj0Zr7UQ9d7jlQOG1RjsF6vIyUNKEu
         i+SgMTkuV7Nvo09AwiDQN2Xu7/CMY4VxDXMjKfM+lEqI9HUkc+wunEUATG/6ehLEr1lc
         TAsQ==
X-Gm-Message-State: ANoB5pnRsoQ+e3q0QNkL7lZOryL6A70/paGK/KcIvZ3g3d3Z8h5TUQBj
        O7ZAtjweyNXDnHFDzVZUd+tpzA==
X-Google-Smtp-Source: AA0mqf5X570gTEmJ39IsjE027DA4h+SIyNsRE2Hm/9tZ4w6ylyD+YQOtiD5i969LSXyXjX0V0d/Ylw==
X-Received: by 2002:a05:6000:146:b0:242:9e3:87ba with SMTP id r6-20020a056000014600b0024209e387bamr19197614wrx.580.1669971357388;
        Fri, 02 Dec 2022 00:55:57 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:29a4:6f04:ddb1:1ed7])
        by smtp.gmail.com with ESMTPSA id a13-20020adfed0d000000b0024219b1cb1bsm6527517wro.60.2022.12.02.00.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 00:55:57 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 00/14] serial: qcom-geni-serial: implement support for SE DMA
Date:   Fri,  2 Dec 2022 09:55:40 +0100
Message-Id: <20221202085554.59637-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The goal of this series is to update the qcom-geni-serial driver to use
the DMA mode of the QUPv3 serial engine. This is accomplished by the last
patch in the series. The previous ones contain either various tweaks,
reworks and refactoring or prepare the driver for adding DMA support.

More work will follow on the serial engine in order to reduce code
redundancy among its users and add support for SE DMA to the qcom GENI
SPI driver.

v4 -> v5:
- split patch 8/13 into two: one for splitting out the chunk sending code
  and one for refactoring it (for easier review)
- when stopping uart: disable the irq first before stopping transfers in
  progress, otherwise we rist rescheduling additional transfers after
  interrupt
- make types even nore consistent in qcom_geni_serial_send_chunk_fifo()

v3 -> v4:
- don't assign NULL (even cast) to variables of type dma_addr_t
- refactor checking the SE_GENI_STATUS into two inline functions
- drop min_t() in favor of regular min() after adding some consistency to types
- check if the abort command was successful and emit a message if not when
  stopping TX in DMA mode

v2 -> v3:
- drop devres patches from the series

v1 -> v2:
- turn to_dev_uport() macro into a static inline function
- use CIRC_CNT_TO_END() and uart_xmit_advance() where applicable and don't
  handle xmit->tail directly
- drop sizeof() where BYTES_PER_FIFO_WORD can be used
- further refactor qcom_geni_serial_handle_tx_fifo()
- collect review tags

Bartosz Golaszewski (14):
  tty: serial: qcom-geni-serial: drop unneeded forward definitions
  tty: serial: qcom-geni-serial: remove unused symbols
  tty: serial: qcom-geni-serial: align #define values
  tty: serial: qcom-geni-serial: improve the to_dev_port() macro
  tty: serial: qcom-geni-serial: remove stray newlines
  tty: serial: qcom-geni-serial: refactor qcom_geni_serial_isr()
  tty: serial: qcom-geni-serial: remove unneeded tabs
  tty: serial: qcom-geni-serial: split out the FIFO tx code
  tty: serial: qcom-geni-serial: refactor
    qcom_geni_serial_send_chunk_fifo()
  tty: serial: qcom-geni-serial: drop the return value from handle_rx
  tty: serial: qcom-geni-serial: use of_device_id data
  tty: serial: qcom-geni-serial: stop operations in progress at shutdown
  soc: qcom-geni-se: add more symbol definitions
  tty: serial: qcom-geni-serial: add support for serial engine DMA

 drivers/tty/serial/qcom_geni_serial.c | 626 +++++++++++++++++---------
 include/linux/qcom-geni-se.h          |   3 +
 2 files changed, 413 insertions(+), 216 deletions(-)

-- 
2.37.2

