Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B96765D0B4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjADKdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjADKdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:33:38 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90AB95BE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:33:37 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-45ef306bd74so471327737b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=canlXLSx19QfOvr6ks9ah6oopssHJpRqJECVG/hZnX0=;
        b=Atv1cA/aJSE+oxwMoOP2cJ/GfAAc2WxdC2V5xaEGddHLSqjwgou2WS3RoUURP5QXkP
         6nsLVQaxmZ06A1OZ43JflnBkAh9p8JNNzvliro2DjPfZYcWckXBEikUKDY9DKc+d6QNn
         +hnjvITsLkZo0h/HoWHBrbjoChhVZP/czu8hZ1yKHGgt71XuSjqitnSKoijBrl6/clwc
         EKZwOOo9Piyb3l9VTSA439rK2QtF1UKkhUBhgmVwOf/YA6Y9WoVTXE2V0WPDDeQwYyhD
         0Eekeu0/pCiQ7SYYSw8ui8/Wq7U8o1eEWp+CDFrMjBy2W93iUfidKDx+7FU4CaiTekfi
         6NVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=canlXLSx19QfOvr6ks9ah6oopssHJpRqJECVG/hZnX0=;
        b=w+SrwPKXJUP8Fpb4RuAVDuge3dvuINtsroFqXZNCJKLlzWNMrVq8SQEYBwbfDe2++1
         hknckoFb/SKDxK4DtnC85gHriwAWXxSYnbfIS6hUGggegvND7FvN+0oy3kEebNmP9BUS
         KV1shPsj/O54At27kKIMPjrWVLYbesm3Fs/DswMzyjuaKL8XyTBYMtA4ra/nFCrlj16M
         71/S8S2PKM91UUM9PPaF/NxI3QmTL9YMPY3Y50t9BanqZDo0/8NRKbYY+ao+w1/d7/RT
         qrCbFBOjg0sZmfTKmksb7HRMHyegm/TpiBrXWyBA8GTQz6tz0zDDl9vzfRl+BKt0UBY5
         Wmjw==
X-Gm-Message-State: AFqh2kq0DJzpLaJk+e0aptsBoPhxklK3t9KS47RpmXTyK0I2B+rkf867
        DPcVm18jX6nnGW8vHJEWsjAYU0g3P1j+jeHOoFzUAzBy1oo=
X-Google-Smtp-Source: AMrXdXttPs+1iOXYI0H7vdqpayzkLsNGaSE8QcOQiMzfVHdHysz7pGPRBN+yeoQ1NCfkGdKlSwCjByB5Z8SN9bsqdAU=
X-Received: by 2002:a81:1b16:0:b0:3e4:9330:75e7 with SMTP id
 b22-20020a811b16000000b003e4933075e7mr4811672ywb.237.1672828416750; Wed, 04
 Jan 2023 02:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20230104095049.59043-1-ppbuk5246@gmail.com> <Y7VT4gvLCQK7B1Ak@kernel.org>
In-Reply-To: <Y7VT4gvLCQK7B1Ak@kernel.org>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Wed, 4 Jan 2023 19:33:25 +0900
Message-ID: <CAM7-yPQakk1bwON8abPm6CpYGNy=MxAjoYXfWYQExY08hFkC9g@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] memblock: Fix return sizeless candidate on __memblock_find_range_top_down.
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Did you see an actual issue or it's solely based on code inspection?

Based on code inspection. I haven't seen the actual issue yet :)

Thanks.

--
Sincerely,
Levi.
