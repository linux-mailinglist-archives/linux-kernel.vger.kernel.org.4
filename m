Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F179736E86
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjFTOTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFTOTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:19:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9889FB3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:19:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b52864b701so37138165ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687270772; x=1689862772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPbHvVq3KoOUs2bhLUrxDABB9R598G0x6TnhcnD1C2A=;
        b=INRvaxKOqHBsjckri6l9HHLMkl6s2YdURy3hUHcRAZoHy/DbfhehWuooYAhZahPioT
         hRS9F33V9mGBG7UgPLTVFelf6j6/SSL/Yri7EpCq0oZZVYawcWbSwLxEzVP1TI/OpZRj
         CG0WIceQMDLy+uqlcqiFvJiGMuSM/pZS7QugyZ582qyMjH5n4Cbi/ucXZuLTSN3Gs553
         HuD/2YvlvJ0QBTVaqPsdVoK9U4ardOLyyvxtT47+zYWDvX6y55XGzMmiX78f+KrPL+LJ
         QdbEE4uiHcoQFb2uuQ9yEBzJ6QBIkeXdG9Grj0EmMc7rV/S2fwjP2tZD4bTc/jGa7seG
         gLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270772; x=1689862772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPbHvVq3KoOUs2bhLUrxDABB9R598G0x6TnhcnD1C2A=;
        b=UukG8vtyAlMwViVbfXUKmAtH/s+yEBQUYaNaCuD88FWX55sgZvgU5TsmkGKst/KRXf
         C4ksnw5MY9FBn/i+yPuCGbFUZ/OtQUBkQq2wad94VYdw0iz02Ht2KUG01LQ1+H6LV+YQ
         LRdV7Pz4xJnyoVRA0tl2LlhvYZK0RaeYUAgA+ySplkE/BjS0N4kTtfcB5dRD923ah0xh
         rtGeVdtmEBhcyDowEKL9wgOwctIwIUexc2tEXg5Qu3i5ZuUkhLXUA1vEwoZ8NAOoRJAW
         LE1zSQoGqLJkC0QWvCl4zbKRisMbVy4i1slK7cwHqrvhEZ3iNvT0mdCGv83W8wkIuD8/
         STXQ==
X-Gm-Message-State: AC+VfDxxN8L2mkUjrD+icYXLweyqaiLv71MwBzGhniRw3ik9m/Rf0c9z
        2ePTrJFkl/R2Egqw2lSZWXvYAhLSvmk=
X-Google-Smtp-Source: ACHHUZ5kbioDDRp7sVjc3eVwrWCQ7vjvVFb6Lt3FKk63Uup/RPhojzASsZeXxDF2hvdS63yxrcVoPw==
X-Received: by 2002:a17:902:daca:b0:1af:c1a7:3bb5 with SMTP id q10-20020a170902daca00b001afc1a73bb5mr15835214plx.4.1687270771917;
        Tue, 20 Jun 2023 07:19:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902e74200b001b3c892c367sm1721661plf.63.2023.06.20.07.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:19:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Jun 2023 07:19:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.4-rc7
Message-ID: <59723b4b-5109-436f-b25c-7513fac65409@roeck-us.net>
References: <CAHk-=wjtPpxeR0t980F8P+pkQ-wNLiH2fpyjxUFJNWGMYRmnuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjtPpxeR0t980F8P+pkQ-wNLiH2fpyjxUFJNWGMYRmnuA@mail.gmail.com>
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

On Sun, Jun 18, 2023 at 02:36:28PM -0700, Linus Torvalds wrote:
> Hmm. Nothing particular stands out in the rc this week, unless you
> count the mptcp selftest changes that are about making the tests work
> on stable kernels too. That accounts for almost a quarter of the
> patch...
> 
> Other than that it's just various driver updates (rdma, gpu,
> networking and usb, with a smattering of small patches elsewhere),
> some networking changes, and a couple of filesystem fixes. And the
> usual random noise elsewhere.
> 

Nothing special to report on the testing side either.

Build results:
	total: 152 pass: 152 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

No new runtime warnings either.

Note: I keep testing, but I did not bother sending reports in the last
few weeks because I did not observe any failures.

Guenter
