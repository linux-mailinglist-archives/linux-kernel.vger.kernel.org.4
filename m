Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747866204C2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 01:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiKHAkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 19:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiKHAkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 19:40:23 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA202611D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 16:40:20 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id h193so11990709pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 16:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OM0r5u0WH+buQLtra84lMSPb6itvSvD0nc8HMAGCciQ=;
        b=TWamq7EdLsQok6vDR75JzTopHL0ZZBUv5VALE1B1puumyYTXPDCYlR+2gogdv6Rkm2
         lugkVLtCa98IEJFVaurvYmUwXAJEojHJv3X8aHMGO4zLnat7Foc8egfpLkd71PLldEHK
         UyszcgqFuL2kpl+QHO1IrpIdrVIr8ZgPDe9kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM0r5u0WH+buQLtra84lMSPb6itvSvD0nc8HMAGCciQ=;
        b=v+P4/R94NLF+aMba6l5mbcJFdhLPVFQPH+CWGYAGEHljutvThCyb60kDfSlimuNnax
         BH7RzJHQW9uhPMec5Qkr2Rrmf70U5lxAJRbeYfauDvaev6qQIsHpwx0Jw/01HoyM94Ti
         nQvYOQOszCdyNcXv8S52pAb2vRa0iPQxIdVKUL2/rDAsvYlAMYRX2dTaGaAdV46BSktr
         Rd6ACWQ1p6v8HSQ/am0PyIPi9a4hOTqUwx2UaSCIlI8IjgnFPvZ+Jx23kwYpQP5Vdjh8
         A5nsUNLaBhNVL6DzcdbWjegmZy/og7auWEWf8F8uMuiW5lZAbBynIfHPGht4gdMk47gL
         rKSQ==
X-Gm-Message-State: ACrzQf1hYDtvzDzn1zRyOJMTKLiDhSL07WgTj23nKifOxVRkYMCe6nD/
        y61oBgzJQuxxeRJe59VKd8ECnlQz6YXSkQ==
X-Google-Smtp-Source: AMsMyM6xYGNGchyjy8QrKxApfI8UUYUySm1ARIZSxlctWm/xSgTxWJ7u0ClT72ZMItyHqsIBJBa+GA==
X-Received: by 2002:a63:8bc3:0:b0:46f:fa99:7d76 with SMTP id j186-20020a638bc3000000b0046ffa997d76mr30252805pge.134.1667868020231;
        Mon, 07 Nov 2022 16:40:20 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d5d:1342:1172:9487])
        by smtp.gmail.com with ESMTPSA id a24-20020aa794b8000000b0056cd54ac8a0sm5055970pfl.197.2022.11.07.16.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 16:40:19 -0800 (PST)
Date:   Tue, 8 Nov 2022 09:40:15 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2mlb6F7G8KskRch@google.com>
References: <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2Ptq1GZISCD7Mor@google.com>
 <Y2SEkzKSWx2iQzLl@google.com>
 <Y2Sat1/FCCT0Lia/@google.com>
 <Y2VPQlnEiP75mY5O@google.com>
 <Y2WjMQeS2DihvPQF@google.com>
 <Y2WnoVJ+Tn5kYWot@google.com>
 <Y2lXt9E6YqB7fRbQ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2lXt9E6YqB7fRbQ@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/07 11:08), Minchan Kim wrote:
[..]
> I am thinking like this:
> 
> * Without recomp_algo setup, user can do whatever they want on the fly
> 
> 
>     echo "type=idle threshold=3000 algo=zstd" > recompress
> 
> Later they could do
> 
>     echo "type=idle threshold=3000 algo=deflate" > recompress

By "without recomp_algo setup" you mean that user doesn't configure
anything before `echo XG > zramX/disksize`? Currently algorithm and
recomp algorithm need to be selected at the same time - before zram
device is initialised, because we use the same code and same approaches:
we need to have zcomp back-ends in per-CPU data in zram read/write/recompress.

Creating per-CPU zcomps on the fly is probably going to be a little bit
intrusive to zram.



What I currently have is as follows.

A copy paste from my test script:

- init device
        echo "algo=lz4 priority=1" > /sys/block/zram0/recomp_algorithm
        echo "algo=zstd priority=2" > /sys/block/zram0/recomp_algorithm
        echo "algo=deflate priority=3" > /sys/block/zram0/recomp_algorithm
        echo 5G > /sys/block/zram0/disksize


Various recompression use cases:

- recompress huge pages using all secondary algos in order of priority
        echo "type=huge" > /sys/block/zram0/recompress

- recompress huge pages using zstd only
        echo "type=huge algo=zstd" > /sys/block/zram0/recompress

- recompress all pages using lz4
        echo "algo=lz4" > /sys/block/zram0/recompress

- recompress idle pages, use all algos in priority order, with threshold
        echo "type=idle threshold=3000" > /sys/block/zram0/recompress

- recompress idle pages, using zstd only, with threshold
        echo "algo=zstd type=idle threshold=2000" > /sys/block/zram0/recompress
