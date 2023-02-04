Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6A668A966
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 11:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjBDKRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 05:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjBDKRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:17:03 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8880D28211
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 02:17:01 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id bk15so21686031ejb.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 02:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQ59r0rotKFAuZhlDECOo7ijCQQ7bHkTI5v6Lahur6Q=;
        b=K21aNLW4STrtjUcxxtGcKDexYbtrAOVLdDkfx/LQrZIMWtzk9zQ9N/ZDdudXQ4PfQi
         9jpiVNZ5RR4ZJfiX8xmSvaRdb+N8ZNfa5MvrmbMm8WO4UVd7MjnkDsdOtDJJJpBtiadJ
         1lit9dHymNEWBfsP5ol47Ipk1T4OfoRaLgPVh23yYBcbaVvDMDS1FbZ1xpLeJWVdrQtp
         x4wPlDOr9DQ5qTk7lEcm0XOw6eBjLoFqo45megdD4d2tu4aGvaGKW8RNuwQHh6nbbLu2
         3K35V8dOhchMg8QzDXjiF0dwsMVRrLKWmw3mGKSTWG6VzsG9n15f8NIoA/PPwsHBv52w
         6hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQ59r0rotKFAuZhlDECOo7ijCQQ7bHkTI5v6Lahur6Q=;
        b=Ur20fw37WyTXjcJ9ij8Kj6AGJcQoRJJG5ruDFudiL+W261kquTDFWda3G+3h7S7W02
         sFQOyk1Vn93rIkrbTBhBIKxCdLks7S5Ak9XF+LWlgodos/HkJmF23vfPVcxTIc2GxOBh
         0jZ3w6hjYr/LMMXDva5HcyiMpXeaP0Py8x6ecXVmyUXBaRMagcCn5/AkoLPoLESZ2w3y
         ETW5mi5Hfo69n9hD0ywSDC1XcpHbG0/3gLWCwVVz40HEqdRPtVOTrRmZytr1eKRYiCad
         7zVXI3W+PFy/vEeGYMAct+AklLzsMWMxyiQJ4rRNaRjDHCGQWoftaAB76X5ny4FK3gpb
         1KxA==
X-Gm-Message-State: AO0yUKWiB+Pdzd2GWPNXUZB4M+s4tRi9/SKXgEscRHgzJ8XnbsiovGvS
        8XXHkTjlEjyIUMe4yBhXHzk=
X-Google-Smtp-Source: AK7set85HT+nNzxKeDL4gH6o+uOwgVuNKxD8+DKHD/QqkyLv5yOuTGdWkqdAYlnKupfqT4d0BEhp/A==
X-Received: by 2002:a17:906:230f:b0:88c:6345:d0e7 with SMTP id l15-20020a170906230f00b0088c6345d0e7mr13744319eja.36.1675505820177;
        Sat, 04 Feb 2023 02:17:00 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbf9.dynamic.kabel-deutschland.de. [95.90.187.249])
        by smtp.gmail.com with ESMTPSA id m19-20020a1709061ed300b0088ed7de4821sm2632378ejj.158.2023.02.04.02.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 02:16:59 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: correct error logic of two functions
Date:   Sat,  4 Feb 2023 11:16:52 +0100
Message-Id: <20230204101654.10232-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.1
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

This series converts two functions away from returning _SUCCESS and
_FAIL. Another tiny step to get rid of _FAIL / _SUCCESS someday.

Tested on x86_64 with Inter-Tech DMG 02.

Michael Straube (2):
  staging: r8188eu: correct error logic of rtl8188eu_init_recv_priv()
  staging: r8188eu: correct error logic of _rtw_init_recv_priv()

 drivers/staging/r8188eu/core/rtw_recv.c   | 30 +++++++++--------------
 drivers/staging/r8188eu/os_dep/os_intfs.c |  2 +-
 2 files changed, 12 insertions(+), 20 deletions(-)

-- 
2.39.1

