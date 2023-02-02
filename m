Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14C46873E5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjBBDhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBBDhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:37:09 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A947755A0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:37:08 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0684E6C0E45;
        Thu,  2 Feb 2023 03:37:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a221.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 44EE76C14EC;
        Thu,  2 Feb 2023 03:37:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1675309027; a=rsa-sha256;
        cv=none;
        b=64cvW95p7ARtEVAc3phIYYvl2e5uKz3VgmeHAlDglf4dz/gpSj2ZJhV/RjeVVWChTAe4Yo
        X7oqkdpWFpQexYM5P40l3yuq8xNnuhlv/Ux1N0JqfOeYNi1lnhNsP/kpoHLtvRDmTK95f1
        aex5AOvZSsIl2XWkTIqEtCf9LqFee0cixyi5SYJ2JQEzbDFGMTp2qzpDTHZ1MfJxwWC5EE
        hkKFzpSfjeYiEv/63R1aS55CLoGnxh5nQmQQtSuXuCyEj0PqWm8g6/80LgqBJBX082ll+G
        EtMwqUNgmw1GR28I84Lj335bQEyLNUU4EBqt2WUoDJZRFbjswag68sR/bckjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1675309027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=T4S2v7ISuVZquux7kOo2tBD0hwS4H3XCBw+AEhFxwYw=;
        b=qQeCzswClXgnRYCbQrwTTZSOGAju9du1MEFLswOBi6y69Odj/S/RcZDiy2OgiNfunutY8H
        kGKX2Y9dTSOFx+h4LjhawCGua+3w+e6tREzrft5NyMbJiAq8MUqRlNUn0jqS+sWdRS7/bY
        dPkx3qAtHm+yungrFy78wFQEQ+OwfjW1yJqYbRJ90WfRgdfhPpgTYO3PjYnbfMtS1yIMXU
        PjUv51nZ5+YAkdVFEnOhBYGhtXeHwCmsrL9B2cb8KQErZ2s4W033HJ4UXTXCDggSdoC/Yd
        GvMmD4OItJ2hprWgiA1/GPWGXkUjr8cSK3I6WaGWKlz0Eg4gqMPym7wIHbhgeg==
ARC-Authentication-Results: i=1;
        rspamd-544f66f495-zkbxd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Troubled-Squirrel: 50844762513b4277_1675309027801_906380104
X-MC-Loop-Signature: 1675309027801:3635550920
X-MC-Ingress-Time: 1675309027801
Received: from pdx1-sub0-mail-a221.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.83 (trex/6.7.1);
        Thu, 02 Feb 2023 03:37:07 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a221.dreamhost.com (Postfix) with ESMTPSA id 4P6kxF5wCBz6x;
        Wed,  1 Feb 2023 19:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1675309027;
        bh=T4S2v7ISuVZquux7kOo2tBD0hwS4H3XCBw+AEhFxwYw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=CoaG4YtuB2SuPmf0ifRffFmn3ZJn2EAuxuAPZmpNQ/omMd2Kz9EEDe3cvWthCB9V8
         kfGX8Z78C3B1jZenRh3/ZRep+QXmQU7ZymGkwLTozcNrhc1g5tub6K/KJD72fqcjU1
         2MidsB2jYKFLmrwL0iMglMIzT4PVhll/TfNMHKWfd8pfxNYhO2jg3FjbVNnfPdt4Xg
         6fwoj+SkdVlFCgfMZ3UKPkd10WEs+Oe0wybeWshBeZmldxG9mkjddKV13kugTKR8rp
         jvMWDKRozZpJl3T59EEP83nCd4ZRzUjkN4GebUeaku8H39EuCSb8Ho0FtvT02NuprJ
         5De/zc0PyJ2cw==
Date:   Wed, 1 Feb 2023 19:09:55 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable] lib/Kconfig.debug: do not enable
 DEBUG_PREEMPT by default
Message-ID: <20230202030955.nfejzcgn6edp6cgl@offworld>
Mail-Followup-To: Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230121033942.350387-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230121033942.350387-1-42.hyeyoo@gmail.com>
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

On Sat, 21 Jan 2023, Hyeonggon Yoo wrote:

>In workloads where this_cpu operations are frequently performed,
>enabling DEBUG_PREEMPT may result in significant increase in
>runtime overhead due to frequent invocation of
>__this_cpu_preempt_check() function.
>
>This can be demonstrated through benchmarks such as hackbench where this
>configuration results in a 10% reduction in performance, primarily due to
>the added overhead within memcg charging path.
>
>Therefore, do not to enable DEBUG_PREEMPT by default and make users aware
>of its potential impact on performance in some workloads.
>
>hackbench-process-sockets
>		      debug_preempt	 no_debug_preempt
>Amean     1       0.4743 (   0.00%)      0.4295 *   9.45%*
>Amean     4       1.4191 (   0.00%)      1.2650 *  10.86%*
>Amean     7       2.2677 (   0.00%)      2.0094 *  11.39%*
>Amean     12      3.6821 (   0.00%)      3.2115 *  12.78%*
>Amean     21      6.6752 (   0.00%)      5.7956 *  13.18%*
>Amean     30      9.6646 (   0.00%)      8.5197 *  11.85%*
>Amean     48     15.3363 (   0.00%)     13.5559 *  11.61%*
>Amean     79     24.8603 (   0.00%)     22.0597 *  11.27%*
>Amean     96     30.1240 (   0.00%)     26.8073 *  11.01%*
>
>Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Acked-by: Davidlohr Bueso <dave@stgolabs.net>
