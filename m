Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09445FAFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJKJuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiJKJua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:50:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD216715A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:50:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fw14so12033318pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMcAAyBurX213ms++6fxs5yYshR15LQEWIK6Brhfq2U=;
        b=E30jldzjDUyedes4Dyz0G7M/yKxEwbf7zvDsjPTux3VYUTaiYNJwgckV4Afjq2WjOR
         KxgSgvDWZGcXxmegkYa5RqsqnsOFjsNCeN+f/N8/ujUHry2iOrtrN1AZs2RFLbjD4PEv
         Gois52svXqDPqXy3q+5GtSWlG2iN/KL4ewUZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMcAAyBurX213ms++6fxs5yYshR15LQEWIK6Brhfq2U=;
        b=nft4qwEWOun781LHetKEHOMsTct2TRePr2vfM+xi2qBhgDHShe1m+XA0AZbM8kuDm4
         JykfO+ddY3SgYrnUeg/duXyNXyXTh8G4LHHngOGZ0NmqjYX4AGzZXxGntEUURGWnUr+8
         pSTCEd7tc1obXBC7dESS0w9v9UVX+1UGhZ34RzmslLGBvzBiac1po+nR4gQ1EAwNyVhu
         6XxMKZcx7hOoEwIEELFtPv/qE6uurZ3HNkB6Qp6pfj/k9gvCX04H117g9zSbHMLAVDMU
         EnIQUWCCEat3NbX2DqvJi+vu7WY+ahh3pPuQbmpc0rT/xciEdmyTEMlcuZjhUsBcC8a8
         dCMQ==
X-Gm-Message-State: ACrzQf1ACHLYQnQzUBru3eXsLZdYm2XKbnDdBKm7ySY7mjFcUedjjnB/
        m0lYdnbi845Cxqdn9G+s+4/zQIakzgqckA==
X-Google-Smtp-Source: AMsMyM64TKsLAdnHpm8xa6rVVP1WyAAfcvlvUT8VgjoPnhg8b/BQy8D8VLy5xVUWdI1nnoYKHjgoWw==
X-Received: by 2002:a17:902:d2c6:b0:17f:592b:35dd with SMTP id n6-20020a170902d2c600b0017f592b35ddmr23669488plc.172.1665481817725;
        Tue, 11 Oct 2022 02:50:17 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:9be2:d006:f7fe:8f60])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a3fc600b001faafa42a9esm7559083pjm.26.2022.10.11.02.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 02:50:17 -0700 (PDT)
Date:   Tue, 11 Oct 2022 18:50:12 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Do not delay boot when printing log to serial console during
 startup?
Message-ID: <Y0U8VA7z/on3Hdbr@google.com>
References: <c87cc376-3b0d-8fda-7fc1-555c930faaf1@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c87cc376-3b0d-8fda-7fc1-555c930faaf1@molgen.mpg.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/11 11:03), Paul Menzel wrote:
> 
> We boot our systems generally with the serial console enabled
> `console=ttyS0,115200n8`, and noticed that initializing the console takes at
> least one second.

[..]

> So it looks to me like, that the already recorded messages are printed out
> over the serial console first, before it continues. The documentation of
> `register_console()` in `kernel/printk/printk.c` confirms that:

I guess your console has CON_PRINTBUFFER flag set, so we flush all
pending kernel messages on this console after registration. Off the
top of my head, you might want to play with the default console loglevel
so that we will suppress printing of most of the messages.
