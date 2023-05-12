Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17EA70001D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 08:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbjELGCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 02:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbjELGCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 02:02:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E984ED2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:02:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ab01bf474aso73175485ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683871328; x=1686463328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KiPZR3DSGJ67e3ukh6EWttwadtz/ZpMiir8Rx/LMdYI=;
        b=ksyq0ACA9mQgupqCDoZo3U6Mmi55g+yPJ1wGysXo9dObFyntRtLjEvxSEYjMe8F74T
         gt5BwUBj45RBFTqMppsiksXl4jp240Xm/1OoSru4q7cTY7q5CD3UR7I2Yn9LieMAq3sc
         RwB9YWEHDucRoxemskt8phC9PzO51eaQus3v/wmeU5d7OlOLfbDlBVQM0yZyQPeBXKIY
         enksV9p0aeSmBN76eM9ISpO2juXIvH29ku360voYQTSMzT/kobWuiYHbfQliwuTKdVm9
         A0XJXVj34S4Eg5+EmY98JFVGnKPnaj4CsZxGtgY3TXH7O4f9tA+Hf2zCcHDebsyb4yVD
         dIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683871328; x=1686463328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiPZR3DSGJ67e3ukh6EWttwadtz/ZpMiir8Rx/LMdYI=;
        b=MZJfFwcZPvwILJ9xV9S/NhfkJFtwvXN3oOtdcnVn+vMQ44TBdBzDVf5PmbaJph+EBo
         s/XN5IIuHp2uFfLoFRkOv9m1QPKIZ7o9wXzo8Kn6CHRgC4X96WRuRFgOGCPrvy+SoSSn
         H4wILJnjYTcs2f7Kks12zOmuLlGVNkO822iGAVDOHSLk06upkHI92RrxUiQw+dMTCCMZ
         G9eq+ZR/NIQY373bhYEVw5weoKNSz2RNuZnex5nzlIUfMJWNLSIrRM8IuSujIVDaBICT
         0PaoBEZr/xOUsjgJOchOD/bxa/GH3z5n2LUbGUOpcvE6rZpfNoh71kQlo7gsXi8YLm9+
         uR4w==
X-Gm-Message-State: AC+VfDwkMYg0DlUGhgmAHsM0W5/3xnwd1Wv8Cd9wlV6HeoVRNproREq/
        Scrx9hGCZnxUBtYmhm1sWcxbK4dj8aaZzZEbYmM=
X-Google-Smtp-Source: ACHHUZ4/v7ftMoPb3vohN9jQoEwLUcKW7f98bDDigmTq4AQHvLpC5uwcquRLZYeCEIEJeLSBhkBB0w==
X-Received: by 2002:a17:902:ee89:b0:1a6:74f6:fa92 with SMTP id a9-20020a170902ee8900b001a674f6fa92mr25067340pld.19.1683871328463;
        Thu, 11 May 2023 23:02:08 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001a6ed2d0ef8sm6950230plk.273.2023.05.11.23.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 23:02:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pxLqu-00EIdU-Sp; Fri, 12 May 2023 16:02:04 +1000
Date:   Fri, 12 May 2023 16:02:04 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "renlei1@chinatelecom.cn" <renlei1@chinatelecom.cn>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] xfs: xfs_nfs_get_inode support zero generation
Message-ID: <20230512060204.GC3223426@dread.disaster.area>
References: <1683800241-14488-1-git-send-email-renlei1@chinatelecom.cn>
 <20230511232206.GG858799@frogsfrogsfrogs>
 <20230512020009.GB3223426@dread.disaster.area>
 <2023051210532845432129@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023051210532845432129@chinatelecom.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 10:53:29AM +0800, renlei1@chinatelecom.cn wrote:
> Yup, gen is 0 for the inodes created by libxfs, such as rootino, rbmino, rsumino.
> but those inodes will never be freed, and gen will always zero.

Yes, but why does that even matter for file handle verification?

> so I think bypass the verification if gen==0 is still valid.

Did you think about what happens when an inode->gen
overflows from 0xffffffff to 0 as part of a normal unlink/create
cycle?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
