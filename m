Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81171606617
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJTQqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJTQpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:45:35 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB1511CB75
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:45:33 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1324e7a1284so216571fac.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SV58pEzlot3lUSwRLTp679DehzwGEhGPGUcZOXm/T3k=;
        b=DwIJBTs3AvpKVlWgkc94WmeShV3unhUEPMT3EPVwcK4bUdyPPG8O8BXWQ696u2kEZC
         Qg4RRHPAUWeSZ0jU9JCGIIpn13dG7MtrK+XE7/rtXtr1vHuYLGHYtvFxx9EkTTzT2lsn
         uisgRyS8LpHARDu88bQH/9dSeJCwfUOpEhYuEqv5gqHlKh8+PFbMrYmuuInRP5GXFTe+
         RdFhDT6UF1XzO6JwMNzd7U52XypJBO0F+TT09mp38hcQlVClYpRCM4c4aR5tKfir4IPE
         i+eVAWwmO0pEtbuoKnvNbCE7Xc1zt8kb5Jdo+sJqTV5xB6aZIhicJdAlhJ7mXtBLxD3j
         GoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV58pEzlot3lUSwRLTp679DehzwGEhGPGUcZOXm/T3k=;
        b=AIWw0zHa6C3jMTSN5uYZ4PRSDLM1wNXPnsRZ4prmBjZa4Vaq8+3ePXB9gzfb1ttz73
         0YPPSD2nwVDNfwJjEfu4MfxNmwteDjfxwCWF9SW6VgqZ60jcmprDoWJh5jCgij0aBjRH
         H7ZAptamv1XHS+JKWShfsqQaGjruqRzum8bJc+8agfYgXSXvLnMmos2BIESpZrU6wm5Q
         6HXjkRqDG3Yqp4aru8MiPU621Pxzmk5KTMiO7NI9jiPDhwTjoc5S+iPEslPpuV6d1KcK
         DLTXtjGhcHY37pDsYtd1++gYID8+BPIRnT4voDYxN/qmkx3RjpxEBvV4UToy3WSUK+Rh
         lLFA==
X-Gm-Message-State: ACrzQf1U5JBP+xGgIo3FoLm0jKviPJvGEpY1HdwbR7UJcCEOpTwKLyei
        /DK2BViCPzy67ARnesX9QAvfvGxlHYQ/BQ==
X-Google-Smtp-Source: AMsMyM5hGbbZ4GDi+jnyhmajXtUWqa0N8GI8e/yyGB4R9QEjR8utZ8LF3T/3el8RnsNltCGkqA9R1w==
X-Received: by 2002:a05:6870:f629:b0:131:7eaa:42bc with SMTP id ek41-20020a056870f62900b001317eaa42bcmr25330934oab.174.1666284332197;
        Thu, 20 Oct 2022 09:45:32 -0700 (PDT)
Received: from fedora.. ([186.122.181.28])
        by smtp.gmail.com with ESMTPSA id u3-20020a056870d58300b0011f00b027bdsm9154325oao.45.2022.10.20.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:45:31 -0700 (PDT)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     broonie@kernel.org
Cc:     mika.westerberg@linux.intel.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH 0/2] intel-spi: Split hardware and software sequencing
Date:   Thu, 20 Oct 2022 13:45:06 -0300
Message-Id: <20221020164508.29182-1-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the only driver for Intel's spi has a DANGEROUS tag for
a bug in the past on certain Lenovo platforms. It was cleared out
that the bug was caused for the spi software sequencing mechanism
and if we only use the driver with the hardware sequencing
capabilities will be much safer[1].

This changes will remove all the software sequencing bits from
the driver and left only the hardware sequencing functionality.
If the software sequencing capabilities are needed, the old driver
can be build using the DANGEROUS option from the menu.

[1] https://lkml.org/lkml/2021/11/11/468

Mauro Lima (2):
  spi: intel-spi: Move software sequencing logic outside the core
  spi: intel-spi: build the driver with hardware sequencing by default

 drivers/spi/Kconfig            |  15 +-
 drivers/spi/Makefile           |   2 +-
 drivers/spi/spi-intel-common.h | 171 +++++++++++++++++
 drivers/spi/spi-intel-swseq.c  | 231 +++++++++++++++++++++++
 drivers/spi/spi-intel-swseq.h  |  23 +++
 drivers/spi/spi-intel.c        | 326 +++------------------------------
 6 files changed, 464 insertions(+), 304 deletions(-)
 create mode 100644 drivers/spi/spi-intel-common.h
 create mode 100644 drivers/spi/spi-intel-swseq.c
 create mode 100644 drivers/spi/spi-intel-swseq.h

-- 
2.34.3

