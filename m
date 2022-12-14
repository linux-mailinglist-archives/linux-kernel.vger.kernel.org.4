Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C03964C4D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbiLNIPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbiLNIPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:15:11 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AE2E27
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:15:10 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id u6-20020a170903124600b00188cd4769bcso2074732plh.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZlQfCsrJq4nqGiGSGJoqdYiGzQG1JqFCkFWZgjViQrU=;
        b=Eb2gingklSMl9cha53wgAH0IBEyXBUinCjy4bH0XwYS066GkCfGG4lKjHYkRDEVxgG
         otK7YVOfig0248wrC/C+nDjvzfrUmK93mXrmV+fmvFaroL0YakK6RRLkrDqRJsq91zNp
         6+yjdPqikrw9AROQwNWnxq6HDdzE3BRNhezCVqDaTsVn6LX99Ys+UdNtT/Wxnfl7D8al
         wv5/nASL4w8NX6r5ocvmt+CNqV3zGK3sskAToMPvI7Xnj52rQayO2Y/27A83V+SSPZoN
         h49USi8WYVWojrlD4hJHoPcdbgSpP3nbipnL2QHeIlQkJ9B+CMzhxKFNeSCR4cT/yhk3
         433g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlQfCsrJq4nqGiGSGJoqdYiGzQG1JqFCkFWZgjViQrU=;
        b=euEJ7xdi9/+TNHoaXvB1f612mRL2C+7ywONb2uaO9kaZ5tlWiRe4lhtc+I3ruPyxzl
         GlFUridI4NfZaQy8gmiO8BTFWpo/kBlgiKW9RBIWIkSO1FFGsDTraGMCp4O6ENcF3QuG
         sSgt6cPls7tlKABoMXAiJza3Q3WQ90PwutenKKSatKvK1v3dB2qmmp6ikwNTfEll0oTb
         lZD+26knUUB1yENojjRU4u/bZkDqFJa9Uzx9q3uOPGWMDYnGU86Y150HlTjDK6QKzroh
         h/esjF1BaWG/94s/JxSju4EX4RNEOoGHICp0w0giJ2dN1TQ0M9J92A8qqM1XMCZQORPq
         CfqQ==
X-Gm-Message-State: ANoB5pka+1NFXqs4hcWZ52lIYrvgVSlAGQIg7lFihRZ7BCeYY3rWu1rE
        6Q+hEvR0epB7Ei7j1CzV4dcJE9qPjP1q
X-Google-Smtp-Source: AA0mqf436BRHiFtx2EhinRKwvE/0cKEMDHFzkVG+T8QjqxOq8AgDKBl7X6OMbCXBnWQNg1DZOzrfvxPKdAm4
X-Received: from pumahsu.ntc.corp.google.com ([2401:fa00:fc:202:cb1:cbe3:3a49:1751])
 (user=pumahsu job=sendgmr) by 2002:a17:903:3314:b0:189:a208:d13d with SMTP id
 jk20-20020a170903331400b00189a208d13dmr44522733plb.144.1671005710041; Wed, 14
 Dec 2022 00:15:10 -0800 (PST)
Date:   Wed, 14 Dec 2022 16:14:54 +0800
Message-Id: <20221214081456.714859-1-pumahsu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Subject: [PATCH v2 0/2] add hooks for usb suspend and resume
From:   Puma Hsu <pumahsu@google.com>
To:     gregkh@linuxfoundation.org, mka@chromium.org, dianders@chromium.org
Cc:     albertccwang@google.com, raychi@google.com, howardyen@google.com,
        leejj@google.com, hch@infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Puma Hsu <pumahsu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mobile, a co-processor can be used for USB audio. When the co-processor
is working for USB audio, the co-processor is the user/owner of the USB
driver, and the ACPU is able to sleep in such condition to improve power
consumption. In order to support this, we need to create hooks in suspend
and resume functions. We also upload our implementations for reviewing.

Puma Hsu (2):
  usb: core: add hooks for usb suspend and resume
  usb: core: add implementations for usb suspend/resume hooks

 drivers/usb/core/driver.c              | 36 +++++++++++++
 drivers/usb/core/usb-hooks-impl-goog.c | 72 ++++++++++++++++++++++++++
 drivers/usb/core/usb.h                 |  5 ++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/usb/core/usb-hooks-impl-goog.c

---
Changes in v2:
- Remove the wrong input in the Makefile
- Change description in commit message

-- 
2.39.0.rc1.256.g54fd8350bd-goog

