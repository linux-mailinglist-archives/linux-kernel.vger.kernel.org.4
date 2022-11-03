Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21141617552
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKCDz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiKCDyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:54:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013A1178B8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 20:54:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 4so805019pli.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 20:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJiPqyKG7qkpi2KSk0a4gpC5uX6Azw5NbmCuDumKLuQ=;
        b=OJ2UavJdv6Ap58NAI4f8cl1JKxdpunJfWpAXBe2WDOpwElPbSw0vLeX+oWC6y6CeY2
         avbQA5sVZ+cK0wr7mvSm9TVxJUXm6lqKGYP7zBzl0BFSPi4j4SrekamltEfGM59oysBg
         ZJK7NyaKcvRbaUUDJUMgGiP3/o1yfnF0FduP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJiPqyKG7qkpi2KSk0a4gpC5uX6Azw5NbmCuDumKLuQ=;
        b=NtpFbok/NPGDAqWTw5tOIfFsG/BcS2DqI/GJQTZMi7la7DyxlIYWJwn4o9ejvi/6so
         HYu5gDEwfj6hEfJiNz0LfTDLLjgTiDjs7+zMxFoIDYGZCC5KsGa/aEZt4N1AmWJa6l2w
         D3bSWt9VTWoUImreQ98EbCbtKVDVZXPTWvGscrvp1Fnq94iS+uHizc+tRmj9J5sPn7V2
         WxeZnMKB+dYDNNp/HDe/1CQhxnLMlI0nJt/xH2CR0e9zQjxv8GW4yUBUpSAxu3YPnh3u
         LIRDvbk9cbLtCV8v2wwkF8bSQbmssLDygTFjWZ9+RZVf4R0h511HXt4LY0OrX+oeag0a
         MwYQ==
X-Gm-Message-State: ACrzQf3J00ZHd+OJVdiwGFr6Zt7wZXQiSPXANA+olY0T8F22g34CcftR
        Vxk3WMOykUCAsui36WOGA8mEnw==
X-Google-Smtp-Source: AMsMyM7TwFRz43Wuxf3h7IChzSXvD57HT2cm/P51xVhWnid2oadAqibgbmmJyu1UagtUG7Dk5Y4eMA==
X-Received: by 2002:a17:902:860a:b0:186:7eab:afa2 with SMTP id f10-20020a170902860a00b001867eabafa2mr27968051plo.46.1667447688504;
        Wed, 02 Nov 2022 20:54:48 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f22:e30:374d:5a2b])
        by smtp.gmail.com with ESMTPSA id c90-20020a17090a496300b00203ab277966sm2236283pjh.7.2022.11.02.20.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 20:54:48 -0700 (PDT)
Date:   Thu, 3 Nov 2022 12:54:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2M7g9fFWoa+MPh/@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Mv4l+V9iCv9EMg@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/03 12:05), Sergey Senozhatsky wrote:
> [..]
> > Just open question(I might be too paranoid?)
> > 
> > I am thinking someone want to add third comp algorithm in future
> > to balance decompression and memory efficiency.
> > 
> > If it's not too crazy idea, let's think about the interface.
> > Maybe, could we make the recomp knobs works like list?
> > 
> > # A primary comp
> > echo "A" > /zram/comp_algo
> > 
> > # Multiple secondary comps
> > echo "B threshold" > /zram/add_recomp_algo
> > echo "C threshold" > /zram/add_recomp_algo
> > echo "D threshold" > /zram/add_recomp_algo

As a side note:
The way it's implemented currently is that comps is an array, so we
can store more comps there. I sort of was thinking that we probably
can have more than two algos at some point the in the future (hence
the MULTI_COMPRESS config option).
