Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA393638453
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiKYHO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiKYHOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:14:46 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05352B620
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:44 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b12so5453758wrn.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Pw7Ud8uaEoBuIuRRBEZJLZJrxngQ8HCMPnpIFft49s=;
        b=FRaPlQvSWHXKw3p1xNOjlopLcDJxmm+nY/UeLG5lB/EWJEvORPVzFIw0AqVWU7so9M
         J4zZtLIcroxqtLVtUSpmMNcdjB4cMmrpE3pigGKv6WFZghzydBL+y0MGVEjaYSZtfka2
         5I5J63lhcfQoib0WQmYoGcCcRhBbMKHdjrzvUo/8+gLGrZQUzYLPusB5vtoLmvjSz5ax
         q2atctidMEkDA74MXhKwENXcdXC5jmJHe4IbKpzNn2dW1rOaik/yO2+aYx4peglkdBsa
         pGbwamKZu9GLPcMq3yDq9dFFXXwYqnCQHbLsOfGL/T/pGlw+9zeMvRv4bAPxuTF6LCys
         eiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Pw7Ud8uaEoBuIuRRBEZJLZJrxngQ8HCMPnpIFft49s=;
        b=fJVhlrfkJHntk9Y2ZH27uZmFuvTyKospSzaRRKrs9LCnfxRNkx4eRkRXAjIwhp/yIV
         ZXFB3L95gHr+Q3qRHi4CKq281/uOL1WH+nfPjVTjljBr1HIq3rssCFqPeSm5xqF9P7pA
         2zAHX9ushT+ykIkCd8aCE0Nr+qfBI/2E+YmwPNt9izDl/2eX/XDTRwO04IT4o5XNzuoJ
         CR+tnJJyKLs//tmL5cYQ192NYDXfBcKm0xVfrS7054/9x7dYIxbGztTazb0IE7qyMYuQ
         AuZRw9dw0UNwwWu1pWzS267rDXhVGC5qRZG4/+o/DNK/8iOfqOGELT7CW4prRjXjcFjw
         WElQ==
X-Gm-Message-State: ANoB5plOHeNcDd13dQUb/EgNfXEb3+fzanyBy1EK5noleUYiSWrlxjTu
        ruxW0X1SD4wRVhV5wCjjWTU7Rg==
X-Google-Smtp-Source: AA0mqf7FW4N96w4Tjg1QXNKmRp04ht4U+dNuA5z6DIMW609sYIhxq7ZZpALTkF1cW+yOtM29ZI7VtQ==
X-Received: by 2002:adf:df09:0:b0:236:885e:ef4b with SMTP id y9-20020adfdf09000000b00236885eef4bmr22205827wrl.13.1669360483089;
        Thu, 24 Nov 2022 23:14:43 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm9108444wmq.1.2022.11.24.23.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:14:42 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 00/10] misc: fastrpc: patches for 6.2
Date:   Fri, 25 Nov 2022 07:13:55 +0000
Message-Id: <20221125071405.148786-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some fastrpc patches which add new feature to handle Audio
Protection Domain. Along with it there is one locking update on dma-buf
and an update to bindings.

Could you please queue them up for 6.2.

Thanks,
Srini


changes since v1:
	dropped a dmabuf lock patch.

Abel Vesa (10):
  dt-bindings: misc: qcom,fastrpc: increase allowed iommus entries
  misc: fastrpc: Rename audio protection domain to root
  misc: fastrpc: Add reserved mem support
  misc: fastrpc: Add fastrpc_remote_heap_alloc
  misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail
  misc: fastrpc: Rework fastrpc_req_munmap
  misc: fastrpc: Add support for audiopd
  misc: fastrpc: Safekeep mmaps on interrupted invoke
  misc: fastrpc: Add mmap request assigning for static PD pool
  misc: fastrpc: Add dma_mask to fastrpc_channel_ctx

 .../bindings/misc/qcom,fastrpc.yaml           |   2 +-
 drivers/misc/fastrpc.c                        | 260 +++++++++++++++---
 include/uapi/misc/fastrpc.h                   |   7 +
 3 files changed, 236 insertions(+), 33 deletions(-)

-- 
2.25.1

