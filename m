Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533186C4E98
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjCVOyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjCVOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C742884C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679496735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yd8xp51YysAjXirymoem/GVNmv6KZ1BXPi2JfEf4sqg=;
        b=UUHYWpShBlKK8+CP65Z9JyKh0odXEuQ6B6uvdZh5/0wwrUBrSr28u6R7KlhbDkSbKCT+ao
        LAV1WX19peZQxe4uFZEz1lnAKhLwM78g52PbTkAo1f5MwN3eegIvB3Bi6YkuvEIO6zvvvK
        7jY/SG5oynqeue5ZXIVINhDq8XVDo6U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-jcCXm_MtO56UVePGUKvZ6A-1; Wed, 22 Mar 2023 10:52:14 -0400
X-MC-Unique: jcCXm_MtO56UVePGUKvZ6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B6DB886068;
        Wed, 22 Mar 2023 14:52:13 +0000 (UTC)
Received: from localhost (ovpn-12-97.pek2.redhat.com [10.72.12.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D610B202701F;
        Wed, 22 Mar 2023 14:52:12 +0000 (UTC)
Date:   Wed, 22 Mar 2023 22:52:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] kexec: Support purgatories with .text.hot sections
Message-ID: <ZBsWFOb9wDGSwRSW@MiWiFi-R3L-srv>
References: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org>
 <ZBsSBr87al9ccG96@home.goodmis.org>
 <CANiDSCt_wvaHBq-Yss0QaKTtefBhWwtahFO8_jw6CPSvBwbbMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCt_wvaHBq-Yss0QaKTtefBhWwtahFO8_jw6CPSvBwbbMg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/23 at 03:42pm, Ricardo Ribalda wrote:
> Hi Steven
> 
> On Wed, 22 Mar 2023 at 15:34, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, Mar 21, 2023 at 12:49:08PM +0100, Ricardo Ribalda wrote:
> > > Clang16 links the purgatory text in two sections:
> > >
> > >   [ 1] .text             PROGBITS         0000000000000000  00000040
> > >        00000000000011a1  0000000000000000  AX       0     0     16
> > >   [ 2] .rela.text        RELA             0000000000000000  00003498
> > >        0000000000000648  0000000000000018   I      24     1     8
> > >   ...
> > >   [17] .text.hot.        PROGBITS         0000000000000000  00003220
> > >        000000000000020b  0000000000000000  AX       0     0     1
> > >   [18] .rela.text.hot.   RELA             0000000000000000  00004428
> > >        0000000000000078  0000000000000018   I      24    17     8
> > >
> > > And both of them have their range [sh_addr ... sh_addr+sh_size] on the
> > > area pointed by `e_entry`.
> > >
> > > This causes that image->start is calculated twice, once for .text and
> > > another time for .text.hot. The second calculation leaves image->start
> > > in a random location.
> > >
> > > Because of this, the system crashes inmediatly after:
> > >
> > > kexec_core: Starting new kernel
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > To: Eric Biederman <ebiederm@xmission.com>
> > > Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
> > > Cc: kexec@lists.infradead.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  kernel/kexec_file.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index f1a0e4e3fb5c..b1a25d97d5e2 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -904,7 +904,8 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
> > >               if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
> > >                   pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
> > >                   pi->ehdr->e_entry < (sechdrs[i].sh_addr
> > > -                                      + sechdrs[i].sh_size)) {
> > > +                                      + sechdrs[i].sh_size) &&
> > > +                 kbuf->image->start != pi->ehdr->e_shnum) {
> >
> > Shouldn't this be: kbuf->image->start == pi->ehdr->e_shnum) {
> 
> You are absolutely right, I screwed up when I ported the code from my
> test tree to the tree that I use for upstreaming.
> Instead of removing all the printks I wrote code.
> 
> :S
> 
> Will resend the patch

When you resne patch, please fix Philipp's mail adress as
'Philipp Rudo <prudo@redhat.com>' if he should know this. He has joined
Redhat.

Thanks
Baoquan

