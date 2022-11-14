Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597B7628AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbiKNUoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbiKNUog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:44:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E826D2DA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:44:34 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a14so20550880wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ltqWv70xhsjqKvmYCLQTQ5/gow9Zeb6RJo0aIx+wB54=;
        b=ALXG4BM7x4DWog/UiKWH4Adq/BFEn6dF//F2c+VGkHprzCZyj0U7hzoI4S42iuKyDk
         s38OnjWvT7JbG+WM2f1yZ2XznNAKoLa9d/AvQecyfZu9FaeJnqc4R8IkFAxM0yQP2Z19
         /ROdn59S4G9yLoXl1lfcniJkLGelD/2bDaziPGsHr+zmLj3rKYT/Rd8yOaQo++InqoEp
         YuDP9gxBy3qNmHQhKxRA0u3RPSWB188JERbiccs5Gk2JLq8UpCD+j9wOCSCrFPSffLI3
         2BA+rglVA3SNZwlXOW3Qta6NQzcWEwAobv6FKwKiFC+bxXd8uUkFmTzIQSbuQcsWmcUr
         FEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltqWv70xhsjqKvmYCLQTQ5/gow9Zeb6RJo0aIx+wB54=;
        b=nNamlVOrGsneeuxB/6V6PLkG1KNNyXu7zERUPSxIZ070mOS+1JwBkkG2BWpJfwQ/+a
         yJrGPBi6iOhDpAI+4R3UePL+9ul7EITVwDJvoL2lWM2+RjdkZXtVw4PPKKzAnm1hmasu
         cPdlA9h8sMjVGsDeeyKQMohYClkoZndTRZxW3rS2F6qcnHgdvH+88Of4KFtfRzNONzeK
         jbzyDPhfjdOS7ba1PJ0gDGlo46cX1jJKOZvDGYU37DKysCzFpa0uPXF9CA914n5dbneG
         Ktx4piT7MzmO2tzNcfwMRhBn2qya32gjLQHVaQwoxUWhurp/bqlpc4MS+z7A0p9j6rHc
         fCpQ==
X-Gm-Message-State: ANoB5pmxW6x4KQyNI3rfaG4raXy/k3SEaJg5NzaYHf6cno7SADfbUaid
        Lw72vmkcAuleZgfmZQxtAHRXUOrXWsqsdQVy7dnTIg==
X-Google-Smtp-Source: AA0mqf4W9AQkpyTmM5CPovzHHuKvbxkCLiDJjNzUs6vLWcaRnUbbki5XxLWfySiCp0uHlyTrUhRbYXKLeizBLPcenAk=
X-Received: by 2002:adf:f211:0:b0:23a:43b7:cdd5 with SMTP id
 p17-20020adff211000000b0023a43b7cdd5mr8725365wro.387.1668458673337; Mon, 14
 Nov 2022 12:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com> <20221003214501.2050087-11-connoro@google.com>
 <Y2/P3cMExRt2fUP5@google.com>
In-Reply-To: <Y2/P3cMExRt2fUP5@google.com>
From:   "Connor O'Brien" <connoro@google.com>
Date:   Mon, 14 Nov 2022 12:44:21 -0800
Message-ID: <CALE1s+Ox_RF81kgF0YeV7sbuBN3RbBEvSK9_z6T4uWW2U_q=RQ@mail.gmail.com>
Subject: Re: [RFC PATCH 10/11] torture: support randomized shuffling for proxy
 exec testing
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Instead of doing it this way, maybe another approach is to randomize the
> sleep interval in:
>
>  */
> static int torture_shuffle(void *arg)
> {
>         VERBOSE_TOROUT_STRING("torture_shuffle task started");
>         do {
>                 schedule_timeout_interruptible(shuffle_interval);
>                 torture_shuffle_tasks();
>                 ...
>         } while (...)
>         ...
> }
>
> Right now with this patch you still wakeup the shuffle thread when skipping
> the affinity set operation.
>
> thanks,
>
>  - Joel
>

Wouldn't the affinities of all the tasks still change in lockstep
then? The intent with this patch is to get into situations where the
tasks have different affinity masks, which I think requires changing
the behavior of torture_shuffle_tasks() rather than how often it's
called.
