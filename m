Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D35741708
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjF1RNZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Jun 2023 13:13:25 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:40133 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjF1RNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:13:23 -0400
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51d889ab483so1205535a12.0;
        Wed, 28 Jun 2023 10:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687972402; x=1690564402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G99E3NhNw3Ywt8OuJDU2trKkI6Sf2iKVkXnbFT0xBig=;
        b=U9Pl0DklCZQ2o4+aDJtz/SsbLW/mXWthDel8besJl6y+JVzUw3Yqi63m56wv1wjA3+
         F62SXmHo7PupDX0hcF2OFsUBYT/zmaQ2h/7dtMw/DvKggONzVHbKdTKlZqTgH9c9lD3k
         nH8A2XKKPesxpJO7cpkbAHDgYFJxnE9Rqrom+H4gFlb1JRzLQHKgncizFGYlGKWXj3OE
         uPm7m1zQeY4VUkRoCpnpXBoeg9BRZOgL00VMOJGhVNgBhttBcu6w9HoQtCOb2/gop63v
         LAvgzXumoyLB2nSWiodI3ZTn0mCYRni5F7ziF7WQs3MnlGzqapulv6Mcka2VY1aqlY+8
         byyQ==
X-Gm-Message-State: AC+VfDz/+tkwG59wVWRffwJIdQX5O9uz04djA/cjwpL0maTpLZZ37VjQ
        OSXDl0e2+UijDqkj7N1/A8RncFH86o+3nR5HOZpeQzMl
X-Google-Smtp-Source: ACHHUZ7fvDyx5OxtA73shkQ22iONBeIWirAFOTQRml8sRdje24uENVBv3zdtBjDU+b+DQCF+Ja93uTk+cCpq82dKMkA=
X-Received: by 2002:a17:906:73cc:b0:98d:b10f:f3cd with SMTP id
 n12-20020a17090673cc00b0098db10ff3cdmr9040491ejl.7.1687972401752; Wed, 28 Jun
 2023 10:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230628022554.1638318-1-longman@redhat.com>
In-Reply-To: <20230628022554.1638318-1-longman@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Jun 2023 19:13:08 +0200
Message-ID: <CAJZ5v0gL9eMY+rvRByp-ZSnhHXjbZWBd4a8Ny6ZLZ7OvmtRQ1Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] x86/speculation: Disable IBRS when idle
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 4:27 AM Waiman Long <longman@redhat.com> wrote:
>
>  v4:
>   - Add a new __update_spec_ctrl() helper in patch 1.
>   - Rebased to the latest linux kernel.
>
>  v3:
>   - Drop patches 1 ("x86/speculation: Provide a debugfs file to dump
>     SPEC_CTRL MSRs") and 5 ("x86/idle: Disable IBRS entering mwait idle
>     and enable it on wakeup") for now.
>   - Drop the MSR restoration code in ("x86/idle: Disable IBRS when cpu
>     is offline") as native_play_dead() does not return.
>   - For patch ("intel_idle: Add ibrs_off module parameter to force
>     disable IBRS"), change the name from "no_ibrs" to "ibrs_off" and
>     document the new parameter in intel_idle.rst.
>
> For Intel processors that need to turn on IBRS to protect against
> Spectre v2 and Retbleed, the IBRS bit in the SPEC_CTRL MSR affects
> the performance of the whole core even if only one thread is turning
> it on when running in the kernel. For user space heavy applications,
> the performance impact of occasionally turning IBRS on during syscalls
> shouldn't be significant. Unfortunately, that is not the case when the
> sibling thread is idling in the kernel. In that case, the performance
> impact can be significant.
>
> When DPDK is running on an isolated CPU thread processing network packets
> in user space while its sibling thread is idle. The performance of the
> busy DPDK thread with IBRS on and off in the sibling idle thread are:
>
>                                 IBRS on         IBRS off
>                                 -------         --------
>   packets/second:                  7.8M           10.4M
>   avg tsc cycles/packet:         282.26          209.86
>
> This is a 25% performance degradation. The test system is a Intel Xeon
> 4114 CPU @ 2.20GHz.
>
> Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
> disables IBRS when the CPU enters long idle (C6 or below). However, there
> are existing users out there who have set "intel_idle.max_cstate=1"
> to decrease latency. Those users won't be able to benefit from this
> commit. This patch series extends this commit by providing a new
> "intel_idle.ibrs_off" module parameter to force disable IBRS even when
> "intel_idle.max_cstate=1" at the expense of increased IRQ response
> latency. It also includes a commit to allow the disabling of IBRS when
> a CPU becomes offline.
>
>
> Waiman Long (4):
>   x86/speculation: Add __update_spec_ctrl() helper
>   x86/idle: Disable IBRS when cpu is offline
>   intel_idle: Use __update_spec_ctrl() in intel_idle_ibrs()
>   intel_idle: Add ibrs_off module parameter to force disable IBRS

x86 maintainers, if you want to take care of this series, please feel
free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to all of the patches in it.

Thanks!
