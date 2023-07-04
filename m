Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB95774756A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjGDPhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjGDPhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:37:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCE8E4F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:37:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-313f61890fbso6220183f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688485030; x=1691077030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZVHggtHO+yJauR9LskgHgrRJhbEnps/FtwfSudSsCo=;
        b=MFwOF7sqVXBxFanxQfr0POOuegrGEdOtkhF028G3OsKGL3xdsPPzrHjjHCl/yZUQsi
         0u2xWsEBho6iRvSucxENpzwYqu7b0USkS0W+q1mqavp72R9LwsRuiUSOgH6bJqxDI2N6
         Myg7WgOAMHNQAOKGq0YrI/FSXNdf8mMkegW+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688485030; x=1691077030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZVHggtHO+yJauR9LskgHgrRJhbEnps/FtwfSudSsCo=;
        b=Yq04T6bXx7osBDBTUMvMlyuoTX7fPi2Wi+Ma8mZxYng5+hwgFUrTS7PswYvqJcOcBJ
         6/wn8gUL0W1NUu7cd3O3fUf2axQFUgFSx0rso9VSzC4HINpUzoTbs9+Bo19P69XFMieE
         B8qBGNC0+O2xfhy93Xh34U/y45j/jzZRHdU1sw9ZQtonxhjIZYRNUwje8Q0CBz/vmVsg
         2R164CMP6DoWDC0sUtgBo1/53BKtYvg3iup18AFrEZ4pBmHYTKE6KdEqoD/h0kxTI86G
         BKkSV+YBZyLqoibMoQPW52iDVhUTVvdwrz5oib0KQrW+AHXEoz78mTaG2iXrT6YZ/Nex
         rE3g==
X-Gm-Message-State: ABy/qLY4Qu2l+nV43do8+I1+2zr27sbfXs0xnYMtHlwT5q+I5ZvVsUtJ
        nzmtB6QqZvgDGWEwbmXCUY8ddtdvJbUYdWYoqzI=
X-Google-Smtp-Source: APBJJlEAgV7A2O402mT7fPusAvg3tuUXWOjSGe1PiyyavUQPEZBAhTj4IWlt79euih0ZpRWlsQjz3Q==
X-Received: by 2002:a5d:44c2:0:b0:314:1ad7:2ea8 with SMTP id z2-20020a5d44c2000000b003141ad72ea8mr11140519wrr.54.1688485030643;
        Tue, 04 Jul 2023 08:37:10 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:99b2:81bb:8407:5369])
        by smtp.gmail.com with ESMTPSA id b2-20020adfde02000000b0030c4d8930b1sm28538709wrm.91.2023.07.04.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:37:10 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        Florent Revest <revest@chromium.org>,
        linux-stable@vger.kernel.org
Subject: [PATCH v3 3/5] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
Date:   Tue,  4 Jul 2023 17:36:27 +0200
Message-ID: <20230704153630.1591122-4-revest@chromium.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230704153630.1591122-1-revest@chromium.org>
References: <20230704153630.1591122-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defining a prctl flag as an int is a footgun because on a 64 bit machine
and with a variadic implementation of prctl (like in musl and glibc),
when used directly as a prctl argument, it can get casted to long with
garbage upper bits which would result in unexpected behaviors.

This patch changes the constant to an unsigned long to eliminate that
possibilities. This does not break UAPI.

Fixes: b507808ebce2 ("mm: implement memory-deny-write-execute as a prctl")
Cc: linux-stable@vger.kernel.org
Signed-off-by: Florent Revest <revest@chromium.org>
Suggested-by: Alexey Izbyshev <izbyshev@ispras.ru>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 include/uapi/linux/prctl.h       | 2 +-
 tools/include/uapi/linux/prctl.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index f23d9a16507f..6e9af6cbc950 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -283,7 +283,7 @@ struct prctl_mm_map {
 
 /* Memory deny write / execute */
 #define PR_SET_MDWE			65
-# define PR_MDWE_REFUSE_EXEC_GAIN	1
+# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
 
 #define PR_GET_MDWE			66
 
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index f23d9a16507f..6e9af6cbc950 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -283,7 +283,7 @@ struct prctl_mm_map {
 
 /* Memory deny write / execute */
 #define PR_SET_MDWE			65
-# define PR_MDWE_REFUSE_EXEC_GAIN	1
+# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
 
 #define PR_GET_MDWE			66
 
-- 
2.41.0.255.g8b1d071c50-goog

