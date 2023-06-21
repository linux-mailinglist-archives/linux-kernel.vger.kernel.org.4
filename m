Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2637385BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjFUNvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFUNvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:51:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBBB19A9;
        Wed, 21 Jun 2023 06:51:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2610f4d2294so1961a91.0;
        Wed, 21 Jun 2023 06:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687355469; x=1689947469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rgUaVj33Q8V+dYunhjxyQcs1yGerwAWKpThsCvWxQl0=;
        b=FAySKuka41Oaxnwyak2X2RDZtth63z3cjHg1S7PirLORN7G+XajdQ9dzTm55cIdEdl
         sDeG67Rj18CMPowVC+Ur6NagZE+PaG6fN/+qfj+UkzKu+BCpwTbVyATDevshoLQN/N+L
         YKkactYq84gjvNajT9rIpsK+GhhMZYVHDRAs/JsttcTRq6LCMVZec4Nqe8InP+DGx7P8
         g+EjwUu9nyPFzBJrliFhoGT5QY6yA++tHe2U9fsYK9SzmFWGZpR8jrhi7lz/oeQlTrYu
         hNiCNp9xVaqFYkGBrzAFhvrpjJE9UY0KTupjthTkOLzGYXF0QTfohWy6uG/YVUTmgCMB
         XIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687355469; x=1689947469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgUaVj33Q8V+dYunhjxyQcs1yGerwAWKpThsCvWxQl0=;
        b=Tfm48eFY+Sf9fkf2rEa376EsDz55KoFuRIOyLZ01lkY9eidssvcftwSfL4e9yz0jCE
         7TGNe1VfpkgdsK7bQ6wOHzJfmMMM6Rs6UzFd/LEDhk83W0xi16NHMGZlKHkAP4s5Gp9h
         arziFqDLhGczWy3OairulTUqkQNc5NWcCEwz5P5CUaM/Tku8x+ihCs0Z2SRpsm8tSuBX
         uWykR7ksEUrcA8biX518XW647iykiDvhM8dD6rrAPYFrMoDyh3McwVKA4sJg10Fn9Wjw
         T/TuzVpxCX0eIkxB2CYo7LAJ/DsIYIL0s/N6VxwpUn9HqUFki6WNxQfAoJ73K/5NQc+d
         /68Q==
X-Gm-Message-State: AC+VfDylUY3S8pNUkdf8GQuknbCZFpI8kgr+fmblc+dfbAHCHhRDEsdB
        mtcHIRPNSYrzzcJTtg2j6h0=
X-Google-Smtp-Source: ACHHUZ4v0mgQcfZVmwFq1z78P/pmlqJbn8eVW8Cu6wXBNThucznOjJPH2rzWDuA9anwusoyvnQOcig==
X-Received: by 2002:a17:90b:164a:b0:25b:e83b:593f with SMTP id il10-20020a17090b164a00b0025be83b593fmr19041391pjb.4.1687355468805;
        Wed, 21 Jun 2023 06:51:08 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8200:e:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b002610a3cdc3dsm463476pjt.12.2023.06.21.06.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:51:08 -0700 (PDT)
Date:   Wed, 21 Jun 2023 06:51:06 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH net-next v3] net: micrel: Change to receive timestamp in
 the frame for lan8841
Message-ID: <ZJMASvms7nLY8HKz@hoboy.vegasvil.org>
References: <20230615094740.627051-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615094740.627051-1-horatiu.vultur@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:47:40AM +0200, Horatiu Vultur wrote:
> Currently for each timestamp frame, the SW needs to go and read the
> received timestamp over the MDIO bus. But the HW has the capability
> to store the received nanoseconds part and the least significant two
> bits of the seconds in the reserved field of the PTP header. In this
> way we could save few MDIO transactions (actually a little more
> transactions because the access to the PTP registers are indirect)
> for each received frame.
> 
> Instead of reading the rest of seconds part of the timestamp of the
> frame using MDIO transactions schedule PTP worker thread to read the
> seconds part every 500ms and then for each of the received frames use
> this information. Because if for example running with 512 frames per
> second, there is no point to read 512 times the second part.
> 
> Doing all these changes will give a great CPU usage performance.
> Running ptp4l with logSyncInterval of -9 will give a ~60% CPU
> improvement.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>
