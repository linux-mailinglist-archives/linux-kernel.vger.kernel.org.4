Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367E2664AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239408AbjAJShc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbjAJShN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:37:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF55A59501;
        Tue, 10 Jan 2023 10:32:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D3CAB81908;
        Tue, 10 Jan 2023 18:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06FAC43398;
        Tue, 10 Jan 2023 18:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673375529;
        bh=QUdSPSJ1dS3+KOPixtik4EX+QpdImlvJMwhGplzoJI4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CSsqhlGsZ3rRP6uogxNQuvYFRLwxQJkenVKpMsdfhh4VCenx4M2sOzB4c5cubXYVE
         Zp6PZXsbBcAQ1md7ssc9o/pna7r9YbilGa92ctHfDXSZx4VJWwTMAxcFgNM5KkZ7OD
         muIFhcHZ9gBcnfvZZHoYeC94JvDCuuOd+Ho1dVM7kZ3vQa4ZZEbmgB2wMP6WnqIxn/
         Bc/ek0tDQOWVXcxYE2a23jB2+F7ZAldB1W2X5HyuShyfZRgX8aFpGEjOZnknglWsnN
         MA6E691iXWt2TZ+Lo1D7Tjg7nP9w/IGuS5LFd79fF0HFevblP3Hv5hTeKbSiJr8pWO
         gr9Ak3EVCOumA==
Received: by mail-lj1-f179.google.com with SMTP id p25so7278801ljn.12;
        Tue, 10 Jan 2023 10:32:08 -0800 (PST)
X-Gm-Message-State: AFqh2krCEq6Gt4vXrHVsM25oXqnEvws13/+kgUBM+qAcokYmtcUSlfOh
        3IMNJaT6dooknfrooh7ZFygSAAnPr7TihBIaMhM=
X-Google-Smtp-Source: AMrXdXvIneVTGj9nKfDPo5Fts30vJtsod1nns86BieZcV2ZxuUxvsrycMRszgV2p/ldobc7B5DyW+h59Ev4lN5NOJGE=
X-Received: by 2002:a2e:bd11:0:b0:280:54b:9ed5 with SMTP id
 n17-20020a2ebd11000000b00280054b9ed5mr994803ljq.414.1673375526906; Tue, 10
 Jan 2023 10:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20230106220959.3398792-1-song@kernel.org>
In-Reply-To: <20230106220959.3398792-1-song@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 10 Jan 2023 10:31:54 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4oY6Gh2c11AvzoCrv7ZShT0E=zU0OgK8LUq_pYW9=edw@mail.gmail.com>
Message-ID: <CAPhsuW4oY6Gh2c11AvzoCrv7ZShT0E=zU0OgK8LUq_pYW9=edw@mail.gmail.com>
Subject: Re: [PATCH/RFC] module: replace module_layout with module_memory
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Cc:     songliubraving@fb.com, Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Christoph

Hi folks,

Could you please share your comments on this work? If there isn't
major issue with it, maybe we can ship it in 6.3? (so we don't pile
too many changes in one big set).

Thanks,
Song

On Fri, Jan 6, 2023 at 2:10 PM Song Liu <song@kernel.org> wrote:
>
> module_layout manages different types of memory (text, data, rodata, etc.)
> in one allocation, which is problematic for some reasons:
>
> 1. It is hard to enable CONFIG_STRICT_MODULE_RWX.
> 2. It is hard to use huge pages in modules (and not break strict rwx).
> 3. Many archs uses module_layout for arch-specific data, but it is not
>    obvious how these data are used (are they RO, RX, or RW?)
>
> Improve the scenario by replacing 2 (or 3) module_layout per module with
> up to 7 module_memory per module:
>
>         MOD_MEM_TYPE_TEXT,
>         MOD_MEM_TYPE_DATA,
>         MOD_MEM_TYPE_RODATA,
>         MOD_MEM_TYPE_RO_AFTER_INIT,
>         MOD_MEM_TYPE_INIT_TEXT,
>         MOD_MEM_TYPE_INIT_DATA,
>         MOD_MEM_TYPE_INIT_RODATA,
>
> and allocating them separately.
>
> Various archs use module_layout for different data. These data are put
> into different module_memory based on their location in module_layout.
> IOW, data that used to go with text is allocated with MOD_MEM_TYPE_TEXT;
> data that used to go with data is allocated with MOD_MEM_TYPE_DATA, etc.
>
> Signed-off-by: Song Liu <song@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>

[...]
