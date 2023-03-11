Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6D86B5F4C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCKRqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKRqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:46:11 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7913C57D24
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:46:09 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id c18so9222970qte.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678556768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pc/briERt9FJh5C2XHv6CkT7y+2L+qDGLr//rdnKvrc=;
        b=ULSh+fxLXFnj1HeU5iXIrGG67yAFGF10F55yq0NsfeTWnm44/u0UfhMnE+St+Ysh7N
         qtdpRavL5uAi/iKad2szMWWIhWukADvlQFgfvFzwFEDkTqZLKmVsli6agC6yFfncnqya
         cARLfAFQYgWBAriYjGkW26SPcDGN1++br5pwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pc/briERt9FJh5C2XHv6CkT7y+2L+qDGLr//rdnKvrc=;
        b=lShqYr5DLaGovtgSBsqecN9npmaKBiqEusJr7vVpdGBtvl+N01gL9ZPRG9zIZdgKiY
         urXrBZCuVPfZaT5a3bwqpo/sUbw80tN7luRATymmPHRsoZa2ejcf2MNY9xGIb11pPzhT
         0sf/sAu/oxw0nGjjVwHDS7P23VKVCBTSoMwSJ58+GJ3UlwJIlmk58/9qM/IUVqXPEt2Z
         Bim8geDtmgt2g9R4cY3ma14xpNQ410ZS81/saezbdCd6JT1tC1yu8fpuC7u2aHxX+4dq
         4tXa1azA+ijLWDOGENE00N5e5puCEwthG7wwRGKzqJNTcXjSF+C38tOk7PqY2Qr0Y8tt
         678g==
X-Gm-Message-State: AO0yUKXZC9NqXjT6KiZhb/NKJH4LOb8GXXHFBID/KV4eLMeW15hmIITr
        JwAkFfxy/rzBnF8IFC0TqM3rvA==
X-Google-Smtp-Source: AK7set8hO6t/689Jo5lexMAWJLjyP9W1ozTlFEuJIaQWqb2VSTGPGIps96hAqM4nkVkd27Fz0MHIWQ==
X-Received: by 2002:a05:622a:1042:b0:3b8:6b74:8ac3 with SMTP id f2-20020a05622a104200b003b86b748ac3mr13608691qte.28.1678556768494;
        Sat, 11 Mar 2023 09:46:08 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id z4-20020ac84304000000b003c03b33e6f5sm2184179qtm.90.2023.03.11.09.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:46:07 -0800 (PST)
Date:   Sat, 11 Mar 2023 17:46:07 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     David Howells <dhowells@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH rcu 14/16] rxrpc: Use call_rcu_hurry() instead of
 call_rcu()
Message-ID: <20230311174607.GA2293352@google.com>
References: <CAEXW_YSd3dyxHxnU1EuER+xyBGGatONzPovphFX5K9seSbkdkg@mail.gmail.com>
 <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
 <20221130181325.1012760-14-paulmck@kernel.org>
 <CAEXW_YS1nfsV_ohXDaB1i2em=+0KP1DofktS24oGFa4wPAbiiw@mail.gmail.com>
 <639433.1669835344@warthog.procyon.org.uk>
 <658624.1669849522@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658624.1669849522@warthog.procyon.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 11:05:22PM +0000, David Howells wrote:
> Joel Fernandes <joel@joelfernandes.org> wrote:
[...] 
> > After your patch, you are still doing a wake up in your call_rcu() callback:
> >
> > - ASSERTCMP(refcount_read(&conn->ref), ==, 0);
> > + if (atomic_dec_and_test(&rxnet->nr_conns))
> > +    wake_up_var(&rxnet->nr_conns);
> > +}
> > 
> > Are you saying the code can now tolerate delays? What if the RCU
> > callback is invoked after arbitrarily long delays making the sleeping
> > process to wait?
> 
> True.  But that now only holds up the destruction of a net namespace and the
> removal of the rxrpc module.

I am guessing not destructing the net namespace soon enough is not an issue.
I do remember (in a different patch) that not tearing down networking things
have a weird side effect to tools that require state to disappear..

> > If you agree, you can convert the call_rcu() to call_rcu_hurry() in
> > your patch itself. Would you be willing to do that? If not, that's
> > totally OK and I can send a patch later once yours is in (after
> > further testing).
> 
> I can add it to part 4 (see my rxrpc-ringless-5 branch) if it is necessary.

I am guessing the conversion to call_rcu_hurry() is still not necessary here,
if it is then consider the conversion.

But yeah feel free to ignore this, I am just pinging here so that it did not
slip through the cracks.

thanks,

 - Joel

