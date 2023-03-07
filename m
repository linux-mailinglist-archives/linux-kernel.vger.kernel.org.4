Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDB36AD640
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCGElO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCGElL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:41:11 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A174BE8C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 20:41:06 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id c18so13217723qte.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 20:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678164066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6qCv0iSiDbulB3jzvpmB167Z8m74Zqa23My4mYkvzyo=;
        b=S+rOnczXhLL9hE9rWM5bJcmXbRaGW8LpzeTlsjlV03Z0jmx2sQfUV+kF00XNjUt5wH
         6Cs5BUZuT1e98XhM/8m002/XCEHzsVp44foblf5fMcwmCWGKdEpQvIVkujMONEHe17K7
         PU1+WwbldpzODroLSAvd7Hf5iSlbFwJDFrICE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678164066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qCv0iSiDbulB3jzvpmB167Z8m74Zqa23My4mYkvzyo=;
        b=vA40KNEi5Q9GzOeV5/I7ZQqFr55Bftm76m/NN95TjK88ws3YIQRCNxWjEY3aOb8B57
         XKmRymXk5coNqHNtOrTNw9AA3999wKN37O3RWg31WRmpLGmoyS38eU5BsGP+4zerK6GQ
         qaQI187N0CepLCOtxLvAspchowB+x16NeddU5MI9x2Edl9vNNYkYdfZwNJCt67NWPojR
         FWjtfcV+HX0XyXNsEFuvO1ynqqWAfpDGGJK2ni4Qq8QaaMEcmA4+fhvXpaBU8q2s661X
         RAs2MAyop2gPeoX7fifjU1DyhdrskR7yQ2DZx9zYJQ76FpHlLvOe079pzLbITmSXQ3NC
         za4A==
X-Gm-Message-State: AO0yUKVxaIMe5l0+SLzjuRsZinIWztHfT5UlF2Fb6tcSI0Gz3a/+3SdT
        tEj5cq8zAuGXsb6/AxmpR2cIGQ==
X-Google-Smtp-Source: AK7set/m+GjYlO4eJ5CADhlKuHFblpQi2qfdmAnotXKArwTXo5PkuuUzwPyTXGJB/ugAPVwxTCwSlQ==
X-Received: by 2002:ac8:5904:0:b0:3b8:6ae7:1757 with SMTP id 4-20020ac85904000000b003b86ae71757mr22229123qty.38.1678164065780;
        Mon, 06 Mar 2023 20:41:05 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id m19-20020a05622a055300b003b2957fb45bsm9103897qtx.8.2023.03.06.20.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 20:41:05 -0800 (PST)
Date:   Tue, 7 Mar 2023 04:41:04 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] checkpatch: Error out if deprecated RCU API used
Message-ID: <20230307044104.GA3532764@google.com>
References: <20230307030457.3499834-1-joel@joelfernandes.org>
 <753b72f5ecd03f94511495a333eb192c5fc42087.camel@perches.com>
 <CAEXW_YRYnikDRTQXwrTpTsQ1r-32FRPABj_Viu+X6Qr7EWqh4g@mail.gmail.com>
 <802731d7bf187573a9084cb23196c096be81b5e1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <802731d7bf187573a9084cb23196c096be81b5e1.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 07:23:23PM -0800, Joe Perches wrote:
> On Mon, 2023-03-06 at 22:10 -0500, Joel Fernandes wrote:
> > On Mon, Mar 6, 2023 at 10:08 PM Joe Perches <joe@perches.com> wrote:
> > > 
> > > On Tue, 2023-03-07 at 03:04 +0000, Joel Fernandes (Google) wrote:
> > > > Single-argument kvfree_rcu() usage is being deprecated [1] [2] as it is
> > > > error-prone. However, till all users are converted, we would like to introduce
> > > > checkpatch errors for new patches submitted.
> > > > 
> > > > This patch adds support for the same. Tested with a trial patch.
> > > > 
> > > > For now, we are only considering usages that don't have compound
> > > > nesting, for example ignore: kvfree_rcu( (rcu_head_obj), rcu_head_name).
> > > > This is sufficient as such usages are unlikely.
> > > > 
> > > > Once all users are converted and we remove the old API, we can also revert this
> > > > checkpatch patch then.
> > > 
> > > I think this should be added to the deprecated_apis hash instead
> > > 
> > > our %deprecated_apis = (
> > >         "synchronize_rcu_bh"                    => "synchronize_rcu",
> > >         "synchronize_rcu_bh_expedited"          => "synchronize_rcu_expedited",
> > >         "call_rcu_bh"                           => "call_rcu",
> > >         "rcu_barrier_bh"                        => "rcu_barrier",
> > >         "synchronize_sched"                     => "synchronize_rcu",
> > >         "synchronize_sched_expedited"           => "synchronize_rcu_expedited",
> > >         "call_rcu_sched"                        => "call_rcu",
> > >         "rcu_barrier_sched"                     => "rcu_barrier",
> > >         "get_state_synchronize_sched"           => "get_state_synchronize_rcu",
> > >         "cond_synchronize_sched"                => "cond_synchronize_rcu",
> > >         "kmap"                                  => "kmap_local_page",
> > >         "kunmap"                                => "kunmap_local",
> > >         "kmap_atomic"                           => "kmap_local_page",
> > >         "kunmap_atomic"                         => "kunmap_local",
> > > );
> > 
> > This is not an API name change though, it is a "number of arguments"
> > or argument list change. Is there a different way to do it?
> 
> Ah, no, not really.
> 
> btw: I don't see a single use of this call without a comma in the tree.
> 

Did you look for kvfree_rcu? It is either kvfree_rcu() or kfree_rcu().

thanks,

 - Joel

