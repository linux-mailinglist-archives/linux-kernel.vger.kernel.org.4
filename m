Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4520A658E74
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiL2Puk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiL2Puh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:50:37 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B48713F49
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso13473678wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 07:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mxBRWEKdxDoxUmsf4m1Rf+wCWTOWa4yctJPkk6Ti6eA=;
        b=mAWTeny0sqvADkOky+spceEmg9syZ8nm2BawGZXoEyTRWH6pr2xqeTmQP6z3nF7ga4
         vJTk2fXB0ynr/dpSkhgIGH/AYtGa7mMVG+z0M/JjcThAmVF0p0wUVjpVmPj3lOfhTAU/
         1Dh/x3SgVJpZYdoD2JxwQb4be7nzV0WLkdsPScKFuwHreV9O5FsSUmYEHeonc8ncGQBL
         if+w7MFVFw/znWnPebEOCHBeErX1HH/SZZa+fqeAEu+TrfHwwvximtCfQSB0ZKsycRTx
         OjveQ4o2aMYzc0HaY5yF5E0kXS30j6QPurPra3G9a3fVSClCvTlbDvp8i1f+mElmsU84
         v3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxBRWEKdxDoxUmsf4m1Rf+wCWTOWa4yctJPkk6Ti6eA=;
        b=WKT2rHsiPvRc5Solg8Sh4YL7cGoYezwbS6Vyj2XwGBRrViyt+OoH5KrlMcNgwoNX6P
         PvZVlx0I/nLqXUPx5vvNdXwVPzJGufvxx4p5ifQKulpJZRx5asb9ye3HeBBJojv0QlR+
         hJx6Mzzyax3ZydzwMUAuPnLJbJhxnHvRNZBTqRT6TYJ0Zg2rLn1w4yDoSBIW/flO6u7E
         49t3vp/hqxqY01h93TAL2xHV4DrijACMEUqBJ9cJIvF70gik9b9yRO5+qU4HEmRHRTVD
         fVFqPYHwb6+CEVkmJLr+3EuHr2I/oTzBTvle+vRvWUb5CYWS+rFatgfIIHLTCREAqaTj
         URfA==
X-Gm-Message-State: AFqh2kom4sEUHB0BUgXzSeb1vLkcUbb+21OuTAJVyrTd006H0+QRSXxv
        li3HHNs6/xA1fqPnXBsj3lXrrg==
X-Google-Smtp-Source: AMrXdXt180PN5Ceh/nenWRord0+ZdJloEExn/Z1fAmgzdQZ3Flv/bOvzy0bNwEZKtBazgUjhZSX2hg==
X-Received: by 2002:a05:600c:1603:b0:3d1:c895:930c with SMTP id m3-20020a05600c160300b003d1c895930cmr20392802wmn.35.1672329033991;
        Thu, 29 Dec 2022 07:50:33 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8f7a:98d8:9d8d:ced8])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm25251647wmb.38.2022.12.29.07.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:50:33 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v6 00/14] serial: qcom-geni-serial: implement support for SE DMA
Date:   Thu, 29 Dec 2022 16:50:16 +0100
Message-Id: <20221229155030.418800-1-brgl@bgdev.pl>
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

v5 -> v6:
- move patch 12/14 to the front of the series and mark it as a fix
- rebase on top of v6.2-rc1 (there were some updates to the driver)

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
  tty: serial: qcom-geni-serial: stop operations in progress at shutdown
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
  soc: qcom-geni-se: add more symbol definitions
  tty: serial: qcom-geni-serial: add support for serial engine DMA

 drivers/tty/serial/qcom_geni_serial.c | 626 +++++++++++++++++---------
 include/linux/qcom-geni-se.h          |   3 +
 2 files changed, 413 insertions(+), 216 deletions(-)

-- 
2.37.2

