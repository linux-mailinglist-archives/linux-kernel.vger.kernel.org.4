Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E407408BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjF1C6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjF1C6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:58:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C55171A;
        Tue, 27 Jun 2023 19:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=MsaI243O9PZkSjKSry7NpW1aTGFmRyGy2dSgztR5u+g=; b=RFU69fkkeTJYbx6VUb59ELLKf5
        lIlzoiR1mZGIeDllX0sQtJib/di/rpB4r9qiJovIJfgK4co/BmiC6WffTtn0DlLryDGRANeybHTrI
        aM74623gxlE+/t1lJG0JbHcCXSjWUGnJgKX1Vl5766sptv7x5Duqw8jJN+S0D8ZKaAFGvz+GOJ6I7
        0mmXGg3ZzTflHnYzCPS4uuej+GnLenLUo4tkaNDPhj1GsSIyznvU4NHirTSTw/YSsDsJI+EmcXaUa
        FJDgJmKzh/RrMZ0oLA70WBC9zs7ZJ33pkh4UMCcJuI0JMopdYpTZbntiggbKdTd9mmDyOzrAwFUJO
        WcOteIQw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qELNp-00EdzB-0C;
        Wed, 28 Jun 2023 02:58:17 +0000
Message-ID: <24b34b27-d2eb-e287-ffbb-29ffde66790d@infradead.org>
Date:   Tue, 27 Jun 2023 19:58:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 4/4] intel_idle: Add ibrs_off module parameter to force
 disable IBRS
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>
References: <20230628022554.1638318-1-longman@redhat.com>
 <20230628022554.1638318-5-longman@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230628022554.1638318-5-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/27/23 19:25, Waiman Long wrote:
>  Documentation/admin-guide/pm/intel_idle.rst | 17 ++++++++++++++++-
>  drivers/idle/intel_idle.c                   | 14 ++++++++++++--
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/admin-guide/pm/intel_idle.rst
> index b799a43da62e..8604e6d1fe2c 100644
> --- a/Documentation/admin-guide/pm/intel_idle.rst
> +++ b/Documentation/admin-guide/pm/intel_idle.rst

You may take or leave these comments as you choose.

> @@ -216,6 +216,21 @@ are ignored).
>  The idle states disabled this way can be enabled (on a per-CPU basis) from user
>  space via ``sysfs``.
>  
> +The ``ibrs_off`` module parameter is a boolean flag (default to false). It is

                                                       (default false).
or
                                                       (defaults to false).

Then I think it reads better if the next sentence begins with: "If set,"
instead of having it in the middle of the sentence.

> +used to control if IBRS (Indirect Branch Restricted Speculation) should be
> +turned off, if set, when the CPU enters an idle state.  This flag will not
> +affect CPUs that are using Enhanced IBRS which can remain on with little
> +performance impact.
> +
> +For some CPUs, IBRS will be selected as mitigation for Spectre v2 and Retbleed
> +security vulnerabilities by default.  Leaving the IBRS mode on while idling may
> +have a performance impact on its sibling CPU.  The IBRS mode will be turned off
> +by default when the CPU enters into a deep idle state, but not in some
> +shallower ones.  Setting the ``ibrs_off`` module parameter will force the IBRS
> +mode to off when the CPU is in any one of the available idle states.  This may
> +help performance of a sibling CPU at the expense of a slightly higher wakeup
> +latency for the idle CPU.

thanks.
-- 
~Randy
