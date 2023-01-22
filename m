Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F1F676CF3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjAVMns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjAVMnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:43:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A671CF4F
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674391379;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=G85QnFBacl0zUMoHghV6EXcFeaY9C51G9nbii003cL4=;
        b=Xd6WcqcWq47L/2pPBmOyvBY28H1U02mChRe9xf98mEnatB2s1JOj7b1YabM2T46u7F0Mua
        0CWWlkXabUM1cjnhmYn5APr2b27i6PD7T/l6HAZtFdpoJbg494HW2jhuFepIis/1U8DWL/
        jAmnxyfJgPKiu/VcOtywfUkrV3WGIvk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-YK9lW9PIMieqML4CVlGxKw-1; Sun, 22 Jan 2023 07:42:55 -0500
X-MC-Unique: YK9lW9PIMieqML4CVlGxKw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B799D380662D;
        Sun, 22 Jan 2023 12:42:54 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.39.192.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38E4D175AD;
        Sun, 22 Jan 2023 12:42:54 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.17.1/8.17.1) with ESMTPS id 30MCgnci1532972
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 22 Jan 2023 13:42:49 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.17.1/8.17.1/Submit) id 30MCgiNs1532970;
        Sun, 22 Jan 2023 13:42:44 +0100
Date:   Sun, 22 Jan 2023 13:42:44 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.osdn.me>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        jakub@gcc.gnu.org
Subject: Re: [PATCH: 1/1] sh4: avoid spurious gcc warning
Message-ID: <Y80vRJfPJ4mIO8Cm@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <52952170-f1a9-89a0-e307-f974ce2b7977@fu-berlin.de>
 <2085aec3-796b-71c3-7cb2-d4103d3b6175@infradead.org>
 <c74cad7b-9ea3-5223-8292-3fe1172a9419@mkarcher.dialup.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c74cad7b-9ea3-5223-8292-3fe1172a9419@mkarcher.dialup.fu-berlin.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 12:33:41PM +0100, Michael Karcher wrote:
> Am 22.01.2023 um 08:00 schrieb Randy Dunlap:
> > > -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
> > > +#define _INTC_ARRAY(a) a, sizeof(a)/(_Generic((a), typeof(NULL): 0xFFFFFFFFU, default: sizeof(*a)))
> > s/: / : / in 2 places.
> > 
> > Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> 
> Thanks for your confirmation! Are you sure about the space before the colon?

No, it should be without those, see various other _Generic uses in
include/linux/
All those are formatted on one line for each case, so for the above macro it
would be
#define _INTC_ARRAY(a) (a), sizeof(a)/(_Generic((a),			\
				       typeof(NULL):	-1,		\
				       default:		sizeof(*(a)))
or so.
Anyway, two comments:
1) I'd use -1 as that would be after promotion to size_t the largest size_t
   unlike 0xFFFFFFFFU; of course, as for the void * case a can't be an array,
   any value > sizeof(void*) will do
2) if *a and a is fine (i.e. argument of the macro has to be really simple or
   wrapped in ()s, then perhaps (a) as first operand to _Generic isn't needed
   either, or use (a) in the two spots (sizeof(a) is of course fine) and
   *(a)

> The colon in this case terminates a case descriptor for the type-level
> switch construction using "_Generic". It says: "In case 'a' has the 'type of
> NULL', divide by 0xFFFFFFFFU, in all other cases, divide by the size of a
> single array element". It's not a colon of the ternary ?: operator, in which
> case I would agree with the space before it.
> 
> If you confirm that you want a space before the colon in this case as well,
> I'm going to add it, though.
> 
> > How far back in gcc versions does this work?
> 
> I tested the support of _Generic on Compiler Explorer at godbolt.org. This
> construction is rejected by gcc 4.8, but accepted by gcc 4.9.

Yeah, introduced in gcc 4.9, as I think kernel minimum version is 5.1, that is fine.
And various headers already use _Generic.

	Jakub

