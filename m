Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A02C6093E1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJWO01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiJWO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:26:20 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660E56888B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 07:26:19 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g129so5019675pgc.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCCvao8fpN3Uiz0o0Wawt3sMV5Z79poKLAthlB6c8r8=;
        b=hNmsNahzRlWfnbEvdZ/lh5M4sqTY7+F+AL9BTTSPNRrvN1YPp7K5QSMJri76AwiaEu
         I2CSUhHc38Ox4roxIv1gc6SrteM2JhLwbw/h+PajqHsOl4xlgJvzLsvuJDqnmsOrCn07
         zgRQx1VoddMiAm+enhdj9CMQ83EIpH1OXW2UJ11YTj1ZBe/bTJFFMdHxLVm1pJCNQIyV
         asfLsjOTyzhG819YCJKibxHuWXou5xxhdwiYwhDAM9XYXHJBwNJiu+Q3QpMl264B5cwu
         HOjUSb7dgXbKo6rcD3Wn0G3qH5gp3KIgUbdiN0Ax1J72D1+4ZvgCnPFO5vRpOURr7mQ2
         qwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCCvao8fpN3Uiz0o0Wawt3sMV5Z79poKLAthlB6c8r8=;
        b=rXtQMew9xBrMNHtNC+EI/CEQF3q0k7mfs7gntlKk7aq4WLfdA6KzQzLQCC96Yvdp1R
         9i9Zcl6zV3hDYpKqzsPoCGNlBa2k+A3VFCRI+SZDIw1m9otPQQt6QJNDekJhozRLgLGT
         WqdYQeCTd9QHYqO95RJ/lGMd8F5H+Sm3OlalO7uo3SIQVyx1pvHcYiIJMUY86T3jIGd/
         f8U0m46t2eDl4C3yS2FPl9QTMFGKETcZPX+Gt3f/kTeJ3qWA1fr1xORVkJeA4LySSKqm
         yFIHp7SbsxtaF9nEB9ra6fXZcWzu/fpnZOOkavD1Bdrupr0S3xR/KQO2zDgWgDQ/kXCH
         NhHA==
X-Gm-Message-State: ACrzQf1eFynOPvsPQ0fSZWsXo+lJ+2Cb710jtsKlDb4cmXX7jQIpgdGa
        Tx7L8ZubkddqBNqfzxBWMtw=
X-Google-Smtp-Source: AMsMyM7Kd7zd8fniNpVLeUCsdN4hfNqclRrXAfgTNN87G6fIN+FR3mT9RixMAqkHRlaJ787nETWCDg==
X-Received: by 2002:a63:e64f:0:b0:43c:9db1:8096 with SMTP id p15-20020a63e64f000000b0043c9db18096mr23504028pgj.567.1666535178868;
        Sun, 23 Oct 2022 07:26:18 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id a11-20020a634d0b000000b0040caab35e5bsm15877880pgb.89.2022.10.23.07.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:26:18 -0700 (PDT)
Date:   Sun, 23 Oct 2022 07:26:14 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, imv4bel@gmail.com
Subject: Re: [PATCH] char: xillybus: Fix use-after-free in xillyusb_open()
Message-ID: <20221023142614.GA385798@ubuntu>
References: <20221022175404.GA375335@ubuntu>
 <9674abb2-b40c-3862-5272-58b643dc91e1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9674abb2-b40c-3862-5272-58b643dc91e1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 05:19:40PM +0300, Eli Billauer wrote:
> Hello, Hyunwoo.
> 
> > A race condition may occur if the user physically removes
> > the USB device while calling open() for this device node.
> > 
> > This is a race condition between the xillyusb_open() function and
> > the xillyusb_disconnect() function, which may eventually result in UAF.
> 
> Thanks a lot for pointing that out. In fact, this reveals two problems in
> the existing code:
> 
> (1) unit->private_data is accessed after the mutex has been released in
> xillybus_find_inode(), so there's no guarantee that it will be valid. This
> is what the test caught. This can however be fixed just by moving the
> release of the lock a few rows down.
> 
> (2) xillyusb_open() accesses @xdev without ensuring that it won't get freed.
> 
> Both of these two issues have a negligible probability of causing a visible
> problem, but this must be fixed, of course.
> 
> > 
> > So, add a mutex to the xillyusb_open() and xillyusb_disconnect()
> > functions to avoid race contidion.
> 
> I'm not very fond of this solution, partially because this mutex protects
> code and not data (There's this "Lock data, not code" rule, see [1]). Also,
> xillyusb_disconnect() can take a significant time to run, during which
> xillybus_open() for another (unrelated and still connected) XillyUSB device
> has to wait. I guess this demonstrates why protecting code with a mutex is
> considered bad practice.
> 
> Besides, there are already three mechanisms in place for preventing
> premature release of memory:
> 
> (1) @unit_mutex in xillybus_class.c, which protects @unit_list.
> (2) @kref inside struct xillyusb_dev (xillyusb.c), which protects the
> structure it resides in.
> (3) @error inside struct xillyusb_dev, which prevents xillybus_open() from
> opening a file that belongs to a device that is about to be released.
> 
> It's now apparent that they're not working well enough. Rather than adding
> another mutex, the existing mechanisms should be fixed.  Would you like to
> do this, or should I?

Thanks for the detailed feedback.
It's probably better for you to work on it.


Regards,
Hyunwoo Kim.
