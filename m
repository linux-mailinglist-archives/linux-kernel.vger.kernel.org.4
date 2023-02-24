Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E866A1564
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 04:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjBXDal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 22:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjBXDaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:30:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E05B521F9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 19:30:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1881B81BC5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAE2C433A7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677209434;
        bh=wFxdbsXrX6akSSocnLKePaTbVUvseZwZz7Gr0BvZckA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b6JP5cSY5FoIiYOADl8b0MFxblseDSTjsKqjQXzLGTLKDMu+WXQjk0SFZ8ugFvoQl
         hlQFc4PGa1boiDnVRWGt1tjMrLIZTz3LHiQZjX28nChEvrgthOe8B3R670B9HnvLo+
         gFpGpDtzFNJQ6BUjod2zbKdmjC94NnD9XuXOSIiX/ioxRxEEUZqipEG6axSHq2GuVW
         AEcq0moaiUmB5qelYNzKxNP83OxUYRmPIvcTHbJtVHXTg4aRqBRToxPhJ7pxngmjb6
         9jUQrEjj2uZndeJOSUPvMpVJhZe+u6lyw/udW1wxpXHzgj44tz6Qw8lavc3wbQBMeC
         owe7W2Ewbo23A==
Received: by mail-ed1-f41.google.com with SMTP id f13so49316181edz.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 19:30:34 -0800 (PST)
X-Gm-Message-State: AO0yUKUCZcW1jWF+ogCv3FvZCodbk4ykDnzKuTnFy6uJgB/1B7NBODBU
        Bwf5xlv3E6aEoaQsKGJn5OJqmYRJKqt6gay7y7Z4KQ==
X-Google-Smtp-Source: AK7set/a2U2gqUx+w1odhF8Rc1nRegOiLI7wK3uvBBO7G/XCc4EG6We936z5VG9KmLDbi2iRREdBJv59Lk639jtdc/Y=
X-Received: by 2002:a17:907:1dda:b0:8b0:fbd5:2145 with SMTP id
 og26-20020a1709071dda00b008b0fbd52145mr10095945ejc.15.1677209432608; Thu, 23
 Feb 2023 19:30:32 -0800 (PST)
MIME-Version: 1.0
References: <20230221184908.2349578-1-kpsingh@kernel.org> <20230221184908.2349578-2-kpsingh@kernel.org>
 <Y/d9qajJnR/ZcHvB@zn.tnic>
In-Reply-To: <Y/d9qajJnR/ZcHvB@zn.tnic>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 23 Feb 2023 22:30:21 -0500
X-Gmail-Original-Message-ID: <CACYkzJ4W5eoWiF5=QyuiPMd7J--+xUE3QN2b+CWhfcJszm1UFg@mail.gmail.com>
Message-ID: <CACYkzJ4W5eoWiF5=QyuiPMd7J--+xUE3QN2b+CWhfcJszm1UFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Documentation/hw-vuln: Document the interaction
 between IBRS and STIBP
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, pjt@google.com, evn@google.com,
        jpoimboe@kernel.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        corbet@lwn.net, bp@suse.de, linyujun809@huawei.com,
        jmattson@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:52 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Feb 21, 2023 at 07:49:08PM +0100, KP Singh wrote:
> > ... Consequently, STIBP needs to be explicitly
> > +   enabled to guard against cross-thread attacks in userspace.
>
> needs?
>
> That sounds like something the user needs to do. But we do it by
> default. Let's rephrase:
>
> "Systems which support enhanced IBRS (eIBRS) enable IBRS protections once at
> boot and they're automatically protected against Spectre v2 variant
> attacks, including cross-thread branch target injections on SMT systems
> (STIBP). IOW, eIBRS enables STIBP too.
>
> Legacy IBRS systems clear the IBRS bit on exit to userspace and
> therefore explicitly enable STIBP for that."

ack, I will respin both patches with your suggestions.

- KP

>
> Simple.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
