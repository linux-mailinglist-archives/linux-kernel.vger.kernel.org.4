Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C27961926D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKDIJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiKDII7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:08:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1094221266
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 01:08:58 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so7506334pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 01:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNE4/+TJdC1epwove+2dQ4MoIHCeASG45k2ERB81ttk=;
        b=jvLgUz81AaSsUkBBNw0rIxUTwkDsPsfJL3yG+Q1m8hvoPabQL3jYMLIHvnL7o7efM3
         OY4nL5C0ezKDjMbaN1oOKBgisiYuuOa9cEfHiNNi8n/U42tdRMolODVyLArAL1D6BSVZ
         mwhHI06OIgV6rTHDni7jzcchwxds0UearMStA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNE4/+TJdC1epwove+2dQ4MoIHCeASG45k2ERB81ttk=;
        b=LL+Hn3pOFgA4F5nrNt30kbim6oUEnsjh21WiEGXx4MoYGl/Weie1fimJvll92t96nZ
         t8iM477hpPrqXPnc6L9nWR8q0uXOa4AJqMFDbe/SFtiqW+q/mxWTbhlOm9JkqqARNkKz
         JI97NVHkBdKFyvbQTzlinaf/edpfzJOykPnK7J5y/69ks9FFHv7Jru9nSSbgYSXNq8Gk
         mBY9DY1rzMoDOVbtwMInwJVvWvXYkK0+uyHy8RFTHfPZyJrHT8bbuwyD7KX5Cs8nIWIK
         7W4dBxZPGWGljnurkdjzl+MP2eiQru9/80GWdfkoe1DaIkZbJ62UQIB54/JJxUTOQm0P
         RPWA==
X-Gm-Message-State: ACrzQf31K2wovCtddStPGvL+FXY8ox6eGn/jd2QK/SWqSgYcetuu6O87
        YJeqS4CjS+EItHuGy1AVUyQOJw==
X-Google-Smtp-Source: AMsMyM7XyPORBcVW/SHv1RIaXkxKX/g43vxC2PrBl/CGbEeB9WdP2jpSZ9ZaZn2kngbXEcmeqEIDYQ==
X-Received: by 2002:a17:902:d4cc:b0:186:f57d:ba61 with SMTP id o12-20020a170902d4cc00b00186f57dba61mr34296152plg.97.1667549337608;
        Fri, 04 Nov 2022 01:08:57 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f2f6:8f5:87c8:3aeb])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b00172f6726d8esm1901198pln.277.2022.11.04.01.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 01:08:57 -0700 (PDT)
Date:   Fri, 4 Nov 2022 17:08:53 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv4 4/9] zram: Introduce recompress sysfs knob
Message-ID: <Y2TIlZoOZwDB+rln@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-5-senozhatsky@chromium.org>
 <Y2Lbxp6to4QNYyGe@google.com>
 <Y2M0t5etyJiUfeQi@google.com>
 <Y2PzseskzPelrZum@google.com>
 <Y2TE6XSTkyXVF+kB@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2TE6XSTkyXVF+kB@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/04 16:53), Sergey Senozhatsky wrote:
[..]
> +static inline void zram_set_priority(struct zram *zram, u32 index, u32 prio)
> +{
> +       prio &= ZRAM_COMP_PRIORITY_MASK;
> +       zram->table[index].flags &= (prio << ZRAM_COMP_PRIORITY_1);
> +}

Uh... Something like this, sorry.

+static inline void zram_set_priority(struct zram *zram, u32 index, u32 prio)
+{
+       prio &= ZRAM_RECOMP_PRIO_MASK;
+       zram->table[index].flags &= ~(ZRAM_RECOMP_PRIO_MASK <<
+                                    ZRAM_RECOMP_PRIORITY_1);
+       zram->table[index].flags |= (prio << ZRAM_RECOMP_PRIORITY_1);
+}
