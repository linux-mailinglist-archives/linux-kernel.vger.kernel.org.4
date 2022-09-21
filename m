Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40A55BFB1E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiIUJiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiIUJh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:37:59 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7147A8A1DC;
        Wed, 21 Sep 2022 02:37:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l10so5051538plb.10;
        Wed, 21 Sep 2022 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=zLWQl2ossHljnmBKykrFSVUQxMB7baGhQaEPgUIB2SY=;
        b=G1FjMvqBS9DgRi9pzqNWBEHzPXsw+yYGFLBcjbzbS8Z1Cib2NlsNcAhrRDuuO/FCBE
         ze1IBDxfCuuPsyCjSdTjNVujCOF20h/2AEYbp9aV5mmIsXGLRHX/QQyW7YHacvg8VaVw
         aw8XWvmwz55ypH3M2OzppoxABzJSXLO3V3qnudz9z6xEh5/L6JiYa9jHM9IIDq0qsvsG
         sAKMbEtTZyrMY7iWhsEqCUqAfzITsVeSjfDOJWTQVfZ29lmCBPcive+pdABh/ClGWHya
         FV5R/rznBmhbfKalNKfieEdO53MuTqpakxfl5kd8bA4uyJFoDlOYDG0d2XUOL32n3CiW
         Pp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=zLWQl2ossHljnmBKykrFSVUQxMB7baGhQaEPgUIB2SY=;
        b=oVvIZrB7HfQSkz+vUFDCnM3pjd7wtWF6dwY+hHfuYwqo6O4Zui/yl4vKwHg7EjCLUL
         a7t4Azxc8jnJ//82DPeqSayd+6FRONR1a03l65H1TmMwVbK4y0Wr/tRlKzTDw8+PS3Mj
         oCrRYg4xEWN+bNlkQmgNiwnhzyfU3M3SVMRwOkT8DRxR0QNogDbteRebpIIZ+1dIYkjf
         zXo65DtzubdrC/D/NBD3lraU+qOueftC+V22Dt2aAZyEHA0ecFF5s9qTh8wlpbeXfAEV
         kf0oG41dONfg1U/UEnWdxqZbdYpRXOD4iwbl6NUfjGjtwrc1EEA9xxrYVIaSyuVQaGRM
         rU8A==
X-Gm-Message-State: ACrzQf1CVYZezeZKR8/tD+jxUvEQuFZKvvaCYlAM8cBYrC2uNaq8AR9s
        YLXkFhvhYi55CxU2WQDb+nw=
X-Google-Smtp-Source: AMsMyM69dMEqriWvI2VKfya4NJ1M8XvDQQRLIqrZe6a1hcFxbx0F8sBk6WEVIe7VWcbAqs5wqyao7A==
X-Received: by 2002:a17:902:b089:b0:178:54cf:d692 with SMTP id p9-20020a170902b08900b0017854cfd692mr3823693plr.1.1663753074966;
        Wed, 21 Sep 2022 02:37:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o27-20020aa7979b000000b0053e4296e1d3sm1622786pfp.198.2022.09.21.02.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:37:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf ui: use strscpy() is more robust and safer
Date:   Wed, 21 Sep 2022 09:37:49 +0000
Message-Id: <20220921093749.230910-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 tools/perf/ui/tui/helpline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
index db4952f5990b..1040e4c33469 100644
--- a/tools/perf/ui/tui/helpline.c
+++ b/tools/perf/ui/tui/helpline.c
@@ -24,7 +24,7 @@ static void tui_helpline__push(const char *msg)
 	SLsmg_set_color(0);
 	SLsmg_write_nstring((char *)msg, SLtt_Screen_Cols);
 	SLsmg_refresh();
-	strlcpy(ui_helpline__current, msg, sz);
+	strscpy(ui_helpline__current, msg, sz);
 }
 
 static int tui_helpline__show(const char *format, va_list ap)
-- 
2.25.1
