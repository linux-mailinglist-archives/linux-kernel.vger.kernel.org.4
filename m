Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE76A617D98
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiKCNM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiKCNMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:12:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F616366
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:12:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso1740303pjc.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qW4gA4/+DJWMLlFKdym0SavPVOtUXQ/aM3xm/iknIAY=;
        b=ZodLdYP8lVPofd3B+oGsbQc367anhy5Z1zIbLllCkCs5hrPGWsNZeaDVg6iqggLZ2X
         PYHvImabBOwQdJXpwvWpcjQxHPsozq0dVT8tpOtk7pP9hgu/jQz5p4ypTfeL3kzdzyRe
         H5I2Gc7OMVjcDdDmfMh+Oam2ryPHSQt4/OMQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qW4gA4/+DJWMLlFKdym0SavPVOtUXQ/aM3xm/iknIAY=;
        b=orV7wggx8/khq8KWLbsGnRcv+4BSQzZ/gpASmbnBJQvYN7ETN4mc1Sk1LdTjnmNOek
         D/zQ7N4qxBLR7R3s7z62y5bDd7oR34qvgXwDxe7AxrkbcEAAEbRiJpLDkmdQ4Ssi+CWU
         J+8DIItXUQHIgRLSbaWku9/vdM1caf9kuRB15rSIqwgWKkW1i00u+uUNU0/NTO1rLVwi
         tcKtOleY0PMc+5jfti+cGDZNiv2LTkLdDYkiWMVcczjdSaoDKj8lt1y9flqbB1wCww2o
         5sKnJ/kCpqtXIKlwxmYiMzBFiiHorTuOme4H17wtugV+//9MQ8CABBlkNM7qnyhwlsD/
         4tPg==
X-Gm-Message-State: ACrzQf3zi/Mx9TYV2dxjf2JnHL5Y7gcNrVhsKHGnALKazahT4ibcwK4J
        wY/m+OFmo+MRrG5BDwai8Xza4A==
X-Google-Smtp-Source: AMsMyM7bFYT5XNLn8m3prIt0FA0POqOU3cUEsL0nsCNLmS94LTYBXYnQNl/5s1+8joJQPsF2fQMb5w==
X-Received: by 2002:a17:90a:17eb:b0:212:8210:c92e with SMTP id q98-20020a17090a17eb00b002128210c92emr47687897pja.62.1667481169633;
        Thu, 03 Nov 2022 06:12:49 -0700 (PDT)
Received: from shuah-tx13.. ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b0018703bf3ec9sm647871plb.61.2022.11.03.06.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:12:48 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, valentina.manea.m@gmail.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix uninit and signed integer overflow errors
Date:   Thu,  3 Nov 2022 07:12:41 -0600
Message-Id: <cover.1667480280.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix uninitialized variable and signed integer overflow errors reported
by cppcheck.

Shuah Khan (2):
  usb/usbip: fix uninitialized variables errors
  usb/usbip: Fix v_recv_cmd_submit() to use PIPE_BULK define

 drivers/usb/usbip/stub_main.c     | 2 +-
 drivers/usb/usbip/stub_rx.c       | 4 ++--
 drivers/usb/usbip/stub_tx.c       | 4 ++--
 drivers/usb/usbip/usbip_event.c   | 2 +-
 drivers/usb/usbip/vhci_hcd.c      | 2 +-
 drivers/usb/usbip/vhci_rx.c       | 2 +-
 drivers/usb/usbip/vhci_tx.c       | 4 ++--
 drivers/usb/usbip/vudc_dev.c      | 2 +-
 drivers/usb/usbip/vudc_rx.c       | 7 +++++--
 drivers/usb/usbip/vudc_transfer.c | 4 ++--
 10 files changed, 18 insertions(+), 15 deletions(-)

-- 
2.34.1

