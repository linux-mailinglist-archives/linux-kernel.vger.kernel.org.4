Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43268748931
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjGEQ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjGEQ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:27:53 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEEF1703
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 09:27:52 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40371070eb7so452251cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 09:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688574471; x=1691166471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+b6HdBO2HTE2Fgq56si0I6hn366dTE1zq4yHg6W9Y0=;
        b=DyQIomzb0HGOrjSSZzDc25EbIFtjXS02c4XUBPZ89883pZrEXwEqIvAqTPU5izH4tI
         YzCv1bHM84pr9hrlxKNebT/aMAWEgU3frR2KZs+O82khTXgvFU6GKExm2m8fgSwVZTs4
         N39yAxRq/LR4kfzHKjQ0el059sAmyDJchQJczSYHkJC8BKElkfESrFOV0WHqSP6P/ugT
         luZXSTTdIk1EcOK7bzX/Nmoey5akNpKPAGMDet04pI/vuQjxeDl89JFrRizqnnzdAqv+
         +YJyEP+IyDmcRoyrqFke90XH4sLRTtB/CQJ+g9SKiCkYmIYqjAatKt5PLteziZEuBq5g
         RNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688574471; x=1691166471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+b6HdBO2HTE2Fgq56si0I6hn366dTE1zq4yHg6W9Y0=;
        b=M0b0cThM+EchGms4diDwf3Rza2N2XRgDXFTCCQKz+OulSYwqpboDgMghXuwhZka8Yd
         R/tn5vrv7RjKc8IXQGgEr8ILvJTANZA4Xhjve0prN3R2ACAY3DBqUYdpFmnkPNwE4RVO
         CjgqpMEh8xti/DqjalHS7MYefBpAlkilwDoiHjtNpr8ZyS7KjwdsRTT6h4uEoTLjYBxy
         kRtTJlaZ5sNJ/+0yd1wTCSA02/kjW5ZN9txElfCgSSrU5Uhqy2rneu+z2eglDNHegT3Q
         0WScrSRJcouPXwXbuY6o4BYX4gy2JbM+pM1i85QYQe12IuQvdBbONzWKCR6sivRFeE/N
         DBIw==
X-Gm-Message-State: ABy/qLZ8y0Uj9PL6vYDayn5fAnCcw3x3CXhRLrIsMs7P7hEC2NMObAx/
        XbCCDHis/oQg7jq54nUueib0TtS8ip+Tg6CVRnrslw==
X-Google-Smtp-Source: APBJJlGP8NPgExSaXIUaVZ5PBn6mZl70QFsmuVh+N8HQEo6jxCLPsG280YnB5ou2hwdGWMkQaNU4v0hovbQymt4kJrw=
X-Received: by 2002:a05:622a:2d6:b0:3f8:5b2:aef4 with SMTP id
 a22-20020a05622a02d600b003f805b2aef4mr135081qtx.28.1688574471033; Wed, 05 Jul
 2023 09:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230629205040.665834-1-axelrasmussen@google.com>
 <ZKSDLogLASaZgKCP@x1n> <CADrL8HXp-P44VxTXdJMkzSgPC8r_b0T21_cuPCTNy6Ub2PFBKA@mail.gmail.com>
 <ZKWXGnSKcOdnaeJw@x1n>
In-Reply-To: <ZKWXGnSKcOdnaeJw@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 5 Jul 2023 09:27:15 -0700
Message-ID: <CADrL8HWO8g2-YdUtyLM6e+f1VJq6YV-b1_rj-beEh2C84kAgEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mm: userfaultfd: add new UFFDIO_POISON ioctl
To:     Peter Xu <peterx@redhat.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 9:15=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jul 05, 2023 at 09:09:19AM -0700, James Houghton wrote:
> > > > diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> > > > index 4c932cb45e0b..8259fee32421 100644
> > > > --- a/include/linux/swapops.h
> > > > +++ b/include/linux/swapops.h
> > > > @@ -394,7 +394,8 @@ typedef unsigned long pte_marker;
> > > >
> > > >  #define  PTE_MARKER_UFFD_WP                  BIT(0)
> > > >  #define  PTE_MARKER_SWAPIN_ERROR             BIT(1)
> > > > -#define  PTE_MARKER_MASK                     (BIT(2) - 1)
> > > > +#define  PTE_MARKER_UFFD_POISON                      BIT(2)
> > >
> > > One more tab.
> > >
> > > Though I remembered the last time we discussed IIRC we plan to rename
> > > SWAPIN_ERROR and reuse it, could you explain why a new bit is still n=
eeded?
> > >
> > > I think I commented this but I'll do it again: IIUC any existing host
> > > swapin errors for guest pages should be reported as MCE too, afaict,
> > > happened in kvm context.
> >
> > I think swapin errors are treated differently than poison. Swapin
> > errors get VM_FAULT_SIGBUS, and poison gets VM_FAULT_HWPOISON, so
> > UFFDIO_POISON should also get VM_FAULT_HWPOISON (so that's what Axel
> > has implemented). And I think that needs a separate PTE marker.
>
> My question was, should we also make SWAPIN_ERROR return VM_FAULT_HWPOISO=
N
> always?
>
> Just to recap from what I already commented above - if a guest page got
> error in swapin due to block sector failures, it should be treated as
> VM_FAULT_HWPOISON too, IMHO.  IOW, I think current SWAPIN_ERROR is wrong
> when in kvm context and we should fix it first.

Oh! Yes, I agree, though I'm not familiar enough with the users of
SWAPIN_ERROR to know if we can actually make this change.
