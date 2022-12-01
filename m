Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06A263F50B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiLAQRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiLAQRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:17:07 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57682BA093
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:17:06 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id s7so2097142plk.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISuxPwYDzCqt8IdYKueJkJ48Z6xBeFf0NTwfB2Gkdr0=;
        b=dMeICjaNj5nIk9l6kaxxgGlMY0GCsn4ezx3phjZDb7Hf3TLpdBrqyJRj7/YpQU3g8h
         +tmxEUeoMYiGfc86DDcQUcydRybOSLcUHQXlWQlkGq7kEprBBjmuu6LW/mZgVU3vectE
         ZCQFSK/l8wj/4IA9+4aN+UrwkGvNh+8ohs46FKInANfsuNsatSZHqrE/3brRyvhSCSb5
         UMv4/bHBHd2LnoCzyMhKFOQ1hwx4cJDSL5GlxZX3GWCojxciJjpYxg3d0+x8kFUx3TIC
         +Z94RiqeGtIUhHLe3shQx4o/LA/tbiOmUAJO3/zs1LqHIaLoCgWRlQseJNC6iMGoZIDE
         IURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISuxPwYDzCqt8IdYKueJkJ48Z6xBeFf0NTwfB2Gkdr0=;
        b=NrXF1h8M6WVjmITRQxKvAkNjmo7D9zxt/nGeFM96QrM7fGNq4bAKnK0U7WTzYRjFBY
         HGHBVDdB3sy+N2xCytikD4tlYGOJSZlZ5n12u8Dc7TX93a9f/XXL0qoO2CAgFy3IN1YN
         YQqLzSemg3ehtgUW6LKNp+ZNqQ/6oo+Guw67ISqjuQbhq/cIs9fdnWFN0u9yfI5kSaSb
         zi2rfPIb7lIBsRzVmezyxftkfCEi0CIXpm+sFwiYG9idBKznefdI1SRiowDWPYo9efrA
         X+El0WovwAJHMriU+n3JsXs6/D6eIyi7ZsjdN8iMO6l4SG1z+M0GQEIyAbL+3MMtdZDR
         gUWg==
X-Gm-Message-State: ANoB5pm1Ca6mSzwZnoInB7yJalcdqgf312Zz5L2ybfhe4YPJymnxU5t5
        RVNKbKm23JMFjhY5GneTcvUA41h/dxQca3Qo
X-Google-Smtp-Source: AA0mqf4OiQkCMHaBNbtThte7wfsfTN4wiDapkq1T0EYnWQCWhGB64fdu6IV8zz/m0H/6w21P0jlYng==
X-Received: by 2002:a17:902:b189:b0:189:396f:7c43 with SMTP id s9-20020a170902b18900b00189396f7c43mr45357095plr.13.1669911425646;
        Thu, 01 Dec 2022 08:17:05 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c090:400::5:6c2d])
        by smtp.gmail.com with ESMTPSA id a4-20020a17090a480400b001fe39bda429sm3192540pjh.38.2022.12.01.08.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 08:17:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20221201070331.25685-1-rdunlap@infradead.org>
References: <20221201070331.25685-1-rdunlap@infradead.org>
Subject: Re: [PATCH] block: bdev & blktrace: use consistent function doc. notation
Message-Id: <166991142449.790835.5342516828140228068.b4-ty@kernel.dk>
Date:   Thu, 01 Dec 2022 09:17:04 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d377f
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 23:03:31 -0800, Randy Dunlap wrote:
> Use only one hyphen in kernel-doc notation between the function name
> and its short description.
> 
> The is the documented kerenl-doc format. It also fixes the HTML
> presentation to be consistent with other functions.
> 
> 
> [...]

Applied, thanks!

[1/1] block: bdev & blktrace: use consistent function doc. notation
      commit: 2e833c8c8c42a3b6e22d6b3a9d2d18e425551261

Best regards,
-- 
Jens Axboe


