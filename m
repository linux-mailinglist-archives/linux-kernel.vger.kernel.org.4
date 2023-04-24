Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32A46ED555
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjDXT00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjDXT0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:26:24 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AC044B1;
        Mon, 24 Apr 2023 12:26:23 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3e8b3aed55bso23151141cf.3;
        Mon, 24 Apr 2023 12:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682364382; x=1684956382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5WcTX+EeaGsxdM7iEyZFoPrBHwjvydFJtcBq7twcJE=;
        b=Q7kqlzPwtnz9GHcfA3FamK1WCOGenrygc8tdrlX+VPt4u+vIyXEtNyjNZag0Csm8PI
         cBh06puZK8ynWwiyKDW0V7GpKQOoH4Zp5iB2ur0Th0zORUbDZU/gevLheLDMnv9716aF
         yE3Fvlb1ntmT2RsJK9CNVZ/yzOWB/gP/o+dZnbrY/NoDwB36uNYX8MSezk9960RuHBz3
         vq7UOlZROP4aWaMetE3961fITx3CMxFmwDOOyjVvr1jctSOMbDpd7f8mnrYQYeSTPlhr
         adf6cJnm4WmeItHzq1mnNaB9uus9imw4/FIHIV8j5tSGYSpPda7OWLCkHuftpscRqj8/
         KdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682364382; x=1684956382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5WcTX+EeaGsxdM7iEyZFoPrBHwjvydFJtcBq7twcJE=;
        b=LhGpa0bF7hl/euEavuSXZQG+a4UVM6A41w/iKyaG0/Z+t7KDeXZNoBEmEjwF3NILF5
         ajxvVrUCuS33IYwJreaJOYAR2fMoeIZO4bqbbYIqCkIX2dwi1aHVXbNvfSjOTFZ3FPqj
         tzsK0se01nvtWWTbw/Va+yAsMiis0hH4WjI3yhncRUbbz/L7L/9+GFtlBCddTFO34AKJ
         QgtjSF9uWl51orIcLzJEmtFLSJVnQxCZr6tuQYzdR5iDOw9SjWvLDhCs4fbJ1twiBEtg
         0qz8ZIjXIFrZdTWru5O3GFIjjFYOH5uBYB+1Wc794lnQ2dZ57LUzxRVI/QsqCFhAAYzq
         InWQ==
X-Gm-Message-State: AAQBX9cVY6AxYn8gqNwUQZ8bYcpZW3tcRDNCn/+vktfgXkkP+3DuNGBP
        inYr5h4Mxnd57dxOqJ2nGpE=
X-Google-Smtp-Source: AKy350bkmGyFsKqtKrCOL6Bro0cXPDHYhK3ExLfdT6QYV5byUqQgandDIZ3XR0YL1G+aj+tjUupYvw==
X-Received: by 2002:ac8:5814:0:b0:3ef:57c1:ad7 with SMTP id g20-20020ac85814000000b003ef57c10ad7mr26361936qtg.30.1682364382044;
        Mon, 24 Apr 2023 12:26:22 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x15-20020ac84d4f000000b003ef28a76a11sm3847395qtv.68.2023.04.24.12.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 12:26:21 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id D316927C0054;
        Mon, 24 Apr 2023 15:26:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 24 Apr 2023 15:26:20 -0400
X-ME-Sender: <xms:29dGZD3p8_jv5S_xCFIABhz7rg745wdKIg--C6b9B55Cy16iwAeTrA>
    <xme:29dGZCE5mVVFd_OP8h5mu0iFcheWWxvbBai6kas8GSL0I2e1ciSRo2YzutwwBqTDf
    YEJpsmvVikGd1_JuA>
X-ME-Received: <xmr:29dGZD5RXVv1dNTMMmO7BHxwPNFT8Xf1Crl7jxuFVqSnA6Yfna9srWb_g1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedutddgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepffehkeeuhfeigeevveejvefftdehueevfeetleevfefgudeitedvudev
    ieevkedunecuffhomhgrihhnpehgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:29dGZI23xKuWw0Egqe40sSpqBSF5fWDx1kbSsvHMacElPSTzlKgJrg>
    <xmx:29dGZGGZ6peQJ9TzZvlGDbuJihx5oy1wN1it-4ibgmzZ9m4tApjY-w>
    <xmx:29dGZJ8QA3nr1KuWgYA-6XsXm6xgnXqnMQE3g2cVLVGAfPrd2sMw8Q>
    <xmx:3NdGZEYFGzVKfJrYn71E_rlCfrtiQyoT5G8uEP4WQd1T0C-z5PBE_w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Apr 2023 15:26:19 -0400 (EDT)
Date:   Mon, 24 Apr 2023 12:25:42 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joel Fernandes <joel@joelfernandes.org>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
Message-ID: <ZEbXtmFUPKA5cl6P@boqun-archlinux>
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com>
 <ZEXOMC2casTlobE1@boqun-archlinux>
 <87fs8pzalj.fsf@mail.concordia>
 <20230424151351.GP19790@gate.crashing.org>
 <ZEagN1jJwg+rUzX4@boqun-archlinux>
 <20230424172900.GR19790@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424172900.GR19790@gate.crashing.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 12:29:00PM -0500, Segher Boessenkool wrote:
> On Mon, Apr 24, 2023 at 08:28:55AM -0700, Boqun Feng wrote:
> > On Mon, Apr 24, 2023 at 10:13:51AM -0500, Segher Boessenkool wrote:
> > > At what points can r13 change?  Only when some particular functions are
> > > called?
> > 
> > r13 is the local paca:
> > 
> > 	register struct paca_struct *local_paca asm("r13");
> > 
> > , which is a pointer to percpu data.
> 
> Yes, it is a global register variable.
> 
> > So if a task schedule from one CPU to anotehr CPU, the value gets
> > changed.
> 
> But the compiler does not see that something else changes local_paca (or

It's more like this, however, in this case r13 is not changed:

	CPU 0			CPU 1
	{r13 = 0x00}		{r13 = 0x04}

	<thread 1>
	<in interrupt>
	 _switch():
	  <switch to the stack of thread 2>
	  <no need to change r13>
	  <in thread 2>
	<thread 2>
				<thread 3>
				_switch():
				 <switch to the stack of thread 1>
				 <no need to change r13>
				 <in thread 1>
				<thread 1>

as you can see thread 1 schedules from CPU 0 to CPU 1 and neither CPU
changes its r13, but in the point of view for thread 1, its r13 changes.

> r13 some other way, via assembler code perhaps)?  Or is there a compiler
> bug?
> 

This looks to me a compiler bug, but I'm not 100% sure.

Regards,
Boqun


> If the latter is true:
> 
> Can you make a reproducer and open a GCC PR?  <https://gcc.gnu.org/bugs/>
> for how to get started doing that.  We need *exact* code that shows the
> problem, together with a compiler command line.  So that we can
> reproduce the problem.  That is step 0 in figuring out what is going on,
> and then maybe fixing the problem :-)
> 
> 
> Segher
