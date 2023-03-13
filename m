Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6363D6B8037
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCMSTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjCMSTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:19:03 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA3C5DECC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:19:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p20so13910093plw.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678731540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKP/AFJeQr40lfvkoUD7JjvzM1HAlX7kxzH4QWjB/+A=;
        b=QppRJ6VBsJ2wKq3IgydXDAmdaCQYA72iSNQZuFXd5Vy318KyNTAAx2EWBosJo1mr+3
         5NLFw1uAeCAkzNQ23L5py1MR2RsKDJ7fS76EoMAD4n+9eQxe1evhh3ddejHwY6zQIneN
         U6RVu3YevdGMoVxiz0EMNm2DbBZVTNKy+vaUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678731540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKP/AFJeQr40lfvkoUD7JjvzM1HAlX7kxzH4QWjB/+A=;
        b=i1GG1162AQiAbBcB03EGErVQ+hYdNxej3jGk+tI/cnt5ag70Lr0LasNp0BjsevAzA/
         S4Kl95ss4LSvkaP1N3B3B0q09stcKG3tNZgNk6Mn0STRSb2KINYQt+kd2XyQ07VSCiFC
         rC259xdWsro2ozVDQ9rB/shA7ofbEHbZTNUFyeFiOEyggw60kuij65aALxEVU6OHJbSU
         Hy/RQ+fkQPez6UMqss5YqW2XbTYNQV6RfkiDo7qigtgLG6cFoZ9sdkNtGIGBd6yEhskZ
         PRBY+qNiM7bDenGqQZCsUKHTT7fJEetvgcLvdf69YznbQaYZP5Feuvp1/HAGB94rqNvE
         S31g==
X-Gm-Message-State: AO0yUKVOWyCrxcb/R0yrnlPaTT3r2h4dt+670enC7Ll4t0MlfvLqudab
        JuS2gP7lfzbyQFAsIWFWT5bEpg==
X-Google-Smtp-Source: AK7set9foeKnFdbG/Ui1XAXKuHYGeyr9EQ8oOYQWT5Aa50yJhB5fHYLdK/hdEMYaalFgdigbD1NkPw==
X-Received: by 2002:a05:6a20:258a:b0:c7:8644:a9ff with SMTP id k10-20020a056a20258a00b000c78644a9ffmr32590787pzd.57.1678731540454;
        Mon, 13 Mar 2023 11:19:00 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:79c6:a848:199d:3491])
        by smtp.gmail.com with ESMTPSA id a11-20020aa780cb000000b005ac419804d3sm25169pfn.186.2023.03.13.11.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 11:18:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     mka@chromium.org, christian@kohlschutter.com,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] regulator: Fix boot speed regression w/ off-on-delay-us
Date:   Mon, 13 Mar 2023 11:18:18 -0700
Message-Id: <20230313181820.2482385-1-dianders@chromium.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches together fix a boot speed regression on
sc7180-trogdor boards which use off-on-delay-us together with
regulator-boot-on with the eDP power rail.

The first patch is _almost_ a revert of another patch. Depending on
when the regulator is probed and the actual delay, the end result
might be the same as a revert or might result in a delay that's
somewhere between "no delay" and a full delay. As talked about in the
patch, I believe this is the correct behavior and, if the problems
fixed in the original patch are still present, I'm hoping that they
can be fixed in a cleaner way.

The first patch doesn't fully eliminate the boot speed regression, it
only gets us back ~250 of the 500 ms delay. The second patch gets us
the rest of the way.

The two patches can be applied independently of each other.


Douglas Anderson (2):
  regulator: core: Shorten off-on-delay-us for always-on/boot-on by time
    since booted
  regulator: fixed: Set PROBE_PREFER_ASYNCHRONOUS

 drivers/regulator/core.c  | 7 +++----
 drivers/regulator/fixed.c | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.40.0.rc1.284.g88254d51c5-goog

