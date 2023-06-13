Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED9D72E310
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbjFMMcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240816AbjFMMci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:32:38 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AD910F9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:32:36 -0700 (PDT)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3AD883F26D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686659553;
        bh=4Cl9VWUxsTMXwPPmsKYIpp+y5A1Gig+mMIFIzxHEGrw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=E6GE5uZfxl2XtN++p5VHcAadToIidS2cEKWCnYL1zzpEz9vfrqLYe/L5ZYbvStjwJ
         8y567VzN/2bAC0KW2XB4lPP/MnrpgYTwirSwbNTboTkmFqreJydJWXwOaL7B2iFWfS
         2QrhgVXbO43gtFT0lEM78wcsIR4VGoF/W8sytJtTCZuLUs0v2zRU3fX79GjcRbE6ho
         ydZGhD66LHmC5MUY3jfksWX70waRx3qPfDM9fvlGP5xVGBgBYE/kzjVy2ejEnpgZPX
         4hpLGI165f0viWBwt6YLeCLuSdMDG3/I0jTNLfdfQ+/CBK9zhT9vy0aZ0CqTWYDUJD
         En7G3yzfBQvMA==
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-39cece40029so1251861b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686659551; x=1689251551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Cl9VWUxsTMXwPPmsKYIpp+y5A1Gig+mMIFIzxHEGrw=;
        b=Hze9E0XAfEKJzoXqXjfV30H9x+HvID0Ho42LpgDBhBJVJ3LflN/htmzhjTH6Xkpl8W
         43jmnDqjLG1i4lPt+uzttEBa0XOX+nl1lJ2VC2TL2IsQyLWglHtFeuAd2GlLv1/WajQk
         SWjv4tmU7MXZV83u0+bHqnN4R4ubQ8AIlMzadAngBMRsKOmzPlkI5eiAhF3X927uvT2+
         pO+aP3xZIJYQcydKuNPeFwXPW65Q0ev6Wif2nLO0QW025USxc1YFodSuRPfXQxl9hZXw
         aFbyVbfKngD6oTLkG1A0eKUqwYYxvJCNnd3lN7OPrHQ0oCiH5GEsofN+FH7xzeDnilzh
         jOhg==
X-Gm-Message-State: AC+VfDyMJWOEfY6tTWausz/yxITU0jOEKI/0PDMmr6GEJIO5bFICA+MA
        Nit0sZtSTUF1tmuQtJdRkxNodzDQGCbyRqYUrZjKGe3h6aMstcO7AqbiLN2OvsJVJfvuO4jLAzb
        vJK7bcwfa3YuGaIALg2mLKR0eMwuqQ2FKEbdWVoaSzw==
X-Received: by 2002:a05:6808:1b06:b0:39a:be57:964b with SMTP id bx6-20020a0568081b0600b0039abe57964bmr8825630oib.13.1686659550793;
        Tue, 13 Jun 2023 05:32:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4JQJTAQ2NTad3LIh15eMndn6uBTwp05kyoejhWNzvWLQ3pSHSq3WyIrued9k1ZJLfgR4nV1A==
X-Received: by 2002:a05:6808:1b06:b0:39a:be57:964b with SMTP id bx6-20020a0568081b0600b0039abe57964bmr8825601oib.13.1686659550505;
        Tue, 13 Jun 2023 05:32:30 -0700 (PDT)
Received: from magali.. ([2804:14c:bbe3:4606:ac1a:e505:990c:70e9])
        by smtp.gmail.com with ESMTPSA id z26-20020a056808049a00b0039c532c9ae1sm4838116oid.55.2023.06.13.05.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 05:32:30 -0700 (PDT)
From:   Magali Lemes <magali.lemes@canonical.com>
To:     davem@davemloft.net, dsahern@gmail.com, edumazet@google.com,
        keescook@chromium.org, kuba@kernel.org, pabeni@redhat.com,
        shuah@kernel.org, tianjia.zhang@linux.alibaba.com,
        vfedorenko@novek.ru
Cc:     andrei.gherzan@canonical.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v4 0/4] Check if FIPS mode is enabled when running selftests
Date:   Tue, 13 Jun 2023 09:32:18 -0300
Message-Id: <20230613123222.631897-1-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some test cases from net/tls, net/fcnal-test and net/vrf-xfrm-tests
that rely on cryptographic functions to work and use non-compliant FIPS
algorithms fail in FIPS mode.

In order to allow these tests to pass in a wider set of kernels,
 - for net/tls, skip the test variants that use the ChaCha20-Poly1305
and SM4 algorithms, when FIPS mode is enabled;
 - for net/fcnal-test, skip the MD5 tests, when FIPS mode is enabled;
 - for net/vrf-xfrm-tests, replace the algorithms that are not
FIPS-compliant with compliant ones.

Changes in v4:
 - Remove extra newline.
 - Add R-b tag.

Changes in v3:
 - Add new commit to allow skipping test directly from test setup.
 - No need to initialize static variable to zero.
 - Skip tests during test setup only.
 - Use the constructor attribute to set fips_enabled before entering
 main().

Changes in v2:
 - Add R-b tags.
 - Put fips_non_compliant into the variants.
 - Turn fips_enabled into a static global variable.
 - Read /proc/sys/crypto/fips_enabled only once at main().

v1: https://lore.kernel.org/netdev/20230607174302.19542-1-magali.lemes@canonical.com/
v2: https://lore.kernel.org/netdev/20230609164324.497813-1-magali.lemes@canonical.com/
v3: https://lore.kernel.org/netdev/20230612125107.73795-1-magali.lemes@canonical.com/

Magali Lemes (4):
  selftests/harness: allow tests to be skipped during setup
  selftests: net: tls: check if FIPS mode is enabled
  selftests: net: vrf-xfrm-tests: change authentication and encryption
    algos
  selftests: net: fcnal-test: check if FIPS mode is enabled

 tools/testing/selftests/kselftest_harness.h   |  6 ++--
 tools/testing/selftests/net/fcnal-test.sh     | 27 +++++++++++-----
 tools/testing/selftests/net/tls.c             | 24 +++++++++++++-
 tools/testing/selftests/net/vrf-xfrm-tests.sh | 32 +++++++++----------
 4 files changed, 61 insertions(+), 28 deletions(-)

-- 
2.34.1

