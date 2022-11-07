Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9711061EB14
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiKGGi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKGGiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:38:24 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FF5D4D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 22:38:23 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d20so9144047plr.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 22:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6yu/HMdn7Jkub/3b0dmYYkkQv71FItSNWFiTNSPq50=;
        b=Gz5V08vmne0nLUBBkA4xxDNUk6kb/hngX27bEnBPfy8ltdrPEdZ1ft0x8m+edcsWdh
         +QXx9zB1ePw4DLZcK7WfzqIn3X/d1OOKGBa/3VtJ3Kpe4Ujy574Xa+c+iVR+PfUBFYn4
         9apexXYj5gCc7RjvYV1NngWQ6y7NUm91crWlpXjYXXH3FXliB3Ot5+vCbSuwWmHSxjw3
         sCmCG9ZCAEMEAFz1nmunXr8I8k4bYdh8mJIO0r25zGAiySKU/2HGNeAEY9BpEIKFmSAk
         AmF7bld223jVbUQk+Dh2RFxQZzfSzreHGLvN0g9QY3F9sGosG6g1H/TDoez2C5UWRPmL
         QcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6yu/HMdn7Jkub/3b0dmYYkkQv71FItSNWFiTNSPq50=;
        b=okPwoy3PwstB+/uFhf2pvz3Y61ebkIRqodydNoLl9gC+fQoiArYMk0HHJU0YS0HYRy
         fwhbt7L+aRJldbxVWFJHM8B49HthSwwN+enXaI8+8NBYQrraa/tgMN2E96O3/tEHcFo1
         HHDwSGajoICCyeO1WMtiwh+R+Dj+j8VKqfud8S7Em2winyMnps87kluf1tJiD5vn33VS
         2Nby3mk0x4f348hbW+b/dqy9s0f2djGdqgqoFpogylUA67H0bim5z4eyT7t/Q4Zxj67V
         ODkNRhdlGqZfuuxobPQ7S0iB+fBB/MiRiJr+weFhwyD/iE3NVFRIp2ca4qyGzRmVtE0/
         /ZVA==
X-Gm-Message-State: ACrzQf3/jaVaHG8PzEIyudB7JkJ/P9YofQ8oKsSH1LaSyYhIodZEGTrb
        dguWJShZSIrGBq8lOlhUqEZuAg==
X-Google-Smtp-Source: AMsMyM7WD6AWzZc4ZGVkkDqHSDfQz7DCf64dpCKMeQy6ET/KQiuYlGgdP2qCw7fQh4QcKUv7RJqK+A==
X-Received: by 2002:a17:902:da8e:b0:187:5b6:1b9e with SMTP id j14-20020a170902da8e00b0018705b61b9emr50343169plx.113.1667803103407;
        Sun, 06 Nov 2022 22:38:23 -0800 (PST)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id b20-20020a63d814000000b004468cb97c01sm3453803pgh.56.2022.11.06.22.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 22:38:22 -0800 (PST)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Robert O'Callahan <robert@ocallahan.org>,
        David Manouchehri <david.manouchehri@riseup.net>
Subject: [RESEND PATCH v6] x86/fpu: Trying to fix writing PKRU through ptrace
Date:   Sun,  6 Nov 2022 22:38:06 -0800
Message-Id: <20221107063807.81774-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Linus,

I've been trying since July to get this regression that was introduced in
5.14 fixed. This is my third time submitting this version of the patch in the
last two months. Both prior submissions have not received any comments from
(nor have they been applied by) the x86 maintainers. I don't really know
what else to do at this point beyond "complain to the management" as it
were.

I appreciate anything you can do to unjam things here.

- Kyle

