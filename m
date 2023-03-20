Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B746C20F9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCTTMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjCTTMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:12:00 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4C330EB9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:04:30 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h5so6976114ile.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679339054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Y1lhyT5n3wfQWF4DTLUL5NVCSEguRHcZuiRjGDyTqU=;
        b=aLl4yhrjpBNSc52hXWEDlw8bCsCQ4Uu1rYanh2yAuA2mW8mR9Msiz2s6mhcGeADaF7
         hQ1vWDJIvtRIUhWT8CEOc7UTby+iQOlZaNBCwKn6gJeHRktpVaxB7MC/f8dbGnIp3cDG
         p+DAzgPQUlbt97S5YEk2CkDUMuQuQhDSKZRhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679339054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Y1lhyT5n3wfQWF4DTLUL5NVCSEguRHcZuiRjGDyTqU=;
        b=sOmIhGrF0WfO+oWx1JeI2KKPApTH8eOZYsugapLT9V+ursTQWv77wUiAKHywwSJAtn
         1yrNvNNJc1wu5Ccntl+hSHv5e8y40z005yx9RGg3J/f1Z7KswL6N1PW7KsWHs5Ahz4D8
         dXw3TJYNmf1lfYZAEbdLIPKRaamsoJlK4X/8/ozqn0qpsj594gMC8VrlbFqWQdD9ulT+
         usUxGDqTHitYk5DDfduy6xqRpDXu61LuwP6CBcELP8qsvCQ6T4OzfZkSiJ2vmyFfNdDv
         VT//T/3dXCGXCLYv1FsXKb6LTNExgXsVD5fjlb0PLWCO0Wof5AaA+xi9d6g4q4m3VlNH
         mn0A==
X-Gm-Message-State: AO0yUKWRvMY/8mYCh/rsgIU8oRN3kvpU4utALZQMmts/W+2COgIwmuZG
        otWXb9KsnX1/2CKU1lS4RmDeSL7qD0cDDqFmS4A=
X-Google-Smtp-Source: AK7set8U9751Q87rUuTdX/gcMlkl5zWkrFWSy64frKlB2tPdpCN7Lso+LMO9uWPzV+QKyi+xiJHwjg==
X-Received: by 2002:a05:6e02:1a83:b0:315:6f9d:e75 with SMTP id k3-20020a056e021a8300b003156f9d0e75mr5781951ilv.7.1679339054691;
        Mon, 20 Mar 2023 12:04:14 -0700 (PDT)
Received: from markhas1.roam.corp.google.com (71-218-36-105.hlrn.qwest.net. [71.218.36.105])
        by smtp.gmail.com with ESMTPSA id y10-20020a927d0a000000b003179b81610csm2955829ilc.17.2023.03.20.12.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 12:04:14 -0700 (PDT)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     mario.limonciello@amd.com
Cc:     Felix.Held@amd.com, Rijo-john.Thomas@amd.com,
        Thomas.Lendacky@amd.com, andriy.shevchenko@linux.intel.com,
        gjb@semihalf.com, herbert@gondor.apana.org.au,
        jarkko.nikula@linux.intel.com, jsd@semihalf.com,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com
Subject: [PATCH v4 8/8] i2c: designware: Add doorbell support for Skyrim
Date:   Mon, 20 Mar 2023 13:04:07 -0600
Message-Id: <20230320190407.51252-1-markhas@chromium.org>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
In-Reply-To: <20230310211954.2490-9-mario.limonciello@amd.com>
References: <20230310211954.2490-9-mario.limonciello@amd.com>
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

Should this function retry acquiring the I2C bus while it is busy?  Similar to
how the cezanne variant works. Also wondering if the function should be named
psp_send_i2c_req_mendocino for consistency.

