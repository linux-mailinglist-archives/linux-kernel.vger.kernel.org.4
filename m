Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B842E5B8759
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiINLla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiINLlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:41:22 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113F645F53
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:41:20 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t65so14095488pgt.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=hlASCyZ5yHCJlW/ULQHayFN3xaIc+StENIfMN2szFas=;
        b=Dd8ra1ADESDUQpD87mmYktUjAh6rEbFaiy1iCgkowUVwJi9c8r4neDZ/BuxbZbb6KL
         cX7fslSAr1v/+thIyuVd2DSwJOqIkxGhM3E40uUuPmfA/c8JRoey9zPJ8w5Cl4Z0SZIK
         TnBVlARJz8+6WnLG/aw7tR8xW3qVMh0BI2q0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=hlASCyZ5yHCJlW/ULQHayFN3xaIc+StENIfMN2szFas=;
        b=NleP3+nzmgfkGb2UkAOSqaagARQggh841kZUaKtqRGoAP6PG8HLSrsPlyu3cAQi3kc
         zUNmJQnve6prOHMDeyiell5XLqaqX+pVgn/otC2N5iGm1CeGVmmuusnWhtv1Ce9y/gc+
         BDsmQ2WQP2F4wspCSXWjfQR/T/WOsh0mkwIDjk7V6bz+0keWj2CmFJKP2X1FEwLLzo/+
         MYMP1HV7dx6bF3wT9pNkLCXTS6meIohLTFXSJPayO5ycEGWf/JKrGQWkuhOncZ7OHHlL
         ZOQM0jSG2hL5eZCa+PU4UynGX90dkK4pFPWVsrFR9ua1LhPg4iPB/egcHheleVFUYo38
         Z9Jw==
X-Gm-Message-State: ACgBeo1g6aBqBGFQjIsLVIwIkl0eih7A4yJ/Obig4/NTu3y9doeafpDP
        NCDmTGNNnHk9jgHYKiqm7GdVow==
X-Google-Smtp-Source: AA6agR4twsdE1ngZRfzxuKoivjNRo72WPdNpBG0uKvjm+FCOsHt7Jz5yJVVWbNeO3rLSLAm39FEXpA==
X-Received: by 2002:a63:91ca:0:b0:436:64db:c902 with SMTP id l193-20020a6391ca000000b0043664dbc902mr27032929pge.87.1663155680071;
        Wed, 14 Sep 2022 04:41:20 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:e5f0:cfaf:bc8c:558e])
        by smtp.gmail.com with ESMTPSA id y5-20020a1709027c8500b0017495461db7sm10429936pll.190.2022.09.14.04.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:41:19 -0700 (PDT)
Date:   Wed, 14 Sep 2022 20:41:13 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [patch RFC 05/29] printk: Mark __printk percpu data ready
 __ro_after_init
Message-ID: <YyG92X5sQ0h4RjaS@google.com>
References: <20220910221947.171557773@linutronix.de>
 <20220910222300.641069948@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910222300.641069948@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/11 00:27), Thomas Gleixner wrote:
> 
> This variable cannot change post boot.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
