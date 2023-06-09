Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D98472A4F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjFIUqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFIUqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD422D7C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686343549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GbEnFkNYtI0z938R0OlkBZpeluMi+fi777FIp4HyK+I=;
        b=gRisSJufAP5fH2SbmCVPQJmXkciZ3gGbUMM0QH2vUT6itmeTq2M/LwI91CY2WFRyMOboRE
        xDTkt320wMbrT1C9+Vo4li0G8/D05Ap7NrmStYqg+EVzfZ/ad4PZJsHtaX4JFKxc0vJ3+U
        7ISIGDUJhAjdhKNCmtXv4K1pzVSInxU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-BP4w_zHUOeCjPNHBgkouew-1; Fri, 09 Jun 2023 16:45:47 -0400
X-MC-Unique: BP4w_zHUOeCjPNHBgkouew-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62632620f00so4465556d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686343547; x=1688935547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbEnFkNYtI0z938R0OlkBZpeluMi+fi777FIp4HyK+I=;
        b=Ze0S9UeMFeM1qApe7XrEPCVcYrIlFfUFjIzZ/NxJxsY2YkURxZtWIonC76FKOwEuOA
         rObp9Rw0taUsd5ymmaM1Nt0vy1UlQq8p4Qhnu+oQZ6LDnK7stVYo4dL1Xv9q230/6mn8
         KshJ2J9V7OMjofObJXW0m/jup/8ZaPAfIFTWUie1YIS2DhFP2AM5+OefVI1iCBn6XVkx
         gICIBwz2K3aSosauxjPkozeRyuPqvtvnEdzYU5EyXqENUAmwozwzm8BQg9hSVON3ZtEe
         71thbJ7hvt+0jOlyiWhp5rFA8O17Qq7Qxz6HAqBbttRoy1xWTpguUndszrMLVxlx7iWC
         eJEA==
X-Gm-Message-State: AC+VfDxqnt2EdoP2cR9aKJlnAPa0Q38TGxVeR2MAxkXYh9aw3oRdHd47
        3xf3UyUfDshWx9q94nu/GlYwvsHMQlKon9Me4hi7xHJnz1/ldVQLtNCahvUhYiaeFkNaBEEaTIP
        ejEJhGIciv+BRYv6Wv+VpDfOy
X-Received: by 2002:a05:6214:c26:b0:626:273e:c35c with SMTP id a6-20020a0562140c2600b00626273ec35cmr2971534qvd.2.1686343547500;
        Fri, 09 Jun 2023 13:45:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73wMpKERL5tHQE5JOMuDd0XS9mBmSdVoVR6mu9g3yyZRrTrmxjQ9Tky2ZwEUMWRCYufmp2gA==
X-Received: by 2002:a05:6214:c26:b0:626:273e:c35c with SMTP id a6-20020a0562140c2600b00626273ec35cmr2971514qvd.2.1686343547267;
        Fri, 09 Jun 2023 13:45:47 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id mg9-20020a056214560900b006260e4b6de9sm1381429qvb.118.2023.06.09.13.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:45:46 -0700 (PDT)
Date:   Fri, 9 Jun 2023 16:45:44 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 2/6] mm: handle swap page faults under VMA lock if
 page is uncontended
Message-ID: <ZIOPeNAy7viKNU5Z@x1n>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-3-surenb@google.com>
 <ZIOKxoTlRzWQtQQR@x1n>
 <ZIONJQGuhYiDnFdg@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIONJQGuhYiDnFdg@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 09:35:49PM +0100, Matthew Wilcox wrote:
> On Fri, Jun 09, 2023 at 04:25:42PM -0400, Peter Xu wrote:
> > >  bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
> > >  			 unsigned int flags)
> > >  {
> > > +	/* Can't do this if not holding mmap_lock */
> > > +	if (flags & FAULT_FLAG_VMA_LOCK)
> > > +		return false;
> > 
> > If here what we need is the page lock, can we just conditionally release
> > either mmap lock or vma lock depending on FAULT_FLAG_VMA_LOCK?
> 
> See patch 5 ...

Just reaching.. :)

Why not in one shot, then?

-- 
Peter Xu

