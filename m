Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766BD610132
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiJ0TLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiJ0TLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:11:39 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7C21D0F4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:11:38 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id n83so3423250oif.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQ3lcfYwLC9190AYWlA0XCj9/Igx7XwRYuBQtpMbns8=;
        b=dK6UwwLCKN0tCadn2ApTOCLJGg0MLMM8qxtwVvu/Ouq4cbFinCB13tvnsQnq1ZFsV4
         0b+f8AVxaoDeahLf8dOv5GgLlEbRphvieF6gPuRnmrCMwSDR57fwdU6nVummon/HiTSb
         IWsZ66Wu2E7WpvZcayF0/PTqztFW4rsuyeuxnzv9lQg23lPqAYdNCCzwgUj9sAx1njgH
         yjmJqa0ObZU9PzR8c9Wk8/h7qjDJ2ZnH4rvqqQjkmiGRlnTn0Log2jBFy3C20I5juSrr
         DG80Aa+ngCJC2RPYgVb73wf4DxXjUvpHlGdUOdVmOsxDcTeLwvGKKMAFnKIpUgvHoDVy
         2HZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ3lcfYwLC9190AYWlA0XCj9/Igx7XwRYuBQtpMbns8=;
        b=VP3/8TneNYJjG3X2f6u0Ae+U/dffHeLFDEbHqRvJy6/X1xSd36fzucpvs7VdM+zmAa
         Z/0Yrw53OePZgOjV5RWC9RDq10V3L4VI/Se1wNQov/2WT6i3Oam2pExUYsI3B2+nfHjU
         iP7nHz4lUafLpJ6ky9aWbqy6RaxvbXIqdi5lsTt1R+c4+Q2SyfqNhrOP+7U0cB31qvt1
         VkKllEXZ+a6+E2CT6GYDju0hLHMtCviOY8//THsn6dxwSallw5fkew5YCEPfB8GYDPd1
         QbYGQU6fpxOj1uWCKPDNZyOckqzS9n34zNXnlXzgArC/xaXB1ee+KHC+Q4ONYwzwJ46y
         7FdQ==
X-Gm-Message-State: ACrzQf1PZmNz9n1YX7TM8WKpz9Rvjhv300/54/nlXFE7oiS1w1tP2VlH
        e3HdqCrddletT3H6BlKydP04zUMxWUQ=
X-Google-Smtp-Source: AMsMyM7ZtsxyZDoegCh1cVmuBxxM4mMwmVI3sXox1ojdKdmeOSEJ11Yw7psA3eBXjadjIoosAfhDxw==
X-Received: by 2002:a05:6808:190e:b0:359:a2f6:8176 with SMTP id bf14-20020a056808190e00b00359a2f68176mr5724829oib.283.1666897898133;
        Thu, 27 Oct 2022 12:11:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a20-20020a544e14000000b003357568e39fsm710361oiy.57.2022.10.27.12.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 12:11:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 27 Oct 2022 12:11:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC][PATCH v2 00/31] timers: Use del_timer_shutdown() before
 freeing timers
Message-ID: <20221027191136.GA3226977@roeck-us.net>
References: <20221027150525.753064657@goodmis.org>
 <f62e19bb-497a-8cf6-93aa-d654d7850356@roeck-us.net>
 <20221027150237.4e69ba27@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027150237.4e69ba27@gandalf.local.home>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 03:02:37PM -0400, Steven Rostedt wrote:
> On Thu, 27 Oct 2022 11:58:59 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > This is with arm64_defconfig plus various debug options.
> > Running the same test with v6.0.4 produces no errors, and neither
> > does running it with v6.1-rc2-105-gb229b6ca5abb (current mainline).
> 
> So it works on current stable and current mainline? Does that mean we need
> to worry about this?
> 
Sorry, I wasn't clear. The test on v6.0.4 and v6.1-rc2-105-gb229b6ca5abb was
without your patch set but with all ODEBUG options enabled, to be sure
that there is no pre-existing condition.

Guenter
