Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC7A67810C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjAWQMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjAWQM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:12:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA1B2A9AA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674490291;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mz7xGqx6E1niOWHAWq/+++r/M9PQbeJ9BovvPUNWROE=;
        b=cZbHsAOYz9KpA+hsg/nJsugsPGxL+IRZi4RJLASlrpRBS4wNcYXSM1SvGKb3cpr8r1h3vk
        NmtoX7RmAOSFOTuG1YHwJsScp2Tw8VQ5T0KyV4svBAyRmyvIhJZn3DlifijfS0433OoDg4
        L8GPExPHAMzbfPjiQGRx0UM3MLjq8nU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-J6O3NOpKOq2HACCAsXOvYw-1; Mon, 23 Jan 2023 11:11:27 -0500
X-MC-Unique: J6O3NOpKOq2HACCAsXOvYw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D6103811F2B;
        Mon, 23 Jan 2023 16:11:26 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.39.192.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E81751121330;
        Mon, 23 Jan 2023 16:11:25 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.17.1/8.17.1) with ESMTPS id 30NGBJAX445026
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 17:11:20 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.17.1/8.17.1/Submit) id 30NGBDHl445025;
        Mon, 23 Jan 2023 17:11:13 +0100
Date:   Mon, 23 Jan 2023 17:11:13 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Michael.Karcher'" <Michael.Karcher@fu-berlin.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.osdn.me>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "jakub@gcc.gnu.org" <jakub@gcc.gnu.org>
Subject: Re: [PATCH: 1/1] sh4: avoid spurious gcc warning
Message-ID: <Y86xofsIk3NzidQO@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <52952170-f1a9-89a0-e307-f974ce2b7977@fu-berlin.de>
 <c411961861df4ae4b011317ff2c3c7df@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c411961861df4ae4b011317ff2c3c7df@AcuMS.aculab.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 04:06:27PM +0000, David Laight wrote:
> From: Michael.Karcher
> > Sent: 22 January 2023 00:15
> > 
> > Prevent sizeof-pointer-div warning in SH4 intc macros
> > 
> > Gcc warns about the pattern sizeof(void*)/sizeof(void), as it looks like
> > the abuse of a pattern to calculate the array size. This pattern appears
> > in the unevaluated part of the ternary operator in _INTC_ARRAY if the
> > parameter is NULL.
> > 
> > The replacement uses an alternate approach to return 0 in case of NULL
> > which does not generate the pattern sizeof(void*)/sizeof(void), but still
> > emits the warning if _INTC_ARRAY is called with a nonarray parameter.
> > 
> > This patch is required for successful compilation with -Werror enabled.
> > 
> > The idea to use _Generic for type distinction is taken from Comment #7
> > in https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108483 by Jakub Jelinek
> > 
> > Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> > ---
> > 
> > diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
> > index c255273b0281..d7a7ffb60a34 100644
> > --- a/include/linux/sh_intc.h
> > +++ b/include/linux/sh_intc.h
> > @@ -97,7 +97,7 @@ struct intc_hw_desc {
> >       unsigned int nr_subgroups;
> >   };
> > 
> > -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
> 
> FWIW it is (currently) enough to add 0 to the top or bottom
> of the division.

If you don't want the warning at all, sure.  But if you want the compiler
to warn if you use the macro on a (non-void *) pointer rather than array,
what has been posted is needed.

	Jakub

