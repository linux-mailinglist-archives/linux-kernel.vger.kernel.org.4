Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A517C5B792F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiIMSLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiIMSLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:11:09 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B3D65561
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:18:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso11979132pjm.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=D9/CMhAnwY+iSxXO7mkpQUkem+9syIuYCz6PSBi314E=;
        b=PrUhFDsazpzObIPf13w3em4XMpw13EzTsTwDotwjA4G9uUwyRxSKT/DriUGSEAy+ZA
         60dG9/NpE0OjmsZBagZeXSZsl+w8GP76KhR1i8FE255XDDO4E9YONMWSCmtNclLPPDPp
         X1+vxIo7iD1opjC3IX4J9SrKg8tDPsZ7QfR7kCy14B/UdQBAiKvLv+WrE3HxWql1HBlU
         YakjZr1ouhdVADCFF1/8gvKsYEBLXARPkFBMNIak6p4C6ulk+Q/6bI5CNiYF/eXH6SKv
         iZZI6u0Js8RvZB6fFaph5AmcDuiy3MMNGADdUbh/5EbBpVqK6tTB3Y+7vJSCpquRKQv+
         hG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=D9/CMhAnwY+iSxXO7mkpQUkem+9syIuYCz6PSBi314E=;
        b=a1cHbJkGVV62UShOmZaTAr2bAEmy81jtOlMa2eyce/2B9g49F3JR5Ba1MHC+Z6yv5q
         kpetSpvAl7tk8Gv7tDAYxl4oo51g13XN9Vmnf+8S47FqitL5YDnYBs7GDb3zG749bXnT
         myh89XtN4CjvzftNYNbgj9NIALaDl5Qsvj7bFnVz2xNifJDKNHF2YO5B6tjarNw2OLlR
         xD/5v5Foo0Tq5E4h1WZg23/mPx+JUf9OuFIQ5vGib7ljBYFSSzSxeuOZDB4OWXqW2naK
         Ku4kJkIxjVatsgtxvWTCnawkoAFL2pEQhKfRrExiSlRtEBtVzcKxmoOTTz/q6Sg3YmgB
         oqIg==
X-Gm-Message-State: ACgBeo2lJRXCiQXxdKvkpfNHKbpI1G3qNKbe3EArG9Dg4Ydm1gPVviry
        qPhQ0qWiitychQ2MrZYec0o=
X-Google-Smtp-Source: AA6agR7LvukJBTHiGSlmNN6EGBGKlOkHAMsEVCHXC4+cx7lsKj/rB6rzJJn561MQga7Gy2i/aJaKwQ==
X-Received: by 2002:a17:902:e2d3:b0:176:e97a:d3eb with SMTP id l19-20020a170902e2d300b00176e97ad3ebmr31484970plc.172.1663089479694;
        Tue, 13 Sep 2022 10:17:59 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id z27-20020aa79e5b000000b0053e5b905843sm796474pfq.203.2022.09.13.10.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 10:17:59 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, Nadav Amit <namit@vmware.com>
Subject: [PATCH 0/3] vmw_balloon: misc fixes and enhancements
Date:   Tue, 13 Sep 2022 02:43:03 -0700
Message-Id: <20220913094306.317734-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Various relatively minor enhancements. Patches 1-2 address borderline
bugs. There have been no actual bug reports, and the first bug is
theoretical and the second one is a minor performance issue. We
therefore do not ask to backport them, but keep them first since we (or
distributions) might want to backport them later.

Patch 3 is doing some cleanup due to recent changes, with no expected
functional change.

Nadav Amit (3):
  vmw_balloon: access reset_required through READ/WRITE_ONCE
  vmw_balloon: exit if initalization fails
  vmw_balloon: open-code vmballoon_compaction_init()

 drivers/misc/vmw_balloon.c | 71 +++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 40 deletions(-)

-- 
2.25.1

