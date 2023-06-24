Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B06C73C6EF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 07:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjFXFbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 01:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjFXFb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 01:31:28 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C715D26AB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:31:27 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-630038f13daso12157176d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687584687; x=1690176687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CpNamKrNpDCdbcF9XbjJPNcFm86c8B3puQQnd+r/HGw=;
        b=Z5+8hPZyJNdpvO1yM9cQ9dK7OuaewDHHeNyPLe429wvaxApbqQBbUA5sankYu8AUqX
         ks5KYxFWZmAJAIQVezo+Hc3LixlxGubI1fok7hnxormr+lUYcmWo4b6XUfojKHXA6kA7
         +vb7NGqYAuA9q04SEl7mCsh4fsNgLUZKMJS6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687584687; x=1690176687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpNamKrNpDCdbcF9XbjJPNcFm86c8B3puQQnd+r/HGw=;
        b=S79KNqDMVUVCKKf2nOMNGNH1tlq9xJLPt7e+R12vHN0M/JCW8iF7a0UK2LfTKoJdNL
         Swx0Zvk/siTGJfnjQ3XGKS+YKjvH6/emmIiVUe0KQGElblvRiijp4YegWbdjVJucksvV
         H86n0qbg/BCqAiCpy+sBGVv2PLJWKM3vw6IWl7doWM5uB0MYyOZ1kVj8uyga5Vj4nQ/I
         s5Qpv7nS/v0abE++RKztuaXzVfiVRecxnduQEiV98PH5y4yStWY0UxGge2i1fpw8TFtn
         WZRdd6PLnbuSA0CrPe6ymyHU3539IJeOSMS+IU3FwIdQLker/r89Ot/BOVcpBh7xWQKR
         ZQfQ==
X-Gm-Message-State: AC+VfDwuOtDUJnsWxBZkfnWjhmqLtVU8/rzwbaxedBZeS0oOP7Q2i3hl
        /gkmjZZGniHgSAtTOSLgyGHijQ==
X-Google-Smtp-Source: ACHHUZ59kbb9oc/3EdlJIPQ1rEUy+0ALxxe9YcwNqaxizKDkr5wxxb3jXDBElCaXtw4nKgj2IS5MBg==
X-Received: by 2002:a05:6214:2302:b0:628:74d6:ba89 with SMTP id gc2-20020a056214230200b0062874d6ba89mr26510620qvb.60.1687584686929;
        Fri, 23 Jun 2023 22:31:26 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:d7fc:8a97:4a18:6a18])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090a0c1000b002563e8a0225sm567069pjs.48.2023.06.23.22.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 22:31:26 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 0/3] zsmalloc: small compaction improvements
Date:   Sat, 24 Jun 2023 14:12:13 +0900
Message-ID: <20230624053120.643409-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	A tiny series that can reduce the number of
find_alloced_obj() invocations (which perform a linear
scan of sub-page) during compaction. Inspired by Alexey
Romanov's findings.

v2:
-- picked up a patch from Minchan

Minchan Kim (1):
  zsmalloc: remove zs_compact_control

Sergey Senozhatsky (2):
  zsmalloc: do not scan for allocated objects in empty zspage
  zsmalloc: move migration destination zspage inuse check

 mm/zsmalloc.c | 50 ++++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog

