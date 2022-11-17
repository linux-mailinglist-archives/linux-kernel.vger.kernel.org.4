Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697B462DC5F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbiKQNMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239908AbiKQNLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:11:44 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26216E54F;
        Thu, 17 Nov 2022 05:11:42 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id h12so2606177ljg.9;
        Thu, 17 Nov 2022 05:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4sws5iJ633AZdBCeJxCZGSrAHkBWS4YaCw1buo2c50w=;
        b=QCiMlsnmcbusTFqVVSqCJqWJuywBvw0xhrGtJfPjhTmNqlehDBdh+VAVoKH+V2trVQ
         5ns/jA1WC2v2I0FgrXI5Hh7wx97SxlvoEh+JFqANtS5+8dXANQKrpVbLvuGd1qNM8dBo
         8p9VhLyenuvTusezUy8mopjAUsZQeUtFjy7ALCg7xjRKLdncs06MK1GM9Z6QtRc7nTB5
         U0pVfgkz+b5eyf0EtZHxGe3E8kBDQ5EJqp0X2TL9AJOZo+klKu2yC3TFTUDqdEIRruLM
         zSHSfFxSM692EUm666d0mc/7ap4zPWdylWmxkOJftFN9uzy2/bPNxzaV9FIZjez7a2nA
         VfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sws5iJ633AZdBCeJxCZGSrAHkBWS4YaCw1buo2c50w=;
        b=IU0DLTvKisDsbKetz712rl25a1rBSiDmtW2r6XckVvTAHU8oZxKJDasM2a5D2c4g1g
         pIWO8qihUfhIhKzPGTIY7lFshlyafXpGsPgNyUyA3jzcmjIpNizwunXcg0mJeHR4VJdY
         WGsEbaST+vevqldKxBdAysNlOvklxfeiukYqDJ3803o5Xex9bPIPoqKmCfosUVdsidyw
         i2QocthqKQjjnozTyq4Tir6T5o2xzgSTYQgMOVveW9ftnvu4cxydVhT0V8nlBPjUyLtl
         iiQO0ucptnMgMPWsk+5T3R1784ixo6fz4EytQ/qo7krSbVAlu+95qT5ByCxBOVIbyco4
         /UBg==
X-Gm-Message-State: ANoB5pkOk5Vfg4vvx7yG12YBy3vJCQNlGdryp/dXnO3LM3nyZzaq54rs
        taqnh1GAeksgKnJ8Vtledzc=
X-Google-Smtp-Source: AA0mqf51RVBQc7wmpL8OoV6vZdamJHyc0t8rqZS0rTd8aQnjcCwTqK4oVq23xXnAOrZsZhTJbl8WDA==
X-Received: by 2002:a2e:a90c:0:b0:278:a7de:54e6 with SMTP id j12-20020a2ea90c000000b00278a7de54e6mr1043922ljq.367.1668690701073;
        Thu, 17 Nov 2022 05:11:41 -0800 (PST)
Received: from pc636 (host-90-235-25-77.mobileonline.telia.com. [90.235.25.77])
        by smtp.gmail.com with ESMTPSA id o19-20020a05651205d300b0049876c1bb24sm140444lfo.225.2022.11.17.05.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 05:11:40 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 17 Nov 2022 14:11:38 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y3YzCi9exKhiAAd0@pc636>
References: <Y3YwDuKibmOiz6/7@pc636>
 <1AF9A4B1-A9E2-4461-99E0-4CEC2E3AFA1F@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1AF9A4B1-A9E2-4461-99E0-4CEC2E3AFA1F@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 08:06:21AM -0500, Joel Fernandes wrote:
> 
> 
> > On Nov 17, 2022, at 7:58 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > ﻿On Wed, Nov 16, 2022 at 10:05:46PM +0000, Joel Fernandes wrote:
> >>> On Wed, Nov 16, 2022 at 7:19 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >>> 
> >>> Hello, Paul, Joel.
> >>> 
> >>>>> 
> >>>>> Yes sure, I am doing a run now with my patch. However, I have a
> >>>>> question -- why do you feel blocking in the kworker is not an issue?
> >>>>> You are taking a snapshot before queuing the normal kwork and then
> >>>>> reading the snapshot when the normal kwork runs. Considering it is a
> >>>>> high priority queue, the delay between when you are taking the
> >>>>> snapshot, and reading it is likely small so there is a bigger chance
> >>>>> of blocking in cond_synchronize_rcu(). Did I miss something?
> >>>>> 
> >>>> We can wait indeed in the reclaim worker. But the worker does not do any
> >>>> nasty or extra work here. If there is a need we block and wait. After a
> >>>> grace period, we are awoken and proceed.
> >>>> 
> >>>> Therefore i do not see the reason in handling two cases:
> >>>> 
> >>>> if (gp_done)
> >>>>    queue_work();
> >>>> else
> >>>>    queue_rcu_work();
> >>>> 
> >>>> it is the same if we just queue the work and check on entry. The current
> >>>> scenario is: queue the work after a grace period. This is the difference.
> >>>> 
> >>>> Right if the reclaimer was a high prio kthread a time would be shorter.
> >>>> 
> >>>> In your scenario the time seems even shorter(i have not checked) because
> >>>> you update a snapshot of krcp each time a kvfree_rcu() is invoked. So
> >>>> basically even though you have objects whose grace period is passed you
> >>>> do not separate it anyhow. Because you update the:
> >>>> 
> >>>> krcp->gp_snap = get_state_synchronize_rcu();
> >>>> 
> >>>> too often.
> >>>> 
> >>> Once upon a time we discussed that it is worth to keep track of GP
> >>> per-a-page in order to reduce a memory footprint. Below patch addresses
> >>> it:
> >> 
> >> In the patch below, it appears you are tracking the GP per krwp, and
> >> not per page. But I could be missing something - could you split it
> >> into separate patches for easier review?
> >> 
> > I will split. I was thinking about it. The GP is tracked per-a-page. As for
> > krwp it is only for channel_3. Everything goes there if no-page or no cache.
> > 
> Ah, ok.
> 
> >> 
> >> Also it still does cond_synchronize_rcu() :-(
> >> 
> > Sometimes we need to wait for a GP we can not just release :)
> 
> You know that is not what I meant ;) I was concerned about the blocking.
> 
Let me split. After that we/you can test and check if there is any issue
with sleeping on entry for waiting a GP if needed.

--
Uladzislau Rezki
