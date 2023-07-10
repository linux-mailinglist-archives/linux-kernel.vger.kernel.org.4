Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62B674CF23
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjGJHxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjGJHxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3FB1B0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688975507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/S5TMpL0uocWIm+1OwtB/ZxbVrEGPEFscIcgVtNogz0=;
        b=PlwVEXS5NMX9eDETMdVbNFJDDOOtnRDD/apB3hkhanL+JiT3UO7zSCjLWO+El6QOEjwAWA
        MdyKbV1aia+d58T47f/ztuvDctZlxnmkE/BEswpS7dykVGX/ITtr0AOWKToimXTi2/U90e
        HmdUlHXBRwti8npSlzFDid8p0Dl3Oos=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-hzcauEoYOBKm99aD_jqffg-1; Mon, 10 Jul 2023 03:51:44 -0400
X-MC-Unique: hzcauEoYOBKm99aD_jqffg-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-c5c8d00ce50so3749028276.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688975504; x=1691567504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/S5TMpL0uocWIm+1OwtB/ZxbVrEGPEFscIcgVtNogz0=;
        b=X1cwywG3f5pagFcB5qjlZiGmU/whduUZHXCCP8vA1fTQvzav14QjJ0ZAVg6DmjSC7o
         i1m5sw3xL+vNinoFKO/ihQ8L2ivy5N9lBh5UmbakP7AekVy7EsRDLPMpGTpVpht7xjCo
         A11WBuJic4f6leSb+UWqv/ZhNvdEtpKdbtEEJWLMzEqsY0/Nel3jJT7eJs+0tynDp/Lp
         zA3u2u1ZTlnTplM2IxtUOwk01S5cqZDMlXRQdJUOgoo3lg5M91xIACjbPImoAut5Wrjn
         HBbU9TPaJ2xLYrV5oB9HkIkV8r4zeoctueEsL0s1NiF9bkAb6li+pflX8pgWMjURUgiI
         ktzQ==
X-Gm-Message-State: ABy/qLaAdZ24apXDIzrtxYkVSwloBtNGwMy1Rekd0ec8OMaSF/x0O4Fw
        5yz9/KSIC9EurUMigYb3bn/5m/tn49TgiAaVmiAi99nkJbmxUOECQ9Vn7Lo0JhyhXyBSzJMKbqB
        JP6t1ZplO/EAcGZ7EKn5c6KOt7vWbBJBd+QzLaePa
X-Received: by 2002:a25:ba11:0:b0:c86:5a9e:86c with SMTP id t17-20020a25ba11000000b00c865a9e086cmr1595359ybg.17.1688975504292;
        Mon, 10 Jul 2023 00:51:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHGQPVTc+6BugVBhgT/QK+tSb7/kPQaEijKSfSd4Y05GgzAtNpEE04vaWKQfYAyiWRusGbi5TTfob93Rlsn7Ns=
X-Received: by 2002:a25:ba11:0:b0:c86:5a9e:86c with SMTP id
 t17-20020a25ba11000000b00c865a9e086cmr1595351ybg.17.1688975504078; Mon, 10
 Jul 2023 00:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230709-fix-selftests-v1-1-57d0878114cc@kernel.org>
In-Reply-To: <20230709-fix-selftests-v1-1-57d0878114cc@kernel.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 10 Jul 2023 09:51:33 +0200
Message-ID: <CAO-hwJL+vqr0Xcb6SgL8xjr6ERM-d19bBF9VeDT3p3SVTOGGBg@mail.gmail.com>
Subject: Re: [PATCH] selftests: hid: fix vmtests.sh not running make headers
To:     Benjamin Tissoires <bentiss@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 9, 2023 at 12:07=E2=80=AFPM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> According to commit 01d6c48a828b ("Documentation: kselftest:
> "make headers" is a prerequisite"), running the kselftests requires
> to run "make headers" first.
>
> Do that in "vmtest.sh" as well to fix the HID CI.
>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
> Looks like the new master branch (v6.5-rc1) broke my CI.
>
> And given that `make headers` is now a requisite to run the kselftests,
> also include that command in vmtests.sh.
>
> Broken CI job: https://gitlab.freedesktop.org/bentiss/hid/-/jobs/44704436
> Fixed CI job: https://gitlab.freedesktop.org/bentiss/hid/-/jobs/45151040

FWIW, I'm going to apply this one now given that otherwise all of the
CI is not working.

Cheers,
Benjamin

> ---
>  tools/testing/selftests/hid/vmtest.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/hid/vmtest.sh b/tools/testing/selfte=
sts/hid/vmtest.sh
> index 681b906b4853..4da48bf6b328 100755
> --- a/tools/testing/selftests/hid/vmtest.sh
> +++ b/tools/testing/selftests/hid/vmtest.sh
> @@ -79,6 +79,7 @@ recompile_kernel()
>         cd "${kernel_checkout}"
>
>         ${make_command} olddefconfig
> +       ${make_command} headers
>         ${make_command}
>  }
>
>
> ---
> base-commit: 0e382fa72bbf0610be40af9af9b03b0cd149df82
> change-id: 20230709-fix-selftests-c8b0bdff1d20
>
> Best regards,
> --
> Benjamin Tissoires <bentiss@kernel.org>
>

