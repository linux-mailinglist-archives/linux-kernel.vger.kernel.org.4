Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A11675875
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjATPYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjATPYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:24:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAB9D05EF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674228233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+e8LXuZohWsWAKx1dvrBva8MxDrnRmzpeJF6iBcKD4=;
        b=eGsMP6o2okaxM4mgNZJIsIDwRKDULHo9+lF2jm7p8eu62jkhmwKNN1bNyx4mTF+Vb0YkSj
        2lkUWzHNZmwQjdQtTrEamXHP8DQKmgtM4NJQJEFR8f9UA5oMtZTt9F/D9nUPJ7bgT/YZzr
        Y84Qlqj1T2hFjCQlmazu+UR1mn60Ovk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-73-0Gxxc3-MNAayknGs_O_mcQ-1; Fri, 20 Jan 2023 10:23:51 -0500
X-MC-Unique: 0Gxxc3-MNAayknGs_O_mcQ-1
Received: by mail-ed1-f72.google.com with SMTP id x5-20020a05640226c500b0049e840f68feso2741483edd.23
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+e8LXuZohWsWAKx1dvrBva8MxDrnRmzpeJF6iBcKD4=;
        b=fUZxkb5r3ApxFYws3Ibsn8kOL2LIiTJ/cn22yDQ2J1vh0uuWEMdDrFuf0Y4dHAMfNI
         n+jROVw7TtZOHlFxxblGads1sdyiuLcOUM3WrJkOcIgtL/6tDtGPDaLUlUZbI4Fo1w5t
         uD5scEEcqBuei7W5c1bni6ubyL7fF8yLJ5VqEJZAM0xo/Yy0zsJI6VBLnTf7aErHlqRo
         oozv1janF3cNdWz9dqzhjusi21kv+KzpTUvJmlbbBhmhR+Ez4WNbPrTMUPvTkzuo2vUY
         htM0GCV2BSE744oaxJ8YmpyHOW9DUobn8mN+J4fWgUHF0oAm5Q3WAqB9cJ+JjrpaFzOg
         6Dkw==
X-Gm-Message-State: AFqh2ko8PNUznRH6yKjTU2B3gUGAGeyRsmP1KqxbgoxSkarxx3au6OGe
        77N+iSwpiFJF9g0v0+77M4dW6cBZzaG3ViqtjqJngW5FVPAcl617zWloDRAt0gz0tyCY2ENLGIB
        UPsXOwluwn37sabHLZaue7Nyf
X-Received: by 2002:a17:907:c019:b0:867:ef3f:dd85 with SMTP id ss25-20020a170907c01900b00867ef3fdd85mr12923881ejc.56.1674228230751;
        Fri, 20 Jan 2023 07:23:50 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsMEOaz7fsloftAxJvTFdFe440vrPpM2DDvZFE55XjUBpJy1hWqEcm+5zW5lIHpijYVTDtVDQ==
X-Received: by 2002:a17:907:c019:b0:867:ef3f:dd85 with SMTP id ss25-20020a170907c01900b00867ef3fdd85mr12923863ejc.56.1674228230607;
        Fri, 20 Jan 2023 07:23:50 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id s16-20020a1709067b9000b00872eb47f46dsm5706976ejo.19.2023.01.20.07.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:23:49 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com,
        david@fromorbit.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v3 1/6] fsverity: Export fsverity_get_digest
Date:   Fri, 20 Jan 2023 16:23:29 +0100
Message-Id: <f5f292caee6b288d39112486ee1b2daef590c3ec.1674227308.git.alexl@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1674227308.git.alexl@redhat.com>
References: <cover.1674227308.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Composefs needs to call this when built in module form, so
we need to export the symbol. This uses EXPORT_SYMBOL_GPL
like the other fsverity functions do.

Signed-off-by: Alexander Larsson <alexl@redhat.com>
---
 fs/verity/measure.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index 5c79ea1b2468..875d143e0c7e 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -85,3 +85,4 @@ int fsverity_get_digest(struct inode *inode,
 	*alg = hash_alg->algo_id;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(fsverity_get_digest);
-- 
2.39.0

