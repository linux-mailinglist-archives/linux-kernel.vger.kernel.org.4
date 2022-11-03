Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47A9617457
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiKCCkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKCCki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:40:38 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7704312AE2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 19:40:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p15-20020a17090a348f00b002141615576dso3888577pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 19:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1CzhzdOGNk13VZOPHqdFQ974H6LQTp0JJL8W4fRoN5g=;
        b=PMyXnCNlzvObOAbZcR73hloc5uKhp2Amt6NbgXVUhwlFycH6Niqq+RfJcl6/7t8uKd
         RFtt2F2mJ2SEw3Rm4bqTzOqMLQtIm3PwgOHH2+dqtpP8Oe+TTy+LDcOwClLpcC92VVhR
         c3zwLx1lt1kTYo8yZCpa1DyQ/dvScj7HtilDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CzhzdOGNk13VZOPHqdFQ974H6LQTp0JJL8W4fRoN5g=;
        b=Do+M9jYfvx057Qnnybgu4/YeR4KuAyXKZC+GYfVQaacdmBgeGeayXzLgclg+hxeI4R
         WghSDTVtShJVIMOiLs5BQkeb0JzKe1gx3DZiHTlgcxXJlF+sMIOyPb8ThILUpklVamzl
         1fIxQz3tHR7JJ+Ysq+BiRrmjwbfKWNN3e79NylFS1k2JQdp0xnsP2b12M7hZ3+feDm8q
         zXlnaKLh1PMpZwgNWmL0zsHgBsgHd9UATllj2Qryy17F2wmXFDlpqQ47PBpkaTl3fa9p
         kySxzdaaRtBcQCl59BiVHPilgs3GyQjJWcI9mFi6Kcbe0Oq9gcguynh2jVZllUvwKukh
         gAcQ==
X-Gm-Message-State: ACrzQf3XCNxWHsmYdggUxNp18nl/bkRBXuY4WCzYyVMDs+dmwS9bYolZ
        E568LuwpKAbm4wLnYNxfYu1bIQ==
X-Google-Smtp-Source: AMsMyM6c2ziFWR9wmPwV8A7mix313F2P4V67TFhErnUDnURE5Xxou/a6n8C+ZqXlV9njPP5XK5yq3g==
X-Received: by 2002:a17:902:b10d:b0:187:29fe:bda0 with SMTP id q13-20020a170902b10d00b0018729febda0mr15989343plr.16.1667443236924;
        Wed, 02 Nov 2022 19:40:36 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f22:e30:374d:5a2b])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902ce0300b00176b63535adsm8984925plg.260.2022.11.02.19.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 19:40:36 -0700 (PDT)
Date:   Thu, 3 Nov 2022 11:40:31 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 1/9] zram: Preparation for multi-zcomp support
Message-ID: <Y2MqH+EdN7wX1vcl@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-2-senozhatsky@chromium.org>
 <Y2LPUlircv6a74mJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2LPUlircv6a74mJ@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/02 13:13), Minchan Kim wrote:
[..]
> >  
> > +static void zram_destroy_comps(struct zram *zram)
> > +{
> > +	u32 idx;
> > +
> > +	for (idx = 0; idx < ZRAM_MAX_ZCOMPS; idx++) {
> > +		struct zcomp *comp = zram->comps[idx];
> > +
> > +		zram->comps[idx] = NULL;
> > +		if (IS_ERR_OR_NULL(comp))
> 
> nit:
> 
> Why don't you use just NULL check? I don't see any error setting
> for zram->comps(Maybe later patch? Will keep check)?

A defense measure. zcomp_create() returns err pointer, so here
I check for err and nil just in case (if somehow someday we
accidentally have err values stored in comps). It's cheap and
safer than NULL.
