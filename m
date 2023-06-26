Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D3B73D737
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 07:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjFZFjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 01:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZFjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:39:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50013116
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 22:39:17 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-66869feb7d1so1297700b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 22:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687757957; x=1690349957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9AnamMRwkc7LzsyydvW/HwuIqH8aQkipGg2iJDVQCk=;
        b=YLPh9B+ykE7OGu19a7yX0rMf1tZJcP5m55rotvO8GefTPpx6e5qyq2D1odDFHe5GSQ
         56Kowxqbe96pmMpu8G4nEHykXYdADsyW5XR7NQdF16yBp24zGB1jNTA/p1xCn83lf+Lu
         toViC8qt+5gH0+WFxuEIy+CHFJkRhhWKe87vRHpHBcjURCiU/lYTufVv9hVNOOPlbTPd
         vE2YJToiyx0eONQ01DqewBW5qDL1cGRTz2K8+toGaM9TMUxiueMWxfO6vQi3cTgIsoR6
         ldDVQlhfUv3JPlf/twe/fDEKc31TYc66zu/orYAuGfSayBi35YQKlda8CZdT4WMVxYqf
         c5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687757957; x=1690349957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9AnamMRwkc7LzsyydvW/HwuIqH8aQkipGg2iJDVQCk=;
        b=aXQQmYXIOOfvoNVLeP6KrTdnNPJ+ip/vJtd4Yd8t0FI/o5bq2NkjYGtl0uuV0S70+f
         8RLPyzGbWE1etwQhqoz7FAaUXioyeITq4ZgBu77Rx0DkHo4zQ2V/RTBKNubv+mzQjyDu
         hrRXsxV4NyCr4hkVXg+gbl21zFgZq1krnqsyL82mMqIjXnJpSTF807sTlHdHuyWMJHhv
         hQGXkogyWhPWW9Bz35enwAUjDKhWQJKEDnLMt2E+fC/n81TEAFSdHdVAnxdWm3594Zcr
         gM9qr8/+UoG0oszIBn+39zJkK4dMjO7+ynG7m59mGJCuAXsA45Hu9jZj2Yi81ZvIMU9X
         qPLw==
X-Gm-Message-State: AC+VfDwavPP2uwMI/ZKs3xacwqLa1+gBn1tT4U0MvWwLAJMe3SqvTBhC
        NpMflX+gK2eVuBKBh6Y5GUWsRlrQ7t0=
X-Google-Smtp-Source: ACHHUZ4JE0xJ120ybak3csX/uHfo05X62Qdin6xBeO5STe79hUDcbmuI0vr2XfGTzQYahtkSNc5Z1A==
X-Received: by 2002:a05:6a20:428b:b0:126:3759:582d with SMTP id o11-20020a056a20428b00b001263759582dmr4577900pzj.15.1687757956675;
        Sun, 25 Jun 2023 22:39:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jb19-20020a170903259300b001b50f35aff1sm3263712plb.140.2023.06.25.22.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 22:39:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Jun 2023 22:39:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.4
Message-ID: <8815f965-cc79-47b6-aee9-668b47a6d9dc@roeck-us.net>
References: <CAHk-=wi7fwNWfqj-QQqEfZTUOB4bbKT8QiEUDHoPk0ecuYA7cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi7fwNWfqj-QQqEfZTUOB4bbKT8QiEUDHoPk0ecuYA7cA@mail.gmail.com>
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

On Sun, Jun 25, 2023 at 04:40:48PM -0700, Linus Torvalds wrote:
> Hmm. Final week of 6.4 is done, and we've mainly got some netfilter
> fixes, some mm reverts, and a few tracing updates.
> 
> There's random small changes elsewhere: the usual architecture noise,
> a number of selftest updates, some filesystem fixes (btrfs, ksmb),
> etc.
> 
> Most of the stuff in my mailbox the last week has been about upcoming
> things for 6.5, and I already have 15 pull requests pending. I
> appreciate all you proactive people.
> 
> But that's for tomorrow. Today we're all busy build-testing the newest
> kernel release, and checking that it's all good. Right?
> 

Build results:
	total: 152 pass: 152 fail: 0
Qemu test results:
	total: 520 pass: 520 fail: 0

Guenter
