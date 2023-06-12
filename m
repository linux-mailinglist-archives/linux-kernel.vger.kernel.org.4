Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D7C72CED3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbjFLS6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjFLS6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A9BB7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686596243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZmIquouHkn7x7g5U3IKxu0y2ezu2hrVL9nMe9oPXqp4=;
        b=LcDgf3QMX/cgLo7n59BV2jOHkdIsDpMxPceWbq2YfaG7bKB02NeKkomZ8Ed9j2S3x7FXvC
        FynsagUJq4/f7FXObYYtXA/+jCq64XPF6pEzE3RbQekNeQC3BL8VLIyIuDjvxND9bxaQ1P
        WcmV7Dhw/a1YWRom6jfblJf+/KajpeY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-uz1MCwERNj2yoFF78lnPsQ-1; Mon, 12 Jun 2023 14:57:21 -0400
X-MC-Unique: uz1MCwERNj2yoFF78lnPsQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3f86a3ce946so10532101cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686596241; x=1689188241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmIquouHkn7x7g5U3IKxu0y2ezu2hrVL9nMe9oPXqp4=;
        b=RSlyW92SOcHqiH7jeN5uhs3+vP9czRyUpOjj2njD4aci6v6ysZeWD7+1t/OQh86onO
         TORJuEFNxJVWSDX623tX4+cDgyc5SWItqAGAAStx3qpxOlx+brodjrKmlEtmAxZ2sRYZ
         rtsWLumCDqJ/G2EjlDzeJZA30K8sTZFugG4AibfHnmXKSZZpiC38jgI79dUVYC23rZRy
         iL15yr5KlSd9dGvZgO0aX3gNqZVcV0ZpxtvnV5Y1QfZjR0qNzBvFOLVaxJZEsZArJTbv
         6woHAWnAHNt1mQ4zgJ/BwIE2pzLmDOBwr9nIyyGe/qoNBxiePA3PDgrdtZT3vAU116zX
         uEYw==
X-Gm-Message-State: AC+VfDyKpkEmNrsQtLHimtSjE+Mq54ApnKO+qEeJhfQR8krRLoxn5XWV
        LbyKXOPWikVjb7qK1CiuJ+L8z2P3P+LhFuRltkgUd4ukkX0/MCHx4ttEcy+SrxXCmht0xhT9+56
        Ok0InXoYcXb7bPEtRpewi3/6R
X-Received: by 2002:a05:6214:2b05:b0:62b:6c6f:b3e3 with SMTP id jx5-20020a0562142b0500b0062b6c6fb3e3mr12804200qvb.3.1686596241367;
        Mon, 12 Jun 2023 11:57:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6e6wlnXH8y0uBmHDsq+xF3VvQe8OmdmhPPpTZDH9TOC0T37Kc9khtjBeEOIaHB3qFNDKkviA==
X-Received: by 2002:a05:6214:2b05:b0:62b:6c6f:b3e3 with SMTP id jx5-20020a0562142b0500b0062b6c6fb3e3mr12804161qvb.3.1686596241115;
        Mon, 12 Jun 2023 11:57:21 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id h23-20020a0cab17000000b005f227de6b1bsm3397636qvb.116.2023.06.12.11.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:57:20 -0700 (PDT)
Date:   Mon, 12 Jun 2023 14:57:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 4/6] mm: drop VMA lock before waiting for migration
Message-ID: <ZIdqjoh+C6gNdlHY@x1n>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-5-surenb@google.com>
 <ZIOOmC26qh4EXUEX@x1n>
 <CAJuCfpHKUjAwgWbxvJQDyEnneRD03p2M6247Q6=3-oOq_FL7zA@mail.gmail.com>
 <CAJuCfpG3PrbGxpDAEkyGQXW88+otb=FsbrhPJ4ePN7Xhn0a+_A@mail.gmail.com>
 <ZIcfYQ1c5teMSHAX@x1n>
 <CAJuCfpGZvhBUdfNHojXwqZbspuhy0bstjT+-JMfwgmnqTnkoHA@mail.gmail.com>
 <ZIdlNj+X2HDwfCeN@x1n>
 <CAJuCfpH6tO8yo8YkUWWiLnkDUR0csdYyqVnuyGC+A-g3N_rKug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpH6tO8yo8YkUWWiLnkDUR0csdYyqVnuyGC+A-g3N_rKug@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:44:33AM -0700, Suren Baghdasaryan wrote:
> I think so. With that change getting VM_FAULT_RETRY in do_page_fault()
> will guarantee that per-vma lock was dropped. Is that what you mean?

Yes, with the newly added "return VM_FAULT_RETRY" in do_swap_page() for
per-vma lock removed.  AFAICT all the rest paths guaranteed that as long as
in the fault paths.

-- 
Peter Xu

