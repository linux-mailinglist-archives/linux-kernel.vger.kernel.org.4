Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C7D645046
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 01:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiLGAWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 19:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLGAWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 19:22:12 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5310C4C27D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 16:22:10 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k7so15543232pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 16:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z7lC7jlSvTqXo19/2/T5KkOA5f3nGD9WS088sLB+XjE=;
        b=UXS4sbGRHT2e9Ver1b4tiyqfrLxdn6Ag3POCRrJqT382zI7se7rl4hJrM2DsFIkoXV
         yxD0v+yf6FMQ2H/3YaDW1xsoNQ7hnsIBvLVMBX5If6Lrsk4OXCIqFHO7ZrmbXcd005Ip
         jhfM/qhJ+Tlx44J7oBWSmkXyPFf5FpmnYnMgyB+0AAN4F7z8LSGLhAIc2akKouqF2927
         IFP9v43gNWgaKgQgx+NcpaU4xpVzx3G/FuO9ZHyddwtnjBRI438gilUsgvzPX2NeZnm/
         A/NdJNSt4qBU3x32XILuU5yDrA9j6ksOTf1bFDxZaYcHYQ5S76Bvx0zWkYrfnmwrOqH8
         sIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7lC7jlSvTqXo19/2/T5KkOA5f3nGD9WS088sLB+XjE=;
        b=Fug9On805Oc6W5gUNzg3QvqGk/ErlgwcveRgWyjZK87Po44449X5vESgc30Sb97e5M
         xxiojX8ECxdJVp7uG427TsNgTwaAp4rlJWtmMvH5wyxAwlHZR58yOAW2txv83NNSmyA5
         0suoig+qGm6jVBFju1btxYTBp+RkuVDzu42sUQoP6c24/f7DFolcrcMUMmOOoJfpDd5O
         B1+YO0TCC7zeapA0/1dDHaqbRinoK+8Pld1reaa/qJMQzjXi25UipQUebWHrBEuSoDWD
         i9VgPro16Wy5jjg/gtXZccJSQAOoNmqJSl27bOdEIupK7lYKHe3L8ZiOWlsjXjwL+VHD
         ToNg==
X-Gm-Message-State: ANoB5ple7PFQOPVbciZPQFohFbiK3vIyb+YRMjpne0IRTCZOoEIWlIZS
        MViebQJGLSEGSipMCPDjjDYaP6sA5MI=
X-Google-Smtp-Source: AA0mqf6z2NFqTV4MCD+CBVSzYVkEfy1O6XiPtDBoUQ0qnPog5yxgEMm9VDGL/OH52IwW/TwcKJ0ygA==
X-Received: by 2002:a17:90a:5d08:b0:218:770c:9a40 with SMTP id s8-20020a17090a5d0800b00218770c9a40mr80245124pji.158.1670372529672;
        Tue, 06 Dec 2022 16:22:09 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id i92-20020a17090a3de500b00218ec4ff0d4sm13369459pjc.6.2022.12.06.16.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 16:22:09 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 0/3] Convert deactivate_page() to deactivate_folio()
Date:   Tue,  6 Dec 2022 16:21:55 -0800
Message-Id: <20221207002158.418789-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deactivate_page() has already been converted to use folios. This patch
series modifies the callers of deactivate_page() to use folios as well
so that deactivate_page() can take in a folio instead.

Vishal Moola (Oracle) (3):
  madvise: Convert madvise_cold_or_pageout_pte_range() to use folios
  damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
  swap: Convert deactivate_page() to deactivate_folio()

 include/linux/swap.h |  2 +-
 mm/damon/paddr.c     | 11 ++++--
 mm/madvise.c         | 88 ++++++++++++++++++++++----------------------
 mm/swap.c            | 14 +++----
 4 files changed, 59 insertions(+), 56 deletions(-)

-- 
2.38.1

