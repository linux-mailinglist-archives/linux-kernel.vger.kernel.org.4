Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0F064D9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiLOK5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiLOK5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:57:36 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E1A6454
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:57:34 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ud5so51358520ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=MBQ6hVnZML0By6HKfqAr16DEf49bHB/ZZHyANQ8cfk4=;
        b=goA+oAoyMvDOA83zxszqQSuR4mN9HGUiBm4OsL7yYfwxHBm04W0N1gRvs3raa13s6I
         2GgMxv8tp37aEFMY2kjtameIBLqrLpjneZPW73zRIP9UW6BAGepx17ebRHvKVz1ds6Yn
         9XN6LcshTcmQ4nKPxpxynY+b7cyPICQGrkKHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBQ6hVnZML0By6HKfqAr16DEf49bHB/ZZHyANQ8cfk4=;
        b=6Qpgvk9aAwPPUluj8CspCYT1Afpfdk9eITzOGV0J0t4v7QZ4bWFjhqq7MhomxVqdN3
         qU9knScYCf8fA+/tstPTpj+RW55JA4I2wa7SGho3kizAIjQgC4ePNrT6g+i7BK6EcwhE
         Tgp57QR4bfwn4wDsWURTtvIUsB5NVk7JGWwCVPwsueQ2fPEwz02yM8EyENkeMAKWBjPf
         uc+Now/Um3kPGJ/QQaFvPmq0diJtZPfP2nArNKo454CzIFe/jr1Z5zCpOYAHJhRF+Ray
         SK1EUFYUE7F3DauJXGwHd8Sa5ERAlXPvlLo0OaXM7EQKL+lY+PIMPpFsR2XQS12kDE8J
         w8Kg==
X-Gm-Message-State: ANoB5pl0Mj95n6I5+5lXhXlomjQ9/bn0XG5E2KjHEto0L99qgt58dTkW
        cAgGI3NXWEJcomYD9CN1ACBWJw==
X-Google-Smtp-Source: AA0mqf5H9toxOvdlWy5KYDrSoWbtkQ5KFtswBQRwoWKsJgdCXt0izz4m+MmRRli29dX9LkOSxg83Zg==
X-Received: by 2002:a17:906:94c2:b0:7c0:e0d9:d20d with SMTP id d2-20020a17090694c200b007c0e0d9d20dmr23308220ejy.37.1671101852962;
        Thu, 15 Dec 2022 02:57:32 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id e8-20020a056402148800b0046c5dda6b32sm7339381edv.31.2022.12.15.02.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 02:57:32 -0800 (PST)
Subject: [PATCH v3 0/2] media: uvcvideo: Code cleanup for dev->status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI39mmMC/4XNTQrDIBAF4KsU17X4ExrtqvcoXejERMEoaBRKyN
 07dNlFuxreg/fNTqorwVVyO+2kuB5qyAmDPJ8IeJMWR8OEmQgmBBd8oK0DrZvZWqUmxgxUS+vAjk
 oqrQjOrKmO2mISeBymFiOWPtQtl9fnTed4Hj/EzimjhjGtpglG0PIOvuQ1tPWSy0Ke6HXxzxBoyJ
 mDNdcZRjl8GcdxvAEmyhvf/AAAAA==
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 15 Dec 2022 11:57:17 +0100
Message-Id: <20221214-uvc-status-alloc-v3-0-9a67616cc549@chromium.org>
To:     Max Staudt <mstaudt@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Yunke Cao <yunkec@chromium.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1868; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=f3vt5vV6S4YKdMY0W+NJsexZg7N1/1PGQBWqQnOC0z0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjmv2PptmDYlP18vZwvL2gkIADmZ0iBHbN5/pK6Z3j
 6JMY2SeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY5r9jwAKCRDRN9E+zzrEiLPJD/
 9Ae/C6WjpTUsgEpw5Hn/My4q1WId3iB6he7Mlmi50/GMmZRiLJRSAIw7YgKuZopsusPoXBCu6xGD/W
 MomFraaRs30tPqOZ3ZPmJu6xfye8LaxcI+ceJ99YBdyygCYFmqnYjxWWXqIvZ9dG65TV87DXeR9mI4
 sC0sIqIThf1YumGT9fM7nN0l1lIg3qz4253g4kf1iz2XstpegimkheGr+7Wt8uv5RITzJ86VMvb8Xc
 zNXg0GPnKLEAZLgKvhUdExx0iFQ9YjvKYNiwHPQe51JqCoykHb8TsGqY2qvMd1cSYLb8gajE94Xmkl
 yPh4fyLKoq/LU82a5SI61VL6YcxPpWAZGIVC7yr5xoK0sLzikTZ02bPYwKD0JQddhf10BBBpxArsto
 1QNunbzaP6vtWyot/k1eP+m6AuxuXd3P6RSiJbk+TDz5JQUYCLujg/lIkPav9euuou1b6ZmX7BUXZs
 lWdHknIO8uqD7cSixDzx1Oaz495pyjjoy7uTr7trvqsLY5d9uue68ImYXHoARyMpnPuPa91+d2IKJJ
 iSEazgE9kKYKc0LGWT5PdUa2RM5MIo4CLLXKr5A5iZk/s0ntN3cYcQiu/6v3hVyHp4Y7ryfmEEqEwb
 duIsmuVgvOjykH7YygDOWLKOf8/pcRrMnwundf3Kfotrj4s4JcHx+4B68dlQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to make a kzalloc just for 16 bytes. Let's embed the data
into the main data structure.

Now that we are at it, lets remove all the castings and open coding of
offsets for it.

[Christoph, do you think dma wise we are violating any non written rules? :) thanks]

Cc: Christoph Hellwig <hch@lst.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yunke Cao <yunkec@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Max Staudt <mstaudt@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v3:
- Split the patch in two
- Add linux-usb, Alan and Christoph for the allocation change.
- Link to v2: https://lore.kernel.org/r/20221214-uvc-status-alloc-v2-0-3f1cba6fc734@chromium.org

Changes in v2:
- using __aligned(), to keep the old alignment
- Adding Johnathan Cameron to:, as he has some similar experience with iio
- Adding Ming Lei, as this patch kind of revert his patch
- Link to v1: https://lore.kernel.org/r/20221214-uvc-status-alloc-v1-0-a0098ddc7c93@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Remove void casting for the status endpoint
      media: uvcvideo: Do not alloc dev->status

 drivers/media/usb/uvc/uvc_status.c | 69 ++++++++++++--------------------------
 drivers/media/usb/uvc/uvcvideo.h   | 29 ++++++++++++++--
 2 files changed, 47 insertions(+), 51 deletions(-)
---
base-commit: 0ec5a38bf8499f403f81cb81a0e3a60887d1993c
change-id: 20221214-uvc-status-alloc-93becb783898

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
