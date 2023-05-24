Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB08F70FA11
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbjEXP0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjEXP0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:26:45 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42853F5;
        Wed, 24 May 2023 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684941998; i=deller@gmx.de;
        bh=a/rTKcQNZd/3MCCXCflu1QYwVp3tjX0c0bd5rguwT9E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=a6fQy5Py0gqpmYfwdBQTG77MEWap1/ef9q8Rk/VSA2XibUr0TgIrfldtMxYzqUzoZ
         xRxGcE5ACKhehV7q9GDRj/lHrKqguek6XXyGcxJUNvxBvm20cEFn7+wtKvm7MHiaJy
         dZNq9aRC/Tvm025oBEkVAIjMIY9wxkCOaLVCZzxoTLNH+1iOPT8+3tWQsXKio4xmAD
         SlP/yGa8kcvN2t+IS180U/FHFRXZxmrwQ/otbDzZlzGZ8a7w7cVZ2Kfk55HPX1Y8aO
         QEzF++aFSu3egH0Xx/p751KkpJmclgqsu179unAn3zhRGWB43L8GCgyd9ejitZAPPh
         6WgbqCglyFq4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.145.4]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjjCF-1qPref0eGh-00lH32; Wed, 24
 May 2023 17:26:38 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux@armlinux.org.uk, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>
Subject: [PATCH 0/3] Fix flush_dcache_page() for usage from irq context on ARM, NIOS2 and PARISC
Date:   Wed, 24 May 2023 17:26:30 +0200
Message-Id: <20230524152633.203927-1-deller@gmx.de>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G9A8rI/s069fPME4StRViMRjVGNrddNylDGY6ZCVlNINeu8Zd7T
 f/DooBjATS+V8JEsbMBrE8FeaRkc7BochojlHoeNnW6qwHjqv5XYtX6TogVxNnHX/EAdz0l
 Z0jjqXPf6OxYS50/uKzAy1o+1Wr+izzYIXg0tO/0hKr7+ckL6ap6jecXwyXH2FRrIRVjI92
 7zf5YDv7QIsLhaXLqaNIA==
UI-OutboundReport: notjunk:1;M01:P0:ZtUcQNgcfns=;/kCVliBqooyPXHZQ7Ck+HSOEngi
 N9M+7+G17HsiIVjWlhzPOxPbRArXJ9+fXJCe9Y5PZybcVbZzWxGVd+x4i7WbI0IVpnqeITEMA
 bab1ItKgRp0G7L5r19zEoDh6H1Zn1TcUsilb0bhPsqRz9UiLs7+oaJco0kLL7rBqCIaMRHXX/
 hsSUkTvJPoKbU+sWgwRxFNRCM19uBWF4hP+GpiWfMdcivzSk7akOv9veeXvUmQt2vvpXcH00H
 i8RA/MKAouI5pR9EGcSer+KWv3nThv2mIRDD1ySlJg4bV7i006beQSqTr9fLQ4iHLl2XJ44AQ
 s6nQ1MJABk/XfESie7apmHLEz3r6a9YQStsHZdjLp2v/G+NRKr3jVBFJF8ZSnel0zKNlWXDjr
 I4R/Pz4j9ZixdpCnzlnej9bD6Y13CuHvpY4oWhsBjJVrWLIyQFz5K0YBKiBC4D6HXhrMXph8Y
 1ka/b8Dptdl4gHhEf0KNFKOz9Qlp0I0akmQbRjCGiISDaXu2TTFGpEo9goWQXKgBNwOuPy9Ng
 IVeEs0Cpa46jJElxQA61vd2OdyaHKHWGAZmCsVFB9MO5dVnBCD4gJ9qTLLoeIPqH/FvThiVHM
 ZrSkcQerBeYvAGZn0mnSKOeYzIU0RIn0NHES0MPM8vjeOFyyiKA7XaBNSzgn3V4QdS/7Okwmz
 aOgoZzD8FUVFN+1+gUkmnBeKC+1Z9Tea+5wkW64B6pS1k8ZskCJqjNm6SXb8UmLvv3VAWtqVS
 H7t9QBEXuH5MS7FM6+x/JzRoy7ZlvHzeaMl7wRZXZomAyJA6AYb85yWjhdYD14wBweoh9Bc3p
 3M0Y57FFDL2x0FryqI0f/PdMxcF9IZOcwbJqBYKvLCJqWOg3g/dF86lAYZfuWnhMv5y4wYFnV
 P4oePXM0jk+Y3cBKc890q9f7qeVf4oXZGMOkwifWUqA9JTMmbLq9Esf8KeYUYrkNof/85Lbav
 LDB+Ng==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM, NIOS2 and PARISC unintentionally re-enable IRQs in
flush_dcache_page() when called from irq context.

This series fixes it and should go to stable series to at
least kernel 6.1.

Helge

Helge Deller (3):
  arm: Fix flush_dcache_page() for usage from irq context
  nios2: Fix flush_dcache_page() for usage from irq context
  parisc: Fix flush_dcache_page() for usage from irq context

 arch/arm/include/asm/cacheflush.h    | 4 ++++
 arch/arm/mm/flush.c                  | 5 +++--
 arch/nios2/include/asm/cacheflush.h  | 4 ++++
 arch/nios2/mm/cacheflush.c           | 5 +++--
 arch/parisc/include/asm/cacheflush.h | 4 ++++
 arch/parisc/kernel/cache.c           | 5 +++--
 6 files changed, 21 insertions(+), 6 deletions(-)

=2D-
2.38.1

