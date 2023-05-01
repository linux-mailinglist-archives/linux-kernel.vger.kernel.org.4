Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE826F2E4C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 06:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjEAECl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 00:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjEAECM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 00:02:12 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715B694
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 20:59:24 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-77d0fcbce6bso247666241.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 20:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682913563; x=1685505563;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wlcWHBp5U9pKjvAervbggqWQHpGZVcQMASIP1AoxR/I=;
        b=myzwtOMYaSxjDGrCGSFKSSggOzmKMiDAQmNPFOrf7hvHNMc7q1Q2liwfV7n1RhjWeF
         jIvZ8NzSDF9ACaAsA1KgIoNHFafy2nMAgzsu5EIpPZMcRwYy10ty6YP6KmRJCZEGz+NS
         YjWrUpjw36+2Rw9w8OtuSJjimgyT/E8boY7z6TXqnyYmfYugsdvL/Vgt/T/FfhepoIMv
         VHttEqVRgaKPtnRBQJR+5j5YjAT3FGdOCt2Gj1z7v5tY5FLgpq2GbFgaprMaXa8AlyMx
         k9VFxnfPQDEyuWbaElSy7fHIHljDiR+L+5D00yjZFazlvp9lUzhaVKe2tUShydns0Eyu
         a9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682913563; x=1685505563;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wlcWHBp5U9pKjvAervbggqWQHpGZVcQMASIP1AoxR/I=;
        b=iJJ8WAHql9zDnEUXraACQcxul4NAbQFQCEbRyenFpwuo6Esf+UpdcZzzn5XG8zlOVp
         SGgzm86gDdfoyhq7wiFBKHAvEFsQLZ+h9Yu+TTr7iBn5yvN28uF48M+dr14+dDwpFrts
         zNNlKqpbNE/giUmYeUtcGTT4Hw+VGJiy0/ARYjr0gUoxjti/+1HYf5EfDHLoflgFStZh
         R7IcwT4SlB3ipLsCk0dPdPDy1SNBHQd6xzRSrqKcUbgQhHG5Vzums9A6qEV8w85jt/Kc
         LeOwP49oWLsoe9gxZP7D3c3SPzsqWeqeVMBUs6rvAZNqmwUQXCcwhnq+vRkdUGDXkQni
         rlLA==
X-Gm-Message-State: AC+VfDzumJol6zh8eGgWUDlFvtYIFoJBliH17KOPkGqnIXfz/fb1FdST
        mU8UG3uT+vY6/p8psY27bn3hfDZ9Z2mtmJBJ1Cl+rsmu8GU=
X-Google-Smtp-Source: ACHHUZ77O6m1nzl4uMS8pnYIcrtXQkGK7n7CP+Sj3OlbhG+hoEm7Vs/1uTYHwLXqJs1HYUum9HexCCOKAaTVRWsJzwA=
X-Received: by 2002:a1f:4d81:0:b0:40f:f3e1:53c with SMTP id
 a123-20020a1f4d81000000b0040ff3e1053cmr3624176vkb.1.1682913563055; Sun, 30
 Apr 2023 20:59:23 -0700 (PDT)
MIME-Version: 1.0
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Mon, 1 May 2023 11:59:12 +0800
Message-ID: <CAAJw_ZsbTVd3Es373x_wTNDF7RknGhCD0r+NKUSwAO7HpLAkYA@mail.gmail.com>
Subject: linux-6.4 alsa sound broken
To:     lkml <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latest git pull from Linus's tree ... playing a simple sound file will
resulted in a lot of echo.

Running on Lenovo X1 with ..
00:1f.3 Audio device: Intel Corporation Alder Lake PCH-P High
Definition Audio Controller (rev 01)

I've bisected and reverted the following patch fixed the problem.

My best,
Jeff

commit 9f656705c5faa18afb26d922cfc64f9fd103c38d
Author: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Date:   Thu Apr 20 13:33:23 2023 +0200

    ALSA: pcm: rewrite snd_pcm_playback_silence()

    The auto-silencer supports two modes: "thresholded" to fill up "just
    enough", and "top-up" to fill up "as much as possible". The two modes
    used rather distinct code paths, which this patch unifies. The only
    remaining distinction is how much we actually want to fill.

    This fixes a bug in thresholded mode, where we failed to use new_hw_ptr,
    resulting in under-fill.

    Top-up mode is now more well-behaved and much easier to understand in
    corner cases.

    This also updates comments in the proximity of silencing-related data
    structures.

    Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
    Reviewed-by: Jaroslav Kysela <perex@perex.cz>
    Link: https://lore.kernel.org/r/20230420113324.877164-1-oswald.buddenhagen@gmx.de
    Signed-off-by: Takashi Iwai <tiwai@suse.de>
