Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C80B6F5C2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjECQi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjECQiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:38:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562C13C01
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:38:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9536df4b907so1095749666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683131901; x=1685723901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CO3/wYgoteeIW67yC+Tl9a59Mskq9ceqxtoEpa1lobg=;
        b=U3V6bMySLKAg6LVk8UPeUuN3y20ze+uC6keiE//AvpxAHHjLxpLgwbX5+U8B+H+OzG
         BIwHzjJxgiDL0l8fqRs4dHxvhbaaNpvXpkxOji9Iv8SWyZZioX7XFzlQZj0+u3PRJ1kr
         HTB0kBlM++ukjBH6tM98i5M0uvfDnc2jzt5Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131901; x=1685723901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CO3/wYgoteeIW67yC+Tl9a59Mskq9ceqxtoEpa1lobg=;
        b=S4XSv6lgobRh+YOx2JDGdWyV3FWq+wVeuXpfXqcO+beBrfn5WyXamvD87qez3ypvq1
         8O+LbOza6OIyFi/PE7A+yvjevfJc+pMlHtKN+w/O8w3UCPdu4Iai/dpgZeHodw+3SA+k
         K5G0qN38F5PoqVzQrV0d1WGEChVuolQI9Q6cOoJKpucABZCQIRbDz99DACzs4bLGOzfc
         wo5GmJfPICMEo+HWVJ9lcuT8JusQ+tRoIr4hgI7u9cUuTRHL1rGwT9IjdMp2TrcGafB+
         i3E4Phkp4mqYqIi/oqbruKZ1VpqQqyUJq25XSfIK52YvldkgpvidPFZVadSKWvkq/Skq
         0Few==
X-Gm-Message-State: AC+VfDyb9sFRVR5NkadXUdBYCJu2A8MXSgUKYG9KmI3G5fyyctIvfbV1
        JIkHxoww5pTCq/U5HCvj922UoOv8+VansjR5U1MFGg==
X-Google-Smtp-Source: ACHHUZ7jdBbfn6SeFscpMkGWZ4oZgHsuJWxkqFkku39+xynqCO8rXvdYPqBN3yoqZG+WO31u85cw1A==
X-Received: by 2002:a17:907:805:b0:94f:cee:56f2 with SMTP id wv5-20020a170907080500b0094f0cee56f2mr4184925ejb.4.1683131901514;
        Wed, 03 May 2023 09:38:21 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id i25-20020a170906851900b0094f1b8901e1sm17539486ejx.68.2023.05.03.09.38.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 09:38:20 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-94f6c285d22so1088857466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:38:20 -0700 (PDT)
X-Received: by 2002:a17:907:845:b0:961:8fcd:53c2 with SMTP id
 ww5-20020a170907084500b009618fcd53c2mr3430082ejb.64.1683131900304; Wed, 03
 May 2023 09:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
 <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name> <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
 <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
 <f5983c42-82a5-1cd8-c717-67bfd72377dc@intel.com> <CAHk-=wgpOqujY210W9-KJPEfD42W_bvUdLwF-PAvyxJQ92tzDg@mail.gmail.com>
In-Reply-To: <CAHk-=wgpOqujY210W9-KJPEfD42W_bvUdLwF-PAvyxJQ92tzDg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 May 2023 09:38:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com>
Message-ID: <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.4
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 6:17=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And in the process I found another broken
> thing:__untagged_addr_remote() is very very buggy.
>
> The reason?
>
>         long sign =3D addr >> 63;
>
> that does *not* do at all what '__untagged_addr()' does, because while
> 'sign' is a signed long, 'addr' is an *unsigned* long.
>
> So the actual shift ends up being done as an unsigned shift, and then
> just the result is assigned to a signed variable.
>
> End result? 'sign' ends up being 0 for user space (intentional) or 1
> for kernel space (not intentional)..

Looking around, this same bug used to exists for the normal
(non-remote) case too, until it was accidentally fixed when changing
that to use inline asm and the alternatives code.

At that point the non-remote case got an explicit 'sar' instruction,
and the result really was ~0 for kernel mode addresses.

> Why does it do that "shift-by-63" game there, instead of making
> tlbstate_untag_mask just have bit #63 always set?

And it turns out that bit #63 really _is_ always set, so I think the
solution to this all is to remove the sign games in untag_addr()
entirely.

Untagging a kernel address will "corrupt" it, but it will stay a
kernel address (well, it will stay a "high bit set" address), which is
all we care about anyway.

If somebody actually tries to untag a kernel address, that would be a
bug anyway, as far as I can tell.

So I'm going to just remove the 'sign' games entirely. They are
completely broken in 'untagged_addr_remote()', they _used_ to be
completely broken in 'untagged_addr()', and it looks like it's all
unnecessary.

           Linus
