Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E53704DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjEPM3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjEPM3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:29:46 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D57D5259
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:29:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64384274895so9992231b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684240184; x=1686832184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5oHxYRsTEmVik20ogmOFpOFFX6Yhrdsk15XGgVQoDA=;
        b=oCuLtW6rxIJaWwNGL8Gi9wTXXIW2qzacrl3o+LtG6Rti2vdxMR40bwyRfxhDbipOSG
         MsewJKDE9Rii64HvSCHJJtIA3LXz8siJy94A+QqOQkhxnT8MpFfPLGT6IEFWywCyeCD/
         YvL0tR68cppBDCKv7yweg3Y4r6iU0l/MA++oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684240184; x=1686832184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5oHxYRsTEmVik20ogmOFpOFFX6Yhrdsk15XGgVQoDA=;
        b=aTh7R7QP1Be3feRA4V7LLxZC5GALbwoqhK3vRIGw2oRZMVB+8IvJKkABUG80dCjyo8
         88hPw0p18L/da/Ii4Kal+U+ejeUrR3b0/p3wxE2i3/muYPnaNKzFBP4rJyY76IdM1sN+
         RtZRdX34Xv6e8Yz6OcCDatFShOUQ2zWNiSUGv58Tzp62FvviVOWONaBCg9IgCFRs2Ovm
         lkF3dvu7V2KttvBMLjpm1ecKeioOoVUa6ahGmGAL3STI5mbULEHlhLcOJxRYKtVZnvTh
         fNmzBh93V+EgX2E0F5RmQJvYujOuKGNL7ajozMceoOJE+6qGD4TWdUjVZMqYSqxhcKNu
         vqRg==
X-Gm-Message-State: AC+VfDx+TGewocH9xjj7Nzy6pD6nXIuMooNgB2B3jJuQvgs2ozGbYrF3
        9e9F3pLsWOBIBq5Q6ncGk2V2Ww==
X-Google-Smtp-Source: ACHHUZ6hpW1u699BdtJ7qhDcE6n6rqI46EVNi3KymLGq37oJvvtnTkFtXmot0FaVNcU0paAZLLQwaw==
X-Received: by 2002:a05:6a20:431b:b0:101:4c8c:d1ee with SMTP id h27-20020a056a20431b00b001014c8cd1eemr30159998pzk.50.1684240184516;
        Tue, 16 May 2023 05:29:44 -0700 (PDT)
Received: from google.com ([110.11.159.72])
        by smtp.gmail.com with ESMTPSA id 3-20020a630a03000000b0051b930b2b49sm13498650pgk.72.2023.05.16.05.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:29:44 -0700 (PDT)
Date:   Tue, 16 May 2023 21:29:39 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Alexey Romanov <AVRomanov@sberdevices.ru>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] mm/zsmalloc: use ARRAY_SIZE in isolate_zspage()
Message-ID: <20230516122939.GC15689@google.com>
References: <20230516095029.49036-1-avromanov@sberdevices.ru>
 <20230516095327.GA15689@google.com>
 <20230516101137.gqu5746k6qzigsw4@cab-wsm-0029881>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516101137.gqu5746k6qzigsw4@cab-wsm-0029881>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/05/16 10:11), Alexey Romanov wrote:
> > > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > > index 702bc3fd687a..f23c2da55368 100644
> > > --- a/mm/zsmalloc.c
> > > +++ b/mm/zsmalloc.c
> > > @@ -1888,7 +1888,7 @@ static struct zspage *isolate_zspage(struct size_class *class, bool source)
> > >  		fg[1] = ZS_ALMOST_EMPTY;
> > >  	}
> > >  
> > > -	for (i = 0; i < 2; i++) {
> > > +	for (i = 0; i < ARRAY_SIZE(fg); i++) {
> > >  		zspage = list_first_entry_or_null(&class->fullness_list[fg[i]],
> > >  							struct zspage, list);
> > >  		if (zspage) {
> > 
> > This patch needs to be dropped. We don't have that function anymore.
> 
> Do I need to sumbit v2 without this patch, or will Andrew just take
> only the 2/2 patch into the branch?

Let's hear from Andrew, but I think v2 won't be necessary.
