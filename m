Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C246319B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiKUG0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKUG0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:26:04 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B90A26571
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 22:26:02 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id cg5so6715246qtb.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 22:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EOs0qwxAH2/pioGUQjAqQZCo5hozuq4moR5tVBbEUtg=;
        b=KfOTHl7grc1+6ZofGZsTdaxAlmOrRNoG6BfBMqSr8xX4NIhIqXAva2jAsFnxYEkdkS
         Ee1Zgia2BPvpj4cOA6FtPSgT7119UG5yKsQdECWZj+M32SeyC9RtXIhWjM4Y6c+rogP+
         IupooRNF5leuyXXUTOqGEBswe0AdgqCvZHERasju3qalsZmMIIMJxFdXiYGCzMeexGSI
         YL49rQ0fwc42sA0G9WcDi2jlbQyUwB7ZYuR5uNrllf2n9LwJe5HE/2EJ6Ow25nR9ZMOa
         Lv4Ux0oYjcysVysviLeqSLSw8pHzabg4Dmc3qwxyOG1Kzavve2uh6WZFC9U5n7QFZ4/l
         tKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOs0qwxAH2/pioGUQjAqQZCo5hozuq4moR5tVBbEUtg=;
        b=craIOr/lAkR6IwN8zs+u4L/Am8oDjg+su9HslxRGcquwmg2P8kQAU4RJsr8qeZmhuo
         +0UiNV0alKRFoffnVfVybiXwHv3mU9wz+6OnzzkHsbHlXNh2mNDfNKqAOnq99ooNjLvy
         woAAmnMjQwXDFI566W5Z/mzXtIwMZKAjIaKNrPwyOAjL6KGo2jZdblLv9+jjBKQ7RziW
         RNE4HVdztdLI0saczHn1CaMVZpB1jqFCukcwbNeT+/iNIpwufvPlwjtOPc7TUBGk/WLJ
         LbnEX+RdhjdkSOb950TGWK6S+ty1DMePJ87pHEELZDKLzhUabcK7BxqlsOcyfzY6I3rs
         W36g==
X-Gm-Message-State: ANoB5pkCrpdQLbcVnMKI0fR8VDLqpPt3EIGiH7jGouEqIr4PlaByhJdi
        u0jKWe8/mgJKxmA5WqqkNRWvPIeGmp3h9k3XvAI=
X-Google-Smtp-Source: AA0mqf7sF2jElD5/SyliGDaozdhgYHqQGtqU+cPqD/Zifqs5evBzkXqDWE3qE0hFQZ7/1dUasxI0NMx8R3/eYeqbVUw=
X-Received: by 2002:ac8:7cbb:0:b0:399:83a8:c28b with SMTP id
 z27-20020ac87cbb000000b0039983a8c28bmr4786015qtv.447.1669011961658; Sun, 20
 Nov 2022 22:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20221119204435.97113-1-ogabbay@kernel.org>
In-Reply-To: <20221119204435.97113-1-ogabbay@kernel.org>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 21 Nov 2022 16:25:50 +1000
Message-ID: <CAPM=9twtQry6S=+Gy2NiUDzX8vrkqHgxCNm8o9UDK8oHtNUZSw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] new subsystem for compute accelerator devices
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Christopher Friedt <chrisfriedt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2022 at 06:44, Oded Gabbay <ogabbay@kernel.org> wrote:
>
> This is the fourth (and hopefully last) version of the patch-set to add the
> new subsystem for compute accelerators. I removed the RFC headline as
> I believe it is now ready for merging.
>
> Compare to v3, this patch-set contains one additional patch that adds
> documentation regarding the accel subsystem. I hope it's good enough for
> this stage. In addition, there were few very minor fixes according to
> comments received on v3.
>
> The patches are in the following repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git/log/?h=accel_v4
>
> As in v3, The HEAD of that branch is a commit adding a dummy driver that
> registers an accel device using the new framework. This can be served
> as a simple reference.
>

FIx the nits Jeffery raised and the one I brought up and I think we
should be good for this to be in a PR.

Reviewed-by: Dave Airlie <airlied@redhat.com>
