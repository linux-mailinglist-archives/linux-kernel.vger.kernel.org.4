Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C333F6664D7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 21:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbjAKU3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 15:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbjAKU2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 15:28:15 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5387312ACA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 12:27:17 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 632623C0F4C;
        Wed, 11 Jan 2023 20:18:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a292.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D4E573C11B1;
        Wed, 11 Jan 2023 20:18:52 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1673468333; a=rsa-sha256;
        cv=none;
        b=o1bQ0SlWXjhpUMKJqMY++h4yREFBaCy0k2PvwXuAG4DrW1ePtRtSfUHKgUVtCEi7WmtBm1
        K8LJstY7q4J9lkTMSkrlDtFxz2URtHnCMulJzWyHywRklCbvHwq3l7cB1v9Us1lk9knA6O
        j5DXed8U13miKm/nBWvuG4L/DdedVLuIzyfm/vDZ5MpNEfhCMxa2yYfOHrNwDZ0LiS/5pX
        oDxplhKMvj7qd5oNlYmzaZbgZazs1md5VqHFAbmttlIaf9ci7IYNjmjHh2XrnONnRyKMV2
        uCWagx6IWpE2LoeEHzSiL10ss5NmpmrpjEaea/sZqd0SCHkhQ4IOSh+eM2j8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1673468333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=wS+GmrFpvGE25kGRXu4cr712LGdTZyedIO8N8BIAZig=;
        b=H2ZwOVFAek61HzxEZRCNoRGEE3TpYPeKeGa0IA69wusZLobsCkJ1AtQ2+tjkJaDhAi7zOo
        LbSf+vFGJSg1k2GwlqgIHTbJDKFNdbt3AlJL1RFo8DYO2uz0/m+/08aPY77Y31m4S0qBbv
        4MCfRc3iYiP6cfvakD8UwW3PCyMR12fN1G/aCltT8A1awF0+n6eu1tdNAm28zBPNix02sY
        bnGimyZGhYs7QXBFFFFPuoXli3Yfw01sYBSFWLImeOP0gE+YIO9KnidAWfWuYBRvhvGQfu
        xURvDIuIDDDbmcNXzJg9wbar6skAsdpq6EcPZcolQ58aC/D5UW79rzGR0JAZug==
ARC-Authentication-Results: i=1;
        rspamd-6f569fcb69-64672;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Reign: 1875abcc38b9467a_1673468333974_2650156361
X-MC-Loop-Signature: 1673468333974:760517353
X-MC-Ingress-Time: 1673468333974
Received: from pdx1-sub0-mail-a292.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.229.59 (trex/6.7.1);
        Wed, 11 Jan 2023 20:18:53 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a292.dreamhost.com (Postfix) with ESMTPSA id 4NsfCD1FpdzBR;
        Wed, 11 Jan 2023 12:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1673468331;
        bh=wS+GmrFpvGE25kGRXu4cr712LGdTZyedIO8N8BIAZig=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=TaLEus5Kxs4Xgc7EFqEAlAtzzYTJ5Ns/cPdthJRVyguJMTXO22OiW4rUNoNV+jYft
         MP/2MMYkp0ThoDJyLDqGUOnh0yCFasMO62DOBsGuNoJGZ5IrSxev/cRsPVvLbzqObC
         dgPbP3psGAjHX83NlTwPhHUjOImqFGW22izEgF06mr4IzxI9GVmAEjwi+ATAQMbJGa
         VoHJUBiUAd6BgFmPomIsoyyiDr9nV6YhCh1M2ftpXxiLnB4oB+VfaNNTtSVJWPqhoN
         x3RU+K3bNgNwCDLw3fSHcMpIaP/lxT1tXjlql6EzObb+ULQjwk/xfdmcwEFX2Dbbbn
         WfXRzd2RzPlaw==
Date:   Wed, 11 Jan 2023 11:52:50 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 13/41] mm: introduce vma->vm_flags modifier functions
Message-ID: <20230111195250.cj27sg4yoslbdjdp@offworld>
Mail-Followup-To: Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-14-surenb@google.com>
 <20230111154726.stadwtzicabwh5u5@offworld>
 <CAJuCfpFmO310qoFJr2EKHRavLx87k6tVkHO3-JCE0s4q5g+TCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJuCfpFmO310qoFJr2EKHRavLx87k6tVkHO3-JCE0s4q5g+TCw@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2023, Suren Baghdasaryan wrote:

>On Wed, Jan 11, 2023 at 8:13 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>>
>> On Mon, 09 Jan 2023, Suren Baghdasaryan wrote:
>>
>> >To keep vma locking correctness when vm_flags are modified, add modifier
>> >functions to be used whenever flags are updated.
>>
>> How about moving this patch and the ones that follow out of this series,
>> into a preliminary patchset? It would reduce the amount of noise in the
>> per-vma lock changes, which would then only be adding the needed
>> vma_write_lock()ing.
>
>How about moving those prerequisite patches to the beginning of the
>patchset (before maple_tree RCU changes)? I feel like they do belong
>in the patchset because as a standalone patchset it would be unclear
>why I'm adding all these accessor functions and introducing this
>churn. Would that be acceptable?

imo the abstraction of vm_flags handling is worth being standalone and is
easier to be picked up before a more complex locking scheme change. But
either way, it's up to you.

Thanks,
Davidlohr
