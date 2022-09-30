Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6CC5F0F9E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiI3QLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiI3QLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:11:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBCDDAF18;
        Fri, 30 Sep 2022 09:11:09 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 10so7611137lfy.5;
        Fri, 30 Sep 2022 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date;
        bh=0XxSJsu3bH9Ppvve7+IqPf3kSnP38YM775YbirmovbM=;
        b=n/cxhgvwSl5U1yWp/bqie6Hz+5vxYMzf6zo2NYJMIfTrIGre0kDynSy1PXXl84JZgq
         fWnFaSroFiUHr4Z5C5zKmRbjQaNLoogzRfoOkAniSL0WVXR8X+JZYK8jFfMnpqYQLzRe
         8U2SdOUFB5CFhQY1YqLx2LiLV9wGkuGh6fVSdUv8nYBSsI5bOcrnF+bo5gQ8PAVZ2sVe
         bwE9o3Iy110M8ZOUvkcdT3xzf0hjj16peHHZHDVSzOK8SuuluvwYyjBKYWYzo0pCQHlD
         2RAHNjQ11fm+8ESMALHE6/CFB35nlX4n89FFfiEFLDmAsoeBp8t8luVlWR8ud3rZzLjP
         d/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0XxSJsu3bH9Ppvve7+IqPf3kSnP38YM775YbirmovbM=;
        b=nIQPDgHU2Po+IHD+yYhMR5U1nou8OURrCTdNyJYef8izZr2Oa/vglWgOwbmdCLsU6o
         SjqvyhQCbXyX8stR9d6l28L/E+DVPZ1146WABNHg6hivg4HxCQg1S1irkkw/F3kNm/UH
         OdDE9v3JTkxu6J8E5N43YGR0FyQywMoY5cq55bPP6jgqVBnPh0rzrwoCAj01z/skD89u
         RHlFP25jVlRgDSZbs5n1v7zTEBHPXkRlID0KibtfZ4+FNv9NPaSOxXEwBWU0Gj9iY4OG
         T6XWKKB8YbwxwsHdglpaZkM/gkSnjVrhXv5G+tgwuOxtcxpQtPXo0PNaAGQzaSUtoCXN
         MVBQ==
X-Gm-Message-State: ACrzQf2KVBVtNzGkNI3bxRg1XrJqMv3rAdOkXzOHe9Y1jSFKfduNnqF4
        SeKvLFsX8QsfF0axHSNbOPc=
X-Google-Smtp-Source: AMsMyM4s9EOuNSqJBfBIwE7Bwcix/Ye0/xm46vQ6KL54uZZ/Xfn8Q8MbFx61eQIfEjOUxPMe+QCAoQ==
X-Received: by 2002:a05:6512:2241:b0:479:6426:15af with SMTP id i1-20020a056512224100b00479642615afmr3654946lfu.631.1664554267775;
        Fri, 30 Sep 2022 09:11:07 -0700 (PDT)
Received: from pc636 (host-90-235-4-249.mobileonline.telia.com. [90.235.4.249])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512048200b004998d9ccb62sm336638lfq.99.2022.09.30.09.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:11:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 30 Sep 2022 18:11:04 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzcVGN8v1yhgIlF6@pc636>
References: <3F5B20A5-6E48-4603-ACBA-0A7947A9C457@joelfernandes.org>
 <9E3CFF3C-8956-4C44-8072-1CCD5E84CC4C@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9E3CFF3C-8956-4C44-8072-1CCD5E84CC4C@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> 
> >> OK. Found the boot up issue. In my case i had 120 seconds delay:
> > 
> > Wow, nice work.
> > 
> >> <snip>
> >> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> >> index 448748e3fba5..a56cfd612e3a 100644
> >> --- a/drivers/scsi/scsi_error.c
> >> +++ b/drivers/scsi/scsi_error.c
> >> @@ -312,7 +312,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
> >>        * Ensure that all tasks observe the host state change before the
> >>        * host_failed change.
> >>        */
> >> -       call_rcu(&scmd->rcu, scsi_eh_inc_host_failed);
> >> +       call_rcu_flush(&scmd->rcu, scsi_eh_inc_host_failed);
> > 
> > Great! Thanks. I’ll include this and the other one you converted in the next revision.
> 
> By the way, any chance you could check android as well, just to rule out any trouble markers? ChromeOS and your Linux distro are doing well on boot so that’s a good sign.
> 
I will check v6 on Android. I will get back shortly.

> (Also let’s start trimming emails before Steven starts sending out nastygrams ;-)).
> 
Done :)

--
Uladzislau Rezki
