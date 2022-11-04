Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF863618EDE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiKDDWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiKDDVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:21:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AD8E0E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 20:18:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so3562652pjl.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 20:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dWJcYf1IEOyHa62fvZcRIIgfl8vj4Lo0xXBk4TWvE4o=;
        b=VAQ4tQAGDSL6HKHNbaB3NF54C7Fen8bOFiCbi4PtSBCoGKZWm4V6H4yctKFjJP/s1d
         gfVWsWEnhSSlFtEME+lXGCwrHPPE1AWyHJADTSUX3M6zkg9Om288/Yomi1m/3ojgrqzj
         YwfNbB4ArMv34TkvtfXd38RZZrhSUAVNVyRHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWJcYf1IEOyHa62fvZcRIIgfl8vj4Lo0xXBk4TWvE4o=;
        b=eTnyhabl/uI6tQp1jbKawlL+GOatayPFQEpY4W4L4noBgJ3YAdt1Yw6HCPisTvhKWs
         IuFq0MCEc5n9ETJSMp8Ab7kywJzy6LUNaBOqJNMEutf5jjTSTjCgaFDfYGWqpbO6JcaW
         OwK81qNDd8LZQ4hLPWTc9xX8YorbddEcas8Z6U926s6h/4j3NdVHRtau4Efdr9gcBg54
         RqBxKR1s5lsFP+VPbrkHlGEAGsxesCiPCewAyiEWshpSqjiPYWDmTGc/HxH6gMFA1Q8u
         TeOzDv/zKEzZEUfbaMrYbeL3US8ukJFlW+b9aGMtvAeXranWCYlK0M/x+uZ0y3VXVNR1
         CV/g==
X-Gm-Message-State: ACrzQf3vHU3MWSXRy1sAHsWgglrN8f/a+Yl5D15ceNLSA9QiVar3O7JY
        ++iZXdyca8OrzLup7E2zoUWdUw==
X-Google-Smtp-Source: AMsMyM6YDoe38XGmkuz7YEBbI47fSd/4+C8NqQ48pKnobyDDqnFPlIak2tfZkBrAKUX6W6O/HeBI6w==
X-Received: by 2002:a17:902:a502:b0:186:aed2:f69d with SMTP id s2-20020a170902a50200b00186aed2f69dmr33699590plq.46.1667531928235;
        Thu, 03 Nov 2022 20:18:48 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f2f6:8f5:87c8:3aeb])
        by smtp.gmail.com with ESMTPSA id y8-20020a1709027c8800b001785a72d285sm1437938pll.48.2022.11.03.20.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:18:47 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:18:43 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2SEkzKSWx2iQzLl@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2Ptq1GZISCD7Mor@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Ptq1GZISCD7Mor@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/03 09:34), Minchan Kim wrote:
> > > My point is that we don't need to implement it atm but makes the
> > > interface to open the possibility for future extension.
> > > 
> > > What do you think?
> > 
> > So, as far as I understand, we don't have reason to add remove_recomp_algo
> > right now. And existing recomp_algo does not enforce any particular format,
> > it can be extended. Right now we accept "$name" but can do something like
> > "$name:$priority". The only thing that we probably need to do is rename
> > recomp_algo to either add_recomp_algo or register_recomp_algo?
> 
> Yeah, I like the name and priority format.
> 
> Only question is how we could support algorithm selection change
> under considering multiple secondary algorithms.

So what I was thinking about, and I'm still in the mental model that
re-compression is a user-space event, just like writeback, extension
of recompress sysfs knob with "algo_index" (or something similar) which
will mirror algorithm priority.

Example:

Configure 2 alternative algos, with priority 1 and 2

	echo "name=lz4 priority=1" > recomp_algo
	echo "name=lz5 priority=2" > recomp_algo

Recompress pages using algo 1 and algo 2

	echo "type=huge threshold=3000 algo_idx=1" > recompress
	echo "type=idle threshold=2000 algo_idx=2" > recompress

Maybe we can even pass algo name instead of idx.
