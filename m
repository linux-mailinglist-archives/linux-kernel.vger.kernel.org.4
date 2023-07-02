Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BD4744DFD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 15:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjGBNpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 09:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBNpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 09:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E4BE55
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688305468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CQPmY3YgKkcmXgnTKyyGhzbqz5W1ZZqveUHs3/0dmWg=;
        b=YxvNe237GKBDvIvRrtkSSbrQUbBY8L/mJFdDxQyuY4ybMTcF9VcXXLN9KvOKCpIpMZ0SFT
        y5igGxH0JyU2em1yHaBJhKx5Du2sTRnRSwGPJ5+SSaF2H0sXzmCutbXfjiruSO3hxUHOpf
        xSbPx1XrHXrhoQvrZIKAl8FldXdG6rI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-_L14SLDAP9W8p_ANxPXNTQ-1; Sun, 02 Jul 2023 09:44:27 -0400
X-MC-Unique: _L14SLDAP9W8p_ANxPXNTQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635e91cba88so39209106d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 06:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688305467; x=1690897467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQPmY3YgKkcmXgnTKyyGhzbqz5W1ZZqveUHs3/0dmWg=;
        b=GnMUBI5B0V6W2ll0OVUG9ZkHfxXDgdjwk/A/q8odguH6ss5xPL033Sbi/i5N7zp8ew
         PsJn2P3Osb1IW4Xjarv7DVq+hjZrIqkiumyx0eFImEnL9CeCDpzea8fCpNJbGEJOspr6
         5BnZqPjuXl/6vcmtk3k4LLmWQF+nQJyeJDmF7y3vruUoLDZxXPjnbOmPK8Hm7YU6Qktl
         RP3ROFybKCkxce46MJjckiUP3gXCll/0Cd7wfQbqpEJ2Hj71JLfsQva4hIvFx3fv9Eq9
         rO2edE/PR+/BLG6Qi1FZQoAfJqb2NORwvvlgD84QsR2/1fTI/KXoTMohlp99u9SsQ1VY
         euvA==
X-Gm-Message-State: ABy/qLbB8oTyTjRUBfyz8ZrjJvD5KyFgbjSAZeAjBFxe5+1Vmz8icBUW
        JxW5hpXMnhKXOx42kpW81xsW1gylb0NDeIlRQU+kQm/76o1llywVIZrygTy3yhALmhmin0FD7xy
        X9gbuatx/b4L+WO9XLTZRsISq
X-Received: by 2002:a05:6214:5194:b0:631:f964:7ab with SMTP id kl20-20020a056214519400b00631f96407abmr10042635qvb.60.1688305467301;
        Sun, 02 Jul 2023 06:44:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH9Hw7Cw7EnZSWaMX/eP2Tdd0HP/I5KQYDhe7mnH4i7QSQGHSQxDgxErkRJk4MklEI+1ytGlw==
X-Received: by 2002:a05:6214:5194:b0:631:f964:7ab with SMTP id kl20-20020a056214519400b00631f96407abmr10042627qvb.60.1688305467128;
        Sun, 02 Jul 2023 06:44:27 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id ep8-20020a05621418e800b00630182f0191sm10227585qvb.1.2023.07.02.06.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 06:44:26 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     djrscally@gmail.com, hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] platform/x86: int3472/discrete: set variable skl_int3472_regulator_second_sensor storage-class-specifier to static
Date:   Sun,  2 Jul 2023 09:44:19 -0400
Message-Id: <20230702134419.3438361-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/platform/x86/intel/int3472/clk_and_regulator.c:263:28: warning: symbol
  'skl_int3472_regulator_second_sensor' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/platform/x86/intel/int3472/clk_and_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/int3472/clk_and_regulator.c b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
index 61aeca804ba2..ef4b3141efcd 100644
--- a/drivers/platform/x86/intel/int3472/clk_and_regulator.c
+++ b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
@@ -260,7 +260,7 @@ static_assert(ARRAY_SIZE(skl_int3472_regulator_map_supplies) ==
  * This DMI table contains the name of the second sensor. This is used to add
  * entries for the second sensor to the supply_map.
  */
-const struct dmi_system_id skl_int3472_regulator_second_sensor[] = {
+static const struct dmi_system_id skl_int3472_regulator_second_sensor[] = {
 	{
 		/* Lenovo Miix 510-12IKB */
 		.matches = {
-- 
2.27.0

