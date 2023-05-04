Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CA56F7742
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjEDUkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjEDUj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592751943C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683232302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m/qDBDw/nNJdwxgJ/b5PZHY5Zg9oYrRyxLosJRIIGco=;
        b=JLlqSzaObAqgBpBrGZzMfBHCvkr8I/8l+EBvI4fGZea0YPwWcy6r4LUrenfcAvGE+bA4AW
        p19BTNs+TaO8PFrRkKiinW/H9g9O7JP02GSWMi+FZpMS74Tt1uBBAGU2v7kB8Ak1m7qbYk
        xyd/QpnnoWwUZxmMVSgVm1GIgE7sH04=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-VhIJEWHyOqGcb1qAgYOnjQ-1; Thu, 04 May 2023 16:06:35 -0400
X-MC-Unique: VhIJEWHyOqGcb1qAgYOnjQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-74faf5008bbso8080885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 13:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683230795; x=1685822795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/qDBDw/nNJdwxgJ/b5PZHY5Zg9oYrRyxLosJRIIGco=;
        b=D0rbwJ4C2zV5wGZ5FHkhXmRCBz6SZSeVvcDWUyKYX6ansFmCQzHWK7Qqgo/KCZZDju
         cQ69KguVL8J9TC8jK6ghVydUp0Fd8LqTH8VbSEJYayk3323tAqIrcysRfm16CKh92gjk
         zBnUotU3g4fIxcrWdfOazZ4KyM+7ubnOxKLf9FixJFK48dsSiaqq3FAp2RHoiuOZ7wMj
         vLaJFUr6tY3uDnMCGqAasZLPMdDplIZ9XkL6ATAkAsYhaQ4IxDHtMpk1JWqGgdGMd78x
         WWEa35UPRdefcNYeARgWK87NmBM8WEXIA4Py/dZovvRW5PQKomskRqEy4trdzLmYozkQ
         k5hw==
X-Gm-Message-State: AC+VfDyGsfMzKUnQM/tZQoHtCTOxGafdIE0cvog5idlHChiD/xSzSTN+
        a637GpeZH4pd+qBGn3FaWo5zrmpofV5w4zT25zjMqNqFPTx5WlfE74eW2FZCYbDsfZh5uQx5kxx
        7p9CRQ04mreplORoH4PDyydrd
X-Received: by 2002:a05:622a:1cb:b0:3f3:726a:6a70 with SMTP id t11-20020a05622a01cb00b003f3726a6a70mr2800144qtw.6.1683230794650;
        Thu, 04 May 2023 13:06:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Wjc1ftfCKYjSepetDA4oT7sVlLuqF5bHmOjjIBYYM8Ko/PVF9+G1TaNTzwpyb1+uQBGLdBA==
X-Received: by 2002:a05:622a:1cb:b0:3f3:726a:6a70 with SMTP id t11-20020a05622a01cb00b003f3726a6a70mr2800119qtw.6.1683230794373;
        Thu, 04 May 2023 13:06:34 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id q3-20020ae9e403000000b0074df3f7e14esm39387qkc.67.2023.05.04.13.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 13:06:33 -0700 (PDT)
Date:   Thu, 4 May 2023 16:06:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, izbyshev@ispras.ru,
        nd@arm.com, broonie@kernel.org, szabolcs.nagy@arm.com
Subject: Re: [PATCH 0/4] MDWE without inheritance
Message-ID: <ZFQQSKijXQHWlYaI@x1n>
References: <20230504170942.822147-1-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230504170942.822147-1-revest@chromium.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 07:09:38PM +0200, Florent Revest wrote:
> Joey recently introduced a Memory-Deny-Write-Executable (MDWE) prctl which tags
> current with a flag that prevents pages that were previously not executable from
> becoming executable.
> This tag always gets inherited by children tasks. (it's in MMF_INIT_MASK)
> 
> At Google, we've been using a somewhat similar downstream patch for a few years
> now. To make the adoption of this feature easier, we've had it support a mode in
> which the W^X flag does not propagate to children. For example, this is handy if
> a C process which wants W^X protection suspects it could start children
> processes that would use a JIT.
> 
> I'd like to align our features with the upstream prctl. This series proposes a
> new NO_INHERIT flag to the MDWE prctl to make this kind of adoption easier. It
> sets a different flag in current that is not in MMF_INIT_MASK and which does not
> propagate.

I don't think I have enough context, so sorry if I'm going to ask a naive
question..

I can understand how current MDWE helps on not allowing any modifi-able
content from becoming executable.  How could NO_INHERIT help if it won't
inherit and not in MMF_INIT_MASK?

IIUC it means the restriction will only apply to the current process.  Then
I assume the process can escape from this rule simply by a fork().  If so,
what's the point to protect at all?

And, what's the difference of this comparing to disabling MDWE after being
enabled (which seems to be forbidden for now, but it seems fork() can play
a similar role of disabling it)?

Thanks,

-- 
Peter Xu

