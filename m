Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB5D712623
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjEZMBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjEZMBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:01:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6329895
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:01:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30a8fa6e6fcso397426f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685102498; x=1687694498;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yND35ais/ukG+uTh3KH7a9De2YZqNP7mXDsC69SJnlM=;
        b=zndeBKmy7vQdUTShwT7eFAF2WU52kDQMUlI0H12GCJW6/ahrt9Il9Hh+H+SrXRFzHj
         XrLC0QNjJcyxx8a72Ot+6CHWW7I1Dgeyl1zIi5z9zeIGyChZBJouAnD4Fi2R6nJEwAGI
         HrZ8UVsuxNUjSwLLB66hGTKSYOnum68DamLumhQbIxpWuWi67/be+NBFqfslwKkYFlWQ
         F1P2EGpD4GumkJVXl9TPChj97/Ymunj9GEqDPKaP7x4fuSZLytOrUTMMk89XsxeHG5wN
         WsEeBwX9dEFV3m9jO64u3e1FaJjm867hwl+D3FNMFVWyNMwvzhN1PXuVxu+r2JrS5CXU
         /qBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685102498; x=1687694498;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yND35ais/ukG+uTh3KH7a9De2YZqNP7mXDsC69SJnlM=;
        b=QFVpUX9ZHP4wsflPpzfrs+JL8Dlwe6qn9LJfAImAA6Mum0qjIdmn4XVqugjE0Jgz9v
         sGzt9N9I3Qr5T6+eE2jqRg1y8RpDwBqpePJfZhgKe1N4lhhJxj4bvDOh4umuXO5eLISV
         rfPOYfh8FxOJoBlkJQlbNQ9usvzzkGbofv3Jsf4nXlDrpFsqbNa/tWiXz5lrIAJYW1yg
         U+Vv3XXCYhUOgWJBsuI5Ek3QmmmZbPAncZ/3Pm2Slkt1VKaFEOxHms7hWgWXFYYC2tbd
         dqkhLPG+eTeHrMrzHM6oW2+nG0+mgqv7LcYCMzJBGZLNL/F3aMy0Pm1os4nRMiWj9ZMs
         35vQ==
X-Gm-Message-State: AC+VfDw5xgO+X0BH50J1ggS139hsD2qINW8kBrgr6fPON5KwMkdNhvvi
        EpukHcaUvpwpQgJyQV7WYPuYmw==
X-Google-Smtp-Source: ACHHUZ47+6xfUhFicStwKDOze5EQJV3MIf1AL/SQeZmtUnb4T3OshVkP4bhO87fqG4B9/SaKC8feCQ==
X-Received: by 2002:a5d:404b:0:b0:306:2c16:8359 with SMTP id w11-20020a5d404b000000b003062c168359mr1339056wrp.39.1685102497818;
        Fri, 26 May 2023 05:01:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e21-20020a05600c219500b003f604ca479esm8609669wme.3.2023.05.26.05.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 05:01:36 -0700 (PDT)
Date:   Fri, 26 May 2023 15:01:33 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Steve French <sfrench@samba.org>
Cc:     Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] smb: delete an unnecessary statement
Message-ID: <077d93ae-adbf-4425-9cc4-eea5163b050c@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to set the list iterators to NULL before a
list_for_each_entry() loop because they are assigned inside the
macro.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/smb/client/smb2ops.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 5065398665f1..6e3be58cfe49 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -618,7 +618,6 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 		 * Add a new one instead
 		 */
 		spin_lock(&ses->iface_lock);
-		iface = niface = NULL;
 		list_for_each_entry_safe(iface, niface, &ses->iface_list,
 					 iface_head) {
 			ret = iface_cmp(iface, &tmp_iface);
-- 
2.39.2

