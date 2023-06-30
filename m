Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEBB743F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjF3PjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjF3PjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:39:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E716D1705
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:39:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbac8b01b3so17698495e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688139552; x=1690731552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yi29T2vIRc/Jr/dhBuRnalltZFUrcB3TL1AHhUs3Ac=;
        b=porJS4cNiq0PjO2bJCZpC9PtrP/jBSNRNCHCMms0COrdpb24HZ9mQOG0UvxYsi7giN
         CHo1u9lWrjX1U1G1TTptJiIwBETa2urzNXGVDdgm4sNJkqwIedPzNcAaxVPGx7B9G2ii
         IKmHmDLuOGIdlaube7+7onpPwRNFsLiAKFO6TbjzNcnwZmt8QWVpkJnhl1I2PsVLqNXU
         lHbfBtL43wR3SYGXcqOpNURLa+bh73QiaNkC8ELOQGhK0pDAUBOgrLLROMVdcWR5h1Lc
         T4jnf5ILyLXKUgAYpwEhN4aOww6pIEuYRmC9eV/KKsf9HrRBQdJtd3Ilw4/8Ea9Zs0Xt
         QEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688139552; x=1690731552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yi29T2vIRc/Jr/dhBuRnalltZFUrcB3TL1AHhUs3Ac=;
        b=YXSHXqCyf8weMeOE2X02CDI7Qxool2nnd26UVnqMeLNLs7+tAdIrlzvjRXE+v3GbTA
         kf51hX5LORd3B+qZLjgFwORPIOEzkR9kAAUSkyph+R9ARazETmZoJ5A2AcRaiySI20US
         X3/R9Z045li+bzsGw5j+oK7DXrPr5EgmykfvR4Wr+9U5HM9OymXDgcFRtbG3JYOzZJm/
         6aoY39Ka6+9gG9wjMI9xkR/mzVd66qS9+WFkr/2ZZxBWICdl/zsHd7n8k+fd/By42Z3c
         0fT+NobXWIJvoe4e+Xi6HmuQmI5YaQrBTWkT4P+hjYZev7a7fCsTUxEZCxPZk6opuhJl
         LD6g==
X-Gm-Message-State: AC+VfDz//vtXnqUeJWbE1UkNXsBLwbXydi6+7bKLJhiJFKCZQX6DQtfq
        E/djcYGZIk/x+E3tfMyMOId6eg==
X-Google-Smtp-Source: ACHHUZ6Q1gem7hiGijIceHRXD1Cr6EYxU0juZvCFx3zCNdKI/eDhA53E3sR0qwGk9NjDMx3c8TEhjw==
X-Received: by 2002:a7b:c40d:0:b0:3f7:c92:57a0 with SMTP id k13-20020a7bc40d000000b003f70c9257a0mr3152415wmi.14.1688139552383;
        Fri, 30 Jun 2023 08:39:12 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id x2-20020a5d54c2000000b003142439c7bcsm1546354wrv.80.2023.06.30.08.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 08:39:12 -0700 (PDT)
Date:   Fri, 30 Jun 2023 16:39:10 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Doug Anderson <dianders@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: include header in signal handling code
Message-ID: <20230630153910.GA2901579@aspen.lan>
References: <20230517125423.930967-1-arnd@kernel.org>
 <20230630152439.GA2900969@aspen.lan>
 <51b8b3c2-f4ac-454c-acde-e1d136139109@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b8b3c2-f4ac-454c-acde-e1d136139109@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 05:31:01PM +0200, Arnd Bergmann wrote:
> On Fri, Jun 30, 2023, at 17:24, Daniel Thompson wrote:
> > On Wed, May 17, 2023 at 02:54:09PM +0200, Arnd Bergmann wrote:
> >> diff --git a/kernel/signal.c b/kernel/signal.c
> >> index 8f6330f0e9ca..d38df14f71ac 100644
> >> --- a/kernel/signal.c
> >> +++ b/kernel/signal.c
> >> @@ -4780,6 +4780,8 @@ void __init signals_init(void)
> >>
> >>  #ifdef CONFIG_KGDB_KDB
> >>  #include <linux/kdb.h>
> >> +#include "debug/kdb/kdb_private.h"
> >> +
> >
> > Isn't is better to move the prototype for kdb_send_sig() into
> > linux/kdb.h instead?
> >
> > That's what other kdb helpers spread across the kernel do
> > (kdb_walk_kallsyms() for example).
>
> Right, that is probably better here. Not sure if it's worth
> reworking the branch if you already merged it, the difference
> seems rather minor.

I figure it will take me as long to rework the branch as it will to
write the covering letter on the pull-request to explain why kgdb/kdb
is messing around in kernel/signal.c ;-) .


Daniel.
