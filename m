Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7E7657180
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiL1AzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 19:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1AzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:55:04 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE0CDFC0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 16:55:02 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d15so14676349pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 16:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yTqVNH++fZMirwbn+n2exEBd8ZG8kfwS08YzOkZ9oH4=;
        b=C94FKUqUcTIXM00dOO50LmScr0c+pLRL5UBLLbs0SVg9FuNwHGd+jVLE1y3gca/htk
         Vi4JvG9gUkpk8DXxuM7m3D/oUZSdIEugOzulbSPCyJ1L4Z3BjqJcMWGFne42sV0JKXc0
         3YLZXjrRIpi6G2GblEy+06rCeHGgXtT0XgbkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTqVNH++fZMirwbn+n2exEBd8ZG8kfwS08YzOkZ9oH4=;
        b=w1KuDOw25q/W87imZ2dyI/EJgtn1Tt8eECi6cFWqtAP5c3sy27jEm7p5WHNSa2/iuG
         n69/Hy4oAAsQqqUErzFnzTC703LGVF+iwPQOvASgU8a4nAaIAMe0he4runmYfZcEtmTg
         c61RpyQ+bj78bzAeB8Z2VyCIfWCPMojiogvg8b7L2ytzh2zc6uItyNYdVEho093i/+48
         AqOUrFhFTUIiDxBpJNN5Dx7XFnzZiJhctEbbaWMhYtDh9S7EfNqaahxBovQNnEVkFXR9
         JRL8Zc4zX3GzgFEkSzQq/m3Ny1jevcjf1kZJUFk4Q58qPbXPpP9zk7pOW3zuFNNjxzJp
         uBzg==
X-Gm-Message-State: AFqh2kpHDzZiIdSSbJ01S4E7BcT68iiPSh04I4FpGm1LaUQRlUHE7y0s
        n6CbnTLQrMeodF/YJJGw8VXE9gddZ2YZT4uY
X-Google-Smtp-Source: AMrXdXsZB9QQ6d2egb2hhk0rfrTPOiTet+8+Sff1neN2SPJQZptUfqgubjgNoZmWQCRxRfJDpqdrPA==
X-Received: by 2002:a05:6a21:c08d:b0:af:f1d1:6f7f with SMTP id bn13-20020a056a21c08d00b000aff1d16f7fmr33010478pzc.31.1672188901932;
        Tue, 27 Dec 2022 16:55:01 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 68-20020a621947000000b00580e679dcf2sm6045566pfz.157.2022.12.27.16.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 16:55:01 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Evan Green <evgreen@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, Lee Jones <lee@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH 00/10] platform/chrome: cros_ec_typec: VDM support
Date:   Wed, 28 Dec 2022 00:45:03 +0000
Message-Id: <20221228004648.793339-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for sending and receiving USB PD Vendor
Defined Messages (VDMs) between the Application Processor's Type-C
ports and connected peripherals.

Thir enables the Application processor to enter alternate modes and
process VDMs directly, instead of relying on state machines that exist
inside of co-processors like the ChromeOS Embedded Controller (EC).

Patch 1/10 reverts an incorrect EC header modification.
Patch 2/10 to 5/10 update headers and existing Type-C structs to
accommodate the VDM code.
Patch 6/10 and 7/10 prepare the Type-C driver to have more than 1 file.
Patch 8/10 to 10/10 introduce the VDM functionality.

Patch submissions suggestion (if approved):
- Even though Patch 1 touches drivers/mfd, it would be better to take
  the entire series through the cbrome-platform branch, to avoid
  cross-dependencies across maintainer trees.


Prashant Malani (10):
  Revert "mfd: cros_ec: Add SCP Core-1 as a new CrOS EC MCU"
  platform_chrome: cros_ec: Add Type-C VDM defines
  platform/chrome: cros_ec_typec: Stash port driver info
  platform/chrome: cros_ec_typec: Set port alt mode drvdata
  platform/chrome: cros_ec_typec: Update port DP VDO
  platform/chrome: cros_ec_typec: Move structs to header
  platform/chrome: cros_ec_typec: Alter module name with hyphens
  platform/chrome: cros_ec_typec: Add initial VDM support
  platform/chrome: cros_typec_vdm: Add VDM reply support
  platform/chrome: cros_typec_vdm: Add VDM send support

 MAINTAINERS                                   |   3 +-
 drivers/mfd/cros_ec_dev.c                     |   5 -
 drivers/platform/chrome/Kconfig               |   2 +-
 drivers/platform/chrome/Makefile              |   3 +-
 drivers/platform/chrome/cros_ec_typec.c       |  91 +++------------
 drivers/platform/chrome/cros_ec_typec.h       |  85 ++++++++++++++
 drivers/platform/chrome/cros_typec_vdm.c      | 106 ++++++++++++++++++
 drivers/platform/chrome/cros_typec_vdm.h      |  12 ++
 .../linux/platform_data/cros_ec_commands.h    |  53 ++++++++-
 include/linux/platform_data/cros_ec_proto.h   |   1 -
 10 files changed, 276 insertions(+), 85 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_ec_typec.h
 create mode 100644 drivers/platform/chrome/cros_typec_vdm.c
 create mode 100644 drivers/platform/chrome/cros_typec_vdm.h

-- 
2.39.0.314.g84b9a713c41-goog

