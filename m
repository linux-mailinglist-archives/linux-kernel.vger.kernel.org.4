Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3316C74EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 02:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCXBPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 21:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCXBPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:15:16 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8AA2A994;
        Thu, 23 Mar 2023 18:15:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so171706pjz.1;
        Thu, 23 Mar 2023 18:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679620507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUAl32IOA1pEsu/DH/HlVmB3L66au2MbVzmZzu5KUw4=;
        b=pY/MW5lVKclIKzJ6YMnqpT7r9ozHKPfWYlqBnmdH5PwxztVWPcy7wuj5YU7fJ32vqm
         TVkgGzHO3ynQvfpLAlHC53HKxOthk6n42cgKsObyMaUNxIAXK8U5X8TSM/lFJOAKxcTb
         8Y3dw6H1eiQ1CVK20D4v6NEYE6s9N2LjPTiuddaXSpJnx67A8rEYnL43LDtpePLoHb24
         EvhiAqG79mTk6zkewU3qaFtg9l50mR6XuPrASLJWzKw/eEmEszVmIS5vH5REoov1ovLd
         VVx+GkG17z2zNXCbTJxycExJG52OiA2NDgJifmg5OKkYAqIyUt1kRB+C49mr34LquPgq
         eW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679620507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUAl32IOA1pEsu/DH/HlVmB3L66au2MbVzmZzu5KUw4=;
        b=LX3OGm1tGpFoOZsjuB9/j7vpx7o/eEv6aOvfB9XP4Bu7TuDMQ0YlAdboWXAmXfBR0S
         sBV5fm0KpzPIV0DbYOJ5WSPBS7WG2+OM+q1hehLJ0Yfvo8W/IEukuC7w4IEI4TrzZGB0
         ZuHwNqGLvTGj27fQANeNK7RJQO8csPkMBepa/Q7wCBp8Dp9g8G28x7vCm+dgDnPCMIBu
         KFY0ZmT3cq6SloHoIGqhKmv9AJORNEZ941ZLGf6CuzVASK6zkjhHOBpKjb9XTxPfShwP
         gfhcdBFEyWgGtJLJlqawjkZ9gkcDMXNb4dlafMkz1MT2BTqNajDWoJ0YWpuoYs7yfvBV
         ERrA==
X-Gm-Message-State: AAQBX9cFm/0ZTdsZIJ64RO5pl8YARzQchtXNH4T7GCGI0+uJcAwCr6HN
        5lM4f9jExAYh+maZwFBEyYA=
X-Google-Smtp-Source: AKy350Y7GhIu81K+SiI3U8EpJENiPefP4VCfxfAVWfNnAQx/Jj8g+E5y/AhgZLz7Cv3x7rz37lpBRg==
X-Received: by 2002:a17:90a:1a07:b0:23d:4625:40d6 with SMTP id 7-20020a17090a1a0700b0023d462540d6mr999651pjk.14.1679620506411;
        Thu, 23 Mar 2023 18:15:06 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f5e9:5a97:54ee:6f66])
        by smtp.gmail.com with ESMTPSA id w15-20020a17090a460f00b0023b2bc8ebc4sm1887496pjg.9.2023.03.23.18.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 18:15:05 -0700 (PDT)
Date:   Thu, 23 Mar 2023 18:15:02 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     hdegoede@redhat.com, mkorpershoek@baylibre.com,
        chenhuacai@kernel.org, tiwai@suse.de,
        wsa+renesas@sang-engineering.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Input: i8042 - add TUXEDO devices to i8042 quirk
 tables for partial fix
Message-ID: <ZBz5ljlHM3v+EAJU@google.com>
References: <20230321191619.647911-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321191619.647911-1-wse@tuxedocomputers.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:16:19PM +0100, Werner Sembach wrote:
> A lot of modern Clevo barebones have touchpad and/or keyboard issues after
> suspend fixable with nomux + reset + noloop + nopnp. Luckily, none of them
> have an external PS/2 port so this can safely be set for all of them.
> 
> I'm not entirely sure if every device listed really needs all four quirks,
> but after testing and production use. No negative effects could be
> observed when setting all four.
> 
> Setting SERIO_QUIRK_NOMUX or SERIO_QUIRK_RESET_ALWAYS on the Clevo N150CU
> and the Clevo NHxxRZQ makes the keyboard very laggy for ~5 seconds after
> boot and sometimes also after resume. However both are required for the
> keyboard to not fail completely sometimes after boot or resume.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org

Applied, thank you.

-- 
Dmitry
