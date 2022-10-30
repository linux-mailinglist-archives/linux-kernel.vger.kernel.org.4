Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F42612D28
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 23:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJ3WCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 18:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ3WCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 18:02:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FB3BC31
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 15:02:08 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e129so9197369pgc.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 15:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YnvTZj3WRTCMiadIaA7JlEQv6UZB93c5sPotkpBOzqA=;
        b=yCQ2f0eDEP4pwEYWwAnTPPDwfcca+KMMARxIMKKecHn//G8uf+5LinlpxM8xgFLmDq
         VcjRzOTs98rg5Bg/3ZIVYDdkSFgXcgHsQi6m4GzKImAMbLprSh5ACoFrCuoR4Uz+9uPL
         zAJZa+OVP1ooVpoKPTGoVwtrmDCTl9YVYiBMPKzMA+TetQ6Yy05es++HmQOPZY6U6ZGS
         lhDwVveCrPUAO11NHwb1iq4jbuu/7SsziXwVrLsTAM/tIh4ExfUT4mcU3UbK70tli3vg
         OTp2ulz19nCLA302l90iF3lbRloXXVYLhQlCB7FoF7PgzVPoWxVyOlfo/EmA51Jaq3n4
         vu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YnvTZj3WRTCMiadIaA7JlEQv6UZB93c5sPotkpBOzqA=;
        b=mKegV1lEgpA03xXn1FhISBL6HyIw/tNc8XIUC/YhYqo1ZnmQKFo6iabtmpvJ9QrdjB
         Y5fJF+dvB9KB8V/L4h+It6t2l1zCyJ0T4EHL2mmpf7AUGzuXPlHoYedYHrE7XsI8V73G
         quuWx+949gQNyN9TBIkzCGOt2MeBUc4qLHf653j7rllcjQ/B4BYzoiOVADSMmG/BOJP1
         xrNUPJ68oCJ5oAv97/GpdyiWdltHFvw2XrmH+GksBYxt5USpVHzNzMRaNnEbEkUVcEpq
         QqzJeomZtIIoL6yemutMz+/aU7mLAa5OdWKGN16K1lH99ha/yvTosy/sCLoAeyViLwLI
         h23w==
X-Gm-Message-State: ACrzQf1u5EzgJ38AEdYQD0gEOkO/RP/cXqA0n4nTTOt7wFOgBwc0mdGA
        pOaPV+FH1IGqw/xiDurx0qXhwRfJl3/E0MWY
X-Google-Smtp-Source: AMsMyM7/+jfrx8a/RMJDhIncUFZk1LYvVTMQuWScBj91iDM6EWoALXhOU7+2hCvPz83ZvCG5FcrhIQ==
X-Received: by 2002:a05:6a00:1a04:b0:52a:d4dc:5653 with SMTP id g4-20020a056a001a0400b0052ad4dc5653mr11257698pfv.69.1667167327782;
        Sun, 30 Oct 2022 15:02:07 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79e03000000b0056d73ef41fdsm562852pfq.75.2022.10.30.15.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 15:02:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCHSET v3 0/5] Add support for epoll min_wait
Date:   Sun, 30 Oct 2022 16:01:57 -0600
Message-Id: <20221030220203.31210-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

tldr - we saw a 6-7% CPU reduction with this patch. See patch 6 for
full numbers.

This adds support for EPOLL_CTL_MIN_WAIT, which allows setting a minimum
time that epoll_wait() should wait for events on a given epoll context.
Some justification and numbers are in patch 6, patches 1-5 are really
just prep patches or cleanups.

Sending this out to get some input on the API, basically. This is
obviously a per-context type of operation in this patchset, which isn't
necessarily ideal for any use case. Questions to be debated:

1) Would we want this to be available through epoll_wait() directly?
   That would allow this to be done on a per-epoll_wait() basis, rather
   than be tied to the specific context.

2) If the answer to #1 is yes, would we still want EPOLL_CTL_MIN_WAIT?

I think there are pros and cons to both, and perhaps the answer to both is
"yes". There are some benefits to doing this at epoll setup time, for
example - it nicely isolates it to that part rather than needing to be
done dynamically everytime epoll_wait() is called. This also helps the
application code, as it can turn off any busy'ness tracking based on if
the setup accepted EPOLL_CTL_MIN_WAIT or not.

Anyway, tossing this out there as it yielded quite good results in some
initial testing, we're running more of it. Sending out a v3 now since
someone reported that nonblock issue which is annoying. Hoping to get some
more discussion this time around, or at least some...

Also available here:

https://git.kernel.dk/cgit/linux-block/log/?h=epoll-min_ts

Since v2:
- Fix an issue with nonblock event checking (timeout given, 0/0 set)
- Add another prep patch, getting rid of passing in a known 'false'
  to ep_busy_loop()

-- 
Jens Axboe


