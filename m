Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818A76E5D02
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjDRJIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjDRJIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:08:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A50A7AAC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681808817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pRNrCYgGB848z5UzPrsHH5olhsaYvQSEqVGi0dF9+RM=;
        b=fZopZSr+AuKScplOVUJYvdyhH5qj/LhPlQYcia6bxsDZANQPV4nA9keawItsZi9X5vUb8w
        VeLuDfIZ5y8KFjGZCVi97hYyCYWg8G9wtHkp3irsmCj0oLE5v5kM2XvJ+t+gE+LfB2mdNO
        F1fEblH7u0XgiG9Ju7jOr2zD0dwtwDk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-6UC646NcOS-g3FegKr14hw-1; Tue, 18 Apr 2023 05:06:55 -0400
X-MC-Unique: 6UC646NcOS-g3FegKr14hw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f0b0c85c4fso36520175e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681808814; x=1684400814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRNrCYgGB848z5UzPrsHH5olhsaYvQSEqVGi0dF9+RM=;
        b=ZMFxwuodGI2wbLF88xjELlHwTyypgqZ686NXIYsifjAND6PN6fis9R9fyQ+WQFltUK
         3xoyFqCPDfjY3O1yVsYc4lWQA1bYbS+XEzmyawRJPSd/CA6VfWEhzCoe+RBoBsLWTv4E
         VklJoYJsStRIACVr4/7HFQuUTHQbWCACw4YnL5x24EBEg2wH4j4yu2g+RFIyOsRI9j3p
         k5Wb89tZkOio3qFazA2r8PhaSvR0DdM5fRptQ92QVMavkAU5Z48CjXAOF0vcPwarjNvR
         +t/bOBpKT1aroWb5bhiPIsPUreR132b/kcJtcYEWYxGtglteaxYJyLL7haUCnHKMqzB5
         3+8A==
X-Gm-Message-State: AAQBX9ewNc5XFFcbMtiFjHtxPtNMzh7CP1sZuzA6o5DYJ8Z464bfXkrH
        AZaVCksOl1hjGUgal7+7hnExmw/uijJFpzRPN1G7Gqn+aZ0o+N4DRY36tvsSn71BsM3eTpJg40/
        TbtkUFHiNJFPkSfSFk3Va2Jjx
X-Received: by 2002:adf:e946:0:b0:2f4:e2d5:401 with SMTP id m6-20020adfe946000000b002f4e2d50401mr1519793wrn.25.1681808814379;
        Tue, 18 Apr 2023 02:06:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350bz/rwcsf+s+AD4QbxZIhyM+n7t/iwWgYMWM6XYFAl0LJK2SNq+DkwwG58Zh35mwMuSCxt1rw==
X-Received: by 2002:adf:e946:0:b0:2f4:e2d5:401 with SMTP id m6-20020adfe946000000b002f4e2d50401mr1519763wrn.25.1681808814032;
        Tue, 18 Apr 2023 02:06:54 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d60cd000000b002c54c9bd71fsm12429777wrt.93.2023.04.18.02.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:06:53 -0700 (PDT)
Date:   Tue, 18 Apr 2023 11:06:51 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        James Chapman <jchapman@katalix.com>, tparkin@katalix.com,
        edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPPoL2TP: Add more code snippets
Message-ID: <ZD5dqwPblo4FOex1@debian>
References: <20230416220704.xqk4q6uwjbujnqpv@begin>
 <ZD5V+z+cBaXvPbQa@debian>
 <20230418085323.h6xij7w6d2o4kxxi@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418085323.h6xij7w6d2o4kxxi@begin>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 10:53:23AM +0200, Samuel Thibault wrote:
> Guillaume Nault, le mar. 18 avril 2023 10:34:03 +0200, a ecrit:
> > On Mon, Apr 17, 2023 at 12:07:04AM +0200, Samuel Thibault wrote:
> > >          sax.sa_family = AF_PPPOX;
> > >          sax.sa_protocol = PX_PROTO_OL2TP;
> > >          sax.pppol2tp.fd = tunnel_fd;
> > > @@ -406,12 +407,64 @@ Sample userspace code:
> > >          /* session_fd is the fd of the session's PPPoL2TP socket.
> > >           * tunnel_fd is the fd of the tunnel UDP / L2TPIP socket.
> > >           */
> > > -        fd = connect(session_fd, (struct sockaddr *)&sax, sizeof(sax));
> > > -        if (fd < 0 ) {
> > > +        ret = connect(session_fd, (struct sockaddr *)&sax, sizeof(sax));
> > > +        if (ret < 0 ) {
> > 
> > Now you also need to close session_fd.
> 
> ? No, we need it for PPPIOCGCHAN, and also PPPIOCGL2TPSTATS.

connect() failed. You can't do anything with this socket.

> I'll put return session_fd instead.

What's the point of returning session_fd if connect() failed?
How will the caller know if session_fd is connected or not?
Why would it even be interested in a half-created session fd?

> > > +The ppp<ifunit> interface can then be configured as usual with SIOCSIFMTU,
> > > +SIOCSIFADDR, SIOCSIFDSTADDR, SIOCSIFNETMASK, and activated by setting IFF_UP
> > > +with SIOCSIFFLAGS
> > > +
> > > +  - Tunnel switching is supported by bridging channels::
> > 
> > This is a PPP feature not an L2TP one.
> > 
> > PPPIOCBRIDGECHAN's description
> > belongs to Documentation/networking/ppp_generic.rst, where it's already
> > documented.
> 
> Yes but that's hard to find out when you're looking from the L2TP end.

That's why I proposed linking to ppp_generic.rst.

> > If necessary, you can link to ppp_generic.rst here.
> > 
> > Also, calling this feature 'tunnel switching' is misleading.
> 
> That's how I have seen it is called in L2TP jargon.

That still doesn't describe the kernel feature. We can add a 'so called
"tunnel switching" in L2TP jargon' into parenthesis to give a hint to
the people using this terminology.

> Samuel
> 

