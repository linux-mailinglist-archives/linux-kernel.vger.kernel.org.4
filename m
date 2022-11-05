Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450C161A640
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 01:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKEACq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 20:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKEACp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 20:02:45 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12E84298C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 17:02:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so5854730pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 17:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xCAri3GmDiSlTNge1Wq3LvamGlY3yMVS4Ph4n/65v4=;
        b=P1zu+aMI5OjVI2su4YAgD1ZfPnhfADlVBnVbqOUzVE+Xd+oOVunhqVqBKMwB1HLMw+
         NzWAqaHGyzw9PgRxaboFC/N3I3QPJT3hZ3vKjI4dBZH7ldi1esEZG950nR1YYfYSQkRz
         XZEFnL4V/SYaBIzf01n8p+hBLm1CC7wq6NiUd0PwQWsWeNk/vmCKwgeD0RFI9mnd+iMu
         s3mXx9NXxrPAivfmKXWlR2hqN2T+xrQg6A7pmBwrGfNe+Dw+e6Us0W7Hzp17MKg7nP5b
         Ond9cMzvFRoRL64tjz9q6CbGY633QPmr6NfsGvqf3y0cwKMYeID1H7SVhGa64fjp8QnW
         Gnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xCAri3GmDiSlTNge1Wq3LvamGlY3yMVS4Ph4n/65v4=;
        b=N3K0Yy3IfKZKp7OV5KKsDvLIEZlNgbf91g0fmLqeN4FGK60gE37SMZnn5pQXLdb3wd
         5ildOXrAF2c1raADawlM0wLGADkZoIdEWJX2Jl/XIU17+5JwoHFy/+VnRa7b9grbtQ28
         5KSvCD/Knbi6vNSG9a9jNJkiJuoBZ+20DsmE3Qds1gapNoGwc59XOvKQtlTxw7t08Y3N
         94U6pv/jjfHqK77aKIyPPk/ylRXsQgUeSxU2Ig0kmmAaU7kSwEH5c0ETWTAAsi7vkpDu
         XWAvC+yomJl32RON/Ca4yRirLI6aZwXK6fSFQkKSF6z5eNtCwmj+f2Ru3QJSXQ88tjv9
         drNg==
X-Gm-Message-State: ACrzQf1Jm0dwMzcgvfQwgeMiQ+GXYy1Shb9x5Jk4lT/z+iuTm7s3dekJ
        wtN7Vyg5koQ1TY1lgRGLX/rSwMif8Fg=
X-Google-Smtp-Source: AMsMyM67M5B4R8Zwwr5gf4wD1hHYiqMNYrrXQlpPKRnTkXanX9H5/KrLSAPI9K7p/XG5J6etXuHtJQ==
X-Received: by 2002:a17:902:c745:b0:186:b287:7d02 with SMTP id q5-20020a170902c74500b00186b2877d02mr38557250plq.87.1667606564108;
        Fri, 04 Nov 2022 17:02:44 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:755f:cdcb:1bd8:5ad8])
        by smtp.gmail.com with ESMTPSA id j17-20020a170902da9100b001811a197797sm298490plx.194.2022.11.04.17.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 17:02:43 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 4 Nov 2022 17:02:42 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2WoInfN5fsI7FTL@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2Ptq1GZISCD7Mor@google.com>
 <Y2SEkzKSWx2iQzLl@google.com>
 <Y2U+/xQBwR3MPygL@google.com>
 <Y2WfeLNwkwQZkEi8@google.com>
 <Y2WjCsYrGfUENegL@google.com>
 <Y2Wj7o9nibDr2X0C@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Wj7o9nibDr2X0C@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 08:44:46AM +0900, Sergey Senozhatsky wrote:
> On (22/11/04 16:40), Minchan Kim wrote:
> > > > > Configure 2 alternative algos, with priority 1 and 2
> > > > > 
> > > > > 	echo "name=lz4 priority=1" > recomp_algo
> > > > > 	echo "name=lz5 priority=2" > recomp_algo
> > > > > 
> > > > > Recompress pages using algo 1 and algo 2
> > > > > 
> > > > > 	echo "type=huge threshold=3000 algo_idx=1" > recompress
> > > > > 	echo "type=idle threshold=2000 algo_idx=2" > recompress
> > > > > 
> > > > > Maybe we can even pass algo name instead of idx.
> > > > 
> > > > Let's use name rather than index.
> > > 
> > > OK. Any preference on the keyword? "name="? "algo="? "algorithm="?
> > > "compressor="? "comp="?
> > > 
> > > I want use the same keyword for recomp_algo. I sort of like "algo=",
> > > but not sure.
> > 
> > +1 with algo
> 
> Minchan, I'm sorry I'm getting a bit confused (didn't sleep last night).
> I just saw your other email and you suggested there that we don't need
> any idx or name in recompress. Or did I misunderstand it?
> 

I should have more clear. Sorry for that.

I meant if you need some reason, I prefer "algo=' to make review
proceed. If you agree we don't need it, then, yeah, we are all good.
