Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA426745C2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjASWSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjASWR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:17:28 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ACD80891
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:59:20 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id fd15so2738300qtb.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EV/40Ti1p6uQrxSptqxGHz+KSFTZGf7X5IQ035Z+iAI=;
        b=LnVd/1DrtbOe8GTxJzFDxRWyyAa/5JCkNoCt6gPGU7wbMjBNA4F8PFREiRfvxceeGN
         JTGz1uKZoU3we6uTh/QCzsY/mrVKvL0Wew3ejYIMtQAPEPPPt/HTn/42LNwnRO2EVNE7
         cBjB0vQEyMujAFTcsLrCdus2QU0OpS0p/Jae0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV/40Ti1p6uQrxSptqxGHz+KSFTZGf7X5IQ035Z+iAI=;
        b=7KB2X5kOijIoEjrTJvtwVtsTsNhCXyXrBF/OpfiDy7UobZnoYLLIKOFkEeoChpMEUc
         VG7JdVvRgsLpW7EapgkrriBj370YKLQC398IqaMSrH5n3dXvbDw7wvh28RE2gxgfLEoN
         2/et3YUK/pjeJg61mDkVqxQQRbxkTrUU8qNzxRZWkG/SWY5h74ntxVLYCQhbLI2G7M6B
         azIcPuvhR5nEB2Dy5qRQQ7Tbb8seKeSURfKRk1spt7exReWPvOIYB4Zdl2dS4pUz+HDo
         6ln2M65MSatVXJS37j6FWtVdCjPy3aqVtehk0s6/CeZr1S1xolMGzQg0sWa4j8F9WClN
         JucQ==
X-Gm-Message-State: AFqh2koJKwUupyG/zmyu2d7pmjoVyHP+sync5fS23a3FdzsMWsKF/fVF
        AAIresPcQscJ7NXbRpR9bGYr4g==
X-Google-Smtp-Source: AMrXdXtQ2KdUqaVXNbNXTktG2wL1uKAVDAGBejMPLK4ZkW00g42p5U9OFzfWgOpYButqotoDz3RNDQ==
X-Received: by 2002:ac8:7511:0:b0:3ac:342:c686 with SMTP id u17-20020ac87511000000b003ac0342c686mr15919643qtq.46.1674165559761;
        Thu, 19 Jan 2023 13:59:19 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id u2-20020a05620a0c4200b006f9f3c0c63csm25153182qki.32.2023.01.19.13.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:59:19 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:59:18 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     sam@ravnborg.org, linux-kernel@vger.kernel.org,
        users@linux.kernel.org
Subject: Re: [PATCH 13/15] backlight: omap1: Use backlight helpers
Message-ID: <20230119215918.3tv5e55a5sfcpf4v@meerkat.local>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-13-1bd9bafb351f@ravnborg.org>
 <Y8m8CM35ku+Fuppc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8m8CM35ku+Fuppc@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 09:54:16PM +0000, Lee Jones wrote:
> My tools appear to dislike the line break in the Message-Id header.
> This isn't something I've encountered before.  Is this a B4 thing?

It's more like it's a Python thing. The upcoming version of b4 will avoid this
(by not relying on Python to do message generation).

> Is this standard?  Should I adapt my tooling to scan over line breaks?

This is RFC conformant, so if your tools are not able to deal with this
situation, you should consider modifying them.

-K
