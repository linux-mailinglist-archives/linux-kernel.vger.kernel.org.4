Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A71B5F116A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiI3SP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiI3SPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:15:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9781B14C6;
        Fri, 30 Sep 2022 11:15:50 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so9841490pjs.1;
        Fri, 30 Sep 2022 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=MZ1QKZutR7qmnF0tSQ5K80ENNLWUnpYLMPuYuggGHcE=;
        b=e6aaG6N3soaXnBwYTrdzTON7U2rYiQbin7cjDdXEEdWFLvk1VtTDumgMwjp4JwhlSy
         Gh5TIMk4leybzzCgEfEkBJESrhzv6lD5BNajq2FnW86JvgMCWoighd8Y/iufUEL6EP4j
         bAZ1mDhpUNw5TqlfMOpmNv9t46BBzq5yeLHbgsOH1fT1D1d78+Im7t9zFgBqmxxtKWqL
         sKtswFkCMsFzFhJb2BXFURTJsqj86heP6P+gcfPlhxsRhksTrbf4KpBNu6RcPVRURg5K
         FbFQy4v/5QuMHaX7Hfow79F47dW2zr9mYJkHi7R4/jVgMHG4EPAmFSx7GdjUp8/6dIcV
         5ZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=MZ1QKZutR7qmnF0tSQ5K80ENNLWUnpYLMPuYuggGHcE=;
        b=mRAr1RVQIW0hOfEOHCHuG9nb1a+FeHY/DDKd0SH76cIz/VizHz6fgiJBPjPWtYNUN6
         gtBUSSVqXtPcxe4Rgi8L1Kukd0jlCQGcj0Ib/I4YdTlULc+f0dQWG2leEzmdEuxML8kV
         FvDALhZ1F0WHotNozR+74O+VSimnCZgTI9ekJr0bqLw4qnQ2vt7l7eJFkkara0s6dnSs
         jMtbYmpDvuN1SUfKDyq1iLQG+mCf7GVYWHcmw4d5xGpJW4UTquRArdchHBuGwquHGOGc
         ifVoTv7wPwycSlX9g910sOGn0ti5S/cWB1biJi5WZNVLpYrjylWX8IYuw+j7WCEp2ha9
         4Tcw==
X-Gm-Message-State: ACrzQf0oyTSmGZEWQWL6/quuhrx8r/oHDLXOzPZEqDtYrKZrOS5h92Qt
        4bS8UsKxzLJ7Q8adSLQil/8=
X-Google-Smtp-Source: AMsMyM5eHHFmQ5TjjKxgOPaPIwz/LbEuSoXpDtbfYbJqWAqSfvF/NEH2MmS5xJm9EVxqvazlcPHsRw==
X-Received: by 2002:a17:90b:33c5:b0:202:fa60:3769 with SMTP id lk5-20020a17090b33c500b00202fa603769mr11001170pjb.60.1664561750075;
        Fri, 30 Sep 2022 11:15:50 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d016:f5be:4ff2:43f])
        by smtp.gmail.com with ESMTPSA id 64-20020a620543000000b0053e6d352ae4sm2106224pff.24.2022.09.30.11.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:15:49 -0700 (PDT)
Date:   Fri, 30 Sep 2022 11:15:46 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: input: Add support for USI style events
Message-ID: <YzcyUgLbZ2pVJSMO@google.com>
References: <20220812103519.2142290-1-tero.kristo@linux.intel.com>
 <nycvar.YFH.7.76.2208251140420.19850@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2209301109030.16823@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2209301109030.16823@cbobk.fhfr.pm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 11:09:12AM +0200, Jiri Kosina wrote:
> On Thu, 25 Aug 2022, Jiri Kosina wrote:
> 
> > > Add support for Universal Stylus Interface (USI) style events to the HID
> > > input layers. The events are mapped as follows:
> > > 
> > > type	id	event
> > > ----	--	-----
> > > MSC(4)	6	Pen ID
> > > MSC(4)	7	Pen Color
> > > MSC(4)	8	Pen Line Style Ink
> > > MSC(4)	9	Pen Line Style Pencil
> > > MSC(4)	0xa	Pen Line Style Highlighter
> > > MSC(4)	0xb	Pen Line Style Chisel Marker
> > > MSC(4)	0xc	Pen Line Style Brush
> > > MSC(4)	0xd	Pen No Preferred Line Style
> > > ABS(3)	0x1c	Pen Line Width
> > > 
> > > All the listed MSC events are new, the ABS one is mapped to an existing
> > > event.
> > 
> > Dmitry, could you please Ack the MSC_PEN_* additions?
> 
> Dmitry, friendly ping on this one.

Very sorry, I meant to answer and forgot...

We need good descriptions of what exactly these events are, and when and
how userspace should expect/use them.

In general, I am wary of MISC_* namespace as it needs to be sent in
every packet as we do not retain state and do not give userspace way of
querying it, unlike ABS_* or KEY_* or number of other events.

Also, what do we do with multiple pens used at once? Maybe we do not
have such devices now, but multitouch devices did not exist in the
beginning either, and now are ubiquitous.

Thanks.

-- 
Dmitry
