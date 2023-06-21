Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D457F738743
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjFUOk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFUOk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:40:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1166E7D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:40:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so8291042e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687358423; x=1689950423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f2ZxKH/zYUyI3Fsx259m0wKdghaf8v8UuN2CsSCojAY=;
        b=XjrdzfFkuf4HVso51RDn3gGgScuQaf3nHVrfPPpb8Xveh/wYdDQliziltCfOK5yw9I
         vQQ4Ww4xfPaROY9UmCwZmikI6IXEbx6O9mQ1WDXD/ZseF+yZH5acwzxFoo0r2+Llmu4n
         mzg5O9TjnZUz6eLWAczaeEkW8fA6mVRObeuNOBzY9MqWDBYeg6HCUzb7/t43xFtUQ5ja
         ffa9/lOntyadCiPCa/J+yA1UFq8q8cXZHGsW26KX2CmCzX9wvoFhLAxVLiIvvFSXpKBs
         DDtD4ofIsKAAIv+Q9ibULUbRNiNI7qW66ihY3JauN9BFJvfI5rpJoeMi95/N+ILWi0gL
         zV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687358423; x=1689950423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2ZxKH/zYUyI3Fsx259m0wKdghaf8v8UuN2CsSCojAY=;
        b=EqaOYlZ+ImDrgf2Pw3hewD9J2pwP/gBoN1VQr7kB6GnHywVFRxKMnWBeRYmfpJzVDp
         NYuRYEvs/rJvJGWW+YlPYZSsVQzKFw/j0pfwL7cAMNRh5U39Ok7CPjatxzlUhVwoe4b9
         Sn8orA8cHXECJdhdXXNNlAJN0sAmak7yD+OwA3TxT1I11QL7MpBXNGkUiybSQLerz4TN
         kEgolgMNYOfrZNm760C5KLMWwrPGNQ0QDP8c40LgR3Qs0eyllODDbdbJE08MOvgYiMLC
         YqTp47Ta7mFQ51DGu0eIgrwZQkJeesevdpfHjYGvlfL7kXTyftYGyDUHehS+B1JtPpnJ
         XJSg==
X-Gm-Message-State: AC+VfDzsYqLhkp4BoV5GLBnVcv/Z0yv0kPsnOTGxEcqB1R+dTO2LQhpz
        a5uVTPDnTguh0Kb18cw8Y5+M8g==
X-Google-Smtp-Source: ACHHUZ55sQz7tTRRQTIxG8rd38eQ5i49fPDzAYmbaSloiQvAWYhkbcIQm8DDi3G6dFFc5XocywuLtw==
X-Received: by 2002:a19:5619:0:b0:4f8:6b7f:c6d6 with SMTP id k25-20020a195619000000b004f86b7fc6d6mr6434056lfb.48.1687358422922;
        Wed, 21 Jun 2023 07:40:22 -0700 (PDT)
Received: from hackbox.lan ([82.79.124.17])
        by smtp.gmail.com with ESMTPSA id l13-20020a056402344d00b0051879c4f598sm2689505edc.66.2023.06.21.07.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 07:40:22 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Bjorn Andersson <andersson@kernel.org>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [RFC PATCH v5 0/4] PM: domain: Support skiping disabling unused domains until sync state
Date:   Wed, 21 Jun 2023 17:40:15 +0300
Message-Id: <20230621144019.3219858-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new approach drops the is_off change that was part of v4. That was
kind of beyond the scope of this patchset. This new approach changes the
boot_keep_on in such a way that we won't need any kind of new locking
for a PD. This involves using the patch [1] for adding dev_set_drv_sync_state
from Saravana for allowing the genpd core to set a default sync state
callback for a provider that doesn't register one by itself. While at it,
we can add another such API but this time to query a device's sync state.
Then, we filter out each power off request in such a way that if a boot
powered on power domain is not attached to its consumer device and
the provider has not state synced yet, the power off request is skipped.

[1] https://lore.kernel.org/all/20210407034456.516204-2-saravanak@google.com/

No worth mentioning what changed since v4 as this version is almost
entirely reworked.

Abel Vesa (3):
  driver core: Add dev_is_drv_state_synced()
  PM: domains: Ignore power off request for enabled unused domains
  PM: domains: Add and set generic sync state callback

Saravana Kannan (1):
  driver core: Add dev_set_drv_sync_state()

 drivers/base/power/domain.c | 72 +++++++++++++++++++++++++++++++++++++
 include/linux/device.h      | 26 ++++++++++++++
 include/linux/pm_domain.h   |  4 +++
 3 files changed, 102 insertions(+)

-- 
2.34.1

