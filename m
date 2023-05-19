Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C5B7099A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjESO2p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 May 2023 10:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjESO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:28:44 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BAC116;
        Fri, 19 May 2023 07:28:43 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso83515866b.0;
        Fri, 19 May 2023 07:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684506521; x=1687098521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLDNSUFZ15J3Btc6EBpClFXuRobltQofOM7qiJmAWtw=;
        b=KRBc+0cu2G/0e8Jlz/2TAvCPf6yW/GIuqnapzYtnswjjty015uxUDsBSv9dFC/Kfvh
         5890fkJrg5abJxwwIo5k8Clvki1rAt6o/n8LELiiwkayCZpEijUWvoh0JWVifRxQd6e2
         39djli+NWpr9EaHIr3n/bPdhAQb2HMFJ/FE1JSonBwzilvS7NY91/S9iXjV6GY1tpqF+
         AcB6H9ZDqEWMzI85poMe+vkoIItfcqBjr6WXA525sr+w1h+mFUDw6inyfIMe9ubq7yer
         /fZD8TgugK9bS/B2Cz0mJXqhQ6luSTX8UHjW3XRQW/tmAfdBbQ9fGh5o9ILvZVy5gCM+
         OJzg==
X-Gm-Message-State: AC+VfDyg2J0hgh48O9vhBDCfXH4GQ3ABSujgXTKysEBbzfo4S3N4m7Jr
        qVSKLXgBpLoj2YtGjyJtbpHy3Av0fpcHq3jEdls=
X-Google-Smtp-Source: ACHHUZ5RV9na8upB9VpmAYJiOF1HuwfHNjLjLE3y5Guu3Tc0j9QfWlBan4m+d1kfmfK4B7nmMhbK5yhqV2F3nabl1aA=
X-Received: by 2002:a17:906:5350:b0:92e:f520:7762 with SMTP id
 j16-20020a170906535000b0092ef5207762mr2447774ejo.6.1684506521290; Fri, 19 May
 2023 07:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <8abea32a-4895-7826-8a9c-9ddc5a7ad2bd@linuxfoundation.org>
In-Reply-To: <8abea32a-4895-7826-8a9c-9ddc5a7ad2bd@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 May 2023 16:28:28 +0200
Message-ID: <CAJZ5v0gqwHmuV+MC8RVfZ51KjC-3mJ-fxTswQmvh3GCjSPPADA@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.4-rc3
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>,
        Thomas Renninger <trenn@suse.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 8:26 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 6.4-rc3 or for
> a later rc.
>
> This cpupower fixes update for Linux 6.4-rc3 consists of:
>
> - a resource leak fix
> - fix drift in C0 percentage calculation due to System-wide TSC read.
>    To lower this drift read TSC per CPU and also just after mperf read.
>    This technique improves C0 percentage calculation in Mperf monitor
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:
>
>    Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.4-rc3
>
> for you to fetch changes up to c2adb1877b76fc81ae041e1db1a6ed2078c6746b:
>
>    cpupower: Make TSC read per CPU for Mperf monitor (2023-05-08 10:46:49 -0600)
>
> ----------------------------------------------------------------
> linux-cpupower-6.4-rc3
>
> This cpupower fixes update for Linux 6.4-rc3 consists of:
>
> - a resource leak fix
> - fix drift in C0 percentage calculation due to System-wide TSC read.
>    To lower this drift read TSC per CPU and also just after mperf read.
>    This technique improves C0 percentage calculation in Mperf monitor
>
> ----------------------------------------------------------------
> Hao Zeng (1):
>        cpupower:Fix resource leaks in sysfs_get_enabled()
>
> Wyes Karny (1):
>        cpupower: Make TSC read per CPU for Mperf monitor
>
>   tools/power/cpupower/lib/powercap.c                | 23 +++++++++++-----
>   .../cpupower/utils/idle_monitor/mperf_monitor.c    | 31 ++++++++++------------
>   2 files changed, 30 insertions(+), 24 deletions(-)
>
> ----------------------------------------------------------------

Pulled, thanks!
