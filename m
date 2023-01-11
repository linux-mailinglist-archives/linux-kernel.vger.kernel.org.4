Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D627D6663E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjAKTlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjAKTkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:40:19 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FA93AA9A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:40:13 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id p15-20020a170902a40f00b00192b2bbb7f8so11244926plq.14
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5bviZdBeZVWu9z0ohPbm1w0zXLBgxhA6laMUN/MloW8=;
        b=WFBqNjkRooygX82Vm48gtU1+bW7i42SR/l0eJYBDRVMkegtq6Ye2zEQ2RAhyUuUCns
         r8CqG/RZnRHeaqTMOshgIh8TozG22ziD8660wAbuAgwF2YdUJpjMDlvXyZ3PotedMlJs
         Iq8wQ8D75023d2DHDwfKgpprRCqh2MXuH8EhbX7LesW1zcETx/907VgnJ74o53BBfQjK
         OatrOHNkheVMS16ah+A0DdpD7djnm8EuuiEbojQo/k0JdHCAamkiH9pbUksaq+Pp9p8+
         OhAP/b6aZCA3+RgYS3rU4Fm/W0S2Ok663QvEWtiefZe+/xsVBzr5ucT3LSEq6lrBVh+A
         t/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5bviZdBeZVWu9z0ohPbm1w0zXLBgxhA6laMUN/MloW8=;
        b=yi+uoRrqO9vGUvZ2AvlWWicECkVRKi4lYRXeo6b24f6AZTrai2gbnmrlKiczKUfHM2
         28RTaLf9nY+XccUDK/i0yG0KT5NHfl4ZUBqnpqmfVIZbupoFbGVXfGgZDRshWMiV5Ous
         OxlqkH01h8phJcFM8TMBXmDZagCLf22IooXodsH77VLgRwAyntAjh2o1LK7+0elNMjTc
         4596EPRKrdulkKjlxn5bdQC/ivM9FqBcgMp0/txJnIcaaMJ4AVNiTf58TELiC+YvomQg
         FjG8/zXSXFlX2QjGdwR+/BkPI3BxZ7jAHH3TNclzjowTe/itFcGH5wxap3rnjdUtFGGQ
         WqBA==
X-Gm-Message-State: AFqh2kpdnRIfPFvVeL3eNvNRY4ffAv7PKdj9WtdUxl1ZtiRrbv0jQGfn
        qre5MRJ4gIbJ2w1sRo8m9Sy0lWAF5SvTwk+PJCWYGP2+jbkCvZN0ldNR4M8GhytjJE5/yiiuhnq
        1KbX19Kwh00BzZRfLy5a6hmg7SW4OOELuaANe3sjr9MKIRlcWkw9SDGwsd3xzAgBpaKz3TMBBDN
        41ELM1IpM=
X-Google-Smtp-Source: AMrXdXtk/BvFnceHRaJuw+iwbGdIY0UI/lHlAazeNkuD+QchdNYrfK9omQdZ7IZOolQbjLoCrJsvVFRdtemQ663SUQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:be16:b0:194:53f1:3912 with
 SMTP id r22-20020a170902be1600b0019453f13912mr113446pls.98.1673466012763;
 Wed, 11 Jan 2023 11:40:12 -0800 (PST)
Date:   Wed, 11 Jan 2023 19:40:00 +0000
In-Reply-To: <20230111194001.1947849-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230111194001.1947849-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230111194001.1947849-7-dionnaglaze@google.com>
Subject: [PATCH v11 6/7] virt/coco/sev-guest: Remove dependence on sev_guestreq_t
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next step in changing the cross-module signature change is to remove
this dependency in sev-guest in favor of the concrete type, u64.

Cc: Borislav Petkov <Borislav.Petkov@amd.com>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 2 +-
 include/uapi/linux/sev-guest.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 04c30e4da642..1204939d4f2b 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -412,7 +412,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 	if (rc) {
 		dev_alert(snp_dev->dev,
 			  "Detected error from ASP request. rc: %d, exitinfo2: %llu\n",
-			rc, (u64)arg->exitinfo2);
+			  rc, arg->exitinfo2);
 		goto disable_vmpck;
 	}
 
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index 49fc4341ac93..ef910e605ef0 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -56,7 +56,7 @@ struct snp_guest_request_ioctl {
 
         union {
                 __u64 fw_err; /* Name deprecated in favor of others */
-		sev_guestreq_err_t exitinfo2;
+		__u64 exitinfo2;
 		struct {
 			__u32 fw_error;
 			__u32 vmm_error;
-- 
2.39.0.314.g84b9a713c41-goog

