Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6A26140D8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJaWry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiJaWrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:47:48 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C4315735;
        Mon, 31 Oct 2022 15:47:47 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-13ae8117023so15058161fac.9;
        Mon, 31 Oct 2022 15:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GBUSFI+VHiFF9npt/hZBaZigRfFySTfJzNUy1BgETY=;
        b=Sk9qUqguwAImZQCkh2lmfngSdvKIV768yp1dexzyeua08Xrd7t3gLj7C1/mYeZSTyn
         r59UglFH7WkdleXskSGehbsUNzANYjB7m4OlJDP/2i7z1kRNnb8SjOlkKXMG6msFS0Xv
         QjS0QPyVbyKA5EUb7igOV4jdZI4Pp1KGn0KCpZIhz3LzKSPTvYh8zVfXx/f32WvJFKZ/
         G+JAPBCHLfZuTyvBjamkCL/+YxtSO8AaFd2L/XI+68baWEWRLzKjvtZnUrzPRcXq8+bS
         hUhiBAb1sPCfQpZ+C+2xR3qUOFiZmjWdccketrHIKwHDqCopV1IXqVzvblbzCQ9SPXyu
         12ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GBUSFI+VHiFF9npt/hZBaZigRfFySTfJzNUy1BgETY=;
        b=qYH/ZLrUR+gWlHvnL9BLGbbnkN4KHYhJ0FMXi3tEgB9vfirrn4k6MOSd8BYwXTVr3r
         jvWZFUDG85kEjBOG6jRPQoRLMrYV03Hwou6aHMjiTGPCOBpLxrxlcn7hKtkNZyZzoeoT
         f0phKfSM2j10PRT/xDT4MUKH55j9F+YrvGnOCFFBYu6VJW8bc1d8Wj12m4GGsDZZdbEc
         MDcZS9/QmBxVfgrDUP28teZk4IKQDVffhN0zA51tJWvPLrho4uuOmvbRomeKqqq7PbQ5
         T1c3vDchnuqvNq+481AHTcHQLagRqxj5IThT3z0DjGYFeeUZ6RH74JCREsRK8I3b+4r3
         q18w==
X-Gm-Message-State: ACrzQf0MnBUNYa5xpVabqPCDEGZ43T6Nrrc2aYHx1lIQkozBpsNqzUPY
        O+km0syrDy2CA8bVE+oZakU=
X-Google-Smtp-Source: AMsMyM7xI52y/1LpfYgwTynoDqPWGfcVWkzza+ZkWkyoRaHgebQV9ESvtTQ52GPriNc6mtG8cfU20Q==
X-Received: by 2002:a05:6871:826:b0:13c:7071:5155 with SMTP id q38-20020a056871082600b0013c70715155mr9416314oap.262.1667256466766;
        Mon, 31 Oct 2022 15:47:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a18-20020a056870d19200b001375188dae9sm3654839oac.16.2022.10.31.15.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:47:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 31 Oct 2022 15:47:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>, linux-rtc@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rtc: cros-ec: Limit RTC alarm range if needed
Message-ID: <20221031224744.GA2082109@roeck-us.net>
References: <20221029005400.2712577-1-linux@roeck-us.net>
 <Y2ABnbBGSJGM3gSS@mail.local>
 <Y2AMQAf/nDGLNMcI@google.com>
 <Y2BESUyKX4KJzhQZ@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2BESUyKX4KJzhQZ@mail.local>
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

On Mon, Oct 31, 2022 at 10:55:21PM +0100, Alexandre Belloni wrote:
> 
> The issue with the current patch is that it forbids going for a better
> solution because you will then take for granted that this driver can't
> ever fail.
> 

This is incorrect. My plan was to get this accepted first and then work
with those responsible on a cleaner solution (which is much more vague).
We can not wait for that cleaner solution now. There is nothing that
prevents us from taking our time to find a cleaner solution, and then
to change the code again to use it.

Guenter
