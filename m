Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6296A6C70C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjCWTHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjCWTGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:06:55 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF1833CD0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:06:39 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id n14so1417933qta.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1679598399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36prM9A8zaos5+TFGUPURrGIGK3rNGaMKQIdDwsgBJ8=;
        b=oGgSIfZLaTXDTewLg4spU3ovWYFoauE33eFdHx4itMmXU+XmM0v/Z20Y/MLovTSywj
         EcZJwhY7Y631lmzB4aEy8bsQEaPczWrFQ5YqrLLripRcy74B/zC7uXw77rO/S2Xxv+pq
         PvB5VMGjHl/Ld7jykVIwh0q3cVdHApNiqij63kpN5GoVOrCHlC4TQBYLp8gAXGDSTPCU
         N6PV1+scZ93dXYUusou13accFYlemFWeePxpmib6hNezb5xWUASwc82Cz+jPbBncawZ+
         cBOIWRnYPJm6Wuxz77ZEAkUry1DYSKblccijSAMEim3937Ltf0ySXzzzMy1LMRjJgB2z
         4BiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679598399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36prM9A8zaos5+TFGUPURrGIGK3rNGaMKQIdDwsgBJ8=;
        b=Qd6f4wayVuS1XVBiRdIY4GYMFyCGYv4TGvy/n3zYgPxQiVohtLgEDMrdTmd5v7pC0u
         xYVNAve5wYGqg2CrdI3FLLY11XOeBiF8IhwLXqV5+VuzdD9IrmAviBy0aPYPxTG9wgXD
         rF4b4Zlpd5GKAa1dVFOaQBilqySluCfqFnITDO+hSL7C92ZkTYJ1xHVh5F185wHmCHdr
         V0lcH7JrBuAZugGig6KZLoXNFn5hEgALxGEo1mzRzfqvDRrCSZCEvA1ruGisI6SKqtV/
         1/kMJpaxEYtvEoluveeIAu5C9eakNtJUd4iZg0t6NAqhD6t2tnim0k8yniVsQYNoA6fZ
         d8qA==
X-Gm-Message-State: AO0yUKVNC84aSR9h4RmcZRea5leDpYQkJSGiNUZBMtk+wdeqTC6+TTUC
        KJgkxie4GUNcZd50+vHwqRaD7K+oQ5xH9suPesBjDA==
X-Google-Smtp-Source: AK7set8xglclw5J5YcCeT1fPB6BezanDOekVyCKLGlb5fhybCh7Nxl4wyle7XuSUGfSvYoBnjT5I23feCbkyRPB5Lhk=
X-Received: by 2002:a05:622a:1a02:b0:3e3:f70f:fb13 with SMTP id
 f2-20020a05622a1a0200b003e3f70ffb13mr170171qtb.6.1679598398835; Thu, 23 Mar
 2023 12:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230323171904.14444-1-krckatom@amazon.de> <CA+CK2bDEPvQnMqv7R9JZybsNWbaMdHOPA0vKs501Txsu2OewKQ@mail.gmail.com>
In-Reply-To: <CA+CK2bDEPvQnMqv7R9JZybsNWbaMdHOPA0vKs501Txsu2OewKQ@mail.gmail.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 23 Mar 2023 15:06:02 -0400
Message-ID: <CA+CK2bAPSeEmQk6uazxSn3k7kWf0f6D6z+3BdHdWJPZXFBBg9w@mail.gmail.com>
Subject: Re: [PATCH] mm: Be less noisy during memory hotplug
To:     Tomas Krcka <krckatom@amazon.de>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 2:37=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Thu, Mar 23, 2023 at 1:19=E2=80=AFPM Tomas Krcka <krckatom@amazon.de> =
wrote:
> >
> > Turn a pr_info() into a pr_debug() to prevent dmesg spamming on systems
> > where memory hotplug is a frequent operation.
> >
> > Fixes: 966cf44f637e ("mm: defer ZONE_DEVICE page initialization to the =
point where we init pgmap")
> >
> > Suggested-by: Jan H. Sch=C3=B6nherr <jschoenh@amazon.de>
> > Signed-off-by: Tomas Krcka <krckatom@amazon.de>
>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Can you please specify what you mean by frequent hotplug: wow frequent
is it and what is the usecase?

Thanks,
Pasha
