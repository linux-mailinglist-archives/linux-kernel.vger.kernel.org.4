Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB40768C94F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBFWZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBFWZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:25:19 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0646C13500;
        Mon,  6 Feb 2023 14:25:19 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id d21-20020a056830005500b0068bd2e0b25bso3654823otp.1;
        Mon, 06 Feb 2023 14:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNOPgu62moUx7Sb91VvKkB9DQeKnSoCSTj9D2NmA0GA=;
        b=p0t1SLe71lnFlRul8n5OK43yU9E2kX4j+cUFkr3rzRg1X5Qupvve8AacZQOcYgGmP7
         NbGNn4LmNVJhUHCjpU2edqGLSxQgaOA/nxhFfD9ZXOSkNwdwjv/9nnE5rV3VuxDbbU0W
         AQA0bhHryagzs6xIPb9C6C6kn59/ISEdPfPnPmyTMX9HHe6ELX5EXW6QTcNY+To7KY88
         76rIWZ29WhybVGnnXmZn2Yyaa7sONNEP17P0EIukxJSDSHXYppqz8pyMvjebV0LX/4X5
         4J0TZNvrFFf99NsuCHoat3JcOokiBedYPF1E/jll1eKALWJei+bAd1GWcaVCtOFBWx2D
         bdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNOPgu62moUx7Sb91VvKkB9DQeKnSoCSTj9D2NmA0GA=;
        b=YaiZFkmX5idCBD8WzI/gGLeQpcWyqQamSOsD9YCGnMPM75mgyF/Dzw+Q0NXTWR69IA
         oGkNBGKaUIVYCnc/SXxyK5Z57ASQScdGBaW09M0fkF/rFx9dAzqgxeJwxQyoGwIaVeQc
         +720gbbwiB0XXWrYSaWe0u+KYMBwzkW5yGUAAs15sIuWwgksINL6A9Z5+M91O5gk1+cZ
         V/o1XzRGUiX/+NRYH/AbfUC1BKd+Fk+hn3bD6HZCMPb46h94N5lkqx1HF+1YJZD/2YCj
         zDTWychere5fCjc02qtl5LX+9XjOk+y4ZoYrym6AkIpA92o3ZXQNly2DwSDq8LZJby4u
         4zVA==
X-Gm-Message-State: AO0yUKXOadCU9/I/7JJ2u98+6DndBG/HE7N2cbxl8bYx6C5Awx+0EbvU
        DqsxAJ/2f/ZOj5/UUxnQYq837YDW0Ss=
X-Google-Smtp-Source: AK7set9f2izeGgNoylcKAPxl+C1Qv73LUvvfK6zQeGbP5Gv2t0QgAqQbs7VT9ZVl54+Y5jHM0SBRrw==
X-Received: by 2002:a9d:63d5:0:b0:68d:a0df:4adf with SMTP id e21-20020a9d63d5000000b0068da0df4adfmr666933otl.38.1675722318378;
        Mon, 06 Feb 2023 14:25:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t7-20020a9d7487000000b0068bce2c3e9esm5552806otk.14.2023.02.06.14.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:25:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Feb 2023 14:25:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        revest@chromium.org, rostedt@goodmis.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ftrace: Add sample with custom ops
Message-ID: <20230206222516.GA873421@roeck-us.net>
References: <20230103124912.2948963-1-mark.rutland@arm.com>
 <20230103124912.2948963-4-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103124912.2948963-4-mark.rutland@arm.com>
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

On Tue, Jan 03, 2023 at 12:49:12PM +0000, Mark Rutland wrote:
> When reworking core ftrace code or architectural ftrace code, it's often
> necessary to test/analyse/benchmark a number of ftrace_ops
> configurations. This patch adds a module which can be used to explore
> some of those configurations.
> 
> I'm using this to benchmark various options for changing the way
> trampolines and handling of ftrace_ops work on arm64, and ensuring other
> architectures aren't adversely affected.
> 
> For example, in a QEMU+KVM VM running on a 2GHz Xeon E5-2660
> workstation, loading the module in various configurations produces:
> 
...

> +++ b/samples/ftrace/ftrace-ops.c

...

> +static int __init ftrace_ops_sample_init(void)
> +{
> +	unsigned long flags = 0;
> +	ktime_t start, end;
> +	u64 period;
> +
...
> +
> +	period = ktime_to_ns(ktime_sub(end, start));
> +
> +	pr_info("Attempted %u calls to %ps in %lluns (%lluns / call)\n",
> +		nr_function_calls, tracee_relevant,
> +		period, period / nr_function_calls);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^

Building csky:allmodconfig ... failed
--------------
Error log:
ERROR: modpost: "__udivdi3" [samples/ftrace/ftrace-ops.ko] undefined!

Guenter
