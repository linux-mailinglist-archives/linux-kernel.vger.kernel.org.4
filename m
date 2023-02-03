Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C81688BAA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjBCAUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBCAUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:20:19 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED23B1448A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 16:20:17 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mc11so10938118ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 16:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o4SeCtxpTd27qR0RdpcpFno4SRCl6KUuB+kcMLwMuEs=;
        b=Q+7fPWvPlZlKiRFwOebhnC/iujWBaiUECP4cOuLomaMGCsrTaSSFwu6NUnirPZ9+0r
         udrwj8gZKy1N0/sU/gqKjEmE3i76LfJ22MYfwOCp20sV5YXorrAY1INPbtG5ZtgaWzqh
         VMzywQfT+LzEDpBsXEmlYVkThE1KCS8Q/mJA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4SeCtxpTd27qR0RdpcpFno4SRCl6KUuB+kcMLwMuEs=;
        b=IQZBUXrlZuctHS19gwI+I+ezXmGA6wgyrqS0PbcVuvtHmAsF3fM8kJ2Ffdoo5quXEH
         NFAH0aK9X+5JLBFAlStSDfD/UxrOajzPzceklnyMLe3ea2OzMR8Fg6/JjAutAdsJ1PKh
         9iFkpF+kIKn+RpwNiA8u/XjXfHEPNU/GbrvuFbZMsSCzrH1vwCcY+65ccm1ANNAjJ5Qa
         88O3DEZfv1kdmLbllaFt7LJyjh5HLHewpm4+qU5IRjOouabILdy1kgfZzk/x8hHSQMAv
         e0IYfr/7nKxPz/eyh/g82GVgEaDFSamaGLJI1sQNLcEhj+N+t5Msv5wsV9WfzkHqqwgN
         MHmg==
X-Gm-Message-State: AO0yUKW9yEbSQWG7x8mNSZoPbXga4YRzu3EOW9LUE9+ByBZD8DU0QWwq
        T0KNu7WXx5h0atJdLuimoiAp4FQkghN1bKoCPHNk9Q==
X-Google-Smtp-Source: AK7set8OJoviz3162qy91tJH8/NfeTh6YS01TZBd2v74AYVpsvXQcBpS4stIVRVMsSGdDuz40fC4Yw==
X-Received: by 2002:a17:906:eecb:b0:7c4:f6e4:3e92 with SMTP id wu11-20020a170906eecb00b007c4f6e43e92mr74534ejb.31.1675383616211;
        Thu, 02 Feb 2023 16:20:16 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id uo29-20020a170907cc1d00b00871ac327db6sm517236ejc.45.2023.02.02.16.20.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 16:20:15 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id gr7so11001981ejb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 16:20:14 -0800 (PST)
X-Received: by 2002:a17:906:f109:b0:882:e1b7:a90b with SMTP id
 gv9-20020a170906f10900b00882e1b7a90bmr2323578ejb.187.1675383614548; Thu, 02
 Feb 2023 16:20:14 -0800 (PST)
MIME-Version: 1.0
References: <20230202232517.8695-1-michael.christie@oracle.com> <20230202232517.8695-5-michael.christie@oracle.com>
In-Reply-To: <20230202232517.8695-5-michael.christie@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Feb 2023 16:19:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjF6j264jDFcY3wgzOUA2RL2SpD2oL5BF9JqCkz3A413Q@mail.gmail.com>
Message-ID: <CAHk-=wjF6j264jDFcY3wgzOUA2RL2SpD2oL5BF9JqCkz3A413Q@mail.gmail.com>
Subject: Re: [PATCH v11 4/8] fork: Add USER_WORKER flag to ignore signals
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 3:25 PM Mike Christie
<michael.christie@oracle.com> wrote:
>
> +       if (args->worker_flags & USER_WORKER_SIG_IGN)
> +               ignore_signals(p);

Same comment as for the other case.

There are real reasons to avoid bitfields:

 - you can't pass addresses to them around

 - it's easier to read or assign multiple fields in one go

 - they are horrible for ABI issues due to the exact bit ordering and
padding being very subtle

but none of those issues are relevant here, where it's a kernel-internal ABI.

All these use-cases seem to actually be testing one bit at a time, and
the "assignments" are structure initializers for which named bitfields
are actually perfect and just make the initializer more legible.

            Linus
