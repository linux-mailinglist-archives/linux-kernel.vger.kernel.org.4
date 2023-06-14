Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E564272D8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbjFMEgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239436AbjFMEgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:36:42 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6984C10D7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:36:37 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230613043633epoutp0492d4adbb9027690c1bfe5774d1491f29~oHfPm1zfy1645916459epoutp04P
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:36:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230613043633epoutp0492d4adbb9027690c1bfe5774d1491f29~oHfPm1zfy1645916459epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686630993;
        bh=wvzK+Ug0rME5HPRFZ9O/Mxb5Kp4d8HOmPKnmQOhvTL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ADSnwLlqu1rry8Kw2dCClN2Vd1I0gCqoAXSeBPy887fdO+SG1ncgZAiLm3PZp8gSf
         n+/vVjY1GOrYRj/2kXcRK4BZk2ldc8bEpJfGIuoN2VxS2F3D1MzDDZGbUS29eKu1HM
         xtpUfCLF4x/sfinHmjm2OPVn97o4NQFeJ+SWucEc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230613043633epcas2p4a652166a5e37b71c8844af4b610ec8fa~oHfPILD6M3150031500epcas2p4F;
        Tue, 13 Jun 2023 04:36:33 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.89]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QgG3N53Hsz4x9Q1; Tue, 13 Jun
        2023 04:36:32 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.B8.11450.052F7846; Tue, 13 Jun 2023 13:36:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230613043632epcas2p1563509b2f29604cc0b18cd0d59e20a09~oHfOK8vIs1162911629epcas2p1t;
        Tue, 13 Jun 2023 04:36:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230613043632epsmtrp20eb1c240866e72e51773b4a612fc5172~oHfOKI7My0450704507epsmtrp2B;
        Tue, 13 Jun 2023 04:36:32 +0000 (GMT)
