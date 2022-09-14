Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9D15B888A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiINMq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiINMqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:46:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AAC7E31B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:46:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id jm11so14986758plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=GoJ883CSmuWdImYFXl/CKCtIpSQMQLOeiAZoLtHBZNU=;
        b=Qc3wB1d5TeWhOXDA9MxG2uojJ8V4CB7wyIRWoKPub2C97qOHkLiydheN9w8IgJ1ndu
         VZj2tCHehzTwIRzTwo3J55Awgq6gDnG6CdixGuzCFBuV9c98N5CooZ3KDIVGFjpSsbLa
         jsrFONqn/D07JMn5cQaZZ0waGyVvmQSPIGKlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=GoJ883CSmuWdImYFXl/CKCtIpSQMQLOeiAZoLtHBZNU=;
        b=Z6CiFFHIvzTknxe1IqkGSEILiimrUGPGpNxJu97MNHkmKeg3BfBwARigjnccUFkgnB
         GIgc2/ja9WMlhmmA7g1OXHfDr6FcWJGKGRGVsj43qwmwPYm+tJ2Kp0X1kCSYYAwaaIl1
         voQZ/+cRgAcb0GVOg+e6zFnXTgxDh0C/7h1AsNESwbWC2UtYSpTD/2AaWArfRjsjbR55
         +DFRHZfk0Mf00dcyBfrjL1JRwR28882xfviVRxlnwIM85cqocqwTC9G4VEErsibIaza0
         xDo8WREvTHoXVEI6v/kOZ0vikNVdpfeYzgrGa3G3H7uPj0S18uC9bACWbVr6XjEZ2Tgr
         7sqQ==
X-Gm-Message-State: ACgBeo0xdew96aEH8u7NLXwL743xfGbqIAzmqgI3nqanJVkyQo+x8LB1
        jwUetzihlmYtmCjrdhbChp/Ahg==
X-Google-Smtp-Source: AA6agR75Of768jj4Idndb0sWeIFEHXojrFUI9SplFYa04BYNSeO+cqaA3Oi32NsDAdtUZWVHTG5wvw==
X-Received: by 2002:a17:902:d4d2:b0:178:491b:40d with SMTP id o18-20020a170902d4d200b00178491b040dmr7345364plg.79.1663159589235;
        Wed, 14 Sep 2022 05:46:29 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:e5f0:cfaf:bc8c:558e])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00172e19c5f8bsm1694701pln.168.2022.09.14.05.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 05:46:28 -0700 (PDT)
Date:   Wed, 14 Sep 2022 21:46:21 +0900
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
Subject: Re: [patch RFC 07/29] printk: Convert console list walks for readers
 to list lock
Message-ID: <YyHNHWBPfcqVY0uY@google.com>
References: <20220910221947.171557773@linutronix.de>
 <20220910222300.783722057@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910222300.783722057@linutronix.de>
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
> Facilities which expose console information to sysfs or procfs can use the
> new list protection to keep the list stable. No need to hold console lock.

Yeah I guess it makes sense to take the list lock in console stop/start then.
(I wonder if it'll be better to do it in this patch.)

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
