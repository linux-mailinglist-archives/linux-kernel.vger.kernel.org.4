Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9E96BBD38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjCOTZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCOTZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:25:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495B66FFF2;
        Wed, 15 Mar 2023 12:25:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y20so3041070lfj.2;
        Wed, 15 Mar 2023 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678908314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPtmNOrGkyP7/zRk/vmjgCq9DR7+ICStQ9LpjNus1jk=;
        b=mnYvE2pJ6hmP8gx3bKoxxlUQCrM8dBph6LoJLvt67LBNDJuoApN44xJoKMPXrDGdZq
         rWFuAEeSSmgssCjDIirW6P/qSnnyysVJLOCBOo549VGXB9uFMYF2iD7QVwroQMzvHfa9
         XwqKmJ8VHbUjAvxkxbhBFiO0BNSJ6vSa5dVtJMOVNGVTaTBuPGR9Z4PYDNXjEjqe6NVA
         0x7dzaP6THiD48nEsSBfl3Z9EJ8B/yS/qx708YZzVZd8f9qWReC0LBZN02uzHYyIKu1f
         BFSR9UCCYchiOOWINesEgmf76JJ4tWAJM35mjxso6uRNeKZ2VIjbJkZNnwNv2SPgatgp
         1gOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678908314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPtmNOrGkyP7/zRk/vmjgCq9DR7+ICStQ9LpjNus1jk=;
        b=colcGqycOKXBPqXl40RN9pdUoF4rJnmSOeaFpLHpDJQitdBg7e/f7yFhiCPPWh+MaG
         aUaHKiLcSwDZUQFVUPuA7Tr5LW+y/8z8mCJd1OlFiVCzuz3256LDApePH+5Ux5ggRbpP
         r/p/SS7ShTpQAl2+AHFlNu71zPi8C0xv9Is8413YyT+kkhYLQLmf3ebjzYka9aFN8ccD
         DtMj7pAVnY4fbDONeFzezyP0Qk8pnQb46jayQxkqUc1ekQaOiI+m+wH6Ml5rhCEpCB8r
         R/Px3FNxU6DsiRkzHHncQRds6hTWdMBiTEAwW/180FTL88a76yU+MbG7IY3C9CrSI2Ci
         NVpA==
X-Gm-Message-State: AO0yUKWLrbwy3WclDqtcUzhWvf5z+L7/zwSd782aGOKXgUV/ssaydbDR
        rkI7ZGIGXBUkjWbWuP9Iswk=
X-Google-Smtp-Source: AK7set/yTtKBCcW1C59dSM+2LjkaNx8T/QOwFD+fbwy8eShv5/t4ps/AVSwRdVIl85tiq3G+bOY/0w==
X-Received: by 2002:ac2:51a6:0:b0:4e8:3fc2:32a8 with SMTP id f6-20020ac251a6000000b004e83fc232a8mr2026722lfk.27.1678908313537;
        Wed, 15 Mar 2023 12:25:13 -0700 (PDT)
Received: from pc636 (host-90-233-209-246.mobileonline.telia.com. [90.233.209.246])
        by smtp.gmail.com with ESMTPSA id j20-20020a19f514000000b004e8c6e9a6ccsm56295lfb.148.2023.03.15.12.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:25:13 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 15 Mar 2023 20:25:10 +0100
To:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <ZBIbloFMm5xRsjfn@pc636>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230315151415.2534e11c@gandalf.local.home>
 <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 01:16:20PM -0600, Jens Axboe wrote:
> On 3/15/23 1:14?PM, Steven Rostedt wrote:
> > On Wed,  1 Feb 2023 16:08:06 +0100
> > "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
> > 
> >> This small series is based on Paul's "dev" branch. Head is 6002817348a1c610dc1b1c01ff81654cdec12be4
> >> it renames a single argument of k[v]free_rcu() to its new k[v]free_rcu_mightsleep() name.
> >>
> >> 1.
> >> The problem is that, recently we have run into a precedent when
> >> a user intended to give a second argument to kfree_rcu() API but
> >> forgot to do it in a code so a call became as a single argument
> >> of kfree_rcu() API.
> >>
> >> 2.
> >> Such mistyping can lead to hidden bags where sleeping is forbidden.
> >>
> >> 3.
> >> _mightsleep() prefix gives much more information for which contexts
> >> it can be used for.
> > 
> > My honest opinion is that I hate that name "kvfree_rcu_mightsleep()" ;-)
> > 
> > As I honestly don't know why it might sleep.
> > 
> > I didn't care about the name before, but now that it's touching code I
> > maintain I do care ;-)
> > 
> > Why not call it:
> > 
> >  kvfree_rcu_synchronize()
> > 
> > ?
> > 
> > As that is much more descriptive of what it does. Especially since these
> > ugly names are popping up in my code because kvfree_rcu() replaced a
> > rcu_synchronize() in the first place.
> 
> This was my main complaint too, kvfree_rcu_mightsleep() is an absolutely
> horrible name for an API... But nobody seemed to care about that!
> 
> I like the _synchronize() suggestion, as it matches other RCU naming.
> 
This is basically about what it does. If you renamed it to "_synchronize()"
in reality it would not mean that it always a synchronous call, most of the
time it is not whereas the name would point that it is.

--
Uladzislau Rezki

