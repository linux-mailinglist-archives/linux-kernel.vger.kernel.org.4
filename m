Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A83695017
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjBMS6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjBMS5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:57:51 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97482212F;
        Mon, 13 Feb 2023 10:57:48 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-16a7f5b6882so16261904fac.10;
        Mon, 13 Feb 2023 10:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70NV1ToQYw50ymKhliFnw04sCbSTdpnLCftKunJ8RHg=;
        b=g9sh5Qacww+llc+gZ856ZATND/GgMxZmJwDrrtBnaKgEjkHC9HhL54iHcxadntNZe4
         GRl3VCNHl6m76J0dEebp8wkYjxq796dfRE1az472jTwiWwcTUY4buwcCj59n1ZADxf+y
         sD+qVetPtACRyLrtREXLIhnjO7Gzk9Rj1ikXBkJL3KKhhoTsvjJIBZYcPqAasR/IJAyP
         5mA3P7Eiv4/c8Ty1/S9VKNG/i9nR+9zMfnPyqgGcKqu9cugjiItlBaBVKDQ6xUYwisVK
         8tou11iSWFraZ1qBqqshAHKBu0RrdFVSbESIIuDSCWumnjWUuajZz5ZXiVQwQQjVEO9Y
         GD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70NV1ToQYw50ymKhliFnw04sCbSTdpnLCftKunJ8RHg=;
        b=UEX4beqUh/ySTAoGzvytlBfO/za9kg0fsjApiox0RbOf5ckMCPBblU8g5ReqfgPMIR
         FFM9BbYq5TlVP/k6U2nGkWwkHolvoM+pG4hpL306dNoH93F6lS6aRI+orsvDWSFmljhY
         ZexHPyfa+ydsU48vJVOrxQ6sVIBdNi8yLewv0QD5P5EUoShS6ZXpld1ZGMOwlZryG5CZ
         TNL6rERpenGAW0AlqvjkpIp6l4VdIGs/xRq3+fNXlxFmXJetQRUv4ik1Q42/xlPYfmRZ
         3zOQVpR+58oPaFSvGYH3HU0K+fuF7eDzjF2rZ8QoW12jJS6sGPjoKvx7JiLcKNw8IU2o
         AA3w==
X-Gm-Message-State: AO0yUKXNJHIg6tMcoiiOL4tVoEA3XkSTKg5OMh8NmZygcD7U+6YKiIDL
        N+1ZumBle1v6Bf5zIltpoqc=
X-Google-Smtp-Source: AK7set+cvl5+hpmINRUSDSryaTu8+KC6HXmo+LEi3o7wg74EiR7EvbaCqJUXMaN5mxLyhJKZxk7/2Q==
X-Received: by 2002:a05:6870:c68c:b0:16d:bbce:29d6 with SMTP id cv12-20020a056870c68c00b0016dbbce29d6mr6703085oab.25.1676314668277;
        Mon, 13 Feb 2023 10:57:48 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:5829:dabf:a50e:e9f2])
        by smtp.gmail.com with ESMTPSA id ef15-20020a0568701a8f00b0016df97ab05bsm1654958oab.31.2023.02.13.10.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:57:47 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] of: add consistency check to of_node_release()
Date:   Mon, 13 Feb 2023 12:57:01 -0600
Message-Id: <20230213185702.395776-7-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213185702.395776-1-frowand.list@gmail.com>
References: <20230213185702.395776-1-frowand.list@gmail.com>
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

Add an additional consistency check to of_node_release(), which is
called when the reference count of a devicetree node is decremented
to zero.  The node's children should have been deleted before the
node is deleted so check that no children exist.

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
---
 drivers/of/dynamic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index dbcbc41f3465..657a65006056 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -377,6 +377,10 @@ void of_node_release(struct kobject *kobj)
 			       __func__, node);
 	}
 
+	if (node->child)
+		pr_err("ERROR: %s() unexpected children for %pOF/%s\n",
+			__func__, node->parent, node->full_name);
+
 	property_list_free(node->properties);
 	property_list_free(node->deadprops);
 	fwnode_links_purge(of_fwnode_handle(node));
-- 
Frank Rowand <frowand.list@gmail.com>

