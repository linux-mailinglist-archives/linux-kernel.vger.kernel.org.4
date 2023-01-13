Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBBE66A4CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjAMVIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjAMVHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:07:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B36869F6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:07:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 591E36233E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 21:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DB9C433F1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 21:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673644067;
        bh=KnI9dpUVEfgfnTEf2BaoXBPxsyAbpN0J7UCpRtROHaY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=abz82Fue0Q3bmKKjWkIaZiLSeVzFIdI+ODUYtfY2x4R/NMfR7PsSpZ4Su+GquJ4kq
         h1eEgS3wuRjRWLfIVyX3s3b1VNEJdkWaBblPxTDl0GS1Iq9wcS2VaQd3waYCsSyozT
         kjS02DDmnX+akYZEIKFd8ILV/hp7eeMVuRNVr+ASRrnNYuoc3VQqXyly1vE1hf7rAC
         +absUwhRvWguHg5VPzyVLIaZlp6xXN8nUkp38VgagLvB5vAB1JVk6O0HmVIyMbtqkr
         4nXQUKLvTwE3ohY58y/Dl79kVawf2bN9rTf+GNV6s57Kry7IXlT/LqkVuQg15Lt2ik
         mB9uyLFRmOPSw==
Received: by mail-lf1-f53.google.com with SMTP id y25so34777747lfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:07:47 -0800 (PST)
X-Gm-Message-State: AFqh2kq2H3LMPk8oWs6hpIHEUXNGvt2asG5uuZzWugaUfl7/1tYXf4lI
        NfFFqzLyKUSUHsV8Wy/qYq/BZlOW636k4dNiMaM=
X-Google-Smtp-Source: AMrXdXsnUUUOjFH1IViqDSfuwZPG3VnmcTtGowMY2CkzP3A+ez9rDUxngSu37ODJJahBImx/8ocEHmRv4jF06+SomAM=
X-Received: by 2002:a05:6512:a95:b0:4d1:3e32:5436 with SMTP id
 m21-20020a0565120a9500b004d13e325436mr325765lfu.215.1673644065860; Fri, 13
 Jan 2023 13:07:45 -0800 (PST)
MIME-Version: 1.0
References: <20230112214015.1014857-1-namhyung@kernel.org> <20230112214015.1014857-7-namhyung@kernel.org>
In-Reply-To: <20230112214015.1014857-7-namhyung@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 13 Jan 2023 13:07:33 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5tXByLgM4kf1SjKBEkiKDAMvK3OqxU+0NrZ_UjyeOvwQ@mail.gmail.com>
Message-ID: <CAPhsuW5tXByLgM4kf1SjKBEkiKDAMvK3OqxU+0NrZ_UjyeOvwQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] perf/core: Do not pass header for sample id init
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 1:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The only thing it does for header in __perf_event_header__init_id() is
> to update the header size with event->id_header_size.  We can do this
> outside and get rid of the argument for the later change.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Song Liu <song@kernel.org>
