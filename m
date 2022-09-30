Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7D85F0795
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiI3JbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiI3JbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:31:00 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D84A6C02
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:30:58 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28U9EDka031267;
        Fri, 30 Sep 2022 09:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=xXBkgUkfhy7ieAdx6vlWNWLYKk2G/hrM/nkE4FkDWbg=;
 b=pTKDkiiEz4KvVDH1ttuBpnxgSkcDDIuxqxZPvQoGt6YS+JBoGuLStBNgzhBRpI8ExZSH
 LCDZOD1w+ffA/rs/5CFu9HLMjQs45gzCO38fybUJsBCpGy263n5W2Kjun+r3TpZxs6aT
 yu7CG9NCsTGnmigK3uGafLD7MQHXLXsSthgqCuG+1YsIOdiJQRhouVdka4+7ExhOeoA2
 xQeazLlxDMel+0+Oh5sy8mGg8jzQzN7JL1Lf2M+fT/Prw+kdjcvQXx675FLs6NxU06bU
 oJdQ/gB+O+3dl9JW0JbjnsBozx+B6SseQvYj2fcwNpU70Q9k+d3LV1zP0oZODRK+91S3 uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwwn2gdtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 09:30:55 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28U9IIBm007040;
        Fri, 30 Sep 2022 09:30:54 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwwn2gdse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 09:30:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28U9Lpsg008066;
        Fri, 30 Sep 2022 09:30:52 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3jss5j7w5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 09:30:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28U9Uojh63898074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 09:30:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ACC05204E;
        Fri, 30 Sep 2022 09:30:50 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.242])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0167152052;
        Fri, 30 Sep 2022 09:30:49 +0000 (GMT)
Date:   Fri, 30 Sep 2022 11:30:47 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     xu.xin.sc@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH 0/3] ksm: fix incorrect count of merged pages when
 enabling use_zero_pages
Message-ID: <20220930113047.60800177@p-imbrenda>
In-Reply-To: <1fc6984b-bcc7-123d-1ea3-9e04d5b26529@redhat.com>
References: <20220929025206.280970-1-xu.xin16@zte.com.cn>
        <4a3daba6-18f9-d252-697c-197f65578c44@redhat.com>
        <20220929123630.0951b199@p-imbrenda>
        <745f75a4-6a2a-630f-8228-0c5e081588e7@redhat.com>
        <20220929140548.1945dccf@p-imbrenda>
        <1fc6984b-bcc7-123d-1ea3-9e04d5b26529@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MC2aevjmZZ_EXMdvbp0gth_dvRppx75k
X-Proofpoint-ORIG-GUID: Tjwx5DbhXsE5VwmwuYigqZPE0D90Fr3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 19:53:34 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 29.09.22 14:05, Claudio Imbrenda wrote:
> > On Thu, 29 Sep 2022 13:12:44 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 29.09.22 12:36, Claudio Imbrenda wrote:  
> >>> On Thu, 29 Sep 2022 11:21:44 +0200
> >>> David Hildenbrand <david@redhat.com> wrote:
> >>>      
> >>>> On 29.09.22 04:52, xu.xin.sc@gmail.com wrote:  
> >>>>> From: xu xin <xu.xin16@zte.com.cn>
> >>>>>
> >>>>> Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
> >>>>> use_zero_pages to 1, pages_sharing of KSM is basically accurate. But
> >>>>> after enabling use_zero_pages, all empty pages that are merged with
> >>>>> kernel zero page are not counted in pages_sharing or pages_shared.
> >>>>> That is because the rmap_items of these ksm zero pages are not
> >>>>> appended to The Stable Tree of KSM.
> >>>>>
> >>>>> We need to add the count of empty pages to let users know how many empty
> >>>>> pages are merged with kernel zero page(s).
> >>>>>
> >>>>> Please see the subsequent patches for details.  
> >>>>
> >>>> Just raising the topic here because it's related to the KSM usage of the
> >>>> shared zero-page:
> >>>>
> >>>> MADV_UNMERGEABLE and other ways to trigger unsharing will *not* unshare
> >>>> the shared zeropage as placed by KSM (which is against the
> >>>> MADV_UNMERGEABLE documentation at least). It will only unshare actual
> >>>> KSM pages. We might not want want to blindly unshare all shared
> >>>> zeropages in applicable VMAs ... using a dedicated shared zero (KSM)
> >>>> page -- instead of the generic zero page --  might be one way to handle
> >>>> this cleaner.  
> >>>
> >>> I don't understand why do you need this.
> >>>
> >>> first of all, one zero page would not be enough (depending on the
> >>> architecture, e.g. on s390x you need many). the whole point of zero
> >>> page merging is that one zero page is not enough.  
> >>
> >> I don't follow. Having multiple ones is a pure optimization on s390x (I
> >> recall something about cache coloring), no? So why should we blindly
> >> care in the special KSM use case here?  
> > 
> > because merging pages full of zeroes with only one page will have
> > negative performance on those architectures that need cache colouring
> > (and s390 is not even the only architecture that needs it)
> > 
> > the whole point of merging pages full of zeroes with zero pages is to
> > not lose the cache colouring.
> > 
> > otherwise you could just let KSM merge all pages full of zeroes with
> > one page (which is what happens without use_zero_pages), and all the
> > numbers are correct.
> > 
> > if you are not on s390 or MIPS, you have no use for use_zero_pages  
> 
> Ah, I see now that use_zero_pages is really only (mostly) s390x 
> specific. I already wondered why on earth we would really need that, 
> thanks for pointing that out.
> 
> One question I'd have is: why is the shared zero page treated special in 
> KSM then *at all*. Cache coloring problem should apply to *each and 
> every* deduplicated page.

