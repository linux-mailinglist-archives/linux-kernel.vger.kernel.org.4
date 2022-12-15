Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03D464E4D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLOXxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiLOXxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:53:12 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1B630F4A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:53:11 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso3020343wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lccfu19p9cgIvowko9C9wyMeB0L0h/ets8k+KA0Vfmc=;
        b=HfK0gn72JK4iZQfIwKXp8qUwKeuunuIE5TtDvINJU4KhaV3Vs7+HveRFv5BGhqXvkE
         jmzsIIbkLCz7c8cRbFz1qIx0cYWmz/MBCaAKrsjqZKpzwdHrTjchTYL5LxlHFtyA6mxK
         z2ygRZejkpTbIvK2GW90yMQe2t68GfW7M5XTwVaBtn+5b6tWDqy5KkbC7df4JoB6yusC
         243FeisxRrJXGYVWku5yKAFOqI7DJt++Gi6HU72D2vodD9n+pYfl2UYKOTCjokVVKYWw
         HKzEM29vWPfj7ZaqJROpObZKDkSFTIpfBzomPYB7FpH/ABPrTDfGLrntS/KHrzMuVwKp
         4akA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lccfu19p9cgIvowko9C9wyMeB0L0h/ets8k+KA0Vfmc=;
        b=o51+A95zT1cGk2nS4TkkTFspDrklk36DjyTWF8YqwGYOkvzzpsgHLGqaQ4enTtysBv
         vvXsXnnQstOQXxAwxgk5/nZ6oQmHzqI2FrUTPfT3CzVn3/Ds3wM78phcxTOR7FaR98TI
         CSovSfWz01x59tuvJUkkA+F6S3lO5YVP2yz05cJaH3HM4xNmkKcrnRxy9vH/jbHZCxGk
         OqG7yuoWvK/ZgmIDCgQt5AnGAuszmEFj0Gmp2llVwF1SiAV8iBVKAO3vsBtylYDBU8FM
         rE/OcpUtIW9fLRJ4S0FWqZN+pKXaMm9C4OUUVtc5NpsFANSjG5VAw6KkZw9GT1oifB1k
         aonA==
X-Gm-Message-State: ANoB5pnJG3ZmDYdVAm+RVUPJbT2Dq901XHwgQLJMY7f4dJ2N5EvfxK3i
        qEeSpPkl9lobChmQf7XzdYQ=
X-Google-Smtp-Source: AA0mqf71JAGSWQGTnlxj9nyUWAoL0YWunmrcfQlmQb06lBECtofxKgHzJA9AZNP1I3DQwqWUut1E7A==
X-Received: by 2002:a05:600c:6899:b0:3d1:cfcb:7d19 with SMTP id fn25-20020a05600c689900b003d1cfcb7d19mr32685222wmb.32.1671148389782;
        Thu, 15 Dec 2022 15:53:09 -0800 (PST)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id o31-20020a05600c511f00b003cf71b1f66csm743681wms.0.2022.12.15.15.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 15:53:09 -0800 (PST)
From:   Joan Bruguera <joanbrugueram@gmail.com>
To:     tiwai@suse.de, linux-kernel@vger.kernel.org
Cc:     Joan Bruguera <joanbrugueram@gmail.com>
Subject: Re: [6.2][regression] after commit ffcb754584603adf7039d7972564fbf6febdc542 all sound devices disappeared (due BUG at mm/page_alloc.c:3592!)
Date:   Thu, 15 Dec 2022 23:52:50 +0000
Message-Id: <20221215235250.1810-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=>
References: <CABXGCsPnpu0TGHnvXM1we7q1t3tJAOYW2rA=>
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

The one passing the __GFP_COMP flag appears to be sound/core/memalloc.c,
see also commit e529d3507a93d3c9528580081bbaf931a50de154.
Removing the flags also fixes the sound issues and warnings for me.
