Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106896020FD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJRCMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJRCMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:12:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABA7635F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:12:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k9so12051310pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EhunVWViOQq+jYCX/ovpRh7yWUwRqDSJab0KzFcLVZQ=;
        b=e5a30VeCk2RpehU6eGYBcDsz/+X2qb5BtjVnkOmFBfnooFxeeOXMJVq43vTJAZmAsa
         OHGrLwVEDEpUjTY/LLRcQR1f27hbjyyQyuD55dN00I+i24ePeFCV8XC2Gc8ZjOrRIKoq
         4RFidxL6ZFXZR9thwNAwYzEpjRGuM0RDgsmPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhunVWViOQq+jYCX/ovpRh7yWUwRqDSJab0KzFcLVZQ=;
        b=deadFU7WtljDGyDtSLDjLn15sTpqR7Cp/SgOwU3txU2df8Hy5ZKGLiS7OaM51PP9Do
         Ipyl8ZgLd9OHh797SPykhpMPSKr05GxmZZ1P8GOYwMgn/f0Iyr/K+VcMPE+L80lxm74n
         R0ZC/iCGv+aSHoqSiSu8ka8DFoIrP1sQXqQTx9O2casm2j33iA2rBJVKl72ZpaLfXCoY
         B0TlizL6ORInLUBYhZAWA6IBP3OlDe5cWINq+T6UmwXbL9k5I3Q36/1Gy22q10wL92Vu
         3LhUZWDPkAd3dNlHiOlgUViJBtdjh8buSDWMAS4Td8AJq6G75prxS9chtgH1VNBVa8bR
         v66g==
X-Gm-Message-State: ACrzQf2qAsjKZBlGOKvA6wiNDVxsUzGzJgNeXZF1Ezra3q9Shgp2sVlC
        eJuydVUk2BHRrGhBn1bQ/2YV3w==
X-Google-Smtp-Source: AMsMyM7t1bozwiZ3hsC6aoXOk5mQp8jw6vae+hgNeUzIvaQtDLVnsnfhVNHEXfeCVGvBN6KrsbixOQ==
X-Received: by 2002:a17:902:7481:b0:180:58d7:24e0 with SMTP id h1-20020a170902748100b0018058d724e0mr695847pll.49.1666059134263;
        Mon, 17 Oct 2022 19:12:14 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:58b4:95a3:4654:2a9f])
        by smtp.gmail.com with ESMTPSA id w9-20020a628209000000b0056276519e8fsm1146716pfd.73.2022.10.17.19.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:12:13 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:12:10 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv3 4/8] zram: Introduce recompress sysfs knob
Message-ID: <Y04LerrIH9KTJM2A@google.com>
References: <20221009090720.1040633-1-senozhatsky@chromium.org>
 <20221009090720.1040633-5-senozhatsky@chromium.org>
 <20221017170850.034705ad83c54b92236d14f7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017170850.034705ad83c54b92236d14f7@linux-foundation.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/17 17:08), Andrew Morton wrote:
> > Allow zram to recompress (using secondary compression streams)
> > pages. We support three modes:
> > 
> > 1) IDLE pages recompression is activated by `idle` mode
> > 
> > 	echo idle > /sys/block/zram0/recompress
> > 
> > 2) Since there may be many idle pages user-space may pass a size
> > watermark value and we will recompress IDLE pages only of equal
> > or greater size:
> > 
> > 	echo 888 > /sys/block/zram0/recompress
> 
> It's helpful to describe the units ("bytes") here and in the
> docmentation.

Will send fixup patches.

> > 3) HUGE pages recompression is activated by `huge` mode
> > 
> > 	echo huge > /sys/block/zram0/recompress
> > 
> > 4) HUGE_IDLE pages recompression is activated by `huge_idle` mode
> > 
> > 	echo huge_idle > /sys/block/zram0/recompress
> > 
> > ...
> >
> > +	if (IS_ERR((void *)handle_next)) {
> 
> IS_ERR_VALUE() avoids castsing back and forth.

Thanks, I'll send a separate patch for this (if you don't mind).