true, but unsurprisingly the zero page is the most common one. e.g. if
you have a very big and very sparse matrix, you will read lots of
consecutive pages of zeroes. there is also a more important issue with
VMs, which is actually the reason of the feature (see below)

in general it's unlikely that you will read lots of consecutive pages
with the exact same non-zero content.

> 
> Why is a page filled with 0xff any different from a page filled with 0x0?

without use_zero_pages, the multiple zero pages in a KVM guest will
be merged into one single page in the host, so the guest will lose the
benefits of coloured zero pages. unsurprisingly this has a big impact
on performance.

> 
> Yes, I read e86c59b1b12d. It doesn't mention any actual performance 
> numbers and if the performance only applies to some microbenchmarks 
> nobody cares about.

that feature was implemented because of customer feedback. aka some
users hit the problem IRL.

> 
> Did you post some benchmarks results back then? That would be 

no, and I don't have the numbers at hand right now, but I remember it
was a very significant difference in the benchmark.

> interesting. I assume that the shared zeropage was simply the low 
> hanging fruit.

of course a very complex system could be implemented to merge pages in
different buckets based on the "colour"; the result would probably be
that nothing is shared.

KSM is a tradeoff between memory consumption and CPU time. fixing zero
pages brings speed advantages (on architectures with coloured zero
pages) without sacrificing memory savings (on any architecture)

> 
> >   
> >>  
> >>>
> >>> second, once a page is merged with a zero page, it's not really handled
> >>> by KSM anymore. if you have a big allocation, of which you only touch a
> >>> few pages, would the rest be considered "merged"? no, it's just zero
> >>> pages, right?  
> >>
> >> If you haven't touched memory, there is nothing populated -- no shared
> >> zeropage.
> >>
> >> We only populate shared zeropages in private anonymous mappings on read
> >> access without prior write.  
> > 
> > that's what I meant. if you read without writing, you get zero pages.
> > you don't consider those to be "shared" from a KSM point of view
> > 
> > does it make a difference if some pages that have been written to but
> > now only contain zeroes are discarded and mapped back to the zero pages?  
> 
> That's a good question. When it comes to unmerging, you'd might expect 
> that whatever was deduplicated will get duplicated again -- and your 
> memory consumption will adjust accordingly. The stats might give an 
> admin an idea regarding how much memory is actually overcommited. See 
> below on the important case where we essentially never see the shared 
> zeropage.
> 
> The motivation behind these patches would be great -- what is the KSM 
> user and what does it want to achieve with these numbers?

anyone who works on big amounts of very sparse data, especially in a VM
(as I explained above, with KSM without use_zero_pages KVM guests lose
the zero page colouring)

> 
> >   
> >>  
> >>> this is the same, except that we take present pages with zeroes in it
> >>> and we discard them and map them to zero pages. it's kinda like if we
> >>> had never touched them.  
> >>
> >> MADV_UNMERGEABLE
> >>
> >> "Undo  the effect of an earlier MADV_MERGEABLE operation on the
> >> specified address range; KSM unmerges whatever pages it had merged in
> >> the address range specified  by  addr  and length."
> >>
> >> Now please explain to me how not undoing a zeropage merging is correct
> >> according to this documentation.
> >>  
> > 
> > because once it's discarded and replaced with a zero page, the page is
> > not handled by KSM anymore.
> > 
> > I understand what you mean, that KSM did an action that now cannot be
> > undone, but how would you differentiate between zero pages that were
> > never written to and pages that had been written to and then discarded
> > and mapped back to a zero page because they only contained zeroes?  
> 
> An application that always properly initializes (write at least some 
> part once) all its memory will never have the shared zeropage mapped. VM 
> guest memory comes to mind, probably still the most important KSM use case.
> 
> There are currently some remaining issues when taking a GUP R/O longterm 
> pin on such a page (e.g., vfio). In contrast to KSM pages, such pins are 
> not reliable for the shared zeropage, but I have fixes for them pending. 
> However, that is rather a corner case (it didn't work at all correctly a 
> while ago) and will be sorted out soon.
> 
> So the question is if MADV_UNMERGEABLE etc. (stats) should be adjusted 
> to document the behavior with use_zero_pages accordingly.

we can count how many times a page full of zeroes was merged with a
zero-page, but we can't count how many time one of those pages was then
unmerged. once it's merged it becomes a zero-page, like the others.

the documentation probably can be fixed to explain what's going on

 

