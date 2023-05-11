Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC416FEF8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbjEKKAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237727AbjEKJ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:59:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082EBA6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:59:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso56376665e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683799179; x=1686391179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05rOzapbDd67ZfWycrOy9C98CIXkiP3ZCwlZ6dRIqgg=;
        b=r7zuCp1tsX1VBK84Nzej5PABziTEhMLj4RND75T3nTFLf2n4vVO7KsJpFdyyOXtNet
         muhVqWnLt1aw2ibSCIqt8ssMX3hPRnnf9EU0CzJ0kXcTcb3264O4z/IwjtwLcl5C2CXk
         JKDhNzPg1Djh7YDBWUqb5MSvZV01xKEq1Ok5HGZJr/zoLuUKzyrxacquTZu8TFsWh7gL
         bymB87Zkm7hYiw1zJtRgtzvubUenJ0m7V+yGZhEh3DIBT5a7ljSeADgqv1KWyCFCfesG
         rC9UeIkamzISQMqpVwMIi/yukbSSVXFgpzdIxg/jvZQH6did22RAU+Q651NA7+kL8RXw
         oh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683799179; x=1686391179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05rOzapbDd67ZfWycrOy9C98CIXkiP3ZCwlZ6dRIqgg=;
        b=j+rq9nkb6v4gf9Xp/nWVDk7yYwQ1MhBtI6fq2V3MrYW/xf8OL0iUS6Sv0hsrJhaNM1
         lKek1gk3WOl1Isx2GFsCzgQ4L+YJBlTATsfJ1MeO80sOlEFsmjR8pmF8RNTcSr7GEM0y
         dK9O5OHQDaaR12anVuy2jeBHcPdxAvg6iOvhzJqnrH09Ppect/VzUawlTGBtg/lq2tey
         kBL5/PIm8I/YPaO90g/arjPMJyjzPuaWCUipk1BosKPx7Y9uvB9CUSpOMNpO+Q1kmyaZ
         HY/63bkRU16HwZnhgm4Pv/iJChldtbHFNiK81MG/8fK1lqG94Wx0czO5J7TXrsiVNuWk
         4JPQ==
X-Gm-Message-State: AC+VfDzgZfP8/nAjeQeqwYuoaopiQCJRroE3+vDNRYv7h0Lz2FXfwht4
        3HXamD2YPyoCBlKRMW56qKZMgwZEv3P+XDbYdYMKBA==
X-Google-Smtp-Source: ACHHUZ6X5mGt+gawgpK3wEAy+hV4fo2DWvgRpdnCKgeSK+o21xgdzUu3tW4IcdJWKlDdOCFsb0yI6A==
X-Received: by 2002:a7b:c3c8:0:b0:3f4:28bd:74f5 with SMTP id t8-20020a7bc3c8000000b003f428bd74f5mr7309185wmj.25.1683799179484;
        Thu, 11 May 2023 02:59:39 -0700 (PDT)
Received: from localhost.localdomain ([64.64.123.10])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c1c8900b003f4283f5c1bsm12122791wms.2.2023.05.11.02.59.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 May 2023 02:59:39 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jean-philippe <jean-philippe@linaro.org>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux.dev, acc@lists.linaro.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2 0/2] uacce misc fix
Date:   Thu, 11 May 2023 17:59:19 +0800
Message-Id: <20230511095921.9331-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230511021553.44318-1-zhangfei.gao@linaro.org>
References: <20230511021553.44318-1-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
using q->mapping instead of inode or file
vma_close clears q->qfrs as well

Zhangfei Gao (2):
  uacce: use q->mapping to replace inode->i_mapping
  uacce: vma_close clears q->qfrs when freeing qfrs

 drivers/misc/uacce/uacce.c | 25 ++++++++++++++-----------
 include/linux/uacce.h      |  4 ++--
 2 files changed, 16 insertions(+), 13 deletions(-)

-- 
2.39.2 (Apple Git-143)

