Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D516BEBB0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjCQOsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCQOsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:48:09 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE73584AB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:48:07 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id x8so3567074qvr.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679064486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y00W2vlLuMTbF2Huj0Es001wY7aldQjIanbtN1YOkHg=;
        b=GkkJPsXsxAnJCR1XPtQdP3YFkyJOXudoVpKmeyKidWxq5/F+DaHJ50CBo/SM2CWZkd
         q0OfIHgh3368j1WUWO3ddvm5pg1ZPrQ7Y25LxtVhO5uIs+c4Z17ucftFryTjJES78N04
         41InlRoIBySZWbfAhx443i5LGCYhFQQKuCerE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679064486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y00W2vlLuMTbF2Huj0Es001wY7aldQjIanbtN1YOkHg=;
        b=SbGpv3XhwXOin8QQ+lgDh0TYBV2RSystUZ/7KrsNPcMLipYQmva1z2gQeLfWlcOZQb
         vKvwL2lpMbQqEOYFWDL4WPedk/qLOGPEHA8Z3/vhf+tcG4onKXw94/UNK4HPbEsJbM45
         4C0e0r3GXLsFirIWlUIzujPy6ryYJ3vZPVaRvG5GOoM7J08hVGIzhlw637wMVzEsFX+g
         CPfdGikvscTI+UkvtzhUxp7wFsaaoVbxTBrMribU3myzagDS0Tnt5ZbHe+VTYoZRCtbl
         4DMsyio6041+YIQucfsC9WfyHMaYGz4hZ3PSCbryHlZOjE9u5iUBdzkkRXU+6BUzZYL2
         Q4Bw==
X-Gm-Message-State: AO0yUKW3SHPggo56djXGHciWmCf+NvXHkPOnJRmdMwDNdZb4BOTtGFOv
        m9/WF4/JKnj9PkZAqZgarnHoRA==
X-Google-Smtp-Source: AK7set/8JqWEiXgvw/KNL4eR/Drm+OM2J6X6b3kpVOvGlbkjiNe1G4th6mtxiSnoXVzd/sVarz3FZw==
X-Received: by 2002:a05:6214:528e:b0:5a1:d92e:5cb2 with SMTP id kj14-20020a056214528e00b005a1d92e5cb2mr23731115qvb.10.1679064486364;
        Fri, 17 Mar 2023 07:48:06 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id x1-20020ac84a01000000b003d4008dccb7sm1408824qtq.48.2023.03.17.07.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 07:48:05 -0700 (PDT)
Date:   Fri, 17 Mar 2023 10:48:03 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] COVER: Remove memcpy_page_flushcache()
Message-ID: <20230317144803.kktahbp4fhmkutsq@meerkat.local>
References: <20221230-kmap-x86-v1-0-15f1ecccab50@intel.com>
 <3523ddf9-03f5-3179-9f39-cec09f79aa97@intel.com>
 <64126d113d163_2595222942@iweiny-mobl.notmuch>
 <87lejxmax8.fsf@mpe.ellerman.id.au>
 <641340e2998b4_2695182944f@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <641340e2998b4_2695182944f@iweiny-mobl.notmuch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 09:16:34AM -0700, Ira Weiny wrote:
> > It's also much easier to run git-send-email HEAD^^^, rather than running
> > it three separate times, let alone if it's a 20 patch series.
> 
> Exactly.  And I'm using b4 which would have forced me to create a separate
> branch for each of the patches to track.  So I was keeping them around in
> a single branch to let 0day run after the merge window.  Then I forgot
> about the idea of splitting them because b4 had it all packaged up nice!
> 
> > 
> > I wonder if we could come up with some convention to indicate that a
> > series is made up of independent patches, and maintainers are free to
> > pick them individually - but still sent as a single series.
> 
> Maybe.  But perhaps b4 could have a send option which would split them
> out?  I'll see about adding an option to b4 but I've Cc'ed Konstantin as
> well for the idea.

Yes, I plan to introduce the concept of "bundles" in addition to "series". The
distinction is that when you send a bundle, each patch is sent as individual
submission and we generate the change-id for each patch. It's a bit more work
to send a v2 of some patch (you have to do a "prep -n --from-thread <msgid>"),
but it's not insurmountable and should help with queuing up individual patches
for sending post merge-window, like in your case.

-K
