Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E2F6F4900
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbjEBRPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjEBRPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:15:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FF1C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 10:15:31 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so4651665b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1683047730; x=1685639730;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+A8Sw/GbyUDc6OouvqtsYaVPbEunyRKH6rDdt34P9UU=;
        b=dsL7jHbGE034WUTc07mFN2pmj7q1QdhVaYAnhUusn2VlN42D987eVEVrsRfbMg2mdq
         TIiXlbQEj8y/8pyeiyQs9hxpuektYOc0bg7AsjYFvf91tBTlOKr4il/jgAvH1KVO4K5h
         rjWXwl/gkE3Jk2YR+BtrSOit9oneXJVvOYkW1VukSIgqPAAW7zZZFg2gfBrc+Bb48+na
         lidGeyKXyfqUtlgsbf7zLUsND13oN7jnoWCQtxFfsJfBmjKcpfb/JLWDZ9VnM0ytv8zd
         iZ+jiZBaDul86jSR5m9O7FUP4C6vRW9G6EyYGETAwtVW76uMVqxX+GjYMxo4hOBj3k6f
         b54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683047730; x=1685639730;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+A8Sw/GbyUDc6OouvqtsYaVPbEunyRKH6rDdt34P9UU=;
        b=CTbVgszRkBhT1uyru/t81RD97GMRoSphOOUVUi5olyZQjSHVaT97/Jr3ORLwu3GbrO
         yDK7PGWEeATSBEQopDYXNiXNK86ugbhN/c/WzzHSfgJYgFWkV/5Z5DUcGouqbiyRYOoD
         YJPjt9e71xb2I8zwY/InTliyf77JBxxW8UyjzNJSTeJK9UtuNmzYza4t8ypaniqypn/8
         kgtigwRW5nmR945NWF6Vp5FabU2udcggrDMLZwxfP3Dx+JEH65tOMqY5FugdUT8uXOZl
         QlGnfvLMtLa3njKmEsW7x0DOZFTnkTYL2AT3tJHVJ5ILLH4JlHZ8rzD9CUuq0vYeBKF4
         xaNw==
X-Gm-Message-State: AC+VfDyHWNCvr+M7qa2Q+N+wtnWRF5/FLkOvWjzR66gkMKfTKPxcOnF8
        zBdhiz/rKRV9zwHZnbG1wA+hDg==
X-Google-Smtp-Source: ACHHUZ5swfbozraNarhMeYBm10PBdqGxzIJMEQxji86jnf86amM1DM0VBEs/+AN6eLoOq84GFcYR+Q==
X-Received: by 2002:a05:6a20:7d95:b0:f4:98d2:591d with SMTP id v21-20020a056a207d9500b000f498d2591dmr23657544pzj.5.1683047730546;
        Tue, 02 May 2023 10:15:30 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id p11-20020a635b0b000000b0050bd4bb900csm7393064pgb.71.2023.05.02.10.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 10:15:29 -0700 (PDT)
Date:   Tue, 02 May 2023 10:15:29 -0700 (PDT)
X-Google-Original-Date: Tue, 02 May 2023 10:15:27 PDT (-0700)
Subject:     Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux vector
In-Reply-To: <CAAeLtUCqyARVaY2YtVXWc_cucMOCbQ2RAd2y35pun_MMagEN_w@mail.gmail.com>
CC:     bjorn@kernel.org, jrtc27@jrtc27.com, heiko@sntech.de,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        kito.cheng@sifive.com, Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com, heinrich.schuchardt@canonical.com,
        greentime.hu@sifive.com, nick.knight@sifive.com,
        christoph.muellner@vrull.eu,
        Richard Henderson <richard.henderson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        heiko.stuebner@vrull.eu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     philipp.tomsich@vrull.eu
Message-ID: <mhng-4b9e3d86-2f0b-47da-8a5d-bd383a0171d6@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 May 2023 02:13:10 PDT (-0700), philipp.tomsich@vrull.eu wrote:
> On Tue, 2 May 2023 at 09:58, Björn Töpel <bjorn@kernel.org> wrote:
>>
>> Philipp Tomsich <philipp.tomsich@vrull.eu> writes:
>>
>> > It is a pity that the current interface was designed without involving
>> > RVI (and that I had to ask my team to put together a patch set for
>> > further discussion, given that none of the other major vendors in RVI
>> > stepped forward).  I guarantee that plenty of reviewers would have
>> > highlighted that a central registry (even if it is just a kernel
>> > header) should be avoided.
>>
>> Are you claiming that the hwprobe work was not done in the open, but
>> secretly merged? That is not only incorrect, but rude to upstream RISC-V
>> Linux developers. I suggest you review how you interact with upstream
>> kernel work.
>
> Please don't put words into my mouth...
>
> I was merely pointing out that there was no engagement by the RVI
> member companies (in regard to this mechanism) within RVI, which would
> have prevented Jessica's issue.
> This would have also helped to address the concerns on vendor-defined
> extensions.
>
> Also who do you refer to when you say "how _you_ interact"?  If it is
> RVI that you refer to: it doesn't interact with upstream work
> directly, as it doesn't own any engineering resources.
> RVI provides a forum for member companies to come to an
> understanding/design and then have the member companies perform the
> work and take it upstream.

I'm not even sure what you're looking for here: if RVI doesn't want to 
work upstream, then complaining that RVI isn't part of upstream 
discussions is pretty pointless.

>> Why didn't RVI get involved in the review of the series? The expectation
>> cannot be that all open source projects go to RVI, but rather the other
>> way around.
>
> That is exactly the point I was making and which you seem to miss: RVI
> does not own any engineering resources and depends solely on its
> member companies to project into open source projects.
>
>> Take a look at commit ea3de9ce8aa2 ("RISC-V: Add a syscall for HW
>> probing"). Your team was very much involved in the review.
>
> I am aware, as I had reviewed and commented on these are well.
> And my only request (was and) is that we need to figure out a way to
> efficiently deal with vendor-defined extensions.

Maybe you should go talk to you team, then?  Handling vendor extensions 
via hwprobe has been discussed, sounds like you're confused again.
