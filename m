Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D285B8744
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiINL3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiINL3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:29:18 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47407675C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:29:17 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id i19so10777808pgi.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=CoKHDRm8Jaz5Qk+1uveIVhRWyeBv4ZOetyaTYsfBbTE=;
        b=HrNcpFcjE+4Z6gAn7bab9zBCK24FgV1k2QLj6FmYv9CSHRHAx0vhPpw/1DdgTYz4lP
         UqYiTQsFHxQZB1CyrWj0GcpZvcpAnybz6Rj1BiSBCqWel6pWT69XWLpy30E0wgSLtM5Q
         dgUcitZHo6OPUwaWr11rYLRHfcLpfXIvV4ick=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CoKHDRm8Jaz5Qk+1uveIVhRWyeBv4ZOetyaTYsfBbTE=;
        b=QWfaWFCdT1YgGPDf8ESduHn/0KZuixJalih8Ht67aPVSW37fbW70tzwRAdTbRpgM4i
         6JO466CTbb+eEkuNf2tiQY/azauqjducM6CrICyJQHCv7wCVPs4L85VetgK9HjnMxt1N
         wVcx8DQ4fu3mqJUlP1a3CcV0X7kyKL1lypy+z+GD/Yc4LmUZT2ZHFwL0zKDNI8Y/PbnZ
         1ySjAIxEvbpJ0resMHcOSCqqqdX0pq86aMo9U5DW+Ty+GfFfFo2+i57Pj9ksg37BFmct
         Qu+j3h9dzbVdohP7Vmwst1p5H/QbJR4hOG4TE6FV2XenpU41m7saNkDIqF5H7/AdhB0p
         Jz1A==
X-Gm-Message-State: ACgBeo0ShlkCNRb1ISYoau5jj8NMEE7hRdScHUD4AAHLoxUN3j0PhwCr
        3+Ev1UVIcJK5GeXWa8L2DjtDgA==
X-Google-Smtp-Source: AA6agR7dPTa5V/CzLJDPzyZcuxWtpmT6k3u2L4MDGgxXRRVfmon7zDE4RukDjHj62LZIoErt0FlCrw==
X-Received: by 2002:a63:824a:0:b0:438:8ba3:fb6a with SMTP id w71-20020a63824a000000b004388ba3fb6amr21299152pgd.49.1663154957265;
        Wed, 14 Sep 2022 04:29:17 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:e5f0:cfaf:bc8c:558e])
        by smtp.gmail.com with ESMTPSA id jb21-20020a170903259500b00176683cde9bsm10317065plb.294.2022.09.14.04.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:29:16 -0700 (PDT)
Date:   Wed, 14 Sep 2022 20:29:10 +0900
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
Subject: Re: [patch RFC 02/29] printk: Declare log_wait properly
Message-ID: <YyG7Bt2qIXiqWau0@google.com>
References: <20220910221947.171557773@linutronix.de>
 <20220910222300.466273303@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910222300.466273303@linutronix.de>
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
> kernel/printk/printk.c:365:1: warning: symbol 'log_wait' was not declared. Should it be static?
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
