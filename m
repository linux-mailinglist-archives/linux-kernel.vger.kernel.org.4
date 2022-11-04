Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942AC619FCD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiKDSZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiKDSZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:25:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADB41163
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:25:27 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z26so5230128pff.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N+zCgb1/SzDeDjC+vBm0YAYeuRy8cLDQigNzNk9ARjk=;
        b=XybAPYJttcijaPr/nAJsmDLP3UTm9pg2RY/hUVR216pKXnvZsPs8UblVlXw6iv++Wt
         twSGPXjkJAmuQtRG59/Rb3MQdTXwOdvfJFdXWoWSPRUhJ0dUkHTYuSKXHAztXcVNyoPY
         RLrhYvQGFb6M3h29pihNmOQha+MZz9F7UBL2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+zCgb1/SzDeDjC+vBm0YAYeuRy8cLDQigNzNk9ARjk=;
        b=VGOHtLRjquvYEyl49Pz5qsEmGoiMzO7d8bkkEGMN58E1wqVzAt14nMDngcz1pNGgBk
         hcaBi6p7gX1Wpp/etRdIjykgdSl8/YifcR1arg1OBy6Y9YZi4YXppQfZlgUx7ZhiexEE
         rUnVHrREgeG6wlobhpf+ZiUxzESgMJamoR7fn7kegSqRvMKpOVvLfKnv5upkeHXs0cr0
         2/XlM0Acr3SMkxyMcAkY6iqjv0ln4PYF+tkF9CqNHV7UpSlGTPtTGY2Hv8ICzYBOwjSI
         /tgU0rzMvUO63d2dy0x1h93aU6m2C/UeBps9XjYagUCT0fUyxGYOYwq8m/mwyZ/8p4b+
         pAiw==
X-Gm-Message-State: ACrzQf2tEgijGT7P3latt+eMOuWkw4akyGe1p4olGa3l0y7n2ZoQ/MZZ
        JlcYLPYaz9U7T27FcGZ0f98wEA==
X-Google-Smtp-Source: AMsMyM5X/Shx4cgtu5hc6fwml5LMImDqhjEcMMKKGnvGAIdHWWZYV748v+nJVyT5k+iiPjXS5Y64nQ==
X-Received: by 2002:a63:211d:0:b0:44e:f294:8440 with SMTP id h29-20020a63211d000000b0044ef2948440mr31050826pgh.103.1667586326820;
        Fri, 04 Nov 2022 11:25:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090a784b00b00217090ece49sm49088pjl.31.2022.11.04.11.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:25:26 -0700 (PDT)
Date:   Fri, 4 Nov 2022 11:25:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v4 02/11] tpm: Export and rename
 tpm2_find_and_validate_cc()
Message-ID: <202211041125.6DA20EB25@keescook>
References: <20221103180120.752659-1-evgreen@chromium.org>
 <20221103105558.v4.2.I7bbedcf5efd3f1c72c32d6002faed086c5ed31c7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103105558.v4.2.I7bbedcf5efd3f1c72c32d6002faed086c5ed31c7@changeid>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:01:10AM -0700, Evan Green wrote:
> Export tpm_find_and_validate_cc() since it will be needed by an upcoming
> change allowing access to certain PCRs to be restricted to the kernel.
> In order to export it consistently, and because it's a tpm2-only
> function, rename it to tpm2_find_and_validate_cc().
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
