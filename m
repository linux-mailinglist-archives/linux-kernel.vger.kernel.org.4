Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3726C5772
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjCVUY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjCVUYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:24:44 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129CDA4037
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:14:33 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id u8so3832528ilb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679515989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSVpoYaq65+xbA9FzmSJjInslmYXWqbzAWERClhv01I=;
        b=Nx3qTbZ20GsX7TOXQaiYemwOz4I72BqU0yeZUan+IOoQxcUzCYXiR6m9hNuyet44c0
         69W3Pn+weLlnax/iMnT9t2K2zy3cNaQd2bK7297jNu6VjCS4Gwdm834G9FfkjusFTz3L
         Og+U6A5VPgvSDLdANAEIH6eXjuS6yPaTvRyv3McBLC5tqM6md1lygdDv5Maj6imD49aR
         8ST6dw7ZGzUWgIMPaN/9tUqhoBcmlNbfrD3Pufkz+f8pB8WaiKZVakO/3pcJS7xmQISF
         2XdBlHmqesWw7t6HIZWxzw3yYbq6HtPIKgryuazt2g88qsmQrv60OUebkiStUz2VrU+f
         129A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSVpoYaq65+xbA9FzmSJjInslmYXWqbzAWERClhv01I=;
        b=rRtLrYtEriq1dNfZUFEEDAFaUx/bSem3MPO+S8c38+Pb8nk2A2NDUpZQ0ZHMDkXvTD
         xwfltz0zFBTVOdyGsgcASxYehGgoOBsKsVPEZvVGWXqESMJLwi1NRb8YBxeYfq8TlSXM
         Kh7g4B8UIKpyjATqRGHMBy/EgS1whv+XbSWWnpPwcfnnnbmmelEHevMb9paytORKcZOy
         qhY1OSAteh36ACl0Yki2oq6NTco9kjMi637PclTwzyDrByKtXS1/WRwXWOuPtcrwv94m
         Uc14lbLHNThMI+pHPgkBs/QXGCcvJnjAAvc4xPAQnxp8nDwUV9JI30wN8Wqqe5IKV+qP
         DeLw==
X-Gm-Message-State: AO0yUKXSOfEyW8kgDxlpWzeSsySAIXltwCvHcmrnHLyUUk+L5Elh9mkn
        BnEvx9cAniPlfe/j7jyiQEfhuQ==
X-Google-Smtp-Source: AK7set+6/bABqcZ7Ui8WBR/o5uSEMuupYads18CiEFawlKIO6/axtKxX5dOWAApzt981uGzOj3EbFg==
X-Received: by 2002:a92:d0c5:0:b0:325:a6cd:4730 with SMTP id y5-20020a92d0c5000000b00325a6cd4730mr5350858ila.29.1679515988574;
        Wed, 22 Mar 2023 13:13:08 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7419:4945:3325:dd1e])
        by smtp.gmail.com with ESMTPSA id v9-20020a056638250900b0040584b8a32fsm996985jat.126.2023.03.22.13.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 13:13:08 -0700 (PDT)
Date:   Wed, 22 Mar 2023 14:13:03 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] kexec: Support purgatories with .text.hot sections
Message-ID: <20230322201303.GA2979303@google.com>
References: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org>
 <ZBsSBr87al9ccG96@home.goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBsSBr87al9ccG96@home.goodmis.org>
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

On Wed, Mar 22, 2023 at 10:34:46AM -0400, Steven Rostedt wrote:
> On Tue, Mar 21, 2023 at 12:49:08PM +0100, Ricardo Ribalda wrote:
> > Clang16 links the purgatory text in two sections:
> > 
> >   [ 1] .text             PROGBITS         0000000000000000  00000040
> >        00000000000011a1  0000000000000000  AX       0     0     16
> >   [ 2] .rela.text        RELA             0000000000000000  00003498
> >        0000000000000648  0000000000000018   I      24     1     8
> >   ...
> >   [17] .text.hot.        PROGBITS         0000000000000000  00003220
> >        000000000000020b  0000000000000000  AX       0     0     1
> >   [18] .rela.text.hot.   RELA             0000000000000000  00004428
> >        0000000000000078  0000000000000018   I      24    17     8
> > 
> > And both of them have their range [sh_addr ... sh_addr+sh_size] on the
> > area pointed by `e_entry`.
> > 
> > This causes that image->start is calculated twice, once for .text and
> > another time for .text.hot. The second calculation leaves image->start
> > in a random location.
> > 
> > Because of this, the system crashes inmediatly after:
> > 
> > kexec_core: Starting new kernel
> > 
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > To: Eric Biederman <ebiederm@xmission.com>
> > Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
> > Cc: kexec@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  kernel/kexec_file.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index f1a0e4e3fb5c..b1a25d97d5e2 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -904,7 +904,8 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
> >  		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
> >  		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
> >  		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
> > -					 + sechdrs[i].sh_size)) {
> > +					 + sechdrs[i].sh_size) &&
> > +		    kbuf->image->start != pi->ehdr->e_shnum) {

I think we should also be comparing against the initial value (set ~20 lines
above) of pi->ehdr->e_entry, not pi->ehdr->e_shnum.

This patch works correctly for me:

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f7a4fd4d243f4..967826a42cdd7 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -913,7 +913,8 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
                if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
                    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
                    pi->ehdr->e_entry < (sechdrs[i].sh_addr
-                                        + sechdrs[i].sh_size)) {
+                                        + sechdrs[i].sh_size) &&
+                   kbuf->image->start == pi->ehdr->e_entry) {
                        kbuf->image->start -= sechdrs[i].sh_addr;
                        kbuf->image->start += kbuf->mem + offset;
                }

Great find.  With those 2 quick changes, you can add:

Reviewed-by: Ross Zwisler <zwisler@google.com>

> Shouldn't this be: kbuf->image->start == pi->ehdr->e_shnum) {
> 
> ?
> 
> As you want to only do this update when it's not equal to the initial value.
> If this did work, then you may want to make sure that was the initial value.
> 
> Also, please add a comment about why you are doing this check.
> 
> Thanks!
> 
> -- Steve
> 
> >  			kbuf->image->start -= sechdrs[i].sh_addr;
> >  			kbuf->image->start += kbuf->mem + offset;
> >  		}
> > 
> > ---
> > base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
> > change-id: 20230321-kexec_clang16-4510c23d129c
> > 
> > Best regards,
> > -- 
> > Ricardo Ribalda <ribalda@chromium.org>
