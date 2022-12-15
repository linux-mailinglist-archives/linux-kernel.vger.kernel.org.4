Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A14264D5A6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 04:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiLODmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 22:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLODmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 22:42:42 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29B126100
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 19:42:41 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso5165178pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 19:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBWZgeBCS0LmwDLnf7B9W9lXRzOPGCk3OwFNg57GifY=;
        b=b6HcvVJ9n1IRme6EA1PifT+om8QfQNltYRC4UcM4+DCS0NoePkJFSgV+9kJlFjKNji
         nIK2ucyCp/As6xz8e/Q7wgsbcfM757Yya1D99+lMJ4fzPW2LIT0SSPX5BYwlZr9GqBjb
         jGjrXVN/b359X5WMSwlcLvUepMUff5z1QdjOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBWZgeBCS0LmwDLnf7B9W9lXRzOPGCk3OwFNg57GifY=;
        b=dvx1xDIO1OVjXhUudqKhaJrGTNGab9c6ChChlQIcUmPfVsCvxpwO14fadi7LWrDMwy
         d1twVV/+HJ0FaGa9/ttq2qL+W8xT3HNXCIPnduGUV0BEwZtmt+Khq8GWT8qRKhoBGwbs
         RqoPYf6BDTzAIjXtUbo6ZofGGhlk90DLxZ+lrHP6a1HvHS+hWuv/Rj4ly1e7sh2Aqei1
         cTEqjM/heteVQBHlbY/djKmBob2XC3M/hlFFtZ8k5b3lBC8ydCLv6XIFX94HuPGJBKPj
         rir9c1MWorLPLQzDG9syucnGw5UTQ2defHNbJxAaT4/iSsekAv6Mj6zAcs/CfZw+g/mJ
         EoAg==
X-Gm-Message-State: ANoB5pmKJY8iSZo12dnFUY29ummUNT7sfqYjzWHCLrJKfHECmhsFNizg
        tpfT9IJIf56uDGKBnPoVQEE2wA==
X-Google-Smtp-Source: AA0mqf5eElFx4wN/AzvgM4zJbxTFT+DEcniWN4Mbi7sA4o56vQCj/t6LbnqIoiudp018NmPl8sJrDA==
X-Received: by 2002:a05:6a20:4a03:b0:a3:5864:e0c5 with SMTP id fr3-20020a056a204a0300b000a35864e0c5mr34271903pzb.9.1671075761325;
        Wed, 14 Dec 2022 19:42:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s14-20020a65644e000000b0047702d44861sm543237pgv.18.2022.12.14.19.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 19:42:40 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     jstultz@google.com, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, wvw@google.com,
        kernel-team@android.com, anton@enomsg.org, connoro@google.com,
        Tony Luck <tony.luck@intel.com>, ccross@android.com,
        midaschieh@google.com
Subject: Re: [PATCH v2] pstore: Switch pmsg_lock to an rt_mutex to avoid priority inversion
Date:   Wed, 14 Dec 2022 19:42:26 -0800
Message-Id: <167107574431.3579002.5090420152523491750.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221214231834.3711880-1-jstultz@google.com>
References: <20221214231834.3711880-1-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 23:18:34 +0000, John Stultz wrote:
> Wei Wang reported seeing priority inversion caused latencies
> caused by contention on pmsg_lock, and suggested it be switched
> to a rt_mutex.
> 
> I was initially hesitant this would help, as the tasks in that
> trace all seemed to be SCHED_NORMAL, so the benefit would be
> limited to only nice boosting.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore: Switch pmsg_lock to an rt_mutex to avoid priority inversion
      https://git.kernel.org/kees/c/76d62f24db07

-- 
Kees Cook

