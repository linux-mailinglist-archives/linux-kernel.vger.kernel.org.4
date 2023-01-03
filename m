Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89ED65C2D9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbjACPQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237742AbjACPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:16:46 -0500
X-Greylist: delayed 299 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 07:16:46 PST
Received: from smtp122.ord1d.emailsrvr.com (smtp122.ord1d.emailsrvr.com [184.106.54.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA145F83
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1672758705;
        bh=J0bXZlq59YGPe6q2p0FZH6dSxQvGOs+tJINEcXenNX8=;
        h=From:To:Subject:Date:From;
        b=GePjypeetYkTwCJaVWn+Zus7KEu2P8YTZfptAQSU9swQnBgmzZG2Nug+Andk+AtS6
         jzeKVjF80FEowraaTWMU8YurI6bcMkxk2Seoa0fznXTCfs037VRkIysrNQZ6JNyCgi
         Jzo0fhWCABmDpJRm+9Mil8kufH3/uZh0d/ullj0o=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp16.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 78AF940169;
        Tue,  3 Jan 2023 10:11:44 -0500 (EST)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH] comedi: check data length for INSN_CONFIG_GET_PWM_OUTPUT
Date:   Tue,  3 Jan 2023 15:11:27 +0000
Message-Id: <20230103151127.19287-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 7ae8aec4-1a89-4677-b63d-079e463441cf-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comedi INSN_CONFIG instructions have different expected instructtion
data lengths depending on the type of configuration instruction
specified by the first word of data.  This is checked by
`check_insn_config_length()`.  There are a few configuration
instructions whose data lengths are not currently checked, usually for
rare configuration instructions that are implemented differently by
different drivers.  For unknown configuration instructions, the function
logs a warning and accepts the specified data length.

The `INSN_CONFIG_GET_PWM_OUTPUT` configuration instruction length is not
currently checked, but all the places it is currently used expect a data
length of 3.  (These places are `ni_get_pwm_config()` in
"ni_mio_common.c", and `pci1760_pwm_insn_config()` in "adv_pci1760.c".)
Make this length official by checking it in
`check_insn_config_length()`.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/comedi_fops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index e2114bcf815a..b982903aaa46 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1215,6 +1215,7 @@ static int check_insn_config_length(struct comedi_insn *insn,
 	case INSN_CONFIG_GET_CLOCK_SRC:
 	case INSN_CONFIG_SET_OTHER_SRC:
 	case INSN_CONFIG_GET_COUNTER_STATUS:
+	case INSN_CONFIG_GET_PWM_OUTPUT:
 	case INSN_CONFIG_PWM_SET_H_BRIDGE:
 	case INSN_CONFIG_PWM_GET_H_BRIDGE:
 	case INSN_CONFIG_GET_HARDWARE_BUFFER_SIZE:
-- 
2.35.1

