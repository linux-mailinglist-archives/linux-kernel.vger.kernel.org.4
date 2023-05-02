Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766806F3C56
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 05:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjEBDVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 23:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjEBDVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 23:21:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887D72D63;
        Mon,  1 May 2023 20:21:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aae46e62e9so17633675ad.2;
        Mon, 01 May 2023 20:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682997697; x=1685589697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kPhkxKtMNwHtdjZlJYGj6frJ2aQ8baVgc0KOSLV7pNU=;
        b=Io5d/8LiYrjrFMutvXlZaPHMhpAfTqeVehDJveJNmuVB4l69aI+EXjVFv7eSCuVqea
         k+gPceeXz96PLXVY9LsgCumZRETnpDZvUFOSoQihzU73O1pDSP1Vb0FkPuH8rciYp7LV
         E+uP5G6pKwYXUg1yMO3aO3vNuAW5nXmTkP6W5sWrIXrb87fPzz/xYChuQtVzfItqFRnk
         uxLBEaMKmZ5sGxJi4KH5DgWd7dhZ8ogh5N6ByRJDVWtC/P18mrF1q/CjhJZSePOYM47K
         rzZhCg77YEciJ3sziK9+ORzTQzjpoox9IUgOpCOkUqGDFKftGZMdgef3OXSARhgsAhJM
         9Llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682997697; x=1685589697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPhkxKtMNwHtdjZlJYGj6frJ2aQ8baVgc0KOSLV7pNU=;
        b=SyYRKwFrbFrc2jFS+FTArr1zeK9ZyjS9mizarFojHY5sDi+tsTckLsDyCDvdDSEzGw
         fQmeJJuAeELdlhyfZtV352NEvD0QJ89Pp9JdjCeP/QoCzvGI8f8FTgZOM+4GCFBnVM92
         LGBhdxi4xsITLFteTy/vBtBH1t7Jl+hzB1p7Z8/u/6tEXYcevG0ZbQcGKyRMM8daXOZg
         inIuaXteVq2cUSKAxMrpKAUtGYgaVo9QAoD3Vpsn6ClEuWJkrLOKULlXfspyoGj3MC7k
         Qs9iNJGw2pOwcP8FOgek6sZxR8dDXB6MdLv7FnVUg9FJa9a8Xr8FP/6VpmRJjyEjznlz
         thLw==
X-Gm-Message-State: AC+VfDwYzH+OyJqCraAN+4aUwTsyruD//Y8Lr0FCjD1th9+D5s9340Zy
        ze5UUiB7unhLmdEyPshLQSc=
X-Google-Smtp-Source: ACHHUZ6WFkvLqJkiVfA1Gaz5wpT4JUungsiWdhLKt0UMTrma8LPWHem3M7LCkCpLVxOkfOgVcjih9Q==
X-Received: by 2002:a17:902:e74c:b0:1aa:db0f:1aba with SMTP id p12-20020a170902e74c00b001aadb0f1abamr11439347plf.47.1682997696812;
        Mon, 01 May 2023 20:21:36 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b001aad2910194sm4894229plx.14.2023.05.01.20.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 20:21:36 -0700 (PDT)
Date:   Mon, 1 May 2023 20:21:33 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Biswarup Pal <biswarupp@google.com>, kernel-team@android.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Call input_set_timestamp for events injected using uinput
Message-ID: <ZFCBve1Sa32C6psb@google.com>
References: <20230427000152.1407471-1-biswarupp@google.com>
 <ZFBh948No3IAV2hf@google.com>
 <20230502021305.GA798180@quokka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502021305.GA798180@quokka>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 12:13:05PM +1000, Peter Hutterer wrote:
