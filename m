Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DB66769D9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 23:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjAUWxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 17:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjAUWxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 17:53:51 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D292625E37
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:53:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d14so4059649wrr.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9tSQMjpLqxlyV/AeOHFU8Kl5AtTNzyiZytNA84R4H8U=;
        b=VselyI+Rxhj1maKsS7acb/KOEAEc12inHHaVwGYRRSiG3Tci1x8s+XNLYhf3UV4Sqh
         3t9I+I7Vhz76KqoyRCIkqpsAlZDIohJSuueU/EW604zElUmEFpInpL5Nt12daNTaAl4s
         yUJsbYJsOBMUUkhir8MmlT8qwZY3TLZtn9/VFRCcmi89AGKeUuUYaHLQKyUjK1279xcJ
         X9/whaRy24MyTumtTDvZPs0K8y03pQm4CWG5k4kbvzEWsEKzvEs40+Jh3t5BYQ8YzdR6
         P4nAKQkJ0lZI37hk/7qQSmVnUvWmhV+B54Cmq8ZgO0JVSISbiv8ym0skmlhDfJDVk91i
         Of1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tSQMjpLqxlyV/AeOHFU8Kl5AtTNzyiZytNA84R4H8U=;
        b=0iIkwFsTGVnTyp7vap92x6r0G4Sm+qvJSCnN+a1TdMg86FaHCyxi9n8Rd95hqlkonJ
         V+CnpzFaebqAvOkt3N2qCH69TQ5aoGyynmJ/VwVCsKoYq92SvV+H3VYOGBwbpzo14JZH
         G6Xkt3VZMjUplS+x4tTIdfik7qzCrY6wyopht+aRrIzaIIku0/xwwqrcDwk+fzNH35hX
         Uq7E5D/gozv6GPjcGD+iGdSpDhwg2ulLDj21HIi0BLjWfkStjfvzan9/caSrmEXWvdA6
         sYSIf/DNNYmr25MKNSd2NlG5XBQk53VAodtLEvrdIHI9VfGVlq+EruiIM9IEw3IMfvZ9
         F5lw==
X-Gm-Message-State: AFqh2kpuH1+mpUaKm5Iqy971ziForyJA8/5gCTo+PttmntcaeMo23ise
        gUpTQv6zNcyEzAc3UTGQr32O7w==
X-Google-Smtp-Source: AMrXdXtEzCvm02XQTQ/MaAdjG9Fzdj7CqMzDxCHMnQmsfedFXkdWYHjUmGsIwI3loI0tyvEmqQBX4Q==
X-Received: by 2002:a05:6000:1c6:b0:2bd:e40d:98d5 with SMTP id t6-20020a05600001c600b002bde40d98d5mr14581375wrx.0.1674341628408;
        Sat, 21 Jan 2023 14:53:48 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.mpl.intranet (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b002bcaa47bf78sm29531001wrr.26.2023.01.21.14.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 14:53:47 -0800 (PST)
From:   Yoann Congal <yoann.congal@smile.fr>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Yoann Congal <yoann.congal@smile.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 0/3] Documentation: kprobetrace: Improve readability
Date:   Sat, 21 Jan 2023 23:53:02 +0100
Message-Id: <20230121225304.1711635-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Version 3 of this series of small readability fixes on kprobetrace.rst.

v1: https://lore.kernel.org/linux-doc/20220915153358.813993-1-yoann.congal@smile.fr/

Changelog 
v3 -> v2:
* fix 2 bytes hex -> 2 byte hex typo

v1 -> v2:
* Removed all ``markup`` additions
* Split commits

Regards,

Yoann Congal (3):
  Documentation: kprobetrace: Fix some typos
  Documentation: kprobetrace: Fix code block markup
  Documentation: kprobetrace: Split paragraphs

 Documentation/trace/kprobetrace.rst | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.30.2

