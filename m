Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D489627514
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiKNDzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiKNDzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:55:11 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA59F1582C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:55:10 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso12628956pjg.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3GShZvQl4pEmRrtjPK8DlcTmZgRHU01e2znj5m/hEU=;
        b=elfcGsDxiPXwzz150co30bptffTx7enBnC3vjVcv3FUPjNOdHhD3FFwlo7U5yP7CLQ
         zlOLSdotYjmPq1VviLKiqDA2gL+JW70oOHGjJsEYBlz/vss8FTyqJ985KmAzrF1dmfMe
         RrgLx+u+qf/rKTM9ZvkHMzZc3Ifk1DJhG1i0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3GShZvQl4pEmRrtjPK8DlcTmZgRHU01e2znj5m/hEU=;
        b=mC3jTC8knrQuMcIgip2Eop88ajwyegTxXiTpkntHLB4c/FVPT61aq0sVl7B73/Ib/e
         znDH+BrBzw14uUqADzdiOfkljKWxqrXhqKAJxu2VtHfhRfvLv+IvIlSEGkNCsk0hIMqk
         f/R6+tKJ65ZiO6nCwkNtDQim0cBpBDP/Ic5/imk3/zoq25gDFs7cnQjkpcq6Xkyk/FaW
         p8Rdp/NEP6gyJZQhnmbUQaXAFBVR+4sWQtRIxY+c5McEeNA6uSiolWHUE6ZUidOikCr6
         kHI6E52ArNHa6jlD+hSX33IQ0D2kA1xfE4h17XG2AM4hdMA3WO59fj2IW1VoUXDnax9n
         sifw==
X-Gm-Message-State: ANoB5pk5J31idRcn6Hulz3csjP1VPYGez4RMO5AAYJ7b2uJhHh9sLnXl
        eUy88QnJPcmNf/9k5mRBQ232xA==
X-Google-Smtp-Source: AA0mqf6r+S/Po/KR0EubjPX0NCRKOxILcyqeQtRODXINN+i8Y+6OLxpxyxl3MwYy9KILMhNfeUkc+A==
X-Received: by 2002:a17:90a:9a8f:b0:212:9625:c8e9 with SMTP id e15-20020a17090a9a8f00b002129625c8e9mr12089043pjp.128.1668398110344;
        Sun, 13 Nov 2022 19:55:10 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:68f5:86c0:dcaa:df5])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902654400b00188a23098aasm6041093pln.69.2022.11.13.19.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 19:55:09 -0800 (PST)
Date:   Mon, 14 Nov 2022 12:55:05 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zsmalloc: turn zspage order into runtime variable
Message-ID: <Y3G8GehTg9ucl7Xs@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <20221031054108.541190-3-senozhatsky@chromium.org>
 <Y210OrSgrqWPr0DT@google.com>
 <Y24mEiy0pt2qSCqr@google.com>
 <Y26BvxM1CeqnaLI3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y26BvxM1CeqnaLI3@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/11 09:09), Minchan Kim wrote:
> > [..]
> > OK. Any reason why we don't want u32? I thought that
> > s16/u16/s32/u32/etc. is the new normal.
> 
> Oh, I didn't know the new normal.
> 
> # ag u32 mm/ | wc -l 
> 65
> 
> Then, I'd like to use int to be consistent with others.

OK.

> > > Let's just use int instead of u32
> > > 
> > > Why do you need num_pages argument instead of using 1UL << ZS_DEFAULT_PAGE_ORDER?
> > > It looks like static value.
> > 
> > It is static right now, but in the a couple of patches it'll change to
> > dynamic.
> 
> Then, plase have the change in the patch you will use to review easier.

OK.
