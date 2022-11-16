Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C230162CEB8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiKPXaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKPXaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:30:13 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B7468299
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:30:12 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 205so8394079ybe.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a2sf9AhIyxwq3f7k04xbxV/djLKynzQPlhmCrV1ud2M=;
        b=Qo93yHrO/cjY0wFuD2EmAVOKPCsf6ZPhGey4RKIkCNkiGFyxwZxmS/00l1hMtoGOD0
         U7ZJUzKaZnStQ3IBcuGbDogIr4AcCA1i66bIXX7P4OVW9AegLXaNnDveWZZqOFul6ZQe
         e+D3KRM5TdZZ4L1y8xCyexo972WrN4hK89Gc43LeEjwSIVKNuFN2w607uQeozB6KZp8H
         qm6Kki0qt7dtAjDS+4qPMRrBBfL4ursRZ1ZkVbhiK7RafVaRtELV32mKv+3wICMC8bW+
         /Vr1lIPw74pG891UsMSHGRdh7uWMfi6kW0kzCHZ/lPbILUgK6pP/NRBTiSQOydfGAfS1
         QMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2sf9AhIyxwq3f7k04xbxV/djLKynzQPlhmCrV1ud2M=;
        b=kw49hohnpzYe/1IpT6uLbM5OcyhWccr6OR8jY7383EIgC3MopvTkjJem/x2EviMQW7
         gIfDiIiuzhZYhpBoaEiR6VPmB73mrZMrs5GEKyxelrdHDfxWqT/EUmXo5sJr3rxKkOqC
         6rY9CClNrV1go+5com+CscvWQg1CGfFgmpOxFC28viWT4lUkNlsLov3KACSLRoSDM5im
         rH1GruHq8+nVHlW6NzyLnzwcTyfQP40GiufGFk7cYNQ3fbKRT0bX1v4O75kNop6EhcGT
         nwwDAcpJnjupop0MU9VwJinHMG7r1lWDXQIFR5G34wyIUPDCQpLIxxd5JxZ7ApRmBX1d
         No3A==
X-Gm-Message-State: ANoB5pllanQpOKAK5ITCIjCXqUoplEcLzq/pbeK3yB18dVEZ0vCHekaw
        gUUyx1lJAHQmv8FtjnV5pdrqE5Wjom1/tZRuyj5cAg==
X-Google-Smtp-Source: AA0mqf7bMhtWNzeLubNMtXbobUmsjuWfRrz+dR3YatVt5qGdk3EPTgP/Uo7EWjEg3KGlOYv382zPgQUp5FnoXWdjlkM=
X-Received: by 2002:a25:bfcf:0:b0:6b9:616:6994 with SMTP id
 q15-20020a25bfcf000000b006b906166994mr6881ybm.126.1668641411295; Wed, 16 Nov
 2022 15:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
 <20221021163703.3218176-34-jthoughton@google.com> <Y3VkIdVKRuq+fO0N@x1n>
In-Reply-To: <Y3VkIdVKRuq+fO0N@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 16 Nov 2022 15:30:00 -0800
Message-ID: <CADrL8HXixUPyTVmYMiwc11Ot5sDMsA3x7VhgXQjimJ93MSZihA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 33/47] userfaultfd: add UFFD_FEATURE_MINOR_HUGETLBFS_HGM
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 2:28 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Oct 21, 2022 at 04:36:49PM +0000, James Houghton wrote:
> > Userspace must provide this new feature when it calls UFFDIO_API to
> > enable HGM. Userspace can check if the feature exists in
> > uffdio_api.features, and if it does not exist, the kernel does not
> > support and therefore did not enable HGM.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
>
> It's still slightly a pity that this can only be enabled by an uffd context
> plus a minor fault, so generic hugetlb users cannot directly leverage this.

The idea here is that, for applications that can conceivably benefit
from HGM, we have a mechanism for enabling it for that application. So
this patch creates that mechanism for userfaultfd/UFFDIO_CONTINUE. I
prefer this approach over something more general like MADV_ENABLE_HGM
or something.

For hwpoison, HGM will be automatically enabled, but that isn't
implemented in this series. We could also extend MADV_DONTNEED to do
high-granularity unmapping in some way, but that also isn't attempted
here. I'm sure that if there are other cases where HGM may be useful,
we can add/change some uapi to make it possible to take advantage HGM.

- James

>
> The patch itself looks good.
>
> --
> Peter Xu
>
