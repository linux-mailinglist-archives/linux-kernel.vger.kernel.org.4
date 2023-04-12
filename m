Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E20C6DFF58
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjDLUBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjDLUBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:01:34 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F764ED8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:01:29 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id z1so3358404qti.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1681329688; x=1683921688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o5q/MDP7b8EY8/uHOBhi/czXTo+bJcB+b/n0D+eyPs=;
        b=kGXowdrE9W59nhkKnD88XHCg63cI/CqPa2scem6wKxFDpSAPt/BNBueuu7ShliBJ78
         wxLCHq+TtYFXBSQNHs8Nv6yk2fcXvqWKV45kdGfURW5yA2mLVq7L51grs6e1JhRe4RSR
         ovfjg4HlZQbFX/Y1X/vnX6nzLvH8MlLAPaJkuBXRkJgprsOZe/nhTQpysj6MGhOvQlva
         Xzs4nxZYPvOYqD+gz41fEwTVvHXHS2CKtLnyVE1LGq9K0ae4/eu+ylrUAHPFASDuUrgK
         9oYW0ByA68z0Rnf86QWJtLsVq69TJIdLdf2BRk1V7MJgy2r/yU/GzI6TCuN7uao4WLub
         rGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681329688; x=1683921688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o5q/MDP7b8EY8/uHOBhi/czXTo+bJcB+b/n0D+eyPs=;
        b=SL2t9+O6BXwVJGFy6YjPJhqpv5K8RTIomwkrE37xw6btR4Fqpy7tAqSGRocJ0azuGz
         A/OVcxLWlMKXK/qxXIdHAORWnqw9BS2+/EdSL48C56oi012+QvvDF4HJxUlbAtXViRq6
         GAsvnrlX/J5K67qUS6kIahVCAlRJXDg3kPEylI2FiABfiIeCKqSYTCIr70lCjU56Kvcv
         KzAe3e2nntZ/qSG20Ah2BM3g1F5BbtXebayBpW/6toh8sjNiEYGjzPXe2f5T6C3BfPzz
         cf4bSQKW2yDuajHmNJpBlfrvLXmdkGKRnLPxz0ZO+HgtD8P1pHTku7wzTfgGH0bCdYsS
         EZbw==
X-Gm-Message-State: AAQBX9cX/mKm1FLDHHB5xfyWmLL7hIkJK5ameQnh3OnHV5a+O7jOExOF
        rrcgOGr8bH6fBAJ6e5w9ZUKFnPJyFkCtdT/ErJ2Zgw==
X-Google-Smtp-Source: AKy350aJ2bGrBAa+qz/GVnNDct6ZDcVSq7qR/7xS3x1LoUoCQczyFrcqsBPZR9REagIaXCeiFX+vDzCHUPX5OaLJ5hc=
X-Received: by 2002:a05:622a:1815:b0:3df:4392:1aff with SMTP id
 t21-20020a05622a181500b003df43921affmr2603706qtc.6.1681329688375; Wed, 12 Apr
 2023 13:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230412152337.1203254-1-pasha.tatashin@soleen.com>
 <63736432-5cef-f67c-c809-cc19b236a7f4@google.com> <20230412195723.GA4759@monkey>
In-Reply-To: <20230412195723.GA4759@monkey>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 12 Apr 2023 16:00:52 -0400
Message-ID: <CA+CK2bBVAUibUvajJP6Xvo-cYuBe57GBqZsjsc4fiKUoYmnxXQ@mail.gmail.com>
Subject: Re: [PATCH] mm: hugetlb_vmemmap: provide stronger vmemmap allocaction gurantees
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, souravpanda@google.com,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 3:57=E2=80=AFPM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> On 04/12/23 10:54, David Rientjes wrote:
> > On Wed, 12 Apr 2023, Pasha Tatashin wrote:
> >
> > > HugeTLB pages have a struct page optimizations where struct pages for=
 tail
> > > pages are freed. However, when HugeTLB pages are destroyed, the memor=
y for
> > > struct pages (vmemmap) need to be allocated again.
> > >
> > > Currently, __GFP_NORETRY flag is used to allocate the memory for vmem=
map,
> > > but given that this flag makes very little effort to actually reclaim
> > > memory the returning of huge pages back to the system can be problem.=
 Lets
> > > use __GFP_RETRY_MAYFAIL instead. This flag is also performs graceful
> > > reclaim without causing ooms, but at least it may perform a few retri=
es,
> > > and will fail only when there is genuinely little amount of unused me=
mory
> > > in the system.
> > >
> >
> > Thanks Pasha, this definitely makes sense.  We want to free the hugetlb
> > page back to the system so it would be a shame to have to strand it in =
the
> > hugetlb pool because we can't allocate the tail pages (we want to free
> > more memory than we're allocating).
>
> Agree.
>
> The hugetlb vmemmmap freeing series went through more than 20 revisions
> before being merged.  One issue with much discussion was the need to
> allocate vmemmap pages when hugetlb pages were returned to buddy.
>
> It looks like the current set of GFP flags was suggested here:
> https://lore.kernel.org/linux-mm/YC4ji+pMhtOs+KVM@dhcp22.suse.cz/
>
> Although, it was also mentioned that __GFP_RETRY_MAYFAIL could be used
> instead of __GFP_NORETRY here:
> https://lore.kernel.org/linux-mm/YCafit5ruRJ+SL8I@dhcp22.suse.cz/
>
> Adding Michal on Cc: since these were his suggestions.

Thank you for the background Mike. I have sent the 2nd version, and
added Michal into that patch.

Pasha
