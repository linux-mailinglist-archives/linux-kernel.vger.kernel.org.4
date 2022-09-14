Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB465B8757
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiINLkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiINLk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:40:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE6E3335B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:40:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o23so13011744pji.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=g0rsQ4l7UmHyrtITmpI1lLcpUUEE5rxqSouv8Vx28LM=;
        b=g7xZVqYVeqkH4bxfqu4qqC5Vm4r1XjAtgnSK9MddChlyT+E6dBLwoOVpE21waZ0qAr
         DMsi2Cx/2/K9YSrzbWD4EcpAubrFl5NMRxRnnWFq5006cDSH/QJ4PUvBlPoHJrG81R8M
         x3cs6XFr7uu1kd96wbKxZi1nxJ7/P4bu+6MFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=g0rsQ4l7UmHyrtITmpI1lLcpUUEE5rxqSouv8Vx28LM=;
        b=o3+MoVg5D9vJbkqoJGXUpEFBi6qQfyZiYd0+SiTzYxBPnp2xJ58kfneBwZ4G9oB7OU
         yeO/bROXKL69tA1gdJj8ErlOaInx1sUk5qvnqbv75Ps4sQlUM20+Z4Ox3vuyLQc+tcsR
         T9629yrQRg0/AbD8CN96tthrG2NCmLFChpVsgg6BB5aH3QGmYKH/CvTKzqdkgqMZDUEB
         nipXf7fpUFu4UBg9LnsJI/yas987GZk5a4MUTUWIgSdMnTZQJqHSSOqlI+QffgbhMEzw
         8ONKlbG/uQuvet5aLAC/USvVJD4Uw9BzR0wnsb05oyRYNDAReWQoD6cciY7RINv/xRns
         +TMw==
X-Gm-Message-State: ACgBeo3K/ArNszID+3eU4O+FpmGqc/zYLlcxlKX5M1NbHkSoawP/9IhS
        LPPiH4bMKX+wectTxoPlXOWMHg==
X-Google-Smtp-Source: AMsMyM6IxLuIlNR+tc1Ff0JRk1CO2I5t6uNyxxIk7qNKQzTmdTd/RDnNqTzuLqs1c2HJHwHD5SuJaw==
X-Received: by 2002:a17:90b:4c45:b0:202:6308:d9c4 with SMTP id np5-20020a17090b4c4500b002026308d9c4mr4373546pjb.40.1663155628394;
        Wed, 14 Sep 2022 04:40:28 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:e5f0:cfaf:bc8c:558e])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090276c700b00176acd80f69sm4445457plt.102.2022.09.14.04.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:40:27 -0700 (PDT)
Date:   Wed, 14 Sep 2022 20:40:21 +0900
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
Subject: Re: [patch RFC 04/29] printk: Remove bogus comment vs. boot consoles
Message-ID: <YyG9pZ2o7WSyvxJ0@google.com>
References: <20220910221947.171557773@linutronix.de>
 <20220910222300.582492276@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910222300.582492276@linutronix.de>
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
> Date: Sun, 11 Sep 2022 00:27:38 +0200 (CEST)
> From: Thomas Gleixner <tglx@linutronix.de>
> To: LKML <linux-kernel@vger.kernel.org>
> Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek
>  <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven
>  Rostedt <rostedt@goodmis.org>, Linus Torvalds
>  <torvalds@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>,
>  "Paul E. McKenney" <paulmck@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
>  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Helge Deller
>  <deller@gmx.de>, Jason Wessel <jason.wessel@windriver.com>, Daniel
>  Thompson <daniel.thompson@linaro.org>
> Subject: [patch RFC 04/29] printk: Remove bogus comment vs. boot consoles
> Message-ID: <20220910222300.582492276@linutronix.de>
> 
> The comment about unregistering boot consoles is just not matching the
> reality. Remove it.

Hmm, yeah, we ~CON_ENABLED console that we unregister before we console_unlock().

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
