Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB8646EFE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiLHLuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiLHLt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:49:57 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3A08BD31;
        Thu,  8 Dec 2022 03:48:54 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id j13so589341qka.3;
        Thu, 08 Dec 2022 03:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqUzGXz7fqT2+R6ToUJYMObx3cVBIGdpHtqiUhY3CCc=;
        b=YVZA8htQVW0wKkb2lQZjV8L7C4kw4TQWWEAMWY64haFklLJkdi7X+ZHQuUaRK7H6UG
         PDl4+c0pK1SzSGDq4mtL+tP8vYCiWvDD0V4m/WIIYX6iIMPso0mNS2dFxjG7hVSXRw6T
         2vj32STAbNRuHWc6rLCu0K03sP/v5YupPMg7fsNytxFhdJqoOPJrAELV8kbZ9UQkbRB1
         ghpTAVJkVElMFFXcdVlyo1+dGycm3luaD+ufGmjDlBaq/MUCmlGiiJ4RQUtG1tg+4BNC
         jWWtEfdEfGaFZO1zzld02SwP8WSLC9YzX0FUTzHT12YPepzZRE0YSalFlMzHxpbBhcXC
         lHvQ==
X-Gm-Message-State: ANoB5pl6fjexNGhs7ww5cs/gvMTel70OgtRJT1h0okjvzkG1Uxx+v9Tn
        ayLv2Z0PEU9EuSj0VRs+ZdNVV7IGhx8tqcc1Xnk=
X-Google-Smtp-Source: AA0mqf4qdTUUqtmr44UYCGTE6at5UCsdamG6GPfpg/kGvcJNMILloKwxDc5hSuhNb+dxOEpmY7OZE6L2/OMnVAEO3LQ=
X-Received: by 2002:a37:b901:0:b0:6ec:2b04:5099 with SMTP id
 j1-20020a37b901000000b006ec2b045099mr69561695qkf.501.1670500132067; Thu, 08
 Dec 2022 03:48:52 -0800 (PST)
MIME-Version: 1.0
References: <20221207154648.233759-1-wyes.karny@amd.com>
In-Reply-To: <20221207154648.233759-1-wyes.karny@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Dec 2022 12:48:41 +0100
Message-ID: <CAJZ5v0gy+sZJp_SD2zF-n-zD=hCL4jXd+=cMuOujQqZOUUCHMQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] amd_pstate: Add guided autonomous mode support
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
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

On Wed, Dec 7, 2022 at 4:47 PM Wyes Karny <wyes.karny@amd.com> wrote:
>
> From ACPI spec[1] below 3 modes for CPPC can be defined:
> 1. Non autonomous: OS scaling governor specifies operating frequency/
>    performance level through `Desired Performance` register and PMFW
> follows that.
> 2. Guided autonomous: OS scaling governor specifies min and max
>    frequencies/ performance levels through `Minimum Performance` and
> `Maximum Performance` register, and PMFW can autonomously select an
> operating frequency in this range.
> 3. Fully autonomous: OS only hints (via EPP) to PMFW for the required
>    energy performance preference for the workload and PMFW autonomously
> scales the frequency.
>
> Currently (1) is supported by amd_pstate as passive mode, and (3) is
> implemented by EPP support[2]. This change is to support (2).

Well, can you guys please agree on priorities?  Like which one is more
important and so it should go in first?

At this point I'm not sure what the ordering assumptions with respect
to the EPP series are.

Also this submission is late for 6.2, so I will only regard it as 6.3
material on the condition the above gets clarified.  In the meantime,
please address review comments and consider resending after 6.2-rc1 is
out.

Thanks!
