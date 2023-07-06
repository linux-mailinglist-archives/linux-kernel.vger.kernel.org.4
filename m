Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992B47493FC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjGFDGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGFDGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:06:06 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA531BCB;
        Wed,  5 Jul 2023 20:06:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso161015e87.3;
        Wed, 05 Jul 2023 20:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688612763; x=1691204763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6uf0a0v+B7/AzrXQVXoSrla0s6BwfseyAsTwf2297VQ=;
        b=NeslzOUhlgf8xCyuIZDKe6UcSUaJOEMWsDS/C5VR4NlfgcVx1ycYdBUJUGeUIXwJTD
         4QwQFZxSFF2Z3ymdkqIms8N9+vlwZkTUjgYiRatceQGSgasXiQL/1w+9bDI3MOjnAiJ0
         wJPDx7K5t0V9Zey+hJnvQleLedU3odv43Y+oFUE2BJWcKW5BSL2WNm4mmzPJBwDPZFwC
         iCkJ5KtgwM591+WHTv0L6OHVCUIKKL+8z4Q4/qQ8GVXfxpuk35w6CID8NJn5f/qJrbki
         +OgncJXgsy92HQ9pN8tgcVTPra1YmPH/535izMuQsIqueYsRTxqRmq5NZnm3pHW9lwBJ
         y6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688612763; x=1691204763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uf0a0v+B7/AzrXQVXoSrla0s6BwfseyAsTwf2297VQ=;
        b=MFBjQGbCcEW3NN73euDMFJaNKtHmSDAXwm9Z3Qh2T3yBi0wCUyS/fOHGbnlcvuC4Ez
         p+CiWOpFaIsHOP+wsxSke5XtxO85P6qSqUh7tVwBn6kAyIc/BeWcnwNOnq+w0f5m6GK9
         exYuxmexBawH4kYQwPkMwzzI0KBwCDrElJCfIxl4GZtA/AX4veENhfEWmUCfT4MvbnhE
         yWAqpQ9FXlQxAryGRg2l7fAmyzgELWy7NZFGY8+UkmD1vqjbafD91HrOwpthqygGH0Wy
         S4Pfjapkq8zi1qcvb9Fn7el9c9Z02zeJH8d2MgAKlkTcQVSZFbm3XoCK7vqwiUguwj+O
         53cw==
X-Gm-Message-State: ABy/qLZ0WtoR2bdnnOM5KnRrBSk7F41F0hS9GUJIa0OWZMgSvII+Z6Gk
        dy2UkPwf86Jnw9bw9mK7zF1+nNMq6/+EsQ==
X-Google-Smtp-Source: APBJJlElI/zQmqLeUgKM70+/XBOsqSJyNGUPgllSD7TbIo9WlakmfYQHvhRV1nnYVY+xyEgeal7gog==
X-Received: by 2002:a05:6512:32b7:b0:4f8:7897:55e6 with SMTP id q23-20020a05651232b700b004f8789755e6mr387278lfe.45.1688612762809;
        Wed, 05 Jul 2023 20:06:02 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id f19-20020a1c6a13000000b003f733c1129fsm679324wmc.33.2023.07.05.20.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 20:06:02 -0700 (PDT)
Date:   Thu, 6 Jul 2023 04:06:01 +0100
From:   Stafford Horne <shorne@gmail.com>
To:     Rich Felker <dalias@libc.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Szabolcs Nagy <nsz@port70.net>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-openrisc@vger.kernel.org
Subject: Re: [RFC PATCH v2] openrisc: Union fpcsr and oldmask in sigcontext
 to unbreak userspace ABI
Message-ID: <ZKYvme8zl731L9R0@antec>
References: <20230705212646.3618706-1-shorne@gmail.com>
 <20230706005916.GW20050@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706005916.GW20050@brightrain.aerifal.cx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 08:59:16PM -0400, Rich Felker wrote:
> On Wed, Jul 05, 2023 at 10:26:45PM +0100, Stafford Horne wrote:
> > With commit 27267655c531 ("openrisc: Support floating point user api") I
> > inproperly added an entry to the struct sigcontext which caused an
> > unwanted to chagne to the userspace ABI.
> > 
> > Since oldmask was never used in OpenRISC we now use it's space for the
> > floating point fpcsr state.  We do this with a union to restore the ABI
> > back to the pre kernel v6.4 ABI and keep API compatibility.
> > 
> > This does mean if there is some code somewhere that is setting oldmask
> > in a userspace sighandler it would end up setting the floating point
> > register status, but I think it's unlikely as oldmask was never used
> > before.
> > 
> > Fixes: 27267655c531 ("openrisc: Support floating point user api")
> > Reported-by: Szabolcs Nagy <nsz@port70.net>
> > Closes: https://lore.kernel.org/openrisc/20230626213840.GA1236108@port70.net/
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> > Changes since v1:
> >  - Rather than revert the change, just use the oldmask slot for fpu state.
> > 
> >  arch/openrisc/include/uapi/asm/sigcontext.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/openrisc/include/uapi/asm/sigcontext.h b/arch/openrisc/include/uapi/asm/sigcontext.h
> > index ca585e4af6b8..93817d7051aa 100644
> > --- a/arch/openrisc/include/uapi/asm/sigcontext.h
> > +++ b/arch/openrisc/include/uapi/asm/sigcontext.h
> > @@ -28,8 +28,10 @@
> >  
> >  struct sigcontext {
> >  	struct user_regs_struct regs;  /* needs to be first */
> > -	struct __or1k_fpu_state fpu;
> > -	unsigned long oldmask;
> > +	union {
> > +		struct __or1k_fpu_state fpu;
> > +		unsigned long oldmask;	/* unused */
> > +	};
> >  };
> >  
> >  #endif /* __ASM_OPENRISC_SIGCONTEXT_H */
> > -- 
> > 2.39.1
> 
> Correctness/ABI-safety of this patch depends on struct
> __or1k_fpu_state being just a single unsigned long and never changing.
> Is this something it's possible to commit to? Otherwise, a much better
> idea would be making the union contain a struct __or1k_fpu_state *
> or some more general pointer type that points to an out-of-band,
> expandable data structure past the end of the ucontext_t.

Thank you for reviewing.

Yes, __or1k_fpu_state I intend to always contain just the single unsigned long.

Thinking about it, I should just change sigcontext from using struct
__or1k_fpu_state to simply 'unsigned long fpcsr' to make this more clear. I will
do this for v3.

If further expansion is needed we can add more structs after ucontext_t as you
mention.  I was considering doing that but found the unused space in oldmask.

-Stafford
