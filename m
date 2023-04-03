Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A826D443E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjDCMS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjDCMSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:18:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E31CFF08
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 05:18:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id kc4so27779446plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 05:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680524306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eMxTwy2i6Q3rtASj4xrv1k39KS5W1FVy01mpjmZ1Is=;
        b=WX1M7g6/BTxny5qTEMUbWYRMzbimPbMl1eOieYl3291YLTA4VgICQnmjwl9DDsgGR9
         xVU+BhIubA+7DHXgh+APrB+YQz4OtA+SA/gJ8eJUsqAJOwVyQ/IP27YCXU17G2Cm4I1Q
         R0OT/pKXp1lUolNKD6+QARkejgJ/8AAoYqMIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680524306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eMxTwy2i6Q3rtASj4xrv1k39KS5W1FVy01mpjmZ1Is=;
        b=5Vzbk4XzLdDPUkXHihgVH7eGen33Qjx9xjNlh0rfVJD0r2WVycq7ZF27TtdWx39CzU
         dALvTEfBjXDOf3wdGUFLl49ENhFM2QEfcVZu80mAlREe7fQk8qpD5w4InFqrqm8fScdL
         ennygLEdwlfkW2Cb7/sWmwbpXBsd0Rnvyaqc/lDLagI9jyz1fPePDbo0vd3l43avFEOr
         1QfA7YsUYZZBiK9z21Mtlr8yGf5rOVyYIk0VZ0ytiw+UPhCH7S0lTijn5edgItzC82hy
         h0QGpG//+Dan5Go4ZZrqc2pCzRI4ouyaXCAfv188bZGkYqk4MFagP1Aj6XnBSyK7zxxK
         7M+g==
X-Gm-Message-State: AAQBX9eO5PfoDGpiLt9721OqpIsddFJ3zM581AexgTr7++HfuAbsdFcl
        kuCfdVljXhVyjaXakZWyUxkmVg==
X-Google-Smtp-Source: AKy350bFkIXxJH3enT/RpgPVaPMOTQYUJJANjUsucqJt9bphHMK2LLE7VG7x+ri6PKjD8draHIYe1g==
X-Received: by 2002:a17:903:280b:b0:19c:65bd:d44b with SMTP id kp11-20020a170903280b00b0019c65bdd44bmr28304892plb.60.1680524306240;
        Mon, 03 Apr 2023 05:18:26 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id jl12-20020a170903134c00b0019edb3ae415sm6509017plb.14.2023.04.03.05.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 05:18:25 -0700 (PDT)
Date:   Mon, 3 Apr 2023 21:18:20 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     "pmladek@suse.com" <pmladek@suse.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        GyeongHwan Hong <gh21.hong@samsung.com>
Subject: Re: [RFC] vsprintf: compile error on %09pK
Message-ID: <20230403121820.GD12892@google.com>
References: <CGME20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
 <20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403104617epcms1p383bacbca705c0d7e4fffca6833050e42@epcms1p3>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/03 19:46), Jaewon Kim wrote:
> I've just changed %09lx to %09pK on my driver code to hide the address, but I
> faced compiler error. The %9pK without 0 worked.
> 
> Is there restriction on %pK which does now allow %0 ? I've wondered whether I
> did wrong or it is a printk problem.

I don't think this is %pK limitation. %p should not take modification flags.
E.g. %3p doesn't make sense, we still should print the entire pointer.
