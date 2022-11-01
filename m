Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A949A6155AA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiKAXAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiKAXAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:00:31 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BE81FFB9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 16:00:30 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s24so22974758ljs.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 16:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9UWlrhGX03RO6ReKvfYCRk7D2QbEdkXgk1Jw8GtoLdc=;
        b=Pq3inMdc11mjCYRR3aOCxe0fIpBL8te0vA1cks+0mMT/U5OVKug57fgMRdc7iZLpim
         CpxaJOIxZfYRWuXKDJ8KqK5kpXMSnuFciYR2Fut0GvfUPaDHorE1SHSdyHNrLNNUr9YI
         9r6RJp0yU/2XdgObMSUYml2m2md/bfhNbEMgiBib+XkkhSqFlF309gWbTh0/8XdIRok8
         Cs7hp6Os9hm/l5Z9hx5I+ZvCHrXXKWQpFZj2APy7wc5ujFy+FfLdkAnsFemM//aZyWo/
         gdFoZ/6dBu/ooMixOio81RyiMFqzBG4ue1udXNmowMgQqYETcOQTgfymCS4UwDCfxLRI
         fgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UWlrhGX03RO6ReKvfYCRk7D2QbEdkXgk1Jw8GtoLdc=;
        b=SSXkG7+YvONpD9JtBZ11yx+l1iGXQ5vCa/b+sCR/DDHXwHNNmy7HQpLuGk6jVGkXUW
         MsZaTb+eAxDEE42u1KrhDR1FJlgTv9V3/W5k7HIiW0c72jrj9tXOMAtp1AlKc8l44oed
         4Ag2eFvzrSNxgvAUmzsQwvql8mpLlI2SKQt5WyNwCG2Umo4b1FWSCCREh9ptBBUQsSGp
         fFHuZzC7k5j9AMlREaBaWhRvB26cdlbfhN5Z8MAGNQ7unBpklHDFdSGcuGOqWp+AJUdS
         cazlEc863vGrRgOEM/fJuw2eMsugY/5H31+uCkDr4hipyKjIeyn5BCZ8e9fRxtr3kNSj
         YJcw==
X-Gm-Message-State: ACrzQf2bRrm6kJibVLO67a8yquYDpkdMVfpIkAbFB2mV7BbSixA88s/2
        PzbrGA/uE+cmiFkf4I2PuxsdgF7hMM/TTt3gcsg=
X-Google-Smtp-Source: AMsMyM6sqZvKWW7raLm/pWpera4S2mX056rfw6tiLIN+pASYV3qZZJ2QfIF0j5eJ1uD+z8nqvU35YQAyguKG2Njm6uQ=
X-Received: by 2002:a05:651c:104:b0:277:42b0:9085 with SMTP id
 a4-20020a05651c010400b0027742b09085mr7093165ljb.47.1667343628385; Tue, 01 Nov
 2022 16:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAM6Wdxc0KRJMXVAA0Y=u6Jh2V=uWB-_Fn6M4xRuNppfXzL1mUg@mail.gmail.com>
 <20221031145046.2a7f9d32@rorschach.local.home> <CAM6WdxeZbGmRopXqLtDNTwPOahnyC6GrCfv4H1m=mF41-J=VbA@mail.gmail.com>
 <20221101153135.5345c748@rorschach.local.home> <CAM6WdxfYU1Dc6dkMQMSGjgiggrziLvfwVPJV5OC02_AQO8YkVw@mail.gmail.com>
 <20221101173802.7a476a04@rorschach.local.home> <CAM6WdxdAF5X8v_tbL1LvNDXgEPY5veL_OtQv5CrADV9qH4um-g@mail.gmail.com>
 <CAM6WdxfsP13aS62=xWNTFEEzAekAuDwFTpnONP9qF3br-65KWQ@mail.gmail.com>
 <20221101183512.285cfd68@rorschach.local.home> <20221101184347.2ecce20c@rorschach.local.home>
In-Reply-To: <20221101184347.2ecce20c@rorschach.local.home>
From:   Roland Ruckerbauer <roland.rucky@gmail.com>
Date:   Wed, 2 Nov 2022 00:00:16 +0100
Message-ID: <CAM6Wdxft33zLeeXHhmNX5jyJtfGTLiwkQSApc=10fqf+rQh9DA@mail.gmail.com>
Subject: Re: [BUG] NULL pointer dereference probably caused by kernel/trace/ring_buffer.c
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        regressions@lists.linux.dev,
        Steven Noonan <steven.noonan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Success!

Now rasdaemon is segfaulting, but that`s hardly a kernel problem.
Seems like the check fixed the problem.

Thanks,
Roland Ruckerbauer
