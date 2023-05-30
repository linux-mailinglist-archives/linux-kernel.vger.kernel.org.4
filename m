Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32897158AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjE3If4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjE3Ify (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:35:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC976A1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:35:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so5085077a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685435751; x=1688027751;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QM+ARZdj9TwbVnGrYRA/jsJR3+Zgqtvr1mDQqqUsgpI=;
        b=SmRjPm6e9BEhfiX/p31Lc2uuDOG1CozKs6USliZSve56KFEkXtkZWMJWSPmZXh+S7z
         JkTOVF5+IuiWz2jKOZ6eqSmwb98ANgafMWgJ47jD0aHdLiHqII1CNqX+hzMaAiwMzZve
         Vw/6eni5BrXnI4YjHPPXEP8PL0aWKEkw7LO0NX8aaFRWIsgO5Ntpw/b/0YU/ixcaaxMT
         iw4aUweWAK+O9ZIh8V1HTMI/DLlCC6I72U4JUUN35rVhxG6SP+o4Y9h1RGgKyMQ1G3yB
         f6jKuI6UrVvQWCdRzg6Kw+0V/21mqXpA4kadmoauORtouE4Ci1wx35Y0uQcZhi48bvBR
         lccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685435751; x=1688027751;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QM+ARZdj9TwbVnGrYRA/jsJR3+Zgqtvr1mDQqqUsgpI=;
        b=h7oRIZR8lsZAK3Coxw6AYQ6IHa2jcQoo17AETQaQcu9SClrVQFJKzYVwkg3ejCCKTf
         mpi699xlpWYv50wougnzBB7YKoAaq7Ff1En0owvpHEyL1h8OtMVUPBkE+Ms/Jy1/EDRm
         ++nY796P3fGZv1d4+eYyf2czeL0uUQj9xoin4iA6P5Ovj0PM/lizq9TzjRerz5ywtW0b
         ZkYMYIaDlT6sY8OVYzxViBucANrbiIsBYMNBm1mHkutQy9vLy46GnEHcyjYNsftITBix
         cc2VISOdGpVuF0Our5I5MYTppFxFn1WbVoirZOnXwdscXtUOKVnWxPrUbsPXgOTAjRox
         PxbQ==
X-Gm-Message-State: AC+VfDzqw5bBYTRNS9tBYQ6W+fD/q2tEd/gZp6CXmvewX5ALcb4rIQOh
        aB9BICBKUxI4GtwlcqEC5cf5vYT5ZC0=
X-Google-Smtp-Source: ACHHUZ7ClATnGDEiK9u7kkjg4PulZeoaJE8MQIpklpYUH+TzhBz4Zpg8KrSGFBFYbHXMwLmdl6yCNg==
X-Received: by 2002:a17:907:3f1b:b0:965:7fba:6bcf with SMTP id hq27-20020a1709073f1b00b009657fba6bcfmr1757828ejc.67.1685435750588;
        Tue, 30 May 2023 01:35:50 -0700 (PDT)
Received: from varodek-thinkpad-x1.cern.ch ([2001:1458:204:1::102:b2a1])
        by smtp.gmail.com with ESMTPSA id re22-20020a170906d8d600b0096aae0b36a1sm7047417ejb.33.2023.05.30.01.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:35:50 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        industrypack-devel@lists.sourceforge.net
Subject: [PATCH] MAINTAINERS: Vaibhav Gupta is the new ipack maintainer
Date:   Tue, 30 May 2023 10:35:46 +0200
Message-Id: <20230530083546.4831-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.40.1
Reply-To: 20230526100718.35531-1-siglesias@igalia.com
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Samuel Iglesias Gonsálvez" <siglesias@igalia.com>

I have no longer access to the HW, nor time to properly maintain it.

Adding Vaibhav as maintainer as he currently has access to the HW, he
is working at CERN (user of these drivers) and he is maintaining them
internally there.

Signed-off-by: Samuel Iglesias Gonsálvez <siglesias@igalia.com>
Acked-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 207a65905f5e..49e384399ee3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10106,7 +10106,7 @@ S:	Maintained
 F:	Documentation/process/kernel-docs.rst
 
 INDUSTRY PACK SUBSYSTEM (IPACK)
-M:	Samuel Iglesias Gonsalvez <siglesias@igalia.com>
+M:	Vaibhav Gupta <vaibhavgupta40@gmail.com>
 M:	Jens Taprogge <jens.taprogge@taprogge.org>
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 L:	industrypack-devel@lists.sourceforge.net
-- 
2.34.1

