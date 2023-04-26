Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431036EF934
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjDZRWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjDZRWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:22:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2A4659C;
        Wed, 26 Apr 2023 10:22:31 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-2f8405b3dc1so4631695f8f.3;
        Wed, 26 Apr 2023 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682529750; x=1685121750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=01hZS7A7jytOXyQf8r/c/6XNX53aVGNcnKzJAHehHTw=;
        b=OBibne1aPzMp1xZq92cu/7tUFqIF9YuvnoESy+Gmt4+qOIk00xNI7o6e2o1zdKtBFm
         EBLN0aNy9FYOFqm9tCQ4m9PurNEW2G8sW/7Gs5bemO7EBfmZdI0n0EeNlHouXmUxCAC0
         K/Kmg5zrDuRTQnc0UQP7Kf41lE3N4sPIFmyT+XWZswcC9Yu7VaDIfw1f+g1jFXgNfdjH
         F8/3RCqDY+HeQa5zgQ6Um9Us3JN+YTDDaKWYBNLf44boDGb289clhYiiEE45Kzxe94gT
         QshUCAh5BaB74tX3q7yQKwr3hI14qSHdTeHvqDxmITXuPwNiaCCnTGn+yfVec25/2xsV
         zpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682529750; x=1685121750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=01hZS7A7jytOXyQf8r/c/6XNX53aVGNcnKzJAHehHTw=;
        b=jiGPZcXehMY8vFaFVpUYSD5QxDvBRqyn0KNgSX01lqiieqgjQ4M7GgMbujuuZdXjc0
         ybUhAdc7U8biDrm8gB0HuKH1Kl7CEQDKZG/sfkiEfA2vmp4HljMhdAp9lGapBVX63Vyj
         e5BVmzgpYFZSBADIUchbIGzzmAK9M2iH7t9tCC6A740yNVnvI6JHzJKgaHzF7qf2ihNz
         1cegOQ6VslfpTZXsT9dPHQyNrqk06gtJ+neZAlRldb84NKS6xDGEzjuDsMxPh1xay7oQ
         FV5zUFror8Uy4qWnnVhDFEYYDkJ2P27mk8MdtEansutzMUIiR6K4Gtk27OnW7znV6MRz
         lFlQ==
X-Gm-Message-State: AAQBX9ePvZruRIQGL5rBZBeCFL029/2/ij3b6AEFpIlQM6C/LhlVEZ7a
        FzHU0m+oVO4REkKcLH1MGak=
X-Google-Smtp-Source: AKy350Yl71g8ZkyU3xL+JBuIEkB73C4V/X1yVsiwQSxSK7YpxyUITrbsqrNAQKKJGxc4/m0SmBrt+w==
X-Received: by 2002:a5d:5492:0:b0:2fa:9036:9cf with SMTP id h18-20020a5d5492000000b002fa903609cfmr15513729wrv.37.1682529749903;
        Wed, 26 Apr 2023 10:22:29 -0700 (PDT)
Received: from localhost.localdomain (host-87-21-14-179.retail.telecomitalia.it. [87.21.14.179])
        by smtp.gmail.com with ESMTPSA id v21-20020a7bcb55000000b003f16f362ae7sm18675613wmj.21.2023.04.26.10.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 10:22:29 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Tyler Hicks <code@tyhicks.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] fs/ecryptfs: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Wed, 26 Apr 2023 19:22:20 +0200
Message-Id: <20230426172223.8896-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap() and kmap_atomic() have been deprecated in favor of
kmap_local_page().

Therefore, replace kmap() and kmap_atomic() with kmap_local_page().

Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
HIGHMEM64GB enabled.

v1->v2: Patches 1/3 and 2/3 were not grouped in a series. Patch 3/3 is
new. Therefore, currently one series groups all conversions needed if
fs/ecryptfs. The subject of 2/3 changed to differentiate between it and
3/3. Furthermore, the commit messages of 1/3 and 2/3 have been largely
reworked.

Fabio M. De Francesco (3):
  fs/ecryptfs: Replace kmap() with kmap_local_page()
  fs/ecryptfs: Use kmap_local_page() in ecryptfs_write()
  fs/ecryptfs: Use kmap_local_page() in copy_up_encrypted_with_header()

 fs/ecryptfs/crypto.c     |  8 ++++----
 fs/ecryptfs/mmap.c       |  4 ++--
 fs/ecryptfs/read_write.c | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.40.0