X-AuditID: b6c32a45-1dbff70000022cba-c1-6487f250a56d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.87.28392.052F7846; Tue, 13 Jun 2023 13:36:32 +0900 (KST)
Received: from KORCO045595.samsungds.net (unknown [10.229.38.76]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230613043632epsmtip2a1541a8236808a2e88564c1b96921d7b~oHfN50msm2580025800epsmtip2O;
        Tue, 13 Jun 2023 04:36:32 +0000 (GMT)
Date:   Tue, 13 Jun 2023 13:36:32 +0900
From:   Bongkyu Kim <bongkyu7.kim@samsung.com>
To:     Waiman Long <longman@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, jwook1.kim@samsung.com,
        lakkyung.jung@samsung.com, bongkyu7.kim@samsung.com
Subject: Re: [PATCH] locking/rwsem: Optionally re-enable reader optimistic
 spinning
Message-ID: <20230613043308.GA1027@KORCO045595.samsungds.net>
MIME-Version: 1.0
In-Reply-To: <8e11066a-017f-a190-39de-17f92128e42f@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOJsWRmVeSWpSXmKPExsWy7bCmqW7Ap/YUg+ZbKhavG18yWazZ0shk
        MffCOXaLj7f3sltc3jWHzeL0sRMsFpcOLGCyON57gMmi5Y6pA6fHzll32T02r9Dy2LSqk83j
        /b6rbB59W1YxenzeJBfAFtXAaJNYlJyRWZaqkJqXnJ+SmZduqxQa4qZroaSQkV9cYqsUbWho
        pGdoYK5nZGSkZ2oUa2VkqqSQl5ibaqtUoQvVq6RQlFwAVJtbWQw0ICdVDyquV5yal+KQlV8K
        8ohecWJucWleul5yfq6SQlliTinQCCX9hG+MGX2/77EVbPnGWHGkr4mpgXHCdsYuRk4OCQET
        iXOfLrB3MXJxCAnsYJRY+/AFG4TziVHi5KlNTBDOZ0aJCSufMsG0/Gh+xAyR2MUo0T35PFT/
        N0aJ9T/ugFWxCKhKdP0/yw5iswnoSPxfPQMsLiJQKnFtQQsriM0skC/x+dYmMFtYIFTi6Yfj
        LCA2r4CtxON9mxkhbEGJkzOfgMU5Bewkfja/BlsmITCRQ6Lp436oL1wklr9sZ4awhSVeHd/C
        DmFLSXx+t5cNws6WOHPnPFR9hcTLv3+gaowlZj1rZ4Q4KENiwsfVQPUcQHFliSO3WCDCfBId
        h/9ClQtKnL7WzQxRwivR0SYEEVaT2P28lRXClpE4eHYtNLA8JCY8mAs2XUhgDZPEvFfVExjl
        ZyH5bBaSxRC2nsSNqVOgbHmJ5q2zmWcBbWMWkJZY/o8DwtSUWL9LfwEj2ypGsdSC4tz01GKj
        AkPk2N/ECE7TWq47GCe//aB3iJGJg/EQowQHs5II71ON9hQh3pTEyqrUovz4otKc1OJDjMnA
        KJvILCWanA/MFHkl8YZmZpYWlkamFpamphaEhU0sDUzMzAzNjUwNzJXEeaVtTyYLCaQnlqRm
        p6YWpBbBbGHi4JRqYDqwM+eDafeb5l4Z698rJ4p9z0rQmDdbb9+GM4Wzb8Tt+v7hkbt8k/av
        O/pvV4jsfze7dYJZULdGJ8+xFdlBm46k5tV25XAlh070vPLy4v+dKqf7b12+4ma4qfu+ev4n
        X9lN3XbTjH4K7q5hjhBU9i1r2aA9PW/rwo6W211PZ6wS9ar6/PMB35n5k04eaes4mCZcG/c3
        6TrP75tzFz4sKKj6vH/+19zM04ebVCYbufx58shvdtf74/dlv0zrF0oVenCg+duNg9o7zy3c
        p/H8oJaLYW+3XEb0Jpd9HzSvcfHVVb098G7yXY6Jlf7ZU297sPzdfaP52DV71QDNazPNvmXp
        BYcuN5ttsDj6+mG2Z5GflFiKMxINtZiLihMBO0aHGYoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSvG7Ap/YUg8aVHBavG18yWazZ0shk
        MffCOXaLj7f3sltc3jWHzeL0sRMsFpcOLGCyON57gMmi5Y6pA6fHzll32T02r9Dy2LSqk83j
        /b6rbB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CV0bhnMlvBxc+MFdcWNbM2MJ7cwtjFyMkh
        IWAi8aP5EXMXIxeHkMAORom9hxdBJWQkDv1bywRhC0vcbznCClH0hVHi7+qf7CAJFgFVia7/
        Z8FsNgEdif+rZ4A1iAiUSlxb0MIKYjML5Et8vrUJzBYWCJV4+uE4C4jNK2Ar8XjfZkaIoWuY
        JF7t2McGkRCUODnzCQtEs47Ezq13gOIcQLa0xPJ/HBBheYnmrbOZQWxOATuJn82v2ScwCs5C
        0j0LSfcshO5ZSLoXMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjh0trR2Me1Z9
        0DvEyMTBeIhRgoNZSYT3qUZ7ihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNT
        UwtSi2CyTBycUg1MGboJ9+2eV2Zs948RzOp69utflVSelK6z58YZr79f3bMzxXXSyR2imnfE
        JnBUi1yXnV8TcL089u6ErvbSbJVlx8O490i+dpY+PtF3inxhyFd5Hzt2TZbn1emLGNZOOuzK
        s49vjRr/Pc53y/5urfIRnbrrfF7lVYGFiRn90rk6R+WfLiw7dGaPsGvIP7640zmT5755abD4
        d2wuG+cO88KmWt8/OeYWmY0zj93SjnjftqJljfGGqk8ekY9i4jnkn31bxRliwGKa8GaF562n
        sfkGndfXNbQXmMs9FGeyf5JyiO32xZYlaRpR22W037IUPtkQFrU9yTNJON0ybvW/zgrf3Qvc
        /PvjFlV8lD9/IFiJpTgj0VCLuag4EQCSPOj6DAMAAA==
X-CMS-MailID: 20230613043632epcas2p1563509b2f29604cc0b18cd0d59e20a09
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----Ia-OLKm9_0_1EVAmMXMmkTXXjuT3FhFkrC5bjtmjvll7fXt0=_aebb7_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230531003446epcas2p1fc55e0439a9c667685d495cd5f5b2e93
References: <CGME20230531003446epcas2p1fc55e0439a9c667685d495cd5f5b2e93@epcas2p1.samsung.com>
        <20230531003436.7082-1-bongkyu7.kim@samsung.com>
        <d5b65c4b-7232-e5a7-27ae-b8efab037396@redhat.com>
        <20230601012246.GA8364@KORCO045595.samsungds.net>
        <8e11066a-017f-a190-39de-17f92128e42f@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------Ia-OLKm9_0_1EVAmMXMmkTXXjuT3FhFkrC5bjtmjvll7fXt0=_aebb7_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Thu, Jun 01, 2023 at 10:06:13AM -0400, Waiman Long wrote:
> On 5/31/23 21:22, Bongkyu Kim wrote:
> > On Wed, May 31, 2023 at 02:29:54PM -0400, Waiman Long wrote:
> > > On 5/30/23 20:34, Bongkyu Kim wrote:
> > > > Remove reader optimistic spinning has a great regression on application
> > > I won't consider this a great regression if it is just a few % point of
> > > performance differences.
> > > 
> > > BTW, this patch is mostly a revert of commit 617f3ef95177 ("locking/rwsem:
> > > Remove reader optimistic spinning"). So it should be mentioned here.
> > > 
> > I will fix these and resend patch v2.
> > Thanks for your review.
> 

I missed your comments in last reply. I reply again.
I'm sorry for confusing you. Please check the answers below.

> There is one more point that I forgot to mention. Enabling this option can
> degrade or improve performance depending on the actual workload. A system
> administrator that is not familiar with the rwsem code will not know what to
> do with it. So I would suggest a bit more wording on the documentation part
> about under what condition should the users try to enable it to see if it
> helps.
> 
> -Longman
> 

I will add more wording to the documentation.

> > > > startup performance in android device. In mobile environment, reader
> > > > optimistic spinning is still useful because there're not many readers.
> > > > So re-enable reader optimistic spinning and disabled by default. And,
> > > > can turn on by cmdline.
> > > > 
> > > > Test result:
> > > > This is 15 application startup performance in our s5e8535 soc.
> > > > - Cortex A78*2 + Cortex A55*6
> > > > 
> > > > Application             base  opt_rspin  Diff  Diff(%)
> > > > --------------------  ------  ---------  ----  -------
> > > > * Total(geomean)         343        330   -13    +3.8%
> > > > --------------------  ------  ---------  ----  -------
> > > > helloworld               110        108    -2    +1.8%
> > > > Amazon_Seller            397        388    -9    +2.3%
> > > > Whatsapp                 311        304    -7    +2.3%
> > > > Simple_PDF_Reader        500        463   -37    +7.4%
> > > > FaceApp                  330        317   -13    +3.9%
> > > > Timestamp_Camera_Free    451        443    -8    +1.8%
> > > > Kindle                   629        597   -32    +5.1%
> > > > Coinbase                 243        233   -10    +4.1%
> > > > Firefox                  425        399   -26    +6.1%
> > > > Candy_Crush_Soda         552        538   -14    +2.5%
> > > > Hill_Climb_Racing        245        230   -15    +6.1%
> > > > Call_Recorder            437        426   -11    +2.5%
> > > > Color_Fill_3D            190        180   -10    +5.3%
> > > > eToro                    512        505    -7    +1.4%
> > > > GroupMe                  281        266   -15    +5.3%
> > > > 
> > > > Signed-off-by: Bongkyu Kim <bongkyu7.kim@samsung.com>
> > > > ---
> > > >    .../admin-guide/kernel-parameters.txt         |   2 +
> > > >    kernel/locking/lock_events_list.h             |   5 +-
> > > >    kernel/locking/rwsem.c                        | 292 +++++++++++++++---
> > > >    3 files changed, 255 insertions(+), 44 deletions(-)
> > > > 
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > index bb23a36a7ff7..b92a6b3f965f 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -5495,6 +5495,8 @@
> > > >    	rw		[KNL] Mount root device read-write on boot
> > > > +	rwsem.opt_rspin= [KNL] Use rwsem reader optimistic spinning
> > > > +
> > > >    	S		[KNL] Run init in single mode
> > > >    	s390_iommu=	[HW,S390]
> > > > diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
> > > > index 97fb6f3f840a..270a0d351932 100644
> > > > --- a/kernel/locking/lock_events_list.h
> > > > +++ b/kernel/locking/lock_events_list.h
> > > > @@ -56,9 +56,12 @@ LOCK_EVENT(rwsem_sleep_reader)	/* # of reader sleeps			*/
> > > >    LOCK_EVENT(rwsem_sleep_writer)	/* # of writer sleeps			*/
> > > >    LOCK_EVENT(rwsem_wake_reader)	/* # of reader wakeups			*/
> > > >    LOCK_EVENT(rwsem_wake_writer)	/* # of writer wakeups			*/
> > > > -LOCK_EVENT(rwsem_opt_lock)	/* # of opt-acquired write locks	*/
> > > > +LOCK_EVENT(rwsem_opt_rlock)	/* # of opt-acquired read locks		*/
> > > > +LOCK_EVENT(rwsem_opt_wlock)	/* # of opt-acquired write locks	*/
> > > >    LOCK_EVENT(rwsem_opt_fail)	/* # of failed optspins			*/
> > > >    LOCK_EVENT(rwsem_opt_nospin)	/* # of disabled optspins		*/
> > > > +LOCK_EVENT(rwsem_opt_norspin)	/* # of disabled reader-only optspins	*/
> > > > +LOCK_EVENT(rwsem_opt_rlock2)	/* # of opt-acquired 2ndary read locks	*/
> > > >    LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
> > > >    LOCK_EVENT(rwsem_rlock_steal)	/* # of read locks by lock stealing	*/
> > > >    LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
> > > > diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> > > > index 9eabd585ce7a..016dbc4312e6 100644
> > > > --- a/kernel/locking/rwsem.c
> > > > +++ b/kernel/locking/rwsem.c
> > > > @@ -33,13 +33,19 @@
> > > >    #include "lock_events.h"
> > > >    /*
> > > > - * The least significant 2 bits of the owner value has the following
> > > > + * The least significant 3 bits of the owner value has the following
> > > >     * meanings when set.
> > > >     *  - Bit 0: RWSEM_READER_OWNED - The rwsem is owned by readers
> > > > - *  - Bit 1: RWSEM_NONSPINNABLE - Cannot spin on a reader-owned lock
> > > > + *  - Bit 1: RWSEM_RD_NONSPINNABLE - Readers cannot spin on this lock.
> > > > + *  - Bit 2: RWSEM_WR_NONSPINNABLE - Writers cannot spin on this lock.
> > > >     *
> > > > - * When the rwsem is reader-owned and a spinning writer has timed out,
> > > > - * the nonspinnable bit will be set to disable optimistic spinning.
> > > > + * When the rwsem is either owned by an anonymous writer, or it is
> > > > + * reader-owned, but a spinning writer has timed out, both nonspinnable
> > > > + * bits will be set to disable optimistic spinning by readers and writers.
> > > > + * In the later case, the last unlocking reader should then check the
> > > > + * writer nonspinnable bit and clear it only to give writers preference
> > > > + * to acquire the lock via optimistic spinning, but not readers. Similar
> > > > + * action is also done in the reader slowpath.
> > > >     * When a writer acquires a rwsem, it puts its task_struct pointer
> > > >     * into the owner field. It is cleared after an unlock.
> > > > @@ -59,9 +65,47 @@
> > > >     * is previously owned by a writer and the following conditions are met:
> > > >     *  - rwsem is not currently writer owned
> > > >     *  - the handoff isn't set.
> > > > + *
> > > > + * Reader optimistic spinning is helpful when the reader critical section
> > > > + * is short and there aren't that many readers around. It makes readers
> > > > + * relatively more preferred than writers. When a writer times out spinning
> > > > + * on a reader-owned lock and set the nospinnable bits, there are two main
> > > > + * reasons for that.
> > > > + *
> > > > + *  1) The reader critical section is long, perhaps the task sleeps after
> > > > + *     acquiring the read lock.
> > > > + *  2) There are just too many readers contending the lock causing it to
> > > > + *     take a while to service all of them.
> > > > + *
> > > > + * In the former case, long reader critical section will impede the progress
> > > > + * of writers which is usually more important for system performance. In
> > > > + * the later case, reader optimistic spinning tends to make the reader
> > > > + * groups that contain readers that acquire the lock together smaller
> > > > + * leading to more of them. That may hurt performance in some cases. In
> > > > + * other words, the setting of nonspinnable bits indicates that reader
> > > > + * optimistic spinning may not be helpful for those workloads that cause
> > > > + * it.
> > > > + *
> > > > + * Therefore, any writers that had observed the setting of the writer
> > > > + * nonspinnable bit for a given rwsem after they fail to acquire the lock
> > > > + * via optimistic spinning will set the reader nonspinnable bit once they
> > > > + * acquire the write lock. Similarly, readers that observe the setting
> > > > + * of reader nonspinnable bit at slowpath entry will set the reader
> > > > + * nonspinnable bits when they acquire the read lock via the wakeup path.
> > > > + *
> > > > + * Once the reader nonspinnable bit is on, it will only be reset when
> > > > + * a writer is able to acquire the rwsem in the fast path or somehow a
> > > > + * reader or writer in the slowpath doesn't observe the nonspinable bit.
> > > > + *
> > > > + * This is to discourage reader optmistic spinning on that particular
> > > > + * rwsem and make writers more preferred. This adaptive disabling of reader
> > > > + * optimistic spinning will alleviate the negative side effect of this
> > > > + * feature.
> > > >     */
> > > >    #define RWSEM_READER_OWNED	(1UL << 0)
> > > > -#define RWSEM_NONSPINNABLE	(1UL << 1)
> > > > +#define RWSEM_RD_NONSPINNABLE	(1UL << 1)
> > > > +#define RWSEM_WR_NONSPINNABLE	(1UL << 2)
> > > > +#define RWSEM_NONSPINNABLE	(RWSEM_RD_NONSPINNABLE | RWSEM_WR_NONSPINNABLE)
> > > >    #define RWSEM_OWNER_FLAGS_MASK	(RWSEM_READER_OWNED | RWSEM_NONSPINNABLE)
> > > >    #ifdef CONFIG_DEBUG_RWSEMS
> > > > @@ -127,6 +171,12 @@
> > > >    #define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
> > > >    				 RWSEM_FLAG_HANDOFF|RWSEM_FLAG_READFAIL)
> > > > +#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
> > > > +/* Reader optimistic spinning, default disabled */
> > > > +static bool rwsem_opt_rspin;
> > > > +module_param_named(opt_rspin, rwsem_opt_rspin, bool, 0644);
> > > > +#endif
> > > The rwsem code isn't really a kernel module. It is a bit odd to use module
> > > parameter here.
> > > 

I will change to __setup or early_param.

> > > 
> > > > +
> > > >    /*
> > > >     * All writes to owner are protected by WRITE_ONCE() to make sure that
> > > >     * store tearing can't happen as optimistic spinners may read and use
> > > > @@ -171,7 +221,7 @@ static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
> > > >    					    struct task_struct *owner)
> > > >    {
> > > >    	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED |
> > > > -		(atomic_long_read(&sem->owner) & RWSEM_NONSPINNABLE);
> > > > +		(atomic_long_read(&sem->owner) & RWSEM_RD_NONSPINNABLE);
> > > >    	atomic_long_set(&sem->owner, val);
> > > >    }
> > > > @@ -341,6 +391,7 @@ struct rwsem_waiter {
> > > >    	enum rwsem_waiter_type type;
> > > >    	unsigned long timeout;
> > > >    	bool handoff_set;
> > > > +	unsigned long last_rowner;
> > > >    };
> > > >    #define rwsem_first_waiter(sem) \
> > > >    	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
> > > > @@ -480,6 +531,10 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
> > > >    		 * the reader is copied over.
> > > >    		 */
> > > >    		owner = waiter->task;
> > > > +		if (waiter->last_rowner & RWSEM_RD_NONSPINNABLE) {
> > > > +			owner = (void *)((unsigned long)owner | RWSEM_RD_NONSPINNABLE);
> > > > +			lockevent_inc(rwsem_opt_norspin);
> > > > +		}
> > > >    		__rwsem_set_reader_owned(sem, owner);
> > > >    	}
> > > > @@ -684,6 +739,30 @@ enum owner_state {
> > > >    };
> > > >    #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
> > > > +/*
> > > > + * Try to acquire read lock before the reader is put on wait queue.
> > > > + * Lock acquisition isn't allowed if the rwsem is locked or a writer handoff
> > > > + * is ongoing.
> > > > + */
> > > > +static inline bool rwsem_try_read_lock_unqueued(struct rw_semaphore *sem)
> > > > +{
> > > > +	long count = atomic_long_read(&sem->count);
> > > > +
> > > > +	if (count & (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))
> > > > +		return false;
> > > > +
> > > > +	count = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS, &sem->count);
> > > > +	if (!(count & (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
> > > > +		rwsem_set_reader_owned(sem);
> > > > +		lockevent_inc(rwsem_opt_rlock);
> > > > +		return true;
> > > > +	}
> > > > +
> > > > +	/* Back out the change */
> > > > +	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
> > > > +	return false;
> > > > +}
> > > > +
> > > >    /*
> > > >     * Try to acquire write lock before the writer has been put on wait queue.
> > > >     */
> > > > @@ -695,14 +774,15 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
> > > >    		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
> > > >    					count | RWSEM_WRITER_LOCKED)) {
> > > >    			rwsem_set_owner(sem);
> > > > -			lockevent_inc(rwsem_opt_lock);
> > > > +			lockevent_inc(rwsem_opt_wlock);
> > > >    			return true;
> > > >    		}
> > > >    	}
> > > >    	return false;
> > > >    }
> > > > -static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
> > > > +static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
> > > > +					   unsigned long nonspinnable)
> > > >    {
> > > >    	struct task_struct *owner;
> > > >    	unsigned long flags;
> > > > @@ -721,7 +801,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
> > > >    	/*
> > > >    	 * Don't check the read-owner as the entry may be stale.
> > > >    	 */
> > > > -	if ((flags & RWSEM_NONSPINNABLE) ||
> > > > +	if ((flags & nonspinnable) ||
> > > >    	    (owner && !(flags & RWSEM_READER_OWNED) && !owner_on_cpu(owner)))
> > > >    		ret = false;
> > > > @@ -732,9 +812,9 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
> > > >    #define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER | OWNER_READER)
> > > >    static inline enum owner_state
> > > > -rwsem_owner_state(struct task_struct *owner, unsigned long flags)
> > > > +rwsem_owner_state(struct task_struct *owner, unsigned long flags, unsigned long nonspinnable)
> > > >    {
> > > > -	if (flags & RWSEM_NONSPINNABLE)
> > > > +	if (flags & nonspinnable)
> > > >    		return OWNER_NONSPINNABLE;
> > > >    	if (flags & RWSEM_READER_OWNED)
> > > > @@ -744,7 +824,7 @@ rwsem_owner_state(struct task_struct *owner, unsigned long flags)
> > > >    }
> > > >    static noinline enum owner_state
> > > > -rwsem_spin_on_owner(struct rw_semaphore *sem)
> > > > +rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
> > > >    {
> > > >    	struct task_struct *new, *owner;
> > > >    	unsigned long flags, new_flags;
> > > > @@ -753,7 +833,7 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
> > > >    	lockdep_assert_preemption_disabled();
> > > >    	owner = rwsem_owner_flags(sem, &flags);
> > > > -	state = rwsem_owner_state(owner, flags);
> > > > +	state = rwsem_owner_state(owner, flags, nonspinnable);
> > > >    	if (state != OWNER_WRITER)
> > > >    		return state;
> > > > @@ -766,7 +846,7 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
> > > >    		 */
> > > >    		new = rwsem_owner_flags(sem, &new_flags);
> > > >    		if ((new != owner) || (new_flags != flags)) {
> > > > -			state = rwsem_owner_state(new, new_flags);
> > > > +			state = rwsem_owner_state(new, new_flags, nonspinnable);
> > > >    			break;
> > > >    		}
> > > > @@ -816,12 +896,14 @@ static inline u64 rwsem_rspin_threshold(struct rw_semaphore *sem)
> > > >    	return sched_clock() + delta;
> > > >    }
> > > > -static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
> > > > +static bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
> > > >    {
> > > >    	bool taken = false;
> > > >    	int prev_owner_state = OWNER_NULL;
> > > >    	int loop = 0;
> > > >    	u64 rspin_threshold = 0;
> > > > +	unsigned long nonspinnable = wlock ? RWSEM_WR_NONSPINNABLE
> > > > +					   : RWSEM_RD_NONSPINNABLE;
> > > >    	/* sem->wait_lock should not be held when doing optimistic spinning */
> > > >    	if (!osq_lock(&sem->osq))
> > > > @@ -836,14 +918,15 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
> > > >    	for (;;) {
> > > >    		enum owner_state owner_state;
> > > > -		owner_state = rwsem_spin_on_owner(sem);
> > > > +		owner_state = rwsem_spin_on_owner(sem, nonspinnable);
> > > >    		if (!(owner_state & OWNER_SPINNABLE))
> > > >    			break;
> > > >    		/*
> > > >    		 * Try to acquire the lock
> > > >    		 */
> > > > -		taken = rwsem_try_write_lock_unqueued(sem);
> > > > +		taken = wlock ? rwsem_try_write_lock_unqueued(sem)
> > > > +			      : rwsem_try_read_lock_unqueued(sem);
> > > >    		if (taken)
> > > >    			break;
> > > > @@ -851,7 +934,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
> > > >    		/*
> > > >    		 * Time-based reader-owned rwsem optimistic spinning
> > > >    		 */
> > > > -		if (owner_state == OWNER_READER) {
> > > > +		if (wlock && (owner_state == OWNER_READER)) {
> > > >    			/*
> > > >    			 * Re-initialize rspin_threshold every time when
> > > >    			 * the owner state changes from non-reader to reader.
> > > > @@ -860,7 +943,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
> > > >    			 * the beginning of the 2nd reader phase.
> > > >    			 */
> > > >    			if (prev_owner_state != OWNER_READER) {
> > > > -				if (rwsem_test_oflags(sem, RWSEM_NONSPINNABLE))
> > > > +				if (rwsem_test_oflags(sem, nonspinnable))
> > > >    					break;
> > > >    				rspin_threshold = rwsem_rspin_threshold(sem);
> > > >    				loop = 0;
> > > > @@ -935,30 +1018,89 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
> > > >    }
> > > >    /*
> > > > - * Clear the owner's RWSEM_NONSPINNABLE bit if it is set. This should
> > > > + * Clear the owner's RWSEM_WR_NONSPINNABLE bit if it is set. This should
> > > >     * only be called when the reader count reaches 0.
> > > > + *
> > > > + * This give writers better chance to acquire the rwsem first before
> > > > + * readers when the rwsem was being held by readers for a relatively long
> > > > + * period of time. Race can happen that an optimistic spinner may have
> > > > + * just stolen the rwsem and set the owner, but just clearing the
> > > > + * RWSEM_WR_NONSPINNABLE bit will do no harm anyway.
> > > >     */
> > > > -static inline void clear_nonspinnable(struct rw_semaphore *sem)
> > > > +static inline void clear_wr_nonspinnable(struct rw_semaphore *sem)
> > > >    {
> > > > -	if (unlikely(rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)))
> > > > -		atomic_long_andnot(RWSEM_NONSPINNABLE, &sem->owner);
> > > > +	if (unlikely(rwsem_test_oflags(sem, RWSEM_WR_NONSPINNABLE)))
> > > > +		atomic_long_andnot(RWSEM_WR_NONSPINNABLE, &sem->owner);
> > > > +}
> > > > +
> > > > +/*
> > > > + * This function is called when the reader fails to acquire the lock via
> > > > + * optimistic spinning. In this case we will still attempt to do a trylock
> > > > + * when comparing the rwsem state right now with the state when entering
> > > > + * the slowpath indicates that the reader is still in a valid reader phase.
> > > > + * This happens when the following conditions are true:
> > > > + *
> > > > + * 1) The lock is currently reader owned, and
> > > > + * 2) The lock is previously not reader-owned or the last read owner changes.
> > > > + *
> > > > + * In the former case, we have transitioned from a writer phase to a
> > > > + * reader-phase while spinning. In the latter case, it means the reader
> > > > + * phase hasn't ended when we entered the optimistic spinning loop. In
> > > > + * both cases, the reader is eligible to acquire the lock. This is the
> > > > + * secondary path where a read lock is acquired optimistically.
> > > > + *
> > > > + * The reader non-spinnable bit wasn't set at time of entry or it will
> > > > + * not be here at all.
> > > > + */
> > > > +static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
> > > > +					      unsigned long last_rowner)
> > > > +{
> > > > +	unsigned long owner = atomic_long_read(&sem->owner);
> > > > +
> > > > +	if (!(owner & RWSEM_READER_OWNED))
> > > > +		return false;
> > > > +
> > > > +	if (((owner ^ last_rowner) & ~RWSEM_OWNER_FLAGS_MASK) &&
> > > > +	    rwsem_try_read_lock_unqueued(sem)) {
> > > > +		lockevent_inc(rwsem_opt_rlock2);
> > > > +		lockevent_add(rwsem_opt_fail, -1);
> > > > +		return true;
> > > > +	}
> > > > +	return false;
> > > > +}
> > > > +
> > > > +static inline bool rwsem_no_spinners(struct rw_semaphore *sem)
> > > > +{
> > > > +	return !osq_is_locked(&sem->osq);
> > > >    }
> > > >    #else
> > > > -static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
> > > > +static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
> > > > +					   unsigned long nonspinnable)
> > > >    {
> > > >    	return false;
> > > >    }
> > > > -static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem)
> > > > +static inline bool rwsem_optimistic_spin(struct rw_semaphore *sem, bool wlock)
> > > >    {
> > > >    	return false;
> > > >    }
> > > > -static inline void clear_nonspinnable(struct rw_semaphore *sem) { }
> > > > +static inline void clear_wr_nonspinnable(struct rw_semaphore *sem) { }
> > > > +
> > > > +static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
> > > > +					      unsigned long last_rowner)
> > > > +{
> > > > +	return false;
> > > > +}
> > > > +
> > > > +static inline bool rwsem_no_spinners(sem)
> > > > +{
> > > > +	return false;
> > > > +}
> > > >    static inline enum owner_state
> > > > -rwsem_spin_on_owner(struct rw_semaphore *sem)
> > > > +rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
> > > >    {
> > > >    	return OWNER_NONSPINNABLE;
> > > >    }
> > > > @@ -984,7 +1126,7 @@ static inline void rwsem_cond_wake_waiter(struct rw_semaphore *sem, long count,
> > > >    		wake_type = RWSEM_WAKE_READERS;
> > > >    	} else {
> > > >    		wake_type = RWSEM_WAKE_ANY;
> > > > -		clear_nonspinnable(sem);
> > > > +		clear_wr_nonspinnable(sem);
> > > >    	}
> > > >    	rwsem_mark_wake(sem, wake_type, wake_q);
> > > >    }
> > > > @@ -995,32 +1137,66 @@ static inline void rwsem_cond_wake_waiter(struct rw_semaphore *sem, long count,
> > > >    static struct rw_semaphore __sched *
> > > >    rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int state)
> > > >    {
> > > > -	long adjustment = -RWSEM_READER_BIAS;
> > > > +	long owner, adjustment = -RWSEM_READER_BIAS;
> > > >    	long rcnt = (count >> RWSEM_READER_SHIFT);
> > > >    	struct rwsem_waiter waiter;
> > > >    	DEFINE_WAKE_Q(wake_q);
> > > >    	/*
> > > >    	 * To prevent a constant stream of readers from starving a sleeping
> > > > -	 * waiter, don't attempt optimistic lock stealing if the lock is
> > > > -	 * currently owned by readers.
> > > > +	 * waiter, don't attempt optimistic spinning if the lock is currently
> > > > +	 * owned by readers.
> > > >    	 */
> > > > -	if ((atomic_long_read(&sem->owner) & RWSEM_READER_OWNED) &&
> > > > -	    (rcnt > 1) && !(count & RWSEM_WRITER_LOCKED))
> > > > +	owner = atomic_long_read(&sem->owner);
> > > > +	if ((owner & RWSEM_READER_OWNED) && (rcnt > 1) &&
> > > > +	   !(count & RWSEM_WRITER_LOCKED))
> > > >    		goto queue;
> > > >    	/*
> > > > -	 * Reader optimistic lock stealing.
> > > > +	 * Reader optimistic lock stealing
> > > > +	 *
> > > > +	 * We can take the read lock directly without doing
> > > > +	 * rwsem_optimistic_spin() if the conditions are right.
> > > > +	 * Also wake up other readers if it is the first reader.
> > > >    	 */
> > > > -	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF))) {
> > > > +	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF)) &&
> > > > +	    rwsem_no_spinners(sem)) {
> > > >    		rwsem_set_reader_owned(sem);
> > > >    		lockevent_inc(rwsem_rlock_steal);
> > > > +		if (rcnt == 1)
> > > > +			goto wake_readers;
> > > > +		return sem;
> > > > +	}
> > > > +
> > > > +#ifdef CONFIG_RWSEM_SPIN_ON_OWNER
> > > > +	if (!rwsem_opt_rspin)
> > > > +		goto queue;
> > > > +#endif
> > > I would suggest changing that to

