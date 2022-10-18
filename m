Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1E16027DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiJRJEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiJRJEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:04:14 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2D4A99E2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:04:13 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 128so12779672pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b6jXP5rr3Q3qr2aS0J/xPsH/umdUTreFu1h1A3gs3aQ=;
        b=QD4p8BVwUzYqkWzz2ygyWHyNq1FIy96vtCbm2AnS4pnHfAaMUZBACOmUP723SmnxmG
         6CN/3G3T88NUXcyQt+k7UJXGvpKbncl+CvCjf9vBmAiGym3FoibWLy5TLCOwLu80Kxdy
         wwHNIk3ih9Cgte0TRQoUo8aYLFcu0hF5V5dY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6jXP5rr3Q3qr2aS0J/xPsH/umdUTreFu1h1A3gs3aQ=;
        b=hWCf4cHvHUGAWqeFhYqOCacNyDNm6Z0qlwPnfRuTWvU/WVeUUS9hOF/eVic5HygzIh
         Blu8wc9XsEoiLQp+fgcq8JgK7+8EiQLmknbxUz8TgiyHe5GwL4iT1mpazX5r1cbjH506
         fq9T/LUEmWUTpkW7qe4vNxejQnLufdmttCIkc0DLfqgbjR9iGZw5TgKQRt7fb4j6GmCa
         SalmwjwrmZNwIUd108o2O76vd50vHTnyit6kAMlZe2bWtobKBZh14fpvBiioE5oqE4Pj
         Inxvei87VTLjnzZsmq6n5QwkI6iOVxoPE/mnrtj47Iw5Rt7Jzc1hc9kymlxQWARKW6nN
         gW+g==
X-Gm-Message-State: ACrzQf3d2x6cQcy6rNbjfXLuTAcJI+vAYfatmBppz/eorzU5kAlIwjeA
        1HSsAfD+SUVs95lid3ZcTi2nPNdekIoa1g==
X-Google-Smtp-Source: AMsMyM5tncSStMmm7cz0EpJNuUki11273cPYl4K7HZtPwAdktvxqKe+AvV3DtABdJHBV+yJGxWiTrQ==
X-Received: by 2002:a05:6a00:148a:b0:566:10d8:9404 with SMTP id v10-20020a056a00148a00b0056610d89404mr2197357pfu.84.1666083853227;
        Tue, 18 Oct 2022 02:04:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g17-20020aa796b1000000b00561b3ee73f6sm8816229pfk.144.2022.10.18.02.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 02:04:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] devres: Use kmalloc_size_roundup() to match ksize() usage
Date:   Tue, 18 Oct 2022 02:04:10 -0700
Message-Id: <20221018090406.never.856-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=845; h=from:subject:message-id; bh=VRjJ85d7FRzO9QdnNALjjPmlohFMyyDeN2Qy48G2Wdc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTmwK5HjmNau/2Z8OSw58zvrURKnB0+VP8PGWljZU GGlZDbCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05sCgAKCRCJcvTf3G3AJmVID/ oDsrYusLzCt85XakVLHBFAmwjiMokMARd8n10E7KTaSxXIUmltwvhx4/yIRmnqwhaXd7y0AG7kNTBy wEb9lwJ8TLrPox+5gjU5C9+NWbMecYR7jAtYyMTtiViFf22JpUc8oSfmrEOzzRX5HlcjTeWgHcyMY+ 4D2Hg4s1XVdHW3uTUy4QMueoZl+svJ1tNYTcd8cQHgbU3l8NtUMh0HN1V7q496B71EsV05Z2QxLV/m 8RX61dFy7n7npWNnwOnnUj1HAvgY8y1SanH2MwhzrkyYWFJ8LEY0EZgXhPGG679HeWfLj5DBcps6UL ZDZRmuJ7bwnvjeivE8L8MS95G0KOc8rgaeX0B0P5rwmQQu738HB0PbVoGR7UBxPc1+nYE0yRvUaWaM rzoIUrtKPapTaiQD2iPKR62e4cBWVQtH0KnJj2NYRuV8WdrY1HRTk/tgQc7A6k8FCMomzmI0MraGuK 22kLZEe8+19L39ybrgAp4E2DR/XHpi3k/ar/Yx0HBXppFR8WtYhSLzF7AbcpREds4r29I7+DwslIuE c1b3gf6dUcUEk+56nb1seyE9vfobXTTW+lWYjDuNrHJWTUrYx4F+iK1CAVM/v7+M8aJ9BQUi0MD/vf ruH8lfb1WQRLCoWlKhUi4rRajDs9+hZC+gDj6xcDzVyZJf3Bq1dArIflUgEw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Round up allocations with kmalloc_size_roundup() so that devres's use
of ksize() is always accurate and no special handling of the memory is
needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/devres.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 4ab2b50ee38f..c0e100074aa3 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -101,6 +101,9 @@ static bool check_dr_size(size_t size, size_t *tot_size)
 					size, tot_size)))
 		return false;
 
+	/* Actually allocate the full kmalloc bucket size. */
+	*tot_size = kmalloc_size_roundup(*tot_size);
+
 	return true;
 }
 
-- 
2.34.1

