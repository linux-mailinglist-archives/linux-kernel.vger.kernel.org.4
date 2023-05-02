Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2996F428C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjEBLUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjEBLUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F83526E
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683026360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZGX3oXDmepVSSgXg/ywOi6E6HyMIWMvPLV7WEL89H4A=;
        b=Z4tI/d+YJuUicCSiAJxRZk+M6Pvyp7Vw+nn3322oLVQzOblWeKEaRKy4kaSqBiFvpw+ltq
        uWR1upyfW4vOgMlR0YNmWNQPREXynNM1YgS1SSNhvH2RorqOpteahPHzpkD2yVqofqSiRe
        nPMnYaeQP/UlQBFE4yoHC2Hxvy7kqTg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-4yeR6X9OPPWgtTi33zHgoA-1; Tue, 02 May 2023 07:19:19 -0400
X-MC-Unique: 4yeR6X9OPPWgtTi33zHgoA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f33f8ffa05so10887395e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 04:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683026358; x=1685618358;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGX3oXDmepVSSgXg/ywOi6E6HyMIWMvPLV7WEL89H4A=;
        b=eI6Ff2fNLGEptAr1yFHrav6fh1HB8GvKEYICGKbnGxmGLbr8QYRHGohIbF5ds3/Uh0
         uU9CMrDd1CIDjJjirk4UADbIChvNWCHU8GilBFuxIl7k3XAT5BPBKPyNU1fyOaTL5raJ
         paNKdYdQPriYdmfUtHhecesVhKTR+wuu3NfKvd7ovGDvvZVXbGDHj6jz3plUTIkXXXwh
         aWewa2xq/BfPG2TNDAgn2lkm4rThzK8IrmrmTbyGuZhZTQucJEmBZJkKkZhMDLNIAqXv
         emFnEWMdbmRWqm+ltEU9H9wBK2Kb5bv547+Bnb6M4QbEd7tiF4a1Dc5c0MyomEoy4Sc4
         QIwA==
X-Gm-Message-State: AC+VfDxOGWu4Yi8f9jM1fmloUhQoJgLn+iZLfUWDLk7ZjTUcSgxvfUh7
        KQBneSQVbfIWVmmeWE3vMMD4KL1SOM5s/AgHR+s/H7y4HWjvBuuTKZR3NHgPLgwMX2l7fBmTafT
        RzcuLFz85LAbcmIDIYBpvKny+
X-Received: by 2002:a05:600c:364f:b0:3f3:1cb7:b2a6 with SMTP id y15-20020a05600c364f00b003f31cb7b2a6mr11124414wmq.6.1683026358452;
        Tue, 02 May 2023 04:19:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4tPcGFK34P936+hkNtJFObgUIXbAcsn7dPF/bQ8zykBW5U1fcHtQfnTagWvTYqne2fpRN3+g==
X-Received: by 2002:a05:600c:364f:b0:3f3:1cb7:b2a6 with SMTP id y15-20020a05600c364f00b003f31cb7b2a6mr11124394wmq.6.1683026358161;
        Tue, 02 May 2023 04:19:18 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c025900b003ed2c0a0f37sm35039778wmj.35.2023.05.02.04.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 04:19:17 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 2/2] Input: tests - modular KUnit tests should not
 depend on KUNIT=y
In-Reply-To: <483c4f520e4acc6357ebba3e605977b4c56374df.1683022164.git.geert+renesas@glider.be>
References: <cover.1683022164.git.geert+renesas@glider.be>
 <483c4f520e4acc6357ebba3e605977b4c56374df.1683022164.git.geert+renesas@glider.be>
Date:   Tue, 02 May 2023 13:19:16 +0200
Message-ID: <87ildbx9or.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Geert,

I've only been Cc'ed in patch #2.

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> While KUnit tests that cannot be built as a loadable module must depend
> on "KUNIT=y", this is not true for modular tests, where it adds an
> unnecessary limitation.
>
> Fix this by relaxing the dependency to "KUNIT".
>
> Fixes: fdefcbdd6f361841 ("Input: Add KUnit tests for some of the input core helper functions")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

