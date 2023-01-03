Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8AD65C84A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbjACUml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjACUmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:42:33 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A152E13D61
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:42:31 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id r26so40418477edc.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 12:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ECm8WA+k+WcnWoeg/q1MJBXySQiL93FB03e86BM2/mI=;
        b=jqx8FVn4X/0/v8pr/ntGsHhYBbI9ZfIaVDTWvlZU2RqguJHRQ8nJF2HNmVuKLInpc5
         tG8AQrf5yS4d3Z0WqTnKKXyUIbP/Am3C9fR+d98WFqXM6StuZqw4DtH0jJme67GoA91W
         fQut24FU+yvi6h/F0FRXsrFLdUXTArdJ0v78kCYFLfq199Q0YDhBe/n9ZGPqZac5vvGE
         6EmHgnfhqxgUwrp54KPRAtcZse2vrtxPu/SN2n1CVLBVUJvyGARPHXeeu4XfoMUZW5kk
         8tqUyCJk6tYxFoyxqYEODmDOzhoUZiqfPFVqD8EHiwBX9/oMAipsCQGdwoM2o75h5k2h
         UI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECm8WA+k+WcnWoeg/q1MJBXySQiL93FB03e86BM2/mI=;
        b=gTdrHT0Cd4M2THckZOSkfwKgngkgJh3q/qtHNES65Pmpu4X7U/KWvAIesJoIW5wLBw
         EDfUTD8LBuSD+VyUBNPJbYT4U9kle/KT21o8tU1n+BH4aq6CfuKb23pslhUfIpTWUkSQ
         epjb1EiiuTNU+IoJ3/SiG85sgAEoKO7YaVD8zW95OyggpPtpH8Ex3+lbaxiarKM3hjFS
         LEVG1TWIvzf3BUuLOnEJTcR1X0i6vlt6mFDuxi0Ay7Od3uTlbiMNi/le46ppQ6q1YUXm
         at/j+tcS3neuZli+TO0WRVF04YzM2KdqozBF9PNCmm/L27+rppKTIr8/QGmwzW9BlhU4
         0gQg==
X-Gm-Message-State: AFqh2krux6fWwv7d0uUUdVRTSC7eCcTScdqD2T/6eFUdIfFaEOr0gpYN
        HeLxSgT6/TqpBUQ0msGj2nuA5ASfWKkSqzOZJ5uKXQ==
X-Google-Smtp-Source: AMrXdXtt5MTR0jTlS5Y3StDuzIUa8QH2PHFhbIcGqUcEd4njNeeWnP3Nrq3FJH6eEITomow0Z1fIVN0HxsNLaLXgK8k=
X-Received: by 2002:aa7:cb52:0:b0:484:93ac:33a6 with SMTP id
 w18-20020aa7cb52000000b0048493ac33a6mr2511161edt.81.1672778550139; Tue, 03
 Jan 2023 12:42:30 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid> <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
In-Reply-To: <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
From:   Matthew Garrett <mgarrett@aurora.tech>
Date:   Tue, 3 Jan 2023 12:42:19 -0800
Message-ID: <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
To:     jejb@linux.ibm.com
Cc:     Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 9:11 AM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Fri, 2022-11-11 at 15:16 -0800, Evan Green wrote:
> > Introduce a new Kconfig, TCG_TPM_RESTRICT_PCR, which if enabled
> > restricts usermode's ability to extend or reset PCR 23.
>
> Could I re ask the question here that I asked of Matthew's patch set:
>
> https://lore.kernel.org/all/b0c4980c8fad14115daa3040979c52f07f7fbe2c.camel@linux.ibm.com/
>
> Which was could we use an NVRAM index in the TPM instead of a PCR?  The
> reason for asking was that PCRs are rather precious and might get more
> so now that Lennart has some grand scheme for using more of them in his
> unified boot project.  Matthew promised to play with the idea but never
> got back to the patch set to say whether he investigated this or not.

Is there any way to get key creation data to include NV indexes? If
not, no, we can't use NVRAM.
