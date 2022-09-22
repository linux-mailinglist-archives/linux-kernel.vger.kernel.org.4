Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BDB5E637C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiIVNX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiIVNXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E9333A16
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663853003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TKSTcL6cyS/hic4/Q9+hr9kET/B4oyx+F6h0cSIUXnI=;
        b=hXcQTSo1yCJGlc8tRspYHD32PLEf+S6tdrj9BFhS/qJD8pSzxDl22C0Qb3PbaEnH0EeYLP
        E2ke1fGB7zMPipJbfJMKvpqaMC9HrEwHs9IGDoyMOe1QkuD/78Klj7pQ6nz1I66PtdjzvH
        5PsTMxTrnhIs+8nO33b9bcBVAj5/MhQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-3njGDTTYM1Gis-yKjJw7CQ-1; Thu, 22 Sep 2022 09:23:19 -0400
X-MC-Unique: 3njGDTTYM1Gis-yKjJw7CQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44E44294EDF8;
        Thu, 22 Sep 2022 13:23:19 +0000 (UTC)
Received: from localhost (ovpn-12-113.pek2.redhat.com [10.72.12.113])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E586CC15BA4;
        Thu, 22 Sep 2022 13:23:17 +0000 (UTC)
Date:   Thu, 22 Sep 2022 21:23:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 02/11] mm: ioremap: fixup the physical address and
 page prot
Message-ID: <YyxhwsMWvFGzYPxZ@MiWiFi-R3L-srv>
References: <e7f8798a-43ac-8083-93ac-4581bd2a5647@csgroup.eu>
 <YwQrC3X3PHa0pNDy@MiWiFi-R3L-srv>
 <54b7afcc-056d-7f33-6858-d451a3222c70@csgroup.eu>
 <YwTI6jAjY68QK5h6@MiWiFi-R3L-srv>
 <8df89136-a7f2-9b66-d522-a4fb9860bf22@csgroup.eu>
 <YwtND/L8xD+ViN3r@MiWiFi-R3L-srv>
 <Yx6fvuXakMnCwinB@MiWiFi-R3L-srv>
 <6ffdbdbb-0a21-25a6-13f6-4c4be3b87e50@csgroup.eu>
 <YyCdpxJeyY0geOLh@MiWiFi-R3L-srv>
 <7b8605d6-0c86-206a-e8ab-27d8ecf344c8@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b8605d6-0c86-206a-e8ab-27d8ecf344c8@csgroup.eu>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/22 at 04:40pm, Christophe Leroy wrote:
