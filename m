Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF9A6174B9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiKCDFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiKCDFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:05:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716E613F7F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 20:05:11 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p3so663061pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 20:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvYVAnQWllCErBPy/YhOowEsw7eIAxS1iA2SHHv3UcY=;
        b=KKihXx5Dop1yjXI4bddf4nkEdYbmFkavybw5mE6Tm3VuFTyzVCyP7BcJl8XlK+KNAw
         iHoqRNp4sWj6jbuUKkCosavoZtSzj0mVEQWvNyNV3i8N+eZ7zjWhLyWe6OycGgme1xeW
         30uIAsLapk5fWCSQV4BlaUMmOqH1y4BPuYVbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvYVAnQWllCErBPy/YhOowEsw7eIAxS1iA2SHHv3UcY=;
        b=D0SJ2SKRBwzkl0XK/frXrtDofpnS+EG/C7UFDuC92L9VlGSVr5RhhQbr/i65nVIkgk
         fYll65WeJncmdTF+gIvXJe1zD2qBPUx5+wcL5RmNsI8vT/mvYiBuUCNAvi+KhdG3CKc0
         18Ju24Hlgb85xVft3fKqLLD7ore9ah6P6y4iHHYXnx23IWN1trW16BOH2s31FejtH76j
         gaa0MIrzNlbZTnuNunmMF4OlZI6pkXo5PCJ0ga00hfV8ZCC731M5cfYMTX0AsMpczuOK
         LkJCY3iiKzp2uOU7MpbRSMqPeu2mHfie1YfB2+WoMOBHm6A2MlBfVZNvX4mMD6IP6mkx
         4zFQ==
X-Gm-Message-State: ACrzQf0/XxBy2RzqOdAeJkInl024dsrAujVmBdf0WTu7CXq5QkChx7IH
        FKyUXj0caFdTYcXMV0cKqdxefQ==
X-Google-Smtp-Source: AMsMyM7+4grXkiF+n3bJ92y2tj6d1JBBBPr5kqsT5H0/sXvxRQDnIf1dXzgPeeIA4NkioXM1foqGWA==
X-Received: by 2002:a17:90b:1e4b:b0:213:519a:ffdb with SMTP id pi11-20020a17090b1e4b00b00213519affdbmr45096420pjb.184.1667444710981;
        Wed, 02 Nov 2022 20:05:10 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f22:e30:374d:5a2b])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902db0600b0017c19d7c89bsm9061848plx.269.2022.11.02.20.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 20:05:10 -0700 (PDT)
Date:   Thu, 3 Nov 2022 12:05:06 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2Mv4l+V9iCv9EMg@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2LP0OWF/WTnkSne@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/02 13:15), Minchan Kim wrote:
[..]
> >  /* Module params (documentation at end) */
> >  static unsigned int num_devices = 1;
> > @@ -1000,31 +1005,37 @@ static ssize_t max_comp_streams_store(struct device *dev,
> >  	return len;
> >  }
> >  
> > -static ssize_t comp_algorithm_show(struct device *dev,
> > -		struct device_attribute *attr, char *buf)
> 
> Do you have any reason to change show and set placement? Otherwise,
> please keep the function order to reduce unnecesssary churns.

I don't change their placement. It's just show and store for primary and
secondary algorithms use the same __store and __show functions, which
are static and are placed ahead of store and show.

[..]
> Just open question(I might be too paranoid?)
> 
> I am thinking someone want to add third comp algorithm in future
> to balance decompression and memory efficiency.
> 
> If it's not too crazy idea, let's think about the interface.
> Maybe, could we make the recomp knobs works like list?
> 
> # A primary comp
> echo "A" > /zram/comp_algo
> 
> # Multiple secondary comps
> echo "B threshold" > /zram/add_recomp_algo
> echo "C threshold" > /zram/add_recomp_algo
> echo "D threshold" > /zram/add_recomp_algo

What is the threshold here? My design approach is that ZRAM doesn't do
recompression on its own, so no magic is happening automatically. It's
the user-space that triggers recompression for selected pages when
user-space thinks it's time to. This allows us to have various flexible
policies and consider things that ZRAM is not even aware of: battery level,
free memory, CPU load average, etc. E.g. no recompression when all CPUs
are busy rendering video game, or when we are draining battery too fast,
etc.

> "cat /zram/recomp_algo" shows the list
> 
> echo "C" > /zram/remove_recomp_algo
> will remove the C algorithm in stack.

What is the use case for removal of a secondary algorithm?

> My point is that we don't need to implement it atm but makes the
> interface to open the possibility for future extension.
> 
> What do you think?

So, as far as I understand, we don't have reason to add remove_recomp_algo
right now. And existing recomp_algo does not enforce any particular format,
it can be extended. Right now we accept "$name" but can do something like
"$name:$priority". The only thing that we probably need to do is rename
recomp_algo to either add_recomp_algo or register_recomp_algo?

> > +static ssize_t recomp_algorithm_store(struct device *dev,
> > +				      struct device_attribute *attr,
> > +				      const char *buf,
> > +				      size_t len)
> > +{
> > +	struct zram *zram = dev_to_zram(dev);
> > +	int ret;
> > +
> > +	ret = __comp_algorithm_store(zram, ZRAM_SECONDARY_ZCOMP, buf);
> > +	return ret ? ret : len;
> > +}
> > +#endif
> > +
> >  static ssize_t compact_store(struct device *dev,
> >  		struct device_attribute *attr, const char *buf, size_t len)
> >  {
> > @@ -1762,7 +1817,11 @@ static void zram_reset_device(struct zram *zram)
> >  	memset(&zram->stats, 0, sizeof(zram->stats));
> >  	reset_bdev(zram);
> >  
> > -	comp_algorithm_set(zram, ZRAM_PRIMARY_ZCOMP, default_compressor);
> > +	comp_algorithm_set(zram, ZRAM_PRIMARY_ZCOMP,
> > +			   default_comp_algs[ZRAM_PRIMARY_ZCOMP]);
> > +	if (IS_ENABLED(CONFIG_ZRAM_MULTI_COMP))
> 
> Dumb question:
> 
> Why do you use IS_ENABLED instead of ifdef?

#ifdef-s are banned in the new C-code, as far as I know. IS_ENABLED is
what we should use.
