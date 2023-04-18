Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFF66E6B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjDRRhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjDRRhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:37:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C851293D9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:36:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94f7a7a3351so158944366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1681839413; x=1684431413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Q8SFl2ULkIvm8UXfuATBUNzL9reEo3S5ggP65kxjqk=;
        b=GSZdVVEt1lfl8sp96Vt7492JQfCpH5jKib5smE+5R34WwS9qBdzCLIY8Hf86Wcmn5W
         WfMPUOxJu+AWYIsuMcPetFseZVPpjeX1SXkVA0ZzWSMgOsOeQfg1ddJqAnEE85lxL3H0
         /o4UUTj+Kd5lL4L+L3K38H+0gp8aZi5cVcZmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681839413; x=1684431413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Q8SFl2ULkIvm8UXfuATBUNzL9reEo3S5ggP65kxjqk=;
        b=XVp7nuLROspwT42QvHFmSB6Na1WWUa8hnhKg5CmJTM4jXFnhq6XG2vb7R+92qXE1GV
         EBqQVDPw4Uawwh1bBB+5hnnemYjMZ3W8BjQiBDgmbJhTOFoHRDLQgU83RblCIHDrRtG7
         JySoAVzenPaomN8KeDnuQnthJFtrL7wqHN0K6M+f265XsQuLNULqa8HfkEUEI28px/FG
         HBQaoZkd4W2S4OvTjOVnKSzH9vjfyc8AH2pfREySK1W1KX8YcQ+tuyGtvyxqwnI7W0xf
         1VIMQblJRlhMAjK0vmz+/XxTbbVWR62tg0MnsVQ/5koCrJTKbwN/8MuEK8+xGNr4Rt2s
         Z3gQ==
X-Gm-Message-State: AAQBX9eS4lKkJz1qmWv4ueNvMaZqtr1IgFFxxCfhSXbkTFrWwAmZz9k7
        omkpzM5D3J4nldhi4Fa5nqsyh+9v88I+y6B2pXU6jQ==
X-Google-Smtp-Source: AKy350b9h6v/rbWktkMMGsiG6e5ANIOP/OAMBH/mnHYX0NwJiHi9hXwVwSoeaUtuoph9oNatzRpc2w==
X-Received: by 2002:a50:ef01:0:b0:500:46f2:e7db with SMTP id m1-20020a50ef01000000b0050046f2e7dbmr3156636eds.15.1681839412776;
        Tue, 18 Apr 2023 10:36:52 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id c18-20020aa7c752000000b00501d73cfc86sm7271971eds.9.2023.04.18.10.36.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 10:36:52 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id xi5so75212341ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:36:51 -0700 (PDT)
X-Received: by 2002:a17:906:7b52:b0:94a:597f:30ee with SMTP id
 n18-20020a1709067b5200b0094a597f30eemr5082326ejo.15.1681839411548; Tue, 18
 Apr 2023 10:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
 <21e49cd7-ee15-5ebd-7805-37d5f347635f@amd.com> <6b14b2a0-cf1c-fbfb-5028-d7a6974ef39f@oracle.com>
In-Reply-To: <6b14b2a0-cf1c-fbfb-5028-d7a6974ef39f@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Apr 2023 10:36:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whogEk1UJfU3E7aW18PDYRbdAzXta5J0ECg=CB5=sCe7g@mail.gmail.com>
Message-ID: <CAHk-=whogEk1UJfU3E7aW18PDYRbdAzXta5J0ECg=CB5=sCe7g@mail.gmail.com>
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
To:     John Garry <john.g.garry@oracle.com>
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
        Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
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

On Tue, Apr 18, 2023 at 3:20=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> JFYI, Since you are using NVMe, you could also alternatively try
> something like which I did for some SCSI storage controller drivers to
> limit the request_queue max_sectors soft limit, like:

That patch is not only whitespace-damaged, it's randomly missing one
'+' character so it makes no sense even ignoring the whitespace
problems. _and_ it has a nonsensical cast to 'unsigned int' which
makes that 'min()' possibly do crazy and invalid things (ie imagine
dma_opt_mapping_size() returning 4GB).

You can't cast things to the smaller size just to get rid of a
warning, for chrissake!

In fact, even without the cast, it seems entirely broken, since the
fallback for dma_opt_mapping_size() is to return 0 (admittedly _that_
case only happens with HAS_DMA=3Dn).

Finally, doing this inside the

        if (ctrl->max_hw_sectors) {

conditional seems entirely wrong, since any dma mapping limits would
be entirely independent of any driver maximum hw size, and in fact
*easier* to hit if the block device itself doesn't have any max
limits.

So please burn that patch in the darkest pits of hell and let's try to
forget it ever existed. Ok?

Also, shouldn't any possible dma mapping size affect not
'max_sectors', but 'max_segment_size'? At least the docs imply that
dma_opt_mapping_size() is about the max size of a _single_ mapping,
not of the whole thing?

Anyway, if this is actually an issue, to the point that it's now being
discussed for a _second_ block driver subsystem, then shouldn't the
queue handling just do this all automatically, instead of adding
random crap to random block driver architectures?

And no, I don't know this code, so maybe I'm entirely missing
something, but that patch just raised my hackles enough that I had to
say something.

              Linus
