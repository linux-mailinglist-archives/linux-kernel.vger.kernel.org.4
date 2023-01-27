Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4667667ED11
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjA0SMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjA0SMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:12:30 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CE91ADDE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:12:29 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 51AA7140B4F;
        Fri, 27 Jan 2023 18:12:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a215.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DAFD81418BF;
        Fri, 27 Jan 2023 18:12:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674843148; a=rsa-sha256;
        cv=none;
        b=8gZAzNhiY910f4xRltxYtaoXOXMwHRoC42Z3yBFi9La4R5jiiKxSZByeaz7GX6QT4UZyZ9
        hTBmJzgoxHTam2zim9I5IckCVSleJJcwssq7PPYGjI22xI6tNj8klWI0e/JZgNmH0IMYg3
        +qHViyzJJfnkKL2YvOOuNKp6l1BWgPN6jAPXQg/1/jaFFoprwSECxxsVEjrllSEn+Nu69h
        aBd+3TiFCO4thbgTo7nhH++DpnjRElj21RbuglqT/KX6HkGs8deHCykbaXGD1l7MO2TiPY
        hzDUxHP8K7wtZ7Rs04lqsQxpFEg876u2TSEGJNMQ2sVn2nD9jEefxRxQfsWSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674843148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=AFPAQrpTa6JQv90tZx2cVE3JvvG6vY0G/Jb1Gz+6tWw=;
        b=O02PU6dv984pHWXFsjmM+jzulO8KVIeZqcPBsmbpNzbp58bz5sTH4TLgJ395b4db1K4glH
        PNzxBM/4bDYTLaHUA+bT/m5lUHemJxoUJc+dSBdw/t9R+t33SbS3vzOC8OBlhwLEZ1IkCV
        XaAX9hmkTRrEhivqwt203HCJs/eLqwaGIpJIXb0kVvnY+OPlNdY3KfM9JPDK9qSvH3GWov
        iL+Ew5cQznNQx8yGqiruPl76Or9XsLWMbcXU4ArpKFSDf+S55e9oeLT69a7xmpkNIkM9WJ
        v2JZ+oerCm9Wfbc4tn9p/crPH16WMSdM/19woLyjLplNZSNQMZGKNHLhfK+Y6w==
ARC-Authentication-Results: i=1;
        rspamd-544f66f495-wxdrn;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Relation-Daffy: 020a35f967655b8b_1674843148840_886956793
X-MC-Loop-Signature: 1674843148840:7612868
X-MC-Ingress-Time: 1674843148840
Received: from pdx1-sub0-mail-a215.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.83 (trex/6.7.1);
        Fri, 27 Jan 2023 18:12:28 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a215.dreamhost.com (Postfix) with ESMTPSA id 4P3Qf00Vj7z95;
        Fri, 27 Jan 2023 10:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1674843147;
        bh=AFPAQrpTa6JQv90tZx2cVE3JvvG6vY0G/Jb1Gz+6tWw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=JIDFKbwUDw0JZ3SbrpB/Bj4GbFEpmvP6tr1C3RSKUPhp73vxhg4Grmp8npGv1MdUu
         fKSGECsi57IjiXo5Wkl6SDhd2OGhJgE1CXQbNjgo/YsxzFZ6KkZS6khj0tqTtaCWxX
         RBmLEBlN7Jm3H6SCAQb+5sh1Hd1UlaapKft3DzcVH+SuqpZGU71b6NEt/RVlzCXXIp
         29+9+f5sWbofBI0N/otn9+yak3RFmUhOpOTT2tLo9PdLOhZ9xqCEJn5MJuRcmM20vL
         KT/9Nes1IeXPlQeTSSJyvq/gCCjkUw9T7OpCcLsxOS2OVRLzesjsxKz66+aKM8NNAv
         /pHd0aOp7eX5w==
Date:   Fri, 27 Jan 2023 09:45:30 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 3/7] mm: replace VM_LOCKED_CLEAR_MASK with
 VM_LOCKED_MASK
Message-ID: <20230127174530.sws4xg3qjsx3agh4@offworld>
Mail-Followup-To: Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20230126193752.297968-1-surenb@google.com>
 <20230126193752.297968-4-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230126193752.297968-4-surenb@google.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023, Suren Baghdasaryan wrote:

>To simplify the usage of VM_LOCKED_CLEAR_MASK in vm_flags_clear(),
>replace it with VM_LOCKED_MASK bitmask and convert all users.

Might be good to mention explicitly no change in semantics, but
otherwise lgtm

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
