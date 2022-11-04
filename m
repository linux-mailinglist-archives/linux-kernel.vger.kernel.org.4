Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BC661A596
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKDXXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiKDXXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:23:03 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CCC1A83F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:22:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k5so5786522pjo.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 16:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EtYEsODmOJKvYgJZvGMTSL9jwi2RIaTO198SEqeZWk8=;
        b=Yx+CBKf4b3KimfG4I1K3wtyMnr4zWBmG9vP+RGZKvxAKi2aXG9ZT3RSjIEEkARv+y4
         2yq+bckIcAk9EMJtiAgzpW39dwVAQODD4yMMEI0ZVIYlrvffXa9VtmUTJ6OugBkAHOww
         AreU5v+ERdUcXBB7IhPjpSsMbF0Km0Wyaz3eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtYEsODmOJKvYgJZvGMTSL9jwi2RIaTO198SEqeZWk8=;
        b=wn5xX+Vkj44aE2vaxi0jgb9mnt2BfLS9596jNZ3e+sG0ademsoIeAE45Nbt+2um0gW
         bX5oP2chfSWNSUV4IonLaFatTRyATb9QqtRVCUdD53DmyBR9Zl1kUXoBCWoR+WBCzdBu
         5/yTB+GylBwwQGOg/DJXrUWABQoWMX7WiQCG56jAIONS+jvCrsIuuJR1C5V+CVm30Rju
         tvP4ktM7KI7M0NxfNU/1Ucpw2Z+ynCCjcZfrQxfw4O+bj94Br33+lnhua85fNyOlhtzs
         PMEw63EVqemG++UyaQSTKhH/rcpSeCrLsoyVE0Hcbf4W6A9d/WHoOqpT76E8Cc1BrTqq
         WZzg==
X-Gm-Message-State: ACrzQf04XKqE+lEpovul7aCzxavjrU23wUo9d1nu04g7yi/aFvrohZHd
        /UXKupyJA/1Waz4AwxzaIhBdAQ==
X-Google-Smtp-Source: AMsMyM5GU5/IpL3gkA0TW2Vgms2y3dZj/AWxzTNpIvA/UlCRAFs0WcnyIDOnjHUFGluK+YQcmeQC2Q==
X-Received: by 2002:a17:902:b581:b0:186:fb90:1151 with SMTP id a1-20020a170902b58100b00186fb901151mr37666494pls.43.1667604179246;
        Fri, 04 Nov 2022 16:22:59 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f2f6:8f5:87c8:3aeb])
        by smtp.gmail.com with ESMTPSA id m20-20020a635814000000b0046ff7db0984sm234228pgb.72.2022.11.04.16.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 16:22:58 -0700 (PDT)
Date:   Sat, 5 Nov 2022 08:22:54 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 4/9] zram: Introduce recompress sysfs knob
Message-ID: <Y2Wezsw+FQU6KAlq@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-5-senozhatsky@chromium.org>
 <Y2Lbxp6to4QNYyGe@google.com>
 <Y2M0t5etyJiUfeQi@google.com>
 <Y2PzseskzPelrZum@google.com>
 <Y2SLmuxLy8tf1X9m@google.com>
 <Y2VLf+W1xwBuu0G7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2VLf+W1xwBuu0G7@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/04 10:27), Minchan Kim wrote:
> > objects that are in-compressible (in a way that saves us memory in
> > zsmalloc) by any of the ZRAM's algorithms.
> > 
> > > read_block_state
> > >     zram_algo_idx(zram, index) > 0 ? 'r' : '.');
> > > 
> > > zram_read_from_zpool
> > >     if (zram_algo_idx(zram, idx) != 0)
> > >         idx = 1;
> > 
> > As an idea, maybe we can store everything re-compression related
> > in a dedicated meta field? SKIP flag, algorithm ID, etc.
> > 
> > We don't have too many bits left in ->flags on 32-bit systems. We
> > currently probably need at least 3 bits - one for RECOMP_SKIP and at
> > least 2 for algorithm ID. 2 bits for algorithm ID put us into situation
> > that we can have only 00, 01, 10, 11 as IDs, that is maximum 3 recompress
> > algorithms: 00 is the primary one and the rest are alternative ones.
> > Maximum 3 re-compression algorithms sounds like a reasonable max value to
> > me. Yeah, maybe we can use flags bits for it.
> 
> If possbile, let's go with those three bits into flags since we could
> factor them out into dedicated field, anytime later since it's not ABI.

Ack.
