Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FC4612FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJaFmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJaFmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:42:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0644CC76B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso14920316pjg.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5bXC0243vzIlXmqJuaoPsZumfjC8+KlYBqtOKgOSLQ=;
        b=lFlf2oVxRN2VsF9XNYteCD5RC9CGXPs9NIzyXxdrHmGL3x5ZbjCN4GvZDcPFRlnVBR
         daPvQtBhbBGUiA1cThKv+Xl9u3TMaERvo6NWER2YakMLm4rZdmtKCnSpTsLeGXVGwzvT
         mABpkqu6zE8My3T25QD1KwXgG5k6ux50h9GNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5bXC0243vzIlXmqJuaoPsZumfjC8+KlYBqtOKgOSLQ=;
        b=c2XqMZaaf8cbucyyjxr5DQmlXLu67GkHv82GVQ0Z5C8/xmJlHXAqx8cj5dVhP7gCXk
         MEVYsw28wJILPa7prIrRIq0t+2cRdoggnwx1o4mNkReBSotSsCPUJjxzo+e/xoSl4amY
         m5Ga6Ej4x+TVNCmmoa+YjCbYmL8fAf8YGcC1yMtVs0UlqAxoyWL/iigcaHAPyk0LvQkB
         k3jGa1dlpUZ/J/llLuZpgNXqvGQdiCQENLDqsFTiehu2z+4WsAgWZBuR7cNmgZMeBawC
         AYirq/fmq5LwC77pjHy/4NyeFmZBED2KtXMjh3h7vE5BsW+JpXozWSQBpnFXi0iDkz3C
         cSLw==
X-Gm-Message-State: ACrzQf25AU7bUj3ytYRP6OX0rgwd/dH7vqFU7nqtxYvu9grjo/yF0N98
        YazaZLAx9vstzuuc+yKL1uym2w==
X-Google-Smtp-Source: AMsMyM5yLDOwBAxqEWKyf/6OjNRVMOVOjTuyZ5Dx6UE1GoL0Kq3F+BX0jGcCoqraaPa30JhwhLf2zQ==
X-Received: by 2002:a17:902:e402:b0:186:6f1d:b463 with SMTP id m2-20020a170902e40200b001866f1db463mr12461840ple.23.1667194900136;
        Sun, 30 Oct 2022 22:41:40 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7616:afe0:ba6c:96f4])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b0056befcd7958sm3573308pfj.84.2022.10.30.22.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 22:41:39 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 9/9] zsmalloc: break out of loop when found perfect zspage order
Date:   Mon, 31 Oct 2022 14:41:08 +0900
Message-Id: <20221031054108.541190-10-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221031054108.541190-1-senozhatsky@chromium.org>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we found zspage configuration that gives us perfect
100% used percentage (zero wasted space) then there is
no point it trying any other configuration

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 42987a913f45..a40c548520d3 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -787,6 +787,9 @@ static int get_pages_per_zspage(u32 class_size, u32 num_pages)
 			max_usedpc = usedpc;
 			max_usedpc_order = i;
 		}
+
+		if (usedpc == 100)
+			break;
 	}
 
 	return max_usedpc_order;
-- 
2.38.1.273.g43a17bfeac-goog

