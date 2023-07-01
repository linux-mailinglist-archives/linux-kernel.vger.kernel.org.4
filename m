Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E90E744A5D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 17:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjGAPvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 11:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGAPvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 11:51:50 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707CA2683
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 08:51:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso4735120e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 08:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688226707; x=1690818707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7bnv2dUq8TcNFZhlGLeiiAGB3YUTNN/I5HHQH6Qnrpo=;
        b=Umdk+2TtzoCcA1fHuw0nOne6Efh0y1OZP9aKvJC+WM0mSuDRkhmEsfyhBQn1m0K7Ae
         2wM/34lsZJF+dN8qiryLOiBMKVVHlxHyEqoCDwgq7o9ms4y9Ci9sZXfzm2N++vsLqHW1
         GBI41wQB/uB9/IJI5TEmXShxVcrnWRWxQZfj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688226707; x=1690818707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bnv2dUq8TcNFZhlGLeiiAGB3YUTNN/I5HHQH6Qnrpo=;
        b=d6N4VODLEFZQu2IGqh+rXfMTy0uf8QKFV2yqYQfqgOFq7sC7oFklgOt+r+tu68puQn
         StNzCvO8ZrhbDSSYm+oKriVyoP6lOv5hLQTqRJZ9rnsT+6UNJllhb1sRK5Z4TMAZFbSu
         Tv4wCMNrvO7TKnQtd20SC01AfoyZGooAgsXOBT6CwYO77P5FpqR5fpvvmWy7QyXNsn01
         HplH3Gpef1HmM91ZP3FhOk5HnRUGuywaPg44tCjRaS4ygciBOx+LEeqzwXUOPU3s9YYU
         nLGSm4GnxFAiBU9U04qmJHT8Nc28x1duLFCT19aKg4IxdWHnkL+TWmx9pOvPILff+HJw
         hSvQ==
X-Gm-Message-State: ABy/qLYVYVZzCKz7NCAucv7TOTs+1q+YMGKz1IXkAYfh1iguMqVtrzGG
        1MZiwFCP1OwHdFTBR6bAnidTJLTb32pZVnSaeBADBcDx
X-Google-Smtp-Source: APBJJlGADRNMd30sAaMp40RZDOb0LPgO0uE5MGlkk5gFpLOw6KsNBEU2swwQ1oNMgtraEx07lLhJxg==
X-Received: by 2002:a05:6512:6c8:b0:4fb:9712:a717 with SMTP id u8-20020a05651206c800b004fb9712a717mr4681674lff.13.1688226707634;
        Sat, 01 Jul 2023 08:51:47 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id c14-20020ac2530e000000b004fb12e0c3eesm3102398lfh.193.2023.07.01.08.51.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 08:51:47 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso4735091e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 08:51:46 -0700 (PDT)
X-Received: by 2002:a05:6512:3b9c:b0:4ec:9ef9:e3d with SMTP id
 g28-20020a0565123b9c00b004ec9ef90e3dmr5355258lfv.26.1688226706024; Sat, 01
 Jul 2023 08:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <b40d43f78d320324c7a65ec0f3162524a4781c4c.camel@intel.com>
In-Reply-To: <b40d43f78d320324c7a65ec0f3162524a4781c4c.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Jul 2023 08:51:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqW4JnbnFQ9BnTsw08WG=MrtyD_bY=4vy66KNSAUnYQA@mail.gmail.com>
Message-ID: <CAHk-=wjqW4JnbnFQ9BnTsw08WG=MrtyD_bY=4vy66KNSAUnYQA@mail.gmail.com>
Subject: Re: [GIT PULL] NVDIMM and DAX for 6.5
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, 30 Jun 2023 at 12:17, Verma, Vishal L <vishal.l.verma@intel.com> wrote:
>
> On an operational note, as Dan handed off the branch to me for this cycle, we
> missed that the original few commits were inadvertently made on top of a few
> CXL commits that went in in the 6.4-rc cycle via the CXL tree.
>
> git-request-pull included these, and hence they appear in the shortlog and
> diffstat below, but the actual merge correctly identifies and skips over them.
> I kept it as it is to preserve the linux-next soak time, but if I should have
> done it differently, please let me know.

No, this was the right thing to do. Apart from a slightly odd choice
of base for this all, the pull looks perfectly normal.

Thanks,
                Linus
