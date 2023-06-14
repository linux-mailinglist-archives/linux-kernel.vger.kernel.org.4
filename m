Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F437304CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjFNQVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjFNQVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:21:36 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C90A2130;
        Wed, 14 Jun 2023 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=EqZ69WEViIG68qz/W0eV6BOXBynqyp/2ao5vcAHxPoc=; b=L
        4XKwqwOMMnXlJ/sGtIYoX7nBQWfBcnc0EoTP8IxbgWlH2UFiTsTVi/x1ANapZAnH
        n/UfAvVT3T0Uu3wPwPJ1UflO41Ys/ehz+i7wWC01HN6b6y1ZPuANOFA8Byuibbv9
        Nv/x2sbMjJSBn5bUa3IaKsi1Nr7bKCjHsrpa9qFOAI=
Received: from ubuntu.localdomain (unknown [10.230.35.76])
        by app1 (Coremail) with SMTP id XAUFCgC3v__56Ilk9+rsAA--.38427S2;
        Thu, 15 Jun 2023 00:21:14 +0800 (CST)
From:   Chenyuan Mi <cymi20@fudan.edu.cn>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Chenyuan Mi <cymi20@fudan.edu.cn>
Subject: [PATCH] ACPICA: Fix missing check for return value of acpi_ns_get_attached_object()
Date:   Wed, 14 Jun 2023 09:21:12 -0700
Message-Id: <20230614162112.122816-1-cymi20@fudan.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: XAUFCgC3v__56Ilk9+rsAA--.38427S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF47uFWrJF4rXFyxXF48tFb_yoWkCFcEga
        s3GFn3Wr1YkF4Skr1akrWrArWayr1fXrn2vF1DtFWfCr1rZF98Jr1rJFnxZr9rZa4kKFW3
        Ja1aya47Cr1I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbV8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
        0VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUAkucUUUUU=
X-CM-SenderInfo: isqsiiisuqikmt6i3vldqovvfxof0/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_ns_get_attached_object() function may return
NULL, which may cause null pointer deference, and most
other callsites of acpi_ns_get_attached_object() do
Null check. Add Null check for return value of
acpi_ns_get_attached_object().

Found by our static analysis tool.

Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
---
 drivers/acpi/acpica/exprep.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 08196fa17080..d9c006ec1ac8 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -431,6 +431,13 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 		obj_desc->field.region_obj =
 		    acpi_ns_get_attached_object(info->region_node);
 
+		if (!obj_desc->field.region_obj) {
+			ACPI_ERROR((AE_INFO,
+				    "Null Region Object during field prep"));
+			acpi_ut_delete_object_desc(obj_desc);
+			return_ACPI_STATUS(AE_AML_INTERNAL);
+		}
+
 		/* Fields specific to generic_serial_bus fields */
 
 		obj_desc->field.access_length = info->access_length;
-- 
2.17.1

