Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ED15FA7B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 00:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJJWfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 18:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJJWf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 18:35:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5BA61D93
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:35:26 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 78so11302925pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCUzlbX4lI+qBxINl7LzHl5RgJSkmrssEexCv70Q4K4=;
        b=HM2tl0TU+MT7+bFfNZ9o/foworkGDJQP+Nm06zNe83ukdGK6tywrs+HFpdwv11aRFO
         Izx9WfvTjPJ97W1SVuhaB/4HEPQancj6vN2alxJAt77JtV5TWmyZzwE+Vq2rITO05azr
         OVkgb6aYOkyB9kuGPVPNLzJydIFeLHO99sxwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCUzlbX4lI+qBxINl7LzHl5RgJSkmrssEexCv70Q4K4=;
        b=X3cR1VjVWStfq/4gzZ32pQ5VDlBjK4APAJFqBc9Lz7TVUaDrVdgbXFvIKT0vMVRrlI
         FNRIu8fvNRaNZDGOUEt+mu+jUZvXgvfQlxjlgEG47CiFXGErsrBqCL5zph7r2lzEiS7s
         3t+NrFlDzMHXFv0/X/+Eognf+gAeKEn7sB4wHHo7GOznQUAsowZaiBgyNmpuGuYuni0V
         2iMIPd41OSbC9+G/bN1XVFt94upENLiLuDDFcoI0BL8oQN7mygGBtSZMXmxMT6JfCL00
         EorEk4EeXAhu3wWWrm4jKdUEGN7TiVi9v6/vO7jWQTohVja//NQefZc6cKAHf1NaQVuE
         0MbA==
X-Gm-Message-State: ACrzQf0ck7UDMU0n0eCKP1a6D3PoVuxtI4aGpwkhdObc0myA9MP2QfQq
        0NdlF21bAfFJn2bj0cLXehDMvKD+5+hH6w==
X-Google-Smtp-Source: AMsMyM60Ou9Efab64ujpBY0XfNTnxeOS7Gm7nER2LiLQbw09k18Z7G7kUFmUOCkRUr6Sh+imlj6BhQ==
X-Received: by 2002:a63:1d1:0:b0:43a:348b:63fd with SMTP id 200-20020a6301d1000000b0043a348b63fdmr19192959pgb.52.1665441325926;
        Mon, 10 Oct 2022 15:35:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 65-20020a630244000000b0045913a96837sm6707422pgc.24.2022.10.10.15.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 15:35:24 -0700 (PDT)
Date:   Mon, 10 Oct 2022 15:35:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Teigland <teigland@redhat.com>
Cc:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Christine Caulfield <ccaulfie@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] dlm: Replace one-element array with
 flexible-array member
Message-ID: <202210101534.BA51029@keescook>
References: <Y0IFEUjwXGZFf7bB@mail.google.com>
 <378C6BDE-0A68-4938-86CD-495BD5F35BE6@chromium.org>
 <Y0IsXXYnS4DnWkMW@mail.google.com>
 <202210082044.51106145BD@keescook>
 <20221010210039.GA30273@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010210039.GA30273@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 04:00:39PM -0500, David Teigland wrote:
> On Sat, Oct 08, 2022 at 09:03:28PM -0700, Kees Cook wrote:
> > On Sun, Oct 09, 2022 at 03:05:17PM +1300, Paulo Miguel Almeida wrote:
> > > On Sat, Oct 08, 2022 at 05:18:35PM -0700, Kees Cook wrote:
> > > > This is allocating 1 more byte than before, since the struct size didn't change. But this has always allocated too much space, due to the struct padding. For a "no binary changes" patch, the above "+ 1" needs to be left off.
> > > 
> > > That's true. I agree that leaving "+ 1" would work and produce a
> > > no-binary-changes patch due to the existing padding that the structure
> > > has. OTOH, I thought that relying on that space could bite us in the
> > > future if anyone tweaks the struct again...so my reaction was to ensure 
> > > that the NUL-terminator space was always guaranteed to be there.
> > > Hence, the change on c693 (objdump above).
> > > 
> > > What do you think? Should we keep or leave the above
> > > "+ 1" after the rationale above?
> > 
> > I think it depends on what's expected from this allocation. Christine or
> > David, can you speak to this?
> 
> Hi, thanks for picking through that.  Most likely the intention was to
> allow up to 64 (DLM_LOCKSPACE_LEN) character names, and then use the
> ls_name[1] for the terminating byte.  I'd be happy to take the patch

Should this just use:

	char			ls_name[DLM_LOCKSPACE_LEN + 1];

instead, or is the byte savings worth keeping it dynamically sized?

-- 
Kees Cook
