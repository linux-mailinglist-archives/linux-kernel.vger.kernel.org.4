Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB02680069
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 18:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjA2R2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 12:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjA2R2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 12:28:33 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE03B1715A
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:28:31 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id mf7so7193013ejc.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 09:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XB/vynYFd1RSVhuOcO9VWCqQzh36o9kJ51i0cwKo730=;
        b=j5HM0h+nY1efDCOQjMA643+FeeduJnvuzDJOnhm4rol9ZGebbR96KZs7DFZUNWjUik
         3rZ1fpGdXci/Qzg1F9y5T45HZiaFvttzooafaDi5s0uAKGd8/uPWoCK1e+6KHLbhdQ09
         NKzSR2/ouga/Eu4ZaFDWDzkRC9tW2rQLOV4OceMTUIOBS5+5FcmHfKD8UQzmtfOCSrk7
         nfXDjxDDrU4UIlWIAbRl981UYyRQy0C4C2jLoHPtd3b/jPpRW46PgvlTlwMQ9Z/JJL2+
         qq4Dtk3Lzunb5VSd0QqTkwhXFm6M4a1AFx6H6i4Ia0uz8rwAoU5SJNRpJV5VwIWu7VgB
         sMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XB/vynYFd1RSVhuOcO9VWCqQzh36o9kJ51i0cwKo730=;
        b=MR73rH/ezmCgBdZoiyq3DeL1ZcYfBux3FXCtxo4x43cFoI58/Ubw29aMxE1GPjZN6F
         9b7yyjQ3zfvIjNn1FocQyIC1jA3VHdh2az6xY3+y2OTCgHgcMJCSJ7mTsw9w9Ou0x4sL
         SRUyeynJo1tFZy8Ae7z6gaqm1K3GrKfE+4jenyX/5ybvnjjeaVd+EYL8w51HfUJxvGhD
         rjhB2b/Pq7cEwoHfdKqaPz18EPTLoyUwPhfzchQM4SE7VaKlUggOo+83H+Sbqiru3utG
         WH7ZLJoEzkkk5sLogWyiOLvPcrucD+vf1BQlgKSVp2euSZglcGi3bAZPjOzVhGgVvWFn
         JftA==
X-Gm-Message-State: AO0yUKUNe1TsEA8gpPMfBYSDKMpFERItZJjIeImjeed1zHvWYPx7UtSy
        cTgm9k+dK5VzqAyoXt5qmF8=
X-Google-Smtp-Source: AK7set9OVNkGQp/NpUu8HF7oDyuCi5J7+4BmGuygb/m+1V68Ig247QRzEDZTZt9wfSgVVhlqqFJDPQ==
X-Received: by 2002:a17:907:77cf:b0:87b:d4e8:5f9a with SMTP id kz15-20020a17090777cf00b0087bd4e85f9amr9551855ejc.50.1675013310336;
        Sun, 29 Jan 2023 09:28:30 -0800 (PST)
Received: from andrea ([217.9.231.172])
        by smtp.gmail.com with ESMTPSA id kg28-20020a17090776fc00b008784e808553sm5608163ejc.6.2023.01.29.09.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 09:28:29 -0800 (PST)
Date:   Sun, 29 Jan 2023 18:28:27 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Message-ID: <Y9asu0CswZZ3yyls@andrea>
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu>
 <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
 <20230129051734.GE2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9aY4hG3p+82vVIw@rowland.harvard.edu>
 <20230129162156.GG2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129162156.GG2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why can't P3's spin_lock() read from that initial write?

Mmh, sounds like you want to play with something like below?

  Andrea

diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 6b52f365d73ac..20c3af4511255 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -74,7 +74,6 @@ flag ~empty UL \ range(critical) as unmatched-unlock
 
 (* Allow up to one unmatched LKW per location; more must deadlock *)
 let UNMATCHED-LKW = LKW \ domain(critical)
-empty ([UNMATCHED-LKW] ; loc ; [UNMATCHED-LKW]) \ id as unmatched-locks
 
 (* rfi for LF events: link each LKW to the LF events in its critical section *)
 let rfi-lf = ([LKW] ; po-loc ; [LF]) \ ([LKW] ; po-loc ; [UL] ; po-loc)
@@ -120,8 +119,7 @@ let rf-ru = rfe-ru | rfi-ru
 let rf = rf | rf-lf | rf-ru
 
 (* Generate all co relations, including LKW events but not UL *)
-let co0 = co0 | ([IW] ; loc ; [LKW]) |
-	(([LKW] ; loc ; [UNMATCHED-LKW]) \ [UNMATCHED-LKW])
+let co0 = co0 | ([IW] ; loc ; [LKW])
 include "cos-opt.cat"
 let W = W | UL
 let M = R | W

