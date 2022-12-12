Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC29D64AB83
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiLLXVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbiLLXVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:21:49 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EA91C10D;
        Mon, 12 Dec 2022 15:21:48 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so1605092pjj.2;
        Mon, 12 Dec 2022 15:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mCcU/Z+VThb7OT6uK7oDWN20W2JtAwff8l6YUKV1Ffw=;
        b=YElE612wDNxklj+Kqu2C0Bp53W+DblJlXkwPmqoXEXcTCbsuJsoQU6BV2tE97kFAej
         k5WVqRDlsKcYTWCv8/wZZx7MAuSulqo6OJ/V2Q5m0YHsnAQrZ+iJ1T94ULFOvcb7hx1u
         fEZ0vZISQylOj8Jv/aZUMwPyLmkIf9ZEivZYW1ljbFzjT4lHw+o5kDaaTKi0kzuuMjBD
         owNuwI2SFKUaVje5iqANwGpdCeTLSpwe+U428JkfmBLUcVxxQ93ZwAxZfBqhweycJQ27
         MSrfStUUQi4X5+qZI4IAn4X/B5p11+EHccj8wnGo+ZcK/SsWSI9H0d4mZ8e3k2LDzECD
         HTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCcU/Z+VThb7OT6uK7oDWN20W2JtAwff8l6YUKV1Ffw=;
        b=C2xtt7PHNacLCeeHkwCUU/q0V0WPVxxXkuz3WXyM5A2dhuLBu+z/IOOCNq/lK8ytKa
         rAZruGTPgux+iJlzsjSkLD1M6doIZ2MbX7hxEe9mv14pZdnCPr8zM3XMGL93a94UZWkH
         yL+ppvaPJMkr2LslSomXU2r0PDdCyeAG6kVrUC0xfFuWyBUf4sDSueZ7fAKw3C1GqDeg
         /gzu1YinTcAlRyL8oKPnWTeuFYAnvtm0cde94dkWA1NETts/pmtKIyucgw0uV738YqC9
         voEiz4TN4GbgiDjS4cZrEclBZJ4/NLxUKyxt7tRe8n8Rn7mlAJWyYwtbIx/eLLPakWZQ
         aLRQ==
X-Gm-Message-State: ANoB5pnJfytE4tFNJasaFrX6IR4eryAW4C1znV59fCzEphRRKkrRssIn
        T5HT3ByDi6Nk/OvOvP3vlhs=
X-Google-Smtp-Source: AA0mqf7GWr/fkBlLduluOfqRZCTa8QKv+1WoxcEq2w1eMkWECfo+xJq4V5IVwCOVARaOtcrRUi8dSw==
X-Received: by 2002:a05:6a21:3d12:b0:aa:955:bedf with SMTP id bi18-20020a056a213d1200b000aa0955bedfmr22879003pzc.2.1670887308026;
        Mon, 12 Dec 2022 15:21:48 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:2094:2357:6f63:1cd5])
        by smtp.gmail.com with ESMTPSA id h67-20020a628346000000b0056b9df2a15esm6342394pfe.62.2022.12.12.15.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 15:21:47 -0800 (PST)
Date:   Mon, 12 Dec 2022 15:21:44 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jingyuan Liang <jingyliang@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org,
        hbarnor@chromium.org, dtor@chromium.org, seobrien@chromium.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Add Mapping for System Microphone Mute
Message-ID: <Y5e3iIW50u02fJpD@google.com>
References: <20221123234619.91313-1-jingyliang@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123234619.91313-1-jingyliang@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:46:19PM +0000, Jingyuan Liang wrote:
> HUTRR110 added a new usage code for a key that is supposed to
> mute/unmute microphone system-wide.
> 
> This patch maps the new usage code(0x01 0xa9) to keycode KEY_MICMUTE.
> Additionally hid-debug is adjusted to recognize this keycode as well.
> 
> Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
