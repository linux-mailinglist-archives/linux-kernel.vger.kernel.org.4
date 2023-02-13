Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DDE694665
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBMMyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBMMyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:54:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2169818E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676292836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LzebZ30kzj7N0BnPIfXYRkFkaGqREtgrrb1Fr7Y2rqM=;
        b=gDI7Uu6X9SNNrVYC8k5M/gC3pmSWzwg1Cj3lTJ+hgwNSsUAdPsWN4wJHDRCT94Yu91onNL
        eXuNhcH/vEKkos0V+xlMEZA/6jlMS8QxV8AvVIdZP81vb1h7+lsMkz2qAJUJxOJToyvXvS
        wdV0HGoqDgbKXsKmoi2hJeTM0npG4kg=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-519-EUVoEHC2PT6nWYHaK6EsaA-1; Mon, 13 Feb 2023 07:53:55 -0500
X-MC-Unique: EUVoEHC2PT6nWYHaK6EsaA-1
Received: by mail-vs1-f72.google.com with SMTP id bk38-20020a05610254a600b003f3633a1a04so2500708vsb.20
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzebZ30kzj7N0BnPIfXYRkFkaGqREtgrrb1Fr7Y2rqM=;
        b=REIKYJiNUcavCJhyHT+qI9sIoHSHq7s8Qjt4AWLqFuTEMljojn5WuLzP+8R0ZiShBB
         FjynnfR/tqipIcfb+uxECgMyuHoRkdc3flcDJwnmS/8THMUpFGd8BUWdp8pSX8Y9qwER
         iQqv2B6T0NeUJCHD9IH4aCLBsJ05FFfMJdB70I4CahZFg6t3dX7km9jO2NtPT0Qajelv
         42EKnfYzqgVgZZLpkhyRY8sBW9Ylut6Kcrk/aCplH0h4NvEvCZ9ZjI/bJCERdcDhviDt
         uXRGIVy4WQl4C2OGA/ptXukVRyhNgzCUoEAlwJj2N+w22j92IQ/O7TcYqTEa4DNWUFnA
         n03g==
X-Gm-Message-State: AO0yUKWThUlO4ukY/1SEYyib19gzwpQ8CSsOLocy58CHkYtmaaRiA5Nd
        hDN7KduSp0T3y7qJSAaNxquR+38HM8kOpPkwSHQsxpQCEe0oVFlPd7bEwbSOC/8bHjoDm39CMeF
        BiRzyRJOIfGtXigjv+zCvP9LESNm9r139I/1h8mxN
X-Received: by 2002:a05:6102:50ac:b0:412:b77:7822 with SMTP id bl44-20020a05610250ac00b004120b777822mr612770vsb.74.1676292834621;
        Mon, 13 Feb 2023 04:53:54 -0800 (PST)
X-Google-Smtp-Source: AK7set+uR4OQVakWkB0Q6ReN9flfEMIBV6WMTofHt8sSly39IdDoXb8ZlGABx4e3XLMo+mm4AgewLTiPoWd0xMM2jpA=
X-Received: by 2002:a05:6102:50ac:b0:412:b77:7822 with SMTP id
 bl44-20020a05610250ac00b004120b777822mr612762vsb.74.1676292834433; Mon, 13
 Feb 2023 04:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20230111152050.559334-1-yakoyoku@gmail.com> <aaf97a61-73c9-ff90-422d-9f3a79b0acd6@iogearbox.net>
 <CANiq72m+8D8OGtkyEjmyqCynp48DCKEw4-zLZ4pm6-OmFe4p1w@mail.gmail.com>
 <bec74b32-e35f-9489-4748-cbb241b31be7@iogearbox.net> <CANiq72nLrUTcQ+Gx6FTBtOR7+Ad2cNAC-0dEE7mUdk7nQ8T6ag@mail.gmail.com>
 <Y+atpJV5rqo08dQJ@kernel.org> <Y+oofL/aJmUjcxIR@kernel.org> <CANiq72=Ghy2awR_+DACyiq_DAtscx3yoKb4tJ+GkpqVCcV_HEQ@mail.gmail.com>
In-Reply-To: <CANiq72=Ghy2awR_+DACyiq_DAtscx3yoKb4tJ+GkpqVCcV_HEQ@mail.gmail.com>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Mon, 13 Feb 2023 12:53:38 +0000
Message-ID: <CAOgh=FzBjR7V+sQOy2OEV+YXxB0_YzapNTO+-Xf3uGnLfA0Vxw@mail.gmail.com>
Subject: Re: pahole issues with Rust DWARF was: Re: [PATCH 1/1] pahole/Rust:
 Check that we're adding DW_TAG_member sorted by byte offset
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org, Neal Gompa <neal@gompa.dev>,
        bpf@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023 at 12:45, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Arnaldo,
>
> On Mon, Feb 13, 2023 at 1:09 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > The namespace.o seems to be ok:
>
> I saw the other message too -- this looks great, thanks a ton.
>
> > The core one needs work:
>
> If `core.o` works, then I think it is likely other things will work :)

Hi Guys,

I'll leave this to the experts, but if we get this to the point where
we are happy to enable again for Rust CUs, could we request another
version bump? It just makes it easier to integrate with the kernel
scripts when we want to enable again.

>
> I can try to extract the cases for those into simpler `.o` files, if
> you would find simpler test cases useful (perhaps for the test suite
> etc.).
>
> Cheers,
> Miguel
>

