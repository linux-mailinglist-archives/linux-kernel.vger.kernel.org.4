Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D64065BDAB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjACKHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbjACKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:06:40 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA597C33
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:06:38 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id fc4so72353613ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 02:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F99wKfYWnkRLMEaWohhJV9dn/8Mvt586gijE7aTfMYE=;
        b=a0sxKHfPVZClBKmmEtqZ9XPqqabc4ONBwlDV/eUfdm2aAWYqQYMbbKdGTbPDiQ7YC7
         DN2Nv+j0lwSCa+20eR8vEmp8o4luc3p3CwlsXIrKsKJNIHXG+c6kyrslejaMNmnx+dPt
         moucOlaq3ciuAoQWXN9nhdz+mhKLBPqX3IHr+vg8jmioqcRVy9t+OqPBGUJ/Vonmu30A
         DGzOub1anfyBxF9BLrmYjI7Jz5Gyub02xIzTW8agPJnEpwlW/BoH+PtLCS4ESv/JjUr/
         Y08GKoV5StW+BeY1xfBiU4mYe/EKLq5P3Af2Vg+0DAXvzoBGjpnLA3lCSwcXFtDQVzuR
         QXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F99wKfYWnkRLMEaWohhJV9dn/8Mvt586gijE7aTfMYE=;
        b=Wx96IrLOqsaXQsVygMCQl//KRpl2mccvwBZuyZ8ftuo+VexE1iq3ujl35t4xnADuMN
         Pr/QbCVAfVcJ5lbR1d924gdfjgtfTSJVMtFQrJJnmgDnDmQi1Dodd1tT9L/3zPxotcXW
         7NouALrdBGWYjZKAXprv1euIeVz6nu2AzomNS+kJ8XFB68YCEAm5wesk1OKjwBlVZmMK
         waJnfkYY04rDc0AnxI36Zgd2wX5ZW2LQGc6Hu1BCPxo2PFmanqXzBYRenb3G27vglomj
         1VRykmkf1lq81F+r+d+AEV9RcQOHXqhFHBeFGQExkRNUPoPjgWH5Zno78zI9vwmC1qV7
         KAlA==
X-Gm-Message-State: AFqh2koEYnXhTMrpNFcChHbfKs8vQy4Aa087Nh1WfK2KE3ArX0r13WgZ
        UCVlIKm5yixhVfPIBEp/uHw=
X-Google-Smtp-Source: AMrXdXuMBNQPrKtP9SEOHprsEC/a/rbZ9I6XQf9rHK9HebRhkLbhcTRqRhnLYh2ztVZfux/lnC4QOg==
X-Received: by 2002:a17:907:1b0b:b0:7c1:6344:84a with SMTP id mp11-20020a1709071b0b00b007c16344084amr58151490ejc.5.1672740397340;
        Tue, 03 Jan 2023 02:06:37 -0800 (PST)
Received: from gmail.com (1F2EF380.nat.pool.telekom.hu. [31.46.243.128])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906768b00b0077b523d309asm13897436ejm.185.2023.01.03.02.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 02:06:36 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Jan 2023 11:06:34 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] time: fix various kernel-doc problems
Message-ID: <Y7P+KuMs52BTfKgv@gmail.com>
References: <20230103032849.12723-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103032849.12723-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy Dunlap <rdunlap@infradead.org> wrote:

> kernel/time/tick-oneshot.c:107: warning: expecting prototype for tick_check_oneshot_mode(). Prototype was for tick_oneshot_mode_active() instead

> --- a/kernel/time/tick-oneshot.c
> +++ b/kernel/time/tick-oneshot.c

> @@ -103,7 +103,7 @@ int tick_switch_to_oneshot(void (*handle
>   *
>   * returns 1 when either nohz or highres are enabled. otherwise 0.
>   */
> -int tick_oneshot_mode_active(void)
> +int tick_check_oneshot_mode(void)
>  {
>  	unsigned long flags;
>  	int ret;

This one looks wrong - did you change the name on the wrong line?

I've applied your patch, but fixed the above hunk to be:

@@ -99,7 +99,7 @@ int tick_switch_to_oneshot(void (*handle
 }
 
 /**
- * tick_check_oneshot_mode - check whether the system is in oneshot mode
+ * tick_oneshot_mode_active - check whether the system is in oneshot mode
  *
  * returns 1 when either nohz or highres are enabled. otherwise 0.
  */

Thanks,

	Ingo