I will change to like this.

> > > 
> > > if (!IS_ENABLED(CONFIG_RWSEM_SPIN_ON_OWNER) || !rwsem_opt_rspin)
> > >  ������� goto queue;
> > > 
> > > > +	/*
> > > > +	 * Save the current read-owner of rwsem, if available, and the
> > > > +	 * reader nonspinnable bit.
> > > > +	 */
> > > > +	waiter.last_rowner = owner;
> > > > +	if (!(waiter.last_rowner & RWSEM_READER_OWNED))
> > > > +		waiter.last_rowner &= RWSEM_RD_NONSPINNABLE;
> > > > +
> > > > +	if (!rwsem_can_spin_on_owner(sem, RWSEM_RD_NONSPINNABLE))
> > > > +		goto queue;
> > > > +
> > > > +	/*
> > > > +	 * Undo read bias from down_read() and do optimistic spinning.
> > > > +	 */
> > > > +	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
> > > > +	adjustment = 0;
> > > > +	if (rwsem_optimistic_spin(sem, false)) {
> > > > +		/* rwsem_optimistic_spin() implies ACQUIRE on success */
> > > >    		/*
> > > > -		 * Wake up other readers in the wait queue if it is
> > > > -		 * the first reader.
> > > > +		 * Wake up other readers in the wait list if the front
> > > > +		 * waiter is a reader.
> > > >    		 */
> > > > -		if ((rcnt == 1) && (count & RWSEM_FLAG_WAITERS)) {
> > > > +wake_readers:
> > > > +		if ((atomic_long_read(&sem->count) & RWSEM_FLAG_WAITERS)) {
> > > >    			raw_spin_lock_irq(&sem->wait_lock);
> > > >    			if (!list_empty(&sem->wait_list))
> > > >    				rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
> > > > @@ -1029,6 +1205,9 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
> > > >    			wake_up_q(&wake_q);
> > > >    		}
> > > >    		return sem;
> > > > +	} else if (rwsem_reader_phase_trylock(sem, waiter.last_rowner)) {
> > > > +		/* rwsem_reader_phase_trylock() implies ACQUIRE on success */
> > > > +		return sem;
> > > >    	}
> > > >    queue:
> > > > @@ -1045,7 +1224,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
> > > >    		 * immediately as its RWSEM_READER_BIAS has already been set
> > > >    		 * in the count.
> > > >    		 */
> > > > -		if (!(atomic_long_read(&sem->count) & RWSEM_WRITER_MASK)) {
> > > > +		if (adjustment && !(atomic_long_read(&sem->count) &
> > > > +		     RWSEM_WRITER_MASK)) {
> > > >    			/* Provide lock ACQUIRE */
> > > >    			smp_acquire__after_ctrl_dep();
> > > >    			raw_spin_unlock_irq(&sem->wait_lock);
> > > > @@ -1058,7 +1238,10 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
> > > >    	rwsem_add_waiter(sem, &waiter);
> > > >    	/* we're now waiting on the lock, but no longer actively locking */
> > > > -	count = atomic_long_add_return(adjustment, &sem->count);
> > > > +	if (adjustment)
> > > > +		count = atomic_long_add_return(adjustment, &sem->count);
> > > > +	else
> > > > +		count = atomic_long_read(&sem->count);
> > > >    	rwsem_cond_wake_waiter(sem, count, &wake_q);
> > > >    	raw_spin_unlock_irq(&sem->wait_lock);
> > > > @@ -1100,21 +1283,43 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
> > > >    	return ERR_PTR(-EINTR);
> > > >    }
> > > > +/*
> > > > + * This function is called by the a write lock owner. So the owner value
> > > > + * won't get changed by others.
> > > > + */
> > > > +static inline void rwsem_disable_reader_optspin(struct rw_semaphore *sem,
> > > > +						bool disable)
> > > > +{
> > > > +	if (unlikely(disable)) {
> > > > +		atomic_long_or(RWSEM_RD_NONSPINNABLE, &sem->owner);
> > > > +		lockevent_inc(rwsem_opt_norspin);
> > > > +	}
> > > > +}
> > > > +
> > > >    /*
> > > >     * Wait until we successfully acquire the write lock
> > > >     */
> > > >    static struct rw_semaphore __sched *
> > > >    rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
> > > >    {
> > > > +	bool disable_rspin;
> > > >    	struct rwsem_waiter waiter;
> > > >    	DEFINE_WAKE_Q(wake_q);
> > > >    	/* do optimistic spinning and steal lock if possible */
> > > > -	if (rwsem_can_spin_on_owner(sem) && rwsem_optimistic_spin(sem)) {
> > > > +	if (rwsem_can_spin_on_owner(sem, RWSEM_WR_NONSPINNABLE) &&
> > > > +	    rwsem_optimistic_spin(sem, true)) {
> > > >    		/* rwsem_optimistic_spin() implies ACQUIRE on success */
> > > >    		return sem;
> > > >    	}
> > > > +	/*
> > > > +	 * Disable reader optimistic spinning for this rwsem after
> > > > +	 * acquiring the write lock when the setting of the nonspinnable
> > > > +	 * bits are observed.
> > > > +	 */
> > > > +	disable_rspin = atomic_long_read(&sem->owner) & RWSEM_NONSPINNABLE;
> > > > +
> > > >    	/*
> > > >    	 * Optimistic spinning failed, proceed to the slowpath
> > > >    	 * and block until we can acquire the sem.
> > > > @@ -1170,7 +1375,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
> > > >    		if (waiter.handoff_set) {
> > > >    			enum owner_state owner_state;
> > > > -			owner_state = rwsem_spin_on_owner(sem);
> > > > +			owner_state = rwsem_spin_on_owner(sem, RWSEM_NONSPINNABLE);
> > > >    			if (owner_state == OWNER_NULL)
> > > >    				goto trylock_again;
> > > >    		}
> > > > @@ -1182,6 +1387,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
> > > >    		raw_spin_lock_irq(&sem->wait_lock);
> > > >    	}
> > > >    	__set_current_state(TASK_RUNNING);
> > > > +	rwsem_disable_reader_optspin(sem, disable_rspin);
> > > >    	raw_spin_unlock_irq(&sem->wait_lock);
> > > >    	lockevent_inc(rwsem_wlock);
> > > >    	trace_contention_end(sem, 0);
> > > > @@ -1348,7 +1554,7 @@ static inline void __up_read(struct rw_semaphore *sem)
> > > >    	DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
> > > >    	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
> > > >    		      RWSEM_FLAG_WAITERS)) {
> > > > -		clear_nonspinnable(sem);
> > > > +		clear_wr_nonspinnable(sem);
> > > >    		rwsem_wake(sem);
> > > >    	}
> > > >    	preempt_enable();
> > > I don't have a strong feeling pro or against it. It does provide a modest
> > > improvement in some use cases, but it does make the code a bit more complex
> > > and harder to understand.
> > > 
> > > Cheers,
> > > Longman
> > > 

In mobile device, application launch time diff about 4% is not small.
We are working hard to make any improvement for this.
In my opinion, reader optimistic spinning is still helpful in light workload environment.
Is this patch acceptable? If so, I will send the new patch for fix about your comments.

Thanks,
Bongkyu

> > > 
> > > 
> 
> 

------Ia-OLKm9_0_1EVAmMXMmkTXXjuT3FhFkrC5bjtmjvll7fXt0=_aebb7_
Content-Type: text/plain; charset="utf-8"


------Ia-OLKm9_0_1EVAmMXMmkTXXjuT3FhFkrC5bjtmjvll7fXt0=_aebb7_--
