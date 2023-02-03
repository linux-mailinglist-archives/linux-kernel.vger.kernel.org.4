Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972276894AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjBCKDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjBCKCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:02:52 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379D379221;
        Fri,  3 Feb 2023 02:02:47 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l4-20020a17090a850400b0023013402671so8297303pjn.5;
        Fri, 03 Feb 2023 02:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BG2QYvy6NMh3jkUceNvjWVdBbpNIzuoerxuxOO9e15w=;
        b=hNvMzC7RPAckWz7Z2Qk/u9uDSOaeNgibp3y0pbCj3dUMyWcnazq467VyDLAE7Uj3d+
         Hp1zHYFUQ+ymjA7vvesMXLXQlR3ZCGtO9nDPjDrmvHtiqAoCVkotR9iYfdok792ktY22
         dVbbMPbKQ8mPs/e46SBPxHxARgmpU+mJBjSHv7thd/lpp2k4Un9JMnxjGLuncHxF/RUL
         pD8y2Ml8GRwWXIGIRZwhE+wB3poEavRbZNRLXJC2N5MOnf/NjtwXM+bJswMQEBnLw2+e
         Xqlt9ngIcG5w09YsTnyzVSncicip44pBj1M14JwwvKa/zkHmDIBYC1WZD4vRNBzKI4e9
         Xn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BG2QYvy6NMh3jkUceNvjWVdBbpNIzuoerxuxOO9e15w=;
        b=DV6TmOWk5edNvnbIowdCeE+hqRu0gqsjF5A+E+5cRkc979Y3W8jneOOtABdp6BXZyX
         J5YxrAfAUsc77dxb1hB3g299cdz25KlB79kf2jMTPVXuIbfUgkw73e6DNgTBXzZaK9E2
         a03pRIbUMuKTNbsTGuaBjgAvFGzMp3BDcfZz4UCMeJRlr5PWMxjq6EYizs0Y17wenS6E
         qYP3qbNqDZtPkppW/HCXGZr0tqnL73G6D97UrrKaBeG5EOqpM6EJJImqulG4Unbcfsjk
         eDtHosASC0ukI+ucHt0X+ghxAlnOtdM++liXCmj0YEnwgYqR2McaYrt03S/L1iHv/FRJ
         tYGg==
X-Gm-Message-State: AO0yUKVrTRnUI/66q4TdoI5oKdV9ge6aEXO6TS7fMaFK/voWUeQ9pHvN
        +l3pW3+UChj6KE22DJH4XU4=
X-Google-Smtp-Source: AK7set+R0TEkeypd3nINmPSzcBNxBayigz71nAlhY7yu1gmDzLP7p9w777hoCF2OhaAxhY11nHoCIQ==
X-Received: by 2002:a17:903:234f:b0:194:4b98:42c8 with SMTP id c15-20020a170903234f00b001944b9842c8mr11309975plh.28.1675418566654;
        Fri, 03 Feb 2023 02:02:46 -0800 (PST)
Received: from debian.me (subs09b-223-255-225-232.three.co.id. [223.255.225.232])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902784c00b00192b23b8451sm1194930pln.108.2023.02.03.02.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 02:02:45 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 7B73E1054B4; Fri,  3 Feb 2023 17:02:41 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Intel Graphics Development List <intel-gfx@lists.freedesktop.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matt Roper <matthew.d.roper@intel.com>,
        Gustavo Sousa <gustavo.sousa@intel.com>,
        Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>,
        Matt Atwood <matthew.s.atwood@intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Srinivasan Shanmugam <srinivasan.s@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 2/3] drm/scheduler: Fix elapsed_ns kernel-doc error
Date:   Fri,  3 Feb 2023 17:02:14 +0700
Message-Id: <20230203100215.31852-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203100215.31852-1-bagasdotme@gmail.com>
References: <20230203100215.31852-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=bagasdotme@gmail.com; h=from:subject; bh=qrXofAp66flXv+Lia5rtjdHHkc9E4+c8afVKnwKMo98=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMl3bi8LuVLl4BMdt8Vjx6WHU75L7q76orZFacUmve8tRyp5 vLTyOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjAR7wkM/4v/hf88NL12XtLb9addPR 9ETmTL89Vyub4v7u8H15mdgasYGVbbNJpdPNs3mVXUd8bzWzedfun4a+bJhHr5T7lnbZOdww8A
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

Stephen Rothwell reported htmldocs warnings:

include/drm/gpu_scheduler.h:232: warning: Incorrect use of kernel-doc format:          * @elapsed_ns
include/drm/gpu_scheduler.h:238: warning: Function parameter or member 'elapsed_ns' not described in 'drm_sched_entity'

Fix the error by appending missing colon to @elapsed_ns name in its
kernel-doc comment.

Link: https://lore.kernel.org/linux-next/20230203135027.1a4679d3@canb.auug.org.au/
Fixes: 248cd9b265fca6 ("drm/scheduler: track GPU active time per entity")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/drm/gpu_scheduler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 9a50365621ed8d..9db9e5e504eeb3 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -229,7 +229,7 @@ struct drm_sched_entity {
 	struct rb_node			rb_tree_node;
 
 	/**
-	 * @elapsed_ns
+	 * @elapsed_ns:
 	 *
 	 * Records the amount of time where jobs from this entity were active
 	 * on the GPU.
-- 
An old man doll... just what I always wanted! - Clara

