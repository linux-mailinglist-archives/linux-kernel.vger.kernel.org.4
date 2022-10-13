Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C745FDF22
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJMRjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMRjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:39:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EF1D77F0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:39:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso2522917pjk.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOJAES6tNu6Y/rEU3NZMbDi0UCSM39vMiEfPAnDU2yQ=;
        b=hqMNGhsAO1Gb8GaQkHCXoY5euH9kqlooRcX7lMwFx2RvH90BkvATWR2BqMdGC5Wqvx
         MTfM3bPDi2Gz3qzbwsIuUa6Fu6oD+cPUxUgdfZxNBR4UTaipUshWY9GGGNh91V8b0SRA
         FApTTqURY8cHXtBRwwtEVyjW+HtgYBQLxX9W/DRWXH2SzcNrmpfPwTXiTiGPOJw7Okg+
         7ujuMpqR0rhHZwP2wDKZWHFxT1ow8hOrC1SkRMUVwO7wmIneyWAFFoiY640ajLohcUAe
         1uZLOWuDZ/zy98Z3/GL9qJIADWZsQEdkkewbXxwSMI4H/QF9Hc4OWZ9COPBgBD2I26mK
         AR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOJAES6tNu6Y/rEU3NZMbDi0UCSM39vMiEfPAnDU2yQ=;
        b=TPyDz2E6ydO89jADWG4p/8ICxSprg3Qs3RiV4I3JvzFeZSPgzYJY/YZVMa3EUI96ov
         OjUNg+I4dr2JwZe65Pu9tKxV2XKHeVbgm7K7rog+chqDdqPK6uRmBrx/tmnct0L3WQ+f
         uOKtexYfNwsSZVqGrZKTYt0XDhgEI7135c4ZSs1v0RKiUxvRnVXtzWq5mzz6Gry2QIOy
         QYK5dcXgMTXGq1Fsp+Yhox4oyBqYsMXz/BtFout187y4dkX+1daJ99SGywyUYcvY1Gf3
         1bmieM8oGSzN0hdnP62DD/n/s5kAJSy/cetG4Yy334Pd/cWGQNfhE0ctqQXyu3SGv8ul
         QiWQ==
X-Gm-Message-State: ACrzQf159BwogIzBOb/rpAvmeF/zoin2Ww7+LMGS7YkQCu6tQP2dVglw
        +/QwJ6eLug3iGbEGLGgFO58=
X-Google-Smtp-Source: AMsMyM6Pwwj1EjhSnByt5dcTN1pcj5GeOJQJvswZ4TxAF89Dt8b/fSdi0P0ZtEUxWzfpApkpPv+uxQ==
X-Received: by 2002:a17:90a:dc05:b0:20a:d73b:53a3 with SMTP id i5-20020a17090adc0500b0020ad73b53a3mr1003054pjv.67.1665682751152;
        Thu, 13 Oct 2022 10:39:11 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f206-20020a6238d7000000b005624e9b3e10sm2280130pfa.210.2022.10.13.10.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 10:39:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 13 Oct 2022 07:39:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+9baaae5fc5795e2e6acf@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 kernfs_walk_and_get_ns
Message-ID: <Y0hNPf+00n26OanO@slm.duckdns.org>
References: <0000000000002b89b205ead703ff@google.com>
 <Y0cEQbWsy7XAkyVZ@slm.duckdns.org>
 <CACT4Y+Z9ku-uZVGvAwDD9ajr3Sx_KQHmc5hRUOB0_S2Ctj_=+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z9ku-uZVGvAwDD9ajr3Sx_KQHmc5hRUOB0_S2Ctj_=+w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 09:38:37AM +0200, Dmitry Vyukov wrote:
> What is the fix?
> syzbot needs it to close the bug and report similarly looking issues in future.

46307fd6e27a ("cgroup: Reorganize css_set_lock and kernfs path processing")

Thanks.

-- 
tejun
