Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180C860B5D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJXSlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiJXSkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:40:37 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DE87B1C1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:22:28 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g129so7580647pgc.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Br7gTGg+bTYjhFikYlTyWIS7XZ/zfRJ4l4mR4BaWnw=;
        b=kzio6O9foLsTdduw4qPWtUunGy7dBPJQWatiZpSYElPVhm7XOnXTntO5nGwbz5Jvks
         3hz7ne7iZC6ZidsmPuTeRpLDSFBpb51Fdso6dMUpyV/yXEX4PV2EXtbQsWKYjS30MUMy
         VEVBye+YalzCl05HweQ5bEdpYqGAFXcc7YWwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Br7gTGg+bTYjhFikYlTyWIS7XZ/zfRJ4l4mR4BaWnw=;
        b=77blKNsbBDVKOVlOjrhGa/qMDY0hUM5xANFVGqbQHfQoKx/9d9kBmhIesNW5sCCHA+
         A8XjGk4dqS9T9OZKJfWPYuF5wDtbv0dVBsI4Rpr96mwebKVGCemF4oUMlvuDcVUrt7mA
         KzBgVIl9zcdtgKViGTjeM6PBhxGOyW9lXkFwY9KpKtauj/1PhilyuCheKRM+fRoBBNYf
         5xgAyVavpTqHGDkyyIo9qxdOR07y1xijt1Ud0ffg5H/F50ZJYL11iE+eEIwOvxSA9kcG
         pw3Fx8BpS2FydWB3ZR3D2kohvnFQuDY+8dO9aHonAPCxUGl+VMgF8nhcG419DqDK8x7o
         HlEw==
X-Gm-Message-State: ACrzQf0NEULNPwowHXWP8r6JkAiYzt123nmqo/w1Z43iDuEiah/kAMgU
        LsWhGgBbCQRALJelyZynKV24eA==
X-Google-Smtp-Source: AMsMyM6Xf/Ay80cc04aGFXkV1EKdELuQWBz0ZTP9I2z2QQPt8yJjKHPxmWAgCU+8kCnc0Yjjbik3Xw==
X-Received: by 2002:a63:f903:0:b0:46f:1b5:b4fd with SMTP id h3-20020a63f903000000b0046f01b5b4fdmr5864583pgi.544.1666632060784;
        Mon, 24 Oct 2022 10:21:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b00172a670607asm19265269plm.300.2022.10.24.10.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 10:20:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Daniel Axtens <dja@axtens.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        Zorro Lang <zlang@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] Introduce flexible array struct helpers
Date:   Mon, 24 Oct 2022 10:20:56 -0700
Message-Id: <20221024171848.never.522-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=700; h=from:subject:message-id; bh=x8uV4aZZztVTmbVMfTDapI60PBgowK00+Q+TiPkLUcA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjVsl56wyNYJzpsbCQL6ohWRdrL8nrZWH1C9b0EBI3 /3hg+QaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1bJeQAKCRCJcvTf3G3AJp3hD/ 9v0h2HOPT0KyV9Wj+/DDXGTNfp/v78T2NN4VTDIWF9kfNT6gT9udpBvDlL8pQHJOICxaNrYg5cgU9R cvDFc5ySXOydg+z588o2heFtR6qOFdJEINyeRVRD4ue22IHHNYcwhQo3P74c3p2C6ho69L8GWCv46P dEXF5lBV+0KCgbBa/YedDUOU1G0cM5G8axwJciEI0GW7Pum/EDLLp2WX0aUUKiYhuvI2EBIRrrLkjq fJ04uDNEh9LdMRsu/N0Tr0OLRuelhmfga6IIQ0isHJ01FNViYhutX7nOGUjSYnIVZA1Ctk37Fu+aB2 hz3i9i3jypYhLpk9PYhRA6JUq52rC98D3Gn+LKF9quKWkLOXrbCUIDAmlGU0P+dwokq77BYJN4QMjs kaNGQ/yqYXU43FnajQMtF8Pp8spcEn6WyVGLnAwz9WoQNa3f0VDD2SbJDEFpt3ZUFm9RTYAU1LlNzC m2kWPSwWkCsn28Swuw/r/zgh5T41RFP/xVn/fbq44PIbV3+VPnE52BO2z99U5CWHJlhKKBRY4+L1S4 KVjZhjG0SpfQP6pRURij0/JIM6vhDr2yF9KgJxZmPGVBUoXdLxGbD4uA9b+XR4ekc6EnbC4HFR8NX8 2G0TrY2OsBOkvoq7z9WNDVWW8pcUtwVLjfmYu0oD/h6rCTmiuteuImcFwYCw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a trimmed-down version of my original proposal, which just includes
flex_cpy(), as this is needed by XFS.

-Kees

v2: only include flex_cpy(), leaving remaining helpers for the future
v1: https://lore.kernel.org/all/20220504014440.3697851-1-keescook@chromium.org/

Kees Cook (2):
  Introduce flexible array struct helpers
  xfs: Use flex_cpy() to check extent copying

 fs/xfs/xfs_bmap_item.c      |   7 +-
 include/linux/flex_array.h  | 325 ++++++++++++++++++++++++++++++++++++
 include/linux/string.h      |   1 +
 include/uapi/linux/stddef.h |  14 ++
 4 files changed, 344 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/flex_array.h

-- 
2.34.1

