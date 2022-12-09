Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5B264843B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiLIOyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiLIOxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:53:39 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66AE5F6DE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:53:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f7so3390987edc.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1ZPBPraqcCSXLcbBqEiTH4593Z8hkjnTNKrVJO6nsc=;
        b=cA94dZQenZJSd/HPwubzdsAVWL9KdO9O1Qo/Eakd4+PcL0EYhUnFp6LZ4Z5Yiq44Ts
         kIk20jFQg1VRnEblzwpnQ/d32eC6W3vdeer4rSpJfq4M8GRXwKq4ssx4ghVd8jx1YD+p
         C2x0fausQ5gxBdut+a+0XS5oiYYSgwNQilm+V2mMDhAxtTVEpGII1j3yeVyZWE2S/hfd
         9d1sYMc0pkCNaXhyjxT3SUsMh3h6dSyi/LLn0XlkNvj+AimVyhLXmFud1jJf1IiPG5Iz
         JjBCanRTRC+nb7XDkV4V07MrkTMCVY8OCJHJ9Iwhaaw4/MGx4OQwAE8eci9EwJC9SN9D
         7raA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1ZPBPraqcCSXLcbBqEiTH4593Z8hkjnTNKrVJO6nsc=;
        b=p2hz6oxPoo1Xfy6ywvORUz4FL1ElyWWoBsKDS0yoXpmzPJVAcl+xIlrO9Ey043B7dM
         mU0ysJLqdEIytzUt4KNEoNSlgjEZsmbCX6um9OqZ+AUwIqRUUW2rmk3xZcab/FHNL4yA
         Q3pUwr+J86D673DOac3nltMhzlVQSnRWeNpsKI4stXPDl2h7eUuCzQvITuhwCPOerRSy
         DSEEu+SMJKNr5/wHdjgpBokDv0SHmZNt3NHgK1xHPRDDMhCBzqgWC/49VLegMWOu9nvw
         gpqbU3DrqkPtvOHCGWmtsviICYJRwe++tsfizdtNPuuHsAmbf5k+9TUfW+gsDHaWweyf
         iWmg==
X-Gm-Message-State: ANoB5pnQmlGOJrC4dzxZe+atTj12xr7twx21D0elaCyQdy60sGHLuuug
        3rQiYD4X0Swd+90VUEGp0yUyqQ==
X-Google-Smtp-Source: AA0mqf4grDFciVpw7S/dEZoa128AlSgEFPzlvhzLMA1gxp2edL4O/WpNrnUJ3+plM+y7TPO8OeT56g==
X-Received: by 2002:aa7:c9d0:0:b0:467:559e:5301 with SMTP id i16-20020aa7c9d0000000b00467559e5301mr5158338edt.7.1670597616464;
        Fri, 09 Dec 2022 06:53:36 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id bd21-20020a056402207500b0046bb7503d9asm728424edb.24.2022.12.09.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:53:36 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 6/8] MAINTAINERS: add drbd headers
Date:   Fri,  9 Dec 2022 15:53:25 +0100
Message-Id: <20221209145327.2272271-7-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
References: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 595d59eec7ea..83b6f3a97cf6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6349,6 +6349,7 @@ T:	git git://git.linbit.com/linux-drbd.git
 T:	git git://git.linbit.com/drbd-8.4.git
 F:	Documentation/admin-guide/blockdev/
 F:	drivers/block/drbd/
+F:	include/linux/drbd*
 F:	lib/lru_cache.c
 
 DRIVER COMPONENT FRAMEWORK
-- 
2.38.1

