Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756EF743366
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 06:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjF3EKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 00:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF3EKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 00:10:38 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41041199C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 21:10:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so173517966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 21:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688098235; x=1690690235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YlumTE1/VZOp3prH/yZnB1tVVLT1aI0qSCA6eRI/6cc=;
        b=hg1yZ14twzSQrztVFPq1eX2eJT3Alhc1s7tgEVXCURfK4hCTUEPifp0fbSPLdlSzFd
         Sk6e5IpSdExKVq05Qy/r7g1cvWrEgWka6CxzwfdHM+HEa8FEKb+RwLto/Eo8uHmmhORw
         qvzXf2CjF7U2aFZK/LWwNTjNvBOCQaBFprZjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688098235; x=1690690235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlumTE1/VZOp3prH/yZnB1tVVLT1aI0qSCA6eRI/6cc=;
        b=lD7HWjnSLd5pQ+S1xnhh4VTC4N63PpqY/vHOiyK9K2RgxZ18KAIDccwnKuGGY6/GOe
         0OUv0x7AZ0HZibqEm+YymstoiGSzRfqjpb6EqdsBKx7KSfMUWGuH6LD7Y7EukQE4HXYT
         pBYcK+DiQeqMFfAmRPdCO+vXxSzP4ME4mdFcOHH2M4kBEFaE6+UazzUqkwDld7ZE+Me5
         tC5w8G3j61IuXhc423Y03Dthk252Ip19neZLKG6mTeQG2lO8/ME8FktOM7NzroCjoERn
         JN9X9ISALG5LzbYUhcSaFVRXHCaM+ZtVOU6bOTyo8WfeEcy/S62j/8MemF8NzRLcY7ik
         luGw==
X-Gm-Message-State: ABy/qLbHNFCdJMziZv+VYuE6MkregGXhChRDi9WoUH2zA64PXgqGVCsc
        UBde20bDha2tt0H2TfFTeIyHAK0Ya1DKQ7JmMKsKf+Lp
X-Google-Smtp-Source: APBJJlFfOQ6hHfBy8ezFcx4Gns0RQsqp9s1YlzyNOYh05A+OLmm50n1Cji5kBE3TQuUN3lO92oNq7w==
X-Received: by 2002:a17:906:4e41:b0:992:5cda:69ee with SMTP id g1-20020a1709064e4100b009925cda69eemr904628ejw.55.1688098235478;
        Thu, 29 Jun 2023 21:10:35 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906948e00b0098d2f703408sm7515618ejx.118.2023.06.29.21.10.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 21:10:34 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51d7f4c1cfeso1508345a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 21:10:34 -0700 (PDT)
X-Received: by 2002:aa7:c703:0:b0:51b:e4b4:8bb0 with SMTP id
 i3-20020aa7c703000000b0051be4b48bb0mr755246edq.2.1688098234320; Thu, 29 Jun
 2023 21:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <ZJzUeFT7lLqEjMJn@nvidia.com>
In-Reply-To: <ZJzUeFT7lLqEjMJn@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 21:10:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjiSW52tf=xaBe0LrFJrRbSnA=E1ziKBEioMT9cMJPM1A@mail.gmail.com>
Message-ID: <CAHk-=wjiSW52tf=xaBe0LrFJrRbSnA=E1ziKBEioMT9cMJPM1A@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2023 at 17:46, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> Here are the changes for RDMA for this cycle, there was a small rxe
> conflict with v6.4 that I resolved in the usual way.

Please just don't. I'd rather know about the conflicts. See

   Documentation/maintainer/rebasing-and-merging.rst

and about gazillion emails on the issue.

> - Lots of small cleanups and rework in bnxt_re
>    * Use the common mmap functions
>    * Support disassociation
>    * Improve FW command flow
>
> - bnxt_re support for "low latency push", this allows a packet

This allows a packet WHAT?

On a positive note, I see that you have a blue checkmark by google
now, and Google says

  "The sender of this email has verified that
    they own nvidia.com and the logo in the
    profile image. Learn more"

which is lovely. I expect great things from nvidia now that you
apparently own it. Congratulations! Champagne all around!

             Linus
