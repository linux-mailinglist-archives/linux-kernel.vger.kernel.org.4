Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8133D5FBB6B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJKTiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJKTiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:38:52 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1ED82776
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:38:51 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u71so6145562pgd.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BoD1TrFnHODKjhV4B7gjV4b37KMnqf573SMeed0vo6o=;
        b=lT9GqNuiIDtAlIvuPeINBt3QbFWbpaFf0BQuReX7ODfYEFG6Vj5SCCBr30nbfRJKuJ
         ONhMIC5vbvhR7TGDjxNJx2zKPGrdb66wgnNctthhm5zddTEF3IDcp+d+eQmo3uH3ISkV
         PbMY8oeFrE2zFCaDMRAbOPY1TAMJeG+JN4Hmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoD1TrFnHODKjhV4B7gjV4b37KMnqf573SMeed0vo6o=;
        b=R8ikqaYEg2jb/NN09DfP47NezUGYeIfxfhAaxbr6fiZ43JjE03uGHFnMcyf3ur4Lz7
         TmTw60eFZR2ka+HQEe5IIde2tbuN42f8KI8cN3MzzxgGLF2Oh+ajsQ5CYyd44wqHpb9F
         ssu9QxVzu64/VqxwFSfPCwpsf4ta17Z/QocX0IkMOb94Pj83BA5FoaK5ze2hnlG7J8ea
         fqR61I/qJhCiPwZC5C0sc0onYixDI9BVnRKcUnY3SH7EjKuVwCD5Y/2PgP6+997Ki5be
         4UIQPqP+7TGii4nqm26X0D60y/NwlHXSa5E4QZLgPl1gtRSnA7Li0j2btXge6o+4AC2X
         V+cw==
X-Gm-Message-State: ACrzQf2v9cmNg4/gOjliUFU0ftCClzYEjvLWK1WPU+W4pUMVFxEzmJm1
        H4epmoI093BNBO3Z8aOgBLEYnz36bO5cUw==
X-Google-Smtp-Source: AMsMyM6WL3FN5VtnynLNkmz6LhBVDYtQfpyUMIm/tv6FEOnez+OBKylQDIQEAVjDXcVPDPYDK2viUw==
X-Received: by 2002:a63:5553:0:b0:43c:5c1e:424f with SMTP id f19-20020a635553000000b0043c5c1e424fmr22272287pgm.353.1665517131327;
        Tue, 11 Oct 2022 12:38:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x13-20020aa79acd000000b00561c3ec5346sm9386829pfp.129.2022.10.11.12.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 12:38:50 -0700 (PDT)
Date:   Tue, 11 Oct 2022 12:38:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     pso@chromium.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Paramjit Oberoi <psoberoi@google.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 1/1] pstore/ram: Ensure stable pmsg address with per-CPU
 ftrace buffers
Message-ID: <202210111209.7F1541F5BE@keescook>
References: <20221011183630.3113666-1-pso@chromium.org>
 <20221011113511.1.I1cf52674cd85d07b300fe3fff3ad6ce830304bb6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011113511.1.I1cf52674cd85d07b300fe3fff3ad6ce830304bb6@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 11:36:31AM -0700, pso@chromium.org wrote:
> From: Paramjit Oberoi <psoberoi@google.com>
> 
> When allocating ftrace pstore zones, there may be space left over at the
> end of the region. The paddr pointer needs to be advanced to account for
> this so that the next region (pmsg) ends up at the correct location.
> 
> Signed-off-by: Paramjit Oberoi <pso@chromium.org>
> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Paramjit Oberoi <psoberoi@google.com>

Hm, interesting point. Since only ftrace is dynamically sized in this
fashion, how about just moving the pmsg allocation before ftrace, and
adding a comment that for now ftrace should be allocated last?

i.e. something like:

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 650f89c8ae36..9e11d3e7dffe 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -788,6 +788,11 @@ static int ramoops_probe(struct platform_device *pdev)
        if (err)
                goto fail_init;
 
+       err = ramoops_init_prz("pmsg", dev, cxt, &cxt->mprz, &paddr,
+                               cxt->pmsg_size, 0);
+       if (err)
+               goto fail_init;
+
        cxt->max_ftrace_cnt = (cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU)
                                ? nr_cpu_ids
                                : 1;
@@ -799,11 +804,6 @@ static int ramoops_probe(struct platform_device *pdev)
        if (err)
                goto fail_init;
 
-       err = ramoops_init_prz("pmsg", dev, cxt, &cxt->mprz, &paddr,
-                               cxt->pmsg_size, 0);
-       if (err)
-               goto fail_init;
-
        cxt->pstore.data = cxt;
        /*
         * Prepare frontend flags based on which areas are initialized.

(Note that this won't apply to the current tree, where I've started some
other refactoring.)

-- 
Kees Cook
