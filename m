Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913E1707A17
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjERGLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjERGLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:11:50 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E56E1B8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:11:49 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f51ea3a062so99451cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684390308; x=1686982308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIcLsEqKC+yr+YYE2WjsmqsRDHb0wRTZZ7t3w6tiqfo=;
        b=LZxmYM7f0rgzPxounlXLCt81a6InSzR6KuPfTwwlb/TPNCmiRHT1MuwkMDodH7wj/N
         hSZ71XdZVDPjJFvE5OKIxlJeNzgEoBWTBgb7gbZJafHJ8tpKpblfW8kUlh3YJ2/L1V2V
         JXunIqKl9p08LIgiEjSc87nYP3fvd3axMq4Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684390308; x=1686982308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIcLsEqKC+yr+YYE2WjsmqsRDHb0wRTZZ7t3w6tiqfo=;
        b=P5DNXFrYglKJfzpG8xWqRF/QRvCFCtuW+gz/juHdenowwmvaq8uVfuwJ4HUtdOGTPM
         BSymX6gwLB427AZb8P9VRX0PHyaj+er0n+p9LyGmfD88ciM+/TX68x6+HAJG70k2Znoj
         nU53OZjocg9mDSqB5i2Zb35oD7njTIdcnN5EM0xWhnOXdR+IEvUSYWlxcQYAhbeWIiBu
         pZt8GV51F5Ac6iC/pFrQaglYMV2LH0OJeOvUa+nsHXpXzNS6gvJGORq6bX/2yItUkRL0
         vrEppx/maV9ICzfmBvWR+1vIdK8hwULn2KZ2xb4BUUhR6/aKvwSLHXZntrDH8zi9cvBO
         ocBA==
X-Gm-Message-State: AC+VfDwzhjpGZCk2ELMl+9uErrv9BE+SfNFp09IgqQI5CFvFkBxLe+n6
        0HPui2vd0sCKH0x68wPeIevqtkaMdFFk/Y6wsxGatg==
X-Google-Smtp-Source: ACHHUZ7UcZ1YOkuaZFJDDRz7vpEArSW4FiyaB16wFsse5hJMzhWmGaUgqnEaO3WqQFo5JI+GGQCnACL2Sh3EitrLRkk=
X-Received: by 2002:a05:622a:14ca:b0:3ef:343b:fe7e with SMTP id
 u10-20020a05622a14ca00b003ef343bfe7emr248479qtx.2.1684390308438; Wed, 17 May
 2023 23:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <CANEJEGvKRVGLYPmD3kujg6veq5KR7J+rAu6ni92wUz72KGtyBA@mail.gmail.com>
 <20230407194645.GA3814486@bhelgaas>
In-Reply-To: <20230407194645.GA3814486@bhelgaas>
From:   Grant Grundler <grundler@chromium.org>
Date:   Wed, 17 May 2023 23:11:37 -0700
Message-ID: <CANEJEGscz3F-6cZcp7dBVekpxHMNXZWgUW2ic3xd6hm3xWH6ZQ@mail.gmail.com>
Subject: Re: [PATCHv2 pci-next 2/2] PCI/AER: Rate limit the reporting of the
 correctable errors
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Grant Grundler <grundler@chromium.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O 'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@chromium.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 12:46=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
...
> But I don't think we need output in a single step; we just need a
> single instance of ratelimit_state (or one for CPER path and another
> for native AER path), and that can control all the output for a single
> error.  E.g., print_hmi_event_info() looks like this:
>
>   static void print_hmi_event_info(...)
>   {
>     static DEFINE_RATELIMIT_STATE(rs, ...);
>
>     if (__ratelimit(&rs)) {
>       printk("%s%s Hypervisor Maintenance interrupt ...");
>       printk("%s Error detail: %s\n", ...);
>       printk("%s      HMER: %016llx\n", ...);
>     }
>   }
>
> I think it's nice that the struct ratelimit_state is explicit and
> there's no danger of breaking it when adding another printk later.

Since the output is spread across at least two functions, I think your
proposal is a better solution.

I'm not happy with the patch series I sent in my previous reply as an
attachment. It's only marginally better than the original code.

I need another day or two to see if I can implement your proposal correctly=
.

cheers,
grant
