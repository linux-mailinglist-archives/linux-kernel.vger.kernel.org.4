Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEEF6F2E2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjEADVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjEADRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658BA6A6B;
        Sun, 30 Apr 2023 20:07:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A990660EA5;
        Mon,  1 May 2023 03:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EFBC4339C;
        Mon,  1 May 2023 03:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910422;
        bh=342p/LqQZxMeFHrcgAvtHLZungpIv0bcCYZMTUCByCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BUyS2tovNLkZsM5z16dnFJRuJ/ifuV+NRM+Bnvha4DisAud3QhAvhJGTLBKj8IW08
         dVYSljPxgbbHHDxdBvzEdU1uzydj86wHrsRygpfcm79J6j6KC37L1ch/l9R+nUU6aM
         FCywIBpV0amCPVnoUAyH+qvrmG5Xp/AvxzS3e3esBaRFabvqcLHq3T6jh2H8ojk71Z
         73HUetknduH85klXN/862sSZ3KzUAFcaQLs0yrg1pYLg0ZYkOYtNIRM7dDuSqv0gm9
         XSBqp2XSU/htL734XcXhew8ieLaknA2WpyeS35e9PlVK9TEXgtLseeU7aXB8NvE4mg
         eCN2p0ADS11AA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     void0red <30990023+void0red@users.noreply.github.com>,
        Bob Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Subject: [PATCH AUTOSEL 4.14 6/6] ACPICA: ACPICA: check null return of ACPI_ALLOCATE_ZEROED in acpi_db_display_objects
Date:   Sun, 30 Apr 2023 23:06:52 -0400
Message-Id: <20230501030653.3255321-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030653.3255321-1-sashal@kernel.org>
References: <20230501030653.3255321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: void0red <30990023+void0red@users.noreply.github.com>

[ Upstream commit ae5a0eccc85fc960834dd66e3befc2728284b86c ]

ACPICA commit 0d5f467d6a0ba852ea3aad68663cbcbd43300fd4

ACPI_ALLOCATE_ZEROED may fails, object_info might be null and will cause
null pointer dereference later.

Link: https://github.com/acpica/acpica/commit/0d5f467d
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/dbnames.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index 8c207c7725179..658fd7cfbd6cd 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -600,6 +600,9 @@ acpi_status acpi_db_display_objects(char *obj_type_arg, char *display_count_arg)
 		object_info =
 		    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_object_info));
 
+		if (!object_info)
+			return (AE_NO_MEMORY);
+
 		/* Walk the namespace from the root */
 
 		(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
-- 
2.39.2

