Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7116989A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 02:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBPBIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 20:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBPBIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 20:08:15 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29452941F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:08:14 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ky6so1513248ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dpuTSv6lGJhmoxF+pMAKZTefirNRzuGsDlz8YcNTEQo=;
        b=HfP3JDL3SQ+gEasoZWi1fUtvDegW8xjV6i7oha9uvRtULaT4hjuzvATJ9WBILQHPTC
         bfUV6skkaMj5D1/M3YmgmtNRb4VOZ+gDBdtpNGMFX6L0Pjr1xH90rO83RkvVSpncOJlM
         d6M8kgsRadnrsnCFdlksx/DhiTQRwNgHg303Ny6en8aSMK7jbAGgE/pVRBlFeCRS+U32
         qmLzd2Kxy4RMsPW8TDHhpb+6kNwFo3DDT3FkRKczIPkLqxquAUK2V1o6LlzXtLftr+GX
         WMdbmVpt1cRkrfTNs6taFrfKevZP3BgVEWdtuMU8aITPB3teuTFZkVyr2igCeB+ZnJ66
         McgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpuTSv6lGJhmoxF+pMAKZTefirNRzuGsDlz8YcNTEQo=;
        b=zDKnq50yC6sIy7Gkon3TuJkJrVElXaUcN3B4bIokKWdcB5Q42wAIQgNqEhnGgURDfD
         u08WVlKqlhF6fvxb8ujv9CsbIZw7Bu1AC/sPwZL3OL5LEEzB5ikkKvZXA4O84Do0WdX6
         1v801wvZvCF0ofZTtjwxVFA42Wx5+C+e4vB4MleeTdOiqQhspGFnQi1LycbiSObxVB7f
         PVIOrZV6WwmuOTkjXwty8ECA3eqSqD8i7wejwCGbgdGpsl5frDT1xDUk05B5uKQdaC3E
         lAVFNJRavkKYlMbA4CnK4VITJYrJlc6VFXJfNTzdfvz/3I7viifiFZqM1fU207RvbXNc
         ssYg==
X-Gm-Message-State: AO0yUKVq+MUAV5yIsitAkL/MdiKg1G6XqPsupf8rhsHavzCItgcqZ3xh
        BBDaNHfrAFkU8jY+aUL8PZJ7rU01rnZKhiX+
X-Google-Smtp-Source: AK7set88eMzGkiWFPjTHSXW2Cs8F0hUlY50a7KiBEH3A0/zwerUlHh2Rc7WM1l1XcYKtkQabWz/vTA==
X-Received: by 2002:a17:906:6807:b0:8af:4684:91cf with SMTP id k7-20020a170906680700b008af468491cfmr4306444ejr.32.1676509693514;
        Wed, 15 Feb 2023 17:08:13 -0800 (PST)
Received: from smurf (80.71.142.58.ipv4.parknet.dk. [80.71.142.58])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709066bc600b008b159612b2dsm84098ejs.106.2023.02.15.17.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 17:08:13 -0800 (PST)
Date:   Thu, 16 Feb 2023 02:07:51 +0100 (CET)
From:   Jesper Juhl <jesperjuhl76@gmail.com>
To:     linux-kernel@vger.kernel.org
cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [Patch] [cs42l42] Remove unneeded version.h include pointed out by
 'make versioncheck'
Message-ID: <83e0ba99-6be6-ede5-08ce-b37aae1fd9c9@gmail.com>
User-Agent: Alpine 2.26 (LNX 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 80dd7af06ef675c183bc7faedc474e5cdda295cb Mon 
Sep 17 00:00:00 2001
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Mon, 13 Feb 2023 02:54:45 +0100
Subject: [PATCH 08/12] [cs42l42] Remove unneeded version.h include pointed out
  by 'make versioncheck'

Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>
---
  sound/soc/codecs/cs42l42.c | 1 -
  1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 2fefbcf7bd13..ba8c81b6ac87 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -11,7 +11,6 @@

  #include <linux/module.h>
  #include <linux/moduleparam.h>
-#include <linux/version.h>
  #include <linux/types.h>
  #include <linux/init.h>
  #include <linux/delay.h>
-- 
2.39.2

