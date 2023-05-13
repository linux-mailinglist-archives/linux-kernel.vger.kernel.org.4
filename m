Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D96A7019B5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 22:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjEMUnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 16:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEMUny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 16:43:54 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56ED2D48
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 13:43:52 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 73B7B140F81;
        Sat, 13 May 2023 20:43:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a232.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A4C08140CA3;
        Sat, 13 May 2023 20:43:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684010629; a=rsa-sha256;
        cv=none;
        b=QL5Z2Z4wjD1xaUH0hQmtyC2XzZpoopSmey7O1QaTpfAY9BUzSIaqnMxGPplv4wr68WGmuo
        AWgGARgwqAc+/o3q4bgbqy2k/FX14GpcoYbnQb4SKmcbTLYr33qtnVEzQRmixBCRjMY+9e
        YeJGYpVhA9L2YtuGZ2mzY0zMBJPnDu+JlQ8vT5GDRSxG40lbn1fiT6rHev55zXUMj8CToZ
        6RVsyE0p/V6E6X1A2R5uEYRK6eFrvMX4r1CdVqxmsWJgueJPk4oLCr6okPMffsbkKUnVfm
        8GHnsDx2movNM0DEuBFAYy5wBcf7abV/YRQzcPaP8KR48oNI+mrZk9L1A7Q3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684010629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ehonwRQjo3E8b31rGbigHFuhtd753Uy5ZgwZqWj0E64=;
        b=aKERXreeEIMFfn5eICwhgUQ3LwAQforBugm8cIukxcepr14D0dbOuh51fYd8fnFwlGeuWf
        sEPmblsdPQGZxZaOUQpdyJXcuSUadvKJ415iVgHz8J3nhSLhAnBdjX3kVJEFiMDjrPHm3l
        cOkplcvRu3D8ECnbB4tdnHx1DnRQg2YP54g5Or6D56Dwo+5b/PCkLGSJn9zP2s+tbzadNn
        I8Xt8zgHPISFTkUbtMNOcgG+OgxH6yOwt6xee1XKp4RKJudoYw+zBM1S0VS4k1bfbJ+R2r
        oHUq0fCn7C+R3bGCwknMU/rIjzcEv60aoJCOK25O59e0iZUwchXL+LAjEto0Og==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-fw8rh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reaction-Eight: 274e905d7af27014_1684010630236_2430788493
X-MC-Loop-Signature: 1684010630236:4012024979
X-MC-Ingress-Time: 1684010630236
Received: from pdx1-sub0-mail-a232.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.61 (trex/6.8.1);
        Sat, 13 May 2023 20:43:50 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a232.dreamhost.com (Postfix) with ESMTPSA id 4QJczm6Q6Gz30;
        Sat, 13 May 2023 13:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684010629;
        bh=ehonwRQjo3E8b31rGbigHFuhtd753Uy5ZgwZqWj0E64=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=XFjqC33YUbOOBqR7qMq7te0o24fAFLDk4JyP8NZf5wSN6fDijoI8lYte2LgAqTtsm
         ORmfxbJ7H9H9o4697eYugNgd5kTGXlsUNxKh3wLhBXfZ38aFrS74aQsIpQZJ0zAm2h
         WzEird8Jw23f2537sXsQrrJ3gXNR1xNOKo0MmoHfbcUBeTSnVj/tF6v2AZnouqxBy9
         9zfB7HRBfiV+4i/FgAgjAZdbTeg6SauPLQlruKJFg2XfeXweBiEWntQ4K4Z430Rrht
         /BOWSJmTmUo3SENfyvsZ4e5KtZ2vjJmDeDkDNCn4TAmk5TTGqzBEXPBDZGlmDCXKZF
         Ax0tmpET39d0A==
Date:   Sat, 13 May 2023 13:10:56 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        =?utf-8?B?QW5kcsOvwr/CvQ==?= Almeida <andrealmeid@igalia.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        linux-mm@kvack.org
Subject: Re: Futexes & Folios
Message-ID: <4b5rvoi6w6nhiihmog6xjftoveohd47oooodekqedo5qhflmrt@jemw5ss5xps3>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>, 
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
        Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
        =?utf-8?B?QW5kcsOvwr/CvQ==?= Almeida <andrealmeid@igalia.com>, linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, 
        linux-mm@kvack.org
References: <ZF+3xpmouwur4sVE@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZF+3xpmouwur4sVE@casper.infradead.org>
User-Agent: NeoMutt/20230407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 May 2023, Matthew Wilcox wrote:

>Here's a patch which converts the futex code from using pages to using
>folios.  I do have some questions.
>
> - I assume we really do want to base the key on the page offset of the
>   futex in the file.  That is, it's not good enough to base the key
>   on the folio's index because the folio can be split after setting up
>   the key, and if it is we'd then fail to find the futex later.
> - In hugetlbfs, it doesn't matter whether the pgoff is based on base
>   pages or huge page size -- as long as it's consistent between
>   invocations, everything will work

As tglx already mentioned, yes to both.

>(I have ideas about a get_user_folio() but those are not represented in
>this patch)

Btw, regarding some of the concerns about the gup overhead for futexes
in the physr discussion at lsfmm; 'perf bench futex hash' would be a good
way of measuring any impact at a micro level and going from there. This
is only necessary of course for shared futexes, fast/private ones just
use the address space.

Thanks,
Davidlohr
