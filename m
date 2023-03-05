Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6F26AAF50
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 12:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCELl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 06:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCELly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 06:41:54 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8E1F977;
        Sun,  5 Mar 2023 03:41:52 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id k10so3684253edk.13;
        Sun, 05 Mar 2023 03:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678016511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C+FZcIOnbQr5WIW/EB04MYDw6O1VY/nZHOjssBpOPDs=;
        b=fQRrahXx3wOyw0cSj7ydWtR9xuIwTUvHGwOEvl8IiSQ1SpilYfnNTZ57lEDbxs4umI
         B/EmB4XqvMI3Dvi6a/qwNMzSoWeZsSOIlDBJTRr2Fdzp+VIfIq1N+sli1N0IhLPlWS1P
         m9VatIh5tPWNuHyN3xZEOFLZ+upW7lDWmAEgvMaqZr6/1kb7ZqBxwNyz9MD4zbNnb8RY
         u9HtcAdSjQBuK9v6LU6F9EdNu49txdV7bzR+QNuQwzjBNc7d5d461ek4a48NPdnyZZ1A
         9siysn0oEvpP2MJhOlEO7a+6se+MaGG9t9sm18a+/T5dRAAfU/ojtSGhxIQh53Q89ts/
         pcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678016511;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+FZcIOnbQr5WIW/EB04MYDw6O1VY/nZHOjssBpOPDs=;
        b=vUixL+X4msgOCzk9XFUf2oVIWsGksRzM7V0RuYe5z1nOvoQ1HOfR38iwfvt45alRRO
         SKXd3QQtDms00kAwhl9TFJnRc9FfdGEm4PAZ9qxxuSVwf/tXtPlHvjQeKvMLYEAyIimD
         NyOR+WFMYhCDii4S/xn+DcuZfTIuMlo0f1Sgl0CvUTWPM2TygjTrROdKcJJAWUSJUEf2
         MwqLckZT/RepWjpqFO5bzea3cleKdT6CTXbhm2jE45BN6XLmbe1PbERQLAzvbEckbRcu
         ILAUb/QKgRb6vncJqlcXqAZ+XXjMoRtjHpw/8Q7ahxHOS2tDHPguyKUgewqNLHPnAKpJ
         ytkA==
X-Gm-Message-State: AO0yUKXU3z8rj6+BGsIn0Qd+++sLpwWke2ZrSoKNnBzbtXiBfZaKDKkz
        S3kMQKb5MyDnJtAJj/k0HCM=
X-Google-Smtp-Source: AK7set+L74oec0oGRHadWBpcenYVmS0ItPBQjZu0+b7lO7nanEDUzLV6r7WpXtKOUqeQVi5+TKw/2Q==
X-Received: by 2002:aa7:c2d1:0:b0:4ca:4a5:91bb with SMTP id m17-20020aa7c2d1000000b004ca04a591bbmr7571268edp.13.1678016511224;
        Sun, 05 Mar 2023 03:41:51 -0800 (PST)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id y7-20020a50eb07000000b004bf28bfc9absm3524014edp.11.2023.03.05.03.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 03:41:50 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sun, 5 Mar 2023 12:41:48 +0100
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 13/13] rcu/kvfree: Eliminate k[v]free_rcu() single
 argument macro
Message-ID: <ZAR//FKO4syzapk6@pc636>
References: <CAEXW_YRhHaVuq+5f+VgCZM=SF+9xO+QXaxe0yE7oA9iCXK-XPg@mail.gmail.com>
 <A3933CE1-1C8A-4E9B-9E10-828CB2CE34AA@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A3933CE1-1C8A-4E9B-9E10-828CB2CE34AA@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Mar 5, 2023, at 5:29 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > ﻿Hi, All,
> > 
> >> On Wed, Feb 1, 2023 at 10:11 AM Uladzislau Rezki (Sony)
> >> <urezki@gmail.com> wrote:
> >> 
> >> For a single argument invocations a new kfree_rcu_mightsleep()
> >> and kvfree_rcu_mightsleep() macroses are used. This is done in
> >> order to prevent users from calling a single argument from
> >> atomic contexts as "_mightsleep" prefix signals that it can
> >> schedule().
> >> 
> > 
> > Since this commit in -dev branch [1] suggests more users still need
> > conversion, let us drop this single patch for 6.4 and move the rest of
> > the series forward? Let me know if you disagree.
> > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=9bf5e3a2626ed474d080f695007541b6ecd6e60b
> > 
> > All -- please supply Ack/Review tags for patches 1-12.
> 
> Or put another way, what is the transition plan for these remaining users?
> 
> I am getting on a plane right now but I can research which users are remaining later.
> 
I am not sure. I think we can cover it on the meeting. My feeling is
that, we introduced "_mightsleep" macros first and after that try to
convert users.

@Paul what is your view?

Thanks!

--
Uladzislau Rezki
