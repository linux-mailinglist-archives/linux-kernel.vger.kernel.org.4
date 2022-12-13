Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C0A64C0F6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbiLMXyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbiLMXyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:54:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74161114E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670975638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8kNUFsiSapaEOV7ygdQ/RnZuA4WU7ECuH6Dq3VkyTdI=;
        b=LYcTaHOrEMtbLz1A7e8dVz8cdLsH/rQEErj9d1btmPu4PAxDfdWNO/doxARZJu9OaqG4jp
        sepbKKcI77NXsrxmvVxh/pK2OvhsrmLxjjjR1jRWLgL0aEWw0khuNjnz4K7wgtAr4tAEGg
        nQ+yjrNdKMUua8B3dMR/lCcAR/6aTG8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-317-kJiZCHGyPDmVgIK-CabHSQ-1; Tue, 13 Dec 2022 18:53:57 -0500
X-MC-Unique: kJiZCHGyPDmVgIK-CabHSQ-1
Received: by mail-yb1-f199.google.com with SMTP id i19-20020a253b13000000b0070358cca7f7so18370709yba.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kNUFsiSapaEOV7ygdQ/RnZuA4WU7ECuH6Dq3VkyTdI=;
        b=mUr7tv0LG9iX8bcDUNdXn1HckoodVqDgVh9BaLNLfjvChtbAqmbvCJ2cIsxdHK9caV
         P+Lh7vGGlxv5DIHB6EQfua4RFseUDo9BtDBvkVE64SWG6CVjlGxEhNdCgQjHEkKFZrmQ
         /RUBG9Ih2IAZZEFnHsoyBI+doQGc4eqpQaaZuX1of8zFV+ak+lS69M+lGYmUagK1ctfR
         YL4KAReQtndJ4LaWfMQu36+OaYFqeMWo3paWpXcX/Dw8887XGYjYXbbh8aE2kyuQmq8X
         oE+/PRHFA6D1PXdCkmmM0DJvRlJjSyXuef4AyQ91QVFgscxlOr7z2rUFsZrPHiY48JUH
         tGVA==
X-Gm-Message-State: ANoB5plaVqa8VmEJ3Un1pMWWOz7uL75g1tcqw8f69FBglvw33jiMdjBo
        ybAg6GcQo8obdOBBoVcQijepDZTWUko9psS+Ak70FF+BI3RVrhZozasgiUp/GFQVXBG+WKDTkKF
        rRv7fO0BqpsNQ84uZgVr6lfxUYM9dJUQBZqiufdRr
X-Received: by 2002:a81:c86:0:b0:3f0:3355:86f2 with SMTP id 128-20020a810c86000000b003f0335586f2mr17786210ywm.88.1670975636972;
        Tue, 13 Dec 2022 15:53:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf51Jqh+4WEJhTU4iZtLHU49d0jUgx/pvRdiDLO5I6Ppy8t6dKAAJVVlZreokulIGnI/17grT6Iw71IV+auKuMo=
X-Received: by 2002:a81:c86:0:b0:3f0:3355:86f2 with SMTP id
 128-20020a810c86000000b003f0335586f2mr17786202ywm.88.1670975636731; Tue, 13
 Dec 2022 15:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20221213234505.173468-1-npache@redhat.com> <Y5kPKpNp5qCnZEWy@monkey>
In-Reply-To: <Y5kPKpNp5qCnZEWy@monkey>
From:   Nico Pache <npache@redhat.com>
Date:   Tue, 13 Dec 2022 16:53:30 -0700
Message-ID: <CAA1CXcB653kDtF90oWUgVA3TDUrJHac-WPe1HdsQtRwtN5B3gA@mail.gmail.com>
Subject: Re: [RFC V2] mm: add the zero case to page[1].compound_nr in set_compound_order
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        willy@infradead.org, gerald.schaefer@linux.ibm.com,
        sidhartha.kumar@oracle.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Thanks for the pointer! Would the branchless conditional be an
improvement over the current approach? I'm not sure how hot this path
is, but it may be worth the optimization.

-- Nico

On Tue, Dec 13, 2022 at 4:48 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 12/13/22 16:45, Nico Pache wrote:
> > Since commit 1378a5ee451a ("mm: store compound_nr as well as
> > compound_order") the page[1].compound_nr must be explicitly set to 0 if
> > calling set_compound_order(page, 0).
> >
> > This can lead to bugs if the caller of set_compound_order(page, 0) forgets
> > to explicitly set compound_nr=0. An example of this is commit ba9c1201beaa
> > ("mm/hugetlb: clear compound_nr before freeing gigantic pages")
>
> There has been some recent work in this area.  The latest patch being,
> https://lore.kernel.org/linux-mm/20221213212053.106058-1-sidhartha.kumar@oracle.com/
>
> --
> Mike Kravetz
>

