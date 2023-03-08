Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC066B1612
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCHXDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjCHXCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:02:30 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C234D38EF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:01:42 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x34so443847pjj.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678316500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvuSENW/Sm9rtW4bM1SrR1ry1qgrfTPMnDe0thHIz60=;
        b=TFeH6WS5ihKkVruK/NdfnWJeq3Iof1T/4QFUepGy76ioe2TpFT9b8KsRS1quh4iEU7
         R89qN8Qd1eYkC7ahS6vv+5qOvGCxYSWAky1EPPzesCu/GAZf2YuPDitInljOAhLK7t3r
         j//CdThtWM3l6Lk3P2tZORz26gDForuTmXn9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvuSENW/Sm9rtW4bM1SrR1ry1qgrfTPMnDe0thHIz60=;
        b=WSni62xjvwgVHMYiO+cpKXFb1BSuW5HcDKyeR6j/UnuC0FPv4+MEPNGAewrQGwhkM+
         OWY1cFSE9tqQzxVPmd8OsHfNd30KTXbCIlHPg3KLAtTiIJW41MUuv4lD86G1rdDnCU+e
         CyhHVCMuaB9o8AfBjtemkGAncOr8D2zLEnHTR003MiK+vVNALOL80bbZbu22+UGRl0R3
         PIz5Qt1IgmR3r0Hl410deJVCVQc4+sQyRPEfkNaGqC5VP3fg4Ah4HT1r1+x4raUNjsgl
         0kdbONGHxCwoLODp+VZXeBxhGExPyprF1ytAN6D4ONoIdRmP6spQ66hO6b17/8ntLuo8
         RPgQ==
X-Gm-Message-State: AO0yUKVstobj/PrCfgI0lwAt7arz2SutFnJaMuq28J2gWzISTfWxXbKj
        QHKyFvpVcWagWtNSF8IKnzjE9Q==
X-Google-Smtp-Source: AK7set+JEzdwzkPLSkbh/ncXhY7o24UjueSquEHwnzuzlpImKBA4prl24xjmoRac/0GrVA5XCJpLLg==
X-Received: by 2002:a17:903:120b:b0:19e:82aa:dc8a with SMTP id l11-20020a170903120b00b0019e82aadc8amr23630728plh.22.1678316500607;
        Wed, 08 Mar 2023 15:01:40 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f54b00b0019934030f46sm10292444plf.132.2023.03.08.15.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:01:40 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     jstultz@google.com, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, gpiccoli@igalia.com,
        chunhui.li@mediatek.com, wvw@google.com, midaschieh@google.com,
        anton@enomsg.org, Tony Luck <tony.luck@intel.com>,
        rostedt@goodmis.org, kernel-team@android.com
Subject: Re: [PATCH v3] pstore: Revert pmsg_lock back to a normal mutex
Date:   Wed,  8 Mar 2023 15:01:32 -0800
Message-Id: <167831648986.1965482.3536353696063382395.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308204043.2061631-1-jstultz@google.com>
References: <20230308204043.2061631-1-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2023 20:40:43 +0000, John Stultz wrote:
> This reverts commit 76d62f24db07f22ccf9bc18ca793c27d4ebef721.
> 
> So while priority inversion on the pmsg_lock is an occasional
> problem that an rt_mutex would help with, in uses where logging
> is writing to pmsg heavily from multiple threads, the pmsg_lock
> can be heavily contended.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore: Revert pmsg_lock back to a normal mutex
      https://git.kernel.org/kees/c/5239a89b06d6

-- 
Kees Cook

