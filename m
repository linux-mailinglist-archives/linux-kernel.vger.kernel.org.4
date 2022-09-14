Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672415B873D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiINL1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiINL1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:27:38 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D621C7674A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:27:37 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j12so14585871pfi.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=QjJf2t+LmqEFzYe2e/vVZjPPvz80J6I/Ow5mNXqbU7Q=;
        b=SOfWClh8jAzg1aJKB35VHEN3TVrGFlgKUUw1wtcinLcoX/bpvgouE4iOVVlIkOc03j
         4uOPrIb41h1Jtm0PUPvuhp7EA8QzvNmrG4Ck3HKseni17NkEPJPLzK7RZtTboO/cz6P1
         LYngC3nDWpBL+HJVDWBA8vdRRSf3gtuLWRwuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=QjJf2t+LmqEFzYe2e/vVZjPPvz80J6I/Ow5mNXqbU7Q=;
        b=36ADan3V3ZY3PIZs5AbESE1is2p/nAiBLOzxm/hGinwDyUD4RoSL02wOcasFcYy1Mf
         42daIMYwCla6SN8piBBlDGarHGuey7g4vhkViAszN+pfcQYNaAnTZ+njAYSb4oTR0EK9
         WYa0U71QzztTatCMZ0x4ITlUwgWfypEHEL5lln+33zYvPzrAPPANaxcMep9iS0fSbdBi
         cDfcELAJ5YA8qKu77k1YV9bzaf1ScfxvG2MpuHGx5GUjEuI+7WhDZXR316dRq1r/QVFu
         T0HcgYeWGxyHnk98s5mlaPqpnvAHjtoTnCKHaLkOR0fmiKCF5LDdHjYr9rR8bI+bD1il
         Bggw==
X-Gm-Message-State: ACgBeo28talus86+28VOAUuwAQ0MT40aecoW4PVFPdjklDkfj//7ceGX
        nysscRUgLGrHox+W9DHIvzddWq2YdtJksA==
X-Google-Smtp-Source: AA6agR5Z0syP9DJezR8i2YD6NkfeYnjsPUzQ9LJxm7puY118nruG/TQss/b4Q9C3idImb6VRswNTGA==
X-Received: by 2002:a63:89c7:0:b0:439:1b08:ba23 with SMTP id v190-20020a6389c7000000b004391b08ba23mr10159037pgd.242.1663154857419;
        Wed, 14 Sep 2022 04:27:37 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:e5f0:cfaf:bc8c:558e])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902d4c600b0016b81679c1fsm10595117plg.216.2022.09.14.04.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:27:36 -0700 (PDT)
Date:   Wed, 14 Sep 2022 20:27:31 +0900
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
Subject: Re: [patch RFC 01/29] printk: Make pr_flush() static
Message-ID: <YyG6o3ChoxsVoxMu@google.com>
References: <20220910221947.171557773@linutronix.de>
 <20220910222300.406755505@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910222300.406755505@linutronix.de>
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
> No user outside the printk code and no reason to export this.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
