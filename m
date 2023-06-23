Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3AC73AF84
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjFWEkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjFWEkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:40:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2115A2128
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:40:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6687466137bso56936b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687495230; x=1690087230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=62yt5qVWyoZQmnreF3LrrB9sgJCoX3gsQ54vlPJGid0=;
        b=iB6lBo9YwW5MgxYwZFgqhOkY2MxLda2QRoe6bpJZpeme26dHBnK6VhAXCfJUBu+xGm
         3qvoaIz/7mOcBKwqVYbH8g81LomgB5PwVv1TfUl5a7Tga0XN0c7Rcl/hRAkTai1BM3i3
         v/SmCCfyPDaATunRcie8miSfjxwrzo/Md1mtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687495230; x=1690087230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62yt5qVWyoZQmnreF3LrrB9sgJCoX3gsQ54vlPJGid0=;
        b=BVAPfemy5c1AYKpPygcHWlvV4+dqvZ11Hz9F4SSoc1kS302eCRBP7zBgfgKbirGLdX
         mB2wBInZrIe1VnXVgaPJie3l5Csrq8O57Ydz3s+dVsfxtN3WOeE+Kl537MSn2vQMNibs
         UYEYaHPDBvBt3C8y5GgIR5tbaESSI9kz75Y9meKt1UdJSslOFFftCDHOFvimZivh9q+r
         tEHsM31uuXexdo3/Kc+LgQtkijqHCOYXiJYR878ZpmEDuDoSLGd/E4QUwueBHBEggboR
         HMYWeCvBMkU10hMoXJDXuW1xm8J9VE4KfBW1QqWQ/QzzrHT5im3YAjIosTR4IerlfxLC
         BPxA==
X-Gm-Message-State: AC+VfDxJMRdTLJQvt6ZAZbZYd778FRHlouGveEGQ7ZDPVittim66/aks
        Pt3u+m+8CCLCQQxlm7bhE/q3cPEdw36gOd86PLc=
X-Google-Smtp-Source: ACHHUZ4nvSxBGFlp+fUxX7rPsn7nYj1O3hJIW5FGy0KeqmrNziwV+VCGCbKU2VgiXahMJHhVvbgzFg==
X-Received: by 2002:a05:6a00:24d5:b0:66a:5e6f:8b21 with SMTP id d21-20020a056a0024d500b0066a5e6f8b21mr3276075pfv.2.1687495230542;
        Thu, 22 Jun 2023 21:40:30 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:3383:b451:fa2:1538])
        by smtp.gmail.com with ESMTPSA id q25-20020a62ae19000000b00666e17004a4sm4237350pff.58.2023.06.22.21.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 21:40:29 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 0/2] zsmalloc: small compaction improvements
Date:   Fri, 23 Jun 2023 13:40:00 +0900
Message-ID: <20230623044016.366793-1-senozhatsky@chromium.org>
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

Sergey Senozhatsky (2):
  zsmalloc: do not scan for allocated objects in empty zspage
  zsmalloc: move migration destination zspage inuse check

 mm/zsmalloc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog

