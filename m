Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14786F2BCC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 02:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjEAAQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 20:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjEAAQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 20:16:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B50E4E
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 17:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bwVD7xPPmW0/T4pDo3syWV+u10HS4qWZOkLHQ50Qrms=; b=CSVo1/WtywdxUAaaP6gtA736bu
        7yzvBIyzmc4s9fXFlk/bEyqKsDSk54DNEvhGHgyJoHKRh1y+cpwIH/NR6RQ9pHYsRN3psZ7FHs26u
        CpCg08Il51etplABWTVrv0tRgwayrEamkHch/yQGPbd4y5XOCTLF9YlNLJFRzYx8wgl/8z9xME886
        gPsfaCUjupucSl+wB/ytgVWK8at8p7BEU2DMZlbb2vhbQc+kmPlOngTrtYNcsd1nNQlOmwBu4JNdL
        O5ftH0NzfqocHM7LKoveIRn/etLVUTvkugVGDYoUP1vOkurJ0kEPAWHohgccduraaoTkvZYrw4TGG
        z1UpS97A==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ptHDH-00EwtV-0y;
        Mon, 01 May 2023 00:16:21 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mushahid Hussain <mushi.shar@gmail.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] accessibility: use C99 array init
Date:   Sun, 30 Apr 2023 17:16:17 -0700
Message-Id: <20230501001617.9152-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use C99 array initializer syntax for consistency with other array
initializers around it and to eliminate a sparse warning:

drivers/accessibility/speakup/main.c:1290:26: sparse: warning: obsolete array initializer, use C99 syntax

Fixes: f43241aafedb ("accessibility: speakup: Specify spk_vars among module parameters")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mushahid Hussain <mushi.shar@gmail.com>
Cc: William Hubbs <w.d.hubbs@gmail.com>
Cc: Chris Brannon <chris@the-brannons.com>
Cc: Kirk Reiser <kirk@reisers.ca>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: speakup@linux-speakup.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accessibility/speakup/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -1287,7 +1287,7 @@ static struct var_t spk_vars[NB_ID] = {
 	[PUNC_LEVEL_ID] = { PUNC_LEVEL, .u.n = {NULL, 1, 0, 4, 0, 0, NULL} },
 	[READING_PUNC_ID] = { READING_PUNC, .u.n = {NULL, 1, 0, 4, 0, 0, NULL} },
 	[CURSOR_TIME_ID] = { CURSOR_TIME, .u.n = {NULL, 120, 50, 600, 0, 0, NULL} },
-	[SAY_CONTROL_ID] { SAY_CONTROL, TOGGLE_0},
+	[SAY_CONTROL_ID] = { SAY_CONTROL, TOGGLE_0},
 	[SAY_WORD_CTL_ID] = {SAY_WORD_CTL, TOGGLE_0},
 	[NO_INTERRUPT_ID] = { NO_INTERRUPT, TOGGLE_0},
 	[KEY_ECHO_ID] = { KEY_ECHO, .u.n = {NULL, 1, 0, 2, 0, 0, NULL} },
