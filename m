Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10977385B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjFUNux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjFUNuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:50:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC33519B;
        Wed, 21 Jun 2023 06:50:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b693afe799so1315095ad.1;
        Wed, 21 Jun 2023 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687355450; x=1689947450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uxn7JpSM143hDirR91x8tlGJ/0kaa0KP5K4TK0Bzc5U=;
        b=Ns+fTk0hvVwPormQiusr7DmQXVsuD62qQ3Rz+CyyZTH3p6x6ugcHEcTmcags9KmKtQ
         kQ9vou1yhNUuLK8TLzHarNMrj9CZtp4Xu6ei1s9jJ7Fyp5pFHoKivHKkyL/DE4zxUCHK
         NcZMbHVaiC9SBVJBQOEUoJIrzRdhput5mN8dmkgEFR9Vd9D/RMLk8mKYgo3vvWKIp4+G
         JyrU25pezUYMlaN9S4i7kseT/YxTw9LdU4Y6VYgo9hgoepHvY2qtJ2Li0KUyOeXfOwWS
         W0uEGdeMUVVUVMOsItfqhpXJIP56zhvGGjmP7wb/mkOdoHfVusuQQnhQUR0FpdMouy4O
         Fh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687355450; x=1689947450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxn7JpSM143hDirR91x8tlGJ/0kaa0KP5K4TK0Bzc5U=;
        b=NsLiQ9o0atdoQUFxvFgeyiRU2BllriIkVidVGcuT+RCWdvm06Rb8Mmw5PyMgq49EzN
         L7mjht6eY0UxqMLpUwxC6NgdDFSnbdG0eXeXDG1c/OkMvopBHex9h2jhdszLs3TuS06b
         z540jLV78u7Xi9rHOEwZ7+5POPmPjJVr9rQLJGoTT4O8peAj09wxEuZxSZkG7ff5xZbY
         B6HmBiFRg5QYl6arCCt6qPEPF2kmzj7FvbOw62os/RZfIFoGuO1aIDcQ6xFzVfjRcWWY
         PCZiQpHe+R3w99ha8aYDMLpB9FjFfCbjbOJnduIRwOIlAJhMWk2MpoULGwPVwg2Kvxk1
         LPvA==
X-Gm-Message-State: AC+VfDz3/DNZF3CQ66916N5Gq2spPliTcTprF2owjwAb7FMjvOeERRbW
        iGzoxY9yr/kq2DVGUBPb/tnN1adiPLc=
X-Google-Smtp-Source: ACHHUZ7XJzc838erhMn5vckigt0mI3Bggtd16R+B32DOImlwodQz+zxnWCzICD6VSODgIA5LBV1DUQ==
X-Received: by 2002:a17:902:f691:b0:1af:adc2:ab5b with SMTP id l17-20020a170902f69100b001afadc2ab5bmr18687631plg.0.1687355450149;
        Wed, 21 Jun 2023 06:50:50 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8200:e:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b001b3c33e575fsm3535573pls.95.2023.06.21.06.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:50:49 -0700 (PDT)
Date:   Wed, 21 Jun 2023 06:50:47 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v3] net: micrel: Change to receive timestamp in
 the frame for lan8841
Message-ID: <ZJMAN88XYA6drwfe@hoboy.vegasvil.org>
References: <20230615094740.627051-1-horatiu.vultur@microchip.com>
 <20230620113021.01d90f90@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620113021.01d90f90@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 11:30:21AM -0700, Jakub Kicinski wrote:
> Richard, looks good?

Yes.
 
> I'm not sure if the settime handling is sufficient, some packets may
> still sneak thru both getting stamped with new value of time and use
> old upper bits and get stamped with old bits and use new upper.
> Can we disable timestamping, drain the queue, then change the time
> and enable stamping again?

This can happen with any driver.  The user space stack combines four
time stamps to calculate the PTP client/server offset.  When setting
the clock, some skbs might be in the kernel's Rx path with the "old"
timestamp.

The kernel doesn't track Rx skbs that have HW timestamps, and stopping
the MAC and then flushing _everything_ seems heavy handed to me.

In the user space PTP stack, setting the clock happens immediately
after Sync message reception.  For configurations with a very high
Sync rate, a linuxptp client has an option to skip a given number of
messages after setting the clock.  In this way you can avoid stale
timestamps by choosing a duration that is longer than the longest
frame residence time from MAC to kernel.

Thanks,
Richard

