Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A176F60FD49
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbiJ0Qiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiJ0Qiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:38:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6669B18708A;
        Thu, 27 Oct 2022 09:38:51 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so6050189pjh.1;
        Thu, 27 Oct 2022 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4/1b1qcy/q10T/xwgjyAFlhqgrlOQeWECP0LCGi9PrM=;
        b=kR+vQY5k4SVLrCb743A3JHbbgYqiBt7Cq6HYCSuJ1fDX1M8gu+PLLJA8as+BSESMpS
         EdCqdj+v9yDXU2Mg8ZoETV7ph55TjCA3sImosMIChII8sFDgeth2mVWVuPnyEO/rN5T/
         4WK4C97ij4A8rOw9RMEqwBvb0nE5idBSnEEpwuC4Xbl9zRJLndurVLtgWtBTGn4ZNA9A
         AncikKgof6oFcmmYtXlXzESkC+wLxWGu0QTnqIMoPxoiegZGNu0NaUngeDMzRIG2ovU8
         o57CHpi+d/YhjTbR2hUGYn8hs8hm70BLNv/eUnGC9o0WLWmS3AeT0jSkf9bLY6Gcrd5j
         rang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/1b1qcy/q10T/xwgjyAFlhqgrlOQeWECP0LCGi9PrM=;
        b=xLGUcFFY2mb/Ilfm3iAvzUYS0qJb8VMZOajySugPRCPeK5hTAU9eKBctt7c4la8ivC
         Yem/2MnH8Sz8/5SV3f5fLBnsbI+mHdvU3Z/0YqUVC2G6C/xXl1bk23uOqOvvJEpWhAuo
         hskyjFkhlJBEJ1xLUHA0xuXN9U2txQYAYCFq5pK8xiqs9w4wXEmceDIdtm71HNMy9vKL
         reRSrJZGMTpHlPfZIURalDF+S2L+b/EiDxnT1l2o+QLBrlCmzi+9sBJavMHCOlSxSUiz
         gx48K9AFO1gYskV59zTb18LTdaFImGMjXrGX2MFBwuW7VB+Ll32Mjoea27TqpWb5UyUL
         gFVA==
X-Gm-Message-State: ACrzQf1U3p4caOxWy+Pist7AUcoSjEXSwb4WqsLlCCCni49XKdxxHudZ
        zNcrrtoJFeiO1zaLEcJ7l+E=
X-Google-Smtp-Source: AMsMyM6NQyy9M6pqOOyiHu/Iq8naC2MMbmNJilYhAd895GtcEme5YsDNjgXNAMotBpRf5wqwbsIfNw==
X-Received: by 2002:a17:90a:c691:b0:212:fd5f:1ab8 with SMTP id n17-20020a17090ac69100b00212fd5f1ab8mr10886380pjt.11.1666888730774;
        Thu, 27 Oct 2022 09:38:50 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:99d6:ae15:f9aa:1819])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902710600b001865e69b4d7sm1370799pll.264.2022.10.27.09.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 09:38:50 -0700 (PDT)
Date:   Thu, 27 Oct 2022 09:38:46 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org,
        linux-parisc@vger.kernel.org
Subject: Re: [RFC][PATCH v2 15/31] timers: Input: Use del_timer_shutdown()
 before freeing timer
Message-ID: <Y1q0FiznpwJ7/TPm@google.com>
References: <20221027150525.753064657@goodmis.org>
 <20221027150927.992061541@goodmis.org>
 <20221027112117.7324570a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221027112117.7324570a@gandalf.local.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:21:17AM -0400, Steven Rostedt wrote:
> [
>   quilt mail --send still can't handle unicode characters.
>     Here's the patch again
> ]
> 
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Before a timer is freed, del_timer_shutdown() must be called.
> 
> Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: "Pali Rohár" <pali@kernel.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-input@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge with the rest of the series.

Thanks.

-- 
Dmitry
