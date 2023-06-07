Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A1872679D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjFGRnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjFGRnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:43:16 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF75F1FE8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:43:13 -0700 (PDT)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CA9133F166
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 17:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686159790;
        bh=WmSHbQvFF5f6oShlSOp6na/vuD5Z3LmWxy6nj8WTjlU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=cF7TKBRCKTxJ3o9GMXhfL85YeUkfyuZ20n/CIJ64VQDz3iYyHa94zaxuO3st+xjM+
         7WSpwxvs9H7QfUgGDmLS8CCrhYLADMmRM5Mfclo7nY3X8S53kHjvOp3SW6heI7r08Z
         Z40Z0FhGHCC1OReTrCkXcGX4H0idrN21taei70AkWbUo2pfbrJCFF83KzkdUlAb2rx
         mA6jyg2Qpo029JuuRIBC4yO1ddMwC5TEEJDd/xmmE8Q9dBF5p+dwNKVfcrVkYF4s1D
         7tVk2QkmPdBCfjfoOm9vlmeDBu/NbkX4GP8KU7EoALivSEn6N+46bN6N3lC1cg2tjK
         hVhs+qxegcPfg==
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b2adf6b550so232168a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 10:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686159789; x=1688751789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmSHbQvFF5f6oShlSOp6na/vuD5Z3LmWxy6nj8WTjlU=;
        b=bZYOc3Yu9FuxmdG1ZK4y5yB57MP8Dg5q5uCykPdb90hJVUxcau9gzhPhODWrptGMXx
         edpGGwrPbxlCySftGFnp7G5GcHT9WKI2TERf7P1NhtbYpEFJ/cUdYdzOC0Ao+/V6houQ
         PR56eM0M2XoaMsZC9uQDSEMpJyja07bkbTkkNROOQ6/OKF++eUsCA54Rj2soIrpN3pUf
         mQENbBbjiVpAmQnvEXRZPFBa59CLf3evpneOZeWg0nTKioCnSMYKkHPzmDDJ88Qv7SWs
         cY3F23F+AF/WVd9OSJtIyFwd/31JLxhj5QQESMHTrW59k0HQOE6jb4ABbwrMgEKljCqc
         Xblg==
X-Gm-Message-State: AC+VfDwlCXUIeJw7c+YVNzzNltcu4EmA+eQtJgWN2+Gjp6GpvgR61pEd
        qEdbr0vrUuZKhz74UTP3PR5FFKkwt4JhOaCjH6S0mUdhmTw6MBfhMzqR/NYl/Lq45YRuDRtfg6P
        RistlV9bFRD5vgKW8PpkKe3zUp/Zv41EzQGSAFjeMlQ==
X-Received: by 2002:a9d:754e:0:b0:6b1:6b1b:a430 with SMTP id b14-20020a9d754e000000b006b16b1ba430mr3686142otl.0.1686159789638;
        Wed, 07 Jun 2023 10:43:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7y2UsOcwGV8QAxAbF4lWwz6+dwjcghWUdXBjvMxOKVP6IbDWHVOWJ/CMebFItvu8iyz/QOMg==
X-Received: by 2002:a9d:754e:0:b0:6b1:6b1b:a430 with SMTP id b14-20020a9d754e000000b006b16b1ba430mr3686122otl.0.1686159789399;
        Wed, 07 Jun 2023 10:43:09 -0700 (PDT)
Received: from mingau.. ([2804:7f0:b443:8cea:efdc:2496:54f7:d884])
        by smtp.gmail.com with ESMTPSA id c10-20020a9d75ca000000b006ac75cff491sm2176016otl.3.2023.06.07.10.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 10:43:09 -0700 (PDT)
From:   Magali Lemes <magali.lemes@canonical.com>
To:     davem@davemloft.net, dsahern@gmail.com, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
        tianjia.zhang@linux.alibaba.com, vfedorenko@novek.ru
Cc:     andrei.gherzan@canonical.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net 0/3] Check if FIPS mode is enabled when running selftests
Date:   Wed,  7 Jun 2023 14:42:59 -0300
Message-Id: <20230607174302.19542-1-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Magali Lemes (3):
  selftests: net: tls: check if FIPS mode is enabled
  selftests: net: vrf-xfrm-tests: change authentication and encryption
    algos
  selftests: net: fcnal-test: check if FIPS mode is enabled

 tools/testing/selftests/net/fcnal-test.sh     |  27 +-
 tools/testing/selftests/net/tls.c             | 265 +++++++++++++++++-
 tools/testing/selftests/net/vrf-xfrm-tests.sh |  32 +--
 3 files changed, 298 insertions(+), 26 deletions(-)

-- 
2.34.1

