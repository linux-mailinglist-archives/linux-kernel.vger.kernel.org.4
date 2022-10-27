Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EB060F3EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiJ0Jpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiJ0Jpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:45:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5027376955
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:45:40 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7cb329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7cb:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B556C1EC02AD;
        Thu, 27 Oct 2022 11:45:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666863938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kRvdo0VXbVuM9lNlzKBftAdtlpQQ17w5SrGYtszVIXg=;
        b=Losv+AjqGqH6kvUmnR+XkVj+jt8yiZTHbNf4ua4Ry+7vKaTmowiHkLLacQAedpPW/yBtJn
        b0kWK8c7ZTJpPUqJng78uplVFjJFpzXJkkDWpAh5JXjtQ+AxMBRY8k+mU7UnkyVCjkuwIL
        yIWNL9K122b5GjU4BQQmXhibhHy8jIg=
Date:   Thu, 27 Oct 2022 11:45:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     Peter Gonda <pgonda@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] virt/coco/sev-guest: Initialize err in
 handle_guest_request
Message-ID: <Y1pTO+T67EBdlQd9@zn.tnic>
References: <20221012002323.2015637-1-dionnaglaze@google.com>
 <CAMkAt6qj-iHzk+FqCGh5z4EZHB9BzOfqES8RmjgYXs3CSg3CXQ@mail.gmail.com>
 <CAAH4kHbf6HO05bSwcSsqXTYKTn6wz44mivNY6ZpNrCVzgO3jRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAH4kHbf6HO05bSwcSsqXTYKTn6wz44mivNY6ZpNrCVzgO3jRg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 12:58:12PM -0700, Dionna Amalie Glaze wrote:
> fw_err = 0xff doesn't make sense to me actually. It's not a documented
> code that the firmware was never called.
> Still, we can simply pass fw_err to snp_issue_guest_request rather
> than an unsigned long err, since a null pointer results in an -EINVAL.

Yes, pls do that. Such I/O function args are always a PITA anyway.

In retrospect, that handle_guest_request() with gazillion args should
have been made to take a struct as a single argument and populate it as
it operates.

The callers then would look at it and decide what to do.

Looking at the callers, they all take members of struct
snp_guest_request_ioctl and pass them in. A first step in cleaning that
up could be to simply pass that struct snp_guest_request_ioctl pointer
instead...

Oh well, in case folks feel bored. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
