Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBD564E590
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLPBOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLPBOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:14:36 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0767F5E08B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:14:32 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id w15so1092304wrl.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=33Hk0dgaad6fpmn1JNRHR9mJrfLP11GuwZMZDZQY18Y=;
        b=XtNQYTlJD+8q8Tsv4dXnzG/MP17FAQhgkkz8Y42JNl7usGB7GITBaHJk1XsVKDCs1O
         iQWuDhSo1thuzpb29MFfvefC0a8MD6u+TX40adg1XUw1xk62cya2jrnDP0OZHRvSXzsL
         DAwVuoftVLsu29MkY6k9K76kl6ZEAQI+KMzf/HvfK8KtoXvm2l4cq04rTif4liWrUanZ
         1yfZjIkEzqiTU4oBHSbhjVb9v27Z7hv5yRXsIluFxwCAJbkpJuCz3c9SQPIlhLG3biFd
         ptc2Aavg3iC2GHbswPh+rEdlTyy1yqJBXGqxfbDNd4nR8EtYrxeWSlXw8mVdfNUes5qz
         JaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33Hk0dgaad6fpmn1JNRHR9mJrfLP11GuwZMZDZQY18Y=;
        b=JzjvOEYwgXl918MsJnaio0sb8Lbqm4T12MODaObCr82vrmUqEONGX+JitvAzThV5Ev
         ddsmV8wRRPyIUtaxXVaWK+jO1ARP4AUUyN6vja0IJAZoEh99fOgyAXKlUDP3mltHfNhY
         Y2Ao9PDXBb1qdglY90Nui3yoXctMbTiL+n9oVJccG4JoJmFLlwx//UwM91jdjDJcPoIR
         M3aoBCupTUkYHFEP+tLXI5mIOCSC0Pz8dqWOp0zQh+5Gu855q29cESPF2GGsj1vmK/cT
         Hp5HNCcF44FsRMxfLHWs68TgY7CRWLcyukQztb2RrUQTtIL1d4DfWgDIELNEH7kiQIGG
         Viow==
X-Gm-Message-State: ANoB5pkL44uAJWWQJcY07IyGx6tcYzUD09NiBQfav6BtSY/qKPCq8Qkr
        X2i2AvjUgI5rkspcVjAi35xiep1+Xp4VtUej5CU=
X-Google-Smtp-Source: AA0mqf5DN7MhGHMLZBYxEoVsrLNeYaUlMsEhTH3t7dGeD40FdYr7MGKkoDr7bT22JBUJaZSbY1uTkVtQarvpREk1qBA=
X-Received: by 2002:a5d:6751:0:b0:242:122c:6672 with SMTP id
 l17-20020a5d6751000000b00242122c6672mr32583834wrw.330.1671153270478; Thu, 15
 Dec 2022 17:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20221213043936.6345-1-richard.xnu.clark@gmail.com> <CAJhGHyA--bPT9ya+mFzZ7h4yUfTXFJ5-BFdynGFC61A-4gdLWg@mail.gmail.com>
In-Reply-To: <CAJhGHyA--bPT9ya+mFzZ7h4yUfTXFJ5-BFdynGFC61A-4gdLWg@mail.gmail.com>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Fri, 16 Dec 2022 09:14:19 +0800
Message-ID: <CAJNi4rMEtTe+qB3eSprzXRFDfa+oPXURDnws2659LUWxnhpn3w@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Add a new flag to spot the potential UAF error
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello TJ,

On Wed, Dec 14, 2022 at 3:16 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> On Tue, Dec 13, 2022 at 12:40 PM Richard Clark
> <richard.xnu.clark@gmail.com> wrote:
> >
> > Currently if the user queues a new work item unintentionally
> > into a wq after the destroy_workqueue(wq), the work still can
> > be queued and scheduled without any noticeable kernel message
> > before the end of a RCU grace period.
> >
> > As a debug-aid facility, this commit adds a new flag
> > __WQ_DESTROYING to spot that issue by triggering a kernel WARN
> > message.
> >
> > Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
>
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

What do I need to do for this patch next?

Thanks
