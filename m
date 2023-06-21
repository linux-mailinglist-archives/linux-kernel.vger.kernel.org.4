Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481207385C6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjFUNzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjFUNzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:55:24 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61C0E6E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:55:23 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-39ee19cfb77so2234899b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687355723; x=1689947723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p4pHQjZOMqBN5NmKCmx+GJA0YbJi+vSazVFlD7bdpAk=;
        b=Q/7FQuLciu+yygCZvdriuhqDpOo04n9GD+hoY8dGXfWSHIZ6JOkYjl7Uv1RyT+nldf
         MMRVtI2vdWUyy7i+d5ulQvEheHoRH/AYXdV13q2P0gKy5ld5zvg7/a3JlkEFyzWCXAZe
         H4F7X7uTDAk5YuehaJk6iYEivkQOa6cjq/WmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687355723; x=1689947723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4pHQjZOMqBN5NmKCmx+GJA0YbJi+vSazVFlD7bdpAk=;
        b=PC7YBVMDaPNO49H/6wvOpL32L/6+byBS/CerxT51PKaTKWDSxvG9FEJsbLwQ59fv86
         Y9eYgCvTNyxhj5iC2qYHj0o9O95Et4mkNZCanBeabJcStdft6uIjLmyOhOiXUW71W5Tx
         a6Vduc0kkhs/HYdSvrHNux1ZwU37UCgZP9XivuD+xygJ8xERod9sIO/4wdAFtsZPjwNy
         kcNlF6xfqBC/Vj62Rkjnmb4LfrhvNyhleCO17sceUGrR1GYnL8PK0Qf+lad4LmX/2jAA
         yn2+wcdVCnUfx4gIt3++by4wT2sbvqRuaO4X8ewqavKcQEGiLyUZ5izxaw7Rf92t8wLk
         ySJA==
X-Gm-Message-State: AC+VfDz+LQ65AdcJFO1NgH/SdmLMMlDWgfb0+ScGXHtydiDJQJor1AB5
        /gluisTaakalwJ17wt4vx31l4A==
X-Google-Smtp-Source: ACHHUZ42TWrozkAAl8dKheHX8FGuRKJk/RX5JCl2EV0zp5CjFa3l5t0IGddLDqpWq/voYddAFYYhCQ==
X-Received: by 2002:a05:6808:614c:b0:3a0:3a17:a146 with SMTP id dl12-20020a056808614c00b003a03a17a146mr4511810oib.57.1687355722979;
        Wed, 21 Jun 2023 06:55:22 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id y17-20020a63e251000000b0050a0227a4bcsm3163906pgj.57.2023.06.21.06.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:55:22 -0700 (PDT)
Date:   Wed, 21 Jun 2023 22:55:18 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <AVRomanov@sberdevices.ru>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1 1/2] zsmalloc: add allocated objects counter for
 subpage
Message-ID: <20230621135518.GD2934656@google.com>
References: <20230619143506.45253-1-avromanov@sberdevices.ru>
 <20230619143506.45253-2-avromanov@sberdevices.ru>
 <20230620103629.GA42985@google.com>
 <20230620111635.gztldehfzvuzkdnj@cab-wsm-0029881>
 <20230621131716.GC2934656@google.com>
 <20230621134130.tm2oucg5eskelwzr@cab-wsm-0029881>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621134130.tm2oucg5eskelwzr@cab-wsm-0029881>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/21 13:41), Alexey Romanov wrote:
[..]
> > +static bool zspage_empty(struct zspage *zspage)
> > +{
> > +	return get_zspage_inuse(zspage) == 0;
> > +}
> > +
> >  /**
> >   * zs_lookup_class_index() - Returns index of the zsmalloc &size_class
> >   * that hold objects of the provided size.
> > @@ -1787,6 +1792,10 @@ static void migrate_zspage(struct zs_pool *pool, struct size_class *class,
> >  		obj_idx++;
> >  		record_obj(handle, free_obj);
> >  		obj_free(class->size, used_obj, NULL);
> > +
> > +		/* Stop if there are no more objects to migrate */
> > +		if (zspage_empty(get_zspage(s_page)))
> > +			break;
> >  	}
> 
> Yes it seems my version is not as good as I thought. Looks bad for an
> architecturally dependent PAGE_SIZE. [..]

Well, we are looking for a solution that is both reasonable (perf wise)
and is maintainable.

> I can implement this option. I'll test this and send patch this week.

Either that or, if Suggested-by: Alexey Romanov <AVRomanov@sberdevices.ru>
is good enough for you, then I can send a series tonight or tomorrow (after
some testing). I have two more patches on top of that one.
