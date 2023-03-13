Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9015D6B7818
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCMMy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCMMy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:54:27 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD73260A85;
        Mon, 13 Mar 2023 05:54:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 63FE232003C0;
        Mon, 13 Mar 2023 08:54:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 13 Mar 2023 08:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1678712064; x=1678798464; bh=ShOvNCaiVb1qXeZ6+e4m27zlx12+5SzUfoS
        aGez+q+o=; b=muqztcjAbaNn28YbHI3oUc609na8rjJupYLXDJFOdvxW8A+KOcV
        SrwEXItYQQJqWTSfxmqN91Wz6f30QqTHLr5XxfVRABg9AN6r/EMt8F9mYL26I3NA
        Kw+Ep9Epn4qqny3RiUnWM9mmHfTIHXkquamNcBLt9IBfbfOTzjSvj8tV8VInd7Jp
        5m7i6jLb6wYQFULGGpx1GV8JzLbYvdafUxQ9FQuF47i8P3lNu0zR1dhzrUMJqc6s
        Llkmov4HhagnL/2yP5IrX90p7aaLzw2YTU0cKeZEyFJxpzDnEXvtCKPhbNyG1tL+
        ijK1cdXLn1kXRq0pqAc/cCxSnGrvEGTWONw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678712064; x=1678798464; bh=ShOvNCaiVb1qX
        eZ6+e4m27zlx12+5SzUfoSaGez+q+o=; b=uoNvQBbye88ynxGIGUpKKkN449hu+
        oYg48h2dRlrgsGRe+0Rq3pl8MhCskBWrLMaTu4dyPA7/OmQxXgSpX7aPAHES5J8H
        XG5ZV+om7bNCBKca+QGMuaLGHPFF3DIUHe0YdH4gtSjZsYgg6L5zYJUP1wZwzkfn
        ElgoZ+fzWTmV07yyAHZfEA/GS0eqeb7VWmrbHsqdBR89YtU7MY498bt08Ggrh3ty
        AEBwifj3Ql/WWHaeeRwmzvYJmbMT8CWkStBjlwbxcOIgkk1+Z21rUevNLUfLDnEa
        oP9t3bpoFT8UcWIC9NZ1YdhnV0dKQc7QoioOBxwNH7lfCS5/QVyLKhp2w==
X-ME-Sender: <xms:_xwPZCVkCZFDLlZhh7hYXmhKZt6tNoVgptNTQwv03UOXVlh-t4_Neg>
    <xme:_xwPZOn9CuEkLsgppICcDO9ZYN-XWJYD97vCXI3RUJFtU5IiXNVVN2Lj_DR16ROEL
    mQxnb4SZU40Qec>
X-ME-Received: <xmr:_xwPZGbK-cmsjvZIih9nkp8AUwzkX7EBd6DyJiqSJHnOkh3UX9tlta-KyL8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhimhhonhcu
    ifgrihhsvghruceoshhimhhonhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeeivefhkeevfeejvddvhefhtdduhfeigedvheevfeef
    teehkeeljeduueeitedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehsihhmohhnsehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtgho
    mh
X-ME-Proxy: <xmx:_xwPZJU9HrqcQnzBZEexwWZgVW2xhtQIEPBbjZTz9M6oNLB-nmWRuA>
    <xmx:_xwPZMna06EwkStcoBpRwtheVV1m0cWPMvOQZwvsYjbzxcZoYG6owA>
    <xmx:_xwPZOdZ970KE0w0P7uW6RbQRycq_E0-nQOcNCfPXp_pR1ebKvUtTA>
    <xmx:AB0PZBwYCqQiHNsQ8viEfaKWiJNHc7pBmpU_ZJzmOM6BbSyJogCTmQ>
Feedback-ID: idc5945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Mar 2023 08:54:21 -0400 (EDT)
From:   Simon Gaiser <simon@invisiblethingslab.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Gaiser <simon@invisiblethingslab.com>
Subject: [PATCH] ACPI: s2idle: Don't ignore error when enabling wakeup IRQ
Date:   Mon, 13 Mar 2023 13:53:44 +0100
Message-Id: <20230313125344.2893-1-simon@invisiblethingslab.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable_irq_wake() can fail. Previously acpi_s2idle_prepare() silently
ignored it's return code, potentially leaving a system that never wakes
up.

Discovered when trying to go into s2idle under Xen. This leads to a
system that can't be woken, since xen-pirq currently doesn't support
setting wakeup IRQs. Real s2idle support for Xen is another topic, but
now at least the user gets an error and the system doesn't needs an hard
reset.

Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
---

Note that I'm unfamiliar with the code so when reviewing please
carefully check if ignoring the error was indeed unintended.

If there are indeed cases where the error should be ignored I would
submit a patch that at least logs the error, although the error message
would be hard to see with broken wakeup.

 drivers/acpi/sleep.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 4ca667251272..c69dd3731126 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -714,7 +714,15 @@ int acpi_s2idle_begin(void)
 int acpi_s2idle_prepare(void)
 {
 	if (acpi_sci_irq_valid()) {
-		enable_irq_wake(acpi_sci_irq);
+		int error;
+
+		error = enable_irq_wake(acpi_sci_irq);
+		if (error) {
+			pr_err("Failed to enable wakeup from IRQ %d: %d\n",
+			       acpi_sci_irq,
+			       error);
+			return error;
+		}
 		acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
 	}
 
-- 
2.39.2

