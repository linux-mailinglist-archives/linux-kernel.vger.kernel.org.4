Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AE063847B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKYHb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKYHbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:31:22 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954D52E9C7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:31:21 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id 11so2576277iou.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KrLjnZXippJMG/lNCJKnflO972Pkf957aUOtnF5EOhQ=;
        b=haYHYH2nF8mUWRPOyArS9Lquo1Kww6HkzfwKoZLO9HaWDCC4WGiPLe2Ir1dd4DjIYB
         U9Mj8dysCSNO7rNruG4n361D5cH85BnYslX6+OcWc4qUrQtITpvPfMjd5mxGCfe3YAti
         IQpsxRIQL0pbExdHgsh5XrHdk/C1RbLJ+RX1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrLjnZXippJMG/lNCJKnflO972Pkf957aUOtnF5EOhQ=;
        b=reEfu1aTSknylEnQvxUoW0KdKykg8b0KYgE9hcjlm/qsZvc5LDxKHfa/ayi4FKzbLZ
         1AuDGD7Xput0WBi+ZycHzCB23QwsnYdjPvhXVYI7ZzBf7LFLC/bVqawb5ZBDv19CTN+2
         pndLtjnS54OBY6dKqgrlP9QA3rd//3lmdp0rITyGsLl+iBnYlxl2I9ZAk1Rd0y8HoJdm
         CVHkqcStp5oq/lkWTPLAy257ullt1swir/guYOvY250VV43ZugcbFIReKzEuPs6KtYTC
         ZUaBW/y4iW8JC/hMY6jrYCxCXVZ6LcpHZfq8oK9GAOnVE185yHSz0bfaR6CWHh7P78Rf
         Q1Yg==
X-Gm-Message-State: ANoB5pmaZpsDbMbjQ66u03sDkj2N0uLpH0AQpMVtH1j1qnFkpIl3HGAq
        JDPNRQjbb9j7cV8RdHf3CvznAtBMAsVmfEMV
X-Google-Smtp-Source: AA0mqf5tzZY9SSCTr+e8kp+YxNefwnjAv7NMt53whGNyRLUNulZwHSuZJu9QEmH1vSq2VZXr464yCA==
X-Received: by 2002:a5e:9701:0:b0:6de:b4b5:490a with SMTP id w1-20020a5e9701000000b006deb4b5490amr11805291ioj.74.1669361480878;
        Thu, 24 Nov 2022 23:31:20 -0800 (PST)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id g6-20020a02a086000000b003754033c6aesm1162097jah.155.2022.11.24.23.31.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 23:31:18 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id j27so1666517ila.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:31:18 -0800 (PST)
X-Received: by 2002:a92:cb85:0:b0:302:624e:e49b with SMTP id
 z5-20020a92cb85000000b00302624ee49bmr15840843ilo.172.1669361477866; Thu, 24
 Nov 2022 23:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20221124-kexec-noalloc-v1-0-d78361e99aec@chromium.org>
 <Y4AvTEZiNXfFU1Wv@MiWiFi-R3L-srv> <CANiDSCsgFYvShoTo9xAPe0wqSJgTnB7ZgzXmNqD+L2cKdsVoRg@mail.gmail.com>
 <Y4BubEVKt78k8xaC@MiWiFi-R3L-srv>
In-Reply-To: <Y4BubEVKt78k8xaC@MiWiFi-R3L-srv>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 25 Nov 2022 08:31:06 +0100
X-Gmail-Original-Message-ID: <CANiDSCuy-uZ4r2x6xujiPGTowzN8JuOvTXh3r0Rc7J+YmpqZiw@mail.gmail.com>
Message-ID: <CANiDSCuy-uZ4r2x6xujiPGTowzN8JuOvTXh3r0Rc7J+YmpqZiw@mail.gmail.com>
Subject: Re: [PATCH] kexec: Enable runtime allocation of crash_image
To:     Baoquan He <bhe@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Philipp Rudo <prudo@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, 25 Nov 2022 at 08:27, Baoquan He <bhe@redhat.com> wrote:
>
> On 11/25/22 at 06:52am, Ricardo Ribalda wrote:
> > Hi Baoquan
> >
> > Thanks for your review!
> >
> > On Fri, 25 Nov 2022 at 03:58, Baoquan He <bhe@redhat.com> wrote:
> > >
> > > On 11/24/22 at 11:23pm, Ricardo Ribalda wrote:
> > > > Usually crash_image is defined statically via the crashkernel parameter
> > > > or DT.
> > > >
> > > > But if the crash kernel is not used, or is smaller than then
> > > > area pre-allocated that memory is wasted.
> > > >
> > > > Also, if the crash kernel was not defined at bootime, there is no way to
> > > > use the crash kernel.
> > > >
> > > > Enable runtime allocation of the crash_image if the crash_image is not
> > > > defined statically. Following the same memory allocation/validation path
> > > > that for the reboot kexec kernel.
> > >
> > > We don't check if the crashkernel memory region is valid in kernel, but
> > > we do have done the check in kexec-tools utility. Since both kexec_load and
> > > kexec_file_load need go through path of kexec-tools loading, we haven't
> > > got problem with lack of the checking in kernel.
> >
> > Not sure if I follow you.
> >
> > We currently check if the crash kernel is in the right place at
> > sanity_check_segment_list()
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kexec_core.c#n239
>
> And it's not checking if crashkernel memory is valid in
> sanity_check_segment_list(), right? It's checking if the segments
> are placed correctly.

If it is not valid, then this condition is not met.

/* Ensure we are within the crash kernel limits */
if ((mstart < phys_to_boot_phys(crashk_res.start)) ||
    (mend > phys_to_boot_phys(crashk_res.end)))
          return -EADDRNOTAVAIL;


>


-- 
Ricardo Ribalda
