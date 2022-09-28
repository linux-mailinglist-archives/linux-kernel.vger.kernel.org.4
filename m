Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF89D5EE873
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiI1Vje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiI1Vjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912D895E64
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664401169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZVwlHkJX+CA2MdLV8ui7Hgvltct3SaTb4zc3R8SWOA=;
        b=MqkAme/WGsgfeDaId7tK+zq+4X7wLDj7XtBjIjX2Qo1QxWgB/638CbNsfghdmSVBgJ8Omg
        jdrus9osXQUjUapqr2vxo0Xkoct7TnFSys49SNfnWLRCmiuikhp8fQTBR8LpkJ7ZmnQy1p
        k050ePzl1Rf0JnJaqSqqjrdxy6KsWCA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-5-ynTss5VzPs2ArrlKWT_2vg-1; Wed, 28 Sep 2022 17:39:20 -0400
X-MC-Unique: ynTss5VzPs2ArrlKWT_2vg-1
Received: by mail-qt1-f197.google.com with SMTP id fv21-20020a05622a4a1500b0035cc9b4fc20so9767227qtb.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lZVwlHkJX+CA2MdLV8ui7Hgvltct3SaTb4zc3R8SWOA=;
        b=1dk0r+jWeHLM/+cGCD5ONWSMx2bOC6rQMnuOPPoJgbDyRQuHFMAD0wfy5ky0tEWcEy
         c5/g7qNI3Ua+PRwpOby5y9A4TNXT25cGPB1tAsxJ4qcCZx/iogX57lIDTR6UuI5BfW3H
         7PoSMLuE1pwMEpYku9i/7dCI2k9knDRWk0B7eTVqvj/m4M8jsX3bpOXzgB8skdCFMTLz
         O2xXTLHPVN9xSNkokGjXff1gkWBv76Zpql8mf8Nh+GZWssmtoqUZCvq7jVgf0iwXsW2P
         eCdkNVsmCLnVgRiXmMDqZaw7ijG4hYIpwZ/SDdKUugvoz2fTKgzTGLPRkCmCsiGJjx3t
         DsFg==
X-Gm-Message-State: ACrzQf3EvAKmB36/4YT5+RTiSjzzeZBSfrtVZdrf4SZxyJ6DH1OYTAnd
        Wzri+1Lma7zR/ie6hM43LYqPA2Wsp2xaoLlUZgr1+V4gtZPVd4xdP/A6d3SW/cQyS1eB7O9OOJ1
        V+TIxvRlcj5GtUSiaPEAFlhlo
X-Received: by 2002:ac8:5d8b:0:b0:35b:b035:9573 with SMTP id d11-20020ac85d8b000000b0035bb0359573mr28229967qtx.632.1664401160167;
        Wed, 28 Sep 2022 14:39:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6+NTBF2OvbAgxteoflWFSd6erD1BpZf1mrqbddCj+mgL2acOrz19fID/cOV8yI3Qia+7pfGg==
X-Received: by 2002:ac8:5d8b:0:b0:35b:b035:9573 with SMTP id d11-20020ac85d8b000000b0035bb0359573mr28229957qtx.632.1664401159952;
        Wed, 28 Sep 2022 14:39:19 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c48:e00::feb? ([2600:4040:5c48:e00::feb])
        by smtp.gmail.com with ESMTPSA id bs13-20020a05620a470d00b006a6ebde4799sm3987020qkb.90.2022.09.28.14.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:39:18 -0700 (PDT)
Message-ID: <139a402b4f9a09a4e89b0c0b0e556014ae7a8b83.camel@redhat.com>
Subject: Re: [PATCH 6/7] nouveau/dmem: Evict device private memory during
 release
From:   Lyude Paul <lyude@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alex Sierra <alex.sierra@amd.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Jason Gunthorpe <jgg@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 28 Sep 2022 17:39:17 -0400
In-Reply-To: <87k05plm9j.fsf@nvdebian.thelocal>
References: <cover.f15b25597fc3afd45b144df863eeca3b2c13f9f4.1664171943.git-series.apopple@nvidia.com>
         <072e1ce590fe101a4cdbd5e91b1702efebb6d0fd.1664171943.git-series.apopple@nvidia.com>
         <881735bda9b1ba0ecf3648af201840233508f206.camel@redhat.com>
         <6ff9dcc5-c34b-963f-f5e7-7038eecae98b@nvidia.com>
         <87k05plm9j.fsf@nvdebian.thelocal>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re comments about infinite retry: gotcha, makes sense to me.

On Tue, 2022-09-27 at 09:45 +1000, Alistair Popple wrote:
> John Hubbard <jhubbard@nvidia.com> writes:
> 
> > On 9/26/22 14:35, Lyude Paul wrote:
> > > > +	for (i = 0; i < npages; i++) {
> > > > +		if (src_pfns[i] & MIGRATE_PFN_MIGRATE) {
> > > > +			struct page *dpage;
> > > > +
> > > > +			/*
> > > > +			 * _GFP_NOFAIL because the GPU is going away and there
> > > > +			 * is nothing sensible we can do if we can't copy the
> > > > +			 * data back.
> > > > +			 */
> > > 
> > > You'll have to excuse me for a moment since this area of nouveau isn't one of
> > > my strongpoints, but are we sure about this? IIRC __GFP_NOFAIL means infinite
> > > retry, in the case of a GPU hotplug event I would assume we would rather just
> > > stop trying to migrate things to the GPU and just drop the data instead of
> > > hanging on infinite retries.
> > > 
> 
> No problem, thanks for taking a look!
> 
> > Hi Lyude!
> > 
> > Actually, I really think it's better in this case to keep trying
> > (presumably not necessarily infinitely, but only until memory becomes
> > available), rather than failing out and corrupting data.
> > 
> > That's because I'm not sure it's completely clear that this memory is
> > discardable. And at some point, we're going to make this all work with
> > file-backed memory, which will *definitely* not be discardable--I
> > realize that we're not there yet, of course.
> > 
> > But here, it's reasonable to commit to just retrying indefinitely,
> > really. Memory should eventually show up. And if it doesn't, then
> > restarting the machine is better than corrupting data, generally.
> 
> The memory is definitely not discardable here if the migration failed
> because that implies it is still mapped into some userspace process.
> 
> We could avoid restarting the machine by doing something similar to what
> happens during memory failure and killing every process that maps the
> page(s). But overall I think it's better to retry until memory is
> available, because that allows things like reclaim to work and in the
> worst case allows the OOM killer to select an appropriate task to kill.
> It also won't cause data corruption if/when we have file-backed memory.
> 
> > thanks,
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

