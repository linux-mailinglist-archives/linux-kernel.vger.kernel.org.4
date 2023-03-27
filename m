Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D706C9D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjC0ITQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjC0ISx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:18:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D02444AE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1A8FB80EBE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB30C433D2;
        Mon, 27 Mar 2023 08:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679905112;
        bh=9t0cjx0L/FLsmroHFm0u19SkOnzyUFj2X8tdR02p+qM=;
        h=From:To:Cc:Subject:Date:From;
        b=ZAAkBg8eewEHp+8nMBEQ9oRlD3ru3FHPTjBRPNlZwQFK+6B3aDZRR1SjIHSTcKL8v
         krj/05l/1aWuHhZNGf6Jpa6VX2w8Fi/Wnw/BT7/Wmo3jbjYXSojamPKqnEstJ+xmMb
         FwIMr65Ni3/l1+cMZyIf8MwdQVTJfrwIowYClWI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] driver core: class: fix documentation for class_create()
Date:   Mon, 27 Mar 2023 10:18:28 +0200
Message-Id: <20230327081828.1087364-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=gregkh@linuxfoundation.org; h=from:subject; bh=9t0cjx0L/FLsmroHFm0u19SkOnzyUFj2X8tdR02p+qM=; b=owGbwMvMwCRo6H6F97bub03G02pJDCmKgUEMgZ/E1aI9vmhL9K36lV4nxmR0UcQkrd5r43pj6 Svl7+o7YlkYBJkYZMUUWb5s4zm6v+KQopeh7WmYOaxMYEO4OAVgIh+PMiw4avZ3x77EbytvT1sQ Hr9nm7kgr8kvhrliTt+VZ8Vx2nyI1thxtVayZk20WxwA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit dcfbb67e48a2 ("driver core: class: use lock_class_key already
present in struct subsys_private") we removed the key parameter to the
function class_create() but forgot to remove it from the kerneldoc,
which causes a build warning.  Fix that up by removing the key parameter
from the documentation as it is now gone.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: dcfbb67e48a2 ("driver core: class: use lock_class_key already present in struct subsys_private")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/class.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index dbaeb79ae917..0f8938a17144 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -223,7 +223,6 @@ static void class_create_release(struct class *cls)
 /**
  * class_create - create a struct class structure
  * @name: pointer to a string for the name of this class.
- * @key: the lock_class_key for this class; used by mutex lock debugging
  *
  * This is used to create a struct class pointer that can then be used
  * in calls to device_create().
-- 
2.40.0

