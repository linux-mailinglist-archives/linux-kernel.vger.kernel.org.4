Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D10666D62
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239783AbjALJFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239911AbjALJEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:04:24 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967E852C68
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:00:03 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id i188so18360989vsi.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ23laUZs6KjNqXK2XFx5Pb9Rdas9/1BF4+iDdlfsBo=;
        b=potZArkto3X9RVVqwM4wpGy6V4Wa/PD0N5YvFlZlzTqb1a3taJrikQ15ozA6/uHamB
         Vo4ZBvDEKy02cf18Vumh3WYXWg00mb9FSEvPVXuzEurzirwgBOCPGNMk6DqKRBwF1lWM
         zJ2k4P6XKKj0AN40zWG56gc5r4zuvoClmK+VpPEUeWV11IsyTbjmVbF/bJitI0cq/reE
         oT9qbJG5WATueXzsj2n87o6/xsfwyRWdsXHK3NF8tEDvIMnogjB7gq++af8yeFqKUtvz
         9cA+46rt+zbMaDw9dM3F6XT/Smi3H/DrHY1agDBAUJ3e18avqvyWnNHQts9ROiOQls74
         nMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJ23laUZs6KjNqXK2XFx5Pb9Rdas9/1BF4+iDdlfsBo=;
        b=x2kbce5kAj+1BZr1W0pamGEWk+Vw7usayyP0ogZVE3OaiLqjwW9lH78oABfUxVdWqh
         Pa4/1y69Z4zFueSy8q9tMDqZDJuhn/y7dddEpE9Kvst3wDsbdcFMAo8G1PiPWZ9HZRcG
         javzWOiL78GFtQT+f2r4uxzkHpc/AwhQpHpxAZGqQytwesFVtTjEypVqFtsaXOOR41wW
         prgeHwLunNoUyYM8DjYbKzX7411Q3e14RkyVMBebOosM5dZgwppkZIkg6qZ4XAV10p3e
         h678k7poJUFtaGYq4aVwa42GwbffieJO+hIWjMnNHY2mga0v5gYr43quGOK8SCitxINm
         lWIA==
X-Gm-Message-State: AFqh2kqJ5RVKEWEVV+XTsSkZW5YnjZaAU5YuwopEDyuW+Sy2IdSnonqf
        yHdHkzw9hTdvHKH3j1QzEvpZTL4aX+WqkazUIVvapQ==
X-Google-Smtp-Source: AMrXdXviWdXojdoV3bFd8Xvbc8Okp/bpO2EoZvp3ZRkSFSZoAkdlPpXJVnkL8JErHGCzjRR9Pyodq2a1TjuQy9hfXnw=
X-Received: by 2002:a67:e111:0:b0:3ce:8fa9:1ec4 with SMTP id
 d17-20020a67e111000000b003ce8fa91ec4mr5712836vsl.73.1673514002505; Thu, 12
 Jan 2023 01:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20221229155030.418800-1-brgl@bgdev.pl>
In-Reply-To: <20221229155030.418800-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 12 Jan 2023 09:59:51 +0100
Message-ID: <CAMRc=McPdvZFJ4DhgAQ9rPOD3Xi89nrA3ZrgZtA33PjptQuPxA@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] serial: qcom-geni-serial: implement support for
 SE DMA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 4:50 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The goal of this series is to update the qcom-geni-serial driver to use
> the DMA mode of the QUPv3 serial engine. This is accomplished by the last
> patch in the series. The previous ones contain either various tweaks,
> reworks and refactoring or prepare the driver for adding DMA support.
>
> More work will follow on the serial engine in order to reduce code
> redundancy among its users and add support for SE DMA to the qcom GENI
> SPI driver.
>
> v5 -> v6:
> - move patch 12/14 to the front of the series and mark it as a fix
> - rebase on top of v6.2-rc1 (there were some updates to the driver)
>
> v4 -> v5:
> - split patch 8/13 into two: one for splitting out the chunk sending code
>   and one for refactoring it (for easier review)
> - when stopping uart: disable the irq first before stopping transfers in
>   progress, otherwise we rist rescheduling additional transfers after
>   interrupt
> - make types even nore consistent in qcom_geni_serial_send_chunk_fifo()
>
> v3 -> v4:
> - don't assign NULL (even cast) to variables of type dma_addr_t
> - refactor checking the SE_GENI_STATUS into two inline functions
> - drop min_t() in favor of regular min() after adding some consistency to types
> - check if the abort command was successful and emit a message if not when
>   stopping TX in DMA mode
>
> v2 -> v3:
> - drop devres patches from the series
>
> v1 -> v2:
> - turn to_dev_uport() macro into a static inline function
> - use CIRC_CNT_TO_END() and uart_xmit_advance() where applicable and don't
>   handle xmit->tail directly
> - drop sizeof() where BYTES_PER_FIFO_WORD can be used
> - further refactor qcom_geni_serial_handle_tx_fifo()
> - collect review tags
>
> Bartosz Golaszewski (14):
>   tty: serial: qcom-geni-serial: stop operations in progress at shutdown
>   tty: serial: qcom-geni-serial: drop unneeded forward definitions
>   tty: serial: qcom-geni-serial: remove unused symbols
>   tty: serial: qcom-geni-serial: align #define values
>   tty: serial: qcom-geni-serial: improve the to_dev_port() macro
>   tty: serial: qcom-geni-serial: remove stray newlines
>   tty: serial: qcom-geni-serial: refactor qcom_geni_serial_isr()
>   tty: serial: qcom-geni-serial: remove unneeded tabs
>   tty: serial: qcom-geni-serial: split out the FIFO tx code
>   tty: serial: qcom-geni-serial: refactor
>     qcom_geni_serial_send_chunk_fifo()
>   tty: serial: qcom-geni-serial: drop the return value from handle_rx
>   tty: serial: qcom-geni-serial: use of_device_id data
>   soc: qcom-geni-se: add more symbol definitions
>   tty: serial: qcom-geni-serial: add support for serial engine DMA
>
>  drivers/tty/serial/qcom_geni_serial.c | 626 +++++++++++++++++---------
>  include/linux/qcom-geni-se.h          |   3 +
>  2 files changed, 413 insertions(+), 216 deletions(-)
>
> --
> 2.37.2
>

It's been two weeks without any further comments, can this be picked
up now into the serial tree?

Bart
