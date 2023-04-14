Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895A36E29AE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDNRuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDNRuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:50:20 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88AE1FE2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:50:18 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k7-20020a170902c40700b001a20f75cd40so10110945plk.22
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681494618; x=1684086618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a6CeTamdicyLZ/7s+LRWUZBxqdL0LQPjD0XtZ5cm3WQ=;
        b=GIuDJQhWQ/FtuCo2i0jZVWT/d40dUYkLnmOK5AUkIoTJJ0V0/tfwq8nNp2nENlpMFO
         gDF41f2YEp1ZOoa6KxDnq87H+eE3iAI6HP58bZMfIF8vPPALAo5YJRmQk3vo1WlgE0mV
         pom/AfgnsCswwZarRdhsqWVVTYSg5s3MO/ebBbM+51AVnltHA9FwVTqy52c2kAdwTJNe
         xATaGURVoaIOwDoG5NI5k5K8ZBllSm3Kv3PzuRESGkzuKkYzqW/30tdFW+9wAcELN+Um
         MWWiVleY3A3XbT86Xk3m6X9X+2jMCaeQ/tUMxF+LwEG/nFONMmXJw3G/Xkbb8CBueUWa
         h92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681494618; x=1684086618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6CeTamdicyLZ/7s+LRWUZBxqdL0LQPjD0XtZ5cm3WQ=;
        b=fR7mT8DmtU9RKzt5795AVGuNxgZJlQxPrjW9PG3bYIGka++fZJKmc5nLZ851K2ApEY
         yXPYvVoU5/+r0rv9NZUfW/DnFOvVBLAXLNuEOfAf7/mrhwWSzjuOo14M8XEaP77XtPRH
         A0azv4tmLP3u1f/iY+EEE92F+MMIGsHt++UWEvVfEvf+OOu5U9auV/DfMM7joywFNkat
         sKwtbCquUBp7gdI7jw/pAWwFuCpH24YrvNLr3h+y/CL+ZSz+CTPNfrPADiRokUhdcpIA
         YHlrDKqQcwIP2yW/wc+azk7qTluZd2Wt6MYuqeY/Ousewr8i4eLeW9mzkqg1BdxkZ87B
         xN4Q==
X-Gm-Message-State: AAQBX9fYgKrV6v1PyHq2CkCjXQnnVw48Aa72y00elOKB+ztjZPvZBLGy
        eaOgYtz5t6Ir5wNh8/ZtKzp+xLw8fxA=
X-Google-Smtp-Source: AKy350bVjNQlfCmuGcgyBmDBirokb5vdFwa9K+zgeLvg8xG7Vaq/gPeOKn/mmbUdIZJrJveHW6y5x7HzN78=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:3348:b0:1a2:1fd0:226b with SMTP id
 ka8-20020a170903334800b001a21fd0226bmr1183636plb.5.1681494618211; Fri, 14 Apr
 2023 10:50:18 -0700 (PDT)
Date:   Fri, 14 Apr 2023 17:50:16 +0000
In-Reply-To: <20230413121112.2563319-1-alexjlzheng@tencent.com>
Mime-Version: 1.0
References: <20230413121112.2563319-1-alexjlzheng@tencent.com>
Message-ID: <ZDmSWIEOTYo3qHf7@google.com>
Subject: Re: [PATCH v2] KVM: x86: Fix poll command
From:   Sean Christopherson <seanjc@google.com>
To:     alexjlzheng@gmail.com
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinliang Zheng <alexjlzheng@tencent.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> According to the hardware manual, when the Poll command is issued, the

Please add "8259", i.e. "According to the 8259 hardware manual".

> byte returned by the I/O read is 1 in Bit 7 when there is an interrupt,
> and the highest priority binary code in Bits 2:0. The current pic
> simulation code is not implemented strictly according to the above
> expression.
> 
> Fix the implementation of pic_poll_read():
> 1. Set Bit 7 when there is an interrupt
> 2. Return 0 when there is no interrupt

I don't think #2 is justified.  The spec says:

  The interrupt requests are ordered in priority from 0 through 7 (0 highest).

I.e. the current code enumerates the _lowest_ priority when there is no interrupt,
which seems more correct than reporting the highest priority possible.
