Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEE1711DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjEZCVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjEZCVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:21:02 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647C21A4
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:20:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b00ecabdf2so2479215ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685067654; x=1687659654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QRIhUR+oTuFzicj0A9tTt5U7sXcp4Ft2BenovbdFSYY=;
        b=b9b5Vz4NA+ou0L4F1w4MxfO5cZLFEG7HNxHx8qLvqjqv9XWEccnmQXdGvPHVTez9zZ
         FxfhmwUloCdF58SRzGhb3Zm7KxwLsh+tAU3zR1C8ZgzDHqme//knfdkHyWHYvIXBXj9+
         HyVz3yL4inYXfIFHSJFKezFk9Ep10SXPRWeNmz+4jI3TWgGD9/EdfwtNZSGtWegTyUS5
         JrHp8kvQ3S1rRRRlJo0QJiLkvru+pL6nRJEX65UKsLMP1YzAA/P33YPszEB94vVDlutD
         Nn3cw1UA7nSHONd242Z7jWMbdG1GrFLz42c5YOCm3XUw3MD0iFs93NgieiWc6LsAN5pp
         lpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685067654; x=1687659654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRIhUR+oTuFzicj0A9tTt5U7sXcp4Ft2BenovbdFSYY=;
        b=RaO4hdUAFI3i2MQc3p4Xp3V2S4VjUWiUraI88u6plSB6jElXsSbg05zIabt62+oNGX
         /lIhcN2saOUMIi258pSAPOFTnyRISP86+Fn/mFQleSX8QLWr4s5IfyqrZRY9RhfLMaX/
         KbyIWZY+h9V2oUxld4i1s4bjUNPeIHreP+RRznVkuM6MKkb0EU8zV8fSWSIRjGDGrZvO
         RYKyHh2fVMe0ygk+szsEHnAmQZ+lrcBZjlyPwUtCYeJDOwfEoPJ8ggcumXvkFKG3Nq31
         NjLDwNCDihFrAzeND5Q+d8m2YXRaokGLV+aKluK6lMRoLP28O8t+mecigBuZ11Fax65+
         rXOQ==
X-Gm-Message-State: AC+VfDxLKOhA+IHVbOPOEnnqvU+/ihNgowuPkU6QRwBcPtuXwaR7Q0Cz
        S6tni7aR37hhJbeOz16lzUM3cMlpxlh+34v/4ArE+vFp9iURHF7S
X-Google-Smtp-Source: ACHHUZ7gD6R1Dpwrc8l71SCL6QbU1t4FAKHvtsRbaoaI3U1g7ZAl4FWTFj4R290tunMpRopUdlhg4l2IHUjyILRBFyQ=
X-Received: by 2002:a17:903:32ca:b0:1b0:1095:f4f6 with SMTP id
 i10-20020a17090332ca00b001b01095f4f6mr484109plr.24.1685067653787; Thu, 25 May
 2023 19:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230525040038.12346-1-qiang.zhang1211@gmail.com> <ZG_JuzyP_1FHIC6L@slm.duckdns.org>
In-Reply-To: <ZG_JuzyP_1FHIC6L@slm.duckdns.org>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Fri, 26 May 2023 10:20:42 +0800
Message-ID: <CALm+0cUrSbSDtx7aenDJiy1xzpEZvDM528rXMJ1Tbz7TdHq-+Q@mail.gmail.com>
Subject: Re: [PATCH v2] workqueue: Do not set CPU_INTENSIVE worker flags with wq_cpu_intensive_thresh_us=0
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hello,
>
> I rewrote the patch description and separated it out into a separate if
> statement for readability. Applied to wq/for-6.5.
>
> Thanks.
>
> From 18c8ae813156a6855f026de80fffb91e1a28ab3d Mon Sep 17 00:00:00 2001
> From: Zqiang <qiang.zhang1211@gmail.com>
> Date: Thu, 25 May 2023 12:00:38 +0800
> Subject: [PATCH] workqueue: Disable per-cpu CPU hog detection when
>  wq_cpu_intensive_thresh_us is 0
>
> If workqueue.cpu_intensive_thresh_us is set to 0, the detection mechanism
> for CPU-hogging per-cpu work item will keep triggering spuriously:
>
>   workqueue: process_srcu hogged CPU for >0us 4 times, consider switching to WQ_UNBOUND
>   workqueue: gc_worker hogged CPU for >0us 4 times, consider switching to WQ_UNBOUND
>   workqueue: gc_worker hogged CPU for >0us 8 times, consider switching to WQ_UNBOUND
>   workqueue: wait_rcu_exp_gp hogged CPU for >0us 4 times, consider switching to WQ_UNBOUND
>   workqueue: kfree_rcu_monitor hogged CPU for >0us 4 times, consider switching to WQ_UNBOUND
>   workqueue: kfree_rcu_monitor hogged CPU for >0us 8 times, consider switching to WQ_UNBOUND
>   workqueue: reg_todo hogged CPU for >0us 4 times, consider switching to WQ_UNBOUND
>
> This commit therefore disables the CPU-hog detection mechanism when
> workqueue.cpu_intensive_thresh_us is set to 0.
>
> tj: Patch description updated and the condition check on
>     cpu_intensive_thresh_us separated into a separate if statement for
>     readability.
>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>
> Can you please use your full name as in "FIRST_NAME LAST_NAME <EMAIL>" when
> signing-off patches in the future?
>

Because there are many people with the same name as me, so I use the
abbreviation of the name to distinguish,
but in the future I will use the full name  :) .

Thanks
Zqiang

>
> Thanks.
>
> --
> tejun
