Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4C8649C3F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiLLKe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiLLKdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:33:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0A011A2D;
        Mon, 12 Dec 2022 02:29:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48426B80CA7;
        Mon, 12 Dec 2022 10:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001F4C433EF;
        Mon, 12 Dec 2022 10:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670840980;
        bh=pd20HLGXJB+83WJGfVgnB4t8xEpwduo8hUzg5RGBfFY=;
        h=From:To:Cc:Subject:Date:From;
        b=DApaj4KGdmw4jxceFBw2m0HnkTg1ZzcQn3dgzC6MIOnywBEdvqB6Lijeyhs8cPkPu
         sTfD1+DNsewxzFvnJ6RjHB+7lRzmhCAdNr3xNKpzwJ6tGK1cRLyPsR0hqY8cIZLuY8
         j+MJWUNQ7hNy5srYJjfO2WhiRxxXsAe6PCja74HI9HnRvoGOyfV3l0ygwVIdJv01D/
         h5ucUWSJviu3MBZ8mL0WxUdnPki6ZeKbmzM4DVy8w7SRtZynJgVLy//qVtNZYb1ZvQ
         C6WXS7245xiz4B+K7U1iprPpcB2sqEP1rfog7Dm7PWxIqSKn2lt0a/tjLo6fY6Zxx2
         qcUSm5JgCE07A==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     mika.westerberg@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Martin Liska <mliska@suse.cz>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2] thunderbolt (gcc13): synchronize tb_port_is_clx_enabled()'s 2nd param
Date:   Mon, 12 Dec 2022 11:29:36 +0100
Message-Id: <20221212102936.23074-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tb_port_is_clx_enabled() generates a valid warning with gcc-13:
  drivers/thunderbolt/switch.c:1286:6: error: conflicting types for 'tb_port_is_clx_enabled' due to enum/integer mismatch; have 'bool(struct tb_port *, unsigned int)' ...
  drivers/thunderbolt/tb.h:1050:6: note: previous declaration of 'tb_port_is_clx_enabled' with type 'bool(struct tb_port *, enum tb_clx)' ...

I.e. the type of the 2nd parameter of tb_port_is_clx_enabled() in the
declaration is unsigned int, while the definition spells enum tb_clx.
Synchronize them to the former as the parameter is in fact a mask of the
enum values.

Cc: Martin Liska <mliska@suse.cz>
Cc: Andreas Noever <andreas.noever@gmail.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---

Notes:
    [v2] switch to uint instead of to enum

 drivers/thunderbolt/tb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index f9786976f5ec..6c4a26b1c37c 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1047,7 +1047,7 @@ void tb_port_lane_bonding_disable(struct tb_port *port);
 int tb_port_wait_for_link_width(struct tb_port *port, int width,
 				int timeout_msec);
 int tb_port_update_credits(struct tb_port *port);
-bool tb_port_is_clx_enabled(struct tb_port *port, enum tb_clx clx);
+bool tb_port_is_clx_enabled(struct tb_port *port, unsigned int clx);
 
 int tb_switch_find_vse_cap(struct tb_switch *sw, enum tb_switch_vse_cap vsec);
 int tb_switch_find_cap(struct tb_switch *sw, enum tb_switch_cap cap);
-- 
2.38.1

