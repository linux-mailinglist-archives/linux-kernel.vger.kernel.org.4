Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD03643A06
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiLFAfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiLFAfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:35:05 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64551EC7F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 16:35:03 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id i83so2365777ioa.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 16:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77rO+gPzClLni+3S5wfokMLSj7yae/3fTCmXDN7kWCE=;
        b=TiaBDG/iwkW4nY50qzQnYVCQM+GXllb6LQZYIA7LYfsxyDMurUi+DF7P9LOM7eczHc
         6s8rUgW1vKR9OZFRQnfW/xDUycFjqLYYsAyh6TNhFRpJaODTYncz3lKMVyk44d9S3Pjk
         hIgdalI84wRexsne7FwvA05UuLiHmhBaASndNT1beSnAuBVLIasGvBJpmY/WNOr6rBEh
         B+LP8a29IKSDqL5UW48mZMZA1uN8qdcvIalZHPwkSlu/qvyiB1HzB2E4ggufmj6ojKTB
         oeo93CLxcHAMwAVjQYkkI5rg5shWbDhvS+IzkqCrX/la772AlLyWRsEoJyzUn9+aVMqY
         yrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77rO+gPzClLni+3S5wfokMLSj7yae/3fTCmXDN7kWCE=;
        b=hwI1rxPnxs65fsBauLK8WVY4G96JXs+dKrvAQ6+SxDW+bkzRTrqu2DzQDdaukOrePJ
         lQDyJOW+cVaBNbQe/5kupcRqylcBYcM78iu/wW66IAbEP6at8b60RkMwE9Enh0dTvI8B
         S+PfwZUP+Nm1GK/xdBXPoAR6bou1S0AzfCiMa12LYMD4+nApR7t5NQN1PyrhcR34gqeP
         hNuwdgK5aCRveQTd4kEmn0BjtUJZLXoVSFcZFgXx+cAptJCy7UWLfYoxWxN0UH0jPG7J
         Tdns8fI7zbXd9jO2bDbCKBbcGjNSwi4ci/GUYWK6mq6b0MROlFBWT60fy1RgEbAAfSfZ
         k/Uw==
X-Gm-Message-State: ANoB5pn3eJLZKk6OGYN2CRdsjaO2gv+GuEQATxI8r5QDeQJYDMWIr39d
        OlMmHfFlYFvK4P/bd+vBBZoi3wc6cerwiw==
X-Google-Smtp-Source: AA0mqf5X5c52RfvyVr/F0IB3pmeSK4ljjXvIHrXrVjgx32GMoi2rAfWpN8Jv8DYtXrWxb28qPa/muw==
X-Received: by 2002:a6b:fd0e:0:b0:6df:5e6c:f5c7 with SMTP id c14-20020a6bfd0e000000b006df5e6cf5c7mr20213554ioi.207.1670286903282;
        Mon, 05 Dec 2022 16:35:03 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id x3-20020a056602160300b006bba42f7822sm6408213iow.52.2022.12.05.16.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 16:35:02 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        jbaron@akamai.com, gregkh@linuxfoundation.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 06/17] dyndbg: dynamic_debug_init - use pointer inequality, not strcmp
Date:   Mon,  5 Dec 2022 17:34:13 -0700
Message-Id: <20221206003424.592078-7-jim.cromie@gmail.com>
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

dynamic_debug_init() currently uses strcmp to find the module
boundaries in the builtin _ddebug[] table.

The table is filled by the linker; for its content, pointer inequality
works, is faster, and communicates the data properties more tightly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5d609ff0d559..a0dc681cd215 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1410,7 +1410,7 @@ static int __init dynamic_debug_init(void)
 
 	for (; iter < __stop___dyndbg; iter++, i++, mod_sites++) {
 
-		if (strcmp(modname, iter->modname)) {
+		if (modname != iter->modname) {
 			mod_ct++;
 			di.num_descs = mod_sites;
 			di.descs = iter_mod_start;
-- 
2.38.1

