Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4716F6410A7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbiLBWdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbiLBWdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:33:41 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC43FD07;
        Fri,  2 Dec 2022 14:33:39 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r26so8206440edc.10;
        Fri, 02 Dec 2022 14:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbJ18LAT9an/pDAz9Nw5nBcBjSUSHEByKAYbNNUtlYA=;
        b=VLCLkNLeQVtnJpjeks0ZFTraYAYw730AEzkkSm91i0rWDWMwJOJAwoaQ7nzKOfRGZz
         lVLPW1WwC7IAwSNB/kYEYnni0y+lL5m6ytRh0MDLmZUC9EuYzh9KGgbU0jeYiC7gwxrk
         AgXs5PofaG1Vn1TTTkuTBuWt3PTf+k9GY6XDztvr6Y7nczdczxs4qX8v8Vu3HargJM3y
         BeukPcXYVLmf2OQTmzWiE03F42PkFwsPaKhA7B9w6lyE5ojTRZ6MYt7FmjWLnth3tAec
         4g4HusyWoPjA7JgB/DI7H6uLX9ONlzjXEgZi+6stQgQxNrA41R/c2JkVz+eZWN7FbUpr
         3F+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbJ18LAT9an/pDAz9Nw5nBcBjSUSHEByKAYbNNUtlYA=;
        b=dMj2oOFhLd4g9/vEBMOOZLRFlXNs8ogPcYLR/Gg/OpII8KzrNjpmg6wneWisInz1MU
         rQh8ZGFOjsPokWJtwpfR7Ov8/pOIzo9k8nYTNqhiujsSsxlQoe84yq22GtvHWlDMP5K4
         yuiPnuLbWxyHR0SQJSU3LiyVC0Qs+Kp715yaPJKY3QuYqLepoIn6hhZVmYdnVxnYDRu0
         dKETJGZQi7/xE+8Lh0aeRniBsJQkRoUyNT4bTJbzaO7YGLX1lBuBA8HZHN6Kjnk/ucsY
         nqtQ8+OCk/aaB3OlVkz3xvrp3x41KfEUGGrVhNcY7BtFz6H5eoooB31BMi7fX4VDIYJL
         jc+A==
X-Gm-Message-State: ANoB5pmxqu8W8W7Zy5ojyKtxb8vNz7ACGgPt1tmnyHI/AD8nG8hGpDmZ
        HxImBnMR2N9t+52A5UQAu+A=
X-Google-Smtp-Source: AA0mqf510SaBH9hnhgQdFhuTS22WouLL0S7lMB5FKfj7YsuSOf6TG839CY3tGz2po+yO00Q554nThQ==
X-Received: by 2002:aa7:cf82:0:b0:46b:34b:5804 with SMTP id z2-20020aa7cf82000000b0046b034b5804mr25495060edx.240.1670020418316;
        Fri, 02 Dec 2022 14:33:38 -0800 (PST)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b007c0d0dad9c6sm575340ejg.108.2022.12.02.14.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:33:37 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] platform/surface: aggregator: Ignore command messages not intended for us
Date:   Fri,  2 Dec 2022 23:33:19 +0100
Message-Id: <20221202223327.690880-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202223327.690880-1-luzmaximilian@gmail.com>
References: <20221202223327.690880-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that we (the host/kernel driver) receive command messages
that are not intended for us. Ignore those for now.

The whole story is a bit more complicated: It is possible to enable
debug output on SAM, which is sent via SSH command messages. By default
this output is sent to a debug connector, with its own target ID
(TID=0x03). It is possible to override the target of the debug output
and set it to the host/kernel driver. This, however, does not change the
original target ID of the message. Meaning, we receive messages with
TID=0x03 (debug) but expect to only receive messages with TID=0x00
(host).

The problem is that the different target ID also comes with a different
scope of request IDs. In particular, these do not follow the standard
event rules (i.e. do not fall into a set of small reserved values).
Therefore, current message handling interprets them as responses to
pending requests and tries to match them up via the request ID. However,
these debug output messages are not in fact responses, and therefore
this will at best fail to find the request and at worst pass on the
wrong data as response for a request.

Therefore ignore any command messages not intended for us (host) for
now. We can implement support for the debug messages once we have a
better understanding of them.

Note that this may also provide a bit more stability and avoid some
driver confusion in case any other targets want to talk to us in the
future, since we don't yet know what to do with those as well. A warning
for the dropped messages should suffice for now and also give us a
chance of discovering new targets if they come along without any
potential for bugs/instabilities.

Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
Note: I've simplified this commit so that it can be applied
independently of the rest of the series for easier backporting.
---
 .../surface/aggregator/ssh_request_layer.c         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
index f5565570f16c..69132976d297 100644
--- a/drivers/platform/surface/aggregator/ssh_request_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_request_layer.c
@@ -916,6 +916,20 @@ static void ssh_rtl_rx_command(struct ssh_ptl *p, const struct ssam_span *data)
 	if (sshp_parse_command(dev, data, &command, &command_data))
 		return;
 
+	/*
+	 * Check if the message was intended for us. If not, drop it.
+	 *
+	 * Note: We will need to change this to handle debug messages. On newer
+	 * generation devices, these seem to be sent to tid_out=0x03. We as
+	 * host can still receive them as they can be forwarded via an override
+	 * option on SAM, but doing so does not change tid_out=0x00.
+	 */
+	if (command->tid_out != 0x00) {
+		rtl_warn(rtl, "rtl: dropping message not intended for us (tid = %#04x)\n",
+			 command->tid_out);
+		return;
+	}
+
 	if (ssh_rqid_is_event(get_unaligned_le16(&command->rqid)))
 		ssh_rtl_rx_event(rtl, command, &command_data);
 	else
-- 
2.38.1

