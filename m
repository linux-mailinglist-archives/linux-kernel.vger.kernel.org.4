Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F626F8793
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjEER0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjEER0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3F51A4A6
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683307523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g1Bpo+/8mdg0BcQOaDhW+K6AV5WuIljiAVrbRU3WN+E=;
        b=C6sF4I4KvMqHm1dUFlr9evXORfk0jXRc/alOJjzflGwtoO3ByOfvU88w27kKA+9MIjNzsV
        2l0ANPjCOR+hFyZqV7kzQ4wTgVlQtdMx2WhWMj44WRBcAcEbmzFuUDr437nlVCOigLkyzS
        Z8SiKouqolX4Bh5sALZyF+F7BXerFEs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-VByFgS41PSuyq_X4Kgpwjw-1; Fri, 05 May 2023 13:25:22 -0400
X-MC-Unique: VByFgS41PSuyq_X4Kgpwjw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-5eee6742285so23785906d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 10:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683307521; x=1685899521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1Bpo+/8mdg0BcQOaDhW+K6AV5WuIljiAVrbRU3WN+E=;
        b=jpdiZwAaKKmDlzecACctrgKbbwEb9GSjtG7CvpgqcQMART0tFty7uLhu5Fg6BTbncO
         KuS8a+KvfRT4SV5Lfwb3/4dOoyOaQQzKnKWGIqlC24GpPcdMQ2DqpRT8LQu5VNHEPzFU
         ZnEu75hhEjQq84Rh2FB8VNuJeWaUlcqztCpL9RgdwqoWRohzZcprIqkMcEJMMQwBqssi
         EJJGfo9gaF30t0zH4qeP4fxy7ycvwZV2lQkzMaaXqqT8oh1RxooIkn20tVSKZNI3ZxhQ
         eUFvG/fPX9g6/5qjpLJufoC5r8QQJs4BapMC5RCfZ9BXnoAxmLxXtOFsGX8uevvMNe93
         QcaQ==
X-Gm-Message-State: AC+VfDzj+ygjC7LDzj+N+HHwPDhlA0j0/4DcZw9tFIWgEZdVtnkOe4YN
        /noyWd8cS7BxcRvbLA/swUapQ7cwpt46ugZJNSHxiTsvDpcGq2ZjalB5iJhT/92IDfiOLIHwr0Z
        Jh/Eb2TUpsW/lBjX1PPqej9E0
X-Received: by 2002:a05:6214:29e4:b0:5ef:739a:1c46 with SMTP id jv4-20020a05621429e400b005ef739a1c46mr2952145qvb.1.1683307521691;
        Fri, 05 May 2023 10:25:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5imN5N9GIC7dzfFAOWtj0K2HPQRe/ppRy2gFMkO+PHvi4F2j9kg5oq4lWEhfv/CuQrL7JL2g==
X-Received: by 2002:a05:6214:29e4:b0:5ef:739a:1c46 with SMTP id jv4-20020a05621429e400b005ef739a1c46mr2952126qvb.1.1683307521434;
        Fri, 05 May 2023 10:25:21 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id j8-20020a05620a000800b0074411b03972sm721761qki.51.2023.05.05.10.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:25:20 -0700 (PDT)
Date:   Fri, 5 May 2023 10:25:19 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, hdegoede@redhat.com,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: tpm_sis IRQ storm on ThinkStation P360 Tiny
Message-ID: <qn4nu342cvqfiloh3vdgaqzpppecpqti4uw4jbhwpa7ixljper@fcbcr3tfk7md>
References: <20230505130731.GO83892@hirez.programming.kicks-ass.net>
 <toe7jsgedknsqj3dgw2fasjlqcpgpiqgloifxow4vnt3tntabw@l6emb5zpbff5>
 <20230505171915.GA1821641@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505171915.GA1821641@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 07:19:15PM +0200, Peter Zijlstra wrote:
> On Fri, May 05, 2023 at 08:05:53AM -0700, Jerry Snitselaar wrote:
> 
> > It will poll like it has for years with tpm_tis.interrupts=0 so that
> > should be working as it was prior to 6.3 when interrupts were re-enabled
> > for tpm_tis. Are you seeing this with 6.2 as well? IIRC with that Thinkpad
> > case is when it was first realized that interrupts had accidentally been
> > disabled for tpm_tis at one point by a change.
> 
> v6.2 gets me:
> 
> [    8.888394] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1D, rev-id 54)
> [    8.891123] tpm tpm0: [Firmware Bug]: TPM interrupt not working, polling instead
> 
> > I guess myself or someone else needs to revisit catching this in
> > general when the irq storm happens, and disabling interrupts for
> > tpm_tis. I think last time I was incorporating some feedback from
> > tglx, let my adhd get me distracted with some other issue and never
> > returned to it.
> > 
> > The diff below should (compile tested) work for the P360, but
> > tpm_tis.interrupts=0 is a good work-around.
> 
> Yep, I suppose it would. I'll keep the kernel parameter for now, that's
> easier than making sure I consistently apply that patch.
> 
> Thanks!

Yeah, going back and looking at the history it was the first attempt
that re-enabling interrupts that I think made it show up on the
Thinkpad.

I'll see if I can finish up that patch I was working on before since
this will probably be coming up again now that the interrupts were
re-enabled.

Thank you for the 6.2 info.

Regards,
Jerry

