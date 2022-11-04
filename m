Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26695619EB7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKDR17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiKDR1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:27:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCE9330
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:27:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso5125518pjc.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ic558+CyRUCz1e5KjxZoWOQyUv1PrJmNJRwEzMieMgQ=;
        b=QaPPqo8O7+x7YAkMZM+CntItXhoDS2obnuRv7W4QbTPSpfCONmNpO9DXsD07vc1DLk
         eT+GcU/6B3tQFCusNwuGLes+roUu+ZmM6xrrf15Zwt2cY/SvPtQOMJr0lBA0DQxywer5
         Gywc8K2TqqbfLpw3FQaqxPaU+0AivMNAuRkV7bFsysDhZVgX64MTU4hfXohXukcoSZ4V
         NiT85BhSp1zs2/N0UugqTTFsxJbt721SIDYuoxv4x4i03K1RHUvdDdQ0nV/s6P8lKp2h
         mi4Y3on5DGxxH622kbZIVWZDcqf/I5AS4WAsAjfXA6NbYVpbG09glA8lE1ipeWEPyk9e
         3Teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ic558+CyRUCz1e5KjxZoWOQyUv1PrJmNJRwEzMieMgQ=;
        b=VFn8W/jkQ6FlG6lOoXIYcco/r56M3qKvhV0Li7fGn4ZEPkpI+noB4LFq0SkKKc4Om6
         cSBFegx3iPcnb3QfZYwtBF+Y50gw2sjZ1/3Te1xpVF3jeqeiKlY7YshBJszMpF+2J80b
         im1V6ufuHlQrNGEiMjjxOIPyaZXSCfhRfqOzwEm34rHWsWZgPR1qrP5FSARSk0qOh6fs
         KRdFQZPP6INegTPjSPpeIa0Qf2O3FhubyMNuNY0ohaMAJhOo7vkSYlmBvsHLRPrYReLa
         scS8BdBZiHGe0iGkNGCtASa0jx5F568LyWuleziGkYZm7T4KSM99NQKOovT0Kb70eqlr
         j5gw==
X-Gm-Message-State: ACrzQf0w45KXXkmamttPpT/4P81iFX7nTM36QOLbPdNBAbGAn2vJuQWc
        40G/3e1VPQl290BLLCmUpl0=
X-Google-Smtp-Source: AMsMyM4ySUTdCIvPYgu8hzeyqE9Nlw0BmDBEw0F+NyEkXkNLeXxgqXBOz67dZ6RscY3mcc8Dn+4wDw==
X-Received: by 2002:a17:903:40ce:b0:188:62b9:cece with SMTP id t14-20020a17090340ce00b0018862b9cecemr5389069pld.93.1667582849289;
        Fri, 04 Nov 2022 10:27:29 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:755f:cdcb:1bd8:5ad8])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00183e2a96414sm23393pln.121.2022.11.04.10.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:27:28 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 4 Nov 2022 10:27:27 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 4/9] zram: Introduce recompress sysfs knob
Message-ID: <Y2VLf+W1xwBuu0G7@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-5-senozhatsky@chromium.org>
 <Y2Lbxp6to4QNYyGe@google.com>
 <Y2M0t5etyJiUfeQi@google.com>
 <Y2PzseskzPelrZum@google.com>
 <Y2SLmuxLy8tf1X9m@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2SLmuxLy8tf1X9m@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 12:48:42PM +0900, Sergey Senozhatsky wrote:
> On (22/11/03 10:00), Minchan Kim wrote:
> [..]
> > > Per-my understanding this threshold can change quite often,
> > > depending on memory pressure and so on. So we may force
> > > user-space to issues more syscalls, without any gain in
> > > simplicity.
> > 
> > Sorry, didn't understand your point. Let me clarify my idea.
> > If we have separate knob for recompress thresh hold, we could
> > work like this.
> > 
> > # recompress any compressed pages which is greater than 888 bytes.
> > echo 888 > /sys/block/zram0/recompress_threshold
> > 
> > # try to compress any pages greather than threshold with following
> > # algorithm.
> > 
> > echo "type=lzo priority=1" > /sys/block/zram0/recompress_algo
> > echo "type=zstd priority=2" > /sys/block/zram0/recompress_algo
> > echo "type=deflate priority=3" > /sys/block/zram0/recompress_algo
> 
> OK. We can always add more sysfs knobs and make threshold a global
> per-device value.
> 
> I think I prefer the approach when threshold is part of the current
> recompress context, not something derived form another context. That
> is, when all values (page type, threshold, possibly algorithm index)
> are submitted by user-space for this particular recompression
> 
> 	echo "type=huge threshold=3000 ..." > recompress
> 
> If threshold is a global value that is applied to all recompress calls
> then how does user-space say no-threshold? For instance, when it wants
> to recompress only huge pages. It probably still needs to supply something
> like threshold=0. So my personal preference for now - keep threshold
> as a context dependent value.
> 
> Another thing that I like about threshold= being context dependent
> is that then we don't need to protect recompression against concurrent
> global threshold modifications with lock and so on. It keeps things
> simpler.

Sure. Let's go with per-algo threshold.

> 
> [..]
> > > > Let's squeeze the comp algo index into meta area since we have
> > > > some rooms for the bits. Then can we could remove the specific
> > > > recomp two flags?
> > > 
> > > What is meta area?
> > 
> > zram->table[index].flags
> > 
> > If we squeeze the algorithm index, we could work like this
> > without ZRAM_RECOMP_SKIP.
> 
> We still need ZRAM_RECOMP_SKIP. Recompression may fail to compress
> object further: sometimes we can get recompressed object that is larger
> than the original one, sometimes of the same size, sometimes of a smaller
> size but still belonging to the same size class, which doesn't save us
> any memory. Without ZRAM_RECOMP_SKIP we will continue re-compressing

Indeed.

> objects that are in-compressible (in a way that saves us memory in
> zsmalloc) by any of the ZRAM's algorithms.
> 
> > read_block_state
> >     zram_algo_idx(zram, index) > 0 ? 'r' : '.');
> > 
> > zram_read_from_zpool
> >     if (zram_algo_idx(zram, idx) != 0)
> >         idx = 1;
> 
> As an idea, maybe we can store everything re-compression related
> in a dedicated meta field? SKIP flag, algorithm ID, etc.
> 
> We don't have too many bits left in ->flags on 32-bit systems. We
> currently probably need at least 3 bits - one for RECOMP_SKIP and at
> least 2 for algorithm ID. 2 bits for algorithm ID put us into situation
> that we can have only 00, 01, 10, 11 as IDs, that is maximum 3 recompress
> algorithms: 00 is the primary one and the rest are alternative ones.
> Maximum 3 re-compression algorithms sounds like a reasonable max value to
> me. Yeah, maybe we can use flags bits for it.

If possbile, let's go with those three bits into flags since we could
factor them out into dedicated field, anytime later since it's not ABI.
