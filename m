Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F735EFEBA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiI2Uiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiI2Uis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:38:48 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606EA133C82
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:38:47 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id gb14so1538518qtb.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=37YVMMjrR6Rz6mEmzpa1y/5RmTAp/Ed6C2qEfsQX/wY=;
        b=wtc5CNeyy6Dtqb+u1ZYrl+6HVOdphYL2J+wto3lT6QkVfR5KZFNMPqy64yb6bZ/dYX
         rXBlOM23Mb7gl0FzBbL9J0bRQYHL42ir+8sfFRN/pRecZodNDmw0SJDEgDaRR3thycz+
         TDlhoFXH7mLoenJGNgbjv7MV3u+St8KR9ahzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=37YVMMjrR6Rz6mEmzpa1y/5RmTAp/Ed6C2qEfsQX/wY=;
        b=8GbQ+FKtY0Slrl+wYLSUDe7R4KAWQngHlxdlv8v3KN4M/3buVIKp/sZKrLHAYRCYc/
         ZluPHf7fnSO2GddyfamT32sjfl3/O11XqW+T5CCeiqQK9DTfDTk2IZbi2mljPJ/Pp2UC
         7mDDul+g3Bu8MQY5LxEkbfn2GPKDRCAqLA492C/R+103Kdj4QB6XdVTgHMjlvtGgKya+
         xhGWOPcw5NYa2Nd8L6Yj+ewpeB4hlps+Nm+p+Cnyh2SPO8Nm9xhzOW7A+RjnEArGunha
         8mgpx7n80FALZlFpFuxU7t/9ypC5VSzaP4DRoa6GnmxDEqQnzE5KDIxO+64YW/CK68/M
         s6uw==
X-Gm-Message-State: ACrzQf3KyjrI2UyqcjfaX2NzvP2eEkMCNFQi93StAuiq6H436O2nM2h3
        KUTqOQIZnbC8prMxsLDx+juVxA==
X-Google-Smtp-Source: AMsMyM7nRdU3xV453gKEIOY7qCUxDxTwgvwpdtKoF7K9Lyt5PcIq8GNLr8/L53ZIec0Uz2Bca7nIVQ==
X-Received: by 2002:a05:622a:282:b0:35d:4999:10cb with SMTP id z2-20020a05622a028200b0035d499910cbmr3975839qtw.191.1664483926515;
        Thu, 29 Sep 2022 13:38:46 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id a5-20020ac85b85000000b0035ba7012724sm160255qta.70.2022.09.29.13.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 13:38:46 -0700 (PDT)
Message-ID: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
Date:   Thu, 29 Sep 2022 16:38:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Subject: Sum of weights idea for CFS PI
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Youssef Esmat <youssefesmat@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, all,

Just following-up about the idea Peter suggested at LPC22 about sum of weights
to solve the CFS priority inversion issues using priority inheritance. I am not
sure if a straight forward summation of the weights of dependencies in the
chain, is sufficient (or may cause too much unfairness).

I think it will work if all the tasks on CPU are 100% in utilization:

Say if you have 4 tasks (A, B, C, D) running and each one has equal
weight (W) except for A which has twice the weight (2W).
So the CPU bandwidth distribution is (assuming all are running):
A:   2 / 5
B, C. D:  1 / 5

Say out of the 4 tasks, 3 of them are a part of a classical priority
inversion scenario (A, B and C).

Say now A blocks on a lock and that lock's owner C is running, however now
because A has blocked, B gets 1/3 bandwidth, where as it should have been
limited to 1/5. To remedy this, say you give C a weight of 2W. B gets 1/4
bandwidth - still not fair since B is eating away CPU bandwidth causing the
priority inversion we want to remedy.

The correct bandwidth distribution should be (B and D should be unchanged):
B = 1/5
D = 1/5

C = 3/5

This means that C's weight should be 3W , and B and D should be W each
as before. So indeed, C's new weight is its original weight PLUS the
weight of the A - that's needed to keep the CPU usage of the other
tasks (B, D) in check so that C makes forward progress on behalf of A and the
other tasks don't eat into the CPU utilization.

However, I think this will kinda fall apart if A is asleep 50% of the time
(assume the sleep is because of I/O and unrelated to the PI chain).

Because now if all were running (and assume no PI dependencies), with A being
50%, the bandwidth of B, C and D each would be divided into 2 components:

a.  when A is running, it would be as above.
b.  but if A was sleeping, B, C, and D would get 1/3.

So on average, B, C and D get:  (1/3 + 1/5) / 2 = 8/30. This gives A about 6/30
or 1/5 bandwidth.

But now say A happen to block on a lock that C is holding. You would boost C to
weight 3W which gives it 3/5 (or 18/30) as we saw above, which is more than what
C should actually get.

C should get (8/30 + 6/30 = 14/30) AFAICS.

Hopefully one can see that a straight summation of weights is not enough. It
needs to be something like:

C's new weight = C's original weight + (A's weight) * (A's utilization)

Or something, otherwise the inherited weight may be too much to properly solve it.

Any thoughts on this? You mentioned you had some notes on this and/or proxy
execution, could you share it?

Thanks,

 - Joel


