Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2989E5FBA8F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJKSjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJKSjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:39:44 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2BD1704B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:39:42 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l1so14004422pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IzYlQa//u6hTMK79BpSt7XrJJaaCVspYQvsy4Q0xk2k=;
        b=KFDX91IQNZpMDxkGaPntHDLpehYANUxuryuOgPhKsxXiD3irRAx4QGRz3G1qJEv0rH
         eufM8CzBmNz4Sx204Ng5fYlMJv4KXz7ogZFZmHAGx9WJFO2RIGG7HSuTgeenkJdln0oX
         SlJ+bOklGcojQ7BSTZ8gFmTkSBaCDEKLe7EgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzYlQa//u6hTMK79BpSt7XrJJaaCVspYQvsy4Q0xk2k=;
        b=xsslJb4FrOnXv1F9qBGAKKy0umRC66F+h1CQ4brCkdl6umdH4tv9UOjVV1I3dvVGMO
         epARSW33EnaraOkDYQqPmZhIBXxvR+lOv+INvovTzL46slAZnassaSGuj0L5+s0u0cMi
         nkGrMomFGiKV1sNrBO/kRES9ecXSQ8cyOrJRRG8S3dvbQTDEoKbClTgChZEcMYLsEj4w
         blpIDL6fubq/sImFJgCPYwz1jRx9p8lkX0qFHYlwgYzAxVqkZUl8XDyDd5geB1KOfRKa
         ToaOxcjaG6NZDNPwf2RoVEkrxtNVbhwvyOf7sQ+pa2Ca/T6Q2hzUA0XwG20uHkwngZEB
         OLCA==
X-Gm-Message-State: ACrzQf2+xRTtDsmsLGoOqHqPiS0jno3kQ52oTZOjJBqZUaV4ar1eeEta
        t22ZTIoABdvGwnoLkispm/tsYQx6eW31Og==
X-Google-Smtp-Source: AMsMyM6SefhZzZADOH/1yfaAZfQUUganxehw2L4jlhB4qrkWlxDmMv8G8I2WS9rNNdnfNKztCF50bQ==
X-Received: by 2002:a17:90b:17ce:b0:20b:7cb:9397 with SMTP id me14-20020a17090b17ce00b0020b07cb9397mr527694pjb.191.1665513582307;
        Tue, 11 Oct 2022 11:39:42 -0700 (PDT)
Received: from localhost (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with UTF8SMTPSA id i21-20020a170902e49500b001753654d9c5sm8982878ple.95.2022.10.11.11.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 11:39:41 -0700 (PDT)
From:   pso@chromium.org
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Paramjit Oberoi <pso@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 0/1] pstore/ram: Ensure stable pmsg address with per-CPU ftrace buffers
Date:   Tue, 11 Oct 2022 11:36:29 -0700
Message-Id: <20221011183630.3113666-1-pso@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paramjit Oberoi <pso@chromium.org>


Hi pstore maintainers,

Resending a little patch from May: without this change, the start
address of pmsg varies with the number of CPUs in the system. This is a
problem for tools that want to manipulate pstore outside a VM (we are
doing this for crash reporting).



Paramjit Oberoi (1):
  pstore/ram: Ensure stable pmsg address with per-CPU ftrace buffers

 fs/pstore/ram.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

