Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9DF651E47
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiLTKBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiLTKAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:00:24 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9757D193F1;
        Tue, 20 Dec 2022 01:58:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so11651002pjd.0;
        Tue, 20 Dec 2022 01:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7vem8Jsd1m3XoRwlR2Dh3rl9t2L0u4OTmfLYFZ+cgOk=;
        b=bBmsWw9d2KWdrS1o/4gOt9QagJxA6nM2Yci5vs+R1NPvyCLpMrfFbRXwyx+8qwIg5w
         hKRrDnTZMece6VuC/C1cb9MdsuPnh825qzfTIK1vI32ZOoTChHC07jsnvMA0mZf/NOsm
         E5nfhm6BRr9BzLgMI7p3Rm4BhEbZRhMwQ1UNtjoSnX8LazefLarHdvnNqBCaR/MdKT4v
         kwSUHrAsYb2NFJvSjChmrVenm6+64tSo1LgM8KUfcfnJPLGI/ju0L25Afs/Y5HIFlojK
         FLF9h0nhTgg0raFXmfRlavC793I7JWrKha1Uc4yxJZVpPNUVS7v+5G1JL9f89A/hGhqr
         h42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vem8Jsd1m3XoRwlR2Dh3rl9t2L0u4OTmfLYFZ+cgOk=;
        b=uRctw8+kskBbJvc4ICY+uZiF74d4IdRLkGVVY3tDGIr4iGPKmqX5YMefehWvtvanWV
         Z2IJZ9lD2+LdZdwFkk7ArI9yk0LsmFWYqvqacsP1w/hjUdgnogCICFruPGGO1kyGkFaR
         lBi0pXvQ/39Pwj17JwXzEIbhmMp290IrkhL63TAtkpPNOIs5rccm0jqVM5Lc2CfOSjnY
         pmK/dWNnuTTlF90gas34KeKFwUtCwi5Yhgx0H9oGNmywRWRSvO2b1oZ6HuhlmJ9ijooB
         9fdXLF2ATi9ezYS1MDmC9bvi0MzdTGaP6QLoOR5cdKirZ+8D1Cl5GMrWnYp9h+DgQVNX
         OUWg==
X-Gm-Message-State: ANoB5pktNpm7QDv3C7zBy/scpVcU41WGp1DYZibGemhz7XONAhIp8Z8D
        px2XSH9owk2jNwkPrmpGh4o=
X-Google-Smtp-Source: AA0mqf4hA27ExixBB4w9eaoE5WnWfsunugUo40uVoSJXl/UwM6YaB0dQqxCP1ieAwUO+4Iqc+nkzkw==
X-Received: by 2002:a17:90b:3591:b0:219:bf1a:7cbe with SMTP id mm17-20020a17090b359100b00219bf1a7cbemr47651789pjb.27.1671530336870;
        Tue, 20 Dec 2022 01:58:56 -0800 (PST)
Received: from debian.me (subs09a-223-255-225-69.three.co.id. [223.255.225.69])
        by smtp.gmail.com with ESMTPSA id ml19-20020a17090b361300b00219f8eb271fsm601247pjb.5.2022.12.20.01.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 01:58:56 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 8FC1B103E99; Tue, 20 Dec 2022 16:58:53 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     virtualization@lists.linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Cornelia Huck <cohuck@redhat.com>, kernel@collabora.com,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/3] docs: driver-api: virtio: documentation improv suggestion
Date:   Tue, 20 Dec 2022 16:58:26 +0700
Message-Id: <20221220095828.27588-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=bagasdotme@gmail.com; h=from:subject; bh=O5UrpaltPN9XdwGBv1ZKKRngtRO9auBkxrm/W23BACY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMkL2+2v27CultDSl7FbdnIJn9v6rNbnwXskUkKvvvNiSTnF HZ3YUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgImoLmBkWOgRa7Gbf671idnJz8zefj rfx1D3tT6zbmb+j2uh874lnWb4H1u1puzBX13NTyfuT5CXcVjsLBqlpnKnOkntcCDfOr4sbgA=
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

Michael S. Tsirkin has asked me [1] to post my improv suggestions for
now-applied virtio documentation [2], so here is the suggestion patch series.
The original suggestion must be splitted since it contains three distinct
changes.

This series is based on kernel-doc fixup posted to fix recent linux-next
warnings [3].

[1]: https://lore.kernel.org/linux-doc/20221219011647-mutt-send-email-mst@kernel.org/
[2]: https://lore.kernel.org/linux-doc/Y0QYTq7KW9C731s0@debian.me/
[3]: https://lore.kernel.org/lkml/20221220073709.2687151-1-ricardo.canuelo@collabora.com/

Bagas Sanjaya (3):
  docs: driver-api: virtio: parenthesize external reference targets
  docs: driver-api: virtio: slightly reword virtqueues allocation
    paragraph
  docs: driver-api: virtio: commentize spec version checking

 Documentation/driver-api/virtio/virtio.rst | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
An old man doll... just what I always wanted! - Clara