> 
> 
> Le 13/09/2022 à 17:11, Baoquan He a écrit :
> > On 09/12/22 at 07:10am, Christophe Leroy wrote:
> >> Hi Baoquan,
> >>
> >> Le 12/09/2022 à 04:55, Baoquan He a écrit :
> >>> Hi Christophe,
> >>>
> >>> On 08/28/22 at 07:10pm, Baoquan He wrote:
> >>>> On 08/23/22 at 07:03pm, Christophe Leroy wrote:
> >>> ......
> >>>>>>>>> Is it really the best approach ? Wouldn't it be better to have helpers
> >>>>>>>>> to do that, those helpers being called by the ioremap_prot(), instead of
> >>>>>>>>> doing it inside the arch_ioremap() function ?
> >>>>>>>>
> >>>>>>>> This is suggested too by Alexander during his v1 reviewing. I tried, but
> >>>>>>>> feel the current way taken in this patchset is better. Because not all
> >>>>>>>> architecutres need the address fix up, only parisc, and only few need
> >>>>>>>> adjust the 'prot'. Introducing other helpers seems too much, that only
> >>>>>>>> increases the complexity of of ioremap() and the generic GENERIC_IOREMAP
> >>>>>>>> method for people to understand and take.
> >>>>>>>
> >>>>>>> I can't understand. Why is it difficult to do something like:
> >>>>>>>
> >>>>>>> #ifndef ioremap_adjust_prot
> >>>>>>> static inline unsigned long ioremap_adjust_prot(unsigned long flags)
> >>>>>>> {
> >>>>>>> 	return flags;
> >>>>>>> }
> >>>>>>> #endif
> >>>>>>>
> >>>>>>> Then for arc you do
> >>>>>>>
> >>>>>>> static inline unsigned long ioremap_adjust_prot(unsigned long flags)
> >>>>>>> {
> >>>>>>> 	return pgprot_val(pgprot_noncached(__pgprot(flags)));
> >>>>>>> }
> >>>>>>> #define ioremap_adjust_prot ioremap_adjust_prot
> >>>>>>
> >>>>>> My thinking is we have four things to do in the added hookers.
> >>>>>> 1) check if we should do ioremap on ARCHes. If not, return NULL from
> >>>>>> ioremap_prot();
> >>>>>> 2) handling the mapping io address specifically on ARCHes, e.g arc,
> >>>>>> ia64, s390;
> >>>>>> 3) the original physical address passed into ioremap_prot() need be
> >>>>>> fixed up, e.g arc;
> >>>>>> 4) the 'prot' passed into ioremap_prot() need be adjusted, e.g on arc
> >>>>>> and xtensa.
> >>>>>>
> >>>>>> With Kefeng's patches, the case 1) is handled with introduced
> >>>>>> ioremap_allowed()/iounmap_allowed(). In this patchset, what I do is
> >>>>>> rename the hooks as arch_ioremap() and arch_iounmap(), then put case 1),
> >>>>>> 2), 3), 4) handling into arch_ioremap(). Adding helpers to cover each
> >>>>>> case is not difficult from my side. I worry that as time goes by, those
> >>>>>> several hooks my cause issue, e.g if a new adjustment need be done,
> >>>>>> should we introduce a new helper or make do with the existed hook; how
> >>>>>>
> >>>>>> When I investigated this, one arch_ioremap() looks not complicated
> >>>>>> since not all ARCHes need cover all above 4 cases. That's why I finally
> >>>>>> choose one hook. I am open to new idea, please let me know if we should
> >>>>>> change it to introduce several different helpers.
> >>>>>>
> >>>>>
> >>>>> A new idea that would have my preference would be to do just like we did
> >>>>> with arch_get_unmapped_area(). Look at
> >>>>> https://elixir.bootlin.com/linux/v6.0-rc1/source/arch/powerpc/mm/book3s64/slice.c#L638
> >>>>> and https://elixir.bootlin.com/linux/v6.0-rc1/source/mm/mmap.c#L2131
> >>>>>
> >>>>> Instead of having the generic that calls the arch specific, make it the
> >>>>> other way round, have the arch specific call the generic after doing its
> >>>>> specialties.
> >>>>
> >>>> This sounds good. I made a draft patch to change code in generic code
> >>>> part, just showing what it looks like.
> >>>>
> >>>> Both arch_ioremap() way and the arch sepcific call the generic way look
> >>>> good to me. Just it will take less effort for me to continue the
> >>>> arch_ioremap() way. I would like to hear Christoph's opinion since he
> >>>> introduced the GENERIC_IOREMAP method and suggested the earlier
> >>>> arch_ioremap() way and change in this patchset.
> >>>
> >>> I will make another round change and post. Since Christoph doesn't
> >>> reply, I would like to continue with the existing
> >>> arch_ioremap/arch_iounmap() hooks way if you don't have strong opinion
> >>> on the new idea to reintroduce ioremap().
> >>>
> >>
> >> I still dislike you approach with the architectures modifying local vars
> >> by reference, and as you said earlier I'm not the only one : "This is
> >> suggested too by Alexander during his v1 reviewing".
> > 
> > Alexander suggested several helpers, as I have explained earlier, that
> > will cause at least four helpers currently. And could be more later if
> > new change is introduced. And the address fixup and prot modifcation
> > are related in few architecutures. Adding all of them is is not so
> > necessary.
> > 
> >>
> >> So I'd really prefer you to reconsider your approach and avoid passign
> >> pointers to local vars to architecture helpers.
> > 
> > If only passing pointers to local vars is disliked, I can explain why I
> > did so. Let me take arch_ioremap() of a64 as example. I can derefence
> > pointer in arch_ioremap() to avoid assigning pointers to local vars.
> > Please see below two version for comparing, and please tell which one is
> > better.
> 
> Ok, yes I overlooked and didn't remember it right.
> 
> > 
> > To me, assigning pointers to local vars make code simple and clean,
> > honestly.
> 
> Well, for me it looks ood, not intellectually natural.
> 
> If I understand correctly, you do
> 
> ioremap()
>    --> Call arch_ioremap()
>      --> If the arch doesn't want to handle ioremap itself, it returns NULL
>      --> Then you fallback on generic handling.
> 
> The arch may say "I don't want to handle it", but at the same time it 
> blindly modifies the parameters so that the generic handling is not 
> exacly the generic handling.

No, it's not like that.

Arch_ioremap() provides a place where arch specific handling can be
done. While it doesn't mean arch has to do all of the follow four
things. From the current change I made listed as below, arch_ioremap()
in each architecture is quite simple to do one or two things.

People only need to provide arch_ioremap() if needed, or do not provide
arch_ioremap() at all if not needed. No such thing could hapen like you
said that arch don't want to handle, but it blindly modifes the parameter.

arm64:
  - address checking;
hexagon: removes the ioremap() directly since it has the same code as standard;
  - N/A
arc:
  - address checking
  - modify the prot flag;
ia64:
  - specific io address mapping
openrisc: removes ioremap() directly after its early ioremap is cleared away;
  - N/A
parisc:
  - physical address fixup
  - address checking;
s390:
  - specific io address mapping
sh:
  - specific io address mapping 
xtensa:
  - address checking;

Four optional things could be done in arch_ioremap():
1) check if we should do ioremap on ARCHes. If not, return NULL from
ioremap_prot();
2) handling the mapping io address specifically on ARCHes, e.g arc,
ia64, s390;
3) the original physical address passed into ioremap_prot() need be
fixed up, e.g arc;
4) the 'prot' passed into ioremap_prot() need be adjusted, e.g on arc
and xtensa.

> Not easy to follow for the reader. Do you have any exemple in the kernel 
> that works more or less with the same approach ?
> 
> 
> What I propose is
> 
> Arch specific ioremap()
>    --> do proper preparation
>    --> call generic_ioremap()
> 
> And the generic fallback implementation when the arch doesn't have a 
> specific ioremap()
> 
> __weak ioremap()
>    --> call generic_ioremap().

Hmm, __weak is not suggested any more in kernel. Please see below
thread.

[PATCH] kexec_file: Drop weak attribute from arch_kexec_apply_relocations[_add]
https://lore.kernel.org/all/20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com/T/#u


So with arch_ioremap() hook, now in each architecture it is:

  arch_ioremap() is provided and called
  or 
  no hookd is needed at all in arch 

It's simpler, isn't it?

> 
> The above looks a lot more natural and easier to follow, it is clear for 
> the reader which function does what.

Before, there's only arm64 taking GENERIC_IOREMAP way and having
arch_ioremap() as an exmaple. Now after this patchset, there are so many
architectures taking the way, it's very easy to refer to and study,
right?

Thanks
Baoquan

