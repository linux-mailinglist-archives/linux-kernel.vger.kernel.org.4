Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB01D651E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiLTKBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiLTKAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:00:30 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8718B19C37;
        Tue, 20 Dec 2022 01:59:01 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 65so8139199pfx.9;
        Tue, 20 Dec 2022 01:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYftegrjnbG/VU3UFqiyjq5V9j2Bx95Lz3jEGGkLoZU=;
        b=Uufd6H1NzY5FClKuvL1wbR2dlllO3/Hap7GRxjHpYu4vxElqQ8pwjs7MkaDjK2knU2
         1gU3+nQc8RDYYtXeOzrgTfWf4BOcpo9mcl7uVqsIVJ/JTNRtWLrtp3L3GH4yAgIzKDL8
         p9lXf5+GLXsaZVBXjYMDdrbjVCSaUuc1JUFnP1RZdxh6pF2D4i3Bm0AtGhAJDFIEYbVJ
         S+y/Zw1z198BWIf/Oe1OADbH2sdIR1ps8PDklENscAXkfCyg5HwuPiZON0AWUvomCFVR
         s6R/nsPuls3pcrpcCcYpHAm1AzDq6xkkLU4m8qcmUpf0EIbpD0sNYemU4ogR7F2wLiLk
         ICFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYftegrjnbG/VU3UFqiyjq5V9j2Bx95Lz3jEGGkLoZU=;
        b=N8P2gG4tY7BOuNIunpnJqHa4HK+1eg4q531Sc8f8PTaXxPUTxBcNwn1BnoaOhkDKVq
         DGZHdUSRHqNzzefmcfxw88Suo9QsdhnqCE9LA2zRoVqRTMkAFNtqiM2ZBNcuQ5xKC9JZ
         RpxOD0iAaqBkeTQfIiDaRu7oPsiOGL7VBwIY5jR2Sq6jZA2I9UWwq2Xojpmlt3ZqgcVL
         zJvR19zy4K/OL/63fjYWhgLhFAFvjff3UR/TJybwWfce4MBij+xZHy0pUXe1NiHbeYdj
         7NrMQtpQXb+RKIX+Mp/i3oY1p88A2OGPtdqEGkNgXfI+mUr9/3I4ELg3fb44Wt7+Ossb
         JJkA==
X-Gm-Message-State: ANoB5pnjARf9VZf+m2sWK03X03PHi45MNBgcOwRoiIdtZpkttYI0Drtz
        IgbChW8kYCOYWKCKlBSHc6M=
X-Google-Smtp-Source: AA0mqf7SohwAAhmDbDdU6VLaSHp38PHzthvuIZgUOmej4ceiRCtd3KVORGSjsWIoFKdepibxVJevfw==
X-Received: by 2002:aa7:90c5:0:b0:572:6e9b:9f9e with SMTP id k5-20020aa790c5000000b005726e9b9f9emr43464029pfk.19.1671530340719;
        Tue, 20 Dec 2022 01:59:00 -0800 (PST)
Received: from debian.me (subs09a-223-255-225-69.three.co.id. [223.255.225.69])
        by smtp.gmail.com with ESMTPSA id w197-20020a6282ce000000b00576b603a913sm8204734pfd.0.2022.12.20.01.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 01:59:00 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id DDF8D103EDE; Tue, 20 Dec 2022 16:58:56 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     virtualization@lists.linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Cornelia Huck <cohuck@redhat.com>, kernel@collabora.com,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 3/3] docs: driver-api: virtio: commentize spec version checking
Date:   Tue, 20 Dec 2022 16:58:29 +0700
Message-Id: <20221220095828.27588-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221220095828.27588-1-bagasdotme@gmail.com>
References: <20221220095828.27588-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=992; i=bagasdotme@gmail.com; h=from:subject; bh=Du5qpH89jZYd1hu95ba3Y7Jdcf0bpirpe4LI3ZgJk6U=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMkL213eSnyM6lmV+euAbOmmBNVZ7vVbK3W2lnRe9xc5FLDl n5VTRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACay8Cojwz37c/bPPgb2tvCdmnkkeV tj44XtLrpynCUTmBt3+6nIJjL8d/qZ9leRp+HHoqcHj9etZ/95YU7RJY0doXFOGif5X+5gZwIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A sentence that checks for later spec version is meant for developers
hacking the documentation source. Make it comment block (hidden from
actual output).

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/virtio/virtio.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/virtio/virtio.rst b/Documentation/driver-api/virtio/virtio.rst
index 88e2a9bcd8b3f7..7947b4ca690efd 100644
--- a/Documentation/driver-api/virtio/virtio.rst
+++ b/Documentation/driver-api/virtio/virtio.rst
@@ -135,7 +135,7 @@ References
 _`[1]` Virtio Spec v1.2:
 https://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html
 
-Check for later versions of the spec as well.
+.. Check for later versions of the spec as well.
 
 _`[2]` Virtqueues and virtio ring: How the data travels
 https://www.redhat.com/en/blog/virtqueues-and-virtio-ring-how-data-travels
-- 
An old man doll... just what I always wanted! - Clara

