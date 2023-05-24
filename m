Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1447100A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 00:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbjEXWKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 18:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjEXWKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 18:10:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2713512E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:10:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1afa6afcf4fso6991745ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684966212; x=1687558212;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hlk6FbizkRfE0g6Mbi2ayuft7RVVPKxaFs9z7XZvbt8=;
        b=DJxxEPCQifdkFvHohQ0CTNLVn/W7Ax0VZgxx8Brng0Glm9JxGJyqaphATv6OM5v2xN
         gHul35XcsjmYZ1Wbv+SE94VwvGesjMZyq7EHaE7rBrA50XH8pcPqOR2Su0W08yCeUdRx
         CYjWAGQRofYP+GsLsqQ5XdW9M8i16VtW4wRHs748qO9jmHdsDwmYnYo+qrUZ4AebVCOw
         umcZlxwaJwr9pO4NhpQM82kZeFp3sJMkjUPdZwxkxWCtEKUm7uEaIxk735t3cptzI2JG
         hAn0lAljcrDNOIiDDFWqonMmdNIIaLp+6kd4iNGqUX/RB9lZvvQEW2fAgOFH1QC9DlQh
         s1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966212; x=1687558212;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hlk6FbizkRfE0g6Mbi2ayuft7RVVPKxaFs9z7XZvbt8=;
        b=iMUyPLEzPzpiILKIVSNQQbyW7WPz4o8MBRxJNa829T9ANVAYNw9eITWXf1ZOeIgeoY
         y7GZOE08mkXOCeuyDeWmKDXEYWISifh9g0YWg6t31+aOLgPM8QITSeqiZFXMp6emi98+
         S1brXzBM4kKSs58DooC3KgH4RFZ9y7VpaFFOHrWX4CVTJkzGmDmznkXSQ2ve8nMsdGKj
         KvocQCPMIK4wJCuqHB9xEabIhCg0xaakbHM/NG1MSVy+cltBh6JcuLh2rrmJyugZt+YE
         JXI8DwZvZfcQ/BGeHjM3wO7X/Ld2UmH0n1gNoyQn14k/THGJmkyLwd+5fhorv39ZRCgk
         6GfQ==
X-Gm-Message-State: AC+VfDypm2oZrrnYbAKn3bfj2sht3QELFKHkgkuJSl1zCo01lMv1ijWr
        ErNu1k2etwOLWhNODc9uHHE=
X-Google-Smtp-Source: ACHHUZ4nFmasMmvR8X/Un7B81nriJLJva7YPXvDucMX14mDcDxcK1JBamHyg8e+FcA8axMGhr0V7yw==
X-Received: by 2002:a17:903:48a:b0:1ae:52ea:5fa6 with SMTP id jj10-20020a170903048a00b001ae52ea5fa6mr17192839plb.8.1684966212407;
        Wed, 24 May 2023 15:10:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:be57])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902788500b001a96269e12csm9237256pll.51.2023.05.24.15.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:10:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 24 May 2023 12:10:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josef =?iso-8859-1?Q?Sch=F6nberger?= <josef.schoenberger@tum.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: KernFS: Missing IN_DELETE_SELF or IN_IGNORED inotify events
Message-ID: <ZG6LQo1LUPn4A72f@slm.duckdns.org>
References: <51354ca5-acd2-f542-95e0-85ed8418f483@tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51354ca5-acd2-f542-95e0-85ed8418f483@tum.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 09:53:01PM +0200, Josef Schönberger wrote:
> Hi everybody,
> 
> I'm currently working on event listeners for cgroups for a long running
> daemon. I found that the removal of cgroups that I'm currently listening
> for produces neither an IN_DELETE_SELF nor an IN_IGNORED event; which is
> unfortunate, since I need to maintain a map from watch descriptors to
> paths, from which I would like to remove all obsolete entries.
> 
> Since this is not the documented behaviour and since I could not find
> any material that would specify an intention behind this, I'm assuming
> that this is a bug?
> 
> I've found that the same applies to the sysfs. Taking a look at the
> kernel code, I'd guess that the issue might be in KernFS.

Yeah, that'd be all kernfs. kernfs does have some explicit fsnotify hookups
so that kernfs users can generate custom modified events (e.g. for
cgroup.events file) but doesn't do anything else. If the generic layer
generates events, they'd go out. If not, they won't. I can't think of a
reason why hooking up the missing events would be difficult tho. I'm pretty
bandwidth constrained these days and don't know when I'll be able to get to
it but if you wanna take a stab at it, I'd be happy to review.

Thanks.

-- 
tejun
