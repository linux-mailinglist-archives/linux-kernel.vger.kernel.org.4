Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EE45B87C8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiINMGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiINMGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:06:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337457F257
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:06:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o23so13083042pji.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=6LmZ4sGuuzXWqmJQ9MZMdzsLWldEMmK7zJAn+QPoPKc=;
        b=aHgdCrTB1incRfUTH2CoMXKphc1IfOJDYjnX9+gydWJRamywY+zWhFtFqjlmLZD1gC
         qaVmuSeZdwzapwapMn5oHGuSX6SYbQK7weqOeuc/bP/JICbBMR1hhQIFkSQgMdtmaT/v
         edKOfYuiL1z7KyNZGfwlaI02LnRsRlwf7JlXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6LmZ4sGuuzXWqmJQ9MZMdzsLWldEMmK7zJAn+QPoPKc=;
        b=eL4NV+Zaf0Qa0fJzou+nkUUkEdFFn6NYPY8UhpCnxsQp5nIFnge7wh9hFk5W8+UeNz
         qiF5miPBr+iKsCfPZYUy/Lj8QU5qvJoV6oTNvL8DwIrTOOFhCKkXEEMikfHohvOaEgDn
         LB/IcFlwnqg1CYP3VRpflrhuRP+I4iReMzkWOXmKd7FWdorXMi9NKhVw+zm0PXFQB4e7
         DjXWheok3hJjPQhywiF3/wDS9nStrc5J6xFvAPCOBZOY7Aw8TP7BiPzr7IYZoju2isao
         Jdr5qkr7gT5fYoOi5vHgbVTuxlOw65PkrQJkJ9KbFhM2r9if4erkfvNogTNBTGiQ8WIk
         pjSw==
X-Gm-Message-State: ACgBeo1uox9S0oZ0z6+9O3m7fe22B+hKiutxUdt4WgJcHNFKkT/OdbRJ
        ocO+Zm0JiJdMTMdXDSKl3gvWoQ==
X-Google-Smtp-Source: AA6agR5ItOZFDBd2R226M4Vwt38bdOJ70rJrpzcmsr/UEOff405XFAhURYehqVIcE1oYTF53MECPtA==
X-Received: by 2002:a17:90b:1e44:b0:202:b347:2daf with SMTP id pi4-20020a17090b1e4400b00202b3472dafmr4584695pjb.34.1663157163743;
        Wed, 14 Sep 2022 05:06:03 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:e5f0:cfaf:bc8c:558e])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902d4c600b00177e5d83d3esm10744517plg.88.2022.09.14.05.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 05:06:02 -0700 (PDT)
Date:   Wed, 14 Sep 2022 21:05:56 +0900
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
Subject: Re: [patch RFC 06/29] printk: Protect [un]register_console() with a
 mutex
Message-ID: <YyHDpP3XcnsII9Yp@google.com>
References: <20220910221947.171557773@linutronix.de>
 <20220910222300.712668210@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910222300.712668210@linutronix.de>
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
> Unprotected list walks are a brilliant idea. Especially in the context of
> hotpluggable consoles.

If it crashes on you then "you're holding the computer the wrong way" ;)
