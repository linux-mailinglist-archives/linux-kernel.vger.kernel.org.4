Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4985063E56A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiK3X0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiK3X0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:26:14 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE10212;
        Wed, 30 Nov 2022 15:17:32 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so3474094pje.5;
        Wed, 30 Nov 2022 15:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JHPYnqkf2NRISNr9s2sdmwDxCB7+PKLiB+fahjpgjKA=;
        b=Gwnn1Tg36v0C9UFyL+lfSUR9DkSygRbLxrb0z2WIrXYkRzlGM3QFGEFI4uA2JlgMui
         NMpWWekWX17ucbs9h107b3sRwm4dqz9UIKTEQR5srBdTr28vW2aJ1E5T4F991BKPovLZ
         BniOrKueHLHlvG2UtMzzMuFdYAPZ6eh9F4N1CXVpjGzD+CgEfi/JkoBqsVurT0q5agiL
         i3cyFj0I13BqOb6HwZHFbvzAN1u1IfLRBpmEAHPGR9CKl/M1JNZs5R+5b3Maj0wvipiR
         c+cdy7zCrkCgdsaNtGA9jOzcvs9DHwOit1X/ax0rgrbsfHihXYFtUo6m0HovfcBb0hGa
         E2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHPYnqkf2NRISNr9s2sdmwDxCB7+PKLiB+fahjpgjKA=;
        b=3azB3gp6GFCSGRqMfyuwL6PCiG97WIcZ29b6QmJ8XgSC5qjBzGjTarMu5Ray4t1q6E
         EpUqPQ3doTTBMfrIScllQqpdKZ11GuKeUz/VK0s3G2WVsBMWJnQ5yMVIFIAsGCYk+vlV
         RRTNOiOKiEwXPPEiLNxpbhAfaTZBcORugsC3Rn6WOCL2EvQg+XJ71EmIkyMrmpFmC5uA
         ga9EEE7XGr+L98XRF72FPp0Ed4rQBu9j2OtskSFn7N1Qev9VOiEHNNRRdPyrYcE6eKkY
         Eyf10pymkqSW1pcwbncw73KOpLiBVu8knoF5u2HBB6spuBLXWmzKniIOmvzFhMPo3Ex4
         n9OQ==
X-Gm-Message-State: ANoB5pkhn6aFUiBIiXSbGxzpN9CFoP0Qkbc0MchmUrVkylfcxFeuWo7L
        9Quo7vwX0NMNK6VMbGEKncOvSbADWng=
X-Google-Smtp-Source: AA0mqf4hOUlc1LUnq7PCe3mgcQJ4Gx4HpQumuFCEp6biAMVWm1P3NUpo9JWayWHSlGl6ufDrh2SjXA==
X-Received: by 2002:a17:902:7d93:b0:186:9cf4:e53b with SMTP id a19-20020a1709027d9300b001869cf4e53bmr48580264plm.50.1669850160375;
        Wed, 30 Nov 2022 15:16:00 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:360e:7e9f:b234:c094])
        by smtp.gmail.com with ESMTPSA id n12-20020a170903110c00b00186a6b63525sm2035082plh.120.2022.11.30.15.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 15:15:59 -0800 (PST)
Date:   Wed, 30 Nov 2022 15:15:56 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        w.david0@protonmail.com, stephan@gerhold.net,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH RESEND] Input: msg2638 - only read linux,keycodes array
 if necessary
Message-ID: <Y4fkLL6nvq6655MW@google.com>
References: <20221130210202.2069213-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130210202.2069213-1-vincent.knecht@mailoo.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 10:01:59PM +0100, Vincent Knecht wrote:
> The linux,keycodes property is optional.
> Fix the driver not probing when it's not specified.
> 
> Fixes: c18ef50346f2 ("Input: msg2638 - add support for msg2138 key events")
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>

Applied, thank you.

-- 
Dmitry
