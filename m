Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C552D6A8A01
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCBUHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCBUHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:07:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EA23B66E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 12:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677787592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LulnG+Y3EN4uHVj7EFNNPoUgBx7UJRXf/9ipLLQ176Y=;
        b=TFLGxl1/va07qUOgd0cm4X7s7RVXRP1ybb0JU+IEqmm4SjNm+5Td00hFEWR3pjknNr6tQ7
        uNJlEaRwfxEMEMCttOpblyKzkphpZkI8KbYM2bkhwNfqmKbNjMmw9jNv1A/vY/29H2NeYj
        FAQZhdZ6c/v3sbxF/UQYxhDgsGjsjwk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-nP8nY7kyNmmjr0DqMz5cHQ-1; Thu, 02 Mar 2023 15:06:31 -0500
X-MC-Unique: nP8nY7kyNmmjr0DqMz5cHQ-1
Received: by mail-qk1-f199.google.com with SMTP id eb13-20020a05620a480d00b00742be8a1a17so66164qkb.18
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 12:06:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677787591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LulnG+Y3EN4uHVj7EFNNPoUgBx7UJRXf/9ipLLQ176Y=;
        b=0HqhagVvAbHhf1HyvDPE78HgiHDNKfZgiEnVm70x2laK4zF6aHyPNv9yixtVtvnNyC
         +oBhvFZ/3F4dthCat+Ui/l0rt+z1XterdEZGQ41KCR+cyAx4ZwT0zIY+3Vd1d8olcz6S
         SXYc70zVLa/uxst2SuFn592k5GAsPKbmFD0JxcoNqhpGR41n4x72HVJfnkyCCu+M1Ip6
         uVpo09sIJDN4DoQsnbaSlGvFUBhfecbDJ9cKrqUiMI5Pu9NoxHWlkRHZ7AxAGtxK/gKZ
         JiCmvdMfgTCd4iw8YtWphM2NMj/QfI8qYvOtJQptDMolJoKOrAIq/O/iZh+5DWecAciI
         lidA==
X-Gm-Message-State: AO0yUKU3y+fHUirttQAs4NDZifTX2uOTgMq+EIlp1aqYFw0kYCBi0xfh
        5bOBxbdPjpoVdWyv9xYL1Q1c6QR8FQHHP18OCDJZ/fM4UoY5O2+fezWKAwmF1BcFji97nwnmhOW
        F4CEaNWuVrKq0tiPdqCYMLmnI
X-Received: by 2002:ac8:5c86:0:b0:3bf:b0c6:497b with SMTP id r6-20020ac85c86000000b003bfb0c6497bmr21941573qta.2.1677787590787;
        Thu, 02 Mar 2023 12:06:30 -0800 (PST)
X-Google-Smtp-Source: AK7set8mMLe+MEoLiLTnvmOFG32KInqu0sERXBXOI4Jk329xSItvmIZxz1MoHmqJD4M2cPOTgPyOAg==
X-Received: by 2002:ac8:5c86:0:b0:3bf:b0c6:497b with SMTP id r6-20020ac85c86000000b003bfb0c6497bmr21941541qta.2.1677787590504;
        Thu, 02 Mar 2023 12:06:30 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id h22-20020ac87776000000b003b9a73cd120sm352020qtu.17.2023.03.02.12.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 12:06:29 -0800 (PST)
Date:   Thu, 2 Mar 2023 15:06:28 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 08/11] mm/vmstat: switch counter modification to
 cmpxchg
Message-ID: <ZAEBxFt9+RJIwldf@x1n>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.846239718@redhat.com>
 <3331790c-95a1-6ab9-2667-86aae3d28d7d@redhat.com>
 <ZAC3BxPIxAplvTzT@tpad>
 <ZADM4U49g+g4S5Xf@x1n>
 <ZAD05KayfUwZQ4Vh@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAD05KayfUwZQ4Vh@tpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 04:11:32PM -0300, Marcelo Tosatti wrote:
> On Thu, Mar 02, 2023 at 11:20:49AM -0500, Peter Xu wrote:
> > On Thu, Mar 02, 2023 at 11:47:35AM -0300, Marcelo Tosatti wrote:
> > > So it will be:
> > > 
> > > #ifdef CONFIG_HAVE_CMPXCHG_LOCAL
> > > mod_zone_page_state
> > > inc_zone_page_state
> > > dec_zone_page_state
> > > mod_node_page_state
> > > inc_node_page_state
> > > dec_node_page_state
> > > __mod_zone_page_state (new function, calls mod_zone_page_state).
> > > __mod_node_page_state (new function, calls mod_node_page_state).
> > > __inc_zone_page_state
> > > __inc_node_page_state
> > > __dec_zone_page_state
> > > __dec_node_page_state
> > > #else
> > > __mod_zone_page_state (old, shared function for both CONFIG_HAVE_CMPXCHG_LOCAL and not)
> > > __mod_node_page_state
> > > __inc_zone_page_state
> > > __inc_node_page_state
> > > __dec_zone_page_state
> > > __dec_node_page_state
> > > mod_zone_page_state
> > > inc_zone_page_state
> > > dec_zone_page_state
> > > mod_node_page_state
> > > inc_node_page_state
> > > dec_node_page_state
> > > #endif
> > > 
> > > Any suggestion on how to split this into multiple patchsets for easier
> > > reviewing? (can't think of anything obvious).
> > 
> > I figured this out before saw this, but it did take me some time to read
> > carefully into the code base..  maybe it'll be a good idea to mention
> > something like above in the commit message to ease future reviewers (and
> > more likelyhood to attract the experts to start chim in)?
> > 
> > One fundamental (but maybe another naive.. :) question on this code piece
> > (so not directly related to the changeset but maybe it is still..):
> > 
> > AFAICT CONFIG_HAVE_CMPXCHG_LOCAL only means we can do cmpxchg() without
> > locking memory bus, 
> 
> CONFIG_HAVE_CMPXCHG_LOCAL means cmpxchg_local is implemented (that is
> cmpxchg which is atomic with respect to local CPU).
> 
> LOCK cmpxchg is necessary for cmpxchg to be atomic on SMP.
> 
> > however when !CONFIG_HAVE_CMPXCHG_LOCAL here we're not
> > using non-local version but using preempt_disable_nested() to make sure the
> > read is atomic.  Does it really worth it?  What happens if we use cmpxchg()
> > unconditionally, but just use local (e.g. no "LOCK" prefix) version when
> > CONFIG_HAVE_CMPXCHG_LOCAL?
> 
> Can't use local version of cmpxchg because the vmstat counters are supposed
> to be accessed from different CPUs simultaneously (this is the objective
> of the patchset):
> 
> CPU-0					CPU-1
> 
> vmstat_shepherd				mod_zone_page_state
> xchg location				LOCK cmpxchg location
> 
> xchg locks memory bus implicitly.
> 
> Is this what you are thinking about or did i misunderstood what you
> mean?

Yes, I think I wrongly interpreted cmpxchg_local() before on assuming it's
still atomic but an accelerated version of cmpxchg() that was only
supported on a few archs.  I double checked the code and spec on x86 - I
believe you're right.  Thanks,

-- 
Peter Xu

