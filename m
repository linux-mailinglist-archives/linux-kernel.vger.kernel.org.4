Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A989161755E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiKCEJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiKCEJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:09:54 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A2713F0A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 21:09:54 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id b62so664518pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 21:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjgiL2MLpB7k2dv0Fav14nQzud4nvz81K/5lxqZhfgU=;
        b=Ie7RO6PLa858Ia9kdyuyUiMlAvM8UZsnPeP1mn7nTLR9ZwGRt+Kf1PdHW6o9D6J93i
         iT0YgS4DJRhMaAXuP4oeyfXlk1/V48NlsRuAd56nHsHXGPJLz4XaBnYB/2O5sxCG0EX3
         2L0kSSpJmwIsjmUndUp2oFhaYc2BJkJA4Gf08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjgiL2MLpB7k2dv0Fav14nQzud4nvz81K/5lxqZhfgU=;
        b=Z/2m2KT+MwoJ1AWz1BHUYd4VENi8ra+FUrbFb7bTnX6m1hNi3gstF2MvwBQao5pEFF
         ZF7YDsQ2lM4l60+vHEwBunO6gD/Puz/VrsX2V59DtG30oZtm0l6YNTDLPR3RMWPFw1vf
         PkcQ6x0A3mGzobv4Y6lNPMLDiZMk5YMDndpSn8gj5iO6xN2LPO9C7EQPYwt4UIK0Dpu7
         JgBuCssbU4QIMwjsrpVHKnUaN0mQ02kK0WJI5b35C6XWHgV+6EHjxeN498vPJcR8x3mn
         3I7izGW/jNqvI/S3xhjM2LwYstIqeu/urjGEMnMrSYsD2LIGuyTLGCWU0E2od9HPR8Ee
         q5Yg==
X-Gm-Message-State: ACrzQf0ajQjntSef6mu3pHKQu4UD3UFbQgvRT4Si0HnRNiweDwgTBIFe
        MxvQIlmiXsk7hHks8c3U/arlLw==
X-Google-Smtp-Source: AMsMyM5csRwutJPzmf7vWy9aYKQhU2w+QRsF3X/nPdTWHybfb4qKRtzaGxW3B8Dnnvp+dRF5jUvcUg==
X-Received: by 2002:a05:6a00:2446:b0:528:5da9:cc7 with SMTP id d6-20020a056a00244600b005285da90cc7mr28855537pfj.51.1667448593611;
        Wed, 02 Nov 2022 21:09:53 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f22:e30:374d:5a2b])
        by smtp.gmail.com with ESMTPSA id z5-20020a170903018500b00186ff402525sm3599016plg.213.2022.11.02.21.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 21:09:53 -0700 (PDT)
Date:   Thu, 3 Nov 2022 13:09:49 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2M/DeLwab0o7btv@google.com>
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
> What is the use case for removal of a secondary algorithm?
> 
> > My point is that we don't need to implement it atm but makes the
> > interface to open the possibility for future extension.
> > 
> > What do you think?
> 
> So, as far as I understand, we don't have reason to add remove_recomp_algo
> right now. And existing recomp_algo does not enforce any particular format,
> it can be extended. Right now we accept "$name" but can do something like
> "$name:$priority".

Or with keywords:

	name=STRING priority=INT

and the only legal priority for now is 1.
