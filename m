Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36785FBAA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJKSou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJKSoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:44:44 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26511CE29;
        Tue, 11 Oct 2022 11:44:41 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q9so13534423pgq.8;
        Tue, 11 Oct 2022 11:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=So4abhNWYFcv274xdP8VWRO69sa0lbWIaXDw4c76tcc=;
        b=QwMCFkGmf5as4oMRr2s+37sf65O2IYJ2UP3HAVQXmkkXH4nasGoL7TRCxhS1z7gbl+
         2mu+JxE54CWqTnCGlzT/AvSduYAsygWPUNwQihLuyVA/0hnTQOk1psxC7Jytj+93KYNw
         IacvgWz4SrBwzG2Ty4dSeA2/5eop9yFreMk+0sJviXQriX/9ytGH0QT5QvCO34ADyS4u
         cBqZ2I4KcNKpxPJbHIr4+DCveLOAkbscD5Xn9yLxs+MaeUiudE4pRexfcwYrWA6Ye9Hn
         j+rACATg8O30iyyuK4Pbd7msDZrcEVEiVzy31Datxlc77hyeImOJmay1tCvcKtE50Hg7
         PANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=So4abhNWYFcv274xdP8VWRO69sa0lbWIaXDw4c76tcc=;
        b=cfe78BFPr8sS13dldq/Hb490opaiwOGi+o85eRXUwc1l5tCS+EjvCnHTbzZaVMbL4G
         nmfYdH/J7p7hhywCvxNZZpfQrX2Z3o3rQPKVnHCYY9GPmsCePxhxGr7XiJ0Bpp9QasCY
         Kl3CmI2zENvqKFT+nXtK2vV7gk/sa16dMyPnseFTEsQUuRA45vV7vC7DuPzdMAkCmPpf
         P8ULNyrjRaDFm+Cysw2rTybyru6o9wOY3PusLj0SS1stK19jHhP3SvdjuOslGlLNAdUI
         nBHwIJ92eZy8Syi6Z3XTNvMwjbU3j5f+fVqTqDXVjSJKCI0zYkaCaYazB+7dr42E6PZf
         q97Q==
X-Gm-Message-State: ACrzQf2XjYal7no/Dhwl5smJBGc0OKk2c/3KEtEvHK8GLIlo4n8XXcpc
        NAVhGit4bTd8VkIyTCSq6V4=
X-Google-Smtp-Source: AMsMyM7BJ8CB9EKNxnOSbRKrT7LpY6uE4q/wqvNSLI9/+llW7wxWlnmGpp25dt/3hYuvgPu5aaBIBQ==
X-Received: by 2002:a63:4753:0:b0:462:b3f0:a984 with SMTP id w19-20020a634753000000b00462b3f0a984mr9116030pgk.501.1665513879789;
        Tue, 11 Oct 2022 11:44:39 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id t4-20020a17090abc4400b0020d352dc81fsm4565078pjv.54.2022.10.11.11.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:44:38 -0700 (PDT)
Date:   Wed, 12 Oct 2022 07:44:30 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     David Teigland <teigland@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christine Caulfield <ccaulfie@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] dlm: Replace one-element array with
 flexible-array member
Message-ID: <Y0W5jkiXUkpNl4ap@mail.google.com>
References: <Y0IFEUjwXGZFf7bB@mail.google.com>
 <378C6BDE-0A68-4938-86CD-495BD5F35BE6@chromium.org>
 <Y0IsXXYnS4DnWkMW@mail.google.com>
 <202210082044.51106145BD@keescook>
 <20221010210039.GA30273@redhat.com>
 <202210101534.BA51029@keescook>
 <20221011152031.GA11089@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011152031.GA11089@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 10:20:31AM -0500, David Teigland wrote:
> On Mon, Oct 10, 2022 at 03:35:24PM -0700, Kees Cook wrote:
> > On Mon, Oct 10, 2022 at 04:00:39PM -0500, David Teigland wrote:
> > > On Sat, Oct 08, 2022 at 09:03:28PM -0700, Kees Cook wrote:
> > > > On Sun, Oct 09, 2022 at 03:05:17PM +1300, Paulo Miguel Almeida wrote:
> > > > > On Sat, Oct 08, 2022 at 05:18:35PM -0700, Kees Cook wrote:
> > > > > > This is allocating 1 more byte than before, since the struct size didn't change. But this has always allocated too much space, due to the struct padding. For a "no binary changes" patch, the above "+ 1" needs to be left off.
> > > > > 
> > > > > That's true. I agree that leaving "+ 1" would work and produce a
> > > > > no-binary-changes patch due to the existing padding that the structure
> > > > > has. OTOH, I thought that relying on that space could bite us in the
> > > > > future if anyone tweaks the struct again...so my reaction was to ensure 
> > > > > that the NUL-terminator space was always guaranteed to be there.
> > > > > Hence, the change on c693 (objdump above).
> > > > > 
> > > > > What do you think? Should we keep or leave the above
> > > > > "+ 1" after the rationale above?
> > > > 
> > > > I think it depends on what's expected from this allocation. Christine or
> > > > David, can you speak to this?
> > > 
> > > Hi, thanks for picking through that.  Most likely the intention was to
> > > allow up to 64 (DLM_LOCKSPACE_LEN) character names, and then use the
> > > ls_name[1] for the terminating byte.  I'd be happy to take the patch
> > 
> > Should this just use:
> > 
> > 	char			ls_name[DLM_LOCKSPACE_LEN + 1];
> > 
> > instead, or is the byte savings worth keeping it dynamically sized?
> 
> Yes, I think that's the best option.
> Dave
> 

Thanks for the reply Dave; Thanks for the suggestion Kees;
I'll send a new patch for it :)

Paulo A.
