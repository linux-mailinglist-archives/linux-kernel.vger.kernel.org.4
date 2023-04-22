Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75F96EB78C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 07:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjDVFKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 01:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDVFKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 01:10:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AAE1BE4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 22:10:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a6670671e3so26022675ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 22:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682140200; x=1684732200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UxCYIXhxrc4LgveFmhzm6zYmuqf5R//p2Q8QJ0ov5SE=;
        b=S47MUzUch19ieIXkOIrOU1bZy7uTIYmHSAOdDzSH2f4wWXf6H56ZWIB49ssnjhdCeR
         EfQExpnxfX5G1AZWisBgVFdvZ2JyHUnoal16IRp9tMqEElg/lcgrMMPMH/Cr88NOKeNX
         WB4w6J/U+Jj7HP0s7Pnpk95Vz+mTvNEb3vEGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682140200; x=1684732200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxCYIXhxrc4LgveFmhzm6zYmuqf5R//p2Q8QJ0ov5SE=;
        b=SD90ZCDK7IClY9grrOTsuBIYXFO54zvOmQXynl8EsMchTg98YZnt9AQFDdZaf9iiko
         gyWNj4U5h4fK6FFKpdVKlaEF6tQIBfg5WAAHzBPjBY9NuikzopXkh4qVDUOXzEX/KJUq
         DVIwiEdH5TotR9rpZeMNakaTzTL2HEQbRYgba4Xue9x+Bj4DMFsDf6l5LXAlP9wJBEBw
         X/kX0GHPOO++cDt8KNE7C3+f9HMMjX/XeN8887WmamuyshS5qlFwK1hyKc1HSylLMklT
         3jCPcBWqH6maq0JRCW+fq24PvWEJwsxpuUDnuutwIcUOyn6n1wPhZfbkeWyFM/o5K2Cs
         bXiQ==
X-Gm-Message-State: AAQBX9eVq+YwuTlYtN6DnVT8O/aaZCSn/0u3bkYIT3+rJD2Y5AUtJkZ5
        JTydb0Yvmj1ieewP0PzQb3MnVueHiUXU483l0Fw=
X-Google-Smtp-Source: AKy350bc71VlYWYZIWgtJzal0kx8y6ZIEjaZSZkOURyHZbYl6r8th3Ltp9Q8UpYaV+zzjHIqatLpjw==
X-Received: by 2002:a17:902:d54b:b0:1a5:153f:2442 with SMTP id z11-20020a170902d54b00b001a5153f2442mr7267214plf.52.1682140200481;
        Fri, 21 Apr 2023 22:10:00 -0700 (PDT)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com. [209.85.216.44])
        by smtp.gmail.com with ESMTPSA id z2-20020a170902708200b001a19196af48sm3400972plk.64.2023.04.21.22.09.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 22:09:59 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2470e93ea71so2067942a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 22:09:59 -0700 (PDT)
X-Received: by 2002:a17:90a:d517:b0:237:97a3:1479 with SMTP id
 t23-20020a17090ad51700b0023797a31479mr7356272pju.28.1682140198936; Fri, 21
 Apr 2023 22:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230414072419.1397808-1-mstaudt@chromium.org>
In-Reply-To: <20230414072419.1397808-1-mstaudt@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Sat, 22 Apr 2023 13:09:47 +0800
X-Gmail-Original-Message-ID: <CANiDSCt61+Y3DP1Fk+tapVLcLPamtGZo56teeXhxm0+csuruEA@mail.gmail.com>
Message-ID: <CANiDSCt61+Y3DP1Fk+tapVLcLPamtGZo56teeXhxm0+csuruEA@mail.gmail.com>
Subject: Re: [PATCH v1] media: vivid: Extend FPS rates offered by simulated webcam
To:     Max Staudt <mstaudt@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunke Cao <yunkec@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max

Thanks for the patch!

> Signed-off-by: Max Staudt <mstaudt@chromium.org>

For what is worth:
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>


nit: maybe update the doc at:
https://www.kernel.org/doc/html/latest/admin-guide/media/vivid.html#webcam-input
although the current description is generic enough for our usecase.

Regards!
