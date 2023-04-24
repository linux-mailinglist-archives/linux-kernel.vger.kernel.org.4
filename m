Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350AB6ECAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjDXLFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjDXLFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:05:42 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CDCB7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:05:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51f405ab061so179794a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xiaomi-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1682334341; x=1684926341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=986EttNUNrEoGLif6ddHg9dFb5CsB93G2H/jBVCiNKU=;
        b=WW7O+Aw3QXziQQpSyYY+V4B0q+PnVZmr6zq9u/uamO43dfx6dYoGthFNMabVyxqmxN
         QNC7pLSBEbpsj2hnva1kUcLnd+wYqCP7+Q7BN61AUSgc4cgxmetEFTx1yE/9ILFu++Oa
         Uu4d9wEJRHJYY/c6KWaCPjNmtcUUrJWgfKtEI+fI6zkQXIPxsyyqCJu8XlDrhUf+HPlt
         JVsQna8eSNqI52MYitOt+ebAwij9zuw6+E7ydAV1E6xNYAKQmQYYKMaBU7PiKroxvTBg
         AgF4IDNTgGIbIiLRu0UPDbbZoAn/YF1Ksgwenclsj6HH6SmMRtclbkNX5Fgi0N/eLzgA
         NrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682334341; x=1684926341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=986EttNUNrEoGLif6ddHg9dFb5CsB93G2H/jBVCiNKU=;
        b=WxD0K0ubyLN3SO7dDJOsmYIZNnk7ljGUqUWli5HHHKrDZkrzPSocVUVYgEZBjlYGRT
         Ll3GbHO3mIsValCEOiYEoFckgIDHrSuJEMLrn21mRTVbOhcRnPLFzyqKcgZWqtrMv517
         Db18eAjfjDGKH55+RHfPUIz/u40qSp67Z1wv+gTxnYz8dkQ0IPjSFhn8IKhKgZ0PMvGw
         HLj1EMGCfHUEp3tZRLnRI1XsSK9LjuWmolJtD2uAjj9145Ss8NYHm4JLQ3YFZPvPi/Vw
         Z+lz01+6RlbuHluS1qVCC4DLlmAKneaof/JNVUniHV/slyxvjx5e6Gc+reCiQRYWYW3V
         em5w==
X-Gm-Message-State: AAQBX9dqsk/RXA8hmIKJSKgpS0xvr/pTFfttSW4ZWNC92O1MlRT0ui6w
        XAmViCiFoS3gyMse5d2GXo7X3g==
X-Google-Smtp-Source: AKy350Y/4GWB9SHQjsERTPxpcxrFUvOXcD5Rtftv8fRmvc5GDIj2YSigNJQxlOsGbIo5ZManhX6/7g==
X-Received: by 2002:a17:902:f690:b0:1a9:581b:fbaa with SMTP id l16-20020a170902f69000b001a9581bfbaamr10547080plg.2.1682334341096;
        Mon, 24 Apr 2023 04:05:41 -0700 (PDT)
Received: from mi-HP-Pro-Tower-480-G9-PCI-Desktop-PC.. ([43.224.245.246])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902694700b0019c91989a1csm6364544plt.300.2023.04.24.04.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 04:05:40 -0700 (PDT)
From:   Chuang Zhang <zhangchuang3@xiaomi.corp-partner.google.com>
To:     gregkh@linuxfoundation.org, cmllamas@google.com
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org,
        Chuang Zhang <zhangchuang3@xiaomi.com>
Subject: [PATCH v2 0/2] Binder: Add timestamp and async from to transaction record
Date:   Mon, 24 Apr 2023 19:05:13 +0800
Message-Id: <cover.1682333709.git.zhangchuang3@xiaomi.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuang Zhang <zhangchuang3@xiaomi.com>

This path adds support for getting the pid, tid, and transfer duration
information of transfers in binderfs transfer records.
Previously, this information was not available in the transfer records,
which made it difficult to analyze certain issues in Android.

With this modification, Android engineers will be able to quickly identify
and diagnose problems in certain scenarios. We believe that this
improvement will be particularly useful for issue analysis and debugging
on Android.

This change does not affect existing functionality or performance and
is fully backward-compatible.

Chuang Zhang (2):
  Binder: Add timestamp to transaction record
  Binder: Add async from to transaction record

 drivers/android/binder.c          | 15 +++++++++++----
 drivers/android/binder_internal.h |  3 +++
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.34.1