> Thanks for the CC, I would've missed that.
> 
> On Mon, May 01, 2023 at 06:05:59PM -0700, Dmitry Torokhov wrote:
> > On Thu, Apr 27, 2023 at 12:01:51AM +0000, Biswarup Pal wrote:
> > > Currently, uinput doesn't use the input_set_timestamp API, so any
> > > event injected using uinput is not accurately timestamped in terms of
> > > measuring when the actual event happened. Hence, call the
> > > input_set_timestamp API from uinput in order to provide a more
> > > accurate sense of time for the event. Propagate only the timestamps
> > > which are a) positive, b) within a pre-defined offset (10 secs) from
> > > the current time, and c) not in the future.
> > 
> > This makes sense to me. Peter, do you see any issues?
> 
> nope, this looks good and has my 
> Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net> 

Great, applied.

> 
> afaict any code that has compiler warnings enabled should have this on
> zero anyway. It'd be really nice to pass a timestamp down to uinput but
> that's obviously a lot more involved.
> 
> Cheers,
>   Peter
> 
> > 
> > Thanks!
> > 
> > > 
> > > Signed-off-by: Biswarup Pal <biswarupp@google.com>
> > > ---
> > >  drivers/input/misc/uinput.c | 34 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > > 
> > > diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> > > index f2593133e524..d98212d55108 100644
> > > --- a/drivers/input/misc/uinput.c
> > > +++ b/drivers/input/misc/uinput.c
> > > @@ -33,6 +33,7 @@
> > >  #define UINPUT_NAME		"uinput"
> > >  #define UINPUT_BUFFER_SIZE	16
> > >  #define UINPUT_NUM_REQUESTS	16
> > > +#define UINPUT_TIMESTAMP_ALLOWED_OFFSET_SECS 10
> > >  
> > >  enum uinput_state { UIST_NEW_DEVICE, UIST_SETUP_COMPLETE, UIST_CREATED };
> > >  
> > > @@ -569,11 +570,40 @@ static int uinput_setup_device_legacy(struct uinput_device *udev,
> > >  	return retval;
> > >  }
> > >  
> > > +/*
> > > + * Returns true if the given timestamp is valid (i.e., if all the following
> > > + * conditions are satisfied), false otherwise.
> > > + * 1) given timestamp is positive
> > > + * 2) it's within the allowed offset before the current time
> > > + * 3) it's not in the future
> > > + */
> > > +static bool is_valid_timestamp(const ktime_t timestamp)
> > > +{
> > > +	ktime_t zero_time;
> > > +	ktime_t current_time;
> > > +	ktime_t min_time;
> > > +	ktime_t offset;
> > > +
> > > +	zero_time = ktime_set(0, 0);
> > > +	if (ktime_compare(zero_time, timestamp) >= 0)
> > > +		return false;
> > > +
> > > +	current_time = ktime_get();
> > > +	offset = ktime_set(UINPUT_TIMESTAMP_ALLOWED_OFFSET_SECS, 0);
> > > +	min_time = ktime_sub(current_time, offset);
> > > +
> > > +	if (ktime_after(min_time, timestamp) || ktime_after(timestamp, current_time))
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> > > +
> > >  static ssize_t uinput_inject_events(struct uinput_device *udev,
> > >  				    const char __user *buffer, size_t count)
> > >  {
> > >  	struct input_event ev;
> > >  	size_t bytes = 0;
> > > +	ktime_t timestamp;
> > >  
> > >  	if (count != 0 && count < input_event_size())
> > >  		return -EINVAL;
> > > @@ -588,6 +618,10 @@ static ssize_t uinput_inject_events(struct uinput_device *udev,
> > >  		if (input_event_from_user(buffer + bytes, &ev))
> > >  			return -EFAULT;
> > >  
> > > +		timestamp = ktime_set(ev.input_event_sec, ev.input_event_usec * NSEC_PER_USEC);
> > > +		if (is_valid_timestamp(timestamp))
> > > +			input_set_timestamp(udev->dev, timestamp);
> > > +
> > >  		input_event(udev->dev, ev.type, ev.code, ev.value);
> > >  		bytes += input_event_size();
> > >  		cond_resched();
> > > -- 
> > > 2.40.1.495.gc816e09b53d-goog
> > > 
> > 
> > -- 
> > Dmitry

-- 
Dmitry
