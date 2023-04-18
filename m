Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE476E7003
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 01:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjDRXl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 19:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjDRXlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 19:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B797513FAF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 16:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681861092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k5Bn3juE3fDshVkllxAzqw/tWdNFN8bQYVRW3fhsVrE=;
        b=Pl3So5w/l3jw5+YK1DOheSihKpYRsMguR7QtyyL2UrZWMfZWgW1euykZlhrb3DJpjjQpGJ
        W6oJTswNZvdVa1V9CPE7veWDQaA3ueyU/p4aNFetW5/xT5t92tGg0ixEjA4Ps7xJFVFEOI
        3PXtvBNMxDQblYW/qzKLqTQXDaw6H4s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-Y-UfINMINFOJPfmCztTQog-1; Tue, 18 Apr 2023 19:38:10 -0400
X-MC-Unique: Y-UfINMINFOJPfmCztTQog-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3ef2cb3bfbfso7795761cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 16:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681861090; x=1684453090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5Bn3juE3fDshVkllxAzqw/tWdNFN8bQYVRW3fhsVrE=;
        b=Cm4xMa62zcMFJDQ6V1dkT2oKnTpy98D2nYJyBsm/IvwVb9DBptRPNpvuCkV5JR0XTk
         p5QHSDKRvw7t10QGmAvy4aDaADJPFE0xtBAAHsqKIP1yQ9ZtKuIRrTshmY3UV3eVA9Jv
         Zld/Fk8Pnw+DMNoFShS5Q0v2nNF4WJnA0kLR25khLTL8IwRCkS8m+ndNSlQoPyX++TK6
         P1rAxI4Zgtv8HYeM33qya5uOCz5QnUK3Sml8C6JMO8AJynTjGUEa9iqwRUKAE3RWiBSA
         7Xs7lnQ73qw42KT86yBkeXWph2W/Xfa/lM0mzOhvBaElDrUtwgPLEGJIKEHgKy+OwVnJ
         RFpA==
X-Gm-Message-State: AAQBX9ct01bAR3fc4MANdGcrm+p8TKK+z61Cadc4xjN+XQnGL4U/15m5
        CI0DYUOn2gNwio4iUrwv+IvA0MLYSK1/nEUUAU09PhLpEhigx8yz+HlY5KvjOwVcIti5Qzgnk56
        acCHP4j8ssf9Sg4sxYd2HAx5e
X-Received: by 2002:ac8:5a84:0:b0:3ef:1642:c123 with SMTP id c4-20020ac85a84000000b003ef1642c123mr14027846qtc.3.1681861090246;
        Tue, 18 Apr 2023 16:38:10 -0700 (PDT)
X-Google-Smtp-Source: AKy350bFSTC9+a3VzPZ5WT1HHb3h4712B+djlPByCXMkSRVkFwpmThKQ3P3ImCkavSgxNCk609F+OQ==
X-Received: by 2002:ac8:5a84:0:b0:3ef:1642:c123 with SMTP id c4-20020ac85a84000000b003ef1642c123mr14027812qtc.3.1681861089946;
        Tue, 18 Apr 2023 16:38:09 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id de39-20020a05620a372700b0074ad4cc603dsm970121qkb.131.2023.04.18.16.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 16:38:09 -0700 (PDT)
Date:   Tue, 18 Apr 2023 19:38:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/1] mm: do not increment pgfault stats when page
 fault handler retries
Message-ID: <ZD8p3+XyvCiq9RJW@x1n>
References: <ZD3Nk0u+nxOT4snZ@casper.infradead.org>
 <CAJuCfpFPziNK65qpzd5dEYSnoE-94UHAsM-CX080VTTJC5ZZKA@mail.gmail.com>
 <ZD6oVgIi/yY1+t1L@casper.infradead.org>
 <CAJuCfpFJ0owZELS2COukb0rHCOpqNMW-x9vVonkhknReZb=Zsg@mail.gmail.com>
 <ZD6yirD6Ob+1xG32@casper.infradead.org>
 <ZD6/805XpvfZde0Y@x1n>
 <CAJuCfpGZAALQbPFGymJOgkMp2knKoos697L8jd1v2jDyBSbdYA@mail.gmail.com>
 <CAJuCfpFFsKkdnHLSojSo0pP-=nQFiY408tpVDHVy6TpGSv1B9g@mail.gmail.com>
 <ZD8dj3Tk2b1TWVK5@x1n>
 <CAJuCfpFyetOXEMB2+b3LRO9-ESdDTdEyOyfUGsr0FbsWJi1-kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpFyetOXEMB2+b3LRO9-ESdDTdEyOyfUGsr0FbsWJi1-kA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:58:26PM -0700, Suren Baghdasaryan wrote:
> Sure. How about replacing my prior "Register both successful and
> failed faults in PGFAULT counters." comment with "To preserve the
> behavior of older kernels, PGFAULT counters record both successful and
> failed faults, as opposed to perf counters which ignore failed cases"

Looks good here, thanks!

-- 
Peter Xu

