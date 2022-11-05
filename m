Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A87261A699
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 02:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKEBaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 21:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKEBao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 21:30:44 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5528117F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 18:30:40 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e129so5782317pgc.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 18:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vM2nfNNh1xjXMSY6VcmCg8+PkxfmboalhkRzZP/gAMw=;
        b=HOIcRdEp87iUaKFHK6AdakNNkbdYi10THlenTzCsrb2ZeZ/JpmN+5JujSX9R5COYSN
         lARB6CAVAXsjZetcYFRJtaPwUP8Y2k4RzrRcq0jIHuIvhyTIn1KOkv0x7i4AKp43Y2Y+
         h3c8FUPAZUtFY/9SFM+xdoZn1HI39lFqAK35s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM2nfNNh1xjXMSY6VcmCg8+PkxfmboalhkRzZP/gAMw=;
        b=2jRQjnN7BsXmrooy7YlVq+38ID4SE1WZ4rqkVGZ/yXq4FsPiECA7a7LF+Rwo6eq/68
         InUGWqaa5IPeW77kEKcpg2Vjek9FLHoXAqbOlqDPedSROzbFwPre+q4aBvR4CWvUdoCY
         B8Aq7k7jrzev2oUotkirdynpznYGKhB8neBk6FgL+KB6HQRAMiWwgoeoqXXbjJljM6uG
         2+RTvQ7wJd45tzSO6JaFthnMEm8G9gBqJg81gCiF/tybqHLy0CRzS+gSAalkB1l6v2iG
         wWY5CFEH8+F0bkdpzHksYrEP1god5/QqFUXcL1NrFXsrU5lnJixZbnUl+YUoHpp1RHpj
         i6kQ==
X-Gm-Message-State: ACrzQf0iQOLAM85M+8HjBZm51/5kdX4VIkvQgYvatb4jO66H2GbqLTu1
        E7vYV6j882OQLaIG5kMYSaexdU/LaQl76w==
X-Google-Smtp-Source: AMsMyM4EGGoAXgRDCR65iommYmSot0sSq1xmi8vUiKeXLKdvcKm7O8IoQZeYe+gZYKhNZFqW0LSEZQ==
X-Received: by 2002:a63:8bc3:0:b0:46f:fa99:7d76 with SMTP id j186-20020a638bc3000000b0046ffa997d76mr17284463pge.134.1667611840181;
        Fri, 04 Nov 2022 18:30:40 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:cce:9a1e:69f0:8d2])
        by smtp.gmail.com with ESMTPSA id c27-20020aa7953b000000b0053e38ac0ff4sm234641pfp.115.2022.11.04.18.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 18:30:39 -0700 (PDT)
Date:   Sat, 5 Nov 2022 10:30:35 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2W8uwlg/rr2LR6M@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2Ptq1GZISCD7Mor@google.com>
 <Y2SEkzKSWx2iQzLl@google.com>
 <Y2Sat1/FCCT0Lia/@google.com>
 <Y2VPQlnEiP75mY5O@google.com>
 <Y2WjMQeS2DihvPQF@google.com>
 <Y2Wny/cKaLuFbm8E@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Wny/cKaLuFbm8E@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/04 17:01), Minchan Kim wrote:
> > One can be SW one can be HW. So I thought about having flexibility here.
> > Instead of doing
> > 
> > 	for (idx = 1; idx < MAX_IDX; idx++) {
> > 		len = zcomp_compress(zram->comps[idx]);
> > 		if (len <= threshold)
> > 			break;
> > 	}
> > 
> > We would just directly use the suggested algo.
> > 
> > But we probably don't need that param at all and can use
> > the loop instead?
> 
> I don't understand what param you are saying. I expected
> the zram->comps array already has sorted algoritm based on the
> priority so the loop will try compression as expected so loop is fine.
> Are we on same page?

I'll try to implement both loop and a specific algorithm selection.
