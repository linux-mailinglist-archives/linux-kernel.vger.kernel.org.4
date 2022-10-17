Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9591601150
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiJQOlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiJQOlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:41:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F00A50184
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:41:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b2so25452095eja.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xsxaicTDlIagIqu6bJeoJSkHH1vSoDWoRrDEv5qAt/k=;
        b=PXGk1RSfUVoWkwBAodqyPkaLmLevIMz9ngvbTVhnnoMhW4dobMdeoNfE+gOOg1L97i
         lm003B2Myr2/bpeXwOy1qtVfNO81w2c1DPL7KdEKGOrsGffhPwOCX1gBgYnup0bABfAk
         GT4OsQCZp1iyhWJgl1zo4k1YzB+dxab1hQ0Ew+dUSxwA2w/krxy8S1gbtJ1jBE2ku9dh
         OlyffLZYB6s/Nw+pq5ybjLnW4zyJ6TeT9GXqUEVtaSdfRwIagd66I2HA8vx8XFrkIpNS
         9ymKDHfFqY+vMH1xZlHixT3VaXgrpQDk1clkpS2w+mdjb5Dcc8Sz8lcdplIRj8+Q6SlZ
         U5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsxaicTDlIagIqu6bJeoJSkHH1vSoDWoRrDEv5qAt/k=;
        b=V5QBLAsTdaueSGtlJxT+Qac4TLXdxKAFENP5OKfWBfn730wTewKjGzHzOmbDBJrZwR
         rVKBROc6yLvyOPAYDU/bvpyNv5f4YSVJPM5BlXHyWXgJYu+o8X3OqaEXq0DC0wLDUaX5
         E4A+pHjAMaTW/Br33CAdlMXHuU0O4Jy+5FlvtJdJegA8FpsIBSLdd4YrTmQhexfOo24r
         LVm2/WKAywWIV8xNs/WiVNqPgw9FAI2AwW+oims9+Y83W5HninyIL5c5FnnZmwCCfA3s
         3xHRKJDv7Zkjm4fCjC6fjZkRfDmM2TUTqJjKIdLyF0FljrUi0weVEtoZkB4jI4MlTFdi
         T7Vg==
X-Gm-Message-State: ACrzQf26cQMxFtWPzwZwRITK5IGbtipefLaZR8QoZMJz88FpbYCvaGXi
        dI0ic8J/pOh6gOoo2ZF7knsT7vau/90+6Q==
X-Google-Smtp-Source: AMsMyM6lXVWDT+zr6Cwo2116+HfaS1B1Oc/6zhRNGMl1BmNKpIIS8w8eMdB0Zl0cVPfou72KvRDmrg==
X-Received: by 2002:a17:907:724d:b0:78d:acf4:4c57 with SMTP id ds13-20020a170907724d00b0078dacf44c57mr8937248ejc.516.1666017671592;
        Mon, 17 Oct 2022 07:41:11 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id dn2-20020a05640222e200b00459cf672a65sm7469144edb.71.2022.10.17.07.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 07:41:11 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH RESEND 0/2] ucount: Fix and improve atomic_long_inc_below
Date:   Mon, 17 Oct 2022 16:40:47 +0200
Message-Id: <20221017144049.3404-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.3
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

The series fixes wrong argument type and improves atomic_long_inc_below
by using atomic_long_try_cmpxchg instead of atomic_long_cmpxchg.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>

Uros Bizjak (2):
  ucount: Fix atomic_long_inc_below argument type
  ucount: Use atomic_long_try_cmpxchg in atomic_long_inc_below

 kernel/ucount.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

-- 
2.37.3

