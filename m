Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6BD7057ED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjEPTvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEPTu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:50:58 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF019A7
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:50:55 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5208be24dcbso10513865a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684266655; x=1686858655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsVpd25y2UfIYmy92zRzM4OcUZ302mvg/5EXsXmtSwA=;
        b=UXJCDwRPf+VMxuUx1hPCVMQIGTgGB+nZ/DfJxYzeBsmbckCVRZFB0Jb0IEu1/ZQZ0P
         sdq45g8RsnKrolytupambK66HEuV2wyzt+PFKRmuYbf4XYGTAGQKEXEm9A0OHlGgO4fN
         61YQmAi4KSRMz59MBqhluIa6skCKhhPcpk6qi53uxgm41m9Yjy06LoqamMs2evIbElWZ
         f8KGK/98GXG4VKyIf3NtOtFJiIPqb1L0qTJsm1PqohJ9zAjWUbCjIfR+L4rmt5bEwdwV
         3fLLjuriNvYNhwKRc+g1Pic2geHuDa3OqHq327xSA3opeUVfC0aDHyjE0HhxTkYLIxgo
         dJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684266655; x=1686858655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsVpd25y2UfIYmy92zRzM4OcUZ302mvg/5EXsXmtSwA=;
        b=eiPSpVj5OFy1iN4/mJF8iYxLN/4O+x8z0QqK2NHF+L17zc6Ty4cvshaHVz1jf8vke7
         ElsybxUe5Prtd9TCnB/ST3hJGD3U3oJf3Bb/XHA1V9JFqsbQJ/hEb3iGEmgYEOqLa1yb
         MAbMhMoWuYe2Wwmhdt5MWpqcF+wN83M5Fpuz0Jt7XFAtDNkiiKjJ2pYBTDcJeEtypluq
         ao+U1wo369pwhIYUm/43gKDnzCVP6V2CbLonvCgMmeBJZ+6glFCkN+UnF434A+B0L5te
         O6Np6/nBZY7MXipEEqhlCOuu9HDUZ5Fv66pf4mQQkRbOARDIRe8IE3S8rX7iORX3vAUW
         SANg==
X-Gm-Message-State: AC+VfDx1TMk3dnElVClVp4SF9b1WfaS3NYbaPT2bvk7xKxkPIwwQSZ08
        HxfmFKg4sHreS6PpHdJJF/5+390t9us=
X-Google-Smtp-Source: ACHHUZ4TwYpZMtj+jBAFthSHMtdAp50UKGy25FHHjqCdqMTL37U8KZW9ahwZExD7zHWo6H5BpB/Zmg==
X-Received: by 2002:a05:6a20:7d83:b0:100:a6ba:ba1b with SMTP id v3-20020a056a207d8300b00100a6baba1bmr40240287pzj.51.1684266654782;
        Tue, 16 May 2023 12:50:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t24-20020a63dd18000000b0053071b00c49sm10369702pgg.23.2023.05.16.12.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 12:50:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 May 2023 12:50:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.4-rc2
Message-ID: <ef156fb3-ead6-41f2-9938-fb7ba458c292@roeck-us.net>
References: <CAHk-=wj3jDtVCi2LqyijGzut2cq=AkPrAMfF0+6gtZ1WB6ruWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj3jDtVCi2LqyijGzut2cq=AkPrAMfF0+6gtZ1WB6ruWQ@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 01:03:27PM -0700, Linus Torvalds wrote:
> It's Mother's Day, which obviously means that you can surprise her
> with a brand new kernel. And you're in luck, since I just happened to
> push out the very newest one: 6.4-rc2 is out there in all the usual
> places.

Build results:
	total: 152 pass: 152 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Guenter
