Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB34961A635
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 01:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKEAAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 20:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiKEAAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 20:00:42 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6945429B8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 17:00:38 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g62so5811380pfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 17:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Bw4Wg2xM8DW6Uw0JUkLXkChOTfhtB/Y2VzKaH2aphE=;
        b=Bj19pyyzgXJLl9fB0xAc++0ux7QPokfwNSjJe28MuqeoYBzC87za4SQpYMPVs6NWH9
         6qbO19bDDHhdDI5tvodUZL98nh9vPkArZSUuEz+jeKcn9uRUZwVzzDDHR/MbUDVDPk+t
         UdeRKjuAyDR7MvQyDTLESEL5GuwQxv2JaoWMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Bw4Wg2xM8DW6Uw0JUkLXkChOTfhtB/Y2VzKaH2aphE=;
        b=32DgzzkIDYL90XBZu3nB8NknfjGsbDmhFVW734g4HaKtar2OdIbEeFn6tv+wgMhFEa
         SSgkG7np3faL6dUh5hCahzEq/caLRIpO2SR7QnGwDUG1z5UKMv64U0ETR51zDdbPtovd
         wiA4J3IaYs69MrB5s4T83nQhv4EVbwEVmnt8lz2wtxeMrHyhA0DVX8Lzf0zTQlxGkFey
         mUYf5cgRAWwCWPDHmNpiWwbz10e/ohq9Bu75JfOomTZLK/ZqABNHxXlqgRbztc1h1Ja0
         MBmMBE9zmJLokz4UqLmS/rv4OhWWFZiq/DMUQR/CDXMguRL23HjD8mJ7vc+JQsEqJvRq
         ea3A==
X-Gm-Message-State: ACrzQf2taVYqsYePSiGEgwElyCa4yhIZZMJj8mXkLRaaUImKjJzu8KbA
        IUCyICGLg/WJ07T+Hrje8Q0HXw==
X-Google-Smtp-Source: AMsMyM7IrcW5lKw5T6cWL2oCNHX/Rtw3BbCJE746Pii74aoaedXsJt2l1A9zNdQMpIW/N5kQYIssVg==
X-Received: by 2002:a63:4d53:0:b0:470:4522:2cf1 with SMTP id n19-20020a634d53000000b0047045222cf1mr2164820pgl.32.1667606438081;
        Fri, 04 Nov 2022 17:00:38 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f2f6:8f5:87c8:3aeb])
        by smtp.gmail.com with ESMTPSA id y12-20020a62640c000000b0056c349f5c70sm175258pfb.79.2022.11.04.17.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 17:00:37 -0700 (PDT)
Date:   Sat, 5 Nov 2022 09:00:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2WnoVJ+Tn5kYWot@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2Ptq1GZISCD7Mor@google.com>
 <Y2SEkzKSWx2iQzLl@google.com>
 <Y2Sat1/FCCT0Lia/@google.com>
 <Y2VPQlnEiP75mY5O@google.com>
 <Y2WjMQeS2DihvPQF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2WjMQeS2DihvPQF@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/05 08:41), Sergey Senozhatsky wrote:
> One can be SW one can be HW. So I thought about having flexibility here.
> Instead of doing
> 
> 	for (idx = 1; idx < MAX_IDX; idx++) {
> 		len = zcomp_compress(zram->comps[idx]);
> 		if (len <= threshold)
> 			break;
> 	}
> 
> We would just directly use the suggested algo.
> 
> But we probably don't need that param at all and can use
> the loop instead?

My idea was that recompress does not loop through the algos (what
on the fly recompression can do for instance), but instead
recompress only does one thing.

Because we can have, for instance, something like this

	algo=zstd priority=1
	algo=deflate priority=2

And we recompress with algo=zstd only first. Without going
into the slowest, most CPU and power consuming one. If the
memory pressure keeps increasing then we might do algo=deflate
recompress, as the last resort before we do writeback. But we
may skip algo=deflate altogether and go straight to writeback,
for instance because we have less than 30% of battery left.

So the reason I suggested algo= in recompress was, basically,
for that for having exact control of what recompression does.
