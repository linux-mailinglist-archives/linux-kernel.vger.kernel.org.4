Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7061A631475
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 14:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKTNuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 08:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKTNuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 08:50:02 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A30327B06;
        Sun, 20 Nov 2022 05:50:01 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id l2so5896664qtq.11;
        Sun, 20 Nov 2022 05:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZ6ugRLwR1ztWoRfak0ibXzIu5wu6sOn2xPehqnrUrA=;
        b=lhbZZ763i/hwX5H74KlKs3FILTyaA8mB6++B3QaCKcBz46sSGrGpnkicjgw1+Ek4ut
         tkhgbKLk0eBHbDL0/3NYtzYnXhh6GYAENDHNfLQOO/TvCp6DdKdXmW4iqeG9XvAyB/9i
         x2INMxI/+9UlRiULGGfHfgJvj5SMHpC8XZd+dDvmnPFrk9RAliNsKP8nPUQ0arJz7H1H
         swHgN8rvuHwFjYt09Kr7CrWnYlxSsqUzlyHFbEUv0smQW5t/JYkn4WWYqL1Av7vJ0S3c
         6AhCe5TNyqRMNCkCmEsPKtc0zIIQlSnMOThJGn9zjoOeok+t5idJwmNk4PCxq1tNwEfR
         QSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZ6ugRLwR1ztWoRfak0ibXzIu5wu6sOn2xPehqnrUrA=;
        b=fIq8EgyClVJcQa+N90dinCJc2TIIcoS/IYvtOSFa+WD3w8ylEav0PJFzKaOnAMLMIT
         gFEpA0x76jNEb9DTvx4MafPEzNdUtVTo6vzohKk1y00yPHV4z+SisJ9YojIcIFiLhg+9
         MNZOHS+akANnVPjA+3ytNCnEpNoZgCe6m5bgiw+qzQ8uaQPjOchOyUgVRCzeVWlRPAVc
         LX8R5RX8y4yMlsKs3ppg3SUhqXGrXjtFJId4gr43BAfMSWz21WBl9Rnl297VwrsZdZ52
         17Wuif9HfbG6OByq6E2HTbksWxp7YcpmKvp439p9Ng7xEN6Z6e3Uu2SbnXisKDt7tr1P
         4dLw==
X-Gm-Message-State: ANoB5plmlgiIllimCW7YyjLO5SpZ42xErlTa98HZqLSdGJK6HHTm8RsM
        ee/j5Hd4+phjYxJoFhq2Ga9K3hoWcBA=
X-Google-Smtp-Source: AA0mqf59M8b1LBmtYK1ilOalZNnWQGknSauGJjzE8CiyBLr6gMY9hZZQVyN7t9KyNa4eJ+pgrnCRoA==
X-Received: by 2002:ac8:514b:0:b0:35d:5a2e:72f with SMTP id h11-20020ac8514b000000b0035d5a2e072fmr13887428qtn.324.1668952200442;
        Sun, 20 Nov 2022 05:50:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id oo19-20020a05620a531300b006fa00941e9dsm6077280qkn.136.2022.11.20.05.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 05:50:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 20 Nov 2022 05:49:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH] coretemp: Check for null before removing sysfs attrs
Message-ID: <20221120134958.GA1787493@roeck-us.net>
References: <20221117162313.3164803-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117162313.3164803-1-pauld@redhat.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:23:13AM -0500, Phil Auld wrote:
> If coretemp_add_core() gets an error then pdata->core_data[indx]
> is already NULL and has been kfreed. Don't pass that to
> sysfs_remove_group() as that will crash in sysfs_remove_group().
> 
> [Shortened for readability]
> [91854.020159] sysfs: cannot create duplicate filename '/devices/platform/coretemp.0/hwmon/hwmon2/temp20_label'
> <cpu offline>
> [91855.126115] BUG: kernel NULL pointer dereference, address: 0000000000000188
> [91855.165103] #PF: supervisor read access in kernel mode
> [91855.194506] #PF: error_code(0x0000) - not-present page
> [91855.224445] PGD 0 P4D 0
> [91855.238508] Oops: 0000 [#1] PREEMPT SMP PTI
> ...
> [91855.342716] RIP: 0010:sysfs_remove_group+0xc/0x80
> ...
> [91855.796571] Call Trace:
> [91855.810524]  coretemp_cpu_offline+0x12b/0x1dd [coretemp]
> [91855.841738]  ? coretemp_cpu_online+0x180/0x180 [coretemp]
> [91855.871107]  cpuhp_invoke_callback+0x105/0x4b0
> [91855.893432]  cpuhp_thread_fun+0x8e/0x150
> ...
> 
> Fix this by checking for NULL first.
> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: linux-hwmon@vger.kernel.org
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>

Applied.

Thanks,
Guenter
