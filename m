Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAE173C656
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 04:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjFXC3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 22:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjFXC3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 22:29:23 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40468126
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 19:29:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b7d4b99a21so3538195ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 19:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687573761; x=1690165761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=11YyvRRAb5IUX+NMds870r+K11ScAeUGmh7sZi++E+8=;
        b=cPnU1I2S7CS0GBUJSTTWf2V3U4gplDBnYXRmSxMs0isGKgs+cZSVgES/5dxAbzmguc
         AeoYHPTjHl9KMLC2xtKpfnDBkRy/qpub3z9s2inBFV4d4k5+g+cwsGRqSL7ViflLC7sH
         eJ98cEFVhYI22uNfeGYFyYVnfrOwjmahdDUiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687573761; x=1690165761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11YyvRRAb5IUX+NMds870r+K11ScAeUGmh7sZi++E+8=;
        b=dxcr23cjIsUumHHRCmXQ5j4CJP0hzji5pTS7D0Gld/Mf3qO9sJO4U+wyuyrLn+91/t
         jqnpUeqfFP2bV6TOgJWy8IjIiFYemfqIlJEYAvg/zWpphgupEIAC+gWwrY8V6YkS/qRN
         CCQoyd/+VJV8AfXdZOAswAhhk+Ho5pi84G0+6HXePQ1KbO95fgjFhMEGQwdPBkTdnCnG
         G7lYz8RS2h8QQ42TBFCq+d2a6AlKE3gftMzQkeb0pt1irteWHC3qhiXYJ55YEgYuQUza
         GKa0GFC4a5/CX1dY67Mu2HH2Ig5PPjdsNFxdck8z/YYt3m8VsLFXpvflEYfkTC1F1NOb
         BkfQ==
X-Gm-Message-State: AC+VfDxJDBQYfFjvAyAeesufRJde9X1OBDOb80RjesUe6DFCkV5tkxMJ
        mNF1yajy3/tovQ3otQstu7qZqreCH0gFXCDrUFU=
X-Google-Smtp-Source: ACHHUZ6G7LKAO1qkjb9+GVt71O+HN8+8TN8PHJ8SXjS/nRGjq2BrtxZTp9fukBdBJ0fuwRK7FsA+fw==
X-Received: by 2002:a17:902:c944:b0:1b2:1a79:147d with SMTP id i4-20020a170902c94400b001b21a79147dmr1247425pla.2.1687573761547;
        Fri, 23 Jun 2023 19:29:21 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b00192aa53a7d5sm226294plr.8.2023.06.23.19.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 19:29:21 -0700 (PDT)
Date:   Sat, 24 Jun 2023 11:29:17 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <AVRomanov@sberdevices.ru>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] zsmalloc: do not scan for allocated objects in empty
 zspage
Message-ID: <20230624022917.GF2934656@google.com>
References: <20230623044016.366793-1-senozhatsky@chromium.org>
 <20230623044016.366793-2-senozhatsky@chromium.org>
 <20230623104917.2n6vcxvhvlwmjm2m@cab-wsm-0029881>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623104917.2n6vcxvhvlwmjm2m@cab-wsm-0029881>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/23 10:49), Alexey Romanov wrote:
> > +static bool zspage_empty(struct zspage *zspage)
> > +{
> > +	return get_zspage_inuse(zspage) == 0;
> > +}
> > +
> >  /**
> >   * zs_lookup_class_index() - Returns index of the zsmalloc &size_class
> >   * that hold objects of the provided size.
> > @@ -1625,6 +1630,10 @@ static void migrate_zspage(struct zs_pool *pool, struct size_class *class,
> >  		obj_idx++;
> >  		record_obj(handle, free_obj);
> >  		obj_free(class->size, used_obj);
> > +
> > +		/* Stop if there are no more objects to migrate */
> > +		if (zspage_empty(get_zspage(s_page)))
> > +			break;
> >  	}
> >  
> >  	/* Remember last position in this iteration */
> > -- 
> > 2.41.0.162.gfafddb0af9-goog
> > 
> 
> I think we can add similar check in zs_reclaim_page() function.
> There we also scan zspage to find the allocated object.

LRU was moved to zswap, so zs_reclaim_page() doesn't exist any longer
(in linux-next).
