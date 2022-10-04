Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BF85F3B8B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJDCnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJDCm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:28 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF30722539
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:42:27 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id s18so7476254qtx.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qHMeLOfJoIrvE9fi2U/J5sqIQb82UDnKuhTxG+3+5zQ=;
        b=WEOsB+5qZH1d35I4d/f2NHtH7P/qhz+3Qst6PAka495OMpNlt8sDrS7968BC/n67h8
         om5lDmx9OSJCQKfgJsL0/CcTl0V0LxHR2ht/OnxMgImsVlevcuEeFXzZ/PvkkQDVM1El
         FKNqOeHxZyofEBK2s50J13JTImjSrJLLdgu0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qHMeLOfJoIrvE9fi2U/J5sqIQb82UDnKuhTxG+3+5zQ=;
        b=VlOynPq+8DwMwP6DBLOqhfU7bXvusTVB95oBIVJgb/lkykzuaEAKxzC3mlb2Wd+JO+
         tWOGGIkXPRhSYIige4CYPkkTJEw1FSsewka2EqiLAJlMC4qQa3dd7qgJxOaR+D70A5Bt
         zdmmVN2SFXMpQI2uMWu1z1IimOqPwNynDWFQYSJGYHFmYi5Dqu17KjyKND0QSunMIuOI
         fEj7ciaXl+oKjDFMrxxqM7x7HnQU02L3oUPX3mkY237DWTVPk0KjJMeoSeVOEQ2amhUr
         SnrDa+dTHWN8+UydpVayxdiZNSscezvD78LroknsWIIBgg2LJSG9OL0Cev8QysHmhwdS
         d1BQ==
X-Gm-Message-State: ACrzQf15iREayyTdMzWEy7sh01BhXSbpyTkJ3Aouf2FwBVjK2RQvTXsQ
        KeDIuaHrsF7feOzJ7ptAWom0jK5FgwlZcg==
X-Google-Smtp-Source: AMsMyM749wYYgpntHIZ9XTkrQjZ2yhgo13uQYn8I0QiKB5i3NqrnNJ1sa/qQhQsQMj5KWOxBJDc2yA==
X-Received: by 2002:ac8:5741:0:b0:35b:b52b:ca9e with SMTP id 1-20020ac85741000000b0035bb52bca9emr18086163qtx.653.1664851347372;
        Mon, 03 Oct 2022 19:42:27 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com, Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v7 10/11] scsi/scsi_error: Use call_rcu_flush() instead of call_rcu()
Date:   Tue,  4 Oct 2022 02:41:56 +0000
Message-Id: <20221004024157.2470238-11-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uladzislau Rezki <urezki@gmail.com>

Slow boot time is seen on KVM running typical Linux distributions due to
SCSI layer calling call_rcu(). Recent changes to save power may be
causing this slowness. Using call_rcu_flush() fixes the issue and brings
the boot time back to what it originally was. Convert it.

Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/scsi/scsi_error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 448748e3fba5..a56cfd612e3a 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -312,7 +312,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
 	 * Ensure that all tasks observe the host state change before the
 	 * host_failed change.
 	 */
-	call_rcu(&scmd->rcu, scsi_eh_inc_host_failed);
+	call_rcu_flush(&scmd->rcu, scsi_eh_inc_host_failed);
 }
 
 /**
-- 
2.38.0.rc1.362.ged0d419d3c-goog

