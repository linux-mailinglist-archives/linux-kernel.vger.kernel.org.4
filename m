Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EB1681A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbjA3Tdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbjA3Tdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:33:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EAC10AAF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675107179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b29OEkSltJ6OkxogQuB+wojLvZ7xn+do3QkNQyjKlOI=;
        b=IlbStPUoFiPKSFblbV1661V8iZi+2iAV5JkKK5AXoWaWsThtMkfeKjJHBlVu50EwgjAw1R
        6lEGrPqkct+aJX254JF86ID474/NHvUjZwha+RklINQs6oPgaRPrybouoo77lkGdNTO7qA
        4iogZX9e1KLiN/Gtn80iy1MZBe0azFE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-519-afQ2HcH2PrijuNOBG-Banw-1; Mon, 30 Jan 2023 14:32:58 -0500
X-MC-Unique: afQ2HcH2PrijuNOBG-Banw-1
Received: by mail-io1-f72.google.com with SMTP id e16-20020a6b5010000000b00719041c51ebso3056639iob.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b29OEkSltJ6OkxogQuB+wojLvZ7xn+do3QkNQyjKlOI=;
        b=KJd07taISYxASBoWh9W9ayTpEu5yt3G2x1IofcxU6FUB0gjp1i9rYFiNZQ3XNS98ZS
         RZBo9A+Iv2+ezjL/gKgYaVdqMj0LV4QZ1gT3vKM7cLbgncPhnkPrlu/gfAW8ecuEmSHf
         ip5dvZGRwxjB2KGHfi77R1NJbRVG2lAYb3G2rqy2ogaQvQuPtJPxgJdBeUWlo/aRSXSJ
         HlvuNUmyYGFAyChP/ANuQY6OgXDvBeZJ6L0AOwIyTl6S+6l8XBiTKNzvk8qPn8FmBrOq
         UXPvxzEEjQxknnKjRJW/3juDOqk+fTbK9j5ogFd1ud1SKpMd3LTx20EM5058CBKPS+wD
         ceAg==
X-Gm-Message-State: AFqh2kqGx2JrXj8cgMe+HLyeZMk/OPVrP47gH1dclMXRrBTc5jgPwjtd
        VNy6/2240Qw3vHwH9mQGKgvsawi22zUOGknhgjrY5fr0LF9qDty2ytwHBj1uaDNBgxAsGUBnWLR
        BAwuCOKBsiqgz4r85xAOEzVaY
X-Received: by 2002:a6b:fa10:0:b0:6e9:d035:45df with SMTP id p16-20020a6bfa10000000b006e9d03545dfmr31146897ioh.6.1675107176343;
        Mon, 30 Jan 2023 11:32:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuvns4Z4qbpbqMq1se1TqOJhE3/Ye97gIwmAlJwWCpTW7nSDZ6ppTaekxB90QXeAOvkgGo/Tg==
X-Received: by 2002:a6b:fa10:0:b0:6e9:d035:45df with SMTP id p16-20020a6bfa10000000b006e9d03545dfmr31146887ioh.6.1675107176110;
        Mon, 30 Jan 2023 11:32:56 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d1-20020a056602280100b00713d437afe8sm1091432ioe.26.2023.01.30.11.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:32:55 -0800 (PST)
Date:   Mon, 30 Jan 2023 12:32:54 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Christoph Hellwig" <hch@lst.de>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Tony Krowiak" <akrowiak@linux.ibm.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Finn Behrens" <me@kloenk.de>, "Miguel Ojeda" <ojeda@kernel.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio-mdev: add back CONFIG_VFIO dependency
Message-ID: <20230130123254.5f69f917.alex.williamson@redhat.com>
In-Reply-To: <a870060c-9438-4383-97e3-e77d1c361b51@app.fastmail.com>
References: <20230126163719.3585002-1-arnd@kernel.org>
        <20230126103811.56d71351.alex.williamson@redhat.com>
        <20230126174044.GA15999@lst.de>
        <20230126104515.3fcb3abf.alex.williamson@redhat.com>
        <20230130073324.GA590@lst.de>
        <a870060c-9438-4383-97e3-e77d1c361b51@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 14:34:54 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, Jan 30, 2023, at 08:33, Christoph Hellwig wrote:
> > On Thu, Jan 26, 2023 at 10:45:15AM -0700, Alex Williamson wrote:  
> >> The culprit is already in my next branch, we just need a fix that
> >> includes all the cases.  A respin of Arnd's patch would be preferable
> >> to keep the fixes in one place.  Thanks,  
> >
> > Arnd, do you plan to resend the patch, or should I take care of it?  
> 
> I sent the v2 last week, it looks like I forgot to add you to Cc there:
> 
> https://lore.kernel.org/all/20230126211211.1762319-1-arnd@kernel.org/

Thanks for the v2, Arnd.  Last call for any acks on the above, this is
setting off too many build failures.  Thanks,

Alex

