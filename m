Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235846CD9D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjC2NBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjC2NBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:01:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51312125
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:01:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so9542392wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680094867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eHIX+oX28bRJE9ca9iSmVcNzrf+BD9Qvi2Tv3q5YQS4=;
        b=cfVeTpBbdILQGnGWXC5gxT9QrDTAEvD4WY+D0oHPO+q7WsB08RaWWmz3/aTUUTduGc
         9GrUyAuqCzcvhN8DEgLq265VMdSFEDf/1eqb5ok50pAegyA/8DzX/aI/qTZqbB4h+1Oe
         U4PNWF2I2gSQtSMIsc5at+Ik7tbd+um0D/FnKGCZgAM+LXUDGPDa1CdqhPo7aFGPIROs
         ZE0kpIyRtbKwm4nFpoKOAnnCd6xsGsDcJUB5KHOTHBgen5O4PoM7J2BkkiLEQFLKsFNm
         6Xoz+3i00l55AfkRQvlzvRE2aoZ/jdqRDbP4RNiTkNbhYyCuON561qrojuRPaT5i1pdf
         yQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680094867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHIX+oX28bRJE9ca9iSmVcNzrf+BD9Qvi2Tv3q5YQS4=;
        b=Ba+e40qu7A84n3VkYfZ3GeFvp8aqZX7oKonqCOoCxYOOc5wT3yN+uAEz1L4M7uxLJq
         ld3eia50Fo+ermTPFOCPoeCs0DSeSZJ0BuMuuvVkHgBiJEeoLP+leIxJ4w5safHTI6YK
         4ezLOKTu+S1a9AT+i9OXMo2Gtu5fSieiMhcHu2Hx60e6ctYyhnppS4V3QY+Q/r6DprM4
         pCT5zro4GqTvKU75jGKf27/QTdgU/eGnxQ0x/IgUS2XyXfRK2NEsMAck9XOsHZ1Nbvnb
         aKiJufoV4Xp7FGz2q+QgDcdtGyKKEBDKBQErvN4rkK8wq2iqtPJD7rf/il3Bekpb7Xa1
         bolw==
X-Gm-Message-State: AAQBX9e6rMaHvfZtdYeb6nn50AVQQYgOsd59betit2LQCM1T1FRvFs/e
        kr/Is3mrxqzJIHe6RxNKx98xE0vo1vV6IjHpCzutJQ==
X-Google-Smtp-Source: AKy350bIIh8kSmRtmTKSzbEr4g49LTEFdztgG+2MEt7EAooUoCmQRIgKAu547h+r6hm00WMchInncw==
X-Received: by 2002:a05:600c:3789:b0:3ef:62cd:1ee with SMTP id o9-20020a05600c378900b003ef62cd01eemr12525833wmr.16.1680094866613;
        Wed, 29 Mar 2023 06:01:06 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b003ef6f87118dsm2409489wmq.42.2023.03.29.06.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 06:01:06 -0700 (PDT)
Date:   Wed, 29 Mar 2023 14:01:01 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZCQ2jW5Jl/cWCG7s@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
 <20230322102244.3239740-2-vdonnefort@google.com>
 <20230328224411.0d69e272@gandalf.local.home>
 <ZCQCsD9+nNwBYIyH@google.com>
 <20230329070353.1e1b443b@gandalf.local.home>
 <20230329085106.046a8991@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329085106.046a8991@rorschach.local.home>
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 08:51:06AM -0400, Steven Rostedt wrote:
> On Wed, 29 Mar 2023 07:03:53 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > struct ring_buffer_meta_page_header {
> > #if __BITS_PER_LONG == 64
> > 	__u64	entries;
> > 	__u64	overrun;
> > #else
> > 	__u32	entries;
> > 	__u32	overrun;
> > #endif
> > 	__u32	pages_touched;
> > 	__u32	meta_page_size;
> > 	__u32	reader_page;	/* page ID for the reader page */
> > 	__u32	nr_data_pages;	/* doesn't take into account the reader_page */
> > };
> 
> Oh, I guess we should also expose the amount read on the reader page,
> that gets updated on the ioctl. That is, if the first time we read the
> reader page and the page is not full and unmap the pages, and then new
> events were added to the reader page, we should not re-read the events
> that were read previously.
> 
> That is, expose cpu_buffer->reader_page->read

Couldn't it be an issue of updating cpu_buffer->reader_page->read during the
ioctl? I guess we would write the value of the current written events on that
page, hopping for the userspace reader to read it all.

But then if new events are written, the reader doesn't need the ioctl to read
them, it can just check the meta->entries field or the commit field in the
reader_page header?

So it's much likely cpu_buffer->reader_page->read will go out of sync?

> 
> -- Steve
