Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB32713386
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 10:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjE0Ix2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 04:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjE0IxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 04:53:24 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49D7125
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 01:53:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d41d8bc63so1439473b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685177603; x=1687769603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=me+mae5cxaS7kwJrJiLva7wyhKeIFfRkkMj+lyKRxtU=;
        b=RHL/T19yv7ny+SqvpezBVm7xumh3z17Ccv0BA2qbw8y6UxdgwyLO74/L5oM65/yRsR
         1GL1EJ5FFUH4fpe2Uz+JuhImX2m5YpPoJVgjdYgF/kOcf1rKzgcKFnqLrfT+goUHIoV/
         lbczMTJeM5HUTwZLqhTYd7DeIqydkSanTbWKjZkb7D00rEcs/choewNm1NTHve3dLJKk
         utho2S8qwM1u50CwfrU9o0qn5zZ6iaYg/ehoL7AKSxnAhmTLV2DTnQjsAH2l8N5Obt6d
         xx4WaBKsCmQeHqn7rgeTp0G7GMS972eq7PA9ccrnelBdlRH9IJhuy1YFHxHQktsvkmkd
         pAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685177603; x=1687769603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me+mae5cxaS7kwJrJiLva7wyhKeIFfRkkMj+lyKRxtU=;
        b=aqT7jIsCU/4DNpA8TGorH0H/3Cak5/iRXh2OjbgK5op5mCBx44meg6jI56ABLCMiAb
         s2SY10foEbyJJDolF5c0p7Vp5HNSjfjfN+TDeCrY75cfeZtn+SwdWsMCuDjWq1wBvyjG
         xk2ZK/PR2liOKFl3VArpbc5WJOLr1OeVp07Qzzz2syuS+0zGXyWfZIodEaDnZUppVs0U
         7xLTiDQ1MPkVX7BnuvsaQNHroNSNOY4PWx78i03NYG8ki0LAtH+QpynCaMLN9SNIzyu3
         kNJK+6QwTq6TwEPGm0Z3GwNvMXAaC+mP46nQtTE8oeZdEfFxQvl81Zo8f95SDqOdKdc3
         6RRQ==
X-Gm-Message-State: AC+VfDz92Y/ElCx5aA2+g6d2UlU2NxX1TDpC+bel5EquU0qAP7f0s2Dh
        zBY83SyTHOCWmh2GEuuvEjcF/GvwHbO34A==
X-Google-Smtp-Source: ACHHUZ4way3YHn4UaZZCYSWMYhMU65cC4uwsS8WLVsLwojobEpcs5dNPiuMf3wLwT4xoAl6uF5YWFQ==
X-Received: by 2002:a05:6a00:2308:b0:645:c730:f826 with SMTP id h8-20020a056a00230800b00645c730f826mr8469649pfh.24.1685177603249;
        Sat, 27 May 2023 01:53:23 -0700 (PDT)
Received: from redkillpc ([49.207.219.227])
        by smtp.gmail.com with ESMTPSA id a15-20020aa780cf000000b00640defda6d2sm3702044pfn.207.2023.05.27.01.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 01:53:22 -0700 (PDT)
Date:   Sat, 27 May 2023 14:23:16 +0530
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dan.carpenter@linaro.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3 1/2] axis-fifo: use devm_kasprintf() for allocating
 formatted strings
Message-ID: <ZHHE/H2p4Go/Igc/@redkillpc>
References: <CAJp9fsfJxoY2=fFK3-R_XoDatMB9z5WT4BaeSw3-nMScicERJQ@mail.gmail.com>
 <20230518145154.33377-1-prathubaronia2011@gmail.com>
 <2023052705-modular-unpleased-0e62@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023052705-modular-unpleased-0e62@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 08:35:57AM +0100, Greg KH wrote:
> 
> Maybe error-prone, but all is fine with the original code, right?
> 
Yes, all is fine with the original code. Replaced it only because it was error-prone.

> When you have "also" in a changelog commit, that usually means this
> needs to be split out into a separate patch.  And that's the case here,
> make the first patch of the series fix the problem.  Then do your
> cleanups on later patches.
> 
Point taken, will split it in v4.

> > Fixes: d2d7aa53891e ("staging: axis-fifo: convert to use miscdevice")
> 
> changing to a different string function does not fix anything.
Right, this should only be part of the smatch warning fixing commit.

> 
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> It did not report that you need to replace a string function, right?
> 
> See, things got messy when you mixed in changes into one.  Please break
> these up.
Understood, will do.

Prathu
