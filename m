Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3198A735C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjFSQko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFSQkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:40:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81E08E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:40:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-543ae674f37so1892292a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687192840; x=1689784840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=chD1v7hFslt/id3ngHvaiW89I/a0twqHaudkcV+NNl0=;
        b=DDMC6mwfK+wLLbzDINuw3Qm8uRFn1bXYbhxD1tEo7YEuRpzE/LrP8G2djpsmwfBtjr
         Hb+13bWZOVR3JNbJD41xN02pdHcroY19ZukwcRdOv82GmRXUipwcsWtdOqkorS2KRrwC
         u3ZvZcIk1gmEc0vD4fY8rRkzBaOVUPY/B4KAVs6i3p0dNbfJ3TOhQPBE5bcsikT5niqI
         NfjBgJZ3q7g3l77Xpe5qd5iNgH1mvrz3pij3sd0qDDDNvZH+UlMrlIfoRso7VuuovTRs
         rbO11QOyuMy8mIHd66Ncj2ZWdFVS+lRjI/Hf2aRRs+Dwt9rqK1irD433101XQj9Q3BjQ
         w+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687192840; x=1689784840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chD1v7hFslt/id3ngHvaiW89I/a0twqHaudkcV+NNl0=;
        b=ZH71Ijhq+7y+TYQk90YsAG7T0eRKkxO4EbBR0eAu3/WFOI3tf81SxSW7G5i7u+itZ7
         zapKiQMcIQWA/2y08wC+6ZLOwbwZQveShAxWlbGNL+bIGE5myvp4ENlSdSZpR0LxXaQo
         b5BqpsaGE4TK9xfZ45Zo4AVpWepv+C8rjhOf0E/ok0k1flLg5h17j3kWFt/+7zPhn4Pg
         KHGBfexrGn0mtoMB74CIDTxAATauVm9p70Z7/fMM7nVlu8COxCbct43Sjzm9vAn2esrT
         EQNJbGEGNKKYAP1kI8vtayxtDYU/ePvbKPiDh2gOQC0j0Bt28O5fRx7V8WJmL1E4vcZ5
         tr1w==
X-Gm-Message-State: AC+VfDxy/6OLf32epT8dWpa41lxyqWL4WVtwEgqlRmQtNZr4A0QARua5
        fbDPep5ob0PyrFRvJ6V/LIU=
X-Google-Smtp-Source: ACHHUZ6hU84TO6j4I3f1kv8nkLZCBWPfnIc6bo7wEYsl0blvq6R/+XTXrOKB7tbVh+NDhHGokWI9jA==
X-Received: by 2002:a17:902:c403:b0:1b3:fafd:11c5 with SMTP id k3-20020a170902c40300b001b3fafd11c5mr10027947plk.44.1687192840151;
        Mon, 19 Jun 2023 09:40:40 -0700 (PDT)
Received: from sumitra.com ([59.95.144.189])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902f68c00b001ab061e352bsm65896plg.195.2023.06.19.09.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:40:39 -0700 (PDT)
Date:   Mon, 19 Jun 2023 09:40:35 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Deepak R Varma <drv@mailo.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: Re: [PATCH v2] lib: Replace kmap() with kmap_local_page()
Message-ID: <20230619164035.GC412243@sumitra.com>
References: <20230610175712.GA348514@sumitra.com>
 <8275009.NyiUUSuA9g@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8275009.NyiUUSuA9g@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2023 at 06:50:04AM +0200, Fabio M. De Francesco wrote:
> On sabato 10 giugno 2023 19:57:12 CEST Sumitra Sharma wrote:
> > kmap() has been deprecated in favor of the kmap_local_page()
> > due to high cost, restricted mapping space, the overhead of
> > a global lock for synchronization, and making the process
> > sleep in the absence of free slots.
> > 
> > kmap_local_page() is faster than kmap() and offers thread-local
> > and CPU-local mappings, take pagefaults in a local kmap region
> > and preserves preemption by saving the mappings of outgoing
> > tasks and restoring those of the incoming one during a context
> > switch.
> > 
> > The mappings are kept thread local in the functions
> > “dmirror_do_read” and “dmirror_do_write” in test_hmm.c
> > 
> > Therefore, replace kmap() with kmap_local_page() and use
> > mempcy_from/to_page() to avoid open coding kmap_local_page()
> > + memcpy() + kunmap_local().
> > 
> > Remove the unused variable “tmp”.
> > 
> > 
> > Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> LGTM, so...
> 
> Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> Thanks,
> 
> Fabio
> 
> P.S.: The answer to an old question from you is that "LGTM" stands for "[It] 
> Looks Good To Me". 
> 
> It's just a way to introduce the "Reviewed-by" tag itself. However, "LGTM" is 
> not required, whereas the tag is required for a valid review and only the tag 
> line will be added by maintainers in the log when your patch gets applied.  
> 
> While here... Please don't put unnecessary blank lines between the tags.They 
> are not required and instead may worsen readability (obviously, I'm not 
> requiring a new version for this).  
> 

Hi Fabio,

Thank you for your explanation and clarification regarding the meaning of "LGTM." 
I will take care of the blank lines.


Thanks & regards
Sumitra

> > 
> > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > ---
> > 
> > Changes in v2:
> > 	- Change commit subject and description.
> > 	- Remove unnecessary type casting (char *).
> > 
> > 
> >  lib/test_hmm.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> > index 67e6f83fe0f8..717dcb830127 100644
> > --- a/lib/test_hmm.c
> > +++ b/lib/test_hmm.c
> > @@ -368,16 +368,13 @@ static int dmirror_do_read(struct dmirror *dmirror,
> > unsigned long start, for (pfn = start >> PAGE_SHIFT; pfn < (end >>
> > PAGE_SHIFT); pfn++) { void *entry;
> >  		struct page *page;
> > -		void *tmp;
> > 
> >  		entry = xa_load(&dmirror->pt, pfn);
> >  		page = xa_untag_pointer(entry);
> >  		if (!page)
> >  			return -ENOENT;
> > 
> > -		tmp = kmap(page);
> > -		memcpy(ptr, tmp, PAGE_SIZE);
> > -		kunmap(page);
> > +		memcpy_from_page(ptr, page, 0, PAGE_SIZE);
> > 
> >  		ptr += PAGE_SIZE;
> >  		bounce->cpages++;
> > @@ -437,16 +434,13 @@ static int dmirror_do_write(struct dmirror *dmirror,
> > unsigned long start, for (pfn = start >> PAGE_SHIFT; pfn < (end >>
> > PAGE_SHIFT); pfn++) { void *entry;
> >  		struct page *page;
> > -		void *tmp;
> > 
> >  		entry = xa_load(&dmirror->pt, pfn);
> >  		page = xa_untag_pointer(entry);
> >  		if (!page || xa_pointer_tag(entry) != DPT_XA_TAG_WRITE)
> >  			return -ENOENT;
> > 
> > -		tmp = kmap(page);
> > -		memcpy(tmp, ptr, PAGE_SIZE);
> > -		kunmap(page);
> > +		memcpy_to_page(page, 0, ptr, PAGE_SIZE);
> > 
> >  		ptr += PAGE_SIZE;
> >  		bounce->cpages++;
> > --
> > 2.25.1
> 
> 
> 
> 
