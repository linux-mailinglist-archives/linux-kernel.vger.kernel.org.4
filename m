Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3482161A5B7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKDX0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiKDXZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:25:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4B728700
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:25:50 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so5754962pjd.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8HZa0x37maTa++1KlKSVo9J5t91bCUk4WcF1knYOig=;
        b=OIk0wWKdO/WHASO4D6Va7QTPjpaYWUt1ibyoLOBpJLdLWmTBdlzTzK/i1twg7GVeZg
         XSfTqsV4TbocQsiyMn1fUy7MJn4sKDL/a8e/cdec1svaCSX8K6nGayZCFpO2Ue/AIENL
         wXysJzNEIGvMF0nJm6BFGllTX/4rWv/E12by0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8HZa0x37maTa++1KlKSVo9J5t91bCUk4WcF1knYOig=;
        b=JfBpg4475snIsAo4pS2i1oc7Z0vZjB/xSthF3/AdGBTh8dShKs0ezEbiQdKP8MMpsw
         MOhto+E06L3D9QCOJgGusJWAlKEaRF4fg/Xjn7Mw1qCxTj+FMJTADOY6LNwaZ8LskH0e
         1ikH5y87jAvZUjNb504DjQU1e5G3Q9fkU+0gF8v90PEwkMt8pJOOCCDP267fJ0J6tVel
         OO9PDMaFM7cl3GotuayyFjMBu/X3JTBXtS7MXoXdtS7Nj1kX6Qm/TpdEAh+Bf0HukS93
         V/Ubdq/evy6rsKzbS32xFICCKVByE3xFl4hZAhjKUUPYjehpyBqcYZ/cuM3k/jW7FC4g
         HodQ==
X-Gm-Message-State: ACrzQf1Ir6ZMxBkuk11HQnBmEIs7rBrhtb2XNR79jMcJootdq4iHksmt
        BtgZT1jq0UHx99znkhDSYis/xg==
X-Google-Smtp-Source: AMsMyM7iBqkri4YuVJ8gX0qgjTiLGhQ4ztkwcf2kUOu6yQfQbgWOf/iCwUQFQqHC6mnIW8j9xZDr5g==
X-Received: by 2002:a17:902:f786:b0:180:6f9e:23b with SMTP id q6-20020a170902f78600b001806f9e023bmr38624968pln.37.1667604349762;
        Fri, 04 Nov 2022 16:25:49 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f2f6:8f5:87c8:3aeb])
        by smtp.gmail.com with ESMTPSA id z12-20020a170903018c00b00180daa59314sm282198plg.125.2022.11.04.16.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 16:25:49 -0700 (PDT)
Date:   Sat, 5 Nov 2022 08:25:44 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2WfeLNwkwQZkEi8@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2Ptq1GZISCD7Mor@google.com>
 <Y2SEkzKSWx2iQzLl@google.com>
 <Y2U+/xQBwR3MPygL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2U+/xQBwR3MPygL@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/04 09:34), Minchan Kim wrote:
> > > > So, as far as I understand, we don't have reason to add remove_recomp_algo
> > > > right now. And existing recomp_algo does not enforce any particular format,
> > > > it can be extended. Right now we accept "$name" but can do something like
> > > > "$name:$priority". The only thing that we probably need to do is rename
> > > > recomp_algo to either add_recomp_algo or register_recomp_algo?
> > > 
> > > Yeah, I like the name and priority format.
> > > 
> > > Only question is how we could support algorithm selection change
> > > under considering multiple secondary algorithms.
> > 
> > So what I was thinking about, and I'm still in the mental model that
> > re-compression is a user-space event, just like writeback, extension
> > of recompress sysfs knob with "algo_index" (or something similar) which
> > will mirror algorithm priority.
> > 
> > Example:
> > 
> > Configure 2 alternative algos, with priority 1 and 2
> > 
> > 	echo "name=lz4 priority=1" > recomp_algo
> > 	echo "name=lz5 priority=2" > recomp_algo
> > 
> > Recompress pages using algo 1 and algo 2
> > 
> > 	echo "type=huge threshold=3000 algo_idx=1" > recompress
> > 	echo "type=idle threshold=2000 algo_idx=2" > recompress
> > 
> > Maybe we can even pass algo name instead of idx.
> 
> Let's use name rather than index.

OK. Any preference on the keyword? "name="? "algo="? "algorithm="?
"compressor="? "comp="?

I want use the same keyword for recomp_algo. I sort of like "algo=",
but not sure.
