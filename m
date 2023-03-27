Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256086CA686
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjC0Nyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjC0Nya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:54:30 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408493C18;
        Mon, 27 Mar 2023 06:54:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l8-20020a05600c1d0800b003ef6708bbf6so3301018wms.5;
        Mon, 27 Mar 2023 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679925268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lX2V9rHz5AfDlYh/m5Os1E5bKBhD8XeCXhZspUZN/Jc=;
        b=SspAkpgey9YhLmH1+qufQWYhk9T6YfA4i88BVpAyL2MyAlID2Wu4pPH0R4Vrkw/mDU
         eXkNCSR9XOzyYGTUGRYMS9Vmz9ILlUM05ntdPLJH4YtI2M1Jc47D8NEieMF4SBhAJ+Av
         Cxxs+5lJDEhkE/uRYjiWfBC/W5YT575CYvFFk23IJBeX8z70MchGUdYqSvtjbOFoUND9
         RomiGhq5h5vkFS3ew12B/1zoK2agSEvrNRkrlJqIzFWMSatxPHLMkny8sYFeBhHrP5D7
         y/XFKOYMvOemXhJZbKNVg0PRudQ60A9t+by8MW64/Z8hhR3y7aBNjaiVS7nxnGyXiKqs
         P/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679925268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lX2V9rHz5AfDlYh/m5Os1E5bKBhD8XeCXhZspUZN/Jc=;
        b=mTbvKhRo+opmuQb1Zc2gtcBgc966SsOLKsSBrdFjvmzMcwYjgpndgaSltd7nuIe9YG
         BhyXQZYKBWZB+S9jbWfba15VS8z4SBFHme90d1YRT5pNluas/YGSZpK9XQbUDmpjy/eT
         95qfixEU02UJUCSsc2mvjcP8lO9iAlrEQmrVe8fgF7nbzZU17WtnYJ7qkE7xTX671OgL
         D4onm1M9olCu7LvUsjP8CrDQwG4E8xBPs9fvctO5QaJVjTukxB3U+gSXlCOaNilM0Cv/
         TXunMdmxhkz88r8J4PnTPRI/6lutXrebTOmlcdgC3lsgO6G5g5ZI6bCt6myIy5pQ/YVb
         kSUA==
X-Gm-Message-State: AO0yUKXl8FH2ea3vN7mMFdRomq9pfcC5XMGBvk+uhO/TbFG4L5FvxrML
        Wu36q+jdMY58MIM5lPz4LUnjxffmxAj6Dw==
X-Google-Smtp-Source: AK7set8M+QU4V9xyoDxuNXnG2WXKTVBQdZJthTNHqwj8S4stvGaJlrNiosh+La1DmXXkAw8NKjYqog==
X-Received: by 2002:a7b:ca4a:0:b0:3ee:5a48:5b54 with SMTP id m10-20020a7bca4a000000b003ee5a485b54mr9275833wml.16.1679925267664;
        Mon, 27 Mar 2023 06:54:27 -0700 (PDT)
Received: from localhost.localdomain (212-59-15-122.static.zebra.lt. [212.59.15.122])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c00cb00b003ef64affec7sm7371244wmm.22.2023.03.27.06.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:54:26 -0700 (PDT)
From:   Yaroslav Furman <yaro330@gmail.com>
X-Google-Original-From: Yaroslav Furman <Yaroslav.Furman@verifone.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     yaro330@gmail.com, Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: 
Date:   Mon, 27 Mar 2023 16:54:22 +0300
Message-Id: <20230327135423.607033-1-Yaroslav.Furman@verifone.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZA12pMgwA/8CguYd@kroah.com>
References: <ZA12pMgwA/8CguYd@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Will this patch get ported to LTS trees? It applies cleanly.
Would love to see it in 6.1 and 5.15 trees.

6.1 is what my steam deck is going to start using soon-ish.

