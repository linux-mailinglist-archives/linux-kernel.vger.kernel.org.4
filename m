Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0575364C16D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 01:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbiLNAjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 19:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbiLNAij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 19:38:39 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3139427CCF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:35:52 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id pp21so10751619qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QTBmSP3I5DWqFPRsGcvXv3WlDrmw/mYVKxKayaNh9SY=;
        b=cCY2Qcv6CiPfbCGGAMXrmjZqvTX59I3xAH/CaiKc7TLqg4WVDIjOu7f5veS8c6A7Gt
         cBR3xs76/UQXi4KnK/Yu731ui7a148/DlLWLbufeGVRC+1Tmo1tMSLThWRzfFFBDuMIa
         21me6uilNvW3Fzh2ZgI2bEiLPSLSXD+CmaSX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QTBmSP3I5DWqFPRsGcvXv3WlDrmw/mYVKxKayaNh9SY=;
        b=a5rAuivO6mQPiBy62HrW0hsUvVqlcDj/u8B6aBrZmwJy/A9iH2062/Q3L24W8ssoUD
         GukfXbTzVkg6ZLcyzoeEjkUPcRbbFy8DeXVWIc1bEEMF8ug3C8YKuREzTA6wyjkmLCDs
         ZwyriF9IVZVga5LvdmzHj0oC/LmbeFNewpUyDQ5O6skegwyCawB/gEM9p6fzc7Bj4Rg/
         8NRH7UKbOd8okjsaT7PKI1apPduUt3/J8PQPOewFDAwwluEHlGof0AnC1TwhJBBVQwDg
         4ZMESC1YjIu6fn38PS+qb+eQXhl+/ooi7lG5cqcSWl4SvPYdxoWQaakG7T/dW/6+UcJp
         ieEQ==
X-Gm-Message-State: ANoB5pk5HTrtEc/GQ1/dhW0gq9Bc83K5lyQdPKFqv2D/VOzAs1iFWENR
        DAB8fDuaGixkxyWRUK9aEPk/FG7ft0yeeJYA
X-Google-Smtp-Source: AA0mqf7g/E50PpepB/Xfjg2XtrcWMv8UmZbVW7LhoFItWIoKklrVzGvnT3/2liH1smlx2clbiNUq2w==
X-Received: by 2002:a0c:fac8:0:b0:4c7:49b:f6da with SMTP id p8-20020a0cfac8000000b004c7049bf6damr26192206qvo.1.1670978147249;
        Tue, 13 Dec 2022 16:35:47 -0800 (PST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id y17-20020a05620a25d100b006ce9e880c6fsm9004028qko.111.2022.12.13.16.35.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 16:35:46 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id h10so11542636qvq.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 16:35:46 -0800 (PST)
X-Received: by 2002:a05:6214:390c:b0:4c7:7282:5817 with SMTP id
 nh12-20020a056214390c00b004c772825817mr14594032qvb.94.1670978145846; Tue, 13
 Dec 2022 16:35:45 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Dec 2022 16:35:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgDEq2LYW6rnfQXmEOSfF8ECPkuwjJ3CR7aC4N2zuRLWQ@mail.gmail.com>
Message-ID: <CAHk-=wgDEq2LYW6rnfQXmEOSfF8ECPkuwjJ3CR7aC4N2zuRLWQ@mail.gmail.com>
Subject: thermal throttling on xps13: unchecked MSR access error
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.

I don't think I've seen this before on my trusty old x86 laptop (XPS
13 9380 - it's a few years old)

    unchecked MSR access error: WRMSR to 0x1b1
      (tried to write 0x0000000004000aa8)
      at rIP: 0xffffffff8b8559fe (throttle_active_work+0xbe/0x1b0)

I'm blaming one of

  930d06bf071a ("thermal: intel: Protect clearing of thermal status bits")
  6fe1e64b6026 ("thermal: intel: Prevent accidental clearing of HFI status")

with no real reason apart from being the last commit to touch that
function, but also when it started happening.

The first kernel I see this for is 6.1.0-03225-g764822972d64, but
honestly, it's possible that it has happened before too, and the real
issue is that the machine just happened to be hot and throttling at
bootup and/or I just didn't notice.

The CPU in this thing is a

  Intel(R) Core(TM) i7-8565U CPU @ 1.80GHz

which hopefully makes somebody go "Ahh, yes, I missed that case".

I don't *think* the MSR access checking has changed, but maybe it did,
and I'm barking up the wrong tree.

Anybody?

                 Linus
