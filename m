Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F045F65D7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJFMWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFMWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4642A9C23F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665058932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x/UtysfkCuzrgaeKGLYY50FbPjsMgpmsjeWMnapVU2o=;
        b=Ee1clCqEDxwZIWIWSAOfaQs1H21tXJuU+seT312eOG7qCkyv07nXHIWCupblvJJtvNhUzb
        hWGCpRIHSf2GmOZhJWvBjmmrIn2oTjX6LmRJ6J7YR6+KhkNTuhMytqIQKfBzSYXbjE17pU
        7kPpt8i0PEwzdPCkEc4h/LIBxvHFzLk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-187-JxPks-vGNLCILPaRdVzMhg-1; Thu, 06 Oct 2022 08:22:11 -0400
X-MC-Unique: JxPks-vGNLCILPaRdVzMhg-1
Received: by mail-wm1-f69.google.com with SMTP id 133-20020a1c028b000000b003bd776ce0f3so2537448wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 05:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/UtysfkCuzrgaeKGLYY50FbPjsMgpmsjeWMnapVU2o=;
        b=cCjyGtua3VH1KwP8Lig7DG/tHyyR932IBfIEyrzrLxKlDK92NRv0mDdVto7z02OcPi
         g4zynQtqY2FSl0lGfYr9jo9o9cbZ2sB5Gq6aQnt+Ay7uryftM6hIEm66JnK7Sozcg89I
         auB6XRgaqbTtUe1UdHQKnVJEL+ElRboSDz1XM2hnQXRKphMuz+1KmQtBhFRrqB0wb7Ec
         iDV2E+Fiqu0lgtdz9JeRZSRvlDuwTH6ufuHH1BQ3kPi+ripdD4MlwJJYQH8k+9kjPCKc
         EE+Nx5w7rZcKWZyP3rp4t9ChTxTOK88QhsavvyV3uJQKEZ72vuZgELWfoS79C/6h41gA
         P2eQ==
X-Gm-Message-State: ACrzQf1Q+1eUPqMHMR690BZshU8/sbDmlLTRzAVMzP8ncIZi4Z8jWBoN
        dqIXUbcYFAl9uVJRKS50B5JkdVwnL1eZl+PEznt42HcHvGNwMo7zUXSXxRFmN7iaaIpszDWrPfb
        XanhGZgrSQyjkJcD7WuLUfAiP
X-Received: by 2002:adf:fad0:0:b0:22e:4998:fd5d with SMTP id a16-20020adffad0000000b0022e4998fd5dmr2944436wrs.267.1665058930416;
        Thu, 06 Oct 2022 05:22:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4ostctxgUrwy0VS1dKaIuIw1DmSeOPVJhENSLFGHA06L5k0dOWjKEbI8XvwfNKgINr50wTyw==
X-Received: by 2002:adf:fad0:0:b0:22e:4998:fd5d with SMTP id a16-20020adffad0000000b0022e4998fd5dmr2944420wrs.267.1665058930230;
        Thu, 06 Oct 2022 05:22:10 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003bdd2add8fcsm5004841wmq.24.2022.10.06.05.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:22:09 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH bitmap-for-next 0/4] lib/cpumask, blk_mq: Fix blk_mq_hctx_next_cpu() vs cpumask_check()
Date:   Thu,  6 Oct 2022 13:21:08 +0100
Message-Id: <20221006122112.663119-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've split this from [1] given I don't have any updates to the other patches,
and this can live separately from them.

I figured I'd follow what Yury has done and condense the logic of
cpumask_next_wrap() into a macro, however cpumask_next_wrap() has a UP variant
which makes this a bit more annoying.

I've tried giving the UP variant its own macro in cpumask.c and declaring
it there, but that means making cpumask.c compile under !CONFIG_SMP (again),
which means doing the same for all of the cpumask.c functions that have UP
variants (cpumask_local_spread(), cpumask_any_*distribute()...).

Before going too deep in what might be a stupid idea, I thought I'd stop there,
send what I have, and check what folks if that sounds sane.

If it does, I see two ways of handling the UP stubs:
o Get rid of the UP optimizations and use the same code as SMP
o Move *all* definitions of the UP optimizations into cpumask.c with
  a different set of macros (e.g. a *_UP() variant).

[1]: http://lore.kernel.org/r/20221003153420.285896-1-vschneid@redhat.com
  
Cheers,
Valentin

Valentin Schneider (4):
  lib/cpumask: Generate cpumask_next_wrap() body with a macro
  lib/cpumask: Fix cpumask_check() warning in cpumask_next_wrap*()
  lib/cpumask: Introduce cpumask_next_and_wrap()
  blk_mq: Fix cpumask_check() warning in blk_mq_hctx_next_cpu()

 block/blk-mq.c          | 39 +++++++++------------------
 include/linux/cpumask.h | 22 +++++++++++++++
 lib/cpumask.c           | 60 ++++++++++++++++++++++++++++++-----------
 3 files changed, 79 insertions(+), 42 deletions(-)

--
2.31.1

