Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB95369E3C1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjBUPlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjBUPk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:40:29 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644AD83FC;
        Tue, 21 Feb 2023 07:40:17 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id s26so18824683edw.11;
        Tue, 21 Feb 2023 07:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8paduNjL+ldLZO0YJ89Hf4jDM5pXtIHjMr0kBBXNfY=;
        b=CO/X77c++qxtn44hpXZZTf1UGCGxdTq1876Mttb2ubWbFGIJwhcleE2nwke+7TEFut
         aGRF1alltHKBF9S8xi3B9Lqw+sX7BTVDgDpZoqXPgf0/G8Tma8bKXRI8+ESU1ndxjaaC
         l374HUzdZblH9cEZRYPUxwCKnzzFsHkeGBxGJQRbdo4u0T0kfBs9AkKrQrOxkwKThbDO
         RkVFdSCYkSM5S13XcMaugD4sX1/eB5gd1GYGk2Aac4C0MXAKMW4kY1VsZJpFOKpS7pnE
         Gtl7f/ok3KklVyqvXjC6JFVdRfNf5WJJrLJGNfU/pj6QAoQiz37INiPYoi++/6D0+nJm
         rsJA==
X-Gm-Message-State: AO0yUKXbYmRu8DPf2BsfVhFf5mXeAAo3X4JK8vt/ZOKiCICrA3AH/b4/
        KI8cNjfh1heGcJFueqYWg6fi1ZLpOFuz+9g4GonDBnz1JJY=
X-Google-Smtp-Source: AK7set9GvLdQSxTtvcxifThLRRQKFz89v5LJRELSCHXrm4w+SntDsNm4c2XOwtv1XX5GvSoz69MoowIgYoLn3JuhegA=
X-Received: by 2002:a17:906:4ecb:b0:895:58be:964 with SMTP id
 i11-20020a1709064ecb00b0089558be0964mr6579488ejv.2.1676994012496; Tue, 21 Feb
 2023 07:40:12 -0800 (PST)
MIME-Version: 1.0
References: <20230214215003.70683-1-kazukih0205@gmail.com>
In-Reply-To: <20230214215003.70683-1-kazukih0205@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Feb 2023 16:40:01 +0100
Message-ID: <CAJZ5v0gVi3U2K-Sj-W0QtBbbEw+HOd3FDSAyL-ugbhuxLeLZUA@mail.gmail.com>
Subject: Re: [PATCH] PM: s2idle: Don't allow s2idle when cpuidle isn't supported
To:     Kazuki Hashimoto <kazukih0205@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:04 PM Kazuki Hashimoto <kazukih0205@gmail.com> wrote:
>
> s2idle isn't supported on platforms that don't support cpuidle as of
> 31a3409065d1 ("cpuidle / sleep: Do sanity checks in cpuidle_enter_freeze()
> too"), so update the suspend framework to reflect this in order to avoid
> breakages.

Hmm.  Doesn't the cpuidle_not_available() check in cpuidle_idle_call()
trigger then?

The commit mentioned above hasn't changed that AFAICS.
