Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F79643A02
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiLFAfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLFAfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:35:01 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD301EEF4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:35:00 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id c7so8741985iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/Lx+Pa2dFiRyEx0ifPOdZSFdKCDCLW5/FmUbDCcn+o=;
        b=ChjTyTqgi3mQ2l4gsr+fcX/YZjq68JbCUyTfna6Sr1gGRSFY2OeF1QcwBTSZQqlAVv
         UIAN3a/YIuNwxxzQLfa69yA/7WV9xeEe/+EzxK+M7CvaVbo2onuvssdnmtLAvvH80G3Z
         nmFYrVqsZ3fQFSohvwl6zao3VxPivGmRMlOe60R6e5gC4BvwSV/nPSXp3/tsyv2xmuy2
         CDU662Kt0tkn/aLJE5fr2pRVAyXIDw2rCjCWbhFwQxLszjutu7G6N3WowR2zgQziXUHv
         t6d7aqR5rRFebvTztB31h09IPP3wjZcNi58xE+rtsMI5Lop+/JECopa1nn7J4YwQU+pB
         NWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/Lx+Pa2dFiRyEx0ifPOdZSFdKCDCLW5/FmUbDCcn+o=;
        b=HWQ/+011SdSHck8C6qkT+QRWYim8qKUvoxOxOr0LodF8fXmFi0E9EZKoCpAq7Ds5aY
         pgsOh4hGJuTUOKlD8ssOepe6Pk2IJXMYugaseWF5oPAoYgJnle6eNFYPNHo/TIj+RkE8
         0MEUNDHAffKUKzBogg94qEB6j7a7OMl3Wzj7NXZYKsnHT2eI8H17eBz+WasGYU4B1qxr
         5jQW5hwtol/WKKY/LilZNumDEp4ZcyM0cprB7bst4jwaSdXkF/1w5syYmMC41LvGUg6G
         FhL31+qnd1vmkLg3GBfU9GUEY+MnjLU5FqY0kB8ZJPU5s5jEpgYwuOUtSwbNGF5KxCG+
         6gkA==
X-Gm-Message-State: ANoB5pnrluFiYbQ8encEB04imsRynM34zMqP5iwZGJOpv1xZ6l2FsOgx
        7A7EytHpD8wHFCLFHH08xA+eWZL4cQxnuQ==
X-Google-Smtp-Source: AA0mqf6tRCCvKuZvdfWrz9xBQygxsXpsVSlGTcPCOl2Fz5EDFHyNVH92XxE5N7apC1UXzG9nmYeLTw==
X-Received: by 2002:a05:6638:42ce:b0:377:ecee:7993 with SMTP id bm14-20020a05663842ce00b00377ecee7993mr23391751jab.305.1670286899656;
        Mon, 05 Dec 2022 16:34:59 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id x3-20020a056602160300b006bba42f7822sm6408213iow.52.2022.12.05.16.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:34:59 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 03/17] dyndbg: fix readback value on LEVEL_NAMES interfaces
Date:   Mon,  5 Dec 2022 17:34:10 -0700
Message-Id: <20221206003424.592078-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206003424.592078-1-jim.cromie@gmail.com>
References: <20221206003424.592078-1-jim.cromie@gmail.com>
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

Since sysfs knobs should generally read-back what was just written
(unless theres a good reason to do otherwise), this result (using
test_dynamic_debug.ko) is suboptimal:

  echo L3 > p_level_names
  cat p_level_names
  4

Fix this with a -1 offset in LEVEL_NAMES readback.

NOTE:

Calling this a BUG is debatable, and the above is slightly inaccurate
wrt "read-back"; whats written is a LEVEL_NAME (a string).  Whats read
back is an integer, giving the 'edge' of the 'low-pass-filter'

The actual test looks like:

RTT: L4 -> p_level_names : 4 :: DOING: levels 4-1
[   17.509594] dyndbg: "L4" > p_level_names:0x4
[   17.510115] dyndbg: apply: 0x1f to: 0xf
[   17.510506] dyndbg: query 0: "class L4 +p" mod:*
[   17.510992] dyndbg: split into words: "class" "L4" "+p"
[   17.511521] dyndbg: op='+'
[   17.511811] dyndbg: flags=0x1
[   17.512127] dyndbg: *flagsp=0x1 *maskp=0xffffffff
[   17.512604] dyndbg: parsed: func="" file="" module="" format="" lineno=0-0 class=L4
[   17.513414] dyndbg: applied: func="" file="" module="" format="" lineno=0-0 class=L4
[   17.514204] dyndbg: processed 1 queries, with 1 matches, 0 errs
[   17.514809] dyndbg: bit_4: 1 matches on class: L4 -> 0x1f
[   17.515355] dyndbg: p_level_names: changed bit-4: "L4" f->1f
[   17.515933] dyndbg: total matches: 1
crap [[ 5 != 4 ]]

This -1 adjustment just reports the edge consistently with its
input-mapping.

Fixes: b9400852c080 (dyndbg: add drm.debug style (drm/parameters/debug) bitmap support)

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 009f2ead09c1..48ca1387a409 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -794,6 +794,8 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 		return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
+		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl - 1);
+
 	case DD_CLASS_TYPE_LEVEL_NUM:
 		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
 	default:
-- 
2.38.1

