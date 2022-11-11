Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912C5625884
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKKKjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiKKKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:39:38 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7178F654F6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:39:37 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id e129so4094574pgc.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2JUDV1unVlaXbofWs/pNvlYuHbbOkp9TycnqFbOAXE=;
        b=F+RBn0VN/l/Y5JdSEZ8vZ3ybsM7Js2Nn5c/9xjxvRezBTsc7XxRbmgSuss6c3f3JFU
         AvqELYzGgFD1+2dTP9v9k9qvY+UDPtlwona1Lz6F0bNcNoBSxE9JbuWaT4TxkwvnZ4ep
         CT9eGaywFuc1S9zV1Wec4IFXOLBbaE7iV00k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2JUDV1unVlaXbofWs/pNvlYuHbbOkp9TycnqFbOAXE=;
        b=KoG0KB22Tj9kRjExxX98Fh9sHTh9UyLHgVvqshTnORD0F/VWBoJl2gcpBQyhw7Rrqa
         3kMmwk5SFbLuvna11XeyQCwI+kl0I0HrR0csgsM0RORi3QSgmhFXWWjIogdWvPSArW+O
         OXl0GDNzSaErXxXw4n/ISjKtDBprd+6hHPpvwkfufHK5cmL6JoUyI/VtdmGoyEbm62sF
         vA0xmrlvythEXfx0z/Ybo69lfelgxdyWbwpF17z55aUdohLRkhhlTw3vlWNHR5Tej6yS
         iNkFIshj/ORdLBvM28aKVW/0n8oftVNZXsZLZFthhwVOcaKPSmvGdNNP2HJidCcmoUEN
         cYxA==
X-Gm-Message-State: ANoB5pkiV7YJve9VTGUFtZ6ZqZLq4mlS/zPZNRW45LeNJJIqY+QtgsvP
        tChkrc/jDCCG4ZQmSTngIMfo/Ox+zMdzDQ==
X-Google-Smtp-Source: AA0mqf7/PaKUrzSWu4IL6ADDSKU5/ZNHIQuZjV3IauWIvRuN5B2UAJJg4qQg3bJ+YQXuRJ3Td6vVJQ==
X-Received: by 2002:a63:c146:0:b0:464:a9a6:5717 with SMTP id p6-20020a63c146000000b00464a9a65717mr1036159pgi.584.1668163176947;
        Fri, 11 Nov 2022 02:39:36 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d55:c60d:579d:741c])
        by smtp.gmail.com with ESMTPSA id s19-20020a634513000000b0046faefad8a1sm1084596pga.79.2022.11.11.02.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 02:39:36 -0800 (PST)
Date:   Fri, 11 Nov 2022 19:39:31 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Nitin Gupta <ngupta@vflare.org>, Jens Axboe <axboe@kernel.dk>,
        Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: zram_recompress(): OVERRUN
Message-ID: <Y24mY4QFq+3Obnkd@google.com>
References: <202211100847.388C61B3@keescook>
 <Y22WtxzDXM5PfFnb@google.com>
 <202211101904.7A0B0C3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211101904.7A0B0C3@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/10 19:15), Kees Cook wrote:
> On Fri, Nov 11, 2022 at 09:26:31AM +0900, Sergey Senozhatsky wrote:
> > On (22/11/10 08:47), coverity-bot wrote:
> > > *** CID 1527270:    (OVERRUN)
> > > drivers/block/zram/zram_drv.c:1727 in zram_recompress()
> > > 1721     		zstrm = zcomp_stream_get(zram->comps[prio]);
> > > 1722     		src = kmap_atomic(page);
> > > 1723     		ret = zcomp_compress(zstrm, src, &comp_len_new);
> > > 1724     		kunmap_atomic(src);
> > > 1725
> > > 1726     		if (ret) {
> > > vvv     CID 1527270:    (OVERRUN)
> > > vvv     Overrunning array "zram->comps" of 4 8-byte elements at element index 4 (byte offset 39) using index "prio" (which evaluates to 4).
> > 
> > Hmm... I don't really see how prio can evaluate to 4.
> 
> Yeah, I agree. This looks like a false positive. I'm not sure why
> Coverity triggered for it. Looking at the extended report, it seems to
> not have any idea that prio_max is correctly bounded.
> 
> Sorry for the noise!

No worries!
