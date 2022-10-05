Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFE95F57CD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJEPt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJEPtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:49:53 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153979FD7;
        Wed,  5 Oct 2022 08:49:52 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id g23so10137029qtu.2;
        Wed, 05 Oct 2022 08:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmiWEVCToBe67RJhgjCgJCKlKhQhca5a1Yk6C0OW+aw=;
        b=q8JfdATL57wOVXtaCgVR9EshNIKWVEczxqJYOuX3Gma3ENgan48MiQM88FVsU1a7D3
         ia5gN6Fs9X/UNB47OhbSd7iMJQquL82le+nswrUbPKHplrvrUfAn5UBayhEKAzuJfYhi
         jBzA1JrJEgicLnkCDMBsmDNOkOt5aOLl4+CVR2Sd/4JzHfOCctjtFSYDcL+FBf1qsMIo
         bPJgJqeeze6VZacTzH3id/blZRG4ShfBsjhWplhhegG59p0g6yfBhwl/A2x1HlqwgFBi
         Yr3NPZhpI0Zd3zpjcJErzeN9aHUuTpS7aVyUWbWQDF7KWp7UvLGkM+PsYtEwMc/Ct2uG
         aPkg==
X-Gm-Message-State: ACrzQf0AJxCVp5zJwjVU7wB/eaSlLczKj7B+S8IxW0g3FcC97H6NhXj6
        hH9U943sx1yzPLMImzP7I6IC8jXljCEfqMKuUTc=
X-Google-Smtp-Source: AMsMyM5aUyTQMOXAg3gyXwCNgnbCTi1H8Ar9/ASt+PFQiPUsMtl48zIG45NDgI/i7bsOutEj8b0zsIah6NQdpDLYClw=
X-Received: by 2002:a05:622a:11c8:b0:35c:e912:a8ea with SMTP id
 n8-20020a05622a11c800b0035ce912a8eamr188341qtk.17.1664984991179; Wed, 05 Oct
 2022 08:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221004230541.449243-1-Ashish.Kalra@amd.com> <20221005154105.454809-1-Ashish.Kalra@amd.com>
In-Reply-To: <20221005154105.454809-1-Ashish.Kalra@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 5 Oct 2022 17:49:40 +0200
Message-ID: <CAJZ5v0jM8WrE1u1x5K26Lj0kEvRfQB=nk4vOXYEnoG-zeuywRw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: Fix num_ghes to unsigned int
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     bp@alien8.de, devel@acpica.org, james.morse@arm.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        robert.moore@intel.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 5:41 PM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> Yes, on one of our AMD EPYC processors, num_ghes is 32776 and we get the following call trace due to vmalloc() failure beacuse of the overflow:

But int should be more than sufficient to accommodate that number.

I think that the overflow takes place during the execution of this statement:

len += (num_ghes * GHES_ESOURCE_PREALLOC_MAX_SIZE);

because the right-hand side of it is of type int, because both
multiplication operands are int.

You should say that in the changelog.
